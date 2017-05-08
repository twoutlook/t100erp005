#該程式已解開Section, 不再透過樣板產出!
{<section id="asfp350.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:1,PR版次:1) Build-000010
#+ 
#+ Filename...: asfp350
#+ Description: 回收料分攤入庫作業
#+ Creator....: 02040(2016-07-07 09:28:38)
#+ Modifier...: 02040(2016-07-07 09:28:38) -SD/PR- 02040
 
{</section>}
 
{<section id="asfp350.global" >}
#應用 p01 樣板自動產生(Version:15)
#add-point:填寫註解說明
#Memos
#160812-00005#1  160812 By 02040 調整table單價欄位命名pmdt007 mode pmdt036 
#end add-point 
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT FGL asf_asfp350_01
IMPORT FGL asf_asfp350_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS "../../asf/4gl/asfp350.inc"
 
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)

   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       sfaa010 LIKE type_t.chr500, 
   sfaadocno LIKE type_t.chr20, 
   sfaa017 LIKE type_t.chr10, 
   sfaa016 LIKE type_t.chr10,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable)
DEFINE li_step              LIKE type_t.num5              #步驟
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="asfp350.main" >}
MAIN
   #add-point:main段define (客製用)

   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define 
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義

   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js

   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call

      #end add-point
      CALL asfp350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp350 WITH FORM cl_ap_formpath("asf",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL asfp350_init()
 
      #進入選單 Menu (="N")
      #CALL asfp350_ui_dialog()
      LET li_step = 1
      #使用while讓程式不斷的在步驟內運作  
      #每一次執行完都會回傳之後要做哪個動作   
      WHILE TRUE
         CASE li_step
            WHEN 1
              CALL asfp350_ui_dialog_step1()  RETURNING li_step
              
            WHEN 2
              CALL asfp350_ui_dialog_step2() RETURNING li_step
              
            WHEN 3
              CALL asfp350_ui_dialog_step3() RETURNING li_step
             
            WHEN 0
              EXIT WHILE 
          
            OTHERWISE
               EXIT WHILE
         END CASE
      END WHILE  
      #add-point:畫面關閉前

      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp350
   END IF
 
   #add-point:作業離開前
   #程式運作完了要記得把temp table刪掉
   CALL asfp350_drop_temp()  RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="asfp350.init" >}
