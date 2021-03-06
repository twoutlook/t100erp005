#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp662.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-07-14 18:37:59), PR版次:0006(2016-12-01 13:40:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: azzp662
#+ Description: 開帳應用元件生成批次作業
#+ Creator....: 04441(2016-07-14 18:37:59)
#+ Modifier...: 04441 -SD/PR- 04441
 
{</section>}
 
{<section id="azzp662.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161128-00013#8  2016/12/01  By Whitney   azzp662執行錯誤要提示訊息
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
   gzal001 LIKE gzal_t.gzal001,
   gzal002 LIKE gzal_t.gzal002,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       gzal001 LIKE type_t.chr500, 
   gzal001_desc LIKE type_t.chr80, 
   gzal002 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o type_master
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzp662.main" >}
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
   #161128-00013#8-s
   IF NOT cl_null(g_argv[01]) THEN
      LET g_bgjob = "Y"
   END IF
   #161128-00013#8-e
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL azzp662_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp662 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp662_init()
 
      #進入選單 Menu (="N")
      CALL azzp662_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp662
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp662.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp662_init()
 
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
 
{<section id="azzp662.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp662_ui_dialog()
 
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
   LET g_master.gzal002 = 'standard'
   DISPLAY BY NAME g_master.gzal002
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON gzal001,gzal002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               LET g_master.gzal001 = GET_FLDBUF(gzal001)
               LET g_master.gzal002 = GET_FLDBUF(gzal002)
               LET g_master_o.* = g_master.*
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.gzal001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzal001
            #add-point:ON ACTION controlp INFIELD gzal001 name="construct.c.gzal001"
            LET g_master.gzal001 = GET_FLDBUF(gzal001)
            LET g_master.gzal002 = GET_FLDBUF(gzal002)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gzal001
            LET g_qryparam.default2 = g_master.gzal002
            CALL q_gzal001_1()
            LET g_master.gzal001 = g_qryparam.return1
            LET g_master.gzal002 = g_qryparam.return2
            DISPLAY g_master.gzal001 TO gzal001
            DISPLAY g_master.gzal002 TO gzal002
            CALL s_desc_get_prog_desc(g_master.gzal001) RETURNING g_master.gzal001_desc
            DISPLAY BY NAME g_master.gzal001_desc
            NEXT FIELD gzal001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzal001
            #add-point:BEFORE FIELD gzal001 name="construct.b.gzal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzal001
            
            #add-point:AFTER FIELD gzal001 name="construct.a.gzal001"
            LET g_master.gzal001 = GET_FLDBUF(gzal001)
            IF NOT cl_null(g_master.gzal001) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.gzal001
               IF NOT cl_chk_exist("v_gzal001") THEN
                  LET g_master.gzal001 = g_master_o.gzal001
                  CALL s_desc_get_prog_desc(g_master.gzal001) RETURNING g_master.gzal001_desc
                  DISPLAY BY NAME g_master.gzal001,g_master.gzal001_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_prog_desc(g_master.gzal001) RETURNING g_master.gzal001_desc
               DISPLAY BY NAME g_master.gzal001_desc
               LET g_master_o.gzal001 = g_master.gzal001
            END IF
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzal002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzal002
            #add-point:ON ACTION controlp INFIELD gzal002 name="construct.c.gzal002"
            LET g_master.gzal001 = GET_FLDBUF(gzal001)
            LET g_master.gzal002 = GET_FLDBUF(gzal002)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.gzal001
            LET g_qryparam.default2 = g_master.gzal002
            CALL q_gzal001_1()
            LET g_master.gzal001 = g_qryparam.return1
            LET g_master.gzal002 = g_qryparam.return2
            DISPLAY g_master.gzal001 TO gzal001
            DISPLAY g_master.gzal002 TO gzal002
            CALL s_desc_get_prog_desc(g_master.gzal001) RETURNING g_master.gzal001_desc
            DISPLAY BY NAME g_master.gzal001_desc
            NEXT FIELD gzal002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzal002
            #add-point:BEFORE FIELD gzal002 name="construct.b.gzal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzal002
            
            #add-point:AFTER FIELD gzal002 name="construct.a.gzal002"
            LET g_master.gzal001 = GET_FLDBUF(gzal001)
            LET g_master.gzal002 = GET_FLDBUF(gzal002)
            IF NOT cl_null(g_master.gzal002) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.gzal001
               LET g_chkparam.arg2 = g_master.gzal002
               IF NOT cl_chk_exist("v_gzal002") THEN
                  LET g_master.gzal002 = g_master_o.gzal002
                  DISPLAY BY NAME g_master.gzal002
                  NEXT FIELD CURRENT
               END IF
               LET g_master_o.gzal002 = g_master.gzal002
            END IF
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
            CALL azzp662_get_buffer(l_dialog)
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
         CALL azzp662_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.gzal001 = g_master.gzal001
      LET lc_param.gzal002 = g_master.gzal002
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
                 CALL azzp662_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp662_transfer_argv(ls_js)
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
 
{<section id="azzp662.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp662_transfer_argv(ls_js)
 
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
 
{<section id="azzp662.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp662_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_path       STRING
   DEFINE ls_path_tmp1  STRING               #160908-00040#1
   DEFINE ls_path_tmp2  STRING               #160908-00040#1
   DEFINE l_channel     base.Channel
   DEFINE l_read        base.Channel
   DEFINE ls_cmd        STRING
   DEFINE ls_msg        STRING
   DEFINE l_gzan013_o   LIKE gzan_t.gzan013
   #161128-00013#8-s
   DEFINE l_gzan013_t   LIKE gzan_t.gzan013
   DEFINE l_gzan014_t   LIKE gzan_t.gzan014
   DEFINE l_gzapcount   LIKE gzan_t.gzan014
   #161128-00013#8-e
   DEFINE l_gzan  RECORD
       gzan001    LIKE gzan_t.gzan001,
       gzan002    LIKE gzan_t.gzan002,
       gzan003    LIKE gzan_t.gzan003,
       gzan004    LIKE gzan_t.gzan004,
       gzan013    LIKE gzan_t.gzan013,
       gzan014    LIKE gzan_t.gzan014
              END RECORD
   DEFINE l_n           LIKE type_t.num5
   #160620-00026#1-s
   DEFINE l_arr_n       LIKE type_t.num5
   DEFINE l_gzap008     LIKE gzap_t.gzap008
   DEFINE l_gzap009     LIKE gzap_t.gzap009
   #160620-00026#1-e

   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   LET g_showmsg = ""
   
   LET li_count = 0
   IF cl_null(lc_param.gzal001) OR cl_null(lc_param.gzal002) THEN
      SELECT COUNT(DISTINCT gzan013) INTO li_count
        FROM gzan_t
       WHERE gzan013 NOT LIKE 'v%'
         AND gzan013 IS NOT NULL
         AND gzan019 = 'Y'
   ELSE
      #檢查azzp660本次維護的作業與版本有無新增元件
      SELECT COUNT(DISTINCT gzan013) INTO li_count
        FROM gzan_t
       WHERE gzan013 NOT LIKE 'v%'
         AND gzan013 IS NOT NULL
         AND ((gzan001 = lc_param.gzal001
         AND gzan002 = lc_param.gzal002
         AND gzan019 = 'N')
          OR gzan019 = 'Y')
   END IF
   IF li_count = 0 THEN
      IF g_bgjob <> "Y" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = "aap-00313"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      ELSE
         LET g_showmsg = cl_getmsg("aap-00313",g_lang)
         LET g_showmsg = "ERROR:",g_showmsg
         DISPLAY g_showmsg
      END IF
      RETURN
   END IF

   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = 0
      IF cl_null(lc_param.gzal001) OR cl_null(lc_param.gzal002) THEN
         SELECT COUNT(1) INTO li_count
           FROM gzan_t
          WHERE gzan013 NOT LIKE 'v%'
            AND gzan013 IS NOT NULL
            AND gzan019 = 'Y'
      ELSE
         #檢查azzp660本次維護的作業與版本有無新增元件
         SELECT COUNT(1) INTO li_count
           FROM gzan_t
          WHERE gzan013 NOT LIKE 'v%'
            AND gzan013 IS NOT NULL
            AND ((gzan001 = lc_param.gzal001
            AND gzan002 = lc_param.gzal002
            AND gzan019 = 'N')
             OR gzan019 = 'Y')
      END IF
      LET li_count = li_count + 2
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp662_process_cs CURSOR FROM ls_sql
#  FOREACH azzp662_process_cs INTO
   #add-point:process段process name="process.process"
   
   IF g_bgjob <> "Y" THEN
      LET ls_msg = "PREPARE..."
      CALL cl_progress_no_window_ing(ls_msg)
   END IF
   
   #160908-00040#1-s
   #產生路徑:$AZZ/4gl
   #160822-00044-s
   #LET ls_path = os.Path.join(FGL_GETENV("AZZ"),"4gl")
   LET ls_path = os.Path.join(os.Path.join(os.Path.join(FGL_GETENV("COM"), "inc"), "erp"), "azz")
   #160822-00044-e
   #/u1/t10dev/com/azz/4gl
   LET ls_path_tmp1 = ls_path
   #準備寫入azzp660_05.4gl
   #160822-00044-s
   #LET ls_path = os.Path.join(ls_path,"azzp661_01.4gl")
   LET ls_path = os.Path.join(ls_path,"azzp661_01.inc")
   #160822-00044-e
   
   IF os.Path.chdir(ls_path_tmp1) THEN
      #160822-00044-s
      #RUN "cp $AZZ/4gl/azzp661_01.4gl $AZZ/4gl/azzp661_01.bck"
      RUN "cp $COM/inc/erp/azz/azzp661_01.inc $COM/inc/erp/azz/azzp661_01.bck"
      #160822-00044-e
   END IF
   #160908-00040#1-e
   
   IF os.Path.exists(ls_path) THEN
      IF NOT os.Path.delete(ls_path) THEN
         IF g_bgjob <> "Y" THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "-587"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         ELSE
            LET g_showmsg = cl_getmsg("-587",g_lang)
            LET g_showmsg = "ERROR:",g_showmsg
            DISPLAY g_showmsg
         END IF
         RETURN
      END IF
   END IF
   
   #寫入檔案
   LET l_channel = base.Channel.create()
   CALL l_channel.openFile(ls_path,"w")
   CALL l_channel.setDelimiter("")
   
   #160822-00044-s
   #CALL l_channel.writeLine("#+ Version..: T100-ERP-1")
   #CALL l_channel.writeLine("#+ ")
   #CALL l_channel.writeLine("#+ Filename...: azzp661_01")
   #CALL l_channel.writeLine("#+ Description: ")
   #LET ls_msg = "#+ ID.........: ",FGL_GETENV("LOGNAME")
   #CALL l_channel.writeLine(ls_msg) 
   #LET ls_msg = "#+ Time.......: ",cl_get_current()
   #CALL l_channel.writeLine(ls_msg)
   #
   #CALL l_channel.writeLine("IMPORT util") 
   ##160620-00026#1-s
   ##CALL l_channel.writeLine("PUBLIC FUNCTION azzp661_01(lc_name,ls_js)") 
   #CALL l_channel.writeLine("PUBLIC FUNCTION azzp661_01(lc_name,ls_js,p_req)")
   ##160620-00026#1-e
   #CALL l_channel.writeLine("DEFINE lc_name      STRING") 
   #CALL l_channel.writeLine("DEFINE ls_js        STRING")
   ##160620-00026#1-s
   #CALL l_channel.writeLine("DEFINE p_req        DYNAMIC ARRAY OF RECORD ")
   #CALL l_channel.writeLine("                       arr     DYNAMIC ARRAY OF VARCHAR(500) ")
   #CALL l_channel.writeLine("                    END RECORD ")
   ##160620-00026#1-e
   #CALL l_channel.writeLine("DEFINE l_arg        DYNAMIC ARRAY OF RECORD")
   #CALL l_channel.writeLine("       param        STRING")
   #CALL l_channel.writeLine("                END RECORD")
   #CALL l_channel.writeLine("DEFINE l_return     DYNAMIC ARRAY OF RECORD")
   #CALL l_channel.writeLine("       param        STRING")
   #CALL l_channel.writeLine("                END RECORD")
   #CALL l_channel.writeLine("   CALL util.JSON.parse(ls_js,l_arg)")
   #CALL l_channel.writeLine("   CASE lc_name")
   #160822-00044-e
   
   #160620-00026#1-s
   LET ls_sql = " SELECT gzap008,gzap009 ",
                "   FROM gzap_t ",
                "  WHERE gzap001 = ? ",
                "    AND gzap002 = ? ",
                "    AND gzap003 = ? ",
                "    AND gzap004 = ? ",
                "  ORDER BY gzap005 "
   PREPARE s_azzp661_gen_gzap_prep FROM ls_sql
   DECLARE s_azzp661_gen_gzap_curs CURSOR FOR s_azzp661_gen_gzap_prep
   #160620-00026#1-e
   
   LET l_gzan013_o = ''
   INITIALIZE l_gzan.* TO NULL
   IF cl_null(lc_param.gzal001) OR cl_null(lc_param.gzal002) THEN
      LET ls_sql = " SELECT DISTINCT gzan001,gzan002,gzan003,gzan004,gzan013,gzan014 ",
                   "   FROM gzan_t ",
                   "  WHERE gzan013 NOT LIKE 'v%' ",
                   "    AND gzan013 IS NOT NULL ",
                   "    AND gzan019 = 'Y' ",
                   "  ORDER BY gzan013 "
   ELSE
      LET ls_sql = " SELECT DISTINCT gzan001,gzan002,gzan003,gzan004,gzan013,gzan014 ",
                   "   FROM gzan_t ",
                   "  WHERE gzan013 NOT LIKE 'v%' ",
                   "    AND gzan013 IS NOT NULL ",
                   "    AND ((gzan001 = '",lc_param.gzal001,"' ",
                   "    AND gzan002 = '",lc_param.gzal002,"' ",
                   "    AND gzan019 = 'N') ",
                   "     OR gzan019 = 'Y') ",
                   "  ORDER BY gzan013 "
   END IF
   PREPARE s_azzp661_gen_prep FROM ls_sql
   DECLARE s_azzp661_gen_curs CURSOR FOR s_azzp661_gen_prep
   FOREACH s_azzp661_gen_curs INTO l_gzan.gzan001,l_gzan.gzan002,l_gzan.gzan003,
                                   l_gzan.gzan004,l_gzan.gzan013,l_gzan.gzan014
      
      IF g_bgjob <> "Y" THEN
         LET ls_msg = l_gzan.gzan001,l_gzan.gzan002,l_gzan.gzan003,l_gzan.gzan004
         CALL cl_progress_no_window_ing(ls_msg)
      END IF
      
      #161128-00013#8-s
      #往前挪
      LET li_count = 0
      SELECT COUNT(1) INTO li_count
        FROM gzap_t
       WHERE gzap001 = l_gzan.gzan001
         AND gzap002 = l_gzan.gzan002
         AND gzap003 = l_gzan.gzan003
         AND gzap004 = l_gzan.gzan004
      #161128-00013#8-e
      IF l_gzan013_o = l_gzan.gzan013 THEN
         #161128-00013#8-s
         IF cl_null(l_gzan013_t) OR l_gzan013_t <> l_gzan013_o THEN
            IF l_gzan014_t <> l_gzan.gzan014 OR l_gzapcount <> li_count THEN
               LET g_showmsg = "ERROR:",l_gzan.gzan013," THE function has not the correct number of values expected."
               DISPLAY g_showmsg
               LET l_gzan013_t = l_gzan.gzan013
            END IF
         END IF
         #161128-00013#8-e
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_gzan.gzan014) THEN
         LET l_gzan.gzan014 = 0
      END IF
      
      LET ls_msg = "      WHEN '",l_gzan.gzan013,"'"
      CALL l_channel.writeLine(ls_msg)
      
      IF li_count = 0 THEN
         LET ls_msg = "         CALL ",l_gzan.gzan013,"()"
      ELSE
         LET ls_msg = "         CALL ",l_gzan.gzan013,"("
         #160620-00026#1-s
         #FOR l_n = 1 TO li_count
         #   IF l_n = 1 THEN
         #      LET ls_msg = ls_msg,"l_arg[",l_n,"].param"
         #   ELSE
         #      LET ls_msg = ls_msg,",l_arg[",l_n,"].param"
         #   END IF
         #END FOR

         LET l_n = 1
         LET l_arr_n = 1 
         FOREACH s_azzp661_gen_gzap_curs USING l_gzan.gzan001,l_gzan.gzan002,l_gzan.gzan003,l_gzan.gzan004 INTO l_gzap008,l_gzap009
            IF l_n = 1 AND l_arr_n = 1 THEN
               IF l_gzap009 = 'Y' THEN
                  LET ls_msg = ls_msg,"p_req[",l_arr_n,"].arr"
                  LET l_arr_n = l_arr_n + 1
               ELSE
                  LET ls_msg = ls_msg,"l_arg[",l_n,"].param"
                  LET l_n = l_n + 1
               END IF
            ELSE
               IF l_gzap009 = 'Y' THEN
                  LET ls_msg = ls_msg,",p_req[",l_arr_n,"].arr"
                  LET l_arr_n = l_arr_n + 1
               ELSE
                  LET ls_msg = ls_msg,",l_arg[",l_n,"].param"
                  LET l_n = l_n + 1
               END IF
            END IF
         END FOREACH
         #160620-00026#1-e
         LET ls_msg = ls_msg,")"
      END IF
      CALL l_channel.writeLine(ls_msg)
      
      IF l_gzan.gzan014 <> 0 THEN
         LET ls_msg = "              RETURNING "
         FOR l_n = 1 TO l_gzan.gzan014
            IF l_n = 1 THEN
               LET ls_msg = ls_msg,"l_return[",l_n,"].param"
            ELSE
               LET ls_msg = ls_msg,",l_return[",l_n,"].param"
            END IF
         END FOR
         CALL l_channel.writeLine(ls_msg)
      END IF
      
      LET l_gzan013_o = l_gzan.gzan013
      #161128-00013#8-s
      LET l_gzan014_t = l_gzan.gzan014
      LET l_gzapcount = li_count
      #161128-00013#8-e
   END FOREACH
   
   IF g_bgjob <> "Y" THEN
      LET ls_msg = "TEST..."
      CALL cl_progress_no_window_ing(ls_msg)
   END IF
   
   #160822-00044-s
   ##結尾
   #CALL l_channel.writeLine("      OTHERWISE EXIT CASE")
   #CALL l_channel.writeLine("   END CASE")
   #CALL l_channel.writeLine("   LET ls_js = util.JSON.stringify(l_return)")
   #CALL l_channel.writeLine("   RETURN ls_js")
   #CALL l_channel.writeLine("END FUNCTION") 
   #160822-00044-e
   
   #關閉寫檔功能
   CALL l_channel.close()
   
   #160908-00040#1-s
   LET ls_path_tmp2 = os.Path.join(FGL_GETENV("AZZ"), "4gl")
   
   IF os.Path.chdir(ls_path_tmp2) THEN
   
      LET l_read = base.Channel.create()
      
      LET ls_cmd = "r.c azzp661_01"," 2>&1"
      CALL l_read.openPipe(ls_cmd, "r")
      LET ls_msg = ""
      WHILE TRUE
         LET ls_msg = l_read.readLine()
         IF l_read.isEof() THEN
            EXIT WHILE
         END IF
         IF ls_msg.getIndexOf("ERROR",1) <> 0 THEN
            LET g_showmsg = ls_msg
            EXIT WHILE
         END IF
      END WHILE
      DISPLAY g_showmsg
      CALL l_read.close()
      
      IF cl_null(g_showmsg) THEN
         LET ls_cmd = "r.l azz"," 2>&1"
         CALL l_read.openPipe(ls_cmd, "r")
         LET ls_msg = ""
         WHILE TRUE
            LET ls_msg = l_read.readLine()
            IF l_read.isEof() THEN
               EXIT WHILE
            END IF
            IF ls_msg.getIndexOf("ERROR",1) <> 0 THEN
               LET g_showmsg = ls_msg
               EXIT WHILE
            END IF
         END WHILE
         DISPLAY g_showmsg
         CALL l_read.close()
      END IF
      
      IF cl_null(g_showmsg) THEN
         LET ls_cmd = "r.l azzp661_01 ALL"," 2>&1"
         CALL l_read.openPipe(ls_cmd, "r")
         LET ls_msg = ""
         WHILE TRUE
            LET ls_msg = l_read.readLine()
            IF l_read.isEof() THEN
               EXIT WHILE
            END IF
            IF ls_msg.getIndexOf("ERROR",1) <> 0 THEN
               LET g_showmsg = ls_msg
               EXIT WHILE
            END IF
         END WHILE
         DISPLAY g_showmsg
         CALL l_read.close()
      END IF
      
      IF NOT cl_null(g_showmsg) THEN
         IF os.Path.chdir(ls_path_tmp1) THEN
            IF os.Path.delete(ls_path) THEN
               RUN "cp $COM/inc/erp/azz/azzp661_01.bck $COM/inc/erp/azz/azzp661_01.inc"
            END IF
         END IF
         IF os.Path.chdir(ls_path_tmp2) THEN
            RUN "r.c azzp661_01"
            RUN "r.l azz"
            LET ls_cmd = "r.l azzp661_01 ALL"
            #使用 WAIT模式，不可以 RUN WITHOUT WAITING
            RUN ls_cmd  WITHOUT WAITING
         END IF
      END IF
   END IF
   #160908-00040#1-e
   
   IF g_bgjob <> "Y" THEN
      LET ls_msg = "FINISH"
      CALL cl_progress_no_window_ing(ls_msg)
   END IF
   
   IF cl_null(g_showmsg) THEN
      DISPLAY "Success"
      #160615-00006#1-s
      IF (NOT cl_null(lc_param.gzal001)) AND (NOT cl_null(lc_param.gzal002)) THEN
         UPDATE gzan_t SET gzan019 = 'Y'
          WHERE gzan001 = lc_param.gzal001
            AND gzan002 = lc_param.gzal002
            AND gzan013 IS NOT NULL
            AND gzan013 NOT LIKE 'v%'
      END IF
      #160615-00006#1-e
   #161128-00013#8-s
   ELSE
      IF g_bgjob <> "Y" THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = g_showmsg
         LET g_errparam.code   = "azz-01132"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   #161128-00013#8-e
   END IF
   
   CLOSE s_azzp661_gen_curs
   FREE s_azzp661_gen_prep
   CLOSE s_azzp661_gen_gzap_curs
   FREE s_azzp661_gen_gzap_prep
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
   CALL azzp662_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp662.get_buffer" >}
PRIVATE FUNCTION azzp662_get_buffer(p_dialog)
 
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
 
{<section id="azzp662.msgcentre_notify" >}
PRIVATE FUNCTION azzp662_msgcentre_notify()
 
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
 
{<section id="azzp662.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
