#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp202.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2014-08-22 15:53:26), PR版次:0016(2017-03-07 18:28:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000119
#+ Filename...: axcp202
#+ Description: 期末投入工時統計和分攤作業
#+ Creator....: 02114(2014-05-20 09:41:52)
#+ Modifier...: 02114 -SD/PR- 05423
 
{</section>}
 
{<section id="axcp202.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
# 160425 zhangllc 修正错误
#160318-00025#52  2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160913-00039#1   2016/09/14 By Ann_Huang  修改axm-00089提示更換成axc-00787, 且先檢查是否存在已確認在製報工和統計資料(axct200)
#161012-00015#1   2016/10/12 By Ann_Huang  刪除#160913-00039#1先檢查是否存在已確認在製報工和統計資料SQL檢核,保留原本控卡。
#161019-00033#1   2016/10/20 By 02295      应检查计算的年度+期别在成本关账日期之后（S-FIN-6012）
#161117-00031#1   2016/11/18 By 02295     将判断条件小于等于改成等于
#161121-00018#8   2016/12/15 By lixiang   若走工艺成本时，產生每月製程成本工時費用分攤統計檔axcq203
#161124-00048#21  2016/12/13 By xujing    整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170221-00036#1   2016/02/21 By xujing    抓去xcbr002,xcbr003,xcbr004 如果是空则给空格.
#170217-00025#7   2017/03/07 By zhujing   整批调整未产生数据时，提示消息修正。
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
        xcbk001          LIKE xcbk_t.xcbk001,
        xcbk001_desc     LIKE type_t.chr80,
        xcbk002          LIKE xcbk_t.xcbk002,
        xcbk003          LIKE xcbk_t.xcbk003,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_wc_xcbkcomp    STRING
DEFINE g_wc_xcbkld      STRING
#單頭 type 宣告
#dorislai-20151026-add----(S)
 TYPE type_g_wc RECORD
   xcbkcomp LIKE xcbk_t.xcbkcomp,
   xcbkld   LIKE xcbk_t.xcbkld
END RECORD
DEFINE g_wc1 type_g_wc
#dorislai-20151026-add----(E)

#161121-00018#8---s
DEFINE g_wc_xcbscomp    STRING
DEFINE g_wc_xcbsld      STRING
#161121-00018#8---e
DEFINE g_flag           LIKE type_t.num5  #170217-00025#7 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="axcp202.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_bgjob = "N" 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp202_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp202 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp202_init()
 
      #進入選單 Menu (="N")
      CALL axcp202_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp202
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp202.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp202_init()
 
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
 
{<section id="axcp202.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp202_ui_dialog()
 
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

         CONSTRUCT BY NAME lc_param.wc ON xcbkcomp,xcbkld
            BEFORE CONSTRUCT    
            
            ON ACTION controlp INFIELD xcbkcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE 
               CALL q_ooef001_2()                        #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcbkcomp    #顯示到畫面上
               NEXT FIELD xcbkcomp                       #返回原欄位
               
            ON ACTION controlp INFIELD xcbkld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE 
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept 
               CALL q_authorised_ld()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcbkld      #顯示到畫面上
               NEXT FIELD xcbkld                         #返回原欄位
         END CONSTRUCT    
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME lc_param.xcbk001,lc_param.xcbk002,lc_param.xcbk003
            
            BEFORE INPUT
               
            AFTER FIELD xcbk001
               CALL axcp202_xcbk001_desc(lc_param.xcbk001) RETURNING lc_param.xcbk001_desc
               DISPLAY lc_param.xcbk001_desc TO xcbk001_desc
               IF NOT cl_null(lc_param.xcbk001) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = lc_param.xcbk001
                  
                  LET g_errshow = TRUE   #160318-00025#52
                  LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"    #160318-00025#52   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_xcat001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET lc_param.xcbk001 = ''
                     CALL axcp202_xcbk001_desc(lc_param.xcbk001) RETURNING lc_param.xcbk001_desc
                     DISPLAY lc_param.xcbk001_desc TO xcbk001_desc
                     NEXT FIELD CURRENT
                  END IF
        
               END IF 
               
            
            ON ACTION controlp INFIELD xcbk001
               #add-point:ON ACTION controlp INFIELD xcck003
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = lc_param.xcbk001             #給予default值
               
               #給予arg
               
               
               CALL q_xcat001()                                #呼叫開窗
               
               LET lc_param.xcbk001 = g_qryparam.return1              
               CALL axcp202_xcbk001_desc(lc_param.xcbk001) RETURNING lc_param.xcbk001_desc
               DISPLAY lc_param.xcbk001_desc TO xcbk001_desc
               DISPLAY lc_param.xcbk001 TO xcbk001              #
               
               NEXT FIELD xcbk001                          #返回原欄位
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
            CALL axcp202_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            #dorislai-21051026-add----(S)
            CALL s_axc_set_site_default() RETURNING g_wc1.xcbkcomp,g_wc1.xcbkld,lc_param.xcbk002,lc_param.xcbk003,lc_param.xcbk001 
            DISPLAY BY NAME g_wc1.xcbkcomp,g_wc1.xcbkld,lc_param.xcbk002,lc_param.xcbk003,lc_param.xcbk001 
            #dorislai-21051026-add----(E)
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
         CALL axcp202_init()
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
                 CALL axcp202_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp202_transfer_argv(ls_js)
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
 
{<section id="axcp202.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp202_transfer_argv(ls_js)
 
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
 
{<section id="axcp202.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp202_process(ls_js)
 
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
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN
         CALL cl_progress_bar_no_window(3)
      ELSE
         CALL cl_progress_bar_no_window(2)
      END IF
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp202_process_cs CURSOR FROM ls_sql
#  FOREACH axcp202_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      LET g_flag = FALSE   #170217-00025#7 add
      #161121-00018#8---s
      #按工艺计算成本
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6003') = 'Y' THEN
         CALL axcp202_process_cost(ls_js)
      ELSE
      #161121-00018#8---e
         CALL axcp202_p(ls_js)
      END IF   #161121-00018#8
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      #170217-00025#7 add-S
      IF g_flag = FALSE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN  
      END IF      
      #170217-00025#7 add-E
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp202_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp202.get_buffer" >}
PRIVATE FUNCTION axcp202_get_buffer(p_dialog)
 
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
 
{<section id="axcp202.msgcentre_notify" >}
PRIVATE FUNCTION axcp202_msgcentre_notify()
 
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
 
{<section id="axcp202.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# xcbk001參開欄位帶值
PRIVATE FUNCTION axcp202_xcbk001_desc(p_xcbk001)
   DEFINE p_xcbk001        LIKE xcbk_t.xcbk001
   DEFINE r_xcbk001_desc   LIKE type_t.chr80
   
   LET r_xcbk001_desc = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xcbk001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_xcbk001_desc = '', g_rtn_fields[1] , ''
   RETURN r_xcbk001_desc
END FUNCTION
# 批處理邏輯
PRIVATE FUNCTION axcp202_p(ls_js)
   DEFINE lc_param    type_parameter
   DEFINE ls_js          STRING
   DEFINE l_string       STRING 
   DEFINE tok            base.stringtokenizer
#   DEFINE l_xcbj         RECORD  LIKE xcbj_t.* #161124-00048#21 mark
#   DEFINE l_xcbk         RECORD  LIKE xcbk_t.* #161124-00048#21 mark
   #161124-00048#21 add(s)
   DEFINE l_xcbj RECORD  #工時費用統計維護檔
       xcbjent LIKE xcbj_t.xcbjent, #企业编号
       xcbjcomp LIKE xcbj_t.xcbjcomp, #法人组织
       xcbjld LIKE xcbj_t.xcbjld, #账套编号
       xcbj001 LIKE xcbj_t.xcbj001, #成本计算类型
       xcbj002 LIKE xcbj_t.xcbj002, #年度
       xcbj003 LIKE xcbj_t.xcbj003, #期别
       xcbj004 LIKE xcbj_t.xcbj004, #成本中心
       xcbj005 LIKE xcbj_t.xcbj005, #费用分类（主成本要素）
       xcbj006 LIKE xcbj_t.xcbj006, #分摊方式
       xcbj010 LIKE xcbj_t.xcbj010, #制费类别
       xcbj011 LIKE xcbj_t.xcbj011, #会计科目
       xcbj020 LIKE xcbj_t.xcbj020, #分摊基础指标总和
       xcbj021 LIKE xcbj_t.xcbj021, #标准产能
       xcbj101 LIKE xcbj_t.xcbj101, #费用总额(本位币一)
       xcbj102 LIKE xcbj_t.xcbj102, #固定费用(本位币一)
       xcbj103 LIKE xcbj_t.xcbj103, #分摊金额(本位币一)
       xcbj104 LIKE xcbj_t.xcbj104, #闲置费用(本位币一)
       xcbj105 LIKE xcbj_t.xcbj105, #单位成本(本位币一)
       xcbj111 LIKE xcbj_t.xcbj111, #费用总额(本位币二)
       xcbj112 LIKE xcbj_t.xcbj112, #固定费用(本位币二)
       xcbj113 LIKE xcbj_t.xcbj113, #分摊金额(本位币二)
       xcbj114 LIKE xcbj_t.xcbj114, #闲置费用(本位币二)
       xcbj115 LIKE xcbj_t.xcbj115, #单位成本(本位币二)
       xcbj121 LIKE xcbj_t.xcbj121, #费用总额(本位币三)
       xcbj122 LIKE xcbj_t.xcbj122, #固定费用(本位币三)
       xcbj123 LIKE xcbj_t.xcbj123, #分摊金额(本位币三)
       xcbj124 LIKE xcbj_t.xcbj124, #闲置费用(本位币三)
       xcbj125 LIKE xcbj_t.xcbj125, #单位成本(本位币三)
       xcbjownid LIKE xcbj_t.xcbjownid, #资料所有者
       xcbjowndp LIKE xcbj_t.xcbjowndp, #资料所有部门
       xcbjcrtid LIKE xcbj_t.xcbjcrtid, #资料录入者
       xcbjcrtdp LIKE xcbj_t.xcbjcrtdp, #资料录入部门
       xcbjcrtdt LIKE xcbj_t.xcbjcrtdt, #资料创建日
       xcbjmodid LIKE xcbj_t.xcbjmodid, #资料更改者
       xcbjmoddt LIKE xcbj_t.xcbjmoddt, #最近更改日
       xcbjstus LIKE xcbj_t.xcbjstus  #状态码
END RECORD
DEFINE l_xcbk RECORD  #每月工單人工制費檔
       xcbkent LIKE xcbk_t.xcbkent, #企业编号
       xcbkld LIKE xcbk_t.xcbkld, #账套编号
       xcbkcomp LIKE xcbk_t.xcbkcomp, #法人组织
       xcbk001 LIKE xcbk_t.xcbk001, #成本计算类型
       xcbk002 LIKE xcbk_t.xcbk002, #年度
       xcbk003 LIKE xcbk_t.xcbk003, #期别
       xcbk004 LIKE xcbk_t.xcbk004, #成本中心
       xcbk005 LIKE xcbk_t.xcbk005, #费用分类(成本主要素)
       xcbk006 LIKE xcbk_t.xcbk006, #工单编号
       xcbk007 LIKE xcbk_t.xcbk007, #分摊方式
       xcbk100 LIKE xcbk_t.xcbk100, #工单分摊数
       xcbk101 LIKE xcbk_t.xcbk101, #单位成本(本位币一)
       xcbk111 LIKE xcbk_t.xcbk111, #单位成本(本位币二)
       xcbk121 LIKE xcbk_t.xcbk121, #单位成本(本位币三)
       xcbk202 LIKE xcbk_t.xcbk202, #分摊金额(本位币一)
       xcbk212 LIKE xcbk_t.xcbk212, #分摊金额(本位币二)
       xcbk222 LIKE xcbk_t.xcbk222, #分摊金额(本位币三)
       xcbkownid LIKE xcbk_t.xcbkownid, #资料所有者
       xcbkowndp LIKE xcbk_t.xcbkowndp, #资料所有部门
       xcbkcrtid LIKE xcbk_t.xcbkcrtid, #资料录入者
       xcbkcrtdp LIKE xcbk_t.xcbkcrtdp, #资料录入部门
       xcbkcrtdt LIKE xcbk_t.xcbkcrtdt, #资料创建日
       xcbkmodid LIKE xcbk_t.xcbkmodid, #资料更改者
       xcbkmoddt LIKE xcbk_t.xcbkmoddt, #最近更改日
       xcbkstus LIKE xcbk_t.xcbkstus  #状态码
END RECORD
   #161124-00048#21 add(e)
   DEFINE l_xcbi002      LIKE xcbi_t.xcbi002
   DEFINE l_sum_xcbi104  LIKE xcbi_t.xcbi104
   DEFINE l_sum_xcbi201  LIKE xcbi_t.xcbi201
   DEFINE l_sum_xcbi202  LIKE xcbi_t.xcbi202
   DEFINE l_sum_xcbi203  LIKE xcbi_t.xcbi203
   DEFINE l_sum_xcbi204  LIKE xcbi_t.xcbi204
   DEFINE l_sum_xcbk202  LIKE xcbk_t.xcbk202
   DEFINE l_sum_xcbk212  LIKE xcbk_t.xcbk212
   DEFINE l_sum_xcbk222  LIKE xcbk_t.xcbk222
   DEFINE l_max_xcbk006  LIKE xcbk_t.xcbk006
#   DEFINE l_xcdq         RECORD  LIKE xcdq_t.* #161124-00048#21 mark
#   DEFINE l_xcdr         RECORD  LIKE xcdr_t.* #161124-00048#21 mark  
   #161124-00048#21 add(s)
   DEFINE l_xcdq RECORD  #每月工單人工制費成本次要素檔
       xcdqent LIKE xcdq_t.xcdqent, #企业编号
       xcdqld LIKE xcdq_t.xcdqld, #账套编号
       xcdqcomp LIKE xcdq_t.xcdqcomp, #法人组织
       xcdq001 LIKE xcdq_t.xcdq001, #成本计算类型
       xcdq002 LIKE xcdq_t.xcdq002, #年度
       xcdq003 LIKE xcdq_t.xcdq003, #期别
       xcdq004 LIKE xcdq_t.xcdq004, #成本中心
       xcdq005 LIKE xcdq_t.xcdq005, #费用分类(成本次要素)
       xcdq006 LIKE xcdq_t.xcdq006, #工单编号
       xcdq007 LIKE xcdq_t.xcdq007, #分摊方式
       xcdq100 LIKE xcdq_t.xcdq100, #工单分摊数
       xcdq101 LIKE xcdq_t.xcdq101, #单位成本(本位币一)
       xcdq111 LIKE xcdq_t.xcdq111, #单位成本(本位币二)
       xcdq121 LIKE xcdq_t.xcdq121, #单位成本(本位币三)
       xcdq202 LIKE xcdq_t.xcdq202, #分摊金额(本位币一)
       xcdq212 LIKE xcdq_t.xcdq212, #分摊金额(本位币二)
       xcdq222 LIKE xcdq_t.xcdq222, #分摊金额(本位币三)
       xcdqownid LIKE xcdq_t.xcdqownid, #资料所有者
       xcdqowndp LIKE xcdq_t.xcdqowndp, #资料所有部门
       xcdqcrtid LIKE xcdq_t.xcdqcrtid, #资料录入者
       xcdqcrtdp LIKE xcdq_t.xcdqcrtdp, #资料录入部门
       xcdqcrtdt LIKE xcdq_t.xcdqcrtdt, #资料创建日
       xcdqmodid LIKE xcdq_t.xcdqmodid, #资料更改者
       xcdqmoddt LIKE xcdq_t.xcdqmoddt, #最近更改日
       xcdqstus LIKE xcdq_t.xcdqstus  #状态码
END RECORD
DEFINE l_xcdr RECORD  #工時費用成本次要素統計維護檔
       xcdrent LIKE xcdr_t.xcdrent, #企业编号
       xcdrcomp LIKE xcdr_t.xcdrcomp, #法人
       xcdrld LIKE xcdr_t.xcdrld, #账套
       xcdr001 LIKE xcdr_t.xcdr001, #成本计算类型
       xcdr002 LIKE xcdr_t.xcdr002, #年度
       xcdr003 LIKE xcdr_t.xcdr003, #期别
       xcdr004 LIKE xcdr_t.xcdr004, #成本中心
       xcdr005 LIKE xcdr_t.xcdr005, #费用分类(成本次要素)
       xcdr006 LIKE xcdr_t.xcdr006, #分摊方式
       xcdr010 LIKE xcdr_t.xcdr010, #制费类别
       xcdr011 LIKE xcdr_t.xcdr011, #会计科目
       xcdr020 LIKE xcdr_t.xcdr020, #分摊基础指标总数
       xcdr021 LIKE xcdr_t.xcdr021, #标准产能
       xcdr101 LIKE xcdr_t.xcdr101, #费用总额(本位币一)
       xcdr102 LIKE xcdr_t.xcdr102, #固定费用(本位币一)
       xcdr103 LIKE xcdr_t.xcdr103, #分摊金额(本位币一)
       xcdr104 LIKE xcdr_t.xcdr104, #闲置费用(本位币一)
       xcdr105 LIKE xcdr_t.xcdr105, #单位成本(本位币一)
       xcdr111 LIKE xcdr_t.xcdr111, #费用总额(本位币二)
       xcdr112 LIKE xcdr_t.xcdr112, #固定费用(本位币二)
       xcdr113 LIKE xcdr_t.xcdr113, #分摊金额(本位币二)
       xcdr114 LIKE xcdr_t.xcdr114, #闲置费用(本位币二)
       xcdr115 LIKE xcdr_t.xcdr115, #单位成本(本位币二)
       xcdr121 LIKE xcdr_t.xcdr121, #费用总额(本位币三)
       xcdr122 LIKE xcdr_t.xcdr122, #固定费用(本位币三)
       xcdr123 LIKE xcdr_t.xcdr123, #分摊金额(本位币三)
       xcdr124 LIKE xcdr_t.xcdr124, #闲置费用(本位币三)
       xcdr125 LIKE xcdr_t.xcdr125  #单位成本(本位币三)
END RECORD
   #161124-00048#21 add(e)
   DEFINE l_sum_xcdq202  LIKE xcdq_t.xcdq202
   DEFINE l_sum_xcdq212  LIKE xcdq_t.xcdq212
   DEFINE l_sum_xcdq222  LIKE xcdq_t.xcdq222
   DEFINE l_max_xcdq006  LIKE xcdq_t.xcdq006
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_curr         LIKE glaa_t.glaa001
   DEFINE l_max_amt      LIKE xcck_t.xcck202
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_ooef014      LIKE ooef_t.ooef014    #币别参照表号 liuym20150811
   DEFINE l_xcbh_cnt     LIKE type_t.num5       #160913-00039#1 add
   
   CALL util.JSON.parse(ls_js,lc_param)
   
   INITIALIZE l_xcbk.* TO NULL
   INITIALIZE l_xcdq.* TO NULL
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #從wc中分別截取xcabsite，imaa001的查詢條件
   IF NOT cl_null(lc_param.wc) OR lc_param.wc != " 1=1" THEN 
      LET g_wc = lc_param.wc
      LET g_wc = cl_replace_str(g_wc,"and","||")
      LET tok = base.StringTokenizer.create(g_wc,"||")
      WHILE tok.hasMoreTokens()
         LET l_string = tok.nextToken()
         LET l_string = l_string.trim()
         IF l_string MATCHES '*xcbkcomp*' THEN
            LET g_wc_xcbkcomp = l_string     
         END IF
         IF l_string MATCHES '*xcbkld*' THEN
            LET g_wc_xcbkld = l_string
         END IF
      END WHILE
   END IF   
   
   IF cl_null(g_wc_xcbkcomp) THEN 
      LET g_wc_xcbkcomp = "1=1"
   END IF
   
   IF cl_null(g_wc_xcbkld) THEN 
      LET g_wc_xcbkld = "1=1"
   END IF
 
   LET l_cnt = 0
   LET g_sql = "SELECT COUNT(*) FROM xcbk_t ",
               " WHERE xcbkent = '",g_enterprise,"'",
               "   AND xcbk001 = '",lc_param.xcbk001,"'",
               "   AND xcbk002 = '",lc_param.xcbk002,"'",
               "   AND xcbk003 = '",lc_param.xcbk003,"'",
               "   AND ",g_wc_xcbkld,
               "   AND ",g_wc_xcbkcomp
   
   PREPARE axcp202_sel_xcbk_pre FROM g_sql 
   EXECUTE axcp202_sel_xcbk_pre INTO l_cnt 
         
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm('axc-00687') THEN   #是否更新 
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   
   #根据"账套"、"成本计算类型"、"成本年度"、"成本期别"删除“工单人工制费分摊金额明细档(xcbk_t)”的资料
   LET g_sql = "DELETE FROM xcbk_t ",
               " WHERE xcbkent = '",g_enterprise,"'",
               "   AND xcbk001 = '",lc_param.xcbk001,"'",
               "   AND xcbk002 = '",lc_param.xcbk002,"'",
               "   AND xcbk003 = '",lc_param.xcbk003,"'",
               "   AND ",g_wc_xcbkld,
               "   AND ",g_wc_xcbkcomp
   
   PREPARE axcp202_del_xcbk_pre FROM g_sql 
   EXECUTE axcp202_del_xcbk_pre 

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素
      CALL axcp202_replace_sql()
      PREPARE axcp202_del_pb1 FROM g_sql 
      
      EXECUTE axcp202_del_pb1
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'DELETE xcdr FILE'
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   
   CALL cl_progress_no_window_ing("delete original file")
   
   LET g_wc_xcbkld = cl_replace_str(g_wc_xcbkld,"xcbkld","xcbjld")
   LET g_wc_xcbkcomp = cl_replace_str(g_wc_xcbkcomp,"xcbkcomp","xcbjcomp")

#   LET g_sql = "SELECT * FROM xcbj_t ",  #161124-00048#21 mark
   #161124-00048#21 add(s)
   LET g_sql = "SELECT xcbjent,xcbjcomp,xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,", 
               "       xcbj006,xcbj010,xcbj011,xcbj020,xcbj021,xcbj101,xcbj102,xcbj103,",
               "       xcbj104,xcbj105,xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,xcbj121,",
               "       xcbj122,xcbj123,xcbj124,xcbj125,xcbjownid,xcbjowndp,xcbjcrtid,  ",
               "       xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt,xcbjstus FROM xcbj_t ", 
   #161124-00048#21 add(e)
               " WHERE xcbjent = '",g_enterprise,"'",
               "   AND xcbj001 = '",lc_param.xcbk001,"'",
               "   AND xcbj002 = '",lc_param.xcbk002,"'",
               "   AND xcbj003 = '",lc_param.xcbk003,"'", 
               "   AND ",g_wc_xcbkld,
               "   AND ",g_wc_xcbkcomp
   PREPARE axcp202_xcbj_pre FROM g_sql
   DECLARE axcp202_xcbj_cur CURSOR FOR axcp202_xcbj_pre  

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素
      CALL axcp202_replace_sql()
      PREPARE axcp202_xcdr_pre FROM g_sql
      DECLARE axcp202_xcdr_cur CURSOR FOR axcp202_xcdr_pre        
   END IF

   #161012-00015#1-(S)-mark
   ##160913-00039#1-(S)-add
   ##檢查是否存在已確認在製報工和統計資料   
   #LET l_xcbh_cnt = 0
   #SELECT COUNT(*) INTO l_xcbh_cnt
   #  FROM xcbh_t,xcbi_t
   # WHERE xcbient = g_enterprise
   #   AND xcbient = xcbhent 
   #   AND xcbidocno = xcbhdocno
   #   AND xcbhstus = 'Y'     
   #   AND xcbhcomp = l_xcbj.xcbjcomp
   #   AND xcbi001  = l_xcbj.xcbj004
   #   AND TO_CHAR(xcbh001,'YYYY') = lc_param.xcbk002
   #   AND TO_CHAR(xcbh001,'MM')   = lc_param.xcbk003                     
   # ORDER BY xcbi002 
   # 
   #IF cl_null(l_xcbh_cnt) THEN  LET l_xcbh_cnt = 0  END IF    
   ##160913-00039#1-(E)-add
   #161012-00015#1-(E)-mark
   
   CALL cl_err_collect_init()
   LET l_flag = 'N'
   FOREACH axcp202_xcbj_cur INTO l_xcbj.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      #161019-00033#1---add---s
      CALL axcp202_date_chk(l_xcbj.xcbjcomp,lc_param.xcbk002,lc_param.xcbk003)
      IF NOT cl_null(g_errno) THEN
         LET g_errparam.extend = lc_param.xcbk002
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CONTINUE FOREACH                      
      END IF       
      #161019-00033#1---add---e
      
      LET l_max_amt = 0
      LET l_max_xcbk006 = NULL
      LET l_xcbk.xcbkent = g_enterprise
      LET l_xcbk.xcbkld = l_xcbj.xcbjld
      LET l_xcbk.xcbkcomp = l_xcbj.xcbjcomp
      LET l_xcbk.xcbk001 = l_xcbj.xcbj001
      LET l_xcbk.xcbk002 = l_xcbj.xcbj002
      LET l_xcbk.xcbk003 = l_xcbj.xcbj003
      LET l_xcbk.xcbk004 = l_xcbj.xcbj004
      LET l_xcbk.xcbk005 = l_xcbj.xcbj005
      LET l_xcbk.xcbk007 = l_xcbj.xcbj006
      LET l_xcbk.xcbk101 = l_xcbj.xcbj105
      LET l_xcbk.xcbk111 = l_xcbj.xcbj115
      LET l_xcbk.xcbk121 = l_xcbj.xcbj125
      
      LET l_xcbk.xcbkownid = g_user
      LET l_xcbk.xcbkowndp = g_dept
      LET l_xcbk.xcbkcrtid = g_user
      LET l_xcbk.xcbkcrtdp = g_dept 
      LET l_xcbk.xcbkcrtdt = cl_get_current()
      LET l_xcbk.xcbkmodid = ""
      LET l_xcbk.xcbkmoddt = ""

      #實際工時
      IF l_xcbj.xcbj006 = '1' THEN 
         LET g_sql = "SELECT xcbi002,SUM(xcbi201) ",
                     "  FROM xcbh_t,xcbi_t ",
                     " WHERE xcbient = '",g_enterprise,"'",
                     "   AND xcbient = xcbhent ",
                     "   AND xcbidocno = xcbhdocno ",
                     "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                     "   AND xcbhcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbi001  = '",l_xcbj.xcbj004,"'",   #wujie 150214
                     "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbi002 ",
                     " ORDER BY xcbi002 "
         PREPARE xcbi_pre_1 FROM g_sql
         DECLARE xcbi_cur_1 CURSOR FOR xcbi_pre_1
         FOREACH xcbi_cur_1 INTO l_xcbi002,l_sum_xcbi201
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbk.xcbk006 = l_xcbi002
            LET l_xcbk.xcbk100 = l_sum_xcbi201
            LET l_xcbk.xcbk202 = l_xcbk.xcbk100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbk.xcbk212 = l_xcbk.xcbk100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbk.xcbk222 = l_xcbk.xcbk100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbk.xcbk100) THEN LET l_xcbk.xcbk100 = 0 END IF   #151116 Sarah add
            #liuym150814 add-----S--------
            IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
            IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
            IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
            #liuym150814 add-----E-------- 
            #fengmy150731-----begin
            IF cl_null(l_xcbk.xcbk202) THEN LET l_xcbk.xcbk202 = 0 END IF   
            IF cl_null(l_xcbk.xcbk212) THEN LET l_xcbk.xcbk212 = 0 END IF
            IF cl_null(l_xcbk.xcbk222) THEN LET l_xcbk.xcbk222 = 0 END IF
            #fengmy150731-----end           
            CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbk.xcbk100 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk100,'1')
               LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
               LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
               LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811
               LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk202,'2') 
               LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk212,'2') 
               LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF
#            INSERT INTO xcbk_t VALUES(l_xcbk.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbk_t(xcbkent,xcbkld,xcbkcomp,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,
                               xcbk007,xcbk100,xcbk101,xcbk111,xcbk121,xcbk202,xcbk212,xcbk222,xcbkownid,
                               xcbkowndp,xcbkcrtid,xcbkcrtdp,xcbkcrtdt,xcbkmodid,xcbkmoddt,xcbkstus) 
                        VALUES(l_xcbk.xcbkent,l_xcbk.xcbkld,l_xcbk.xcbkcomp,l_xcbk.xcbk001,l_xcbk.xcbk002,l_xcbk.xcbk003,l_xcbk.xcbk004,l_xcbk.xcbk005,l_xcbk.xcbk006,
                               l_xcbk.xcbk007,l_xcbk.xcbk100,l_xcbk.xcbk101,l_xcbk.xcbk111,l_xcbk.xcbk121,l_xcbk.xcbk202,l_xcbk.xcbk212,l_xcbk.xcbk222,l_xcbk.xcbkownid,
                               l_xcbk.xcbkowndp,l_xcbk.xcbkcrtid,l_xcbk.xcbkcrtdp,l_xcbk.xcbkcrtdt,l_xcbk.xcbkmodid,l_xcbk.xcbkmoddt,l_xcbk.xcbkstus)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbk"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbk006 = l_xcbk.xcbk006
            IF l_xcbk.xcbk202 > l_max_amt THEN 
               LET l_max_amt = l_xcbk.xcbk202
            END IF
         END FOREACH 
      END IF
      
      #標準工時
      IF l_xcbj.xcbj006 = '2' THEN 
         LET g_sql = "SELECT xcbi002,SUM(xcbi203) ",
                     "  FROM xcbh_t,xcbi_t ",
                     " WHERE xcbient = '",g_enterprise,"'",
                     "   AND xcbient = xcbhent ",
                     "   AND xcbidocno = xcbhdocno ",
                     "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                     "   AND xcbhcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbi001  = '",l_xcbj.xcbj004,"'",   #wujie 150214
                     "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbi002 ",
                     " ORDER BY xcbi002 "
         PREPARE xcbi_pre_2 FROM g_sql
         DECLARE xcbi_cur_2 CURSOR FOR xcbi_pre_2
         FOREACH xcbi_cur_2 INTO l_xcbi002,l_sum_xcbi203
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbk.xcbk006 = l_xcbi002
            LET l_xcbk.xcbk100 = l_sum_xcbi203
            LET l_xcbk.xcbk202 = l_xcbk.xcbk100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbk.xcbk212 = l_xcbk.xcbk100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbk.xcbk222 = l_xcbk.xcbk100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbk.xcbk100) THEN LET l_xcbk.xcbk100 = 0 END IF   #151116 Sarah add
            #liuym150814 add-----S--------
            IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
            IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
            IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
            #liuym150814 add-----E--------
            #fengmy150731-----begin
            IF cl_null(l_xcbk.xcbk202) THEN LET l_xcbk.xcbk202 = 0 END IF   
            IF cl_null(l_xcbk.xcbk212) THEN LET l_xcbk.xcbk212 = 0 END IF
            IF cl_null(l_xcbk.xcbk222) THEN LET l_xcbk.xcbk222 = 0 END IF
            #fengmy150731-----end
            CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbk.xcbk100 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk100,'1')
               LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
               LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
               LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811               
               LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk202,'2') 
               LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk212,'2') 
               LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbk_t VALUES(l_xcbk.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbk_t(xcbkent,xcbkld,xcbkcomp,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,
                               xcbk007,xcbk100,xcbk101,xcbk111,xcbk121,xcbk202,xcbk212,xcbk222,xcbkownid,
                               xcbkowndp,xcbkcrtid,xcbkcrtdp,xcbkcrtdt,xcbkmodid,xcbkmoddt,xcbkstus) 
                        VALUES(l_xcbk.xcbkent,l_xcbk.xcbkld,l_xcbk.xcbkcomp,l_xcbk.xcbk001,l_xcbk.xcbk002,l_xcbk.xcbk003,l_xcbk.xcbk004,l_xcbk.xcbk005,l_xcbk.xcbk006,
                               l_xcbk.xcbk007,l_xcbk.xcbk100,l_xcbk.xcbk101,l_xcbk.xcbk111,l_xcbk.xcbk121,l_xcbk.xcbk202,l_xcbk.xcbk212,l_xcbk.xcbk222,l_xcbk.xcbkownid,
                               l_xcbk.xcbkowndp,l_xcbk.xcbkcrtid,l_xcbk.xcbkcrtdp,l_xcbk.xcbkcrtdt,l_xcbk.xcbkmodid,l_xcbk.xcbkmoddt,l_xcbk.xcbkstus)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbk"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbk006 = l_xcbk.xcbk006
            IF l_xcbk.xcbk202 > l_max_amt THEN 
               LET l_max_amt = l_xcbk.xcbk202
            END IF
         END FOREACH 
      END IF
      
      #標準機時
      IF l_xcbj.xcbj006 = '3' THEN 
         LET g_sql = "SELECT xcbi002,SUM(xcbi204) ",
                     "  FROM xcbh_t,xcbi_t ",
                     " WHERE xcbient = '",g_enterprise,"'",
                     "   AND xcbient = xcbhent ",
                     "   AND xcbidocno = xcbhdocno ",
                     "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                     "   AND xcbhcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbi001  = '",l_xcbj.xcbj004,"'",   #wujie 150214
                     "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbi002 ",
                     " ORDER BY xcbi002 "
         PREPARE xcbi_pre_3 FROM g_sql
         DECLARE xcbi_cur_3 CURSOR FOR xcbi_pre_3
         FOREACH xcbi_cur_3 INTO l_xcbi002,l_sum_xcbi204
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbk.xcbk006 = l_xcbi002
            LET l_xcbk.xcbk100 = l_sum_xcbi204
            LET l_xcbk.xcbk202 = l_xcbk.xcbk100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbk.xcbk212 = l_xcbk.xcbk100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbk.xcbk222 = l_xcbk.xcbk100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbk.xcbk100) THEN LET l_xcbk.xcbk100 = 0 END IF   #151116 Sarah add
            #liuym150814 add-----S--------
            IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
            IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
            IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
            #liuym150814 add-----E--------
            #fengmy150731-----begin
            IF cl_null(l_xcbk.xcbk202) THEN LET l_xcbk.xcbk202 = 0 END IF   
            IF cl_null(l_xcbk.xcbk212) THEN LET l_xcbk.xcbk212 = 0 END IF
            IF cl_null(l_xcbk.xcbk222) THEN LET l_xcbk.xcbk222 = 0 END IF
            #fengmy150731-----end
            CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbk.xcbk100 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk100,'1')
               LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
               LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
               LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811               
               LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk202,'2') 
               LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk212,'2') 
               LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbk_t VALUES(l_xcbk.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbk_t(xcbkent,xcbkld,xcbkcomp,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,
                               xcbk007,xcbk100,xcbk101,xcbk111,xcbk121,xcbk202,xcbk212,xcbk222,xcbkownid,
                               xcbkowndp,xcbkcrtid,xcbkcrtdp,xcbkcrtdt,xcbkmodid,xcbkmoddt,xcbkstus) 
                        VALUES(l_xcbk.xcbkent,l_xcbk.xcbkld,l_xcbk.xcbkcomp,l_xcbk.xcbk001,l_xcbk.xcbk002,l_xcbk.xcbk003,l_xcbk.xcbk004,l_xcbk.xcbk005,l_xcbk.xcbk006,
                               l_xcbk.xcbk007,l_xcbk.xcbk100,l_xcbk.xcbk101,l_xcbk.xcbk111,l_xcbk.xcbk121,l_xcbk.xcbk202,l_xcbk.xcbk212,l_xcbk.xcbk222,l_xcbk.xcbkownid,
                               l_xcbk.xcbkowndp,l_xcbk.xcbkcrtid,l_xcbk.xcbkcrtdp,l_xcbk.xcbkcrtdt,l_xcbk.xcbkmodid,l_xcbk.xcbkmoddt,l_xcbk.xcbkstus)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbk"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbk006 = l_xcbk.xcbk006
            IF l_xcbk.xcbk202 > l_max_amt THEN 
               LET l_max_amt = l_xcbk.xcbk202
            END IF
         END FOREACH 
      END IF
      
      #產出數量*分攤權屬
      IF l_xcbj.xcbj006 = '4' THEN 
         LET g_sql = "SELECT xcbi002,SUM(xcbi104) ",
                     "  FROM xcbh_t,xcbi_t ",
                     " WHERE xcbient = '",g_enterprise,"'",
                     "   AND xcbient = xcbhent ",
                     "   AND xcbidocno = xcbhdocno ",
                     "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                     "   AND xcbhcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbi001  = '",l_xcbj.xcbj004,"'",   #wujie 150214
                     "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbi002 ",
                     " ORDER BY xcbi002 "
         PREPARE xcbi_pre_4 FROM g_sql
         DECLARE xcbi_cur_4 CURSOR FOR xcbi_pre_4
         #FOREACH xcbi_cur_4 INTO l_xcbi002,l_sum_xcbi202
         FOREACH xcbi_cur_4 INTO l_xcbi002,l_sum_xcbi104 #mod zhangllc 160425
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbk.xcbk006 = l_xcbi002
            LET l_xcbk.xcbk100 = l_sum_xcbi104 * 1   #SUM(报工数量(xcbi104)*分摊权数(目前没有维护作业和档案，值给‘1’))
            LET l_xcbk.xcbk202 = l_xcbk.xcbk100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbk.xcbk212 = l_xcbk.xcbk100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbk.xcbk222 = l_xcbk.xcbk100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbk.xcbk100) THEN LET l_xcbk.xcbk100 = 0 END IF   #151116 Sarah add
            #liuym150814 add-----S--------
            IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
            IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
            IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
            #liuym150814 add-----E--------
            #fengmy150731-----begin
            IF cl_null(l_xcbk.xcbk202) THEN LET l_xcbk.xcbk202 = 0 END IF   
            IF cl_null(l_xcbk.xcbk212) THEN LET l_xcbk.xcbk212 = 0 END IF
            IF cl_null(l_xcbk.xcbk222) THEN LET l_xcbk.xcbk222 = 0 END IF
            #fengmy150731-----end
            CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbk.xcbk100 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk100,'1')
               LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
               LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
               LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811
               LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk202,'2') 
               LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk212,'2') 
               LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbk_t VALUES(l_xcbk.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbk_t(xcbkent,xcbkld,xcbkcomp,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,
                               xcbk007,xcbk100,xcbk101,xcbk111,xcbk121,xcbk202,xcbk212,xcbk222,xcbkownid,
                               xcbkowndp,xcbkcrtid,xcbkcrtdp,xcbkcrtdt,xcbkmodid,xcbkmoddt,xcbkstus) 
                        VALUES(l_xcbk.xcbkent,l_xcbk.xcbkld,l_xcbk.xcbkcomp,l_xcbk.xcbk001,l_xcbk.xcbk002,l_xcbk.xcbk003,l_xcbk.xcbk004,l_xcbk.xcbk005,l_xcbk.xcbk006,
                               l_xcbk.xcbk007,l_xcbk.xcbk100,l_xcbk.xcbk101,l_xcbk.xcbk111,l_xcbk.xcbk121,l_xcbk.xcbk202,l_xcbk.xcbk212,l_xcbk.xcbk222,l_xcbk.xcbkownid,
                               l_xcbk.xcbkowndp,l_xcbk.xcbkcrtid,l_xcbk.xcbkcrtdp,l_xcbk.xcbkcrtdt,l_xcbk.xcbkmodid,l_xcbk.xcbkmoddt,l_xcbk.xcbkstus)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbk"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbk006 = l_xcbk.xcbk006
            IF l_xcbk.xcbk202 > l_max_amt THEN 
               LET l_max_amt = l_xcbk.xcbk202
            END IF
         END FOREACH 
      END IF
      
      #實際機時
      IF l_xcbj.xcbj006 = '5' THEN 
         LET g_sql = "SELECT xcbi002,SUM(xcbi202) ",
                     "  FROM xcbh_t,xcbi_t ",
                     " WHERE xcbient = '",g_enterprise,"'",
                     "   AND xcbient = xcbhent ",
                     "   AND xcbidocno = xcbhdocno ",
                     "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                     "   AND xcbhcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbi001  = '",l_xcbj.xcbj004,"'",   #wujie 150214
                     "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbi002 ",
                     " ORDER BY xcbi002 "
         PREPARE xcbi_pre_5 FROM g_sql
         DECLARE xcbi_cur_5 CURSOR FOR xcbi_pre_5
         FOREACH xcbi_cur_5 INTO l_xcbi002,l_sum_xcbi202
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbk.xcbk006 = l_xcbi002
            LET l_xcbk.xcbk100 = l_sum_xcbi202
            LET l_xcbk.xcbk202 = l_xcbk.xcbk100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbk.xcbk212 = l_xcbk.xcbk100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbk.xcbk222 = l_xcbk.xcbk100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbk.xcbk100) THEN LET l_xcbk.xcbk100 = 0 END IF   #151116 Sarah add
            #liuym150814 add-----S--------
            IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
            IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
            IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
            #liuym150814 add-----E--------
            #fengmy150731-----begin
            IF cl_null(l_xcbk.xcbk202) THEN LET l_xcbk.xcbk202 = 0 END IF   
            IF cl_null(l_xcbk.xcbk212) THEN LET l_xcbk.xcbk212 = 0 END IF
            IF cl_null(l_xcbk.xcbk222) THEN LET l_xcbk.xcbk222 = 0 END IF
            #fengmy150731-----end            
            CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbk.xcbk100 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk100,'1')
               LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
               LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
               LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811               
               LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk202,'2') 
               LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk212,'2') 
               LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbk_t VALUES(l_xcbk.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbk_t(xcbkent,xcbkld,xcbkcomp,xcbk001,xcbk002,xcbk003,xcbk004,xcbk005,xcbk006,
                               xcbk007,xcbk100,xcbk101,xcbk111,xcbk121,xcbk202,xcbk212,xcbk222,xcbkownid,
                               xcbkowndp,xcbkcrtid,xcbkcrtdp,xcbkcrtdt,xcbkmodid,xcbkmoddt,xcbkstus) 
                        VALUES(l_xcbk.xcbkent,l_xcbk.xcbkld,l_xcbk.xcbkcomp,l_xcbk.xcbk001,l_xcbk.xcbk002,l_xcbk.xcbk003,l_xcbk.xcbk004,l_xcbk.xcbk005,l_xcbk.xcbk006,
                               l_xcbk.xcbk007,l_xcbk.xcbk100,l_xcbk.xcbk101,l_xcbk.xcbk111,l_xcbk.xcbk121,l_xcbk.xcbk202,l_xcbk.xcbk212,l_xcbk.xcbk222,l_xcbk.xcbkownid,
                               l_xcbk.xcbkowndp,l_xcbk.xcbkcrtid,l_xcbk.xcbkcrtdp,l_xcbk.xcbkcrtdt,l_xcbk.xcbkmodid,l_xcbk.xcbkmoddt,l_xcbk.xcbkstus)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbk"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbk006 = l_xcbk.xcbk006
            IF l_xcbk.xcbk202 > l_max_amt THEN 
               LET l_max_amt = l_xcbk.xcbk202
            END IF
         END FOREACH 
      END IF
      
#处理尾差，按工单排序，最后一笔加上前端xcbj分摊总金额-本次各笔分摊金额合计的差异 
#尾差处理的范围是同一分摊方式不同工单
      IF l_xcbk.xcbk006 IS NOT NULL THEN   #没有工单，说明前面没有抓到xcbi资料，不该有尾差调整
         LET l_sum_xcbk202 = 0
         LET l_sum_xcbk212 = 0
         LET l_sum_xcbk222 = 0
         SELECT SUM(xcbk202),SUM(xcbk212),SUM(xcbk222) INTO l_sum_xcbk202,l_sum_xcbk212,l_sum_xcbk222
           FROM xcbk_t
          WHERE xcbkent = g_enterprise
            AND xcbkld  = l_xcbj.xcbjld
            AND xcbk001 = l_xcbj.xcbj001
            AND xcbk002 = l_xcbj.xcbj002
            AND xcbk003 = l_xcbj.xcbj003
            AND xcbk004 = l_xcbj.xcbj004
            AND xcbk005 = l_xcbj.xcbj005
            AND xcbk007 = l_xcbj.xcbj006
         #liuym150814 add-----S--------
         IF cl_null(l_xcbk.xcbk101) THEN LET l_xcbk.xcbk101 = 0 END IF   
         IF cl_null(l_xcbk.xcbk111) THEN LET l_xcbk.xcbk111 = 0 END IF
         IF cl_null(l_xcbk.xcbk121) THEN LET l_xcbk.xcbk121 = 0 END IF
         #liuym150814 add-----E-------- 
         IF cl_null(l_sum_xcbk202) THEN LET l_sum_xcbk202 = 0 END IF   #151116 Sarah add
         IF cl_null(l_sum_xcbk212) THEN LET l_sum_xcbk212 = 0 END IF   #151116 Sarah add
         IF cl_null(l_sum_xcbk222) THEN LET l_sum_xcbk222 = 0 END IF   #151116 Sarah add
         #fengmy150731-------b 
         IF cl_null(l_xcbj.xcbj103) THEN   LET l_xcbj.xcbj103 = 0 END IF 
         IF cl_null(l_xcbj.xcbj113) THEN   LET l_xcbj.xcbj113 = 0 END IF 
         IF cl_null(l_xcbj.xcbj123) THEN   LET l_xcbj.xcbj123 = 0 END IF           
         #fengmy150731-------e        
         CALL s_ld_sel_glaa(l_xcbk.xcbkld,'glaa001') RETURNING l_success,l_curr
         IF l_success THEN
            LET l_xcbk.xcbk101 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk101,'1')     #liuym 20150811
            LET l_xcbk.xcbk111 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk111,'1')     #liuym 20150811
            LET l_xcbk.xcbk121 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbk.xcbk121,'1')     #liuym 20150811            
            LET l_xcbk.xcbk202 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_sum_xcbk202,'2') 
            LET l_xcbk.xcbk212 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_sum_xcbk212,'2') 
            LET l_xcbk.xcbk222 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_sum_xcbk222,'2')
            LET l_xcbj.xcbj103 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbj.xcbj103,'2') 
            LET l_xcbj.xcbj113 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbj.xcbj113,'2') 
            LET l_xcbj.xcbj123 = s_curr_round(l_xcbk.xcbkcomp,l_curr,l_xcbj.xcbj123,'2')            
         ELSE
            CONTINUE FOREACH
         END IF
         
         IF l_sum_xcbk202 IS NULL THEN LET l_sum_xcbk202 = 0 END IF
         IF l_sum_xcbk212 IS NULL THEN LET l_sum_xcbk212 = 0 END IF
         IF l_sum_xcbk222 IS NULL THEN LET l_sum_xcbk222 = 0 END IF
         
         UPDATE xcbk_t SET xcbk202 = xcbk202 + l_xcbj.xcbj103 - l_sum_xcbk202,
                           xcbk212 = xcbk212 + l_xcbj.xcbj113 - l_sum_xcbk212,
                           xcbk222 = xcbk222 + l_xcbj.xcbj123 - l_sum_xcbk222
          WHERE xcbkent = g_enterprise
            AND xcbkld  = l_xcbj.xcbjld
            AND xcbk001 = l_xcbj.xcbj001
            AND xcbk002 = l_xcbj.xcbj002
            AND xcbk003 = l_xcbj.xcbj003
            AND xcbk004 = l_xcbj.xcbj004
            AND xcbk005 = l_xcbj.xcbj005
            AND xcbk007 = l_xcbj.xcbj006
            AND xcbk202 = l_max_amt
            AND rownum  = 1
      END IF
