#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp480.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-29 15:40:31), PR版次:0001(2017-01-16 16:39:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aisp480
#+ Description: 交易稅明細檔批次刪除作業
#+ Creator....: 08729(2016-11-29 15:40:31)
#+ Modifier...: 08729 -SD/PR- 08729
 
{</section>}
 
{<section id="aisp480.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
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
       xrcdcomp LIKE xrcd_t.xrcdcomp, 
   xrcdcomp_desc LIKE type_t.chr80, 
   xrcd001 LIKE xrcd_t.xrcd001, 
   type1 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE  g_wc_xrcdcomp            STRING
DEFINE  l_str                    STRING
DEFINE  l_xrcd001       LIKE xrcd_t.xrcd001
DEFINE  g_ld            LIKE glaa_t.glaald

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp480.main" >}
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
      CALL aisp480_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp480 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp480_init()
 
      #進入選單 Menu (="N")
      CALL aisp480_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp480
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp480.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp480_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_year        LIKE type_t.num5
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
   CALL aisp480_qbe_clear()
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)   
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcdcomp
   CALL s_fin_get_wc_str(g_wc_xrcdcomp) RETURNING g_wc_xrcdcomp
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp480.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp480_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_month        LIKE type_t.chr10
   DEFINE l_month1       LIKE type_t.chr10
   DEFINE l_year         LIKE type_t.chr10
   DEFINE l_date         LIKE type_t.chr500
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_time         LIKE type_t.dat
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrcdcomp,g_master.xrcd001,g_master.type1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdcomp
            
            #add-point:AFTER FIELD xrcdcomp name="input.a.xrcdcomp"
            LET g_master.xrcdcomp_desc = ''
               IF NOT cl_null(g_master.xrcdcomp) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xrcdcomp
                  IF cl_chk_exist("v_ooef001_1") THEN
                     #檢查成功時後續處理
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.xrcdcomp = ''
                     CALL s_desc_get_department_desc(g_master.xrcdcomp)RETURNING g_master.xrcdcomp_desc
                     DISPLAY BY NAME g_master.xrcdcomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_wc_xrcdcomp,g_master.xrcdcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00127'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xrcdcomp = ''
                     CALL s_desc_get_department_desc(g_master.xrcdcomp)RETURNING g_master.xrcdcomp_desc
                     DISPLAY BY NAME g_master.xrcdcomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_department_desc(g_master.xrcdcomp) RETURNING g_master.xrcdcomp_desc
               DISPLAY BY NAME g_master.xrcdcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdcomp
            #add-point:BEFORE FIELD xrcdcomp name="input.b.xrcdcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdcomp
            #add-point:ON CHANGE xrcdcomp name="input.g.xrcdcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd001
            #add-point:BEFORE FIELD xrcd001 name="input.b.xrcd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd001
            
            #add-point:AFTER FIELD xrcd001 name="input.a.xrcd001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd001
            #add-point:ON CHANGE xrcd001 name="input.g.xrcd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type1
            #add-point:BEFORE FIELD type1 name="input.b.type1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type1
            
            #add-point:AFTER FIELD type1 name="input.a.type1"
            CALL s_chr_alphanumeric(g_master.type1,'1') RETURNING l_success
            IF NOT l_success OR g_master.type1 < 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00318'
               LET g_errparam.extend = ''     
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.type1 = ''
               NEXT FIELD CURRENT
            END IF
            CALL s_chr_chk_str(g_master.type1,'6','')RETURNING g_sub_success
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00318'
               LET g_errparam.extend = ''     
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.type1 = ''
               NEXT FIELD CURRENT
            END IF                     
            LET l_month1 = g_master.type1[5,6]
            LET l_time = cl_get_today()
            LET l_month = MONTH(l_time)  USING '&&'
            LET l_year = YEAR(l_time)
            LET l_date = l_year CLIPPED,l_month
            LET l_date = s_chr_atrim(l_date)
            IF l_date = g_master.type1 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ais-00348'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               DISPLAY BY NAME g_master.type1
               NEXT FIELD CURRENT
            END IF
            IF l_month1 <= 0 OR l_month1 > 12 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00321'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               DISPLAY BY NAME g_master.type1
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type1
            #add-point:ON CHANGE type1 name="input.g.type1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrcdcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdcomp
            #add-point:ON ACTION controlp INFIELD xrcdcomp name="input.c.xrcdcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrcdcomp
            LET g_qryparam.where = "ooef003 = 'Y'"
            IF NOT cl_null(g_wc_xrcdcomp)THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_xrcdcomp
            END IF                  
            CALL q_ooef001()
            LET g_master.xrcdcomp = g_qryparam.return1
            DISPLAY BY NAME g_master.xrcdcomp
            NEXT FIELD xrcdcomp
            #END add-point
 
 
         #Ctrlp:input.c.xrcd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd001
            #add-point:ON ACTION controlp INFIELD xrcd001 name="input.c.xrcd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.type1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type1
            #add-point:ON ACTION controlp INFIELD type1 name="input.c.type1"
            
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
            CALL aisp480_get_buffer(l_dialog)
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
            CALL aisp480_qbe_clear()
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
         CALL aisp480_init()
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
                 CALL aisp480_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp480_transfer_argv(ls_js)
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
 
