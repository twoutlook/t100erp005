#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-03 13:40:52), PR版次:0002(2016-11-10 14:07:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: aisp530
#+ Description: 電子發票中獎清冊匯入作業
#+ Creator....: 05016(2016-02-23 14:27:19)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aisp530.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161104-00024#10  161108 By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#6   161110 By 08171  程式中INSERT時不可以用*的寫法，要一個一個欄位定義
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
       l_route LIKE type_t.chr100, 
   l_couction LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_file          STRING
DEFINE g_download_file  STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="aisp530.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisp530_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp530 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp530_init()
 
      #進入選單 Menu (="N")
      CALL aisp530_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp530
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp530.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp530_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_att LIKE gzzd_t.gzzd005
   DEFINE l_str LIKE gzzd_t.gzzd005
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
   SELECT gzzd005 INTO l_att FROM gzzd_t WHERE gzzd003 = 'lbl_att' AND gzzd002 = g_dlang AND gzzd001 = 'aisp530'
   SELECT gzzd005 INTO l_str FROM gzzd_t WHERE gzzd003 = 'lbl_str' AND gzzd002 = g_dlang AND gzzd001 = 'aisp530'
   LET g_master.l_couction = l_att,"\n",
                            l_str
   DISPLAY BY NAME g_master.l_couction     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp530.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp530_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_att LIKE gzzd_t.gzzd005
   DEFINE l_str LIKE gzzd_t.gzzd005
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_route 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_route
            #add-point:BEFORE FIELD l_route name="input.b.l_route"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_route
            
            #add-point:AFTER FIELD l_route name="input.a.l_route"
            IF NOT cl_null(g_master.l_route) THEN         
               CALL aisp530_route_chk(g_master.l_route) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  NEXT FIELD l_route
               END IF              
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_route
            #add-point:ON CHANGE l_route name="input.g.l_route"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_route
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_route
            #add-point:ON ACTION controlp INFIELD l_route name="input.c.l_route"
           # CALL ui.interface.frontcall("standard", "setwebcomponentpath", ["C:/",""], [g_file])
            LET g_master.l_route = cl_client_browse_file()         
            #LET g_master.l_route = g_file
            DISPLAY BY NAME g_master.l_route
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL aisp530_get_buffer(l_dialog)
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
            SELECT gzzd005 INTO l_att FROM gzzd_t WHERE gzzd003 = 'lbl_att' AND gzzd002 = g_dlang AND gzzd001 = 'aisp530'
            SELECT gzzd005 INTO l_str FROM gzzd_t WHERE gzzd003 = 'lbl_str' AND gzzd002 = g_dlang AND gzzd001 = 'aisp530'
            LET g_master.l_couction = l_att,"\n",
                                     l_str
            DISPLAY BY NAME g_master.l_couction   
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
         CALL aisp530_init()
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
                 CALL aisp530_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp530_transfer_argv(ls_js)
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
 
