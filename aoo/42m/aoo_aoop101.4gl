#該程式未解開Section, 採用最新樣板產出!
{<section id="aoop101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-03-05 10:34:54), PR版次:0010(2016-10-08 17:35:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: aoop101
#+ Description: 營運組織申請批次更新作業
#+ Creator....: 02749(2014-07-21 17:39:56)
#+ Modifier...: 02749 -SD/PR- 05423
 
{</section>}
 
{<section id="aoop101.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160331-00026#1   2016/04/01  By Ann_Huang  檢核是否於生效日期有作廢或未生效的單據, 不應將where條件取消，故該段之被mark的where條件加回來
#161005-00014#1   2016/10/08  By zhujing    新增及修改時, 若為法人組織者,則一併勾選【結算織織、資金組織、資產組織、預算組織】
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
   oojldocno LIKE oojl_t.oojldocno,   #申請單號
   oojlsite  LIKE oojl_t.oojlsite,    #申請組織
   oojl004   LIKE oojl_t.oojl004,     #申請部門
   oojl003   LIKE oojl_t.oojl003,     #申請人員
   oojl002   LIKE oojl_t.oojl002,     #異動生效日
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       oojldocno LIKE oojl_t.oojldocno, 
   oojlsite LIKE oojl_t.oojlsite, 
   oojl004 LIKE oojl_t.oojl004, 
   oojl003 LIKE oojl_t.oojl003, 
   oojl002 LIKE oojl_t.oojl002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
                  
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
   #argv[1] oojl_t.oojldocno   #申請單號
   #argv[2] oojl_t.oojlsite    #申請組織
   #argv[3] oojl_t.oojl004     #申請部門
   #argv[4] oojl_t.oojl003     #申請人員
   #argv[5] oojl_t.oojl002     #異動生效日
   #argv[6] type_t.chr1        #是否由aoot101呼叫背景執行
#end add-point
 
{</section>}
 
{<section id="aoop101.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aoo","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
#150710-00014#1 20150713 mark by beckxie---S
#   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
#   LET g_argv[2] = cl_replace_str(g_argv[2], '\"', '')
#   LET g_argv[3] = cl_replace_str(g_argv[3], '\"', '')
#   LET g_argv[4] = cl_replace_str(g_argv[4], '\"', '')
#   LET g_argv[5] = cl_replace_str(g_argv[5], '\"', '')
#   LET g_argv[6] = cl_replace_str(g_argv[6], '\"', '')
#   
#   DISPLAY 'g_argv[1]',g_argv[1]
#   DISPLAY 'g_argv[2]',g_argv[2]
#   DISPLAY 'g_argv[3]',g_argv[3]
#   DISPLAY 'g_argv[4]',g_argv[4]
#   DISPLAY 'g_argv[5]',g_argv[5]
#   DISPLAY 'g_argv[6]',g_argv[6]
#   
#   LET lc_param.oojldocno = g_argv[1]
#   LET lc_param.oojlsite  = g_argv[2]
#   LET lc_param.oojl004   = g_argv[3]
#   LET lc_param.oojl003   = g_argv[4]
#   LET lc_param.oojl002   = g_argv[5] 

#   IF g_argv[6] = 'Y' THEN
#      LET g_bgjob = "Y"
#      LET lc_param.wc = NULL
#   END IF
#150710-00014#1 20150713 mark by beckxie---E
   LET ls_js = util.JSON.stringify(lc_param)
   
   #150710-00014#1 20150713 add by beckxie
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add

   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
#      IF g_argv[6] = 'Y' THEN
#         LET g_bgjob = 'N'
#      END IF
      #end add-point
      CALL aoop101_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aoop101 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aoop101_init()
 
      #進入選單 Menu (="N")
      CALL aoop101_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aoop101
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aoop101.init" >}
#+ 初始化作業
PRIVATE FUNCTION aoop101_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
   #150710-00014#1 20150713 mark by beckxie
#   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aoop101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aoop101_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.oojl002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojl002
            #add-point:BEFORE FIELD oojl002 name="input.b.oojl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojl002
            
            #add-point:AFTER FIELD oojl002 name="input.a.oojl002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oojl002
            #add-point:ON CHANGE oojl002 name="input.g.oojl002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.oojl002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojl002
            #add-point:ON ACTION controlp INFIELD oojl002 name="input.c.oojl002"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON oojldocno,oojlsite,oojl004,oojl003
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.oojldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojldocno
            #add-point:ON ACTION controlp INFIELD oojldocno name="construct.c.oojldocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojldocno_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojldocno  #顯示到畫面上
            NEXT FIELD oojldocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojldocno
            #add-point:BEFORE FIELD oojldocno name="construct.b.oojldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojldocno
            
            #add-point:AFTER FIELD oojldocno name="construct.a.oojldocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojlsite
            #add-point:BEFORE FIELD oojlsite name="construct.b.oojlsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojlsite
            
            #add-point:AFTER FIELD oojlsite name="construct.a.oojlsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oojlsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojlsite
            #add-point:ON ACTION controlp INFIELD oojlsite name="construct.c.oojlsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'oojlsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO oojlsite          #顯示到畫面上
            NEXT FIELD oojlsite                             #返回原欄位  
            #END add-point
 
 
         #Ctrlp:construct.c.oojl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojl004
            #add-point:ON ACTION controlp INFIELD oojl004 name="construct.c.oojl004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojl004  #顯示到畫面上
            NEXT FIELD oojl004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojl004
            #add-point:BEFORE FIELD oojl004 name="construct.b.oojl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojl004
            
            #add-point:AFTER FIELD oojl004 name="construct.a.oojl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oojl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oojl003
            #add-point:ON ACTION controlp INFIELD oojl003 name="construct.c.oojl003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO oojl003  #顯示到畫面上
            NEXT FIELD oojl003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oojl003
            #add-point:BEFORE FIELD oojl003 name="construct.b.oojl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oojl003
            
            #add-point:AFTER FIELD oojl003 name="construct.a.oojl003"
            
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
            CALL aoop101_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.oojl002 = g_today
            DISPLAY BY NAME g_master.oojl002 
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
         CALL aoop101_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.oojldocno = g_master.oojldocno
      LET lc_param.oojlsite  = g_master.oojlsite 
      LET lc_param.oojl004   = g_master.oojl004  
      LET lc_param.oojl003   = g_master.oojl003
#      IF g_schedule.gzpa003 = "3" THEN
#         LET lc_param.oojl002 = g_today
#      ELSE      
         LET lc_param.oojl002 = g_master.oojl002 
#      END IF
      LET lc_param.wc        = g_master.wc
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
                 CALL aoop101_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aoop101_transfer_argv(ls_js)
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
 
{<section id="aoop101.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aoop101_transfer_argv(ls_js)
 
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
 
{<section id="aoop101.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aoop101_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_source_sql   STRING
   DEFINE l_sub_sql      STRING
   DEFINE l_doc_list     STRING
   DEFINE l_err_doc_sql  STRING
   DEFINE l_err_cnt      LIKE type_t.num5
   DEFINE l_oojlmoddt    LIKE oojl_t.oojlmoddt
   DEFINE l_wc           STRING
   DEFINE l_oojm001      LIKE oojm_t.oojm001
   DEFINE l_oofb001_t    LIKE oofb_t.oofb001
   DEFINE l_oofb002_t    LIKE oofb_t.oofb002
   DEFINE l_oofb001      LIKE oofb_t.oofb001
   DEFINE l_oofb002      LIKE oofb_t.oofb002
   DEFINE l_oofc001_t    LIKE oofc_t.oofc001
   DEFINE l_oofc001      LIKE oofc_t.oofc001
   DEFINE l_ooef012      LIKE ooef_t.ooef012
   DEFINE l_oojl000      LIKE oojl_t.oojl000
   DEFINE l_oojl001      LIKE oojl_t.oojl001
   DEFINE l_oojldocno    LIKE oojl_t.oojldocno
   DEFINE l_oojlstus     LIKE oojl_t.oojlstus
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_where        STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_str          STRING         #150817-00027#1--add by dongsz
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_err_cnt = 0       #錯誤次數
   
   #判斷是否由aoot101呼叫
   CALL cl_err_collect_init()   #錯誤訊息清單初始化
   
   #LET l_where = s_aooi500_sql_where(g_prog,'oojlsite')
   
   #1.檢查是否有異動生效日期之前未作廢且未更新的單據, 如果有列成錯誤清單並show錯誤訊息  
   IF aoop101_chk_unupd_doc() THEN
      CALL s_transaction_begin()
      
      #將本次需要進行處理但已作廢或已確認未更新的單據列出(組SQL)
      LET l_err_doc_sql = "SELECT oojldocno,oojlstus ",
                          "  FROM oojm_t,oojl_t ",
                          " WHERE oojment = oojlent ",
                          "   AND oojmdocno = oojldocno ",           
                          "   AND oojl002 = '",lc_param.oojl002,"' ",
                          "   AND (oojlstus = 'Y' AND oojl005 = 'Y')"
                          #"   AND (oojlstus = 'X' OR (oojlstus = 'Y' AND oojl005 = 'Y')) "
      #將本次需要進行處理的單據列出(組SQL)
      LET l_source_sql = "  FROM oojm_t,oojl_t ",
                         " WHERE oojment = oojlent ",
                         "   AND oojmdocno = oojldocno ",                     
                         "   AND oojl002 = '",lc_param.oojl002,"' ",
                         "   AND oojlstus = 'Y' ",  
                         "   AND oojl005 = 'N' "
      IF NOT cl_null(lc_param.wc) THEN
         LET l_err_doc_sql = l_err_doc_sql,
                             " AND ",lc_param.wc   
      
         LET l_source_sql =  l_source_sql,
                             " AND ",lc_param.wc
      END IF
      
      LET l_err_doc_sql = l_err_doc_sql CLIPPED
      LET l_source_sql = l_source_sql CLIPPED
      
      IF g_argv[6] = 'Y' THEN
         LET l_err_doc_sql = l_err_doc_sql,
                             " AND oojldocno = '",lc_param.oojldocno,"' "      
      
         LET l_source_sql =  l_source_sql,
                             " AND oojldocno = '",lc_param.oojldocno,"' "
      END IF
      
#      #1.1.將本次要更新的單據但狀態有問題者
#      PREPARE aoop101_err_pre FROM l_err_doc_sql
#      DECLARE aoop101_err_cur CURSOR FOR aoop101_err_pre
#      FOREACH aoop101_err_cur INTO l_oojldocno,l_oojlstus
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = "Foreach aoop101_err_cur："
#            LET g_errparam.code   = SQLCA.sqlcode
#            CALL cl_err() 
#         END IF
#
#         LET l_err_cnt = l_err_cnt + 1
#         
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_oojldocno
#         
#         IF l_oojlstus = 'X' THEN
#            LET g_errparam.code   = "aoo-00626"
#         END IF
#         
#         IF l_oojlstus = 'Y' THEN
#            LET g_errparam.code   = "aoo-00627"
#         END IF
#         
#         CALL cl_err() 
#      END FOREACH
      
      
      #2.更新組織多語言資料檔:已存在時Update,不存在時Insert
      LET ls_sql = "MERGE INTO (SELECT ooeflent,ooefl001,ooefl002,ooefl003,ooefl004, ",
                   "                   ooefl005,ooefl006 ",
                   "              FROM ooefl_t) a ",
                   "     USING (SELECT oojmlent,oojml001,oojml002,oojml003,oojml004, ",
                   "                   oojml005,oojml006 ",
                   "              FROM oojml_t ",
                   "             WHERE EXISTS(SELECT oojm001 ",l_source_sql,
                   "                             AND oojmdocno = oojmldocno ",
                   "                             AND oojm001 = oojml001 ))b ",
                   "        ON (    a.ooeflent = b.oojmlent ",
                   "            AND a.ooefl001 = b.oojml001 ",
                   "            AND a.ooefl002 = b.oojml002 ) ",
                   "WHEN MATCHED THEN UPDATE SET a.ooefl003 = b.oojml003 , a.ooefl004 = b.oojml004, ",
                   "                             a.ooefl005 = b.oojml006 , a.ooefl006 = b.oojml005  ",
                   "WHEN NOT MATCHED THEN INSERT VALUES (b.oojmlent,b.oojml001,b.oojml002,b.oojml003,b.oojml004, ",
                   "                                     b.oojml006,b.oojml005) "
      PREPARE aoop101_ins_ooefl FROM ls_sql
      EXECUTE aoop101_ins_ooefl
      IF SQLCA.sqlcode THEN
         DISPLAY "aoop101-Ins. ooefl_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Insert ooefl_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err()
      ELSE
         DISPLAY "aoop101-Insert ooefl_t Success!"
      END IF
      
      #3.更新銷售範圍基本資料檔:已存在時Update,不存在時Insert
      LET ls_sql = "MERGE INTO (SELECT dbbcent  ,dbbc001 ,dbbc002 ,dbbc003, dbbc004, ",
                   "                   dbbc005  , ",
                   "                   dbbcownid,dbbcowndp, ",
                   "                   dbbccrtid,dbbccrtdp,dbbccrtdt, ",
                   "                   dbbcmodid,dbbcmoddt,dbbcstus ",
                   "              FROM dbbc_t) a ",
                   "     USING (SELECT oojm001  , oojm401  , oojm402  , oojm403, oojm404, ",
                   "                   oojmacti , oojlent  , oojlownid, oojlowndp, oojl002, ",
                   "                   oojlcrtid, oojlcrtdp, oojlcrtdt, ",
                   "                   oojlmodid, oojlmoddt ",l_source_sql,
                   "               AND oojl001 = '3' ) b ",
                   "        ON (    a.dbbcent = b.oojlent ",
                   "            AND a.dbbc001 = b.oojm001) ",
                   "WHEN MATCHED THEN UPDATE SET a.dbbc002   = b.oojm401   , a.dbbc003   = b.oojm402 , ",
                   "                             a.dbbc004   = b.oojm403   , a.dbbc005   = b.oojm404 , ",
                   "                             a.dbbcstus  = b.oojmacti ",
                   "WHEN NOT MATCHED THEN INSERT VALUES (b.oojlent  ,b.oojm001 ,b.oojm401 ,b.oojm402 , b.oojm403, ",
                   "                                     b.oojm404  , ",
                   "                                     b.oojlownid,b.oojlowndp, ",
                   "                                     b.oojlcrtid,b.oojlcrtdp,b.oojl002, ",
                   "                                     '','',b.oojmacti) "
      PREPARE aoop101_ins_dbbc FROM ls_sql
      EXECUTE aoop101_ins_dbbc
      IF SQLCA.sqlcode THEN
         #DISPLAY "aoop101-Ins. dbbc_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Insert dbbc_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err()  
      ELSE
         DISPLAY "aoop101-Insert dbbc_t Success!"      
      END IF
      
      #4.更新銷售範圍基本資料檔:已存在時Update,不存在時Insert
      LET ls_sql = "MERGE INTO (SELECT dbbclent,dbbcl001,dbbcl002,dbbcl003,dbbcl004 ",
                   "              FROM dbbcl_t) a ",
                   "     USING (SELECT oojmlent,oojml001,oojml002,oojml003,oojml006 ",
                   "              FROM oojml_t ",
                   "             WHERE EXISTS(SELECT oojm001 ",l_source_sql,
                   "                             AND oojm001 = oojml001 ",
                   "                             AND oojl001 = '3')) b ",
                   "        ON (    a.dbbclent = b.oojmlent ",
                   "            AND a.dbbcl001 = b.oojml001 ",
                   "            AND a.dbbcl002 = b.oojml002 ) ",
                   "WHEN MATCHED THEN UPDATE SET a.dbbcl003 = b.oojml003 , a.dbbcl004 = b.oojml006 ",
                   "WHEN NOT MATCHED THEN INSERT VALUES (b.oojmlent,b.oojml001,b.oojml002,b.oojml003,b.oojml006) "
      PREPARE aoop101_ins_dbbcl FROM ls_sql
      EXECUTE aoop101_ins_dbbcl
      IF SQLCA.sqlcode THEN
         #DISPLAY "aoop101-Ins. dbbcl_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1

         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Insert dbbcl_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err() 
      ELSE
         DISPLAY "aoop101-Insert dbbcl_t Success!"      
      END IF
      
      #6-1.當為狀態 = 'U'修改的單據，將原識別碼(ooef012)的地址資料清除
      LET ls_sql = "DELETE FROM oofb_t ",
                   "      WHERE oofbent = ",g_enterprise,
                   "        AND oofb002 IN (SELECT ooef012 FROM ooef_t ",
                   "                         WHERE ooefent = ",g_enterprise,
                   "                           AND ooef001 IN ( SELECT oojm001 ",l_source_sql,
                   "                                               AND oojl000 = 'U' ))"
      PREPARE aoop101_del_oofb FROM ls_sql
      EXECUTE aoop101_del_oofb
      IF SQLCA.sqlcode THEN
         #DISPLAY "aoop101-Del. oofb_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Delete oofb_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err() 
      ELSE
         DISPLAY "aoop101-Delete oofb_t Success!"      
      END IF
      #5-2.當為狀態 = 'U'修改的單據，將原識別碼(ooef012)的聯絡方式清除
      LET ls_sql = "DELETE FROM oofc_t ",
                   "      WHERE oofcent = ",g_enterprise,
                   "        AND oofc002 IN (SELECT ooef012 FROM ooef_t ",
                   "                         WHERE ooefent = ",g_enterprise,
                   "                           AND ooef001 IN ( SELECT oojm001 ",l_source_sql,
                   "                                               AND oojl000 = 'U' ))"
      PREPARE aoop101_del_oofc FROM ls_sql
      EXECUTE aoop101_del_oofc
      IF SQLCA.sqlcode THEN
         #DISPLAY "aoop101-Del. oofc_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Delete oofc_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err()       
      ELSE
         DISPLAY "aoop101-Delete oofc_t Success!"      
      END IF
      
      #6.準備SQL
      #6-1.更新聯絡對象相關table資料
      LET ls_sql = "SELECT oojl000,oojl001,oojldocno,oojm012,oojm001,ooef012",
                   "  FROM oojl_t,oojm_t",
                   "  LEFT JOIN ooef_t ON oojment = ooefent AND oojm001 = ooef001",
                   " WHERE oojment = ",g_enterprise,
                   "   AND oojment = oojlent ",
                   "   AND oojmdocno = oojldocno ",
                   "   AND oojl002 = '",lc_param.oojl002,"' ",
                   "   AND oojlstus = 'Y' ",
                   "   AND oojl005 <> 'Y' "
      IF NOT cl_null(lc_param.wc) THEN                     
         LET ls_sql = ls_sql,"   AND ",lc_param.wc
      END IF
      IF g_argv[6] = 'Y' THEN
         LET ls_sql =  ls_sql," AND oojldocno = '",lc_param.oojldocno,"'"
      END IF
      PREPARE aoop101_sel_oojm_pre FROM ls_sql
      DECLARE aoop101_sel_oojm_curs CURSOR FOR aoop101_sel_oojm_pre
      
      #6-2.準備新增基本組織檔(ooef_t)SQL
      #6-2-1.確認要新增的組織代碼沒有存在基本組織檔(ooef_t)
      LET ls_sql = "SELECT COUNT(ooef001)",
                   "  FROM ooef_t",
                   " WHERE ooefent = ",g_enterprise,
                   "   AND ooef001 = ?"
      PREPARE aoop101_chk_ooef FROM ls_sql
      #6-2-2.準備新增基本組織檔(ooef_t)SQL
      LET ls_sql = "INSERT INTO ooef_t(ooefent  ,ooefstus ,ooefunit, ",                    #150501-00004#1 150502 by lori522612 add ooefunit
                   "                   ooef001  ,ooef002  ,ooef003 ,ooef004 ,ooef005 ,",
                   "                   ooef006  ,ooef007  ,ooef008 ,ooef009 ,ooef010 ,",
                   "                   ooef011  ,ooef012  ,ooef013 ,ooef014 ,ooef015 ,",
                   "                   ooef016  ,ooef017  ,ooef018 ,ooef019 ,ooef020 ,",
                   "                   ooef021  ,ooef022  ,ooef023 ,ooef024 ,ooef025 ,",
                   "                   ooef200  ,ooef201  ,ooef202 ,ooef203 ,ooef204 ,",
                   "                   ooef205  ,ooef206  ,ooef207 ,ooef208 ,ooef209 ,",
                   "                   ooef210  ,ooef211  ,ooef212 ,ooef301 ,ooef302 ,",
                   "                   ooef303  ,ooef304  ,ooef305 ,",
                   "                   ooef123  ,ooef126  ,ooef124 ,ooef127 ,ooef125 ,",   #sakura add
                   "                   ooef128  ,",                                        #sakura add
                   "                   ooefownid,ooefowndp,",
                   "                   ooefcrtid,ooefcrtdp,ooefcrtdt,",
                   "                   ooefmodid,ooefmoddt)",
                   " SELECT oojlent  ,oojmacti , oojlsite, ",                              #150501-00004#1 150502 by lori522612 add oojlsite
                   "        oojm001  ,oojm002  ,oojm003 ,oojm004 ,oojm005 ,",
                   "        oojm006  ,oojm007  ,oojm008 ,oojm009 ,oojm010 ,",
                   "        oojm011  ,?        ,oojm013 ,oojm014 ,oojm015 ,",
                   "        oojm016  ,oojm017  ,oojm018 ,oojm019 ,oojm020 ,",
                   "        oojm021  ,oojm022  ,oojm023 ,oojm024 ,oojm025 ,",
#                   "        oojm200  ,oojm201  ,oojm202 ,oojm203 ,oojm204 ,",          #161005-00014#2 marked
#                   "        oojm205  ,oojm206  ,oojm207 ,oojm208 ,oojm209 ,",          #161005-00014#2 marked
                   "        oojm200  ,oojm201  ,oojm202 ,oojm203 ,DECODE(oojm003,'Y','Y','N') oojm204 ,",          #161005-00014#2 add
                   "        DECODE(oojm003,'Y','Y','N') oojm205  ,DECODE(oojm003,'Y','Y','N') oojm206 ,",
                   "        DECODE(oojm003,'Y','Y','N') oojm207  ,oojm208 ,oojm209 ,",          #161005-00014#2 add
                   "        oojm210  ,oojm211  ,oojm212 ,oojm301 ,oojm302 ,",
                   "        oojm303  ,oojm304  ,oojm305 ,",
                   "        oojm405  ,oojm408  ,oojm406 ,oojm409 ,oojm407 ,", #sakura add
                   "        oojm410  ,", #sakura add
                   "        oojlownid,oojlowndp,",
                   "        oojlcrtid,oojlcrtdp,oojl002,",
                   "        '',''",
                   "   FROM oojl_t,oojm_t",
                   "  WHERE oojment = oojlent",
                   "    AND oojmdocno = oojldocno",
                   "    AND oojment = ",g_enterprise,
                   "    AND oojmdocno = ?",
                   "    AND oojm001 = ?"
      PREPARE aoop101_ins_ooef FROM ls_sql
      
      #6-3.準備更新基本組織檔(ooef_t)SQL
      #6-3-1.aoot101 更新基本組織檔(ooef_t)
      LET ls_sql = " UPDATE ooef_t SET( ",
                   "        ooefstus ,ooef002  ,ooef003 ,ooef004 ,ooef005 , ",
                   "        ooef006  ,ooef007  ,ooef008 ,ooef009 ,ooef010 , ",
                   "        ooef011  ,ooef012  ,ooef013 ,ooef014 ,ooef015 , ",
                   "        ooef016  ,ooef017  ,ooef018 ,ooef019 ,ooef020 , ",
                   "        ooef021  ,ooef022  ,ooef023 ,ooef024 ,ooef025 , ",
                   "        ooef200  ,ooef201  ,ooef208 ,ooef210 , ",
                   "        ooef211  ,ooef212  , ",
                   "        ooef123  ,ooef126  ,ooef124 ,ooef127 ,ooef125 , ", #sakura add
                   "        ooef128  , ",                                      #sakura add
                   #161005-00014#2 add-S
                   "        ooef204  ,ooef205  ,ooef206 ,ooef207,",
                   #161005-00014#2 add-E
                   "        ooefmodid,ooefmoddt ) = ",
                   "        ((SELECT oojmacti ,oojm002 ,oojm003 ,oojm004 ,oojm005 , ",
                   "                 oojm006  ,oojm007 ,oojm008 ,oojm009 ,oojm010 , ",
                   "                 oojm011  ,?       ,oojm013 ,oojm014 ,oojm015 , ",
                   "                 oojm016  ,oojm017 ,oojm018 ,oojm019 ,oojm020 , ",
                   "                 oojm021  ,oojm022 ,oojm023 ,oojm024 ,oojm025 , ",
                   "                 oojm200  ,oojm201 ,oojm208 ,oojm210 , ",
                   "                 oojm211  ,oojm212 , ",
                   "                 oojm405  ,oojm408  ,oojm406 ,oojm409 ,oojm407 ,", #sakura add
                   "                 oojm410  ,",                                      #sakura add      
                   #161005-00014#2 add-S
                   "                 DECODE(oojm003,'Y','Y','N') oojm204 ,",
                   "                 DECODE(oojm003,'Y','Y','N') oojm205 ,",
                   "                 DECODE(oojm003,'Y','Y','N') oojm206 ,",
                   "                 DECODE(oojm003,'Y','Y','N') oojm207 ,",
                   #161005-00014#2 add-E                   
                   "                 oojlmodid,oojl002 ",
                   "            FROM oojl_t,oojm_t",
                   "           WHERE oojment = oojlent",
                   "             AND oojmdocno = oojldocno",
                   "             AND oojment = ",g_enterprise,
                   "             AND oojmdocno = ?",
                   "             AND oojm001 = ?))",
                   " WHERE ooefent = ",g_enterprise,
                   "   AND ooef001 = ?"
      PREPARE aoop101_upd_ooef_1 FROM ls_sql
#      DISPLAY 'aoop101_upd_ooef_1 SQL:',ls_sql
      #6-3-2.aoot102 更新基本組織檔(ooef_t)
      LET ls_sql = " UPDATE ooef_t SET( ",
                   "        ooefstus ,ooef003 ,ooef012, ooef017, ooef200 , ",
                   "        ooef305  ,ooefmodid,ooefmoddt ) = ",
                   "        ((SELECT oojmacti ,oojm003   ,?       ,oojm017 ,oojm200 , ",
                   "                 oojm305  ,oojlmodid ,oojl002 ",
                   "            FROM oojl_t,oojm_t",
                   "           WHERE oojment = oojlent",
                   "             AND oojmdocno = oojldocno",
                   "             AND oojment = ",g_enterprise,
                   "             AND oojmdocno = ?",
                   "             AND oojm001 = ?))",
                   " WHERE ooefent = ",g_enterprise,
                   "   AND ooef001 = ?"
      PREPARE aoop101_upd_ooef_2 FROM ls_sql
#      DISPLAY 'aoop101_upd_ooef_2 SQL:',ls_sql
      #6-3-3.aoot103 更新基本組織檔(ooef_t)
      LET ls_sql = " UPDATE ooef_t SET( ",
                   "        ooefstus ,ooef003 , ooef200 ,ooef209 ,",
                   "        ooefmodid,ooefmoddt ) = ",
                   "        ((SELECT oojmacti ,oojm003 ,oojm200 ,oojm209 , ",
                   "                 oojlmodid,oojl002",
                   "            FROM oojl_t,oojm_t",
                   "           WHERE oojment = oojlent",
                   "             AND oojmdocno = oojldocno",
                   "             AND oojment = ",g_enterprise,
                   "             AND oojmdocno = ?",
                   "             AND oojm001 = ?))",
                   " WHERE ooefent = ",g_enterprise,
                   "   AND ooef001 = ?"
      PREPARE aoop101_upd_ooef_3 FROM ls_sql
#      DISPLAY 'aoop101_upd_ooef_3 SQL:',ls_sql
      
      #6-4.準備聯絡地址及通訊方式SQL
      LET ls_sql = "SELECT oofb001 FROM oofb_t",
                   " WHERE oofbent = ",g_enterprise,
                   "   AND oofb002 = ?"
      PREPARE aoop101_sel_oofb_pre FROM ls_sql
      DECLARE aoop101_sel_oofb_curs CURSOR FOR aoop101_sel_oofb_pre
      LET ls_sql = "SELECT oofc001 FROM oofc_t",
                   " WHERE oofcent = ",g_enterprise,
                   "   AND oofc002 = ?"
      PREPARE aoop101_sel_oofc_pre FROM ls_sql
      DECLARE aoop101_sel_oofc_curs CURSOR FOR aoop101_sel_oofc_pre
      
      #7.把單據相關的資料撈取出來
      FOREACH aoop101_sel_oojm_curs INTO l_oojl000,l_oojl001,l_oojldocno,l_oofb002_t,l_oojm001,l_ooef012
         IF SQLCA.sqlcode THEN
            LET l_err_cnt = l_err_cnt + 1
            
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "Foreach aoop101_sel_oojm_curs："
            LET g_errparam.code   = SQLCA.sqlcode
            CALL cl_err() 
            
            EXIT FOREACH
         END IF
         
         #7-1.當基本組織檔裡面的聯絡對象識別碼為空，就重新取得聯絡對象識別碼
         IF cl_null(l_ooef012) AND (l_oojl001 = '1' OR l_oojl001 = '2')THEN
            LET l_oofb002 = ''
            CALL s_aooi350_ins_oofa('1',l_oojm001,'') RETURNING l_success,l_oofb002
            IF NOT l_success THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "s_aooi350_ins_oofa Error!"
               LET g_errparam.code   = "sub-00034"
               CALL cl_err()  
            END IF
         ELSE
            LET l_oofb002 = l_ooef012
         END IF
         
         #6-4.當單據異動類型 = 'I'新增時，對組織基本資料檔新增
         #    當單據異動類型 = 'U'修改時，對組織基本資料檔更新
         CASE l_oojl000
            WHEN 'I'
               #當要新增的組織編號已經存在基本組織檔中(ooef_t)不可以新增
               LET l_cnt = 0
               EXECUTE aoop101_chk_ooef USING l_oojm001 INTO l_cnt
               IF l_cnt = 0 THEN
                  EXECUTE aoop101_ins_ooef USING l_oofb002,l_oojldocno,l_oojm001
                  IF SQLCA.sqlcode THEN
                     LET l_err_cnt = l_err_cnt + 1
                     
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "aoop101_ins_ooef Error!"
                     LET g_errparam.code   = SQLCA.sqlcode
                     CALL cl_err()    
                     
                     EXIT FOREACH
                  END IF
                  #160511-00037#8 20160519 mark by beckxie---S
                  ##150817-00027#1--add by dongsz--s
                  #LET l_str = " ooef001 = '",l_oojm001,"' "
                  #CALL s_pmab_ins(l_str,'') RETURNING l_success
                  #IF NOT l_success THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'sub-00034'
                  #   LET g_errparam.extend = "ins pmab"
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET l_err_cnt = l_err_cnt + 1
                  #   EXIT FOREACH
                  #END IF
                  ##150817-00027#1--add by dongsz--e
                  #160511-00037#8 20160519 mark by beckxie---E
               ELSE
                  LET l_err_cnt = l_err_cnt + 1
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "aoo-00411"
                  LET g_errparam.replace[1] = l_oojm001
                  CALL cl_err()
                  EXIT FOREACH
               END IF
            WHEN 'U'
               CASE l_oojl001
                  WHEN '1'
                     EXECUTE aoop101_upd_ooef_1
                       USING l_oofb002,l_oojldocno,l_oojm001,l_oojm001
                     IF SQLCA.sqlcode THEN
                        LET l_err_cnt = l_err_cnt + 1
                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "aoop101_upd_ooef_1 Error!"
                        LET g_errparam.code   = SQLCA.sqlcode
                        CALL cl_err() 
                        
                        EXIT FOREACH
                     END IF
                  WHEN '2'
                     EXECUTE aoop101_upd_ooef_2
                       USING l_oofb002,l_oojldocno,l_oojm001,l_oojm001
                     DISPLAY 'oofb002 = ',l_oofb002
                     DISPLAY 'oojldocno = ',l_oojldocno
                     DISPLAY 'oojm001 = ',l_oojm001
                     IF SQLCA.sqlcode THEN
                        LET l_err_cnt = l_err_cnt + 1
                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "aoop101_upd_ooef_2 Error!"
                        LET g_errparam.code   = SQLCA.sqlcode
                        CALL cl_err()   
                        
                        EXIT FOREACH
                     END IF
                  WHEN '3'
                     EXECUTE aoop101_upd_ooef_3
                       USING l_oojldocno,l_oojm001,l_oojm001
                     IF SQLCA.sqlcode THEN
                        LET l_err_cnt = l_err_cnt + 1
                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "aoop101_upd_ooef_3 Error!"
                        LET g_errparam.code   = SQLCA.sqlcode
                        CALL cl_err()
                        
                        EXIT FOREACH
                     END IF
               END CASE
         END CASE
         
         #7.1.更新聯絡地址
         FOREACH aoop101_sel_oofb_curs USING l_oofb002_t INTO l_oofb001_t
            IF SQLCA.sqlcode THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "Foreach aoop101_sel_oofb_curs："
               LET g_errparam.code   = SQLCA.sqlcode
               CALL cl_err() 
               
               EXIT FOREACH
            END IF
            
            LET l_wc = " oofbent = ",g_enterprise
            CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
               RETURNING l_success,l_oofb001
            IF NOT l_success THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "aoop101-s_aooi350_get_idno Error!"
               LET g_errparam.code   = "sub-00034"
               CALL cl_err()   
               
               EXIT FOREACH
            END IF
            
            LET ls_sql = " INSERT INTO oofb_t( ",
                         "        oofbstus, oofbent, oofb001, oofb002, oofb003, oofb004, oofb005, oofb006, ",
                         "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                         "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                         "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019,oofb020,oofb021,oofb022 ",
                         "        )",
                         " SELECT oofbstus, oofbent, '",l_oofb001,"','",l_oofb002,"','", l_oojm001,"', oofb004, oofb005, oofb006,",
                         "        oofb007, oofb008, oofb009, oofb010, oofb011, oofb012, oofb013, oofb014, ",
                         "        oofb015, oofb016, oofb017, oofb018, oofbownid, oofbowndp, oofbcrtid, ",
                         "        oofbcrtdp, oofbcrtdt, oofbmodid, oofbmoddt, oofb019,oofb020,oofb021,oofb022 ",
                         "   FROM oofb_t ",
                         "  WHERE oofbent = ",g_enterprise," AND oofb001 = '",l_oofb001_t,"' AND oofb002 = '",l_oofb002_t,"'"
            PREPARE aoop101_ins_oofb_pre FROM ls_sql
            EXECUTE aoop101_ins_oofb_pre
         
            IF SQLCA.SQLcode  THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "Insert oofb_t："
               LET g_errparam.code   = "sub-00034"
               CALL cl_err() 
               
               DISPLAY "aoop101-Ins oofb_t Error!"
               EXIT FOREACH
            END IF
         END FOREACH
         
         #7.2.更新通訊方式
         FOREACH aoop101_sel_oofc_curs USING l_oofb002_t INTO l_oofc001_t
            IF SQLCA.sqlcode THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "Foreach aoop101_sel_oofc_curs Error："
               LET g_errparam.code   = SQLCA.sqlcode
               CALL cl_err()  
               
               EXIT FOREACH
            END IF
            
            LET l_wc = " oofcent = ",g_enterprise
            CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
               RETURNING l_success,l_oofc001
            IF NOT l_success THEN
               LET l_err_cnt = l_err_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "s_aooi350_get_idno Error："
               LET g_errparam.code   = "sub-00034"
               CALL cl_err()   
               
               EXIT FOREACH
            END IF
         
            LET ls_sql = " INSERT INTO oofc_t( ",
                         "        oofcstus, oofcent, oofc001, oofc002, oofc003, oofc004, oofc005, oofc006, ",
                         "         oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                         "         oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                         "        )",
                         " SELECT oofcstus, oofcent,'",l_oofc001,"','",l_oofb002,"','", l_oojm001,"', oofc004, oofc005, oofc006,",
                         "        oofc007, oofc008, oofc009, oofc010, oofc011, oofc012, oofc013, oofcownid, ",
                         "        oofcowndp, oofccrtid, oofccrtdp, oofccrtdt, oofcmodid, oofcmoddt, oofc014 ",
                         "   FROM oofc_t ",
                         "  WHERE oofcent = ",g_enterprise," AND oofc001 = '",l_oofc001_t,"' AND oofc002 = '",l_oofb002_t,"'"
            PREPARE aoop101_ins_oofc_pre FROM ls_sql
            EXECUTE aoop101_ins_oofc_pre
#            DISPLAY "Ins oofc_t SQL=",ls_sql
            IF SQLCA.SQLcode  THEN
               LET l_err_cnt = l_err_cnt + 1

               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "Insert oofc_t："
               LET g_errparam.code   = "sub-00034"
               CALL cl_err()
               
               EXIT FOREACH
            END IF
         END FOREACH
      END FOREACH
      
      #8.整更新申請單的"資料更新否"
      LET l_oojlmoddt = cl_get_current()
      LET ls_sql = "UPDATE oojl_t ",
                   "   SET oojl005 = 'Y', ",
                   "       oojlmodid = '", g_user,"' , ",
                   "       oojlmoddt = ?",
                   " WHERE oojlent = ",g_enterprise,
                   "   AND oojldocno IN (SELECT oojldocno ",l_source_sql," ) "
      PREPARE aoop101_upd_oojl FROM ls_sql
      EXECUTE aoop101_upd_oojl USING l_oojlmoddt
      IF SQLCA.sqlcode THEN
         #DISPLAY "aoop101-Upd. oojl_t SQL: ",ls_sql
         LET l_err_cnt = l_err_cnt + 1
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "Update oojl_t："
         LET g_errparam.code   = SQLCA.sqlcode
         CALL cl_err() 
      ELSE
         DISPLAY "aoop101-Update oojl_t Success!"      
      END IF
   ELSE
      LET l_err_cnt = l_err_cnt + 1
   END IF
   
   DISPLAY "aoop101_Process-Error count: ",l_err_cnt
   IF l_err_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "aoo-00369"
      CALL cl_err() 
      
      CALL s_transaction_end('N',0)
      #CALL cl_err_collect_show()
   ELSE
      CALL s_transaction_end('Y',0)
   END IF
   CALL cl_err_collect_show()
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aoop101_process_cs CURSOR FROM ls_sql
#  FOREACH aoop101_process_cs INTO
   #add-point:process段process name="process.process"
   IF g_argv[6] = 'Y' THEN
      LET g_bgjob = 'Y'
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
      IF g_argv[6] = 'Y' THEN
         LET g_bgjob = 'N'
      END IF
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aoop101_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aoop101.get_buffer" >}
PRIVATE FUNCTION aoop101_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.oojl002 = p_dialog.getFieldBuffer('oojl002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aoop101.msgcentre_notify" >}
PRIVATE FUNCTION aoop101_msgcentre_notify()
 
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
 
{<section id="aoop101.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢查有無異動生效日前未更新的單據
# Memo...........:
# Usage..........: CALL aoop101_chk_unupd_doc()
#                  RETURNING r_success
# Return Code....: r_success   檢查結果
# Date & Author..: 2014/07/21 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop101_chk_unupd_doc()
DEFINE r_success    LIKE type_t.num5
DEFINE l_sql        STRING
DEFINE l_oojldocno  LIKE oojl_t.oojldocno
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_oojl002    LIKE oojl_t.oojl002

   LET r_success  = TRUE
   LET l_oojldocno = ''  
   LET l_cnt = 0
   
   LET l_oojl002 = ''
   IF g_argv[6] = 'Y' THEN
      LET l_oojl002 = g_argv[5]
   ELSE
      LET l_oojl002 = g_master.oojl002
   END IF
   
   LET l_sql = "SELECT oojldocno ",
               "  FROM oojm_t,oojl_t ",
               " WHERE oojment = oojlent ",
               "   AND oojmdocno = oojldocno ",
               "   AND oojlstus <> 'X' ",
               #"   AND oojl002 < '",g_argv[5],"' ",  #g_master.oojl002
               "   AND oojl002 < '",l_oojl002,"' ",
               "   AND oojl005 = 'N' "
   #160331-00026#1  --- remark Start ---
   IF NOT cl_null(g_master.wc) THEN            
      LET l_sql = l_sql,
                 " AND ",g_master.wc
   END IF
   #160331-00026#1  --- remark End ---
   LET l_sql = l_sql, " ORDER BY oojl002"

   PREPARE aoop101_unupd_pre FROM l_sql
   DECLARE aoop101_unupd_cur CURSOR FOR aoop101_unupd_pre
   FOREACH aoop101_unupd_cur INTO l_oojldocno
      LET l_cnt = l_cnt + 1
      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "oojldocno：",l_oojldocno
      LET g_errparam.code   = "aoo-00358"
      CALL cl_err()
      
      #IF cl_null(r_doc_list) THEN
      #  LET r_doc_list = l_oojldocno
      #ELSE
      #   LET r_doc_list = r_doc_list,"/",l_oojldocno
      #END IF
   END FOREACH

   IF l_cnt > 0 THEN 
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
