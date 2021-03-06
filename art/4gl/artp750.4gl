#該程式未解開Section, 採用最新樣板產出!
{<section id="artp750.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-12-28 13:48:38), PR版次:0008(2017-01-03 09:47:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: artp750
#+ Description: 門店商品DMS與庫存計算作業
#+ Creator....: 03247(2014-11-27 14:53:40)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="artp750.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#16 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   artp750_debn_tmp -->artp750_tmp01
#161011-00033#2  2016/10/12 By dongsz  写入debn资料时增加字段维度
#161129-00027#3  2016/12/06 By 02481   写入debn资料时增加字段维度 debn018
#161206-00005#4  2016/12/07 by 02481   若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
#161216-00004#3  2016/12/27 by sakura  1.增加集團參數(跨日期操作E-CIR-0079)設定處理
#                                      2.增加程式背景執行時參數:deba002_end
#                                      3.調整進度條的計量與顯示
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
   deba002          LIKE deba_t.deba002,   #日結日期
   deba002_end      LIKE deba_t.deba002,   #日結截止日期   #161216-00004#3 by sakura add
   chk1             LIKE type_t.chr1,     
   chk2             LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       debasite LIKE type_t.chr500, 
   deba002 LIKE type_t.dat, 
   deba002_end LIKE type_t.dat, 
   chk1 LIKE type_t.chr500, 
   chk2 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_cnt      LIKE type_t.num10
DEFINE g_muti_dat LIKE type_t.chr10    #跨日期結算參數   #161216-00004#3 by sakura add
DEFINE g_master_o type_master          #備份舊值         #161216-00004#3 by sakura add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artp750.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
      display 'ctrl pt1:',ls_js
      display 'ctrl pt2: pass temp',l_success
      #end add-point
      CALL artp750_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp750 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artp750_init()
 
      #進入選單 Menu (="N")
      CALL artp750_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp750
   END IF
 
   #add-point:作業離開前 name="main.exit"
   #CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   CALL s_aooi500_drop_temp() RETURNING l_success       #161011-00033#2 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp750.init" >}
#+ 初始化作業
PRIVATE FUNCTION artp750_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   DEFINE l_dat_label   STRING            #161216-00004#4 by sakura add
   DEFINE l_comment     STRING            #161216-00004#4 by sakura add  
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
   #161216-00004#3 by sakura add(S)
   LET g_muti_dat = ''
   LET g_muti_dat = cl_get_para(g_enterprise,"","E-CIR-0079")
   IF cl_null(g_muti_dat) THEN
      LET g_muti_dat = 'N'
   END IF
   #跨日期 
   IF g_muti_dat = 'Y' THEN
      LET l_dat_label = ''
      LET l_comment = ''
      CALL s_azzi902_get_gzzd(g_prog,"lbl_deba002_str") RETURNING l_dat_label, l_comment
      CALL cl_set_comp_att_text("lbl_deba002",l_dat_label) 
   ELSE
      CALL cl_set_comp_visible("lbl_deba002_end,deba002_end",FALSE)
      CALL cl_set_comp_visible("lbl_deba002_end,deba002_end,lbl_deba002_str",FALSE)
   END IF   
   DISPLAY '跨日期操作(E-CIR-0079)：',g_muti_dat
   #161216-00004#3 by sakura add(E)
   
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp750.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp750_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_deba002 LIKE deba_t.deba002
   DEFINE l_success LIKE type_t.num5   #161216-00004#3 by sakura add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.deba002,g_master.deba002_end,g_master.chk1,g_master.chk2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deba002
            #add-point:BEFORE FIELD deba002 name="input.b.deba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deba002
            
            #add-point:AFTER FIELD deba002 name="input.a.deba002"
            IF NOT cl_null(g_master.deba002) THEN
               IF g_master.deba002 > g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_master.deba002
                  LET g_errparam.code   = 'amm-00207'   #日期不可大於當前日期
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD deba002
               END IF
            END IF
            #161216-00004#3 by sakura add(S)
            IF NOT cl_null(g_master.deba002) THEN
               IF cl_null(g_master_o.deba002) OR g_master.deba002 <> g_master_o.deba002 THEN
                  IF NOT cl_null(g_master.deba002) AND NOT cl_null(g_master.deba002_end) THEN
                     IF g_master.deba002 > g_master.deba002_end THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00786"   #截止日期不可小於起始日期！
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.deba002 = g_master_o.deba002                        
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                END IF
            END IF
            LET g_master_o.deba002 = g_master.deba002            
            #161216-00004#3 by sakura add(E)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deba002
            #add-point:ON CHANGE deba002 name="input.g.deba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deba002_end
            #add-point:BEFORE FIELD deba002_end name="input.b.deba002_end"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deba002_end
            
            #add-point:AFTER FIELD deba002_end name="input.a.deba002_end"
            #161216-00004#3 by sakura add(S)
            IF NOT cl_null(g_master.deba002_end) THEN
               IF g_master.deba002_end > g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_master.deba002_end
                  LET g_errparam.code   = 'amm-00207'   #日期不可大於當前日期
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD deba002_end
               END IF
            END IF            
            IF NOT cl_null(g_master.deba002_end) THEN
               IF cl_null(g_master_o.deba002_end) OR g_master.deba002_end <> g_master_o.deba002_end THEN            
                  IF NOT cl_null(g_master.deba002) AND  NOT cl_null(g_master.deba002_end) THEN
                     IF g_master.deba002 > g_master.deba002_end THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00786"   #截止日期不可小於起始日期！
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        LET g_master.deba002_end = g_master_o.deba002_end                       
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.deba002_end = g_master.deba002_end
            #161216-00004#3 by sakura add(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE deba002_end
            #add-point:ON CHANGE deba002_end name="input.g.deba002_end"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk1
            #add-point:BEFORE FIELD chk1 name="input.b.chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk1
            
            #add-point:AFTER FIELD chk1 name="input.a.chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk1
            #add-point:ON CHANGE chk1 name="input.g.chk1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk2
            #add-point:BEFORE FIELD chk2 name="input.b.chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk2
            
            #add-point:AFTER FIELD chk2 name="input.a.chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk2
            #add-point:ON CHANGE chk2 name="input.g.chk2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.deba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deba002
            #add-point:ON ACTION controlp INFIELD deba002 name="input.c.deba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.deba002_end
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deba002_end
            #add-point:ON ACTION controlp INFIELD deba002_end name="input.c.deba002_end"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk1
            #add-point:ON ACTION controlp INFIELD chk1 name="input.c.chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk2
            #add-point:ON ACTION controlp INFIELD chk2 name="input.c.chk2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON debasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.debasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debasite
            #add-point:ON ACTION controlp INFIELD debasite name="construct.c.debasite"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debasite  #顯示到畫面上 
            NEXT FIELD debasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debasite
            #add-point:BEFORE FIELD debasite name="construct.b.debasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debasite
            
            #add-point:AFTER FIELD debasite name="construct.a.debasite"
            
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
            CALL artp750_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            #161216-00004#3 by sakura mark(S)
            #IF cl_null(g_master.chk1) THEN
            #   LET g_master.chk1 = 'N'
            #END IF
            #161216-00004#3 by sakura mark(E)
            IF cl_null(g_master.chk2) THEN
               #LET g_master.chk2 = 'N'    #20150716 mark by dongsz
               LET g_master.chk2 = 'Y'     #20150716 mark by dongsz
            END IF
            #LET g_master.deba002 = g_today    #20150716 mark by dongsz
            #161216-00004#3 by sakura mark(S)
            ##20150716 add by dongsz--s
            #LET l_deba002 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')   #營業日期
            #LET g_master.deba002 = l_deba002 - 1  
            ##20150716 add by dongsz--e
            #161216-00004#3 by sakura mark(E)
            
            #161216-00004#3 by sakura add(S)
            IF g_muti_dat = 'Y' THEN
               LET g_master.deba002 = g_today - 1            
               LET g_master.deba002_end = g_today - 1
            ELSE
               LET g_master.deba002 = g_today - 1
            END IF
            CALL s_aooi500_default(g_prog,'debasite',g_site)
                RETURNING l_success,g_master.debasite           
            DISPLAY BY NAME g_master.debasite
            INITIALIZE g_master_o.* TO NULL
            LET g_master_o.* = g_master.*
            #161216-00004#3 by sakura add(E)
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
         CALL artp750_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.deba002 = g_master.deba002
      LET lc_param.deba002_end = g_master.deba002_end
      #LET lc_param.chk1 = g_master.chk1   #161216-00004#3 by sakura add
      LET lc_param.chk2 = g_master.chk2
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
                 CALL artp750_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = artp750_transfer_argv(ls_js)
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
 
{<section id="artp750.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION artp750_transfer_argv(ls_js)
 
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
 
{<section id="artp750.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION artp750_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_rtkh001      LIKE rtkh_t.rtkh001
   DEFINE l_rtkh002      LIKE rtkh_t.rtkh002
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_date         LIKE deba_t.deba002   #結算日
   DEFINE l_date1        LIKE deba_t.deba002
   DEFINE l_date_s       LIKE deba_t.deba002
   DEFINE l_date_e       LIKE deba_t.deba002
   DEFINE l_debasite     LIKE deba_t.debasite
   DEFINE l_sql          STRING
   DEFINE l_where        STRING
   DEFINE l_str          STRING
   DEFINE l_str1         STRING
   DEFINE l_str2         STRING
   DEFINE l_n            LIKE type_t.num10
   DEFINE l_debn002      LIKE debn_t.debn002
   DEFINE l_rtkf012      DATETIME YEAR TO SECOND
   DEFINE l_deba002      LIKE deba_t.deba002    #20150730--add by dongsz
   DEFINE l_msg          LIKE type_t.chr100   #160225-00040#18 2016/04/13 s983961--add
   DEFINE l_cnt          LIKE type_t.num5     #160225-00040#18 2016/04/13 s983961--add
   DEFINE l_checkpos     LIKE type_t.chr1   #161206-00005#4--add 
   DEFINE l_flag         LIKE type_t.chr1   #161206-00005#4--add 失败则返回
   DEFINE l_str3         STRING             #161206-00005#4--add
   #161216-00004#3 by sakura add(S)
   DEFINE l_dat_cnt     LIKE type_t.num10        #統計結算天數
   DEFINE l_bus_date    LIKE deba_t.deba002      #記錄參數值:營業日期
   DEFINE l_off_date    LIKE deba_t.deba002      #記錄參數值:門店日結關帳日期
   DEFINE l_colname_1   STRING                   #錯誤訊息title
   DEFINE l_comment_1   STRING                   #錯誤訊息comment
   DEFINE l_colname_2   STRING                   #錯誤訊息title
   DEFINE l_comment_2   STRING                   #錯誤訊息comment
   DEFINE g_exitstus    LIKE type_t.num5
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_i           LIKE type_t.num10
   #161216-00004#3 by sakura add(E)
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   #20150730--add by dongsz--s
   IF cl_null(lc_param.deba002) THEN
      LET l_deba002 = cl_get_para(g_enterprise,g_site,'S-CIR-0003')
      LET lc_param.deba002 = l_deba002 - 1
   END IF
   #161216-00004#3 by sakura mark(S)
   #IF cl_null(lc_param.chk1) THEN
   #   LET lc_param.chk1 = 'N'
   #END IF
   #161216-00004#3 by sakura mark(E)
   IF cl_null(lc_param.chk2) THEN
      LET lc_param.chk2 = 'Y'  
   END IF
   #161206-00005#4--add---begin-------------
   #若勾选参数检查门店日结是否上传，则门店必须要有值
   LET l_checkpos = cl_get_para(g_enterprise,g_site,'S-CIR-2037') 
   IF l_checkpos = 'Y' THEN
      IF cl_null(lc_param.wc) OR lc_param.wc = " 1=1"  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00772'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         RETURN 
      END IF
   END IF
   #161206-00005#4--add---end-------------
   #161216-00004#3 by sakura mark(S)
   #IF cl_null(lc_param.wc) THEN
   #   LET lc_param.wc = " 1=1"
   #END IF
   ##20150730--add by dongsz--e
   #161216-00004#3 by sakura mark(E)
   
   #161216-00004#3 by sakura add(S)
   LET l_dat_cnt = 0
   #1.日結截止日期為空時，結算截止日為空時給予預設
   IF cl_null(lc_param.deba002_end) THEN
      LET lc_param.deba002_end = lc_param.deba002
   END IF
   #2.統計需要結算的天數
   LET l_dat_cnt = lc_param.deba002_end - lc_param.deba002 + 1
   #3.取得aooi500組織管控的過濾條件
   CALL s_aooi500_sql_where(g_prog,'debasite') RETURNING l_where   
   #4.替換過濾條件的欄位名稱
   LET l_str = ''
   LET l_str = cl_replace_str(lc_param.wc,"debasite","ooef001")," AND ",cl_replace_str(l_where,"debasite","ooef001")
   #5.檢查門店編號是否為空或為*(即1=1)
   IF cl_null(lc_param.wc) OR lc_param.wc = " 1=1" OR lc_param.wc = "debasite like '%'"THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ade-00182"   #門店編號不可為空或「*」
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF   
   #161216-00004#3 by sakura add(E)
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #161216-00004#3 by sakura add(S)
      #IF lc_param.chk1 = 'Y' THEN
      #   LET l_str1 = cl_replace_str(lc_param.wc,'debasite','ooed005')
      #   LET l_str2 = cl_replace_str(lc_param.wc,'debasite','ooed004')
      #   LET l_str = " rtdxsite IN (SELECT ooed004 FROM ooed_t ",
      #               "              START WITH ",l_str1," AND ooed001 = '8' AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
      #               "             CONNECT BY nocycle PRIOR ooed004 = ooed005 AND ooed001 = '8' ",
      #               "                                  AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
      #               "             UNION ",
      #               "             SELECT ooed004 FROM ooed_t WHERE ",l_str2,")"
      #ELSE
      #   LET l_str = cl_replace_str(lc_param.wc,'debasite','rtdxsite')
      #END IF
      #LET l_where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')   #150308-00001#5  By benson add 'c'
      #LET l_str = l_str," AND ",l_where 
      #LET l_str = cl_replace_str(l_str,'ooef001','rtdxsite')
      #LET l_cnt = 0
      #LET l_sql = " SELECT COUNT(DISTINCT rtdxsite) FROM rtdx_t ",
      #            "  WHERE rtdxent = ",g_enterprise," ",
      #            "    AND rtdxstus = 'Y' ",
      #            "    AND ",l_str,
      #            "  ORDER BY rtdxsite "
      #PREPARE sel_debasite_pre2 FROM l_sql
      #EXECUTE sel_debasite_pre2 INTO l_cnt
      #LET l_cnt = l_cnt +2
      #CALL cl_progress_bar_no_window(l_cnt)   #160225-00040#18 2016/04/13 s983961--add        
      #161216-00004#3 by sakura add(E)
      
      #161216-00004#3 by sakura add(S)
      #取日結門店
      LET l_cnt = 0  
      LET li_count = 0   
      LET l_sql = "SELECT COUNT(ooef001) FROM ooef_t ",
                  " WHERE ooefent = ",g_enterprise,
                  "   AND ",l_str
      PREPARE artp750_cnt_ooef FROM l_sql
      EXECUTE artp750_cnt_ooef INTO l_cnt
      
      #ProgressBar計量統計      
      LET li_count =  (l_cnt * l_dat_cnt) + 2      #ProgressBar計量:(門店數*結算天數)+開始結束數量
      CALL cl_progress_bar_no_window(li_count) 
      #161216-00004#3 by sakura add(E)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE artp750_process_cs CURSOR FROM ls_sql
#  FOREACH artp750_process_cs INTO
   #add-point:process段process name="process.process"
   IF g_bgjob <> "Y" THEN   #161216-00004#3 by sakura add
      #160225-00040#18 2016/04/13 s983961--add(s)
      LET l_msg = cl_getmsg('ade-00114',g_lang)   #批次資料準備  
      CALL cl_progress_no_window_ing(l_msg)
      #160225-00040#18 2016/04/13 s983961--add(e)
   END IF   #161216-00004#3 by sakura add
   
   #建立臨時表
   CALL artp750_create_tmp('1') RETURNING l_success
   IF NOT l_success THEN
      DISPLAY 'create_tmp error!'
      LET li_p01_status = 1
      RETURN
   END IF
   #161216-00004#3 by sakura mark(S)
   #CALL cl_err_collect_init()   
   #
   ##遍歷門店
   ##選擇下展則展開門店
   #IF lc_param.chk1 = 'Y' THEN
   #   LET l_str1 = cl_replace_str(lc_param.wc,'debasite','ooed005')
   #   LET l_str2 = cl_replace_str(lc_param.wc,'debasite','ooed004')
   #   LET l_str = " rtdxsite IN (SELECT ooed004 FROM ooed_t ",
   #               "              START WITH ",l_str1," AND ooed001 = '8' AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
   #               "             CONNECT BY nocycle PRIOR ooed004 = ooed005 AND ooed001 = '8' ",
   #               "                                  AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
   #               "             UNION ",
   #               "             SELECT ooed004 FROM ooed_t WHERE ",l_str2,")"
   #ELSE
   #   LET l_str = cl_replace_str(lc_param.wc,'debasite','rtdxsite')
   #END IF
   #LET l_where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')   #150308-00001#5  By benson add 'c'
   #LET l_str = l_str," AND ",l_where 
   #LET l_str = cl_replace_str(l_str,'ooef001','rtdxsite')
   #
   #LET l_sql = " SELECT DISTINCT rtdxsite FROM rtdx_t ",
   #            "  WHERE rtdxent = ",g_enterprise," ",
   #            "    AND rtdxstus = 'Y' ",
   #            "    AND ",l_str,
   #            "  ORDER BY rtdxsite "
   #PREPARE sel_debasite_pre FROM l_sql
   #DECLARE sel_debasite_cs  CURSOR WITH HOLD FOR sel_debasite_pre
   #FOREACH sel_debasite_cs  INTO l_debasite
   #   #160225-00040# 20160302 s983961--add(s)
   #   LET l_msg = cl_getmsg_parm('amm-00495',g_lang,l_debasite)   #批次產生資料%1   
   #   CALL cl_progress_no_window_ing(l_msg) 
   #   #160225-00040# 20160302 s983961--add(e)
   #   
   #   #161206-00005#4---add--begin-------------
   #   #若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
   #   #参数=Y 需呼叫POS 服务。若返回值等于N，则不继续往下走逻辑
   #   #参数=N 则不呼叫POS服务。走原来逻辑
   #   IF l_checkpos = 'Y' THEN
   #      LET l_flag = 'Y'
   #      CALL cl_err_collect_init()
   #      IF NOT s_check_pos_upload_json('i',l_debasite,lc_param.deba002) THEN
   #         LET l_flag = 'N'
   #      END IF
   #      CALL cl_err_collect_show()
   #      IF l_flag = 'N' THEN
   #         #add by 08172 -S
   #         LET l_msg = cl_getmsg('std-00012',g_lang)   #批次作業已執行完成。
   #         CALL cl_progress_no_window_ing(l_msg)
   #         #add by 08172 -E
   #         RETURN
   #      END IF
   #   END IF
   #   #161206-00005#4---add--end---------------
   #
   #   CALL s_transaction_begin()
   #   #已存在資料刪除重新計算
   #   SELECT COUNT(*) INTO l_n
   #     FROM debn_t
   #    WHERE debnent = g_enterprise
   #      AND debnsite = l_debasite
   #      AND debn002 = lc_param.deba002
   #   IF l_n > 0 THEN
   #      IF lc_param.chk2 = 'Y' THEN
   #         DELETE FROM debn_t
   #          WHERE debnent = g_enterprise
   #            AND debnsite = l_debasite
   #            AND debn002 = lc_param.deba002
   #         IF SQLCA.sqlcode THEN
   #            INITIALIZE g_errparam TO NULL
   #            LET g_errparam.extend = l_debasite
   #            LET g_errparam.code   = SQLCA.sqlcode
   #            LET g_errparam.popup  = TRUE
   #            CALL cl_err()
   #            DISPLAY 'del_debn error!'
   #            LET li_p01_status = 1
   #            CONTINUE FOREACH
   #         END IF
   #      ELSE
   #         CONTINUE FOREACH
   #      END IF
   #   END IF
   #   #獲取自動補貨類型
   #   LET l_rtkh001 = cl_get_para(g_enterprise,l_debasite,'S-CIR-1000')
#  #    IF cl_null(l_rtkh001) THEN
#  #       INITIALIZE g_errparam TO NULL
#  #       LET g_errparam.extend = l_debasite
#  #       LET g_errparam.code   = 'art-00409'
#  #       LET g_errparam.popup  = TRUE
#  #       CALL cl_err()
#  #       CONTINUE FOREACH
#  #    END IF
   #   #獲取DMS公式計算方法
   #   SELECT rtkh002 INTO l_rtkh002
   #     FROM rtkh_t
   #    WHERE rtkhent = g_enterprise
   #      AND rtkh001 = l_rtkh001
#  #    IF SQLCA.sqlcode = 100 THEN
#  #       INITIALIZE g_errparam TO NULL
#  #       LET g_errparam.extend = l_debasite
#  #       LET g_errparam.code   = 'art-00409'
#  #       LET g_errparam.popup  = TRUE
#  #       CALL cl_err()
#  #       CONTINUE FOREACH
#  #    END IF
#  #    IF cl_null(l_rtkh002) THEN
#  #       INITIALIZE g_errparam TO NULL
#  #       LET g_errparam.extend = l_debasite
#  #       LET g_errparam.code   = 'art-00410'
#  #       LET g_errparam.popup  = TRUE
#  #       CALL cl_err()
#  #       CONTINUE FOREACH
#  #    END IF
#  #    #判斷門店是否存在條件日期的日結檔deba資料，不存在返回
#  #    LET l_date = cl_get_para(g_enterprise,l_debasite,'S-CIR-0001')
#  #    IF cl_null(l_date) OR l_date < g_master.deba002 THEN
#  #       INITIALIZE g_errparam TO NULL
#  #       LET g_errparam.extend = l_debasite
#  #       LET g_errparam.code   = 'art-00413'
#  #       LET g_errparam.popup  = TRUE
#  #       CALL cl_err()
#  #       CONTINUE FOREACH
#  #    END IF
#  #    #獲取日均銷量已完成計算日期
#  #    IF cl_null(l_date1) OR l_date1 = '1999/12/31' THEN           #日期為空或未設置，則按照畫面日期計算
#  #       LET l_date_s = g_master.deba002
#  #       LET l_date_e = g_master.deba002
#  #    ELSE                                                         #日期有設置，則從設置日期開始計算
#  #       LET l_date_s = l_date1 + 1
#  #       LET l_date_e = g_master.deba002
#  #    END IF
#  #    #已計算日期大於畫面日期，不可重複計算
#  #    IF l_date1 >= l_date_e THEN
#  #       INITIALIZE g_errparam TO NULL
#  #       LET g_errparam.extend = l_debasite
#  #       LET g_errparam.code   = 'art-00428'
#  #       LET g_errparam.popup  = TRUE
#  #       CALL cl_err()
#  #       CONTINUE FOREACH
#  #    END IF
   #   #日結日期必須大於門店日結關帳日期
   #   LET l_date = cl_get_para(g_enterprise,l_debasite,'S-CIR-0001')
   #   IF cl_null(l_date) OR lc_param.deba002 <= l_date THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.extend = l_debasite
   #      LET g_errparam.code   = 'art-00413'
   #      LET g_errparam.popup  = TRUE
   #      CALL cl_err()
   #      DISPLAY 'error:日结日期小于关账日期',l_debasite
   #      LET li_p01_status = 1
   #      CONTINUE FOREACH
   #   END IF
#  #    #計算日期內存在日結日期，則計算結束日期按照日結日期
#  #    IF l_date < l_date_e THEN
#  #       LET l_date_e = l_date
#  #    END IF
   #   
   #   LET l_success = TRUE
#  #    #前三種方法直接計算最大日期
#  #    IF l_rtkh002 = '01' OR l_rtkh002 = '02' OR l_rtkh002 = '03' THEN
#  #       LET l_date_s = l_date_e
#  #    END IF
#  #    WHILE l_date_s <= l_date_e
   #   #抓所有商品寫日結檔臨時表debn_tmp
   #   CALL artp750_ins_tmp(l_debasite,lc_param.deba002) RETURNING l_success
   #   IF NOT l_success THEN
   #      CALL s_transaction_end('N','0')
   #      DISPLAY 'ins_tmp error!',l_debasite
   #      CONTINUE FOREACH
   #   END IF
   #   #計算DMS/PDMS更新到日結檔debn_tmp
   #   CASE l_rtkh002
   #      WHEN '01'       #歷史資料乘百分比法
   #         CALL artp750_rtkh002_01(l_debasite,lc_param.deba002) RETURNING l_success
   #      WHEN '02'       #移動平均法
   #         CALL artp750_rtkh002_02(l_debasite,lc_param.deba002) RETURNING l_success
   #      WHEN '03'       #加權移動平均法
   #         CALL artp750_rtkh002_03(l_debasite,lc_param.deba002) RETURNING l_success
   #      WHEN '04'       #指數平滑法
   #         CALL artp750_rtkh002_04(l_debasite,lc_param.deba002) RETURNING l_success
   #      WHEN '10'       #多平滑指數法
   #         CALL artp750_rtkh002_10(l_debasite,l_rtkh001,lc_param.deba002) RETURNING l_success
   #   END CASE         
   #   IF NOT l_success THEN
   #      CALL s_transaction_end('N','0')
   #      display 'upd_tmp error:',l_debasite
   #      CONTINUE FOREACH
   #   END IF
   #   display l_debasite,' ins_debn_tmp笔数:',g_cnt
   #   #寫入實體表debn_t
   #   CALL artp750_ins_debn() RETURNING l_success
   #   IF NOT l_success THEN
   #      CALL s_transaction_end('N','0')
   #      display 'error:debn error!',l_debasite
   #      CONTINUE FOREACH
   #   END IF
   #   #更新artm700
   #   LET l_debn002 = lc_param.deba002
   #   LET l_rtkf012 = cl_get_current()    
   #   LET l_sql = " MERGE INTO rtkf_t ",
   #               #" USING (SELECT debnsite,debn005,debn007,debn008 ",     #161011-00033#2 mark
   #               "  USING (SELECT debnsite,debn005,SUM(debn007) sum1,SUM(debn008) sum2 ",      #161011-00033#2 add
   #               "          FROM debn_t ",
   #               "         WHERE debnent = ",g_enterprise," AND debnsite = '",l_debasite,"' ",
   #               "           AND debn002 = '",l_debn002,"' ",
   #               "         GROUP BY debnsite,debn005) ",                  #161011-00033#2 add
   #               "    ON (rtkf001 = debnsite AND rtkf002 = debn005) ",
   #               "  WHEN MATCHED THEN ",
   #               #"       UPDATE SET rtkf010 = debn007, ",      #161011-00033#2 mark
   #               #"                  rtkf011 = debn008, ",      #161011-00033#2 mark
   #               "       UPDATE SET rtkf010 = sum1, ",          #161011-00033#2 add
   #               "                  rtkf011 = sum2, ",          #161011-00033#2 add
   #               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   #   PREPARE upd_rtkf_pre FROM l_sql
   #   EXECUTE upd_rtkf_pre
   #   LET g_cnt = SQLCA.sqlerrd[3]
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.extend = l_debasite,'upd rtkf'
   #      LET g_errparam.code   = SQLCA.sqlcode
   #      LET g_errparam.popup  = TRUE
   #      CALL cl_err()
   #      CALL s_transaction_end('N','0')
   #      display 'upd_rtkf error:',l_debasite
   #      CONTINUE FOREACH
   #   END IF
   #   display 'upd_rtkf笔数:',g_cnt
   #   CALL s_transaction_end('Y','0')
#  #       #更新aoos020中已完成計算日期
#  #       UPDATE ooab_t SET ooab002 = l_date_s
#  #        WHERE ooabent = g_enterprise
#  #          AND ooabsite = l_debasite
#  #       IF SQLCA.sqlcode THEN
#  #          INITIALIZE g_errparam TO NULL
#  #          LET g_errparam.extend = l_debasite
#  #          LET g_errparam.code   = SQLCA.sqlcode
#  #          LET g_errparam.popup  = TRUE
#  #          CALL cl_err()
#  #          CALL s_transaction_end('N','0')
#  #          CONTINUE FOREACH
#  #       END IF
#  #       CALL s_transaction_end('Y','0')
#  #       LET l_date_s = l_date_s + 1
#  #    END WHILE
   #END FOREACH
   #CALL cl_err_collect_show()
   #CALL artp750_create_tmp('2') RETURNING l_success
   ##160225-00040#18 2016/04/13 s983961--add(s)
   #LET l_msg = cl_getmsg('std-00012',g_lang)
   #CALL cl_progress_no_window_ing(l_msg)
   #161216-00004#3 by sakura mark(E)
   
   #161216-00004#3 by sakura -----------------------------------------add(S)
   LET g_exitstus = TRUE
   LET l_cnt       = 0
   LET l_ooef001   = ''
   LET l_date      = ''
   LET l_rtkh001   = ''
   LET l_checkpos  = ''
   LET l_rtkh002   = ''
   LET l_colname_1 = ""
   LET l_comment_1 = ""
   LET l_colname_2 = ""
   LET l_comment_2 = ""
   
   #匯總訊息初始化
   CALL cl_err_collect_init()
   #匯總訊息增加顯示欄位:日結門店
   CALL s_azzi902_get_gzzd(g_prog,"lbl_debasite") RETURNING l_colname_1, l_comment_1
   LET g_coll_title[1] = l_colname_1
   #匯總訊息增加顯示欄位:日結日期
   CALL s_azzi902_get_gzzd(g_prog,"lbl_deba002") RETURNING l_colname_2, l_comment_2
   LET g_coll_title[2] = l_colname_2
   
   #準備需處理的門店清單
   LET l_sql = "SELECT ooef001 FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND ",l_str
   PREPARE artp750_sel_ooef_pre FROM l_sql
   DECLARE artp750_sel_ooef_cur  CURSOR WITH HOLD FOR artp750_sel_ooef_pre
   
   #SQL異常錯誤,g_exitstus=FALSE,中斷執行程式
   FOREACH artp750_sel_ooef_cur  INTO l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:adep220_sel_ooef_cur"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = ""
         LET g_errparam.coll_vals[2] = ""
         CALL cl_err()   
         CALL cl_err_collect_show()
         LET g_exitstus = FALSE
         RETURN
      END IF
      
      #參數準備
      LET l_bus_date  = cl_get_para(g_enterprise,l_ooef001,"S-CIR-0003")   #營業日期#參考原單:160804-00060#1
      LET l_off_date = cl_get_para(g_enterprise,l_ooef001,'S-CIR-0001')   #門店日結關帳日期
      LET l_rtkh001   = cl_get_para(g_enterprise,l_ooef001,'S-CIR-1000')   #自動補貨模型
      #獲取DMS公式計算方法
      SELECT rtkh002 INTO l_rtkh002
        FROM rtkh_t
       WHERE rtkhent = g_enterprise
         AND rtkh001 = l_rtkh001      
      
      #日期處理
      FOR l_i = 1 TO l_dat_cnt STEP 1
         IF l_i = 1 THEN
            LET l_date = lc_param.deba002
         ELSE
            LET l_date = l_date + 1
         END IF
         DISPLAY "Org.:",l_ooef001," AmountDate:",l_date," BussineDate:",l_bus_date," CheckPOS:",l_checkpos,
                 " AutomaticReplenishmentModel:",l_rtkh001
                 
         IF g_bgjob <> "Y" THEN
            LET l_str1 = ":",l_ooef001,",",l_date
            LET l_msg = cl_getmsg_parm('amm-00495',g_lang,l_str1)   #批次產生資料%1   
            CALL cl_progress_no_window_ing(l_msg)
         END IF

         #參考原單:161206-00005#4(S)
         #若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
         #参数=Y 需呼叫POS 服务。若返回值等于N，则不继续往下走逻辑
         #参数=N 则不呼叫POS服务。走原来逻辑
         IF l_checkpos = 'Y' THEN
            LET l_flag = 'Y'
            IF NOT s_check_pos_upload_json('i',l_ooef001,l_date) THEN
               LET l_flag = 'N'
            END IF
            IF l_flag = 'N' THEN  #繼續走下一間門店
                IF SQLCA.sqlcode THEN                 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = "art-00817"  #POS門店日結資料未上傳完成！
                   LET g_errparam.popup = TRUE
                   LET g_errparam.coll_vals[1] = l_ooef001
                   LET g_errparam.coll_vals[2] = l_date
                   CALL cl_err()
                   
                   CALL artp750_progress_cnt(l_i,l_dat_cnt)
                   EXIT FOR
                END IF
            END IF
         END IF
         #參考原單:161206-00005#4(E)

         CALL s_transaction_begin()
         
         #已存在資料刪除重新計算
         SELECT COUNT(*) INTO l_n
           FROM debn_t
          WHERE debnent = g_enterprise
            AND debnsite = l_ooef001
            AND debn002 = l_date
         IF l_n > 0 THEN
            CASE lc_param.chk2
              WHEN 'Y'
                DELETE FROM debn_t
                 WHERE debnent = g_enterprise
                   AND debnsite = l_ooef001
                   AND debn002 = l_date
                IF SQLCA.sqlcode THEN                 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code   = SQLCA.sqlcode
                   LET g_errparam.extend = "del_debn error!"               
                   LET g_errparam.popup = TRUE
                   LET g_errparam.coll_vals[1] = l_ooef001
                   LET g_errparam.coll_vals[2] = l_date
                   CALL cl_err()
                   
                   CALL artp750_progress_cnt(l_i,l_dat_cnt)
                   CALL s_transaction_end('N','0')
                   EXIT FOR
                END IF
              WHEN 'N'
                #如果是N 且 DEBN_T 已經有資料，直接跳過處理，往下一天進行
                CALL s_transaction_end('N','0')
                CONTINUE FOR                
            END CASE
         END IF
         
         #檢查結帳日期是否大於營業日期
         IF l_date >= l_bus_date THEN      
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "art-00815"   #日期必須小於營業日期%1！
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_bus_date
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()
            
            CALL artp750_progress_cnt(l_i,l_dat_cnt)
            CALL s_transaction_end('N','0')
            EXIT FOR
         END IF
         
         #檢查結帳日期是否小於等於日結關帳日期
         IF cl_null(l_off_date) OR l_date <= l_off_date THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'art-00413'   #門店日結關帳日期未設定或大於等於需日結日期！
            LET g_errparam.popup  = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date            
            CALL cl_err()
            
            CALL artp750_progress_cnt(l_i,l_dat_cnt)
            CALL s_transaction_end('N','0')
            EXIT FOR
         END IF         
         
         #抓所有商品寫日結檔臨時表debn_tmp
         LET l_success = TRUE
         CALL artp750_ins_tmp(l_ooef001,l_date) RETURNING l_success
         IF NOT l_success THEN
            CALL artp750_progress_cnt(l_i,l_dat_cnt)         
            CALL s_transaction_end('N','0')
            EXIT FOR
         END IF
         
         #計算DMS/PDMS更新到日結檔debn_tmp
         LET l_success = TRUE
         CASE l_rtkh002
            WHEN '01'       #歷史資料乘百分比法
               CALL artp750_rtkh002_01(l_ooef001,l_date) RETURNING l_success
            WHEN '02'       #移動平均法
               CALL artp750_rtkh002_02(l_ooef001,l_date) RETURNING l_success
            WHEN '03'       #加權移動平均法
               CALL artp750_rtkh002_03(l_ooef001,l_date) RETURNING l_success
            WHEN '04'       #指數平滑法
               CALL artp750_rtkh002_04(l_ooef001,l_date) RETURNING l_success
            WHEN '10'       #多平滑指數法
               CALL artp750_rtkh002_10(l_ooef001,l_rtkh001,l_date) RETURNING l_success
         END CASE         
         IF NOT l_success THEN
            CALL artp750_progress_cnt(l_i,l_dat_cnt)
            CALL s_transaction_end('N','0')
            EXIT FOR            
         END IF
         DISPLAY l_ooef001,' ins_debn_tmp笔数:',g_cnt
         #寫入實體表debn_t
         LET l_success = TRUE
         CALL artp750_ins_debn() RETURNING l_success
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "ins_debn error!"               
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()
            
            CALL artp750_progress_cnt(l_i,l_dat_cnt)
            CALL s_transaction_end('N','0')
            EXIT FOR            
         END IF
         #更新artm700
         LET l_debn002 = l_date
         LET l_rtkf012 = cl_get_current()    
         LET l_sql = " MERGE INTO rtkf_t ",
                     "  USING (SELECT debnsite,debn005,SUM(debn007) sum1,SUM(debn008) sum2 ",
                     "           FROM debn_t ",
                     "          WHERE debnent = ",g_enterprise," AND debnsite = '",l_ooef001,"' ",
                     "            AND debn002 = '",l_debn002,"' ",
                     "          GROUP BY debnsite,debn005) ",
                     "    ON (rtkf001 = debnsite AND rtkf002 = debn005) ",
                     "  WHEN MATCHED THEN ",
                     "       UPDATE SET rtkf010 = sum1, ",
                     "                  rtkf011 = sum2, ",
                     "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
         PREPARE artp750_upd_rtkf_pre FROM l_sql
         EXECUTE artp750_upd_rtkf_pre
         LET g_cnt = SQLCA.sqlerrd[3]
         IF SQLCA.sqlcode THEN         
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "upd_rtkf error!"               
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()
            
            CALL artp750_progress_cnt(l_i,l_dat_cnt)
            CALL s_transaction_end('N','0')
            EXIT FOR
         END IF
         DISPLAY 'upd_rtkf笔数:',g_cnt
         CALL s_transaction_end('Y','0')
      END FOR     
      LET l_ooef001 = ''
      LET l_date = ''
   END FOREACH
   
   CALL artp750_create_tmp('2') RETURNING l_success  
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('std-00012',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   CALL cl_err_collect_show()   
   #161216-00004#3 by sakura -----------------------------------------add(E)
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      #CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309  #161011-00033#2 mark
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL artp750_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp750.get_buffer" >}
PRIVATE FUNCTION artp750_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.deba002 = p_dialog.getFieldBuffer('deba002')
   LET g_master.deba002_end = p_dialog.getFieldBuffer('deba002_end')
   LET g_master.chk1 = p_dialog.getFieldBuffer('chk1')
   LET g_master.chk2 = p_dialog.getFieldBuffer('chk2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artp750.msgcentre_notify" >}
PRIVATE FUNCTION artp750_msgcentre_notify()
 
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
 
{<section id="artp750.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 歷史資料乘百分比法
# Memo...........:
# Usage..........: CALL artp750_rtkh002_01(p_debasite,p_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20141127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_rtkh002_01(p_debasite,p_date)
DEFINE p_debasite     LIKE deba_t.debasite
DEFINE p_date         LIKE deba_t.deba002  
DEFINE l_fcaa001      LIKE fcaa_t.fcaa001
DEFINE l_fcaa002      LIKE fcaa_t.fcaa002
DEFINE l_date         LIKE deba_t.deba002
DEFINE l_sql          STRING
DEFINE l_rtkf012      DATETIME YEAR TO SECOND
DEFINE l_msg          LIKE gzze_t.gzze003

   #LET p_date = g_master.deba002
   
   #抓取前期銷量基數和百分比
   SELECT fcaa001,fcaa002 
     INTO l_fcaa001,l_fcaa002
     FROM fcaa_t
    WHERE fcaaent = g_enterprise
   IF cl_null(l_fcaa001) OR cl_null(l_fcaa002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00411'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add
      CALL cl_err()
      RETURN FALSE
   END IF
   
   CASE l_fcaa001
      WHEN '1'        #昨日銷量
         LET l_date = s_date_get_date(p_date,0,-1)
      WHEN '2'        #上月同期
         LET l_date = s_date_get_date(p_date,-1,0)
      WHEN '3'        #去年同期
         LET l_date = s_date_get_date(p_date,-12,0)
   END CASE
   
#   LET l_rtkf012 = cl_get_current()
#   LET l_sql = " MERGE INTO rtkf_t ",
#               " USING (SELECT rtdxsite,rtdx001,COALESCE((SUM(deba021)*",l_fcaa002,"/100),0) sum1,COALESCE((SUM(deba021)*",l_fcaa002,"/100),0) sum2 ",
#               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",l_date,"' ",
#               "         WHERE rtdxent = ",g_enterprise," ",
#               "           AND rtdxsite = '",p_debasite,"' ",
#               "         GROUP BY rtdxsite,rtdx001) ",
#               "    ON (rtkf001 = rtdxsite AND rtkf002 = rtdx001) ",
#               "  WHEN MATCHED THEN ",
#               "       UPDATE SET rtkf010 = sum1, ",
#               "                  rtkf011 = sum2, ",
#               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   LET l_sql = " MERGE INTO artp750_tmp01 ",              #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               " USING (SELECT rtdxsite,rtdx001,deba020,deba043,deba005,COALESCE((SUM(deba021)*",l_fcaa002,"/100),0) sum1,COALESCE((SUM(deba021)*",l_fcaa002,"/100),0) sum2 ",  #161011-00033#2 add deba #161129-00027#3 add deba005
               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",l_date,"' ",
               "         WHERE rtdxent = ",g_enterprise," ",
               "           AND rtdxsite = '",p_debasite,"' ",
               "         GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005) ",   #161011-00033#2 add deba  #161129-00027#3 add deba005
               "    ON (debnsite = rtdxsite AND debn005 = rtdx001 AND debnent = ",g_enterprise," AND debn002 = '",p_date,"' AND debn006 = deba020 AND debn016 = deba043  AND debn018 = deba005",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "        AND debn017 = (SELECT MIN(debn017) FROM artp750_tmp01 a WHERE a.debnent=debnent AND a.debnsite=debnsite AND a.debn005=debn005 AND a.debn002=debn002 AND a.debn006=debn006 AND a.debn016=debn016 AND a.debn018=debn018)) ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "  WHEN MATCHED THEN ",
               "       UPDATE SET debn007 = sum1, ",
               "                  debn008 = sum2 "
   PREPARE upd_debn_pre1 FROM l_sql
   LET l_msg = cl_getmsg('art-00446',g_dlang)
   EXECUTE upd_debn_pre1
   LET g_cnt = SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd debn_tmp",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add      
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 移動平均法
# Memo...........:
# Usage..........: CALL artp750_rtkh002_02(p_debasite,p_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20141127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_rtkh002_02(p_debasite,p_date)
DEFINE p_debasite     LIKE deba_t.debasite
DEFINE p_date         LIKE deba_t.deba002
DEFINE l_fcaa011      LIKE fcaa_t.fcaa011
DEFINE l_fcaa012      LIKE fcaa_t.fcaa012
DEFINE l_date_s       LIKE deba_t.deba002
DEFINE l_date_e       LIKE deba_t.deba002
DEFINE l_sql          STRING
DEFINE l_rtkf012      DATETIME YEAR TO SECOND
DEFINE l_msg          LIKE gzze_t.gzze003

   #LET p_date = g_master.deba002
   
   #抓取前期銷量基數和移動期數N
   SELECT fcaa011,fcaa012 
     INTO l_fcaa011,l_fcaa012
     FROM fcaa_t
    WHERE fcaaent = g_enterprise
   IF cl_null(l_fcaa011) OR cl_null(l_fcaa012) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00411'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   CASE l_fcaa011
      WHEN '1'        #昨日銷量
         LET l_date_e = s_date_get_date(p_date,0,-1)
      WHEN '2'        #上月同期
         LET l_date_e = s_date_get_date(p_date,-1,0)
      WHEN '3'        #去年同期
         LET l_date_e = s_date_get_date(p_date,-12,0)
   END CASE
   LET l_date_s = s_date_get_date(l_date_e,0,(-1)*(l_fcaa012-1))
   
#   LET l_rtkf012 = cl_get_current()
#   LET l_sql = " MERGE INTO rtkf_t ",
#               " USING (SELECT rtdxsite,rtdx001,COALESCE((SUM(deba021)/",l_fcaa012,"),0) sum1,COALESCE((SUM(deba021)/",l_fcaa012,"),0) sum2 ",
#               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 ",
#               "                                            AND (deba002 BETWEEN '",l_date_s,"' AND '",l_date_e,"') ",
#               "         WHERE rtdxent = ",g_enterprise," ",
#               "           AND rtdxsite = '",p_debasite,"' ",
#               "         GROUP BY rtdxsite,rtdx001) ",
#               "    ON (rtkf001 = rtdxsite AND rtkf002 = rtdx001) ",
#               "  WHEN MATCHED THEN ",
#               "       UPDATE SET rtkf010 = sum1, ",
#               "                  rtkf011 = sum2, ",
#               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   LET l_sql = " MERGE INTO artp750_tmp01 ",       #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               " USING (SELECT rtdxsite,rtdx001,deba020,deba043,deba005,COALESCE((SUM(deba021)/",l_fcaa012,"),0) sum1,COALESCE((SUM(deba021)/",l_fcaa012,"),0) sum2 ",  #161011-00033#2 add deba #161129-00027#3 add deba005
               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 ",
               "                                            AND (deba002 BETWEEN '",l_date_s,"' AND '",l_date_e,"') ",
               "         WHERE rtdxent = ",g_enterprise," ",
               "           AND rtdxsite = '",p_debasite,"' ",
               "         GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005) ",     #161011-00033#2 add deba #161129-00027#3 add deba005
               "    ON (debnsite = rtdxsite AND debn005 = rtdx001 AND debnent = ",g_enterprise," AND debn002 = '",p_date,"' AND debn006 = deba020 AND debn016 = deba043 AND debn018 = deba005 ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "        AND debn017 = (SELECT MIN(debn017) FROM artp750_tmp01 a WHERE a.debnent=debnent AND a.debnsite=debnsite AND a.debn005=debn005 AND a.debn002=debn002 AND a.debn006=debn006 AND a.debn016=debn016 AND a.debn018=debn018)) ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "  WHEN MATCHED THEN ",
               "       UPDATE SET debn007 = sum1, ",
               "                  debn008 = sum2 "
   PREPARE upd_debn_pre2 FROM l_sql
   LET l_msg = cl_getmsg('art-00447',g_dlang)
   EXECUTE upd_debn_pre2
   LET g_cnt = SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd debn_tmp",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 加權移動平均法
# Memo...........:
# Usage..........: CALL artp750_rtkh002_03(p_debasite,p_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20141127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_rtkh002_03(p_debasite,p_date)
DEFINE p_debasite     LIKE deba_t.debasite
DEFINE p_date         LIKE deba_t.deba002
DEFINE l_fcaa021      LIKE fcaa_t.fcaa021
DEFINE l_fcaa022      LIKE fcaa_t.fcaa022
DEFINE l_fcaa023      LIKE fcaa_t.fcaa023
DEFINE l_date         LIKE deba_t.deba002
DEFINE l_date_s       LIKE deba_t.deba002
DEFINE l_date_e       LIKE deba_t.deba002
DEFINE l_sql          STRING
DEFINE tok            base.StringTokenizer
DEFINE l_n            LIKE type_t.num5
DEFINE l_num          LIKE type_t.num5
DEFINE l_sum          LIKE type_t.num5
DEFINE l_rtkf012      DATETIME YEAR TO SECOND
DEFINE l_msg          LIKE gzze_t.gzze003

   #LET p_date = g_master.deba002

   #抓取前期銷量基數和移動期數N
   SELECT fcaa021,fcaa022,fcaa023 
     INTO l_fcaa021,l_fcaa022,l_fcaa023
     FROM fcaa_t
    WHERE fcaaent = g_enterprise
   IF cl_null(l_fcaa021) OR cl_null(l_fcaa022) OR cl_null(l_fcaa023) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00411'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   CASE l_fcaa021
      WHEN '1'        #昨日銷量
         LET l_date_e = s_date_get_date(p_date,0,-1)
      WHEN '2'        #上月同期
         LET l_date_e = s_date_get_date(p_date,-1,0)
      WHEN '3'        #去年同期
         LET l_date_e = s_date_get_date(p_date,-12,0)
   END CASE
   LET l_date_s = s_date_get_date(l_date_e,0,(-1)*(l_fcaa022-1))
   
   LET tok = base.StringTokenizer.create(l_fcaa023,",")
   LET l_n = 0
   LET l_sum = 0
   WHILE tok.hasMoreTokens()
      LET l_num  = tok.nextToken()
      LET l_date = l_date_e - l_n
      IF cl_null(l_sql) THEN
         LET l_sql = " SELECT rtdxsite,rtdx001,deba020,deba043,deba005,COALESCE((SUM(deba021)*",l_num,"),0) sum1,COALESCE((SUM(deba021)*",l_num,"),0) sum2 ",  #161011-00033#2 add deba #161129-00027#3 add deba005
                     "   FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",l_date,"' ",
                     "  WHERE rtdxent = ",g_enterprise," ",
                     "    AND rtdxsite = '",p_debasite,"' ",
                     "  GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005 "    #161011-00033#2 add deba #161129-00027#3 add deba005
      ELSE
         LET l_sql = l_sql CLIPPED,
                     " UNION ALL ",
                     " SELECT rtdxsite,rtdx001,deba020,deba043,deba005,COALESCE((SUM(deba021)*",l_num,"),0) sum1,COALESCE((SUM(deba021)*",l_num,"),0) sum2 ",  #161011-00033#2 add deba #161129-00027#3 add deba005
                     "   FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",l_date,"' ",
                     "  WHERE rtdxent = ",g_enterprise," ",
                     "    AND rtdxsite = '",p_debasite,"' ",
                     "  GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005 "    #161011-00033#2 add deba #161129-00027#3 add deba005
      END IF
      
      LET l_n = l_n + 1
      LET l_sum = l_sum + l_num
   END WHILE
   LET l_sql = " SELECT rtdxsite,rtdx001,SUM(sum1)/",l_sum," s1,SUM(sum2)/",l_sum," s2 ",
               "   FROM (",l_sql,")",
               "  GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005 "          #161011-00033#2 add deba #161129-00027#3 add deba005

#   LET l_rtkf012 = cl_get_current()
#   LET l_sql = " MERGE INTO rtkf_t ",
#               " USING (",l_sql,") ",
#               "    ON (rtkf001 = rtdxsite AND rtkf002 = rtdx001) ",
#               "  WHEN MATCHED THEN ",
#               "       UPDATE SET rtkf010 = s1, ",
#               "                  rtkf011 = s2, ",
#               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   LET l_sql = " MERGE INTO artp750_tmp01 ",            #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               " USING (",l_sql,") ",
               "    ON (debnsite = rtdxsite AND debn005 = rtdx001 AND debnent = ",g_enterprise," AND debn002 = '",p_date,"' AND debn006 = deba020 AND debn016 = deba043 AND debn018 = deba005 ",   #161011-00033#2 add deba #161129-00027#3 add debn018
               "        AND debn017 = (SELECT MIN(debn017) FROM artp750_tmp01 a WHERE a.debnent=debnent AND a.debnsite=debnsite AND a.debn005=debn005 AND a.debn002=debn002 AND a.debn006=debn006 AND a.debn016=debn016 AND a.debn018=debn018)) ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "  WHEN MATCHED THEN ",
               "       UPDATE SET debn007 = s1, ",
               "                  debn008 = s2 "
   PREPARE upd_debn_pre3 FROM l_sql
   LET l_msg = cl_getmsg('art-00448',g_dlang)
   EXECUTE upd_debn_pre3
   LET g_cnt = SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd debn_tmp",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 指數平滑法
# Memo...........:
# Usage..........: CALL artp750_rtkh002_04(p_debasite,p_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20141127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_rtkh002_04(p_debasite,p_date)
DEFINE p_debasite     LIKE deba_t.debasite
DEFINE p_date         LIKE deba_t.deba002
DEFINE l_fcaa031      LIKE fcaa_t.fcaa031
DEFINE l_date         LIKE deba_t.deba002
DEFINE l_sql          STRING
DEFINE l_rtkf012      DATETIME YEAR TO SECOND
DEFINE l_msg          LIKE gzze_t.gzze003

   #LET p_date = g_master.deba002

   #抓取平滑指數
   SELECT fcaa031 
     INTO l_fcaa031
     FROM fcaa_t
    WHERE fcaaent = g_enterprise
   IF cl_null(l_fcaa031) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'art-00411'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #昨日銷量
   LET l_date = p_date - 1
   
   #deba030>0則計算PDMS，否則計算DMS
#   LET l_rtkf012 = cl_get_current()
#   LET l_sql = " MERGE INTO rtkf_t ",
#               " USING (SELECT rtdxsite,rtdx001,",
#               "               CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE(rtkf010,0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE((",l_fcaa031,"*rtkf010+(1-",l_fcaa031,")*SUM(deba021)),0) END sum1,",
#               "               CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE((",l_fcaa031,"*rtkf011+(1-",l_fcaa031,")*SUM(deba021)),0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE(rtkf011,0) END sum2 ",
#               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",l_date,"',rtkf_t ",
#               "         WHERE rtdxent = rtkfent ",
#               "           AND rtdxsite = rtkf001 ",
#               "           AND rtdx001 = rtkf002 ",
#               "           AND rtdxent = ",g_enterprise," ",
#               "           AND rtdxsite = '",p_debasite,"' ",
#               "         GROUP BY rtdxsite,rtdx001,rtkf010,rtkf011) ",
#               "    ON (rtkf001 = rtdxsite AND rtkf002 = rtdx001) ",
#               "  WHEN MATCHED THEN ",
#               "       UPDATE SET rtkf010 = sum1, ",
#               "                  rtkf011 = sum2, ",
#               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   LET l_sql = " MERGE INTO artp750_tmp01 ",          #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               " USING (SELECT rtdxsite,rtdx001,deba020,deba043,deba005,",       #161011-00033#2 add deba #161129-00027#3 add deba005
               "               CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE(debn007,0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE((",l_fcaa031,"*COALESCE(debn007,0)+(1-",l_fcaa031,")*SUM(deba021)),0) END sum1,",
               "               CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE((",l_fcaa031,"*COALESCE(debn008,0)+(1-",l_fcaa031,")*SUM(deba021)),0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE(debn008,0) END sum2 ",
               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",p_date,"' ",
               "                      LEFT OUTER JOIN debn_t ON rtdxent = debnent AND rtdxsite = debnsite AND rtdx001 = debn005 AND debn002 = '",l_date,"' ",
               "         WHERE rtdxent = ",g_enterprise," ",
               "           AND rtdxsite = '",p_debasite,"' ",
               "         GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005,debn007,debn008) ",     #161011-00033#2 add deba #161129-00027#3 add deba005
               "    ON (debnsite = rtdxsite AND debn005 = rtdx001 AND debnent = ",g_enterprise," AND debn002 = '",p_date,"' AND debn006 = deba020 AND debn016 = deba043 AND debn018 = deba005 ",   #161011-00033#2 add deba, #161129-00027#3 add debn018
               "        AND debn017 = (SELECT MIN(debn017) FROM artp750_tmp01 a WHERE a.debnent=debnent AND a.debnsite=debnsite AND a.debn005=debn005 AND a.debn002=debn002 AND a.debn006=debn006 AND a.debn016=debn016 AND a.debn018=debn018)) ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "  WHEN MATCHED THEN ",
               "       UPDATE SET debn007 = sum1, ",
               "                  debn008 = sum2 "
   PREPARE upd_debn_pre4 FROM l_sql
   LET l_msg = cl_getmsg('art-00449',g_dlang)
   EXECUTE upd_debn_pre4
   LET g_cnt = SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd debn_tmp",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artp750_rtkh002_10(p_debasite,p_rtkh001,p_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 20141127 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_rtkh002_10(p_debasite,p_rtkh001,p_date)
DEFINE p_debasite     LIKE deba_t.debasite
DEFINE p_date         LIKE deba_t.deba002
DEFINE p_rtkh001      LIKE rtkh_t.rtkh001
DEFINE l_rtkh003      LIKE rtkh_t.rtkh003
DEFINE l_rtkh004      LIKE rtkh_t.rtkh004
DEFINE l_date         LIKE deba_t.deba002
DEFINE l_ooef008      LIKE ooef_t.ooef008
DEFINE l_ooef010      LIKE ooef_t.ooef010
DEFINE r_flag         LIKE type_t.chr1
DEFINE r_errno        LIKE type_t.chr100
DEFINE r_oogc015      LIKE oogc_t.oogc015
DEFINE r_oogc007      LIKE oogc_t.oogc007
DEFINE r_sdate_s      LIKE oogc_t.oogc003
DEFINE r_sdate_e      LIKE oogc_t.oogc003
DEFINE r_oogc006      LIKE oogc_t.oogc006
DEFINE r_pdate_s      LIKE oogc_t.oogc003
DEFINE r_pdate_e      LIKE oogc_t.oogc003
DEFINE r_oogc008      LIKE oogc_t.oogc008
DEFINE r_wdate_s      LIKE oogc_t.oogc003
DEFINE r_wdate_e      LIKE oogc_t.oogc003
DEFINE l_n            LIKE type_t.num5
DEFINE l_str          LIKE type_t.chr10
DEFINE l_str1         LIKE type_t.chr10
DEFINE l_sql          STRING
DEFINE l_rtkf012      DATETIME YEAR TO SECOND
DEFINE l_msg          LIKE gzze_t.gzze003

   #LET p_date = g_master.deba002

   #抓取DMS/PDMS昨日值估比
   SELECT rtkh003,rtkh004 INTO l_rtkh003,l_rtkh004
     FROM rtkh_t
    WHERE rtkhent = g_enterprise
      AND rtkh001 = p_rtkh001
   IF cl_null(l_rtkh003) OR cl_null(l_rtkh004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = p_rtkh001
      LET g_errparam.code   = 'art-00412'
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF

   #昨日銷量
   LET l_date = p_date - 1
   LET l_sql = " SELECT DISTINCT rtdxsite,rtdx001, "
   #獲取日期對應週別
   SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_debasite
   CALL s_get_oogcdate(l_ooef008,l_ooef010,p_date,'','')
       RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
   IF NOT cl_null(r_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "sel oogc"
      LET g_errparam.code   = r_errno
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
       
   FOR l_n=1 TO 52
      IF l_n = r_oogc008 THEN
         IF l_n < 10 THEN
            LET l_str = "rtkj10"
         ELSE
            LET l_str = "rtkj1"
         END IF
         LET l_str1 = l_n
         LET l_str = l_str CLIPPED,l_str1 CLIPPED
         EXIT FOR
      END IF
   END FOR
   IF cl_null(l_str) THEN
      LET l_str = "rtkj152"
   END IF
   
   LET l_sql = l_sql CLIPPED,"COALESCE(",l_str CLIPPED,",1)"
   LET l_sql = l_sql CLIPPED," a ",
               "   FROM rtdx_t LEFT OUTER JOIN imaa_t ON imaa001 = rtdx001 AND imaaent = rtdxent ",
               "               LEFT OUTER JOIN rtkj_t ON rtkjent = imaaent AND imaa009 = rtkj002 AND rtkj001 = '",p_rtkh001,"' ",
               "  WHERE rtdxent = ",g_enterprise," "
   LET l_sql = " SELECT rtdxsite a1,rtdx001 a2,a a3,COALESCE(rtkk004,1) a4 ",
               "   FROM (",l_sql,")"," LEFT OUTER JOIN rtkk_t ON rtkkent = ",g_enterprise," AND rtkk001 = '",p_rtkh001,"' AND (a BETWEEN rtkk002 AND rtkk003) "
   LET l_sql = " SELECT rtdxsite,rtdx001,deba020,deba043,deba005,",        #161011-00033#2 add deba #161129-00027#3 add deba005
               "        CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE(debn007,0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE(((",l_rtkh003,"+(1-",l_rtkh003,")*(1-a4))*COALESCE(debn007,0)+(1-",l_rtkh003,")*a4*SUM(deba021)/a3),0) END sum1,",
               "        CASE WHEN COALESCE(SUM(deba030),0)>0 THEN COALESCE(((",l_rtkh004,"+(1-",l_rtkh004,")*(1-a4))*COALESCE(debn008,0)+(1-",l_rtkh004,")*a4*SUM(deba021)/a3),0) WHEN COALESCE(SUM(deba030),0)<=0 THEN COALESCE(debn008,0) END sum2 ",
               "          FROM rtdx_t LEFT OUTER JOIN deba_t ON rtdxent = debaent AND rtdxsite = debasite AND rtdx001 = deba009 AND deba002 = '",p_date,"' ",
               "                      LEFT OUTER JOIN debn_t ON rtdxent = debnent AND rtdxsite = debnsite AND rtdx001 = debn005 AND debn002 = '",l_date,"',(",l_sql,") ",
               "         WHERE rtdxsite = a1 ",
               "           AND rtdx001 = a2 ",
               "           AND rtdxent = ",g_enterprise," ",
               "           AND rtdxsite = '",p_debasite,"' ",
               "         GROUP BY rtdxsite,rtdx001,deba020,deba043,deba005,debn007,debn008,a3,a4 "     #161011-00033#2 add deba #161129-00027#3 add deba005
               
#   LET l_rtkf012 = cl_get_current()
#   LET l_sql = " MERGE INTO rtkf_t ",
#               " USING (",l_sql,") ",
#               "    ON (rtkf001 = rtdxsite AND rtkf002 = rtdx001) ",
#               "  WHEN MATCHED THEN ",
#               "       UPDATE SET rtkf010 = sum1, ",
#               "                  rtkf011 = sum2, ",
#               "                  rtkf012 = to_date('",l_rtkf012,"','YYYY-MM-DD hh24:mi:ss') "
   LET l_sql = " MERGE INTO artp750_tmp01 ",          #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               " USING (",l_sql,") ",
               "    ON (debnsite = rtdxsite AND debn005 = rtdx001 AND debnent = ",g_enterprise," AND debn002 = '",p_date,"' AND debn006 = deba020 AND debn016 = deba043 AND debn018 = deba005 ",  #161011-00033#2 add deba #161129-00027#3 add debn018
               "        AND debn017 = (SELECT MIN(debn017) FROM artp750_tmp01 a WHERE a.debnent=debnent AND a.debnsite=debnsite AND a.debn005=debn005 AND a.debn002=debn002 AND a.debn006=debn006 AND a.debn016=debn016 AND a.debn018=debn018)) ",  #161011-00033#2 add deba #161129-00027#3 add debn018 
               "  WHEN MATCHED THEN ",
               "       UPDATE SET debn007 = sum1, ",
               "                  debn008 = sum2 "
   PREPARE upd_debn_pre10 FROM l_sql
   LET l_msg = cl_getmsg('art-00450',g_dlang)
   EXECUTE upd_debn_pre10
   LET g_cnt = SQLCA.sqlerrd[3]
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "upd debn_tmp",l_msg
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_debasite   #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_date       #161216-00004#3 by sakura add       
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 寫入商品日統計日結檔
# Memo...........:
# Usage..........: CALL artp750_ins_debn()
# Input parameter: p_site   門店
# Date & Author..: 20150325 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_ins_debn()

   INSERT INTO debn_t (debnent, debnsite, debn001, debn002, debn003, debn004, debn005, debn006, debn007,
                       debn008, debn009, debn010, debn011, debn012, debn013, debn014, debn015, debn016, debn017,debn018)   #20150715 dongsz add debn014,debn015 #161011-00033#2 add 016,017  #161129-00027#3 add 018
   SELECT debnent, debnsite, debn001, debn002, debn003, debn004, debn005, debn006, debn007,
          debn008, debn009, debn010, debn011, debn012, debn013, debn014, debn015, debn016, debn017,debn018  #20150715 dongsz add debn014,debn015 #161011-00033#2 add 016,017 #161129-00027#3 add 018
     FROM artp750_tmp01            #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
     
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ins debn_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE      
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
   
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL artp750_create_tmp(p_type)
# Date & Author..: 20150327 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_create_tmp(p_type)
DEFINE p_type      LIKE type_t.chr1

   IF p_type = '1' THEN
      DROP TABLE artp750_tmp01                  #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
      CREATE TEMP TABLE artp750_tmp01(          #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
         debnent      LIKE debn_t.debnent,
         debnsite     LIKE debn_t.debnsite,
         debn001      LIKE debn_t.debn001,
         debn002      LIKE debn_t.debn002, 
         debn003      LIKE debn_t.debn003, 
         debn004      LIKE debn_t.debn004, 
         debn005      LIKE debn_t.debn005, 
         debn006      LIKE debn_t.debn006, 
         debn007      LIKE debn_t.debn007, 
         debn008      LIKE debn_t.debn008, 
         debn009      LIKE debn_t.debn009, 
         debn010      LIKE debn_t.debn010, 
         debn011      LIKE debn_t.debn011, 
         debn012      LIKE debn_t.debn012, 
         debn013      LIKE debn_t.debn013,
         debn014      LIKE debn_t.debn014,    #20150715 add by dongsz
         debn015      LIKE debn_t.debn015,    #20150715 add by dongsz
         debn016      LIKE debn_t.debn016,    #161011-00033#2 add
         debn017      LIKE debn_t.debn017,    #161011-00033#2 add
         debn018      LIKE debn_t.debn018)    #161129-00027#3 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "create debn_tmp"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   
   IF p_type = '2' THEN
      DROP TABLE artp750_tmp01              #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "drop debn_tmp"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 寫入商品日統計日結檔臨時表
# Memo...........:
# Usage..........: CALL artp750_ins_tmp(p_site,p_deba002)
# Input parameter: p_site   門店
# Date & Author..: 20150325 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_ins_tmp(p_site,p_deba002)
DEFINE p_site         LIKE debn_t.debnsite
DEFINE p_deba002      LIKE deba_t.deba002
DEFINE l_sql          STRING
DEFINE l_ooef017      LIKE ooef_t.ooef017
DEFINE l_glaa003      LIKE glaa_t.glaa003
DEFINE l_glaald       LIKE glaa_t.glaald    #主帐套 #20150715 add by dongsz
DEFINE l_glaa120      LIKE glaa_t.glaa120   #成本计算类型 #20150715 add by dongsz
DEFINE r_flag         LIKE type_t.chr1
DEFINE r_errno        LIKE type_t.chr100
DEFINE r_glav002      LIKE glav_t.glav002
DEFINE r_glav005      LIKE glav_t.glav005
DEFINE r_sdate_s      LIKE glav_t.glav004
DEFINE r_sdate_e      LIKE glav_t.glav004
DEFINE r_glav006      LIKE glav_t.glav006
DEFINE r_pdate_s      LIKE glav_t.glav004
DEFINE r_pdate_e      LIKE glav_t.glav004
DEFINE r_glav007      LIKE glav_t.glav007
DEFINE r_wdate_s      LIKE glav_t.glav004
DEFINE r_wdate_e      LIKE glav_t.glav004
DEFINE l_date         LIKE deba_t.deba002   #150721-00010#1-add by dongsz
DEFINE l_debn002      LIKE debn_t.debn002   #150721-00010#1-add by dongsz
DEFINE l_flag         LIKE type_t.chr1      #20151022 dongsz add
DEFINE l_xcbf003      LIKE xcbf_t.xcbf003   #20151022 dongsz add
DEFINE l_xcbf001        LIKE xcbf_t.xcbf001   #20151109 geza add
   #LET p_deba002 = g_master.deba002
   
   #150721-00010#1--add by dongsz--s
   #判断计算日期+1是否大于营业日期，是则返回
   LET l_date = cl_get_para(g_enterprise,p_site,'S-CIR-0003')
   IF p_deba002 + 1 > l_date THEN
      display 'error! 判断计算日期(',p_deba002,')+1(',p_deba002+1,')大于营业日期:',l_date
      RETURN FALSE
   END IF
   #150721-00010#1--add by dongsz--e
   
   #抓取法人對應會計週期參照表
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_site
   SELECT glaa003,glaald,glaa120 INTO l_glaa003,l_glaald,l_glaa120  #20150715 dongsz add glaald,glaa120
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'
   IF cl_null(l_glaa003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = p_site
      LET g_errparam.code = "sub-00424"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add
      CALL cl_err()
      RETURN FALSE
   END IF
   #20151022--dongsz add--str---
   #抓取aoos020设定的成本域
   #启用成本域否
   LET l_flag = cl_get_para(g_enterprise,p_site,'S-FIN-6001')
   #成本域类型
   LET l_xcbf003 = cl_get_para(g_enterprise,p_site,'S-FIN-6002')
   #20151022--dongsz add--end---
   
   #add by geza 20151109(S)
   #成本域类型
   SELECT xcbf001 INTO l_xcbf001
     FROM xcbf_t 
    WHERE xcbfent = g_enterprise 
      AND xcbfcomp = l_ooef017 
      AND xcbf002 = p_site 
      AND xcbf003 = l_xcbf003
   #add by geza 20151109(E)
   
   #取得會計週期資料
   CALL s_get_accdate(l_glaa003,p_deba002,'','')
      RETURNING r_flag,r_errno,r_glav002,r_glav005,r_sdate_s,r_sdate_e,r_glav006,r_pdate_s,r_pdate_e,r_glav007,r_wdate_s,r_wdate_e
   IF r_flag <> 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = p_site
      LET g_errparam.code = r_errno
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add      
      CALL cl_err()
      RETURN FALSE
   END IF

   DELETE FROM artp750_tmp01            #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
   LET l_sql = " INSERT INTO artp750_tmp01 (    debnent, ",            #企業編號       #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
               "                                debnsite, ",           #門店編號
               "                                debn001, ",            #層級類型
               "                                debn002, ",            #統計日期
               "                                debn003, ",            #會計週
               "                                debn004, ",            #會計期
               "                                debn005, ",            #商品編號
               "                                debn006, ",            #銷售單位
               "                                debn007, ",            #日均銷量
               "                                debn008, ",            #促銷日均銷量
               "                                debn009, ",            #庫存單位
               "                                debn010, ",            #成本倉數量
               "                                debn011, ",            #非成本倉數量
               "                                debn012, ",            #可用數量
               "                                debn013, ",            #不可用數量
               "                                debn014, ",            #库存总量   #20150715 add by dongsz
               "                                debn015, ",            #库存总额   #20150715 add by dongsz
               "                                debn016, ",            #产品特征   #161011-00033#2 add
               "                                debn017, ",            #库存管理特征  #161011-00033#2 add
               "                                debn018) ",            #库位        #161129-00027#3 add
               " SELECT DISTINCT rtdxent, ",
               "        rtdxsite, ",
               "        ooef101, ",
               "        '",p_deba002,"', ",
               "        ",r_glav007,", ",
               "        ",r_glav006,", ",
               "        rtdx001, ",
               "        imaa105, ",
               "        0, ",
               "        0, ",
               #"        imaa104, ",   #161011-00033#2 mark
               "        inag007, ",    #161011-00033#2 add
               "        0, ",
               "        0, ",
               "        0, ",
               "        0, ",
               "        0, ",          #20150715 add by dongsz
               "        0, ",          #20150715 add by dongsz
               "        inag002, ",    #161011-00033#2 add
               "        inag003,  ",   #161011-00033#2 add
               "        inag004  ",    #161129-00027#3 add
               "   FROM rtdx_t,ooef_t,imaa_t,inag_t ",     #161011-00033#2 add inag_t
               "  WHERE rtdxent = ",g_enterprise," AND rtdxent = ooefent AND rtdxent = imaaent ",
               "    AND rtdxsite = '",p_site,"' AND rtdxsite = ooef001 ",
               "    AND inagent = rtdxent AND inagsite = rtdxsite AND inag001 = rtdx001 ",   #161011-00033#2 add
               "    AND rtdx001 = imaa001 "
   PREPARE ins_debn_pre FROM l_sql
   EXECUTE ins_debn_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ins debn_tmp"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
      LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add      
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #更新debn_t
   #150721-00010#1--add by dongsz--s
   #判断计算日期+1是否等于营业日期
   IF p_deba002 + 1 = l_date THEN
   #150721-00010#1--add by dongsz--e
      LET l_sql = " UPDATE artp750_tmp01 ",             #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
                  "    SET debn010 = (SELECT COALESCE(SUM(inag008),0) FROM inag_t,inaa_t ",
                  "                    WHERE inagent = debnent AND inaaent = debnent AND inagsite = debnsite AND inaasite = debnsite ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add  #161129-00027#3 add
                  "                      AND inag001 = debn005 AND inag004 = inaa001 AND inag007 = debn009 AND inaa010 = 'Y'), ",
                  "        debn011 = (SELECT COALESCE(SUM(inag008),0) FROM inag_t,inaa_t ",
                  "                    WHERE inagent = debnent AND inaaent = debnent AND inagsite = debnsite AND inaasite = debnsite ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add #161129-00027#3 add
                  "                      AND inag001 = debn005 AND inag004 = inaa001 AND inag007 = debn009 AND inaa010 = 'N'), ",
                  "        debn012 = (SELECT COALESCE(SUM(inag008),0) FROM inag_t,inaa_t ",
                  "                    WHERE inagent = debnent AND inaaent = debnent AND inagsite = debnsite AND inaasite = debnsite ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add #161129-00027#3 add
                  "                      AND inag001 = debn005 AND inag004 = inaa001 AND inag007 = debn009 AND inaa008 = 'Y'), ",
                  "        debn013 = (SELECT COALESCE(SUM(inag008),0) FROM inag_t,inaa_t ",
                  "                    WHERE inagent = debnent AND inaaent = debnent AND inagsite = debnsite AND inaasite = debnsite ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add #161129-00027#3 add
                  "                      AND inag001 = debn005 AND inag004 = inaa001 AND inag007 = debn009 AND inaa008 = 'N'), ",
                  #20150715 add by dongsz--s
                  "        debn014 = (SELECT COALESCE(SUM(inag008),0) FROM inag_t ",
                  "                    WHERE inagent = debnent AND inagsite = debnsite ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add #161129-00027#3 add
                  "                      AND inag001 = debn005 AND inag007 = debn009), ",
                  "        debn015 = (SELECT COALESCE(SUM(SUM(inag008*xccu202)),0) FROM xccu_t,inag_t ",
                  #add by geza 20151110(S)
                  "                     LEFT OUTER JOIN ooef_t ",
                  "                       ON ooefent = inagent AND ooef001 = inagsite  ",
                  #抓取该法人和组织对应成本域类型的成本域编号 
                  "                     LEFT OUTER JOIN xcbf_t ",
                  "                       ON xcbfent = inagent AND xcbfcomp = ooef017 
                                         AND xcbf002 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                            WHEN 'Y' THEN 
                                                                            CASE '",l_xcbf003,"' WHEN '1' THEN inagsite
                                                                                                 WHEN '2' THEN inag004
                                                                            END                                                                                       
                                                        END 
                                         AND xcbf003 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                            WHEN 'Y' THEN '",l_xcbf003,"'                                                                                      
                                                        END ",
                  #add by geza 20151110(E)
                  "                    WHERE inagent = debnent AND xccuent = debnent ",
                  "                      AND inagsite = debnsite AND inag001 = debn005 ",
                  "                      AND inag002 = debn016 AND inag003 = debn017 AND inag004 = debn018 ",        #161011-00033#2 add #161129-00027#3 add
                  "                      AND inag007 = debn009 AND inag001 = xccu004 AND inag006 = xccu006 ",
                  "                      AND xcculd = '",l_glaald,"' AND xccu001 = '1' AND xccu003 = '",l_glaa120,"' ",
                  #add by geza 20151109(S)
                  #xccu加上其他主键
                  "                      AND xccu005 = inag002 AND xccu002 = COALESCE(xcbf001,xccu002) ",
                  #add by geza 20151109(E)
                  "                    GROUP BY inag006) ",
                  #20150715 add by dongsz--e
                  "  WHERE debnent = ",g_enterprise," ",
                  "    AND debnsite = '",p_site,"' ",
                  "    AND debn002 = '",p_deba002,"' "
      PREPARE upd_debn_pre5 FROM l_sql
      EXECUTE upd_debn_pre5
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd debn_tmp"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
         LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add         
         CALL cl_err()
         RETURN FALSE
      END IF
   #150721-00010#1--add by dongsz--s
   ELSE
      LET l_debn002 = p_deba002 - 1
      LET l_sql = " UPDATE artp750_tmp01 t1 ",                  #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
                  "    SET t1.debn010 = COALESCE((SELECT COALESCE(t2.debn010,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0), ",
                  "        t1.debn011 = COALESCE((SELECT COALESCE(t2.debn011,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0), ",
                  "        t1.debn012 = COALESCE((SELECT COALESCE(t2.debn012,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0), ",
                  "        t1.debn013 = COALESCE((SELECT COALESCE(t2.debn013,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0), ",
                  "        t1.debn014 = COALESCE((SELECT COALESCE(t2.debn014,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0), ",
                  "        t1.debn015 = COALESCE((SELECT COALESCE(t2.debn015,0) FROM debn_t t2 ",
                  "                       WHERE t2.debnent = ",g_enterprise," AND t2.debnsite = '",p_site,"' ",
                  "                         AND t2.debn009 = t1.debn009 AND t2.debn016 = t1.debn016 AND t2.debn017 = t1.debn017 AND t2.debn018 = t1.debn018 ",  #161011-00033#2 add #161129-00027#3 add
                  "                         AND t2.debn002 = '",l_debn002,"' AND t2.debn005 = t1.debn005),0) "
      PREPARE upd_debn_pre6 FROM l_sql
      EXECUTE upd_debn_pre6
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd debn_tmp"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
         LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add         
         CALL cl_err()
         RETURN FALSE
      END IF
      LET l_sql = " UPDATE artp750_tmp01 ",                #160727-00019#16 Mod   artp750_debn_tmp -->artp750_tmp01
                  "    SET debn010 = debn010+COALESCE((SELECT COALESCE(SUM(inaj011*inaj013*inaj004),0) FROM inaj_t,inaa_t ",
                  "                    WHERE inajent = debnent AND inaaent = debnent AND inajsite = debnsite AND inaasite = debnsite ",
                  "                      AND inaj005 = debn005 AND inaj008 = inaa001 AND inaj022 = '",p_deba002,"' ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaa010 = 'Y' AND inaastus = 'Y'),0), ",
                  "        debn011 = debn011+COALESCE((SELECT COALESCE(SUM(inaj011*inaj013*inaj004),0) FROM inaj_t,inaa_t ",
                  "                    WHERE inajent = debnent AND inaaent = debnent AND inajsite = debnsite AND inaasite = debnsite ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaj005 = debn005 AND inaj008 = inaa001 AND inaj022 = '",p_deba002,"' ",
                  "                      AND inaa010 = 'N' AND inaastus = 'Y'),0), ",
                  "        debn012 = debn012+COALESCE((SELECT COALESCE(SUM(inaj011*inaj013*inaj004),0) FROM inaj_t,inaa_t ",
                  "                    WHERE inajent = debnent AND inaaent = debnent AND inajsite = debnsite AND inaasite = debnsite ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaj005 = debn005 AND inaj008 = inaa001 AND inaj022 = '",p_deba002,"' ",
                  "                      AND inaa008 = 'Y' AND inaastus = 'Y'),0), ",
                  "        debn013 = debn013+COALESCE((SELECT COALESCE(SUM(inaj011*inaj013*inaj004),0) FROM inaj_t,inaa_t ",
                  "                    WHERE inajent = debnent AND inaaent = debnent AND inajsite = debnsite AND inaasite = debnsite ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaj005 = debn005 AND inaj008 = inaa001 AND inaj022 = '",p_deba002,"' ",
                  "                      AND inaa008 = 'N' AND inaastus = 'Y'),0), ",
                  "        debn014 = debn014+COALESCE((SELECT COALESCE(SUM(inaj011*inaj013*inaj004),0) FROM inaj_t ",
                  "                    WHERE inajent = debnent AND inajsite = debnsite ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaj005 = debn005 AND inaj022 = '",p_deba002,"'),0), ",
                  "        debn015 = debn015+COALESCE((SELECT COALESCE(SUM(SUM((inaj011*inaj013*inaj004)*xccu202)),0) FROM xccu_t,inaj_t ",
                   #add by geza 20151110(S)
                  "                     LEFT OUTER JOIN ooef_t ",
                  "                       ON ooefent = inajent AND ooef001 = inajsite  ",
                  #抓取该法人和组织对应成本域类型的成本域编号 
                  "                     LEFT OUTER JOIN xcbf_t ",
                  "                       ON xcbfent = inajent AND xcbfcomp = ooef017 
                                         AND xcbf002 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                            WHEN 'Y' THEN 
                                                                            CASE '",l_xcbf003,"' WHEN '1' THEN inajsite
                                                                                                 WHEN '2' THEN inaj008
                                                                            END                                                                                       
                                                        END 
                                         AND xcbf003 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                                            WHEN 'Y' THEN '",l_xcbf003,"'                                                                                      
                                                        END ",
                  #add by geza 20151110(E)
                  "                    WHERE inajent = debnent AND xccuent = debnent ",
                  "                      AND inajsite = debnsite AND inaj005 = debn005 ",
                  "                      AND inaj045 = debn009 AND inaj006 = debn016 AND inaj007 = debn017 AND inaj008 = debn018 ",   #161011-00033#2 add #161129-00027#3 add
                  "                      AND inaj022 = '",p_deba002,"' AND inaj005 = xccu004 AND inaj010 = xccu006 ",
                  "                      AND xcculd = '",l_glaald,"' AND xccu001 = '1' AND xccu003 = '",l_glaa120,"' ",
                  #add by geza 20151109(S)
                  #xccu加上其他主键
                  "                      AND xccu005 = inaj006 AND xccu002 = COALESCE(xcbf001,xccu002)  ",
                  #add by geza 20151109(E)
                  "                    GROUP BY inaj010),0) ",
                  "  WHERE debnent = ",g_enterprise," ",
                  "    AND debnsite = '",p_site,"' ",
                  "    AND debn002 = '",p_deba002,"' "
      PREPARE upd_debn_pre7 FROM l_sql
      EXECUTE upd_debn_pre7
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd debn_tmp"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         LET g_errparam.coll_vals[1] = p_site      #161216-00004#3 by sakura add
         LET g_errparam.coll_vals[2] = p_deba002   #161216-00004#3 by sakura add         
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #150721-00010#1--add by dongsz--e
   
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 處理在日期迴圈中的進度條
# Memo...........:
# Usage..........: CALL artp750_progress_cnt(p_cnt,p_total)
# Input parameter: p_cnt          目前的日期位置
#                  p_total        日期總長度
# Return code....: 
# Date & Author..: 2016/12/29 By sakura #161216-00004#3 
# Modify.........:
################################################################################
PRIVATE FUNCTION artp750_progress_cnt(p_cnt,p_total)
DEFINE p_cnt     LIKE type_t.num10
DEFINE p_total   LIKE type_t.num10
DEFINE l_i       LIKE type_t.num10
  
  LET p_cnt = p_cnt + 1
  FOR l_i = p_cnt TO p_total
      CALL cl_progress_no_window_ing('')
  END FOR  

END FUNCTION

#end add-point
 
{</section>}
 
