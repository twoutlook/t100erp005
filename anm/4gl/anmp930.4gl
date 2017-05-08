#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp930.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-09-02 17:11:05), PR版次:0006(2016-11-30 13:43:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: anmp930
#+ Description: 內部資金調度利息計算作業
#+ Creator....: 02599(2014-08-15 22:49:52)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="anmp930.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150624-00005#3  150629     BY Jessy  處理排程相關程式
#150813-00015#41 2016/01/15 By 02599  增加单据日期栏位检核,不可小于关账日期
#160125-00019#2  2016/03/23 By 02599  利息计算时间长度修改
#160328-00020#11 2016/04/27 By 02599  nmbp_t增加nmbp016利息不截位栏位，用于记录没有按照币别取位的利息金额
#160816-00012#2  2016/08/29 By 01727  ANM增加资金中心，帐套，法人三个栏位权限
#161021-00050#1  2016/10/24 By 08729  處理組織開窗
#161128-00061#2  2016/11/29 by 02481  标准程式定义采用宣告模式,弃用.*写法
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
   #150624-00005#3-----s
   year      LIKE type_t.chr500, 
   month     LIKE type_t.chr500, 
   nmbpdocno LIKE nmbp_t.nmbpdocno, 
   #150624-00005#3-----e
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       nmbm001 LIKE nmbm_t.nmbm001, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   nmbpdocno LIKE nmbp_t.nmbpdocno, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaald       LIKE glaa_t.glaald   #帐套                 #liuym add 2014/12/26
DEFINE g_glaa003      LIKE glaa_t.glaa003  #会计周期参照表号      #liuym add 2014/12/26
DEFINE g_glaa024      LIKE glaa_t.glaa024  #单据别参照表号        #liuym add 2014/12/26
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmp930.main" >}
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
      #150624-00005#3-----s
      #背景執行之預設值
      SELECT glaald,glaa003,glaa024 INTO g_glaald,g_glaa003,g_glaa024 FROM glaa_t WHERE glaaent=g_enterprise
      AND glaa014='Y' AND glaacomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site)
      #150624-00005#3-----e
      #end add-point
      CALL anmp930_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp930 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmp930_init()
 
      #進入選單 Menu (="N")
      CALL anmp930_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp930
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp930.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmp930_init()
 
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
   #2014/12/26 liuym add-----str-----
   #获取资金中心主帐套、会计周期参照表号、单据别参照表号
   SELECT glaald,glaa003,glaa024 INTO g_glaald,g_glaa003,g_glaa024 FROM glaa_t WHERE glaaent=g_enterprise
   AND glaa014='Y' AND glaacomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=g_site)
   #2014/12/26 liuym add-----end-----
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp930.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp930_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa024          LIKE glaa_t.glaa024
   DEFINE l_glaacomp         LIKE glaa_t.glaacomp
   DEFINE l_glaald           LIKE glaa_t.glaald
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_para_data        LIKE fabg_t.fabg004
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-4007') RETURNING l_para_data
   #单据别
   CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
   CALL s_ld_sel_glaa(l_glaald,'glaa024') RETURNING  r_success,l_glaa024    
   
   LET g_master.year=YEAR(g_today)
   LET g_master.month=MONTH(g_today)
   DISPLAY BY NAME g_master.year,g_master.month
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.year,g_master.month,g_master.nmbpdocno 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               IF cl_null(g_master.year) THEN
                  LET g_master.year=YEAR(g_today)
               END IF
               IF cl_null(g_master.month) THEN
                  LET g_master.month=MONTH(g_today)
               END IF
               DISPLAY BY NAME g_master.year,g_master.month
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            IF NOT cl_null(g_master.year) THEN
               IF g_master.year<YEAR(l_para_data) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "anm-00248"
                  LET g_errparam.extend = g_master.year
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  NEXT FIELD year
               END IF
               #150813-00015#41--add--str--
               IF NOT cl_null(g_master.month) THEN
                  IF g_master.year = YEAR(l_para_data) AND g_master.month < MONTH(l_para_data) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_master.month
                     LET g_errparam.code   = 'anm-00387'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_master.month = ''
                     NEXT FIELD month
                  END IF
               END IF
               #150813-00015#41--add--end
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            IF NOT cl_null(g_master.month) THEN
#               IF g_master.month<MONTH(l_para_data) THEN  #150813-00015#41 mark
                IF g_master.year = YEAR(l_para_data) AND g_master.month < MONTH(l_para_data) THEN  #150813-00015#41 add
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = "anm-00249" #150813-00015#41 mark
                  LET g_errparam.code = "anm-00387"  #150813-00015#41 add
                  LET g_errparam.extend = g_master.month
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  
                  NEXT FIELD month
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbpdocno
            #add-point:BEFORE FIELD nmbpdocno name="input.b.nmbpdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbpdocno
            
            #add-point:AFTER FIELD nmbpdocno name="input.a.nmbpdocno"
            IF NOT cl_null(g_master.nmbpdocno) THEN
               #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/26 liuym mark-----str-----
               #IF NOT s_aooi200_chk_slip(g_site,l_glaa024,g_master.nmbpdocno,'anmt950') THEN
               #   LET g_master.nmbpdocno = ''
               #   NEXT FIELD nmbpdocno
               #END IF     
               #2014/12/26 liuym mark-----end-----
               #2014/12/26 liuym add-----str-----
               #财务改为使用s_aooi200_fin中的FUNCTION---
               IF NOT s_aooi200_fin_chk_slip(g_glaald,l_glaa024,g_master.nmbpdocno,'anmt950') THEN
                  LET g_master.nmbpdocno = ''
                  NEXT FIELD nmbpdocno
               END IF
               #2014/12/26 liuym add-----end-----
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbpdocno
            #add-point:ON CHANGE nmbpdocno name="input.g.nmbpdocno"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbpdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbpdocno
            #add-point:ON ACTION controlp INFIELD nmbpdocno name="input.c.nmbpdocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.nmbpdocno             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = l_glaa024 #
            LET g_qryparam.arg2 = "anmt950" #
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.nmbpdocno = g_qryparam.return1              

            DISPLAY g_master.nmbpdocno TO nmbpdocno              #

            NEXT FIELD nmbpdocno                          #返回原欄位


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON nmbm001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               DISPLAY g_site TO nmbm001  #160125-00019#2 aadd
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.nmbm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbm001
            #add-point:ON ACTION controlp INFIELD nmbm001 name="construct.c.nmbm001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef206 = 'Y' "         #161021-00050#1 mark
            #CALL q_ooef001()                      #呼叫開窗   #161021-00050#1 mark
            CALL q_ooef001_33()                               #161021-00050#1 add
            DISPLAY g_qryparam.return1 TO nmbm001  #顯示到畫面上
            NEXT FIELD nmbm001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbm001
            #add-point:BEFORE FIELD nmbm001 name="construct.b.nmbm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbm001
            
            #add-point:AFTER FIELD nmbm001 name="construct.a.nmbm001"
            
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
            CALL anmp930_get_buffer(l_dialog)
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
         CALL anmp930_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#3
      LET lc_param.year       = g_master.year
      LET lc_param.month      = g_master.month
      LET lc_param.nmbpdocno  = g_master.nmbpdocno
      #150624-00005#3
      
      IF cl_null(g_master.wc) THEN
         LET g_master.wc=" 1=1"
      END IF
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
                 CALL anmp930_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmp930_transfer_argv(ls_js)
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
 