#处理尾差结束
   END FOREACH 
   IF l_flag = 'N' THEN                    #160913-00039#1 mark  #161012-00015#1 remark
  #IF l_flag = 'N' OR l_xcbh_cnt = 0 THEN  #160913-00039#1 add
      INITIALIZE g_errparam TO NULL
     #LET g_errparam.code = 'axm-00089'    #160913-00039#1 mark
      LET g_errparam.code = 'axc-00787'    #160913-00039#1 add
      LET g_errparam.extend = "xcbk_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   CALL cl_progress_no_window_ing("ins xcbk")
 
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素 
   
      #161012-00015#1-(S)-mark
      ##160913-00039#1-(S)-add
      ##檢查是否存在已確認在製報工和統計資料   
      #LET l_xcbh_cnt = 0             
      #SELECT COUNT(*) INTO l_xcbh_cnt 
      #  FROM xcbh_t,xcbi_t 
      # WHERE xcbient = g_enterprise
      #   AND xcbient = xcbhent 
      #   AND xcbidocno = xcbhdocno 
      #   AND xcbhstus = 'Y' 
      #   AND xcbhcomp = l_xcdr.xcdrcomp
      #   AND xcbi001  = l_xcdr.xcdr004
      #   AND TO_CHAR(xcbh001,'YYYY') = lc_param.xcbk002
      #   AND TO_CHAR(xcbh001,'MM')   = lc_param.xcbk003       
      # ORDER BY xcbi002 
      # 
      #IF cl_null(l_xcbh_cnt) THEN  LET l_xcbh_cnt = 0  END IF    
      ##160913-00039#1-(E)-add
      #161012-00015#1-(E)-mark
   
      LET l_flag = 'N'   
      FOREACH axcp202_xcdr_cur INTO l_xcdr.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
   
            EXIT FOREACH
         END IF 
         
         LET l_max_amt = 0
         LET l_max_xcdq006 = NULL
         LET l_xcdq.xcdqent = g_enterprise
         LET l_xcdq.xcdqld = l_xcdr.xcdrld
         LET l_xcdq.xcdqcomp = l_xcdr.xcdrcomp
         LET l_xcdq.xcdq001 = l_xcdr.xcdr001
         LET l_xcdq.xcdq002 = l_xcdr.xcdr002
         LET l_xcdq.xcdq003 = l_xcdr.xcdr003
         LET l_xcdq.xcdq004 = l_xcdr.xcdr004
         LET l_xcdq.xcdq005 = l_xcdr.xcdr005
         LET l_xcdq.xcdq007 = l_xcdr.xcdr006
         LET l_xcdq.xcdq101 = l_xcdr.xcdr105
         LET l_xcdq.xcdq111 = l_xcdr.xcdr115
         LET l_xcdq.xcdq121 = l_xcdr.xcdr125
         
         LET l_xcdq.xcdqownid = g_user
         LET l_xcdq.xcdqowndp = g_dept
         LET l_xcdq.xcdqcrtid = g_user
         LET l_xcdq.xcdqcrtdp = g_dept 
         LET l_xcdq.xcdqcrtdt = cl_get_current()
         LET l_xcdq.xcdqmodid = ""
         LET l_xcdq.xcdqmoddt = ""
   
         
         #實際工時
         IF l_xcdr.xcdr006 = '1' THEN 
            LET g_sql = "SELECT xcbi002,SUM(xcbi201) ",
                        "  FROM xcbh_t,xcbi_t ",
                        " WHERE xcbient = '",g_enterprise,"'",
                        "   AND xcbient = xcbhent ",
                        "   AND xcbidocno = xcbhdocno ",
                        "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                        "   AND xcbhcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbi001  = '",l_xcdr.xcdr004,"'",   #wujie 150214
                        "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbi002 ",
                        " ORDER BY xcbi002 "
            PREPARE xcbi_pre_11 FROM g_sql
            DECLARE xcbi_cur_11 CURSOR FOR xcbi_pre_11
            FOREACH xcbi_cur_11 INTO l_xcbi002,l_sum_xcbi201
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdq.xcdq006 = l_xcbi002
               LET l_xcdq.xcdq100 = l_sum_xcbi201
               LET l_xcdq.xcdq202 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq212 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq222 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdq.xcdq100) THEN   LET l_xcdq.xcdq100 = 0 END IF   #151116 Sarah add 
               #fengmy150731-------b 
               IF cl_null(l_xcdq.xcdq202) THEN   LET l_xcdq.xcdq202 = 0 END IF 
               IF cl_null(l_xcdq.xcdq212) THEN   LET l_xcdq.xcdq212 = 0 END IF 
               IF cl_null(l_xcdq.xcdq222) THEN   LET l_xcdq.xcdq222 = 0 END IF
               #fengmy150731-------e 
               CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdq.xcdq100 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq100,'1')
                  LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq202,'2') 
                  LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq212,'2') 
                  LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdq_t VALUES(l_xcdq.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdq_t(xcdqent,xcdqld,xcdqcomp,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,
                                  xcdq007,xcdq100,xcdq101,xcdq111,xcdq121,xcdq202,xcdq212,xcdq222,xcdqownid,
                                  xcdqowndp,xcdqcrtid,xcdqcrtdp,xcdqcrtdt,xcdqmodid,xcdqmoddt,xcdqstus) 
                           VALUES(l_xcdq.xcdqent,l_xcdq.xcdqld,l_xcdq.xcdqcomp,l_xcdq.xcdq001,l_xcdq.xcdq002,l_xcdq.xcdq003,l_xcdq.xcdq004,l_xcdq.xcdq005,l_xcdq.xcdq006,
                                  l_xcdq.xcdq007,l_xcdq.xcdq100,l_xcdq.xcdq101,l_xcdq.xcdq111,l_xcdq.xcdq121,l_xcdq.xcdq202,l_xcdq.xcdq212,l_xcdq.xcdq222,l_xcdq.xcdqownid,
                                  l_xcdq.xcdqowndp,l_xcdq.xcdqcrtid,l_xcdq.xcdqcrtdp,l_xcdq.xcdqcrtdt,l_xcdq.xcdqmodid,l_xcdq.xcdqmoddt,l_xcdq.xcdqstus)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdq"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdq006 = l_xcdq.xcdq006
               IF l_xcdq.xcdq202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdq.xcdq202
               END IF
            END FOREACH 
         END IF
         
         #標準工時
         IF l_xcdr.xcdr006 = '2' THEN 
            LET g_sql = "SELECT xcbi002,SUM(xcbi203) ",
                        "  FROM xcbh_t,xcbi_t ",
                        " WHERE xcbient = '",g_enterprise,"'",
                        "   AND xcbient = xcbhent ",
                        "   AND xcbidocno = xcbhdocno ",
                        "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                        "   AND xcbhcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbi001  = '",l_xcdr.xcdr004,"'",   #wujie 150214
                        "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbi002 ",
                        " ORDER BY xcbi002 "
            PREPARE xcbi_pre_21 FROM g_sql
            DECLARE xcbi_cur_21 CURSOR FOR xcbi_pre_21
            FOREACH xcbi_cur_21 INTO l_xcbi002,l_sum_xcbi203
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdq.xcdq006 = l_xcbi002
               LET l_xcdq.xcdq100 = l_sum_xcbi203
               LET l_xcdq.xcdq202 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq212 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq222 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdq.xcdq100) THEN   LET l_xcdq.xcdq100 = 0 END IF   #151116 Sarah add
               #fengmy150731-------b 
               IF cl_null(l_xcdq.xcdq202) THEN   LET l_xcdq.xcdq202 = 0 END IF 
               IF cl_null(l_xcdq.xcdq212) THEN   LET l_xcdq.xcdq212 = 0 END IF 
               IF cl_null(l_xcdq.xcdq222) THEN   LET l_xcdq.xcdq222 = 0 END IF
               #fengmy150731-------e 
               CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdq.xcdq100 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq100,'1')
                  LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq202,'2') 
                  LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq212,'2') 
                  LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdq_t VALUES(l_xcdq.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdq_t(xcdqent,xcdqld,xcdqcomp,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,
                                  xcdq007,xcdq100,xcdq101,xcdq111,xcdq121,xcdq202,xcdq212,xcdq222,xcdqownid,
                                  xcdqowndp,xcdqcrtid,xcdqcrtdp,xcdqcrtdt,xcdqmodid,xcdqmoddt,xcdqstus) 
                           VALUES(l_xcdq.xcdqent,l_xcdq.xcdqld,l_xcdq.xcdqcomp,l_xcdq.xcdq001,l_xcdq.xcdq002,l_xcdq.xcdq003,l_xcdq.xcdq004,l_xcdq.xcdq005,l_xcdq.xcdq006,
                                  l_xcdq.xcdq007,l_xcdq.xcdq100,l_xcdq.xcdq101,l_xcdq.xcdq111,l_xcdq.xcdq121,l_xcdq.xcdq202,l_xcdq.xcdq212,l_xcdq.xcdq222,l_xcdq.xcdqownid,
                                  l_xcdq.xcdqowndp,l_xcdq.xcdqcrtid,l_xcdq.xcdqcrtdp,l_xcdq.xcdqcrtdt,l_xcdq.xcdqmodid,l_xcdq.xcdqmoddt,l_xcdq.xcdqstus)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdq"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdq006 = l_xcdq.xcdq006
               IF l_xcdq.xcdq202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdq.xcdq202
               END IF
            END FOREACH 
         END IF
         
         #標準機時
         IF l_xcdr.xcdr006 = '3' THEN 
            LET g_sql = "SELECT xcbi002,SUM(xcbi204) ",
                        "  FROM xcbh_t,xcbi_t ",
                        " WHERE xcbient = '",g_enterprise,"'",
                        "   AND xcbient = xcbhent ",
                        "   AND xcbidocno = xcbhdocno ",
                        "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                        "   AND xcbhcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbi001  = '",l_xcdr.xcdr004,"'",   #wujie 150214
                        "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbi002 ",
                        " ORDER BY xcbi002 "
            PREPARE xcbi_pre_31 FROM g_sql
            DECLARE xcbi_cur_31 CURSOR FOR xcbi_pre_31
            FOREACH xcbi_cur_31 INTO l_xcbi002,l_sum_xcbi204
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdq.xcdq006 = l_xcbi002
               LET l_xcdq.xcdq100 = l_sum_xcbi204
               LET l_xcdq.xcdq202 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq212 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq222 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdq.xcdq100) THEN   LET l_xcdq.xcdq100 = 0 END IF   #151116 Sarah add
               #fengmy150731-------b 
               IF cl_null(l_xcdq.xcdq202) THEN   LET l_xcdq.xcdq202 = 0 END IF 
               IF cl_null(l_xcdq.xcdq212) THEN   LET l_xcdq.xcdq212 = 0 END IF 
               IF cl_null(l_xcdq.xcdq222) THEN   LET l_xcdq.xcdq222 = 0 END IF
               #fengmy150731-------e 
               CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdq.xcdq100 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq100,'1')
                  LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq202,'2') 
                  LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq212,'2') 
                  LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdq_t VALUES(l_xcdq.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdq_t(xcdqent,xcdqld,xcdqcomp,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,
                                  xcdq007,xcdq100,xcdq101,xcdq111,xcdq121,xcdq202,xcdq212,xcdq222,xcdqownid,
                                  xcdqowndp,xcdqcrtid,xcdqcrtdp,xcdqcrtdt,xcdqmodid,xcdqmoddt,xcdqstus) 
                           VALUES(l_xcdq.xcdqent,l_xcdq.xcdqld,l_xcdq.xcdqcomp,l_xcdq.xcdq001,l_xcdq.xcdq002,l_xcdq.xcdq003,l_xcdq.xcdq004,l_xcdq.xcdq005,l_xcdq.xcdq006,
                                  l_xcdq.xcdq007,l_xcdq.xcdq100,l_xcdq.xcdq101,l_xcdq.xcdq111,l_xcdq.xcdq121,l_xcdq.xcdq202,l_xcdq.xcdq212,l_xcdq.xcdq222,l_xcdq.xcdqownid,
                                  l_xcdq.xcdqowndp,l_xcdq.xcdqcrtid,l_xcdq.xcdqcrtdp,l_xcdq.xcdqcrtdt,l_xcdq.xcdqmodid,l_xcdq.xcdqmoddt,l_xcdq.xcdqstus)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdq"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdq006 = l_xcdq.xcdq006
               IF l_xcdq.xcdq202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdq.xcdq202
               END IF
            END FOREACH 
         END IF
         
         #產出數量*分攤權屬
         IF l_xcdr.xcdr006 = '4' THEN 
            LET g_sql = "SELECT xcbi002,SUM(xcbi104) ",
                        "  FROM xcbh_t,xcbi_t ",
                        " WHERE xcbient = '",g_enterprise,"'",
                        "   AND xcbient = xcbhent ",
                        "   AND xcbidocno = xcbhdocno ",
                        "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                        "   AND xcbhcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbi001  = '",l_xcdr.xcdr004,"'",   #wujie 150214
                        "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbi002 ",
                        " ORDER BY xcbi002 "
            PREPARE xcbi_pre_41 FROM g_sql
            DECLARE xcbi_cur_41 CURSOR FOR xcbi_pre_41
            #FOREACH xcbi_cur_41 INTO l_xcbi002,l_sum_xcbi202
            FOREACH xcbi_cur_41 INTO l_xcbi002,l_sum_xcbi104 #mod zhangllc 160425
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdq.xcdq006 = l_xcbi002
               LET l_xcdq.xcdq100 = l_sum_xcbi104 * 1   #SUM(报工数量(xcbi104)*分摊权数(目前没有维护作业和档案，值给‘1’))
               LET l_xcdq.xcdq202 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq212 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq222 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdq.xcdq100) THEN   LET l_xcdq.xcdq100 = 0 END IF   #151116 Sarah add
               #fengmy150731-------b 
               IF cl_null(l_xcdq.xcdq202) THEN   LET l_xcdq.xcdq202 = 0 END IF 
               IF cl_null(l_xcdq.xcdq212) THEN   LET l_xcdq.xcdq212 = 0 END IF 
               IF cl_null(l_xcdq.xcdq222) THEN   LET l_xcdq.xcdq222 = 0 END IF
               #fengmy150731-------e 
               CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdq.xcdq100 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq100,'1')
                  LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq202,'2') 
                  LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq212,'2') 
                  LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdq_t VALUES(l_xcdq.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdq_t(xcdqent,xcdqld,xcdqcomp,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,
                                  xcdq007,xcdq100,xcdq101,xcdq111,xcdq121,xcdq202,xcdq212,xcdq222,xcdqownid,
                                  xcdqowndp,xcdqcrtid,xcdqcrtdp,xcdqcrtdt,xcdqmodid,xcdqmoddt,xcdqstus) 
                           VALUES(l_xcdq.xcdqent,l_xcdq.xcdqld,l_xcdq.xcdqcomp,l_xcdq.xcdq001,l_xcdq.xcdq002,l_xcdq.xcdq003,l_xcdq.xcdq004,l_xcdq.xcdq005,l_xcdq.xcdq006,
                                  l_xcdq.xcdq007,l_xcdq.xcdq100,l_xcdq.xcdq101,l_xcdq.xcdq111,l_xcdq.xcdq121,l_xcdq.xcdq202,l_xcdq.xcdq212,l_xcdq.xcdq222,l_xcdq.xcdqownid,
                                  l_xcdq.xcdqowndp,l_xcdq.xcdqcrtid,l_xcdq.xcdqcrtdp,l_xcdq.xcdqcrtdt,l_xcdq.xcdqmodid,l_xcdq.xcdqmoddt,l_xcdq.xcdqstus)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdq"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdq006 = l_xcdq.xcdq006
               IF l_xcdq.xcdq202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdq.xcdq202
               END IF
            END FOREACH 
         END IF
         
         #實際機時
         IF l_xcdr.xcdr006 = '5' THEN 
            LET g_sql = "SELECT xcbi002,SUM(xcbi202) ",
                        "  FROM xcbh_t,xcbi_t ",
                        " WHERE xcbient = '",g_enterprise,"'",
                        "   AND xcbient = xcbhent ",
                        "   AND xcbidocno = xcbhdocno ",
                        "   AND xcbhstus = 'Y' ",        #20150709 add lujh
                        "   AND xcbhcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbi001  = '",l_xcdr.xcdr004,"'",   #wujie 150214
                        "   AND TO_CHAR(xcbh001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbh001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbi002 ",
                        " ORDER BY xcbi002 "
            PREPARE xcbi_pre_51 FROM g_sql
            DECLARE xcbi_cur_51 CURSOR FOR xcbi_pre_51
            FOREACH xcbi_cur_51 INTO l_xcbi002,l_sum_xcbi202
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdq.xcdq006 = l_xcbi002
               LET l_xcdq.xcdq100 = l_sum_xcbi202
               LET l_xcdq.xcdq202 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq212 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdq.xcdq222 = l_xcdq.xcdq100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdq.xcdq100) THEN   LET l_xcdq.xcdq100 = 0 END IF   #151116 Sarah add
               #fengmy150731-------b 
               IF cl_null(l_xcdq.xcdq202) THEN   LET l_xcdq.xcdq202 = 0 END IF 
               IF cl_null(l_xcdq.xcdq212) THEN   LET l_xcdq.xcdq212 = 0 END IF 
               IF cl_null(l_xcdq.xcdq222) THEN   LET l_xcdq.xcdq222 = 0 END IF
               #fengmy150731-------e 
               CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdq.xcdq100 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq100,'1')
                  LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq202,'2') 
                  LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq212,'2') 
                  LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdq.xcdq222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdq_t VALUES(l_xcdq.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdq_t(xcdqent,xcdqld,xcdqcomp,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,
                                  xcdq007,xcdq100,xcdq101,xcdq111,xcdq121,xcdq202,xcdq212,xcdq222,xcdqownid,
                                  xcdqowndp,xcdqcrtid,xcdqcrtdp,xcdqcrtdt,xcdqmodid,xcdqmoddt,xcdqstus) 
                           VALUES(l_xcdq.xcdqent,l_xcdq.xcdqld,l_xcdq.xcdqcomp,l_xcdq.xcdq001,l_xcdq.xcdq002,l_xcdq.xcdq003,l_xcdq.xcdq004,l_xcdq.xcdq005,l_xcdq.xcdq006,
                                  l_xcdq.xcdq007,l_xcdq.xcdq100,l_xcdq.xcdq101,l_xcdq.xcdq111,l_xcdq.xcdq121,l_xcdq.xcdq202,l_xcdq.xcdq212,l_xcdq.xcdq222,l_xcdq.xcdqownid,
                                  l_xcdq.xcdqowndp,l_xcdq.xcdqcrtid,l_xcdq.xcdqcrtdp,l_xcdq.xcdqcrtdt,l_xcdq.xcdqmodid,l_xcdq.xcdqmoddt,l_xcdq.xcdqstus)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdq"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdq006 = l_xcdq.xcdq006
               IF l_xcdq.xcdq202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdq.xcdq202
               END IF
            END FOREACH 
         END IF
         
   #处理尾差，按工单排序，最后一笔加上前端xcdr分摊总金额-本次各笔分摊金额合计的差异 
   #尾差处理的范围是同一分摊方式不同工单
         IF l_xcdq.xcdq006 IS NOT NULL THEN    #没有工单，说明前面没有抓到xcbi资料，不该有尾差调整
            LET l_sum_xcdq202 = 0
            LET l_sum_xcdq212 = 0
            LET l_sum_xcdq222 = 0
            SELECT SUM(xcdq202),SUM(xcdq212),SUM(xcdq222) INTO l_sum_xcdq202,l_sum_xcdq212,l_sum_xcdq222
              FROM xcdq_t
             WHERE xcdqent = g_enterprise
               AND xcdqld  = l_xcdr.xcdrld
               AND xcdq001 = l_xcdr.xcdr001
               AND xcdq002 = l_xcdr.xcdr002
               AND xcdq003 = l_xcdr.xcdr003
               AND xcdq004 = l_xcdr.xcdr004
               AND xcdq005 = l_xcdr.xcdr005
               AND xcdq007 = l_xcdr.xcdr006
            IF cl_null(l_sum_xcdq202) THEN   LET l_sum_xcdq202 = 0 END IF   #151116 Sarah add
            IF cl_null(l_sum_xcdq212) THEN   LET l_sum_xcdq212 = 0 END IF   #151116 Sarah add
            IF cl_null(l_sum_xcdq222) THEN   LET l_sum_xcdq222 = 0 END IF   #151116 Sarah add
            #fengmy150731-------b
            IF cl_null(l_xcdr.xcdr103) THEN   LET l_xcdr.xcdr103 = 0 END IF 
            IF cl_null(l_xcdr.xcdr113) THEN   LET l_xcdr.xcdr113 = 0 END IF 
            IF cl_null(l_xcdr.xcdr123) THEN   LET l_xcdr.xcdr123 = 0 END IF           
            #fengmy150731-------e             
            CALL s_ld_sel_glaa(l_xcdq.xcdqld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcdq.xcdq202 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_sum_xcdq202,'2') 
               LET l_xcdq.xcdq212 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_sum_xcdq212,'2') 
               LET l_xcdq.xcdq222 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_sum_xcdq222,'2')
               LET l_xcdr.xcdr103 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdr.xcdr103,'2') 
               LET l_xcdr.xcdr113 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdr.xcdr113,'2') 
               LET l_xcdr.xcdr123 = s_curr_round(l_xcdq.xcdqcomp,l_curr,l_xcdr.xcdr123,'2')            
            ELSE
               CONTINUE FOREACH
            END IF
            
            IF l_sum_xcdq202 IS NULL THEN LET l_sum_xcdq202 = 0 END IF
            IF l_sum_xcdq212 IS NULL THEN LET l_sum_xcdq212 = 0 END IF
            IF l_sum_xcdq222 IS NULL THEN LET l_sum_xcdq222 = 0 END IF
            
            UPDATE xcdq_t SET xcdq202 = xcdq202 + l_xcdr.xcdr103 - l_sum_xcdq202,
                              xcdq212 = xcdq212 + l_xcdr.xcdr113 - l_sum_xcdq212,
                              xcdq222 = xcdq222 + l_xcdr.xcdr123 - l_sum_xcdq222
             WHERE xcdqent = g_enterprise
               AND xcdqld  = l_xcdr.xcdrld
               AND xcdq001 = l_xcdr.xcdr001
               AND xcdq002 = l_xcdr.xcdr002
               AND xcdq003 = l_xcdr.xcdr003
               AND xcdq004 = l_xcdr.xcdr004
               AND xcdq005 = l_xcdr.xcdr005
               AND xcdq007 = l_xcdr.xcdr006
               AND xcdq202 = l_max_amt
               AND rownum  = 1
         END IF
   #处理尾差结束
      END FOREACH 
      IF l_flag = 'N' THEN                      #160913-00039#1 mark  #161012-00015#1 remark
     #IF l_flag = 'N' OR l_xcbh_cnt = 0 THEN    #160913-00039#1 add
         INITIALIZE g_errparam TO NULL
        #LET g_errparam.code = 'axm-00089'      #160913-00039#1 mark
         LET g_errparam.code = 'axc-00787'      #160913-00039#1 add
         LET g_errparam.extend = "xcdq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      CALL cl_progress_no_window_ing("ins xcdq")
   END IF
   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp202_replace_sql()

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN         #启用成本次要素
      CALL s_chr_replace(g_sql,'xcbk','xcdq',0) RETURNING g_sql
      CALL s_chr_replace(g_sql,'xcbj','xcdr',0) RETURNING g_sql
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2016/10/20 By 02295
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp202_date_chk(p_comp,p_xcbk002,p_xcbk003)
   DEFINE p_comp         LIKE xcbk_t.xcbkcomp
   DEFINE p_xcbk002      LIKE xcbk_t.xcbk002
   DEFINE p_xcbk003      LIKE xcbk_t.xcbk003
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   
   LET g_errno = ''
   IF cl_null(p_comp) THEN RETURN END IF

   IF cl_null(p_xcbk002) THEN RETURN END IF

   IF cl_null(p_xcbk003) THEN RETURN END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_comp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > p_xcbk002 THEN
      LET g_errno = 'axc-00303'
   END IF

   #IF l_yy <= p_xcbk002 AND l_pp > p_xcbk003 THEN   #161117-00031#1 mark
   IF l_yy = p_xcbk002 AND l_pp > p_xcbk003 THEN   #161117-00031#1
      LET g_errno = 'axc-00304'
   END IF
