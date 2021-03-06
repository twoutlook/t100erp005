#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp210.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2016-06-03 14:21:35), PR版次:0023(2017-02-17 14:56:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000215
#+ Filename...: axcp210
#+ Description: 料件庫存量按帳套期統計作業
#+ Creator....: 02291(2014-04-03 10:48:51)
#+ Modifier...: 02295 -SD/PR- 07423
 
{</section>}
 
{<section id="axcp210.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#8   2016/04/21 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160518-00033#4   2016/05/30 By 02295  不能直接取換算率作乘算(inaj014)应用換算分子/換算分母
#160727-00019#20  2016/08/4 By 08742   系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                      Mod  axcp210_xcbz_tmp--> axcp210_tmp01
#161008-00005#1   2016/10/12 By 02040  拿除法人ooef003 = 'Y'條件
#161014-00008#1   2016/10/19 By charles4m 調整在 BEFORE INPUT及AFTER FIELD glaald 時，抓g_glaa003、l_bdate、l_edate的值
#161019-00033#1   2016/10/20 By 02295      应检查计算的年度+期别在成本关账日期之后（S-FIN-6012）
#161021-00027#1   2016/10/21 By 02295   建表之前先drop表
#161109-00085#25  2016/11/16 By 08993   整批調整系統星號寫法
#161117-00031#1   2016/11/18 By 02295    将判断条件小于等于改成等于
#161109-00085#63  2016/12/01 By 08171   整批調整系統星號寫法
#161214-00026#1   2016/12/14 By 00537   多一个inaj052，删除即可
#170208-00048#1   2017/02/15 By Ann_Huang 修正預帶年度期別時,應該取得agli010的現行年度(glaa010)/期別(glaa011)
#170210-00035#1   2017/02/17 By fionchen  inaj_tmp建表之前先drop表 
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
       imaa001 LIKE type_t.chr500, 
   imaa003 LIKE type_t.chr500, 
   glaacomp LIKE type_t.chr500, 
   glaacomp_desc LIKE type_t.chr80, 
   glaald LIKE type_t.chr500, 
   glaald_desc LIKE type_t.chr80, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告
 TYPE type_g_glaa_m RECORD
   glaacomp LIKE glaa_t.glaacomp,
   glaacomp_desc LIKE type_t.chr80,
   glaald LIKE glaa_t.glaald,
   glaald_desc LIKE type_t.chr80,
   year LIKE type_t.num5,
   month LIKE type_t.num5
END RECORD
DEFINE g_glaa_m     type_g_glaa_m
DEFINE g_glaa_m_t   type_g_glaa_m
DEFINE l_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE l_edate      LIKE glav_t.glav004
DEFINE g_success    LIKE type_t.chr1
DEFINE g_wc2        STRING
DEFINE g_glaa003    LIKE glaa_t.glaa003
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp210.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp210_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp210 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp210_init()
 
      #進入選單 Menu (="N")
      CALL axcp210_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp210
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp210.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp210_init()
 
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
 
{<section id="axcp210.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp210_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   CALL axcp210_construct()
   RETURN
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.imaa001,g_master.imaa003,g_master.glaacomp,g_master.glaald,g_master.year, 
             g_master.month 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="input.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="input.a.imaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa001
            #add-point:ON CHANGE imaa001 name="input.g.imaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="input.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="input.a.imaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa003
            #add-point:ON CHANGE imaa003 name="input.g.imaa003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t
             WHERE ooeflent=g_enterprise AND ooefl001= g_glaa_m.glaacomp AND ooefl002=g_dlang
            DISPLAY BY NAME g_glaa_m.glaacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="input.a.glaald"
            SELECT glaal003 INTO g_glaa_m.glaald_desc FROM glaal_t 
             WHERE glaalent=g_enterprise AND glaal001=g_glaa_m.glaald AND glaal002=g_dlang
            DISPLAY BY NAME g_glaa_m.glaald_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="input.b.glaald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaald
            #add-point:ON CHANGE glaald name="input.g.glaald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
 
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
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.imaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="input.c.imaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.imaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="input.c.imaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaacomp             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glaa_m.glaacomp = g_qryparam.return1              
            #LET g__m.ooefl003 = g_qryparam.return2 
            DISPLAY g_glaa_m.glaacomp TO glaacomp              #
            #DISPLAY g__m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD glaacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="input.c.glaald"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glaa_m.glaald = g_qryparam.return1              

            DISPLAY g_glaa_m.glaald TO glaald              #

            NEXT FIELD glaald                          #返回原欄位


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
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa001,imaa003,glaacomp,glaald,year,month
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
            NEXT FIELD imaa003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="construct.b.glaald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="construct.a.glaald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="construct.c.glaald"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="construct.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="construct.a.year"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="construct.c.year"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="construct.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="construct.a.month"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="construct.c.month"
            
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
            CALL axcp210_get_buffer(l_dialog)
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
         CALL axcp210_init()
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
                 CALL axcp210_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp210_transfer_argv(ls_js)
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
 
{<section id="axcp210.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp210_transfer_argv(ls_js)
 
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
 
{<section id="axcp210.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp210_process(ls_js)
 
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
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp210_process_cs CURSOR FROM ls_sql
#  FOREACH axcp210_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axcp210_ins_xcbz()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL axcp210_ins_xcbz()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp210_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp210.get_buffer" >}
PRIVATE FUNCTION axcp210_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.imaa001 = p_dialog.getFieldBuffer('imaa001')
   LET g_master.imaa003 = p_dialog.getFieldBuffer('imaa003')
   LET g_master.glaacomp = p_dialog.getFieldBuffer('glaacomp')
   LET g_master.glaald = p_dialog.getFieldBuffer('glaald')
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp210.msgcentre_notify" >}
PRIVATE FUNCTION axcp210_msgcentre_notify()
 
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
 
{<section id="axcp210.other_function" readonly="Y" >}
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
PRIVATE FUNCTION axcp210_construct()
DEFINE l_n     LIKE type_t.num5 
DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
DEFINE li_idx   LIKE type_t.num5
DEFINE ls_js    STRING
DEFINE ls_wc    STRING
DEFINE l_dialog ui.DIALOG
DEFINE lc_param type_parameter
DEFINE l_xcaz001  LIKE xcaz_t.xcaz001    #160816-00048#1


   CLEAR FORM
   INITIALIZE g_glaa_m.* TO NULL
   INITIALIZE g_wc2 TO NULL
   
   WHILE TRUE
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      CONSTRUCT BY NAME g_wc2 ON imaa001,imaa003
      BEFORE CONSTRUCT
          CALL cl_qbe_init() 
               
          
       ON ACTION controlp INFIELD imaa001     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
		  LET g_qryparam.where = " imaastus = 'Y'  "
          CALL q_imaa001()                    #呼叫開窗
          DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
          NEXT FIELD imaa001
         
       ON ACTION controlp INFIELD imaa003     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
		  LET g_qryparam.arg1 = "200"
		  LET g_qryparam.where = " oocqstus = 'Y'  "
          CALL q_oocq002()                    #呼叫開窗
          DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
          NEXT FIELD imaa003
          
       
      END CONSTRUCT 
      
      INPUT BY NAME g_glaa_m.glaacomp,g_glaa_m.glaald,g_glaa_m.year,g_glaa_m.month
       
      
         BEFORE INPUT 
            #160816-00048#1---add---s
            CALL s_axc_set_site_default() RETURNING g_glaa_m.glaacomp,g_glaa_m.glaald,g_glaa_m.year,g_glaa_m.month,l_xcaz001
           #161014-00008#1 ---add (s)---
           #SELECT glaa003 INTO g_glaa003 FROM glaa_t   #170208-00048#1 mark
            SELECT glaa003, glaa010,glaa011 INTO g_glaa003, g_glaa_m.year,g_glaa_m.month FROM glaa_t   #170208-00048#1 add 
             WHERE glaaent = g_enterprise 
               AND glaald = g_glaa_m.glaald
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
               RETURNING l_bdate,l_edate               
            END IF               
          ##161014-00008#1 ---add (e)---
            DISPLAY BY NAME g_glaa_m.glaacomp,g_glaa_m.glaald,g_glaa_m.year,g_glaa_m.month         
            #160816-00048#1---add---e
         AFTER FIELD glaacomp
        
            IF NOT cl_null(g_glaa_m.glaacomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaacomp
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#8--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_ooef001_15') THEN
                  #檢查失敗時後續處理
                  LET g_glaa_m.glaacomp = g_glaa_m_t.glaacomp
                  CALL axcp210_glaacomp_desc()
                  NEXT FIELD glaacomp
               END IF
               IF NOT cl_null(g_glaa_m.glaald) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
                     AND glaacomp = g_glaa_m.glaacomp
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00225'
                     LET g_errparam.extend = g_glaa_m.glaacomp
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD glaald
                  END IF
               END IF
               CALL axcp210_glaacomp_desc()        {#ADP版次:1#}
               
               
                                                    
            END IF            
            
             
          ON ACTION controlp INFIELD glaacomp
	  	     #開窗i段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
		        
                LET g_qryparam.default1 = g_glaa_m.glaacomp            #給予default值
                IF NOT cl_null(g_glaa_m.glaald) THEN
                   LET g_qryparam.where = " ooef003 = 'Y' AND ooef017 =(SELECT glaacomp FROM glaa_t ",
                         " WHERE glaaent = '",g_enterprise,"' AND glaald = '",g_glaa_m.glaald,"')"
                ELSE
                   LET g_qryparam.where = " ooef003 = 'Y' "
                END IF
		        
                #給予arg
                CALL q_ooef001()
		        
                LET g_glaa_m.glaacomp = g_qryparam.return1              #將開窗取得的值回傳到變數
		        
		        
                DISPLAY g_glaa_m.glaacomp TO glaacomp              #顯示到畫面上
                LET g_qryparam.where = NULL
                CALL axcp210_glaacomp_desc()
		        
                NEXT FIELD glaacomp                          #返回原欄位    

         AFTER FIELD glaald
        
            IF NOT cl_null(g_glaa_m.glaald) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaald
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_glaald') THEN
                  #檢查失敗時後續處理
                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
                  CALL axcp210_glaald_desc()
                  NEXT FIELD glaald
               END IF
               
               
               IF NOT cl_null(g_glaa_m.glaacomp) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM glaa_t 
                   WHERE glaaent = g_enterprise AND glaacomp = g_glaa_m.glaacomp
                     AND glaald = g_glaa_m.glaald
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axc-00225'
                     LET g_errparam.extend = g_glaa_m.glaald
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD glaacomp
                  END IF
               END IF
               
               IF NOT s_ld_chk_authorization(g_user,g_glaa_m.glaald) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00165'
                  LET g_errparam.extend = g_glaa_m.glaald
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glaacomp
               END IF
               CALL axcp210_glaald_desc()        {#ADP版次:1#}
               SELECT glaa003,glaa010,glaa011 INTO g_glaa003,g_glaa_m.year,g_glaa_m.month FROM glaa_t
                WHERE glaaent = g_enterprise 
                  AND glaald = g_glaa_m.glaald
              #161014-00008#1 ---add (s)---
               IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                  RETURNING l_bdate,l_edate               
               END IF         
               #161014-00008#1 ---add (e)---
               DISPLAY BY NAME g_glaa_m.year,g_glaa_m.month                                     
            END IF            
            
             
          ON ACTION controlp INFIELD glaald
	  	     #開窗i段
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
		     
             LET g_qryparam.default1 = g_glaa_m.glaald             #給予default值
             LET g_qryparam.arg1 = g_user
             LET g_qryparam.arg2 = g_dept
             IF NOT cl_null(g_glaa_m.glaacomp) THEN
                LET g_qryparam.where = " glaacomp='",g_glaa_m.glaacomp,"'"
             END IF
		     
             #給予arg
             CALL q_authorised_ld()
		     
             LET g_glaa_m.glaald = g_qryparam.return1              #將開窗取得的值回傳到變數
		     
             DISPLAY g_glaa_m.glaald TO glaald              #顯示到畫面上
             LET g_qryparam.where = NULL
             CALL axcp210_glaald_desc()
		        
              NEXT FIELD glaald                          #返回原欄位 
         
         AFTER FIELD year
        
            IF NOT cl_null(g_glaa_m.year) THEN
               IF NOT s_fin_date_chk_year(g_glaa_m.year) THEN
                  LET g_glaa_m.year = g_glaa_m_t.year
                  DISPLAY BY NAME g_glaa_m.year
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_glaa_m.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               #161019-00033#1---add---s
               CALL axcp210_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_glaa_m.year
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT                       
               END IF      
               #161019-00033#1---add---e                                                      
            END IF  
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
            END IF               
            
         BEFORE FIELD month
            IF cl_null(g_glaa_m.year) THEN
               NEXT FIELD year
            END IF

         AFTER FIELD month
            IF NOT cl_null(g_glaa_m.month) THEN                      
               IF NOT s_fin_date_chk_period(g_glaa003,g_glaa_m.year,g_glaa_m.month) THEN
                  LET g_glaa_m.month = g_glaa_m_t.month
                  DISPLAY BY NAME g_glaa_m.month
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00106'
                  LET g_errparam.extend = g_glaa_m.month
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               #161019-00033#1---add---s
               CALL axcp210_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = g_glaa_m.month
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT                       
               END IF      
               #161019-00033#1---add---e                
            END IF
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
            END IF 
        AFTER INPUT
     END INPUT
       
#      BEFORE DIALOG
##          CALL cl_qbe_init()
# 
#      ON ACTION qbe_select      
# 
#      ON ACTION qbe_save       
#      
#      ON ACTION accept
#         ACCEPT DIALOG
# 
#      ON ACTION cancel
#         LET INT_FLAG = 1
#         EXIT DIALOG 
# 
#      #交談指令共用ACTION
#      &include "common_action.4gl" 
#         CONTINUE DIALOG
       
       SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axcp210_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後

               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
            #add-point:ui_dialog段qbeclear

            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action

         #end add-point
 
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
   END DIALOG
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         LET g_jobid = cl_schedule_get_jobid(g_prog)
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axcp210_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = axcp210_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
 
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
PRIVATE FUNCTION axcp210_glaacomp_desc()
   SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t 
    WHERE ooeflent=g_enterprise AND ooefl001=g_glaa_m.glaacomp AND ooefl002=g_dlang

   #160816-00048#1---add---s   
   SELECT glaald INTO g_glaa_m.glaald
     FROM glaa_t 
    WHERE glaaent = g_enterprise
      AND glaacomp = g_glaa_m.glaacomp
      AND glaa014 ='Y'
      AND glaastus = 'Y' 
   DISPLAY BY NAME g_glaa_m.glaald
   #160816-00048#1---add---e   
   DISPLAY BY NAME g_glaa_m.glaacomp_desc
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
PRIVATE FUNCTION axcp210_glaald_desc()
   SELECT glaal003 INTO g_glaa_m.glaald_desc FROM glaal_t 
    WHERE glaalent=g_enterprise AND glaal001=g_glaa_m.glaald AND glaal002=g_dlang

   DISPLAY BY NAME g_glaa_m.glaald_desc
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
PRIVATE FUNCTION axcp210_ins_xcbz()
DEFINE l_sql           STRING
DEFINE l_sql1          STRING
DEFINE l_sql2          STRING
DEFINE l_sql3          STRING
DEFINE l_msg           STRING
#161109-00085#25-s mod
#DEFINE l_inaj          RECORD LIKE inaj_t.*   #161109-00085#25-s mark
DEFINE l_inaj RECORD  #庫存交易明細檔
       inajent LIKE inaj_t.inajent, #企業編號
       inajsite LIKE inaj_t.inajsite, #營運據點
       inaj001 LIKE inaj_t.inaj001, #單據編號
       inaj002 LIKE inaj_t.inaj002, #項次
       inaj003 LIKE inaj_t.inaj003, #項序
       inaj004 LIKE inaj_t.inaj004, #出入庫碼
       inaj005 LIKE inaj_t.inaj005, #料件編號
       inaj006 LIKE inaj_t.inaj006, #產品特徵
       inaj007 LIKE inaj_t.inaj007, #庫存管理特徵
       inaj008 LIKE inaj_t.inaj008, #庫位編號
       inaj009 LIKE inaj_t.inaj009, #儲位編號
       inaj010 LIKE inaj_t.inaj010, #批號
       inaj011 LIKE inaj_t.inaj011, #交易數量
       inaj012 LIKE inaj_t.inaj012, #交易單位
       inaj013 LIKE inaj_t.inaj013, #交易單位與庫存單位換算率
       inaj014 LIKE inaj_t.inaj014, #交易單位與料件基本單位換算率
       inaj015 LIKE inaj_t.inaj015, #異動單據性質
       inaj016 LIKE inaj_t.inaj016, #理由碼
       inaj017 LIKE inaj_t.inaj017, #異動部門編號
       inaj018 LIKE inaj_t.inaj018, #異動供應商/客戶編號
       inaj019 LIKE inaj_t.inaj019, #備註
       inaj020 LIKE inaj_t.inaj020, #工單單號
       inaj021 LIKE inaj_t.inaj021, #多角序號
       inaj022 LIKE inaj_t.inaj022, #單據扣帳日期
       inaj023 LIKE inaj_t.inaj023, #實際執行扣帳日期
       inaj024 LIKE inaj_t.inaj024, #資料產生時間
       inaj025 LIKE inaj_t.inaj025, #異動資料產生者
       inaj026 LIKE inaj_t.inaj026, #參考單位
       inaj027 LIKE inaj_t.inaj027, #參考數量
       inaj028 LIKE inaj_t.inaj028, #成本料號
       inaj036 LIKE inaj_t.inaj036, #庫存異動類型
       inaj029 LIKE inaj_t.inaj029, #交易單位與成本單位換算率
       inaj030 LIKE inaj_t.inaj030, #VMI交易結算否
       inaj031 LIKE inaj_t.inaj031, #VMI對應入庫/倉退單號
       inaj032 LIKE inaj_t.inaj032, #VMI對應入庫/倉退項次
       inaj033 LIKE inaj_t.inaj033, #VMI對應雜發/雜收單號
       inaj034 LIKE inaj_t.inaj034, #VMI對應雜發/雜收項次
       inaj035 LIKE inaj_t.inaj035, #異動作業編號
       inaj037 LIKE inaj_t.inaj037, #成本中心
       inaj038 LIKE inaj_t.inaj038, #專案編號
       inaj039 LIKE inaj_t.inaj039, #WBS編號
       inaj040 LIKE inaj_t.inaj040, #重複性生產-計畫編號
       inaj041 LIKE inaj_t.inaj041, #重複性生產-生產料號
       inaj042 LIKE inaj_t.inaj042, #重複性生產-生產料號BOM特性
       inaj043 LIKE inaj_t.inaj043, #重複性生產-生產料號產品特徵
       inaj044 LIKE inaj_t.inaj044, #來源單號
       inaj200 LIKE inaj_t.inaj200, #內部結算否
       inaj201 LIKE inaj_t.inaj201, #業務類型
       inaj202 LIKE inaj_t.inaj202, #內部交易類型
       inaj203 LIKE inaj_t.inaj203, #幣別
       inaj204 LIKE inaj_t.inaj204, #稅別
       inaj205 LIKE inaj_t.inaj205, #內部結算未稅金額
       inaj206 LIKE inaj_t.inaj206, #內部結算含稅金額
       inaj207 LIKE inaj_t.inaj207, #交易所屬法人
       inaj208 LIKE inaj_t.inaj208, #內部交易對象組織
       inaj209 LIKE inaj_t.inaj209, #內部交易對象法人
       #161109-00085#63 --s add
       inajud001 LIKE inaj_t.inajud001, #自定義欄位(文字)001
       inajud002 LIKE inaj_t.inajud002, #自定義欄位(文字)002
       inajud003 LIKE inaj_t.inajud003, #自定義欄位(文字)003
       inajud004 LIKE inaj_t.inajud004, #自定義欄位(文字)004
       inajud005 LIKE inaj_t.inajud005, #自定義欄位(文字)005
       inajud006 LIKE inaj_t.inajud006, #自定義欄位(文字)006
       inajud007 LIKE inaj_t.inajud007, #自定義欄位(文字)007
       inajud008 LIKE inaj_t.inajud008, #自定義欄位(文字)008
       inajud009 LIKE inaj_t.inajud009, #自定義欄位(文字)009
       inajud010 LIKE inaj_t.inajud010, #自定義欄位(文字)010
       inajud011 LIKE inaj_t.inajud011, #自定義欄位(數字)011
       inajud012 LIKE inaj_t.inajud012, #自定義欄位(數字)012
       inajud013 LIKE inaj_t.inajud013, #自定義欄位(數字)013
       inajud014 LIKE inaj_t.inajud014, #自定義欄位(數字)014
       inajud015 LIKE inaj_t.inajud015, #自定義欄位(數字)015
       inajud016 LIKE inaj_t.inajud016, #自定義欄位(數字)016
       inajud017 LIKE inaj_t.inajud017, #自定義欄位(數字)017
       inajud018 LIKE inaj_t.inajud018, #自定義欄位(數字)018
       inajud019 LIKE inaj_t.inajud019, #自定義欄位(數字)019
       inajud020 LIKE inaj_t.inajud020, #自定義欄位(數字)020
       inajud021 LIKE inaj_t.inajud021, #自定義欄位(日期時間)021
       inajud022 LIKE inaj_t.inajud022, #自定義欄位(日期時間)022
       inajud023 LIKE inaj_t.inajud023, #自定義欄位(日期時間)023
       inajud024 LIKE inaj_t.inajud024, #自定義欄位(日期時間)024
       inajud025 LIKE inaj_t.inajud025, #自定義欄位(日期時間)025
       inajud026 LIKE inaj_t.inajud026, #自定義欄位(日期時間)026
       inajud027 LIKE inaj_t.inajud027, #自定義欄位(日期時間)027
       inajud028 LIKE inaj_t.inajud028, #自定義欄位(日期時間)028
       inajud029 LIKE inaj_t.inajud029, #自定義欄位(日期時間)029
       inajud030 LIKE inaj_t.inajud030, #自定義欄位(日期時間)030
       #161109-00085#63 --e add
       inaj045 LIKE inaj_t.inaj045, #異動時庫存單位
       inaj046 LIKE inaj_t.inaj046, #交易單位與庫存單位換算分子
       inaj047 LIKE inaj_t.inaj047, #交易單位與庫存單位換算分母
       inaj048 LIKE inaj_t.inaj048, #交易單位與料件基本單位換算分子
       inaj049 LIKE inaj_t.inaj049, #交易單位與料件基本單位換算分母
       inaj050 LIKE inaj_t.inaj050, #交易單位與成本單位換算分子
       inaj051 LIKE inaj_t.inaj051, #交易單位與成本單位換算分母
       inaj210 LIKE inaj_t.inaj210, #單據單價
       inaj211 LIKE inaj_t.inaj211  #品類
END RECORD
#161109-00085#25-e mod
#161109-00085#25-s mod
#DEFINE l_xcbz          RECORD LIKE xcbz_t.*   #161109-00085#25-s mark
DEFINE l_xcbz          RECORD  #料件庫存量按帳套期統計檔
       xcbzent LIKE xcbz_t.xcbzent, #企業編號
       xcbzcomp LIKE xcbz_t.xcbzcomp, #法人組織
       xcbzld LIKE xcbz_t.xcbzld, #帳套
       xcbzsite LIKE xcbz_t.xcbzsite, #營運據點
       xcbz001 LIKE xcbz_t.xcbz001, #年度
       xcbz002 LIKE xcbz_t.xcbz002, #期別
       xcbz003 LIKE xcbz_t.xcbz003, #料件編號
       xcbz004 LIKE xcbz_t.xcbz004, #特性
       xcbz005 LIKE xcbz_t.xcbz005, #庫存管理特徵
       xcbz006 LIKE xcbz_t.xcbz006, #倉庫編碼
       xcbz007 LIKE xcbz_t.xcbz007, #儲位編號
       xcbz008 LIKE xcbz_t.xcbz008, #批號
       xcbz009 LIKE xcbz_t.xcbz009, #單位
       xcbz101 LIKE xcbz_t.xcbz101, #上期結存數量
       xcbz201 LIKE xcbz_t.xcbz201, #本期採購入庫數量
       xcbz202 LIKE xcbz_t.xcbz202, #本期委外入庫數量
       xcbz203 LIKE xcbz_t.xcbz203, #本期工單入庫數量
       xcbz204 LIKE xcbz_t.xcbz204, #本期重工領出數量
       xcbz205 LIKE xcbz_t.xcbz205, #本期重工入庫數量
       xcbz206 LIKE xcbz_t.xcbz206, #本期雜項入庫數量
       xcbz207 LIKE xcbz_t.xcbz207, #本期調整入庫數量
       xcbz208 LIKE xcbz_t.xcbz208, #本期銷退入庫數量
       xcbz209 LIKE xcbz_t.xcbz209, #本期其他入庫數量
       xcbz301 LIKE xcbz_t.xcbz301, #本期工單領用數量
       xcbz302 LIKE xcbz_t.xcbz302, #本期銷貨數量
       xcbz303 LIKE xcbz_t.xcbz303, #本期銷退數量
       xcbz304 LIKE xcbz_t.xcbz304, #本期雜發數量
       xcbz305 LIKE xcbz_t.xcbz305, #本期盤盈虧數量
       xcbz306 LIKE xcbz_t.xcbz306, #本期其他出庫數量
       xcbz901 LIKE xcbz_t.xcbz901  #期末結存數量
          END RECORD
#161109-00085#25-e mod
DEFINE l_sum           LIKE type_t.num10
DEFINE l_sum1          LIKE type_t.num10
DEFINE l_year          LIKE type_t.num5
DEFINE l_month         LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_qty           LIKE xcbz_t.xcbz101
DEFINE l_imaa006       LIKE imaa_t.imaa006
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_fin_6004      LIKE type_t.chr1
DEFINE l_fin_6006      LIKE type_t.chr1
DEFINE l_fin_6016      LIKE type_t.chr1
#160518-00033#4---add---s      
DEFINE l_inaj011       LIKE inaj_t.inaj011
DEFINE l_inajent       LIKE inaj_t.inajent
DEFINE l_inajsite      LIKE inaj_t.inajsite
DEFINE l_inaj001       LIKE inaj_t.inaj001
DEFINE l_inaj002       LIKE inaj_t.inaj002
DEFINE l_inaj003       LIKE inaj_t.inaj003
DEFINE l_inaj004       LIKE inaj_t.inaj004
#160518-00033#4---add---e         

    IF NOT axcp210_del_xcbz() THEN 
       LET g_success = 'N'
       RETURN
    END IF 
#找到上期
    CALL s_ld_sel_glaa(g_glaa_m.glaald,'glaa003') RETURNING  l_success,l_glaa003
    IF NOT l_success THEN
       LET g_success = 'N'
       RETURN
    END IF 
    
    CALL s_fin_date_get_last_period(l_glaa003,'',g_glaa_m.year,g_glaa_m.month)
         RETURNING l_success,l_year,l_month
    IF NOT l_success THEN
       LET g_success = 'N'
       RETURN
    END IF 
  
   IF NOT axcp210_create_tmp() THEN
       LET g_success = 'N'
       RETURN
   END IF

   DROP TABLE inaj_tmp    #170210-00035#1 add
   
   #160518-00033#4---mod---s
   #2.建立临时表inaj_tmp  -- 把需要运算的inaj全部放至inaj_tmp中     
  #LET g_sql = " SELECT inaj_t.* ", #161109-00085#63 mark
   #161109-00085#63 --s add
   LET g_sql = " SELECT inajent,inajsite,inaj001,inaj002,inaj003, ",
               "        inaj004,inaj005,inaj006,inaj007,inaj008, ",
               "        inaj009,inaj010,inaj011,inaj012,inaj013, ",
               "        inaj014,inaj015,inaj016,inaj017,inaj018, ",
               "        inaj019,inaj020,inaj021,inaj022,inaj023, ",
               "        inaj024,inaj025,inaj026,inaj027,inaj028, ",
               "        inaj036,inaj029,inaj030,inaj031,inaj032, ",
               "        inaj033,inaj034,inaj035,inaj037,inaj038, ",
               "        inaj039,inaj040,inaj041,inaj042,inaj043, ",
               "        inaj044,inaj200,inaj201,inaj202,inaj203, ",
               "        inaj204,inaj205,inaj206,inaj207,inaj208, ",
               "        inaj209,inajud001,inajud002,inajud003,inajud004, ",
               "        inajud005,inajud006,inajud007,inajud008,inajud009, ",
               "        inajud010,inajud011,inajud012,inajud013,inajud014, ",
               "        inajud015,inajud016,inajud017,inajud018,inajud019, ",
               "        inajud020,inajud021,inajud022,inajud023,inajud024, ",
               "        inajud025,inajud026,inajud027,inajud028,inajud029, ",
               "        inajud030,inaj045,inaj046,inaj047,inaj048, ",
               "        inaj049,inaj050,inaj051,inaj210,inaj211 ",   #161214-00026 remove ,
#               "        inaj052 ",            #161214-00026  mark
   #161109-00085#63 --e add
               "   FROM inaj_t,imaa_t ",
               "  WHERE inajent = imaaent AND imaa001 = inaj005 AND (inaj004 = '1' OR inaj004 = '-1')",
               "    AND inajent = '",g_enterprise,"' AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               "    AND inajsite IN ( SELECT ooef001 FROM ooef_t ",
               "                       WHERE ooefent = ",g_enterprise," AND ooef201 = 'Y' ",
              #"                         AND ooef003 = 'Y' AND ooef017 = '",g_glaa_m.glaacomp,"')",   #161008-00005#1 mark
               "                         AND ooef017 = '",g_glaa_m.glaacomp,"')",                     #161008-00005#1 add
               "    AND ",g_wc2 CLIPPED,
               "   INTO TEMP inaj_tmp "

   PREPARE axcp210_cre_tmp_inaj_p FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp210_cre_tmp_inaj_p"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN 
   END IF

   EXECUTE axcp210_cre_tmp_inaj_p
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp210_cre_tmp_inaj_p"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN 
   END IF

   FREE axcp210_cre_tmp_inaj_p
   DROP TABLE aooi250_tmp;     #161021-00027#1   
   CREATE TEMP TABLE aooi250_tmp(
   imaa001      VARCHAR(40),         #料件编号
   ooca002      VARCHAR(10),         #小数字数
   ooca004      VARCHAR(10)     #舍入类型
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create aooi250_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN         
   END IF
   LET l_sql = " INSERT INTO aooi250_tmp ",
               " SELECT DISTINCT inaj005,ooca002,ooca004 ",
               "   FROM inaj_tmp ",
               " INNER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001 ",
               " INNER JOIN ooca_t ON oocaent = imaaent AND ooca001 = imaa006 ",
               " WHERE ooca004 IN ('1','3','4')"
   PREPARE ins_aooi250_tmp FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE ins_aooi250_tmp"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN         
   END IF      
   EXECUTE ins_aooi250_tmp  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE ins_aooi250_tmp"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN         
   END IF       
   #160518-00033#4---mod---e

   LET g_success = 'Y'
   CALL s_transaction_begin()   #wujie 150512   
   CALL cl_err_collect_init() #汇总错误讯息初始化   #wujie 150512        
   DELETE FROM axcp210_tmp01             #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
   
   #160518-00033#4---mod---s
   LET l_sql = " MERGE INTO inaj_tmp a ",
               " USING (SELECT imaa001,ooca002,ooca004 FROM aooi250_tmp WHERE ooca004 = '1' ) b",
               "    ON (a.inaj005 = b.imaa001) ",
               "  WHEN MATCHED THEN ",            
               "UPDATE ",
               "   SET a.inaj011 = ROUND((a.inaj011*a.inaj048/a.inaj049),b.ooca002)"
   PREPARE upd_inaj011_1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE upd_inaj011_1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF   
   EXECUTE upd_inaj011_1   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE upd_inaj011_1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF 

   LET l_sql = " MERGE INTO inaj_tmp a ",
               " USING (SELECT imaa001,ooca002,ooca004 FROM aooi250_tmp WHERE ooca004 = '3' ) b",
               "    ON (a.inaj005 = b.imaa001) ",
               "  WHEN MATCHED THEN ",            
               "UPDATE ",
               "   SET a.inaj011 = TRUNC((a.inaj011*a.inaj048/a.inaj049),b.ooca002)"
   PREPARE upd_inaj011_3 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE upd_inaj011_3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF   
   EXECUTE upd_inaj011_3   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE upd_inaj011_3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF 
   
   LET l_sql = " MERGE INTO inaj_tmp a ",
               " USING (SELECT imaa001,ooca002,ooca004 FROM aooi250_tmp WHERE ooca004 = '4' ) b",
               "    ON (a.inaj005 = b.imaa001) ",
               "  WHEN MATCHED THEN ",            
               "UPDATE ",
               "   SET a.inaj011 = CEIL((a.inaj011*a.inaj048/a.inaj049)*POWER(10,b.ooca002))/POWER(10,b.ooca002)"
   PREPARE upd_inaj011_4 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE upd_inaj011_4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF   
   EXECUTE upd_inaj011_4   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE upd_inaj011_4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN            
   END IF    
   LET l_sql = " SELECT DISTINCT inajent,inajsite,inaj001,inaj002,inaj003,inaj004,(inaj011*inaj048/inaj049), ",
               "        (SELECT imaa006 FROM imaa_t WHERE imaaent = inajent AND imaa001 = inaj005) imaa006 ",
               "   FROM inaj_tmp ",
               "  WHERE NOT EXISTS(SELECT 1 FROM aooi250_tmp WHERE imaa001 = inaj005)"               
   PREPARE axcp210_upd_inaj011_p FROM l_sql
   DECLARE axcp210_upd_inaj011_c CURSOR FOR axcp210_upd_inaj011_p
   FOREACH axcp210_upd_inaj011_c INTO l_inajent,l_inajsite,l_inaj001,l_inaj002,
                                             l_inaj003,l_inaj004,l_inaj011,l_imaa006 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH axcp210_upd_inaj011_c'
         LET g_errparam.popup  = TRUE
         CALL cl_err()      
         LET g_success = 'N'          
      END IF         
      IF NOT cl_null(l_imaa006) AND NOT cl_null(l_inaj011) THEN
         CALL s_aooi250_take_decimals(l_imaa006,l_inaj011) RETURNING l_success,l_inaj011
      END IF
      UPDATE inaj_tmp
         SET inaj011 = l_inaj011
       WHERE inajent = l_inajent
         AND inajsite = l_inajsite
         AND inaj001 = l_inaj001 
         AND inaj002 = l_inaj002
         AND inaj003 = l_inaj003
         AND inaj004 = l_inaj004 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE inaj_tmp"
            LET g_errparam.popup  = TRUE       
            CALL cl_err()
            LET g_success = 'N' 
         END IF         
   END FOREACH    
   #160518-00033#4---mod---e   

   LET l_sql = " INSERT INTO axcp210_tmp01 ",      #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
               #160518-00033#4---mod---s   
               #" SELECT DISTINCT inajent,'','',inajsite,0,0,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,'',inaj036,0,",
               #"  NVL(CASE WHEN inaj036 = '102' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期採購入庫數量
               #"  NVL(CASE WHEN (inaj036 = '103' OR inaj036 = '104' OR inaj036 = '105' OR inaj036 = '106' OR inaj036 = '107') ",
               #"     THEN SUM(inaj004*inaj011*inaj014) END,0) ,",                               #本期委外入庫數量
               #"  NVL(CASE WHEN (inaj036 = '110' OR inaj036 = '111') THEN SUM(inaj004*inaj011*inaj014) END,0),",  #本期工單入庫數量
               #"  NVL(CASE WHEN inaj036 = '113' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期重工領出數量
               #"  NVL(CASE WHEN inaj036 = '114' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期重工入庫數量
               #"  NVL(CASE WHEN inaj036 = '101' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期雜項入庫數量
               #"  NVL(CASE WHEN (inaj036 = '115' OR inaj036 = '401') THEN SUM(inaj004*inaj011*inaj014) END,0),",  #本期調整入庫數量
               #"  NVL(CASE WHEN inaj036 = '202' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷退入庫數量
               #"  NVL(CASE WHEN inaj036 = '112' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期其他入庫數量
               #"  NVL(CASE WHEN (inaj036 = '302' OR inaj036 = '303') THEN SUM(inaj004*inaj011*inaj014) END,0),",  #本期工單領用數量
               #"  NVL(CASE WHEN inaj036 = '201' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷貨數量
               #"  NVL(CASE WHEN inaj036 = '304' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷退數量
               #"  NVL(CASE WHEN inaj036 = '301' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期雜發數量
               #"  NVL(CASE WHEN inaj036 = '501' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期盤盈虧數量
               #"  NVL(CASE WHEN (inaj036 = '108' OR inaj036 = '109') THEN SUM(inaj004*inaj011*inaj014) END,0),",  #本期其他出庫數量
               #"  0",
               #"   FROM inaj_t,imaa_t ",
               #"  WHERE inajent = imaaent AND imaa001 = inaj005 AND (inaj004 = '1' OR inaj004 = '-1')",
               #"    AND inajent = '",g_enterprise,"' AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               #"    AND inajsite IN ( SELECT ooef001 FROM ooef_t ",
               #"  WHERE ooefent = ",g_enterprise," AND ooef201 = 'Y' ",
               #"    AND ooef003 = 'Y' AND ooef017 = '",g_glaa_m.glaacomp,"')",
               #"    AND ",g_wc2 CLIPPED,               
               " SELECT DISTINCT inajent,'','',inajsite,0,0,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,'',inaj036,0,",
               "  NVL(CASE WHEN inaj036 = '102' THEN SUM(inaj004*inaj011) END,0),",     #本期採購入庫數量
               "  NVL(CASE WHEN (inaj036 = '103' OR inaj036 = '104' OR inaj036 = '105' OR inaj036 = '106' OR inaj036 = '107') ",
               "     THEN SUM(inaj004*inaj011) END,0) ,",                               #本期委外入庫數量
               "  NVL(CASE WHEN (inaj036 = '110' OR inaj036 = '111') THEN SUM(inaj004*inaj011) END,0),",  #本期工單入庫數量
               "  NVL(CASE WHEN inaj036 = '113' THEN SUM(inaj004*inaj011) END,0),",     #本期重工領出數量
               "  NVL(CASE WHEN inaj036 = '114' THEN SUM(inaj004*inaj011) END,0),",     #本期重工入庫數量
               "  NVL(CASE WHEN inaj036 = '101' THEN SUM(inaj004*inaj011) END,0),",     #本期雜項入庫數量
               "  NVL(CASE WHEN (inaj036 = '115' OR inaj036 = '401') THEN SUM(inaj004*inaj011) END,0),",  #本期調整入庫數量
               "  NVL(CASE WHEN inaj036 = '202' THEN SUM(inaj004*inaj011) END,0),",     #本期銷退入庫數量                        
               "  NVL(CASE WHEN inaj036 = '112' THEN SUM(inaj004*inaj011) END,0),",     #本期其他入庫數量
               "  NVL(CASE WHEN (inaj036 = '302' OR inaj036 = '303') THEN SUM(inaj004*inaj011) END,0),",  #本期工單領用數量
               "  NVL(CASE WHEN inaj036 = '201' THEN SUM(inaj004*inaj011) END,0),",     #本期銷貨數量
               "  NVL(CASE WHEN inaj036 = '304' THEN SUM(inaj004*inaj011) END,0),",     #本期銷退數量
               "  NVL(CASE WHEN inaj036 = '301' THEN SUM(inaj004*inaj011) END,0),",     #本期雜發數量
               "  NVL(CASE WHEN inaj036 = '501' THEN SUM(inaj004*inaj011) END,0),",     #本期盤盈虧數量
               "  NVL(CASE WHEN (inaj036 = '108' OR inaj036 = '109') THEN SUM(inaj004*inaj011) END,0),",  #本期其他出庫數量
               "  0",
               "  FROM inaj_tmp ",               
               #160518-00033#4---mod---s 
               " GROUP BY inajent,inajsite,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj036 ", 
               " ORDER BY inajent,inajsite,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj036 "

#预留今后需要看明细时使用
#   LET l_fin_6004 = cl_get_para(g_enterprise,g_glaa_m.glaacomp,'S-FIN-6004')   #雜項發料的取價方式 123
#   LET l_fin_6006 = cl_get_para(g_enterprise,g_glaa_m.glaacomp,'S-FIN-6006')   #銷退是否影響成本   123
#   LET l_fin_6016 = cl_get_para(g_enterprise,g_glaa_m.glaacomp,'S-FIN-6016')   #當站下線是否影響成本 Y/N
##参考小英的xcck055及xcck020说明文档调整xcbz各数量与inaj036的对应关系   
#   LET l_sql = " INSERT INTO axcp210_xcbz_tmp ",   
#               " SELECT DISTINCT inajent,'','',inajsite,0,0,inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,'',inaj036,B.sfaa042,B.sfaa010,B.sfaa011,B.xcbb006,A.xcbb006,0,",
#               "  NVL(CASE WHEN (inaj036 = '102' OR inaj036 = '108') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期採購入庫數量
#               "  NVL(CASE WHEN (inaj036 = '103' OR inaj036 = '104' OR inaj036 = '105' OR inaj036 = '106' OR inaj036 = '109') ",
#               "     THEN SUM(inaj004*inaj011*inaj014) END,0) ,",                               #本期委外入庫數量
#               "  NVL(CASE WHEN ((inaj036 = '110' OR inaj036 = '111' OR inaj036 = '112') AND B.sfaa042 = 'N') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期工單入庫數量
#               "  NVL(CASE WHEN ((inaj036 = '302' OR inaj036 = '303') AND B.sfaa042 = 'Y' AND B.xcbb006 >= A.xcbb006 ) ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期重工領出數量
#               "  NVL(CASE WHEN ((inaj036 = '110' OR inaj036 = '111' OR inaj036 = '112') AND B.sfaa042 = 'Y') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期重工入庫數量
#               "  NVL(CASE WHEN inaj036 = '101' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期雜項入庫數量
#               "  NVL(CASE WHEN (substr(inaj036,1,1) = '5') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期調整入庫數量
#               "  NVL(CASE WHEN (inaj036 = '202' AND ('",l_fin_6006,"' = '2' OR '",l_fin_6006,"' = '3'))",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷退入庫數量
#               "  NVL(CASE WHEN (inaj036 = '115' AND '",l_fin_6016,"' = 'Y') OR (inaj036 ='401' AND inaj004 = 1) ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期其他入庫數量
#               "  NVL(CASE WHEN (inaj036 = '107' OR inaj036 = '113' OR (inaj036 = '114' AND B.sfaa042 = 'N') ",
#               "                 OR (inaj036 = '115' AND '",l_fin_6016,"' = 'N') OR (inaj036 = '302' AND (B.sfaa042 = 'N' OR B.xcbb006 < A.xcbb006)) ",
#               "                 OR (inaj036 = '303' AND (B.sfaa042 = 'N' OR B.xcbb006 < A.xcbb006))) ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期工單領用數量
#               "  NVL(CASE WHEN inaj036 = '201' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷貨數量
#               "  NVL(CASE WHEN (inaj036 = '202' AND '",l_fin_6006,"' ='1') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期銷退數量
#               "  NVL(CASE WHEN (inaj036 = '301' OR inaj036 ='304') ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期雜發數量
#               "  NVL(CASE WHEN inaj036 = '501' THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期盤盈虧數量
#               "  NVL(CASE WHEN (inaj036 = '401' AND inaj004 =-1) ",
#               "                                THEN SUM(inaj004*inaj011*inaj014) END,0),",     #本期其他出庫數量
#               "  0",
#               "   FROM inaj_t LEFT OUTER JOIN ",
#               "               (SELECT sfaa_t.*,xcbb006 FROM sfaa_t,xcbb_t WHERE sfaaent = xcbbent AND sfaa010 = xcbb003 AND sfaa011 = xcbb004 ",
#               "                   AND xcbbcomp = '",g_glaa_m.glaacomp,"' AND xcbb001 = '",g_glaa_m.year,"' AND xcbb002 = '",g_glaa_m.month,"') B ",
#               "               ON inajent = sfaaent AND inaj020 = sfaadocno,",
#               "        imaa_t,xcbb_t A ",
#               "  WHERE inajent = imaaent AND imaa001 = inaj005 AND (inaj004 = '1' OR inaj004 = '-1')",
#               "    AND inajent = '",g_enterprise,"' AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               "    AND inajsite IN ( SELECT ooef001 FROM ooef_t ",
#               "  WHERE ooefent = ",g_enterprise," AND ooef201 = 'Y' ",
#               "    AND ooef003 = 'Y' AND ooef017 = '",g_glaa_m.glaacomp,"')",
#               "    AND inajent = A.xcbbent AND inaj005 = A.xcbb003 AND inaj006 = A.xcbb004 ",
#               "    AND A.xcbbcomp = '",g_glaa_m.glaacomp,"' AND A.xcbb001 = '",g_glaa_m.year,"' AND A.xcbb002 = '",g_glaa_m.month,"'",
#               "    AND ",g_wc2 CLIPPED,
#               " GROUP BY inajent,inajsite,inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj036,B.sfaa042,B.sfaa010,B.sfaa011,B.xcbb006,A.xcbb006 ", 
#               " ORDER BY inajent,inajsite,inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj036,B.sfaa042,B.sfaa010,B.sfaa011,B.xcbb006,A.xcbb006 "
               
   PREPARE axcp210_inaj_prep1 FROM l_sql
   EXECUTE axcp210_inaj_prep1

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET g_success = 'N'                                 
   END IF
      
#   LET l_sql = " INSERT INTO axcp210_xcbz_tmp ",   
#               " SELECT inajent,'','',inajsite,0,0,inaj005,inaj006,inaj008,inaj009,inaj010,0,0,",
#               "  0,0,0,0,0,0,0,0,0,0,0,0,0,SUM(inaj011),0,0",
#               "   FROM inaj_t,imaa_t ",
#               "  WHERE inajent = imaaent AND imaa001 = inaj005 AND inaj004 = '2' ",
#               "    AND inajent = '",g_enterprise,"' AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               "    AND inajsite IN ( SELECT ooef001 FROM ooef_t ",
#               "  WHERE ooefent = ",g_enterprise," AND ooef201 = 'Y' ",
#               "    AND ooef003 = 'Y' AND ooef017 = '",g_glaa_m.glaacomp,"')",
#               "    AND ",g_wc2 CLIPPED,
#               " GROUP BY inajent,inajsite,inaj005,inaj006,inaj008,inaj009,inaj010,0 ", 
#               " ORDER BY inajent,inajsite,inaj005,inaj006,inaj008,inaj009,inaj010,0 "
#                
#   PREPARE axcp210_inaj_prep2 FROM l_sql
#   EXECUTE axcp210_inaj_prep2
#   FREE axcp210_inaj_prep2

#以上是本期有异动的,再来插入有上期结存,但是本期无异动的
   LET l_sql = " INSERT INTO axcp210_tmp01 ",           #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
               " SELECT DISTINCT xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,",
               "        xcbz005,xcbz006,xcbz007,xcbz008,xcbz009,'',xcbz901,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0",
               "   FROM imaa_t,xcbz_t ",                       
               "  WHERE imaaent = xcbzent AND imaa001 = xcbz003 ",
               "    AND xcbzent = '",g_enterprise,"'",
               "    AND xcbz001 = '",l_year,"' AND xcbz002 = '",l_month,"'",
               "    AND xcbzld  = '",g_glaa_m.glaald,"'",
               "    AND ",g_wc2,
               "    AND NOT EXISTS (SELECT * FROM axcp210_tmp01 T1",         #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
               "                     WHERE T1.xcbzent = '",g_enterprise,"'",
               "                       AND T1.xcbzld  = '",g_glaa_m.glaald,"'",
               "                       AND T1.xcbzsite= xcbzsite ",
               "                       AND T1.xcbz001 = '",g_glaa_m.year,"'",
               "                       AND T1.xcbz002 = '",g_glaa_m.month,"'",
               "                       AND T1.xcbz003 = xcbz003 ",
               "                       AND T1.xcbz004 = xcbz004 ",
               "                       AND T1.xcbz005 = xcbz005 ",
               "                       AND T1.xcbz006 = xcbz006 ",
               "                       AND T1.xcbz007 = xcbz007 ",
               "                       AND T1.xcbz008 = xcbz008 ",
               "                       AND T1.xcbz009 = xcbz009 )"

   PREPARE axcp210_inag_prep FROM l_sql
   EXECUTE axcp210_inag_prep

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins tmp inag'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET g_success = 'N'                                   
   END IF

   UPDATE axcp210_tmp01 SET xcbzld = g_glaa_m.glaald,             #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
                                   xcbzcomp = g_glaa_m.glaacomp,
                                   xcbz001 = g_glaa_m.year,
                                   xcbz002 = g_glaa_m.month
 
  LET l_sql = " SELECT xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,xcbz007,xcbz008,xcbz009,SUM(xcbz101), ",
              "        SUM(xcbz201),SUM(xcbz202),SUM(xcbz203),SUM(xcbz204),SUM(xcbz205),SUM(xcbz206),SUM(xcbz207),",
              "        SUM(xcbz208),SUM(xcbz209),SUM(xcbz301),SUM(xcbz302),SUM(xcbz303),SUM(xcbz304),SUM(xcbz305), ",
              "        SUM(xcbz306),SUM(xcbz901) ",
              "        FROM axcp210_tmp01 ",          #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01
              " GROUP BY xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,xcbz007,xcbz008,xcbz009 ",
              " ORDER BY xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,xcbz007,xcbz008,xcbz009 "
   
   PREPARE axcp210_xcbz_prep1 FROM l_sql
   DECLARE axcp210_xcbz_curs1 CURSOR FOR axcp210_xcbz_prep1  
    
    #161109-00085#25-s mod   
#    FOREACH axcp210_xcbz_curs1 INTO l_xcbz.*   #161109-00085#25-s mark
     FOREACH axcp210_xcbz_curs1 INTO l_xcbz.xcbzent,l_xcbz.xcbzcomp,l_xcbz.xcbzld,l_xcbz.xcbzsite,l_xcbz.xcbz001,
                                     l_xcbz.xcbz002,l_xcbz.xcbz003,l_xcbz.xcbz004,l_xcbz.xcbz005,l_xcbz.xcbz006,
                                     l_xcbz.xcbz007,l_xcbz.xcbz008,l_xcbz.xcbz009,l_xcbz.xcbz101,l_xcbz.xcbz201,
                                     l_xcbz.xcbz202,l_xcbz.xcbz203,l_xcbz.xcbz204,l_xcbz.xcbz205,l_xcbz.xcbz206,
                                     l_xcbz.xcbz207,l_xcbz.xcbz208,l_xcbz.xcbz209,l_xcbz.xcbz301,l_xcbz.xcbz302,
                                     l_xcbz.xcbz303,l_xcbz.xcbz304,l_xcbz.xcbz305,l_xcbz.xcbz306,l_xcbz.xcbz901
    #161109-00085#25-e mod
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
      END IF    
    
       IF cl_null(l_xcbz.xcbz003) THEN LET l_xcbz.xcbz003 = " " END IF
       IF cl_null(l_xcbz.xcbz004) THEN LET l_xcbz.xcbz004 = " " END IF
       IF cl_null(l_xcbz.xcbz005) THEN LET l_xcbz.xcbz005 = " " END IF
       IF cl_null(l_xcbz.xcbz006) THEN LET l_xcbz.xcbz006 = " " END IF
#推算期初 
         SELECT xcbz901 INTO l_xcbz.xcbz101 FROM xcbz_t
          WHERE xcbzent = g_enterprise 
            AND xcbzsite= l_xcbz.xcbzsite
            AND xcbzld  = g_glaa_m.glaald 
            AND xcbz001 = l_year 
            AND xcbz002 = l_month
            AND xcbz003 = l_xcbz.xcbz003
            AND xcbz004 = l_xcbz.xcbz004
            AND xcbz005 = l_xcbz.xcbz005
            AND xcbz006 = l_xcbz.xcbz006
            AND xcbz007 = l_xcbz.xcbz007
            AND xcbz008 = l_xcbz.xcbz008
            AND xcbz009 = l_xcbz.xcbz009

                                
      IF l_xcbz.xcbz101 IS NULL THEN  LET l_xcbz.xcbz101 = 0 END IF
      IF l_xcbz.xcbz201 IS NULL THEN  LET l_xcbz.xcbz201 = 0 END IF
      IF l_xcbz.xcbz202 IS NULL THEN  LET l_xcbz.xcbz202 = 0 END IF
      IF l_xcbz.xcbz203 IS NULL THEN  LET l_xcbz.xcbz203 = 0 END IF
      IF l_xcbz.xcbz204 IS NULL THEN  LET l_xcbz.xcbz204 = 0 END IF
      IF l_xcbz.xcbz205 IS NULL THEN  LET l_xcbz.xcbz205 = 0 END IF
      IF l_xcbz.xcbz206 IS NULL THEN  LET l_xcbz.xcbz206 = 0 END IF
      IF l_xcbz.xcbz207 IS NULL THEN  LET l_xcbz.xcbz207 = 0 END IF
      IF l_xcbz.xcbz208 IS NULL THEN  LET l_xcbz.xcbz208 = 0 END IF
      IF l_xcbz.xcbz209 IS NULL THEN  LET l_xcbz.xcbz209 = 0 END IF
      IF l_xcbz.xcbz301 IS NULL THEN  LET l_xcbz.xcbz301 = 0 END IF
      IF l_xcbz.xcbz302 IS NULL THEN  LET l_xcbz.xcbz302 = 0 END IF
      IF l_xcbz.xcbz303 IS NULL THEN  LET l_xcbz.xcbz303 = 0 END IF
      IF l_xcbz.xcbz304 IS NULL THEN  LET l_xcbz.xcbz304 = 0 END IF
      IF l_xcbz.xcbz305 IS NULL THEN  LET l_xcbz.xcbz305 = 0 END IF
      IF l_xcbz.xcbz306 IS NULL THEN  LET l_xcbz.xcbz306 = 0 END IF

      LET l_imaa006 = NULL
      SELECT DISTINCT imaa006 INTO l_imaa006 FROM imaa_t
       WHERE imaaent  = g_enterprise
         AND imaa001  = l_xcbz.xcbz003  #料件

      IF NOT cl_null(l_xcbz.xcbz009) AND l_xcbz.xcbz009 <> l_imaa006 THEN 
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz101)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz101 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz201)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz201 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz202)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz202 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz203)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz203 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz204)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz204 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz205)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz205 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz206)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz206 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz207)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz207 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF       
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz208)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz208 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz209)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz209 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz301)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz301 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz302)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz302 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz303)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz303 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz304)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz304 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz305)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz305 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
         
         CALL s_aooi250_convert_qty(l_xcbz.xcbz003,l_xcbz.xcbz009,l_imaa006,l_xcbz.xcbz306)
              RETURNING l_success,l_qty      
         IF l_success THEN
            LET l_xcbz.xcbz306 = l_qty
         ELSE
            LET g_success = 'N'
            EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH
         END IF 
               
      END IF 
      LET l_xcbz.xcbz009 = l_imaa006      