{<section id="anmp930.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmp930_transfer_argv(ls_js)
 
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
 
{<section id="anmp930.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmp930_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_flag      LIKE type_t.num5  
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #150624-00005#3-----s
   #將傳遞參數變數傳回給畫面上的變數
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc        = lc_param.wc
      LET g_master.year      = lc_param.year
      LET g_master.month     = lc_param.month
      LET g_master.nmbpdocno = lc_param.nmbpdocno
   END IF
   #150624-00005#3-----e
   
   #错误信息汇总初始化
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
   CALL s_transaction_begin() 
   LET g_success = 'Y'
   #產生利息資料
   CALL anmp930_p() 
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','0')
      CALL cl_err_collect_show()
      #CALL cl_err_showmsg() 
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE anmp930_process_cs CURSOR FROM ls_sql
#  FOREACH anmp930_process_cs INTO
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
   CALL anmp930_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp930.get_buffer" >}
PRIVATE FUNCTION anmp930_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.nmbpdocno = p_dialog.getFieldBuffer('nmbpdocno')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmp930.msgcentre_notify" >}
PRIVATE FUNCTION anmp930_msgcentre_notify()
 
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
 
{<section id="anmp930.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 產生利息資料
# Memo...........:
# Usage..........: CALL anmp930_p()
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp930_p()
   #161128-00061#2----modify------begin-----------
  #DEFINE l_nmbp         RECORD LIKE nmbp_t.* #利息收入
  #DEFINE l_nmbp1        RECORD LIKE nmbp_t.* #利息支出
  #DEFINE l_nmbz         RECORD LIKE nmbz_t.* #利息單頭檔
   DEFINE l_nmbp RECORD  #內部資金排程專案利息資料檔
       nmbpent LIKE nmbp_t.nmbpent, #企業編碼
       nmbpdocno LIKE nmbp_t.nmbpdocno, #利息單號
       nmbpseq LIKE nmbp_t.nmbpseq, #利息項次
       nmbpseq1 LIKE nmbp_t.nmbpseq1, #項次
       nmbp001 LIKE nmbp_t.nmbp001, #資金中心
       nmbp002 LIKE nmbp_t.nmbp002, #年度
       nmbp003 LIKE nmbp_t.nmbp003, #月份
       nmbp004 LIKE nmbp_t.nmbp004, #調度專案
       nmbp005 LIKE nmbp_t.nmbp005, #撥出/撥入單位內部帳戶
       nmbp006 LIKE nmbp_t.nmbp006, #撥入/撥出組織
       nmbp007 LIKE nmbp_t.nmbp007, #幣別
       nmbp008 LIKE nmbp_t.nmbp008, #本金
       nmbp009 LIKE nmbp_t.nmbp009, #年利率
       nmbp010 LIKE nmbp_t.nmbp010, #計息起始日
       nmbp011 LIKE nmbp_t.nmbp011, #利息金額
       nmbp012 LIKE nmbp_t.nmbp012, #調撥單據
       nmbp013 LIKE nmbp_t.nmbp013, #項次
       nmbp014 LIKE nmbp_t.nmbp014, #日
       nmbp015 LIKE nmbp_t.nmbp015, #交易對象
       nmbp016 LIKE nmbp_t.nmbp016  #利息不截位
       END RECORD
   DEFINE l_nmbp1 RECORD  #內部資金排程專案利息資料檔
       nmbpent LIKE nmbp_t.nmbpent, #企業編碼
       nmbpdocno LIKE nmbp_t.nmbpdocno, #利息單號
       nmbpseq LIKE nmbp_t.nmbpseq, #利息項次
       nmbpseq1 LIKE nmbp_t.nmbpseq1, #項次
       nmbp001 LIKE nmbp_t.nmbp001, #資金中心
       nmbp002 LIKE nmbp_t.nmbp002, #年度
       nmbp003 LIKE nmbp_t.nmbp003, #月份
       nmbp004 LIKE nmbp_t.nmbp004, #調度專案
       nmbp005 LIKE nmbp_t.nmbp005, #撥出/撥入單位內部帳戶
       nmbp006 LIKE nmbp_t.nmbp006, #撥入/撥出組織
       nmbp007 LIKE nmbp_t.nmbp007, #幣別
       nmbp008 LIKE nmbp_t.nmbp008, #本金
       nmbp009 LIKE nmbp_t.nmbp009, #年利率
       nmbp010 LIKE nmbp_t.nmbp010, #計息起始日
       nmbp011 LIKE nmbp_t.nmbp011, #利息金額
       nmbp012 LIKE nmbp_t.nmbp012, #調撥單據
       nmbp013 LIKE nmbp_t.nmbp013, #項次
       nmbp014 LIKE nmbp_t.nmbp014, #日
       nmbp015 LIKE nmbp_t.nmbp015, #交易對象
       nmbp016 LIKE nmbp_t.nmbp016  #利息不截位
       END RECORD
   DEFINE l_nmbz RECORD  #內部資金排程專案利息資料單據檔
       nmbzent LIKE nmbz_t.nmbzent, #企業編號
       nmbzdocno LIKE nmbz_t.nmbzdocno, #利息單號
       nmbz001 LIKE nmbz_t.nmbz001, #資金中心
       nmbz002 LIKE nmbz_t.nmbz002, #年度
       nmbz003 LIKE nmbz_t.nmbz003, #月份
       nmbzownid LIKE nmbz_t.nmbzownid, #資料所有者
       nmbzowndp LIKE nmbz_t.nmbzowndp, #資料所屬部門
       nmbzcrtid LIKE nmbz_t.nmbzcrtid, #資料建立者
       nmbzcrtdp LIKE nmbz_t.nmbzcrtdp, #資料建立部門
       nmbzcrtdt LIKE nmbz_t.nmbzcrtdt, #資料創建日
       nmbzmodid LIKE nmbz_t.nmbzmodid, #資料修改者
       nmbzmoddt LIKE nmbz_t.nmbzmoddt, #最近修改日
       nmbzstus LIKE nmbz_t.nmbzstus, #狀態碼
       nmbzcnfid LIKE nmbz_t.nmbzcnfid, #資料確認者
       nmbzcnfdt LIKE nmbz_t.nmbzcnfdt  #資料確認日
       END RECORD
   #161128-00061#2----modify------end-----------
   DEFINE l_seq          LIKE type_t.num5
   DEFINE l_max_day      LIKE type_t.num5
   DEFINE l_sdate        LIKE nmbm_t.nmbmdocdt
   DEFINE l_edate        LIKE nmbm_t.nmbmdocdt
   DEFINE l_nmbmdocno    LIKE nmbm_t.nmbmdocno
   DEFINE l_nmbm001      LIKE nmbm_t.nmbm001
   DEFINE l_nmboseq      LIKE nmbo_t.nmboseq
   DEFINE l_nmbo002      LIKE nmbo_t.nmbo002
   DEFINE l_nmbo005      LIKE nmbo_t.nmbo005
   DEFINE l_nmbo001      LIKE nmbo_t.nmbo002
   DEFINE l_nmbo006      LIKE nmbo_t.nmbo006
   DEFINE l_nmbo008      LIKE nmbo_t.nmbo008
   DEFINE l_nmbo014      LIKE nmbo_t.nmbo014
   DEFINE l_nmbo025      LIKE nmbo_t.nmbo025
   DEFINE l_nmbo022      LIKE nmbo_t.nmbo022
   DEFINE l_nmbg005      LIKE nmbg_t.nmbg005
   DEFINE l_nmbg001      LIKE nmbg_t.nmbg001
   DEFINE l_nmbg008      LIKE nmbg_t.nmbg008
   DEFINE l_nmbg012      LIKE nmbg_t.nmbg012
   DEFINE l_nmbg025      LIKE nmbg_t.nmbg025
   DEFINE l_date         LIKE nmbm_t.nmbmdocdt  #还款日期
   DEFINE l_sday         LIKE type_t.num5       #開始天數
   DEFINE l_eday         LIKE type_t.num5       #結束天數
   DEFINE l_xday         LIKE type_t.num5       #利息結束日
   DEFINE l_day          LIKE type_t.num5       #每一日
   DEFINE l_amt_s        LIKE nmbo_t.nmbo008    #還款金額
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_nmbqdocdt    LIKE nmbq_t.nmbqdocdt
   DEFINE l_nmbw006      LIKE nmbw_t.nmbw006
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_nmbpdocno    LIKE nmbp_t.nmbpdocno
   DEFINE l_nmbp001      LIKE nmbp_t.nmbp001
   #160125-00019#2--add--str--
   DEFINE l_sql1         STRING
   DEFINE l_sql          STRING
   DEFINE l_wc           STRING
   DEFINE l_date_s       LIKE nmbm_t.nmbmdocdt
   DEFINE l_date_e       LIKE nmbm_t.nmbmdocdt
   DEFINE l_nmbm001_o    LIKE nmbm_t.nmbm001
   DEFINE l_glaald       LIKE glaa_t.glaald
   DEFINE l_glaa024      LIKE glaa_t.glaa024
   DEFINE l_glaa003      LIKE glaa_t.glaa003
   DEFINE l_glaa001      LIKE glaa_t.glaa001
   #160125-00019#2--add--end
   DEFINE l_wc_nmbo        STRING      #160816-00012#2 Add
   DEFINE l_wc_nmbg        STRING      #160816-00012#2 Add

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc        #160816-00012#2 Add
   LET l_wc_nmbo = cl_replace_str(l_wc,"ooef001","nmbo001")     #160816-00012#2 Add
   LET l_wc_nmbg = cl_replace_str(l_wc,"ooef001","nmbg001")     #160816-00012#2 Add
   
#   #151125-00006#3--s
#   DEFINE  l_slip_success   LIKE type_t.num5
#   DEFINE  l_conf_success   LIKE type_t.num5
#   DEFINE  l_dfin0031       LIKE type_t.chr1
#   DEFINE  l_dfin0032       LIKE type_t.chr1
#   DEFINE  l_gl_slip        LIKE ooba_t.ooba002 
#   DEFINE  l_slip           LIKE ooba_t.ooba002
#   DEFINE  l_glaald      LIKE glaa_t.glaald
#   #151125-00006#3--e

   #160125-00019#2--mod--str--
#   SELECT COUNT(*) INTO l_cnt FROM nmbp_t 
#   WHERE nmbpent=g_enterprise AND nmbp002=g_master.year AND nmbp003=g_master.month
#   IF l_cnt>0 THEN
#      IF NOT cl_ask_confirm("anm-00267") THEN
#         LET g_success="N"
#         RETURN
#      ELSE
#         DELETE FROM nmbp_t 
#         WHERE nmbpent=g_enterprise AND nmbp002=g_master.year AND nmbp003=g_master.month
#      END IF
#   END IF
   LET l_wc = cl_replace_str(g_master.wc,'nmbm001','nmbp001')
   LET l_sql1="SELECT COUNT(*) FROM nmbz_t,nmbp_t",
              " WHERE nmbzent=nmbpent AND nmbzdocno=nmbpdocno ",
              "   AND nmbz001=nmbp001 AND nmbz002=nmbp002 AND nmbz003=nmbp003",
              "   AND nmbpent=",g_enterprise," AND nmbp002=",g_master.year,
              "   AND nmbp003=",g_master.month,
              "   AND ",l_wc
   #判断是否存在已审核的利息资料，如果存在，提示不可重新产生
   LET l_sql=l_sql1," AND nmbzstus='Y'"
   PREPARE anmp930_cnt_pr1 FROM l_sql
   LET l_cnt=0
   EXECUTE anmp930_cnt_pr1 INTO l_cnt
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00131'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #判断是否产生利息资料
   LET l_sql="SELECT COUNT(*) FROM nmbp_t",
             " WHERE nmbpent=",g_enterprise," AND nmbp002=",g_master.year,
             "   AND nmbp003=",g_master.month,
             "   AND ",l_wc
   PREPARE anmp930_cnt_pr3 FROM l_sql
   
   #判断是否已存在未审核或作废的利息资料，如果存在，询问是否删除重产
   LET l_sql=l_sql1," AND nmbzstus IN ('N','X')"
   PREPARE anmp930_cnt_pr2 FROM l_sql
   LET l_cnt=0
   EXECUTE anmp930_cnt_pr2 INTO l_cnt
   IF l_cnt>0 THEN
      IF NOT cl_ask_confirm("anm-00267") THEN
         LET g_success="N"
         RETURN
      ELSE
         #删除nmbp_t，nmbz_t资料
         LET l_sql="DELETE FROM nmbp_t ",
                   " WHERE nmbpent=",g_enterprise,
                   "   AND nmbp002=",g_master.year," AND nmbp003=",g_master.month,
                   "   AND ",l_wc
         PREPARE anmp930_del_pr1 FROM l_sql
         EXECUTE anmp930_del_pr1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'delete nmbp_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         
         LET l_wc=cl_replace_str(l_wc,'nmbp001','nmbz001')
         LET l_sql="DELETE FROM nmbz_t ",
                   " WHERE nmbzent=",g_enterprise,
                   "   AND nmbz002=",g_master.year," AND nmbz003=",g_master.month,
                   "   AND ",l_wc
         PREPARE anmp930_del_pr2 FROM l_sql
         EXECUTE anmp930_del_pr2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'delete nmbz_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
      END IF
   END IF
   #160125-00019#2--mod--end
   
   CALL s_date_get_max_day(g_master.year,g_master.month) RETURNING l_max_day
   LET l_sdate=MDY(g_master.month,1,g_master.year)
   LET l_edate=MDY(g_master.month,l_max_day,g_master.year)
   #当月建立的调拨单
   LET g_sql="SELECT nmbmdocno,nmbm001,nmboseq,nmbo002,nmbo005,nmbo001,nmbo006,nmbo008,nmbo014,nmbo025,nmbo022,",
             "       nmbg005,nmbg001,nmbg008,nmbg012,nmbg025 ",
             "  FROM nmbm_t,nmbo_t,nmbg_t",
             " WHERE nmbment=nmboent AND nmbmdocno=nmbodocno ",
             "   AND nmbment=nmbgent AND nmbmdocno=nmbgdocno ",
             "   AND nmboseq=nmbgseq AND nmboseq<>nmboseq2 ",
             "   AND nmbmdocdt BETWEEN '",l_sdate,"' AND '",l_edate,"' ",
             #（1）未结案；（2）在本月内结案的
             "   AND (nmbo021='N' OR nmbo021 IS NULL OR (nmbo021='Y' AND nmbo022<='",l_edate,"'))",
             "   AND nmbmstus='Y'",
             "   AND ",g_master.wc,
             "   AND ",l_wc_nmbo CLIPPED,   #160816-00012#2 Add
             "   AND ",l_wc_nmbg CLIPPED,   #160816-00012#2 Add
             " UNION ",
   #当月之前建立的尚未还完款的调拨单
             "SELECT nmbmdocno,nmbm001,nmboseq,nmbo002,nmbo005,nmbo001,nmbo006,nmbo008,nmbo014,nmbo025,nmbo022,",
             "       nmbg005,nmbg001,nmbg008,nmbg012,nmbg025 ",
             "  FROM nmbm_t,nmbo_t,nmbg_t",
             " WHERE nmbment=nmboent AND nmbmdocno=nmbodocno ",
             "   AND nmbment=nmbgent AND nmbmdocno=nmbgdocno ",
             "   AND nmboseq=nmbgseq AND nmboseq<>nmboseq2 ",
             "   AND nmbmdocdt<'",l_sdate,"' ",
             #（1）未结案；（2）在其实截止日期之间结案的
             "   AND (nmbo021='N' OR nmbo021 IS NULL OR (nmbo021='Y' AND nmbo022 BETWEEN '",l_sdate,"' AND '",l_edate,"' ))",
             "   AND nmbmstus='Y'",
             "   AND ",g_master.wc,
             "   AND ",l_wc_nmbo CLIPPED,   #160816-00012#2 Add
             "   AND ",l_wc_nmbg CLIPPED,   #160816-00012#2 Add
             " ORDER BY nmbmdocno,nmboseq"
   PREPARE anmp930_pr FROM g_sql
   DECLARE anmp930_cs CURSOR FOR anmp930_pr
   
   #抓取还款资料
   LET g_sql="SELECT DISTINCT nmbqdocdt,SUM(nmbw006) FROM nmbq_t,nmbw_t ",
             " WHERE nmbqent=nmbwent AND nmbqdocno=nmbwdocno AND nmbqent=",g_enterprise,
             "   AND nmbw001='1' AND nmbw002=? AND nmbw003=?  AND nmbqstus='Y' ",
             "   AND nmbqdocdt BETWEEN '",l_sdate,"' AND '",l_edate,"' ",
             " GROUP BY nmbqdocdt ",
             " ORDER BY nmbqdocdt ASC"
   PREPARE anmp930_pr1 FROM g_sql
   DECLARE anmp930_cs1 CURSOR FOR anmp930_pr1
   
   #起始日期之前已还款金额
   LET g_sql="SELECT SUM(nmbw006) FROM nmbq_t,nmbw_t ",
             " WHERE nmbqent=nmbwent AND nmbqdocno=nmbwdocno AND nmbqent=",g_enterprise,
             "   AND nmbw001='1' AND nmbw002=? AND nmbw003=?  AND nmbqstus='Y' ",
             "   AND nmbqdocdt <' ",l_sdate,"'"
   PREPARE anmp930_pr2 FROM g_sql
   
   LET l_seq=0
   #利息单号
   #财务改为使用s_aooi200_fin中的FUNCTION---2014/12/26 liuym mark-----str-----
   #CALL s_aooi200_gen_docno(g_site,g_master.nmbpdocno,l_edate,'anmt950') 
   #RETURNING l_success,l_nmbpdocno
   #2014/12/26 liuym mark-----end-----
      
   #2014/12/26 liuym add-----str-----
   #财务改为使用s_aooi200_fin中的FUNCTION---
#160125-00019#2--mark--str--    
#   CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_master.nmbpdocno,l_edate,'anmt950')
#                     RETURNING l_success,l_nmbpdocno
#   #2014/12/26 liuym add-----end-----              
#   IF l_success  = 0  THEN
#      #CALL cl_errmsg('','','','apm-00003',1)
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'apm-00003'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      LET g_success = 'N'
#   END IF  
#160125-00019#2--mark--end
   #利息收入
   INITIALIZE l_nmbp.* TO NULL
   LET l_nmbp.nmbpent = g_enterprise
   LET l_nmbp.nmbp002 = g_master.year   #年度
   LET l_nmbp.nmbp003 = g_master.month  #月份
   #利息收入
   INITIALIZE l_nmbp1.* TO NULL
   LET l_nmbp1.nmbpent = g_enterprise
   LET l_nmbp1.nmbp002 = g_master.year   #年度
   LET l_nmbp1.nmbp003 = g_master.month  #月份
      
   LET l_nmbm001_o=NULL
   FOREACH anmp930_cs INTO l_nmbmdocno,l_nmbm001,l_nmboseq,l_nmbo002,l_nmbo005,l_nmbo001,l_nmbo006,
                           l_nmbo008,l_nmbo014,l_nmbo025,l_nmbo022,l_nmbg005,l_nmbg001,
                           l_nmbg008,l_nmbg012,l_nmbg025
      IF SQLCA.sqlcode THEN
         #CALL cl_errmsg('','foreach anmp930_cs','',SQLCA.SQLCODE,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'foreach anmp930_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      #160125-00019#2--add--str--
      #按照资金中心产生单据单号
      IF cl_null(l_nmbm001_o) OR l_nmbm001_o <> l_nmbm001 THEN
         SELECT glaald,glaa024,glaa003,glaa001 INTO l_glaald,l_glaa024,l_glaa003,l_glaa001
           FROM glaa_t
          WHERE glaaent=g_enterprise AND glaa014='Y'
            AND glaacomp=(SELECT ooef017 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_nmbm001)
            
         CALL s_aooi200_fin_gen_docno(l_glaald,l_glaa024,l_glaa003,g_master.nmbpdocno,l_edate,'anmt950')
         RETURNING l_success,l_nmbpdocno
         IF l_success  = 0  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00003'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            CONTINUE FOREACH
         END IF
         LET l_nmbm001_o = l_nmbm001
         LET l_seq = 0
      END IF
      #160125-00019#2--add--end
      #利息收入
#      INITIALIZE l_nmbp.* TO NULL         #160125-00019#2 mark
#      LET l_nmbp.nmbpent = g_enterprise   #160125-00019#2 mark
      LET l_nmbp.nmbpdocno = l_nmbpdocno   #单号 
      LET l_nmbp.nmbpseq1 = l_nmboseq      #調撥單项次
      LET l_nmbp.nmbp001 = l_nmbm001       #資金中心 
#      LET l_nmbp.nmbp002 = g_master.year   #年度   #160125-00019#2 mark
#      LET l_nmbp.nmbp003 = g_master.month  #月份   #160125-00019#2 mark
      LET l_nmbp.nmbp004 = l_nmbo002       #调度项目=nmbo002
      LET l_nmbp.nmbp005 = l_nmbo005       #拨出/入单位内部帐户=nmbo005/nmbg005
      LET l_nmbp.nmbp006 = l_nmbo001       #拨出/入组织=nmbo001/nmbg001
      LET l_nmbp.nmbp007 = l_nmbo006       #币别=nmbo006
      LET l_nmbp.nmbp008 = l_nmbo008       #本金(交易币）:nmbo008/nmbg008 
      LET l_nmbp.nmbp009 = l_nmbo014       #年利率=nmbo014
      LET l_nmbp.nmbp010 = l_nmbg012       #起息日=调拨单的入帐日期=nmbg012
      LET l_nmbp.nmbp012 = l_nmbmdocno     #調撥單據
      LET l_nmbp.nmbp013 = l_nmboseq       #項次
      LET l_nmbp.nmbp015 = l_nmbo025       #利息收入：取nmbo025 交易對象　利息支出取nmbg025
      
      #利息收入
#      INITIALIZE l_nmbp1.* TO NULL         #160125-00019#2 mark
#      LET l_nmbp1.nmbpent = g_enterprise   #160125-00019#2 mark
      LET l_nmbp1.nmbpdocno = l_nmbpdocno   #单号 
      LET l_nmbp1.nmbpseq1 = l_nmboseq      #調撥單项次
      LET l_nmbp1.nmbp001 = l_nmbm001       #資金中心 
#      LET l_nmbp1.nmbp002 = g_master.year   #年度   #160125-00019#2 mark
#      LET l_nmbp1.nmbp003 = g_master.month  #月份   #160125-00019#2 mark
      LET l_nmbp1.nmbp004 = l_nmbo002       #调度项目=nmbo002
      LET l_nmbp1.nmbp005 = l_nmbg005       #拨出/入单位内部帐户=nmbo005/nmbg005
      LET l_nmbp1.nmbp006 = l_nmbg001       #拨出/入组织=nmbo001/nmbg001
      LET l_nmbp1.nmbp007 = l_nmbo006       #币别=nmbo006
      LET l_nmbp1.nmbp008 = l_nmbg008       #本金(交易币）:nmbo008/nmbg008 
      LET l_nmbp1.nmbp009 = l_nmbo014       #年利率=nmbo014
      LET l_nmbp1.nmbp010 = l_nmbg012       #起息日=调拨单的入帐日期=nmbg012
      LET l_nmbp1.nmbp012 = l_nmbmdocno     #調撥單據
      LET l_nmbp1.nmbp013 = l_nmboseq       #項次
      LET l_nmbp1.nmbp015 = l_nmbg025       #利息收入：取nmbo025 交易對象　利息支出取nmbg025
      
      #計算利息截止日
      #160125-00019#2--mod--str--
#      IF cl_null(l_nmbo022) THEN
#         LET l_xday=l_max_day
#      ELSE
#         LET l_xday=DAY(l_nmbo022)
#      END IF
      #开始计算利息日期l_date_s
      IF l_nmbg012< l_sdate THEN
         LET l_date_s=l_sdate
      ELSE
         LET l_date_s=l_nmbg012
      END IF
      #截止计算利息日期l_date_e
      IF cl_null(l_nmbo022) THEN
         LET l_date_e=l_edate
      ELSE
         IF l_nmbo022 < l_edate THEN
            LET l_date_e=l_nmbo022
         ELSE
            LET l_date_e=l_edate
         END IF
      END IF
      #计息日
      LET l_nmbp.nmbp014  = DAY(l_date_s) - 1
      LET l_nmbp1.nmbp014 = l_nmbp.nmbp014                
      #160125-00019#2--mod--end
      
      #利息起始日
#      LET l_sday=1
      
      #起始日期之前已还款金额
      EXECUTE anmp930_pr2 USING l_nmbmdocno,l_nmboseq INTO l_amt_s
      IF cl_null(l_amt_s) THEN LET l_amt_s=0 END IF
      
      #当本金已还款完毕时无需计提利息，退出本次循环
      IF l_nmbo008 < l_amt_s THEN
         CONTINUE FOREACH
      END IF
      
      #查詢是否有還款資料，計算利息，逐筆插入利息表nmbp_t中
      FOREACH anmp930_cs1 USING l_nmbmdocno,l_nmboseq INTO l_nmbqdocdt,l_nmbw006 
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg('','foreach anmp930_cs1','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'foreach anmp930_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         IF cl_null(l_nmbw006) THEN LET l_nmbw006 = 0 END IF #160125-00019#2 add
#         LET l_eday = DAY(l_nmbqdocdt)         #160125-00019#2 mark
         LET l_eday = l_nmbqdocdt - l_date_s +1 #160125-00019#2 add
         
#         FOR l_day = l_sday TO l_eday #160125-00019#2 mark
         FOR l_day = 1 TO l_eday       #160125-00019#2 add
             #利息金额計算
             LET l_nmbp.nmbp011 = (l_nmbo008 -l_amt_s) * l_nmbo014/100/360 
             LET l_nmbp.nmbp016 = l_nmbp.nmbp011  #160328-00020#11 add 
             CALL s_curr_round_ld('1',l_glaald,l_glaa001,l_nmbp.nmbp011,2) RETURNING l_success,g_errno,l_nmbp.nmbp011 #160125-00019#2 add
#             LET l_nmbp.nmbp014 = l_day  #日             #160125-00019#2 mark
             LET l_nmbp.nmbp014 = l_nmbp.nmbp014 + 1  #日 #160125-00019#2 add
             
             #插入利息收入
             LET l_seq=l_seq+1
             LET l_nmbp.nmbpseq = l_seq       #利息项次
             #161128-00061#2----modify------begin-----------
             #INSERT INTO nmbp_t VALUES(l_nmbp.*)
             INSERT INTO nmbp_t (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp004,nmbp005,
                                 nmbp006,nmbp007,nmbp008,nmbp009,nmbp010,nmbp011,nmbp012,nmbp013,nmbp014,
                                 nmbp015,nmbp016)
              VALUES(l_nmbp.nmbpent,l_nmbp.nmbpdocno,l_nmbp.nmbpseq,l_nmbp.nmbpseq1,l_nmbp.nmbp001,l_nmbp.nmbp002,l_nmbp.nmbp003,l_nmbp.nmbp004,l_nmbp.nmbp005,
                     l_nmbp.nmbp006,l_nmbp.nmbp007,l_nmbp.nmbp008,l_nmbp.nmbp009,l_nmbp.nmbp010,l_nmbp.nmbp011,l_nmbp.nmbp012,l_nmbp.nmbp013,l_nmbp.nmbp014,
                     l_nmbp.nmbp015,l_nmbp.nmbp016)
             #161128-00061#2----modify------end-----------
             IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
                #CALL cl_errmsg('ins nmbp_t','','',SQLCA.SQLCODE,1)
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.SQLCODE
                LET g_errparam.extend = "ins nmbp_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET g_success = 'N' 
             END IF
             
             #插入利息支出
             LET l_seq=l_seq+1
             LET l_nmbp1.nmbpseq = l_seq       #利息项次
             LET l_nmbp1.nmbp011 = l_nmbp.nmbp011 * (-1) 
             LET l_nmbp1.nmbp016 = l_nmbp.nmbp016 * (-1)   #160328-00020#11 add
#             LET l_nmbp1.nmbp014 = l_day  #日             #160125-00019#2 mark     
             LET l_nmbp1.nmbp014 = l_nmbp1.nmbp014 + 1 #日 #160125-00019#2 add 
             
             #161128-00061#2----modify------begin-----------
             #INSERT INTO nmbp_t VALUES(l_nmbp1.*)
             INSERT INTO nmbp_t (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp004,nmbp005,
                                 nmbp006,nmbp007,nmbp008,nmbp009,nmbp010,nmbp011,nmbp012,nmbp013,nmbp014,
                                 nmbp015,nmbp016)
              VALUES(l_nmbp1.nmbpent,l_nmbp1.nmbpdocno,l_nmbp1.nmbpseq,l_nmbp1.nmbpseq1,l_nmbp1.nmbp001,l_nmbp1.nmbp002,l_nmbp1.nmbp003,l_nmbp1.nmbp004,l_nmbp1.nmbp005,
                     l_nmbp1.nmbp006,l_nmbp1.nmbp007,l_nmbp1.nmbp008,l_nmbp1.nmbp009,l_nmbp1.nmbp010,l_nmbp1.nmbp011,l_nmbp1.nmbp012,l_nmbp1.nmbp013,l_nmbp1.nmbp014,
                     l_nmbp1.nmbp015,l_nmbp1.nmbp016)
             #161128-00061#2----modify------end-----------
             
             IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
                #CALL cl_errmsg('ins nmbp_t','','',SQLCA.SQLCODE,1)
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.SQLCODE
                LET g_errparam.extend = "ins nmbp_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET g_success = 'N' 
             END IF             
         END FOR
         LET l_date_s = l_nmbqdocdt + 1 #160125-00019#2 add 
#         LET l_sday=l_eday+1           #160125-00019#2 mark
         LET l_amt_s=l_amt_s+l_nmbw006 #歸還金額
      END FOREACH
      #當未完全還款且最後一次還款日不是本月最後一天時繼續計算利息
      #160125-00019#2--mod--str--
#      IF l_sday<l_xday AND l_nmbo008>l_amt_s THEN 
#         FOR l_day = l_sday TO l_xday
      IF l_date_s < l_date_e AND l_nmbo008 > l_amt_s THEN
         LET l_eday = l_date_e - l_date_s + 1
         FOR l_day = 1 TO l_eday
      #160125-00019#2--mod--end
             #利息金额計算
             LET l_nmbp.nmbp011 = (l_nmbo008 -l_amt_s) * l_nmbo014/100/360
             LET l_nmbp.nmbp016 = l_nmbp.nmbp011  #160328-00020#11 add 
             CALL s_curr_round_ld('1',l_glaald,l_glaa001,l_nmbp.nmbp011,2) RETURNING l_success,g_errno,l_nmbp.nmbp011 #160125-00019#2 add
#             LET l_nmbp.nmbp014 = l_day  #日             #160125-00019#2 mark
             LET l_nmbp.nmbp014 = l_nmbp.nmbp014 + 1  #日 #160125-00019#2 add
             
             #插入利息收入
             LET l_seq=l_seq+1
             LET l_nmbp.nmbpseq = l_seq       #利息项次
             #161128-00061#2----modify------begin-----------
             #INSERT INTO nmbp_t VALUES(l_nmbp.*)
             INSERT INTO nmbp_t (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp004,nmbp005,
                                 nmbp006,nmbp007,nmbp008,nmbp009,nmbp010,nmbp011,nmbp012,nmbp013,nmbp014,
                                 nmbp015,nmbp016)
              VALUES(l_nmbp.nmbpent,l_nmbp.nmbpdocno,l_nmbp.nmbpseq,l_nmbp.nmbpseq1,l_nmbp.nmbp001,l_nmbp.nmbp002,l_nmbp.nmbp003,l_nmbp.nmbp004,l_nmbp.nmbp005,
                     l_nmbp.nmbp006,l_nmbp.nmbp007,l_nmbp.nmbp008,l_nmbp.nmbp009,l_nmbp.nmbp010,l_nmbp.nmbp011,l_nmbp.nmbp012,l_nmbp.nmbp013,l_nmbp.nmbp014,
                     l_nmbp.nmbp015,l_nmbp.nmbp016)
             #161128-00061#2----modify------end-----------
             IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
                #CALL cl_errmsg('ins nmbp_t','','',SQLCA.SQLCODE,1)
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.SQLCODE
                LET g_errparam.extend = "ins nmbp_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET g_success = 'N' 
             END IF
             
             #插入利息支出
             LET l_seq=l_seq+1
             LET l_nmbp1.nmbpseq = l_seq       #利息项次
             LET l_nmbp1.nmbp011 = l_nmbp.nmbp011 * (-1) 
             LET l_nmbp1.nmbp016 = l_nmbp.nmbp016 * (-1)   #160328-00020#11 add
#             LET l_nmbp1.nmbp014 = l_day  #日              #160125-00019#2 mark
             LET l_nmbp1.nmbp014 = l_nmbp1.nmbp014 + 1  #日 #160125-00019#2 add
             
             #161128-00061#2----modify------begin-----------
             #INSERT INTO nmbp_t VALUES(l_nmbp1.*)
             INSERT INTO nmbp_t (nmbpent,nmbpdocno,nmbpseq,nmbpseq1,nmbp001,nmbp002,nmbp003,nmbp004,nmbp005,
                                 nmbp006,nmbp007,nmbp008,nmbp009,nmbp010,nmbp011,nmbp012,nmbp013,nmbp014,
                                 nmbp015,nmbp016)
              VALUES(l_nmbp1.nmbpent,l_nmbp1.nmbpdocno,l_nmbp1.nmbpseq,l_nmbp1.nmbpseq1,l_nmbp1.nmbp001,l_nmbp1.nmbp002,l_nmbp1.nmbp003,l_nmbp1.nmbp004,l_nmbp1.nmbp005,
                     l_nmbp1.nmbp006,l_nmbp1.nmbp007,l_nmbp1.nmbp008,l_nmbp1.nmbp009,l_nmbp1.nmbp010,l_nmbp1.nmbp011,l_nmbp1.nmbp012,l_nmbp1.nmbp013,l_nmbp1.nmbp014,
                     l_nmbp1.nmbp015,l_nmbp1.nmbp016)
             #161128-00061#2----modify------end-----------
             
             IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
                #CALL cl_errmsg('ins nmbp_t','','',SQLCA.SQLCODE,1)
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.SQLCODE
                LET g_errparam.extend = "ins nmbp_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET g_success = 'N' 
             END IF               
         END FOR
      END IF
   END FOREACH
   #160125-00019#2--mod--str--
#   SELECT COUNT(*) INTO l_cnt FROM nmbp_t 
#   WHERE nmbpent=g_enterprise AND nmbpdocno=l_nmbpdocno
#   AND nmbp002=g_master.year AND nmbp003=g_master.month
   #判断是否产生利息资料
   LET l_cnt=0
   EXECUTE anmp930_cnt_pr3 INTO l_cnt
   #160125-00019#2--mod--end
   IF l_cnt>0 THEN
      LET g_sql="SELECT DISTINCT nmbp001,nmbpdocno FROM nmbp_t ",   #160125-00019#2 add nmbpdocno
                " WHERE nmbpent=",g_enterprise," AND nmbpdocno='",l_nmbpdocno,"'",
                "   AND nmbp002=",g_master.year," AND nmbp003=",g_master.month
      PREPARE anmp930_pr3 FROM g_sql
      DECLARE anmp930_cs3 CURSOR FOR anmp930_pr3
      
      FOREACH anmp930_cs3 INTO l_nmbp001,l_nmbpdocno  #160125-00019#2 add l_nmbpdocno
         IF SQLCA.sqlcode THEN
            #CALL cl_errmsg('','foreach anmp930_cs3','',SQLCA.SQLCODE,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "foreach anmp930_cs3"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            EXIT FOREACH
         END IF
         
         INITIALIZE l_nmbz.* TO NULL
         LET l_nmbz.nmbzent = g_enterprise
         LET l_nmbz.nmbzdocno = l_nmbpdocno 
         LET l_nmbz.nmbz001 = l_nmbp001      #資金中心
         LET l_nmbz.nmbz002 = g_master.year
         LET l_nmbz.nmbz003 = g_master.month
         LET l_nmbz.nmbzownid = g_user
         LET l_nmbz.nmbzowndp = g_dept
         LET l_nmbz.nmbzcrtid = g_user
         LET l_nmbz.nmbzcrtdp = g_dept
         LET l_nmbz.nmbzcrtdt = cl_get_current()
         LET l_nmbz.nmbzstus = 'N'
         #161128-00061#2----modify------begin-----------
         #INSERT INTO nmbz_t VALUES(l_nmbz.*)
         INSERT INTO nmbz_t (nmbzent,nmbzdocno,nmbz001,nmbz002,nmbz003,nmbzownid,nmbzowndp,nmbzcrtid,
                             nmbzcrtdp,nmbzcrtdt,nmbzmodid,nmbzmoddt,nmbzstus,nmbzcnfid,nmbzcnfdt)
          VALUES(l_nmbz.nmbzent,l_nmbz.nmbzdocno,l_nmbz.nmbz001,l_nmbz.nmbz002,l_nmbz.nmbz003,l_nmbz.nmbzownid,l_nmbz.nmbzowndp,l_nmbz.nmbzcrtid,
                 l_nmbz.nmbzcrtdp,l_nmbz.nmbzcrtdt,l_nmbz.nmbzmodid,l_nmbz.nmbzmoddt,l_nmbz.nmbzstus,l_nmbz.nmbzcnfid,l_nmbz.nmbzcnfdt)
         #161128-00061#2----modify------end-----------
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins nmbz_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N' 
         END IF
      END FOREACH
#      #151125-00006#3  执行立即审核功能
#   SELECT glaald INTO l_glaald
#     FROM glaa_t
#    WHERE glaaent = g_enterprise 
#      AND glaacomp = l_nmbm001
#      AND glaa014 = 'Y'
#      LET l_conf_success = NULL
#      CALL s_aooi200_fin_get_slip(l_nmbz.nmbzdocno) RETURNING l_slip_success,l_slip
#      CALL s_fin_get_doc_para(l_glaald,l_nmbm001,l_slip,'D-FIN-0031') RETURNING l_dfin0031
#  
#      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
#         CALL anmp930_immediately_conf(l_nmbm001,l_nmbz.nmbzdocno) #RETURNING l_conf_success
#      END IF       
#    #151125-00006#3
   #160125-00019#2--add--str--
   ELSE
      #无资料产生
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   #160125-00019#2--add--end
   END IF
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
PRIVATE FUNCTION anmp930_immediately_conf(p_nmbm001,p_nmbzdocno)

#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glaald          LIKE glaa_t.glaald
   DEFINE p_nmbm001         LIKE nmbm_t.nmbm001
   DEFINE p_nmbzdocno       LIKE nmbz_t.nmbzdocno
   DEFINE l_nmbzmoddt       LIKE nmbz_t.nmbzmoddt
   DEFINE l_nmbzcnfdt       LIKE nmbz_t.nmbzcnfdt

   SELECT glaald INTO l_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = p_nmbm001
      AND glaa014 = 'Y'   

   IF cl_null(l_glaald)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(p_nmbm001)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(p_nmbzdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
#   LET l_count = 0
#   SELECT COUNT(*) INTO l_count FROM nmci_t WHERE nmcient = g_enterprise
#      AND nmcidocno = p_nmbzdocno
#      
#   IF cl_null(l_count) THEN LET l_count = 0 END IF
#   IF l_count = 0 THEN
#      RETURN 
#   END IF                   #单身無資料直接返回不做處理
   

   LET l_doc_success = TRUE
   
      IF NOT s_anmt950_conf_chk(p_nmbm001,g_master.year,g_master.month) THEN
         LET l_doc_success = FALSE
      END IF
   
      IF NOT s_anmt950_conf_upd(p_nmbm001,g_master.year,g_master.month) THEN
         LET l_doc_success = FALSE
      END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET l_nmbzmoddt = cl_get_current()
   LET l_nmbzcnfdt = cl_get_current()
   UPDATE nmbz_t SET nmbzstus = 'Y',
                     nmbzmodid= g_user,
                     nmbzmoddt= l_nmbzmoddt,
                     nmbzcnfid= g_user,
                     nmbzcnfdt= l_nmbzcnfdt
    WHERE nmbzent = g_enterprise AND nmbz001 = p_nmbm001
      AND nmbz002 = g_master.year  AND nmbz003 = g_master.month  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

#end add-point
 
{</section>}
 