END FUNCTION

#161121-00018#8 add
#工艺成本批處理邏輯
PRIVATE FUNCTION axcp202_process_cost(ls_js)
   DEFINE lc_param    type_parameter
   DEFINE ls_js          STRING
   DEFINE l_string       STRING 
   DEFINE tok            base.stringtokenizer
#   DEFINE l_xcbj         RECORD  LIKE xcbj_t.*  #161124-00048#21 mark
#   DEFINE l_xcbs         RECORD  LIKE xcbs_t.*  #161124-00048#21 mark
   #161124-00048#21 add(s)
   DEFINE l_xcbj RECORD  #工時費用統計維護檔
       xcbjent LIKE xcbj_t.xcbjent, #企业编号
       xcbjcomp LIKE xcbj_t.xcbjcomp, #法人组织
       xcbjld LIKE xcbj_t.xcbjld, #账套编号
       xcbj001 LIKE xcbj_t.xcbj001, #成本计算类型
       xcbj002 LIKE xcbj_t.xcbj002, #年度
       xcbj003 LIKE xcbj_t.xcbj003, #期别
       xcbj004 LIKE xcbj_t.xcbj004, #成本中心
       xcbj005 LIKE xcbj_t.xcbj005, #费用分类（主成本要素）
       xcbj006 LIKE xcbj_t.xcbj006, #分摊方式
       xcbj010 LIKE xcbj_t.xcbj010, #制费类别
       xcbj011 LIKE xcbj_t.xcbj011, #会计科目
       xcbj020 LIKE xcbj_t.xcbj020, #分摊基础指标总和
       xcbj021 LIKE xcbj_t.xcbj021, #标准产能
       xcbj101 LIKE xcbj_t.xcbj101, #费用总额(本位币一)
       xcbj102 LIKE xcbj_t.xcbj102, #固定费用(本位币一)
       xcbj103 LIKE xcbj_t.xcbj103, #分摊金额(本位币一)
       xcbj104 LIKE xcbj_t.xcbj104, #闲置费用(本位币一)
       xcbj105 LIKE xcbj_t.xcbj105, #单位成本(本位币一)
       xcbj111 LIKE xcbj_t.xcbj111, #费用总额(本位币二)
       xcbj112 LIKE xcbj_t.xcbj112, #固定费用(本位币二)
       xcbj113 LIKE xcbj_t.xcbj113, #分摊金额(本位币二)
       xcbj114 LIKE xcbj_t.xcbj114, #闲置费用(本位币二)
       xcbj115 LIKE xcbj_t.xcbj115, #单位成本(本位币二)
       xcbj121 LIKE xcbj_t.xcbj121, #费用总额(本位币三)
       xcbj122 LIKE xcbj_t.xcbj122, #固定费用(本位币三)
       xcbj123 LIKE xcbj_t.xcbj123, #分摊金额(本位币三)
       xcbj124 LIKE xcbj_t.xcbj124, #闲置费用(本位币三)
       xcbj125 LIKE xcbj_t.xcbj125, #单位成本(本位币三)
       xcbjownid LIKE xcbj_t.xcbjownid, #资料所有者
       xcbjowndp LIKE xcbj_t.xcbjowndp, #资料所有部门
       xcbjcrtid LIKE xcbj_t.xcbjcrtid, #资料录入者
       xcbjcrtdp LIKE xcbj_t.xcbjcrtdp, #资料录入部门
       xcbjcrtdt LIKE xcbj_t.xcbjcrtdt, #资料创建日
       xcbjmodid LIKE xcbj_t.xcbjmodid, #资料更改者
       xcbjmoddt LIKE xcbj_t.xcbjmoddt, #最近更改日
       xcbjstus LIKE xcbj_t.xcbjstus  #状态码
