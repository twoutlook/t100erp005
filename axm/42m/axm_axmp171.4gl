#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp171.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-05-07 18:13:14), PR版次:0008(2016-12-01 17:42:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000239
#+ Filename...: axmp171
#+ Description: 集團預測匯總作業
#+ Creator....: 02295(2014-03-21 16:22:28)
#+ Modifier...: 02295 -SD/PR- 08993
 
{</section>}
 
{<section id="axmp171.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150708-00007#1    160621 By 02097  修改背景處理程式段
#161109-00085#11   2016/11/10  By 08993    整批調整系統星號寫法
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
       xmic001 LIKE xmic_t.xmic001, 
   xmic002 LIKE xmic_t.xmic002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_stagecomplete LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp171.main" >}
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
   CALL cl_ap_init("axm","")
 
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
      CALL axmp171_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp171 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmp171_init()
 
      #進入選單 Menu (="N")
      CALL axmp171_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp171
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp171.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmp171_init()
 
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
 
{<section id="axmp171.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp171_ui_dialog()
 
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
   LET g_master.xmic001 = ''
   LET g_master.xmic002 = ''
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xmic001,g_master.xmic002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmic001
            #add-point:BEFORE FIELD xmic001 name="input.b.xmic001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmic001
            
            #add-point:AFTER FIELD xmic001 name="input.a.xmic001"
            IF NOT axmp171_xmic001_chk() THEN 
               LET g_master.xmic001 = ''
               NEXT FIELD CURRENT
            END IF
            IF NOT axmp171_xmic_exist() THEN 
               LET g_master.xmic001 = ''
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmic001
            #add-point:ON CHANGE xmic001 name="input.g.xmic001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmic002
            #add-point:BEFORE FIELD xmic002 name="input.b.xmic002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmic002
            
            #add-point:AFTER FIELD xmic002 name="input.a.xmic002"
            IF NOT axmp171_xmic_exist() THEN 
               LET g_master.xmic002 = ''
               NEXT FIELD CURRENT               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmic002
            #add-point:ON CHANGE xmic002 name="input.g.xmic002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xmic001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmic001
            #add-point:ON ACTION controlp INFIELD xmic001 name="input.c.xmic001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmic001       #給予default值
            CALL q_xmic001()                                 #呼叫開窗
            LET g_master.xmic001 = g_qryparam.return1        #將開窗取得的值回傳到變數
            DISPLAY g_master.xmic001 TO xmic001              #顯示到畫面上
            NEXT FIELD xmic001                               #返回原欄位 


            #END add-point
 
 
         #Ctrlp:input.c.xmic002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmic002
            #add-point:ON ACTION controlp INFIELD xmic002 name="input.c.xmic002"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xmic001,xmic002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmic001
            #add-point:BEFORE FIELD xmic001 name="construct.b.xmic001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmic001
            
            #add-point:AFTER FIELD xmic001 name="construct.a.xmic001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmic001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmic001
            #add-point:ON ACTION controlp INFIELD xmic001 name="construct.c.xmic001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmic002
            #add-point:BEFORE FIELD xmic002 name="construct.b.xmic002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmic002
            
            #add-point:AFTER FIELD xmic002 name="construct.a.xmic002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmic002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmic002
            #add-point:ON ACTION controlp INFIELD xmic002 name="construct.c.xmic002"
            
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
            CALL axmp171_get_buffer(l_dialog)
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
         CALL axmp171_init()
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
                 CALL axmp171_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmp171_transfer_argv(ls_js)
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
 
{<section id="axmp171.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmp171_transfer_argv(ls_js)
 
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
 
{<section id="axmp171.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmp171_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_xmic     RECORD
          xmic001    LIKE xmic_t.xmic001,
          xmic002    LIKE xmic_t.xmic002,
          xmic003    LIKE xmic_t.xmic003,
          xmic005    LIKE xmic_t.xmic005
          END RECORD
   
   #161109-00085#11-mod-s
   #DEFINE l_xmii  RECORD LIKE xmii_t.*   #161109-00085#11   mark
   DEFINE l_xmii  RECORD  #銷售預測單身檔
       xmiient LIKE xmii_t.xmiient, #企業編號
       xmii001 LIKE xmii_t.xmii001, #預測編號
       xmii002 LIKE xmii_t.xmii002, #預測起始日
       xmii003 LIKE xmii_t.xmii003, #版本
       xmii004 LIKE xmii_t.xmii004, #本層組織
       xmii005 LIKE xmii_t.xmii005, #上層組織
       xmii006 LIKE xmii_t.xmii006, #預測營運據點
       xmii007 LIKE xmii_t.xmii007, #銷售組織
       xmii008 LIKE xmii_t.xmii008, #業務員
       xmii009 LIKE xmii_t.xmii009, #預測料號
       xmii010 LIKE xmii_t.xmii010, #產品特徵
       xmii011 LIKE xmii_t.xmii011, #產品分類
       xmii012 LIKE xmii_t.xmii012, #客戶
       xmii013 LIKE xmii_t.xmii013, #通路
       xmii014 LIKE xmii_t.xmii014, #期別
       xmii015 LIKE xmii_t.xmii015, #起始日期
       xmii016 LIKE xmii_t.xmii016, #截止日期
       xmii017 LIKE xmii_t.xmii017, #單位
       xmii018 LIKE xmii_t.xmii018, #預測數量
       xmii019 LIKE xmii_t.xmii019, #調整量
       xmii020 LIKE xmii_t.xmii020, #總數量
       xmii021 LIKE xmii_t.xmii021, #單價
       xmii022 LIKE xmii_t.xmii022, #金額
       xmii023 LIKE xmii_t.xmii023, #調整金額
       xmii024 LIKE xmii_t.xmii024  #總金額
          END RECORD
   #161109-00085#11-mod-e
   DEFINE l_xmii003 LIKE xmii_t.xmii003   
   DEFINE l_xmii004 LIKE xmii_t.xmii004   
   DEFINE l_xmii005 LIKE xmii_t.xmii005
   DEFINE l_xmii005_new LIKE xmii_t.xmii005    
   DEFINE l_xmih        RECORD
          xmih001 LIKE xmih_t.xmih001,
          xmih002 LIKE xmih_t.xmih002,
          xmih003 LIKE xmih_t.xmih003,
          xmih004 LIKE xmih_t.xmih004,
          xmih005 LIKE xmih_t.xmih005,
          xmihownid LIKE xmih_t.xmihownid,
          xmihowndp LIKE xmih_t.xmihowndp,
          xmihcrtid LIKE xmih_t.xmihcrtid,
          xmihcrtdp LIKE xmih_t.xmihcrtdp,
          xmihcrtdt DATETIME YEAR TO SECOND,
          xmihmodid LIKE xmih_t.xmihmodid,
          xmihmoddt DATETIME YEAR TO SECOND,
          xmihcnfid LIKE xmih_t.xmihcnfid,
          xmihcnfdt DATETIME YEAR TO SECOND,
          xmihstus LIKE xmih_t.xmihstus
          END RECORD       
DEFINE l_flag    LIKE type_t.chr1
DEFINE l_xmij004 LIKE xmij_t.xmij004,
       l_xmij005 LIKE xmij_t.xmij005,
       l_xmij006 LIKE xmij_t.xmij006,
       l_xmij007 LIKE xmij_t.xmij007,
       l_xmij008 LIKE xmij_t.xmij008,
       l_xmij009 LIKE xmij_t.xmij009,
       l_xmij010 LIKE xmij_t.xmij010,
       l_xmij011 LIKE xmij_t.xmij011,
       l_group   STRING,
       l_date    DATETIME YEAR TO SECOND
   DEFINE l_success  LIKE type_t.num5 

   DEFINE l_over     LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_cnt2     LIKE type_t.num5 
   DEFINE l_type     LIKE type_t.chr1   
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
#  DECLARE axmp171_process_cs CURSOR FROM ls_sql
#  FOREACH axmp171_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_stagecomplete = 0
   DISPLAY g_stagecomplete TO stagecomplete
   CALL s_transaction_begin()
   LET l_success = TRUE
   DROP TABLE axmp171_xmii
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axmp171_xmii AS ",
                "SELECT xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008,",
                "       xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii015,",
                "       xmii016,xmii017,xmii018,xmii019,xmii020,",
                "       xmii021,xmii022,xmii023,xmii024",                
                " FROM xmii_t "
   PREPARE xmii_tbl FROM ls_sql
   EXECUTE xmii_tbl
   FREE xmii_tbl     

   #预设点资料INSERT
   #xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008
   #        xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii015,
   #        xmii016,xmii017,xmii018,xmii019,xmii020
   #        xmii021,xmii022,xmii023,xmii024
   #161109-00085#11-mod-s
   #INSERT INTO axmp171_xmii SELECT DISTINCT xmident,xmid001,xmid002,xmid003,xmid005,' ',xmid004,xmid005,xmid006,
   INSERT INTO axmp171_xmii ( xmiient,xmii001,xmii002,xmii003,xmii004,
                              xmii005,xmii006,xmii007,xmii008,xmii009,
                              xmii010,xmii011,xmii012,xmii013,xmii014,
                              xmii015,xmii016,xmii017,xmii018,xmii019,
                              xmii020,xmii021,xmii022,xmii023,xmii024)                              
   SELECT DISTINCT xmident,xmid001,xmid002,xmid003,xmid005,' ',xmid004,xmid005,xmid006,
   #161109-00085#11-mod-s
                                   xmid007,xmid008,     '',xmid009,xmid010,xmid011,xmid012, 
                                   xmid013,xmid014,xmid015,xmid016,xmid017,
                                   xmid018,xmid019,xmid020,xmid021
                              FROM xmid_t,(SELECT xmic001,xmic002,MAX(xmic003) a,xmic004,xmic005,xmic006 
                                             FROM xmic_t 
                                            WHERE xmicent = g_enterprise
                                              AND xmic001 = g_master.xmic001
                                              AND xmic002 = g_master.xmic002
                                            GROUP BY xmic001,xmic002,xmic004,xmic005,xmic006 
                                            ORDER BY xmic001,xmic002,xmic005,a) A 
                             WHERE xmid001 = xmic001 
                               AND xmid002 = xmic002 
                               AND xmid003 = a 
                               AND xmid005 = xmic005
                               AND xmid006 = xmic006                               

   UPDATE axmp171_xmii
      SET xmii011 = (SELECT imaa009 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = xmii009)
   
   LET ls_sql = "SELECT DISTINCT xmii004 FROM axmp171_xmii "
   PREPARE axmp171_process_pr FROM ls_sql
   DECLARE axmp171_process_cs CURSOR FOR axmp171_process_pr
   FOREACH axmp171_process_cs INTO l_xmii004      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF       
      
      CALL axmp171_get_xmii004(l_xmii004) RETURNING l_xmii005
      UPDATE axmp171_xmii 
         SET xmii005 = l_xmii005
       WHERE xmii004 = l_xmii004         
   END FOREACH
   
   DELETE FROM axmp171_xmii WHERE xmii005 IS NULL
   
   LET g_stagecomplete = 10
   DISPLAY g_stagecomplete TO stagecomplete
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM axmp171_xmii
   IF l_cnt = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt 
     FROM xmic_t,axmp171_xmii
    WHERE xmicent = xmiient 
      AND xmic001 = xmii001
      AND xmic002 = xmii002
      AND xmic003 = xmii003
      AND xmic004 = xmii006
      AND xmic005 = xmii007
      AND xmic006 = xmii008                               
      AND xmicstus = 'N'  
   IF l_cnt > 0  THEN 
      #資料內有任一筆是未確認的
      IF NOT cl_ask_confirm('axm-00297') THEN
         RETURN
      ELSE
         LET ls_sql =" DELETE FROM axmp171_xmii ",
                     "  WHERE (xmiient,xmii001,xmii002,xmii003,xmii006,xmii007,xmii008) IN ( ",
                     "         SELECT xmicent,xmic001,xmic002,xmic003,xmic004,xmic005,xmic006 FROM xmic_t",
                     "          WHERE xmicent = xmiient ",
                     "            AND xmic001 = xmii001",
                     "            AND xmic002 = xmii002",
                     "            AND xmic003 = xmii003",
                     "            AND xmic004 = xmii006",
                     "            AND xmic005 = xmii007",
                     "            AND xmic006 = xmii008 ",                              
                     "            AND xmicstus = 'N' )  "
         PREPARE axmp171_pre6 FROM ls_sql
         EXECUTE axmp171_pre6                    
      END IF
   END IF
   
   
   SELECT DISTINCT MAX(a.xmii003) INTO l_xmii003 FROM xmii_t a,axmp171_xmii b
    WHERE a.xmiient = b.xmiient
      AND a.xmii002 = b.xmii002
      AND a.xmii004 = b.xmii004
      AND a.xmii006 = b.xmii006
      AND a.xmii007 = b.xmii007
      AND a.xmii008 = b.xmii008
   IF l_xmii003 IS NULL THEN 
      LET l_xmii003 = 1  
   END IF
   
   #####判斷有已經產生資料且是否全部未確認
   LET l_type = '0'
   LET ls_sql = "SELECT DISTINCT xmii005 FROM axmp171_xmii "
   PREPARE axmp171_process_pr1 FROM ls_sql
   DECLARE axmp171_process_cs1 CURSOR FOR axmp171_process_pr1
   FOREACH axmp171_process_cs1 INTO l_xmii005      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = 0 
      LET ls_sql =  "  SELECT COUNT(*)  FROM xmih_t ",
                    "   WHERE xmihent = '",g_enterprise,"'", 
                    "     AND xmih001 = '",g_master.xmic001,"'", 
                    "     AND xmih002 = '",g_master.xmic002,"'",
                    "     AND xmih003 = ",l_xmii003,
                    "     AND xmihstus = 'N' ",      
                    "  START WITH xmih004 = '",l_xmii005,"'",
                    "  CONNECT BY PRIOR xmih005 = xmih004 "
      PREPARE axmp171_pre5 FROM ls_sql
      EXECUTE axmp171_pre5 INTO l_cnt 
      
      LET l_cnt2 = 0 
      LET ls_sql =  "  SELECT COUNT(*)  FROM xmih_t ",
                    "   WHERE xmihent = '",g_enterprise,"'", 
                    "     AND xmih001 = '",g_master.xmic001,"'", 
                    "     AND xmih002 = '",g_master.xmic002,"'",
                    "     AND xmih003 = ",l_xmii003,
                    "     AND xmihstus = 'Y' ",      
                    "  START WITH xmih004 = '",l_xmii005,"'",
                    "  CONNECT BY PRIOR xmih005 = xmih004 "
      PREPARE axmp171_pre2 FROM ls_sql
      EXECUTE axmp171_pre2 INTO l_cnt2   
      
      ##不存在汇总资料
      IF l_cnt = 0 AND l_cnt2 = 0 THEN 
         LET l_type = '0'
      END IF
      ##已存在汇总资料但未确认      
      IF l_cnt > 0 AND l_cnt2 = 0 THEN 
         LET l_type = '1'
      END IF
      ##已存在汇总资料且存在确认资料      
      IF l_cnt2 > 0 THEN 
         LET l_type = '2'
         EXIT FOREACH
      END IF 
    
   END FOREACH
   IF l_type = '1' THEN 
      IF NOT cl_ask_confirm('axm-00298') THEN
         RETURN
      ELSE
         LET ls_sql = "SELECT DISTINCT xmii005 FROM axmp171_xmii "
         PREPARE axmp171_process_pr2 FROM ls_sql
         DECLARE axmp171_process_cs2 CURSOR FOR axmp171_process_pr2
         FOREACH axmp171_process_cs2 INTO l_xmii005      
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

               EXIT FOREACH
            END IF

            LET ls_sql = " DELETE FROM xmii_t ",
                         "  WHERE (xmiient,xmii001,xmii002,xmii003,xmii004) IN (",
                         "         SELECT xmihent,xmih001,xmih002,xmih003,xmih004 ",
                         "           FROM xmih_t ",
                         "          WHERE xmihent = '",g_enterprise,"'", 
                         "            AND xmih001 = '",g_master.xmic001,"'", 
                         "            AND xmih002 = '",g_master.xmic002,"'",
                         "            AND xmih003 = ",l_xmii003,
                         "            AND xmihstus = 'N' ",      
                         "         START WITH xmih004 = '",l_xmii005,"'",
                         "         CONNECT BY PRIOR xmih005 = xmih004  ) "
            PREPARE axmp171_pre4 FROM ls_sql
            EXECUTE axmp171_pre4  
            
            DELETE FROM xmii_t 
             WHERE xmiient = g_enterprise 
               AND xmii001 = g_master.xmic001 
               AND xmii002 = g_master.xmic002
               AND xmii003 = l_xmii003
               AND xmii005 = l_xmii005 
      
            LET ls_sql = " DELETE FROM xmih_t ",
                         "  WHERE (xmihent,xmih001,xmih002,xmih003,xmih004) IN (",
                         "         SELECT xmihent,xmih001,xmih002,xmih003,xmih004 ",
                         "           FROM xmih_t ",
                         "          WHERE xmihent = '",g_enterprise,"'", 
                         "            AND xmih001 = '",g_master.xmic001,"'", 
                         "            AND xmih002 = '",g_master.xmic002,"'",
                         "            AND xmih003 = ",l_xmii003,
                         "            AND xmihstus = 'N' ",      
                         "         START WITH xmih004 = '",l_xmii005,"'",
                         "         CONNECT BY PRIOR xmih005 = xmih004  ) "
            PREPARE axmp171_pre3 FROM ls_sql
            EXECUTE axmp171_pre3  

         END FOREACH      
      END IF     
   END IF
   IF l_type = '2' THEN 
      LET l_xmii003 = l_xmii003 + 1  
   END IF
   UPDATE axmp171_xmii
     SET xmii003 = l_xmii003
 
   
   LET g_stagecomplete = 20
   DISPLAY g_stagecomplete TO stagecomplete

   INSERT INTO xmii_t(xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008,
                      xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii015,
                      xmii016,xmii017,xmii018,xmii019,xmii020,
                      xmii021,xmii022,xmii023,xmii024)
                      #161109-00085#11-mod-s
#                      SELECT * FROM axmp171_xmii   #161109-00085#11-mark
                      SELECT xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008,xmii009,xmii010,xmii011,xmii012,
                             xmii013,xmii014,xmii015,xmii016,xmii017,xmii018,xmii019,xmii020,xmii021,xmii022,xmii023,xmii024 
                         FROM axmp171_xmii
                      #161109-00085#11-mod-e
   IF SQLCA.sqlcode THEN 
      LET l_success = FALSE
   END IF

   #汇总点资料INSERT
   LET l_over = FALSE
   
   #判斷是否存在上層組織不爲空的資料
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM axmp171_xmii
    WHERE xmii005 <> ' '
   IF l_cnt = 0 THEN LET l_over = TRUE END IF 
   
   WHILE l_over = FALSE
   
      LET ls_sql = "SELECT DISTINCT xmii005 FROM axmp171_xmii WHERE xmii005 <> ' ' "
      PREPARE axmp171_process_pr3 FROM ls_sql
      DECLARE axmp171_process_cs3 CURSOR FOR axmp171_process_pr3
      FOREACH axmp171_process_cs3 INTO l_xmii005      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

            EXIT FOREACH
         END IF 
          
          

         CALL axmp171_get_xmii004(l_xmii005) RETURNING l_xmii005_new
         UPDATE axmp171_xmii 
            SET xmii004 = l_xmii005,
                xmii005 = l_xmii005_new
          WHERE xmii005 = l_xmii005         
         
         SELECT xmij004,xmij005,xmij006,xmij007,xmij008,xmij009,xmij010,xmij011
           INTO l_xmij004,l_xmij005,l_xmij006,l_xmij007,l_xmij008,l_xmij009,l_xmij010,l_xmij011
           FROM xmij_t
          WHERE xmijent = g_enterprise
            AND xmij001 = l_xmii005
            
         LET ls_sql = " SELECT xmiient,xmii001,xmii002,xmii003,xmii004,xmii005"
         LET l_group = " GROUP BY xmiient,xmii001,xmii002,xmii003,xmii004,xmii005"
         IF l_xmij004 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii006"
            LET l_group = l_group,",xmii006"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         
         LET ls_sql = ls_sql,",xmii007"
         LET l_group = l_group,",xmii007"
   
         IF l_xmij008 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii008"
            LET l_group = l_group,",xmii008"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         IF l_xmij010 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii009"
            LET l_group = l_group,",xmii009"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         IF l_xmij011 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii010"
            LET l_group = l_group,",xmii010"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         IF l_xmij009 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii011"
            LET l_group = l_group,",xmii011"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         IF l_xmij006 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii012"
            LET l_group = l_group,",xmii012"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF
         IF l_xmij007 = 'Y' THEN 
            LET ls_sql = ls_sql,",xmii013"
            LET l_group = l_group,",xmii013"
         ELSE
            LET ls_sql = ls_sql,",' '"      
         END IF    
         LET ls_sql = ls_sql," ,xmii014,xmii015,xmii016,xmii017,SUM(xmii018),SUM(xmii019),SUM(xmii020),",
                             "  DECODE(SUM(xmii018),0,0,SUM(xmii022)/SUM(xmii018)),SUM(xmii022),SUM(xmii023),SUM(xmii024)",
                             " FROM axmp171_xmii",
                             " WHERE xmii004 = '",l_xmii005,"'",l_group,",xmii014,xmii015,xmii016,xmii017"
         LET ls_sql = "INSERT INTO xmii_t(xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008,",
                                        " xmii009,xmii010,xmii011,xmii012,xmii013,xmii014,xmii015,",
                                        " xmii016,xmii017,xmii018,xmii019,xmii020,",
                                        " xmii021,xmii022,xmii023,xmii024) ",ls_sql                    
         PREPARE ins_xmii2 FROM ls_sql
         EXECUTE ins_xmii2
         IF SQLCA.sqlcode THEN 
            LET l_success = FALSE
            EXIT FOREACH
         END IF
     END FOREACH
     LET l_date = cl_get_current()
     LET ls_sql = " SELECT DISTINCT '",g_enterprise,"',xmii001,xmii002,xmii003,xmii004,xmii005,",
                  " '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"','','','','','','N' ",
                  "   FROM axmp171_xmii WHERE xmii004 <> xmii007 "
     LET ls_sql = "INSERT INTO xmih_t(xmihent,xmih001,xmih002,xmih003,xmih004,xmih005,",
                   " xmihownid,xmihowndp,xmihcrtid,xmihcrtdp,xmihcrtdt,xmihmodid,xmihmoddt,xmihcnfid,xmihcnfdt,xmihstus) ",ls_sql                
     PREPARE ins_xmih FROM ls_sql              
     EXECUTE ins_xmih
     IF SQLCA.sqlcode THEN 
        LET l_success = FALSE
     END IF 
     UPDATE xmih_t 
        SET xmihcrtdt = l_date
      WHERE EXISTS(
                  #161109-00085#11-mod-s
#                  SELECT * FROM axmp171_xmii   #161109-00085#11-mark
                   SELECT xmiient,xmii001,xmii002,xmii003,xmii004,xmii005,xmii006,xmii007,xmii008,xmii009,xmii010,xmii011,xmii012,
                          xmii013,xmii014,xmii015,xmii016,xmii017,xmii018,xmii019,xmii020,xmii021,xmii022,xmii023,xmii024 
                      FROM axmp171_xmii
                   #161109-00085#11-mod-e
                    WHERE xmiient = g_enterprise
                      AND xmihent = xmiient
                      AND xmih001 = xmii001
                      AND xmih002 = xmii002
                      AND xmih003 = xmii003
                      AND xmih004 = xmii004)       
     IF SQLCA.sqlcode THEN 
        LET l_success = FALSE
     END IF
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM axmp171_xmii
       WHERE xmii005 <> ' '
      IF l_cnt = 0 THEN LET l_over = TRUE END IF  
   END WHILE


   LET g_stagecomplete = 100
   DISPLAY g_stagecomplete TO stagecomplete
      
   DROP TABLE axmp171_xmii
   IF l_success THEN 
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
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
      #150708-00007#1--(S)
      IF NOT l_success THEN
         LET li_p01_status = FALSE
      END IF
      IF g_schedule.gzpa003 = 1 THEN 
         IF cl_chk_process_exists(g_parentsession,g_account) THEN
            CALL cl_ask_confirm("std-00012") RETURNING li_stus
         END IF
      END IF 
      DISPLAY cl_getmsg_parm("azz-01007",g_lang,'')
      #150708-00007#1--(E)
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axmp171_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp171.get_buffer" >}
PRIVATE FUNCTION axmp171_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xmic001 = p_dialog.getFieldBuffer('xmic001')
   LET g_master.xmic002 = p_dialog.getFieldBuffer('xmic002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmp171.msgcentre_notify" >}
PRIVATE FUNCTION axmp171_msgcentre_notify()
 
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
 
{<section id="axmp171.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢查預測編號+預測起始日期存在
# Memo...........:
# Usage..........: CALL axmp171_xmic_exist()
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/03/25 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp171_xmic_exist()
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(g_master.xmic001) AND NOT cl_null(g_master.xmic002) THEN 
      IF NOT ap_chk_isExist(g_master.xmic001,"SELECT COUNT(*) FROM xmic_t WHERE "||"xmicent = '" ||g_enterprise|| "' AND "||"xmic001 = ? AND xmic002 = '"||g_master.xmic002||"' ",'axm-00195',1) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      IF NOT ap_chk_isExist(g_master.xmic001,"SELECT COUNT(*) FROM xmic_t WHERE "||"xmicent = '" ||g_enterprise|| "' AND "||"xmic001 = ? AND xmic002 = '"||g_master.xmic002||"' AND xmicstus = 'Y'",'axm-00318',1) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF       
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查銷售組織是否爲匯總點或預測點
# Memo...........:
# Usage..........: CALL axmp171_chk_xmic005(p_xmij001)
#                  RETURNING r_flag
# Input parameter: p_xmij001   銷售組織
#                : 
# Return code....: 1   銷售組織是匯總點
#                : 2   銷售組織爲預測點
#                : 3   銷售組織不是匯總點也不是預測點
# Date & Author..: 2014/03/26 By xianghui 
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp171_chk_xmic005(p_xmij001)
DEFINE p_xmij001  LIKE xmij_t.xmij001
DEFINE l_xmij002  LIKE xmij_t.xmij002
DEFINE l_xmij003  LIKE xmij_t.xmij003
DEFINE r_flag     LIKE type_t.chr1

   LET r_flag = '0'
   SELECT xmij002,xmij003 INTO l_xmij002,l_xmij003
     FROM xmij_t
    WHERE xmijent = g_enterprise
      AND xmij001 = p_xmij001
   IF l_xmij002 = 'Y' THEN       
      LET r_flag = '2'
   END IF
   IF l_xmij003 = 'Y' THEN       
      LET r_flag = '1'
   END IF   
   RETURN r_flag
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_ooed004   組織編號
# Return code....: r_ooed005   上級組織編號
# Date & Author..: 2014/03/26 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp171_get_xmii004(p_ooed004)
DEFINE p_ooed004  LIKE ooed_t.ooed004
DEFINE r_ooed005  LIKE ooed_t.ooed005
DEFINE l_ooed002  LIKE ooed_t.ooed002
DEFINE l_flag     LIKE type_t.chr1

   SELECT DISTINCT ooed005,ooed002 
     INTO r_ooed005,l_ooed002
     FROM ooed_t
    WHERE ooedent = g_enterprise
      AND ooed001 = '2'                  #mod xianghui 7->2
      AND ooed004 = p_ooed004
      AND ooed006 <= g_master.xmic002
      AND (ooed007 IS NULL OR ooed007 >= g_master.xmic002)

   IF NOT cl_null(l_ooed002) THEN 
      IF l_ooed002 = p_ooed004 THEN 
         LET r_ooed005 = ' '
         RETURN r_ooed005
      ELSE    
         CALL axmp171_chk_xmic005(r_ooed005) RETURNING l_flag
         IF l_flag = '1' THEN 
            RETURN r_ooed005    
         ELSE
            CALL axmp171_get_xmii004(r_ooed005) RETURNING r_ooed005
            RETURN r_ooed005      
         END IF
      END IF
   END IF
   RETURN r_ooed005
END FUNCTION

PRIVATE FUNCTION axmp171_xmic001_chk()
DEFINE l_cnt        LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5
DEFINE l_xmia009    LIKE xmia_t.xmia009   #add--2015/03/25 By shiun
   LET r_success = TRUE
   IF NOT cl_null(g_master.xmic001) THEN 
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt 
        FROM xmic_t
       WHERE xmicent = g_enterprise
         AND xmic001 = g_master.xmic001 
      IF l_cnt = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00277'
         LET g_errparam.extend = g_master.xmic001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
          #modify--2015/03/25 By shiun--(S)
      ELSE
         LET l_xmia009 = ''
         SELECT xmia009 INTO l_xmia009
           FROM xmia_t
          WHERE xmiaent = g_enterprise
            AND xmia001 = g_master.xmic001
         
         IF l_xmia009 != 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axm-00317'
            LET g_errparam.extend = g_master.xmic001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
         END IF
            #modify--2015/03/25 By shiun--(E)
      END IF
   END IF
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
