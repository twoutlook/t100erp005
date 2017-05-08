#該程式未解開Section, 採用最新樣板產出!
{<section id="adep150.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-29 13:33:30), PR版次:0004(2016-08-04 10:42:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: adep150
#+ Description: 門店銷售單品週結批次處理作業
#+ Creator....: 01752(2015-06-22 11:06:03)
#+ Modifier...: 06137 -SD/PR- 08734
 
{</section>}
 
{<section id="adep150.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下
#                                   adep150_decf_temp ——> adep150_tmp01,adep150_decg_temp ——> adep150_tmp02,adep150_deba_temp ——> adep150_tmp03
#                                   adep150_dect_temp ——> adep150_tmp04,adep150_decu_temp ——> adep150_tmp05,adep150_dech_temp ——> adep150_tmp06
#                                   adep150_deci_temp ——> adep150_tmp07,adep150_decj_temp ——> adep150_tmp08,adep150_deck_temp ——> adep150_tmp09
#                                   adep150_decl_temp ——> adep150_tmp10,adep150_decm_temp ——> adep150_tmp11,adep150_decn_temp ——> adep150_tmp12
#                                   adep150_deco_temp ——> adep150_tmp13,adep150_decp_temp ——> adep150_tmp14,adep150_decq_temp ——> adep150_tmp15
#                                   adep150_decr_temp ——> adep150_tmp16,adep150_decs_temp ——> adep150_tmp17,adep150_decv_temp ——> adep150_tmp18
#                                   adep150_decw_temp ——> adep150_tmp19,adep150_debu_temp ——> adep150_tmp20,adep150_dede_temp ——> adep150_tmp21
#                                   adep150_deba_temp2 ——> adep150_tmp22,adep150_dedq_temp ——> adep150_tmp23,adep150_dedr_temp ——> adep150_tmp24
#                                   dep150_dedf_temp ——> adep150_tmp25,adep150_dedg_temp ——> adep150_tmp26,adep150_dedh_temp ——> adep150_tmp27
#                                   adep150_dedi_temp ——> adep150_tmp28,adep150_dedj_temp ——> adep150_tmp29,adep150_dedk_temp ——> adep150_tmp30
#                                   adep150_dedl_temp ——> adep150_tmp31,adep150_dedm_temp ——> adep150_tmp32,adep150_dedn_temp ——> adep150_tmp33
#                                   adep150_debv_temp ——> adep150_tmp34,adep150_dedo_temp ——> adep150_tmp35,adep150_dedp_temp ——> adep150_tmp36
#                                   adep150_deds_temp ——> adep150_tmp37,adep150_dedt_temp ——> adep150_tmp38
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
        type             LIKE type_t.chr2,  #150716-00020#6 Add By Ken 150729
        rtjadocdt        LIKE rtja_t.rtjadocdt,
        l_del            LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjasite LIKE rtja_t.rtjasite, 
   rtjadocdt LIKE rtja_t.rtjadocdt, 
   l_del LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_yearmonth   LIKE type_t.num10
DEFINE g_week        LIKE type_t.num5
DEFINE g_sdate       LIKE type_t.dat
DEFINE g_edate       LIKE type_t.dat
DEFINE g_year        LIKE type_t.num5
DEFINE g_month       LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adep150.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由02開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[02]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep150_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep150 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep150_init()
 
      #進入選單 Menu (="N")
      CALL adep150_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep150
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep150.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep150_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
 
{<section id="adep150.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep150_ui_dialog()
 
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
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.rtjadocdt,g_master.l_del 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt
            #add-point:BEFORE FIELD rtjadocdt name="input.b.rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt
            
            #add-point:AFTER FIELD rtjadocdt name="input.a.rtjadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt
            #add-point:ON CHANGE rtjadocdt name="input.g.rtjadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_del
            #add-point:BEFORE FIELD l_del name="input.b.l_del"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_del
            
            #add-point:AFTER FIELD l_del name="input.a.l_del"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_del
            #add-point:ON CHANGE l_del name="input.g.l_del"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt
            #add-point:ON ACTION controlp INFIELD rtjadocdt name="input.c.rtjadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_del
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_del
            #add-point:ON ACTION controlp INFIELD l_del name="input.c.l_del"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjasite
            #add-point:BEFORE FIELD rtjasite name="construct.b.rtjasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjasite
            
            #add-point:AFTER FIELD rtjasite name="construct.a.rtjasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上
            NEXT FIELD rtjasite                     #返回原欄位  
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
            CALL adep150_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.rtjadocdt = g_today
            DISPLAY BY NAME g_master.rtjadocdt
            LET g_master.l_del  = 'Y'
            DISPLAY g_master.l_del TO l_del
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
         CALL adep150_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.type = g_argv[1] #150716-00020#6 Add By Ken 150729
      LET lc_param.rtjadocdt = g_master.rtjadocdt
      LET lc_param.l_del  = g_master.l_del
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
                 CALL adep150_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep150_transfer_argv(ls_js)
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
 
{<section id="adep150.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep150_transfer_argv(ls_js)
 
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
 
{<section id="adep150.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep150_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_year        LIKE type_t.num10
   DEFINE l_month       LIKE type_t.num10   
   DEFINE l_week        LIKE type_t.num5
   DEFINE l_sdate       LIKE type_t.dat
   DEFINE l_edate       LIKE type_t.dat
   DEFINE l_msg         STRING
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
#  DECLARE adep150_process_cs CURSOR FROM ls_sql
#  FOREACH adep150_process_cs INTO
   #add-point:process段process name="process.process"
   
   #取得週結範圍與日期相關資料
   LET l_year = YEAR(lc_param.rtjadocdt)
   LET l_month = MONTH(lc_param.rtjadocdt)   
   LET g_yearmonth = (l_year * 100) + l_month 
   
   LET l_sdate = MDY(l_month,1,l_year)                                   #結算日期的該月第一天
   LET l_edate = MDY(l_month,s_date_get_max_day(l_year,l_month),l_year)  #結算日期的該月最後一天
   
   #150716-00020#6 Modify By Ken 150729(S)
   #IF g_argv[1] = '0' OR g_argv[1] = '1' OR g_argv[1] = '4' OR g_argv[1] = '5' OR
   #   g_argv[1] = '6' OR g_argv[1] = '7' OR g_argv[1] = '9' THEN

   IF lc_param.type = '0' OR lc_param.type = '1' OR lc_param.type = '4' OR lc_param.type = '5' OR
      lc_param.type = '6' OR lc_param.type = '7' OR lc_param.type = '9' THEN
   #150716-00020#6 Modify By Ken 150729(E)
      
      #週結資料範圍 主要欄位抓取
      LET l_week = ''
      SELECT ooga013 INTO l_week FROM ooga_t
       WHERE oogaent = g_enterprise
         AND ooga001 = lc_param.rtjadocdt
      IF cl_null(l_week) THEN 
         #日曆檔中取不到本日"月週"的資料
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00116'
         LET g_errparam.extend = lc_param.rtjadocdt
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         RETURN
      END IF   
     
      LET g_sdate = ''    #此次結算的起始日
      LET g_edate = ''    #此次結算的截止日
      
      #每個月只計4週,超過第四週的都以第四週計算
      IF l_week >= 4 THEN 
         LET g_week = 4       
         SELECT min(ooga001) INTO g_sdate FROM ooga_t
          WHERE oogaent = g_enterprise
            AND ooga012 = l_month
            AND ooga013 = g_week
            AND ooga001 BETWEEN l_sdate AND l_edate
     
         LET g_edate = l_edate
      ELSE 
         LET g_week = l_week
         
         SELECT min(ooga001),max(ooga001) INTO g_sdate,g_edate FROM ooga_t
          WHERE oogaent = g_enterprise
            AND ooga012 = l_month
            AND ooga013 = l_week
            AND ooga001 BETWEEN l_sdate AND l_edate
      END IF  
   ELSE
      #月結資料範圍 主要欄位
      LET g_year = l_year
      LET g_month = l_month
      LET g_sdate = l_sdate
      LET g_edate = l_edate
   END IF
   
  #CASE g_argv[1]  #150716-00020#6 Mark By Ken 150729
   CASE lc_param.type  #150716-00020#6 Add By Ken 150729
      WHEN '0'
         IF adep150_create_temp0() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp0(lc_param.wc) THEN
               CALL adep150_drop_temp0() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp0() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process0(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp0() RETURNING l_success

      WHEN '1'
         IF adep150_create_temp1() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp1(lc_param.wc) THEN
               CALL adep150_drop_temp1() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp1() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process1(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp1() RETURNING l_success
      WHEN '4'
         IF adep150_create_temp4() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp4(lc_param.wc) THEN
               CALL adep150_drop_temp4() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp4() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process4(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp4() RETURNING l_success
      WHEN '5'
         IF adep150_create_temp5() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp5(lc_param.wc) THEN
               CALL adep150_drop_temp5() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp5() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)               
         CALL adep150_process5(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp5() RETURNING l_success

      WHEN '6'
         IF adep150_create_temp6() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp6(lc_param.wc) THEN
               CALL adep150_drop_temp6() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp6() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)              
         CALL adep150_process6(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp6() RETURNING l_success
      WHEN '7'
         IF adep150_create_temp7() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp7(lc_param.wc) THEN
               CALL adep150_drop_temp7() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp7() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process7(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp7() RETURNING l_success
      WHEN '9'
         IF adep150_create_temp9() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp9(lc_param.wc) THEN
               CALL adep150_drop_temp9() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp9() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process9(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp9() RETURNING l_success

      WHEN '10'
         IF adep150_create_temp10() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp10(lc_param.wc) THEN
               CALL adep150_drop_temp10() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp10() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)            
         CALL adep150_process10(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp10() RETURNING l_success
      WHEN '11'
         IF adep150_create_temp11() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp11(lc_param.wc) THEN
               CALL adep150_drop_temp11() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp11() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)         
         CALL adep150_process11(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp11() RETURNING l_success
      WHEN '14'
         IF adep150_create_temp14() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp14(lc_param.wc) THEN
               CALL adep150_drop_temp14() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp14() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)        
         CALL adep150_process14(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp14() RETURNING l_success
      WHEN '15'
         IF adep150_create_temp15() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp15(lc_param.wc) THEN
               CALL adep150_drop_temp15() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp15() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)          
         CALL adep150_process15(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp15() RETURNING l_success

      WHEN '16'
         IF adep150_create_temp16() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp16(lc_param.wc) THEN
               CALL adep150_drop_temp16() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp16() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)          
         CALL adep150_process16(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp16() RETURNING l_success
      WHEN '17'
         IF adep150_create_temp17() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp17(lc_param.wc) THEN
               CALL adep150_drop_temp17() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp17() RETURNING l_success
            RETURN
         END IF    
      
         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)        
         CALL adep150_process17(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp17() RETURNING l_success
      WHEN '19'
         IF adep150_create_temp19() THEN
            LET l_msg = cl_getmsg('ade-00114',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF NOT adep150_ins_temp19(lc_param.wc) THEN
               CALL adep150_drop_temp19() RETURNING l_success
               RETURN
            END IF
         ELSE
            CALL adep150_drop_temp19() RETURNING l_success
            RETURN
         END IF    

         CALL cl_err_collect_init()
         CALL s_transaction_begin()  
         LET l_msg = cl_getmsg('ast-00330',g_lang)
         CALL cl_progress_no_window_ing(l_msg)        
         CALL adep150_process19(lc_param.l_del) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','1')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
         
         CALL adep150_drop_temp19() RETURNING l_success
         
      OTHERWISE
         #傳入的參數 沒有對應的相關後續程序
         
   END CASE
   
   
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
   CALL adep150_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep150.get_buffer" >}
PRIVATE FUNCTION adep150_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.rtjadocdt = p_dialog.getFieldBuffer('rtjadocdt')
   LET g_master.l_del = p_dialog.getFieldBuffer('l_del')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep150.msgcentre_notify" >}
PRIVATE FUNCTION adep150_msgcentre_notify()
 
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
 
{<section id="adep150.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#門店單品週結
PRIVATE FUNCTION adep150_process0(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_decfsite          LIKE decf_t.decfsite
   DEFINE l_decf041           LIKE decf_t.decf041
   DEFINE l_decf042           LIKE decf_t.decf042
   DEFINE l_decgsite          LIKE decg_t.decgsite
   DEFINE l_decg035           LIKE decg_t.decg035
   DEFINE l_decg036           LIKE decg_t.decg036
   
   LET r_success = TRUE  
   
   #decf_t已結轉資料 
   DECLARE adep150_decf_cs1 CURSOR FOR
    SELECT DISTINCT a.decfsite,a.decf041,a.decf042
      FROM adep150_tmp01 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
     WHERE EXISTS (SELECT 1 FROM decf_t b
             WHERE b.decfent  = a.decfent
               AND b.decfsite = a.decfsite
               AND b.decf041  = a.decf041 
               AND b.decf042  = a.decf042 ) 

   #decg_t已結轉資料
   DECLARE adep150_decg_cs1 CURSOR FOR
    SELECT DISTINCT a.decgsite,a.decg035,a.decg036
      FROM adep150_tmp02 a      #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
     WHERE EXISTS (SELECT 1 FROM decg_t b
                    WHERE a.decgent  = b.decgent    
                      AND a.decgsite = b.decgsite   
                      AND a.decg035  = b.decg035    
                      AND a.decg036  = b.decg036)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp01 c  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
                        WHERE a.decgent  = c.decfent
                          AND a.decgsite = c.decfsite
                          AND a.decg035  = c.decf041 
                          AND a.decg036  = c.decf042 )

   IF p_del = "Y" THEN

      FOREACH adep150_decf_cs1 INTO l_decfsite,l_decf041,l_decf042
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decfsite
         LET g_errparam.replace[2] = l_decf041
         LET g_errparam.replace[3] = l_decf042
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decf_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp01 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
                  "         WHERE a.decfent  = b.decfent ",
                  "           AND a.decfsite = b.decfsite",
                  "           AND a.decf041  = b.decf041 ", 
                  "           AND a.decf042  = b.decf042 )" 
      PREPARE adep150_del_decf_prep1 FROM g_sql
      EXECUTE adep150_del_decf_prep1

      #塞資料                  
      INSERT INTO decf_t ( decfent, decfsite,decf001, decf005, decf006,
                           decf007, decf008, decf009, decf010, decf011,
                           decf012, decf013, decf014, decf015, decf016,
                           decf017, decf018, decf019, decf020, decf021,
                           decf022, decf023, decf024, decf025, decf026,
                           decf027, decf028, decf029, decf030, decf031,
                           decf032, decf033, decf034, decf035, decf036,
                           decf037, decf038, decf039, decf040, decf041,
                           decf042, decf043, decf044, decf045, decf046, 
                           decf047, decf048, decf049, decf051, decf052,
                           decf053, decf054)
      SELECT decfent, decfsite,decf001, decf005, decf006,
             decf007, decf008, decf009, decf010, decf011,
             decf012, decf013, decf014, decf015, decf016,
             decf017, decf018, decf019, decf020, decf021,
             decf022, decf023, decf024, decf025, decf026,
             decf027, decf028, decf029, decf030, decf031,
             decf032, decf033, decf034, decf035, decf036,
             decf037, decf038, decf039, decf040, decf041,
             decf042, decf043, decf044, decf045, decf046,
             decf047, decf048, decf049, decf051, decf052,
             decf053, decf054
        FROM adep150_tmp01   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decg_cs1 INTO l_decgsite,l_decg035,l_decg036
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decgsite
         LET g_errparam.replace[2] = l_decg035
         LET g_errparam.replace[3] = l_decg036
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decg_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp02 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
                  "                WHERE b.decgent  = a.decgent ",
                  "                  AND b.decgsite = a.decgsite",
                  "                  AND b.decg035  = a.decg035 ",
                  "                  AND b.decg036  = a.decg036)"
      PREPARE adep150_del_decg_prep1 FROM g_sql
      EXECUTE adep150_del_decg_prep1

      #塞資料                  
      INSERT INTO decg_t ( decgent,  decgsite, decg001, decg005, decg006,
                           decg007,  decg008,  decg009, decg010, decg011,
                           decg012,  decg013,  decg014, decg015, decg016,
                           decg017,  decg018,  decg019, decg020, decg021,   
                           decg022,  decg023,  decg024, decg025, decg026,
                           decg027,  decg028,  decg029, decg030, decg031, 
                           decg032,  decg033,  decg034, decg035, decg036,
                           decg037,  decg038,  decg039, decg040, decg041)
      SELECT decgent,  decgsite, decg001, decg005, decg006,
             decg007,  decg008,  decg009, decg010, decg011,
             decg012,  decg013,  decg014, decg015, decg016,
             decg017,  decg018,  decg019, decg020, decg021,   
             decg022,  decg023,  decg024, decg025, decg026,
             decg027,  decg028,  decg029, decg030, decg031, 
             decg032,  decg033,  decg034, decg035, decg036,
             decg037,  decg038,  decg039, decg040, decg041
        FROM adep150_tmp02  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_decf_cs1 INTO l_decfsite,l_decf041,l_decf042
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decfsite
         LET g_errparam.replace[2] = l_decf041
         LET g_errparam.replace[3] = l_decf042
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO decf_t ( decfent, decfsite,decf001, decf005, decf006,
                           decf007, decf008, decf009, decf010, decf011,
                           decf012, decf013, decf014, decf015, decf016,
                           decf017, decf018, decf019, decf020, decf021,
                           decf022, decf023, decf024, decf025, decf026,
                           decf027, decf028, decf029, decf030, decf031,
                           decf032, decf033, decf034, decf035, decf036,
                           decf037, decf038, decf039, decf040, decf041,
                           decf042, decf043, decf044, decf045, decf046, 
                           decf047, decf048, decf049, decf051, decf052,
                           decf053, decf054)
      SELECT a.decfent, a.decfsite, a.decf001, a.decf005, a.decf006,
             a.decf007, a.decf008,  a.decf009, a.decf010, a.decf011,
             a.decf012, a.decf013,  a.decf014, a.decf015, a.decf016,
             a.decf017, a.decf018,  a.decf019, a.decf020, a.decf021,
             a.decf022, a.decf023,  a.decf024, a.decf025, a.decf026,
             a.decf027, a.decf028,  a.decf029, a.decf030, a.decf031,
             a.decf032, a.decf033,  a.decf034, a.decf035, a.decf036,
             a.decf037, a.decf038,  a.decf039, a.decf040, a.decf041,
             a.decf042, a.decf043,  a.decf044, a.decf045, a.decf046,
             a.decf047, a.decf048,  a.decf049, a.decf051, a.decf052,
             a.decf053, a.decf054
        FROM adep150_tmp01 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
       WHERE NOT EXISTS (SELECT 1 FROM decf_t b
                          WHERE b.decfent  = a.decfent
                            AND b.decfsite = a.decfsite
                            AND b.decf041  = a.decf041 
                            AND b.decf042  = a.decf042 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decg_cs1 INTO l_decgsite,l_decg035,l_decg036
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decgsite
         LET g_errparam.replace[2] = l_decg035
         LET g_errparam.replace[3] = l_decg036
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO decg_t ( decgent,  decgsite, decg001, decg005, decg006,
                           decg007,  decg008,  decg009, decg010, decg011,
                           decg012,  decg013,  decg014, decg015, decg016,
                           decg017,  decg018,  decg019, decg020, decg021,   
                           decg022,  decg023,  decg024, decg025, decg026,
                           decg027,  decg028,  decg029, decg030, decg031, 
                           decg032,  decg033,  decg034, decg035, decg036,
                           decg037,  decg038,  decg039, decg040, decg041)
      SELECT a.decgent,  a.decgsite, a.decg001, a.decg005, a.decg006,
             a.decg007,  a.decg008,  a.decg009, a.decg010, a.decg011,
             a.decg012,  a.decg013,  a.decg014, a.decg015, a.decg016,
             a.decg017,  a.decg018,  a.decg019, a.decg020, a.decg021,   
             a.decg022,  a.decg023,  a.decg024, a.decg025, a.decg026,
             a.decg027,  a.decg028,  a.decg029, a.decg030, a.decg031, 
             a.decg032,  a.decg033,  a.decg034, a.decg035, a.decg036,
             a.decg037,  a.decg038,  a.decg039, a.decg040, a.decg041
        FROM adep150_tmp02 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
       WHERE NOT EXISTS (SELECT 1 FROM decg_t b
                          WHERE a.decgent  = b.decgent    
                            AND a.decgsite = b.decgsite   
                            AND a.decg035  = b.decg035    
                            AND a.decg036  = b.decg036)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店品類週結
PRIVATE FUNCTION adep150_process1(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dectsite          LIKE dect_t.dectsite
   DEFINE l_dect034           LIKE dect_t.dect034
   DEFINE l_dect035           LIKE dect_t.dect035
   DEFINE l_decusite          LIKE decu_t.decusite
   DEFINE l_decu025           LIKE decu_t.decu025
   DEFINE l_decu026           LIKE decu_t.decu026
   
   LET r_success = TRUE  
   
   #dect_t已結轉資料 
   DECLARE adep150_dect_cs1 CURSOR FOR
    SELECT DISTINCT a.dectsite,a.dect034,a.dect035
      FROM adep150_tmp04 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
     WHERE EXISTS (SELECT 1 FROM dect_t b
             WHERE b.dectent  = a.dectent
               AND b.dectsite = a.dectsite
               AND b.dect034  = a.dect034 
               AND b.dect035  = a.dect035 ) 

   #decu_t已結轉資料
   DECLARE adep150_decu_cs1 CURSOR FOR
    SELECT DISTINCT a.decusite,a.decu025,a.decu026
      FROM adep150_tmp05 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
     WHERE EXISTS (SELECT 1 FROM decu_t b
                    WHERE a.decuent  = b.decuent    
                      AND a.decusite = b.decusite   
                      AND a.decu025  = b.decu025    
                      AND a.decu026  = b.decu026)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp04 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
                        WHERE a.decuent  = c.dectent
                          AND a.decusite = c.dectsite
                          AND a.decu025  = c.dect034 
                          AND a.decu026  = c.dect035 )

   IF p_del = "Y" THEN

      FOREACH adep150_dect_cs1 INTO l_dectsite,l_dect034,l_dect035
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dectsite
         LET g_errparam.replace[2] = l_dect034
         LET g_errparam.replace[3] = l_dect035
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dect_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp04 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
                  "         WHERE a.dectent  = b.dectent ",
                  "           AND a.dectsite = b.dectsite",
                  "           AND a.dect034  = b.dect034 ", 
                  "           AND a.dect035  = b.dect035 )" 
      PREPARE adep150_del_dect_prep1 FROM g_sql
      EXECUTE adep150_del_dect_prep1

      #塞資料                  
      INSERT INTO dect_t ( dectent, dectsite,dect001, dect005, dect006,
                           dect007, dect008, dect009, dect010, dect011,
                           dect012, dect013, dect014, dect015, dect016,
                           dect017, dect018, dect019, dect020, dect021,
                           dect022, dect023, dect024, dect025, dect026,
                           dect027, dect028, dect029, dect030, dect031,
                           dect032, dect033, dect034, dect035, dect036,
                           dect037)
      SELECT dectent, dectsite,dect001, dect005, dect006,
             dect007, dect008, dect009, dect010, dect011,
             dect012, dect013, dect014, dect015, dect016,
             dect017, dect018, dect019, dect020, dect021,
             dect022, dect023, dect024, dect025, dect026,
             dect027, dect028, dect029, dect030, dect031,
             dect032, dect033, dect034, dect035, dect036,
             dect037
        FROM adep150_tmp04   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dect_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decu_cs1 INTO l_decusite,l_decu025,l_decu026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decusite
         LET g_errparam.replace[2] = l_decu025
         LET g_errparam.replace[3] = l_decu026
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decu_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp05 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
                  "                WHERE b.decuent  = a.decuent ",
                  "                  AND b.decusite = a.decusite",
                  "                  AND b.decu025  = a.decu025 ",
                  "                  AND b.decu026  = a.decu026)"
      PREPARE adep150_del_decu_prep1 FROM g_sql
      EXECUTE adep150_del_decu_prep1

      #塞資料                  
      INSERT INTO decu_t ( decuent,  decusite, decu001, decu005, decu006,
                           decu007,  decu008,  decu009, decu010, decu011,
                           decu012,  decu013,  decu014, decu015, decu016,
                           decu017,  decu018,  decu019, decu020, decu021,   
                           decu022,  decu023,  decu024, decu025, decu026,
                           decu027,  decu028)
      SELECT decuent,  decusite, decu001, decu005, decu006,
             decu007,  decu008,  decu009, decu010, decu011,
             decu012,  decu013,  decu014, decu015, decu016,
             decu017,  decu018,  decu019, decu020, decu021,   
             decu022,  decu023,  decu024, decu025, decu026,
             decu027,  decu028
        FROM adep150_tmp05  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decu_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dect_cs1 INTO l_dectsite,l_dect034,l_dect035
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dectsite
         LET g_errparam.replace[2] = l_dect034
         LET g_errparam.replace[3] = l_dect035
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dect_t ( dectent, dectsite,dect001, dect005, dect006,
                           dect007, dect008, dect009, dect010, dect011,
                           dect012, dect013, dect014, dect015, dect016,
                           dect017, dect018, dect019, dect020, dect021,
                           dect022, dect023, dect024, dect025, dect026,
                           dect027, dect028, dect029, dect030, dect031,
                           dect032, dect033, dect034, dect035, dect036,
                           dect037)
      SELECT a.dectent, a.dectsite, a.dect001, a.dect005, a.dect006,
             a.dect007, a.dect008,  a.dect009, a.dect010, a.dect011,
             a.dect012, a.dect013,  a.dect014, a.dect015, a.dect016,
             a.dect017, a.dect018,  a.dect019, a.dect020, a.dect021,
             a.dect022, a.dect023,  a.dect024, a.dect025, a.dect026,
             a.dect027, a.dect028,  a.dect029, a.dect030, a.dect031,
             a.dect032, a.dect033,  a.dect034, a.dect035, a.dect036,
             a.dect037
        FROM adep150_tmp04 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
       WHERE NOT EXISTS (SELECT 1 FROM dect_t b
                          WHERE b.dectent  = a.dectent
                            AND b.dectsite = a.dectsite
                            AND b.dect034  = a.dect034 
                            AND b.dect035  = a.dect035 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dect_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decu_cs1 INTO l_decusite,l_decu025,l_decu026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decusite
         LET g_errparam.replace[2] = l_decu025
         LET g_errparam.replace[3] = l_decu026
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO decu_t ( decuent,  decusite, decu001, decu005, decu006,
                           decu007,  decu008,  decu009, decu010, decu011,
                           decu012,  decu013,  decu014, decu015, decu016,
                           decu017,  decu018,  decu019, decu020, decu021,   
                           decu022,  decu023,  decu024, decu025, decu026,
                           decu027,  decu028)
      SELECT a.decuent,  a.decusite, a.decu001, a.decu005, a.decu006,
             a.decu007,  a.decu008,  a.decu009, a.decu010, a.decu011,
             a.decu012,  a.decu013,  a.decu014, a.decu015, a.decu016,
             a.decu017,  a.decu018,  a.decu019, a.decu020, a.decu021,   
             a.decu022,  a.decu023,  a.decu024, a.decu025, a.decu026,
             a.decu027,  a.decu028
        FROM adep150_tmp05 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
       WHERE NOT EXISTS (SELECT 1 FROM decu_t b
                          WHERE a.decuent  = b.decuent    
                            AND a.decusite = b.decusite   
                            AND a.decu025  = b.decu025    
                            AND a.decu026  = b.decu026)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decu_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
   
END FUNCTION
#門店庫區週結
PRIVATE FUNCTION adep150_process4(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dechsite          LIKE dech_t.dechsite
   DEFINE l_dech031           LIKE dech_t.dech031
   DEFINE l_dech032           LIKE dech_t.dech032
   DEFINE l_decisite          LIKE deci_t.decisite
   DEFINE l_deci027           LIKE deci_t.deci027
   DEFINE l_deci028           LIKE deci_t.deci028
   DEFINE l_decjsite          LIKE decj_t.decjsite
   DEFINE l_decj015           LIKE decj_t.decj015
   DEFINE l_decj016           LIKE decj_t.decj016
   
   LET r_success = TRUE  
   
   #dech_t已結轉資料 
   DECLARE adep150_dech_cs1 CURSOR FOR
    SELECT DISTINCT a.dechsite,a.dech031,a.dech032
      FROM adep150_tmp06 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
     WHERE EXISTS (SELECT 1 FROM dech_t b
             WHERE b.dechent  = a.dechent
               AND b.dechsite = a.dechsite
               AND b.dech031  = a.dech031 
               AND b.dech032  = a.dech032 ) 

   #deci_t已結轉資料
   DECLARE adep150_deci_cs1 CURSOR FOR
    SELECT DISTINCT a.decisite,a.deci027,a.deci028
      FROM adep150_tmp07 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
     WHERE EXISTS (SELECT 1 FROM deci_t b
                    WHERE a.decient  = b.decient    
                      AND a.decisite = b.decisite   
                      AND a.deci027  = b.deci027    
                      AND a.deci028  = b.deci028)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp06 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
                        WHERE a.decient  = c.dechent
                          AND a.decisite = c.dechsite
                          AND a.deci027  = c.dech031 
                          AND a.deci028  = c.dech032 )

   #decj_t已結轉資料
   DECLARE adep150_decj_cs1 CURSOR FOR
    SELECT DISTINCT a.decjsite,a.decj015,a.decj016
      FROM adep150_tmp08 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
     WHERE EXISTS (SELECT 1 FROM decj_t b
                    WHERE a.decjent  = b.decjent    
                      AND a.decjsite = b.decjsite   
                      AND a.decj015  = b.decj015    
                      AND a.decj016  = b.decj016)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp06 c  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
                        WHERE a.decjent  = c.dechent
                          AND a.decjsite = c.dechsite
                          AND a.decj015  = c.dech031 
                          AND a.decj016  = c.dech032 )

   IF p_del = "Y" THEN

      FOREACH adep150_dech_cs1 INTO l_dechsite,l_dech031,l_dech032
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dechsite
         LET g_errparam.replace[2] = l_dech031
         LET g_errparam.replace[3] = l_dech032
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dech_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp06 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
                  "         WHERE a.dechent  = b.dechent ",
                  "           AND a.dechsite = b.dechsite",
                  "           AND a.dech031  = b.dech031 ", 
                  "           AND a.dech032  = b.dech032 )" 
      PREPARE adep150_del_dech_prep1 FROM g_sql
      EXECUTE adep150_del_dech_prep1

      #塞資料                  
      INSERT INTO dech_t ( dechent, dechsite,dech001, dech005, dech006,
                           dech007, dech008, dech009, dech010, dech011,
                           dech012, dech013, dech014, dech015, dech016,
                           dech017, dech018, dech019, dech020, dech021,
                           dech022, dech023, dech024, dech025, dech026,
                           dech027, dech028, dech029, dech030, dech031,
                           dech032, dech033)
      SELECT dechent, dechsite,dech001, dech005, dech006,
             dech007, dech008, dech009, dech010, dech011,
             dech012, dech013, dech014, dech015, dech016,
             dech017, dech018, dech019, dech020, dech021,
             dech022, dech023, dech024, dech025, dech026,
             dech027, dech028, dech029, dech030, dech031,
             dech032, dech033
        FROM adep150_tmp06   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dech_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_deci_cs1 INTO l_decisite,l_deci027,l_deci028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decisite
         LET g_errparam.replace[2] = l_deci027
         LET g_errparam.replace[3] = l_deci028
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM deci_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp07 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
                  "                WHERE b.decient  = a.decient ",
                  "                  AND b.decisite = a.decisite",
                  "                  AND b.deci027  = a.deci027 ",
                  "                  AND b.deci028  = a.deci028)"
      PREPARE adep150_del_deci_prep1 FROM g_sql
      EXECUTE adep150_del_deci_prep1

      #塞資料                  
      INSERT INTO deci_t ( decient,  decisite, deci001, deci005, deci006,
                           deci007,  deci008,  deci009, deci010, deci011,
                           deci012,  deci013,  deci014, deci015, deci016,
                           deci017,  deci018,  deci019, deci020, deci021,   
                           deci022,  deci023,  deci024, deci025, deci026,
                           deci027,  deci028,  deci029)
      SELECT decient,  decisite, deci001, deci005, deci006,
             deci007,  deci008,  deci009, deci010, deci011,
             deci012,  deci013,  deci014, deci015, deci016,
             deci017,  deci018,  deci019, deci020, deci021,   
             deci022,  deci023,  deci024, deci025, deci026,
             deci027,  deci028,  deci029
        FROM adep150_tmp07     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deci_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decj_cs1 INTO l_decjsite,l_decj015,l_decj016
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decjsite
         LET g_errparam.replace[2] = l_decj015
         LET g_errparam.replace[3] = l_decj016
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decj_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp08 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
                  "                WHERE b.decjent  = a.decjent ",
                  "                  AND b.decjsite = a.decjsite",
                  "                  AND b.decj015  = a.decj015 ",
                  "                  AND b.decj016  = a.decj016)"
      PREPARE adep150_del_decj_prep1 FROM g_sql
      EXECUTE adep150_del_decj_prep1

      #塞資料                  
      INSERT INTO decj_t ( decjent,  decjsite, decj001, decj005, decj006,
                           decj007,  decj008,  decj009, decj010, decj011,
                           decj012,  decj013,  decj014, decj015, decj016)
      SELECT decjent,  decjsite, decj001, decj005, decj006,
             decj007,  decj008,  decj009, decj010, decj011,
             decj012,  decj013,  decj014, decj015, decj016 
        FROM adep150_tmp08   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dech_cs1 INTO l_dechsite,l_dech031,l_dech032
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dechsite
         LET g_errparam.replace[2] = l_dech031
         LET g_errparam.replace[3] = l_dech032
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dech_t ( dechent, dechsite,dech001, dech005, dech006,
                           dech007, dech008, dech009, dech010, dech011,
                           dech012, dech013, dech014, dech015, dech016,
                           dech017, dech018, dech019, dech020, dech021,
                           dech022, dech023, dech024, dech025, dech026,
                           dech027, dech028, dech029, dech030, dech031,
                           dech032, dech033)
      SELECT a.dechent, a.dechsite, a.dech001, a.dech005, a.dech006,
             a.dech007, a.dech008,  a.dech009, a.dech010, a.dech011,
             a.dech012, a.dech013,  a.dech014, a.dech015, a.dech016,
             a.dech017, a.dech018,  a.dech019, a.dech020, a.dech021,
             a.dech022, a.dech023,  a.dech024, a.dech025, a.dech026,
             a.dech027, a.dech028,  a.dech029, a.dech030, a.dech031,
             a.dech032, a.dech033 
        FROM adep150_tmp06 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
       WHERE NOT EXISTS (SELECT 1 FROM dech_t b
                          WHERE b.dechent  = a.dechent
                            AND b.dechsite = a.dechsite
                            AND b.dech031  = a.dech031 
                            AND b.dech032  = a.dech032 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dech_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_deci_cs1 INTO l_decisite,l_deci027,l_deci028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decisite
         LET g_errparam.replace[2] = l_deci027
         LET g_errparam.replace[3] = l_deci028
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO deci_t ( decient,  decisite, deci001, deci005, deci006,
                           deci007,  deci008,  deci009, deci010, deci011,
                           deci012,  deci013,  deci014, deci015, deci016,
                           deci017,  deci018,  deci019, deci020, deci021,   
                           deci022,  deci023,  deci024, deci025, deci026,
                           deci027,  deci028,  deci029)
      SELECT a.decient,  a.decisite, a.deci001, a.deci005, a.deci006,
             a.deci007,  a.deci008,  a.deci009, a.deci010, a.deci011,
             a.deci012,  a.deci013,  a.deci014, a.deci015, a.deci016,
             a.deci017,  a.deci018,  a.deci019, a.deci020, a.deci021,   
             a.deci022,  a.deci023,  a.deci024, a.deci025, a.deci026,
             a.deci027,  a.deci028,  a.deci029
        FROM adep150_tmp07 a      #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
       WHERE NOT EXISTS (SELECT 1 FROM deci_t b
                          WHERE a.decient  = b.decient    
                            AND a.decisite = b.decisite   
                            AND a.deci027  = b.deci027    
                            AND a.deci028  = b.deci028)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deci_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decj_cs1 INTO l_decjsite,l_decj015,l_decj016
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decjsite
         LET g_errparam.replace[2] = l_decj015
         LET g_errparam.replace[3] = l_decj016
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO decj_t ( decjent,  decjsite, decj001, decj005, decj006,
                           decj007,  decj008,  decj009, decj010, decj011,
                           decj012,  decj013,  decj014, decj015, decj016)
      SELECT decjent,  decjsite, decj001, decj005, decj006,
             decj007,  decj008,  decj009, decj010, decj011,
             decj012,  decj013,  decj014, decj015, decj016 
        FROM adep150_tmp08   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
       WHERE NOT EXISTS (SELECT 1 FROM decj_t b
                          WHERE a.decjent  = b.decjent    
                            AND a.decjsite = b.decjsite   
                            AND a.decj015  = b.decj015    
                            AND a.decj016  = b.decj016)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店專櫃週結
PRIVATE FUNCTION adep150_process5(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_decksite          LIKE deck_t.decksite
   DEFINE l_deck027           LIKE deck_t.deck027
   DEFINE l_deck028           LIKE deck_t.deck028
   DEFINE l_declsite          LIKE decl_t.declsite
   DEFINE l_decl023           LIKE decl_t.decl023
   DEFINE l_decl024           LIKE decl_t.decl024
   DEFINE l_decmsite          LIKE decm_t.decmsite
   DEFINE l_decm012           LIKE decm_t.decm012
   DEFINE l_decm013           LIKE decm_t.decm013
   
   LET r_success = TRUE  
   
   #deck_t已結轉資料 
   DECLARE adep150_deck_cs1 CURSOR FOR
    SELECT DISTINCT a.decksite,a.deck027,a.deck028
      FROM adep150_tmp09 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
     WHERE EXISTS (SELECT 1 FROM deck_t b
             WHERE b.deckent  = a.deckent
               AND b.decksite = a.decksite
               AND b.deck027  = a.deck027 
               AND b.deck028  = a.deck028 ) 

   #decl_t已結轉資料
   DECLARE adep150_decl_cs1 CURSOR FOR
    SELECT DISTINCT a.declsite,a.decl023,a.decl024
      FROM adep150_tmp10 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
     WHERE EXISTS (SELECT 1 FROM decl_t b
                    WHERE a.declent  = b.declent    
                      AND a.declsite = b.declsite   
                      AND a.decl023  = b.decl023    
                      AND a.decl024  = b.decl024)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp09 c  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
                        WHERE a.declent  = c.deckent
                          AND a.declsite = c.decksite
                          AND a.decl023  = c.deck027 
                          AND a.decl024  = c.deck028 )

   #decm_t已結轉資料
   DECLARE adep150_decm_cs1 CURSOR FOR
    SELECT DISTINCT a.decmsite,a.decm012,a.decm013
      FROM adep150_tmp11 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
     WHERE EXISTS (SELECT 1 FROM decm_t b
                    WHERE a.decment  = b.decment    
                      AND a.decmsite = b.decmsite   
                      AND a.decm012  = b.decm012    
                      AND a.decm013  = b.decm013)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp09 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
                        WHERE a.decment  = c.deckent
                          AND a.decmsite = c.decksite
                          AND a.decm012  = c.deck027 
                          AND a.decm013  = c.deck028 )

   IF p_del = "Y" THEN

      FOREACH adep150_deck_cs1 INTO l_decksite,l_deck027,l_deck028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decksite
         LET g_errparam.replace[2] = l_deck027
         LET g_errparam.replace[3] = l_deck028
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM deck_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp09 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
                  "         WHERE a.deckent  = b.deckent ",
                  "           AND a.decksite = b.decksite",
                  "           AND a.deck027  = b.deck027 ", 
                  "           AND a.deck028  = b.deck028 )" 
      PREPARE adep150_del_deck_prep1 FROM g_sql
      EXECUTE adep150_del_deck_prep1

      #塞資料                  
      INSERT INTO deck_t ( deckent, decksite,deck001, deck005, deck006,
                           deck007, deck008, deck009, deck010, deck011,
                           deck012, deck013, deck014, deck015, deck016,
                           deck017, deck018, deck019, deck020, deck021,
                           deck022, deck023, deck024, deck025, deck026,
                           deck027, deck028)
      SELECT deckent, decksite,deck001, deck005, deck006,
             deck007, deck008, deck009, deck010, deck011,
             deck012, deck013, deck014, deck015, deck016,
             deck017, deck018, deck019, deck020, deck021,
             deck022, deck023, deck024, deck025, deck026,
             deck027, deck028
        FROM adep150_tmp09   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deck_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decl_cs1 INTO l_declsite,l_decl023,l_decl024
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_declsite
         LET g_errparam.replace[2] = l_decl023
         LET g_errparam.replace[3] = l_decl024
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decl_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp10 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
                  "                WHERE b.declent  = a.declent ",
                  "                  AND b.declsite = a.declsite",
                  "                  AND b.decl023  = a.decl023 ",
                  "                  AND b.decl024  = a.decl024)"
      PREPARE adep150_del_decl_prep1 FROM g_sql
      EXECUTE adep150_del_decl_prep1

      #塞資料                  
      INSERT INTO decl_t ( declent,  declsite, decl001, decl005, decl006,
                           decl007,  decl008,  decl009, decl010, decl011,
                           decl012,  decl013,  decl014, decl015, decl016,
                           decl017,  decl018,  decl019, decl020, decl021,   
                           decl022,  decl023,  decl024)
      SELECT declent,  declsite, decl001, decl005, decl006,
             decl007,  decl008,  decl009, decl010, decl011,
             decl012,  decl013,  decl014, decl015, decl016,
             decl017,  decl018,  decl019, decl020, decl021,   
             decl022,  decl023,  decl024
        FROM adep150_tmp10   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decm_cs1 INTO l_decmsite,l_decm012,l_decm013
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decmsite
         LET g_errparam.replace[2] = l_decm012
         LET g_errparam.replace[3] = l_decm013
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decm_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp11 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
                  "                WHERE b.decment  = a.decment ",
                  "                  AND b.decmsite = a.decmsite",
                  "                  AND b.decm012  = a.decm012 ",
                  "                  AND b.decm013  = a.decm013)"
      PREPARE adep150_del_decm_prep1 FROM g_sql
      EXECUTE adep150_del_decm_prep1

      #塞資料                  
      INSERT INTO decm_t ( decment,  decmsite, decm001, decm005, decm006,
                           decm007,  decm008,  decm009, decm010, decm011,
                           decm012,  decm013)
      SELECT decment,  decmsite, decm001, decm005, decm006,
             decm007,  decm008,  decm009, decm010, decm011,
             decm012,  decm013
        FROM adep150_tmp11  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decm_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_deck_cs1 INTO l_decksite,l_deck027,l_deck028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decksite
         LET g_errparam.replace[2] = l_deck027
         LET g_errparam.replace[3] = l_deck028
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO deck_t ( deckent, decksite,deck001, deck005, deck006,
                           deck007, deck008, deck009, deck010, deck011,
                           deck012, deck013, deck014, deck015, deck016,
                           deck017, deck018, deck019, deck020, deck021,
                           deck022, deck023, deck024, deck025, deck026,
                           deck027, deck028)
      SELECT a.deckent, a.decksite, a.deck001, a.deck005, a.deck006,
             a.deck007, a.deck008,  a.deck009, a.deck010, a.deck011,
             a.deck012, a.deck013,  a.deck014, a.deck015, a.deck016,
             a.deck017, a.deck018,  a.deck019, a.deck020, a.deck021,
             a.deck022, a.deck023,  a.deck024, a.deck025, a.deck026,
             a.deck027, a.deck028
        FROM adep150_tmp09 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
       WHERE NOT EXISTS (SELECT 1 FROM deck_t b
                          WHERE b.deckent  = a.deckent
                            AND b.decksite = a.decksite
                            AND b.deck027  = a.deck027 
                            AND b.deck028  = a.deck028 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deck_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decl_cs1 INTO l_declsite,l_decl023,l_decl024
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_declsite
         LET g_errparam.replace[2] = l_decl023
         LET g_errparam.replace[3] = l_decl024
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO decl_t ( declent,  declsite, decl001, decl005, decl006,
                           decl007,  decl008,  decl009, decl010, decl011,
                           decl012,  decl013,  decl014, decl015, decl016,
                           decl017,  decl018,  decl019, decl020, decl021,   
                           decl022,  decl023,  decl024)
      SELECT a.declent,  a.declsite, a.decl001, a.decl005, a.decl006,
             a.decl007,  a.decl008,  a.decl009, a.decl010, a.decl011,
             a.decl012,  a.decl013,  a.decl014, a.decl015, a.decl016,
             a.decl017,  a.decl018,  a.decl019, a.decl020, a.decl021,   
             a.decl022,  a.decl023,  a.decl024
        FROM adep150_tmp10 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
       WHERE NOT EXISTS (SELECT 1 FROM decl_t b
                          WHERE a.declent  = b.declent    
                            AND a.declsite = b.declsite   
                            AND a.decl023  = b.decl023    
                            AND a.decl024  = b.decl024)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decm_cs1 INTO l_decmsite,l_decm012,l_decm013
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decmsite
         LET g_errparam.replace[2] = l_decm012
         LET g_errparam.replace[3] = l_decm013
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO decm_t ( decment,  decmsite, decm001, decm005, decm006,
                           decm007,  decm008,  decm009, decm010, decm011,
                           decm012,  decm013)
      SELECT decment,  decmsite, decm001, decm005, decm006,
             decm007,  decm008,  decm009, decm010, decm011,
             decm012,  decm013
        FROM adep150_tmp11   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
       WHERE NOT EXISTS (SELECT 1 FROM decm_t b
                          WHERE a.decment  = b.decment    
                            AND a.decmsite = b.decmsite   
                            AND a.decm012  = b.decm012    
                            AND a.decm013  = b.decm013)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decm_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店部門週結
PRIVATE FUNCTION adep150_process6(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_decnsite          LIKE decn_t.decnsite
   DEFINE l_decn024           LIKE decn_t.decn024
   DEFINE l_decn025           LIKE decn_t.decn025
   DEFINE l_decosite          LIKE deco_t.decosite
   DEFINE l_deco021           LIKE deco_t.deco021
   DEFINE l_deco022           LIKE deco_t.deco022
   DEFINE l_decpsite          LIKE decp_t.decpsite
   DEFINE l_decp009           LIKE decp_t.decp009
   DEFINE l_decp010           LIKE decp_t.decp010
   
   LET r_success = TRUE  
   
   #decn_t已結轉資料 
   DECLARE adep150_decn_cs1 CURSOR FOR
    SELECT DISTINCT a.decnsite,a.decn024,a.decn025
      FROM adep150_tmp12 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
     WHERE EXISTS (SELECT 1 FROM decn_t b
             WHERE b.decnent  = a.decnent
               AND b.decnsite = a.decnsite
               AND b.decn024  = a.decn024 
               AND b.decn025  = a.decn025 ) 

   #deco_t已結轉資料
   DECLARE adep150_deco_cs1 CURSOR FOR
    SELECT DISTINCT a.decosite,a.deco021,a.deco022
      FROM adep150_tmp13 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
     WHERE EXISTS (SELECT 1 FROM deco_t b
                    WHERE a.decoent  = b.decoent    
                      AND a.decosite = b.decosite   
                      AND a.deco021  = b.deco021    
                      AND a.deco022  = b.deco022)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp12 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
                        WHERE a.decoent  = c.decnent
                          AND a.decosite = c.decnsite
                          AND a.deco021  = c.decn024 
                          AND a.deco022  = c.decn025 )

   #decp_t已結轉資料
   DECLARE adep150_decp_cs1 CURSOR FOR
    SELECT DISTINCT a.decpsite,a.decp009,a.decp010
      FROM adep150_tmp14 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
     WHERE EXISTS (SELECT 1 FROM decp_t b
                    WHERE a.decpent  = b.decpent    
                      AND a.decpsite = b.decpsite   
                      AND a.decp009  = b.decp009    
                      AND a.decp010  = b.decp010)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp12 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
                        WHERE a.decpent  = c.decnent
                          AND a.decpsite = c.decnsite
                          AND a.decp009  = c.decn024 
                          AND a.decp010  = c.decn025 )

   IF p_del = "Y" THEN

      FOREACH adep150_decn_cs1 INTO l_decnsite,l_decn024,l_decn025
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decnsite
         LET g_errparam.replace[2] = l_decn024
         LET g_errparam.replace[3] = l_decn025
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decn_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp12 b ",    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
                  "         WHERE a.decnent  = b.decnent ",
                  "           AND a.decnsite = b.decnsite",
                  "           AND a.decn024  = b.decn024 ", 
                  "           AND a.decn025  = b.decn025 )" 
      PREPARE adep150_del_decn_prep1 FROM g_sql
      EXECUTE adep150_del_decn_prep1

      #塞資料                  
      INSERT INTO decn_t ( decnent, decnsite,decn001, decn005, decn006,
                           decn007, decn008, decn009, decn010, decn011,
                           decn012, decn013, decn014, decn015, decn016,
                           decn017, decn018, decn019, decn020, decn021,
                           decn022, decn023, decn024, decn025)
      SELECT decnent, decnsite,decn001, decn005, decn006,
             decn007, decn008, decn009, decn010, decn011,
             decn012, decn013, decn014, decn015, decn016,
             decn017, decn018, decn019, decn020, decn021,
             decn022, decn023, decn024, decn025
        FROM adep150_tmp12   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_deco_cs1 INTO l_decosite,l_deco021,l_deco022
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decosite
         LET g_errparam.replace[2] = l_deco021
         LET g_errparam.replace[3] = l_deco022
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM deco_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp13 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
                  "                WHERE b.decoent  = a.decoent ",
                  "                  AND b.decosite = a.decosite",
                  "                  AND b.deco021  = a.deco021 ",
                  "                  AND b.deco022  = a.deco022)"
      PREPARE adep150_del_deco_prep1 FROM g_sql
      EXECUTE adep150_del_deco_prep1

      #塞資料                  
      INSERT INTO deco_t ( decoent,  decosite, deco001, deco005, deco006,
                           deco007,  deco008,  deco009, deco010, deco011,
                           deco012,  deco013,  deco014, deco015, deco016,
                           deco017,  deco018,  deco019, deco020, deco021,   
                           deco022)
      SELECT decoent,  decosite, deco001, deco005, deco006,
             deco007,  deco008,  deco009, deco010, deco011,
             deco012,  deco013,  deco014, deco015, deco016,
             deco017,  deco018,  deco019, deco020, deco021,   
             deco022
        FROM adep150_tmp13  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deco_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decp_cs1 INTO l_decpsite,l_decp009,l_decp010
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decpsite
         LET g_errparam.replace[2] = l_decp009
         LET g_errparam.replace[3] = l_decp010
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decp_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp14 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
                  "                WHERE b.decpent  = a.decpent ",
                  "                  AND b.decpsite = a.decpsite",
                  "                  AND b.decp009  = a.decp009 ",
                  "                  AND b.decp010  = a.decp010)"
      PREPARE adep150_del_decp_prep1 FROM g_sql
      EXECUTE adep150_del_decp_prep1

      #塞資料                  
      INSERT INTO decp_t ( decpent,  decpsite, decp001, decp005, decp006,
                           decp007,  decp008,  decp009, decp010)
      SELECT decpent,  decpsite, decp001, decp005, decp006,
             decp007,  decp008,  decp009, decp010
        FROM adep150_tmp14   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_decn_cs1 INTO l_decnsite,l_decn024,l_decn025
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decnsite
         LET g_errparam.replace[2] = l_decn024
         LET g_errparam.replace[3] = l_decn025
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO decn_t ( decnent, decnsite,decn001, decn005, decn006,
                           decn007, decn008, decn009, decn010, decn011,
                           decn012, decn013, decn014, decn015, decn016,
                           decn017, decn018, decn019, decn020, decn021,
                           decn022, decn023, decn024, decn025)
      SELECT a.decnent, a.decnsite, a.decn001, a.decn005, a.decn006,
             a.decn007, a.decn008,  a.decn009, a.decn010, a.decn011,
             a.decn012, a.decn013,  a.decn014, a.decn015, a.decn016,
             a.decn017, a.decn018,  a.decn019, a.decn020, a.decn021,
             a.decn022, a.decn023,  a.decn024, a.decn025
        FROM adep150_tmp12 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
       WHERE NOT EXISTS (SELECT 1 FROM decn_t b
                          WHERE b.decnent  = a.decnent
                            AND b.decnsite = a.decnsite
                            AND b.decn024  = a.decn024 
                            AND b.decn025  = a.decn025 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_deco_cs1 INTO l_decosite,l_deco021,l_deco022
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decosite
         LET g_errparam.replace[2] = l_deco021
         LET g_errparam.replace[3] = l_deco022
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO deco_t ( decoent,  decosite, deco001, deco005, deco006,
                           deco007,  deco008,  deco009, deco010, deco011,
                           deco012,  deco013,  deco014, deco015, deco016,
                           deco017,  deco018,  deco019, deco020, deco021,   
                           deco022)
      SELECT a.decoent,  a.decosite, a.deco001, a.deco005, a.deco006,
             a.deco007,  a.deco008,  a.deco009, a.deco010, a.deco011,
             a.deco012,  a.deco013,  a.deco014, a.deco015, a.deco016,
             a.deco017,  a.deco018,  a.deco019, a.deco020, a.deco021,   
             a.deco022
        FROM adep150_tmp13 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
       WHERE NOT EXISTS (SELECT 1 FROM deco_t b
                          WHERE a.decoent  = b.decoent    
                            AND a.decosite = b.decosite   
                            AND a.deco021  = b.deco021    
                            AND a.deco022  = b.deco022)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deco_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decp_cs1 INTO l_decpsite,l_decp009,l_decp010
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decpsite
         LET g_errparam.replace[2] = l_decp009
         LET g_errparam.replace[3] = l_decp010
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO decp_t ( decpent,  decpsite, decp001, decp005, decp006,
                           decp007,  decp008,  decp009, decp010)
      SELECT decpent,  decpsite, decp001, decp005, decp006,
             decp007,  decp008,  decp009, decp010
        FROM adep150_tmp14  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
       WHERE NOT EXISTS (SELECT 1 FROM decp_t b
                          WHERE a.decpent  = b.decpent    
                            AND a.decpsite = b.decpsite   
                            AND a.decp009  = b.decp009    
                            AND a.decp010  = b.decp010)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店週結
PRIVATE FUNCTION adep150_process7(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_decqsite          LIKE decq_t.decqsite
   DEFINE l_decq025           LIKE decq_t.decq025
   DEFINE l_decq026           LIKE decq_t.decq026
   DEFINE l_decrsite          LIKE decr_t.decrsite
   DEFINE l_decr020           LIKE decr_t.decr020
   DEFINE l_decr021           LIKE decr_t.decr021
   DEFINE l_decssite          LIKE decs_t.decssite
   DEFINE l_decs008           LIKE decs_t.decs008
   DEFINE l_decs009           LIKE decs_t.decs009
   
   LET r_success = TRUE  
   
   #decq_t已結轉資料 
   DECLARE adep150_decq_cs1 CURSOR FOR
    SELECT DISTINCT a.decqsite,a.decq025,a.decq026
      FROM adep150_tmp15 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
     WHERE EXISTS (SELECT 1 FROM decq_t b
             WHERE b.decqent  = a.decqent
               AND b.decqsite = a.decqsite
               AND b.decq025  = a.decq025 
               AND b.decq026  = a.decq026 ) 

   #decr_t已結轉資料
   DECLARE adep150_decr_cs1 CURSOR FOR
    SELECT DISTINCT a.decrsite,a.decr020,a.decr021
      FROM adep150_tmp16 a       #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
     WHERE EXISTS (SELECT 1 FROM decr_t b
                    WHERE a.decrent  = b.decrent    
                      AND a.decrsite = b.decrsite   
                      AND a.decr020  = b.decr020    
                      AND a.decr021  = b.decr021)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp15 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
                        WHERE a.decrent  = c.decqent
                          AND a.decrsite = c.decqsite
                          AND a.decr020  = c.decq025 
                          AND a.decr021  = c.decq026 )

   #decs_t已結轉資料
   DECLARE adep150_decs_cs1 CURSOR FOR
    SELECT DISTINCT a.decssite,a.decs008,a.decs009
      FROM adep150_tmp17 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
     WHERE EXISTS (SELECT 1 FROM decs_t b
                    WHERE a.decsent  = b.decsent    
                      AND a.decssite = b.decssite   
                      AND a.decs008  = b.decs008    
                      AND a.decs009  = b.decs009)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp15 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
                        WHERE a.decsent  = c.decqent
                          AND a.decssite = c.decqsite
                          AND a.decs008  = c.decq025 
                          AND a.decs009  = c.decq026 )

   IF p_del = "Y" THEN

      FOREACH adep150_decq_cs1 INTO l_decqsite,l_decq025,l_decq026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decqsite
         LET g_errparam.replace[2] = l_decq025
         LET g_errparam.replace[3] = l_decq026
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decq_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp15 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
                  "         WHERE a.decqent  = b.decqent ",
                  "           AND a.decqsite = b.decqsite",
                  "           AND a.decq025  = b.decq025 ", 
                  "           AND a.decq026  = b.decq026 )" 
      PREPARE adep150_del_decq_prep1 FROM g_sql
      EXECUTE adep150_del_decq_prep1

      #塞資料                  
      INSERT INTO decq_t ( decqent, decqsite,decq001, decq005, decq006,
                           decq007, decq008, decq009, decq010, decq011,
                           decq012, decq013, decq014, decq015, decq016,
                           decq017, decq018, decq019, decq020, decq023, 
                           decq024, decq025, decq026, decq027)
      SELECT decqent, decqsite,decq001, decq005, decq006,
             decq007, decq008, decq009, decq010, decq011,
             decq012, decq013, decq014, decq015, decq016,
             decq017, decq018, decq019, decq020, decq023, 
             decq024, decq025, decq026, decq027
        FROM adep150_tmp15   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decr_cs1 INTO l_decrsite,l_decr020,l_decr021
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decrsite
         LET g_errparam.replace[2] = l_decr020
         LET g_errparam.replace[3] = l_decr021
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decr_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp16 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
                  "                WHERE b.decrent  = a.decrent ",
                  "                  AND b.decrsite = a.decrsite",
                  "                  AND b.decr020  = a.decr020 ",
                  "                  AND b.decr021  = a.decr021)"
      PREPARE adep150_del_decr_prep1 FROM g_sql
      EXECUTE adep150_del_decr_prep1

      #塞資料                  
      INSERT INTO decr_t ( decrent,  decrsite, decr001, decr005, decr006,
                           decr007,  decr008,  decr009, decr010, decr011,
                           decr012,  decr013,  decr014, decr015, decr016,
                           decr017,  decr018,  decr019, decr020, decr021,
                           decr022)   
      SELECT decrent,  decrsite, decr001, decr005, decr006,
             decr007,  decr008,  decr009, decr010, decr011,
             decr012,  decr013,  decr014, decr015, decr016,
             decr017,  decr018,  decr019, decr020, decr021,
             decr022             
        FROM adep150_tmp16   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decr_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decs_cs1 INTO l_decssite,l_decs008,l_decs009
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decssite
         LET g_errparam.replace[2] = l_decs008
         LET g_errparam.replace[3] = l_decs009
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decs_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp17 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
                  "                WHERE b.decsent  = a.decsent ",
                  "                  AND b.decssite = a.decssite",
                  "                  AND b.decs008  = a.decs008 ",
                  "                  AND b.decs009  = a.decs009)"
      PREPARE adep150_del_decs_prep1 FROM g_sql
      EXECUTE adep150_del_decs_prep1

      #塞資料                  
      INSERT INTO decs_t ( decsent,  decssite, decs001, decs005, decs006,
                           decs007,  decs008,  decs009)
      SELECT decsent,  decssite, decs001, decs005, decs006,
             decs007,  decs008,  decs009
        FROM adep150_tmp17   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decs_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_decq_cs1 INTO l_decqsite,l_decq025,l_decq026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decqsite
         LET g_errparam.replace[2] = l_decq025
         LET g_errparam.replace[3] = l_decq026
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO decq_t ( decqent, decqsite,decq001, decq005, decq006,
                           decq007, decq008, decq009, decq010, decq011,
                           decq012, decq013, decq014, decq015, decq016,
                           decq017, decq018, decq019, decq020, decq023,
                           decq024, decq025, decq026, decq027)
      SELECT a.decqent, a.decqsite, a.decq001, a.decq005, a.decq006,
             a.decq007, a.decq008,  a.decq009, a.decq010, a.decq011,
             a.decq012, a.decq013,  a.decq014, a.decq015, a.decq016,
             a.decq017, a.decq018,  a.decq019, a.decq020, a.decq023,
             a.decq024, a.decq025,  a.decq026, a.decq027
        FROM adep150_tmp15 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
       WHERE NOT EXISTS (SELECT 1 FROM decq_t b
                          WHERE b.decqent  = a.decqent
                            AND b.decqsite = a.decqsite
                            AND b.decq025  = a.decq025 
                            AND b.decq026  = a.decq026 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decr_cs1 INTO l_decrsite,l_decr020,l_decr021
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decrsite
         LET g_errparam.replace[2] = l_decr020
         LET g_errparam.replace[3] = l_decr021
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO decr_t ( decrent,  decrsite, decr001, decr005, decr006,
                           decr007,  decr008,  decr009, decr010, decr011,
                           decr012,  decr013,  decr014, decr015, decr016,
                           decr017,  decr018,  decr019, decr020, decr021,
                           decr022 )   
      SELECT a.decrent,  a.decrsite, a.decr001, a.decr005, a.decr006,
             a.decr007,  a.decr008,  a.decr009, a.decr010, a.decr011,
             a.decr012,  a.decr013,  a.decr014, a.decr015, a.decr016,
             a.decr017,  a.decr018,  a.decr019, a.decr020, a.decr021,
             a.decr022
        FROM adep150_tmp16 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
       WHERE NOT EXISTS (SELECT 1 FROM decr_t b
                          WHERE a.decrent  = b.decrent    
                            AND a.decrsite = b.decrsite   
                            AND a.decr020  = b.decr020    
                            AND a.decr021  = b.decr021)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decr_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decs_cs1 INTO l_decssite,l_decs008,l_decs009
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decssite
         LET g_errparam.replace[2] = l_decs008
         LET g_errparam.replace[3] = l_decs009
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO decs_t ( decsent,  decssite, decs001, decs005, decs006,
                           decs007,  decs008,  decs009)
      SELECT decsent,  decssite, decs001, decs005, decs006,
             decs007,  decs008,  decs009
        FROM adep150_tmp17   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
       WHERE NOT EXISTS (SELECT 1 FROM decs_t b
                          WHERE a.decsent  = b.decsent    
                            AND a.decssite = b.decssite   
                            AND a.decs008  = b.decs008    
                            AND a.decs009  = b.decs009)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decs_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
   
END FUNCTION
#收入收款週結
PRIVATE FUNCTION adep150_process9(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_decvsite          LIKE decv_t.decvsite
   DEFINE l_decv019           LIKE decv_t.decv019
   DEFINE l_decv020           LIKE decv_t.decv020
   DEFINE l_decwsite          LIKE decw_t.decwsite
   DEFINE l_decw019           LIKE decw_t.decw019
   DEFINE l_decw020           LIKE decw_t.decw020
   
   LET r_success = TRUE  
   
   #decv_t已結轉資料 
   DECLARE adep150_decv_cs1 CURSOR FOR
    SELECT DISTINCT a.decvsite,a.decv019,a.decv020
      FROM adep150_tmp18 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
     WHERE EXISTS (SELECT 1 FROM decv_t b
             WHERE b.decvent  = a.decvent
               AND b.decvsite = a.decvsite
               AND b.decv019  = a.decv019 
               AND b.decv020  = a.decv020 ) 

   #decw_t已結轉資料
   DECLARE adep150_decw_cs1 CURSOR FOR
    SELECT DISTINCT a.decwsite,a.decw019,a.decw020
      FROM adep150_tmp19 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
     WHERE EXISTS (SELECT 1 FROM decw_t b
                    WHERE a.decwent  = b.decwent    
                      AND a.decwsite = b.decwsite   
                      AND a.decw019  = b.decw019    
                      AND a.decw020  = b.decw020)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp18 c    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
                        WHERE a.decwent  = c.decvent
                          AND a.decwsite = c.decvsite
                          AND a.decw019  = c.decv019 
                          AND a.decw020  = c.decv020 )

   IF p_del = "Y" THEN

      FOREACH adep150_decv_cs1 INTO l_decvsite,l_decv019,l_decv020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decvsite
         LET g_errparam.replace[2] = l_decv019
         LET g_errparam.replace[3] = l_decv020
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decv_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp18 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
                  "         WHERE a.decvent  = b.decvent ",
                  "           AND a.decvsite = b.decvsite",
                  "           AND a.decv019  = b.decv019 ", 
                  "           AND a.decv020  = b.decv020 )" 
      PREPARE adep150_del_decv_prep1 FROM g_sql
      EXECUTE adep150_del_decv_prep1

      #塞資料                  
      INSERT INTO decv_t ( decvent, decvsite,decv001, decv002, decv004,
                           decv005, decv006, decv007, decv008, decv009,
                           decv010, decv011, decv012, decv013, decv014,
                           decv015, decv016, decv017, decv018, decv019,
                           decv020)
      SELECT decvent, decvsite,decv001, decv002, decv004,
             decv005, decv006, decv007, decv008, decv009, 
             decv010, decv011, decv012, decv013, decv014,
             decv015, decv016, decv017, decv018, decv019,
             decv020
        FROM adep150_tmp18   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decv_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decw_cs1 INTO l_decwsite,l_decw019,l_decw020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decwsite
         LET g_errparam.replace[2] = l_decw019
         LET g_errparam.replace[3] = l_decw020
         LET g_errparam.code = 'ade-00121'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM decw_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp19 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
                  "                WHERE b.decwent  = a.decwent ",
                  "                  AND b.decwsite = a.decwsite",
                  "                  AND b.decw019  = a.decw019 ",
                  "                  AND b.decw020  = a.decw020)"
      PREPARE adep150_del_decw_prep1 FROM g_sql
      EXECUTE adep150_del_decw_prep1

      #塞資料                  
      INSERT INTO decw_t ( decwent,  decwsite, decw001, decw005, decw006,
                           decw007,  decw008,  decw009, decw010, decw011,
                           decw012,  decw013,  decw014, decw015, decw016,
                           decw017,  decw018,  decw019, decw020)
      SELECT decwent,  decwsite, decw001, decw005, decw006,
             decw007,  decw008,  decw009, decw010, decw011,
             decw012,  decw013,  decw014, decw015, decw016,
             decw017,  decw018,  decw019, decw020
        FROM adep150_tmp19   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decw_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_decv_cs1 INTO l_decvsite,l_decv019,l_decv020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decvsite
         LET g_errparam.replace[2] = l_decv019
         LET g_errparam.replace[3] = l_decv020
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO decv_t ( decvent, decvsite,decv001, decv002, decv004,
                           decv005, decv006, decv007, decv008, decv009,
                           decv010, decv011, decv012, decv013, decv014,
                           decv015, decv016, decv017, decv018, decv019,
                           decv020)
      SELECT a.decvent, a.decvsite, a.decv001, a.decv002, a.decv004,
             a.decv005, a.decv006,  a.decv007, a.decv008, a.decv009,
             a.decv010, a.decv011,  a.decv012, a.decv013, a.decv014,
             a.decv015, a.decv016,  a.decv017, a.decv018, a.decv019,
             a.decv020
        FROM adep150_tmp18 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
       WHERE NOT EXISTS (SELECT 1 FROM decv_t b
                          WHERE b.decvent  = a.decvent
                            AND b.decvsite = a.decvsite
                            AND b.decv019  = a.decv019 
                            AND b.decv020  = a.decv020 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decv_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_decw_cs1 INTO l_decwsite,l_decw019,l_decw020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_decwsite
         LET g_errparam.replace[2] = l_decw019
         LET g_errparam.replace[3] = l_decw020
         LET g_errparam.code = 'ade-00122'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO decw_t ( decwent,  decwsite, decw001, decw005, decw006,
                           decw007,  decw008,  decw009, decw010, decw011,
                           decw012,  decw013,  decw014, decw015, decw016,
                           decw017,  decw018,  decw019, decw020)
      SELECT a.decwent,  a.decwsite, a.decw001, a.decw005, a.decw006,
             a.decw007,  a.decw008,  a.decw009, a.decw010, a.decw011,
             a.decw012,  a.decw013,  a.decw014, a.decw015, a.decw016,
             a.decw017,  a.decw018,  a.decw019, a.decw020
        FROM adep150_tmp19 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
       WHERE NOT EXISTS (SELECT 1 FROM decw_t b
                          WHERE a.decwent  = b.decwent    
                            AND a.decwsite = b.decwsite   
                            AND a.decw019  = b.decw019    
                            AND a.decw020  = b.decw020)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins decw_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_create_temp0()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp0() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp01(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      decfent         SMALLINT,  
      decfsite        VARCHAR(10),  
      decf001         VARCHAR(10),  
      decf005         VARCHAR(10),  
      decf006         VARCHAR(10),  
      decf007         VARCHAR(10),  
      decf008         VARCHAR(10),  
      decf009         VARCHAR(40),  
      decf010         VARCHAR(40),  
      decf011         VARCHAR(255),  
      decf012         VARCHAR(255),  
      decf013         VARCHAR(20),  
      decf014         VARCHAR(10),  
      decf015         VARCHAR(10),  
      decf016         VARCHAR(10),  
      decf017         VARCHAR(20),  
      decf018         VARCHAR(10),  
      decf019         DECIMAL(20,6),  
      decf020         VARCHAR(10),  
      decf021         DECIMAL(20,6),  
      decf022         DECIMAL(20,6),  
      decf023         DECIMAL(20,6),  
      decf024         DECIMAL(20,6),  
      decf025         DECIMAL(20,6),  
      decf026         DECIMAL(20,6),  
      decf027         DECIMAL(20,6),  
      decf028         DECIMAL(20,6),  
      decf029         DECIMAL(20,6),  
      decf030         DECIMAL(20,6),  
      decf031         DECIMAL(20,6),  
      decf032         DECIMAL(20,6),  
      decf033         DECIMAL(20,6),  
      decf034         DECIMAL(20,6),  
      decf035         DECIMAL(20,6),  
      decf036         DECIMAL(20,6),  
      decf037         DECIMAL(20,6),  
      decf038         DECIMAL(20,6),  
      decf039         DECIMAL(20,6),  
      decf040         DECIMAL(20,6),  
      decf041         INTEGER,  
      decf042         SMALLINT,  
      decf043         VARCHAR(256),  
      decf044         DECIMAL(20,6),  
      decf045         DECIMAL(20,6),  
      decf046         DECIMAL(20,6),  
      decf047         DECIMAL(20,6),
      decf048         DECIMAL(20,6),
      decf049         VARCHAR(10),
      decf051         DECIMAL(20,6),
      decf052         DECIMAL(20,6),
      decf053         VARCHAR(10),
      decf054         VARCHAR(20)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp01'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp02(     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      decgent         SMALLINT,  
      decgsite        VARCHAR(10),
      decg001         VARCHAR(10),
      decg005         VARCHAR(10),
      decg006         VARCHAR(10),
      decg007         VARCHAR(10),
      decg008         VARCHAR(10),
      decg009         VARCHAR(40),
      decg010         VARCHAR(40),
      decg011         VARCHAR(255),
      decg012         VARCHAR(255),
      decg013         VARCHAR(20),
      decg014         VARCHAR(10),
      decg015         VARCHAR(10),
      decg016         VARCHAR(10),
      decg017         VARCHAR(20),
      decg018         VARCHAR(10),
      decg019         VARCHAR(10),
      decg020         VARCHAR(10),
      decg021         VARCHAR(10),   
      decg022         DECIMAL(20,6),
      decg023         DECIMAL(20,6),
      decg024         DECIMAL(20,6),
      decg025         DECIMAL(20,6),
      decg026         DECIMAL(20,6),
      decg027         DECIMAL(20,6),
      decg028         DECIMAL(20,6),
      decg029         DECIMAL(20,6),
      decg030         DECIMAL(22,2),  
      decg031         DECIMAL(20,6),
      decg032         DECIMAL(20,6),
      decg033         DECIMAL(20,6),
      decg034         DECIMAL(20,6),
      decg035         INTEGER,
      decg036         SMALLINT,
      decg037         VARCHAR(256),
      decg038         DECIMAL(20,6),
      decg039         VARCHAR(10),
      decg040         VARCHAR(10),
      decg041         VARCHAR(20)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp02'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp03(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
      debaent         SMALLINT,  
      debasite        VARCHAR(10),  
      deba001         VARCHAR(10),  
      deba002         DATE,  
      deba003         SMALLINT,  
      deba004         SMALLINT,  
      deba005         VARCHAR(10),  
      deba006         VARCHAR(10),  
      deba007         VARCHAR(10),  
      deba008         VARCHAR(10),  
      deba009         VARCHAR(40),  
      deba010         VARCHAR(40),        
      deba011         VARCHAR(255),  
      deba012         VARCHAR(255),  
      deba013         VARCHAR(20),  
      deba014         VARCHAR(10),  
      deba015         VARCHAR(10),  
      deba016         VARCHAR(10),  
      deba017         VARCHAR(20),  
      deba018         VARCHAR(10),  
      deba019         DECIMAL(20,6),  
      deba020         VARCHAR(10),       
      deba021         DECIMAL(20,6),  
      deba022         DECIMAL(20,6),  
      deba023         DECIMAL(20,6),  
      deba024         DECIMAL(20,6),  
      deba025         DECIMAL(20,6),  
      deba026         DECIMAL(20,6),  
      deba027         DECIMAL(20,6),  
      deba028         DECIMAL(20,6),  
      deba029         DECIMAL(20,6),  
      deba030         DECIMAL(20,6),        
      deba031         DECIMAL(20,6),  
      deba032         DECIMAL(20,6),  
      deba033         DECIMAL(20,6),  
      deba034         DECIMAL(20,6),  
      deba035         DECIMAL(20,6),  
      deba036         DECIMAL(20,6),  
      deba037         DECIMAL(20,6),  
      deba038         DECIMAL(20,6),  
      deba039         DECIMAL(20,6),  
      deba040         DECIMAL(20,6),        
      deba041         SMALLINT,  
      deba042         SMALLINT,  
      deba043         VARCHAR(256),  
      deba044         DECIMAL(20,6),  
      deba045         DECIMAL(20,6),  
      deba046         DECIMAL(20,6),  
      deba047         DECIMAL(20,6),
      deba048         DECIMAL(20,6),
      deba049         VARCHAR(10),
      deba050         DECIMAL(20,6),      
      deba051         DECIMAL(20,6),
      deba052         DECIMAL(20,6),
      deba053         VARCHAR(10),
      deba054         VARCHAR(20)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp03'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp1()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp1() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp04(  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      dectent         SMALLINT,  
      dectsite        VARCHAR(10),  
      dect001         VARCHAR(10),  
      dect005         VARCHAR(10),  
      dect006         VARCHAR(20),  
      dect007         VARCHAR(10),  
      dect008         VARCHAR(10),  
      dect009         VARCHAR(10),  
      dect010         DECIMAL(20,6),  
      dect011         DECIMAL(20,6),  
      dect012         DECIMAL(20,6),  
      dect013         DECIMAL(20,6),  
      dect014         DECIMAL(20,6),  
      dect015         DECIMAL(20,6),  
      dect016         DECIMAL(20,6),  
      dect017         DECIMAL(20,6),  
      dect018         DECIMAL(20,6),  
      dect019         DECIMAL(20,6),  
      dect020         DECIMAL(20,6),  
      dect021         DECIMAL(20,6),  
      dect022         DECIMAL(20,6),  
      dect023         DECIMAL(20,6),  
      dect024         DECIMAL(20,6),  
      dect025         DECIMAL(20,6),  
      dect026         DECIMAL(20,6),  
      dect027         DECIMAL(20,6),  
      dect028         DECIMAL(20,6),  
      dect029         DECIMAL(20,6),  
      dect030         DECIMAL(20,6),  
      dect031         DECIMAL(20,6),  
      dect032         DECIMAL(20,6),  
      dect033         DECIMAL(20,6),  
      dect034         INTEGER,  
      dect035         SMALLINT,
      dect036         DECIMAL(20,6),
      dect037         VARCHAR(1)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp04'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp05(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      decuent         SMALLINT,  
      decusite        VARCHAR(10),
      decu001         VARCHAR(10),
      decu005         VARCHAR(10),
      decu006         VARCHAR(20),
      decu007         VARCHAR(10),
      decu008         VARCHAR(10),
      decu009         VARCHAR(10),
      decu010         VARCHAR(10),
      decu011         VARCHAR(10),
      decu012         DECIMAL(20,6),
      decu013         DECIMAL(20,6),
      decu014         DECIMAL(20,6),
      decu015         DECIMAL(20,6),
      decu016         DECIMAL(20,6),
      decu017         DECIMAL(20,6),
      decu018         DECIMAL(20,6),
      decu019         DECIMAL(20,6),
      decu020         DECIMAL(22,2),
      decu021         DECIMAL(20,6),   
      decu022         DECIMAL(20,6),
      decu023         DECIMAL(20,6),
      decu024         DECIMAL(20,6),
      decu025         INTEGER,
      decu026         SMALLINT,
      decu027         DECIMAL(20,6),
      decu028         VARCHAR(1)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp05'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp4()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp4() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp06(  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      dechent         SMALLINT,  
      dechsite        VARCHAR(10),  
      dech001         VARCHAR(10),  
      dech005         VARCHAR(10),  
      dech006         VARCHAR(10),  
      dech007         VARCHAR(10),  
      dech008         VARCHAR(10),  
      dech009         VARCHAR(10),  
      dech010         VARCHAR(20),  
      dech011         VARCHAR(10),  
      dech012         DECIMAL(20,6),  
      dech013         DECIMAL(20,6),  
      dech014         DECIMAL(20,6),  
      dech015         DECIMAL(20,6),  
      dech016         DECIMAL(20,6),  
      dech017         DECIMAL(20,6),  
      dech018         DECIMAL(20,6),  
      dech019         DECIMAL(20,6),  
      dech020         DECIMAL(20,6),  
      dech021         DECIMAL(20,6),  
      dech022         DECIMAL(20,6),  
      dech023         DECIMAL(20,6),  
      dech024         DECIMAL(20,6),  
      dech025         DECIMAL(20,6),  
      dech026         DECIMAL(20,6),  
      dech027         DECIMAL(20,6),  
      dech028         DECIMAL(20,6),  
      dech029         DECIMAL(20,6),  
      dech030         DECIMAL(20,6),  
      dech031         INTEGER,  
      dech032         SMALLINT,
      dech033         DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp06'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp07(     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      decient         SMALLINT,  
      decisite        VARCHAR(10),
      deci001         VARCHAR(10),
      deci005         VARCHAR(10),
      deci006         VARCHAR(10),
      deci007         VARCHAR(10),
      deci008         VARCHAR(10),
      deci009         VARCHAR(10),
      deci010         VARCHAR(20),
      deci011         VARCHAR(10),
      deci012         VARCHAR(10),
      deci013         VARCHAR(10),
      deci014         DECIMAL(20,6),
      deci015         DECIMAL(20,6),
      deci016         DECIMAL(20,6),
      deci017         DECIMAL(20,6),
      deci018         DECIMAL(20,6),
      deci019         DECIMAL(20,6),
      deci020         DECIMAL(20,6),
      deci021         DECIMAL(20,6),   
      deci022         DECIMAL(22,2),
      deci023         DECIMAL(20,6),
      deci024         DECIMAL(20,6),
      deci025         DECIMAL(20,6),
      deci026         DECIMAL(20,6),
      deci027         INTEGER,
      deci028         SMALLINT,
      deci029         DECIMAL(20,6)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp07'    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp08(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      decjent         SMALLINT,  
      decjsite        VARCHAR(10),
      decj001         VARCHAR(10),
      decj005         VARCHAR(10),
      decj006         VARCHAR(10),
      decj007         VARCHAR(10),
      decj008         VARCHAR(10),
      decj009         VARCHAR(10),
      decj010         VARCHAR(20),
      decj011         VARCHAR(10),
      decj012         VARCHAR(10),
      decj013         VARCHAR(10),
      decj014         DECIMAL(20,6),
      decj015         INTEGER,
      decj016         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp08'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp5()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp5() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp09(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      deckent         SMALLINT,  
      decksite        VARCHAR(10),  
      deck001         VARCHAR(10),  
      deck005         VARCHAR(20),  
      deck006         VARCHAR(10),  
      deck007         VARCHAR(10),  
      deck008         VARCHAR(10),  
      deck009         DECIMAL(20,6),  
      deck010         DECIMAL(20,6),  
      deck011         DECIMAL(20,6),  
      deck012         DECIMAL(20,6),  
      deck013         DECIMAL(20,6),  
      deck014         DECIMAL(20,6),  
      deck015         DECIMAL(20,6),  
      deck016         DECIMAL(20,6),  
      deck017         DECIMAL(20,6),  
      deck018         DECIMAL(20,6),  
      deck019         DECIMAL(20,6),  
      deck020         DECIMAL(20,6),  
      deck021         DECIMAL(20,6),  
      deck022         DECIMAL(20,6),  
      deck023         DECIMAL(20,6),  
      deck024         DECIMAL(20,6),  
      deck025         DECIMAL(20,6),  
      deck026         DECIMAL(20,6),  
      deck027         INTEGER,  
      deck028         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp09'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp10(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      declent         SMALLINT,   
      declsite        VARCHAR(10),
      decl001         VARCHAR(10),
      decl005         VARCHAR(20),
      decl006         VARCHAR(10),
      decl007         VARCHAR(10),
      decl008         VARCHAR(10),
      decl009         VARCHAR(10),
      decl010         DECIMAL(20,6),
      decl011         DECIMAL(20,6),
      decl012         DECIMAL(20,6),
      decl013         DECIMAL(20,6),
      decl014         DECIMAL(20,6),
      decl015         DECIMAL(20,6),
      decl016         DECIMAL(20,6),
      decl017         DECIMAL(20,6),
      decl018         DECIMAL(22,2),
      decl019         DECIMAL(20,6),
      decl020         DECIMAL(20,6),
      decl021         DECIMAL(20,6),   
      decl022         DECIMAL(20,6),
      decl023         INTEGER,
      decl024         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp10'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   CREATE TEMP TABLE adep150_tmp11(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      decment         SMALLINT,  
      decmsite        VARCHAR(10),
      decm001         VARCHAR(10),
      decm005         VARCHAR(20),
      decm006         VARCHAR(10),
      decm007         VARCHAR(10),
      decm008         VARCHAR(10),
      decm009         VARCHAR(10),
      decm010         VARCHAR(10),
      decm011         DECIMAL(20,6),
      decm012         INTEGER,
      decm013         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp11'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp6()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp6() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp12(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      decnent         SMALLINT,  
      decnsite        VARCHAR(10),  
      decn001         VARCHAR(10),  
      decn005         VARCHAR(10),  
      decn006         DECIMAL(20,6),  
      decn007         DECIMAL(20,6),  
      decn008         DECIMAL(20,6),  
      decn009         DECIMAL(20,6),  
      decn010         DECIMAL(20,6),  
      decn011         DECIMAL(20,6),  
      decn012         DECIMAL(20,6),  
      decn013         DECIMAL(20,6),  
      decn014         DECIMAL(20,6),  
      decn015         DECIMAL(20,6),  
      decn016         DECIMAL(20,6),  
      decn017         DECIMAL(20,6),  
      decn018         DECIMAL(20,6),  
      decn019         DECIMAL(20,6),  
      decn020         DECIMAL(20,6),  
      decn021         DECIMAL(20,6),  
      decn022         DECIMAL(20,6),  
      decn023         DECIMAL(20,6),  
      decn024         INTEGER,  
      decn025         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp12'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp13(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      decoent         SMALLINT,  
      decosite        VARCHAR(10),
      deco001         VARCHAR(10),
      deco005         VARCHAR(10),
      deco006         VARCHAR(10),
      deco007         VARCHAR(10),
      deco008         DECIMAL(20,6),
      deco009         DECIMAL(20,6),
      deco010         DECIMAL(20,6),
      deco011         DECIMAL(20,6),
      deco012         DECIMAL(20,6),
      deco013         DECIMAL(20,6),
      deco014         DECIMAL(20,6),
      deco015         DECIMAL(20,6),
      deco016         DECIMAL(22,2),
      deco017         DECIMAL(20,6),
      deco018         DECIMAL(20,6),
      deco019         DECIMAL(20,6),
      deco020         DECIMAL(20,6),
      deco021         INTEGER,   
      deco022         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp13'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp14(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      decpent         SMALLINT,  
      decpsite        VARCHAR(10),
      decp001         VARCHAR(10),
      decp005         VARCHAR(10),
      decp006         VARCHAR(10),
      decp007         VARCHAR(10),
      decp008         DECIMAL(20,6),
      decp009         INTEGER,
      decp010         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp14'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp7()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp7() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp15(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      decqent         SMALLINT,  
      decqsite        VARCHAR(10),  
      decq001         VARCHAR(10),  
      decq005         DECIMAL(20,6),  
      decq006         DECIMAL(20,6),  
      decq007         DECIMAL(20,6),  
      decq008         DECIMAL(20,6),  
      decq009         DECIMAL(20,6),  
      decq010         DECIMAL(20,6),  
      decq011         DECIMAL(20,6),  
      decq012         DECIMAL(20,6),  
      decq013         DECIMAL(20,6),  
      decq014         DECIMAL(20,6),  
      decq015         DECIMAL(20,6),  
      decq016         DECIMAL(20,6),  
      decq017         DECIMAL(20,6),  
      decq018         DECIMAL(20,6),  
      decq019         DECIMAL(20,6),  
      decq020         DECIMAL(20,6),   
      decq023         DECIMAL(20,6),  
      decq024         DECIMAL(20,6),  
      decq025         INTEGER,
      decq026         SMALLINT,
      decq027         DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp15'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp16(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      decrent         SMALLINT,  
      decrsite        VARCHAR(10),
      decr001         VARCHAR(10),
      decr005         VARCHAR(10),
      decr006         VARCHAR(10),
      decr007         DECIMAL(20,6),
      decr008         DECIMAL(20,6),
      decr009         DECIMAL(20,6),
      decr010         DECIMAL(20,6),
      decr011         DECIMAL(20,6),
      decr012         DECIMAL(20,6),
      decr013         DECIMAL(20,6),
      decr014         DECIMAL(20,6),
      decr015         DECIMAL(22,2),
      decr016         DECIMAL(20,6),
      decr017         DECIMAL(20,6),
      decr018         DECIMAL(20,6),
      decr019         DECIMAL(20,6),
      decr020         INTEGER,
      decr021         SMALLINT,
      decr022         DECIMAL(20,6)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp16'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp17(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      decsent         SMALLINT,  
      decssite        VARCHAR(10),
      decs001         VARCHAR(10),
      decs005         VARCHAR(10),
      decs006         VARCHAR(10),
      decs007         DECIMAL(20,6),
      decs008         INTEGER,
      decs009         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp17'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 

END FUNCTION

PRIVATE FUNCTION adep150_create_temp9()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp9() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp18(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      decvent         SMALLINT,  
      decvsite        VARCHAR(10),  
      decv001         VARCHAR(10),  
      decv002         VARCHAR(10),  
      decv004         DECIMAL(20,6),  
      decv005         VARCHAR(40),  
      decv006         DECIMAL(20,6),  
      decv007         DATE,  
      decv008         VARCHAR(15),  
      decv009         VARCHAR(1),  
      decv010         VARCHAR(20),  
      decv011         VARCHAR(10),  
      decv012         DECIMAL(20,6),  
      decv013         VARCHAR(10),  
      decv014         DECIMAL(15,3),  
      decv015         VARCHAR(10),  
      decv016         DECIMAL(20,6),  
      decv017         DECIMAL(20,6),  
      decv018         DECIMAL(20,6),  
      decv019         INTEGER,  
      decv020         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp18'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp19(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      decwent         SMALLINT,  
      decwsite        VARCHAR(10),
      decw001         VARCHAR(10),
      decw005         VARCHAR(20),
      decw006         VARCHAR(10),
      decw007         VARCHAR(10),
      decw008         VARCHAR(10),
      decw009         DECIMAL(20,6),
      decw010         DECIMAL(20,6),
      decw011         DECIMAL(20,6),
      decw012         DECIMAL(20,6),
      decw013         DECIMAL(20,6),
      decw014         VARCHAR(10),
      decw015         DECIMAL(20,6),
      decw016         DECIMAL(20,6),
      decw017         DECIMAL(20,6),
      decw018         VARCHAR(10),
      decw019         INTEGER,
      decw020         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp19'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp0()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp01   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp01'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp02   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp02'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE adep150_tmp03  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp03'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp1()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp04  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
 
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp04'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp05   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp05'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_drop_temp4()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp06   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp06'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp07   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp07'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp08   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp08'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp5()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp09   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp09'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp10   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp10'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp11   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp11'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_drop_temp7()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp15   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp15'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp16   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp16'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp17   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp17'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp6()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp12   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp12'    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp13   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp13'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp14  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp14'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp9()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp18   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp18'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp19   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp19'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp0(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   DEFINE l_date         LIKE type_t.dat
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp01  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
   LET l_where = s_aooi500_sql_where(g_prog,'debasite') 
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debasite')
   
   LET l_sql = " INSERT INTO adep150_tmp01( decfent, decfsite,decf005, decf009, decf014, decf015,",    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
               "                                decf017, decf018, decf019, decf020, decf021, ",
               "                                decf022, decf023, decf024, decf025, decf026, ",
               "                                decf027, decf029, decf030, decf031, decf032, ",
               "                                decf033, decf034, decf035, decf036, decf037, ",
               "                                decf038, decf039, decf040, decf043, decf044, ",
               "                                decf045, decf046, decf047, decf049, decf053, ",
               "                                decf054  ) ",                
               " SELECT debaent,      debasite,     deba005,      deba009,  COALESCE(deba014,' ') ,   COALESCE(deba015,' '),",
               "        COALESCE(deba017,' '),    COALESCE(deba018,' '),    SUM(COALESCE(deba019,0)), COALESCE(deba020,' '),    SUM(COALESCE(deba021,0)),",
               "        SUM(COALESCE(deba022,0)), SUM(COALESCE(deba023,0)), SUM(COALESCE(deba024,0)), SUM(COALESCE(deba025,0)), SUM(COALESCE(deba026,0)),",
               "        SUM(COALESCE(deba027,0)), SUM(COALESCE(deba029,0)), SUM(COALESCE(deba030,0)), SUM(COALESCE(deba031,0)), SUM(COALESCE(deba032,0)),",
               "        SUM(COALESCE(deba033,0)), SUM(COALESCE(deba034,0)), SUM(COALESCE(deba035,0)), SUM(COALESCE(deba036,0)), SUM(COALESCE(deba037,0)),",
               "        SUM(COALESCE(deba038,0)), SUM(COALESCE(deba039,0)), SUM(COALESCE(deba040,0)), COALESCE(deba043,' '),    SUM(COALESCE(deba044,0)),",
               "        SUM(COALESCE(deba045,0)), SUM(COALESCE(deba046,0)), SUM(COALESCE(deba047,0)), COALESCE(deba049,' '),    COALESCE(deba053,' '), ",
               "        COALESCE(deba054,' ') ",
               "   FROM deba_t ",
               "  WHERE debaent = ",g_enterprise,
               "    AND deba002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debaent, debasite, deba005, deba009, deba014,",
               "           deba015, deba017,  deba018, deba020, deba043,",
               "           deba049, deba053,  deba054 "

   PREPARE adep150_ins_decf_temp_prep FROM l_sql
   EXECUTE adep150_ins_decf_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp01"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
   LET l_sql = "UPDATE adep150_tmp01 SET decf001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decfent AND ooef001 = decfsite),",
               "                            (decf010,decf013,decf016) = ( SELECT imaa014,imaa126,COALESCE(imaa009,' ')  ",
               "                                                           FROM imaa_t  ",
               "                                                          WHERE imaaent = decfent AND imaa001 = decf009), ",
               "                            (decf011,decf012) = (SELECT imaal003,imaal004 FROM imaal_t  ",
               "                                                  WHERE imaalent = decfent AND imaal001 = decf009 ",
               "                                                    AND imaal002 = '",g_dlang,"'),",
               "                            (decf006,decf007,decf008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = decfent AND inaasite = decfsite  ",
               "                                                            AND inaa001 = decf005 ), ",
               "                            decf028 = CASE WHEN decf027 = 0 THEN 0 ELSE (decf027 / (CASE WHEN decf026 = 0 THEN decf027 ELSE decf026 END) * 100) END,",
               "                            decf048 = decf026 / (CASE WHEN decf029 = 0 THEN 1 ELSE decf029 END), ",
               "                            decf041 = ",g_yearmonth,",",
               "                            decf042 = ",g_week

   PREPARE adep150_decf_upd FROM l_sql 
   EXECUTE adep150_decf_upd  
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp01"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #CREATE INDEX decf_temp_01 ON adep150_decf_temp(decfent,decfsite,decf041,decf042)  
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01   
   EXECUTE IMMEDIATE "CREATE INDEX decf_temp_01 
                          ON adep150_tmp01(decfent,decfsite,     
                                               COALESCE(decf006,' '), COALESCE(decf009,' '), COALESCE(decf014,' '), COALESCE(decf015,' '),
                                               COALESCE(decf017,' '), COALESCE(decf018,' '), COALESCE(decf020,' '), COALESCE(decf043,' '),
                                               COALESCE(decf049,' '), COALESCE(decf053,' '), COALESCE(decf054,' '))" 
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp01"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   IF cl_db_generate_analyze("adep150_tmp01") THEN END IF   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
   LET l_sql = " INSERT INTO adep150_tmp03( debaent, debasite,deba001, deba002, deba003, ",
               "                                deba004, deba005, deba006, deba007, deba008, ",
               "                                deba009, deba010, deba011, deba012, deba013, ",
               "                                deba014, deba015, deba016, deba017, deba018, ",
               "                                deba019, deba020, deba021, deba022, deba023, ",
               "                                deba024, deba025, deba026, deba027, deba028, ",
               "                                deba029, deba030, deba031, deba032, deba033, ",
               "                                deba034, deba035, deba036, deba037, deba038, ",
               "                                deba039, deba040, deba041, deba042, deba043, ",
               "                                deba044, deba045, deba046, deba047, deba048, ",
               "                                deba049, deba050, deba051, deba052, deba053, ",
               "                                deba054 ) ",
               " SELECT debaent, debasite, deba001, deba002, deba003, ",
               "        deba004, deba005,  deba006, deba007, deba008, ",
               "        deba009, deba010,  deba011, deba012, deba013, ",
               "        deba014, deba015,  deba016, deba017, deba018, ",
               "        deba019, deba020,  deba021, deba022, deba023, ",
               "        deba024, deba025,  deba026, deba027, deba028, ",
               "        deba029, deba030,  deba031, deba032, deba033, ",
               "        deba034, deba035,  deba036, deba037, deba038, ",
               "        deba039, deba040,  deba041, deba042, deba043, ",
               "        deba044, deba045,  deba046, deba047, deba048, ",
               "        deba049, deba050,  deba051, deba052, deba053, ",
               "        deba054 ",
               "   FROM deba_t ",
               "  WHERE debaent = ",g_enterprise,
               "    AND deba002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where 
   
   PREPARE adep150_ins_deba_temp_prep FROM l_sql
   EXECUTE adep150_ins_deba_temp_prep USING g_sdate,g_edate   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
   EXECUTE IMMEDIATE "CREATE INDEX deba_temp_01 
                          ON adep150_tmp03(debaent,debasite,deba002, 
                                               COALESCE(deba005,' '), COALESCE(deba009,' '), COALESCE(deba014,' '), COALESCE(deba015,' '),
                                               COALESCE(deba017,' '), COALESCE(deba018,' '), COALESCE(deba020,' '), COALESCE(deba043,' '),
                                               COALESCE(deba049,' '), COALESCE(deba053,' '), COALESCE(deba054,' '))" 
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp03"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   IF cl_db_generate_analyze("adep150_tmp03") THEN END IF   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp ——> adep150_tmp03
   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decf_temp ——> adep150_tmp01,adep150_deba_temp ——> adep150_tmp03
   LET l_sql = "UPDATE adep150_tmp01 ",
               "   SET (decf051,decf052) = ((SELECT SUM(COALESCE(deba051,0)),SUM(COALESCE(deba052,0)) FROM adep150_tmp03 ",
               "                              WHERE debaent = decfent  ",
               "                                AND debasite= decfsite ",
               "                                AND COALESCE(deba005,' ') = COALESCE(decf005,' ')  ",
               "                                AND COALESCE(deba009,' ') = COALESCE(decf009,' ')  ",
               "                                AND COALESCE(deba014,' ') = COALESCE(decf014,' ')  ",
               "                                AND COALESCE(deba015,' ') = COALESCE(decf015,' ')  ",
               "                                AND COALESCE(deba017,' ') = COALESCE(decf017,' ')  ",
               "                                AND COALESCE(deba018,' ') = COALESCE(decf018,' ')  ",
               "                                AND COALESCE(deba020,' ') = COALESCE(decf020,' ')  ",
               "                                AND COALESCE(deba043,' ') = COALESCE(decf043,' ')  ",
               "                                AND COALESCE(deba049,' ') = COALESCE(decf049,' ')  ",
               "                                AND COALESCE(deba053,' ') = COALESCE(decf053,' ')  ",
               "                                AND COALESCE(deba054,' ') = COALESCE(decf054,' ')  ",
               "                                AND deba002 = ? ))",  
               " WHERE decf051 IS NULL"
      
   PREPARE adep150_decf_upd2 FROM l_sql                
   LET l_date = g_edate
   WHILE TRUE
   
      EXECUTE adep150_decf_upd2 USING l_date
      
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE adep150_decf_temp2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_date = l_date - 1
      IF l_date < g_sdate THEN EXIT WHILE END IF
   END WHILE
   
    
   DELETE FROM adep150_tmp02   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02 
   LET l_where = s_aooi500_sql_where(g_prog,'debbsite')    
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debbsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
   LET l_sql = " INSERT INTO adep150_tmp02( decgent,  decgsite, decg005, decg009, ",
               "                                decg017,  decg018,  decg019, decg020, decg021,",   
               "                                decg022,  decg023,  decg024, decg025, decg026,",
               "                                decg027,  decg028,  decg030, decg031, decg032,",
               "                                decg033,  decg034,  decg037, decg039, decg040,",
               "                                decg041,  decg014,  decg015)",
               " SELECT debbent,       debbsite,      debb005,      debb009, ",
               "        debb017,       debb018,       debb019,      debb020,      debb021,",  
               "        SUM(COALESCE(debb022,0)),  SUM(COALESCE(debb023,0)),  SUM(COALESCE(debb024,0)), SUM(COALESCE(debb025,0)), SUM(COALESCE(debb026,0)),",
               "        SUM(COALESCE(debb027,0)),  SUM(COALESCE(debb028,0)),  SUM(COALESCE(debb030,0)), SUM(COALESCE(debb031,0)), SUM(COALESCE(debb032,0)),",
               "        SUM(COALESCE(debb033,0)),  SUM(COALESCE(debb034,0)),  COALESCE(debb035,' '),    COALESCE(debb037,' '),    COALESCE(debb038,' '),",
               "        COALESCE(debb039,' '),     COALESCE(debb014,' '),     COALESCE(debb015,' ') ",
               "   FROM debb_t ",
               "  WHERE debbent = ",g_enterprise,
               "    AND debb002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debbent, debbsite, debb005, debb009, debb017, ",
               "           debb018, debb019,  debb020, debb021, debb035, ",
               "           debb037, debb038,  debb039, debb014, debb015  "
                    
   PREPARE adep150_ins_decg_temp_prep FROM l_sql
   EXECUTE adep150_ins_decg_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp02"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
   LET l_sql = "UPDATE adep150_tmp02 SET decg001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decgent AND ooef001 = decgsite),",
               "                            (decg010,decg013,decg016) = ( SELECT imaa014,imaa126,COALESCE(imaa009,' ')  ",
               "                                                           FROM imaa_t  ",
               "                                                          WHERE imaaent = decgent AND imaa001 = decg009), ",
               "                            (decg011,decg012) = (SELECT imaal003,imaal004 FROM imaal_t  ",
               "                                                  WHERE imaalent = decgent AND imaal001 = decg009 ",
               "                                                    AND imaal002 = '",g_dlang,"'),",
               "                            (decg006,decg007,decg008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = decgent AND inaasite = decgsite  ",
               "                                                            AND inaa001 = decg005 ), ",
               "                            decg029 = CASE WHEN decg028 = 0 THEN 0 ELSE (decg028 / (CASE WHEN decg027 = 0 THEN decg028 ELSE decg027 END) * 100) END,",
               "                            decg038 = decg027 / (CASE WHEN decg031 = 0 THEN 1 ELSE decg031 END), ",
               "                            decg035 = ",g_yearmonth,",",
               "                            decg036 = ",g_week
   PREPARE adep150_decg_upd FROM l_sql 
   EXECUTE adep150_decg_upd
               
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp02"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decg_temp_01 ON adep150_tmp02(decgent,decgsite,decg035,decg036)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp02"    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decg_temp ——> adep150_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp1(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   
   DELETE FROM adep150_tmp04   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
   LET l_where = s_aooi500_sql_where(g_prog,'debssite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debssite')
   LET l_sql = " INSERT INTO adep150_tmp04( dectent, dectsite,dect005, dect006,",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
               "                                dect007, dect008, dect009, dect010, dect011,",
               "                                dect012, dect013, dect014, dect015, dect016,",
               "                                dect017, dect019, dect020, dect021, dect022,",
               "                                dect023, dect024, dect025, dect026, dect027,",
               "                                dect028, dect029, dect030, dect031, dect032,",
               "                                dect033, dect037)",
               " SELECT debsent,      debssite,     debs005,      debs006,     ",
               "        debs007,      debs008,      debs009,      SUM(COALESCE(debs010,0)),      SUM(COALESCE(debs011,0)),",
               "        SUM(COALESCE(debs012,0)), SUM(COALESCE(debs013,0)), SUM(COALESCE(debs014,0)), SUM(COALESCE(debs015,0)), SUM(COALESCE(debs016,0)),",
               "        SUM(COALESCE(debs017,0)), SUM(COALESCE(debs019,0)), SUM(COALESCE(debs020,0)), SUM(COALESCE(debs021,0)), SUM(COALESCE(debs022,0)),",
               "        SUM(COALESCE(debs023,0)), SUM(COALESCE(debs024,0)), SUM(COALESCE(debs025,0)), SUM(COALESCE(debs026,0)), SUM(COALESCE(debs027,0)),",
               "        SUM(COALESCE(debs028,0)), SUM(COALESCE(debs029,0)), SUM(COALESCE(debs030,0)), SUM(COALESCE(debs031,0)), SUM(COALESCE(debs032,0)),", 
               "        SUM(COALESCE(debs033,0)), debs035",
               "   FROM debs_t ",
               "  WHERE debsent = ", g_enterprise,
               "    AND debs002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debsent, debssite, debs005, debs006,",
               "           debs007, debs008,  debs009, debs035  "
               
   PREPARE adep150_ins_dect_temp_prep FROM l_sql
   EXECUTE adep150_ins_dect_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp04"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
   LET l_sql = "UPDATE adep150_tmp04 SET dect001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dectent AND ooef001 = dectsite),",
               "                             dect018 = CASE WHEN dect017 = 0 THEN 0 ELSE (dect017 / (CASE WHEN dect016 = 0 THEN dect017 ELSE dect016 END) * 100) END,",
               "                             dect036 = dect016 / (CASE WHEN dect019 = 0 THEN 1 ELSE dect019 END), ",
               "                             dect034 = ",g_yearmonth,",",
               "                             dect035 = ",g_week
   PREPARE adep150_dect_upd FROM l_sql 
   EXECUTE adep150_dect_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp04"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dect_temp_01 ON adep150_tmp04(dectent,dectsite,dect034,dect035)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp04"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dect_temp ——> adep150_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp05   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
   LET l_where = s_aooi500_sql_where(g_prog,'debtsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debtsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
   LET l_sql = " INSERT INTO adep150_tmp05( decuent,  decusite, decu001, decu005, decu006,",
               "                                decu007,  decu008,  decu009, decu010, decu011,",
               "                                decu012,  decu013,  decu014, decu015, decu016,",
               "                                decu017,  decu018,  decu020, decu021, decu022,",
               "                                decu023,  decu024,  decu028) ",
               " SELECT debtent,       debtsite,      debt001,      debt005,      debt006,     ",
               "        debt007,       debt008,       debt009,      debt010,      debt011,     ",
               "        SUM(COALESCE(debt012,0)),  SUM(COALESCE(debt013,0)),  SUM(COALESCE(debt014,0)), SUM(COALESCE(debt015,0)), SUM(COALESCE(debt016,0)),",
               "        SUM(COALESCE(debt017,0)),  SUM(COALESCE(debt018,0)),  SUM(COALESCE(debt020,0)), SUM(COALESCE(debt021,0)), SUM(COALESCE(debt022,0)),",
               "        SUM(COALESCE(debt023,0)),  SUM(COALESCE(debt024,0)),  debt026 ",
               "   FROM debt_t ",
               "  WHERE debtent = ",g_enterprise,
               "    AND debt002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debtent, debtsite, debt001, debt005, debt006,",
               "           debt007, debt008,  debt009, debt010, debt011, debt026"
               
   PREPARE adep150_ins_decu_temp_prep FROM l_sql
   EXECUTE adep150_ins_decu_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp05"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
   LET l_sql = "UPDATE adep150_tmp05 SET decu001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decuent AND ooef001 = decusite),",
               "                             decu019 = CASE WHEN decu018 = 0 THEN 0 ELSE (decu018 / (CASE WHEN decu017 = 0 THEN decu018 ELSE decu017 END) * 100) END,",
               "                             decu027 = decu017 / (CASE WHEN decu021 = 0 THEN 1 ELSE decu021 END), ",
               "                             decu025 = ",g_yearmonth,",",
               "                             decu026 = ",g_week
   PREPARE adep150_decu_upd FROM l_sql 
   EXECUTE adep150_decu_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp05"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decu_temp_01 ON adep150_tmp05(decuent,decusite,decu025,decu026)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp05"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decu_temp ——> adep150_tmp05
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp4(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp06   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
   LET l_where = s_aooi500_sql_where(g_prog,'debcsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debcsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
   LET l_sql = " INSERT INTO adep150_tmp06( dechent, dechsite,dech005, dech009, dech010, dech011,",
               "                                dech012, dech013, dech014, dech015, dech016,",
               "                                dech017, dech018, dech019, dech020, dech021,",
               "                                dech022, dech024, dech025, dech026, dech027,",
               "                                dech028, dech029, dech030)",
               " SELECT debcent,      debcsite,     debc005,      debc009,      debc010,      debc011,     ",
               "        SUM(COALESCE(debc012,0)), SUM(COALESCE(debc013,0)), SUM(COALESCE(debc014,0)), SUM(COALESCE(debc015,0)), SUM(COALESCE(debc016,0)),",
               "        SUM(COALESCE(debc017,0)), SUM(COALESCE(debc018,0)), SUM(COALESCE(debc019,0)), SUM(COALESCE(debc020,0)), SUM(COALESCE(debc021,0)),",
               "        SUM(COALESCE(debc022,0)), SUM(COALESCE(debc024,0)), SUM(COALESCE(debc025,0)), SUM(COALESCE(debc026,0)), SUM(COALESCE(debc027,0)),",
               "        SUM(COALESCE(debc028,0)), SUM(COALESCE(debc029,0)), SUM(COALESCE(debc030,0))",
               "   FROM debc_t",
               "  WHERE debcent = ",g_enterprise,
               "    AND debc002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debcent, debcsite, debc005, debc009, debc010, debc011 "
               
   PREPARE adep150_ins_dech_temp_prep FROM l_sql
   EXECUTE adep150_ins_dech_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp06"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql = "UPDATE adep150_tmp06 SET dech001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dechent AND ooef001 = dechsite),",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
               "                            (dech006,dech007,dech008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = dechent AND inaasite = dechsite  ",
               "                                                            AND inaa001 = dech005 ), ",
               "                            dech023 = CASE WHEN dech022 = 0 THEN 0 ELSE (dech022 / (CASE WHEN dech018 = 0 THEN dech022 ELSE dech018 END) * 100) END,",
               "                            dech033 = dech018 / (CASE WHEN dech024 = 0 THEN 1 ELSE dech024 END), ",
               "                            dech031 = ",g_yearmonth,",",
               "                            dech032 = ",g_week
   PREPARE adep150_dech_upd FROM l_sql 
   EXECUTE adep150_dech_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp06"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dech_temp_01 ON adep150_tmp06(dechent,dechsite,dech031,dech032)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp06"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dech_temp ——> adep150_tmp06
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp07    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
   LET l_where = s_aooi500_sql_where(g_prog,'debdsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debdsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
   LET l_sql = " INSERT INTO adep150_tmp07( decient,  decisite, deci005, deci009, deci010, deci011,",
               "                                deci012,  deci013,  deci014, deci015, deci016,",
               "                                deci017,  deci018,  deci019, deci020, deci022,",
               "                                deci023,  deci024,  deci025, deci026)",
               " SELECT debdent,      debdsite,      debd005,      debd009,       debd010,      debd011,",
               "        debd012,                   debd013,                   SUM(COALESCE(debd014,0)), SUM(COALESCE(debd015,0)), SUM(COALESCE(debd016,0)),",
               "        SUM(COALESCE(debd017,0)),  SUM(COALESCE(debd018,0)),  SUM(COALESCE(debd019,0)), SUM(COALESCE(debd020,0)), SUM(COALESCE(debd022,0)),",
               "        SUM(COALESCE(debd023,0)),  SUM(COALESCE(debd024,0)),  SUM(COALESCE(debd025,0)), SUM(COALESCE(debd026,0))",
               "   FROM debd_t",
               "  WHERE debdent = ",g_enterprise,
               "    AND debd002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debdent, debdsite, debd005, debd009, debd010, debd011,",
               "           debd012, debd013 "
   
   PREPARE adep150_ins_deci_temp_prep FROM l_sql
   EXECUTE adep150_ins_deci_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp07"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
   LET l_sql = "UPDATE adep150_tmp07 SET deci001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decient AND ooef001 = decisite),",
               "                            (deci006,deci007,deci008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = decient AND inaasite = decisite  ",
               "                                                            AND inaa001 = deci005 ), ",
               "                            deci021 = CASE WHEN deci020 = 0 THEN 0 ELSE (deci020 / (CASE WHEN deci019 = 0 THEN deci020 ELSE deci019 END) * 100) END,",
               "                            deci029 = deci019 / (CASE WHEN deci023 = 0 THEN 1 ELSE deci023 END), ",
               "                            deci027 = ",g_yearmonth,",",
               "                            deci028 = ",g_week
   PREPARE adep150_deci_upd FROM l_sql 
   EXECUTE adep150_deci_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp07"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX deci_temp_01 ON adep150_tmp07(decient,decisite,deci027,deci028)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp07"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deci_temp ——> adep150_tmp07
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp08   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
   LET l_where = s_aooi500_sql_where(g_prog,'debesite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debesite')
   LET l_sql = " INSERT INTO adep150_tmp08( decjent,  decjsite, decj005, decj009, decj010,",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
               "                                decj011,  decj012,  decj013, decj014) ",
               " SELECT debeent,       debesite,      debe005,       debe009,      debe010,",
               "        debe011,       debe012,       debe013,       SUM(COALESCE(debe014,0)) ",
               "   FROM debe_t ",
               "  WHERE debeent = ",g_enterprise,
               "    AND debe002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debeent, debesite, debe005, debe009, debe010,",
               "           debe011, debe012,  debe013 "

   PREPARE adep150_ins_decj_temp_prep FROM l_sql
   EXECUTE adep150_ins_decj_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp08"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
   LET l_sql = "UPDATE adep150_tmp08 SET decj001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decjent AND ooef001 = decjsite),",
               "                            (decj006,decj007,decj008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = decjent AND inaasite = decjsite  ",
               "                                                            AND inaa001 = decj005 ), ",
               "                            decj015 = ",g_yearmonth,",",
               "                            decj016 = ",g_week
   PREPARE adep150_decj_upd FROM l_sql 
   EXECUTE adep150_decj_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp08"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decj_temp_01 ON adep150_tmp08(decjent,decjsite,decj015,decj016)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp08"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decj_temp ——> adep150_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp5(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp09   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
   LET l_where = s_aooi500_sql_where(g_prog,'debgsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debgsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
   LET l_sql = " INSERT INTO adep150_tmp09( deckent, decksite,deck005, ",
               "                                deck007, deck008, deck009, deck010, deck011,",
               "                                deck012, deck013, deck014, deck015, deck016,",
               "                                deck017, deck018, deck020, deck021, deck022,",
               "                                deck023, deck024, deck025, deck026)",
               " SELECT debgent,      debgsite,        debg005,",
               "        debg007,                  debg008,                  SUM(COALESCE(debg009,0)), SUM(COALESCE(debg010,0)), SUM(COALESCE(debg011,0)),",
               "        SUM(COALESCE(debg012,0)), SUM(COALESCE(debg013,0)), SUM(COALESCE(debg014,0)), SUM(COALESCE(debg015,0)), SUM(COALESCE(debg016,0)),",
               "        SUM(COALESCE(debg017,0)), SUM(COALESCE(debg018,0)), SUM(COALESCE(debg020,0)), SUM(COALESCE(debg021,0)), SUM(COALESCE(debg022,0)),",
               "        SUM(COALESCE(debg023,0)), SUM(COALESCE(debg024,0)), SUM(COALESCE(debg025,0)), SUM(COALESCE(debg026,0))",
               "   FROM debg_t",
               "  WHERE debgent = ",g_enterprise,
               "    AND debg002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debgent, debgsite, debg005, debg007, debg008 "

   PREPARE adep150_ins_deck_temp_prep FROM l_sql
   EXECUTE adep150_ins_deck_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp09"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
   LET l_sql = "UPDATE adep150_tmp09 SET deck001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = deckent AND ooef001 = decksite),",
               "                             deck006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = deckent AND mhaesite = decksite AND mhae001 = deck005),", 
               "                             deck019 = CASE WHEN deck018 = 0 THEN 0 ELSE (deck018 / (CASE WHEN deck015 = 0 THEN deck018 ELSE deck015 END) * 100) END,",
               "                             deck027 = ",g_yearmonth,",",
               "                             deck028 = ",g_week
   PREPARE adep150_deck_upd FROM l_sql 
   EXECUTE adep150_deck_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp09"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX deck_temp_01 ON adep150_tmp09(deckent,decksite,deck027,deck028)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp09"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deck_temp ——> adep150_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp10   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
   LET l_where = s_aooi500_sql_where(g_prog,'debhsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debhsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
   LET l_sql = "INSERT INTO adep150_tmp10( declent,  declsite, decl005, decl006,",
               "                               decl007,  decl008,  decl009, decl010, decl011,",
               "                               decl012,  decl013,  decl014, decl015, decl016,",
               "                               decl018,  decl019,  decl020, decl021, decl022)",
               " SELECT debhent,       debhsite,         debh005,      debh006,",
               "        debh007,                   debh008,                   debh009,                  SUM(COALESCE(debh010,0)), SUM(COALESCE(debh011,0)),",
               "        SUM(COALESCE(debh012,0)),  SUM(COALESCE(debh013,0)),  SUM(COALESCE(debh014,0)), SUM(COALESCE(debh015,0)), SUM(COALESCE(debh016,0)),",
               "        SUM(COALESCE(debh018,0)),  SUM(COALESCE(debh019,0)),  SUM(COALESCE(debh020,0)), SUM(COALESCE(debh021,0)), SUM(COALESCE(debh022,0))",
               "   FROM debh_t",
               "  WHERE debhent = ",g_enterprise,
               "    AND debh002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debhent, debhsite, debh005, debh006,",
               "           debh007, debh008,  debh009"
               
   PREPARE adep150_ins_decl_temp_prep FROM l_sql
   EXECUTE adep150_ins_decl_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp10"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
   LET l_sql = "UPDATE adep150_tmp10 SET decl001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = declent AND ooef001 = declsite),",
               "                             decl017 = CASE WHEN decl016 = 0 THEN 0 ELSE (decl016 / (CASE WHEN decl015 = 0 THEN decl016 ELSE decl015 END) * 100) END,",
               "                             decl023 = ",g_yearmonth,",",
               "                             decl024 = ",g_week
   PREPARE adep150_decl_upd FROM l_sql 
   EXECUTE adep150_decl_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp10"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decl_temp_01 ON adep150_tmp10(declent,declsite,decl023,decl024)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp10"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decl_temp ——> adep150_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp11   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
   LET l_where = s_aooi500_sql_where(g_prog,'debisite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debisite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
   LET l_sql = " INSERT INTO adep150_tmp11( decment,  decmsite, decm005, ",
               "                                decm007,  decm008,  decm009, decm010, decm011) ",
               " SELECT debient,       debisite,      debi005, ",
               "        debi007,       debi008,       debi009,      debi010,      SUM(COALESCE(debi011,0))",
               "   FROM debi_t",
               "  WHERE debient = ",g_enterprise,
               "    AND debi002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debient, debisite, debi005, ",
               "           debi007, debi008,  debi009, debi010"
               
   PREPARE adep150_ins_decm_temp_prep FROM l_sql
   EXECUTE adep150_ins_decm_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp11"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
   LET l_sql = "UPDATE adep150_tmp11 SET decm001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decment AND ooef001 = decmsite),",
               "                             decm006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = decment AND mhaesite = decmsite AND mhae001 = decm005),", 
               "                             decm012 = ",g_yearmonth,",",
               "                             decm013 = ",g_week
   PREPARE adep150_decm_upd FROM l_sql 
   EXECUTE adep150_decm_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp11"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decm_temp_01 ON adep150_tmp11(decment,decmsite,decm012,decm013)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp11"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decm_temp ——> adep150_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success   

END FUNCTION

PRIVATE FUNCTION adep150_ins_temp6(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp12   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
   LET l_where = s_aooi500_sql_where(g_prog,'debksite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debksite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
   LET l_sql = " INSERT INTO adep150_tmp12( decnent, decnsite,decn005, decn006,",
               "                                decn007, decn008, decn009, decn010, decn011,",
               "                                decn012, decn013, decn014, decn015, decn017,",
               "                                decn018, decn019, decn020, decn021, decn022,",
               "                                decn023) ",
               " SELECT debkent,      debksite,       debk005,      SUM(COALESCE(debk006,0)),",
               "        SUM(COALESCE(debk007,0)), SUM(COALESCE(debk008,0)), SUM(COALESCE(debk009,0)), SUM(COALESCE(debk010,0)), SUM(COALESCE(debk011,0)),",
               "        SUM(COALESCE(debk012,0)), SUM(COALESCE(debk013,0)), SUM(COALESCE(debk014,0)), SUM(COALESCE(debk015,0)), SUM(COALESCE(debk017,0)),",
               "        SUM(COALESCE(debk018,0)), SUM(COALESCE(debk019,0)), SUM(COALESCE(debk020,0)), SUM(COALESCE(debk021,0)), SUM(COALESCE(debk022,0)),",
               "        SUM(COALESCE(debk023,0)) ",
               "   FROM debk_t",
               "  WHERE debkent = ",g_enterprise,
               "    AND debk002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debkent, debksite, debk005 "

   PREPARE adep150_ins_decn_temp_prep FROM l_sql
   EXECUTE adep150_ins_decn_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp12"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
   LET l_sql = "UPDATE adep150_tmp12 SET decn001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decnent AND ooef001 = decnsite),", 
               "                             decn016 = CASE WHEN decn015 = 0 THEN 0 ELSE (decn015 / (CASE WHEN decn011 = 0 THEN decn015 ELSE decn011 END) * 100) END,",
               "                             decn024 = ",g_yearmonth,",",
               "                             decn025 = ",g_week               
   PREPARE adep150_decn_upd FROM l_sql 
   EXECUTE adep150_decn_upd       
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp12"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decn_temp_01 ON adep150_tmp12(decnent,decnsite,decn024,decn025)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp12"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decn_temp ——> adep150_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp13   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
   LET l_where = s_aooi500_sql_where(g_prog,'deblsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','deblsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
   LET l_sql = " INSERT INTO adep150_tmp13( decoent,  decosite, deco005, deco006,",
               "                                deco007,  deco008,  deco009, deco010, deco011,",
               "                                deco012,  deco013,  deco014, deco016, deco017,",
               "                                deco018,  deco019,  deco020) ",
               " SELECT deblent,       deblsite,      debl005,      debl006, ",
               "        debl007,                   SUM(COALESCE(debl008,0)),  SUM(COALESCE(debl009,0)), SUM(COALESCE(debl010,0)), SUM(COALESCE(debl011,0)),",
               "        SUM(COALESCE(debl012,0)),  SUM(COALESCE(debl013,0)),  SUM(COALESCE(debl014,0)), SUM(COALESCE(debl016,0)), SUM(COALESCE(debl017,0)),",
               "        SUM(COALESCE(debl018,0)),  SUM(COALESCE(debl019,0)),  SUM(COALESCE(debl020,0))",
               "   FROM debl_t ",
               "  WHERE deblent = ",g_enterprise,
               "    AND debl002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY deblent, deblsite, debl005, debl006, debl007 "
                    
   PREPARE adep150_ins_deco_temp_prep FROM l_sql
   EXECUTE adep150_ins_deco_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp13"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
   LET l_sql = "UPDATE adep150_tmp13 SET deco001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decoent AND ooef001 = decosite),",
               "                             deco015 = CASE WHEN deco014 = 0 THEN 0 ELSE (deco014 / (CASE WHEN deco013 = 0 THEN deco014 ELSE deco013 END) * 100) END,",
               "                             deco021 = ",g_yearmonth,",",
               "                             deco022 = ",g_week
   PREPARE adep150_deco_upd FROM l_sql 
   EXECUTE adep150_deco_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp13"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX deco_temp_01 ON adep150_tmp13(decoent,decosite,deco021,deco022)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp13"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deco_temp ——> adep150_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp14   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
   LET l_where = s_aooi500_sql_where(g_prog,'debmsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debmsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
   LET l_sql = " INSERT INTO adep150_tmp14( decpent,  decpsite,  decp005, decp006,",
               "                                decp007,  decp008)",
               " SELECT debment,       debmsite,      debm005,      debm006,",
               "        debm007,       SUM(COALESCE(debm008,0))",
               "   FROM debm_t",
               "  WHERE debment = ",g_enterprise,
               "    AND debm002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debment, debmsite, debm005, debm006,  debm007"
               
   PREPARE adep150_ins_decp_temp_prep FROM l_sql
   EXECUTE adep150_ins_decp_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp14"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
   LET l_sql = "UPDATE adep150_tmp14 SET decp001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decpent AND ooef001 = decpsite),",
               "                             decp009 = ",g_yearmonth,",",
               "                             decp010 = ",g_week
   PREPARE adep150_decp_upd FROM l_sql 
   EXECUTE adep150_decp_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp14"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decp_temp_01 ON adep150_tmp14(decpent,decpsite,decp009,decp010)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp14"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decp_temp ——> adep150_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success  
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp7(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp15   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
   LET l_where = s_aooi500_sql_where(g_prog,'debosite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debosite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
   LET l_sql = " INSERT INTO adep150_tmp15( decqent, decqsite,decq005, decq006,",
               "                                decq007, decq008, decq009, decq010, decq011,",
               "                                decq012, decq013, decq014, decq016, decq017,",
               "                                decq018, decq019, decq020, decq023, decq024)",
               " SELECT deboent,                  debosite,                 SUM(COALESCE(debo005,0)), SUM(COALESCE(debo006,0)),",
               "        SUM(COALESCE(debo007,0)), SUM(COALESCE(debo008,0)), SUM(COALESCE(debo009,0)), SUM(COALESCE(debo010,0)), SUM(COALESCE(debo011,0)),",
               "        SUM(COALESCE(debo012,0)), SUM(COALESCE(debo013,0)), SUM(COALESCE(debo014,0)), SUM(COALESCE(debo016,0)), SUM(COALESCE(debo017,0)),",
               "        SUM(COALESCE(debo018,0)), SUM(COALESCE(debo019,0)), SUM(COALESCE(debo020,0)), SUM(COALESCE(debo023,0)), SUM(COALESCE(debo024,0)) ",
               "   FROM debo_t",
               "  WHERE deboent = ",g_enterprise,
               "    AND debo002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY deboent, debosite "
               
   PREPARE adep150_ins_decq_temp_prep FROM l_sql
   EXECUTE adep150_ins_decq_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp15"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
   LET l_sql = "UPDATE adep150_tmp15 SET decq001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decqent AND ooef001 = decqsite),",
               "                             decq015 = CASE WHEN decq014 = 0 THEN 0 ELSE (decq014 / (CASE WHEN decq010 = 0 THEN decq014 ELSE decq010 END) * 100) END,",
               "                             decq027 = decq010 / (CASE WHEN decq016 = 0 THEN 1 ELSE decq016 END), ",
               "                             decq025 = ",g_yearmonth,",",
               "                             decq026 = ",g_week
               
   PREPARE adep150_decq_upd FROM l_sql 
   EXECUTE adep150_decq_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp15"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decq_temp_01 ON adep150_tmp15(decqent,decqsite,decq025,decq026)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp15"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decq_temp ——> adep150_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp16   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
   LET l_where = s_aooi500_sql_where(g_prog,'debpsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debpsite')
   LET l_sql = " INSERT INTO adep150_tmp16( decrent,  decrsite, decr005, decr006,",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
               "                                decr007,  decr008,  decr009, decr010, decr011,",
               "                                decr012,  decr013,  decr015, decr016, decr017,",
               "                                decr018,  decr019)",
               " SELECT debpent,       debpsite,         debp005,      debp006,",
               "        SUM(COALESCE(debp007,0)),  SUM(COALESCE(debp008,0)),  SUM(COALESCE(debp009,0)), SUM(COALESCE(debp010,0)), SUM(COALESCE(debp011,0)),",
               "        SUM(COALESCE(debp012,0)),  SUM(COALESCE(debp013,0)),  SUM(COALESCE(debp015,0)), SUM(COALESCE(debp016,0)), SUM(COALESCE(debp017,0)),",
               "        SUM(COALESCE(debp018,0)),  SUM(COALESCE(debp019,0))",
               "   FROM debp_t",
               "  WHERE debpent = ",g_enterprise,
               "    AND debp002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debpent, debpsite, debp005, debp006 "

   PREPARE adep150_ins_decr_temp_prep FROM l_sql
   EXECUTE adep150_ins_decr_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp16"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
   LET l_sql = "UPDATE adep150_tmp16 SET decr001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decrent AND ooef001 = decrsite),",
               "                             decr014 = CASE WHEN decr013 = 0 THEN 0 ELSE (decr013 / (CASE WHEN decr012 = 0 THEN decr013 ELSE decr012 END) * 100) END,",
               "                             decr022 = decr012 / (CASE WHEN decr016 = 0 THEN 1 ELSE decr016 END), ",
               "                             decr020 = ",g_yearmonth,",",
               "                             decr021 = ",g_week
   PREPARE adep150_decr_upd FROM l_sql 
   EXECUTE adep150_decr_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp16"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decr_temp_01 ON adep150_tmp16(decrent,decrsite,decr020,decr021)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp16"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decr_temp ——> adep150_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp17   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
   LET l_where = s_aooi500_sql_where(g_prog,'debqsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debqsite')
    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
   LET l_sql = " INSERT INTO adep150_tmp17( decsent,  decssite,  decs005, decs006, decs007) ",
               " SELECT debqent,       debqsite,        debq005,      debq006,  SUM(COALESCE(debq007,0))",
               "   FROM debq_t",
               "  WHERE debqent = ",g_enterprise,
               "    AND debq002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debqent, debqsite,  debq005, debq006 "

   PREPARE adep150_ins_decs_temp_prep FROM l_sql
   EXECUTE adep150_ins_decs_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp17"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
   LET l_sql = "UPDATE adep150_tmp17 SET decs001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decsent AND ooef001 = decssite),",
               "                             decs008 = ",g_yearmonth,",",
               "                             decs009 = ",g_week
   PREPARE adep150_decs_upd FROM l_sql 
   EXECUTE adep150_decs_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp17"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decs_temp_01 ON adep150_tmp17(decsent,decssite,decs008,decs009)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp17"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decs_temp ——> adep150_tmp17
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp9(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   DEFINE l_init_date    LIKE type_t.dat
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp18   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
   LET l_where = s_aooi500_sql_where(g_prog,'debysite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debysite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
   LET l_sql = " INSERT INTO adep150_tmp18( decvent, decvsite,decv002, decv004,",
               "                                decv005, decv006, decv007, decv008, decv009,",
               "                                decv010, decv011, decv012, decv013, decv014,",
               "                                decv015, decv016, decv017, decv018 ) ",
               " SELECT debyent,               debysite,                 deby002,                    SUM(COALESCE(deby004,0)),",
               "        deby005,               SUM(COALESCE(deby006,0)), COALESCE(deby007,?),        COALESCE(deby008,' '),    COALESCE(deby009,' '),     ",
               "        COALESCE(deby010,' '), deby011,                  SUM(COALESCE(deby012,0)),   COALESCE(deby013,' '),    SUM(COALESCE(deby014,0)),",
               "        COALESCE(deby015,' '), SUM(COALESCE(deby016,0)), SUM(COALESCE(deby017,0)),   SUM(COALESCE(deby018,0)) ",
               "   FROM deby_t ",
               "  WHERE debyent = ",g_enterprise,
               "    AND deby003 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debyent, debysite, deby002, deby005,",
               "           deby007, deby008,  deby009, deby010, deby011,",
               "           deby013, deby015 "
               
   PREPARE adep150_ins_decv_temp_prep FROM l_sql
   EXECUTE adep150_ins_decv_temp_prep USING l_init_date,g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp18"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
   LET l_sql = "UPDATE adep150_tmp18 SET decv001 = (SELECT ooia002 FROM ooia_t WHERE ooiaent = decvent AND ooia001 = decv002),",
               "                             decv019 = ",g_yearmonth,",",
               "                             decv020 = ",g_week
   PREPARE adep150_decv_upd FROM l_sql 
   EXECUTE adep150_decv_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp18"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decv_temp_01 ON adep150_tmp18(decvent,decvsite,decv019,decv020)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp18"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decv_temp ——> adep150_tmp18
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp19  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
   LET l_where = s_aooi500_sql_where(g_prog,'debzsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debzsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
   LET l_sql = " INSERT INTO adep150_tmp19( decwent,  decwsite, decw005, ",
               "                                decw007,  decw008,  decw009, decw010, decw011,",
               "                                decw012,  decw013,  decw014, decw015, decw016,",
               "                                decw017,  decw018) ",
               " SELECT debzent,                   debzsite,                  debz005, ",
               "        debz007,                   debz008,                   SUM(COALESCE(debz009,0)), SUM(COALESCE(debz010,0)), SUM(COALESCE(debz011,0)),",
               "        SUM(COALESCE(debz012,0)),  SUM(COALESCE(debz013,0)),  debz014 ,                 SUM(COALESCE(debz015,0)), SUM(COALESCE(debz016,0)),",
               "        SUM(COALESCE(debz017,0)),  debz018 ",
               "   FROM debz_t ",
               "  WHERE debzent = ",g_enterprise,
               "    AND debz002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debzent, debzsite, debz005, ",
               "           debz007, debz008,  debz014, debz018"
               
   PREPARE adep150_ins_decw_temp_prep FROM l_sql
   EXECUTE adep150_ins_decw_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp19"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
   LET l_sql = "UPDATE adep150_tmp19 SET decw001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = decwent AND ooef001 = decwsite),",
               "                             decw006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = decwent AND mhaesite = decwsite AND mhae001 = decw005), ", 
               "                             decw019 = ",g_yearmonth,",",
               "                             decw020 = ",g_week
   PREPARE adep150_decw_upd FROM l_sql 
   EXECUTE adep150_decw_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp19"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX decw_temp_01 ON adep150_tmp19(decwent,decwsite,decw019,decw020)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp19"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_decw_temp ——> adep150_tmp19
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
END FUNCTION
#門店單品月結
PRIVATE FUNCTION adep150_process10(p_del)
   DEFINE p_del               LIKE type_t.chr1 
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_debusite          LIKE debu_t.debusite
   DEFINE l_debu002           LIKE debu_t.debu002
   DEFINE l_debu003           LIKE debu_t.debu003
   DEFINE l_dedesite          LIKE dede_t.dedesite
   DEFINE l_dede035           LIKE dede_t.dede035
   DEFINE l_dede036           LIKE dede_t.dede036
   
   LET r_success = TRUE  
   
   #debu_t已結轉資料 
   DECLARE adep150_debu_cs1 CURSOR FOR
    SELECT DISTINCT a.debusite,a.debu002,a.debu003
      FROM adep150_tmp20 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
     WHERE EXISTS (SELECT 1 FROM debu_t b
             WHERE b.debuent  = a.debuent
               AND b.debusite = a.debusite
               AND b.debu002  = a.debu002 
               AND b.debu003  = a.debu003 ) 

   #dede_t已結轉資料
   DECLARE adep150_dede_cs1 CURSOR FOR
    SELECT DISTINCT a.dedesite,a.dede035,a.dede036
      FROM adep150_tmp21 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
     WHERE EXISTS (SELECT 1 FROM dede_t b
                    WHERE a.dedeent  = b.dedeent    
                      AND a.dedesite = b.dedesite   
                      AND a.dede035  = b.dede035    
                      AND a.dede036  = b.dede036)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp20 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
                        WHERE a.dedeent  = c.debuent
                          AND a.dedesite = c.debusite
                          AND a.dede035  = c.debu002 
                          AND a.dede036  = c.debu003 )

   IF p_del = "Y" THEN

      FOREACH adep150_debu_cs1 INTO l_debusite,l_debu002,l_debu003
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_debusite
         LET g_errparam.replace[2] = l_debu002
         LET g_errparam.replace[3] = l_debu003
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM debu_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp20 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
                  "         WHERE a.debuent  = b.debuent ",
                  "           AND a.debusite = b.debusite",
                  "           AND a.debu002  = b.debu002 ", 
                  "           AND a.debu003  = b.debu003 )" 
      PREPARE adep150_del_debu_prep1 FROM g_sql
      EXECUTE adep150_del_debu_prep1

      #塞資料                  
      INSERT INTO debu_t ( debuent, debusite,debu001, debu002, debu003,
                           debu004, debu005, debu006, debu007, debu008,
                           debu009, debu010, debu011, debu012, debu013,
                           debu014, debu015, debu016, debu017, debu018,
                           debu019, debu020, debu021, debu022, debu023,
                           debu024, debu025, debu026, debu027, debu028,
                           debu029, debu030, debu031, debu032, debu033,
                           debu034, debu035, debu036, debu037, debu038,
                           debu039, debu040, debu041, debu042, debu043,
                           debu044, debu045, debu046, debu048, debu049,
                           debu050, debu051)
      SELECT debuent, debusite,debu001, debu002, debu003,
             debu004, debu005, debu006, debu007, debu008,
             debu009, debu010, debu011, debu012, debu013,
             debu014, debu015, debu016, debu017, debu018,
             debu019, debu020, debu021, debu022, debu023,
             debu024, debu025, debu026, debu027, debu028,
             debu029, debu030, debu031, debu032, debu033,
             debu034, debu035, debu036, debu037, debu038,
             debu039, debu040, debu041, debu042, debu043,
             debu044, debu045, debu046, debu048, debu049,
             debu050, debu051
        FROM adep150_tmp20  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debu_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dede_cs1 INTO l_dedesite,l_dede035,l_dede036
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedesite
         LET g_errparam.replace[2] = l_dede035
         LET g_errparam.replace[3] = l_dede036
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dede_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp21 b ",    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
                  "                WHERE b.dedeent  = a.dedeent ",
                  "                  AND b.dedesite = a.dedesite",
                  "                  AND b.dede035  = a.dede035 ",
                  "                  AND b.dede036  = a.dede036)"
      PREPARE adep150_del_dede_prep1 FROM g_sql
      EXECUTE adep150_del_dede_prep1

      #塞資料                  
      INSERT INTO dede_t ( dedeent,  dedesite, dede001, dede005, dede006,
                           dede007,  dede008,  dede009, dede010, dede011,
                           dede012,  dede013,  dede014, dede015, dede016,
                           dede017,  dede018,  dede019, dede020, dede021,   
                           dede022,  dede023,  dede024, dede025, dede026,
                           dede027,  dede028,  dede029, dede030, dede031, 
                           dede032,  dede033,  dede034, dede035, dede036,
                           dede037,  dede038,  dede039, dede040, dede041)
      SELECT dedeent,  dedesite, dede001, dede005, dede006,
             dede007,  dede008,  dede009, dede010, dede011,
             dede012,  dede013,  dede014, dede015, dede016,
             dede017,  dede018,  dede019, dede020, dede021,   
             dede022,  dede023,  dede024, dede025, dede026,
             dede027,  dede028,  dede029, dede030, dede031, 
             dede032,  dede033,  dede034, dede035, dede036,
             dede037,  dede038,  dede039, dede040, dede041
        FROM adep150_tmp21   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dede_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_debu_cs1 INTO l_debusite,l_debu002,l_debu003
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_debusite
         LET g_errparam.replace[2] = l_debu002
         LET g_errparam.replace[3] = l_debu003
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      #塞資料                  
      INSERT INTO debu_t ( debuent, debusite,debu001, debu002, debu003,
                           debu004, debu005, debu006, debu007, debu008,
                           debu009, debu010, debu011, debu012, debu013,
                           debu014, debu015, debu016, debu017, debu018,
                           debu019, debu020, debu021, debu022, debu023,
                           debu024, debu025, debu026, debu027, debu028,
                           debu029, debu030, debu031, debu032, debu033,
                           debu034, debu035, debu036, debu037, debu038,
                           debu039, debu040, debu041, debu042, debu043,
                           debu044, debu045,debu046, debu048, debu049,
                           debu050, debu051)
      SELECT a.debuent, a.debusite, a.debu001, a.debu002, a.debu003,
             a.debu004, a.debu005,  a.debu006, a.debu007, a.debu008,
             a.debu009, a.debu010,  a.debu011, a.debu012, a.debu013,
             a.debu014, a.debu015,  a.debu016, a.debu017, a.debu018,
             a.debu019, a.debu020,  a.debu021, a.debu022, a.debu023,
             a.debu024, a.debu025,  a.debu026, a.debu027, a.debu028,
             a.debu029, a.debu030,  a.debu031, a.debu032, a.debu033,
             a.debu034, a.debu035,  a.debu036, a.debu037, a.debu038,
             a.debu039, a.debu040,  a.debu041, a.debu042, a.debu043,
             a.debu044, a.debu045,  a.debu046, a.debu048, a.debu049,
             a.debu050, a.debu051
        FROM adep150_tmp20 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
       WHERE NOT EXISTS (SELECT 1 FROM debu_t b
                          WHERE b.debuent  = a.debuent
                            AND b.debusite = a.debusite
                            AND b.debu002  = a.debu002 
                            AND b.debu003  = a.debu003 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debu_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dede_cs1 INTO l_dedesite,l_dede035,l_dede036
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedesite
         LET g_errparam.replace[2] = l_dede035
         LET g_errparam.replace[3] = l_dede036
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dede_t ( dedeent,  dedesite, dede001, dede005, dede006,
                           dede007,  dede008,  dede009, dede010, dede011,
                           dede012,  dede013,  dede014, dede015, dede016,
                           dede017,  dede018,  dede019, dede020, dede021,   
                           dede022,  dede023,  dede024, dede025, dede026,
                           dede027,  dede028,  dede029, dede030, dede031, 
                           dede032,  dede033,  dede034, dede035, dede036,
                           dede037,  dede038,  dede039, dede040, dede041)
      SELECT a.dedeent,  a.dedesite, a.dede001, a.dede005, a.dede006,
             a.dede007,  a.dede008,  a.dede009, a.dede010, a.dede011,
             a.dede012,  a.dede013,  a.dede014, a.dede015, a.dede016,
             a.dede017,  a.dede018,  a.dede019, a.dede020, a.dede021,   
             a.dede022,  a.dede023,  a.dede024, a.dede025, a.dede026,
             a.dede027,  a.dede028,  a.dede029, a.dede030, a.dede031, 
             a.dede032,  a.dede033,  a.dede034, a.dede035, a.dede036,
             a.dede037,  a.dede038,  a.dede039, a.dede040, a.dede041
        FROM adep150_tmp21 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
       WHERE NOT EXISTS (SELECT 1 FROM dede_t b
                          WHERE a.dedeent  = b.dedeent    
                            AND a.dedesite = b.dedesite   
                            AND a.dede035  = b.dede035    
                            AND a.dede036  = b.dede036)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dede_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店品類月結
PRIVATE FUNCTION adep150_process11(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dedqsite          LIKE dedq_t.dedqsite
   DEFINE l_dedq034           LIKE dedq_t.dedq034
   DEFINE l_dedq035           LIKE dedq_t.dedq035
   DEFINE l_dedrsite          LIKE dedr_t.dedrsite
   DEFINE l_dedr025           LIKE dedr_t.dedr025
   DEFINE l_dedr026           LIKE dedr_t.dedr026
   
   LET r_success = TRUE  
   
   #dedq_t已結轉資料 
   DECLARE adep150_dedq_cs1 CURSOR FOR
    SELECT DISTINCT a.dedqsite,a.dedq034,a.dedq035
      FROM adep150_tmp23 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
     WHERE EXISTS (SELECT 1 FROM dedq_t b
             WHERE b.dedqent  = a.dedqent
               AND b.dedqsite = a.dedqsite
               AND b.dedq034  = a.dedq034 
               AND b.dedq035  = a.dedq035 ) 

   #dedr_t已結轉資料
   DECLARE adep150_dedr_cs1 CURSOR FOR
    SELECT DISTINCT a.dedrsite,a.dedr025,a.dedr026
      FROM adep150_tmp24 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
     WHERE EXISTS (SELECT 1 FROM dedr_t b
                    WHERE a.dedrent  = b.dedrent    
                      AND a.dedrsite = b.dedrsite   
                      AND a.dedr025  = b.dedr025    
                      AND a.dedr026  = b.dedr026)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp23 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
                        WHERE a.dedrent  = c.dedqent
                          AND a.dedrsite = c.dedqsite
                          AND a.dedr025  = c.dedq034 
                          AND a.dedr026  = c.dedq035 )

   IF p_del = "Y" THEN

      FOREACH adep150_dedq_cs1 INTO l_dedqsite,l_dedq034,l_dedq035
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedqsite
         LET g_errparam.replace[2] = l_dedq034
         LET g_errparam.replace[3] = l_dedq035
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedq_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp23 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
                  "         WHERE a.dedqent  = b.dedqent ",
                  "           AND a.dedqsite = b.dedqsite",
                  "           AND a.dedq034  = b.dedq034 ", 
                  "           AND a.dedq035  = b.dedq035 )" 
      PREPARE adep150_del_dedq_prep1 FROM g_sql
      EXECUTE adep150_del_dedq_prep1

      #塞資料                  
      INSERT INTO dedq_t ( dedqent, dedqsite,dedq001, dedq005, dedq006,
                           dedq007, dedq008, dedq009, dedq010, dedq011,
                           dedq012, dedq013, dedq014, dedq015, dedq016,
                           dedq017, dedq018, dedq019, dedq020, dedq021,
                           dedq022, dedq023, dedq024, dedq025, dedq026,
                           dedq027, dedq028, dedq029, dedq030, dedq031,
                           dedq032, dedq033, dedq034, dedq035, dedq036,
                           dedq037)
      SELECT dedqent, dedqsite,dedq001, dedq005, dedq006,
             dedq007, dedq008, dedq009, dedq010, dedq011,
             dedq012, dedq013, dedq014, dedq015, dedq016,
             dedq017, dedq018, dedq019, dedq020, dedq021,
             dedq022, dedq023, dedq024, dedq025, dedq026,
             dedq027, dedq028, dedq029, dedq030, dedq031,
             dedq032, dedq033, dedq034, dedq035, dedq036,
             dedq037
        FROM adep150_tmp23  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedr_cs1 INTO l_dedrsite,l_dedr025,l_dedr026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedrsite
         LET g_errparam.replace[2] = l_dedr025
         LET g_errparam.replace[3] = l_dedr026
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedr_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp24 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
                  "                WHERE b.dedrent  = a.dedrent ",
                  "                  AND b.dedrsite = a.dedrsite",
                  "                  AND b.dedr025  = a.dedr025 ",
                  "                  AND b.dedr026  = a.dedr026)"
      PREPARE adep150_del_dedr_prep1 FROM g_sql
      EXECUTE adep150_del_dedr_prep1

      #塞資料                  
      INSERT INTO dedr_t ( dedrent,  dedrsite, dedr001, dedr005, dedr006,
                           dedr007,  dedr008,  dedr009, dedr010, dedr011,
                           dedr012,  dedr013,  dedr014, dedr015, dedr016,
                           dedr017,  dedr018,  dedr019, dedr020, dedr021,   
                           dedr022,  dedr023,  dedr024, dedr025, dedr026,
                           dedr027,  dedr028)
      SELECT dedrent,  dedrsite, dedr001, dedr005, dedr006,
             dedr007,  dedr008,  dedr009, dedr010, dedr011,
             dedr012,  dedr013,  dedr014, dedr015, dedr016,
             dedr017,  dedr018,  dedr019, dedr020, dedr021,   
             dedr022,  dedr023,  dedr024, dedr025, dedr026,
             dedr027,  dedr028
        FROM adep150_tmp24   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedr_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dedq_cs1 INTO l_dedqsite,l_dedq034,l_dedq035
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedqsite
         LET g_errparam.replace[2] = l_dedq034
         LET g_errparam.replace[3] = l_dedq035
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dedq_t ( dedqent, dedqsite,dedq001, dedq005, dedq006,
                           dedq007, dedq008, dedq009, dedq010, dedq011,
                           dedq012, dedq013, dedq014, dedq015, dedq016,
                           dedq017, dedq018, dedq019, dedq020, dedq021,
                           dedq022, dedq023, dedq024, dedq025, dedq026,
                           dedq027, dedq028, dedq029, dedq030, dedq031,
                           dedq032, dedq033, dedq034, dedq035, dedq036,
                           dedq037 )
      SELECT a.dedqent, a.dedqsite, a.dedq001, a.dedq005, a.dedq006,
             a.dedq007, a.dedq008,  a.dedq009, a.dedq010, a.dedq011,
             a.dedq012, a.dedq013,  a.dedq014, a.dedq015, a.dedq016,
             a.dedq017, a.dedq018,  a.dedq019, a.dedq020, a.dedq021,
             a.dedq022, a.dedq023,  a.dedq024, a.dedq025, a.dedq026,
             a.dedq027, a.dedq028,  a.dedq029, a.dedq030, a.dedq031,
             a.dedq032, a.dedq033,  a.dedq034, a.dedq035, a.dedq036,
             a.dedq037
        FROM adep150_tmp23 a  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
       WHERE NOT EXISTS (SELECT 1 FROM dedq_t b
                          WHERE b.dedqent  = a.dedqent
                            AND b.dedqsite = a.dedqsite
                            AND b.dedq034  = a.dedq034 
                            AND b.dedq035  = a.dedq035 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedr_cs1 INTO l_dedrsite,l_dedr025,l_dedr026
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedrsite
         LET g_errparam.replace[2] = l_dedr025
         LET g_errparam.replace[3] = l_dedr026
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedr_t ( dedrent,  dedrsite, dedr001, dedr005, dedr006,
                           dedr007,  dedr008,  dedr009, dedr010, dedr011,
                           dedr012,  dedr013,  dedr014, dedr015, dedr016,
                           dedr017,  dedr018,  dedr019, dedr020, dedr021,   
                           dedr022,  dedr023,  dedr024, dedr025, dedr026,
                           dedr027,  dedr028)
      SELECT a.dedrent,  a.dedrsite, a.dedr001, a.dedr005, a.dedr006,
             a.dedr007,  a.dedr008,  a.dedr009, a.dedr010, a.dedr011,
             a.dedr012,  a.dedr013,  a.dedr014, a.dedr015, a.dedr016,
             a.dedr017,  a.dedr018,  a.dedr019, a.dedr020, a.dedr021,   
             a.dedr022,  a.dedr023,  a.dedr024, a.dedr025, a.dedr026,
             a.dedr027,  a.dedr028
        FROM adep150_tmp24 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
       WHERE NOT EXISTS (SELECT 1 FROM dedr_t b
                          WHERE a.dedrent  = b.dedrent    
                            AND a.dedrsite = b.dedrsite   
                            AND a.dedr025  = b.dedr025    
                            AND a.dedr026  = b.dedr026)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedr_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
   
END FUNCTION
#門店庫區月結
PRIVATE FUNCTION adep150_process14(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dedfsite          LIKE dedf_t.dedfsite
   DEFINE l_dedf031           LIKE dedf_t.dedf031
   DEFINE l_dedf032           LIKE dedf_t.dedf032
   DEFINE l_dedgsite          LIKE dedg_t.dedgsite
   DEFINE l_dedg027           LIKE dedg_t.dedg027
   DEFINE l_dedg028           LIKE dedg_t.dedg028
   DEFINE l_dedhsite          LIKE dedh_t.dedhsite
   DEFINE l_dedh015           LIKE dedh_t.dedh015
   DEFINE l_dedh016           LIKE dedh_t.dedh016
   
   LET r_success = TRUE  
   
   #dedf_t已結轉資料 
   DECLARE adep150_dedf_cs1 CURSOR FOR
    SELECT DISTINCT a.dedfsite,a.dedf031,a.dedf032
      FROM adep150_tmp25 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
     WHERE EXISTS (SELECT 1 FROM dedf_t b
             WHERE b.dedfent  = a.dedfent
               AND b.dedfsite = a.dedfsite
               AND b.dedf031  = a.dedf031 
               AND b.dedf032  = a.dedf032 ) 

   #dedg_t已結轉資料
   DECLARE adep150_dedg_cs1 CURSOR FOR
    SELECT DISTINCT a.dedgsite,a.dedg027,a.dedg028
      FROM adep150_tmp26 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
     WHERE EXISTS (SELECT 1 FROM dedg_t b
                    WHERE a.dedgent  = b.dedgent    
                      AND a.dedgsite = b.dedgsite   
                      AND a.dedg027  = b.dedg027    
                      AND a.dedg028  = b.dedg028)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp25 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
                        WHERE a.dedgent  = c.dedfent
                          AND a.dedgsite = c.dedfsite
                          AND a.dedg027  = c.dedf031 
                          AND a.dedg028  = c.dedf032 )

   #dedh_t已結轉資料
   DECLARE adep150_dedh_cs1 CURSOR FOR
    SELECT DISTINCT a.dedhsite,a.dedh015,a.dedh016
      FROM adep150_tmp27 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
     WHERE EXISTS (SELECT 1 FROM dedh_t b
                    WHERE a.dedhent  = b.dedhent    
                      AND a.dedhsite = b.dedhsite   
                      AND a.dedh015  = b.dedh015    
                      AND a.dedh016  = b.dedh016)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp25 c  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
                        WHERE a.dedhent  = c.dedfent
                          AND a.dedhsite = c.dedfsite
                          AND a.dedh015  = c.dedf031 
                          AND a.dedh016  = c.dedf032 )

   IF p_del = "Y" THEN

      FOREACH adep150_dedf_cs1 INTO l_dedfsite,l_dedf031,l_dedf032
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedfsite
         LET g_errparam.replace[2] = l_dedf031
         LET g_errparam.replace[3] = l_dedf032
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedf_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp25 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
                  "         WHERE a.dedfent  = b.dedfent ",
                  "           AND a.dedfsite = b.dedfsite",
                  "           AND a.dedf031  = b.dedf031 ", 
                  "           AND a.dedf032  = b.dedf032 )" 
      PREPARE adep150_del_dedf_prep1 FROM g_sql
      EXECUTE adep150_del_dedf_prep1

      #塞資料                  
      INSERT INTO dedf_t ( dedfent, dedfsite,dedf001, dedf005, dedf006,
                           dedf007, dedf008, dedf009, dedf010, dedf011,
                           dedf012, dedf013, dedf014, dedf015, dedf016,
                           dedf017, dedf018, dedf019, dedf020, dedf021,
                           dedf022, dedf023, dedf024, dedf025, dedf026,
                           dedf027, dedf028, dedf029, dedf030, dedf031,
                           dedf032, dedf033)
      SELECT dedfent, dedfsite,dedf001, dedf005, dedf006,
             dedf007, dedf008, dedf009, dedf010, dedf011,
             dedf012, dedf013, dedf014, dedf015, dedf016,
             dedf017, dedf018, dedf019, dedf020, dedf021,
             dedf022, dedf023, dedf024, dedf025, dedf026,
             dedf027, dedf028, dedf029, dedf030, dedf031,
             dedf032, dedf033
        FROM adep150_tmp25  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedg_cs1 INTO l_dedgsite,l_dedg027,l_dedg028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedgsite
         LET g_errparam.replace[2] = l_dedg027
         LET g_errparam.replace[3] = l_dedg028
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedg_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp26 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
                  "                WHERE b.dedgent  = a.dedgent ",
                  "                  AND b.dedgsite = a.dedgsite",
                  "                  AND b.dedg027  = a.dedg027 ",
                  "                  AND b.dedg028  = a.dedg028)"
      PREPARE adep150_del_dedg_prep1 FROM g_sql
      EXECUTE adep150_del_dedg_prep1

      #塞資料                  
      INSERT INTO dedg_t ( dedgent,  dedgsite, dedg001, dedg005, dedg006,
                           dedg007,  dedg008,  dedg009, dedg010, dedg011,
                           dedg012,  dedg013,  dedg014, dedg015, dedg016,
                           dedg017,  dedg018,  dedg019, dedg020, dedg021,   
                           dedg022,  dedg023,  dedg024, dedg025, dedg026,
                           dedg027,  dedg028,  dedg029)
      SELECT dedgent,  dedgsite, dedg001, dedg005, dedg006,
             dedg007,  dedg008,  dedg009, dedg010, dedg011,
             dedg012,  dedg013,  dedg014, dedg015, dedg016,
             dedg017,  dedg018,  dedg019, dedg020, dedg021,   
             dedg022,  dedg023,  dedg024, dedg025, dedg026,
             dedg027,  dedg028,  dedg029
        FROM adep150_tmp26  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedh_cs1 INTO l_dedhsite,l_dedh015,l_dedh016
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedhsite
         LET g_errparam.replace[2] = l_dedh015
         LET g_errparam.replace[3] = l_dedh016
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedh_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp27 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
                  "                WHERE b.dedhent  = a.dedhent ",
                  "                  AND b.dedhsite = a.dedhsite",
                  "                  AND b.dedh015  = a.dedh015 ",
                  "                  AND b.dedh016  = a.dedh016)"
      PREPARE adep150_del_dedh_prep1 FROM g_sql
      EXECUTE adep150_del_dedh_prep1

      #塞資料                  
      INSERT INTO dedh_t ( dedhent,  dedhsite, dedh001, dedh005, dedh006,
                           dedh007,  dedh008,  dedh009, dedh010, dedh011,
                           dedh012,  dedh013,  dedh014, dedh015, dedh016)
      SELECT dedhent,  dedhsite, dedh001, dedh005, dedh006,
             dedh007,  dedh008,  dedh009, dedh010, dedh011,
             dedh012,  dedh013,  dedh014, dedh015, dedh016 
        FROM adep150_tmp27  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedh_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dedf_cs1 INTO l_dedfsite,l_dedf031,l_dedf032
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedfsite
         LET g_errparam.replace[2] = l_dedf031
         LET g_errparam.replace[3] = l_dedf032
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dedf_t ( dedfent, dedfsite,dedf001, dedf005, dedf006,
                           dedf007, dedf008, dedf009, dedf010, dedf011,
                           dedf012, dedf013, dedf014, dedf015, dedf016,
                           dedf017, dedf018, dedf019, dedf020, dedf021,
                           dedf022, dedf023, dedf024, dedf025, dedf026,
                           dedf027, dedf028, dedf029, dedf030, dedf031,
                           dedf032, dedf033)
      SELECT a.dedfent, a.dedfsite, a.dedf001, a.dedf005, a.dedf006,
             a.dedf007, a.dedf008,  a.dedf009, a.dedf010, a.dedf011,
             a.dedf012, a.dedf013,  a.dedf014, a.dedf015, a.dedf016,
             a.dedf017, a.dedf018,  a.dedf019, a.dedf020, a.dedf021,
             a.dedf022, a.dedf023,  a.dedf024, a.dedf025, a.dedf026,
             a.dedf027, a.dedf028,  a.dedf029, a.dedf030, a.dedf031,
             a.dedf032, a.dedf033
        FROM adep150_tmp25 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
       WHERE NOT EXISTS (SELECT 1 FROM dedf_t b
                          WHERE b.dedfent  = a.dedfent
                            AND b.dedfsite = a.dedfsite
                            AND b.dedf031  = a.dedf031 
                            AND b.dedf032  = a.dedf032 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedg_cs1 INTO l_dedgsite,l_dedg027,l_dedg028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedgsite
         LET g_errparam.replace[2] = l_dedg027
         LET g_errparam.replace[3] = l_dedg028
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedg_t ( dedgent,  dedgsite, dedg001, dedg005, dedg006,
                           dedg007,  dedg008,  dedg009, dedg010, dedg011,
                           dedg012,  dedg013,  dedg014, dedg015, dedg016,
                           dedg017,  dedg018,  dedg019, dedg020, dedg021,   
                           dedg022,  dedg023,  dedg024, dedg025, dedg026,
                           dedg027,  dedg028,  dedg029)
      SELECT a.dedgent,  a.dedgsite, a.dedg001, a.dedg005, a.dedg006,
             a.dedg007,  a.dedg008,  a.dedg009, a.dedg010, a.dedg011,
             a.dedg012,  a.dedg013,  a.dedg014, a.dedg015, a.dedg016,
             a.dedg017,  a.dedg018,  a.dedg019, a.dedg020, a.dedg021,   
             a.dedg022,  a.dedg023,  a.dedg024, a.dedg025, a.dedg026,
             a.dedg027,  a.dedg028,  a. dedg029
        FROM adep150_tmp26 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
       WHERE NOT EXISTS (SELECT 1 FROM dedg_t b
                          WHERE a.dedgent  = b.dedgent    
                            AND a.dedgsite = b.dedgsite   
                            AND a.dedg027  = b.dedg027    
                            AND a.dedg028  = b.dedg028)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedh_cs1 INTO l_dedhsite,l_dedh015,l_dedh016
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedhsite
         LET g_errparam.replace[2] = l_dedh015
         LET g_errparam.replace[3] = l_dedh016
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO dedh_t ( dedhent,  dedhsite, dedh001, dedh005, dedh006,
                           dedh007,  dedh008,  dedh009, dedh010, dedh011,
                           dedh012,  dedh013,  dedh014, dedh015, dedh016)
      SELECT dedhent,  dedhsite, dedh001, dedh005, dedh006,
             dedh007,  dedh008,  dedh009, dedh010, dedh011,
             dedh012,  dedh013,  dedh014, dedh015, dedh016 
        FROM adep150_tmp27   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
       WHERE NOT EXISTS (SELECT 1 FROM dedh_t b
                          WHERE a.dedhent  = b.dedhent    
                            AND a.dedhsite = b.dedhsite   
                            AND a.dedh015  = b.dedh015    
                            AND a.dedh016  = b.dedh016)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedh_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success
END FUNCTION
#門店專櫃週結
PRIVATE FUNCTION adep150_process15(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dedisite          LIKE dedi_t.dedisite
   DEFINE l_dedi027           LIKE dedi_t.dedi027
   DEFINE l_dedi028           LIKE dedi_t.dedi028
   DEFINE l_dedjsite          LIKE dedj_t.dedjsite
   DEFINE l_dedj023           LIKE dedj_t.dedj023
   DEFINE l_dedj024           LIKE dedj_t.dedj024
   DEFINE l_dedksite          LIKE dedk_t.dedksite
   DEFINE l_dedk012           LIKE dedk_t.dedk012
   DEFINE l_dedk013           LIKE dedk_t.dedk013
   
   LET r_success = TRUE  
   
   #dedi_t已結轉資料 
   DECLARE adep150_dedi_cs1 CURSOR FOR
    SELECT DISTINCT a.dedisite,a.dedi027,a.dedi028
      FROM adep150_tmp28 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
     WHERE EXISTS (SELECT 1 FROM dedi_t b
             WHERE b.dedient  = a.dedient
               AND b.dedisite = a.dedisite
               AND b.dedi027  = a.dedi027 
               AND b.dedi028  = a.dedi028 ) 

   #dedj_t已結轉資料
   DECLARE adep150_dedj_cs1 CURSOR FOR
    SELECT DISTINCT a.dedjsite,a.dedj023,a.dedj024
      FROM adep150_tmp29 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
     WHERE EXISTS (SELECT 1 FROM dedj_t b
                    WHERE a.dedjent  = b.dedjent    
                      AND a.dedjsite = b.dedjsite   
                      AND a.dedj023  = b.dedj023    
                      AND a.dedj024  = b.dedj024)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp28 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
                        WHERE a.dedjent  = c.dedient
                          AND a.dedjsite = c.dedisite
                          AND a.dedj023  = c.dedi027 
                          AND a.dedj024  = c.dedi028 )

   #dedk_t已結轉資料
   DECLARE adep150_dedk_cs1 CURSOR FOR
    SELECT DISTINCT a.dedksite,a.dedk012,a.dedk013
      FROM adep150_tmp30 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
     WHERE EXISTS (SELECT 1 FROM dedk_t b
                    WHERE a.dedkent  = b.dedkent    
                      AND a.dedksite = b.dedksite   
                      AND a.dedk012  = b.dedk012    
                      AND a.dedk013  = b.dedk013)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp28 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
                        WHERE a.dedkent  = c.dedient
                          AND a.dedksite = c.dedisite
                          AND a.dedk012  = c.dedi027 
                          AND a.dedk013  = c.dedi028 )

   IF p_del = "Y" THEN

      FOREACH adep150_dedi_cs1 INTO l_dedisite,l_dedi027,l_dedi028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedisite
         LET g_errparam.replace[2] = l_dedi027
         LET g_errparam.replace[3] = l_dedi028
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedi_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp28 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
                  "         WHERE a.dedient  = b.dedient ",
                  "           AND a.dedisite = b.dedisite",
                  "           AND a.dedi027  = b.dedi027 ", 
                  "           AND a.dedi028  = b.dedi028 )" 
      PREPARE adep150_del_dedi_prep1 FROM g_sql
      EXECUTE adep150_del_dedi_prep1

      #塞資料                  
      INSERT INTO dedi_t ( dedient, dedisite,dedi001, dedi005, dedi006,
                           dedi007, dedi008, dedi009, dedi010, dedi011,
                           dedi012, dedi013, dedi014, dedi015, dedi016,
                           dedi017, dedi018, dedi019, dedi020, dedi021,
                           dedi022, dedi023, dedi024, dedi025, dedi026,
                           dedi027, dedi028)
      SELECT dedient, dedisite,dedi001, dedi005, dedi006,
             dedi007, dedi008, dedi009, dedi010, dedi011,
             dedi012, dedi013, dedi014, dedi015, dedi016,
             dedi017, dedi018, dedi019, dedi020, dedi021,
             dedi022, dedi023, dedi024, dedi025, dedi026,
             dedi027, dedi028
        FROM adep150_tmp28  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedi_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedj_cs1 INTO l_dedjsite,l_dedj023,l_dedj024
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedjsite
         LET g_errparam.replace[2] = l_dedj023
         LET g_errparam.replace[3] = l_dedj024
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedj_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp29 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
                  "                WHERE b.dedjent  = a.dedjent ",
                  "                  AND b.dedjsite = a.dedjsite",
                  "                  AND b.dedj023  = a.dedj023 ",
                  "                  AND b.dedj024  = a.dedj024)"
      PREPARE adep150_del_dedj_prep1 FROM g_sql
      EXECUTE adep150_del_dedj_prep1

      #塞資料                  
      INSERT INTO dedj_t ( dedjent,  dedjsite, dedj001, dedj005, dedj006,
                           dedj007,  dedj008,  dedj009, dedj010, dedj011,
                           dedj012,  dedj013,  dedj014, dedj015, dedj016,
                           dedj017,  dedj018,  dedj019, dedj020, dedj021,   
                           dedj022,  dedj023,  dedj024)
      SELECT dedjent,  dedjsite, dedj001, dedj005, dedj006,
             dedj007,  dedj008,  dedj009, dedj010, dedj011,
             dedj012,  dedj013,  dedj014, dedj015, dedj016,
             dedj017,  dedj018,  dedj019, dedj020, dedj021,   
             dedj022,  dedj023,  dedj024
        FROM adep150_tmp29   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedk_cs1 INTO l_dedksite,l_dedk012,l_dedk013
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedksite
         LET g_errparam.replace[2] = l_dedk012
         LET g_errparam.replace[3] = l_dedk013
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedk_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp30 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
                  "                WHERE b.dedkent  = a.dedkent ",
                  "                  AND b.dedksite = a.dedksite",
                  "                  AND b.dedk012  = a.dedk012 ",
                  "                  AND b.dedk013  = a.dedk013)"
      PREPARE adep150_del_dedk_prep1 FROM g_sql
      EXECUTE adep150_del_dedk_prep1

      #塞資料                  
      INSERT INTO dedk_t ( dedkent,  dedksite, dedk001, dedk005, dedk006,
                           dedk007,  dedk008,  dedk009, dedk010, dedk011,
                           dedk012,  dedk013)
      SELECT dedkent,  dedksite, dedk001, dedk005, dedk006,
             dedk007,  dedk008,  dedk009, dedk010, dedk011,
             dedk012,  dedk013
        FROM adep150_tmp30   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedk_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dedi_cs1 INTO l_dedisite,l_dedi027,l_dedi028
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedisite
         LET g_errparam.replace[2] = l_dedi027
         LET g_errparam.replace[3] = l_dedi028
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dedi_t ( dedient, dedisite,dedi001, dedi005, dedi006,
                           dedi007, dedi008, dedi009, dedi010, dedi011,
                           dedi012, dedi013, dedi014, dedi015, dedi016,
                           dedi017, dedi018, dedi019, dedi020, dedi021,
                           dedi022, dedi023, dedi024, dedi025, dedi026,
                           dedi027, dedi028)
      SELECT a.dedient, a.dedisite, a.dedi001, a.dedi005, a.dedi006,
             a.dedi007, a.dedi008,  a.dedi009, a.dedi010, a.dedi011,
             a.dedi012, a.dedi013,  a.dedi014, a.dedi015, a.dedi016,
             a.dedi017, a.dedi018,  a.dedi019, a.dedi020, a.dedi021,
             a.dedi022, a.dedi023,  a.dedi024, a.dedi025, a.dedi026,
             a.dedi027, a.dedi028
        FROM adep150_tmp28 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
       WHERE NOT EXISTS (SELECT 1 FROM dedi_t b
                          WHERE b.dedient  = a.dedient
                            AND b.dedisite = a.dedisite
                            AND b.dedi027  = a.dedi027 
                            AND b.dedi028  = a.dedi028 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedi_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedj_cs1 INTO l_dedjsite,l_dedj023,l_dedj024
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedjsite
         LET g_errparam.replace[2] = l_dedj023
         LET g_errparam.replace[3] = l_dedj024
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedj_t ( dedjent,  dedjsite, dedj001, dedj005, dedj006,
                           dedj007,  dedj008,  dedj009, dedj010, dedj011,
                           dedj012,  dedj013,  dedj014, dedj015, dedj016,
                           dedj017,  dedj018,  dedj019, dedj020, dedj021,   
                           dedj022,  dedj023,  dedj024)
      SELECT a.dedjent,  a.dedjsite, a.dedj001, a.dedj005, a.dedj006,
             a.dedj007,  a.dedj008,  a.dedj009, a.dedj010, a.dedj011,
             a.dedj012,  a.dedj013,  a.dedj014, a.dedj015, a.dedj016,
             a.dedj017,  a.dedj018,  a.dedj019, a.dedj020, a.dedj021,   
             a.dedj022,  a.dedj023,  a.dedj024
        FROM adep150_tmp29 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
       WHERE NOT EXISTS (SELECT 1 FROM dedj_t b
                          WHERE a.dedjent  = b.dedjent    
                            AND a.dedjsite = b.dedjsite   
                            AND a.dedj023  = b.dedj023    
                            AND a.dedj024  = b.dedj024)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedj_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedk_cs1 INTO l_dedksite,l_dedk012,l_dedk013
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedksite
         LET g_errparam.replace[2] = l_dedk012
         LET g_errparam.replace[3] = l_dedk013
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO dedk_t ( dedkent,  dedksite, dedk001, dedk005, dedk006,
                           dedk007,  dedk008,  dedk009, dedk010, dedk011,
                           dedk012,  dedk013)
      SELECT dedkent,  dedksite, dedk001, dedk005, dedk006,
             dedk007,  dedk008,  dedk009, dedk010, dedk011,
             dedk012,  dedk013
        FROM adep150_tmp30   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
       WHERE NOT EXISTS (SELECT 1 FROM dedk_t b
                          WHERE a.dedkent  = b.dedkent    
                            AND a.dedksite = b.dedksite   
                            AND a.dedk012  = b.dedk012    
                            AND a.dedk013  = b.dedk013)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedk_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success

END FUNCTION
#門店部門月結
PRIVATE FUNCTION adep150_process16(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dedlsite          LIKE dedl_t.dedlsite
   DEFINE l_dedl024           LIKE dedl_t.dedl024
   DEFINE l_dedl025           LIKE dedl_t.dedl025
   DEFINE l_dedmsite          LIKE dedm_t.dedmsite
   DEFINE l_dedm021           LIKE dedm_t.dedm021
   DEFINE l_dedm022           LIKE dedm_t.dedm022
   DEFINE l_dednsite          LIKE dedn_t.dednsite
   DEFINE l_dedn009           LIKE dedn_t.dedn009
   DEFINE l_dedn010           LIKE dedn_t.dedn010
   
   LET r_success = TRUE  
   
   #dedl_t已結轉資料 
   DECLARE adep150_dedl_cs1 CURSOR FOR
    SELECT DISTINCT a.dedlsite,a.dedl024,a.dedl025
      FROM adep150_tmp31 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
     WHERE EXISTS (SELECT 1 FROM dedl_t b
             WHERE b.dedlent  = a.dedlent
               AND b.dedlsite = a.dedlsite
               AND b.dedl024  = a.dedl024 
               AND b.dedl025  = a.dedl025 ) 

   #dedm_t已結轉資料
   DECLARE adep150_dedm_cs1 CURSOR FOR
    SELECT DISTINCT a.dedmsite,a.dedm021,a.dedm022
      FROM adep150_tmp32 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
     WHERE EXISTS (SELECT 1 FROM dedm_t b
                    WHERE a.dedment  = b.dedment    
                      AND a.dedmsite = b.dedmsite   
                      AND a.dedm021  = b.dedm021    
                      AND a.dedm022  = b.dedm022)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp31 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
                        WHERE a.dedment  = c.dedlent
                          AND a.dedmsite = c.dedlsite
                          AND a.dedm021  = c.dedl024 
                          AND a.dedm022  = c.dedl025 )

   #dedn_t已結轉資料
   DECLARE adep150_dedn_cs1 CURSOR FOR
    SELECT DISTINCT a.dednsite,a.dedn009,a.dedn010
      FROM adep150_tmp33 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
     WHERE EXISTS (SELECT 1 FROM dedn_t b
                    WHERE a.dednent  = b.dednent    
                      AND a.dednsite = b.dednsite   
                      AND a.dedn009  = b.dedn009    
                      AND a.dedn010  = b.dedn010)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp31 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
                        WHERE a.dednent  = c.dedlent
                          AND a.dednsite = c.dedlsite
                          AND a.dedn009  = c.dedl024 
                          AND a.dedn010  = c.dedl025 )

   IF p_del = "Y" THEN

      FOREACH adep150_dedl_cs1 INTO l_dedlsite,l_dedl024,l_dedl025
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedlsite
         LET g_errparam.replace[2] = l_dedl024
         LET g_errparam.replace[3] = l_dedl025
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedl_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp31 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
                  "         WHERE a.dedlent  = b.dedlent ",
                  "           AND a.dedlsite = b.dedlsite",
                  "           AND a.dedl024  = b.dedl024 ", 
                  "           AND a.dedl025  = b.dedl025 )" 
      PREPARE adep150_del_dedl_prep1 FROM g_sql
      EXECUTE adep150_del_dedl_prep1

      #塞資料                  
      INSERT INTO dedl_t ( dedlent, dedlsite,dedl001, dedl005, dedl006,
                           dedl007, dedl008, dedl009, dedl010, dedl011,
                           dedl012, dedl013, dedl014, dedl015, dedl016,
                           dedl017, dedl018, dedl019, dedl020, dedl021,
                           dedl022, dedl023, dedl024, dedl025)
      SELECT dedlent, dedlsite,dedl001, dedl005, dedl006,
             dedl007, dedl008, dedl009, dedl010, dedl011,
             dedl012, dedl013, dedl014, dedl015, dedl016,
             dedl017, dedl018, dedl019, dedl020, dedl021,
             dedl022, dedl023, dedl024, dedl025
        FROM adep150_tmp31  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedm_cs1 INTO l_dedmsite,l_dedm021,l_dedm022
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedmsite
         LET g_errparam.replace[2] = l_dedm021
         LET g_errparam.replace[3] = l_dedm022
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedm_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp32 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
                  "                WHERE b.dedment  = a.dedment ",
                  "                  AND b.dedmsite = a.dedmsite",
                  "                  AND b.dedm021  = a.dedm021 ",
                  "                  AND b.dedm022  = a.dedm022)"
      PREPARE adep150_del_dedm_prep1 FROM g_sql
      EXECUTE adep150_del_dedm_prep1

      #塞資料                  
      INSERT INTO dedm_t ( dedment,  dedmsite, dedm001, dedm005, dedm006,
                           dedm007,  dedm008,  dedm009, dedm010, dedm011,
                           dedm012,  dedm013,  dedm014, dedm015, dedm016,
                           dedm017,  dedm018,  dedm019, dedm020, dedm021,   
                           dedm022)
      SELECT dedment,  dedmsite, dedm001, dedm005, dedm006,
             dedm007,  dedm008,  dedm009, dedm010, dedm011,
             dedm012,  dedm013,  dedm014, dedm015, dedm016,
             dedm017,  dedm018,  dedm019, dedm020, dedm021,   
             dedm022
        FROM adep150_tmp32  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedm_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedn_cs1 INTO l_dednsite,l_dedn009,l_dedn010
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dednsite
         LET g_errparam.replace[2] = l_dedn009
         LET g_errparam.replace[3] = l_dedn010
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedn_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp33 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
                  "                WHERE b.dednent  = a.dednent ",
                  "                  AND b.dednsite = a.dednsite",
                  "                  AND b.dedn009  = a.dedn009 ",
                  "                  AND b.dedn010  = a.dedn010)"
      PREPARE adep150_del_dedn_prep1 FROM g_sql
      EXECUTE adep150_del_dedn_prep1

      #塞資料                  
      INSERT INTO dedn_t ( dednent,  dednsite, dedn001, dedn005, dedn006,
                           dedn007,  dedn008,  dedn009, dedn010)
      SELECT dednent,  dednsite, dedn001, dedn005, dedn006,
             dedn007,  dedn008,  dedn009, dedn010
        FROM adep150_tmp33   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_dedl_cs1 INTO l_dedlsite,l_dedl024,l_dedl025
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedlsite
         LET g_errparam.replace[2] = l_dedl024
         LET g_errparam.replace[3] = l_dedl025
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO dedl_t ( dedlent, dedlsite,dedl001, dedl005, dedl006,
                           dedl007, dedl008, dedl009, dedl010, dedl011,
                           dedl012, dedl013, dedl014, dedl015, dedl016,
                           dedl017, dedl018, dedl019, dedl020, dedl021,
                           dedl022, dedl023, dedl024, dedl025)
      SELECT a.dedlent, a.dedlsite, a.dedl001, a.dedl005, a.dedl006,
             a.dedl007, a.dedl008,  a.dedl009, a.dedl010, a.dedl011,
             a.dedl012, a.dedl013,  a.dedl014, a.dedl015, a.dedl016,
             a.dedl017, a.dedl018,  a.dedl019, a.dedl020, a.dedl021,
             a.dedl022, a.dedl023,  a.dedl024, a.dedl025
        FROM adep150_tmp31 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
       WHERE NOT EXISTS (SELECT 1 FROM dedl_t b
                          WHERE b.dedlent  = a.dedlent
                            AND b.dedlsite = a.dedlsite
                            AND b.dedl024  = a.dedl024 
                            AND b.dedl025  = a.dedl025 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedm_cs1 INTO l_dedmsite,l_dedm021,l_dedm022
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedmsite
         LET g_errparam.replace[2] = l_dedm021
         LET g_errparam.replace[3] = l_dedm022
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedm_t ( dedment,  dedmsite, dedm001, dedm005, dedm006,
                           dedm007,  dedm008,  dedm009, dedm010, dedm011,
                           dedm012,  dedm013,  dedm014, dedm015, dedm016,
                           dedm017,  dedm018,  dedm019, dedm020, dedm021,   
                           dedm022)
      SELECT a.dedment,  a.dedmsite, a.dedm001, a.dedm005, a.dedm006,
             a.dedm007,  a.dedm008,  a.dedm009, a.dedm010, a.dedm011,
             a.dedm012,  a.dedm013,  a.dedm014, a.dedm015, a.dedm016,
             a.dedm017,  a.dedm018,  a.dedm019, a.dedm020, a.dedm021,   
             a.dedm022
        FROM adep150_tmp32 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
       WHERE NOT EXISTS (SELECT 1 FROM dedm_t b
                          WHERE a.dedment  = b.dedment    
                            AND a.dedmsite = b.dedmsite   
                            AND a.dedm021  = b.dedm021    
                            AND a.dedm022  = b.dedm022)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedm_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedn_cs1 INTO l_dednsite,l_dedn009,l_dedn010
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dednsite
         LET g_errparam.replace[2] = l_dedn009
         LET g_errparam.replace[3] = l_dedn010
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO dedn_t ( dednent,  dednsite, dedn001, dedn005, dedn006,
                           dedn007,  dedn008,  dedn009, dedn010)
      SELECT dednent,  dednsite, dedn001, dedn005, dedn006,
             dedn007,  dedn008,  dedn009, dedn010
        FROM adep150_tmp33   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
       WHERE NOT EXISTS (SELECT 1 FROM dedn_t b
                          WHERE a.dednent  = b.dednent    
                            AND a.dednsite = b.dednsite   
                            AND a.dedn009  = b.dedn009    
                            AND a.dedn010  = b.dedn010)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success

END FUNCTION
#門店月結
PRIVATE FUNCTION adep150_process17(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_debvsite          LIKE debv_t.debvsite
   DEFINE l_debv002           LIKE debv_t.debv002
   DEFINE l_debv003           LIKE debv_t.debv003
   DEFINE l_dedosite          LIKE dedo_t.dedosite
   DEFINE l_dedo020           LIKE dedo_t.dedo020
   DEFINE l_dedo021           LIKE dedo_t.dedo021
   DEFINE l_dedpsite          LIKE dedp_t.dedpsite
   DEFINE l_dedp008           LIKE dedp_t.dedp008
   DEFINE l_dedp009           LIKE dedp_t.dedp009
   
   LET r_success = TRUE  
   
   #debv_t已結轉資料 
   DECLARE adep150_debv_cs1 CURSOR FOR
    SELECT DISTINCT a.debvsite,a.debv002,a.debv003
      FROM adep150_tmp34 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
     WHERE EXISTS (SELECT 1 FROM debv_t b
             WHERE b.debvent  = a.debvent
               AND b.debvsite = a.debvsite
               AND b.debv002  = a.debv002 
               AND b.debv003  = a.debv003 ) 

   #dedo_t已結轉資料
   DECLARE adep150_dedo_cs1 CURSOR FOR
    SELECT DISTINCT a.dedosite,a.dedo020,a.dedo021
      FROM adep150_tmp35 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
     WHERE EXISTS (SELECT 1 FROM dedo_t b
                    WHERE a.dedoent  = b.dedoent    
                      AND a.dedosite = b.dedosite   
                      AND a.dedo020  = b.dedo020    
                      AND a.dedo021  = b.dedo021)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp34 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
                        WHERE a.dedoent  = c.debvent
                          AND a.dedosite = c.debvsite
                          AND a.dedo020  = c.debv002 
                          AND a.dedo021  = c.debv003 )

   #dedp_t已結轉資料
   DECLARE adep150_dedp_cs1 CURSOR FOR
    SELECT DISTINCT a.dedpsite,a.dedp008,a.dedp009
      FROM adep150_tmp36 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
     WHERE EXISTS (SELECT 1 FROM dedp_t b
                    WHERE a.dedpent  = b.dedpent    
                      AND a.dedpsite = b.dedpsite   
                      AND a.dedp008  = b.dedp008    
                      AND a.dedp009  = b.dedp009)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp34 c   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
                        WHERE a.dedpent  = c.debvent
                          AND a.dedpsite = c.debvsite
                          AND a.dedp008  = c.debv002 
                          AND a.dedp009  = c.debv003 )

   IF p_del = "Y" THEN

      FOREACH adep150_debv_cs1 INTO l_debvsite,l_debv002,l_debv003
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_debvsite
         LET g_errparam.replace[2] = l_debv002
         LET g_errparam.replace[3] = l_debv003
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM debv_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp34 b ",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
                  "         WHERE a.debvent  = b.debvent ",
                  "           AND a.debvsite = b.debvsite",
                  "           AND a.debv002  = b.debv002 ", 
                  "           AND a.debv003  = b.debv003 )" 
      PREPARE adep150_del_debv_prep1 FROM g_sql
      EXECUTE adep150_del_debv_prep1

      #塞資料                  
      INSERT INTO debv_t ( debvent, debvsite,debv001, debv002, debv003,
                           debv012, debv013, debv014, debv015, debv016,
                           debv017, debv018, debv019, debv020, debv025,
                           debv026, debv027, debv028, debv029, debv030,
                           debv031, debv032, debv033, debv034)
      SELECT debvent, debvsite,debv001, debv002, debv003,
             debv012, debv013, debv014, debv015, debv016,
             debv017, debv018, debv019, debv020, debv025,
             debv026, debv027, debv028, debv029, debv030,
             debv031, debv032, debv033, debv034
        FROM adep150_tmp34  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debv_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedo_cs1 INTO l_dedosite,l_dedo020,l_dedo021
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedosite
         LET g_errparam.replace[2] = l_dedo020
         LET g_errparam.replace[3] = l_dedo021
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedo_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp35 b ",    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
                  "                WHERE b.dedoent  = a.dedoent ",
                  "                  AND b.dedosite = a.dedosite",
                  "                  AND b.dedo020  = a.dedo020 ",
                  "                  AND b.dedo021  = a.dedo021)"
      PREPARE adep150_del_dedo_prep1 FROM g_sql
      EXECUTE adep150_del_dedo_prep1

      #塞資料                  
      INSERT INTO dedo_t ( dedoent,  dedosite, dedo001, dedo005, dedo006,
                           dedo007,  dedo008,  dedo009, dedo010, dedo011,
                           dedo012,  dedo013,  dedo014, dedo015, dedo016,
                           dedo017,  dedo018,  dedo019, dedo020, dedo021,
                           dedo022)   
      SELECT dedoent,  dedosite, dedo001, dedo005, dedo006,
             dedo007,  dedo008,  dedo009, dedo010, dedo011,
             dedo012,  dedo013,  dedo014, dedo015, dedo016,
             dedo017,  dedo018,  dedo019, dedo020, dedo021,
             dedo022             
        FROM adep150_tmp35  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedo_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedp_cs1 INTO l_dedpsite,l_dedp008,l_dedp009
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedpsite
         LET g_errparam.replace[2] = l_dedp008
         LET g_errparam.replace[3] = l_dedp009
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedp_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp36 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
                  "                WHERE b.dedpent  = a.dedpent ",
                  "                  AND b.dedpsite = a.dedpsite",
                  "                  AND b.dedp008  = a.dedp008 ",
                  "                  AND b.dedp009  = a.dedp009)"
      PREPARE adep150_del_dedp_prep1 FROM g_sql
      EXECUTE adep150_del_dedp_prep1

      #塞資料                  
      INSERT INTO dedp_t ( dedpent,  dedpsite, dedp001, dedp005, dedp006,
                           dedp007,  dedp008,  dedp009)
      SELECT dedpent,  dedpsite, dedp001, dedp005, dedp006,
             dedp007,  dedp008,  dedp009
        FROM adep150_tmp36   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_debv_cs1 INTO l_debvsite,l_debv002,l_debv003
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_debvsite
         LET g_errparam.replace[2] = l_debv002
         LET g_errparam.replace[3] = l_debv003
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO debv_t ( debvent, debvsite,debv001, debv002, debv003,
                           debv012, debv013, debv014, debv015, debv016,
                           debv017, debv018, debv019, debv020, debv025,
                           debv026, debv027, debv028, debv029, debv030,
                           debv031, debv032, debv033, debv034)
      SELECT a.debvent, a.debvsite, a.debv001, a.debv002, a.debv003,
             a.debv012, a.debv013,  a.debv014, a.debv015, a.debv016,
             a.debv017, a.debv018,  a.debv019, a.debv020, a.debv025,
             a.debv026, a.debv027,  a.debv028, a.debv029, a.debv030,
             a.debv031, a.debv032,  a.debv033, a.debv034
        FROM adep150_tmp34 a  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
       WHERE NOT EXISTS (SELECT 1 FROM debv_t b
                          WHERE b.debvent  = a.debvent
                            AND b.debvsite = a.debvsite
                            AND b.debv002  = a.debv002 
                            AND b.debv003  = a.debv003 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debv_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedo_cs1 INTO l_dedosite,l_dedo020,l_dedo021
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedosite
         LET g_errparam.replace[2] = l_dedo020
         LET g_errparam.replace[3] = l_dedo021
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedo_t ( dedoent,  dedosite, dedo001, dedo005, dedo006,
                           dedo007,  dedo008,  dedo009, dedo010, dedo011,
                           dedo012,  dedo013,  dedo014, dedo015, dedo016,
                           dedo017,  dedo018,  dedo019, dedo020, dedo021,
                           dedo022)   
      SELECT a.dedoent,  a.dedosite, a.dedo001, a.dedo005, a.dedo006,
             a.dedo007,  a.dedo008,  a.dedo009, a.dedo010, a.dedo011,
             a.dedo012,  a.dedo013,  a.dedo014, a.dedo015, a.dedo016,
             a.dedo017,  a.dedo018,  a.dedo019, a.dedo020, a.dedo021,
             a.dedo022             
        FROM adep150_tmp35 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
       WHERE NOT EXISTS (SELECT 1 FROM dedo_t b
                          WHERE a.dedoent  = b.dedoent    
                            AND a.dedosite = b.dedosite   
                            AND a.dedo020  = b.dedo020    
                            AND a.dedo021  = b.dedo021)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedo_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedp_cs1 INTO l_dedpsite,l_dedp008,l_dedp009
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedpsite
         LET g_errparam.replace[2] = l_dedp008
         LET g_errparam.replace[3] = l_dedp009
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料                  
      INSERT INTO dedp_t ( dedpent,  dedpsite, dedp001, dedp005, dedp006,
                           dedp007,  dedp008,  dedp009)
      SELECT dedpent,  dedpsite, dedp001, dedp005, dedp006,
             dedp007,  dedp008,  dedp009
        FROM adep150_tmp36   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
       WHERE NOT EXISTS (SELECT 1 FROM dedp_t b
                          WHERE a.dedpent  = b.dedpent    
                            AND a.dedpsite = b.dedpsite   
                            AND a.dedp008  = b.dedp008    
                            AND a.dedp009  = b.dedp009)  

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success

END FUNCTION
#收入收款月結
PRIVATE FUNCTION adep150_process19(p_del)
   DEFINE p_del               LIKE type_t.chr1
   DEFINE r_success           LIKE type_t.num5
   DEFINE l_dedssite          LIKE deds_t.dedssite
   DEFINE l_deds019           LIKE deds_t.deds019
   DEFINE l_deds020           LIKE deds_t.deds020
   DEFINE l_dedtsite          LIKE dedt_t.dedtsite
   DEFINE l_dedt019           LIKE dedt_t.dedt019
   DEFINE l_dedt020           LIKE dedt_t.dedt020
   
   LET r_success = TRUE  
   
   #deds_t已結轉資料 
   DECLARE adep150_deds_cs1 CURSOR FOR
    SELECT DISTINCT a.dedssite,a.deds019,a.deds020
      FROM adep150_tmp37 a     #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
     WHERE EXISTS (SELECT 1 FROM deds_t b
             WHERE b.dedsent  = a.dedsent
               AND b.dedssite = a.dedssite
               AND b.deds019  = a.deds019 
               AND b.deds020  = a.deds020 ) 

   #dedt_t已結轉資料
   DECLARE adep150_dedt_cs1 CURSOR FOR
    SELECT DISTINCT a.dedtsite,a.dedt019,a.dedt020
      FROM adep150_tmp38 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
     WHERE EXISTS (SELECT 1 FROM dedt_t b
                    WHERE a.dedtent  = b.dedtent    
                      AND a.dedtsite = b.dedtsite   
                      AND a.dedt019  = b.dedt019    
                      AND a.dedt020  = b.dedt020)  
       AND NOT EXISTS (SELECT 1 FROM adep150_tmp37 c  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
                        WHERE a.dedtent  = c.dedsent
                          AND a.dedtsite = c.dedssite
                          AND a.dedt019  = c.deds019 
                          AND a.dedt020  = c.deds020 )

   IF p_del = "Y" THEN

      FOREACH adep150_deds_cs1 INTO l_dedssite,l_deds019,l_deds020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedssite
         LET g_errparam.replace[2] = l_deds019
         LET g_errparam.replace[3] = l_deds020
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM deds_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp37 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
                  "         WHERE a.dedsent  = b.dedsent ",
                  "           AND a.dedssite = b.dedssite",
                  "           AND a.deds019  = b.deds019 ", 
                  "           AND a.deds020  = b.deds020 )" 
      PREPARE adep150_del_deds_prep1 FROM g_sql
      EXECUTE adep150_del_deds_prep1

      #塞資料                  
      INSERT INTO deds_t ( dedsent, dedssite,deds001, deds002, deds004,
                           deds005, deds006, deds007, deds008, deds009,
                           deds010, deds011, deds012, deds013, deds014,
                           deds015, deds016, deds017, deds018, deds019,
                           deds020)
      SELECT dedsent, dedssite,deds001, deds002, deds004,
             deds005, deds006, deds007, deds008, deds009, 
             deds010, deds011, deds012, deds013, deds014,
             deds015, deds016, deds017, deds018, deds019,
             deds020
        FROM adep150_tmp37   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deds_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedt_cs1 INTO l_dedtsite,l_dedt019,l_dedt020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedtsite
         LET g_errparam.replace[2] = l_dedt019
         LET g_errparam.replace[3] = l_dedt020
         LET g_errparam.code = 'ade-00123'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #刪除已結轉資料
      LET g_sql = "DELETE FROM dedt_t a ",
                  " WHERE EXISTS (SELECT 1 FROM adep150_tmp38 b ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
                  "                WHERE b.dedtent  = a.dedtent ",
                  "                  AND b.dedtsite = a.dedtsite",
                  "                  AND b.dedt019  = a.dedt019 ",
                  "                  AND b.dedt020  = a.dedt020)"
      PREPARE adep150_del_dedt_prep1 FROM g_sql
      EXECUTE adep150_del_dedt_prep1

      #塞資料                  
      INSERT INTO dedt_t ( dedtent,  dedtsite, dedt001, dedt005, dedt006,
                           dedt007,  dedt008,  dedt009, dedt010, dedt011,
                           dedt012,  dedt013,  dedt014, dedt015, dedt016,
                           dedt017,  dedt018,  dedt019, dedt020)
      SELECT dedtent,  dedtsite, dedt001, dedt005, dedt006,
             dedt007,  dedt008,  dedt009, dedt010, dedt011,
             dedt012,  dedt013,  dedt014, dedt015, dedt016,
             dedt017,  dedt018,  dedt019, dedt020
        FROM adep150_tmp38   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedt_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      FOREACH adep150_deds_cs1 INTO l_dedssite,l_deds019,l_deds020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedssite
         LET g_errparam.replace[2] = l_deds019
         LET g_errparam.replace[3] = l_deds020
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH

      #塞資料
      INSERT INTO deds_t ( dedsent, dedssite,deds001, deds002, deds004,
                           deds005, deds006, deds007, deds008, deds009,
                           deds010, deds011, deds012, deds013, deds014,
                           deds015, deds016, deds017, deds018, deds019,
                           deds020)
      SELECT a.dedsent, a.dedssite, a.deds001, a.deds002, a.deds004,
             a.deds005, a.deds006,  a.deds007, a.deds008, a.deds009,
             a.deds010, a.deds011,  a.deds012, a.deds013, a.deds014,
             a.deds015, a.deds016,  a.deds017, a.deds018, a.deds019,
             a.deds020
        FROM adep150_tmp37 a   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
       WHERE NOT EXISTS (SELECT 1 FROM deds_t b
                          WHERE b.dedsent  = a.dedsent
                            AND b.dedssite = a.dedssite
                            AND b.deds019  = a.deds019 
                            AND b.deds020  = a.deds020 ) 

      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deds_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      FOREACH adep150_dedt_cs1 INTO l_dedtsite,l_dedt019,l_dedt020
         INITIALIZE g_errparam TO NULL
         LET g_errparam.replace[1] = l_dedtsite
         LET g_errparam.replace[2] = l_dedt019
         LET g_errparam.replace[3] = l_dedt020
         LET g_errparam.code = 'ade-00124'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END FOREACH


      INSERT INTO dedt_t ( dedtent,  dedtsite, dedt001, dedt005, dedt006,
                           dedt007,  dedt008,  dedt009, dedt010, dedt011,
                           dedt012,  dedt013,  dedt014, dedt015, dedt016,
                           dedt017,  dedt018,  dedt019, dedt020)
      SELECT a.dedtent,  a.dedtsite, a.dedt001, a.dedt005, a.dedt006,
             a.dedt007,  a.dedt008,  a.dedt009, a.dedt010, a.dedt011,
             a.dedt012,  a.dedt013,  a.dedt014, a.dedt015, a.dedt016,
             a.dedt017,  a.dedt018,  a.dedt019, a.dedt020
        FROM adep150_tmp38 a    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
       WHERE NOT EXISTS (SELECT 1 FROM dedt_t b
                          WHERE a.dedtent  = b.dedtent    
                            AND a.dedtsite = b.dedtsite   
                            AND a.dedt019  = b.dedt019    
                            AND a.dedt020  = b.dedt020)  
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins dedt_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

   END IF  
   
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_create_temp10()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp10() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp20(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      debuent         SMALLINT,  
      debusite        VARCHAR(10),  
      debu001         VARCHAR(10),  
      debu002         VARCHAR(10),  
      debu003         VARCHAR(10),  
      debu004         VARCHAR(10),  
      debu005         VARCHAR(10),  
      debu006         VARCHAR(10),  
      debu007         VARCHAR(40),  
      debu008         VARCHAR(256),  
      debu009         VARCHAR(255),  
      debu010         VARCHAR(255),  
      debu011         VARCHAR(10),  
      debu012         VARCHAR(10),  
      debu013         VARCHAR(10),  
      debu014         VARCHAR(10),  
      debu015         VARCHAR(20),  
      debu016         VARCHAR(10),  
      debu017         DECIMAL(20,6),  
      debu018         VARCHAR(10),  
      debu019         DECIMAL(20,6),  
      debu020         DECIMAL(20,6),  
      debu021         DECIMAL(20,6),  
      debu022         DECIMAL(20,6),  
      debu023         DECIMAL(20,6),  
      debu024         DECIMAL(20,6),  
      debu025         DECIMAL(20,6),  
      debu026         DECIMAL(20,6),  
      debu027         DECIMAL(20,6),  
      debu028         DECIMAL(20,6),  
      debu029         DECIMAL(20,6),  
      debu030         DECIMAL(20,6),  
      debu031         DECIMAL(20,6),  
      debu032         DECIMAL(20,6),  
      debu033         DECIMAL(20,6),  
      debu034         DECIMAL(20,6),  
      debu035         DECIMAL(20,6),  
      debu036         DECIMAL(20,6),  
      debu037         DECIMAL(20,6),  
      debu038         DECIMAL(20,6),  
      debu039         DECIMAL(20,6),  
      debu040         VARCHAR(40),  
      debu041         VARCHAR(10),
      debu042         DECIMAL(20,6),
      debu043         DECIMAL(20,6),
      debu044         DECIMAL(20,6),
      debu045         DECIMAL(20,6),
      debu046         VARCHAR(10),
      debu048         DECIMAL(20,6),
      debu049         DECIMAL(20,6),
      debu050         VARCHAR(10),
      debu051         VARCHAR(20)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp20'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp21(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      dedeent         SMALLINT,  
      dedesite        VARCHAR(10),
      dede001         VARCHAR(10),
      dede005         VARCHAR(10),
      dede006         VARCHAR(10),
      dede007         VARCHAR(10),
      dede008         VARCHAR(10),
      dede009         VARCHAR(40),
      dede010         VARCHAR(40),
      dede011         VARCHAR(255),
      dede012         VARCHAR(255),
      dede013         VARCHAR(20),
      dede014         VARCHAR(10),
      dede015         VARCHAR(10),
      dede016         VARCHAR(10),
      dede017         VARCHAR(20),
      dede018         VARCHAR(10),
      dede019         VARCHAR(10),
      dede020         VARCHAR(10),
      dede021         VARCHAR(10),   
      dede022         DECIMAL(20,6),
      dede023         DECIMAL(20,6),
      dede024         DECIMAL(20,6),
      dede025         DECIMAL(20,6),
      dede026         DECIMAL(20,6),
      dede027         DECIMAL(20,6),
      dede028         DECIMAL(20,6),
      dede029         DECIMAL(20,6),
      dede030         DECIMAL(22,2),  
      dede031         DECIMAL(20,6),
      dede032         DECIMAL(20,6),
      dede033         DECIMAL(20,6),
      dede034         DECIMAL(20,6),
      dede035         SMALLINT,
      dede036         SMALLINT,
      dede037         VARCHAR(256),
      dede038         DECIMAL(20,6),
      dede039         VARCHAR(10),
      dede040         VARCHAR(10),
      dede041         VARCHAR(20)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp21'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp22(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
      debaent         SMALLINT,  
      debasite        VARCHAR(10),  
      deba001         VARCHAR(10),  
      deba002         DATE,  
      deba003         SMALLINT,  
      deba004         SMALLINT,  
      deba005         VARCHAR(10),  
      deba006         VARCHAR(10),  
      deba007         VARCHAR(10),  
      deba008         VARCHAR(10),  
      deba009         VARCHAR(40),  
      deba010         VARCHAR(40),  
      deba011         VARCHAR(255),  
      deba012         VARCHAR(255),  
      deba013         VARCHAR(20),  
      deba014         VARCHAR(10),  
      deba015         VARCHAR(10),  
      deba016         VARCHAR(10),  
      deba017         VARCHAR(20),  
      deba018         VARCHAR(10),  
      deba019         DECIMAL(20,6),  
      deba020         VARCHAR(10),  
      deba021         DECIMAL(20,6),  
      deba022         DECIMAL(20,6),  
      deba023         DECIMAL(20,6),  
      deba024         DECIMAL(20,6),  
      deba025         DECIMAL(20,6),  
      deba026         DECIMAL(20,6),  
      deba027         DECIMAL(20,6),  
      deba028         DECIMAL(20,6),  
      deba029         DECIMAL(20,6),  
      deba030         DECIMAL(20,6),  
      deba031         DECIMAL(20,6),  
      deba032         DECIMAL(20,6),  
      deba033         DECIMAL(20,6),  
      deba034         DECIMAL(20,6),  
      deba035         DECIMAL(20,6),  
      deba036         DECIMAL(20,6),  
      deba037         DECIMAL(20,6),  
      deba038         DECIMAL(20,6),  
      deba039         DECIMAL(20,6),  
      deba040         DECIMAL(20,6),  
      deba041         SMALLINT,  
      deba042         SMALLINT,  
      deba043         VARCHAR(256),  
      deba044         DECIMAL(20,6),  
      deba045         DECIMAL(20,6),  
      deba046         DECIMAL(20,6),  
      deba047         DECIMAL(20,6),
      deba048         DECIMAL(20,6),
      deba049         VARCHAR(10),
      deba050         DECIMAL(20,6),
      deba051         DECIMAL(20,6),
      deba052         DECIMAL(20,6),
      deba053         VARCHAR(10),
      deba054         VARCHAR(20)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp22'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp11()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp11() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp23(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      dedqent         SMALLINT,  
      dedqsite        VARCHAR(10),  
      dedq001         VARCHAR(10),  
      dedq005         VARCHAR(10),  
      dedq006         VARCHAR(20),  
      dedq007         VARCHAR(10),  
      dedq008         VARCHAR(10),  
      dedq009         VARCHAR(10),  
      dedq010         DECIMAL(20,6),  
      dedq011         DECIMAL(20,6),  
      dedq012         DECIMAL(20,6),  
      dedq013         DECIMAL(20,6),  
      dedq014         DECIMAL(20,6),  
      dedq015         DECIMAL(20,6),  
      dedq016         DECIMAL(20,6),  
      dedq017         DECIMAL(20,6),  
      dedq018         DECIMAL(20,6),  
      dedq019         DECIMAL(20,6),  
      dedq020         DECIMAL(20,6),  
      dedq021         DECIMAL(20,6),  
      dedq022         DECIMAL(20,6),  
      dedq023         DECIMAL(20,6),  
      dedq024         DECIMAL(20,6),  
      dedq025         DECIMAL(20,6),  
      dedq026         DECIMAL(20,6),  
      dedq027         DECIMAL(20,6),  
      dedq028         DECIMAL(20,6),  
      dedq029         DECIMAL(20,6),  
      dedq030         DECIMAL(20,6),  
      dedq031         DECIMAL(20,6),  
      dedq032         DECIMAL(20,6),  
      dedq033         DECIMAL(20,6),  
      dedq034         SMALLINT,  
      dedq035         SMALLINT,
      dedq036         DECIMAL(20,6),
      dedq037         VARCHAR(1)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp23'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp24(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      dedrent         SMALLINT,  
      dedrsite        VARCHAR(10),
      dedr001         VARCHAR(10),
      dedr005         VARCHAR(10),
      dedr006         VARCHAR(20),
      dedr007         VARCHAR(10),
      dedr008         VARCHAR(10),
      dedr009         VARCHAR(10),
      dedr010         VARCHAR(10),
      dedr011         VARCHAR(10),
      dedr012         DECIMAL(20,6),
      dedr013         DECIMAL(20,6),
      dedr014         DECIMAL(20,6),
      dedr015         DECIMAL(20,6),
      dedr016         DECIMAL(20,6),
      dedr017         DECIMAL(20,6),
      dedr018         DECIMAL(20,6),
      dedr019         DECIMAL(20,6),
      dedr020         DECIMAL(22,2),
      dedr021         DECIMAL(20,6),   
      dedr022         DECIMAL(20,6),
      dedr023         DECIMAL(20,6),
      dedr024         DECIMAL(20,6),
      dedr025         SMALLINT,
      dedr026         SMALLINT,
      dedr027         DECIMAL(20,6),
      dedr028         VARCHAR(1)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp24'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp14()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp14() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp25(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      dedfent         SMALLINT,  
      dedfsite        VARCHAR(10),  
      dedf001         VARCHAR(10),  
      dedf005         VARCHAR(10),  
      dedf006         VARCHAR(10),  
      dedf007         VARCHAR(10),  
      dedf008         VARCHAR(10),  
      dedf009         VARCHAR(10),  
      dedf010         VARCHAR(20),  
      dedf011         VARCHAR(10),  
      dedf012         DECIMAL(20,6),  
      dedf013         DECIMAL(20,6),  
      dedf014         DECIMAL(20,6),  
      dedf015         DECIMAL(20,6),  
      dedf016         DECIMAL(20,6),  
      dedf017         DECIMAL(20,6),  
      dedf018         DECIMAL(20,6),  
      dedf019         DECIMAL(20,6),  
      dedf020         DECIMAL(20,6),  
      dedf021         DECIMAL(20,6),  
      dedf022         DECIMAL(20,6),  
      dedf023         DECIMAL(20,6),  
      dedf024         DECIMAL(20,6),  
      dedf025         DECIMAL(20,6),  
      dedf026         DECIMAL(20,6),  
      dedf027         DECIMAL(20,6),  
      dedf028         DECIMAL(20,6),  
      dedf029         DECIMAL(20,6),  
      dedf030         DECIMAL(20,6),  
      dedf031         SMALLINT,  
      dedf032         SMALLINT,
      dedf033         DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp25'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp26(  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      dedgent         SMALLINT,  
      dedgsite        VARCHAR(10),
      dedg001         VARCHAR(10),
      dedg005         VARCHAR(10),
      dedg006         VARCHAR(10),
      dedg007         VARCHAR(10),
      dedg008         VARCHAR(10),
      dedg009         VARCHAR(10),
      dedg010         VARCHAR(20),
      dedg011         VARCHAR(10),
      dedg012         VARCHAR(10),
      dedg013         VARCHAR(10),
      dedg014         DECIMAL(20,6),
      dedg015         DECIMAL(20,6),
      dedg016         DECIMAL(20,6),
      dedg017         DECIMAL(20,6),
      dedg018         DECIMAL(20,6),
      dedg019         DECIMAL(20,6),
      dedg020         DECIMAL(20,6),
      dedg021         DECIMAL(20,6),   
      dedg022         DECIMAL(22,2),
      dedg023         DECIMAL(20,6),
      dedg024         DECIMAL(20,6),
      dedg025         DECIMAL(20,6),
      dedg026         DECIMAL(20,6),
      dedg027         SMALLINT,
      dedg028         SMALLINT,
      dedg029         DECIMAL(20,6)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp26'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp27(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      dedhent         SMALLINT,  
      dedhsite        VARCHAR(10),
      dedh001         VARCHAR(10),
      dedh005         VARCHAR(10),
      dedh006         VARCHAR(10),
      dedh007         VARCHAR(10),
      dedh008         VARCHAR(10),
      dedh009         VARCHAR(10),
      dedh010         VARCHAR(20),
      dedh011         VARCHAR(10),
      dedh012         VARCHAR(10),
      dedh013         VARCHAR(10),
      dedh014         DECIMAL(20,6),
      dedh015         SMALLINT,
      dedh016         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp27'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 

END FUNCTION

PRIVATE FUNCTION adep150_create_temp15()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp15() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp28(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      dedient         SMALLINT,  
      dedisite        VARCHAR(10),  
      dedi001         VARCHAR(10),  
      dedi005         VARCHAR(20),  
      dedi006         VARCHAR(10),  
      dedi007         VARCHAR(10),  
      dedi008         VARCHAR(10),  
      dedi009         DECIMAL(20,6),  
      dedi010         DECIMAL(20,6),  
      dedi011         DECIMAL(20,6),  
      dedi012         DECIMAL(20,6),  
      dedi013         DECIMAL(20,6),  
      dedi014         DECIMAL(20,6),  
      dedi015         DECIMAL(20,6),  
      dedi016         DECIMAL(20,6),  
      dedi017         DECIMAL(20,6),  
      dedi018         DECIMAL(20,6),  
      dedi019         DECIMAL(20,6),  
      dedi020         DECIMAL(20,6),  
      dedi021         DECIMAL(20,6),  
      dedi022         DECIMAL(20,6),  
      dedi023         DECIMAL(20,6),  
      dedi024         DECIMAL(20,6),  
      dedi025         DECIMAL(20,6),  
      dedi026         DECIMAL(20,6),  
      dedi027         SMALLINT,  
      dedi028         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp28'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp29(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      dedjent         SMALLINT,  
      dedjsite        VARCHAR(10),
      dedj001         VARCHAR(10),
      dedj005         VARCHAR(20),
      dedj006         VARCHAR(10),
      dedj007         VARCHAR(10),
      dedj008         VARCHAR(10),
      dedj009         VARCHAR(10),
      dedj010         DECIMAL(20,6),
      dedj011         DECIMAL(20,6),
      dedj012         DECIMAL(20,6),
      dedj013         DECIMAL(20,6),
      dedj014         DECIMAL(20,6),
      dedj015         DECIMAL(20,6),
      dedj016         DECIMAL(20,6),
      dedj017         DECIMAL(20,6),
      dedj018         DECIMAL(22,2),
      dedj019         DECIMAL(20,6),
      dedj020         DECIMAL(20,6),
      dedj021         DECIMAL(20,6),   
      dedj022         DECIMAL(20,6),
      dedj023         SMALLINT,
      dedj024         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp29'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
 
   CREATE TEMP TABLE adep150_tmp30(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      dedkent         SMALLINT,  
      dedksite        VARCHAR(10),
      dedk001         VARCHAR(10),
      dedk005         VARCHAR(20),
      dedk006         VARCHAR(10),
      dedk007         VARCHAR(10),
      dedk008         VARCHAR(10),
      dedk009         VARCHAR(10),
      dedk010         VARCHAR(10),
      dedk011         DECIMAL(20,6),
      dedk012         SMALLINT,
      dedk013         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp30'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp16()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp16() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp31(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      dedlent         SMALLINT,  
      dedlsite        VARCHAR(10),  
      dedl001         VARCHAR(10),  
      dedl005         VARCHAR(10),  
      dedl006         DECIMAL(20,6),  
      dedl007         DECIMAL(20,6),  
      dedl008         DECIMAL(20,6),  
      dedl009         DECIMAL(20,6),  
      dedl010         DECIMAL(20,6),  
      dedl011         DECIMAL(20,6),  
      dedl012         DECIMAL(20,6),  
      dedl013         DECIMAL(20,6),  
      dedl014         DECIMAL(20,6),  
      dedl015         DECIMAL(20,6),  
      dedl016         DECIMAL(20,6),  
      dedl017         DECIMAL(20,6),  
      dedl018         DECIMAL(20,6),  
      dedl019         DECIMAL(20,6),  
      dedl020         DECIMAL(20,6),  
      dedl021         DECIMAL(20,6),  
      dedl022         DECIMAL(20,6),  
      dedl023         DECIMAL(20,6),  
      dedl024         SMALLINT,  
      dedl025         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp31'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp32(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      dedment         SMALLINT,  
      dedmsite        VARCHAR(10),
      dedm001         VARCHAR(10),
      dedm005         VARCHAR(10),
      dedm006         VARCHAR(10),
      dedm007         VARCHAR(10),
      dedm008         DECIMAL(20,6),
      dedm009         DECIMAL(20,6),
      dedm010         DECIMAL(20,6),
      dedm011         DECIMAL(20,6),
      dedm012         DECIMAL(20,6),
      dedm013         DECIMAL(20,6),
      dedm014         DECIMAL(20,6),
      dedm015         DECIMAL(20,6),
      dedm016         DECIMAL(22,2),
      dedm017         DECIMAL(20,6),
      dedm018         DECIMAL(20,6),
      dedm019         DECIMAL(20,6),
      dedm020         DECIMAL(20,6),
      dedm021         SMALLINT,   
      dedm022         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp32'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp33(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      dednent         SMALLINT,  
      dednsite        VARCHAR(10),
      dedn001         VARCHAR(10),
      dedn005         VARCHAR(10),
      dedn006         VARCHAR(10),
      dedn007         VARCHAR(10),
      dedn008         DECIMAL(20,6),
      dedn009         SMALLINT,
      dedn010         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp33'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 

END FUNCTION

PRIVATE FUNCTION adep150_create_temp17()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp17() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp34(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      debvent         SMALLINT,    
      debvsite        VARCHAR(10),  
      debv001         VARCHAR(10),  
      debv002         SMALLINT,  
      debv003         SMALLINT,  
      debv012         DECIMAL(20,6),  
      debv013         DECIMAL(20,6),  
      debv014         DECIMAL(20,6),  
      debv015         DECIMAL(20,6),  
      debv016         DECIMAL(20,6),  
      debv017         DECIMAL(20,6),  
      debv018         DECIMAL(20,6),  
      debv019         DECIMAL(20,6),  
      debv020         DECIMAL(20,6),  
      debv025         DECIMAL(20,6),
      debv026         DECIMAL(20,6),  
      debv027         DECIMAL(20,6),  
      debv028         DECIMAL(20,6),
      debv029         DECIMAL(20,6),
      debv030         DECIMAL(20,6),
      debv031         DECIMAL(20,6),
      debv032         DECIMAL(20,6),
      debv033         DECIMAL(20,6),
      debv034         DECIMAL(20,6)
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp34'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp35(  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      dedoent         SMALLINT,  
      dedosite        VARCHAR(10),
      dedo001         VARCHAR(10),
      dedo005         VARCHAR(10),
      dedo006         VARCHAR(10),
      dedo007         DECIMAL(20,6),
      dedo008         DECIMAL(20,6),
      dedo009         DECIMAL(20,6),
      dedo010         DECIMAL(20,6),
      dedo011         DECIMAL(20,6),
      dedo012         DECIMAL(20,6),
      dedo013         DECIMAL(20,6),
      dedo014         DECIMAL(20,6),
      dedo015         DECIMAL(22,2),
      dedo016         DECIMAL(20,6),
      dedo017         DECIMAL(20,6),
      dedo018         DECIMAL(20,6),
      dedo019         DECIMAL(20,6),
      dedo020         SMALLINT,
      dedo021         SMALLINT,
      dedo022         DECIMAL(20,6)
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp35'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adep150_tmp36(  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      dedpent         SMALLINT,  
      dedpsite        VARCHAR(10),
      dedp001         VARCHAR(10),
      dedp005         VARCHAR(10),
      dedp006         VARCHAR(10),
      dedp007         DECIMAL(20,6),
      dedp008         SMALLINT,
      dedp009         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp36'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep150_create_temp19()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adep150_drop_temp19() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp37(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      dedsent         SMALLINT,  
      dedssite        VARCHAR(10),  
      deds001         VARCHAR(10),  
      deds002         VARCHAR(10),  
      deds004         DECIMAL(20,6),  
      deds005         VARCHAR(40),  
      deds006         DECIMAL(20,6),  
      deds007         DATE,  
      deds008         VARCHAR(15),  
      deds009         VARCHAR(1),  
      deds010         VARCHAR(20),  
      deds011         VARCHAR(10),  
      deds012         DECIMAL(20,6),  
      deds013         VARCHAR(10),  
      deds014         DECIMAL(15,3),  
      deds015         VARCHAR(10),  
      deds016         DECIMAL(20,6),  
      deds017         DECIMAL(20,6),  
      deds018         DECIMAL(20,6),  
      deds019         SMALLINT,  
      deds020         SMALLINT
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp37'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   CREATE TEMP TABLE adep150_tmp38(   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      dedtent         SMALLINT,  
      dedtsite        VARCHAR(10),
      dedt001         VARCHAR(10),
      dedt005         VARCHAR(20),
      dedt006         VARCHAR(10),
      dedt007         VARCHAR(10),
      dedt008         VARCHAR(10),
      dedt009         DECIMAL(20,6),
      dedt010         DECIMAL(20,6),
      dedt011         DECIMAL(20,6),
      dedt012         DECIMAL(20,6),
      dedt013         DECIMAL(20,6),
      dedt014         VARCHAR(10),
      dedt015         DECIMAL(20,6),
      dedt016         DECIMAL(20,6),
      dedt017         DECIMAL(20,6),
      dedt018         VARCHAR(10),
      dedt019         SMALLINT,
      dedt020         SMALLINT
     )               
                    
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adep150_tmp38'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_drop_temp10()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp20   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp20'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp21   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp21'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE adep150_tmp22  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp22'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_drop_temp11()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp23   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp23'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp24   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp24'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp14()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp25   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp25'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp26   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp26'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp27   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp27'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp15()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp28  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp28'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp29    #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp29'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp30   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp30'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp16()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp31   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp31'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp32  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp32'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp33  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp33'   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_drop_temp17()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp34   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp34'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp35  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp35'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp36  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp36'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep150_drop_temp19()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adep150_tmp37   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp37'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE adep150_tmp38   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep150_tmp38'  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_ins_temp10(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   DEFINE l_date         LIKE type_t.dat
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp20  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
   LET l_where = s_aooi500_sql_where(g_prog,'debasite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debasite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
   LET l_sql = " INSERT INTO adep150_tmp20( debuent, debusite,debu004, debu007, debu012, debu013,",
               "                                debu015, debu016, debu017, debu018, debu019, ",
               "                                debu020, debu021, debu022, debu023, debu024, ",
               "                                debu025, debu027, debu028, debu029, debu030, ",
               "                                debu031, debu032, debu033, debu034, debu035, ",
               "                                debu036, debu037, debu038, debu008, debu039, ",
               "                                debu042, debu043, debu044, debu046, debu050, ",
               "                                debu051)  ",
               " SELECT debaent,      debasite,     deba005,     deba009,   COALESCE(deba014,' ') ,   COALESCE(deba015,' '),",
               "        COALESCE(deba017,' '),    COALESCE(deba018,' '),    SUM(COALESCE(deba019,0)), COALESCE(deba020,' '),    SUM(COALESCE(deba021,0)),",
               "        SUM(COALESCE(deba022,0)), SUM(COALESCE(deba023,0)), SUM(COALESCE(deba024,0)), SUM(COALESCE(deba025,0)), SUM(COALESCE(deba026,0)),",
               "        SUM(COALESCE(deba027,0)), SUM(COALESCE(deba029,0)), SUM(COALESCE(deba030,0)), SUM(COALESCE(deba031,0)), SUM(COALESCE(deba032,0)),",
               "        SUM(COALESCE(deba033,0)), SUM(COALESCE(deba034,0)), SUM(COALESCE(deba035,0)), SUM(COALESCE(deba036,0)), SUM(COALESCE(deba037,0)),",
               "        SUM(COALESCE(deba038,0)), SUM(COALESCE(deba039,0)), SUM(COALESCE(deba040,0)), COALESCE(deba043,' '),    SUM(COALESCE(deba044,0)),",
               "        SUM(COALESCE(deba045,0)), SUM(COALESCE(deba046,0)), SUM(COALESCE(deba047,0)), COALESCE(deba049,' '),    COALESCE(deba053,' '),  ",
               "        COALESCE(deba054,' ') ",
               "   FROM deba_t ",
               "  WHERE debaent = ",g_enterprise,
               "    AND deba002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debaent, debasite, deba005, deba009, deba014,",
               "           deba015, deba017,  deba018, deba020, deba043,",
               "           deba049, deba053,  deba054 "               

   PREPARE adep150_ins_debu_temp_prep FROM l_sql
   EXECUTE adep150_ins_debu_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp20"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
   LET l_sql = "UPDATE adep150_tmp20 SET debu001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = debuent AND ooef001 = debusite),",
               "                            (debu040,debu011,debu014) = ( SELECT imaa014,imaa126,COALESCE(imaa009,' ')  ",
               "                                                           FROM imaa_t  ",
               "                                                          WHERE imaaent = debuent AND imaa001 = debu007), ",
               "                            (debu009,debu010) = (SELECT imaal003,imaal004 FROM imaal_t  ",
               "                                                  WHERE imaalent = debuent AND imaal001 = debu007 ",
               "                                                    AND imaal002 = '",g_dlang,"'),",
               "                            (debu041,debu005,debu006) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = debuent AND inaasite = debusite  ",
               "                                                            AND inaa001 = debu004 ), ",
               "                            debu026 = CASE WHEN debu025 = 0 THEN 0 ELSE (debu025 / (CASE WHEN debu024 = 0 THEN debu025 ELSE debu024 END) * 100) END,",
               "                            debu045 = debu024 / (CASE WHEN debu027 = 0 THEN 1 ELSE debu027 END), ",
               "                            debu002 = ",g_year,",",
               "                            debu003 = ",g_month

   PREPARE adep150_debu_upd FROM l_sql 
   EXECUTE adep150_debu_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp20"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #CREATE INDEX debu_temp_01 ON adep150_debu_temp(debuent,debusite,debu002,debu003)
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
   EXECUTE IMMEDIATE "CREATE INDEX debu_temp_01 
                          ON adep150_tmp20( debuent,debusite,debu002,debu003,
                                                COALESCE(debu004,' '),COALESCE(debu007,' '),COALESCE(debu008,' '),COALESCE(debu012,' '),
                                                COALESCE(debu013,' '),COALESCE(debu015,' '),COALESCE(debu016,' '),COALESCE(debu018,' '),
                                                COALESCE(debu046,' '),COALESCE(debu050,' '),COALESCE(debu051,' '))" 
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp20"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      

   IF cl_db_generate_analyze("adep150_tmp20") THEN END IF   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
   LET l_sql = " INSERT INTO adep150_tmp22( debaent, debasite,deba001, deba002, deba003, ",
               "                                 deba004, deba005, deba006, deba007, deba008, ",
               "                                 deba009, deba010, deba011, deba012, deba013, ",
               "                                 deba014, deba015, deba016, deba017, deba018, ",
               "                                 deba019, deba020, deba021, deba022, deba023, ",
               "                                 deba024, deba025, deba026, deba027, deba028, ",
               "                                 deba029, deba030, deba031, deba032, deba033, ",
               "                                 deba034, deba035, deba036, deba037, deba038, ",
               "                                 deba039, deba040, deba041, deba042, deba043, ",
               "                                 deba044, deba045, deba046, deba047, deba048, ",
               "                                 deba049, deba050, deba051, deba052, deba053, ",
               "                                 deba054 ) ",
               " SELECT debaent, debasite,deba001, deba002, deba003, ",
               "        deba004, deba005, deba006, deba007, deba008, ",
               "        deba009, deba010, deba011, deba012, deba013, ",
               "        deba014, deba015, deba016, deba017, deba018, ",
               "        deba019, deba020, deba021, deba022, deba023, ",
               "        deba024, deba025, deba026, deba027, deba028, ",
               "        deba029, deba030, deba031, deba032, deba033, ",
               "        deba034, deba035, deba036, deba037, deba038, ",
               "        deba039, deba040, deba041, deba042, deba043, ",
               "        deba044, deba045, deba046, deba047, deba048, ",
               "        deba049, deba050, deba051, deba052, deba053, ",
               "        deba054 ",
               "   FROM deba_t ",
               "  WHERE debaent = ",g_enterprise,
               "    AND deba002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where 
   
   PREPARE adep150_ins_deba_temp2_prep FROM l_sql
   EXECUTE adep150_ins_deba_temp2_prep USING g_sdate,g_edate   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
   EXECUTE IMMEDIATE "CREATE INDEX deba_temp2_01 
                          ON adep150_tmp22(debaent,debasite,deba002,   
                                                COALESCE(deba005,' '), COALESCE(deba009,' '), COALESCE(deba014,' '), COALESCE(deba015,' '),
                                                COALESCE(deba017,' '), COALESCE(deba018,' '), COALESCE(deba020,' '), COALESCE(deba043,' '),
                                                COALESCE(deba049,' '), COALESCE(deba053,' '), COALESCE(deba054,' '))" 
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp22"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   IF cl_db_generate_analyze("adep150_tmp22") THEN END IF   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
   
   LET l_sql = "UPDATE adep150_tmp20 ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
               "   SET (debu048,debu049) = ((SELECT SUM(COALESCE(deba051,0)),SUM(COALESCE(deba052,0)) FROM adep150_tmp22 ",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deba_temp2 ——> adep150_tmp22
               "                              WHERE debaent = debuent  ",
               "                                AND debasite= debusite ",
               "                                AND COALESCE(deba005,' ') = COALESCE(debu004,' ')  ",
               "                                AND COALESCE(deba009,' ') = COALESCE(debu007,' ')  ",
               "                                AND COALESCE(deba014,' ') = COALESCE(debu012,' ')  ",
               "                                AND COALESCE(deba015,' ') = COALESCE(debu013,' ')  ",
               "                                AND COALESCE(deba017,' ') = COALESCE(debu015,' ')  ",
               "                                AND COALESCE(deba018,' ') = COALESCE(debu016,' ')  ",
               "                                AND COALESCE(deba020,' ') = COALESCE(debu018,' ')  ",
               "                                AND COALESCE(deba043,' ') = COALESCE(debu008,' ')  ",
               "                                AND COALESCE(deba049,' ') = COALESCE(debu046,' ')  ",
               "                                AND COALESCE(deba053,' ') = COALESCE(debu050,' ')  ",
               "                                AND COALESCE(deba054,' ') = COALESCE(debu051,' ')  ",
               "                                AND deba002 = ? ))",  
               " WHERE debu048 IS NULL"
      
   PREPARE adep150_debu_upd2 FROM l_sql                
   LET l_date = g_edate
   
   WHILE TRUE   
      EXECUTE adep150_debu_upd2 USING l_date
      
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE adep150_tmp20"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debu_temp ——> adep150_tmp20
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_date = l_date - 1
      IF l_date < g_sdate THEN EXIT WHILE END IF
   END WHILE
   
   DELETE FROM adep150_tmp21   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
   LET l_where = s_aooi500_sql_where(g_prog,'debbsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debbsite') 
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
   LET l_sql = " INSERT INTO adep150_tmp21( dedeent,  dedesite, dede005, dede009, ",
               "                                dede017,  dede018,  dede019, dede020, dede021,",   
               "                                dede022,  dede023,  dede024, dede025, dede026,",
               "                                dede027,  dede028,  dede030, dede031, dede032,",
               "                                dede033,  dede034,  dede037, dede039, dede040,",
               "                                dede041,  dede014,  dede015)",
               " SELECT debbent,       debbsite,      debb005,      debb009, ",
               "        COALESCE(debb017,' '),     COALESCE(debb018,' '),     COALESCE(debb019,' '),    COALESCE(debb020,' '),    COALESCE(debb021,' '),",  
               "        SUM(COALESCE(debb022,0)),  SUM(COALESCE(debb023,0)),  SUM(COALESCE(debb024,0)), SUM(COALESCE(debb025,0)), SUM(COALESCE(debb026,0)),",
               "        SUM(COALESCE(debb027,0)),  SUM(COALESCE(debb028,0)),  SUM(COALESCE(debb030,0)), SUM(COALESCE(debb031,0)), SUM(COALESCE(debb032,0)),",
               "        SUM(COALESCE(debb033,0)),  SUM(COALESCE(debb034,0)),  COALESCE(debb035,' '),    COALESCE(debb037,' '),    COALESCE(debb038,' '),",
               "        COALESCE(debb039,' '),     COALESCE(debb014,' '),     COALESCE(debb015,' ')   ", 
               "   FROM debb_t ",
               "  WHERE debbent = ",g_enterprise,
               "    AND debb002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debbent, debbsite, debb005, debb009, debb017, ",
               "           debb018,  debb019, debb020, debb021, debb035, ",
               "           debb037,  debb038, debb039, debb014, debb015 "
                    
   PREPARE adep150_ins_dede_temp_prep FROM l_sql
   EXECUTE adep150_ins_dede_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp21"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
   LET l_sql = "UPDATE adep150_tmp21 SET dede001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedeent AND ooef001 = dedesite),",
               "                            (dede010,dede013,dede016) = ( SELECT imaa014,imaa126,COALESCE(imaa009,' ')  ",
               "                                                           FROM imaa_t  ",
               "                                                          WHERE imaaent = dedeent AND imaa001 = dede009), ",
               "                            (dede011,dede012) = (SELECT imaal003,imaal004 FROM imaal_t  ",
               "                                                  WHERE imaalent = dedeent AND imaal001 = dede009 ",
               "                                                    AND imaal002 = '",g_dlang,"'),",
               "                            (dede006,dede007,dede008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = dedeent AND inaasite = dedesite  ",
               "                                                            AND inaa001 = dede005 ), ",
               "                            dede029 = CASE WHEN dede028 = 0 THEN 0 ELSE (dede028 / (CASE WHEN dede027 = 0 THEN dede028 ELSE dede027 END) * 100) END,",
               "                            dede038 = dede027 / (CASE WHEN dede031 = 0 THEN 1 ELSE dede031 END), ",
               "                            dede035 = ",g_year,",",
               "                            dede036 = ",g_month
   PREPARE adep150_dede_upd FROM l_sql 
   EXECUTE adep150_dede_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp21"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dede_temp_01 ON adep150_tmp21(dedeent,dedesite,dede035,dede036)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp21"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dede_temp ——> adep150_tmp21
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp11(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp23  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
   LET l_where = s_aooi500_sql_where(g_prog,'debssite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debssite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
   LET l_sql = " INSERT INTO adep150_tmp23( dedqent, dedqsite,dedq001, dedq005, dedq006,",
               "                                dedq007, dedq008, dedq009, dedq010, dedq011,",
               "                                dedq012, dedq013, dedq014, dedq015, dedq016,",
               "                                dedq017, dedq019, dedq020, dedq021, dedq022,",
               "                                dedq023, dedq024, dedq025, dedq026, dedq027,",
               "                                dedq028, dedq029, dedq030, dedq031, dedq032,",
               "                                dedq033, dedq037)",
               " SELECT debsent,      debssite,     debs001,      debs005,      debs006,     ",
               "        debs007,      debs008,      debs009,      SUM(COALESCE(debs010,0)),      SUM(COALESCE(debs011,0)),",
               "        SUM(COALESCE(debs012,0)), SUM(COALESCE(debs013,0)), SUM(COALESCE(debs014,0)), SUM(COALESCE(debs015,0)), SUM(COALESCE(debs016,0)),",
               "        SUM(COALESCE(debs017,0)), SUM(COALESCE(debs019,0)), SUM(COALESCE(debs020,0)), SUM(COALESCE(debs021,0)), SUM(COALESCE(debs022,0)),",
               "        SUM(COALESCE(debs023,0)), SUM(COALESCE(debs024,0)), SUM(COALESCE(debs025,0)), SUM(COALESCE(debs026,0)), SUM(COALESCE(debs027,0)),",
               "        SUM(COALESCE(debs028,0)), SUM(COALESCE(debs029,0)), SUM(COALESCE(debs030,0)), SUM(COALESCE(debs031,0)), SUM(COALESCE(debs032,0)),", 
               "        SUM(COALESCE(debs033,0)), debs035",
               "   FROM debs_t ",
               "  WHERE debsent = ", g_enterprise,
               "    AND debs002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debsent, debssite, debs001, debs005, debs006,",
               "           debs007, debs008,  debs009, debs035"
               
   PREPARE adep150_ins_dedq_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedq_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp23"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
   LET l_sql = "UPDATE adep150_tmp23 SET dedq001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedqent AND ooef001 = dedqsite),",
               "                             dedq018 = CASE WHEN dedq017 = 0 THEN 0 ELSE (dedq017 / (CASE WHEN dedq016 = 0 THEN dedq017 ELSE dedq016 END) * 100) END,",
               "                             dedq036 = dedq016 / (CASE WHEN dedq019 = 0 THEN 1 ELSE dedq019 END), ",
               "                             dedq034 = ",g_year,",",
               "                             dedq035 = ",g_month
   PREPARE adep150_dedq_upd FROM l_sql 
   EXECUTE adep150_dedq_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp23"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedq_temp_01 ON adep150_tmp23(dedqent,dedqsite,dedq034,dedq035)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp23"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedq_temp ——> adep150_tmp23
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp24   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
   LET l_where = s_aooi500_sql_where(g_prog,'debtsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debtsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24 
   LET l_sql = " INSERT INTO adep150_tmp24( dedrent,  dedrsite, dedr001, dedr005, dedr006,",
               "                                dedr007,  dedr008,  dedr009, dedr010, dedr011,",
               "                                dedr012,  dedr013,  dedr014, dedr015, dedr016,",
               "                                dedr017,  dedr018,  dedr020, dedr021, dedr022,",
               "                                dedr023,  dedr024,  dedr028) ",
               " SELECT debtent,       debtsite,      debt001,      debt005,      debt006,     ",
               "        debt007,       debt008,       debt009,      debt010,      debt011,     ",
               "        SUM(COALESCE(debt012,0)),  SUM(COALESCE(debt013,0)),  SUM(COALESCE(debt014,0)), SUM(COALESCE(debt015,0)), SUM(COALESCE(debt016,0)),",
               "        SUM(COALESCE(debt017,0)),  SUM(COALESCE(debt018,0)),  SUM(COALESCE(debt020,0)), SUM(COALESCE(debt021,0)), SUM(COALESCE(debt022,0)),",
               "        SUM(COALESCE(debt023,0)),  SUM(COALESCE(debt024,0)),  debt026 ",
               "   FROM debt_t ",
               "  WHERE debtent = ",g_enterprise,
               "    AND debt002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debtent, debtsite, debt001, debt005, debt006,",
               "           debt007, debt008,  debt009, debt010, debt011, debt026"
               
   PREPARE adep150_ins_dedr_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedr_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp24"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
   LET l_sql = "UPDATE adep150_tmp24 SET dedr001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedrent AND ooef001 = dedrsite),",
               "                             dedr019 = CASE WHEN dedr018 = 0 THEN 0 ELSE (dedr018 / (CASE WHEN dedr017 = 0 THEN dedr018 ELSE dedr017 END) * 100) END,",
               "                             dedr027 = dedr017 / (CASE WHEN dedr021 = 0 THEN 1 ELSE dedr021 END), ",
               "                             dedr025 = ",g_year,",",
               "                             dedr026 = ",g_month
   PREPARE adep150_dedr_upd FROM l_sql 
   EXECUTE adep150_dedr_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp24"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedr_temp_01 ON adep150_tmp24(dedrent,dedrsite,dedr025,dedr026)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp24"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedr_temp ——> adep150_tmp24
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp14(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp25  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
   LET l_where = s_aooi500_sql_where(g_prog,'debcsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debcsite')
   LET l_sql = " INSERT INTO adep150_tmp25( dedfent, dedfsite,dedf005, dedf009, dedf010, dedf011,",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
               "                                dedf012, dedf013, dedf014, dedf015, dedf016,",
               "                                dedf017, dedf018, dedf019, dedf020, dedf021,",
               "                                dedf022, dedf024, dedf025, dedf026, dedf027,",
               "                                dedf028, dedf029, dedf030)",
               " SELECT debcent,      debcsite,     debc005,      debc009,      debc010,      debc011,     ",
               "        SUM(COALESCE(debc012,0)), SUM(COALESCE(debc013,0)), SUM(COALESCE(debc014,0)), SUM(COALESCE(debc015,0)), SUM(COALESCE(debc016,0)),",
               "        SUM(COALESCE(debc017,0)), SUM(COALESCE(debc018,0)), SUM(COALESCE(debc019,0)), SUM(COALESCE(debc020,0)), SUM(COALESCE(debc021,0)),",
               "        SUM(COALESCE(debc022,0)), SUM(COALESCE(debc024,0)), SUM(COALESCE(debc025,0)), SUM(COALESCE(debc026,0)), SUM(COALESCE(debc027,0)),",
               "        SUM(COALESCE(debc028,0)), SUM(COALESCE(debc029,0)), SUM(COALESCE(debc030,0))",
               "   FROM debc_t",
               "  WHERE debcent = ",g_enterprise,
               "    AND debc002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debcent, debcsite, debc005, debc009, debc010, debc011 "
               
   PREPARE adep150_ins_dedf_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedf_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp25"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
   LET l_sql = "UPDATE adep150_tmp25 SET dedf001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedfent AND ooef001 = dedfsite),",
               "                            (dedf006,dedf007,dedf008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = dedfent AND inaasite = dedfsite  ",
               "                                                            AND inaa001 = dedf005 ), ",
               "                            dedf023 = CASE WHEN dedf022 = 0 THEN 0 ELSE (dedf022 / (CASE WHEN dedf018 = 0 THEN dedf022 ELSE dedf018 END) * 100) END,",
               "                            dedf033 = dedf018 / (CASE WHEN dedf024 = 0 THEN 1 ELSE dedf024 END), ",
               "                            dedf031 = ",g_year,",",
               "                            dedf032 = ",g_month
   PREPARE adep150_dedf_upd FROM l_sql 
   EXECUTE adep150_dedf_upd
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp25"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedf_temp_01 ON adep150_tmp25(dedfent,dedfsite,dedf031,dedf032)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp25"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedf_temp ——> adep150_tmp25
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp26   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
   LET l_where = s_aooi500_sql_where(g_prog,'debdsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debdsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
   LET l_sql = " INSERT INTO adep150_tmp26( dedgent,  dedgsite, dedg005, dedg009, dedg010, dedg011,",
               "                                dedg012,  dedg013,  dedg014, dedg015, dedg016,",
               "                                dedg017,  dedg018,  dedg019, dedg020, dedg022,",
               "                                dedg023,  dedg024,  dedg025, dedg026)",
               " SELECT debdent,      debdsite,      debd005,      debd009,       debd010,      debd011,",
               "        debd012,                   debd013,                   SUM(COALESCE(debd014,0)), SUM(COALESCE(debd015,0)), SUM(COALESCE(debd016,0)),",
               "        SUM(COALESCE(debd017,0)),  SUM(COALESCE(debd018,0)),  SUM(COALESCE(debd019,0)), SUM(COALESCE(debd020,0)), SUM(COALESCE(debd022,0)),",
               "        SUM(COALESCE(debd023,0)),  SUM(COALESCE(debd024,0)),  SUM(COALESCE(debd025,0)), SUM(COALESCE(debd026,0))",
               "   FROM debd_t",
               "  WHERE debdent = ",g_enterprise,
               "    AND debd002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debdent, debdsite, debd005, debd009, debd010, debd011,",
               "           debd012, debd013 "
   
   PREPARE adep150_ins_dedg_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedg_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp26"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
   LET l_sql = "UPDATE adep150_tmp26 SET dedg001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedgent AND ooef001 = dedgsite),",
               "                            (dedg006,dedg007,dedg008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = dedgent AND inaasite = dedgsite  ",
               "                                                            AND inaa001 = dedg005 ), ",
               "                            dedg021 = CASE WHEN dedg020 = 0 THEN 0 ELSE (dedg020 / (CASE WHEN dedg019 = 0 THEN dedg020 ELSE dedg019 END) * 100) END,",
               "                            dedg029 = dedg019 / (CASE WHEN dedg023 = 0 THEN 1 ELSE dedg023 END), ",
               "                            dedg027 = ",g_year,",",
               "                            dedg028 = ",g_month
   PREPARE adep150_dedg_upd FROM l_sql 
   EXECUTE adep150_dedg_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp26"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedg_temp_01 ON adep150_tmp26(dedgent,dedgsite,dedg027,dedg028)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp26"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedg_temp ——> adep150_tmp26
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp27  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
   LET l_where = s_aooi500_sql_where(g_prog,'debesite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debesite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
   LET l_sql = " INSERT INTO adep150_tmp27( dedhent,  dedhsite, dedh005, dedh009, dedh010,",
               "                                dedh011,  dedh012,  dedh013, dedh014) ",
               " SELECT debeent,       debesite,      debe005,       debe009,      debe010,",
               "        debe011,       debe012,       debe013,       SUM(COALESCE(debe014,0)) ",
               "   FROM debe_t ",
               "  WHERE debeent = ",g_enterprise,
               "    AND debe002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debeent, debesite, debe005, debe009, debe010,",
               "           debe011, debe012,  debe013 "

   PREPARE adep150_ins_dedh_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedh_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp27"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
   LET l_sql = "UPDATE adep150_tmp27 SET dedh001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedhent AND ooef001 = dedhsite),",
               "                            (dedh006,dedh007,dedh008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t ",
               "                                                          WHERE inaaent = dedhent AND inaasite = dedhsite  ",
               "                                                            AND inaa001 = dedh005 ), ",
               "                            dedh015 = ",g_year,",",
               "                            dedh016 = ",g_month
   PREPARE adep150_dedh_upd FROM l_sql 
   EXECUTE adep150_dedh_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp27"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedh_temp_01 ON adep150_tmp27(dedhent,dedhsite,dedh015,dedh016)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp27"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedh_temp ——> adep150_tmp27
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success   
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp15(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp28   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
   LET l_where = s_aooi500_sql_where(g_prog,'debgsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debgsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
   LET l_sql = " INSERT INTO adep150_tmp28( dedient, dedisite,dedi005, ",
               "                                dedi007, dedi008, dedi009, dedi010, dedi011,",
               "                                dedi012, dedi013, dedi014, dedi015, dedi016,",
               "                                dedi017, dedi018, dedi020, dedi021, dedi022,",
               "                                dedi023, dedi024, dedi025, dedi026)",
               " SELECT debgent,      debgsite,        debg005,",
               "        debg007,                  debg008,                  SUM(COALESCE(debg009,0)), SUM(COALESCE(debg010,0)), SUM(COALESCE(debg011,0)),",
               "        SUM(COALESCE(debg012,0)), SUM(COALESCE(debg013,0)), SUM(COALESCE(debg014,0)), SUM(COALESCE(debg015,0)), SUM(COALESCE(debg016,0)),",
               "        SUM(COALESCE(debg017,0)), SUM(COALESCE(debg018,0)), SUM(COALESCE(debg020,0)), SUM(COALESCE(debg021,0)), SUM(COALESCE(debg022,0)),",
               "        SUM(COALESCE(debg023,0)), SUM(COALESCE(debg024,0)), SUM(COALESCE(debg025,0)), SUM(COALESCE(debg026,0))",
               "   FROM debg_t",
               "  WHERE debgent = ",g_enterprise,
               "    AND debg002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debgent, debgsite, debg005, debg007, debg008 "

   PREPARE adep150_ins_dedi_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedi_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp28"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
   LET l_sql = "UPDATE adep150_tmp28 SET dedi001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedient AND ooef001 = dedisite),",
               "                             dedi006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = dedient AND mhaesite = dedisite AND mhae001 = dedi005),", 
               "                             dedi019 = CASE WHEN dedi018 = 0 THEN 0 ELSE (dedi018 / (CASE WHEN dedi015 = 0 THEN dedi018 ELSE dedi015 END) * 100) END,",
               "                             dedi027 = ",g_year,",",
               "                             dedi028 = ",g_month
   PREPARE adep150_dedi_upd FROM l_sql 
   EXECUTE adep150_dedi_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp28"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedi_temp_01 ON adep150_tmp28(dedient,dedisite,dedi027,dedi028)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp28"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedi_temp ——> adep150_tmp28
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp29   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
   LET l_where = s_aooi500_sql_where(g_prog,'debhsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debhsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
   LET l_sql = "INSERT INTO adep150_tmp29( dedjent,  dedjsite, dedj005, dedj006,",
               "                               dedj007,  dedj008,  dedj009, dedj010, dedj011,",
               "                               dedj012,  dedj013,  dedj014, dedj015, dedj016,",
               "                               dedj018,  dedj019,  dedj020, dedj021, dedj022)",
               " SELECT debhent,       debhsite,         debh005,      debh006,",
               "        debh007,                   debh008,                   debh009,                  SUM(COALESCE(debh010,0)), SUM(COALESCE(debh011,0)),",
               "        SUM(COALESCE(debh012,0)),  SUM(COALESCE(debh013,0)),  SUM(COALESCE(debh014,0)), SUM(COALESCE(debh015,0)), SUM(COALESCE(debh016,0)),",
               "        SUM(COALESCE(debh018,0)),  SUM(COALESCE(debh019,0)),  SUM(COALESCE(debh020,0)), SUM(COALESCE(debh021,0)), SUM(COALESCE(debh022,0))",
               "   FROM debh_t",
               "  WHERE debhent = ",g_enterprise,
               "    AND debh002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debhent, debhsite, debh005, debh006,",
               "           debh007, debh008,  debh009"
               
   PREPARE adep150_ins_dedj_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedj_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp29"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
   LET l_sql = "UPDATE adep150_tmp29 SET dedj001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedjent AND ooef001 = dedjsite),",
               "                             dedj017 = CASE WHEN dedj016 = 0 THEN 0 ELSE (dedj016 / (CASE WHEN dedj015 = 0 THEN dedj016 ELSE dedj015 END) * 100) END,",
               "                             dedj023 = ",g_year,",",
               "                             dedj024 = ",g_month
   PREPARE adep150_dedj_upd FROM l_sql 
   EXECUTE adep150_dedj_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp29"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedj_temp_01 ON adep150_tmp29(dedjent,dedjsite,dedj023,dedj024)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode 
      LET g_errparam.extend = "CREATE INDEX adep150_tmp29"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedj_temp ——> adep150_tmp29
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp30   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
   LET l_where = s_aooi500_sql_where(g_prog,'debisite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debisite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
   LET l_sql = " INSERT INTO adep150_tmp30( dedkent,  dedksite, dedk005, ",
               "                                dedk007,  dedk008,  dedk009, dedk010, dedk011) ",
               " SELECT debient,       debisite,      debi005, ",
               "        debi007,       debi008,       debi009,      debi010,      SUM(COALESCE(debi011,0))",
               "   FROM debi_t",
               "  WHERE debient = ",g_enterprise,
               "    AND debi002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debient, debisite, debi005, ",
               "           debi007, debi008,  debi009, debi010"
               
   PREPARE adep150_ins_dedk_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedk_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp30"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
   LET l_sql = "UPDATE adep150_tmp30 SET dedk001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedkent AND ooef001 = dedksite),",
               "                             dedk006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = dedkent AND mhaesite = dedksite AND mhae001 = dedk005),", 
               "                             dedk012 = ",g_year,",",
               "                             dedk013 = ",g_month
   PREPARE adep150_dedk_upd FROM l_sql 
   EXECUTE adep150_dedk_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp30"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedk_temp_01 ON adep150_tmp30(dedkent,dedksite,dedk012,dedk013)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp30"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedk_temp ——> adep150_tmp30
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success  
END FUNCTION

PRIVATE FUNCTION adep150_ins_temp16(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp31   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
   LET l_where = s_aooi500_sql_where(g_prog,'debksite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debksite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
   LET l_sql = " INSERT INTO adep150_tmp31( dedlent, dedlsite,dedl005, dedl006,",
               "                                dedl007, dedl008, dedl009, dedl010, dedl011,",
               "                                dedl012, dedl013, dedl014, dedl015, dedl017,",
               "                                dedl018, dedl019, dedl020, dedl021, dedl022,",
               "                                dedl023) ",
               " SELECT debkent,      debksite,       debk005,      SUM(COALESCE(debk006,0)),",
               "        SUM(COALESCE(debk007,0)), SUM(COALESCE(debk008,0)), SUM(COALESCE(debk009,0)), SUM(COALESCE(debk010,0)), SUM(COALESCE(debk011,0)),",
               "        SUM(COALESCE(debk012,0)), SUM(COALESCE(debk013,0)), SUM(COALESCE(debk014,0)), SUM(COALESCE(debk015,0)), SUM(COALESCE(debk017,0)),",
               "        SUM(COALESCE(debk018,0)), SUM(COALESCE(debk019,0)), SUM(COALESCE(debk020,0)), SUM(COALESCE(debk021,0)), SUM(COALESCE(debk022,0)),",
               "        SUM(COALESCE(debk023,0)) ",
               "   FROM debk_t",
               "  WHERE debkent = ",g_enterprise,
               "    AND debk002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debkent, debksite, debk005 "

   PREPARE adep150_ins_dedl_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedl_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp31"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
   LET l_sql = "UPDATE adep150_tmp31 SET dedl001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedlent AND ooef001 = dedlsite),", 
               "                             dedl016 = CASE WHEN dedl015 = 0 THEN 0 ELSE (dedl015 / (CASE WHEN dedl011 = 0 THEN dedl015 ELSE dedl011 END) * 100) END,",
               "                             dedl024 = ",g_year,",",
               "                             dedl025 = ",g_month               
   PREPARE adep150_dedl_upd FROM l_sql 
   EXECUTE adep150_dedl_upd    
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp31"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedl_temp_01 ON adep150_tmp31(dedlent,dedlsite,dedl024,dedl025)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp31"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedl_temp ——> adep150_tmp31
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp32  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
   LET l_where = s_aooi500_sql_where(g_prog,'deblsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','deblsite')
   LET l_sql = " INSERT INTO adep150_tmp32( dedment,  dedmsite, dedm005, dedm006,",  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
               "                                dedm007,  dedm008,  dedm009, dedm010, dedm011,",
               "                                dedm012,  dedm013,  dedm014, dedm016, dedm017,",
               "                                dedm018,  dedm019,  dedm020) ",
               " SELECT deblent,       deblsite,      debl005,      debl006, ",
               "        debl007,                   SUM(COALESCE(debl008,0)),  SUM(COALESCE(debl009,0)), SUM(COALESCE(debl010,0)), SUM(COALESCE(debl011,0)),",
               "        SUM(COALESCE(debl012,0)),  SUM(COALESCE(debl013,0)),  SUM(COALESCE(debl014,0)), SUM(COALESCE(debl016,0)), SUM(COALESCE(debl017,0)),",
               "        SUM(COALESCE(debl018,0)),  SUM(COALESCE(debl019,0)),  SUM(COALESCE(debl020,0))",
               "   FROM debl_t ",
               "  WHERE deblent = ",g_enterprise,
               "    AND debl002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY deblent, deblsite, debl005, debl006, debl007 "
                    
   PREPARE adep150_ins_dedm_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedm_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp32"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
   LET l_sql = "UPDATE adep150_tmp32 SET dedm001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedment AND ooef001 = dedmsite),",
               "                             dedm015 = CASE WHEN dedm014 = 0 THEN 0 ELSE (dedm014 / (CASE WHEN dedm013 = 0 THEN dedm014 ELSE dedm013 END) * 100) END,",
               "                             dedm021 = ",g_year,",",
               "                             dedm022 = ",g_month
   PREPARE adep150_dedm_upd FROM l_sql 
   EXECUTE adep150_dedm_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp32"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedm_temp_01 ON adep150_tmp32(dedment,dedmsite,dedm021,dedm022)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp32"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedm_temp ——> adep150_tmp32
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp33  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
   LET l_where = s_aooi500_sql_where(g_prog,'debmsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debmsite')
   LET l_sql = " INSERT INTO adep150_tmp33( dednent,  dednsite,  dedn005, dedn006,",   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
               "                                dedn007,  dedn008)",
               " SELECT debment,       debmsite,       debm005,      debm006,",
               "        debm007,       SUM(COALESCE(debm008,0))",
               "   FROM debm_t",
               "  WHERE debment = ",g_enterprise,
               "    AND debm002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debment, debmsite, debm005, debm006, debm007"
               
   PREPARE adep150_ins_dedn_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedn_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp33"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
   LET l_sql = "UPDATE adep150_tmp33 SET dedn001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dednent AND ooef001 = dednsite),",
               "                             dedn009 = ",g_year,",",
               "                             dedn010 = ",g_month
   PREPARE adep150_dedn_upd FROM l_sql 
   EXECUTE adep150_dedn_upd       
               
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp33"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedn_temp_01 ON adep150_tmp33(dednent,dednsite,dedn009,dedn010)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp33"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedn_temp ——> adep150_tmp33
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success

END FUNCTION

PRIVATE FUNCTION adep150_ins_temp17(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp34   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
   LET l_where = s_aooi500_sql_where(g_prog,'debosite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debosite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
   LET l_sql = " INSERT INTO adep150_tmp34( debvent, debvsite,debv012, debv013,",
               "                                debv014, debv015, debv016, debv017, debv018,",
               "                                debv020, debv025, debv026, debv027, debv028,",
               "                                debv029, debv030, debv031, debv032, debv033)",
               " SELECT deboent,      debosite,   SUM(COALESCE(debo005,0)), SUM(COALESCE(debo006,0)),",
               "        SUM(COALESCE(debo007,0)), SUM(COALESCE(debo008,0)), SUM(COALESCE(debo009,0)), SUM(COALESCE(debo010,0)), SUM(COALESCE(debo014,0)),",
               "        SUM(COALESCE(debo016,0)), SUM(COALESCE(debo017,0)), SUM(COALESCE(debo018,0)), SUM(COALESCE(debo019,0)), SUM(COALESCE(debo020,0)),",
               "        SUM(COALESCE(debo011,0)), SUM(COALESCE(debo012,0)), SUM(COALESCE(debo013,0)), SUM(COALESCE(debo023,0)), SUM(COALESCE(debo024,0)) ",
               "   FROM debo_t",
               "  WHERE deboent = ",g_enterprise,
               "    AND debo002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY deboent, debosite "
               
   PREPARE adep150_ins_debv_temp_prep FROM l_sql
   EXECUTE adep150_ins_debv_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp34"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
   LET l_sql = "UPDATE adep150_tmp34 SET debv001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = debvent AND ooef001 = debvsite),",
               "                             debv019 = CASE WHEN debv018 = 0 THEN 0 ELSE (debv018 / (CASE WHEN debv017 = 0 THEN debv018 ELSE debv017 END) * 100) END,",
               "                             debv034 = debv017 / (CASE WHEN debv020 = 0 THEN 1 ELSE debv020 END),",
               "                             debv002 = ",g_year,",",
               "                             debv003 = ",g_month
               
   PREPARE adep150_debv_upd FROM l_sql 
   EXECUTE adep150_debv_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp34"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
    
   CREATE INDEX debv_temp_01 ON adep150_tmp34(debvent,debvsite,debv002,debv003)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp34"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_debv_temp ——> adep150_tmp34
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp35  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
   LET l_where = s_aooi500_sql_where(g_prog,'debpsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debpsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
   LET l_sql = " INSERT INTO adep150_tmp35( dedoent,  dedosite, dedo005, dedo006,",
               "                                dedo007,  dedo008,  dedo009, dedo010, dedo011,",
               "                                dedo012,  dedo013,  dedo015, dedo016, dedo017,",
               "                                dedo018,  dedo019)",
               " SELECT debpent,       debpsite,        debp005,      debp006,",
               "        SUM(COALESCE(debp007,0)),  SUM(COALESCE(debp008,0)),  SUM(COALESCE(debp009,0)), SUM(COALESCE(debp010,0)), SUM(COALESCE(debp011,0)),",
               "        SUM(COALESCE(debp012,0)),  SUM(COALESCE(debp013,0)),  SUM(COALESCE(debp015,0)), SUM(COALESCE(debp016,0)), SUM(COALESCE(debp017,0)),",
               "        SUM(COALESCE(debp018,0)),  SUM(COALESCE(debp019,0))",
               "   FROM debp_t",
               "  WHERE debpent = ",g_enterprise,
               "    AND debp002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debpent, debpsite, debp005, debp006 "

   PREPARE adep150_ins_dedo_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedo_temp_prep USING g_sdate,g_edate

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp35"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
   LET l_sql = "UPDATE adep150_tmp35 SET dedo001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedoent AND ooef001 = dedosite),",
               "                             dedo014 = CASE WHEN dedo013 = 0 THEN 0 ELSE (dedo013 / (CASE WHEN dedo012 = 0 THEN dedo013 ELSE dedo012 END) * 100) END,",
               "                             dedo022 = dedo012 / (CASE WHEN dedo016 = 0 THEN 1 ELSE dedo016 END), ",
               "                             dedo020 = ",g_year,",",
               "                             dedo021 = ",g_month
   PREPARE adep150_dedo_upd FROM l_sql 
   EXECUTE adep150_dedo_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp35"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedo_temp_01 ON adep150_tmp35(dedoent,dedosite,dedo020,dedo021)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp35"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedo_temp ——> adep150_tmp35
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   DELETE FROM adep150_tmp36   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
   LET l_where = s_aooi500_sql_where(g_prog,'debqsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debqsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
   LET l_sql = " INSERT INTO adep150_tmp36( dedpent,  dedpsite, dedp005, dedp006, dedp007) ",
               " SELECT debqent,       debqsite,       debq005,      debq006,  SUM(COALESCE(debq007,0))",
               "   FROM debq_t",  
               "  WHERE debqent = ",g_enterprise,
               "    AND debq002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debqent, debqsite, debq005, debq006 "

   PREPARE adep150_ins_dedp_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedp_temp_prep USING g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp36"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
   LET l_sql = "UPDATE adep150_tmp36 SET dedp001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedpent AND ooef001 = dedpsite),", 
               "                             dedp008 = ",g_year,",",
               "                             dedp009 = ",g_month
   PREPARE adep150_dedp_upd FROM l_sql
   EXECUTE adep150_dedp_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp36"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedp_temp_01 ON adep150_tmp36(dedpent,dedpsite,dedp008,dedp009)   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp36"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedp_temp ——> adep150_tmp36
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success 

END FUNCTION

PRIVATE FUNCTION adep150_ins_temp19(p_wc)
   DEFINE p_wc           STRING
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   DEFINE l_init_date    LIKE type_t.dat
   
   LET r_success = TRUE
   DELETE FROM adep150_tmp37   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
   LET l_where = s_aooi500_sql_where(g_prog,'debysite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debysite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
   LET l_sql = " INSERT INTO adep150_tmp37( dedsent, dedssite,deds002, deds004,",
               "                                deds005, deds006, deds007, deds008, deds009,",
               "                                deds010, deds011, deds012, deds013, deds014,",
               "                                deds015, deds016, deds017, deds018 ) ",
               " SELECT debyent,                  debysite,                 deby002,                  SUM(COALESCE(deby004,0)),",
               "        deby005,                  SUM(COALESCE(deby006,0)), COALESCE(deby007,? ),    COALESCE(deby008,' '),       COALESCE(deby009,' '),",
               "        COALESCE(deby010,' '),    deby011,                  SUM(COALESCE(deby012,0)), COALESCE(deby013,' '),       SUM(COALESCE(deby014,0)),",
               "        COALESCE(deby015,' '),    SUM(COALESCE(deby016,0)), SUM(COALESCE(deby017,0)), SUM(COALESCE(deby018,0)) ",
               "   FROM deby_t ",
               "  WHERE debyent = ",g_enterprise,
               "    AND deby003 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debyent, debysite, deby002, deby005,",
               "           deby007, deby008,  deby009, deby010, deby011,",
               "           deby013, deby015 "
               
   PREPARE adep150_ins_deds_temp_prep FROM l_sql
   EXECUTE adep150_ins_deds_temp_prep USING l_init_date,g_sdate,g_edate
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp37"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
   LET l_sql = "UPDATE adep150_tmp37 SET deds001 = (SELECT ooia002 FROM ooia_t WHERE ooiaent = dedsent AND ooia001 = deds002),",
               "                             deds019 = ",g_year,",",
               "                             deds020 = ",g_month
   PREPARE adep150_deds_upd FROM l_sql 
   EXECUTE adep150_deds_upd
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp37"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX deds_temp_01 ON adep150_tmp37(dedsent,dedssite,deds019,deds020)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp37"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_deds_temp ——> adep150_tmp37
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF      
   DELETE FROM adep150_tmp38   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
   LET l_where = s_aooi500_sql_where(g_prog,'debzsite')
   LET l_wc = cl_replace_str(p_wc,'rtjasite','debzsite')
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
   LET l_sql = " INSERT INTO adep150_tmp38( dedtent,  dedtsite, dedt005, ",
               "                                dedt007,  dedt008,  dedt009, dedt010, dedt011,",
               "                                dedt012,  dedt013,  dedt014, dedt015, dedt016,",
               "                                dedt017,  dedt018) ",
               " SELECT debzent,                   debzsite,                  debz005, ",
               "        debz007,                   debz008,                   SUM(COALESCE(debz009,0)), SUM(COALESCE(debz010,0)), SUM(COALESCE(debz011,0)),",
               "        SUM(COALESCE(debz012,0)),  SUM(COALESCE(debz013,0)),  debz014 ,                 SUM(COALESCE(debz015,0)), SUM(COALESCE(debz016,0)),",
               "        SUM(COALESCE(debz017,0)),  debz018 ",
               "   FROM debz_t ",
               "  WHERE debzent = ",g_enterprise,
               "    AND debz002 BETWEEN ? AND ? ",
               "    AND ",l_wc,
               "    AND ",l_where,
               "  GROUP BY debzent, debzsite, debz005, ",
               "           debz007, debz008,  debz014, debz018"
               
   PREPARE adep150_ins_dedt_temp_prep FROM l_sql
   EXECUTE adep150_ins_dedt_temp_prep USING g_sdate,g_edate   
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adep150_tmp38"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
   LET l_sql = "UPDATE adep150_tmp38 SET dedt001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = dedtent AND ooef001 = dedtsite),",
               "                             dedt006 = (SELECT mhae002 FROM mhae_t WHERE mhaeent = dedtent AND mhaesite = dedtsite AND mhae001 = dedt005), ", 
               "                             dedt019 = ",g_year,",",
               "                             dedt020 = ",g_month
   PREPARE adep150_dedt_upd FROM l_sql 
   EXECUTE adep150_dedt_upd

   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE adep150_tmp38"   #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE INDEX dedt_temp_01 ON adep150_tmp38(dedtent,dedtsite,dedt019,dedt020)  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep150_tmp38"  #160727-00019#8   16/08/01 By 08734 临时表长度超过15码的减少到15码以下 adep150_dedt_temp ——> adep150_tmp38
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
