#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcp700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-08-01 17:50:04), PR版次:0007(2017-02-28 15:38:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000004
#+ Filename...: aqcp700
#+ Description: 檢驗清單批次產生作業
#+ Creator....: 04543(2016-08-01 17:33:57)
#+ Modifier...: 04543 -SD/PR- 05423
 
{</section>}
 
{<section id="aqcp700.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161124-00048#10  2016/12/13  By xujing     整批调整系统RECORD LIKE xxxx_t.* 星号写法
#170120-00042#1   2017/01/20  By xujing     调整sql没有ent的问题
#170207-00018#3   2017/02/10  By 08734      ROWNUM整批调整
#170217-00025#6   2017/02/28  By zhujing    整批调整未产生数据时，提示消息修正。
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
       imae001 LIKE imae_t.imae001, 
   imaa009 LIKE imaa_t.imaa009, 
   imae111 LIKE imae_t.imae111, 
   checkbox_IQC LIKE type_t.chr500, 
   checkbox_FQC LIKE type_t.chr500, 
   checkbox_PQC LIKE type_t.chr500, 
   checkbox_OQC LIKE type_t.chr500, 
   checkbox_InvQC LIKE type_t.chr500, 
   checkbox_RQC LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#DEFINE g_qcbo        RECORD LIKE qcbo_t.* #161124-00048#10 mark
#161124-00048#10 add(s)
DEFINE g_qcbo RECORD  #待驗清單單頭檔
       qcboent LIKE qcbo_t.qcboent, #企业编号
       qcbosite LIKE qcbo_t.qcbosite, #营运据点
       qcbo001 LIKE qcbo_t.qcbo001, #检验类型
       qcbo002 LIKE qcbo_t.qcbo002, #来源单号
       qcbo003 LIKE qcbo_t.qcbo003, #来源项次
       qcbo004 LIKE qcbo_t.qcbo004, #RUNCARD
       qcbo005 LIKE qcbo_t.qcbo005, #参考单号
       qcbo006 LIKE qcbo_t.qcbo006, #参考单项次
       qcbo007 LIKE qcbo_t.qcbo007, #交易对象编号
       qcbo008 LIKE qcbo_t.qcbo008, #作业编号
       qcbo009 LIKE qcbo_t.qcbo009, #加工序
       qcbo010 LIKE qcbo_t.qcbo010, #来源数量
       qcbo011 LIKE qcbo_t.qcbo011, #单位
       qcbo012 LIKE qcbo_t.qcbo012, #料件编号
       qcbo013 LIKE qcbo_t.qcbo013, #版本
       qcbo014 LIKE qcbo_t.qcbo014, #产品特征
       qcbo015 LIKE qcbo_t.qcbo015, #品管分群
       qcbo016 LIKE qcbo_t.qcbo016, #检验程度
       qcbo017 LIKE qcbo_t.qcbo017, #检验级数
       qcbo018 LIKE qcbo_t.qcbo018, #承认文号
       qcbo019 LIKE qcbo_t.qcbo019, #类型分类
       qcbo020 LIKE qcbo_t.qcbo020, #当前检验人员
       qcbo021 LIKE qcbo_t.qcbo021, #开始检验日期
       qcbo022 LIKE qcbo_t.qcbo022, #开始检验时间
       qcbo023 LIKE qcbo_t.qcbo023, #紧急度
       qcbo024 LIKE qcbo_t.qcbo024 #检验项目识别码
END RECORD
#161124-00048#10 add(e)
#DEFINE g_qcbp        RECORD LIKE qcbp_t.*   #161124-00048#10 mark
#161124-00048#10 add(s)
DEFINE g_qcbp RECORD  #待驗清單單身檔
       qcbpent LIKE qcbp_t.qcbpent, #企业编号
       qcbpsite LIKE qcbp_t.qcbpsite, #营运据点
       qcbp001 LIKE qcbp_t.qcbp001, #检验类型
       qcbp002 LIKE qcbp_t.qcbp002, #来源单号
       qcbp003 LIKE qcbp_t.qcbp003, #来源项次
       qcbp004 LIKE qcbp_t.qcbp004, #RUNCARD
       qcbp005 LIKE qcbp_t.qcbp005, #行序
       qcbp006 LIKE qcbp_t.qcbp006, #检验项目
       qcbp007 LIKE qcbp_t.qcbp007, #检验位置
       qcbp008 LIKE qcbp_t.qcbp008, #缺点等级
       qcbp009 LIKE qcbp_t.qcbp009, #AQL
       qcbp010 LIKE qcbp_t.qcbp010, #允收数
       qcbp011 LIKE qcbp_t.qcbp011, #拒绝数
       qcbp012 LIKE qcbp_t.qcbp012, #K法标准值
       qcbp013 LIKE qcbp_t.qcbp013, #F法标准值
       qcbp014 LIKE qcbp_t.qcbp014, #抽验量
       qcbp015 LIKE qcbp_t.qcbp015, #规范上限
       qcbp016 LIKE qcbp_t.qcbp016, #检验上限
       qcbp017 LIKE qcbp_t.qcbp017, #检验标准值
       qcbp018 LIKE qcbp_t.qcbp018, #检验下限
       qcbp019 LIKE qcbp_t.qcbp019, #规范下限
       qcbp020 LIKE qcbp_t.qcbp020, #计量单位
       qcbp021 LIKE qcbp_t.qcbp021, #检验规格说明
       qcbp022 LIKE qcbp_t.qcbp022 #抽样计划
END RECORD
#161124-00048#10 add(e)
DEFINE g_qcaz001     LIKE qcaz_t.qcaz001
DEFINE g_imae116     LIKE imae_t.imae116
DEFINE g_flag        LIKE type_t.num5     #170217-00025#6 add 记录是否异动
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aqcp700.main" >}
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
   CALL cl_ap_init("aqc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aqcp700_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcp700 WITH FORM cl_ap_formpath("aqc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aqcp700_init()
 
      #進入選單 Menu (="N")
      CALL aqcp700_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aqcp700
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aqcp700.init" >}
#+ 初始化作業
PRIVATE FUNCTION aqcp700_init()
 
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
 
{<section id="aqcp700.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcp700_ui_dialog()
 
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
         INPUT BY NAME g_master.checkbox_IQC,g_master.checkbox_FQC,g_master.checkbox_PQC,g_master.checkbox_OQC, 
             g_master.checkbox_InvQC,g_master.checkbox_RQC 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_IQC
            #add-point:BEFORE FIELD checkbox_IQC name="input.b.checkbox_IQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_IQC
            
            #add-point:AFTER FIELD checkbox_IQC name="input.a.checkbox_IQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_IQC
            #add-point:ON CHANGE checkbox_IQC name="input.g.checkbox_IQC"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_FQC
            #add-point:BEFORE FIELD checkbox_FQC name="input.b.checkbox_FQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_FQC
            
            #add-point:AFTER FIELD checkbox_FQC name="input.a.checkbox_FQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_FQC
            #add-point:ON CHANGE checkbox_FQC name="input.g.checkbox_FQC"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_PQC
            #add-point:BEFORE FIELD checkbox_PQC name="input.b.checkbox_PQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_PQC
            
            #add-point:AFTER FIELD checkbox_PQC name="input.a.checkbox_PQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_PQC
            #add-point:ON CHANGE checkbox_PQC name="input.g.checkbox_PQC"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_OQC
            #add-point:BEFORE FIELD checkbox_OQC name="input.b.checkbox_OQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_OQC
            
            #add-point:AFTER FIELD checkbox_OQC name="input.a.checkbox_OQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_OQC
            #add-point:ON CHANGE checkbox_OQC name="input.g.checkbox_OQC"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_InvQC
            #add-point:BEFORE FIELD checkbox_InvQC name="input.b.checkbox_InvQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_InvQC
            
            #add-point:AFTER FIELD checkbox_InvQC name="input.a.checkbox_InvQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_InvQC
            #add-point:ON CHANGE checkbox_InvQC name="input.g.checkbox_InvQC"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_RQC
            #add-point:BEFORE FIELD checkbox_RQC name="input.b.checkbox_RQC"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_RQC
            
            #add-point:AFTER FIELD checkbox_RQC name="input.a.checkbox_RQC"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_RQC
            #add-point:ON CHANGE checkbox_RQC name="input.g.checkbox_RQC"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.checkbox_IQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_IQC
            #add-point:ON ACTION controlp INFIELD checkbox_IQC name="input.c.checkbox_IQC"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_FQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_FQC
            #add-point:ON ACTION controlp INFIELD checkbox_FQC name="input.c.checkbox_FQC"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_PQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_PQC
            #add-point:ON ACTION controlp INFIELD checkbox_PQC name="input.c.checkbox_PQC"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_OQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_OQC
            #add-point:ON ACTION controlp INFIELD checkbox_OQC name="input.c.checkbox_OQC"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_InvQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_InvQC
            #add-point:ON ACTION controlp INFIELD checkbox_InvQC name="input.c.checkbox_InvQC"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_RQC
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_RQC
            #add-point:ON ACTION controlp INFIELD checkbox_RQC name="input.c.checkbox_RQC"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imae001,imaa009,imae111
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae001
            #add-point:ON ACTION controlp INFIELD imae001 name="construct.c.imae001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae001  #顯示到畫面上
            NEXT FIELD imae001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae001
            #add-point:BEFORE FIELD imae001 name="construct.b.imae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae001
            
            #add-point:AFTER FIELD imae001 name="construct.a.imae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:3)
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
            
 
 
         #Ctrlp:construct.c.imae111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae111
            #add-point:ON ACTION controlp INFIELD imae111 name="construct.c.imae111"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcg111()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae111  #顯示到畫面上
            NEXT FIELD imae111                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae111
            #add-point:BEFORE FIELD imae111 name="construct.b.imae111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae111
            
            #add-point:AFTER FIELD imae111 name="construct.a.imae111"
            
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
            CALL aqcp700_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.checkbox_IQC = 'Y'
            LET g_master.checkbox_FQC = 'Y'
            LET g_master.checkbox_PQC = 'Y'
            LET g_master.checkbox_OQC = 'Y'
            LET g_master.checkbox_InvQC = 'Y'
            LET g_master.checkbox_RQC = 'Y'
            DISPLAY BY NAME g_master.*
            
            LET g_qcaz001 = cl_get_para(g_enterprise,g_site,'S-MFG-0046')
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
         CALL aqcp700_init()
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
                 CALL aqcp700_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aqcp700_transfer_argv(ls_js)
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
 
{<section id="aqcp700.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aqcp700_transfer_argv(ls_js)
 
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
 
{<section id="aqcp700.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aqcp700_process(ls_js)
 
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
   
   CALL s_transaction_begin()
   LET g_flag = FALSE   #170217-00025#6
   IF aqcp700_select(lc_param.wc) THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   #170217-00025#6 add-S
   IF g_flag = FALSE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code = 'sub-00491'   #無資料產生
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN  
   END IF      
   #170217-00025#6 add-E
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aqcp700_process_cs CURSOR FROM ls_sql
#  FOREACH aqcp700_process_cs INTO
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
   CALL aqcp700_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aqcp700.get_buffer" >}
PRIVATE FUNCTION aqcp700_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.checkbox_IQC = p_dialog.getFieldBuffer('checkbox_IQC')
   LET g_master.checkbox_FQC = p_dialog.getFieldBuffer('checkbox_FQC')
   LET g_master.checkbox_PQC = p_dialog.getFieldBuffer('checkbox_PQC')
   LET g_master.checkbox_OQC = p_dialog.getFieldBuffer('checkbox_OQC')
   LET g_master.checkbox_InvQC = p_dialog.getFieldBuffer('checkbox_InvQC')
   LET g_master.checkbox_RQC = p_dialog.getFieldBuffer('checkbox_RQC')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aqcp700.msgcentre_notify" >}
PRIVATE FUNCTION aqcp700_msgcentre_notify()
 
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
 
{<section id="aqcp700.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: select資料
# Memo...........:
# Usage..........: CALL aqcp700_select(p_wc)
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 160805 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcp700_select(p_wc)
   DEFINE p_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_date         LIKE type_t.dat
   DEFINE l_docno        LIKE type_t.chr20
   DEFINE l_cnt          LIKE type_t.num10
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_slip         LIKE ooba_t.ooba002
   DEFINE lc_para_data   LIKE type_t.chr80
   LET l_sql = ""
   
   LET r_success = TRUE
   
   #IQC
   IF g_master.checkbox_IQC = 'Y' THEN
      #收貨
      LET l_sql = "SELECT '1',pmdtdocno,pmdtseq,0,pmdt001,",
                  "       pmdt002,pmds007,TO_CHAR(''),TO_CHAR(''),cnt,",
                  "       pmdt019,pmdt006,pmdt007,imae111,",
                  "       TO_CHAR(''),TO_DATE(''),TO_CHAR(''),imae116",
                  "  FROM (SELECT pmdtent,pmdtsite,",
                  "               pmdtdocno,pmdtseq,pmdt001,",
                  "               pmdt002,pmds007,",
                  "               pmdt019,pmdt006,pmdt007,",
                  "               pmdt020 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = pmdtent",
                  "                                      AND qcbasite = pmdtsite",
                  "                                      AND qcba000 = '1'",
                  "                                      AND COALESCE(qcba031,' ') = ' '",
                  "                                      AND qcba001 = pmdtdocno",
                  "                                      AND qcba002 = pmdtseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM pmds_t,pmdt_t",
                  "         WHERE pmdtent = pmdsent AND pmdsent = ",g_enterprise,
                  "           AND pmdtdocno = pmdsdocno",
                  "           AND pmdssite = '",g_site,"'",
                  "           AND pmdsstus = 'Y'",
                  "           AND pmds000 IN ('1','2')",
                  "           AND pmdt026 = 'Y'",
                  "       )",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = pmdtent AND imaa001 = pmdt006",
                  "       LEFT OUTER JOIN imae_t ON imaeent = pmdtent AND imaesite = pmdtsite AND imae001 = pmdt006",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = pmdtent",
                  "                      AND qcbosite = pmdtsite",
                  "                      AND qcbo001 = '1'",
                  "                      AND qcbo002 = pmdtdocno",
                  "                      AND qcbo003 = pmdtseq",
                  "                      AND COALESCE(qcbo004,0) = 0)"
   END IF

   #FQC
   IF g_master.checkbox_FQC = 'Y' THEN
      IF NOT cl_null(l_sql) THEN
         LET l_sql = l_sql," UNION ALL "
      END IF
      
      #工單完工入庫
      LET l_sql = l_sql,
                  "SELECT '2',sfebdocno,sfebseq,0,sfeb001,",
                  "       TO_NUMBER(''),sfaa009,TO_CHAR(''),TO_CHAR(''),cnt,",
                  "       sfeb007,sfeb004,sfeb005,imae111,",
                  "       TO_CHAR(''),sfaa020,TO_CHAR(''),imae116",
                  "  FROM (SELECT sfebent,sfebsite,",
                  "               sfebdocno,sfebseq,sfeb001,",
                  "               sfeb007,sfeb004,sfeb005,",
                  "               sfeb008 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = sfebent",
                  "                                      AND qcbasite = sfebsite",
                  "                                      AND qcba000 = '2'",
                  "                                      AND COALESCE(qcba031,' ') = ' '",
                  "                                      AND qcba001 = sfebdocno",
                  "                                      AND qcba002 = sfebseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM sfea_t,sfeb_t",
                  "         WHERE sfebent = sfeaent AND sfeaent = ",g_enterprise,
                  "           AND sfebdocno = sfeadocno",
                  "           AND sfeasite = '",g_site,"'",
                  "           AND sfeastus = 'Y'",
                  "           AND sfea006 IS NULL",
                  "           AND sfeb002 = 'Y'",
                  "       )",
                  "       LEFT OUTER JOIN sfaa_t ON sfaaent = sfebent AND sfaadocno = sfeb001",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = sfebent AND imaa001 = sfeb004",
                  "       LEFT OUTER JOIN imae_t ON imaeent = sfebent AND imaesite = sfebsite AND imae001 = sfeb004",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = sfebent",
                  "                      AND qcbosite = sfebsite",
                  "                      AND qcbo001 = '2'",
                  "                      AND qcbo002 = sfebdocno",
                  "                      AND qcbo003 = sfebseq",
                  "                      AND COALESCE(qcbo004,0) = 0)"
   END IF

   #PQC
   IF g_master.checkbox_PQC = 'Y' THEN
      IF NOT cl_null(l_sql) THEN
         LET l_sql = l_sql," UNION ALL "
      END IF
      
      #工單製程
      LET l_sql = l_sql,
                  "SELECT '3',sfcbdocno,sfcb002,sfcb001,sfaa006,",
                  "       sfaa007,sfaa009,sfcb003,sfcb004,cnt,",
                  "       sfcb052,sfaa010,TO_CHAR(''),imae111,",
                  "       TO_CHAR(''),sfcb045,TO_CHAR(''),imae116",
                  "  FROM (SELECT sfcbent,sfcbsite,",
                  "               sfcbdocno,sfcb002,sfcb001,",
                  "               sfcb003,sfcb004,",
                  "               sfcb052,",
                  "               sfcb045,",
                  "               sfcb050 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = sfcbent",
                  "                                      AND qcbasite = sfcbsite",
                  "                                      AND qcba000 = '3'",
                  "                                      AND COALESCE(qcba031,' ') = ' '",
                  "                                      AND qcba001 = sfcbdocno",
                  "                                      AND qcba002 = sfcb002",
                  "                                      AND COALESCE(qcba029,0) = sfcb001",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM sfca_t,sfcb_t",
                  "         WHERE sfcbent = sfcaent AND sfcaent = ",g_enterprise,
                  "           AND sfcbdocno = sfcadocno",
                  "           AND sfcb001 = sfca001",
                  "           AND sfcasite = '",g_site,"'",
                  "           AND sfcb017 = 'Y'",
                  "           AND sfcb050 > 0",
                  "       )",
                  "       LEFT OUTER JOIN sfaa_t ON sfaaent = sfcbent AND sfaadocno = sfcbdocno AND sfaastus = 'F'",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = sfcbent AND imaa001 = sfaa010",
                  "       LEFT OUTER JOIN imae_t ON imaeent = sfcbent AND imaesite = sfcbsite AND imae001 = sfaa010",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = sfcbent",
                  "                      AND qcbosite = sfcbsite",
                  "                      AND qcbo001 = '3'",
                  "                      AND qcbo002 = sfcbdocno",
                  "                      AND qcbo003 = sfcb002",
                  "                      AND COALESCE(qcbo004,0) = sfcb001)"
   END IF

   #OCQ
   IF g_master.checkbox_OQC = 'Y' THEN
      IF NOT cl_null(l_sql) THEN
         LET l_sql = l_sql," UNION ALL "
      END IF
      
      #出貨
      LET l_sql = l_sql,
                  "SELECT '4',xmdldocno,xmdlseq,0,xmdl001,",
                  "       xmdl002,xmdk007,TO_CHAR(''),TO_CHAR(''),cnt,",
                  "       xmdl017,xmdl008,xmdl009,imae111,",
                  "       type,xmdd011,xmdddocno,imae116",
                  "  FROM (SELECT xmdlent,xmdlsite,",
                  "               xmdldocno,xmdlseq,xmdl001,",
                  "               xmdl002,xmdk007,",
                  "               xmdl017,xmdl008,xmdl009,",
                  "               '2' type,xmdd011,xmdddocno,",
                  "               xmdl018 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = xmdlent",
                  "                                      AND qcbasite = xmdlsite",
                  "                                      AND qcba000 = '4'",
                  "                                      AND COALESCE(qcba031,' ') = '2'",
                  "                                      AND qcba001 = xmdldocno",
                  "                                      AND qcba002 = xmdlseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM xmdk_t,xmdl_t",
                  "          LEFT OUTER JOIN xmdd_t ON xmddent = xmdlent AND xmdddocno = xmdl003 AND xmddseq = xmdl004 AND xmddseq1 = xmdl005 AND xmddseq2 = xmdl006",
                  "         WHERE xmdlent = xmdkent AND xmdkent = ",g_enterprise,
                  "           AND xmdldocno = xmdkdocno",
                  "           AND xmdksite = '",g_site,"'",
                  "           AND xmdkstus = 'Y'",
                  "           AND xmdk000 = '1'",
                  "           AND xmdk002 <> '2'",
                  "           AND xmdl023 = 'Y'",
                  
                  "         UNION ALL ",
      #出通 
                  "        SELECT xmdhent,xmdhsite,",
                  "               xmdhdocno,xmdhseq,xmdh001,",
                  "               xmdh002,xmdg005,",
                  "               xmdh015,xmdh006,xmdh007,",
                  "               '1' type,xmdd011,xmdddocno,",
                  "               xmdh016 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = xmdhent",
                  "                                      AND qcbasite = xmdhsite",
                  "                                      AND qcba000 = '4'",
                  "                                      AND COALESCE(qcba031,' ') = '1'",
                  "                                      AND qcba001 = xmdhdocno",
                  "                                      AND qcba002 = xmdhseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM xmdg_t,xmdh_t",
                  "          LEFT OUTER JOIN xmdd_t ON xmddent = xmdhent AND xmdddocno = xmdh001 AND xmddseq = xmdh002 AND xmddseq1 = xmdh003 AND xmddseq2 = xmdh004",
                  "         WHERE xmdhent = xmdgent AND xmdgent = ",g_enterprise,
                  "           AND xmdhdocno = xmdgdocno",
                  "           AND xmdgsite = '",g_site,"'",
                  "           AND xmdgstus = 'Y'",
                  "           AND xmdh022 = 'Y'",
                  "       )",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008",
                  "       LEFT OUTER JOIN imae_t ON imaeent = xmdlent AND imaesite = xmdlsite AND imae001 = xmdl008",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = xmdlent",
                  "                      AND qcbosite = xmdlsite",
                  "                      AND qcbo001 = '4'",
                  "                      AND qcbo002 = xmdldocno",
                  "                      AND qcbo003 = xmdlseq",
                  "                      AND COALESCE(qcbo004,0) = 0)"
   END IF
   
   #InvQC
   IF g_master.checkbox_InvQC = 'Y' THEN
      IF NOT cl_null(l_sql) THEN
         LET l_sql = l_sql," UNION ALL "
      END IF
      
      #調撥
      LET l_sql = l_sql,
                  "SELECT '5',indddocno,inddseq,0,indd101,",
                  "       indd001,cust,TO_CHAR(''),TO_CHAR(''),cnt,",
                  "       unit,indd002,indd004,imae111,",
                  "       type,indcdocdt,TO_CHAR(''),imae116",
                  "  FROM (SELECT inddent,inddsite,",
                  "               indddocno,inddseq,indd101,",
                  "               indd001,TO_CHAR('') cust,",
                  "               indd006,indd002,indd004,",
                  "               indcdocdt,",
                  "               CASE WHEN indc000 = '1' THEN indd006 ELSE indd041 END unit,",
                  "               CASE WHEN indc000 = '1' THEN '3' ELSE '4' END type,",
                  "               CASE WHEN indc000 = '1' THEN",
                  "                  indd103 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                       WHERE qcbaent = inddent",
                  "                                         AND qcbasite = inddsite",
                  "                                         AND qcba000 = '5'",
                  "                                         AND COALESCE(qcba031,' ') = '3'",
                  "                                         AND qcba001 = indddocno",
                  "                                         AND qcba002 = inddseq",
                  "                                         AND COALESCE(qcba029,0) = 0",
                  "                                         AND qcbastus <> 'X'),0)",
                  "               ELSE ",
                  "                  indd107 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                       WHERE qcbaent = inddent",
                  "                                         AND qcbasite = inddsite",
                  "                                         AND qcba000 = '5'",
                  "                                         AND COALESCE(qcba031,' ') = '4'",
                  "                                         AND qcba001 = indddocno",
                  "                                         AND qcba002 = inddseq",
                  "                                         AND COALESCE(qcba029,0) = 0",
                  "                                         AND qcbastus <> 'X'),0)",                  
                  "               END cnt",
                  "          FROM indc_t,indd_t",
                  "         WHERE inddent = indcent AND indcent = ",g_enterprise,
                  "           AND indddocno = indcdocno",
                  "           AND indcsite = '",g_site,"'",
                  "           AND indd040 <> 'Y'",
                  "           AND ((indcstus = 'O' AND indc102 = '2') OR (indcstus = 'P' AND indc102 = '3'))",
                  
                  "         UNION ALL ",
      #雜收發            
                  "        SELECT inbbent,inbbsite,",
                  "               inbbdocno,inbbseq,TO_CHAR(''),",
                  "               TO_NUMBER(''),TO_CHAR('') cust,",
                  "               inbb010,inbb001,inbb002,",
                  "               inbadocdt,",
                  "               inbb010 unit,",
                  "               CASE WHEN inba001 = '1' THEN '1' ELSE '2' END type,",
                  "               CASE WHEN inba001 = '1' THEN",
                  "                  inbb011 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                       WHERE qcbaent = inbbent",
                  "                                         AND qcbasite = inbbsite",
                  "                                         AND qcba000 = '5'",
                  "                                         AND COALESCE(qcba031,' ') = '1'",
                  "                                         AND qcba001 = inbbdocno",
                  "                                         AND qcba002 = inbbseq",
                  "                                         AND COALESCE(qcba029,0) = 0",
                  "                                         AND qcbastus <> 'X'),0)",
                  "               ELSE ",
                  "                  inbb011 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                       WHERE qcbaent = inbbent",
                  "                                         AND qcbasite = inbbsite",
                  "                                         AND qcba000 = '5'",
                  "                                         AND COALESCE(qcba031,' ') = '2'",
                  "                                         AND qcba001 = inbbdocno",
                  "                                         AND qcba002 = inbbseq",
                  "                                         AND COALESCE(qcba029,0) = 0",
                  "                                         AND qcbastus <> 'X'),0)",                  
                  "               END cnt",
                  "          FROM inba_t,inbb_t",
                  "         WHERE inbbent = inbaent AND inbaent = ",g_enterprise,
                  "           AND inbbdocno = inbadocno",
                  "           AND inbasite = '",g_site,"'",
                  "           AND inbb018 = 'Y'",
                  "           AND inbastus = 'Y'",
                  
                  "         UNION ALL ",
      #報廢            
                  "        SELECT inbjent,inbjsite,",
                  "               inbjdocno,inbjseq,TO_CHAR(''),",
                  "               TO_NUMBER(''),TO_CHAR('') cust,",
                  "               inbj008,inbj001,inbj002,",
                  "               inbidocdt,",
                  "               inbj008 unit,",
                  "               '5' type,",
                  "               inbj009 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = inbjent",
                  "                                      AND qcbasite = inbjsite",
                  "                                      AND qcba000 = '5'",
                  "                                      AND COALESCE(qcba031,' ') = '5'",
                  "                                      AND qcba001 = inbjdocno",
                  "                                      AND qcba002 = inbjseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM inbi_t,inbj_t",
                  "         WHERE inbjent = inbient AND inbient = ",g_enterprise,
                  "           AND inbjdocno = inbidocno",
                  "           AND inbisite = '",g_site,"'",
                  "           AND inbi004 = 'Y'",
                  "           AND inbistus = 'O'",
                  
                  "         UNION ALL ",
      #倉庫            
                  "        SELECT qcbnent,qcbnsite,",
                  "               qcbndocno,TO_NUMBER(''),TO_CHAR(''),",
                  "               TO_NUMBER(''),qcbn009 cust,",
                  "               qcbn010,qcbn003,qcbn004,",
                  "               qcbndocdt,",
                  "               qcbn010 unit,",
                  "               '6' type,",
                  "               qcbn011 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = qcbnent",
                  "                                      AND qcbasite = qcbnsite",
                  "                                      AND qcba000 = '5'",
                  "                                      AND COALESCE(qcba031,' ') = '6'",
                  "                                      AND qcba001 = qcbndocno",
                  "                                      AND COALESCE(qcba002,0) = 0",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",                  
                  "          FROM qcbn_t",
                  "         WHERE qcbnent = ",g_enterprise,
                  "           AND qcbnsite = '",g_site,"'",
                  "           AND qcbnstus = 'Y'",
                  "       )",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = inddent AND imaa001 = indd002",
                  "       LEFT OUTER JOIN imae_t ON imaeent = inddent AND imaesite = inddsite AND imae001 = indd002",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = inddent",
                  "                      AND qcbosite = inddsite",
                  "                      AND qcbo001 = '5'",
                  "                      AND qcbo002 = indddocno",
                  "                      AND qcbo003 = inddseq",
                  "                      AND COALESCE(qcbo004,0) = 0)"
   END IF

   #RQC
   IF g_master.checkbox_RQC = 'Y' THEN
      IF NOT cl_null(l_sql) THEN
         LET l_sql = l_sql," UNION ALL "
      END IF
      
      #借貨還貨檢驗
      LET l_sql = l_sql,
                  "SELECT '6',xmdldocno,xmdlseq,0,xmdl001,",
                  "       xmdl002,xmdk007,TO_CHAR(''),TO_CHAR(''),cnt,",
                  "       xmdl017,xmdl008,xmdl009,imae111,",
                  "       TO_CHAR(''),xmdd011,xmdddocno,imae116",
                  "  FROM (SELECT xmdlent,xmdlsite,",
                  "               xmdldocno,xmdlseq,xmdl001,",
                  "               xmdl002,xmdk007,",
                  "               xmdl017,xmdl008,xmdl009,",
                  "               xmdd011,xmdddocno,",
                  "               xmdl092 - COALESCE((SELECT SUM(qcba017) FROM qcba_t",
                  "                                    WHERE qcbaent = xmdlent",
                  "                                      AND qcbasite = xmdlsite",
                  "                                      AND qcba000 = '6'",
                  "                                      AND COALESCE(qcba031,' ') = ' '",
                  "                                      AND qcba001 = xmdldocno",
                  "                                      AND qcba002 = xmdlseq",
                  "                                      AND COALESCE(qcba029,0) = 0",
                  "                                      AND qcbastus <> 'X'),0) cnt",
                  "          FROM xmdk_t,xmdl_t",
                  "          LEFT OUTER JOIN xmdd_t ON xmddent = xmdlent AND xmdddocno = xmdl003 AND xmddseq = xmdl004 AND xmddseq1 = xmdl005 AND xmddseq2 = xmdl006",
                  "         WHERE xmdlent = xmdkent AND xmdkent = ",g_enterprise,
                  "           AND xmdldocno = xmdkdocno",
                  "           AND xmdksite = '",g_site,"'",
                  "           AND xmdkstus = 'Y'",
                  "           AND xmdk000 = '7'",
                  "           AND xmdk002 <> '2'",
                  "           AND xmdl023 = 'Y'",
                  "       )",
                  "       LEFT OUTER JOIN imaa_t ON imaaent = xmdlent AND imaa001 = xmdl008",
                  "       LEFT OUTER JOIN imae_t ON imaeent = xmdlent AND imaesite = xmdlsite AND imae001 = xmdl008",
                  " WHERE cnt > 0",
                  "   AND ",p_wc,
                  "   AND NOT EXISTS (SELECT 1 FROM qcbo_t",
                  "                    WHERE qcboent = xmdlent",
                  "                      AND qcbosite = xmdlsite",
                  "                      AND qcbo001 = '6'",
                  "                      AND qcbo002 = xmdldocno",
                  "                      AND qcbo003 = xmdlseq",
                  "                      AND COALESCE(qcbo004,0) = 0)"
   END IF
   
   PREPARE aqcp700_sel_pre FROM l_sql
   DECLARE aqcp700_sel_cs CURSOR FOR aqcp700_sel_pre
   
   #刪除時只刪除目前檢驗人員qcbo_t.qcbo020為空白的資料
   DELETE FROM qcbp_t
    WHERE EXISTS (SELECT 1 FROM qcbo_t
                          WHERE qcboent = qcbpent
                            AND qcbosite = qcbpsite
                            AND qcbo001 = qcbp001
                            AND qcbo002 = qcbp002
                            AND qcbo003 = qcbp003
                            AND qcbo004 = qcbp004
                            AND qcbo020 IS NULL)
      AND qcbpent = g_enterprise   #170120-00042#1 add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "DELETE FROM qcbp_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM qcbo_t
    WHERE qcbo020 IS NULL
      AND qcboent = g_enterprise   #170120-00042#1 add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "DELETE FROM qcbo_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   INITIALIZE g_qcbo.* TO NULL
   FOREACH aqcp700_sel_cs INTO g_qcbo.qcbo001,g_qcbo.qcbo002,g_qcbo.qcbo003,g_qcbo.qcbo004,g_qcbo.qcbo005,
                               g_qcbo.qcbo006,g_qcbo.qcbo007,g_qcbo.qcbo008,g_qcbo.qcbo009,g_qcbo.qcbo010,
                               g_qcbo.qcbo011,g_qcbo.qcbo012,g_qcbo.qcbo014,g_qcbo.qcbo015,
                               g_qcbo.qcbo019,l_date,l_docno,g_imae116
      IF g_qcbo.qcbo001 = '4' THEN  #OQC
         CALL s_aooi200_get_slip(l_docno) RETURNING l_success,l_slip
         CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0094') RETURNING lc_para_data
         
         #OQC檢驗時機為"1出貨通知時檢驗"
         IF lc_para_data = '1' AND g_qcbo.qcbo019 <> '1' THEN
            CONTINUE FOREACH
         END IF
         
         #OQC檢驗時機為"2出貨時檢驗"
         IF lc_para_data = '2' AND g_qcbo.qcbo019 <> '2' THEN
            CONTINUE FOREACH
         END IF
      END IF

      LET g_qcbo.qcbo013 = ''    #版本
      LET g_qcbo.qcbo018 = ''    #承認文號
      LET g_qcbo.qcbo020 = ''    #目前檢驗人員
      LET g_qcbo.qcbo021 = ''    #開始檢驗日期
      LET g_qcbo.qcbo022 = ''    #開始檢驗時間

      LET g_qcbo.qcbo016 = ''  #檢驗程度
      LET g_qcbo.qcbo017 = ''  #檢驗級數
      SELECT qcap007,qcap009 INTO g_qcbo.qcbo016,g_qcbo.qcbo017
        FROM qcap_t
       WHERE qcapent = g_enterprise AND qcapsite = g_site
         AND qcap001 = g_qcbo.qcbo012 AND qcap002 = g_qcbo.qcbo007
         AND qcap003 = COALESCE(g_qcbo.qcbo008,'ALL') AND qcap004 = COALESCE(g_qcbo.qcbo009,0)
         AND (qcap005 = g_qcbo.qcbo014 OR qcap005 = 'ALL')
         
      IF cl_null(g_qcbo.qcbo016) OR cl_null(g_qcbo.qcbo017) THEN
            SELECT imae115,imae117 INTO g_qcbo.qcbo016,g_qcbo.qcbo017
              FROM imae_t
             WHERE imaeent = g_enterprise AND imaesite = g_site
               AND imae001 = g_qcbo.qcbo012
      END IF
      
      LET g_qcbo.qcbo023 = ''  #緊急度
      CASE g_qcbo.qcbo001
         WHEN '1'  #IQC
            LET l_sql = "SELECT COUNT(*) FROM sfaa_t,sfba_t",
                        " WHERE sfaaent = sfbaent AND sfaaent = ",g_enterprise,
                        "   AND sfaasite = '",g_site,"'",
                        "   AND sfaadocno = sfbadocno",
                        "   AND sfaastus = 'F'",
                        "   AND sfba006 = '",g_qcbo.qcbo012,"'",
                        "   AND sfba013 > sfba016",
      	               "   AND EXISTS (SELECT sfdadocno FROM sfda_t,sfdb_t",
      	               "                WHERE sfdaent = sfdbent AND sfdaent = sfaaent",
      	               "                  AND sfdasite = sfaasite",
      	               "                  AND sfdadocno = sfdbdocno",
      	               "                  AND sfdastus = 'S'",
      	               "                  AND sfdb001 = sfaadocno",
      	               "                  AND sfda002 IN ('11','12','13','14','15'))"
      	   PREPARE aqcp700_emg_pre01 FROM l_sql
      	   
      	   LET l_cnt = 0
      	   EXECUTE aqcp700_emg_pre01 INTO l_cnt
      	   
      	   IF l_cnt > 0 THEN
      	      LET g_qcbo.qcbo023 = 'A'  #緊急
      	      EXIT CASE
      	   END IF

            LET l_sql = "SELECT COUNT(*) FROM sfaa_t,sfba_t",
                        " WHERE sfaaent = sfbaent AND sfaaent = ",g_enterprise,
                        "   AND sfaasite = '",g_site,"'",
                        "   AND sfaadocno = sfbadocno",
                        "   AND sfaastus = 'F'",
                        "   AND sfba006 = '",g_qcbo.qcbo012,"'",
                        "   AND sfba013 > sfba016",
      	               "   AND NOT EXISTS (SELECT sfdadocno FROM sfda_t,sfdb_t",
      	               "                    WHERE sfdaent = sfdbent AND sfdaent = sfaaent",
      	               "                      AND sfdasite = sfaasite",
      	               "                      AND sfdadocno = sfdbdocno",
      	               "                      AND sfdastus = 'S'",
      	               "                      AND sfdb001 = sfaadocno",
      	               "                      AND sfda002 IN ('11','12','13','14','15'))"
      	   PREPARE aqcp700_emg_pre02 FROM l_sql

      	   LET l_cnt = 0
      	   EXECUTE aqcp700_emg_pre02 INTO l_cnt
      	   
      	   IF l_cnt > 0 THEN
      	      LET g_qcbo.qcbo023 = 'B'  #重要
      	      EXIT CASE
      	   END IF
            
            LET g_qcbo.qcbo023 = 'C'  #一般
            EXIT CASE
            
         OTHERWISE  #2.FQC, 3.PQC, 4.OQC, 5.InventoryQC, 6.RQC
            CASE
               WHEN l_date < g_today
      	         LET g_qcbo.qcbo023 = 'A'  #緊急
      	      
               WHEN l_date = g_today
      	         LET g_qcbo.qcbo023 = 'B'  #重要
      	      
      	      OTHERWISE
                  LET g_qcbo.qcbo023 = 'C'  #一般

            END CASE      
      
      END CASE
      
      IF NOT aqcp700_insert() THEN
         RETURN r_success
      END IF
      
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: insert資料
# Memo...........:
# Usage..........: CALL aqcp700_insert()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 160805 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcp700_insert()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
#   DEFINE l_qcan        RECORD LIKE qcan_t.* #161124-00048#10 mark
   #161124-00048#10 add(s)
   DEFINE l_qcan RECORD  #品質檢驗項目單身檔
       qcanent LIKE qcan_t.qcanent, #企业编号
       qcan001 LIKE qcan_t.qcan001, #参照表号
       qcan002 LIKE qcan_t.qcan002, #品管分群
       qcan003 LIKE qcan_t.qcan003, #料件编号
       qcan004 LIKE qcan_t.qcan004, #产品特征
       qcan005 LIKE qcan_t.qcan005, #作业编号
       qcan006 LIKE qcan_t.qcan006, #加工序
       qcan007 LIKE qcan_t.qcan007, #交易对象编号
       qcan008 LIKE qcan_t.qcan008, #检验类型
       qcan009 LIKE qcan_t.qcan009, #项次
       qcan010 LIKE qcan_t.qcan010, #检验项目
       qcan011 LIKE qcan_t.qcan011, #检验位置
       qcan012 LIKE qcan_t.qcan012, #缺点等级
       qcan013 LIKE qcan_t.qcan013, #抽样计划
       qcan014 LIKE qcan_t.qcan014, #AQL
       qcan015 LIKE qcan_t.qcan015, #测量值控制方式
       qcan016 LIKE qcan_t.qcan016, #检验方式
       qcan017 LIKE qcan_t.qcan017, #资源类型
       qcan018 LIKE qcan_t.qcan018, #指定仪器
       qcan019 LIKE qcan_t.qcan019, #规范上限
       qcan020 LIKE qcan_t.qcan020, #检验上限
       qcan021 LIKE qcan_t.qcan021, #检验标准值
       qcan022 LIKE qcan_t.qcan022, #检验下限
       qcan023 LIKE qcan_t.qcan023, #规范下限
       qcan024 LIKE qcan_t.qcan024, #计量单位
       qcan025 LIKE qcan_t.qcan025, #检验规格说明
       qcan026 LIKE qcan_t.qcan026  #备注
   END RECORD
   #161124-00048#10 add(e)
   
   LET r_success = TRUE
   
   CALL aqcp700_qcbo024_sel()
   
   INSERT INTO qcbo_t (qcboent,qcbosite,
                       qcbo001,qcbo002,qcbo003,qcbo004,qcbo005,
                       qcbo006,qcbo007,qcbo008,qcbo009,qcbo010,
                       qcbo011,qcbo012,qcbo013,qcbo014,qcbo015,
                       qcbo016,qcbo017,qcbo018,qcbo019,qcbo020,
                       qcbo021,qcbo022,qcbo023,qcbo024)
   VALUES (g_enterprise,g_site,
           g_qcbo.qcbo001,g_qcbo.qcbo002,g_qcbo.qcbo003,g_qcbo.qcbo004,g_qcbo.qcbo005,
           g_qcbo.qcbo006,g_qcbo.qcbo007,g_qcbo.qcbo008,g_qcbo.qcbo009,g_qcbo.qcbo010,
           g_qcbo.qcbo011,g_qcbo.qcbo012,g_qcbo.qcbo013,g_qcbo.qcbo014,g_qcbo.qcbo015,
           g_qcbo.qcbo016,g_qcbo.qcbo017,g_qcbo.qcbo018,g_qcbo.qcbo019,g_qcbo.qcbo020,
           g_qcbo.qcbo021,g_qcbo.qcbo022,g_qcbo.qcbo023,g_qcbo.qcbo024)
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT INTO qcbo_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   #170217-00025#6 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
   END IF
   #170217-00025#6 add-E
   
#   LET l_sql = "SELECT * FROM qcan_t,qcam_t WHERE  qcan001 = '",g_qcaz001,"'",  #161124-00048#10 mark
    #161124-00048#10 add(s)
   LET l_sql = "SELECT qcanent,qcan001,qcan002,qcan003,qcan004,qcan005,qcan006,qcan007,",
               "       qcan008,qcan009,qcan010,qcan011,qcan012,qcan013,qcan014,qcan015,",
               "       qcan016,qcan017,qcan018,qcan019,qcan020,qcan021,qcan022,qcan023,",
               "       qcan024,qcan025,qcan026 FROM qcan_t,qcam_t WHERE  qcan001 = '",g_qcaz001,"'", 
    #161124-00048#10 add(e)
               "   AND qcanent = qcament  AND qcam001 = qcan001 ",
               "   AND qcan002 = qcam002  AND qcan003 = qcam003 ",
               "   AND qcan004 = qcam004  AND qcan005 = qcam005 ",
               "   AND qcan006 = qcam006  AND qcan007 = qcam008 ",
               "   AND qcan008 = qcam009 ",
               "   AND qcanent = '",g_enterprise,"'",
               "   AND qcam010 = '",g_qcbo.qcbo024,"'",
               "  ORDER BY qcan009" 
   PREPARE aqcp700_qcan_pre FROM l_sql
   DECLARE aqcp700_qcan_cs CURSOR FOR aqcp700_qcan_pre
   
   FOREACH aqcp700_qcan_cs INTO l_qcan.*
      INITIALIZE g_qcbp.* TO NULL
      LET g_qcbp.qcbp001 = g_qcbo.qcbo001  #檢驗類型
      LET g_qcbp.qcbp002 = g_qcbo.qcbo002  #來源單號
      LET g_qcbp.qcbp003 = g_qcbo.qcbo003  #來源項次
      LET g_qcbp.qcbp004 = g_qcbo.qcbo004  #RUNCARD
      LET g_qcbp.qcbp005 = l_qcan.qcan009  #行序
      LET g_qcbp.qcbp006 = l_qcan.qcan010  #檢驗項目
      LET g_qcbp.qcbp007 = l_qcan.qcan011  #檢驗位置
      LET g_qcbp.qcbp008 = l_qcan.qcan012  #缺點等級
      LET g_qcbp.qcbp009 = l_qcan.qcan014  #AQL
      LET g_qcbp.qcbp015 = l_qcan.qcan019  #規範上限
      LET g_qcbp.qcbp016 = l_qcan.qcan020  #檢驗上限
      LET g_qcbp.qcbp017 = l_qcan.qcan021  #檢驗標準值
      LET g_qcbp.qcbp018 = l_qcan.qcan022  #檢驗下限
      LET g_qcbp.qcbp019 = l_qcan.qcan023  #規範下限
      LET g_qcbp.qcbp020 = l_qcan.qcan024  #計量單位
      LET g_qcbp.qcbp021 = l_qcan.qcan025  #檢驗規格說明
      LET g_qcbp.qcbp022 = l_qcan.qcan013  #抽樣計畫
      #允收數、拒絕數
      CALL aqcp700_qcbp010_qcbp011_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING g_qcbp.qcbp010,g_qcbp.qcbp011
      #參照CALL aqct300_qcbd005_qcbd006_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING g_qcbp.qcbd005,g_qcbp.qcbd006      
      #K法標準值、F法標準值
      CALL aqcp700_qcbp012_qcbp013_result(l_qcan.qcan013)  RETURNING g_qcbp.qcbp012,g_qcbp.qcbp013
      #參照CALL aqct300_qcbd007_qcbd008_result(l_qcan.qcan013)  RETURNING g_qcbp.qcbd007,g_qcbp.qcbd008
      #抽驗量
      CALL aqcp700_qcbp014_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING g_qcbp.qcbp014
      #參照CALL aqct300_qcbd009_result(l_qcan.qcan013,l_qcan.qcan014) RETURNING g_qcbp.qcbd009

      INSERT INTO qcbp_t (qcbpent,qcbpsite,
                          qcbp001,qcbp002,qcbp003,qcbp004,qcbp005,
                          qcbp006,qcbp007,qcbp008,qcbp009,qcbp010,
                          qcbp011,qcbp012,qcbp013,qcbp014,qcbp015,
                          qcbp016,qcbp017,qcbp018,qcbp019,qcbp020,
                          qcbp021,qcbp022)
      VALUES (g_enterprise,g_site,
              g_qcbp.qcbp001,g_qcbp.qcbp002,g_qcbp.qcbp003,g_qcbp.qcbp004,g_qcbp.qcbp005,
              g_qcbp.qcbp006,g_qcbp.qcbp007,g_qcbp.qcbp008,g_qcbp.qcbp009,g_qcbp.qcbp010,
              g_qcbp.qcbp011,g_qcbp.qcbp012,g_qcbp.qcbp013,g_qcbp.qcbp014,g_qcbp.qcbp015,
              g_qcbp.qcbp016,g_qcbp.qcbp017,g_qcbp.qcbp018,g_qcbp.qcbp019,g_qcbp.qcbp020,
              g_qcbp.qcbp021,g_qcbp.qcbp022)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "INSERT INTO qcbp_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF
      #170217-00025#6 add-S
      IF SQLCA.sqlerrd[3] > 0 THEN
         LET g_flag = TRUE
      END IF
      #170217-00025#6 add-E
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 預設檢驗專案識別碼
# Memo...........:
# Usage..........: CALL aqcp700_qcbo024_sel()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 160805 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aqcp700_qcbo024_sel()
   
   LET g_qcbo.qcbo024 = ''
   #170207-00018#3    2017/02/10   By 08734 mark(S)
   #SELECT qcam010 INTO g_qcbo.qcbo024 FROM qcam_t 
   #WHERE qcam001 = g_qcaz001
   #  AND (qcam002 = g_qcbo.qcbo015 OR qcam002 = 'ALL')
   #  AND (qcam003 = g_qcbo.qcbo012 OR qcam003 = 'ALL')
   #  AND (qcam004 = g_qcbo.qcbo014 OR qcam004 = 'ALL')
   #  AND (qcam005 = g_qcbo.qcbo008 OR qcam005 = 'ALL')
   #  AND (qcam006 = g_qcbo.qcbo009 OR qcam006 = 0)
   #  AND (qcam008 = g_qcbo.qcbo007 OR qcam008 = 'ALL')
   #  AND (qcam009 = g_qcbo.qcbo001 OR qcam009 = '0') 
   #  AND qcamstus = 'Y'     
   #  AND qcament = g_enterprise   #170120-00042#1 add
   #  AND ROWNUM = 1 ORDER BY qcam010
   #170207-00018#3    2017/02/10   By 08734 mark(E)
   #170207-00018#3    2017/02/10   By 08734 add(S)   
   SELECT A.qcam010 INTO g_qcbo.qcbo024 FROM(SELECT qcam010  FROM qcam_t 
   WHERE qcam001 = g_qcaz001
     AND (qcam002 = g_qcbo.qcbo015 OR qcam002 = 'ALL')
     AND (qcam003 = g_qcbo.qcbo012 OR qcam003 = 'ALL')
     AND (qcam004 = g_qcbo.qcbo014 OR qcam004 = 'ALL')
     AND (qcam005 = g_qcbo.qcbo008 OR qcam005 = 'ALL')
     AND (qcam006 = g_qcbo.qcbo009 OR qcam006 = 0)
     AND (qcam008 = g_qcbo.qcbo007 OR qcam008 = 'ALL')
     AND (qcam009 = g_qcbo.qcbo001 OR qcam009 = '0') 
     AND qcamstus = 'Y'     
     AND qcament = g_enterprise   
     ORDER BY qcam010) A 
   WHERE ROWNUM = 1
   #170207-00018#3    2017/02/10   By 08734 add(E)
   
END FUNCTION

################################################################################
# 計算qcbp010,qcbp011的數量
################################################################################
PRIVATE FUNCTION aqcp700_qcbp010_qcbp011_result(p_qcan013,p_qcan014)
   DEFINE p_qcan013   LIKE qcan_t.qcan013
   DEFINE p_qcan014   LIKE qcan_t.qcan014
   DEFINE r_qcbp010   LIKE qcbp_t.qcbp010
   DEFINE r_qcbp011   LIKE qcbp_t.qcbp011
   DEFINE l_n         LIKE type_t.num5   
   DEFINE l_qcaa004   LIKE qcaa_t.qcaa004
   
   IF p_qcan013 = '1' THEN
      IF g_qcbo.qcbo010 = 1 THEN
         LET r_qcbp010 = 0 LET r_qcbp011 = 1
      END IF
      
      LET l_n = 0 
      SELECT COUNT(*) INTO l_n FROM imae_t WHERE imaeent = g_enterprise 
         AND imaesite = g_site AND imae001 = g_qcbo.qcbo012
      IF l_n = 0 THEN
         LET r_qcbp010 = 0 LET r_qcbp011 = 0
      END IF  
      
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM qcap_t WHERE qcapent = g_enterprise
         AND qcap001 = g_qcbo.qcbo012 AND qcap002 = g_qcbo.qcbo007
      IF l_n = 0 THEN
         LET r_qcbp010 = 0 LET r_qcbp011 = 0
      END IF
      
      IF g_imae116 = '1' THEN
         SELECT qcaa004 INTO l_qcaa004 FROM qcaa_t 
          WHERE qcaa003 = g_qcbo.qcbo017 AND (g_qcbo.qcbo010 BETWEEN qcaa001 AND qcaa002)
            AND qcaaent = g_enterprise   #170120-00042#1 add
         IF l_n = 0 THEN
            LET r_qcbp010 = 0 LET r_qcbp011 = 0
         END IF
      END IF
      
      IF g_imae116 = '2' THEN
         SELECT qcab004 INTO l_qcaa004 FROM qcab_t 
          WHERE qcab003 = g_qcbo.qcbo017 AND (g_qcbo.qcbo010 BETWEEN qcab001 AND qcab002)
            AND qcabent = g_enterprise   #170120-00042#1 add
         IF l_n = 0 THEN
            LET r_qcbp010 = 0 LET r_qcbp011 = 0
         END IF
      END IF
      
      IF g_imae116 MATCHES '[12]' AND NOT cl_null(l_qcaa004) THEN
         SELECT qcac005,qcac006 INTO r_qcbp010,r_qcbp011 FROM qcac_t
          WHERE qcacent = g_enterprise AND qcac001 = g_qcbo.qcbo016
            AND qcac002 = p_qcan014 AND qcac003 = l_qcaa004
      END IF
   END IF
   
   IF p_qcan013 MATCHES '[2357]' THEN    
      LET r_qcbp010 = 0   LET r_qcbp011 = 1
   END IF
   
   IF p_qcan013 = '6' THEN   #自定义公式
       SELECT qcah007 INTO r_qcbp010
        FROM qcah_t
       WHERE qcahent = g_enterprise
         AND (g_qcbo.qcbo010 BETWEEN qcah004 AND qcah005)
         AND qcah001 = g_qcaz.qcaz001
         AND qcah002 = p_qcan014
         AND qcah003 = g_qcbo.qcbo016
       IF cl_null(r_qcbp010) THEN LET r_qcbp010 = 0 END IF
       LET r_qcbp011 = 1
   END IF
   
   IF p_qcan013 = '4' THEN
      LET r_qcbp010 = 0  LET r_qcbp011 = 1
   END IF
   IF r_qcbp010 > g_qcbo.qcbo010 THEN
      LET r_qcbp010 = g_qcbo.qcbo010 - 1
   END IF
   
   IF r_qcbp011 > g_qcbo.qcbo010 THEN
      LET r_qcbp011 = g_qcbo.qcbo010
   END IF
   RETURN r_qcbp010,r_qcbp011
END FUNCTION

################################################################################
# 計算qcbp012 qcbp013的數值
################################################################################
PRIVATE FUNCTION aqcp700_qcbp012_qcbp013_result(p_qcan013)
   DEFINE p_qcan013   LIKE qcan_t.qcan013
   DEFINE r_qcbp012   LIKE qcbp_t.qcbp012
   DEFINE r_qcbp013   LIKE qcbp_t.qcbp013
   DEFINE l_qcad002   LIKE qcad_t.qcad002

   IF p_qcan013 MATCHES '[123567]' THEN
      LET r_qcbp012 = ''  LET r_qcbp013 = ''
   END IF
   
   IF p_qcan013 = '4' THEN
      SELECT qcad002 INTO l_qcad002 FROM qcad_t WHERE qcadent = g_enterprise 
         AND qcad001 = g_qcbo.qcbo017 AND (g_qcbo.qcbo010 BETWEEN qcad003 AND qcad004) 
         
      SELECT qcae005,qcae006 INTO r_qcbp012,r_qcbp013 FROM qcae_t
       WHERE qcaeent = g_enterprise AND qcae001 = '4' AND qcae002 = g_qcbo.qcbo017
         AND qcae003 = l_qcad002
   END IF
   RETURN r_qcbp012,r_qcbp013
END FUNCTION

################################################################################
# 計算qcbp014的數值
################################################################################
PRIVATE FUNCTION aqcp700_qcbp014_result(p_qcan013,p_qcan014)
   DEFINE p_qcan013   LIKE qcan_t.qcan013
   DEFINE p_qcan014   LIKE qcan_t.qcan014
   DEFINE l_qcac004   LIKE qcac_t.qcac004
   DEFINE l_qcaa005   LIKE qcaa_t.qcaa005
   DEFINE l_qcaa006   LIKE qcaa_t.qcaa006
   DEFINE l_qcaa007   LIKE qcaa_t.qcaa007
   DEFINE l_qcab005   LIKE qcab_t.qcab005
   DEFINE l_qcab006   LIKE qcab_t.qcab006
   DEFINE l_qcab007   LIKE qcab_t.qcab007
   DEFINE r_qcbp014   LIKE qcbp_t.qcbp014
   DEFINE l_qcad001   LIKE qcad_t.qcad001
   DEFINE l_qcad002   LIKE qcad_t.qcad002
   DEFINE l_qcac003   LIKE qcac_t.qcac003

   IF p_qcan013 = '1' THEN

     CASE g_imae116
        WHEN '1'
            SELECT DISTINCT qcaa004 INTO l_qcac003 FROM qcaa_t
             WHERE qcaaent = g_enterprise
               AND qcaa003 = g_qcbo.qcbo017
               AND (g_qcbo.qcbo010 BETWEEN qcaa001 AND qcaa002)
        WHEN '2'
             SELECT DISTINCT qcab004 INTO l_qcac003 FROM qcab_t
              WHERE qcabent = g_enterprise
                AND qcab003 = g_qcbo.qcbo017
                AND (g_qcbo.qcbo010 BETWEEN qcab001 AND qcab002)       
     END CASE
     
     IF g_imae116 MATCHES '[12]' THEN
        SELECT qcac007 INTO r_qcbp014 FROM qcac_t
          WHERE qcacent = g_enterprise
            AND qcac001 = g_qcbo.qcbo016
            AND qcac002 = p_qcan014
            AND qcac003 = l_qcac003
     END IF 
   END IF
 
   IF p_qcan013 = '2' THEN            #C=0 时抓 aqci007
      SELECT qcag005 INTO r_qcbp014
        FROM qcag_t
       WHERE qcagent = g_enterprise
         AND (g_qcbo.qcbo010 BETWEEN qcag001 AND qcag002)
         AND qcag003 = p_qcan014
         AND qcag004 = g_qcbo.qcbo017
      IF cl_null(r_qcbp014) THEN LET r_qcbp014 = 0 END IF
   END IF
 
   IF p_qcan013 MATCHES '[34]' THEN
      LET l_qcad001 = g_qcbo.qcbo017
      CASE g_qcbo.qcbo016 
         WHEN 'T' 
              CASE g_qcbo.qcbo017 
                 WHEN '1'
                    LET l_qcad001 = '2'
                 WHEN '2'
                    LET l_qcad001 = '3'
                 WHEN '3'
                    LET l_qcad001 = '4'
                 WHEN '4'
                    LET l_qcad001 = '5'
                 WHEN '5'
                    LET l_qcad001 = '6'
                 WHEN '6'
                    LET l_qcad001 = '7'
                 WHEN '7'
                    LET l_qcad001 = 'T'
              END CASE

         WHEN 'R'  

              CASE g_qcbo.qcbo017 
                 WHEN '1'
                    LET l_qcad001 = 'R'
                 WHEN '2'
                    LET l_qcad001 = '1'
                 WHEN '3'
                    LET l_qcad001 = '2'
                 WHEN '4'
                    LET l_qcad001 = '3'
                 WHEN '5'
                    LET l_qcad001 = '4'
                 WHEN '6'
                    LET l_qcad001 = '5'
                 WHEN '7'
                    LET l_qcad001 = '6'
              END CASE
      END CASE
      
      SELECT qcad002 INTO l_qcad002 FROM qcad_t
       WHERE qcadent = g_enterprise
         AND (g_qcbo.qcbo010 BETWEEN qcad003 AND qcad004)
         AND qcad001 = l_qcad001
         
      SELECT qcae004 INTO r_qcbp014 FROM qcae_t
       WHERE qcaeent = g_enterprise
         AND qcae001 = p_qcan013
         AND qcae002 = g_qcbo.qcbo017
         AND qcae003 = l_qcad002
   END IF
   
   IF p_qcan013 = '5' THEN #百分比
      LET r_qcbp014 = g_qcbo.qcbo010 * (p_qcan014 * 0.01)
   END IF
   
   IF p_qcan013 = '6' THEN  #自定義公式
      SELECT qcah006 INTO r_qcbp014
        FROM qcah_t
       WHERE qcahent = g_enterprise
         AND (g_qcbo.qcbo010 BETWEEN qcah004 AND qcah005)
         AND qcah001 = g_qcaz.qcaz001
         AND qcah002 = p_qcan014
         AND qcah003 = g_qcbo.qcbo016
   END IF
   
   IF p_qcan013 = '7' THEN
      LET r_qcbp014 = g_qcbo.qcbo010
   END IF
   IF r_qcbp014 > g_qcbo.qcbo010 THEN
      LET r_qcbp014 = g_qcbo.qcbo010
   END IF
   RETURN r_qcbp014
END FUNCTION

#end add-point
 
{</section>}
 