END RECORD
DEFINE l_xcbs RECORD  #每月製程成本工時費用分攤統計檔
       xcbsent LIKE xcbs_t.xcbsent, #企业编号
       xcbsld LIKE xcbs_t.xcbsld, #账套编号
       xcbscomp LIKE xcbs_t.xcbscomp, #法人组织
       xcbs001 LIKE xcbs_t.xcbs001, #成本计算类型
       xcbs002 LIKE xcbs_t.xcbs002, #年度
       xcbs003 LIKE xcbs_t.xcbs003, #期别
       xcbs004 LIKE xcbs_t.xcbs004, #成本中心
       xcbs005 LIKE xcbs_t.xcbs005, #费用分类(成本主要素)
       xcbs006 LIKE xcbs_t.xcbs006, #工单编号
       xcbs007 LIKE xcbs_t.xcbs007, #分摊方式
       xcbs008 LIKE xcbs_t.xcbs008, #作业编号
       xcbs009 LIKE xcbs_t.xcbs009, #作业序
       xcbs100 LIKE xcbs_t.xcbs100, #工单分摊数
       xcbs101 LIKE xcbs_t.xcbs101, #单位成本(本位币一)
       xcbs111 LIKE xcbs_t.xcbs111, #单位成本(本位币二)
       xcbs121 LIKE xcbs_t.xcbs121, #单位成本(本位币三)
       xcbs202 LIKE xcbs_t.xcbs202, #分摊金额(本位币一)
       xcbs212 LIKE xcbs_t.xcbs212, #分摊金额(本位币二)
       xcbs222 LIKE xcbs_t.xcbs222  #分摊金额(本位币三)
