#該程式未解開Section, 採用最新樣板產出!
{<section id="aoop160.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-05-06 17:48:12), PR版次:0005(2017-01-12 18:47:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: aoop160
#+ Description: 產生日匯率批次作業
#+ Creator....: 00593(2015-04-28 15:27:01)
#+ Modifier...: 00593 -SD/PR- 07024
 
{</section>}
 
{<section id="aoop160.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160111-00029#1  16/01/11  by Sarah  匯入選項不見了
#160318-00005#33 2016/03/27   By 07900     重复错误信息修改
#160826-00012#1  2016/08/29   By charles4m 調整背景執行時無法新增匯率的問題
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
        ooam001  LIKE ooam_t.ooam001, 
        ooam003  LIKE ooam_t.ooam003, 
        ooam005  LIKE ooam_t.ooam005, 
        ooam004  LIKE ooam_t.ooam004, 
        ooam007  LIKE ooam_t.ooam007, 
        type     LIKE type_t.chr500, 
        ratetype LIKE type_t.chr500, 
        excel    LIKE type_t.chr80,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       ooam001 LIKE ooam_t.ooam001, 
   ooam001_desc LIKE type_t.chr80, 
   ooam003 LIKE ooam_t.ooam003, 
   ooam003_desc LIKE type_t.chr80, 
   ooam005 LIKE ooam_t.ooam005, 
   ooam004 LIKE ooam_t.ooam004, 
   ooam007 LIKE ooam_t.ooam007, 
   type LIKE type_t.chr500, 
   ratetype LIKE type_t.chr500, 
   excel LIKE type_t.chr500, 
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

#end add-point
 
{</section>}
 
{<section id="aoop160.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET lc_param.ooam001 = g_argv[1]
   LET lc_param.ooam003 = g_argv[2]
   LET lc_param.ooam005 = g_argv[3]
   LET lc_param.ooam004 = g_argv[4]
   LET lc_param.ooam007 = g_argv[5]
   LET lc_param.type = g_argv[6]
   LET lc_param.ratetype = g_argv[7]
   LET lc_param.excel = g_argv[8]   
   LET ls_js = util.JSON.stringify(lc_param)
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aoop160_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aoop160 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aoop160_init()
 
      #進入選單 Menu (="N")
      CALL aoop160_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aoop160
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aoop160.init" >}
#+ 初始化作業
PRIVATE FUNCTION aoop160_init()
 
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
  #CALL cl_set_combo_scc('type','31')           #匯入選項   #160111-00029#1 mark
   CALL cl_set_combo_scc('formonly.type','31')  #匯入選項   #160111-00029#1
   CALL cl_set_combo_scc('ratetype','190')      #匯率種類
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aoop160.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aoop160_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success   LIKE type_t.num5      
   DEFINE l_status    LIKE type_t.num5
   DEFINE l_excel     STRING 
   DEFINE ls_str      STRING
   DEFINE l_chr       LIKE type_t.chr1   
   DEFINE l_chr1      LIKE type_t.chr1 
   DEFINE l_chr2      LIKE type_t.chr5   
   DEFINE l_num       LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   IF NOT cl_null(g_argv[1]) THEN 
      LET g_master.ooam001 = g_argv[1]
      CALL s_desc_ooal002_desc(1,g_master.ooam001) RETURNING g_master.ooam001_desc
      DISPLAY BY NAME g_master.ooam001_desc 
   END IF
   IF NOT cl_null(g_argv[2]) THEN 
      LET g_master.ooam003 = g_argv[2]
      CALL s_desc_get_currency_desc(g_master.ooam003) RETURNING g_master.ooam003_desc
      DISPLAY BY NAME g_master.ooam003_desc
   END IF
   LET g_master.ooam005 = 1
   LET g_master.ooam004 = g_today
   LET g_master.ooam007 = 'N'               
   LET g_master.type = ''
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.ooam001,g_master.ooam003,g_master.ooam005,g_master.ooam004,g_master.ooam007, 
             g_master.type,g_master.ratetype,g_master.excel 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL aoop160_set_no_entry()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam001
            
            #add-point:AFTER FIELD ooam001 name="input.a.ooam001"
            DISPLAY '' TO  ooam001_desc
            IF NOT cl_null(g_master.ooam001)  THEN
               CALL aoop160_ooal002_chk(1,g_master.ooam001)
               IF NOT cl_null (g_errno)  THEN
                  IF g_errno = 'aoo-00076' THEN
                     IF NOT cl_ask_confirm('aoo-00076') THEN
                        LET g_master.ooam001 = ''                        
                     ELSE
                        CALL s_transaction_begin()
                        CALL s_aooi070_ins(1,g_master.ooam001) RETURNING l_success
                        IF l_success = TRUE THEN
                           CALL s_transaction_end('Y','1')
                        ELSE
                           CALL s_transaction_end('N','1')
                        END IF 
                     END IF 
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.ooam001
                     #160318-00005#33  By 07900 --add-str
                     LET g_errparam.replace[1] ='aooi071'
                     LET g_errparam.replace[2] = cl_get_progname("aooi071",g_lang,"2")
                     LET g_errparam.exeprog ='aooi071'
                     #160318-00005#33  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.ooam001 = ''
                  END IF
                  NEXT FIELD ooam001                  
               END IF
               CALL s_desc_ooal002_desc(1,g_master.ooam001) RETURNING g_master.ooam001_desc
               DISPLAY BY NAME g_master.ooam001_desc               
            ELSE
               LET g_master.ooam001_desc = ''
               DISPLAY BY NAME g_master.ooam001_desc
               NEXT FIELD ooam001
            END  IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam001
            #add-point:BEFORE FIELD ooam001 name="input.b.ooam001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam001
            #add-point:ON CHANGE ooam001 name="input.g.ooam001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam003
            
            #add-point:AFTER FIELD ooam003 name="input.a.ooam003"
            DISPLAY '' TO ooam003_desc
            IF NOT cl_null(g_master.ooam003) THEN
               LET g_errno = ''
               CALL s_fin_ooai001_chk(g_master.ooam003) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.ooam003
                  #160321-00016#41 s983961--add(s)
                  LET g_errparam.replace[1] ='aooi140'
                  LET g_errparam.replace[2] = cl_get_progname('aooi140',g_lang,"2")
                  LET g_errparam.exeprog ='aooi140'
                  #160321-00016#41 s983961--add(e)
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_master.ooam003 = ''
                  LET g_master.ooam003_desc = ''
                  DISPLAY BY NAME g_master.ooam003_desc
                  NEXT FIELD ooam003	
               END IF 
            END IF 
            CALL s_desc_get_currency_desc(g_master.ooam003) RETURNING g_master.ooam003_desc
            DISPLAY BY NAME g_master.ooam003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam003
            #add-point:BEFORE FIELD ooam003 name="input.b.ooam003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam003
            #add-point:ON CHANGE ooam003 name="input.g.ooam003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.ooam005,"0","0","","","azz-00079",1) THEN
               NEXT FIELD ooam005
            END IF 
 
 
 
            #add-point:AFTER FIELD ooam005 name="input.a.ooam005"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam005
            #add-point:BEFORE FIELD ooam005 name="input.b.ooam005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam005
            #add-point:ON CHANGE ooam005 name="input.g.ooam005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam004
            #add-point:BEFORE FIELD ooam004 name="input.b.ooam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam004
            
            #add-point:AFTER FIELD ooam004 name="input.a.ooam004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam004
            #add-point:ON CHANGE ooam004 name="input.g.ooam004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam007
            #add-point:BEFORE FIELD ooam007 name="input.b.ooam007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam007
            
            #add-point:AFTER FIELD ooam007 name="input.a.ooam007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam007
            #add-point:ON CHANGE ooam007 name="input.g.ooam007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            CALL aoop160_set_no_entry()
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            CALL aoop160_set_entry()
            IF g_master.type = 'A' THEN
               LET g_master.excel = ''
            ELSE
               LET g_master.ratetype = ''
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ratetype
            #add-point:BEFORE FIELD ratetype name="input.b.ratetype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ratetype
            
            #add-point:AFTER FIELD ratetype name="input.a.ratetype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ratetype
            #add-point:ON CHANGE ratetype name="input.g.ratetype"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD excel
            #add-point:BEFORE FIELD excel name="input.b.excel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD excel
            
            #add-point:AFTER FIELD excel name="input.a.excel"
            IF NOT cl_null(g_master.excel) THEN
               LET ls_str= ''
               LET l_chr2 = ''
               LET ls_str = g_master.excel
               LET l_num = ls_str.getlength()
               LET l_chr2 = ls_str.substring(l_num-2,l_num)
               IF l_chr2 <>'xls' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00260'   #檔案格式錯誤！
                  LET g_errparam.extend = g_master.excel
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD excel
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE excel
            #add-point:ON CHANGE excel name="input.g.excel"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.ooam001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam001
            #add-point:ON ACTION controlp INFIELD ooam001 name="input.c.ooam001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ooam001  #給予default值
            CALL q_ooal002_3()                          #呼叫開窗
            LET g_master.ooam001 = g_qryparam.return1
            DISPLAY g_master.ooam001 TO ooam001
            CALL s_desc_ooal002_desc(1,g_master.ooam001) RETURNING g_master.ooam001_desc
            DISPLAY BY NAME g_master.ooam001_desc
            NEXT FIELD ooam001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.ooam003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam003
            #add-point:ON ACTION controlp INFIELD ooam003 name="input.c.ooam003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ooam003   #給予default值
            CALL q_ooai001()                             #呼叫開窗
            LET g_master.ooam003 = g_qryparam.return1
            DISPLAY g_master.ooam003 TO ooam003
            CALL s_desc_get_currency_desc(g_master.ooam003) RETURNING g_master.ooam003_desc
            DISPLAY BY NAME g_master.ooam003_desc
            NEXT FIELD ooam003                           #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.ooam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam005
            #add-point:ON ACTION controlp INFIELD ooam005 name="input.c.ooam005"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooam004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam004
            #add-point:ON ACTION controlp INFIELD ooam004 name="input.c.ooam004"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooam007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam007
            #add-point:ON ACTION controlp INFIELD ooam007 name="input.c.ooam007"
            
            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
         #Ctrlp:input.c.ratetype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ratetype
            #add-point:ON ACTION controlp INFIELD ratetype name="input.c.ratetype"
            
            #END add-point
 
 
         #Ctrlp:input.c.excel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD excel
            #add-point:ON ACTION controlp INFIELD excel name="input.c.excel"
            
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
            CALL aoop160_get_buffer(l_dialog)
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
         ON ACTION browser
            CALL cl_client_browse_file() RETURNING g_master.excel
            DISPLAY BY NAME g_master.excel
            LET ls_str= ''
            LET l_chr2 = ''
            LET ls_str = g_master.excel
            LET l_num = ls_str.getlength()
            LET l_chr2 = ls_str.substring(l_num-2,l_num)
            IF l_chr2 <>'xls' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00260'   #檔案格式錯誤！
               LET g_errparam.extend = g_master.excel
               LET g_errparam.popup = TRUE
               CALL cl_err()   
               NEXT FIELD excel
            END IF 
            
         ON ACTION download
            CALL cl_client_browse_dir() RETURNING l_excel
            LET ls_str= ''
            LET l_chr = ''
            LET l_chr1 = ''
            LET ls_str = l_excel
            #抓取目录斜杆
            LET l_num =ls_str.getIndexOf(':',1)                                  #抓取：后的字符位置
            LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
            LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength()) #判断是否为根目录
            IF l_chr <> l_chr1  THEN         
               LET l_excel = l_excel||l_chr||"exrate.xls"
            ELSE
               LET l_excel = l_excel||"exrate.xls"
            END IF
            IF NOT cl_null(l_excel) THEN         
               LET g_bgjob = 'Y'                                                 #add-mpp      
               LET status =  cl_client_download_file("$RES/std/exrate.xls",l_excel) 
               IF status THEN
                  ERROR "Download OK!!"
               ELSE
                  ERROR "Download fail!!"
               END IF         
            END IF
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
         CALL aoop160_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.ooam001 = g_master.ooam001
      LET lc_param.ooam003 = g_master.ooam003
      LET lc_param.ooam005 = g_master.ooam005
      LET lc_param.ooam004 = g_master.ooam004
      LET lc_param.ooam007 = g_master.ooam007
      LET lc_param.type = g_master.type
      LET lc_param.ratetype = g_master.ratetype
      LET lc_param.excel = g_master.excel
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
                 CALL aoop160_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aoop160_transfer_argv(ls_js)
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
 
{<section id="aoop160.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aoop160_transfer_argv(ls_js)
 
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
 
{<section id="aoop160.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aoop160_process(ls_js)
 
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
   #170111-00039#1-s-add
   CALL s_aooi160_cre_tmp()
   #170111-00039#1-e-add
   CALL s_transaction_begin()
  #IF NOT aoop160_data() THEN      #160826-00012#1 mark
   IF NOT aoop160_data(ls_js) THEN #160826-00012#1 add
      CALL s_transaction_end('N','1')
      RETURN 
   ELSE
      DISPLAY 100 TO stagecomplete
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aoop160_process_cs CURSOR FROM ls_sql
#  FOREACH aoop160_process_cs INTO
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
   CALL aoop160_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aoop160.get_buffer" >}
PRIVATE FUNCTION aoop160_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.ooam001 = p_dialog.getFieldBuffer('ooam001')
   LET g_master.ooam003 = p_dialog.getFieldBuffer('ooam003')
   LET g_master.ooam005 = p_dialog.getFieldBuffer('ooam005')
   LET g_master.ooam004 = p_dialog.getFieldBuffer('ooam004')
   LET g_master.ooam007 = p_dialog.getFieldBuffer('ooam007')
   LET g_master.type = p_dialog.getFieldBuffer('type')
   LET g_master.ratetype = p_dialog.getFieldBuffer('ratetype')
   LET g_master.excel = p_dialog.getFieldBuffer('excel')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aoop160.msgcentre_notify" >}
PRIVATE FUNCTION aoop160_msgcentre_notify()
 
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
 
{<section id="aoop160.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢查參照表編號
# Memo...........:
# Usage..........: CALL aoop160_ooal002_chk(p_ooal001,p_ooal002)
# Input parameter: p_ooal001   參照表類型
#                : p_ooal002   參照表編號
# Return code....: 無
# Date & Author..: 15/04/19 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop160_ooal002_chk(p_ooal001,p_ooal002)
   DEFINE p_ooal001     LIKE ooal_t.ooal001
   DEFINE p_ooal002     LIKE ooal_t.ooal002
   DEFINE l_ooalstus    like ooal_t.ooalstus
   
   LET g_errno = ''
   SELECT ooalstus INTO l_ooalstus
     FROM ooal_t 
    WHERE ooalent = g_enterprise
      AND ooal001 = p_ooal001
      AND ooal002 = p_ooal002
   CASE
      WHEN sqlca.sqlcode = 100
         LET g_errno = 'aoo-00076'  #輸入的參照表號不存在於[參照表檔],請問是否要新增此參照表號?
      WHEN l_ooalstus ='N'  
         LET g_errno = 'sub-01302'  #輸入資料為無效！ #aoo-00128 #160318-00005#33 by 07900 --mod
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 欄位開啟設定
# Memo...........:
# Usage..........: CALL aoop160_set_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/29 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop160_set_entry()
   IF g_master.type = 'A' THEN
      CALL cl_set_comp_entry("ratetype",TRUE)
   ELSE
      CALL cl_set_comp_entry("excel",TRUE)
      CALL cl_set_act_visible("browser,download",TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉設定
# Memo...........:
# Usage..........: CALL aoop160_set_no_entry()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/04/29 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop160_set_no_entry()
   CALL cl_set_comp_entry("ratetype,excel",FALSE)
   CALL cl_set_act_visible("browser,download",FALSE)
END FUNCTION
# Descriptions...: 
# Memo...........:
# Usage..........: CALL aoop160_data(ls_js)
# Input parameter: 
# Return code....: 無
# Date & Author..: 
# Modify.........:#160826-00012#1 16/08/29 By charles4m
PRIVATE FUNCTION aoop160_data(ls_js)
   DEFINE l_success   LIKE type_t.num5
   DEFINE ls_js       STRING         #160826-00012#1 add
   DEFINE lc_param    type_parameter #160826-00012#1 add


   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處           #160826-00012#1 add
   CALL s_aooi160_ins(lc_param.ooam001,lc_param.ooam003,lc_param.ooam005,lc_param.ooam004, #160826-00012#1 add
                      lc_param.ooam007,lc_param.type,lc_param.ratetype,lc_param.excel )    #160826-00012#1 add
  #160826-00012#1 mark start -----
  #CALL s_aooi160_ins(g_master.ooam001,g_master.ooam003,g_master.ooam005,g_master.ooam004,
  #                   g_master.ooam007,g_master.type,g_master.ratetype,g_master.excel ) 
  #160826-00012#1 mark end   -----
   RETURNING l_success
   
   RETURN l_success
   
END FUNCTION

#end add-point
 
{</section>}
 
