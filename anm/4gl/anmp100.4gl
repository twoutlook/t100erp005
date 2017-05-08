#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-11-06 15:49:28), PR版次:0003(2016-10-26 11:08:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: anmp100
#+ Description: 銀行對帳單整批下載對帳作業
#+ Creator....: 00810(2014-09-15 10:12:16)
#+ Modifier...: 00810 -SD/PR- 08729
 
{</section>}
 
{<section id="anmp100.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150624-00005#1 150629 By Jessy 處理排程相關程式
#160816-00012#2  2016/08/29  By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#161021-00050#1  2016/10/24  By 08729    處理組織開窗
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
   #150624-00005#1-----s
   b_date     LIKE type_t.chr500, 
   t_nmcksite LIKE type_t.chr500, 
   e_date     LIKE type_t.chr500, 
   #150624-00005#1-----e
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       b_date LIKE type_t.chr500, 
   t_nmcksite LIKE type_t.chr500, 
   e_date LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 TYPE type_g_nmaa_d RECORD
      sel    LIKE type_t.chr1,      #選擇
      nmaa005 LIKE nmaa_t.nmaa005,  #銀行賬戶
      nmaal003 LIKE nmaal_t.nmaal003, #銀行賬戶說明
      nmas003 LIKE nmas_t.nmas003, #幣別
      ooefl004 LIKE ooefl_t.ooefl004 #法人
       END RECORD
       
DEFINE g_nmaa_d        DYNAMIC ARRAY OF type_g_nmaa_d
DEFINE l_ac                 LIKE type_t.num5
DEFINE g_rec_b       LIKE type_t.num5

DEFINE g_wc_nmcksite STRING
DEFINE g_wc_nmckcomp STRING
DEFINE g_apcald      LIKE glaa_t.glaald
DEFINE g_nmckcomp    LIKE nmck_t.nmckcomp
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmp100.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL anmp100_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp100 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmp100_init()
 
      #進入選單 Menu (="N")
      CALL anmp100_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp100.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmp100_init()
 
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
 
{<section id="anmp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp100_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_nmau003 LIKE nmau_t.nmau003 #作業編號
   DEFINE la_param  RECORD #串查用
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   
   DEFINE  l_count    LIKE type_t.num5
   DEFINE  l_wc       STRING
   DEFINE  l_sql      STRING
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
       
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
         CALL anmp100_table()
         
         DISPLAY ARRAY g_nmaa_d TO s_detail1.*  
         END DISPLAY
         
         
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.b_date,g_master.t_nmcksite,g_master.e_date 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_date
            #add-point:BEFORE FIELD b_date name="input.b.b_date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_date
            
            #add-point:AFTER FIELD b_date name="input.a.b_date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_date
            #add-point:ON CHANGE b_date name="input.g.b_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD t_nmcksite
            #add-point:BEFORE FIELD t_nmcksite name="input.b.t_nmcksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD t_nmcksite
            
            #add-point:AFTER FIELD t_nmcksite name="input.a.t_nmcksite"
            IF NOT cl_null(g_master.t_nmcksite ) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.t_nmcksite ,'',g_user,'6','Y','',g_today) RETURNING g_sub_success,g_errno  #161021-00050#1 add
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.t_nmcksite  = ''
                  NEXT FIELD CURRENT
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE t_nmcksite
            #add-point:ON CHANGE t_nmcksite name="input.g.t_nmcksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e_date
            #add-point:BEFORE FIELD e_date name="input.b.e_date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e_date
            
            #add-point:AFTER FIELD e_date name="input.a.e_date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e_date
            #add-point:ON CHANGE e_date name="input.g.e_date"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.b_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_date
            #add-point:ON ACTION controlp INFIELD b_date name="input.c.b_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.t_nmcksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD t_nmcksite
            #add-point:ON ACTION controlp INFIELD t_nmcksite name="input.c.t_nmcksite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.t_nmcksite             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooef001()             #呼叫開窗 #161021-00050#1 mark
            CALL q_ooef001_33()                    #161021-00050#1 add
            LET g_master.t_nmcksite = g_qryparam.return1              
            #LET g_master.ooefl003 = g_qryparam.return2 
            DISPLAY g_master.t_nmcksite TO t_nmcksite              #
            #DISPLAY g_master.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD t_nmcksite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.e_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e_date
            #add-point:ON ACTION controlp INFIELD e_date name="input.c.e_date"
            
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
         INPUT ARRAY g_nmaa_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
               BEFORE INPUT
               
               BEFORE ROW
    
               ON CHANGE b_sel
       
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
            CALL anmp100_get_buffer(l_dialog)
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
          #選擇全部
          ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "Y"
            END FOR
            
           #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "N"
            END FOR
       
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "Y"
               END IF
            END FOR
           
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "N"
               END IF
            END FOR 
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
         CALL anmp100_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#1-----s
      LET lc_param.b_date      = g_master.b_date
      LET lc_param.t_nmcksite  = g_master.t_nmcksite
      LET lc_param.e_date      = g_master.e_date
      #150624-00005#1-----e
      
      FOR li_idx = 1 TO g_nmaa_d.getLength()
         LET l_nmau003 = ''
         IF g_nmaa_d[li_idx].sel = "Y" THEN
         
            SELECT nmau003 INTO l_nmau003 FROM nmau_t,nmaa_t,nmab_t 
            WHERE nmaa004 = nmab001 AND nmau002 = '2' AND nmaa005 = g_nmaa_d[li_idx].nmaa005 AND nmab010 = nmau001
            
            IF l_nmau003 IS NOT NULL THEN
                LET la_param.prog = l_nmau003 #調用的那隻作業
#                LET la_param.param[1] = ' '       #需要傳的參數
                LET la_param.param[1] = l_nmau003   #作業編號
                LET la_param.param[2] = g_nmaa_d[li_idx].nmaa005       #銀行賬戶
                LET la_param.param[3] = g_master.b_date       #查询开始日期
                LET la_param.param[4] = g_master.e_date       #查询结束日期
                LET la_param.param[5] = g_master.t_nmcksite       #资金中心
                LET la_param.param[6] = g_nmaa_d[li_idx].ooefl004 #法人
                LET la_param.param[7] = g_nmaa_d[li_idx].nmas003 #类别
                LET ls_js = util.JSON.stringify(la_param)
                CALL cl_cmdrun(ls_js)
            END IF
         END IF
      END FOR
     
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
                 CALL anmp100_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmp100_transfer_argv(ls_js)
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
 
{<section id="anmp100.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmp100_transfer_argv(ls_js)
 
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
 
{<section id="anmp100.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmp100_process(ls_js)
 
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
   #150624-00005#1-----s
   #將傳遞參數變數傳回給畫面上的變數
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
   LET g_master.wc          = lc_param.wc
   LET g_master.b_date      = lc_param.b_date
   LET g_master.t_nmcksite  = lc_param.t_nmcksite
   LET g_master.e_date      = lc_param.e_date
   END IF
   #150624-00005#1-----e
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE anmp100_process_cs CURSOR FROM ls_sql
#  FOREACH anmp100_process_cs INTO
   #add-point:process段process name="process.process"
   
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
   CALL anmp100_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp100.get_buffer" >}
PRIVATE FUNCTION anmp100_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.b_date = p_dialog.getFieldBuffer('b_date')
   LET g_master.t_nmcksite = p_dialog.getFieldBuffer('t_nmcksite')
   LET g_master.e_date = p_dialog.getFieldBuffer('e_date')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
 
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmp100.msgcentre_notify" >}
PRIVATE FUNCTION anmp100_msgcentre_notify()
 
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
 
{<section id="anmp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION anmp100_table()
   DEFINE l_wc         STRING      #160816-00012#2 Add

   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc   #160816-00012#2 Add
   LET l_wc = cl_replace_str(l_wc,"ooef017","nmaa002")     #160816-00012#2 Add

      LET g_sql = " SELECT 'N',nmaa005,nmaal003,nmas003,ooefl004 FROM nmas_t,nmaa_t  ",
                  " LEFT JOIN nmaal_t ON nmaalent = nmaaent AND nmaal001 = nmaa001 AND nmaal002='"||g_dlang||"' ", 
                  " LEFT JOIN ooefl_t ON ooeflent = nmaaent AND ooefl001 = nmaa002 AND ooefl002='"||g_dlang||"' ",
                  " WHERE nmaaent = nmasent AND nmaa001 = nmas001 AND nmaa006 = 'Y' ",
                  " AND nmaaent='"||g_enterprise||"'",
                  " AND ",l_wc   #160816-00012#2 Add
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmp100_pb FROM g_sql
         DECLARE b_fill_curs CURSOR FOR anmp100_pb
         OPEN   b_fill_curs
         CALL g_nmaa_d.clear()
         LET l_ac = 1
         FOREACH b_fill_curs INTO g_nmaa_d[l_ac].sel,g_nmaa_d[l_ac].nmaa005,g_nmaa_d[l_ac].nmaal003,g_nmaa_d[l_ac].nmas003,g_nmaa_d[l_ac].ooefl004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF

            IF l_ac > g_max_rec THEN
               IF g_error_show = 1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = l_ac
                  LET g_errparam.code   = 9035 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF
               EXIT FOREACH
            END IF
 
            LET l_ac = l_ac + 1
         END FOREACH
         
         CALL g_nmaa_d.deleteElement(g_nmaa_d.getLength()) 
      
END FUNCTION

#end add-point
 
{</section>}
 