END RECORD
   #161124-00048#21 add(e)
   DEFINE l_xcbr002      LIKE xcbr_t.xcbr002
   DEFINE l_xcbr003      LIKE xcbr_t.xcbr003
   DEFINE l_xcbr004      LIKE xcbr_t.xcbr004
   DEFINE l_sum_xcbr104  LIKE xcbr_t.xcbr104
   DEFINE l_sum_xcbr201  LIKE xcbr_t.xcbr201
   DEFINE l_sum_xcbr202  LIKE xcbr_t.xcbr202
   DEFINE l_sum_xcbr203  LIKE xcbr_t.xcbr203
   DEFINE l_sum_xcbr204  LIKE xcbr_t.xcbr204
   DEFINE l_sum_xcbs202  LIKE xcbs_t.xcbs202
   DEFINE l_sum_xcbs212  LIKE xcbs_t.xcbs212
   DEFINE l_sum_xcbs222  LIKE xcbs_t.xcbs222
   DEFINE l_max_xcbs006  LIKE xcbs_t.xcbs006
#   DEFINE l_xcdy         RECORD  LIKE xcdy_t.*   #161124-00048#21 mark
#   DEFINE l_xcdr         RECORD  LIKE xcdr_t.*   #161124-00048#21 mark
   #161124-00048#21 add(s)
   DEFINE l_xcdy RECORD  #每月工單人工制費製程成本次要素檔
       xcdyent LIKE xcdy_t.xcdyent, #企業代碼
       xcdyld LIKE xcdy_t.xcdyld, #
       xcdycomp LIKE xcdy_t.xcdycomp, #法人組織
       xcdy001 LIKE xcdy_t.xcdy001, #成本計算類型
       xcdy002 LIKE xcdy_t.xcdy002, #年度
       xcdy003 LIKE xcdy_t.xcdy003, #期別
       xcdy004 LIKE xcdy_t.xcdy004, #成本中心
       xcdy005 LIKE xcdy_t.xcdy005, #費用分類(成本次要素)
       xcdy006 LIKE xcdy_t.xcdy006, #工單編號
       xcdy007 LIKE xcdy_t.xcdy007, #分攤方式
       xcdy008 LIKE xcdy_t.xcdy008, #作業編號
       xcdy009 LIKE xcdy_t.xcdy009, #作業序
       xcdy100 LIKE xcdy_t.xcdy100, #工單分攤數
       xcdy101 LIKE xcdy_t.xcdy101, #單位成本(本位幣一)
       xcdy111 LIKE xcdy_t.xcdy111, #單位成本(本位幣二)
       xcdy121 LIKE xcdy_t.xcdy121, #單位成本(本位幣三)
       xcdy202 LIKE xcdy_t.xcdy202, #分攤金額(本位幣一)
       xcdy212 LIKE xcdy_t.xcdy212, #分攤金額(本位幣二)
       xcdy222 LIKE xcdy_t.xcdy222  #分攤金額(本位幣三)
END RECORD
DEFINE l_xcdr RECORD  #工時費用成本次要素統計維護檔
       xcdrent LIKE xcdr_t.xcdrent, #企业编号
       xcdrcomp LIKE xcdr_t.xcdrcomp, #法人
       xcdrld LIKE xcdr_t.xcdrld, #账套
       xcdr001 LIKE xcdr_t.xcdr001, #成本计算类型
       xcdr002 LIKE xcdr_t.xcdr002, #年度
       xcdr003 LIKE xcdr_t.xcdr003, #期别
       xcdr004 LIKE xcdr_t.xcdr004, #成本中心
       xcdr005 LIKE xcdr_t.xcdr005, #费用分类(成本次要素)
       xcdr006 LIKE xcdr_t.xcdr006, #分摊方式
       xcdr010 LIKE xcdr_t.xcdr010, #制费类别
       xcdr011 LIKE xcdr_t.xcdr011, #会计科目
       xcdr020 LIKE xcdr_t.xcdr020, #分摊基础指标总数
       xcdr021 LIKE xcdr_t.xcdr021, #标准产能
       xcdr101 LIKE xcdr_t.xcdr101, #费用总额(本位币一)
       xcdr102 LIKE xcdr_t.xcdr102, #固定费用(本位币一)
       xcdr103 LIKE xcdr_t.xcdr103, #分摊金额(本位币一)
       xcdr104 LIKE xcdr_t.xcdr104, #闲置费用(本位币一)
       xcdr105 LIKE xcdr_t.xcdr105, #单位成本(本位币一)
       xcdr111 LIKE xcdr_t.xcdr111, #费用总额(本位币二)
       xcdr112 LIKE xcdr_t.xcdr112, #固定费用(本位币二)
       xcdr113 LIKE xcdr_t.xcdr113, #分摊金额(本位币二)
       xcdr114 LIKE xcdr_t.xcdr114, #闲置费用(本位币二)
       xcdr115 LIKE xcdr_t.xcdr115, #单位成本(本位币二)
       xcdr121 LIKE xcdr_t.xcdr121, #费用总额(本位币三)
       xcdr122 LIKE xcdr_t.xcdr122, #固定费用(本位币三)
       xcdr123 LIKE xcdr_t.xcdr123, #分摊金额(本位币三)
       xcdr124 LIKE xcdr_t.xcdr124, #闲置费用(本位币三)
       xcdr125 LIKE xcdr_t.xcdr125  #单位成本(本位币三)