#+ 初始化作業
PRIVATE FUNCTION asfp350_init()
 
   #add-point:init段define (客製用)

   #end add-point
   #add-point:ui_dialog段define 
   DEFINE l_success  LIKE type_t.num5
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   #CALL cl_schedule_import_4fd()
   #CALL cl_set_combo_scc("gzpa003","75")
   #IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
   #    CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   #END IF 
   #add-point:畫面資料初始化
   #畫面嵌入
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp350_01"), "main_grid01", "Group", "master")
   CALL asfp350_01_init()     
   CALL cl_ui_replace_sub_window(cl_ap_formpath("asf", "asfp350_02"), "main_grid02", "Group", "master")
  #CALL asfp350_02_init()

   #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE) 

   #建立各程式的temp table
   CALL asfp350_create_temp_table() RETURNING l_success


   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asfp350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp350_ui_dialog()
 
   #add-point:ui_dialog段define (客製用)
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define 
   
   #end add-point
   
   #add-point:ui_dialog段before dialog
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON sfaa010,sfaadocno,sfaa017,sfaa016
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010
            #add-point:BEFORE FIELD sfaa010 name="construct.b.sfaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010
            
            #add-point:AFTER FIELD sfaa010 name="construct.a.sfaa010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010 name="construct.c.sfaa010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocno
            #add-point:BEFORE FIELD sfaadocno name="construct.b.sfaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocno
            
            #add-point:AFTER FIELD sfaadocno name="construct.a.sfaadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno name="construct.c.sfaadocno"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa017
            #add-point:BEFORE FIELD sfaa017 name="construct.b.sfaa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa017
            
            #add-point:AFTER FIELD sfaa017 name="construct.a.sfaa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa017
            #add-point:ON ACTION controlp INFIELD sfaa017 name="construct.c.sfaa017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa016
            #add-point:BEFORE FIELD sfaa016 name="construct.b.sfaa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa016
            
            #add-point:AFTER FIELD sfaa016 name="construct.a.sfaa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa016
            #add-point:ON ACTION controlp INFIELD sfaa016 name="construct.c.sfaa016"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct
         
         #end add-point
         #add-point:ui_dialog段input
         
         #end add-point
         #add-point:ui_dialog段自定義display array
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL asfp350_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL asfp350_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL asfp350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = asfp350_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="asfp350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION asfp350_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用)
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define 
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="asfp350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION asfp350_process(ls_js)
 
   #add-point:process段define (客製用)
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE asfp350_process_cs CURSOR FROM ls_sql
#  FOREACH asfp350_process_cs INTO
   #add-point:process段process
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL asfp350_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="asfp350.get_buffer" >}
PRIVATE FUNCTION asfp350_get_buffer(p_dialog)
 
   #add-point:process段define (客製用)
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfp350.msgcentre_notify" >}
PRIVATE FUNCTION asfp350_msgcentre_notify()
 
   #add-point:process段define (客製用)
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="asfp350.other_function" >}
#add-point:自定義元件(Function)
################################################################################
# Descriptions...: 設定左方流程圖片
# Memo...........:
# Usage..........: CALL asfp350_set_step_img(p_step)
# Input parameter: p_step    第幾步驟的圖
# Date & Author..: 16/07/07 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_set_step_img(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL gfrm_curr2.setElementImage("step01","32/step01.png")
   CALL gfrm_curr2.setElementImage("step02","32/step02.png")
   CALL gfrm_curr2.setElementImage("step03","32/step03.png")
   
   #文字顏色設定 
   CALL gfrm_curr2.setElementStyle("step01","menuitem")
   CALL gfrm_curr2.setElementStyle("step02","menuitem")
   CALL gfrm_curr2.setElementStyle("step03","menuitem")
   CALL gfrm_curr2.setElementStyle("step04","menuitem")

   CASE p_step
      WHEN 1
         CALL gfrm_curr2.setElementImage("step01","32/step01on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr2.setElementStyle("step01","menuitemfocus")
      WHEN 2
         CALL gfrm_curr2.setElementImage("step02","32/step02on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr2.setElementStyle("step02","menuitemfocus")
      WHEN 3
         CALL gfrm_curr2.setElementImage("step03","32/step03on.png")   #有on的是顏色不同的圖
         CALL gfrm_curr2.setElementStyle("step03","menuitemfocus")
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 設定每一步的畫面顯示與隱藏
# Memo...........:
# Usage..........: CALL asfp350_set_vbox_visible(p_step)
# Input parameter: p_step   步驟
# Date & Author..: 16/07/07 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_set_vbox_visible(p_step)
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
# Usage..........: CALL asfp350_set_act_visible(p_step)
# Input parameter: p_step   步驟
# Date & Author..: 16/07/07 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_set_act_visible(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL cl_set_comp_visible("next_step",FALSE)           #產生分攤明細      
   CALL cl_set_comp_visible("over",FALSE)                #完成   
   CALL cl_set_comp_visible("back_step",FALSE)           #上一步
   CALL cl_set_comp_visible("back_first",FALSE)          #繼續分攤
   
   CASE p_step
      WHEN 1
         CALL cl_set_comp_visible("next_step",TRUE)       #產生分攤明細          
      WHEN 2
         CALL cl_set_comp_visible("back_step",TRUE)       #上一步 
         CALL cl_set_comp_visible("over",TRUE)            #完成
      WHEN 3
         CALL cl_set_comp_visible("back_first",TRUE)     #繼續分攤          

   END CASE   
   
END FUNCTION
################################################################################
# Descriptions...: 步驟1
# Memo...........:
# Usage..........: CALL asfp350_ui_dialog_step1()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 160707 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_ui_dialog_step1()

   #設定左方的流程圖  
   CALL asfp350_set_step_img('1')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL asfp350_set_vbox_visible('1')
   
   #設定button隱藏
   CALL asfp350_set_act_visible('1')

   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("sfeb010,sfeb011",FALSE)
   ELSE
      CALL cl_set_comp_visible("sfeb010,sfeb011",TRUE)
   END IF  

   CALL asfp350_01_b_fill()
   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG asf_asfp350_01.asfp350_01_input_01
        SUBDIALOG asf_asfp350_01.asfp350_01_input_02
        SUBDIALOG asf_asfp350_01.asfp350_01_construct


        BEFORE DIALOG
           IF g_action_choice = "back_step" THEN
              LET g_detail_idx = 1
           ELSE 
              NEXT FIELD l_wo_type        
           END IF 
   
      
        ON ACTION close
           LET INT_FLAG = TRUE
           LET g_action_choice = "close"
           EXIT DIALOG
       
        ON ACTION exit
           LET INT_FLAG = TRUE
           LET g_action_choice = "exit"
           EXIT DIALOG
       
             
        ON ACTION next_step                             #下一步，分攤明細               
           IF NOT asfp350_01_execute_chk() THEN         #檢查資料正確性       
              NEXT FIELD sfeb004
           END IF
           LET g_action_choice = "next_step"
           
           LET INT_FLAG = TRUE
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
   
   CASE g_action_choice
      WHEN "next_step"
         RETURN 2       
      WHEN "menu"
         RETURN 0
      OTHERWISE
         RETURN 0
   END CASE   

END FUNCTION
################################################################################
# Descriptions...: 步驟2
# Memo...........:
# Usage..........: CALL asfp350_ui_dialog_step2()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 160707 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_ui_dialog_step2()
   #設定左方的流程圖  
   CALL asfp350_set_step_img('2')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL asfp350_set_vbox_visible('2')
   
   #設定button隱藏
   CALL asfp350_set_act_visible('2')
   
   #設定欄位隱藏
   CALL cl_set_comp_visible("sfebdocno_01",FALSE)              #入庫單號
   
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("sfeb012_01",FALSE)
   ELSE
      CALL cl_set_comp_visible("sfeb012_01",TRUE)
   END IF  
   
   CALL cl_set_comp_visible("pmdt001_01",TRUE) 
   CALL cl_set_comp_visible("pmdt002_01",TRUE) 
   CALL cl_set_comp_visible("pmdt003_01",TRUE) 
   CALL cl_set_comp_visible("pmdt004_01",TRUE)

   IF g_input.l_wo_type = '1' THEN
      CALL cl_set_comp_visible("pmdt001_01",FALSE) 
      CALL cl_set_comp_visible("pmdt002_01",FALSE) 
      CALL cl_set_comp_visible("pmdt003_01",FALSE) 
      CALL cl_set_comp_visible("pmdt004_01",FALSE) 
   END IF 

   LET g_action_choice = NULL

   
   #CALL asfp350_02_gen()
   IF NOT asfp350_02_gen() THEN
      CALL cl_err_collect_show()
      RETURN 1     #回到上一步
   END IF 
   
   CALL asfp350_02_b_fill()

   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG asf_asfp350_02.asfp350_02_input_01

        
        BEFORE DIALOG
            NEXT FIELD l_sfebseq

       #ON ACTION asfp350_02_modify_detail                         #點擊待分攤明細頁籤，進入INPUT段
       #   LET g_action_choice = "asfp350_02_modify_detail"
           

        ON ACTION CLOSE
           LET INT_FLAG = TRUE
           LET g_action_choice = "CLOSE"
           EXIT DIALOG

        ON ACTION EXIT
           LET INT_FLAG = TRUE
           LET g_action_choice = "EXIT"
           EXIT DIALOG

        ON ACTION back_step                    #回到上一步
           IF cl_ask_confirm('apm-00541') THEN
              LET g_action_choice = "back_step"
              LET INT_FLAG = TRUE
              EXIT DIALOG
           END IF           
            
         ON ACTION over                         #完成
           #檢查資料是否都有輸入
            CALL cl_err_collect_init()           
            IF NOT asfp350_02_execute_chk() THEN
               CALL cl_err_collect_show()
               NEXT FIELD CURRENT
            END IF
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
################################################################################
# Descriptions...: 步驟3
# Memo...........:
# Usage..........: CALL asfp350_ui_dialog_step3()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 160707 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_ui_dialog_step3()
   #設定左方的流程圖  
   CALL asfp350_set_step_img('3')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL asfp350_set_vbox_visible('3')
   
   #設定button隱藏
   CALL asfp350_set_act_visible('3')
   
   #設定欄位隱藏
   CALL cl_set_comp_visible("sfebdocno_01",TRUE)              #入庫單號  
   
   
   IF g_input.l_wo_type = '1' THEN
      CALL asfp350_02_ins_sfea()
   ELSE
      CALL asfp350_02_ins_pmds()
   END IF
   IF g_success = 'N' THEN
      INITIALIZE g_errparam TO NULL    
      LET g_errparam.code = 'aap-00187'  #單據產生失敗!       
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()     
   END IF
   CALL cl_err_collect_show()
   
   CALL asfp350_02_b_fill()
   
   LET g_action_choice = NULL

   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)    
        SUBDIALOG asf_asfp350_02.asfp350_02_display_01 
     

         ON ACTION CLOSE
            LET INT_FLAG = TRUE
            LET g_action_choice = "CLOSE"
            EXIT DIALOG

         ON ACTION EXIT
            LET INT_FLAG = TRUE
            LET g_action_choice = "EXIT"
            EXIT DIALOG


         ON ACTION back_first                    #繼續分攤(回到主畫面重新開始操作)
           #清空tmptable
            LET g_action_choice = "back_first"
            DELETE FROM p350_01_temp
            DELETE FROM p350_02_temp               
            LET INT_FLAG = TRUE
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
# Descriptions...: asfp350_create_temp_table()
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: r_success
# Date & Author..: 160707 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_create_temp_table()
  DEFINE r_success         LIKE type_t.num5 
  
  
   LET r_success = TRUE

   CREATE TEMP TABLE p350_01_temp(
       sfebseq LIKE sfeb_t.sfebseq, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb005 LIKE sfeb_t.sfeb005,  
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011)
   
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p350_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
  
  
  CREATE TEMP TABLE p350_02_temp(
   sfebseq LIKE type_t.num10, 
   sfebseq2 LIKE type_t.num10, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb001 LIKE sfeb_t.sfeb001, 
   sfeb023 LIKE sfeb_t.sfeb023, 
   sfeb027 LIKE sfeb_t.sfeb027, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmdt002 LIKE pmdt_t.pmdt002, 
   pmdt003 LIKE pmdt_t.pmdt003, 
   pmdt004 LIKE pmdt_t.pmdt004,
   pmdt036 LIKE pmdt_t.pmdt036,   #請購單單價  #160812-00005#1 pmdt007==>pmdt036(單價) 
   rate LIKE type_t.num20_6,
   rate2 LIKE type_t.num20_6,
   sfeb008 LIKE sfeb_t.sfeb008,   #已入庫回收料號
   sfeb009 LIKE sfeb_t.sfeb009,    
   sfeb012 LIKE sfeb_t.sfeb012,
   sfeb007 LIKE sfeb_t.sfeb007,   #申請單位
   sfeb010 LIKE sfeb_t.sfeb010,   #參考單位   
   sfebdocno LIKE sfeb_t.sfebdocno)
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create p350_02_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除TEMP
# Memo...........:
# Usage..........: CALL asfp350_drop_temp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success
# Date & Author..: 160707 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp350_drop_temp()
   DEFINE r_success          LIKE type_t.num5
   
   LET r_success = TRUE
   
   DROP TABLE p350_01_temp;
  
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p350_01_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   


   DROP TABLE p350_02_temp;
  
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop p350_02_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