#推算期末
      LET l_xcbz.xcbz901 = l_xcbz.xcbz101 + l_xcbz.xcbz201 + l_xcbz.xcbz202 + l_xcbz.xcbz203 + l_xcbz.xcbz204 + l_xcbz.xcbz205
                         + l_xcbz.xcbz206 + l_xcbz.xcbz207 + l_xcbz.xcbz208 + l_xcbz.xcbz209 
                         + l_xcbz.xcbz301 + l_xcbz.xcbz302 + l_xcbz.xcbz303 + l_xcbz.xcbz304 + l_xcbz.xcbz305 + l_xcbz.xcbz306
      #161109-00085#25-s mod
#      INSERT INTO xcbz_t VALUES l_xcbz.*   #161109-00085#25-s mark
      INSERT INTO xcbz_t (xcbzent,xcbzcomp,xcbzld,xcbzsite,xcbz001,xcbz002,xcbz003,xcbz004,xcbz005,xcbz006,
                          xcbz007,xcbz008,xcbz009,xcbz101,xcbz201,xcbz202,xcbz203,xcbz204,xcbz205,xcbz206,
                          xcbz207,xcbz208,xcbz209,xcbz301,xcbz302,xcbz303,xcbz304,xcbz305,xcbz306,xcbz901) 
                  VALUES (l_xcbz.xcbzent,l_xcbz.xcbzcomp,l_xcbz.xcbzld,l_xcbz.xcbzsite,l_xcbz.xcbz001,l_xcbz.xcbz002,
                          l_xcbz.xcbz003,l_xcbz.xcbz004,l_xcbz.xcbz005,l_xcbz.xcbz006,l_xcbz.xcbz007,l_xcbz.xcbz008,
                          l_xcbz.xcbz009,l_xcbz.xcbz101,l_xcbz.xcbz201,l_xcbz.xcbz202,l_xcbz.xcbz203,l_xcbz.xcbz204,
                          l_xcbz.xcbz205,l_xcbz.xcbz206,l_xcbz.xcbz207,l_xcbz.xcbz208,l_xcbz.xcbz209,l_xcbz.xcbz301,
                          l_xcbz.xcbz302,l_xcbz.xcbz303,l_xcbz.xcbz304,l_xcbz.xcbz305,l_xcbz.xcbz306,l_xcbz.xcbz901)
      #161109-00085#25-e mod

      IF cl_err_sql_dup_value(SQLCA.sqlcode) THEN   #若重复插入则更新
         UPDATE xcbz_t SET xcbz101 = xcbz101 + l_xcbz.xcbz101,
                           xcbz201 = xcbz201 + l_xcbz.xcbz201,
                           xcbz202 = xcbz202 + l_xcbz.xcbz202,
                           xcbz203 = xcbz203 + l_xcbz.xcbz203,
                           xcbz204 = xcbz204 + l_xcbz.xcbz204,
                           xcbz205 = xcbz205 + l_xcbz.xcbz205,
                           xcbz206 = xcbz206 + l_xcbz.xcbz206,
                           xcbz207 = xcbz207 + l_xcbz.xcbz207,
                           xcbz208 = xcbz208 + l_xcbz.xcbz208,
                           xcbz209 = xcbz209 + l_xcbz.xcbz209,
                           xcbz301 = xcbz301 + l_xcbz.xcbz301,
                           xcbz302 = xcbz302 + l_xcbz.xcbz302,
                           xcbz303 = xcbz303 + l_xcbz.xcbz303,
                           xcbz304 = xcbz304 + l_xcbz.xcbz304,
                           xcbz305 = xcbz305 + l_xcbz.xcbz305,
                           xcbz306 = xcbz306 + l_xcbz.xcbz306,
                           xcbz901 = xcbz901 + l_xcbz.xcbz901
          WHERE xcbzent  = l_xcbz.xcbzent
            AND xcbzld   = l_xcbz.xcbzld
            AND xcbzsite = l_xcbz.xcbzsite
            AND xcbz001  = l_xcbz.xcbz001
            AND xcbz002  = l_xcbz.xcbz002
            AND xcbz003  = l_xcbz.xcbz003
            AND xcbz004  = l_xcbz.xcbz004
            AND xcbz005  = l_xcbz.xcbz005
            AND xcbz006  = l_xcbz.xcbz006
            AND xcbz007  = l_xcbz.xcbz007
            AND xcbz008  = l_xcbz.xcbz008
            AND xcbz009  = l_xcbz.xcbz009

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'upd xcbz'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               
               LET g_success = 'N'
               EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH                                 
            END IF
         
      END IF
      IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins xcbz'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET g_success = 'N'
         EXIT FOREACH    #wujie 150512 RETURN --> EXIT FOREACH                          
      END IF
    END FOREACH
    CALL cl_progress_no_window_ing("ins xcbz")
   CALL cl_err_showmsg()
   #結束事務