END RECORD
   #161124-00048#21 add(e)
   DEFINE l_sum_xcdy202  LIKE xcdy_t.xcdy202
   DEFINE l_sum_xcdy212  LIKE xcdy_t.xcdy212
   DEFINE l_sum_xcdy222  LIKE xcdy_t.xcdy222
   DEFINE l_max_xcdy006  LIKE xcdy_t.xcdy006
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_curr         LIKE glaa_t.glaa001
   DEFINE l_max_amt      LIKE xcck_t.xcck202
   DEFINE l_max_xcbs008  LIKE xcbs_t.xcbs008
   DEFINE l_max_xcbs009  LIKE xcbs_t.xcbs009
   DEFINE l_max_xcdy008  LIKE xcdy_t.xcdy008
   DEFINE l_max_xcdy009  LIKE xcdy_t.xcdy009
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_ooef014      LIKE ooef_t.ooef014    #币别参照表号  
     
   
   CALL util.JSON.parse(ls_js,lc_param)
   
   INITIALIZE l_xcbs.* TO NULL
   INITIALIZE l_xcdy.* TO NULL
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #從wc中分別截取xcabsite，imaa001的查詢條件
   IF NOT cl_null(lc_param.wc) OR lc_param.wc != " 1=1" THEN 
      LET g_wc = lc_param.wc
      LET g_wc = cl_replace_str(g_wc,"and","||")
      LET tok = base.StringTokenizer.create(g_wc,"||")
      WHILE tok.hasMoreTokens()
         LET l_string = tok.nextToken()
         LET l_string = l_string.trim()
         IF l_string MATCHES '*xcbkcomp*' THEN
			LET g_wc_xcbscomp = l_string			
         END IF
         IF l_string MATCHES '*xcbkld*' THEN
            LET g_wc_xcbsld = l_string
         END IF
      END WHILE
   END IF   
   LET g_wc_xcbscomp = cl_replace_str(g_wc_xcbscomp,"xcbk","xcbs")
   LET g_wc_xcbsld = cl_replace_str(g_wc_xcbsld,"xcbk","xcbs")
   IF cl_null(g_wc_xcbscomp) THEN 
      LET g_wc_xcbscomp = "1=1"
   END IF
   
   IF cl_null(g_wc_xcbsld) THEN 
      LET g_wc_xcbsld = "1=1"
   END IF
 
   LET l_cnt = 0
   LET g_sql = "SELECT COUNT(*) FROM xcbs_t ",
               " WHERE xcbsent = '",g_enterprise,"'",
               "   AND xcbs001 = '",lc_param.xcbk001,"'",
               "   AND xcbs002 = '",lc_param.xcbk002,"'",
               "   AND xcbs003 = '",lc_param.xcbk003,"'",
               "   AND ",g_wc_xcbsld,
               "   AND ",g_wc_xcbscomp
   
   PREPARE axcp202_sel_xcbs_pre FROM g_sql 
   EXECUTE axcp202_sel_xcbs_pre INTO l_cnt 
         
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm('axc-00687') THEN   #是否更新 
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   
   #根据"账套"、"成本计算类型"、"成本年度"、"成本期别"删除“工单人工制费分摊金额明细档(xcbs_t)”的资料
   LET g_sql = "DELETE FROM xcbs_t ",
               " WHERE xcbsent = '",g_enterprise,"'",
               "   AND xcbs001 = '",lc_param.xcbk001,"'",
               "   AND xcbs002 = '",lc_param.xcbk002,"'",
               "   AND xcbs003 = '",lc_param.xcbk003,"'",
               "   AND ",g_wc_xcbsld,
               "   AND ",g_wc_xcbscomp
   
   PREPARE axcp202_del_xcbs_pre FROM g_sql 
   EXECUTE axcp202_del_xcbs_pre 

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN         #启用成本次要素
         CALL s_chr_replace(g_sql,'xcbs','xcdy',0) RETURNING g_sql
      END IF
      PREPARE axcp202_del_pb2 FROM g_sql 
      
      EXECUTE axcp202_del_pb2
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'DELETE xcdr FILE'
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   
   CALL cl_progress_no_window_ing("delete original file")
   
   LET g_wc_xcbsld = cl_replace_str(g_wc_xcbsld,"xcbsld","xcbjld")
   LET g_wc_xcbscomp = cl_replace_str(g_wc_xcbscomp,"xcbscomp","xcbjcomp")

#   LET g_sql = "SELECT * FROM xcbj_t ",  #161124-00048#21 mark
   #161124-00048#21 add(s)
   LET g_sql = "SELECT xcbjent,xcbjcomp,xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,", 
               "       xcbj006,xcbj010,xcbj011,xcbj020,xcbj021,xcbj101,xcbj102,xcbj103,",
               "       xcbj104,xcbj105,xcbj111,xcbj112,xcbj113,xcbj114,xcbj115,xcbj121,",
               "       xcbj122,xcbj123,xcbj124,xcbj125,xcbjownid,xcbjowndp,xcbjcrtid,  ",
               "       xcbjcrtdp,xcbjcrtdt,xcbjmodid,xcbjmoddt,xcbjstus FROM xcbj_t ", 
   #161124-00048#21 add(e)
               " WHERE xcbjent = '",g_enterprise,"'",
               "   AND xcbj001 = '",lc_param.xcbk001,"'",
               "   AND xcbj002 = '",lc_param.xcbk002,"'",
               "   AND xcbj003 = '",lc_param.xcbk003,"'", 
               "   AND ",g_wc_xcbsld,
               "   AND ",g_wc_xcbscomp
   PREPARE axcp202_xcbj_pre2 FROM g_sql
   DECLARE axcp202_xcbj_cur2 CURSOR FOR axcp202_xcbj_pre2

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN         #启用成本次要素
         CALL s_chr_replace(g_sql,'xcbj','xcdr',0) RETURNING g_sql
      END IF
      PREPARE axcp202_xcdr_pre2 FROM g_sql
      DECLARE axcp202_xcdr_cur2 CURSOR FOR axcp202_xcdr_pre2        
   END IF
   
   CALL cl_err_collect_init()
   LET l_flag = 'N'
   FOREACH axcp202_xcbj_cur2 INTO l_xcbj.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 

      CALL axcp202_date_chk(l_xcbj.xcbjcomp,lc_param.xcbk002,lc_param.xcbk003)
      IF NOT cl_null(g_errno) THEN
         LET g_errparam.extend = lc_param.xcbk002
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CONTINUE FOREACH                      
      END IF       
      
      LET l_max_amt = 0
      LET l_max_xcbs008 = ''
      LET l_max_xcbs009 = ''
      LET l_max_xcbs006 = NULL
      LET l_xcbs.xcbsent = g_enterprise
      LET l_xcbs.xcbsld = l_xcbj.xcbjld
      LET l_xcbs.xcbscomp = l_xcbj.xcbjcomp
      LET l_xcbs.xcbs001 = l_xcbj.xcbj001
      LET l_xcbs.xcbs002 = l_xcbj.xcbj002
      LET l_xcbs.xcbs003 = l_xcbj.xcbj003
      LET l_xcbs.xcbs004 = l_xcbj.xcbj004
      LET l_xcbs.xcbs005 = l_xcbj.xcbj005
      LET l_xcbs.xcbs007 = l_xcbj.xcbj006
      LET l_xcbs.xcbs101 = l_xcbj.xcbj105
      LET l_xcbs.xcbs111 = l_xcbj.xcbj115
      LET l_xcbs.xcbs121 = l_xcbj.xcbj125
      
      #LET l_xcbs.xcbsownid = g_user
      #LET l_xcbs.xcbsowndp = g_dept
      #LET l_xcbs.xcbscrtid = g_user
      #LET l_xcbs.xcbscrtdp = g_dept 
      #LET l_xcbs.xcbscrtdt = cl_get_current()
      #LET l_xcbs.xcbsmodid = ""
      #LET l_xcbs.xcbsmoddt = ""

      #實際工時
      IF l_xcbj.xcbj006 = '1' THEN 
         LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr201) ",     #170221-00036#1 add NVL
                     "  FROM xcbq_t,xcbr_t ",
                     " WHERE xcbrent = '",g_enterprise,"'",
                     "   AND xcbrent = xcbqent ",
                     "   AND xcbrdocno = xcbqdocno ",
                     "   AND xcbqstus = 'Y' ",       
                     "   AND xcbqcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbr001  = '",l_xcbj.xcbj004,"'",   
                     "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbr002,xcbr003,xcbr004 ",
                     " ORDER BY xcbr002,xcbr003,xcbr004 "
         PREPARE xcbr_pre_1 FROM g_sql
         DECLARE xcbr_cur_1 CURSOR FOR xcbr_pre_1
         FOREACH xcbr_cur_1 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr201
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbs.xcbs006 = l_xcbr002
		   	LET l_xcbs.xcbs008 = l_xcbr003
			   LET l_xcbs.xcbs009 = l_xcbr004
            LET l_xcbs.xcbs100 = l_sum_xcbr201
            LET l_xcbs.xcbs202 = l_xcbs.xcbs100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbs.xcbs212 = l_xcbs.xcbs100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbs.xcbs222 = l_xcbs.xcbs100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbs.xcbs100) THEN LET l_xcbs.xcbs100 = 0 END IF   

            IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
            IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
            IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

            IF cl_null(l_xcbs.xcbs202) THEN LET l_xcbs.xcbs202 = 0 END IF   
            IF cl_null(l_xcbs.xcbs212) THEN LET l_xcbs.xcbs212 = 0 END IF
            IF cl_null(l_xcbs.xcbs222) THEN LET l_xcbs.xcbs222 = 0 END IF
         
            CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbs.xcbs100 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs100,'1')
               LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')    
               LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')    
               LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')    
               LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs202,'2') 
               LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs212,'2') 
               LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF
#            INSERT INTO xcbs_t VALUES(l_xcbs.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbs_t(xcbsent,xcbsld,xcbscomp,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,
                               xcbs006,xcbs007,xcbs008,xcbs009,xcbs100,xcbs101,xcbs111,xcbs121,
                               xcbs202,xcbs212,xcbs222) 
                        VALUES(l_xcbs.xcbsent,l_xcbs.xcbsld,l_xcbs.xcbscomp,l_xcbs.xcbs001,l_xcbs.xcbs002,l_xcbs.xcbs003,l_xcbs.xcbs004,l_xcbs.xcbs005,
                               l_xcbs.xcbs006,l_xcbs.xcbs007,l_xcbs.xcbs008,l_xcbs.xcbs009,l_xcbs.xcbs100,l_xcbs.xcbs101,l_xcbs.xcbs111,l_xcbs.xcbs121,
                               l_xcbs.xcbs202,l_xcbs.xcbs212,l_xcbs.xcbs222)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbs"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbs006 = l_xcbs.xcbs006
            IF l_xcbs.xcbs202 > l_max_amt THEN 
               LET l_max_amt = l_xcbs.xcbs202
               LET l_max_xcbs008 = l_xcbs.xcbs008
               LET l_max_xcbs009 = l_xcbs.xcbs009
            END IF
         END FOREACH 
      END IF
      
      #標準工時
      IF l_xcbj.xcbj006 = '2' THEN 
         LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr203) ",  #170221-00036#1 add NVL
                     "  FROM xcbq_t,xcbr_t ",
                     " WHERE xcbrent = '",g_enterprise,"'",
                     "   AND xcbrent = xcbqent ",
                     "   AND xcbrdocno = xcbqdocno ",
                     "   AND xcbqstus = 'Y' ",       
                     "   AND xcbqcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbr001  = '",l_xcbj.xcbj004,"'",   
                     "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbr002,xcbr003,xcbr004 ",
                     " ORDER BY xcbr002,xcbr003,xcbr004 "
         PREPARE xcbr_pre_2 FROM g_sql
         DECLARE xcbr_cur_2 CURSOR FOR xcbr_pre_2
         FOREACH xcbr_cur_2 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr203
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbs.xcbs006 = l_xcbr002
			   LET l_xcbs.xcbs008 = l_xcbr003
			   LET l_xcbs.xcbs009 = l_xcbr004
            LET l_xcbs.xcbs100 = l_sum_xcbr203
            LET l_xcbs.xcbs202 = l_xcbs.xcbs100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbs.xcbs212 = l_xcbs.xcbs100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbs.xcbs222 = l_xcbs.xcbs100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbs.xcbs100) THEN LET l_xcbs.xcbs100 = 0 END IF  

            IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
            IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
            IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

            IF cl_null(l_xcbs.xcbs202) THEN LET l_xcbs.xcbs202 = 0 END IF   
            IF cl_null(l_xcbs.xcbs212) THEN LET l_xcbs.xcbs212 = 0 END IF
            IF cl_null(l_xcbs.xcbs222) THEN LET l_xcbs.xcbs222 = 0 END IF

            CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbs.xcbs100 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs100,'1')
               LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')     
               LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')    
               LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')            
               LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs202,'2') 
               LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs212,'2') 
               LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbs_t VALUES(l_xcbs.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbs_t(xcbsent,xcbsld,xcbscomp,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,
                               xcbs006,xcbs007,xcbs008,xcbs009,xcbs100,xcbs101,xcbs111,xcbs121,
                               xcbs202,xcbs212,xcbs222) 
                        VALUES(l_xcbs.xcbsent,l_xcbs.xcbsld,l_xcbs.xcbscomp,l_xcbs.xcbs001,l_xcbs.xcbs002,l_xcbs.xcbs003,l_xcbs.xcbs004,l_xcbs.xcbs005,
                               l_xcbs.xcbs006,l_xcbs.xcbs007,l_xcbs.xcbs008,l_xcbs.xcbs009,l_xcbs.xcbs100,l_xcbs.xcbs101,l_xcbs.xcbs111,l_xcbs.xcbs121,
                               l_xcbs.xcbs202,l_xcbs.xcbs212,l_xcbs.xcbs222)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbs"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbs006 = l_xcbs.xcbs006
            IF l_xcbs.xcbs202 > l_max_amt THEN 
               LET l_max_amt = l_xcbs.xcbs202
               LET l_max_xcbs008 = l_xcbs.xcbs008
               LET l_max_xcbs009 = l_xcbs.xcbs009
            END IF
         END FOREACH 
      END IF
      
      #標準機時
      IF l_xcbj.xcbj006 = '3' THEN 
         LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr204) ",   #170221-00036#1 add NVL
                     "  FROM xcbq_t,xcbr_t ",
                     " WHERE xcbrent = '",g_enterprise,"'",
                     "   AND xcbrent = xcbqent ",
                     "   AND xcbrdocno = xcbqdocno ",
                     "   AND xcbqstus = 'Y' ",        
                     "   AND xcbqcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbr001  = '",l_xcbj.xcbj004,"'",   
                     "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbr002,xcbr003,xcbr004 ",
                     " ORDER BY xcbr002,xcbr003,xcbr004 "
         PREPARE xcbr_pre_3 FROM g_sql
         DECLARE xcbr_cur_3 CURSOR FOR xcbr_pre_3
         FOREACH xcbr_cur_3 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr204
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbs.xcbs006 = l_xcbr002
			   LET l_xcbs.xcbs008 = l_xcbr003
			   LET l_xcbs.xcbs009 = l_xcbr004
            LET l_xcbs.xcbs100 = l_sum_xcbr204
            LET l_xcbs.xcbs202 = l_xcbs.xcbs100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbs.xcbs212 = l_xcbs.xcbs100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbs.xcbs222 = l_xcbs.xcbs100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbs.xcbs100) THEN LET l_xcbs.xcbs100 = 0 END IF  

            IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
            IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
            IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

            IF cl_null(l_xcbs.xcbs202) THEN LET l_xcbs.xcbs202 = 0 END IF   
            IF cl_null(l_xcbs.xcbs212) THEN LET l_xcbs.xcbs212 = 0 END IF
            IF cl_null(l_xcbs.xcbs222) THEN LET l_xcbs.xcbs222 = 0 END IF

            CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbs.xcbs100 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs100,'1')
               LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')    
               LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')    
               LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')          
               LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs202,'2') 
               LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs212,'2') 
               LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbs_t VALUES(l_xcbs.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbs_t(xcbsent,xcbsld,xcbscomp,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,
                               xcbs006,xcbs007,xcbs008,xcbs009,xcbs100,xcbs101,xcbs111,xcbs121,
                               xcbs202,xcbs212,xcbs222) 
                        VALUES(l_xcbs.xcbsent,l_xcbs.xcbsld,l_xcbs.xcbscomp,l_xcbs.xcbs001,l_xcbs.xcbs002,l_xcbs.xcbs003,l_xcbs.xcbs004,l_xcbs.xcbs005,
                               l_xcbs.xcbs006,l_xcbs.xcbs007,l_xcbs.xcbs008,l_xcbs.xcbs009,l_xcbs.xcbs100,l_xcbs.xcbs101,l_xcbs.xcbs111,l_xcbs.xcbs121,
                               l_xcbs.xcbs202,l_xcbs.xcbs212,l_xcbs.xcbs222)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbs"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbs006 = l_xcbs.xcbs006
            IF l_xcbs.xcbs202 > l_max_amt THEN 
               LET l_max_amt = l_xcbs.xcbs202
               LET l_max_xcbs008 = l_xcbs.xcbs008
               LET l_max_xcbs009 = l_xcbs.xcbs009
            END IF
         END FOREACH 
      END IF
      
      #產出數量*分攤權屬
      IF l_xcbj.xcbj006 = '4' THEN 
         LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr104) ",   #170221-00036#1 add NVL
                     "  FROM xcbq_t,xcbr_t ",
                     " WHERE xcbrent = '",g_enterprise,"'",
                     "   AND xcbrent = xcbqent ",
                     "   AND xcbrdocno = xcbqdocno ",
                     "   AND xcbqstus = 'Y' ",       
                     "   AND xcbqcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbr001  = '",l_xcbj.xcbj004,"'",   
                     "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbr002,xcbr003,xcbr004 ",
                     " ORDER BY xcbr002,xcbr003,xcbr004 "
         PREPARE xcbr_pre_4 FROM g_sql
         DECLARE xcbr_cur_4 CURSOR FOR xcbr_pre_4
         FOREACH xcbr_cur_4 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr104 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbs.xcbs006 = l_xcbr002
			   LET l_xcbs.xcbs008 = l_xcbr003
			   LET l_xcbs.xcbs009 = l_xcbr004
            LET l_xcbs.xcbs100 = l_sum_xcbr104 * 1   #SUM(报工数量(xcbr104)*分摊权数(目前没有维护作业和档案，值给‘1’))
            LET l_xcbs.xcbs202 = l_xcbs.xcbs100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbs.xcbs212 = l_xcbs.xcbs100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbs.xcbs222 = l_xcbs.xcbs100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbs.xcbs100) THEN LET l_xcbs.xcbs100 = 0 END IF   #151116 Sarah add

            IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
            IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
            IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

            IF cl_null(l_xcbs.xcbs202) THEN LET l_xcbs.xcbs202 = 0 END IF   
            IF cl_null(l_xcbs.xcbs212) THEN LET l_xcbs.xcbs212 = 0 END IF
            IF cl_null(l_xcbs.xcbs222) THEN LET l_xcbs.xcbs222 = 0 END IF

            CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbs.xcbs100 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs100,'1')
               LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')     
               LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')   
               LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')  
               LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs202,'2') 
               LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs212,'2') 
               LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbs_t VALUES(l_xcbs.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbs_t(xcbsent,xcbsld,xcbscomp,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,
                               xcbs006,xcbs007,xcbs008,xcbs009,xcbs100,xcbs101,xcbs111,xcbs121,
                               xcbs202,xcbs212,xcbs222) 
                        VALUES(l_xcbs.xcbsent,l_xcbs.xcbsld,l_xcbs.xcbscomp,l_xcbs.xcbs001,l_xcbs.xcbs002,l_xcbs.xcbs003,l_xcbs.xcbs004,l_xcbs.xcbs005,
                               l_xcbs.xcbs006,l_xcbs.xcbs007,l_xcbs.xcbs008,l_xcbs.xcbs009,l_xcbs.xcbs100,l_xcbs.xcbs101,l_xcbs.xcbs111,l_xcbs.xcbs121,
                               l_xcbs.xcbs202,l_xcbs.xcbs212,l_xcbs.xcbs222)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbs"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbs006 = l_xcbs.xcbs006
            IF l_xcbs.xcbs202 > l_max_amt THEN 
               LET l_max_amt = l_xcbs.xcbs202
               LET l_max_xcbs008 = l_xcbs.xcbs008
               LET l_max_xcbs009 = l_xcbs.xcbs009
            END IF
         END FOREACH 
      END IF
      
      #實際機時
      IF l_xcbj.xcbj006 = '5' THEN 
         LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr202) ",   #170221-00036#1 add NVL
                     "  FROM xcbq_t,xcbr_t ",
                     " WHERE xcbrent = '",g_enterprise,"'",
                     "   AND xcbrent = xcbqent ",
                     "   AND xcbrdocno = xcbqdocno ",
                     "   AND xcbqstus = 'Y' ",       
                     "   AND xcbqcomp = '",l_xcbj.xcbjcomp,"'",
                     "   AND xcbr001  = '",l_xcbj.xcbj004,"'",  
                     "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                     "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                     " GROUP BY xcbr002,xcbr003,xcbr004 ",
                     " ORDER BY xcbr002,xcbr003,xcbr004 "
         PREPARE xcbr_pre_5 FROM g_sql
         DECLARE xcbr_cur_5 CURSOR FOR xcbr_pre_5
         FOREACH xcbr_cur_5 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr202
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF 
            
            LET l_xcbs.xcbs006 = l_xcbr002
			   LET l_xcbs.xcbs008 = l_xcbr003
			   LET l_xcbs.xcbs009 = l_xcbr004
            LET l_xcbs.xcbs100 = l_sum_xcbr202
            LET l_xcbs.xcbs202 = l_xcbs.xcbs100 * (l_xcbj.xcbj103 / l_xcbj.xcbj020)    
            LET l_xcbs.xcbs212 = l_xcbs.xcbs100 * (l_xcbj.xcbj113 / l_xcbj.xcbj020)
            LET l_xcbs.xcbs222 = l_xcbs.xcbs100 * (l_xcbj.xcbj123 / l_xcbj.xcbj020)
            IF cl_null(l_xcbs.xcbs100) THEN LET l_xcbs.xcbs100 = 0 END IF  

            IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
            IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
            IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

            IF cl_null(l_xcbs.xcbs202) THEN LET l_xcbs.xcbs202 = 0 END IF   
            IF cl_null(l_xcbs.xcbs212) THEN LET l_xcbs.xcbs212 = 0 END IF
            IF cl_null(l_xcbs.xcbs222) THEN LET l_xcbs.xcbs222 = 0 END IF
          
            CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcbs.xcbs100 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs100,'1')
               LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')     
               LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')     
               LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')                 
               LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs202,'2') 
               LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs212,'2') 
               LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs222,'2') 
            ELSE
               CONTINUE FOREACH
            END IF

