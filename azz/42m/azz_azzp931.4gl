#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp931.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-10-28 13:57:57), PR版次:0004(2016-09-26 15:35:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: azzp931
#+ Description: 型管批次更新問題管制表
#+ Creator....: 06815(2015-10-22 16:31:20)
#+ Modifier...: 06815 -SD/PR- 01101
 
{</section>}
 
{<section id="azzp931.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160601-00006#1   2016/06/01  by 03538   下*條件不能正常執行問題修正
#+ Creator....: No.160726-00017#3 2016/07/29 By frank0521 共用函式改呼叫library
#+ Modifier...: No.160829-00021#1 2016/08/29 By tsai_yen 1.同步更新客戶資料 2.連ERP DB再顯示訊息
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
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
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       gzwi001 LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_g_gzwi_inc        RECORD   #問題反映記錄檔,共用:cl_helps932,cl_helps932,azzi931,azzi932
   gzwi001 LIKE gzwi_t.gzwi001,             #問題編號  
   gzwi002 LIKE gzwi_t.gzwi002,             #類別
   gzwi003 LIKE gzwi_t.gzwi003,             #模組
   gzwi004 LIKE gzwi_t.gzwi004,             #問題描述
   gzwi005 LIKE gzwi_t.gzwi005,             #反映人員
   gzwi006 LIKE gzwi_t.gzwi006,             #反映人員營運據點
   gzwi007 LIKE gzwi_t.gzwi007,             #處理人員
   gzwi008 LIKE gzwi_t.gzwi008,             #作業編號
   gzwi009 LIKE gzwi_t.gzwi009,             #案件代號
   gzwi010 LIKE gzwi_t.gzwi010,             #緊急案件
   gzwi011 LIKE gzwi_t.gzwi011,             #處理狀態
   gzwi012 LIKE gzwi_t.gzwi012,             #更新摘要
   gzwi013 DATETIME YEAR TO SECOND,         #反應日期
   gzwi014 LIKE gzwi_t.gzwi014,             #負責單位:SCC '153': 0.產中;1.MIS;2.鼎新
   gzwi015 LIKE gzwi_t.gzwi015,             #處理人員類型,聯絡對象類型oofa002
   gzwi016 LIKE gzwi_t.gzwi016,             #流水號
   gzwi017 LIKE gzwi_t.gzwi017,             #反映企業代碼
   gzwi018 LIKE gzwi_t.gzwi018,             #處理人員,聯絡對象代碼一oofa003
   gzwistus LIKE gzwi_t.gzwistus,           #狀態碼
   gzwiownid LIKE gzwi_t.gzwiownid,         #資料所有者
   gzwiownid_desc LIKE type_t.chr80,        ##
   gzwiowndp LIKE gzwi_t.gzwiowndp,         #資料所屬部門
   gzwiowndp_desc LIKE type_t.chr80,        ##
   gzwicrtid LIKE gzwi_t.gzwicrtid,         #資料建立者
   gzwicrtid_desc LIKE type_t.chr80,        ##
   gzwicrtdp LIKE gzwi_t.gzwicrtdp,         #資料建立部門
   gzwicrtdp_desc LIKE type_t.chr80,        ##
   gzwicrtdt DATETIME YEAR TO SECOND,       #資料創建日
   gzwimodid LIKE gzwi_t.gzwimodid,         #資料修改者
   gzwimodid_desc LIKE type_t.chr80,        ##
   gzwimoddt DATETIME YEAR TO SECOND,       #最近修改日
   gzwi005_desc LIKE type_t.chr80,          #反映人員名稱
   gzwi005dp_desc LIKE type_t.chr80,        #反映人員部門名稱
   gzwi005op_desc LIKE type_t.chr80,        #反映人員營運據點名稱
   gzwi008_desc LIKE gzzal_t.gzzal003,      #作業程式名稱
   gzwi025 LIKE gzwi_t.gzwi025,             #確認書編號
   gzwi026 LIKE gzwi_t.gzwi026,             #最近同步時間
   gzwi027 LIKE gzwi_t.gzwi027,             #案件歷程
   gzwi028 LIKE gzwi_t.gzwi028,              #客戶代號
   gzwi028_desc LIKE type_t.chr80 
   END RECORD
TYPE type_g_gzwo_inc_2 RECORD         
   gzwoownid    LIKE gzwo_t.gzwoownid,   #資料所有者
   gzwoowndp    LIKE gzwo_t.gzwoowndp,   #資料所屬部門
   gzwocrtid    LIKE gzwo_t.gzwocrtid,   #資料建立者
   gzwocrtdp    LIKE gzwo_t.gzwocrtdp,   #資料建立部門
   gzwocrtdt    LIKE gzwo_t.gzwocrtdt,   #資料創建日
   gzwomodid    LIKE gzwo_t.gzwomodid,   #資料修改者
   gzwomoddt    LIKE gzwo_t.gzwomoddt,   #最近修改日
   gzwostus     LIKE gzwo_t.gzwostus,    #狀態碼
   gzwo001      LIKE gzwo_t.gzwo001,     #問題編號
   gzwo002      LIKE gzwo_t.gzwo002,     #類別
   gzwo003      LIKE gzwo_t.gzwo003,     #模組
   gzwo004      LIKE gzwo_t.gzwo004,     #問題描述
   gzwo005      LIKE gzwo_t.gzwo005,     #反映人員
   gzwo006      LIKE gzwo_t.gzwo006,     #反映營運據點
   gzwo007      LIKE gzwo_t.gzwo007,     #處理人員
   gzwo008      LIKE gzwo_t.gzwo008,     #作業編號
   gzwo009      LIKE gzwo_t.gzwo009,     #案件代號
   gzwo010      LIKE gzwo_t.gzwo010,     #緊急案件
   gzwo011      LIKE gzwo_t.gzwo011,     #處理狀態
   gzwo012      LIKE gzwo_t.gzwo012,     #更新摘要
   gzwo013      LIKE gzwo_t.gzwo013,     #反映日期
   gzwo014      LIKE gzwo_t.gzwo014,     #負責單位
   gzwo015      LIKE gzwo_t.gzwo015,     #處理人員類型
   gzwo016      LIKE gzwo_t.gzwo016,     #流水號
   gzwo017      LIKE gzwo_t.gzwo017,     #企業編號
   gzwo018      LIKE gzwo_t.gzwo018,     #處理人員
   gzwo019      LIKE gzwo_t.gzwo019,     #規格預計完成日
   gzwo020      LIKE gzwo_t.gzwo020,     #規格實際完成日
   gzwo021      LIKE gzwo_t.gzwo021,     #預計完成日
   gzwo022      LIKE gzwo_t.gzwo022,     #實際完成日
   gzwo023      LIKE gzwo_t.gzwo023,     #預估時數
   gzwo024      LIKE gzwo_t.gzwo024,     #實際時數
   gzwo025      LIKE gzwo_t.gzwo025,     #確認書編號
   gzwoseq      LIKE gzwo_t.gzwoseq,     #項次
   gzwo901      LIKE gzwo_t.gzwo901,     #執行指令
   gzwo902      LIKE gzwo_t.gzwo902,     #異動欄位
   gzwo026      LIKE gzwo_t.gzwo026,     #最近同步時間
   gzwo027      LIKE gzwo_t.gzwo012,     #案件歷程
   gzwo028      LIKE gzwo_t.gzwo028      #客戶代號
   END RECORD
DEFINE g_dbs2   STRING   
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="azzp931.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
  
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_dbs2 = g_dbs  #儲存原始DB資料
   DISPLAY "開始執行..."
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL azzp931_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp931 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp931_init()
 
      #進入選單 Menu (="N")
      CALL azzp931_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp931
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DISPLAY "執行完畢"
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp931.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp931_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
    
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp931.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp931_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success              BOOLEAN
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON gzwi001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.gzwi001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi001
            #add-point:ON ACTION controlp INFIELD gzwi001 name="construct.c.gzwi001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzwi001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwi001  #顯示到畫面上
            NEXT FIELD gzwi001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi001
            #add-point:BEFORE FIELD gzwi001 name="construct.b.gzwi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi001
            
            #add-point:AFTER FIELD gzwi001 name="construct.a.gzwi001"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp931_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
             
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
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
         CALL azzp931_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL azzp931_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp931_transfer_argv(ls_js)
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
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
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
 
{<section id="azzp931.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp931_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp931.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp931_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     BOOLEAN
   DEFINE l_syncway     STRING   #與服務平台同步方式 alm,almhelp,eservice
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp931_process_cs CURSOR FROM ls_sql
#  FOREACH azzp931_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_helps932_syncway() RETURNING l_syncway  
   IF l_syncway = "alm" THEN  #判斷同步方式是在產中內部直接連型管時，才可以執行程式azzp931

   ELSE
     INITIALIZE g_errparam TO NULL
     LET g_errparam.extend = ""
     LET g_errparam.code   = "azz-00931"   
     LET g_errparam.popup  = TRUE
     CALL cl_err()
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp931_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp931.get_buffer" >}
PRIVATE FUNCTION azzp931_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp931.msgcentre_notify" >}
PRIVATE FUNCTION azzp931_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp931.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 型管更新azzi932
# Usage..........: CALL azzp931_alm_updhelp(ls_js)
# Input parameter: ls_js 畫面上的條件
# Return code....: r_success
# Date & Author..: 2015/10/22 & s983961
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp931_alm_updhelp(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        BOOLEAN

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