{<section id="aisp480.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp480_transfer_argv(ls_js)
 
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
 
{<section id="aisp480.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp480_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql         STRING
   DEFINE l_sql1        STRING 
   DEFINE l_sql2        STRING
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_xrcddocno   LIKE type_t.chr1000   #單號
   DEFINE l_xrcd001     LIKE type_t.chr1000   #模組
   DEFINE l_dzeb002     LIKE type_t.chr1000   #單據日期名稱
   DEFINE l_dzeb001     LIKE type_t.chr1000   #table名稱
   DEFINE l_table       LIKE dzeb_t.dzeb001   #table前4碼
   DEFINE l_table_1     LIKE dzeb_t.dzeb001   #old table前4碼
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE p_array DYNAMIC ARRAY OF RECORD
             docno       STRING,
             value       STRING,
             label_tag   STRING,
             label       STRING
                   END RECORD
   DEFINE l_apcadocdt   LIKE apca_t.apcadocdt  
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_year =  g_master.type1[1,4]
   LET l_month = g_master.type1[5,6]
   #將畫面上的年月轉換 ex:201511-->11012015
   LET l_apcadocdt = MDY(l_month,1,l_year)
   #取當月最後一天
   CALL s_date_get_last_date(l_apcadocdt) RETURNING l_apcadocdt   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp480_process_cs CURSOR FROM ls_sql
#  FOREACH aisp480_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   LET g_success = 'Y'
######################################
   LET l_sql1 =  "SELECT DISTINCT xrcddocno,substr(xrcd001,1,3),dzeb002,dzeb001",
                 "  FROM xrcd_t                                                ",
                 "  LEFT JOIN gzzz_t ON  gzzz001 = xrcd001                     ",
                 "  LEFT JOIN gzdg_t ON  gzdg001 = gzzz002                     ",
                 "  LEFT JOIN dzeb_t ON  gzdg002 = dzeb001                     ",
                 " WHERE xrcdent = ",g_enterprise, 
                 "   AND dzeb002 LIKE '%docdt'                                 ",
                 "   AND gzdg003 = 'I'                                         ",
                 "   AND substr(xrcd001,1,3) = '",g_master.xrcd001,"'          ",
                 "   AND xrcdcomp = '",g_master.xrcdcomp,"'                    ",
                 " ORDER BY xrcddocno                                           "

   PREPARE aisp480_pb1 FROM l_sql1
   DECLARE aisp480_cs1 SCROLL CURSOR FOR aisp480_pb1
#####################################      
   #將選項填入陣列
   LET l_sql2 = " SELECT COUNT(1) FROM apca_t ",
                "  WHERE apcaent = ",g_enterprise, 
                "    AND apcadocno =  ? ",
                "    AND apcadocdt <= '",l_apcadocdt,"'"
   FOREACH aisp480_cs1 INTO l_xrcddocno,l_xrcd001,l_dzeb002,l_dzeb001
###################################                  
      #抓table前4碼
      SELECT DISTINCT substr(dzeb001,1,4) INTO l_table
        FROM dzeb_t 
        LEFT JOIN gzdg_t ON  gzdg002 = dzeb001
        LEFT JOIN gzzz_t ON  gzdg001 = gzzz002
        LEFT JOIN xrcd_t ON  xrcd001 = gzzz001
       WHERE xrcdent = g_enterprise
         AND xrcddocno = l_xrcddocno
         AND substr(xrcd001,1,3) = g_master.xrcd001
         AND xrcdcomp = g_master.xrcdcomp
         AND dzeb001 = l_dzeb001
       
      #把l_sql從apca替換成xxxx
      LET l_sql2 = s_chr_replace(l_sql2,'apca',l_table,0) 
      IF l_table != l_table_1 THEN
         LET l_sql2 = s_chr_replace(l_sql2,l_table_1,l_table,0) 
      END IF
      #excute 抓取符合筆數  
      LET l_cnt = 0   
      PREPARE aisp480_pb2 FROM l_sql2         
      EXECUTE aisp480_pb2 USING l_xrcddocno INTO l_cnt  
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      LET l_table_1 = l_table 
      #比數>0刪除這一筆xrcd
      IF l_cnt > 0 THEN 
         DELETE FROM xrcd_t
          WHERE xrcdent = g_enterprise
            AND xrcdcomp = g_master.xrcdcomp
            AND xrcddocno = l_xrcddocno
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF   
      ELSE 
         CONTINUE FOREACH
      END IF
   END FOREACH     
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
###################################### 
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
   CALL aisp480_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp480.get_buffer" >}
PRIVATE FUNCTION aisp480_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrcdcomp = p_dialog.getFieldBuffer('xrcdcomp')
   LET g_master.xrcd001 = p_dialog.getFieldBuffer('xrcd001')
   LET g_master.type1 = p_dialog.getFieldBuffer('type1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp480.msgcentre_notify" >}
PRIVATE FUNCTION aisp480_msgcentre_notify()
 
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
 
{<section id="aisp480.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 抓取使用xrcd的模組
# Memo...........:
# Usage..........: CALL aisp480_get_scc(ps_field_name)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 161130 By 08729
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp480_get_scc(ps_field_name)
   DEFINE ps_values      STRING
   DEFINE ps_items       STRING
   DEFINE ps_field_name  STRING
   DEFINE pc_gzca001     LIKE gzca_t.gzca001      #系統分類碼
   DEFINE pc_gzcb002     LIKE gzcb_t.gzcb002      #系統分類值
   DEFINE pc_gzcbl004    LIKE gzcbl_t.gzcbl004    #說明
   DEFINE l_xrcd001      LIKE xrcd_t.xrcd001
   DEFINE li_cnt         LIKE type_t.num10
   DEFINE l_sql          STRING
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING
                   END RECORD
   WHENEVER ERROR CALL cl_err_msg_log
############################################
    DECLARE p_scc_item_cs CURSOR FOR
       SELECT DISTINCT substr(xrcd001,1,3)
         FROM xrcd_t 
         LEFT JOIN gzdg_t ON  xrcd001 = gzdg001
         LEFT JOIN dzeb_t ON  gzdg002 = dzeb001
        WHERE dzeb002 LIKE '%docdt'
          AND gzdg003 = 'I'
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-00068"
         LET g_errparam.extend = "gzcb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         #將選項填入陣列
         LET li_cnt = 1
         FOREACH p_scc_item_cs INTO l_xrcd001
            LET pa_array[li_cnt].value = l_xrcd001 CLIPPED
            LET li_cnt = li_cnt + 1
         END FOREACH
         CALL aisp480_set_scc(ps_field_name, pa_array)
      END IF
      CLOSE p_scc_item_cs
      FREE p_scc_item_cs

END FUNCTION

################################################################################
# Descriptions...: combox item
# Memo...........:
# Usage..........: CALL aisp480_set_scc(ps_field_name,pa_array)
# Input parameter: 無
# Return code....: 無
# Date & Author..: 161130 By 08729
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp480_set_scc(ps_field_name,pa_array)
DEFINE ps_field_name  STRING
   DEFINE lcbo_target    ui.ComboBox
   DEFINE ls_temp        STRING
   DEFINE lwin_curr      ui.Window
   DEFINE f              ui.form
   DEFINE r              om.DomNode
   DEFINE c              om.domnode
   DEFINE lc_gztz001     LIKE gztz_t.gztz001
   DEFINE lc_gztz002     LIKE gztz_t.gztz002
   DEFINE pa_array DYNAMIC ARRAY OF RECORD
             value       STRING
                     END RECORD
   DEFINE li_cnt LIKE type_t.num5

   WHENEVER ERROR CALL cl_err_msg_log

   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]" THEN
      RETURN
   END IF

   LET ps_field_name = ps_field_name.trim()
   CALL lcbo_target.clear()
   LET lcbo_target = ui.ComboBox.forName(ps_field_name)
   #判斷是Combobox 或是 RadioGroup (NULL即為RadioGroup)
   IF lcbo_target IS NULL THEN
      #以下是RadioGroup 的處理
      LET lwin_curr = ui.Window.getCurrent()
      LET f = lwin_curr.getForm()
      IF f IS NOT NULL THEN
         LET lc_gztz002 = ps_field_name CLIPPED
         SELECT gztz001 INTO lc_gztz001 FROM gztz_t
          WHERE gztz002 = lc_gztz002
         IF SQLCA.SQLCODE THEN
            IF NOT ps_field_name.getIndexof("formonly",1) THEN
               LET ps_field_name = "formonly.",lc_gztz002
            END IF
         ELSE
            LET ps_field_name = lc_gztz001,".",lc_gztz002
         END IF
         LET r = f.findNode("FormField", ps_field_name)
         LET r = r.getfirstchild()
         FOR li_cnt = 1 TO pa_array.getLength()
            LET c = r.createChild("Item")
            CALL c.setattribute("name", pa_array[li_cnt].value)
         END FOR
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-00070"
         LET g_errparam.extend = ps_field_name
         LET g_errparam.popup = TRUE
         CALL cl_err()
  #欄位不存在此畫面中
      END IF
      RETURN
   ELSE
      CALL lcbo_target.clear()
   END IF
   CALL lcbo_target.clear()
   #以下是Combobox的處理
   FOR li_cnt = 1 TO pa_array.getLength()
       IF cl_null(pa_array[li_cnt].value) THEN
          LET ls_temp = pa_array[li_cnt].value
       END IF
      CALL lcbo_target.addItem(pa_array[li_cnt].value,ls_temp)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 清空給預設值
# Memo...........:
# Usage..........: CALL aisp480_qbe_clear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 161207 By 08729
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp480_qbe_clear()
DEFINE l_month       LIKE type_t.chr10
DEFINE l_year        LIKE type_t.chr10 
DEFINE l_time        LIKE type_t.dat
   CLEAR FORM
   INITIALIZE g_master.* TO NULL   #畫面變數清空
   CALL aisp480_get_scc('xrcd001')
   LET g_master.xrcd001 = 'aap'
   LET l_time = cl_get_today()
   LET l_month = MONTH(l_time) USING '&&'
   LET l_year = YEAR(l_time)-1
   LET g_master.type1  = MDY(l_month,1,l_year)
   #取得當月最後一天
   CALL s_date_get_last_date(g_master.type1 ) RETURNING g_master.type1   
   LET g_master.type1 = l_year CLIPPED,l_month
   LET g_master.type1 = s_chr_atrim(g_master.type1)
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,g_master.xrcdcomp,g_ld
   CALL s_desc_get_department_desc(g_master.xrcdcomp) RETURNING g_master.xrcdcomp_desc
   DISPLAY BY NAME g_master.xrcdcomp,g_master.xrcdcomp_desc
END FUNCTION

#end add-point
 
{</section>}
 