#            INSERT INTO xcbs_t VALUES(l_xcbs.*)  #161124-00048#21 mark
            #161124-00048#21 add(s)
            INSERT INTO xcbs_t(xcbsent,xcbsld,xcbscomp,xcbs001,xcbs002,xcbs003,xcbs004,xcbs005,
                               xcbs006,xcbs007,xcbs008,xcbs009,xcbs100,xcbs101,xcbs111,xcbs121,
                               xcbs202,xcbs212,xcbs222) 
                        VALUES(l_xcbs.xcbsent,l_xcbs.xcbsld,l_xcbs.xcbscomp,l_xcbs.xcbs001,l_xcbs.xcbs002,l_xcbs.xcbs003,l_xcbs.xcbs004,l_xcbs.xcbs005,
                               l_xcbs.xcbs006,l_xcbs.xcbs007,l_xcbs.xcbs008,l_xcbs.xcbs009,l_xcbs.xcbs100,l_xcbs.xcbs101,l_xcbs.xcbs111,l_xcbs.xcbs121,
                               l_xcbs.xcbs202,l_xcbs.xcbs212,l_xcbs.xcbs222)
            #161124-00048#21 add(e)
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "l_xcbs"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
            #170217-00025#7 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#7 add-E
            LET l_flag = 'Y'
            LET l_max_xcbs006 = l_xcbs.xcbs006
            IF l_xcbs.xcbs202 > l_max_amt THEN 
               LET l_max_amt = l_xcbs.xcbs202
               LET l_max_xcbs008 = l_xcbs.xcbs008
               LET l_max_xcbs009 = l_xcbs.xcbs009
            END IF
         END FOREACH 
      END IF
      
#处理尾差，按工单排序，最后一笔加上前端xcbj分摊总金额-本次各笔分摊金额合计的差异 
#尾差处理的范围是同一分摊方式不同工单
      IF l_xcbs.xcbs006 IS NOT NULL THEN   #没有工单，说明前面没有抓到xcbr资料，不该有尾差调整
         LET l_sum_xcbs202 = 0
         LET l_sum_xcbs212 = 0
         LET l_sum_xcbs222 = 0
         SELECT SUM(xcbs202),SUM(xcbs212),SUM(xcbs222) INTO l_sum_xcbs202,l_sum_xcbs212,l_sum_xcbs222
           FROM xcbs_t
          WHERE xcbsent = g_enterprise
            AND xcbsld  = l_xcbj.xcbjld
            AND xcbs001 = l_xcbj.xcbj001
            AND xcbs002 = l_xcbj.xcbj002
            AND xcbs003 = l_xcbj.xcbj003
            AND xcbs004 = l_xcbj.xcbj004
            AND xcbs005 = l_xcbj.xcbj005
            AND xcbs007 = l_xcbj.xcbj006

         IF cl_null(l_xcbs.xcbs101) THEN LET l_xcbs.xcbs101 = 0 END IF   
         IF cl_null(l_xcbs.xcbs111) THEN LET l_xcbs.xcbs111 = 0 END IF
         IF cl_null(l_xcbs.xcbs121) THEN LET l_xcbs.xcbs121 = 0 END IF

         IF cl_null(l_sum_xcbs202) THEN LET l_sum_xcbs202 = 0 END IF   
         IF cl_null(l_sum_xcbs212) THEN LET l_sum_xcbs212 = 0 END IF   
         IF cl_null(l_sum_xcbs222) THEN LET l_sum_xcbs222 = 0 END IF  

         IF cl_null(l_xcbj.xcbj103) THEN   LET l_xcbj.xcbj103 = 0 END IF 
         IF cl_null(l_xcbj.xcbj113) THEN   LET l_xcbj.xcbj113 = 0 END IF 
         IF cl_null(l_xcbj.xcbj123) THEN   LET l_xcbj.xcbj123 = 0 END IF           
      
         CALL s_ld_sel_glaa(l_xcbs.xcbsld,'glaa001') RETURNING l_success,l_curr
         IF l_success THEN
            LET l_xcbs.xcbs101 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs101,'1')   
            LET l_xcbs.xcbs111 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs111,'1')    
            LET l_xcbs.xcbs121 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbs.xcbs121,'1')            
            LET l_xcbs.xcbs202 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_sum_xcbs202,'2') 
            LET l_xcbs.xcbs212 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_sum_xcbs212,'2') 
            LET l_xcbs.xcbs222 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_sum_xcbs222,'2')
            LET l_xcbj.xcbj103 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbj.xcbj103,'2') 
            LET l_xcbj.xcbj113 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbj.xcbj113,'2') 
            LET l_xcbj.xcbj123 = s_curr_round(l_xcbs.xcbscomp,l_curr,l_xcbj.xcbj123,'2')            
         ELSE
            CONTINUE FOREACH
         END IF
         
         IF l_sum_xcbs202 IS NULL THEN LET l_sum_xcbs202 = 0 END IF
         IF l_sum_xcbs212 IS NULL THEN LET l_sum_xcbs212 = 0 END IF
         IF l_sum_xcbs222 IS NULL THEN LET l_sum_xcbs222 = 0 END IF
         
         UPDATE xcbs_t SET xcbs202 = xcbs202 + l_xcbj.xcbj103 - l_sum_xcbs202,
                           xcbs212 = xcbs212 + l_xcbj.xcbj113 - l_sum_xcbs212,
                           xcbs222 = xcbs222 + l_xcbj.xcbj123 - l_sum_xcbs222
          WHERE xcbsent = g_enterprise
            AND xcbsld  = l_xcbj.xcbjld
            AND xcbs001 = l_xcbj.xcbj001
            AND xcbs002 = l_xcbj.xcbj002
            AND xcbs003 = l_xcbj.xcbj003
            AND xcbs004 = l_xcbj.xcbj004
            AND xcbs005 = l_xcbj.xcbj005
            AND xcbs007 = l_xcbj.xcbj006
            AND xcbs008 = l_max_xcbs008
            AND xcbs009 = l_max_xcbs009
            AND xcbs202 = l_max_amt
            AND rownum  = 1
      END IF
