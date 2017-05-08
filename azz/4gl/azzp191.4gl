#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp191.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0029(2017-02-20 14:42:22), PR版次:0029(2016-12-19 17:18:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000268
#+ Filename...: azzp191
#+ Description: 畫面多語言元件產生工具
#+ Creator....: 00845(2014-02-13 18:25:57)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzp191.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Modify.........: No.160330-00012#1 16/03/31 By catmoon 將CALL cl_progress_no_window_ing(參數)參數有中文的情形改由變數帶入
#Modify.........: No.160414-00005#1 16/04/14 By jrg542  修正行業別程式無法預覽的問題
#Modify.........: No.160420-00002#1 16/04/20 By jrg542  Light 平台 增加 azzt000 多語言機制
#Modify.........: No.160518-00049#1 16/04/20 By jrg542  修正參數作業沒有轉換出多語言，畫面呈現出來是未轉換的的標籤(沒正常顯示出中文畫面)
#Modify.........: No.160706-00005#1 16/07/06 By jrg542  azzp191 優化 傳入zh_TW，可以帶出其他語言別
#Modify.........: No.160822-00025#1 16/08/29 By jrg542  T100rebuild 系統工具優化 配合產生42s修改
#Modify.........: No.160906-00055#1 16/09/06 By jrg542  修正azzp191 傳入參數 傳入多個語言別，可以一併帶出其他str
#Modify.........: No.161017-00003#1 16/10/17 By jrg542  azzp191 產生多個語系時，沒有正確產生str
#Modify.........: No.161024-00002#1 16/10/24 By jrg542  修正組語系en_US的str檔，不用把空白去掉
#Modify.........: No.161129-00065#1 16/11/29 By jrg542  當一次同時產生多個語系會造成 檢體轉換標籤有、繁體轉換標籤沒有的情況時，簡體語系str 檔會漏掉簡體標籤
#Modify.........: No.161219-00019#1 16/12/19 By jrg542  azzi310 不重新產生str 42s 
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
               gzzd002 LIKE gzzd_t.gzzd002,
      wc1                 STRING,
      wc2                 STRING,
      wc3                 STRING,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       gzzz001 LIKE gzzz_t.gzzz001, 
   gzde001 LIKE gzde_t.gzde001, 
   gzdf002 LIKE gzdf_t.gzdf002, 
   gzzd002 LIKE gzzd_t.gzzd002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
GLOBALS   
   DEFINE gs_cmd         STRING 
   DEFINE gd_4gl_arr     DYNAMIC ARRAY OF STRING 
   DEFINE gd_4fd_array   DYNAMIC ARRAY OF STRING
   DEFINE gi_count       LIKE type_t.num5
   DEFINE gt_lang        LIKE gzzd_t.gzzd002
   DEFINE gc_main_prog LIKE gzza_t.gzza001
END GLOBALS 

DEFINE g_record DYNAMIC ARRAY OF RECORD
         item    STRING,
         value   STRING
                 END RECORD
#160706-00005#1 start                 
DEFINE g_record_tag DYNAMIC ARRAY OF RECORD                 
         gzzd001  LIKE gzzd_t.gzzd001,
         gt_lang  LIKE gzzd_t.gzzd002,
         gzzdstus LIKE gzzd_t.gzzdstus,
         gzzd003  LIKE gzzd_t.gzzd003,
         gzzd005  LIKE gzzd_t.gzzd005
    END RECORD 
#160706-00005#1 end    
                 
DEFINE g_target STRING
DEFINE g_gzzz001 LIKE gzzz_t.gzzz001
DEFINE g_gzzz002 LIKE gzzz_t.gzzz002
DEFINE g_item DYNAMIC ARRAY OF RECORD
         gzsx002 LIKE gzsx_t.gzsx002,
         page_no LIKE type_t.num5,
         gzsx003 LIKE gzsx_t.gzsx003,
         item_no LIKE type_t.num5,
         gzsxl005 LIKE gzsxl_t.gzsxl005
                 END RECORD
DEFINE g_stronly LIKE type_t.num5
DEFINE g_t100rebuild LIKE type_t.num5
DEFINE g_start_time  DATETIME YEAR TO FRACTION(5)
DEFINE g_end_time    DATETIME YEAR TO FRACTION(5)
DEFINE g_str_lang    STRING 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzp191.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE ls_target    STRING
   DEFINE lc_spec_type LIKE type_t.chr1
   
   LET g_bgjob = "Y"
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   # 傳進來是語言別表示要 背景執行
   IF g_argv[2] IS NOT NULL THEN
      LET g_bgjob = "Y"
   ELSE 
      LET ls_js = g_argv[1]
      display "ls_js:",ls_js
	   display "g_argv[1]:",g_argv[1]
      #當排程設定的指定時間背景執行
      IF ls_js.getIndexOf("{",1) AND ls_js.getIndexOf("}",ls_js.getIndexOf("{",1)+1) THEN #{"gzzd002":"zh_TW","wc1":"gzzz001='azzi903'","wc2":" 1=2","wc3":" 1=2"}
         LET g_bgjob = "Y"
      ELSE  
         LET g_bgjob = "N"
      END IF 
      #LET g_bgjob = "N"
   END IF 
   
   IF g_t100debug = "9" THEN
      DISPLAY  "g_argv[1]:",g_argv[1]
      DISPLAY  "g_argv[2]:",g_argv[2]
      DISPLAY  "g_argv[3]:",g_argv[3] #若此數值為 tiptop 表示由 rebuild 串入
      DISPLAY  "g_argv[4]:",g_argv[4]
      DISPLAY  "g_argv[5]:",g_argv[5]
   END IF 
   LET g_start_time = cl_get_timestamp()   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      LET ls_js = "" #稍等重新給予, 搭配r.r傳入參數重新配置
      #需要特別拉出來定義不是背景的狀態
      IF g_argv[4] IS NOT NULL AND g_argv[4].getIndexOf("_",1) THEN     
         #當排程設定的立即背景執行
         #格式 g_argv[1]:gzzz001='azzi900' g_argv[2]: 1=2 g_argv[3]: 1=2 g_argv[4]:zh_TW g_argv[5]:
         #g_argv[1]:{"gzzd002":"zh_TW","wc1":"gzzz001='azzi900'","wc2":" azzi901","wc3":"azzi900_s01"}
         LET lc_param.wc1 = g_argv[1]
         IF lc_param.wc1.getIndexOf("=",1) THEN
            LET lc_param.wc1 = lc_param.wc1.subString(1,lc_param.wc1.getIndexOf("=",1)),
                               lc_param.wc1.subString(lc_param.wc1.getIndexOf("=",1)+1,lc_param.wc1.getLength())
                               #"'",lc_param.wc1.subString(lc_param.wc1.getIndexOf("=",1)+1,lc_param.wc1.getLength()),
                               #"'"
         END IF
         LET lc_param.wc2 = g_argv[2]
         LET lc_param.wc3 = g_argv[3]
         LET lc_param.gzzd002 = g_argv[4]
         LET ls_js = util.JSON.stringify( lc_param )
      ELSE
         #當排程設定的指定時間背景執行
         #格式 g_argv[1]:{"gzzd002":"zh_TW","wc1":"gzzz001='azzi900'","wc2":" 1=2","wc3":" 1=2"} g_argv[2]: g_argv[3]: g_argv[4]: g_argv[5]:
         IF g_argv[2] IS NULL THEN 
            LET ls_js = g_argv[1]
            CALL util.JSON.parse(ls_js,lc_param)
         ELSE 
            #一般指令執行 r.r azzp191 azzi900 zh_TW
            LET lc_spec_type = cl_chk_spec_type(g_argv[1])
            CASE
               WHEN lc_spec_type = "M" OR lc_spec_type = "N"  #主程式
                  LET lc_param.wc1 = "gzzz001='",DOWNSHIFT(g_argv[1]),"'"
                  LET lc_param.wc2 = " 1=2"
                  LET lc_param.wc3 = " 1=2"
               WHEN lc_spec_type = "S"   #子程式
                  LET lc_param.wc1 = " 1=2"
                  LET lc_param.wc2 = "gzde001='",DOWNSHIFT(g_argv[1]),"'"
                  LET lc_param.wc3 = " 1=2"
               WHEN lc_spec_type = "F"   #子畫面
                  LET lc_param.wc1 = " 1=2"
                  LET lc_param.wc2 = " 1=2"
                  LET lc_param.wc3 = "gzdf002='",DOWNSHIFT(g_argv[1]),"'"
               WHEN lc_spec_type = "Q"   #開窗畫面
                  LET lc_param.wc1 = "dzca001='",DOWNSHIFT(g_argv[1]),"'"
                  LET lc_param.wc2 = " 1=2"
                  LET lc_param.wc3 = " 1=2"
                  LET g_argv[5] = "Y"                 
            END CASE 
            #160906-00055 start            
            LET g_str_lang = g_argv[2] 
            IF g_str_lang.getIndexOf(",",1) THEN 
               LET lc_param.gzzd002 = g_str_lang.subString(1,g_str_lang.getIndexOf(",",1)-1)
               #從第二個語系截取 
               LET g_str_lang = g_str_lang.subString(g_str_lang.getIndexOf(",",1)+1,g_str_lang.getLength()) 
            ELSE 
               LET lc_param.gzzd002 = g_argv[2]    
            END IF 
            LET ls_js = util.JSON.stringify( lc_param )
            #160906-00055 end 
         END IF 
      END IF
      #當是背景 呼叫azzp191 時 參數指定格式 r.r azzp191 azzi900 zh_TW '' '' Y
      IF g_argv[5] IS NOT NULL AND g_argv[5] = "Y" THEN
         LET g_stronly = 1   #只做str
      ELSE
         LET g_stronly = 0   #沒限制
      END IF
      
      #end add-point
      CALL azzp191_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp191 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp191_init()
 
      #進入選單 Menu (="N")
      CALL azzp191_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
                  
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp191
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp191.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp191_init()
 
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
    CALL cl_set_combo_lang("gzzd002")
         
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp191.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp191_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
         
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
      CONSTRUCT lc_param.wc1 ON gzzz001 FROM gzzz001
            BEFORE CONSTRUCT
         END CONSTRUCT
         CONSTRUCT lc_param.wc2 ON gzde001 FROM gzde001
            BEFORE CONSTRUCT
         END CONSTRUCT
         CONSTRUCT lc_param.wc3 ON gzdf002 FROM gzdf002
            BEFORE CONSTRUCT
         END CONSTRUCT
      

 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
      INPUT lc_param.gzzd002 FROM gzzd002
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
      END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                           
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp191_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET lc_param.gzzd002 = g_master.gzzd002
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
         CALL azzp191_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      IF lc_param.wc1.getIndexOf("1=1",1) THEN LET lc_param.wc1 = " 1=2" END IF
      IF lc_param.wc2.getIndexOf("1=1",1) THEN LET lc_param.wc2 = " 1=2" END IF
      IF lc_param.wc3.getIndexOf("1=1",1) THEN LET lc_param.wc3 = " 1=2" END IF

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
                 CALL azzp191_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp191_transfer_argv(ls_js)
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
 
