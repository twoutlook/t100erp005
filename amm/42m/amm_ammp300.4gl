#該程式未解開Section, 採用最新樣板產出!
{<section id="ammp300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-11 15:29:03), PR版次:0001(2016-11-17 13:49:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ammp300
#+ Description: 會員異動紀錄重計
#+ Creator....: 02749(2016-11-11 09:31:35)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="ammp300.global" >}
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
       mmaq003 LIKE type_t.chr30, 
   mmaq001 LIKE type_t.chr30, 
   mmaq002 LIKE type_t.chr10, 
   mmaq022 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_g_mmar        RECORD
          mmar001   LIKE mmar_t.mmar001,
          mmar004   LIKE mmar_t.mmar004,
          mmar005   LIKE mmar_t.mmar005,
          mmarseq   LIKE mmar_t.mmarseq,
          mmar006   LIKE mmar_t.mmar006,
          mmar009   LIKE mmar_t.mmar009,
          mmar011   LIKE mmar_t.mmar011,
          mmar012   LIKE mmar_t.mmar012
                     END RECORD 
TYPE type_g_mmau       RECORD
          mmau001   LIKE mmau_t.mmau001,
          mmau004   LIKE mmau_t.mmau004,
          mmau005   LIKE mmau_t.mmau005,
          mmauseq   LIKE mmau_t.mmauseq,
          mmau006   LIKE mmau_t.mmau006, 
          mmau007   LIKE mmau_t.mmau007,
          mmau008   LIKE mmau_t.mmau008,
          mmau009   LIKE mmau_t.mmau009,
          mmau012   LIKE mmau_t.mmau012,
          mmau013   LIKE mmau_t.mmau013,
          mmau014   LIKE mmau_t.mmau014,
          mmau015   LIKE mmau_t.mmau015,
          mmau016   LIKE mmau_t.mmau016
                    END RECORD   

DEFINE g_fail_exit   LIKE type_t.num5   #批次異常離開, TURE:發生錯誤/異常 ,FALSE:無任何錯誤/異常
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="ammp300.main" >}
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
   CALL cl_ap_init("amm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_fail_exit = FALSE
   
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ammp300_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammp300 WITH FORM cl_ap_formpath("amm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ammp300_init()
 
      #進入選單 Menu (="N")
      CALL ammp300_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ammp300
   END IF
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   
   IF g_fail_exit THEN
      CALL cl_ap_exitprogram("1")
   END IF
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ammp300.init" >}
#+ 初始化作業
PRIVATE FUNCTION ammp300_init()
 
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
 
{<section id="ammp300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammp300_ui_dialog()
 
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
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON mmaq003,mmaq001,mmaq002,mmaq022
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.mmaq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq003
            #add-point:ON ACTION controlp INFIELD mmaq003 name="construct.c.mmaq003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001_1()                    
            DISPLAY g_qryparam.return1 TO mmaq003 
            NEXT FIELD mmaq003  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq003
            #add-point:BEFORE FIELD mmaq003 name="construct.b.mmaq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq003
            
            #add-point:AFTER FIELD mmaq003 name="construct.a.mmaq003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq001
            #add-point:ON ACTION controlp INFIELD mmaq001 name="construct.c.mmaq001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_2()                     
            DISPLAY g_qryparam.return1 TO mmaq001  
            NEXT FIELD mmaq001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq001
            #add-point:BEFORE FIELD mmaq001 name="construct.b.mmaq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq001
            
            #add-point:AFTER FIELD mmaq001 name="construct.a.mmaq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq002
            #add-point:ON ACTION controlp INFIELD mmaq002 name="construct.c.mmaq002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                      
            DISPLAY g_qryparam.return1 TO mmaq002 
            NEXT FIELD mmaq002  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq002
            #add-point:BEFORE FIELD mmaq002 name="construct.b.mmaq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq002
            
            #add-point:AFTER FIELD mmaq002 name="construct.a.mmaq002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaq022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaq022
            #add-point:ON ACTION controlp INFIELD mmaq022 name="construct.c.mmaq022"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            IF s_aooi500_setpoint(g_prog,'mmaq022') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmaq022',g_site,'c')               
            ELSE               
               LET g_qryparam.where = " ooef150 = 'Y' "              
            END IF
            
            CALL q_ooef001_24() 
            DISPLAY g_qryparam.return1 TO mmaq022 
            NEXT FIELD mmaq022 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaq022
            #add-point:BEFORE FIELD mmaq022 name="construct.b.mmaq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaq022
            
            #add-point:AFTER FIELD mmaq022 name="construct.a.mmaq022"
            
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
            CALL ammp300_get_buffer(l_dialog)
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
         CALL ammp300_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.wc      = g_master.wc
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
                 CALL ammp300_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ammp300_transfer_argv(ls_js)
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
 
{<section id="ammp300.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ammp300_transfer_argv(ls_js)
 
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
 
{<section id="ammp300.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ammp300_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_where       STRING
   DEFINE l_sour        STRING
   DEFINE l_msg         STRING
   DEFINE l_cnt1        LIKE type_t.num10
   DEFINE l_cnt2        LIKE type_t.num10
   DEFINE l_point       LIKE mmar_t.mmar009
   DEFINE l_value       LIKE mmau_t.mmau009
   DEFINE l_value_cost  LIKE mmau_t.mmau014 
   DEFINE l_mmar011     LIKE mmar_t.mmar011,
          l_mmar012     LIKE mmar_t.mmar012
   DEFINE l_mmar        type_g_mmar
   DEFINE l_mmar_t      type_g_mmar
   DEFINE l_mmau007     LIKE mmau_t.mmau007, 
          l_mmau015     LIKE mmau_t.mmau015, 
          l_mmau008     LIKE mmau_t.mmau008, 
          l_mmau016     LIKE mmau_t.mmau016 
   DEFINE l_mmau        type_g_mmau
   DEFINE l_mmau_t      type_g_mmau
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #需要重計的會員卡
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = " 1=1 "
   END IF
   
   LET l_where = ""
   LET l_sour = ""
   
   CALL s_aooi500_sql_where(g_prog,'mmaq022') RETURNING l_where
   IF cl_null(l_where) THEN
      LET l_where = " 1=1 "
   END IF   
   
   LET l_sour = "SELECT mmaq001 ",
                "  FROM mmaq_t ",
                " WHERE mmaqent = ",g_enterprise,
                "   AND ",lc_param.wc,
                "   AND ",l_where   
  #DISPLAY "[Source] ",l_sour 
   
   #1.積點異常,需要重計積點的異動資訊
   #1.1.先取得積點紀錄異常的會員卡
   LET ls_sql = l_sour,
                " AND EXISTS(SELECT 1 FROM mmar_t ",
                "             WHERE mmarent = mmaqent AND mmar001 = mmaq001 ",
                "               AND (mmar011 IS NULL ",                                #異常1:期初積點餘額為空
                "                 OR mmar012 IS NULL ",                                #異常2:期未積點餘額為空
                "                 OR COALESCE(mmar011,0) + COALESCE(mmar009,0) <> COALESCE(mmar012,0) ",   #異常3:期初積點餘額+本次異動積點<>期未積點餘額
                "                   )) "   
  #DISPLAY "[ammp300_sel_card_1] ",ls_sql   
  
   #1.2.取得會員卡的所有積點異動紀錄
   LET ls_sql = "SELECT mmar001,mmar004,mmar005,mmarseq,mmar006, ",
                "       mmar009,mmar011,mmar012 ",
                "  FROM mmar_t ",
                " WHERE mmarent = ",g_enterprise,
                "   AND mmar001 IN (",ls_sql,")",
                " ORDER BY mmar001,mmar006,mmar004,mmar005 " 
  #DISPLAY "[ammp300_sel_mmar_pre] ",ls_sql             
   PREPARE ammp300_sel_mmar_pre FROM ls_sql
   DECLARE ammp300_sel_mmar_cur CURSOR FOR ammp300_sel_mmar_pre 

   #2.儲值異常,需要重計儲值的異動資訊
   #2.1.先取得儲值紀錄異常的會員卡
   LET ls_sql = l_sour,
                " AND EXISTS (SELECT 1 FROM mmau_t ",
                "              WHERE mmauent = mmaqent AND mmau001 = mmaq001 ",
                "                AND (mmau007 IS NULL ",                                #異常1:期初儲值金額為空
                "                  OR mmau015 IS NULL ",                                #異常2:期未儲值金額為空
                "                  OR (COALESCE(mmau007,0) + COALESCE(mmau009,0) + COALESCE(mmau012,0) + COALESCE(mmau013,0)) ",   #異常3:期初儲值金+本次儲值金額+本次加值金額+本次送抵現值金額<>期末儲值金額
                "                     <> COALESCE(mmau015,0) ",
                "                  OR mmau008 IS NULL ",                                #異常4:期初儲值成本為空
                "                  OR mmau016 IS NULL ",                                #異常5:期末儲值成本為空
                "                  OR (COALESCE(mmau008,0) + COALESCE(mmau014,0)) <> COALESCE(mmau016,0)",   #異常6:期初儲值成本+本次儲值成本<>期末儲值成本
                "                    )) "
  #DISPLAY "[ammp300_sel_card_2] ",ls_sql 
   
   #2.2.取得會員卡的所有儲值異動紀錄    
   LET ls_sql = "SELECT mmau001,mmau004,mmau005,mmauseq,mmau006, ",
                "       mmau007,mmau008,mmau009,mmau012,mmau013, ",
                "       mmau014,mmau015,mmau016 ",
                "  FROM mmau_t ",
                " WHERE mmauent = ",g_enterprise,
                "   AND mmau001 IN (",ls_sql,") ",
                " ORDER BY mmau001,mmau006,mmau004,mmau005 "                
  #DISPLAY "[ammp300_sel_mmau_pre] ",ls_sql             
   PREPARE ammp300_sel_mmau_pre FROM ls_sql
   DECLARE ammp300_sel_mmau_cur CURSOR FOR ammp300_sel_mmau_pre
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = 3
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ammp300_process_cs CURSOR FROM ls_sql
#  FOREACH ammp300_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #積點異常重計
   LET l_msg = cl_getmsg('amm-00794',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   
   LET l_point = 0
   LET l_mmar011 = 0
   LET l_mmar012 = 0
   INITIALIZE l_mmar.* TO NULL
   INITIALIZE l_mmar_t.* TO NULL
   
   FOREACH ammp300_sel_mmar_cur INTO l_mmar.mmar001,l_mmar.mmar004,l_mmar.mmar005,l_mmar.mmarseq,l_mmar.mmar006, 
                                     l_mmar.mmar009,l_mmar.mmar011,l_mmar.mmar012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Foreach(ammp300_sel_mmar_cur):"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_fail_exit = TRUE
         EXIT FOREACH
      END IF        
     
     IF l_mmar.mmar001 <> l_mmar_t.mmar001 OR cl_null(l_mmar_t.mmar001) THEN
        LET l_point = 0
     END IF
     
     IF cl_null(l_mmar.mmar009) THEN
        LET l_mmar.mmar009 = 0 
     END IF   
     
     #DISPLAY "卡:",l_mmar.mmar001,"(1)",l_mmar.mmar006," 期初: ",l_point," 異動: ",l_mmar.mmar009," 期末: ",l_mmar.mmar012
        
      LET l_mmar011 = l_point                      #期初積點餘額
      LET l_mmar012 = l_mmar011 + l_mmar.mmar009   #期未積點餘額=期初積點餘額+本次異動積點         
      
     #DISPLAY "卡:",l_mmar.mmar001,"(2)",l_mmar.mmar006," 期初: ",l_mmar011," 異動: ",l_mmar.mmar009," 期末: ",l_mmar012
       
      UPDATE mmar_t
         SET mmar011 = l_mmar011,
             mmar012 = l_mmar012
       WHERE mmarent = g_enterprise
         AND mmar001 = l_mmar.mmar001
         AND mmar004 = l_mmar.mmar004
         AND mmar005 = l_mmar.mmar005
         AND mmarseq = l_mmar.mmarseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "UPDATE mmar_t:",l_mmar.mmar001
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_fail_exit = TRUE
         EXIT FOREACH
      END IF  
      
      #備份
      LET l_point    = l_mmar012   #期未積點餘額
      LET l_mmar_t.* = l_mmar.*  
      #初始化
      LET l_mmar011 = 0
      LET l_mmar012 = 0       
      INITIALIZE l_mmar.* TO NULL        
   END FOREACH
   
   #儲值異常重計
   LET l_msg = cl_getmsg('amm-00795',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   
   LET l_value = 0
   LET l_value_cost = 0 
   LET l_mmau007 = 0
   LET l_mmau015 = 0
   LET l_mmau008 = 0
   LET l_mmau016 = 0
   INITIALIZE l_mmau.* TO NULL
   INITIALIZE l_mmau_t.* TO NULL
   
   FOREACH ammp300_sel_mmau_cur INTO l_mmau.mmau001,l_mmau.mmau004,l_mmau.mmau005,l_mmau.mmauseq,l_mmau.mmau006,
                                     l_mmau.mmau007,l_mmau.mmau008,l_mmau.mmau009,l_mmau.mmau012,l_mmau.mmau013,
                                     l_mmau.mmau014,l_mmau.mmau015,l_mmau.mmau016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Foreach(ammp300_sel_mmau_cur):"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_fail_exit = TRUE
         EXIT FOREACH
      END IF

     IF l_mmau.mmau001 <> l_mmau_t.mmau001 OR cl_null(l_mmau_t.mmau001) THEN
        LET l_value = 0
        LET l_value_cost = 0
     END IF
     
     IF cl_null(l_mmau.mmau009) THEN      LET l_mmau.mmau009 = 0      END IF
     IF cl_null(l_mmau.mmau012) THEN      LET l_mmau.mmau012 = 0      END IF
     IF cl_null(l_mmau.mmau013) THEN      LET l_mmau.mmau013 = 0      END IF
     IF cl_null(l_mmau.mmau014) THEN      LET l_mmau.mmau014 = 0      END IF
     #DISPLAY "卡:",l_mmau.mmau001,"(1)",l_mmau.mmau006," 期初: ",l_value," 異動: ",l_mmau.mmau009," 加值: ",l_mmau.mmau012," 送抵: ",l_mmau.mmau013," 期末: ",l_mmau.mmau015

     #期初儲值金額
     LET l_mmau007 = l_value                                 
     
     #期未儲值金額=期初儲值金額+本次儲值金額+本次加值金額+本次送抵現值金額
     LET l_mmau015 = l_mmau007 + l_mmau.mmau009 + l_mmau.mmau012 + l_mmau.mmau013 
     
     #期初儲值成本
     LET l_mmau008  = l_value_cost   
     
     #期末儲值成本=期初儲值成本+本次儲值成本
     LET l_mmau016  = l_mmau008 + l_mmau.mmau014  

     #DISPLAY "卡:",l_mmau.mmau001,"(2)",l_mmau.mmau006," 期初: ",l_mmau007," 異動: ",l_mmau.mmau009," 加值: ",l_mmau.mmau012," 送抵: ",l_mmau.mmau013," 期末: ",l_mmau015


      UPDATE mmau_t
         SET mmau007 = l_mmau007,
             mmau008 = l_mmau008,
             mmau015 = l_mmau015,
             mmau016 = l_mmau016
       WHERE mmauent = g_enterprise
         AND mmau001 = l_mmau.mmau001
         AND mmau004 = l_mmau.mmau004
         AND mmau005 = l_mmau.mmau005
         AND mmauseq = l_mmau.mmauseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "UPDATE mmau_t:",l_mmau.mmau001
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET g_fail_exit = TRUE
         EXIT FOREACH
      END IF  
      
      #備份
      LET l_mmau_t.*   = l_mmau.* 
      LET l_value      = l_mmau015    #期未儲值金額  
      LET l_value_cost = l_mmau016    #期末儲值成本       
      #初始化      
      LET l_mmau007 = 0
      LET l_mmau015 = 0
      LET l_mmau008 = 0
      LET l_mmau016 = 0      
      INITIALIZE l_mmau.* TO NULL      
   END FOREACH
   
   CALL cl_err_collect_show()
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   
   IF g_fail_exit THEN
      CALL s_transaction_end('N',0)
      RETURN
   END IF   
   
   CALL s_transaction_end('Y',0)
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
   CALL ammp300_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ammp300.get_buffer" >}
PRIVATE FUNCTION ammp300_get_buffer(p_dialog)
 
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
 
{<section id="ammp300.msgcentre_notify" >}
PRIVATE FUNCTION ammp300_msgcentre_notify()
 
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
 
{<section id="ammp300.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