#处理尾差结束
   END FOREACH 
   IF l_flag = 'N' THEN                    
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00787'    
      LET g_errparam.extend = "xcbs_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   CALL cl_progress_no_window_ing("ins xcbs")
 
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素 
      LET l_flag = 'N'   
      FOREACH axcp202_xcdr_cur2 INTO l_xcdr.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
   
            EXIT FOREACH
         END IF 
         
         LET l_max_amt = 0
         LET l_max_xcdy008 = ''
         LET l_max_xcdy009 = ''
         LET l_max_xcdy006 = NULL
         LET l_xcdy.xcdyent = g_enterprise
         LET l_xcdy.xcdyld = l_xcdr.xcdrld
         LET l_xcdy.xcdycomp = l_xcdr.xcdrcomp
         LET l_xcdy.xcdy001 = l_xcdr.xcdr001
         LET l_xcdy.xcdy002 = l_xcdr.xcdr002
         LET l_xcdy.xcdy003 = l_xcdr.xcdr003
         LET l_xcdy.xcdy004 = l_xcdr.xcdr004
         LET l_xcdy.xcdy005 = l_xcdr.xcdr005
         LET l_xcdy.xcdy007 = l_xcdr.xcdr006
         LET l_xcdy.xcdy101 = l_xcdr.xcdr105
         LET l_xcdy.xcdy111 = l_xcdr.xcdr115
         LET l_xcdy.xcdy121 = l_xcdr.xcdr125
         
         #LET l_xcdy.xcdyownid = g_user
         #LET l_xcdy.xcdyowndp = g_dept
         #LET l_xcdy.xcdycrtid = g_user
         #LET l_xcdy.xcdycrtdp = g_dept 
         #LET l_xcdy.xcdycrtdt = cl_get_current()
         #LET l_xcdy.xcdymodid = ""
         #LET l_xcdy.xcdymoddt = ""
   
         
         #實際工時
         IF l_xcdr.xcdr006 = '1' THEN 
            LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr201) ",   #170221-00036#1 add NVL
                        "  FROM xcbq_t,xcbr_t ",
                        " WHERE xcbrent = '",g_enterprise,"'",
                        "   AND xcbrent = xcbqent ",
                        "   AND xcbrdocno = xcbqdocno ",
                        "   AND xcbqstus = 'Y' ",       
                        "   AND xcbqcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbr001  = '",l_xcdr.xcdr004,"'",   
                        "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbr002,xcbr003,xcbr004 ",
                        " ORDER BY xcbr002,xcbr003,xcbr004 "
            PREPARE xcbr_pre_11 FROM g_sql
            DECLARE xcbr_cur_11 CURSOR FOR xcbr_pre_11
            FOREACH xcbr_cur_11 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr201
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdy.xcdy006 = l_xcbr002
               LET l_xcdy.xcdy008 = l_xcbr003
			      LET l_xcdy.xcdy009 = l_xcbr004
               LET l_xcdy.xcdy100 = l_sum_xcbr201
               LET l_xcdy.xcdy202 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy212 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy222 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdy.xcdy100) THEN   LET l_xcdy.xcdy100 = 0 END IF   

               IF cl_null(l_xcdy.xcdy202) THEN   LET l_xcdy.xcdy202 = 0 END IF 
               IF cl_null(l_xcdy.xcdy212) THEN   LET l_xcdy.xcdy212 = 0 END IF 
               IF cl_null(l_xcdy.xcdy222) THEN   LET l_xcdy.xcdy222 = 0 END IF

               CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdy.xcdy100 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy100,'1')
                  LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy202,'2') 
                  LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy212,'2') 
                  LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdy_t VALUES(l_xcdy.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdy_t(xcdyent,xcdyld,xcdycomp,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,
                                  xcdy006,xcdy007,xcdy008,xcdy009,xcdy100,xcdy101,xcdy111,xcdy121,
                                  xcdy202,xcdy212,xcdy222) 
                           VALUES(l_xcdy.xcdyent,l_xcdy.xcdyld,l_xcdy.xcdycomp,l_xcdy.xcdy001,l_xcdy.xcdy002,l_xcdy.xcdy003,l_xcdy.xcdy004,l_xcdy.xcdy005,
                                  l_xcdy.xcdy006,l_xcdy.xcdy007,l_xcdy.xcdy008,l_xcdy.xcdy009,l_xcdy.xcdy100,l_xcdy.xcdy101,l_xcdy.xcdy111,l_xcdy.xcdy121,
                                  l_xcdy.xcdy202,l_xcdy.xcdy212,l_xcdy.xcdy222)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdy"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdy006 = l_xcdy.xcdy006
               IF l_xcdy.xcdy202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdy.xcdy202
                  LET l_max_xcdy008 = l_xcdy.xcdy008
                  LET l_max_xcdy009 = l_xcdy.xcdy009
               END IF
            END FOREACH 
         END IF
         
         #標準工時
         IF l_xcdr.xcdr006 = '2' THEN 
            LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr203) ",   #170221-00036#1 add NVL
                        "  FROM xcbq_t,xcbr_t ",
                        " WHERE xcbrent = '",g_enterprise,"'",
                        "   AND xcbrent = xcbqent ",
                        "   AND xcbrdocno = xcbqdocno ",
                        "   AND xcbqstus = 'Y' ",        
                        "   AND xcbqcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbr001  = '",l_xcdr.xcdr004,"'",  
                        "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbr002,xcbr003,xcbr004 ",
                        " ORDER BY xcbr002,xcbr003,xcbr004 "
            PREPARE xcbr_pre_21 FROM g_sql
            DECLARE xcbr_cur_21 CURSOR FOR xcbr_pre_21
            FOREACH xcbr_cur_21 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr203
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdy.xcdy006 = l_xcbr002
               LET l_xcdy.xcdy008 = l_xcbr003
			      LET l_xcdy.xcdy009 = l_xcbr004
               LET l_xcdy.xcdy100 = l_sum_xcbr203
               LET l_xcdy.xcdy202 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy212 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy222 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdy.xcdy100) THEN   LET l_xcdy.xcdy100 = 0 END IF   

               IF cl_null(l_xcdy.xcdy202) THEN   LET l_xcdy.xcdy202 = 0 END IF 
               IF cl_null(l_xcdy.xcdy212) THEN   LET l_xcdy.xcdy212 = 0 END IF 
               IF cl_null(l_xcdy.xcdy222) THEN   LET l_xcdy.xcdy222 = 0 END IF

               CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdy.xcdy100 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy100,'1')
                  LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy202,'2') 
                  LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy212,'2') 
                  LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdy_t VALUES(l_xcdy.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdy_t(xcdyent,xcdyld,xcdycomp,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,
                                  xcdy006,xcdy007,xcdy008,xcdy009,xcdy100,xcdy101,xcdy111,xcdy121,
                                  xcdy202,xcdy212,xcdy222) 
                           VALUES(l_xcdy.xcdyent,l_xcdy.xcdyld,l_xcdy.xcdycomp,l_xcdy.xcdy001,l_xcdy.xcdy002,l_xcdy.xcdy003,l_xcdy.xcdy004,l_xcdy.xcdy005,
                                  l_xcdy.xcdy006,l_xcdy.xcdy007,l_xcdy.xcdy008,l_xcdy.xcdy009,l_xcdy.xcdy100,l_xcdy.xcdy101,l_xcdy.xcdy111,l_xcdy.xcdy121,
                                  l_xcdy.xcdy202,l_xcdy.xcdy212,l_xcdy.xcdy222)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdy"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdy006 = l_xcdy.xcdy006
               IF l_xcdy.xcdy202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdy.xcdy202
                  LET l_max_xcdy008 = l_xcdy.xcdy008
                  LET l_max_xcdy009 = l_xcdy.xcdy009
               END IF
            END FOREACH 
         END IF
         
         #標準機時
         IF l_xcdr.xcdr006 = '3' THEN 
            LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr204) ",   #170221-00036#1 add NVL
                        "  FROM xcbq_t,xcbr_t ",
                        " WHERE xcbrent = '",g_enterprise,"'",
                        "   AND xcbrent = xcbqent ",
                        "   AND xcbrdocno = xcbqdocno ",
                        "   AND xcbqstus = 'Y' ",        
                        "   AND xcbqcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbr001  = '",l_xcdr.xcdr004,"'",  
                        "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbr002,xcbr003,xcbr004 ",
                        " ORDER BY xcbr002,xcbr003,xcbr004 "
            PREPARE xcbr_pre_31 FROM g_sql
            DECLARE xcbr_cur_31 CURSOR FOR xcbr_pre_31
            FOREACH xcbr_cur_31 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr204
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdy.xcdy006 = l_xcbr002
               LET l_xcdy.xcdy008 = l_xcbr003
			      LET l_xcdy.xcdy009 = l_xcbr004
               LET l_xcdy.xcdy100 = l_sum_xcbr204
               LET l_xcdy.xcdy202 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy212 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy222 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdy.xcdy100) THEN   LET l_xcdy.xcdy100 = 0 END IF  

               IF cl_null(l_xcdy.xcdy202) THEN   LET l_xcdy.xcdy202 = 0 END IF 
               IF cl_null(l_xcdy.xcdy212) THEN   LET l_xcdy.xcdy212 = 0 END IF 
               IF cl_null(l_xcdy.xcdy222) THEN   LET l_xcdy.xcdy222 = 0 END IF

               CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdy.xcdy100 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy100,'1')
                  LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy202,'2') 
                  LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy212,'2') 
                  LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdy_t VALUES(l_xcdy.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdy_t(xcdyent,xcdyld,xcdycomp,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,
                                  xcdy006,xcdy007,xcdy008,xcdy009,xcdy100,xcdy101,xcdy111,xcdy121,
                                  xcdy202,xcdy212,xcdy222) 
                           VALUES(l_xcdy.xcdyent,l_xcdy.xcdyld,l_xcdy.xcdycomp,l_xcdy.xcdy001,l_xcdy.xcdy002,l_xcdy.xcdy003,l_xcdy.xcdy004,l_xcdy.xcdy005,
                                  l_xcdy.xcdy006,l_xcdy.xcdy007,l_xcdy.xcdy008,l_xcdy.xcdy009,l_xcdy.xcdy100,l_xcdy.xcdy101,l_xcdy.xcdy111,l_xcdy.xcdy121,
                                  l_xcdy.xcdy202,l_xcdy.xcdy212,l_xcdy.xcdy222)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdy"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdy006 = l_xcdy.xcdy006
               IF l_xcdy.xcdy202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdy.xcdy202
                  LET l_max_xcdy008 = l_xcdy.xcdy008
                  LET l_max_xcdy009 = l_xcdy.xcdy009
               END IF
            END FOREACH 
         END IF
         
         #產出數量*分攤權屬
         IF l_xcdr.xcdr006 = '4' THEN 
            LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr104) ",   #170221-00036#1 add NVL
                        "  FROM xcbq_t,xcbr_t ",
                        " WHERE xcbrent = '",g_enterprise,"'",
                        "   AND xcbrent = xcbqent ",
                        "   AND xcbrdocno = xcbqdocno ",
                        "   AND xcbqstus = 'Y' ",       
                        "   AND xcbqcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbr001  = '",l_xcdr.xcdr004,"'",  
                        "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbr002,xcbr003,xcbr004 ",
                        " ORDER BY xcbr002,xcbr003,xcbr004 "
            PREPARE xcbr_pre_41 FROM g_sql
            DECLARE xcbr_cur_41 CURSOR FOR xcbr_pre_41
            FOREACH xcbr_cur_41 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr104
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdy.xcdy006 = l_xcbr002
               LET l_xcdy.xcdy008 = l_xcbr003
			      LET l_xcdy.xcdy009 = l_xcbr004
               LET l_xcdy.xcdy100 = l_sum_xcbr104 * 1   #SUM(报工数量(xcbr104)*分摊权数(目前没有维护作业和档案，值给‘1’))
               LET l_xcdy.xcdy202 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy212 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy222 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdy.xcdy100) THEN   LET l_xcdy.xcdy100 = 0 END IF   #151116 Sarah add

               IF cl_null(l_xcdy.xcdy202) THEN   LET l_xcdy.xcdy202 = 0 END IF 
               IF cl_null(l_xcdy.xcdy212) THEN   LET l_xcdy.xcdy212 = 0 END IF 
               IF cl_null(l_xcdy.xcdy222) THEN   LET l_xcdy.xcdy222 = 0 END IF

               CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdy.xcdy100 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy100,'1')
                  LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy202,'2') 
                  LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy212,'2') 
                  LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdy_t VALUES(l_xcdy.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdy_t(xcdyent,xcdyld,xcdycomp,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,
                                  xcdy006,xcdy007,xcdy008,xcdy009,xcdy100,xcdy101,xcdy111,xcdy121,
                                  xcdy202,xcdy212,xcdy222) 
                           VALUES(l_xcdy.xcdyent,l_xcdy.xcdyld,l_xcdy.xcdycomp,l_xcdy.xcdy001,l_xcdy.xcdy002,l_xcdy.xcdy003,l_xcdy.xcdy004,l_xcdy.xcdy005,
                                  l_xcdy.xcdy006,l_xcdy.xcdy007,l_xcdy.xcdy008,l_xcdy.xcdy009,l_xcdy.xcdy100,l_xcdy.xcdy101,l_xcdy.xcdy111,l_xcdy.xcdy121,
                                  l_xcdy.xcdy202,l_xcdy.xcdy212,l_xcdy.xcdy222)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdy"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdy006 = l_xcdy.xcdy006
               IF l_xcdy.xcdy202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdy.xcdy202
                  LET l_max_xcdy008 = l_xcdy.xcdy008
                  LET l_max_xcdy009 = l_xcdy.xcdy009
               END IF
            END FOREACH 
         END IF
         
         #實際機時
         IF l_xcdr.xcdr006 = '5' THEN 
            LET g_sql = "SELECT NVl(xcbr002,' '),NVL(xcbr003,' '),NVL(xcbr004,' '),SUM(xcbr202) ",   #170221-00036#1 add NVL
                        "  FROM xcbq_t,xcbr_t ",
                        " WHERE xcbrent = '",g_enterprise,"'",
                        "   AND xcbrent = xcbqent ",
                        "   AND xcbrdocno = xcbqdocno ",
                        "   AND xcbqstus = 'Y' ",        
                        "   AND xcbqcomp = '",l_xcdr.xcdrcomp,"'",
                        "   AND xcbr001  = '",l_xcdr.xcdr004,"'",   
                        "   AND TO_CHAR(xcbq001,'YYYY') = ",lc_param.xcbk002,
                        "   AND TO_CHAR(xcbq001,'MM') = ",lc_param.xcbk003,
                        " GROUP BY xcbr002,xcbr003,xcbr004 ",
                        " ORDER BY xcbr002,xcbr003,xcbr004 "
            PREPARE xcbr_pre_51 FROM g_sql
            DECLARE xcbr_cur_51 CURSOR FOR xcbr_pre_51
            FOREACH xcbr_cur_51 INTO l_xcbr002,l_xcbr003,l_xcbr004,l_sum_xcbr202
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  EXIT FOREACH
               END IF 
               
               LET l_xcdy.xcdy006 = l_xcbr002
               LET l_xcdy.xcdy008 = l_xcbr003
			      LET l_xcdy.xcdy009 = l_xcbr004
               LET l_xcdy.xcdy100 = l_sum_xcbr202
               LET l_xcdy.xcdy202 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy212 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               LET l_xcdy.xcdy222 = l_xcdy.xcdy100 * (l_xcdr.xcdr103 / l_xcdr.xcdr020)
               IF cl_null(l_xcdy.xcdy100) THEN   LET l_xcdy.xcdy100 = 0 END IF   

               IF cl_null(l_xcdy.xcdy202) THEN   LET l_xcdy.xcdy202 = 0 END IF 
               IF cl_null(l_xcdy.xcdy212) THEN   LET l_xcdy.xcdy212 = 0 END IF 
               IF cl_null(l_xcdy.xcdy222) THEN   LET l_xcdy.xcdy222 = 0 END IF

               CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
               IF l_success THEN
                  LET l_xcdy.xcdy100 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy100,'1')
                  LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy202,'2') 
                  LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy212,'2') 
                  LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdy.xcdy222,'2') 
               ELSE
                  CONTINUE FOREACH
               END IF

#               INSERT INTO xcdy_t VALUES(l_xcdy.*)  #161124-00048#21 mark
               #161124-00048#21 add(s)
               INSERT INTO xcdy_t(xcdyent,xcdyld,xcdycomp,xcdy001,xcdy002,xcdy003,xcdy004,xcdy005,
                                  xcdy006,xcdy007,xcdy008,xcdy009,xcdy100,xcdy101,xcdy111,xcdy121,
                                  xcdy202,xcdy212,xcdy222) 
                           VALUES(l_xcdy.xcdyent,l_xcdy.xcdyld,l_xcdy.xcdycomp,l_xcdy.xcdy001,l_xcdy.xcdy002,l_xcdy.xcdy003,l_xcdy.xcdy004,l_xcdy.xcdy005,
                                  l_xcdy.xcdy006,l_xcdy.xcdy007,l_xcdy.xcdy008,l_xcdy.xcdy009,l_xcdy.xcdy100,l_xcdy.xcdy101,l_xcdy.xcdy111,l_xcdy.xcdy121,
                                  l_xcdy.xcdy202,l_xcdy.xcdy212,l_xcdy.xcdy222)
               #161124-00048#21 add(e)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "l_xcdy"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
     
                  LET g_success = 'N'                        
               END IF
               #170217-00025#7 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#7 add-E
               LET l_flag = 'Y'
               LET l_max_xcdy006 = l_xcdy.xcdy006
               IF l_xcdy.xcdy202 > l_max_amt THEN 
                  LET l_max_amt = l_xcdy.xcdy202
                  LET l_max_xcdy008 = l_xcdy.xcdy008
                  LET l_max_xcdy009 = l_xcdy.xcdy009
               END IF
            END FOREACH 
         END IF
         
   #处理尾差，按工单排序，最后一笔加上前端xcdr分摊总金额-本次各笔分摊金额合计的差异 
   #尾差处理的范围是同一分摊方式不同工单
         IF l_xcdy.xcdy006 IS NOT NULL THEN    #没有工单，说明前面没有抓到xcbr资料，不该有尾差调整
            LET l_sum_xcdy202 = 0
            LET l_sum_xcdy212 = 0
            LET l_sum_xcdy222 = 0
            SELECT SUM(xcdy202),SUM(xcdy212),SUM(xcdy222) INTO l_sum_xcdy202,l_sum_xcdy212,l_sum_xcdy222
              FROM xcdy_t
             WHERE xcdyent = g_enterprise
               AND xcdyld  = l_xcdr.xcdrld
               AND xcdy001 = l_xcdr.xcdr001
               AND xcdy002 = l_xcdr.xcdr002
               AND xcdy003 = l_xcdr.xcdr003
               AND xcdy004 = l_xcdr.xcdr004
               AND xcdy005 = l_xcdr.xcdr005
               AND xcdy007 = l_xcdr.xcdr006
            IF cl_null(l_sum_xcdy202) THEN   LET l_sum_xcdy202 = 0 END IF  
            IF cl_null(l_sum_xcdy212) THEN   LET l_sum_xcdy212 = 0 END IF 
            IF cl_null(l_sum_xcdy222) THEN   LET l_sum_xcdy222 = 0 END IF   

            IF cl_null(l_xcdr.xcdr103) THEN   LET l_xcdr.xcdr103 = 0 END IF 
            IF cl_null(l_xcdr.xcdr113) THEN   LET l_xcdr.xcdr113 = 0 END IF 
            IF cl_null(l_xcdr.xcdr123) THEN   LET l_xcdr.xcdr123 = 0 END IF           
            
            CALL s_ld_sel_glaa(l_xcdy.xcdyld,'glaa001') RETURNING l_success,l_curr
            IF l_success THEN
               LET l_xcdy.xcdy202 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_sum_xcdy202,'2') 
               LET l_xcdy.xcdy212 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_sum_xcdy212,'2') 
               LET l_xcdy.xcdy222 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_sum_xcdy222,'2')
               LET l_xcdr.xcdr103 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdr.xcdr103,'2') 
               LET l_xcdr.xcdr113 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdr.xcdr113,'2') 
               LET l_xcdr.xcdr123 = s_curr_round(l_xcdy.xcdycomp,l_curr,l_xcdr.xcdr123,'2')            
            ELSE
               CONTINUE FOREACH
            END IF
            
            IF l_sum_xcdy202 IS NULL THEN LET l_sum_xcdy202 = 0 END IF
            IF l_sum_xcdy212 IS NULL THEN LET l_sum_xcdy212 = 0 END IF
            IF l_sum_xcdy222 IS NULL THEN LET l_sum_xcdy222 = 0 END IF
            
            UPDATE xcdy_t SET xcdy202 = xcdy202 + l_xcdr.xcdr103 - l_sum_xcdy202,
                              xcdy212 = xcdy212 + l_xcdr.xcdr113 - l_sum_xcdy212,
                              xcdy222 = xcdy222 + l_xcdr.xcdr123 - l_sum_xcdy222
             WHERE xcdyent = g_enterprise
               AND xcdyld  = l_xcdr.xcdrld
               AND xcdy001 = l_xcdr.xcdr001
               AND xcdy002 = l_xcdr.xcdr002
               AND xcdy003 = l_xcdr.xcdr003
               AND xcdy004 = l_xcdr.xcdr004
               AND xcdy005 = l_xcdr.xcdr005
               AND xcdy007 = l_xcdr.xcdr006
               AND xcdy008 = l_max_xcdy008
               AND xcdy009 = l_max_xcdy009
               AND xcdy202 = l_max_amt
               AND rownum  = 1
         END IF
    #处理尾差结束
      END FOREACH 
      IF l_flag = 'N' THEN                      
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00787'      
         LET g_errparam.extend = "xcdy_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
      CALL cl_progress_no_window_ing("ins xcdy")
   END IF
   CALL cl_err_collect_show()
   
END FUNCTION

#end add-point
 
{</section>}
 