#wujie 150512 --begin
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
#wujie 150512 --end
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
PRIVATE FUNCTION axcp210_del_xcbz()
   DEFINE l_cnt         LIKE type_t.num10   #num5 -->num10
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM xcbz_t
       WHERE xcbzent = g_enterprise 
         AND xcbz001 = g_glaa_m.year 
         AND xcbz002 = g_glaa_m.month
         AND xcbzld  = g_glaa_m.glaald
         AND xcbzcomp = g_glaa_m.glaacomp
         
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('axc-00624') THEN   #是否更新
         DELETE FROM xcbz_t 
          WHERE xcbzent = g_enterprise 
            AND xcbz001 = g_glaa_m.year 
            AND xcbz002 = g_glaa_m.month
            AND xcbzld  = g_glaa_m.glaald
            AND xcbzcomp = g_glaa_m.glaacomp
            
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00266'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF
      ELSE
         LET r_success = FALSE
      END IF
   END IF
   CALL cl_progress_no_window_ing("delete xcbz")
   RETURN r_success
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
PRIVATE FUNCTION axcp210_create_tmp()
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
 
   DROP TABLE axcp210_tmp01            #160727-00019#20 Mod  axcp210_xcbz_tmp--> axcp210_tmp01

   CREATE TEMP TABLE axcp210_tmp01     
   (
   xcbzent  SMALLINT,
   xcbzcomp  VARCHAR(10),
   xcbzld  VARCHAR(5),
   xcbzsite  VARCHAR(10),
   xcbz001  SMALLINT,              #年度
   xcbz002  SMALLINT,              #期別
#   inaj004 DECIMAL(5,0),               #出入库码
   xcbz003  VARCHAR(40),              #料件編號
   xcbz004  VARCHAR(256),              #特性
   xcbz005  VARCHAR(30),              #庫存管理特徵
   xcbz006  VARCHAR(10),              #倉庫編碼
   xcbz007  VARCHAR(10),              #儲位編號
   xcbz008  VARCHAR(30),              #批號
   xcbz009  VARCHAR(10),              #單位
   inaj036  VARCHAR(10),              #庫存異動類型 
#   sfaa042 VARCHAR(1),                 #重工否
#   sfaa010 VARCHAR(40),                #主件料號
#   sfaa011 VARCHAR(30),                #主件特征
#   b_xcbb006 DECIMAL(5,0),             #主件成本阶
#   a_xcbb006 DECIMAL(5,0),             #发料料号成本阶
   xcbz101  DECIMAL(20,6),              #上期結存數量
   xcbz201  DECIMAL(20,6),              #本期採購入庫數量
   xcbz202  DECIMAL(20,6),              #本期委外入庫數量
   xcbz203  DECIMAL(20,6),              #本期工單入庫數量
   xcbz204  DECIMAL(20,6),              #本期重工領出數量
   xcbz205  DECIMAL(20,6),              #本期重工入庫數量
   xcbz206  DECIMAL(20,6),              #本期雜項入庫數量
   xcbz207  DECIMAL(20,6),              #本期調整入庫數量
   xcbz208  DECIMAL(20,6),              #本期銷退入庫數量
   xcbz209  DECIMAL(20,6),              #本期其他入庫數量
   xcbz301  DECIMAL(20,6),              #本期工單領用數量
   xcbz302  DECIMAL(20,6),              #本期銷貨數量
   xcbz303  DECIMAL(20,6),              #本期銷退數量
   xcbz304  DECIMAL(20,6),              #本期雜發數量
   xcbz305  DECIMAL(20,6),              #本期盤盈虧數量
   xcbz306  DECIMAL(20,6),              #本期其他出庫數量
   xcbz901  DECIMAL(20,6)     #期末結存數量
    );
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success                                    
   END IF
   
   CALL cl_progress_no_window_ing("create tmp table")
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2016/10/20 By 02295
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp210_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   IF cl_null(g_glaa_m.glaacomp) THEN RETURN END IF

   IF cl_null(g_glaa_m.year) THEN RETURN END IF

   IF cl_null(g_glaa_m.month) THEN RETURN END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_glaa_m.glaacomp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > g_glaa_m.year THEN
      LET g_errno = 'axc-00303'
   END IF

   #IF l_yy <= g_glaa_m.year AND l_pp > g_glaa_m.month THEN   #161117-00031#1 mark
   IF l_yy = g_glaa_m.year AND l_pp > g_glaa_m.month THEN   #161117-00031#1 
      LET g_errno = 'axc-00304'
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