{<section id="azzp191.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp191_transfer_argv(ls_js)
 
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
   #把 ls_js 填到 la_param
   CALL util.JSON.parse(ls_js,la_param)
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.param[1] = la_param.wc1
   LET la_cmdrun.param[2] = la_param.wc2
   LET la_cmdrun.param[3] = la_param.wc3
   LET la_cmdrun.param[4] = la_param.gzzd002
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp191.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp191_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   #傳進來的參數是
   #作業級 作業級有關
   #主程式 主程式相關
   #子程式 取子程式本身
   #子作業 取子畫面
   DEFINE ls_target   STRING
   DEFINE ls_temp     STRING
   DEFINE ls_module   STRING
   DEFINE ls_path     STRING
   DEFINE li_pos      LIKE type_t.num10
   DEFINE lnode_temp  om.DomNode
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE lc_target   LIKE gzza_t.gzza001
   DEFINE lc_type     LIKE type_t.chr1    #傳入的規格型態
   DEFINE lc_gzzz001  LIKE gzzz_t.gzzz001
   DEFINE li_cnt1     LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE li_cnt3     LIKE type_t.num10
   DEFINE li_cnt_4fd  LIKE type_t.num10
   DEFINE li_stus_4fd LIKE type_t.num5
   DEFINE ls_info     STRING             #160330-00012#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET gt_lang = lc_param.gzzd002

   LET lc_target = ls_target
   LET gi_count = 1
   CALL g_item.clear()
   
   #預先計算progressbar迴圈次數
   IF lc_param.wc1.getIndexOf("dzca001",1) THEN
      LET ls_sql = "SELECT count(dzca001) FROM dzca_t "
   ELSE
      LET ls_sql = "SELECT count(gzzz001) FROM gzzz_t "
   END IF
   LET ls_sql = ls_sql, " WHERE ",lc_param.wc1

   PREPARE azzp191_cnt1_cs FROM ls_sql
   EXECUTE azzp191_cnt1_cs INTO li_cnt1
   FREE azzp191_cnt1_cs
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #將s類需要用到的全域變數陣列清空

   #計算迴圈次數
     LET ls_sql = "SELECT count(gzde001) FROM gzde_t ",
                  " WHERE ",lc_param.wc2
     PREPARE azzp191_cnt2_cs FROM ls_sql
     EXECUTE azzp191_cnt2_cs INTO li_cnt2
     FREE azzp191_cnt2_cs
     LET ls_sql = "SELECT count(gzdf002) FROM gzdf_t ",
                  " WHERE ",lc_param.wc3
     PREPARE azzp191_cnt3_cs FROM ls_sql
     EXECUTE azzp191_cnt3_cs INTO li_cnt3
     FREE azzp191_cnt3_cs

     #LET li_count = (li_cnt1+li_cnt2+li_cnt3) * 3 #15/04/24 先註解 jrg542
     LET li_count = (li_cnt1+li_cnt2+li_cnt3) 
     CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp191_process_cs CURSOR FROM ls_sql
#  FOREACH azzp191_process_cs INTO
   #add-point:process段process name="process.process"
            
   # li_cnt1 > 0 表示先以作業為主否則以程式為主,另外1=2表示其實傳入就已判定非主程式
   IF li_cnt1 > 0 OR lc_param.wc1 = " 1=2" THEN
      IF lc_param.wc1.getIndexOf("dzca001",1) THEN
         LET ls_sql = "SELECT UNIQUE dzca001 FROM dzca_t "
      ELSE
         LET ls_sql = "SELECT gzzz001 FROM gzzz_t "
      END IF
      LET ls_sql = ls_sql," WHERE ",lc_param.wc1, " UNION "
   ELSE
      LET ls_sql = "SELECT gzza001 FROM gzza_t ",
                   " WHERE gzza001 = ",lc_param.wc1.subString(lc_param.wc1.getIndexOf("=",1)+1,lc_param.wc1.getLength()), " UNION "
   END IF
   LET ls_sql = ls_sql, "SELECT gzde001 FROM gzde_t ",
                        " WHERE ",lc_param.wc2, " UNION ",
                        "SELECT gzdf002 FROM gzdf_t ",
                        " WHERE ",lc_param.wc3

   DECLARE azzp191_process_cs CURSOR FROM ls_sql
   
   FOREACH azzp191_process_cs INTO lc_gzzz001
      LET g_target = lc_gzzz001
      LET lc_target = lc_gzzz001
      #part 1
      IF g_bgjob <> "Y" THEN
        #CALL cl_progress_no_window_ing("讀取"||lc_gzzz001||"基本資料")        #160330-00012#1 mark
         LET ls_info = cl_getmsg_parm("azz-01004",g_lang,lc_gzzz001)          #160330-00012#1 add
         CALL cl_progress_no_window_ing(ls_info)                              #160330-00012#1 add
      END IF

      LET ls_target = lc_gzzz001
      LET lc_type = cl_chk_spec_type(ls_target) 
      #M:主程式  B:應用元件  S:子程式  L:library F:子畫面 N:Null
      #No.160420-00002#1
      LET ls_module = azzp191_check_module(g_target,lc_type) #模組取到，避免解析4fd錯誤
      IF lc_type = "B" OR lc_type = "S" OR lc_type = "L" OR lc_type = "F" OR lc_type = "Q" THEN
         #LET ls_module = azzp191_check_module(g_target,lc_type)
         LET ls_path = os.Path.join(os.Path.join(FGL_GETENV(ls_module),"4fd"),g_target),".4fd"
         LET lnode_temp = s_azzp191_load_xml(ls_path)
         CALL azzp191_analyze(lnode_temp,ls_path)
         CALL azzp191_compose_str()
         CONTINUE FOREACH
      ELSE
         #注意:留下M 主程式 及 N <-表象是NULL,實際上應該是作業ID


         #將作業轉換為程式名稱 (作業與程式其實不衝突,所以當輸入的是程式應該也要找到)
         SELECT gzzz001,gzzz002 INTO g_gzzz001,g_gzzz002
           FROM gzzz_t
          WHERE gzzz001 = lc_target
            AND gzzzstus = 'Y'
         IF SQLCA.SQLCODE THEN
            #會進到此處,是因為還沒有註冊為作業
            SELECT gzza001,gzza001 INTO g_gzzz001,g_gzzz002
              FROM gzza_t
             WHERE gzza001 = lc_target
               AND gzzastus = 'Y'
         END IF
         #161219-00019 start
         IF (g_gzzz001 <> "azzi310" AND g_gzzz002 = "azzi310" )THEN 
            DISPLAY  "共用azzi310相關作業不產生str、42s"
            DISPLAY  "INFO: Succeed:1",gt_lang
            RETURN 
            
         END IF
         #161219-00019 end
         IF NOT cl_null(g_gzzz001) AND NOT cl_null(g_gzzz002) THEN 
            LET ls_target = g_gzzz002
            LET g_target = g_gzzz002
         END IF
      END IF
      IF g_t100debug = "9" THEN
         DISPLAY "module:", azzp191_check_module(g_target,lc_type)
      END IF 
      #part 2
      IF g_bgjob <> "Y" THEN
        #CALL cl_progress_no_window_ing("讀取"||lc_gzzz001||"相關4fd並分析") #160330-00012#1 mark
         LET ls_info = cl_getmsg_parm("azz-01005",g_lang,lc_gzzz001)        #160330-00012#1 add
         CALL cl_progress_no_window_ing(ls_info)                            #160330-00012#1 add
      END IF
      #讀取 相關4fd 並分IF NOT gd_4gl_arr.getLength() > 0 OR gd_4fd_array.getLength() = 0 THEN析
      CALL s_azzp191_reads_gzzl_info(ls_target)

      IF gd_4gl_arr.getLength() > 0 THEN
         #若可以成功讀取, 就開始分析4gl code
         CALL azzp191_analyze_fglrun_info()
      END IF

      IF NOT gd_4gl_arr.getLength() > 0 OR gd_4fd_array.getLength() = 0 THEN
         #若失敗的話,就直接把4fd檔案寫入4fd array
         LET li_cnt = gd_4fd_array.getLength() + 1
         #LET ls_module = azzp191_check_module(g_target,lc_type)
         LET gd_4fd_array[li_cnt] = FGL_GETENV(UPSHIFT(ls_module)),"/4fd/",ls_target.trim(),".4fd" #160414-00005#1 
         #LET gd_4fd_array[li_cnt] = FGL_GETENV(UPSHIFT(ls_target.subString(1,3))),"/4fd/",ls_target.trim(),".4fd" 160414-00005#1 mark 
      ELSE
         #指定的主程式       
         IF gc_main_prog IS NOT NULL THEN
            LET li_stus_4fd = FALSE
            FOR li_cnt_4fd = 1 TO gd_4fd_array.getLength()
               IF os.Path.rootname(os.Path.basename(gd_4fd_array[li_cnt_4fd])) = gc_main_prog THEN
                  LET li_stus_4fd = TRUE
                  EXIT FOR
               END IF
            END FOR
            IF NOT li_stus_4fd THEN
               LET li_cnt = gd_4fd_array.getLength() + 1
               LET gd_4fd_array[li_cnt] = FGL_GETENV(UPSHIFT(ls_target.subString(1,3))),"/4fd/",ls_target.trim(),".4fd"
            END IF
         END IF      
      END IF

      FOR li_cnt = gd_4fd_array.getLength() TO 1 STEP -1
         #讀取 相關4fd 並分析
         LET ls_temp = gd_4fd_array[li_cnt]
         LET li_pos = ls_temp.getIndexOf("/4fd/",2)
         LET g_target = ls_temp.subString(li_pos +5,ls_temp.getLength()-4)
         LET lnode_temp = s_azzp191_load_xml(gd_4fd_array[li_cnt])
         #取出4fd內的text待轉換字串
         CALL azzp191_analyze(lnode_temp,gd_4fd_array[li_cnt])
      END FOR 
      
      #part 3
      IF g_bgjob <> "Y" THEN
        #CALL cl_progress_no_window_ing("組合"||lc_gzzz001||"檔案")       #160330-00012#1 mark
         LET ls_info = cl_getmsg_parm("azz-01006",g_lang,lc_gzzz001)     #160330-00012#1 add
         CALL cl_progress_no_window_ing(ls_info)                         #160330-00012#1 add
      END IF
      #組回 str 檔案  $MODULE/str/語言別/xxxxx.str
      LET g_target = ls_target

      IF NOT cl_null(g_gzzz001) AND NOT cl_null(g_gzzz002) THEN
         LET g_target = g_gzzz001
      END IF

      CALL azzp191_compose_str()          {#ADP版次:1#}

   END FOREACH
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
      IF g_schedule.gzpa003 = 1 THEN 
         IF cl_chk_process_exists(g_parentsession,g_account) THEN
            CALL cl_ask_confirm("std-00012") RETURNING li_stus
         END IF
      END IF 
     #DISPLAY "!!!!程序已完成!!!"                        #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01007",g_lang,'')     #160330-00012#1 add
      LET g_end_time = cl_get_timestamp() 
      DISPLAY "spent time:",g_end_time - g_start_time ," start:",g_start_time," end:",g_end_time
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp191_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp191.get_buffer" >}
PRIVATE FUNCTION azzp191_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   LET g_master.gzzz001 = p_dialog.getFieldBuffer("gzzz001")
   LET g_master.gzde001 = p_dialog.getFieldBuffer("gzde001")
   LET g_master.gzdf002 = p_dialog.getFieldBuffer("gzdf002")
   LET g_master.gzzd002 = p_dialog.getFieldBuffer("gzzd002")
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp191.msgcentre_notify" >}
PRIVATE FUNCTION azzp191_msgcentre_notify()
 
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
 
{<section id="azzp191.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 加入 item 項目名稱
# Memo...........:
# Usage..........: CALL azzp191_add_item(ls_tag,ls_tmp,ls_formname)
#                  RETURNING 
# Input parameter: ls_tag STRING tag 名稱
#                : ls_tmp STRING 屬性名稱
#                : ls_formname STRING form名稱
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_add_item(ls_tag,ls_tmp,ls_formname)
   DEFINE ls_tag   STRING
   DEFINE ls_tmp   STRING
   DEFINE ls_formname STRING
   DEFINE ls_form   STRING
   DEFINE li_parameter LIKE type_t.num5

   #濾除無值的內容
   IF ls_tmp.getLength() < 1 THEN
      RETURN
   END IF

   #判斷是否來自於參數
   LET ls_form = os.Path.rootname(os.Path.basename(ls_formname))
   IF ls_form.subString(4,4) = "s" AND ls_form.subString(1,3) <> 'cl_' AND
      ls_form.subString(1,2) <> "s_" THEN  #AND ls_form.subString(1,2) <> "q_" THEN
      LET li_parameter = TRUE
   ELSE 
      LET li_parameter = FALSE
   END IF

   #濾除不在規則內的內容
   CASE
      #lbl_  or _desc
      WHEN ls_tmp.subString(1,4) = "lbl_" OR ls_tmp.subString(1,3) = "cl_" OR
           ls_tmp.subString(ls_tmp.getLength()-4 ,ls_tmp.getLength()) = "_desc"
         #參數特別處理
         IF li_parameter THEN
            IF azzp191_get_param(ls_tmp,ls_form) THEN
               EXIT CASE
            END IF
         END IF
         #一般處理
         IF NOT azzp191_get_gzzd(ls_tmp) THEN
            IF ls_tmp.subString(1,4) = "lbl_" THEN
               IF NOT azzp191_get_dzebl(ls_tmp.subString(5,ls_tmp.getLength())) THEN
               END IF
            ELSE
               IF NOT azzp191_get_dzebl(ls_tmp.subString(ls_tmp.getLength()-4,ls_tmp.getLength())) THEN
               END IF
            END IF
         END IF

      WHEN ls_tmp.subString(1,4) = "lyr_" 
         IF azzp191_get_param(ls_tmp,ls_form) THEN
         END IF

      WHEN ls_tag = "Item" # ls_tmp.subString(1,4) = "cbo_" OR ls_tmp.subString(1,4) = "rdo_" 
         IF NOT azzp191_get_gzzd(ls_tmp) THEN

         END IF

      #Button/Group/Page無規則
      WHEN ls_tag = "Button" OR ls_tag = "Group" OR ls_tag = "Page"
         #參數特別處理
         IF li_parameter THEN
            IF azzp191_get_param(ls_tmp,ls_form) THEN
               EXIT CASE
            END IF
         END IF
         #一般處理
         IF NOT azzp191_get_gzzd(ls_tmp) THEN
         END IF
 
      OTHERWISE 
         #一般處理
         IF NOT azzp191_get_gzzd(ls_tmp) THEN
         END IF
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 分析xml node
# Memo...........:
# Usage..........: CALL azzp191_analyze(lnode_tmp,ls_formname)
#                   
# Input parameter: lnode_tmp  om.DomNode 
#                : ls_formname STRING   
# Return code....: 
#                :
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_analyze(lnode_tmp,ls_formname)
   DEFINE lnode_tmp     om.DomNode
   DEFINE li_cnt        LIKE type_t.num10
   DEFINE ls_attribute  STRING
   DEFINE ls_tagname    STRING
   DEFINE ls_formname   STRING

   LET ls_tagname = lnode_tmp.getTagName()
   CASE ls_tagname
      #一般Label
      WHEN "Button"      LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Group"       LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Page"        LET ls_attribute = lnode_tmp.getAttribute("text")
      WHEN "Label"       LET ls_attribute = lnode_tmp.getAttribute("text")
      #以下是在TABLE內才成立
      WHEN "ButtonEdit"  LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "CheckBox"    #先檢查text (一般狀況),在驗 title
         LET ls_attribute = lnode_tmp.getAttribute("text")
         CALL azzp191_add_item(ls_tagname,ls_attribute.trim(),ls_formname)
         LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "ComboBox"    

         LET ls_attribute = lnode_tmp.getAttribute("comment")
         IF ls_attribute  IS NOT NULL  THEN 
            CALL azzp191_add_item(ls_tagname,ls_attribute.trim(),ls_formname)
         END IF 
         LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "RadioGroup"  LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "DateEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "Edit"
         LET ls_attribute = lnode_tmp.getAttribute("aggregateText")
         IF ls_attribute IS NOT NULL THEN
            CALL azzp191_add_item(ls_tagname,ls_attribute.trim(),ls_formname)
         END IF
         LET ls_attribute = lnode_tmp.getAttribute("comment")
         IF ls_attribute  IS NOT NULL  THEN 
            CALL azzp191_add_item(ls_tagname,ls_attribute.trim(),ls_formname)
         END IF 
         
         LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "TextEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "SpinEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "TimeEdit"    LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "Slider"      LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "FFLabel"     LET ls_attribute = lnode_tmp.getAttribute("title")
      WHEN "FFImage"     LET ls_attribute = lnode_tmp.getAttribute("title")
      #以下是ComboBox/RadioGroup使用
      WHEN "Item"        LET ls_attribute = lnode_tmp.getAttribute("text")
   END CASE
   CALL azzp191_add_item(ls_tagname,ls_attribute.trim(),ls_formname)
   
   LET lnode_tmp = lnode_tmp.getFirstChild()

   WHILE lnode_tmp IS NOT NULL
      CALL azzp191_analyze(lnode_tmp,ls_formname)
      LET lnode_tmp = lnode_tmp.getNext()
   END WHILE

END FUNCTION
################################################################################
# Descriptions...: 取得table array
# Memo...........:
# Usage..........: azzp191_analyze_fglrun_info()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: BOOLEAN   主表相關table array
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_analyze_fglrun_info()
   
   DEFINE li_cnt      LIKE type_t.num5 
   DEFINE li_index    LIKE type_t.num5 
   DEFINE ls_text     STRING 
   DEFINE ls_tmp      STRING
   DEFINE lnode_temp  om.DomNode
   DEFINE ld_array    DYNAMIC ARRAY OF STRING 
   
   FOR li_cnt = 1 TO gd_4gl_arr.getLength()
      LET li_index = gd_4gl_arr[li_cnt].getIndexOf(FGL_GETENV("TOP"),1)  #2013-01-31 11:24:13 2.41.02-2081.37 /u1/t10dit/com/lib/42m/lib_cl_show_array.4gl 22   
      LET ls_text = gd_4gl_arr[li_cnt].subString(li_index,gd_4gl_arr[li_cnt].getLength())
      #找到4gl index   
      LET li_index = ls_text.getIndexOf("4gl",1)    #/u1/t10dev/erp/azz/42m/azz_azzi900_a.4gl 
      IF NOT li_index THEN 
         CONTINUE FOR 
      END IF
      LET ls_text = ls_text.subString(1,li_index-1) #/u1/t10dev/erp/azz/42m/azz_azzi900_a. 
      LET ls_tmp = os.Path.basename(ls_text)        #azz_azzi900_a.
      LET li_index = ls_text.getIndexOf("42m",1)
      LET ls_text = ls_text.subString(1,li_index-1) #/u1/t10dev/erp/azz/
      LET li_index = ls_tmp.getIndexOf("_",1)
      LET ls_tmp = ls_tmp.subString(li_index+1,ls_tmp.getLength()) #azzi900_a.4gl

      #azzi000全包
      #No.160420-00002#1
      IF g_target = "azzi000" OR g_target = "azzp000" OR g_target = "azzt000" OR
         g_target.subString(1,2) = "q_" OR g_target.subString(1,3) = "cq_" THEN
      ELSE
         #濾除q_/cq_/cl_/ccl_ 項目
         IF ls_tmp.subString(1,2) = "q_" OR ls_tmp.subString(1,3) = "cq_" OR
            ls_tmp.subString(1,3) = "cl_" OR ls_tmp.subString(1,4) = "ccl_" THEN
            CONTINUE FOR
         END IF
      END IF

      LET ls_text = ls_text,"4gl",os.Path.separator(),ls_tmp,"4gl"
      IF g_t100debug = "9" THEN
         DISPLAY "analyze_fglrun_info 4gl:",ls_text
      END IF 
      CALL s_azzp191_open_list(ls_text)
   END FOR 
END FUNCTION
################################################################################
# Descriptions...: 取dzebl
# Memo...........:
# Usage..........: CALL azzp191_get_dzebl(ls_temp)
#                  RETURNING TRUE/FALSE
# Input parameter: ls_temp STRING
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_dzebl(ls_temp)
   DEFINE ls_temp     STRING
   DEFINE li_pos      LIKE type_t.num10
   DEFINE l_dzebl     RECORD 
            dzebl001  LIKE dzebl_t.dzebl001,
            dzebl003  LIKE dzebl_t.dzebl003
                  END RECORD
   DEFINE l_gzzf003   LIKE gzzf_t.gzzf003   #130813 by wuxj add
   DEFINE l_gzzf005   LIKE gzzf_t.gzzf005   #130813 by wuxj add

   LET l_dzebl.dzebl001 = ls_temp.trim()

   SELECT dzebl003 INTO l_dzebl.dzebl003 FROM dzebl_t
    WHERE dzebl001 = l_dzebl.dzebl001 AND dzebl002 = gt_lang

   IF NOT cl_null(l_dzebl.dzebl003) THEN
      IF NOT cl_null(g_gzzz001) THEN
         LET l_gzzf003 = "lbl_",l_dzebl.dzebl001
         SELECT gzzf005 INTO l_gzzf005 FROM gzzf_t
          WHERE gzzf001 = g_gzzz001
            AND gzzf002 = gt_lang
            AND gzzfstus = 'Y'
            AND gzzf003 = l_gzzf003
         IF NOT cl_null(l_gzzf005) THEN
            LET l_dzebl.dzebl003 = l_gzzf005
         END IF
      END IF
      LET li_pos = g_record.getLength() + 1
      LET g_record[li_pos].item = "lbl_",l_dzebl.dzebl001
      LET g_record[li_pos].value = l_dzebl.dzebl003
      
      #160706-00005 #1 start 表示由rebuild串進來 
      IF g_argv[3] = "tiptop" THEN 
         CALL azzp191_get_dzebl_all(ls_temp) 
      END IF
      #160706-00005 #1 end
      
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION
################################################################################
# Descriptions...: 取gztx
# Memo...........:
# Usage..........: CALL azzp191_get_gztx(ls_temp)
#                  RETURNING TRUE/FLASE
# Input parameter: ls_temp STRING
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_gztx(ls_temp)
   DEFINE ls_temp    STRING
   DEFINE lc_gztx001 LIKE gztx_t.gztx001
   DEFINE lc_gztx002 LIKE gztx_t.gztx002
   DEFINE lc_gztx004 LIKE gztx_t.gztx004
   DEFINE li_pos     LIKE type_t.num10

   LET lc_gztx001 = ls_temp.subString(1,ls_temp.getIndexOf(".",1)-1)
   LET lc_gztx002 = ls_temp.subString(ls_temp.getIndexOf(".",1)+1,ls_temp.getLength())

   SELECT gztx004 INTO lc_gztx004 FROM gztx_t
    WHERE gztx001 = lc_gztx001 AND gztx002 = lc_gztx002 
      AND gztx003 = gt_lang
   IF STATUS THEN
      LET lc_gztx004 = ""
   END IF

   IF NOT cl_null(lc_gztx004) THEN
      LET li_pos = g_record.getLength() + 1
      LET g_record[li_pos].item = ls_temp
      LET g_record[li_pos].value = lc_gztx004
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION
################################################################################
# Descriptions...: 取gzzd
# Memo...........:
# Usage..........: CALL azzp191_get_gzzd(ls_temp)
#                  RETURNING 回传参数
# Input parameter: ls_temp STRING
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_gzzd(ls_temp)
   DEFINE ls_temp STRING
   DEFINE li_pos  LIKE type_t.num10
   DEFINE l_gzzd  RECORD 
            gzzd001  LIKE gzzd_t.gzzd001,
            gzzd002  LIKE gzzd_t.gzzd002,
            gzzd003  LIKE gzzd_t.gzzd003,
            gzzd005  LIKE gzzd_t.gzzd005 
                 END RECORD
   DEFINE l_gzzf005  LIKE gzzf_t.gzzf005  #130813 by wuxj add
   DEFINE li_chk     LIKE type_t.num5     #161129-00065 #1 add

   LET l_gzzd.gzzd001 = g_target.trim()
   LET l_gzzd.gzzd003 = ls_temp.trim()
  
  #15/04/28 加入處理客製標籤抓取規則  
  #先取自定 客製
   SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
    WHERE gzzd001 = l_gzzd.gzzd001
      AND gzzd002 = gt_lang
      AND gzzdstus = 'Y'
      AND gzzd003 = l_gzzd.gzzd003
      AND gzzd004 = 'c'

   IF cl_null(l_gzzd.gzzd005) THEN 
      #取自定 標準
      SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
       WHERE gzzd001 = l_gzzd.gzzd001
        AND gzzd002 = gt_lang
        AND gzzdstus = 'Y'
        AND gzzd003 = l_gzzd.gzzd003
        AND gzzd004 = 's'
   END IF    
  

   IF cl_null(l_gzzd.gzzd005) THEN
      # 標準standard  客製
      SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
       WHERE gzzd001 = "standard" 
         AND gzzd002 = gt_lang
         AND gzzd003 = l_gzzd.gzzd003
         AND gzzd004 = 'c'
      IF cl_null(l_gzzd.gzzd005) THEN 
         # 標準standard 標準
         SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
          WHERE gzzd001 = "standard" 
           AND gzzd002 = gt_lang
           AND gzzd003 = l_gzzd.gzzd003
           AND gzzd004 = 's'  
      END IF    
   END IF

   IF STATUS THEN
      #表示找不到代換標籤 -100 
      #RETURN FALSE       #161129-00065 #1 mark
      LET li_chk = FALSE  #161129-00065 #1 add
   ELSE
      IF NOT cl_null(g_gzzz001) THEN
         #作業級UI多語言 gzzf_t
         SELECT gzzf005 INTO l_gzzf005 FROM gzzf_t
          WHERE gzzf001 = g_gzzz001
            AND gzzf002 = gt_lang
            AND gzzfstus = 'Y'
            AND gzzf003 = l_gzzd.gzzd003
         IF NOT cl_null(l_gzzf005) THEN
            LET l_gzzd.gzzd005 = l_gzzf005
         END IF
      END IF
      LET li_pos = g_record.getLength() + 1
      LET g_record[li_pos].item = l_gzzd.gzzd003
      LET g_record[li_pos].value = l_gzzd.gzzd005
      
      #160706-00005 #1 start 表示由rebuild串進來
       #161129-00065 #1 start
      #IF g_argv[3] = "tiptop" THEN 
      #   CALL azzp191_get_gzzd_all(ls_temp) 
      #END IF
       #161129-00065 #1 end     
      #160706-00005 #1 end 
      
      #RETURN TRUE  #161129-00065 #1 mark
      LET li_chk = TRUE  #161129-00065 #1
   END IF
   IF g_argv[3] = "tiptop" THEN 
      CALL azzp191_get_gzzd_all(ls_temp) 
   END IF 
   RETURN li_chk   
END FUNCTION
################################################################################
# Descriptions...: #讀取參數設定資料
# Memo...........:
# Usage..........: CALL azzp191_get_param(ls_temp,ls_formname)
#                  RETURNING TRUE/FALSE
# Input parameter: ls_temp STRING
#                : ls_formname STRING 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_param(ls_temp,ls_formname)
   DEFINE ls_temp     STRING
   DEFINE ls_formname STRING
   DEFINE lc_gzsxl001 LIKE gzsxl_t.gzsxl001   #設定作業名稱
   DEFINE lc_gzsxl002 LIKE gzsxl_t.gzsxl002   #分頁編號
   DEFINE lc_gzsxl003 LIKE gzsxl_t.gzsxl003   #分項編號
   DEFINE lc_gzsxl005 LIKE gzsxl_t.gzsxl005   #說明
   DEFINE lc_all_gzsxl005 LIKE gzsxl_t.gzsxl005   #說明
   DEFINE li_pos      LIKE type_t.num5
   DEFINE li_row      LIKE type_t.num5
   DEFINE lc_gzsz001  LIKE gzsz_t.gzsz001
   DEFINE lc_gzsz002  LIKE gzsz_t.gzsz002
   DEFINE ls_sql      STRING
   DEFINE ls_bak      STRING
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE li_cnt2     LIKE type_t.num5
   DEFINE li_page,li_item    LIKE type_t.num5
   DEFINE li_chk      LIKE type_t.num5
   DEFINE ls_lang     STRING
   DEFINE l_token     base.StringTokenizer
   DEFINE lc_gzzd002  LIKE gzzd_t.gzzd002
   DEFINE ls_token    STRING

   LET lc_gzsxl001 = ls_formname
   LET ls_bak = ls_temp
   CASE
      #參數lbl只處理參數名稱
      WHEN ls_temp.subString(1,4) = "lbl_" 
         LET ls_temp = ls_temp.subString(5,ls_temp.getLength())
         LET li_row = s_azzp191_find_underline_pos(ls_temp) + 1
         #160518-00049 #1 start
         #判斷行業參數或標準參數
         CALL azzp191_token_param_pos(ls_temp) RETURNING li_pos,li_chk 
         #if true  表示是行業參數
         IF li_chk THEN 
            #ex:bph_ph_validity_ph_1
            LET lc_gzsxl002 = ls_temp.subString(1,li_pos-1)
            LET lc_gzsxl003 = ls_temp.subString(li_pos+1,li_row-2)  
         ELSE
         #表示是標準參數   
            LET lc_gzsxl002 = ls_temp.subString(1,ls_temp.getIndexOf("_",1)-1)
            LET lc_gzsxl003 = ls_temp.subString(ls_temp.getIndexOf("_",1)+1,li_row-2)   
         END IF
         #160518-00049 #1 end         
         #160518-00049 #1 mark
         #LET lc_gzsxl002 = ls_temp.subString(1,ls_temp.getIndexOf("_",1)-1)
         #LET lc_gzsxl003 = ls_temp.subString(ls_temp.getIndexOf("_",1)+1,li_row-2) 
         LET li_row = ls_temp.subString(li_row,ls_temp.getLength()) 
         LET ls_sql = "SELECT gzsv005,gzsv006 FROM gzsv_t ",
                      " WHERE gzsv001 = '",lc_gzsxl001 CLIPPED,"' ",   #作業名稱
                        " AND gzsv002 = '",lc_gzsxl002 CLIPPED,"' ",   #分頁編號
                        " AND gzsv003 = '",lc_gzsxl003 CLIPPED,"' ",   #分項編號
                        " AND gzsv004 = '",li_row CLIPPED,"' ",        #序號
                      " ORDER BY gzsv004 "             
         DECLARE azzp191_get_param_cs CURSOR FROM ls_sql
         LET li_cnt = 1
         FOREACH azzp191_get_param_cs INTO lc_gzsz001,lc_gzsz002
            IF li_cnt = li_row THEN
               EXIT FOREACH
            END IF
            LET li_cnt = li_cnt + 1
         END FOREACH
         SELECT gzszl004 INTO lc_gzsxl005 FROM gzszl_t
          WHERE gzszl001 = lc_gzsz001
            AND gzszl002 = lc_gzsz002
            AND gzszl003 = gt_lang
            
       #160706-00005 #1 start 表示由rebuild串進來 start
         IF g_argv[3] = "tiptop" THEN 
            LET l_token = base.StringTokenizer.create(g_str_lang, ",")
            WHILE l_token.hasMoreTokens()
               LET ls_token = l_token.nextToken()
               LET lc_gzzd002 = ls_token 
               LET lc_all_gzsxl005 = "" #161017-00003 #1

              SELECT gzszl004 INTO lc_all_gzsxl005 FROM gzszl_t
               WHERE gzszl001 = lc_gzsz001
                AND gzszl002 = lc_gzsz002
                AND gzszl003 = lc_gzzd002

                IF NOT cl_null(lc_all_gzsxl005) THEN
                   LET li_pos = g_record_tag.getLength() + 1
                   LET g_record_tag[li_pos].gt_lang = lc_gzzd002
                   LET g_record_tag[li_pos].gzzd003 = ls_bak
                   LET g_record_tag[li_pos].gzzd005 = lc_all_gzsxl005

                END IF 
                
            END WHILE              
         END IF 
         #160706-00005 #1 end 
         
      #參數lyr只處理Grid分項名稱
      WHEN ls_temp.subString(1,4) = "lyr_"
         LET ls_temp = ls_temp.subString(15,ls_temp.getLength())
         #確認s的結構是否有事先產出,沒有的話就先產
         IF g_item.getLength() = 0 THEN
            CALL azzp191_generate_s_structure(ls_formname)
         END IF

         #拆解項次,取得節點的多語言資料
         LET li_page = ls_temp.subString(1,ls_temp.getIndexOf("_",1)-1)
         LET li_item = ls_temp.subString(ls_temp.getIndexOf("_",1)+1,ls_temp.getLength())
         FOR li_cnt = 1 TO g_item.getLength()
            IF g_item[li_cnt].page_no = li_page AND g_item[li_cnt].item_no = li_item THEN
               LET lc_gzsxl005 = g_item[li_cnt].gzsxl005
               EXIT FOR
            END IF
         END FOR
         
         #160706-00005 #1 start 表示由rebuild串進來 start
         #DISPLAY "ls_temp :",ls_temp ," g_item[li_cnt].gzsxl005 :",g_item[li_cnt].gzsxl005 ," ls_bak:",ls_bak
         IF g_argv[3] = "tiptop" THEN
            LET l_token = base.StringTokenizer.create(g_str_lang, ",")
            #LET lc_gzsxl001  = ls_formname.trim()
            WHILE l_token.hasMoreTokens()
               LET ls_token = l_token.nextToken()
               LET lc_gzzd002 = ls_token 
               LET lc_all_gzsxl005 = "" #161017-00003 #1

               SELECT gzsxl005 INTO lc_all_gzsxl005 FROM gzsxl_t
                WHERE gzsxl001 = lc_gzsxl001
                 AND gzsxl002 = g_item[li_cnt].gzsx002
                 AND gzsxl003 = g_item[li_cnt].gzsx003
                 AND gzsxl004 = lc_gzzd002 

                IF NOT cl_null(lc_all_gzsxl005) THEN 
                   LET li_cnt2 = g_record_tag.getLength() + 1 
                   LET g_record_tag[li_cnt2].gt_lang = lc_gzzd002
                   LET g_record_tag[li_cnt2].gzzd003 = ls_bak
                   LET g_record_tag[li_cnt2].gzzd005 = lc_all_gzsxl005
                END IF 
            END WHILE 
         END IF
        
         #160706-00005 #1 end  

      #參數btn只處理換頁按鈕
      WHEN ls_temp.subString(1,4) = "btn_"
         LET lc_gzsxl002 = ls_temp.subString(5,ls_temp.getLength())
         SELECT gzswl004 INTO lc_gzsxl005 FROM gzswl_t
          WHERE gzswl001 = lc_gzsxl001
            AND gzswl002 = lc_gzsxl002
            AND gzswl003 = gt_lang
            
         
         #160706-00005 #1 start 表示由rebuild串進來 start   
         IF g_argv[3] = "tiptop" THEN
            LET l_token = base.StringTokenizer.create(g_str_lang, ",")
            LET lc_gzsxl001  = ls_formname.trim()
            WHILE l_token.hasMoreTokens()
               LET ls_token = l_token.nextToken()
               LET lc_gzzd002 = ls_token
               LET lc_all_gzsxl005 = "" #161017-00003 #1
               SELECT gzswl004 INTO lc_all_gzsxl005 FROM gzswl_t
                WHERE gzswl001 = lc_gzsxl001
                 AND gzswl002 = lc_gzsxl002
                 AND gzswl003 = lc_gzzd002

                IF NOT cl_null(lc_all_gzsxl005) THEN 
                   LET li_cnt = g_record_tag.getLength() + 1 
                   LET g_record_tag[li_cnt].gt_lang = lc_gzzd002
                   LET g_record_tag[li_cnt].gzzd003 = ls_bak
                   LET g_record_tag[li_cnt].gzzd005 = lc_all_gzsxl005
                END IF   
            END WHILE 
         END IF
         #160706-00005 #1 end 
      OTHERWISE
   END CASE

   IF NOT cl_null(lc_gzsxl005) THEN
      LET li_pos = g_record.getLength() + 1
      LET g_record[li_pos].item = ls_bak
      LET g_record[li_pos].value = lc_gzsxl005
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION
################################################################################
# Descriptions...: 組回 str 檔案  $MODULE/str/語言別/xxxxx.str
# Memo...........:
# Usage..........: CALL azzp191_compose_str()
################################################################################
PRIVATE FUNCTION azzp191_compose_str()
   DEFINE li_pos       LIKE type_t.num10
   DEFINE lc_gzzz005   LIKE gzzz_t.gzzz005 #歸屬模組   
   DEFINE ls_module    STRING
   DEFINE ls_path      STRING
   DEFINE ls_file      STRING
   DEFINE ls_temp      STRING
   DEFINE ls_text      STRING
   DEFINE lch_channel  base.channel
   DEFINE li_chr       LIKE type_t.num5

   LET ls_module = azzp191_check_module(g_target,cl_chk_spec_type(g_target))
   LET ls_path = os.Path.join(FGL_GETENV(ls_module),"str")
   LET ls_path = os.Path.join(ls_path,gt_lang)
   LET ls_file = os.Path.join(ls_path,g_target),".str"

   IF os.Path.exists(ls_file) THEN 
      IF os.Path.delete(ls_file) THEN END IF 
   END IF 
   LET lch_channel = base.Channel.create()
   CALL lch_channel.openFile(ls_file,"w")
   CALL lch_channel.setDelimiter("")

   #從 array撈出資料組合
   
   FOR li_pos = 1 TO g_record.getLength()
     #display "li_pos:",li_pos ," ",g_record[li_pos].item  , " ",g_record[li_pos].value
     IF g_record[li_pos].value.getIndexOf('"',1) THEN
         LET ls_temp = ""
         FOR li_chr = 1 TO g_record[li_pos].value.getLength()
            IF g_record[li_pos].value.getCharAt(li_chr) IS NOT NULL THEN
               IF g_record[li_pos].value.getCharAt(li_chr) = '"' THEN
                  LET ls_temp = ls_temp,"\\",g_record[li_pos].value.getCharAt(li_chr) CLIPPED
               ELSE
                  #LET ls_temp = ls_temp,g_record[li_pos].value.getCharAt(li_chr) CLIPPED #161024-00002 #1
                  LET ls_temp = ls_temp,g_record[li_pos].value.getCharAt(li_chr) #161024-00002 #1
               END IF
            END IF
         END FOR
         LET g_record[li_pos].value = ls_temp
      END IF
      LET ls_text = '"',g_record[li_pos].item CLIPPED,'" = "',g_record[li_pos].value,'"'
      CALL lch_channel.writeLine(ls_text)
   END FOR

   CALL lch_channel.close()
   IF os.Path.exists(ls_file) THEN

     #DISPLAY "INFO: 產生str檔成功:",ls_file              #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01008",g_lang,ls_file) #160330-00012#1 add
   ELSE
     #DISPLAY "錯誤: 產生str檔失敗:",ls_file               #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01009",g_lang,ls_file)  #160330-00012#1 add
      RETURN
   END IF
   
   IF g_t100debug = "9" THEN
      DISPLAY  "g_stronly:",g_stronly
      DISPLAY  "str file:",ls_file
   END IF 
   
   #只產生str檔
   IF g_stronly THEN 
      RETURN
   END IF 
   
   #編譯42s檔案
   LET ls_temp = "cd ",ls_path.trim(),"; fglmkstr ",g_target CLIPPED,".str 2>/dev/null"
   RUN ls_temp

   #準備搬移42s New:ls_path  Old:ls_file
   LET ls_path = os.Path.join(FGL_GETENV(ls_module),"42s")
   LET ls_path = os.Path.join(ls_path,gt_lang)
   LET ls_path = os.Path.join(ls_path,g_target),".42s"

   LET ls_file = ls_file.subString(1,ls_file.getLength()-3),"42s"
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
        #DISPLAY "錯誤: 原有42s無法移除:",ls_path             #160330-00012#1 mark
         DISPLAY cl_getmsg_parm("azz-01010",g_lang,ls_path)  #160330-00012#1 add
         RETURN
      END IF
   END IF

   IF os.Path.copy(ls_file,ls_path) THEN
      IF g_argv[3] IS NOT NULL AND g_argv[3] = "tiptop" THEN 
          DISPLAY "INFO: Succeed:1",gt_lang                       #for rebuild tool 讀取訊息
      END IF                            
      #DISPLAY "INFO: Succeed(產生42s檔成功):",ls_path     #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01011",g_lang,ls_path)  #160330-00012#1 add                          
   END IF

   IF g_t100debug = "9" THEN
      DISPLAY  "42s file:",ls_file
   END IF
   
   #建立新目錄
   IF g_gzzz001 IS NOT NULL THEN
      #重新抓取作業的歸屬模組，如果無法取得才使用原有的模組
      SELECT gzzz005 INTO lc_gzzz005 FROM gzzz_t
       WHERE gzzz001 = g_gzzz001
      IF SQLCA.SQLCODE THEN
         LET ls_path = os.Path.rootname(ls_path)
      ELSE
         #新取出的歸屬模組，可能會與作業名稱無關
         LET ls_path = os.Path.join(FGL_GETENV(lc_gzzz005),"42s")
         LET ls_path = os.Path.join(ls_path,gt_lang)
         LET ls_path = os.Path.join(ls_path,g_gzzz001)
      END IF

      IF NOT os.Path.exists(ls_path) THEN
         IF os.Path.mkdir(ls_path) THEN END IF
      END IF
   
      LET ls_path = os.Path.join(ls_path,g_gzzz002 CLIPPED),".42s"
      IF os.Path.copy(ls_file,ls_path) THEN
        #DISPLAY "INFO: 複製42s檔成功:",ls_path              #160330-00012#1 mark
         DISPLAY cl_getmsg_parm("azz-01012",g_lang,ls_path) #160330-00012#1 add
      END IF
      IF NOT os.Path.delete(ls_file) THEN
        #DISPLAY "錯誤: 新產生42s無法移除:",ls_file           #160330-00012#1 mark
         DISPLAY cl_getmsg_parm("azz-01013",g_lang,ls_file) #160330-00012#1 add
      END IF
   END IF
   #160706-00005 #1 start 表示由rebuild串進來 start 
   IF g_argv[3] = "tiptop" THEN 

      CALL azzp191_compose_str_all() 
   END IF 
   #160706-00005 #1 end
END FUNCTION
################################################################################
# Descriptions...: 建置參數類的項目結構+多語言
# Memo...........:
# Usage..........: CALL azzp191_generate_s_structure(ls_formname)
#                  RETURNING 
# Input parameter: ls_formname
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_generate_s_structure(ls_formname)
   DEFINE ls_sql       STRING
   DEFINE ls_formname  STRING
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE li_page      LIKE type_t.num5
   DEFINE li_item      LIKE type_t.num5
   DEFINE lc_gzsx002_t LIKE gzsx_t.gzsx002
   DEFINE li_total     LIKE type_t.num5
   DEFINE lc_gzsv001   LIKE gzsv_t.gzsv001

   LET ls_sql = "SELECT gzsx002,'',gzsx003,'',gzsxl005 ",
                 " FROM gzsx_t,gzsxl_t ",
                " WHERE gzsx001 = '",ls_formname.trim(),"' ",
                  " AND gzsxl001 = gzsx001 ",
                  " AND gzsxl002 = gzsx002 ",
                  " AND gzsxl003 = gzsx003 ",
                  " AND gzsxl004 = '",gt_lang CLIPPED,"' ",
                " ORDER BY gzsx004,gzsx005 "
   DECLARE azzp191_generate_s_structure_cs CURSOR FROM ls_sql

   LET li_cnt = 1
   FOREACH azzp191_generate_s_structure_cs INTO g_item[li_cnt].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      ELSE
         LET lc_gzsv001 = ls_formname
         SELECT COUNT(*) INTO li_total FROM gzsv_t
          WHERE gzsv001 = lc_gzsv001              #作業
            AND gzsv002 = g_item[li_cnt].gzsx002  #分頁
            AND gzsv003 = g_item[li_cnt].gzsx003  #分項
         IF li_total = 0 THEN
            CONTINUE FOREACH
         END IF
         LET li_cnt = li_cnt + 1
      END IF
   END FOREACH
   CALL g_item.deleteElement(li_cnt)

   LET lc_gzsx002_t = ""
   LET li_page = 0
   LET li_item = 1
   FOR li_cnt = 1 TO g_item.getLength()
      IF lc_gzsx002_t IS NULL OR lc_gzsx002_t <> g_item[li_cnt].gzsx002 THEN
         LET lc_gzsx002_t = g_item[li_cnt].gzsx002
         LET li_page = li_page + 1
         LET li_item = 1
      END IF
      LET g_item[li_cnt].page_no = li_page
      LET g_item[li_cnt].item_no = li_item
      LET li_item = li_item + 1
   END FOR
END FUNCTION
################################################################################
# Descriptions...: 找到數字位置
# Memo...........:
# Usage..........: CALL azzp191_find_num_pos(ls_temp)
#                  RETURNING li_pos
# Input parameter: ls_temp
#                : 
# Return code....: li_pos NUMBER(5)
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_find_num_pos(ls_temp)
   DEFINE ls_temp   STRING 
   DEFINE ls_target STRING 
   DEFINE li_pos    LIKE type_t.num5
   #LET ls_target = "[01-9]"
   FOR li_pos = ls_temp.getLength() TO 1 STEP -1
      #IF ls_temp.subString(li_pos, li_pos) MATCHES ls_target THEN
      IF ls_temp.subString(li_pos, li_pos) = "_" THEN
         LET li_pos = li_pos + 1
         EXIT FOR
      END IF
   END FOR
   RETURN li_pos
END FUNCTION
################################################################################
# Descriptions...: lnode_dom    om.DomNode
# Memo...........:
# Usage..........: azzp191_load_xml(ls_file)
#                  RETURNING lnode_dom
# Input parameter: ls_file
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_load_xml(ls_file)
   DEFINE ls_file      STRING
   DEFINE l_domdoc     om.DomDocument
   DEFINE lnode_dom    om.DomNode
   #DEFINE ls_sys   STRING

   #4fd  $MODULE/4fd/xxxxx.4fd
   IF os.Path.exists(ls_file) THEN
     #DISPLAY "INFO: 讀取4fd路徑:",ls_file                #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01014",g_lang,ls_file) #160330-00012#1 add
      LET l_domdoc = om.DomDocument.createFromXmlFile(ls_file)
      LET lnode_dom = l_domdoc.getDocumentElement()
   ELSE
     #DISPLAY "WARNING: 以下4fd不存在:",ls_file          #160330-00012#1 mark
     DISPLAY cl_getmsg_parm("azz-01015",g_lang,ls_file) #160330-00012#1 add
   END IF
   RETURN lnode_dom
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp191_check_module(ls_target,lc_type)
#                  RETURNING ls_module
# Input parameter: ls_target STRING 
#                : lc_type   CHAR(1) 
# Return code....: 
#                : ls_module STRING 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_check_module(ls_target,lc_type)
   DEFINE ls_target   STRING
   DEFINE ls_module   STRING
   DEFINE lc_type     LIKE type_t.chr1
   DEFINE ls_sql      STRING 
   DEFINE lc_module   LIKE type_t.chr4
   DEFINE lc_cust     LIKE type_t.chr1
   DEFINE lc_gzzz001  LIKE gzzz_t.gzzz001
   DEFINE lc_gzza001  LIKE gzza_t.gzza001
   DEFINE lc_gzdf001  LIKE gzdf_t.gzdf001

   #是當勾選客製 (C) 的時候，產生到客製模組下
   #M:主程式  B:應用元件  S:子程式  L:library F:子畫面 N:Null Q:開窗查詢子畫面
   #lc_type = "B" OR lc_type = "S" OR lc_type = "L" OR lc_type = "F"

   IF lc_type = "M" OR lc_type = "N" THEN 
      #M 主程式 及 N <-表象是NULL,實際上應該是作業ID 
      CASE 
         #作業轉成程式
         WHEN lc_type = "N"
            LET lc_gzzz001 = ls_target
            SELECT gzzz002 INTO lc_gzza001 FROM gzzz_t
             WHERE gzzz001 = lc_gzzz001
            LET ls_target = lc_gzza001
      END CASE

      LET ls_sql = "SELECT gzza003,gzza011 FROM gzza_t WHERE gzza001 = '",ls_target,"'"
      PREPARE azzp191_check_module_pre FROM ls_sql
      EXECUTE azzp191_check_module_pre INTO lc_module,lc_cust
      FREE azzp191_check_module_pre
   ELSE
     
      CASE
         WHEN lc_type = "F"
            LET ls_sql = "SELECT gzdf001,gzdf003 FROM gzdf_t WHERE gzdf002 = '",ls_target,"'"
            PREPARE azzp191_check_module_pre2 FROM ls_sql
            EXECUTE azzp191_check_module_pre2 INTO lc_gzdf001,lc_cust
            FREE azzp191_check_module_pre2
            #取得所屬哪一隻程式的子作業
            #先到主程式 
            SELECT gzza003 INTO lc_module FROM gzza_t WHERE gzza001 = lc_gzdf001 
            IF SQLCA.sqlcode THEN 
               #在到子程式
               SELECT gzde002 INTO lc_module FROM gzde_t WHERE gzde001 = lc_gzdf001
               IF SQLCA.SQLCODE THEN
                 #DISPLAY '找不到azzi900/azzi901'                #160330-00012#1 mark
                  DISPLAY cl_getmsg_parm("azz-01016",g_lang,'') #160330-00012#1 add
               END IF
            END IF

         WHEN lc_type = "Q"
            LET ls_sql = "SELECT dzca002 FROM dzca_t WHERE dzca001 = '",ls_target,"' AND dzca002='c' "
            PREPARE azzp191_check_module_pre3 FROM ls_sql
            EXECUTE azzp191_check_module_pre3 INTO lc_cust
            FREE azzp191_check_module_pre3
            IF lc_cust IS NOT NULL AND lc_cust = "c" THEN
               LET lc_module = "CQRY"
            ELSE
               LET lc_module = "QRY"
               LET lc_cust = "s"
            END IF

         OTHERWISE 
            LET ls_sql = "SELECT gzde002,gzde008 FROM gzde_t WHERE gzde001 = '",ls_target,"'"
            PREPARE azzp191_check_module_pre4 FROM ls_sql
            EXECUTE azzp191_check_module_pre4 INTO lc_module,lc_cust
            FREE azzp191_check_module_pre4
      END CASE
   END IF

   #標準
   IF lc_cust = 's' THEN 
      LET ls_module = lc_module 
   ELSE 
      #客製
      #dxx or exx or cxx 應該不用判別
      LET ls_module = lc_module 
      CASE 
         WHEN ls_module.subString(1,1) = 'A' 
            LET ls_module = 'C',ls_module.subString(2,3)
         WHEN ls_module = 'LIB' OR ls_module = 'SUB' OR ls_module = 'QRY'
            LET ls_module = 'C',ls_module.subString(1,3)            
         WHEN ls_module.subString(1,1) = 'B'
            #ex 假如 bxmt800_ph bxmt800_ph_01 判斷bxm 是否是行業模組 是:表示行業模組 否:表示在標準模組下的行業程式 
            IF s_azzi900_chk_industry(ls_module.subString(2,3)) THEN 
               LET ls_module = 'D',ls_module.subString(2,3)
            ELSE 
               LET ls_module = 'C',ls_module.subString(2,3)
            END IF 
      END CASE  
   END IF

   RETURN ls_module
END FUNCTION

################################################################################
# Descriptions...: 對行業參數做檢核
# Memo...........:
# Usage..........: CALL azzp191_token_param_pos(ps_temp)
#                  RETURNING 回传参数
# Input parameter: ps_temp STRING
# Return code....: li_find,li_chk
# Date & Author..: 2016/05/18 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_token_param_pos(ps_temp)
   DEFINE ps_temp       STRING 
   DEFINE li_find       LIKE type_t.num5
   DEFINE li_srt        LIKE type_t.num5
   DEFINE ls_str        STRING
   DEFINE ls_tmp        STRING
   DEFINE li_chk        LIKE type_t.num5  

   #Ex:bph_ph_validity_ph_1 
   LET li_find = 1 
   LET li_srt = 1
   LET ls_tmp = ps_temp
   LET li_chk = FALSE 
   #對行業參數做檢核，假如是行業參數找到index，準備切截字串 ex:bph_ph_validity_ph 會被切成 bph_ph 、validity_ph
   WHILE TRUE 
      IF ls_tmp.getIndexOf("_",li_find) THEN 
         LET li_find = ls_tmp.getIndexOf("_",li_find)
         LET ls_str = ls_tmp.subString(li_srt,li_find-1) 
      ELSE 
         EXIT WHILE 
      END IF 

      #檢查行業id
      IF cl_chk_industry(DOWNSHIFT(ls_str)) THEN 
         #不是行業id 往下一個繼續檢查
         LET li_find = li_find + 1
         LET li_srt = li_find 
         CONTINUE WHILE 
      ELSE 
         #是行業id 離開迴圈
         LET li_chk = TRUE 
         EXIT WHILE 
      END IF  
   END WHILE 
    
   RETURN li_find,li_chk
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp191_get_gzzd_all(ls_temp)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_gzzd_all(ls_temp)
   DEFINE ls_temp STRING
   DEFINE li_cnt2 LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE l_gzzd  RECORD 
            gzzd001  LIKE gzzd_t.gzzd001,
            gzzd002  LIKE gzzd_t.gzzd002,
            gzzd003  LIKE gzzd_t.gzzd003,
            gzzd005  LIKE gzzd_t.gzzd005 
                 END RECORD
   DEFINE l_gzzf005  LIKE gzzf_t.gzzf005  
   DEFINE ls_lang  STRING 
   DEFINE ls_sql   STRING 
   DEFINE l_token      base.StringTokenizer
   DEFINE ps_lang      STRING 
   DEFINE ls_token     STRING
   DEFINE lc_gzzd002   LIKE gzzd_t.gzzd002
   DEFINE li_chk       LIKE type_t.num5
    
   LET l_gzzd.gzzd001 = g_target.trim()
   LET l_gzzd.gzzd003 = ls_temp.trim()
   #進行token
   LET l_token = base.StringTokenizer.create(g_str_lang, ",")

   WHILE l_token.hasMoreTokens()
          LET ls_token = l_token.nextToken()
          LET lc_gzzd002 = ls_token 
          LET l_gzzd.gzzd005 = ""

          SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
           WHERE gzzd001 = l_gzzd.gzzd001
            AND gzzd002 = lc_gzzd002
            AND gzzdstus = 'Y'
            AND gzzd003 = l_gzzd.gzzd003
            AND gzzd004 = 'c'

         IF cl_null(l_gzzd.gzzd005) THEN 
           

           #取自定 標準
           SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t

           WHERE gzzd001 = l_gzzd.gzzd001
             AND gzzd002 = lc_gzzd002

             AND gzzdstus = 'Y'
             AND gzzd003 = l_gzzd.gzzd003
             AND gzzd004 = 's'
         END IF    
         

         IF cl_null(l_gzzd.gzzd005) THEN
            # 標準standard  客製
            SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
             WHERE gzzd001 = "standard" 
              AND gzzd002 = lc_gzzd002
              AND gzzd003 = l_gzzd.gzzd003
              AND gzzd004 = 'c'
            IF cl_null(l_gzzd.gzzd005) THEN 
               # 標準standard 標準
               SELECT gzzd005 INTO l_gzzd.gzzd005 FROM gzzd_t
                WHERE gzzd001 = "standard" 
                 AND gzzd002 = lc_gzzd002
                 AND gzzd003 = l_gzzd.gzzd003
                 AND gzzd004 = 's'  
            END IF    
         END IF

         IF STATUS THEN
            #表示找不到代換標籤 -100 
            #RETURN FALSE
            #LET li_chk = FALSE 
         ELSE
            LET li_chk = TRUE  
            IF NOT cl_null(g_gzzz001) THEN
               #作業級UI多語言 gzzf_t
               SELECT gzzf005 INTO l_gzzf005 FROM gzzf_t
                WHERE gzzf001 = g_gzzz001
                 AND gzzf002 = lc_gzzd002
                 AND gzzfstus = 'Y'
                 AND gzzf003 = l_gzzd.gzzd003
               IF NOT cl_null(l_gzzf005) THEN
                  LET l_gzzd.gzzd005 = l_gzzf005
               END IF
            END IF

            LET li_cnt2 = g_record_tag.getLength() + 1
            LET g_record_tag[li_cnt2].gt_lang = lc_gzzd002
            LET g_record_tag[li_cnt2].gzzd003 = l_gzzd.gzzd003
            LET g_record_tag[li_cnt2].gzzd005 = l_gzzd.gzzd005
            #DISPLAY "3 l_gzzd.gzzd001:",l_gzzd.gzzd001 ," lc_gzzd002:",lc_gzzd002 ," l_gzzd.gzzd003 ",l_gzzd.gzzd003 ," l_gzzd.gzzd005:",l_gzzd.gzzd005   
         #RETURN TRUE
         END IF
   END WHILE 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp191_get_dzebl_all(ls_temp)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_get_dzebl_all(ls_temp)
   DEFINE ls_temp     STRING
   DEFINE li_pos      LIKE type_t.num10
   DEFINE l_dzebl     RECORD 
            dzebl001  LIKE dzebl_t.dzebl001,
            dzebl003  LIKE dzebl_t.dzebl003
                  END RECORD
   DEFINE l_gzzf003   LIKE gzzf_t.gzzf003   
   DEFINE l_gzzf005   LIKE gzzf_t.gzzf005 
   DEFINE li_cnt      LIKE type_t.num5 
   DEFINE ls_lang     STRING 
   DEFINE ls_sql      STRING  
   DEFINE li_cnt2     LIKE type_t.num5 
   DEFINE l_token      base.StringTokenizer
   DEFINE ps_lang      STRING 
   DEFINE ls_token     STRING
   DEFINE lc_gzzd002   LIKE gzzd_t.gzzd002
   
   LET l_dzebl.dzebl001 = ls_temp.trim()

   #進行token
   LET l_token = base.StringTokenizer.create(g_str_lang, ",")
   WHILE l_token.hasMoreTokens()
      LET ls_token = l_token.nextToken()
      LET lc_gzzd002 = ls_token 
      LET l_dzebl.dzebl003 = ""  #161017-00003 #1
      LET l_gzzf005 = ""         #161017-00003 #1 

      SELECT dzebl003 INTO l_dzebl.dzebl003 FROM dzebl_t
       WHERE dzebl001 = l_dzebl.dzebl001 AND dzebl002 = lc_gzzd002

      IF NOT cl_null(l_dzebl.dzebl003) THEN

         LET l_gzzf003 = "lbl_",l_dzebl.dzebl001
         SELECT gzzf005 INTO l_gzzf005 FROM gzzf_t
          WHERE gzzf001 = g_gzzz001
            AND gzzf002 = gt_lang
            AND gzzfstus = 'Y'
            AND gzzf003 = l_gzzf003

         IF NOT cl_null(l_gzzf005) THEN
            LET l_dzebl.dzebl003 = l_gzzf005
         END IF
      END IF

      LET li_pos = g_record_tag.getLength() + 1
      LET g_record_tag[li_pos].gzzd003 = "lbl_",l_dzebl.dzebl001
      LET g_record_tag[li_pos].gt_lang = lc_gzzd002
      LET g_record_tag[li_pos].gzzd005 = l_dzebl.dzebl003
   END WHILE  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp191_compose_str_all()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp191_compose_str_all()
   DEFINE li_pos       LIKE type_t.num10
   DEFINE lc_gzzz005   LIKE gzzz_t.gzzz005 #歸屬模組   
   DEFINE ls_module    STRING
   DEFINE ls_path      STRING
   DEFINE ls_file      STRING
   DEFINE ls_temp      STRING
   DEFINE ls_text      STRING
   DEFINE lch_channel  base.channel
   DEFINE li_chr       LIKE type_t.num5
   DEFINE l_token      base.StringTokenizer
   DEFINE ls_lang      STRING  
   DEFINE ps_lang      STRING 
   DEFINE ls_token     STRING
   DEFINE ls_value     STRING
   DEFINE li_cnt       LIKE type_t.num5 

   LET ls_module = azzp191_check_module(g_target,cl_chk_spec_type(g_target))
   LET ls_path = os.Path.join(FGL_GETENV(ls_module),"str")
   #進行token
   LET l_token = base.StringTokenizer.create(g_str_lang, ",")
   LET lch_channel = base.Channel.create()
   LET li_cnt = 1
   WHILE l_token.hasMoreTokens()
      LET ls_path = ""
      LET ls_file = ""
      LET ls_token = l_token.nextToken()
      LET gt_lang = ls_token
      LET ls_path = os.Path.join(FGL_GETENV(ls_module),"str")
      LET ls_path = os.Path.join(ls_path,gt_lang)
      LET ls_file = os.Path.join(ls_path,g_target),".str"
      IF os.Path.exists(ls_file) THEN 
         IF os.Path.delete(ls_file) THEN END IF 
      END IF 
     # LET lch_channel = base.Channel.create()
      CALL lch_channel.openFile(ls_file,"w")
      CALL lch_channel.setDelimiter("")

      FOR li_pos = 1 TO g_record_tag.getLength()
         IF gt_lang = g_record_tag[li_pos].gt_lang THEN #161024-00002 #1 
          LET ls_value = g_record_tag[li_pos].gzzd005
          #DISPLAY " gzzd005 :",g_record_tag[li_pos].gzzd005 , " gzzd003:",g_record_tag[li_pos].gzzd003 ," gt_lang:",g_record_tag[li_pos].gt_lang
          IF ls_value.getIndexOf('"',1) THEN
             LET ls_temp = ""
             FOR li_chr = 1 TO ls_value.getLength()
               IF ls_value.getCharAt(li_chr) IS NOT NULL THEN
                  IF ls_value.getCharAt(li_chr) = '"' THEN
                     LET ls_temp = ls_temp,"\\",ls_value.getCharAt(li_chr) CLIPPED
                  ELSE
                     #LET ls_temp = ls_temp,ls_value.getCharAt(li_chr) CLIPPED #161024-00002 #1
                     LET ls_temp = ls_temp,ls_value.getCharAt(li_chr) #161024-00002 #1
                  END IF
               END IF
             END FOR 
             LET g_record_tag[li_pos].gzzd005 = ls_temp 
          END IF 

          #IF gt_lang = g_record_tag[li_pos].gt_lang THEN 
             LET ls_text = '"',g_record_tag[li_pos].gzzd003 CLIPPED,'" = "',g_record_tag[li_pos].gzzd005 CLIPPED,'"'
             CALL lch_channel.writeLine(ls_text)
          END IF  
      END FOR 

      #產生str檔
      IF os.Path.exists(ls_file) THEN
         DISPLAY cl_getmsg_parm("azz-01008",g_lang,ls_file) #160330-00012#1 add
      ELSE
         
          DISPLAY cl_getmsg_parm("azz-01009",g_lang,ls_file)  #160330-00012#1 add
          #RETURN
          CONTINUE WHILE
      END IF

      #編譯42s檔案
      LET ls_temp = "cd ",ls_path.trim(),"; fglmkstr ",g_target CLIPPED,".str 2>/dev/null"
      RUN ls_temp

      #準備搬移42s New:ls_path  Old:ls_file
      LET ls_path = os.Path.join(FGL_GETENV(ls_module),"42s")
      LET ls_path = os.Path.join(ls_path,gt_lang)
      LET ls_path = os.Path.join(ls_path,g_target),".42s"

      LET ls_file = ls_file.subString(1,ls_file.getLength()-3),"42s"
      IF os.Path.exists(ls_path) THEN
         IF NOT os.Path.delete(ls_path) THEN
            #DISPLAY "錯誤: 原有42s無法移除:",ls_path             #160330-00012#1 mark
            DISPLAY cl_getmsg_parm("azz-01010",g_lang,ls_path)  #160330-00012#1 add
           #RETURN
           CONTINUE WHILE
         END IF
      END IF
      LET li_cnt = li_cnt + 1
      IF os.Path.copy(ls_file,ls_path) THEN
         DISPLAY cl_getmsg_parm("azz-01011",g_lang,ls_path)  #160330-00012#1 add 
         IF g_argv[3] IS NOT NULL AND g_argv[3] = "tiptop" THEN 
           DISPLAY "INFO: Succeed:",li_cnt USING "<<<<",gt_lang                       #for rebuild tool 讀取訊息
         END IF          
      END IF
      
      #建立新目錄
      IF g_gzzz001 IS NOT NULL THEN
         #重新抓取作業的歸屬模組，如果無法取得才使用原有的模組
         SELECT gzzz005 INTO lc_gzzz005 FROM gzzz_t
          WHERE gzzz001 = g_gzzz001
         IF SQLCA.SQLCODE THEN
            LET ls_path = os.Path.rootname(ls_path)
         ELSE
            #新取出的歸屬模組，可能會與作業名稱無關
            LET ls_path = os.Path.join(FGL_GETENV(lc_gzzz005),"42s")
            LET ls_path = os.Path.join(ls_path,gt_lang)
            LET ls_path = os.Path.join(ls_path,g_gzzz001)
         END IF

         IF NOT os.Path.exists(ls_path) THEN
            IF os.Path.mkdir(ls_path) THEN END IF
         END IF
   
         LET ls_path = os.Path.join(ls_path,g_gzzz002 CLIPPED),".42s"
         IF os.Path.copy(ls_file,ls_path) THEN
            #DISPLAY "INFO: 複製42s檔成功:",ls_path              #160330-00012#1 mark
            DISPLAY cl_getmsg_parm("azz-01012",g_lang,ls_path) #160330-00012#1 add 
         END IF
         IF NOT os.Path.delete(ls_file) THEN
           #DISPLAY "錯誤: 新產生42s無法移除:",ls_file           #160330-00012#1 mark
            DISPLAY cl_getmsg_parm("azz-01013",g_lang,ls_file) #160330-00012#1 add
         END IF
      END IF
   END WHILE 
   CALL lch_channel.close()
END FUNCTION

#end add-point
 
{</section>}
 
