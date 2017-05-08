#該程式已解開Section, 不再透過樣板產出!
{<section id="axmp520.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000002
#+ 
#+ Filename...: axmp520
#+ Description: 引導式出貨通知處理作業
#+ Creator....: 02040(2015-06-05 10:34:08)
#+ Modifier...: 02040(2015-06-05 15:18:40) -SD/PR- 08992
 
{</section>}
 
{<section id="axmp520.global" >}
#應用 p01 樣板自動產生(Version:10)
#+ Modifier...: No.160318-00005#48  2016/3/31   pengxin  修正azzi902重复定义之错误讯息
#160727-00019#23   2016/08/15 By 08742    系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 
#                                          Mod   p520_02_xmdg_temp--> p520_tmp01  ,  p520_02_xmdh_temp--> p520_tmp02
#                                          Mod   p520_02_xmdi_temp--> p520_tmp03  ， axmp520_lock_b_t--> axmp520_tmp01
#                                          
#160913-00033#1    2016/09/26 By 06948    約定交貨日改抓xmdd011 (xmdc012 -> xmdd011)，調整axmp520、axmp520_01規格畫面及程式
#160706-00037#12   2016/10/21 By shiun    引導式作業調整的作法:進行到第二步時，針對勾選的資料中若有被別人處理中的單據提示"單據編號OOO+項次XX被其他使用者處理中"
#160706-00037#13   2016/11/14 By lienjunqi     整批加上
#                                          1.檢查第一步勾選的資料有沒有被別人處理中，測試資料有沒有被別人LOCK的EXECUTE前要先把變數清空
#                                          2.若排除掉被別人處理中的資料後，本次沒有需要處理的資料，l_where應補上1=2條件而非1=1
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT FGL axm_axmp520_01
IMPORT FGL axm_axmp520_02
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS "../../axm/4gl/axmp520_01.inc"
GLOBALS "../../axm/4gl/axmp520_02.inc"
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
 
 
PRIVATE TYPE type_master RECORD
       xmdc028 LIKE xmdc_t.xmdc028, 
   inac003 LIKE inac_t.inac003, 
   xmda004 LIKE xmda_t.xmda004, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda033 LIKE xmda_t.xmda033, 
  #xmdc012 LIKE xmdc_t.xmdc012,     #160913-00033#1 mark
   xmdd011 LIKE xmdd_t.xmdd011,     #160913-00033#1 add
   xmdc001 LIKE xmdc_t.xmdc001, 
   imaf141 LIKE imaf_t.imaf141,
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
 
{<section id="axmp520.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define 
   DEFINE l_success     LIKE type_t.num5
   #end add-point 
   #add-point:main段define (客製用)

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js

   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call

      #end add-point
      CALL axmp520_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp520 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmp520_init()
 
      #進入選單 Menu (="N")
      #CALL axmp520_ui_dialog()
      LET li_step = 1
      #使用while讓程式不斷的在步驟內運作  
      #每一次執行完都會回傳之後要做哪個動作   
      WHILE TRUE
         CASE li_step
            WHEN 1
              CALL axmp520_ui_dialog_step1()  RETURNING li_step
              
            WHEN 2
              CALL axmp520_ui_dialog_step2() RETURNING li_step
              
            WHEN 3
              CALL axmp520_ui_dialog_step3() RETURNING li_step
             
            WHEN 0
              EXIT WHILE 
          
            OTHERWISE
               EXIT WHILE
         END CASE
      END WHILE  
      #add-point:畫面關閉前

      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp520
   END IF
 
   #add-point:作業離開前
   #程式運作完了要記得把temp table刪掉
   CALL axmp520_01_drop_temp_table()  RETURNING l_success
   CALL axmp520_02_drop_temp_table()  RETURNING l_success
   CALL axmp520_03_drop_temp_table()  RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp520.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmp520_init()
   #add-point:init段define 
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   #add-point:init段define (客製用)

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
   CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp520_01"), "main_grid01", "Group", "master")
   CALL axmp520_01_init()     
   CALL cl_ui_replace_sub_window(cl_ap_formpath("axm", "axmp520_02"), "main_grid02", "Group", "master")
   CALL axmp520_02_init()      

   #先將嵌入的畫面都隱藏  
   CALL cl_set_comp_visible("main_vbox01",FALSE)
   CALL cl_set_comp_visible("main_vbox02",FALSE)  
   #建立各程式的temp table
   CALL axmp520_01_create_temp_table() RETURNING l_success
   CALL axmp520_02_create_temp_table() RETURNING l_success
   CALL axmp520_03_create_temp_table() RETURNING l_success
   
   #160808-00024 by whitney add start
   LET g_s_bas_0028 = cl_get_para(g_enterprise,g_site,'S-BAS-0028')
   LET g_s_bas_0036 = cl_get_para(g_enterprise,g_site,'S-BAS-0036')
   LET g_s_bas_0007 = cl_get_para(g_enterprise,g_site,'S-BAS-0007')
   #160808-00024 by whitney add end
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp520_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define 

   #end add-point
   #add-point:ui_dialog段define (客製用)

   #end add-point
   
   #add-point:ui_dialog段before dialog

   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2

      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         #應用 a58 樣板自動產生(Version:2)
         CONSTRUCT BY NAME g_master.wc ON xmdc028,inac003,xmda004,xmdadocno,xmdadocdt,xmda002,xmda033, 
            #xmdc012,xmdc001,imaf141    #160913-00033#1 mark
             xmdd011,xmdc001,imaf141    #160913-00033#1 add
            BEFORE CONSTRUCT
               #add-point:cs段before_construct

               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xmdc028
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdc028
            #add-point:ON ACTION controlp INFIELD xmdc028
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdc028  #顯示到畫面上
            NEXT FIELD xmdc028                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdc028
            #add-point:BEFORE FIELD xmdc028

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdc028
            
            #add-point:AFTER FIELD xmdc028

            #END add-point
            
 
         #Ctrlp:construct.c.inac003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inac003
            #add-point:ON ACTION controlp INFIELD inac003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inac003  #顯示到畫面上
            NEXT FIELD inac003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inac003
            #add-point:BEFORE FIELD inac003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inac003
            
            #add-point:AFTER FIELD inac003

            #END add-point
            
 
         #Ctrlp:construct.c.xmda004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmda004
            #add-point:ON ACTION controlp INFIELD xmda004
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda004  #顯示到畫面上
            NEXT FIELD xmda004                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmda004
            #add-point:BEFORE FIELD xmda004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmda004
            
            #add-point:AFTER FIELD xmda004

            #END add-point
            
 
         #Ctrlp:construct.c.xmdadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdadocno
            #add-point:ON ACTION controlp INFIELD xmdadocno
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdadocno  #顯示到畫面上
            NEXT FIELD xmdadocno                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdadocno
            #add-point:BEFORE FIELD xmdadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdadocno
            
            #add-point:AFTER FIELD xmdadocno

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdadocdt
            #add-point:BEFORE FIELD xmdadocdt

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdadocdt
            
            #add-point:AFTER FIELD xmdadocdt

            #END add-point
            
 
         #Ctrlp:construct.c.xmdadocdt
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdadocdt
            #add-point:ON ACTION controlp INFIELD xmdadocdt

            #END add-point
 
         #Ctrlp:construct.c.xmda002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmda002
            #add-point:ON ACTION controlp INFIELD xmda002
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
            NEXT FIELD xmda002                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmda002
            #add-point:BEFORE FIELD xmda002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmda002
            
            #add-point:AFTER FIELD xmda002

            #END add-point
            
 
         #Ctrlp:construct.c.xmda033
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmda033
            #add-point:ON ACTION controlp INFIELD xmda033
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmda033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda033  #顯示到畫面上
            NEXT FIELD xmda033                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmda033
            #add-point:BEFORE FIELD xmda033

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmda033
            
            #add-point:AFTER FIELD xmda033

            #END add-point
            
         #應用 a01 樣板自動產生(Version:1)
         #BEFORE FIELD xmdc012   #160913-00033#1 mark
          BEFORE FIELD xmdd011   #160913-00033#1 add
            #add-point:BEFORE FIELD xmdc012

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         #AFTER FIELD xmdc012   #160913-00033#1 mark
          AFTER FIELD xmdd011   #160913-00033#1 add
            
            #add-point:AFTER FIELD xmdc012

            #END add-point
            
 
         #Ctrlp:construct.c.xmdc012
         #應用 a03 樣板自動產生(Version:2)
         #ON ACTION controlp INFIELD xmdc012   #160913-00033#1 mark
          ON ACTION controlp INFIELD xmdd011   #160913-00033#1 add
            #add-point:ON ACTION controlp INFIELD xmdc012

            #END add-point
 
         #Ctrlp:construct.c.xmdc001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdc001
            #add-point:ON ACTION controlp INFIELD xmdc001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdc001  #顯示到畫面上
            NEXT FIELD xmdc001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdc001
            #add-point:BEFORE FIELD xmdc001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdc001
            
            #add-point:AFTER FIELD xmdc001

            #END add-point
            
 
         #Ctrlp:construct.c.imaf141
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141

            #END add-point
            
 
 
            
            #add-point:其他管控

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
            CALL axmp520_get_buffer(l_dialog)
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
         CALL axmp520_init()
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
                 CALL axmp520_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmp520_transfer_argv(ls_js)
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
 
{<section id="axmp520.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmp520_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用)
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axmp520.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmp520_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define 
   
   #end add-point
   #add-point:process段define (客製用)
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
 
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
#  DECLARE axmp520_process_cs CURSOR FROM ls_sql
#  FOREACH axmp520_process_cs INTO
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
   CALL axmp520_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp520.get_buffer" >}
PRIVATE FUNCTION axmp520_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmp520.msgcentre_notify" >}
PRIVATE FUNCTION axmp520_msgcentre_notify()
 
   DEFINE lc_state LIKE type_t.chr5
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp520.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 步驟1
# Memo...........:
# Usage..........: CALL axmp520_ui_dialog_step1()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 150709 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_ui_dialog_step1()


   #設定左方的流程圖  
   CALL axmp520_set_step_img('1')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp520_set_vbox_visible('1')
   
   #設定button隱藏
   CALL axmp520_set_act_visible('1')
   
   #mark--160706-00037#12 By shiun--(S)
#   #160120-00002#3 s983961--add(s)   
#   #開啟transaction 
#   CALL s_transaction_begin()
#   #160120-00002#3 s983961--add(e)
   #mark--160706-00037#12 By shiun--(E)
   
   #每次進入第一頁時 就是資料輸入模式 
   LET g_mode = "i"
   
   #設定右方的button開關 
   CALL axmp520_01_set_act_visible()   
#   CALL axmp520_01_b_fill()   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG axm_axmp520_01.axmp520_01_input
        SUBDIALOG axm_axmp520_01.axmp520_01_input01
        SUBDIALOG axm_axmp520_01.axmp520_01_construct


        BEFORE DIALOG
           IF g_action_choice = "back_step" THEN
              LET g_detail_idx = 1
              NEXT FIELD sel
           ELSE 
              NEXT FIELD xmdgdocno           
           END IF              

       
        ON ACTION Search                                  #搜尋  
           IF cl_null(g_xmdg_m.xmdgdocno) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'apm-00603'
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD xmdgdocno
           END IF        
           LET g_action_choice = "Search"
           IF cl_null(g_wc) THEN
              LET g_wc = ' 1=1'
           END IF
           CALL axmp520_01(g_wc)
           CALL s_transaction_begin()        #add--160706-00037#12 By shiun
           CALL axmp520_01_b_fill()           
           CALL s_transaction_end('Y','0')   #add--160706-00037#12 By shiun
           
           IF g_detail_cnt = 0 THEN              
              INITIALIZE g_errparam TO NULL
#              LET g_errparam.code = 'axm-00276'   #160318-00005#48  mark
              LET g_errparam.code = 'sub-01321'    #160318-00005#48  add
              LET g_errparam.extend = ""
              LET g_errparam.popup = TRUE
              CALL cl_err()
              NEXT FIELD xmdgdocno
           ELSE
              LET g_detail_idx = 1
              NEXT FIELD sel           
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
              CALL axmp520_01_save_temp()
              CALL s_transaction_begin()        #add--160706-00037#12 By shiun
              CALL axmp520_01_b_fill()
              CALL s_transaction_end('Y','0')   #add--160706-00037#12 By shiun
           END IF
             
        ON ACTION next_step                           #下一步，出貨資料調整
           IF axmp520_01_tmp_chk() THEN              #檢查底稿資料正確性       
              LET g_action_choice = "next_step"
              LET INT_FLAG = TRUE
              EXIT DIALOG
           END IF
           
        #CS：客戶全選  OS：訂單全選   AS：全選   S：單選   US：取消單選   UA：取消全選        
        #取消所選資料
        ON ACTION unsel
           LET g_action_choice = "unsel"
           CALL axmp520_01_sel_action('US')        
        #取消全部
        ON ACTION selnone                           
           LET g_action_choice = "selnone"
           CALL axmp520_01_sel_action('UA')  
        #勾選所選資料
        ON ACTION sel
           LET g_action_choice = "sel"
           CALL axmp520_01_sel_action('S')
        #選擇全部
        ON ACTION selall                       
           LET g_action_choice = "selall"
           CALL axmp520_01_sel_action('AS')
        #客戶全選
        ON ACTION all_c_sel                    
           LET g_action_choice = "all_c_sel"
           CALL axmp520_01_sel_action('CS')
        #訂單全選  
        ON ACTION all_o_sel                    
           LET g_action_choice = "all_o_sel"
           CALL axmp520_01_sel_action('OS')
        #取消全選 
        ON ACTION all_un_sel                   
           LET g_action_choice = "all_un_sel"
           CALL axmp520_01_sel_action('UA')
        #檢示底稿
        ON ACTION see_tmp                         
           LET g_mode = 'd'
           CALL axmp520_01_set_act_visible()             
           CALL axmp520_01_b_fill_tmp()
        #刪資底稿
        ON ACTION del_tmp                          
           CALL axmp520_01_del_tmp()
           CALL axmp520_01_b_fill_tmp()
           
        #出貨資料 
        ON ACTION sel_mode                                   
           LET g_mode = 'i'
           CALL axmp520_01_set_act_visible() 
           CALL axmp520_01_b_fill()            

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
   
   #mark--160706-00037#12 By shiun--(S)
#   #160120-00002#3 s983961--add(s)   
#   CALL s_transaction_end('Y','0')
#   #160120-00002#3 s983961--add(e) 
   #mark--160706-00037#12 By shiun--(E)

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
################################################################################
# Descriptions...: 步驟2
# Memo...........:
# Usage..........: CALL axmp520_ui_dialog_step2()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 150709 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_ui_dialog_step2()
DEFINE l_success         LIKE type_t.num5
#160120-00002#1 s983961--add(s)   
DEFINE l_sql       STRING
DEFINE l_where     STRING
DEFINE l_xmdcdocno LIKE xmdc_t.xmdcdocno
DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq 
#160120-00002#1 s983961--add(e) 
#add--160706-00037#12 By shiun--(S) 
DEFINE l_docno     LIKE xmdc_t.xmdcdocno
DEFINE l_seq       LIKE xmdc_t.xmdcseq
#add--160706-00037#12 By shiun--(E)

   #設定左方的流程圖  
   CALL axmp520_set_step_img('2')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp520_set_vbox_visible('2')
   
   #設定button隱藏
   CALL axmp520_set_act_visible('2')
   
   #畫面欄位顯示 與 隱藏      
   CALL cl_set_comp_visible("docno",FALSE)   #出貨單號
   CALL cl_set_comp_visible("result",FALSE)  #執行結果
   CALL axmp520_set_comp_visible()           #160808-00024 by whitney add
   
   #add--160706-00037#12 By shiun--(S)
   CALL s_transaction_begin()

   CALL cl_err_collect_init()

   LET l_sql = "SELECT xmdcdocno,xmdcseq ",
               "  FROM axmp520_tmp01 ",
               " ORDER BY xmdcdocno,xmdcseq "
   PREPARE p520_chk_lock_prep FROM l_sql
   DECLARE p520_chk_lock_curs CURSOR WITH HOLD FOR p520_chk_lock_prep

   LET l_sql = "SELECT xmdcdocno,xmdcseq ",
               "  FROM xmdc_t ",
               " WHERE xmdcent = '",g_enterprise,"' ",
               "   AND xmdcdocno = ? ",
               "   AND xmdcseq   = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE p520_test_lock_prep FROM l_sql

   LET l_xmdcdocno = ''   
   LET l_xmdcseq   = ''
   FOREACH p520_chk_lock_curs INTO l_xmdcdocno,l_xmdcseq
      LET l_docno = ''   
      LET l_seq   = ''
      EXECUTE p520_test_lock_prep USING l_xmdcdocno,l_xmdcseq
                                   INTO l_docno,l_seq
      IF cl_null(l_docno) OR cl_null(l_seq) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_xmdcdocno
         LET g_errparam.replace[2] = l_xmdcseq
         CALL cl_err()


         DELETE FROM p520_01_xmdh
          WHERE xmdh001 = l_xmdcdocno
            AND xmdh002 = l_xmdcseq

         DELETE FROM p520_01_tmp
          WHERE xmdh001 = l_xmdcdocno
            AND xmdh002 = l_xmdcseq
         
         DELETE FROM axmp520_tmp01
          WHERE xmdcdocno = l_xmdcdocno
            AND xmdcseq   = l_xmdcseq

      END IF

      LET l_xmdcdocno = ''   
      LET l_xmdcseq   = ''
   END FOREACH

   CALL cl_err_collect_show()

   CALL s_transaction_end('Y','0')
   #add--160706-00037#12 By shiun--(E)
   
   #160120-00002#3 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#3 s983961--add(e)
   
   LET g_action_choice = NULL   
   
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_init()
   
   #160120-00002#3 s983961--add(s)
   LET l_sql = "SELECT xmdcdocno,xmdcseq ",
               "  FROM axmp520_tmp01 ",           #160727-00019#23 Mod  axmp520_lock_b_t--> axmp520_tmp01
               " ORDER BY xmdcdocno,xmdcseq "
   PREPARE axmp520_02_lock_prep FROM l_sql
   DECLARE axmp520_02_lock_curs CURSOR FOR axmp520_02_lock_prep

   LET l_sql = "SELECT xmdcdocno,xmdcseq ",
               "  FROM xmdc_t ",
               #" WHERE "  #160706-00037#13  MARK
               #160706-00037#13-s
               " WHERE xmdcent = ",g_enterprise," AND ("
               #160706-00037#13-e

   LET l_where = ''
   FOREACH axmp520_02_lock_curs INTO l_xmdcdocno,l_xmdcseq
      IF cl_null(l_where) THEN
         LET l_where = "(xmdcdocno = '",l_xmdcdocno,"' AND xmdcseq = '",l_xmdcseq,"')"
      ELSE
         LET l_where = l_where," OR ","(xmdcdocno = '",l_xmdcdocno,"' AND xmdcseq = '",l_xmdcseq,"')"
      END IF
   END FOREACH
   #add--160706-00037#13-s
   IF cl_null(l_where) THEN
      LET l_where  = " 1=2 "
   END IF
   LET l_where = l_where," )"
   #add--160706-00037#13-e
   LET l_sql = l_sql,l_where," FOR UPDATE " 
   PREPARE axmp520_02_lock_body_prep FROM l_sql
   DECLARE axmp520_02_lock_body_curs CURSOR FOR axmp520_02_lock_body_prep
   OPEN axmp520_02_lock_body_curs
   #160120-00002#3 s983961--add(e)
   
   CALL axmp520_02()
   CALL axmp520_02_b_fill()
   CALL axmp520_02_fetch()
   
   #匯總資料時，錯誤訊息先匯總後再顯示
   CALL cl_err_collect_show()
   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        SUBDIALOG axm_axmp520_02.axmp520_02_input01
        SUBDIALOG axm_axmp520_02.axmp520_02_display01
        #SUBDIALOG axm_axmp520_02.axmp520_02_input02  #151118-00029 20160225 s983961--mark
        SUBDIALOG axm_axmp520_02.axmp520_02_display04
        SUBDIALOG axm_axmp520_02.axmp520_02_display02
        SUBDIALOG axm_axmp520_02.axmp520_02_display03

        
        BEFORE DIALOG
            NEXT FIELD l_gather

        ON ACTION axmp520_02_modify_detail                         #點擊待出貨明細頁籤，進入INPUT段
           LET g_action_choice = "axmp520_02_modify_detail"
           CALL axmp520_02_b()  #151118-00029 20160225 s983961--add

        ON ACTION CLOSE
           LET INT_FLAG = TRUE
           LET g_action_choice = "CLOSE"
           EXIT DIALOG

        ON ACTION EXIT
           LET INT_FLAG = TRUE
           LET g_action_choice = "EXIT"
           EXIT DIALOG

        ON ACTION back_step                    #抓取出貨資料(回到上一步)
           IF cl_ask_confirm('apm-00541') THEN
              LET g_action_choice = "back_step"
              LET INT_FLAG = TRUE
              EXIT DIALOG
           END IF           
            
         ON ACTION over                         #完成
            #檢查資料是否都有輸入
            CALL axmp520_02_check_field() RETURNING l_success
            IF NOT l_success THEN
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
   
   #160120-00002#3 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#3 s983961--add(e) 
   
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
# Usage..........: CALL axmp520_ui_dialog_step3()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 150709 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_ui_dialog_step3()

   #設定左方的流程圖  
   CALL axmp520_set_step_img('3')

   #設定嵌入畫面的 顯示 與 隱藏 
   CALL axmp520_set_vbox_visible('3')
   
   #設定button隱藏
   CALL axmp520_set_act_visible('3')
   
   #畫面欄位顯示 與 隱藏 
   CALL cl_set_comp_visible("docno",TRUE)   #出貨單號
   CALL cl_set_comp_visible("result",TRUE)  #執行結果    
   CALL axmp520_set_comp_visible()          #160808-00024 by whitney add

   #160120-00002#3 s983961--add(s)   
   #開啟transaction 
   CALL s_transaction_begin()
   #160120-00002#3 s983961--add(e)

   LET g_action_choice = NULL
   CALL axmp520_02_ins_xmdg()
   CALL axmp520_02_b_fill()
   CALL axmp520_02_fetch()
   
   WHILE TRUE
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)    
        SUBDIALOG axm_axmp520_02.axmp520_02_display01
        SUBDIALOG axm_axmp520_02.axmp520_02_display02
        SUBDIALOG axm_axmp520_02.axmp520_02_display03
        SUBDIALOG axm_axmp520_02.axmp520_02_display04       

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
            DELETE FROM p520_01_tmp              #出通底稿
            DELETE FROM p520_tmp01               #出通單頭     #160727-00019#23 Mod  p520_02_xmdg_temp--> p520_tmp01     
            DELETE FROM p520_tmp02               #出通單身     #160727-00019#23 Mod  p520_02_xmdh_temp--> p520_tmp02    
            DELETE FROM p520_tmp03               #多庫儲批     #160727-00019#23 Mod  p520_02_xmdi_temp--> p520_tmp03
            CALL axmp520_01(g_wc)
            LET g_action_choice = "back_first"
            LET INT_FLAG = TRUE
            EXIT DIALOG
            
         ON ACTION open_axmt520                    #出貨單維護
            CALL axmp520_02_open_axmt520()
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

   #160120-00002#3 s983961--add(s)   
   CALL s_transaction_end('Y','0')
   #160120-00002#3 s983961--add(e) 

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
# Usage..........: CALL axmp520_set_step_img(p_step)
# Input parameter: p_step    第幾步驟的圖
# Date & Author..: 15/07/09 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_set_step_img(p_step)
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
# Usage..........: CALL axmp520_set_vbox_visible(p_step)
# Input parameter: p_step   步驟
# Date & Author..: 15/07/09 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_set_vbox_visible(p_step)
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
# Usage..........: CALL axmp520_set_act_visible(p_step)
# Input parameter: p_step  步驟
# Date & Author..: 15/07/09 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_set_act_visible(p_step)
   DEFINE p_step     LIKE type_t.num5

   CALL cl_set_comp_visible("next_step",FALSE)           #出貨調整 
   CALL cl_set_comp_visible("save",FALSE)                #出貨資料寫入 
     
   CALL cl_set_comp_visible("back_step",FALSE)           #抓取出貨資料   
   CALL cl_set_comp_visible("over",FALSE)                #完成  
   
   CALL cl_set_comp_visible("back_first",FALSE)          #回待出貨資料
   CALL cl_set_comp_visible("open_axmt520",FALSE)        #出貨單維護
   
   CASE p_step
      WHEN 1
         CALL cl_set_comp_visible("next_step",TRUE)           #出貨調整          
      WHEN 2
         CALL cl_set_comp_visible("back_step",TRUE)           #抓取出貨資料、完成 
         CALL cl_set_comp_visible("over",TRUE)                #完成
      WHEN 3
         CALL cl_set_comp_visible("back_first",TRUE)          #回待出貨資料 
         CALL cl_set_comp_visible("open_axmt520",TRUE)        #出貨單維護

   END CASE   
   
END FUNCTION

################################################################################
# Descriptions...: axmp520_02欄位顯隱
# Memo...........:
# Usage..........: CALL axmp520_set_comp_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 160808-00024 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp520_set_comp_visible()


   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護(據點參數:S-BAS-0028)
   IF g_s_bas_0028 = 'N' THEN
      CALL cl_set_comp_visible("xmdh018,xmdh018_desc,xmdh019_02,xmdi010,xmdi010_desc,xmdi011",FALSE)
      CALL cl_set_comp_visible("lbl_xmdl019,xmdl019,lbl_xmdl019_display,xmdl019_desc,lbl_xmdl020,xmdl020,xmdi010,xmdi010_desc,xmdi011",FALSE)
   END IF

   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF g_s_bas_0036 = 'N' THEN
      CALL cl_set_comp_visible("xmdh007,xmdh007_desc,xmdi002,xmdi002_desc,xmdc002,xmdc002_desc",FALSE)
      CALL cl_set_comp_visible("lbl_xmdl009,xmdl009,xmdi002",FALSE)
   END IF

   #整體參數未使用採購計價單位
   IF g_s_bas_0007 = 'N' THEN
      CALL cl_set_comp_visible("xmdh020,xmdh020_desc,xmdh021_02,xmdc010,xmdc010_desc,xmdc011",FALSE)
      CALL cl_set_comp_visible("",FALSE)
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
