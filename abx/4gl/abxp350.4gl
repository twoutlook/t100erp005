#該程式未解開Section, 採用最新樣板產出!
{<section id="abxp350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-27 15:12:05), PR版次:0001(2016-12-28 10:55:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abxp350
#+ Description: 保稅機器設備盤點資料產生作業
#+ Creator....: 01996(2016-12-26 15:09:08)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="abxp350.global" >}
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
       bxdb001 LIKE bxdb_t.bxdb001, 
   bxdb005 LIKE bxdb_t.bxdb005, 
   bxdc003 LIKE bxdc_t.bxdc003, 
   bxdc004 LIKE bxdc_t.bxdc004, 
   bxdb012 LIKE bxdb_t.bxdb012, 
   bxdb013 LIKE bxdb_t.bxdb013, 
   checkbox1 LIKE type_t.chr500, 
   checkbox2 LIKE type_t.chr500, 
   bxdfdocno LIKE bxdf_t.bxdfdocno, 
   bxdfdocno_desc LIKE type_t.chr80, 
   bxdfdocdt LIKE bxdf_t.bxdfdocdt, 
   bxdf001 LIKE bxdf_t.bxdf001, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ooef RECORD  #組織基本資料檔
       ooef004 LIKE ooef_t.ooef004, #单据别参照表号
       ooef008 LIKE ooef_t.ooef008, #行事历参照表号
       ooef009 LIKE ooef_t.ooef009  #制造行事历对应类别
END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abxp350.main" >}
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
   CALL cl_ap_init("abx","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abxp350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abxp350 WITH FORM cl_ap_formpath("abx",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abxp350_init()
 
      #進入選單 Menu (="N")
      CALL abxp350_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abxp350
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abxp350.init" >}
#+ 初始化作業
PRIVATE FUNCTION abxp350_init()
 
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
   CALL cl_set_combo_scc("bxdb005","4074")
    #抓單據別參照表
   SELECT ooef004,ooef008,ooef009 
     INTO g_ooef.* FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abxp350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abxp350_ui_dialog()
 
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
   LET g_errshow=1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.checkbox1,g_master.checkbox2,g_master.bxdfdocno,g_master.bxdfdocdt,g_master.bxdf001  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox1
            #add-point:BEFORE FIELD checkbox1 name="input.b.checkbox1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox1
            
            #add-point:AFTER FIELD checkbox1 name="input.a.checkbox1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox1
            #add-point:ON CHANGE checkbox1 name="input.g.checkbox1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox2
            #add-point:BEFORE FIELD checkbox2 name="input.b.checkbox2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox2
            
            #add-point:AFTER FIELD checkbox2 name="input.a.checkbox2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox2
            #add-point:ON CHANGE checkbox2 name="input.g.checkbox2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdfdocno
            
            #add-point:AFTER FIELD bxdfdocno name="input.a.bxdfdocno"
            CALL abxp350_bxdfdocno_ref()
            IF  NOT cl_null(g_master.bxdfdocno) THEN 
                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM bxdf_t WHERE "||"bxdfent = '" ||g_enterprise|| "' AND "||"bxdfdocno = '"||g_master.bxdfdocno ||"'",'std-00004',0) THEN 
                   NEXT FIELD CURRENT
                END IF
                IF NOT s_aooi200_chk_slip(g_site,'',g_master.bxdfdocno,'abxt350') THEN
                   CALL abxp350_bxdfdocno_ref()
                   NEXT FIELD CURRENT
                END IF                    
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdfdocno
            #add-point:BEFORE FIELD bxdfdocno name="input.b.bxdfdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdfdocno
            #add-point:ON CHANGE bxdfdocno name="input.g.bxdfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdfdocdt
            #add-point:BEFORE FIELD bxdfdocdt name="input.b.bxdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdfdocdt
            
            #add-point:AFTER FIELD bxdfdocdt name="input.a.bxdfdocdt"
            IF NOT cl_null(g_master.bxdfdocdt) THEN
               SELECT oogc015 INTO g_master.bxdf001 FROM oogc_t
                WHERE oogcent = g_enterprise
                  AND oogc001 = g_ooef.ooef008
                  AND oogc002 = g_ooef.ooef009
                  AND oogc003 = g_master.bxdfdocdt
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdfdocdt
            #add-point:ON CHANGE bxdfdocdt name="input.g.bxdfdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdf001
            #add-point:BEFORE FIELD bxdf001 name="input.b.bxdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdf001
            
            #add-point:AFTER FIELD bxdf001 name="input.a.bxdf001"
            IF NOT cl_null(g_master.bxdf001) THEN
               IF g_master.bxdf001 < 1911 OR g_master.bxdf001 > 3000 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abx-00066'
                  LET g_errparam.extend = g_master.bxdf001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()    
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bxdf001
            #add-point:ON CHANGE bxdf001 name="input.g.bxdf001"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.checkbox1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox1
            #add-point:ON ACTION controlp INFIELD checkbox1 name="input.c.checkbox1"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox2
            #add-point:ON ACTION controlp INFIELD checkbox2 name="input.c.checkbox2"
            
            #END add-point
 
 
         #Ctrlp:input.c.bxdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdfdocno
            #add-point:ON ACTION controlp INFIELD bxdfdocno name="input.c.bxdfdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.bxdfdocno             #給予default值
       
            IF cl_null(g_ooef.ooef004) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00007'
               LET g_errparam.extend = g_site#g_bxdf_m.bxdfsite
               LET g_errparam.popup = TRUE
               CALL cl_err()            
            END IF 

            #給予arg
            LET g_qryparam.arg1 = g_ooef.ooef004
            LET g_qryparam.arg2 = 'abxt350'

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.bxdfdocno = g_qryparam.return1              

            DISPLAY g_master.bxdfdocno TO bxdfdocno              #
            CALL abxp350_bxdfdocno_ref()
            NEXT FIELD bxdfdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bxdfdocdt
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdfdocdt
            #add-point:ON ACTION controlp INFIELD bxdfdocdt name="input.c.bxdfdocdt"
            IF NOT cl_null(g_master.bxdfdocdt) THEN
                SELECT oogc015 INTO g_master.bxdf001 FROM oogc_t
                 WHERE oogcent = g_enterprise
                   AND oogc001 = g_ooef.ooef008
                   AND oogc002 = g_ooef.ooef009
                   AND oogc003 = g_master.bxdfdocdt
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.bxdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdf001
            #add-point:ON ACTION controlp INFIELD bxdf001 name="input.c.bxdf001"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bxdb001,bxdb005,bxdc003,bxdc004,bxdb012,bxdb013
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bxdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdb001
            #add-point:ON ACTION controlp INFIELD bxdb001 name="construct.c.bxdb001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_bxdb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdb001  #顯示到畫面上
            NEXT FIELD bxdb001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdb001
            #add-point:BEFORE FIELD bxdb001 name="construct.b.bxdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdb001
            
            #add-point:AFTER FIELD bxdb001 name="construct.a.bxdb001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdb005
            #add-point:BEFORE FIELD bxdb005 name="construct.b.bxdb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdb005
            
            #add-point:AFTER FIELD bxdb005 name="construct.a.bxdb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdb005
            #add-point:ON ACTION controlp INFIELD bxdb005 name="construct.c.bxdb005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bxdc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdc003
            #add-point:ON ACTION controlp INFIELD bxdc003 name="construct.c.bxdc003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdc003  #顯示到畫面上
            NEXT FIELD bxdc003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdc003
            #add-point:BEFORE FIELD bxdc003 name="construct.b.bxdc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdc003
            
            #add-point:AFTER FIELD bxdc003 name="construct.a.bxdc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdc004
            #add-point:ON ACTION controlp INFIELD bxdc004 name="construct.c.bxdc004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bxdc004  #顯示到畫面上
            NEXT FIELD bxdc004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdc004
            #add-point:BEFORE FIELD bxdc004 name="construct.b.bxdc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdc004
            
            #add-point:AFTER FIELD bxdc004 name="construct.a.bxdc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdb012
            #add-point:BEFORE FIELD bxdb012 name="construct.b.bxdb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdb012
            
            #add-point:AFTER FIELD bxdb012 name="construct.a.bxdb012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdb012
            #add-point:ON ACTION controlp INFIELD bxdb012 name="construct.c.bxdb012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bxdb013
            #add-point:BEFORE FIELD bxdb013 name="construct.b.bxdb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bxdb013
            
            #add-point:AFTER FIELD bxdb013 name="construct.a.bxdb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bxdb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bxdb013
            #add-point:ON ACTION controlp INFIELD bxdb013 name="construct.c.bxdb013"
            
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
            CALL abxp350_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.checkbox1 = 'N'
            LET g_master.checkbox2 = 'N'
            LET g_master.bxdfdocdt = g_today
            SELECT oogc015 INTO g_master.bxdf001 FROM oogc_t
             WHERE oogcent = g_enterprise
               AND oogc001 = g_ooef.ooef008
               AND oogc002 = g_ooef.ooef009
               AND oogc003 = g_master.bxdfdocdt
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
         CALL abxp350_init()
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
                 CALL abxp350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abxp350_transfer_argv(ls_js)
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
 
{<section id="abxp350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abxp350_transfer_argv(ls_js)
 
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
 
{<section id="abxp350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abxp350_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_bxdfdocno LIKE bxdf_t.bxdfdocno
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   CALL s_transaction_begin()
   CALL abxp350_insert_bxdf() RETURNING l_success,l_bxdfdocno
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      IF NOT abxp350_insert_bxdg(l_bxdfdocno) THEN
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF
   DISPLAY 100 TO stagecomplete
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abxp350_process_cs CURSOR FROM ls_sql
#  FOREACH abxp350_process_cs INTO
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
   CALL abxp350_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abxp350.get_buffer" >}
PRIVATE FUNCTION abxp350_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.checkbox1 = p_dialog.getFieldBuffer('checkbox1')
   LET g_master.checkbox2 = p_dialog.getFieldBuffer('checkbox2')
   LET g_master.bxdfdocno = p_dialog.getFieldBuffer('bxdfdocno')
   LET g_master.bxdfdocdt = p_dialog.getFieldBuffer('bxdfdocdt')
   LET g_master.bxdf001 = p_dialog.getFieldBuffer('bxdf001')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abxp350.msgcentre_notify" >}
PRIVATE FUNCTION abxp350_msgcentre_notify()
 
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
 
{<section id="abxp350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION abxp350_bxdfdocno_ref()
DEFINE l_flag            LIKE type_t.num5
DEFINE l_site            LIKE ooef_t.ooef005
DEFINE l_ooef004         LIKE ooef_t.ooef004
DEFINE l_success         LIKE type_t.num5
DEFINE l_slip            LIKE oobal_t.oobal002
   LET g_master.bxdfdocno_desc = ''
   IF cl_null(g_master.bxdfdocno) THEN
      RETURN
   END IF   
   #抓取單據別
   LET l_slip = ''
   CALL s_aooi200_get_slip(g_master.bxdfdocno) RETURNING l_success,l_slip 
   IF NOT l_success THEN
      RETURN
   END IF

   #抓取單據別說明
   SELECT oobxl003 INTO g_master.bxdfdocno_desc
     FROM oobxl_t
    WHERE oobxlent = g_enterprise
      AND oobxl001 = l_slip 
      AND oobxl002 = g_dlang

   DISPLAY BY NAME g_master.bxdfdocno_desc
END FUNCTION
#新增bxdf
PRIVATE FUNCTION abxp350_insert_bxdf()
DEFINE l_bxdf RECORD  #保稅機器設備盤點底稿單頭檔
       bxdfent LIKE bxdf_t.bxdfent, #企业编号
       bxdfsite LIKE bxdf_t.bxdfsite, #营运据点
       bxdfdocno LIKE bxdf_t.bxdfdocno, #盘点单号
       bxdfdocdt LIKE bxdf_t.bxdfdocdt, #盘点日期
       bxdf001 LIKE bxdf_t.bxdf001, #盘点年度
       bxdf002 LIKE bxdf_t.bxdf002, #盘点人员
       bxdf003 LIKE bxdf_t.bxdf003, #盘点部门
       bxdf010 LIKE bxdf_t.bxdf010, #备注
       bxdfownid LIKE bxdf_t.bxdfownid, #资料所有者
       bxdfowndp LIKE bxdf_t.bxdfowndp, #资料所有部门
       bxdfcrtid LIKE bxdf_t.bxdfcrtid, #资料录入者
       bxdfcrtdp LIKE bxdf_t.bxdfcrtdp, #资料录入部门
       bxdfcrtdt LIKE bxdf_t.bxdfcrtdt, #资料创建日
       bxdfmodid LIKE bxdf_t.bxdfmodid, #资料更改者
       bxdfmoddt LIKE bxdf_t.bxdfmoddt, #最近更改日
       bxdfcnfid LIKE bxdf_t.bxdfcnfid, #资料审核者
       bxdfcnfdt LIKE bxdf_t.bxdfcnfdt, #数据审核日
       bxdfstus LIKE bxdf_t.bxdfstus  #状态码
END RECORD
DEFINE l_success LIKE type_t.num5
DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   LET l_bxdf.bxdfent = g_enterprise
   LET l_bxdf.bxdfsite = g_site
    CALL s_aooi200_gen_docno(g_site,g_master.bxdfdocno,g_master.bxdfdocdt,'abxt350') 
                  RETURNING l_success,l_bxdf.bxdfdocno
    IF NOT l_success THEN
       LET r_success = FALSE
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'apm-00003'
       LET g_errparam.extend = l_bxdf.bxdfdocno
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN r_success,l_bxdf.bxdfdocno
    END IF
    LET l_bxdf.bxdfdocdt = g_master.bxdfdocdt
    LET l_bxdf.bxdf001 = g_master.bxdf001
    LET l_bxdf.bxdf002 = g_user
    LET l_bxdf.bxdf003 = g_dept
    LET l_bxdf.bxdfownid = g_user
    LET l_bxdf.bxdfowndp = g_dept
    LET l_bxdf.bxdfcrtid = g_user
    LET l_bxdf.bxdfcrtdp = g_dept 
    LET l_bxdf.bxdfcrtdt = cl_get_current()
    LET l_bxdf.bxdfmodid = g_user
    LET l_bxdf.bxdfmoddt = cl_get_current()
    LET l_bxdf.bxdfstus = 'N'
    
    INSERT INTO bxdf_t(bxdfent,bxdfsite,bxdfdocno,bxdfdocdt,bxdf001,bxdf002,bxdf003,
                       bxdf010,bxdfownid,bxdfowndp,bxdfcrtid,bxdfcrtdp,bxdfcrtdt,bxdfmodid,
                       bxdfmoddt,bxdfcnfid,bxdfcnfdt,bxdfstus)
                VALUES(l_bxdf.bxdfent,l_bxdf.bxdfsite,l_bxdf.bxdfdocno,l_bxdf.bxdfdocdt,l_bxdf.bxdf001,l_bxdf.bxdf002,l_bxdf.bxdf003,
                       l_bxdf.bxdf010,l_bxdf.bxdfownid,l_bxdf.bxdfowndp,l_bxdf.bxdfcrtid,l_bxdf.bxdfcrtdp,l_bxdf.bxdfcrtdt,l_bxdf.bxdfmodid,
                       l_bxdf.bxdfmoddt,l_bxdf.bxdfcnfid,l_bxdf.bxdfcnfdt,l_bxdf.bxdfstus)
    IF SQLCA.SQLCODE THEN
       LET r_success = FALSE
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.SQLCODE
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN r_success,l_bxdf.bxdfdocno
    END IF
    RETURN r_success,l_bxdf.bxdfdocno
END FUNCTION
#新增bxdg_t
PRIVATE FUNCTION abxp350_insert_bxdg(p_bxdfdocno)
DEFINE l_bxdg RECORD  #保稅機器設備盤點底稿單身檔
       bxdgent LIKE bxdg_t.bxdgent, #企业编号
       bxdgsite LIKE bxdg_t.bxdgsite, #营运据点
       bxdgdocno LIKE bxdg_t.bxdgdocno, #盘点单号
       bxdgseq LIKE bxdg_t.bxdgseq, #项次
       bxdg001 LIKE bxdg_t.bxdg001, #机器设备编号
       bxdg002 LIKE bxdg_t.bxdg002, #序号
       bxdg003 LIKE bxdg_t.bxdg003, #账面结余数量
       bxdg004 LIKE bxdg_t.bxdg004, #外送数量
       bxdg005 LIKE bxdg_t.bxdg005, #盘点数量
       bxdg006 LIKE bxdg_t.bxdg006  #备注
END RECORD
DEFINE p_bxdfdocno LIKE bxdf_t.bxdfdocno
DEFINE l_sql    STRING
DEFINE r_success   LIKE type_t.num5
   LET r_success = TRUE
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = "1=1"
   END IF
   LET l_sql = "SELECT ",g_enterprise,",'",g_site,"','",p_bxdfdocno,"',rownum,bxdb001,",
               "        bxdc002,bxdc007,bxdc010,bxdc007 + bxdc010",
               "  FROM bxdb_t LEFT OUTER JOIN bxdc_t ON bxdcent = bxdbent ",
               "   AND bxdcsite = bxdbsite AND bxdc001 = bxdb001 ",
               " WHERE bxdbent = ",g_enterprise," AND bxdbsite = '",g_site,"'",
               "   AND bxdbstus = 'Y' AND ",g_master.wc
   IF g_master.checkbox1 = 'N' THEN
      LET l_sql = l_sql," AND bxdc007 <> 0"
   END IF
   
   IF g_master.checkbox2 = 'N' THEN
      LET l_sql = l_sql," AND bxdc005 <> bxdc013"
   END IF
   
   LET l_sql = " INSERT INTO bxdg_t(bxdgent,bxdgsite,bxdgdocno,bxdgseq,bxdg001,bxdg002,bxdg003,bxdg004,bxdg005) ",l_sql," ORDER BY bxdc002"
   PREPARE insert_bxdg_prep FROM l_sql
   EXECUTE insert_bxdg_prep
   IF SQLCA.SQLCODE THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