{<section id="aisp530.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp530_transfer_argv(ls_js)
 
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
 
{<section id="aisp530.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp530_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp530_process_cs CURSOR FROM ls_sql
#  FOREACH aisp530_process_cs INTO
   #add-point:process段process name="process.process"
   
   LET g_download_file = ''
   #將要上傳的檔案上傳至$TEMPDIR下
   CALL aisp530_upload_file(g_master.l_route) RETURNING g_sub_success,g_download_file
   #將檔案資訊寫入table中
   CALL cl_err_collect_init()
   CALL aisp530_ins_isaw(g_download_file) RETURNING g_sub_success  
   IF NOT g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00125'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()  
   END IF
   CALL cl_err_collect_show()
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
   CALL aisp530_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp530.get_buffer" >}
PRIVATE FUNCTION aisp530_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_route = p_dialog.getFieldBuffer('l_route')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp530.msgcentre_notify" >}
PRIVATE FUNCTION aisp530_msgcentre_notify()
 
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
 
{<section id="aisp530.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 上傳檔案
# Memo...........:
# Usage..........: CALL aisp530_upload_file(p_file)
# Date & Author..: 2016/02/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp530_upload_file(p_file)
DEFINE p_file            STRING
DEFINE l_download_file   STRING
DEFINE l_upload_file     STRING
DEFINE l_status          LIKE type_t.num5
DEFINE l_tempdir         STRING
DEFINE l_n               LIKE type_t.num5
DEFINE lst_token         base.StringTokenizer
DEFINE ls_token          STRING
DEFINE r_success         LIKE type_t.chr1


   LET r_success = TRUE
   LET l_tempdir = FGL_GETENV("TEMPDIR")
   LET l_n = LENGTH(l_tempdir)
   IF l_n > 0 THEN
      IF l_tempdir.subString(l_n,l_n) = '/' THEN
         LET l_tempdir = l_tempdir.subString(1,l_n-1)
      END IF
   END IF
 
   LET lst_token = base.StringTokenizer.create(p_file,'/')
 
   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
   END WHILE
 
   LET l_download_file = l_tempdir CLIPPED,'/',ls_token.trim()
   LET l_upload_file = p_file

   # 上傳檔案
   CALL cl_client_upload_file(l_upload_file,l_download_file) RETURNING l_status
 
   IF l_status THEN
      # 因財政部給的中獎清冊是以Big5編碼，而5.3版是Unicode環境，所以要先轉碼
      CALL aisp530_trans_code(l_download_file) RETURNING g_sub_success
      IF NOT g_sub_success  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'lib-00125'
         LET g_errparam.extend = 'lib-00125'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00125'
      LET g_errparam.extend = 'lib-00125'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF


   RETURN r_success,l_download_file
END FUNCTION

################################################################################
# Descriptions...: 將讀取到的檔案轉成UTF8
# Memo...........:
# Usage..........: CALL aisp530_trans_code(p_file)
# Date & Author..: 2016/02/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp530_trans_code(p_file)
DEFINE p_file       STRING
DEFINE l_temp_file  STRING
DEFINE l_cmd        STRING
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   LET l_temp_file = p_file CLIPPED,".temp"

   LET l_cmd = "iconv -f  BIG5 -t UTF-8 ",p_file CLIPPED," > ",l_temp_file CLIPPED
   RUN l_cmd
   IF STATUS > 0 THEN
      LET r_success = FALSE
   ELSE
     LET l_cmd = "mv ",l_temp_file CLIPPED," ",p_file CLIPPED
     RUN l_cmd
     
     IF STATUS > 0 THEN
        LET r_success = FALSE
     END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增isaw資料
# Memo...........:
# Usage..........: CALL aisp530_ins_isaw(p_file)
# Date & Author..: 2016/02/24 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp530_ins_isaw(p_file)
DEFINE p_file           STRING
DEFINE l_ch             base.Channel
DEFINE l_code           STRING
DEFINE l_mmaf            RECORD 
                         mmaf001     LIKE mmaf_t.mmaf001,
                         mmaf008     LIKE mmaf_t.mmaf008,
                         mmaf023     LIKE mmaf_t.mmaf023,
                         mmaf011     LIKE mmaf_t.mmaf011,
                         mmaf012     LIKE mmaf_t.mmaf012,
                         mmaf013     LIKE mmaf_t.mmaf013,
                         mmaf014     LIKE mmaf_t.mmaf014
                         END RECORD
DEFINE r_success         LIKE type_t.num5
DEFINE l_tot_row         LIKE type_t.num10
DEFINE l_tot_amt         LIKE type_t.num10
DEFINE l_file_tot_row    LIKE type_t.num10
DEFINE l_file_tot_amt    LIKE type_t.num10
DEFINE l_i               LIKE type_t.num10    #迴圈
DEFINE l_char            STRING                  #取單一字元
DEFINE l_str             STRING                  #組合字元
DEFINE l_len             STRING                  #取單一字元長度
DEFINE l_len_tot         STRING                  #字串總長度
#DEFINE l_isaw            RECORD LIKE isaw_t.*   #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE l_isaw RECORD  #電子發票中獎清冊檔
       isawent LIKE isaw_t.isawent, #企業編碼
       isaw001 LIKE isaw_t.isaw001, #總公司統一編號
       isaw002 LIKE isaw_t.isaw002, #發票所屬年度
       isaw003 LIKE isaw_t.isaw003, #發票所屬月份
       isaw004 LIKE isaw_t.isaw004, #發票編號
       isaw005 LIKE isaw_t.isaw005, #發票號碼
       isaw006 LIKE isaw_t.isaw006, #營業人名稱(賣方)
       isaw007 LIKE isaw_t.isaw007, #營業人統一編號(賣方)
       isaw008 LIKE isaw_t.isaw008, #營業人地址(賣方)
       isaw009 LIKE isaw_t.isaw009, #發票開立日期
       isaw010 LIKE isaw_t.isaw010, #發票開立時間
       isaw011 LIKE isaw_t.isaw011, #發票金額總計
       isaw012 LIKE isaw_t.isaw012, #載具類別號碼
       isaw013 LIKE isaw_t.isaw013, #載具類別名稱
       isaw014 LIKE isaw_t.isaw014, #載具顯碼ID
       isaw015 LIKE isaw_t.isaw015, #載具隱碼ID
       isaw016 LIKE isaw_t.isaw016, #發票防偽隨機碼
       isaw017 LIKE isaw_t.isaw017, #中獎獎別
       isaw018 LIKE isaw_t.isaw018, #中獎獎金
       isaw019 LIKE isaw_t.isaw019, #營利事業統一編號(買受人)
       isaw020 LIKE isaw_t.isaw020, #大平臺已匯款註記
       isaw021 LIKE isaw_t.isaw021, #資料類別
       isaw022 LIKE isaw_t.isaw022, #例外編號
       isaw023 LIKE isaw_t.isaw023, #列印格式
       isaw024 LIKE isaw_t.isaw024, #唯一識別碼
       isaw025 LIKE isaw_t.isaw025, #會員編號
       isaw026 LIKE isaw_t.isaw026, #會員名稱
       isaw027 LIKE isaw_t.isaw027, #中獎通知方式
       isaw028 LIKE isaw_t.isaw028, #通知方式內容
       isaw029 LIKE isaw_t.isaw029, #發票列印碼
       isaw030 LIKE isaw_t.isaw030, #最後一次列印人員
       isawcomp LIKE isaw_t.isawcomp, #法人
       isawsite LIKE isaw_t.isawsite, #營運據點
       isawud001 LIKE isaw_t.isawud001, #自定義欄位(文字)001
       isawud002 LIKE isaw_t.isawud002, #自定義欄位(文字)002
       isawud003 LIKE isaw_t.isawud003, #自定義欄位(文字)003
       isawud004 LIKE isaw_t.isawud004, #自定義欄位(文字)004
       isawud005 LIKE isaw_t.isawud005, #自定義欄位(文字)005
       isawud006 LIKE isaw_t.isawud006, #自定義欄位(文字)006
       isawud007 LIKE isaw_t.isawud007, #自定義欄位(文字)007
       isawud008 LIKE isaw_t.isawud008, #自定義欄位(文字)008
       isawud009 LIKE isaw_t.isawud009, #自定義欄位(文字)009
       isawud010 LIKE isaw_t.isawud010, #自定義欄位(文字)010
       isawud011 LIKE isaw_t.isawud011, #自定義欄位(數字)011
       isawud012 LIKE isaw_t.isawud012, #自定義欄位(數字)012
       isawud013 LIKE isaw_t.isawud013, #自定義欄位(數字)013
       isawud014 LIKE isaw_t.isawud014, #自定義欄位(數字)014
       isawud015 LIKE isaw_t.isawud015, #自定義欄位(數字)015
       isawud016 LIKE isaw_t.isawud016, #自定義欄位(數字)016
       isawud017 LIKE isaw_t.isawud017, #自定義欄位(數字)017
       isawud018 LIKE isaw_t.isawud018, #自定義欄位(數字)018
       isawud019 LIKE isaw_t.isawud019, #自定義欄位(數字)019
       isawud020 LIKE isaw_t.isawud020, #自定義欄位(數字)020
       isawud021 LIKE isaw_t.isawud021, #自定義欄位(日期時間)021
       isawud022 LIKE isaw_t.isawud022, #自定義欄位(日期時間)022
       isawud023 LIKE isaw_t.isawud023, #自定義欄位(日期時間)023
       isawud024 LIKE isaw_t.isawud024, #自定義欄位(日期時間)024
       isawud025 LIKE isaw_t.isawud025, #自定義欄位(日期時間)025
       isawud026 LIKE isaw_t.isawud026, #自定義欄位(日期時間)026
       isawud027 LIKE isaw_t.isawud027, #自定義欄位(日期時間)027
       isawud028 LIKE isaw_t.isawud028, #自定義欄位(日期時間)028
       isawud029 LIKE isaw_t.isawud029, #自定義欄位(日期時間)029
       isawud030 LIKE isaw_t.isawud030  #自定義欄位(日期時間)030
END RECORD
#161104-00024#10 --e add
DEFINE l_ooef001         LIKE ooef_t.ooef001
DEFINE l_gzcb003         LIKE gzcb_t.gzcb003
DEFINE l_count           LIKE type_t.num5

   LET r_success = TRUE
   LET l_tot_row = 0
   LET l_tot_amt = 0
   LET l_file_tot_row = 0
   LET l_file_tot_amt = 0

   # 讀取上傳的檔案內容
   LET l_ch = base.Channel.create()
   CALL l_ch.openFile(p_file CLIPPED, "r") 

   CALL s_transaction_begin()
   WHILE l_ch.read(l_code)
      # 讀到檔案最後一筆時，需解析檔案內容，並比對資料是否正確
      # 需比對總筆數及總金額是否正確
      # PS.最後一筆資料為 F 開頭的文字
      IF l_code.subString(1,1) <> 'F' THEN               #--------     FOR迴圈程式邏輯說明 START  ------------------------------------------------------  #
         INITIALIZE l_isaw.* TO NULL                     # 目的：設有一字串 --> 鼎A新 <-- 其財政部格式字串長度為5，oracle為7                                 #
         LET l_char = ''                                 #       為符合財政部格式，故以此FOR迴圈計算長度，以便讀取時能取到正確字串                            #
         LET l_str = ''                                  # 規則：oracle的單一中文字串長度是3，財政部格式的中文字串長度是2                                    #
         LET l_len_tot = 0                               #       故讀到3時字串總長則加2且迴圈圈數也加2                                                     #
         FOR l_i = 1 TO l_code.getLength()               # 說明：設有一字串 ------------->  鼎A新                                                         #
            LET l_char = l_code.getCharAt(l_i)           #       其getCharAt()的index 為    1234567                                                      #
            LET l_len = l_char.getLength()               #       當讀到'鼎'字，index為1，且2、3皆為半形空白，如'鼎  ' ，長度為5                              #
            IF l_len = 3 THEN                            #       當讀到'A'字，index為4，長度為1                                                           #
               LET l_len_tot = l_len_tot + 2             #       當讀到'新'字，index為5，且6、7皆為半形空白，如'新  ' ，長度為5                             #
               LET l_i = l_i + 2                         #       讀完字串後總長度為5+1+5=11，與財政部格式不符                                              #
            ELSE                                         # 解法：迴圈第一圈，LET l_char = ls_code.getCharAt(l_i)，此時的l_char為'鼎'                      #
               LET l_len_tot = l_len_tot + 1             #       LET l_len = l_char.getLength()，l_len為l_char長度，此時為3                              #
            END IF                                       #       當l_len為3時，總長度l_len_tot則累加2，且迴圈圈數加2，以避開緊接在中文字後的兩個半形空格      #
            LET l_str = l_str,l_char                     #       使下一圈的迴圈(第四圈)能準確的抓到'A'(長度1)，接著第五圈抓'新'(以此規則計長度為2)            #
            CASE l_len_tot                               #       如此字串長度即為2+1+2=5，符合財政部格式                                                   #     
               WHEN 10   # 總公司統一編號                 #--------     FOR 迴圈程式邏輯說明 END   ------------------------------------------------------- #
                  LET l_isaw.isaw001 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 13   # 發票所屬年度
                  LET l_isaw.isaw002 = l_str.trim() + 1911
                  LET l_char = '' 
                  LET l_str = ''
               WHEN 15   # 發票所屬月份
                  LET l_isaw.isaw003 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 25   # 發票號碼
                  LET l_isaw.isaw005 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 85   # 營業人名稱(賣方)
                  LET l_isaw.isaw006 = l_str
                  LET l_char = ''
                  LET l_str = ''
               WHEN 95   # 營業人統一編號(賣方)
                  LET l_isaw.isaw007 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 195   # 營業人住址(賣方)
                  LET l_isaw.isaw008 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 205   # 發票開立日期
                  LET l_isaw.isaw009 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 213   # 發票開立時間
                  LET l_isaw.isaw010 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 225   # 發票金額總計
                  LET l_isaw.isaw011 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 231   # 載具類別號碼
                  LET l_isaw.isaw012 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 291   # 載具類別名稱
                  LET l_isaw.isaw013 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 355   # 載具顯碼ID
                  LET l_isaw.isaw014 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 419   # 載具隱碼ID
                  LET l_isaw.isaw015 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 423   # 發票隨機碼D
                  LET l_isaw.isaw016 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 424   # 中獎獎別
                  LET l_isaw.isaw017 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 434   # 中獎獎金
                  LET l_isaw.isaw018 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 444   # 營利事業統一編號(買受人)
                  LET l_isaw.isaw019 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 445   # 大平台已匯款註記
                  LET l_isaw.isaw020 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 446   # 資料類別
                  LET l_isaw.isaw021 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 448   # 例外代碼
                  LET l_isaw.isaw022 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 450   # 列印格式
                  LET l_isaw.isaw023 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
               WHEN 474   # 唯一識別碼
                  LET l_isaw.isaw024 = l_str.trim()
                  LET l_char = ''
                  LET l_str = ''
            END CASE
         END FOR
         # 檢核獎別與獎金是否相符
         SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
          WHERE gzcb001 = '9756' AND gzcb002 = l_isaw.isaw017
         IF l_isaw.isaw018 <> l_gzcb003 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00325'
            LET g_errparam.extend = l_isaw.isaw005
            LET g_errparam.popup = TRUE
            CALL cl_err()                
            LET r_success = FALSE
            EXIT WHILE
         END IF       
         IF cl_null(l_gzcb003) THEN LET r_success = FALSE EXIT WHILE END IF         
         # 若非會員廠商的資料，不匯入系統
         IF l_isaw.isaw021 <> 'A' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00321'
            LET g_errparam.extend = l_isaw.isaw001
            LET g_errparam.popup = TRUE
            CALL cl_err()                
            LET r_success =FALSE       
            EXIT WHILE
         END IF  

         INITIALIZE l_mmaf.* TO NULL  
         SELECT mmaf001,mmaf008,mmaf023,mmaf011,mmaf012,mmaf013,mmaf014 
           INTO l_mmaf.* FROM mmaf_t
          WHERE mmafent = g_enterprise
            AND mmaf001 = l_isaw.isaw012
         IF cl_null(l_mmaf.mmaf001) THEN LET r_success = FALSE EXIT WHILE END IF
         IF cl_null(l_mmaf.mmaf008) THEN LET r_success = FALSE EXIT WHILE END IF
         IF cl_null(l_mmaf.mmaf023) THEN LET r_success = FALSE EXIT WHILE END IF
         LET l_isaw.isaw025 = l_mmaf.mmaf001                       # 會員代碼
         LET l_isaw.isaw026 = l_mmaf.mmaf008                       # 會員名稱
         LET l_isaw.isaw027 = l_mmaf.mmaf023                       # 中獎通知方式
       
         IF cl_null(l_isaw.isaw027) THEN     #若此會員未設定中獎通知方式，則預設為 0：不通知
            LET l_isaw.isaw027 = '0'
         END IF 

         CASE l_isaw.isaw027 
            WHEN "0"    # 不通知
               LET l_isaw.isaw028 = ''
            WHEN "1"    # 郵寄
               LET l_isaw.isaw028 = l_mmaf.mmaf011                 # 通知方式內容 (地址)
               IF cl_null(l_mmaf.mmaf011) THEN LET r_success = FALSE EXIT WHILE END IF
            WHEN "2"    # 電話通知
               LET l_isaw.isaw028 = l_mmaf.mmaf013                 # 通知方式內容 (電話)
               IF cl_null(l_mmaf.mmaf013) THEN LET r_success = FALSE EXIT WHILE END IF
            WHEN "3"    # 手機通知
               LET l_isaw.isaw028 = l_mmaf.mmaf014                 # 通知方式內容 (手機)
               IF cl_null(l_mmaf.mmaf014) THEN LET r_success = FALSE EXIT WHILE END IF
            WHEN "4"    # 簡訊通知
               LET l_isaw.isaw028 = l_mmaf.mmaf014                 # 通知方式內容 (手機)
               IF cl_null(l_mmaf.mmaf014) THEN LET r_success = FALSE EXIT WHILE END IF
            WHEN "5"    # E-mail通知
               LET l_isaw.isaw028 = l_mmaf.mmaf012                 # 通知方式內容 (E-mail)
               IF cl_null(l_mmaf.mmaf012) THEN LET r_success = FALSE EXIT WHILE END IF
         END CASE
         LET l_isaw.isaw029 = 'N'                                  # 發票列印碼
         LET l_isaw.isaw030  = ''                                  # 最後一次列印人員
         SELECT DISTINCT ooef001 INTO l_ooef001 
           FROM ooef_t WHERE ooefent = g_enterprise AND ooef002 = l_isaw.isaw001 AND ooef003 = 'Y'
         IF cl_null(l_ooef001) THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00322'
            LET g_errparam.extend = l_isaw.isaw001
            LET g_errparam.popup = TRUE
            CALL cl_err()                  
            LET r_success = FALSE 
            EXIT WHILE       
         END IF
         LET l_isaw.isawcomp = l_ooef001   
         LET l_isaw.isawsite = l_ooef001
         LET l_isaw.isawent = g_enterprise     
         LET l_isaw.isaw004 = ' '
        #內當期資料已存在, 且 isaw029(發票列印碼) 有任一筆為 'Y,表示已列印過中奬發票給會員.
        #則提示訊息: 當期已有列印中奬發票, 不可重匯.
         IF l_tot_row = 0 THEN #只執行一次
            LET l_count = 0
            SELECT COUNT(*) INTO l_count FROM isaw_t         
             WHERE isawent = g_enterprise
               AND isaw002 = l_isaw.isaw002
               AND isaw003 = l_isaw.isaw003
               AND isaw029 ='Y'
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count > 0  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00290'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE 
               EXIT WHILE       
            END IF
            LET l_count = 0
            SELECT COUNT(*) INTO l_count FROM isaw_t         
             WHERE isawent = g_enterprise
               AND isaw002 = l_isaw.isaw002
               AND isaw003 = l_isaw.isaw003
               IF cl_null(l_count) THEN LET l_count = 0 END IF 
            IF l_count > 0  THEN
               IF NOT cl_ask_confirm("ais-00291") THEN #當期資料已存在，是否從新匯入?                 
                  EXIT WHILE
               ELSE               
                  DELETE FROM  isaw_t    
                   WHERE isawent = g_enterprise
                     AND isaw002 = l_isaw.isaw002
                     AND isaw003 = l_isaw.isaw003
               END IF 
            END IF                              
         END IF
        #INSERT INTO isaw_t VALUES (l_isaw.*) #161108-00017#6 mark
         #161108-00017#6 --s add
         INSERT INTO isaw_t(isawent,isaw001,isaw002,isaw003,isaw004,
                            isaw005,isaw006,isaw007,isaw008,isaw009,
                            isaw010,isaw011,isaw012,isaw013,isaw014,
                            isaw015,isaw016,isaw017,isaw018,isaw019,
                            isaw020,isaw021,isaw022,isaw023,isaw024,
                            isaw025,isaw026,isaw027,isaw028,isaw029,
                            isaw030,isawcomp,isawsite,isawud001,isawud002,
                            isawud003,isawud004,isawud005,isawud006,isawud007,
                            isawud008,isawud009,isawud010,isawud011,isawud012,
                            isawud013,isawud014,isawud015,isawud016,isawud017,
                            isawud018,isawud019,isawud020,isawud021,isawud022,
                            isawud023,isawud024,isawud025,isawud026,isawud027,
                            isawud028,isawud029,isawud030)
         VALUES (l_isaw.isawent,l_isaw.isaw001,l_isaw.isaw002,l_isaw.isaw003,l_isaw.isaw004,
                 l_isaw.isaw005,l_isaw.isaw006,l_isaw.isaw007,l_isaw.isaw008,l_isaw.isaw009,
                 l_isaw.isaw010,l_isaw.isaw011,l_isaw.isaw012,l_isaw.isaw013,l_isaw.isaw014,
                 l_isaw.isaw015,l_isaw.isaw016,l_isaw.isaw017,l_isaw.isaw018,l_isaw.isaw019,
                 l_isaw.isaw020,l_isaw.isaw021,l_isaw.isaw022,l_isaw.isaw023,l_isaw.isaw024,
                 l_isaw.isaw025,l_isaw.isaw026,l_isaw.isaw027,l_isaw.isaw028,l_isaw.isaw029,
                 l_isaw.isaw030,l_isaw.isawcomp,l_isaw.isawsite,l_isaw.isawud001,l_isaw.isawud002,
                 l_isaw.isawud003,l_isaw.isawud004,l_isaw.isawud005,l_isaw.isawud006,l_isaw.isawud007,
                 l_isaw.isawud008,l_isaw.isawud009,l_isaw.isawud010,l_isaw.isawud011,l_isaw.isawud012,
                 l_isaw.isawud013,l_isaw.isawud014,l_isaw.isawud015,l_isaw.isawud016,l_isaw.isawud017,
                 l_isaw.isawud018,l_isaw.isawud019,l_isaw.isawud020,l_isaw.isawud021,l_isaw.isawud022,
                 l_isaw.isawud023,l_isaw.isawud024,l_isaw.isawud025,l_isaw.isawud026,l_isaw.isawud027,
                 l_isaw.isawud028,l_isaw.isawud029,l_isaw.isawud030)
         #161108-00017#6 --e add
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT WHILE
         END IF

         LET l_tot_row = l_tot_row + 1
         LET l_tot_amt = l_tot_amt +  l_isaw.isaw018
      ELSE
         # 檢核總筆數是否正確
         LET l_file_tot_row = l_code.subString(7,13)
         IF l_file_tot_row <> l_tot_row THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00323'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()                                    
            LET r_success = FALSE
            EXIT WHILE
         END IF

         # 檢核總領獎金額是否正確
         LET l_file_tot_amt = l_code.subString(14,28)
         IF l_file_tot_amt <> l_tot_amt THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00324'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()                  
            LET r_success = FALSE
            EXIT WHILE
         END IF
      END IF
   END WHILE

   IF r_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL l_ch.close()
 
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 檢核路徑檔案名稱是否正確
# Memo...........:
# Usage..........: CALL aisp530_route_chk(p_file)
# Date & Author..: 2016/02/24 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp530_route_chk(p_file)
DEFINE p_file          STRING
DEFINE l_buf           base.StringBuffer
DEFINE l_p1            LIKE type_t.num5
DEFINE l_p2            LIKE type_t.num5
DEFINE l_p3            LIKE type_t.num5
DEFINE lst_token       base.StringTokenizer
DEFINE ls_token        STRING
DEFINE l_mark          LIKE type_t.chr1
DEFINE r_error         LIKE gzze_t.gzze001
DEFINE r_success       LIKE type_t.num5

   # 上傳檔案格式為  A_總公司統編_發票年月(YYYMM)_產生日期時間(YYYYMMDDhhmmss)

   LET r_error = NULL LET r_success = TRUE
   LET lst_token = base.StringTokenizer.create(p_file,'/')

   WHILE lst_token.hasMoreTokens()
      LET ls_token = lst_token.nextToken()
   END WHILE

   LET l_buf = base.StringBuffer.create()
   LET p_file = ls_token
   CALL l_buf.append(p_file)

   #check delimeter
   LET l_p1 = l_buf.getIndexOf("_", 1)
   IF l_p1 < 1 THEN
      LET r_error = 'azz-00678'
      LET r_success = FALSE
      RETURN r_success,r_error
   END IF
   LET l_mark = p_file.subString(1,l_p1-1)
   IF cl_null(l_mark) THEN
      LET r_error = 'azz-00678'
      LET r_success = FALSE
      RETURN r_success,r_error
   END IF

   # 會員中獎清冊檔案為A開頭
   IF l_mark <> 'A' THEN
      LET r_error = 'azz-00678'
      LET r_success = FALSE
      RETURN r_success,r_error
   END IF


   RETURN r_success,r_error
END FUNCTION

#end add-point
 
{</section>}
 
