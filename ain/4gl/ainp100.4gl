#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-12-21 16:51:12), PR版次:0013(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000097
#+ Filename...: ainp100
#+ Description: 庫存明細重新計算作業
#+ Creator....: 02295(2014-07-01 15:34:49)
#+ Modifier...: 02295 -SD/PR- 00000
 
{</section>}
 
{<section id="ainp100.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160504-00001#1  2016/05/05 By xianghui 程式效能优化
#160810-00031#1  2016/08/10 By lixiang  将ainp100中的ainp100_process的处理逻辑段独立到元件中
#161207-00047#1  2016/12/14 By 02295    效能优化
#161207-00047#2  2016/12/15 By 02295    去掉画面上的上期年度和上期期别，抓取inaj_t时直接计算所有inaj_t的数据
#161220-00034#1  2016/12/15 By 02295    还原#161207-00047#2这个单的处理逻辑
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
   glav002 LIKE type_t.num5,  #161207-00047#2 mark  #161220-00034#1 remark
   glav006 LIKE type_t.num5,   #161207-00047#2 mark #161220-00034#1 remark
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       inag001 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   inag004 LIKE type_t.chr10, 
   imaf052 LIKE type_t.chr20, 
   glav002 LIKE glav_t.glav002, 
   glav006 LIKE glav_t.glav006, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_inag          RECORD LIKE inag_t.*
DEFINE g_stagecomplete LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp100.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #150312---earl---add---s
   SELECT DISTINCT glaa003 INTO g_glaa003
     FROM glaa_t,ooef_t
    WHERE glaacomp = ooef017
      AND glaaent = ooefent
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND glaa014 = 'Y'
   #150312---earl---add---s


   #150312---earl---add---s
   IF NOT cl_null(g_argv[02]) AND NOT cl_null(g_argv[03]) THEN
      LET g_bgjob = "Y"
   END IF
   #150312---earl---add---e

   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainp100_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp100 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp100_init()
 
      #進入選單 Menu (="N")
      CALL ainp100_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp100
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp100.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp100_init()
 
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
   
   #150312---earl---mark---s
#搬至MAIN段，不然背景執行不會跑到這段
#   SELECT DISTINCT glaa003 INTO g_glaa003
#     FROM glaa_t,ooef_t
#    WHERE glaacomp = ooef017
#      AND glaaent = ooefent
#      AND ooefent = g_enterprise
#      AND ooef001 = g_site
#      AND glaa014 = 'Y'
   #150312---earl---mark---s
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp100.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp100_ui_dialog()
 
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
   LET g_master.glav002 = ''   #161207-00047#2 mark  #161220-00034#1 remark
   LET g_master.glav006 = ''   #161207-00047#2 mark  #161220-00034#1 remark
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glav002,g_master.glav006 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav002
            #add-point:BEFORE FIELD glav002 name="input.b.glav002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav002
            
            #add-point:AFTER FIELD glav002 name="input.a.glav002"
            #161220-00034#1---add---s
            IF NOT cl_null(g_master.glav002) THEN 
               IF NOT s_fin_date_chk_year(g_master.glav002) THEN 
                  LET g_master.glav002 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(g_master.glav002) AND NOT cl_null(g_master.glav006) THEN 
               IF NOT s_fin_date_chk_period(g_glaa003,g_master.glav002,g_master.glav006) THEN 
                  LET g_master.glav002 = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT ainp100_glav_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00129'
                  LET g_errparam.extend = g_master.glav002||'/'||g_master.glav006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_master.glav002 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161220-00034#1---add---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav002
            #add-point:ON CHANGE glav002 name="input.g.glav002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.glav006,"1.000","1","13.000","1","azz-00087",1) THEN
               NEXT FIELD glav006
            END IF 
 
 
 
            #add-point:AFTER FIELD glav006 name="input.a.glav006"
            #161220-00034#1---add---s
            IF NOT cl_null(g_master.glav002) AND NOT cl_null(g_master.glav006) THEN 
               IF NOT s_fin_date_chk_period(g_glaa003,g_master.glav002,g_master.glav006) THEN 
                  LET g_master.glav006 = ''
                  NEXT FIELD CURRENT
               END IF
               IF NOT ainp100_glav_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00129'
                  LET g_errparam.extend = g_master.glav002||'/'||g_master.glav006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET g_master.glav006 = ''
                  NEXT FIELD CURRENT
               END IF               
            END IF
            #161220-00034#1---add---e            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav006
            #add-point:BEFORE FIELD glav006 name="input.b.glav006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav006
            #add-point:ON CHANGE glav006 name="input.g.glav006"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glav002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav002
            #add-point:ON ACTION controlp INFIELD glav002 name="input.c.glav002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav006
            #add-point:ON ACTION controlp INFIELD glav006 name="input.c.glav006"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON inag001,imaa009,inag004,imaf052
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.inag001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inag001
            #add-point:ON ACTION controlp INFIELD inag001 name="construct.c.inag001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag001  #顯示到畫面上
            NEXT FIELD inag001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inag001
            #add-point:BEFORE FIELD inag001 name="construct.b.inag001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inag001
            
            #add-point:AFTER FIELD inag001 name="construct.a.inag001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inag004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inag004
            #add-point:ON ACTION controlp INFIELD inag004 name="construct.c.inag004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004  #顯示到畫面上
            NEXT FIELD inag004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inag004
            #add-point:BEFORE FIELD inag004 name="construct.b.inag004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inag004
            
            #add-point:AFTER FIELD inag004 name="construct.a.inag004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf052
            #add-point:ON ACTION controlp INFIELD imaf052 name="construct.c.imaf052"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf052  #顯示到畫面上
            NEXT FIELD imaf052                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf052
            #add-point:BEFORE FIELD imaf052 name="construct.b.imaf052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf052
            
            #add-point:AFTER FIELD imaf052 name="construct.a.imaf052"
            
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
            CALL ainp100_get_buffer(l_dialog)
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
         CALL ainp100_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.glav002 = g_master.glav002  #161207-00047#2 mark  #161220-00034#1 remark
      LET lc_param.glav006 = g_master.glav006  #161207-00047#2 mark  #161220-00034#1 remark
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
                 CALL ainp100_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp100_transfer_argv(ls_js)
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
 
{<section id="ainp100.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp100_transfer_argv(ls_js)
 
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
 
{<section id="ainp100.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp100_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_value    STRING
   DEFINE l_bdate     LIKE type_t.dat
   DEFINE l_edate     LIKE type_t.dat
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_inat015   LIKE inat_t.inat015,
          l_inat021   LIKE inat_t.inat021,
          l_inaj004   LIKE inaj_t.inaj004,
          l_inaj011   LIKE inaj_t.inaj011,
          l_inaj013   LIKE inaj_t.inaj013,
          l_inaj027   LIKE inaj_t.inaj027,
          l_inai007   LIKE inai_t.inai007,
          l_inai008   LIKE inai_t.inai008,
          l_inau017   LIKE inau_t.inau017,
          l_inal014   LIKE inal_t.inal014,
          l_inal014_sum   LIKE inal_t.inal014,
          l_imaf071   LIKE imaf_t.imaf071,
          l_imaf081   LIKE imaf_t.imaf081,
          l_inag008   LIKE inag_t.inag008,
          l_inag025   LIKE inag_t.inag025,
          l_inai010   LIKE inai_t.inai010
#   DEFINE l_imaf054  LIKE imaf_t.imaf054   #150324---earl---mark
#   DEFINE l_inaj014  LIKE inaj_t.inaj014   #150324---earl---mark
   DEFINE l_imaa006  LIKE imaa_t.imaa006   
   
   #150324---earl---add---s
   DEFINE l_inaj046   LIKE inaj_t.inaj046
   DEFINE l_inaj047   LIKE inaj_t.inaj047
   DEFINE l_inaj048   LIKE inaj_t.inaj048
   DEFINE l_inaj049   LIKE inaj_t.inaj049
   #150324---earl---add---e
   DEFINE li_count2   LIKE type_t.num10  #161201-00023#1
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #150312---earl---add---s      
#   IF NOT cl_null(g_argv[01]) THEN  #QBE條件
#      LET lc_param.wc = g_argv[01]
#   END IF
#   
#   IF NOT cl_null(g_argv[02]) THEN  #上期年度
#      LET lc_param.glav002 = g_argv[02]
#   END IF
#   
#   IF NOT cl_null(g_argv[03]) THEN  #上期期別
#      LET lc_param.glav006 = g_argv[03]
#   END IF
   #150312---earl---add---e
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #抓去所需處理資料的總筆數
      #161207-00047#1---mark---s
      #LET g_sql = " SELECT COUNT(*) ",
      #            "   FROM inag_t ",
      #            "        LEFT OUTER JOIN imaa_t ON inagent = imaaent AND inag001 = imaa001 ",
      #            "        LEFT OUTER JOIN imaf_t ON inagent = imafent AND inagsite = imafsite AND inag001 = imaf001 ",              
      #            "  WHERE inagent = '",g_enterprise,"'",
      #            "    AND inagsite = '",g_site,"' AND ",lc_param.wc   
      #PREPARE p100_count_pre FROM g_sql
      #EXECUTE p100_count_pre INTO li_count
      ##161201-00023#1---add---s
      #LET li_count2 = 0
      #LET g_sql = "SELECT COUNT(1)",               
      #            "  FROM inai_t ",
      #            "  LEFT JOIN inau_t ON inauent = inaient AND inausite = inaisite ",
      #            "                  AND inau001 = inai001 AND inau002 = inai002 ",
      #            "                  AND inau003 = inai003 AND inau004 = inai004 ",
      #            "                  AND inau005 = inai005 AND inau006 = inai006 ",
      #            "                  AND inau007 = inai007 AND inau008 = inai008 ",
      #            "                  AND inau009 = inai009 AND inau010 = ",lc_param.glav002,
      #            "                  AND inau011 = ",lc_param.glav006,
      #            "  INNER JOIN imaf_t ON inaient = imafent AND inaisite = imafsite AND inai001 = imaf001 ", 
      #            "  INNER JOIN inag_t ON inai001=inag001 AND inai002=inag002 AND inai003=inag003 AND inai004=inag004",
      #            "                   AND inai005=inag005 AND inai006=inag006 AND inai009=inag007 ",
      #            " WHERE inaient = '",g_enterprise,"'",
      #            "   AND inaisite = '",g_site,"'",
      #            "   AND ",lc_param.wc,
      #            "   AND imaf071 <> '2' ",
      #            "   AND imaf081 <> '2' ",
      #            "   AND EXISTS(SELECT 1 FROM inal_t WHERE inaient = inalent AND inaisite = inalsite AND inai001 = inal006 ",
      #            "                 AND inai002 = inal007 AND inai003 = inal008 AND inai004 = inal009 AND inai005 = inal010 ",
      #            "                 AND inai006 = inal011 AND inai007 = inal012 AND inai008 = inal013 AND inal014 <> 0 )"              
      #PREPARE p100_count_pre2 FROM g_sql
      #EXECUTE p100_count_pre2 INTO li_count2
      #LET li_count = li_count + li_count2
      #161207-00047#1---mark---s
      
      LET li_count = 3  #161207-00047#1 add
      #161201-00023#1---add---e
      CALL cl_progress_bar_no_window(li_count) 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ainp100_process_cs CURSOR FROM ls_sql
#  FOREACH ainp100_process_cs INTO
   #add-point:process段process name="process.process"
#160810-00031#1--s
   #CALL s_ainp100_process(lc_param.glav002,lc_param.glav006,lc_param.wc)  #161207-00047#2 mark
   #CALL s_ainp100_process(0,0,lc_param.wc)  #161207-00047#2 mark  #161220-00034#1 mark
   CALL s_ainp100_process(lc_param.glav002,lc_param.glav006,lc_param.wc)  #161220-00034#1 add
#   ##抓取期別起迄日期
#   CALL s_fin_date_get_period_range(g_glaa003,lc_param.glav002,lc_param.glav006) RETURNING l_bdate,l_edate
#   
#   #150324---earl---mod---s
#   ##依[T.庫存明細檔(inag_t)]抓取[T.庫存交易明細檔(inaj_t)]資料
##   LET g_sql = "SELECT inaj004,inaj011,inaj013,inaj027 ",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
##               "   AND inaj022 > '",l_edate,"'",
##               "   AND inaj004 <> 0 "
##   PREPARE p100_per2 FROM g_sql 
##   DECLARE p100_cur2 CURSOR FOR p100_per2    
##  
##   LET g_sql = "SELECT inaj004,inaj011,inaj013,inaj027 ",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
##               "   AND inaj012 =? ",
##               "   AND inaj022 > '",l_edate,"'",
##               "   AND inaj004 <> 0 "
##   PREPARE p100_per21 FROM g_sql
##   DECLARE p100_cur21 CURSOR FOR p100_per21
#
#   #160504-00001#1---mod---begin
#   #LET g_sql = " SELECT inaj004,inaj011,inaj013,inaj027,",
#   #            "        inaj046,inaj047 ",       
#   LET g_sql = "SELECT COALESCE(SUM(inaj011*inaj046/inaj047*inaj004),0),COALESCE(SUM(inaj027*inaj004),0)",
#   #160504-00001#1---mod---end            
#               "  FROM inaj_t ",
#               " WHERE inajent = '",g_enterprise,"'",
#               "   AND inajsite = '",g_site,"'",
#               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
#               "   AND inaj045 = ?",
#               "   AND inaj022 > '",l_edate,"'",
#               "   AND inaj004 <> 0 "
#   PREPARE p100_per2 FROM g_sql 
#   DECLARE p100_cur2 CURSOR FOR p100_per2    
#   #150324---earl---mod---e
#            
#   LET g_sql = "SELECT DISTINCT inai007,inai008,inau017 ",    #160504-00001#1 add inau017
#               "  FROM inai_t ",
#               #160504-00001#1---add---begin
#               "  LEFT JOIN inau_t ON inauent = inaient AND inausite = inaisite ",
#               "                  AND inau001 = inai001 AND inau002 = inai002 ",
#               "                  AND inau003 = inai003 AND inau004 = inai004 ",
#               "                  AND inau005 = inai005 AND inau006 = inai006 ",
#               "                  AND inau007 = inai007 AND inau008 = inai008 ",
#               "                  AND inau009 = inai009 AND inau010 = ",lc_param.glav002,
#               "                  AND inau011 = ",lc_param.glav006,
#               #160504-00001#1---add---begin
#               " WHERE inaient = '",g_enterprise,"'",
#               "   AND inaisite = '",g_site,"'",
#               "   AND inai001=? AND inai002=? AND inai003=? AND inai004=? AND inai005=? AND inai006=? AND inai009=?"
#   PREPARE p100_pre3 FROM g_sql
#   DECLARE p100_cur3 CURSOR FOR p100_pre3
#     
#   #160504-00001#1---mod---begin  
#   #LET g_sql = "SELECT inaj004,inal014,inaj013,",
#   #            "       inaj046,inaj047",   #150324---earl---add
#   LET g_sql = "SELECT COALESCE(SUM(inal014*inaj046/inaj047*inaj004),0) ",
#   #160504-00001#1---mod---end   
#               "  FROM inal_t,inaj_t ",
#               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
#               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
#               "   AND inalent = '",g_enterprise,"'",
#               "   AND inalsite = '",g_site,"'",
#               "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
#               "   AND inal011 =? AND inal012 =? AND inal013 =? ",
#               "   AND inal016 > '",l_edate,"'",
#               "   AND inal005 <> 0 "
#   PREPARE p100_pre4 FROM g_sql
#   DECLARE p100_cur4 CURSOR FOR p100_pre4   
#    
#   #160504-00001#1---add---begin
#   #   SELECT imaa006 INTO l_imaa006 FROM imaa_t
##    WHERE imaaent= g_enterprise
##      AND imaa001 = g_inag.inag001
##
###150324---earl---mod---s
##   #計算交易單位與成本單位的換算率，和抓取成本料號
##   LET l_imag013 = ''
##   LET l_imag014 = ''
##   SELECT imag013,imag014
##     INTO l_imag013,l_imag014
##     FROM imag_t
##    WHERE imagent = g_enterprise
##      AND imagsite = g_site
##      AND imag001 = g_inag.inag001
#   LET g_sql = "SELECT DISTINCT inaj012,inaj045,inaj028,",
#               "                imaa006,imag013,imag014",
#               "  FROM inaj_t ",
#               "  LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001 ",
#               "  LEFT OUTER JOIN imag_t ON inajent = imagent AND inajsite = imagsite AND inaj005 = imag001 ",               
#               " WHERE inajent = '",g_enterprise,"'",
#               "   AND inajsite = '",g_site,"'",
#               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
#               "   AND inaj045 = ?",
#               "   AND inaj022 > ? ",
#               "   AND inaj004 <> 0 "
#   PREPARE p100_up_inaj_per FROM g_sql 
#   DECLARE p100_up_inaj_cur CURSOR FOR p100_up_inaj_per  
#
#   LET g_sql = " UPDATE inaj_t ",
#               "    SET inaj013 = ? ,",
#               "        inaj014 = ? ,",
#               "        inaj028 = ? ,",
#               "        inaj046 = ? ,",
#               "        inaj047 = ? ,",
#               "        inaj048 = ? ,",
#               "        inaj049 = ? ,",
#               "        inaj050 = ? ,",
#               "        inaj051 = ? ",
#               "  WHERE inajent = '",g_enterprise,"'",
#               "    AND inajsite = '",g_site,"'",
#               "    AND inaj005 = ?",  #g_inag.inag001
#               "    AND inaj006 = ?",  #g_inag.inag002
#               "    AND inaj007 = ?",  #g_inag.inag003
#               "    AND inaj008 = ?",  #g_inag.inag004
#               "    AND inaj009 = ?",  #g_inag.inag005
#               "    AND inaj010 = ?",  #g_inag.inag006
#               "    AND inaj012 = ?",  #l_inaj012
#               "    AND inaj045 = ?"   #l_inaj045
#   PREPARE p100_upd_inaj FROM g_sql          
#         
#   LET g_sql = "UPDATE inag_t ",
#               "   SET inag008 = ?,",    #g_inag.inag008,
#               "       inag025 = ?,",    #g_inag.inag025,
#               "       inag032 = ?,",    #g_inag.inag032,
#               "       inag033 = ?",     #g_inag.inag033 
#               " WHERE inagent = '",g_enterprise,"'",
#               "   AND inagsite = '",g_site,"'",
#               "   AND inag001 = ? ",   #g_inag.inag001
#               "   AND inag002 = ? ",   #g_inag.inag002
#               "   AND inag003 = ? ",   #g_inag.inag003
#               "   AND inag004 = ? ",   #g_inag.inag004
#               "   AND inag005 = ? ",   #g_inag.inag005
#               "   AND inag006 = ? ",   #g_inag.inag006
#               "   AND inag007 = ? "    #g_inag.inag007
#   PREPARE p100_upd_inag FROM g_sql         
#         
#   LET g_sql = "UPDATE inai_t ",
#               "   SET inai010 = ?,",  #l_inai010,
#               "       inai014 = ? ",  #g_inag.inag032   
#               " WHERE inaient = '",g_enterprise,"'",
#               "   AND inaisite = '",g_site,"'",
#               "   AND inai001 = ? ",  #g_inag.inag001 
#               "   AND inai002 = ? ",  #g_inag.inag002
#               "   AND inai003 = ? ",  #g_inag.inag003
#               "   AND inai004 = ? ",  #g_inag.inag004
#               "   AND inai005 = ? ",  #g_inag.inag005
#               "   AND inai006 = ? ",  #g_inag.inag006
#               "   AND inai007 = ? ",  #l_inai007
#               "   AND inai008 = ? ",  #l_inai008
#               "   AND inai009 = ? "   #g_inag.inag007
#   PREPARE p100_upd_inai FROM g_sql            
#   #160504-00001#1---add---end
#   
#   LET g_sql = " SELECT DISTINCT inag001,inag002,inag003,inag004,inag005,inag006,inag007,",
#               "                 inag024,inag032,",   #150416---earl---add
#               "                 COALESCE(inat015,0),COALESCE(inat021,0),imaa006,imaf071,imaf081",   #160504-00001#1 add
#               "   FROM inag_t  ",
#               #160504-00001#1---add---begin
#               "        LEFT JOIN inat_t ON inatent = inagent AND inatsite = inagsite ",
#               "                        AND inat001 = inag001 AND inat002 = inag002 ",
#               "                        AND inat003 = inag003 AND inat004 = inag004 ",
#               "                        AND inat005 = inag005 AND inat006 = inag006 ",
#               "                        AND inat007 = inag007 AND inat008 = ",lc_param.glav002,
#               "                        AND inat009 = ",lc_param.glav006,
#               #160504-00001#1---add---end
#               "        LEFT OUTER JOIN imaa_t ON inagent = imaaent AND inag001 = imaa001 ",
#               "        LEFT OUTER JOIN imaf_t ON inagent = imafent AND inagsite = imafsite AND inag001 = imaf001 ",              
#               "  WHERE inagent = '",g_enterprise,"'",
#               "    AND inagsite = '",g_site,"' AND ",lc_param.wc
#   PREPARE p100_pre FROM g_sql
#   DECLARE p100_cur CURSOR FOR p100_pre
#   FOREACH p100_cur INTO g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#                         g_inag.inag005,g_inag.inag006,g_inag.inag007,
#                         g_inag.inag024,g_inag.inag032,       #150416---earl---add
#                         l_inat015,l_inat021,l_imaa006,l_imaf071,l_imaf081    #160504-00001#1 add
#      #更新庫存交易明細檔中交易單位與庫存單位換算率和交易單位與料件基本單位換算率           
#      CALL ainp100_upd_inaj(l_edate) 
#      
#      ##畫面顯示處理進度 
#      IF g_bgjob <> "Y" THEN
#         LET ls_value = g_inag.inag001
#         CALL cl_progress_no_window_ing(ls_value)
#      END IF       
#                        
#      #160504-00001#1---mark---begin
#      ###抓取上期的期末數量
#      #LET l_inat015 = 0
#      #LET l_inat021 = 0      
#      #SELECT inat015,inat021 INTO l_inat015,l_inat021
#      #  FROM inat_t
#      # WHERE inatent = g_enterprise
#      #   AND inatsite = g_site
#      #   AND inat001 = g_inag.inag001 
#      #   AND inat002 = g_inag.inag002
#      #   AND inat003 = g_inag.inag003
#      #   AND inat004 = g_inag.inag004
#      #   AND inat005 = g_inag.inag005
#      #   AND inat006 = g_inag.inag006
#      #   AND inat007 = g_inag.inag007
#      #   AND inat008 = lc_param.glav002
#      #   AND inat009 = lc_param.glav006
#      #IF cl_null(l_inat015) THEN LET l_inat015 = 0 END IF 
#      #IF cl_null(l_inat021) THEN LET l_inat021 = 0 END IF       
#      #160504-00001#1---mark---end
#      LET l_inag008 = 0   
#      LET l_inag025 = 0   
#      
##150324---earl---mod---s
##      ##依[T.庫存明細檔(inag_t)]抓取[T.庫存交易明細檔(inaj_t)]資料
##      SELECT imaf054 INTO l_imaf054 FROM imaf_t
##       WHERE imafent = g_enterprise AND imafsite = g_site
##         AND imaf001 = g_inag.inag001
##      IF l_imaf054="Y" THEN
##         FOREACH p100_cur21 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
##                                 g_inag.inag005,g_inag.inag006,g_inag.inag007
##                            INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027
##            LET l_inag008 = l_inag008 + l_inaj011 * l_inaj013 * l_inaj004
##            LET l_inag025 = l_inag025 + l_inaj027 * l_inaj004
##            IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
##            IF cl_null(l_inag025) THEN LET l_inag025 = 0 END IF
##         END FOREACH
##      ELSE
##         FOREACH p100_cur2 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
##                                 g_inag.inag005,g_inag.inag006
##                            INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027
##            LET l_inag008 = l_inag008 + l_inaj011 * l_inaj013 * l_inaj004
##            LET l_inag025 = l_inag025 + l_inaj027 * l_inaj004
##            IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
##            IF cl_null(l_inag025) THEN LET l_inag025 = 0 END IF
##         END FOREACH
##      END IF 
# 
#      #160504-00001#1---mod---begin
#      #FOREACH p100_cur2 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#      #                        g_inag.inag005,g_inag.inag006,g_inag.inag007
#      #                   INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027,
#      #                        l_inaj046,l_inaj047
#      #      #LET l_inag008 = l_inag008 + l_inaj011 * l_inaj013 * l_inaj004
#      #      LET l_inag008 = l_inag008 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
#      #      
#      #      LET l_inag025 = l_inag025 + l_inaj027 * l_inaj004
#      #      IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
#      #      IF cl_null(l_inag025) THEN LET l_inag025 = 0 END IF
#      #END FOREACH
#      EXECUTE p100_cur2 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#                              g_inag.inag005,g_inag.inag006,g_inag.inag007
#                         INTO l_inag008,l_inag025    
#      #160504-00001#1---mod---end                        
#      LET g_inag.inag008 = l_inat015 + l_inag008
#      LET g_inag.inag025 = l_inat021 + l_inag025 
#      #160504-00001#1---mark---begin
#      #SELECT imaa006 INTO l_imaa006 FROM imaa_t
#      # WHERE imaaent= g_enterprise
#      #   AND imaa001 = g_inag.inag001
#      #160504-00001#1---mark---end
#      #150416---earl---add----s
#      #取位
#      IF NOT cl_null(g_inag.inag007) AND NOT cl_null(g_inag.inag008) THEN
#         CALL s_aooi250_take_decimals(g_inag.inag007,g_inag.inag008) RETURNING l_success,g_inag.inag008
#      END IF
#      IF NOT cl_null(g_inag.inag024) AND NOT cl_null(g_inag.inag025) THEN
#         CALL s_aooi250_take_decimals(g_inag.inag024,g_inag.inag025) RETURNING l_success,g_inag.inag025
#      END IF
#      #150416---earl---add----e
#      
##      CALL s_aimi190_get_convert(g_inag.inag001,g_inag.inag007,l_imaa006) RETURNING g_success,l_inaj014
##      LET g_inag.inag032 = l_imaa006
##      LET g_inag.inag033 = g_inag.inag008 * l_inaj014
#      
#      CALL s_aimi190_get_convert1(g_inag.inag001,g_inag.inag007,l_imaa006) RETURNING g_success,l_inaj049,l_inaj048
#      LET g_inag.inag032 = l_imaa006
#      LET g_inag.inag033 = g_inag.inag008 * l_inaj048 / l_inaj049
#
#      #150416---earl---add---s
#      IF NOT cl_null(g_inag.inag032) AND NOT cl_null(g_inag.inag033) THEN
#         CALL s_aooi250_take_decimals(g_inag.inag032,g_inag.inag033) RETURNING l_success,g_inag.inag033
#      END IF
#      #150416---earl---add---e
#
#      ##更新[T.庫存明細檔(inag_t)]
##      IF l_imaf054="Y" THEN
##         UPDATE inag_t
##            SET inag008 = g_inag.inag008,
##                inag025 = g_inag.inag025,
##                inag032 = g_inag.inag032,
##                inag033 = g_inag.inag033 
##          WHERE inagent = g_enterprise
##            AND inagsite = g_site
##            AND inag001 = g_inag.inag001
##            AND inag002 = g_inag.inag002
##            AND inag003 = g_inag.inag003
##            AND inag004 = g_inag.inag004
##            AND inag005 = g_inag.inag005
##            AND inag006 = g_inag.inag006
##            AND inag007 = g_inag.inag007
##      ELSE
##         UPDATE inag_t
##            SET inag008 = g_inag.inag008,
##                inag025 = g_inag.inag025,
##                inag032 = g_inag.inag032,
##                inag033 = g_inag.inag033 
##          WHERE inagent = g_enterprise
##            AND inagsite = g_site
##            AND inag001 = g_inag.inag001
##            AND inag002 = g_inag.inag002
##            AND inag003 = g_inag.inag003
##            AND inag004 = g_inag.inag004
##            AND inag005 = g_inag.inag005
##            AND inag006 = g_inag.inag006
##      END IF
#      #160504-00001#1---mod---begin
#      EXECUTE p100_upd_inag USING g_inag.inag008,g_inag.inag025,g_inag.inag032,g_inag.inag033,
#                                  g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#                                  g_inag.inag005,g_inag.inag006,g_inag.inag007                                  
#      #UPDATE inag_t
#      #   SET inag008 = g_inag.inag008,
#      #       inag025 = g_inag.inag025,
#      #       inag032 = g_inag.inag032,
#      #       inag033 = g_inag.inag033 
#      # WHERE inagent = g_enterprise
#      #   AND inagsite = g_site
#      #   AND inag001 = g_inag.inag001
#      #   AND inag002 = g_inag.inag002
#      #   AND inag003 = g_inag.inag003
#      #   AND inag004 = g_inag.inag004
#      #   AND inag005 = g_inag.inag005
#      #   AND inag006 = g_inag.inag006
#      #   AND inag007 = g_inag.inag007
#      #160504-00001#1---mod---ned
##150324---earl---mod---e
#             
#      ##判斷符合條件的料件是否有用製造批號管理或製造序號管理，有的話繼續進行製造批序號月結
#      #160504-00001#1---mark---begin
#      #SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
#      # WHERE imafent = g_enterprise AND imafsite = g_site
#      #   AND imaf001 = g_inag.inag001
#      #160504-00001#1---mark---end   
#      IF l_imaf071 <> '2' AND l_imaf081 <> '2' THEN                
#         FOREACH p100_cur3 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#                                 g_inag.inag005,g_inag.inag006,g_inag.inag007
#                            INTO l_inai007,l_inai008,l_inau017     #160504-00001#1 add l_inau017
#
#            #160504-00001#1---mark---begin
#            ###抓取前一期的期末數量
#            #LET l_inau017 = 0 
#            #SELECT inau017 INTO l_inau017
#            #  FROM inau_t
#            # WHERE inauent = g_enterprise
#            #   AND inausite = g_site
#            #   AND inau001 = g_inag.inag001 
#            #   AND inau002 = g_inag.inag002
#            #   AND inau003 = g_inag.inag003
#            #   AND inau004 = g_inag.inag004
#            #   AND inau005 = g_inag.inag005
#            #   AND inau006 = g_inag.inag006
#            #   AND inau007 = l_inai007
#            #   AND inau008 = l_inai008
#            #   AND inau009 = g_inag.inag007
#            #   AND inau010 = lc_param.glav002
#            #   AND inau011 = lc_param.glav006
#            #IF cl_null(l_inau017) THEN LET l_inau017 = 0 END IF
#            #160504-00001#1---mark---end
#            LET l_inal014_sum = 0
#            #160504-00001#1---mod---begin
#            #FOREACH p100_cur4 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#            #                        g_inag.inag005,g_inag.inag006,l_inai007,l_inai008
#            #                   INTO l_inaj004,l_inal014,l_inaj013,
#            #                        l_inaj046,l_inaj047      #150324---earl---add
#            #   #150324---earl---mod---s
#            #   #LET l_inal014_sum = l_inal014_sum + l_inal014 * l_inaj013 * l_inaj004
#            #   LET l_inal014_sum = l_inal014_sum + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004
#            #   #150324---earl---mod---e
#            #   IF cl_null(l_inal014_sum) THEN LET l_inal014_sum = 0 END IF        
#            #END FOREACH 
#            EXECUTE p100_cur4 USING g_inag.inag001,g_inag.inag002,g_inag.inag003,g_inag.inag004,
#                                    g_inag.inag005,g_inag.inag006,l_inai007,l_inai008
#                               INTO l_inal014_sum
#            #160504-00001#1---mod---end
#            LET l_inai010 = l_inau017 + l_inal014_sum
#            
#            #150416---earl---add---s
#            #取位
#            IF NOT cl_null(g_inag.inag032) AND NOT cl_null(l_inai010) THEN
#               CALL s_aooi250_take_decimals(g_inag.inag032,l_inai010) RETURNING l_success,l_inai010
#            END IF
#            #150416---earl---add---e
#            #160504-00001#1---mod---begin
#            EXECUTE p100_upd_inai USING l_inai010,g_inag.inag032,
#                                        g_inag.inag001,g_inag.inag002,g_inag.inag003,
#                                        g_inag.inag004,g_inag.inag005,g_inag.inag006,
#                                        l_inai007,l_inai008,g_inag.inag007
#            
#            #UPDATE inai_t
#            #   SET inai010 = l_inai010,
#            #       inai014 = g_inag.inag032   #150416---earl---add
#            # WHERE inaient = g_enterprise
#            #   AND inaisite = g_site
#            #   AND inai001 = g_inag.inag001 
#            #   AND inai002 = g_inag.inag002
#            #   AND inai003 = g_inag.inag003
#            #   AND inai004 = g_inag.inag004
#            #   AND inai005 = g_inag.inag005
#            #   AND inai006 = g_inag.inag006
#            #   AND inai007 = l_inai007
#            #   AND inai008 = l_inai008
#            #   AND inai009 = g_inag.inag007
#            #160504-00001#1---mod---end
#         END FOREACH
#      END IF   
#   END FOREACH 
#160810-00031#1---e

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
   CALL ainp100_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp100.get_buffer" >}
PRIVATE FUNCTION ainp100_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glav002 = p_dialog.getFieldBuffer('glav002')
   LET g_master.glav006 = p_dialog.getFieldBuffer('glav006')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp100.msgcentre_notify" >}
PRIVATE FUNCTION ainp100_msgcentre_notify()
 
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
 
{<section id="ainp100.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ainp100_glav_chk()
DEFINE l_cnt       LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
   
   #161207-00047#2 mark
   #LET r_success = FALSE
   #LET l_cnt = 0
   ##SELECT COUNT(*) INTO l_cnt  #161207-00047#1
   #SELECT COUNT(1) INTO l_cnt  #161207-00047#1
   #  FROM glav_t
   # WHERE glavent = g_enterprise
   #   AND glav001 = g_glaa003
   #   AND glav002 = g_master.glav002
   #   AND glav006 = g_master.glav006
   #IF l_cnt > 0 THEN 
   #   LET r_success = TRUE
   #END IF
   #RETURN r_success
   #161207-00047#2 mark
   #161220-00034#1---add---s
   LET r_success = FALSE
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt  
     FROM glav_t
    WHERE glavent = g_enterprise
      AND glav001 = g_glaa003
      AND glav002 = g_master.glav002
      AND glav006 = g_master.glav006
   IF l_cnt > 0 THEN 
      LET r_success = TRUE
   END IF
   RETURN r_success   
   #161220-00034#1---add---e
END FUNCTION

PRIVATE FUNCTION ainp100_upd_inaj(p_date)
DEFINE p_date     LIKE type_t.dat
DEFINE l_sql      STRING
DEFINE l_imaa006  LIKE imaa_t.imaa006
DEFINE l_inaj012  LIKE inaj_t.inaj012
DEFINE l_rate     LIKE inaj_t.inaj013
DEFINE l_inaj013  LIKE inaj_t.inaj013
DEFINE l_inaj014  LIKE inaj_t.inaj013
#DEFINE l_imaf054  LIKE imaf_t.imaf054    #150324---earl---mark
#150324---earl---add---s
DEFINE l_imag013  LIKE imag_t.imag013
DEFINE l_imag014  LIKE imag_t.imag014
DEFINE l_inaj045  LIKE inaj_t.inaj045
DEFINE l_inaj046  LIKE inaj_t.inaj046
DEFINE l_inaj047  LIKE inaj_t.inaj047
DEFINE l_inaj048  LIKE inaj_t.inaj048
DEFINE l_inaj049  LIKE inaj_t.inaj049
DEFINE l_inaj050  LIKE inaj_t.inaj050
DEFINE l_inaj051  LIKE inaj_t.inaj051
DEFINE l_inaj028  LIKE inaj_t.inaj028

#160810-00031#1--s
##160504-00001#1---mark---begin
###150324---earl---add---e
##
##   SELECT imaa006 INTO l_imaa006 FROM imaa_t
##    WHERE imaaent= g_enterprise
##      AND imaa001 = g_inag.inag001
##
###150324---earl---mod---s
##   #計算交易單位與成本單位的換算率，和抓取成本料號
##   LET l_imag013 = ''
##   LET l_imag014 = ''
##   SELECT imag013,imag014
##     INTO l_imag013,l_imag014
##     FROM imag_t
##    WHERE imagent = g_enterprise
##      AND imagsite = g_site
##      AND imag001 = g_inag.inag001
##160504-00001#1---mark---end
#
##   SELECT imaf054 INTO l_imaf054 FROM imaf_t
##    WHERE imafent = g_enterprise AND imafsite = g_site
##      AND imaf001 = g_inag.inag001
#      
##   LET l_sql = "SELECT DISTINCT inaj012 ",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
##               "   AND inaj022 > '",p_date,"'",
##               "   AND inaj004 <> 0 "
##   IF l_imaf054="Y" THEN
##      LET l_sql = l_sql," AND inaj012='",g_inag.inag007,"'"
##   END IF
##   PREPARE p100_up_inaj_per FROM l_sql
##   DECLARE p100_up_inaj_cur CURSOR FOR p100_up_inaj_per
##   FOREACH p100_up_inaj_cur USING g_inag.inag001,g_inag.inag002,g_inag.inag003,
##                                  g_inag.inag004,g_inag.inag005,g_inag.inag006
##                             INTO l_inaj012
##
##      IF NOT cl_null(l_inaj012) THEN
##         CALL s_aimi190_get_convert(g_inag.inag001,l_inaj012,g_inag.inag007) RETURNING g_success,l_inaj013
##         CALL s_aimi190_get_convert(g_inag.inag001,l_inaj012,l_imaa006) RETURNING g_success,l_inaj014
##      END IF
##      IF cl_null(l_inaj013) THEN LET l_inaj013 = 1 END IF
##      IF cl_null(l_inaj014) THEN LET l_inaj014 = 1 END IF
#
#   #160504-00001#1---mark---begin
#   #LET l_sql = "SELECT DISTINCT inaj012,inaj045,inaj028 ",
#   #            "  FROM inaj_t ",
#   #            " WHERE inajent = '",g_enterprise,"'",
#   #            "   AND inajsite = '",g_site,"'",
#   #            "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
#   #            "   AND inaj045 = ?",
#   #            "   AND inaj022 > '",p_date,"'",
#   #            "   AND inaj004 <> 0 "
#   #PREPARE p100_up_inaj_per FROM l_sql 
#   #DECLARE p100_up_inaj_cur CURSOR FOR p100_up_inaj_per
#   #160504-00001#1---mark---end
#   FOREACH p100_up_inaj_cur USING g_inag.inag001,g_inag.inag002,g_inag.inag003,
#                                  g_inag.inag004,g_inag.inag005,g_inag.inag006,g_inag.inag007,p_date
#                             INTO l_inaj012,l_inaj045,l_inaj028,
#                                  l_imaa006,l_imag013,l_imag014    #160504-00001#1
#                                   
#      IF NOT cl_null(l_inaj012) THEN
#         IF NOT cl_null(l_inaj045) THEN 
#            CALL s_aimi190_get_convert(g_inag.inag001,l_inaj012,l_inaj045) RETURNING g_success,l_inaj013
#            CALL s_aimi190_get_convert1(g_inag.inag001,l_inaj012,l_inaj045) RETURNING g_success,l_inaj047,l_inaj046
#         ELSE
#            LET l_inaj013 = 1
#            LET l_inaj046 = 1
#            LET l_inaj047 = 1
#         END IF
#         
#         IF NOT cl_null(l_imaa006) THEN 
#            CALL s_aimi190_get_convert(g_inag.inag001,l_inaj012,l_imaa006) RETURNING g_success,l_inaj014
#            CALL s_aimi190_get_convert1(g_inag.inag001,l_inaj012,l_imaa006) RETURNING g_success,l_inaj049,l_inaj048
#         ELSE
#            LET l_inaj014 = 1
#            LET l_inaj048 = 1
#            LET l_inaj049 = 1
#         END IF
#         
#         IF NOT cl_null(l_imag014) THEN
#            LET l_inaj028 = l_imag013
#            CALL s_aimi190_get_convert1(g_inag.inag001,l_inaj012,l_imag014) RETURNING g_success,l_inaj051,l_inaj050
#         ELSE
#            LET l_inaj050 = 1
#            LET l_inaj051 = 1
#         END IF
#      ELSE
#         LET l_inaj013 = 1
#         LET l_inaj014 = 1
#         LET l_inaj046 = 1
#         LET l_inaj047 = 1         
#         LET l_inaj048 = 1
#         LET l_inaj049 = 1
#         LET l_inaj050 = 1
#         LET l_inaj051 = 1
#      END IF
#      #160504-00001#1---mod---begin
#      EXECUTE p100_upd_inaj USING l_inaj013,l_inaj014,l_inaj028,l_inaj046,l_inaj047,      
#                                  l_inaj048,l_inaj049,l_inaj050,l_inaj051,      
#                                  g_inag.inag001,g_inag.inag002,g_inag.inag003,      
#                                  g_inag.inag004,g_inag.inag005,g_inag.inag006,      
#                                  l_inaj012,l_inaj045      
#      #UPDATE inaj_t
#      #   SET inaj013 = l_inaj013,
#      #       inaj014 = l_inaj014,
#      #       inaj028 = l_inaj028,
#      #       inaj046 = l_inaj046,
#      #       inaj047 = l_inaj047,
#      #       inaj048 = l_inaj048,
#      #       inaj049 = l_inaj049,
#      #       inaj050 = l_inaj050,
#      #       inaj051 = l_inaj051
#      # WHERE inajent = g_enterprise
#      #   AND inajsite = g_site
#      #   AND inaj005 = g_inag.inag001
#      #   AND inaj006 = g_inag.inag002
#      #   AND inaj007 = g_inag.inag003
#      #   AND inaj008 = g_inag.inag004
#      #   AND inaj009 = g_inag.inag005
#      #   AND inaj010 = g_inag.inag006
#      #   AND inaj012 = l_inaj012
#      #   AND inaj045 = l_inaj045
#      #160504-00001#1---mod---end
##      UPDATE inaj_t
##         SET inaj013 = l_inaj013,
##             inaj014 = l_inaj014
##       WHERE inajent = g_enterprise
##         AND inajsite = g_site
##         AND inaj005 = g_inag.inag001
##         AND inaj006 = g_inag.inag002
##         AND inaj007 = g_inag.inag003
##         AND inaj008 = g_inag.inag004
##         AND inaj009 = g_inag.inag005
##         AND inaj010 = g_inag.inag006
##         AND inaj012 = l_inaj012
##150324---earl---mod---e
#
##      IF l_imaf054="Y" THEN
##         UPDATE inaj_t
##            SET inaj013 = l_inaj013,
##                inaj014 = l_inaj014
##          WHERE inajent = g_enterprise
##            AND inajsite = g_site
##            AND inaj005 = g_inag.inag001
##            AND inaj006 = g_inag.inag002
##            AND inaj007 = g_inag.inag003
##            AND inaj008 = g_inag.inag004
##            AND inaj009 = g_inag.inag005
##            AND inaj010 = g_inag.inag006
##            AND inaj012 = g_inag.inag007      
##      ELSE
##         UPDATE inaj_t
##            SET inaj013 = l_inaj013,
##                inaj014 = l_inaj014
##          WHERE inajent = g_enterprise
##            AND inajsite = g_site
##            AND inaj005 = g_inag.inag001 
##            AND inaj006 = g_inag.inag002 
##            AND inaj007 = g_inag.inag003 
##            AND inaj008 = g_inag.inag004 
##            AND inaj009 = g_inag.inag005 
##            AND inaj010 = g_inag.inag006 
##      END IF         
#   END FOREACH
#160810-00031#1--e
END FUNCTION

#end add-point
 
{</section>}
 
