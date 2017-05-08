#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp203.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-04-16 09:56:06), PR版次:0009(2017-03-31 13:49:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: axcp203
#+ Description: 報工單批次產生製程成本工時作業
#+ Creator....: 03297(2015-04-10 16:24:44)
#+ Modifier...: 03297 -SD/PR- 08525
 
{</section>}
 
{<section id="axcp203.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161019-00017#4  2016/10/21 By lixiang  调整组织栏位的开窗
#161124-00048#17 2016/12/16 By 08734    星号整批调整
#170219-00001#1  2017/02/19 By Whitney  
#170217-00025#6  2017/02/28 By zhujing  整批调整未产生数据时，提示消息修正。
#170327-00098#1  2017/03/28 By 02295    存在已审核的资料时不允许再次产生
#160711-00040#36 2017/03/30 By 08734    T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                       CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#170330-00022#1  2017/03/30 By zhaoqya  修正取值时取到xcbrxcbrcomp
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
       sfaasite LIKE type_t.chr10, 
   comp LIKE type_t.chr500, 
   sfaadocno LIKE type_t.chr20, 
   sfaa010 LIKE type_t.chr500, 
   sfaadocdt LIKE type_t.dat, 
   xcbqdocno LIKE type_t.chr20, 
   xcbq001 LIKE type_t.dat, 
   Outsourcing LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003         LIKE glaa_t.glaa003
DEFINE g_glaa010         LIKE glaa_t.glaa010  #170219-00001#1
DEFINE g_glaa011         LIKE glaa_t.glaa011  #170219-00001#1
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaa024         LIKE glaa_t.glaa024
DEFINE g_flag1           LIKE type_t.chr1
DEFINE g_errno           LIKE type_t.chr100
DEFINE g_glav002         LIKE glav_t.glav002
DEFINE g_glav005         LIKE glav_t.glav005
DEFINE g_bdate           LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE g_edate           LIKE glav_t.glav004
DEFINE g_sdate_s         LIKE glav_t.glav004
DEFINE g_sdate_e         LIKE glav_t.glav004
DEFINE g_glav006         LIKE glav_t.glav006
DEFINE g_glav007         LIKE glav_t.glav007
DEFINE g_wdate_s         LIKE glav_t.glav004
DEFINE g_wdate_e         LIKE glav_t.glav004
DEFINE g_wc_comp         STRING
DEFINE g_tmp             STRING
DEFINE g_token           base.StringTokenizer
DEFINE g_compp           STRING
DEFINE g_flag            LIKE type_t.num5 #170217-00025#6 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp203.main" >}
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
      CALL axcp203_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp203 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp203_init()
 
      #進入選單 Menu (="N")
      CALL axcp203_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp203
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp203.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp203_init()
 
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
 
{<section id="axcp203.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp203_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE  l_success  LIKE type_t.num5
   DEFINE  l_sql1     STRING   #160711-00040#36 add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcbqdocno,g_master.xcbq001,g_master.Outsourcing 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbqdocno
            #add-point:BEFORE FIELD xcbqdocno name="input.b.xcbqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbqdocno
            
            #add-point:AFTER FIELD xcbqdocno name="input.a.xcbqdocno"
            IF NOT cl_null(g_master.xcbqdocno) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcbq_t WHERE "||"xcbqent = '" ||g_enterprise|| "' AND "||"xcbqdocno = '"||g_master.xcbqdocno ||"'",'std-00004',0) THEN
                 NEXT FIELD CURRENT
               END IF
               #CALL axcp203_get_glaa('')  #170219-00001#1
               CALL s_aooi200_fin_chk_docno(g_glaald,g_glaa024,g_glaa003,g_master.xcbqdocno,g_master.xcbq001,'axct203') RETURNING l_success
               IF l_success = FALSE THEN
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbqdocno
            #add-point:ON CHANGE xcbqdocno name="input.g.xcbqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbq001
            #add-point:BEFORE FIELD xcbq001 name="input.b.xcbq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbq001
            
            #add-point:AFTER FIELD xcbq001 name="input.a.xcbq001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbq001
            #add-point:ON CHANGE xcbq001 name="input.g.xcbq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD Outsourcing
            #add-point:BEFORE FIELD Outsourcing name="input.b.Outsourcing"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD Outsourcing
            
            #add-point:AFTER FIELD Outsourcing name="input.a.Outsourcing"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE Outsourcing
            #add-point:ON CHANGE Outsourcing name="input.g.Outsourcing"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcbqdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbqdocno
            #add-point:ON ACTION controlp INFIELD xcbqdocno name="input.c.xcbqdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #CALL axcp203_get_glaa('')  #170219-00001#1
            
            LET g_qryparam.default1 = g_master.xcbqdocno             #給予default值
            LET g_qryparam.where = " ooba001 = '",g_glaa024,"' AND oobx003 = 'axct203'" 
            #160711-00040#36 add(S)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",l_sql1
            END IF
            #160711-00040#36 add(E)
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooba002_4()                                #呼叫開窗

            LET g_master.xcbqdocno = g_qryparam.return1              

            DISPLAY g_master.xcbqdocno TO xcbqdocno              #

            NEXT FIELD xcbqdocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcbq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbq001
            #add-point:ON ACTION controlp INFIELD xcbq001 name="input.c.xcbq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.Outsourcing
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD Outsourcing
            #add-point:ON ACTION controlp INFIELD Outsourcing name="input.c.Outsourcing"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON sfaasite,sfaadocno,sfaa010,sfaadocdt
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.sfaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaasite
            #add-point:ON ACTION controlp INFIELD sfaasite name="construct.c.sfaasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗 #161019-00017#4
            CALL q_ooef001_1()   #161019-00017#4
            DISPLAY g_qryparam.return1 TO sfaasite  #顯示到畫面上
            NEXT FIELD sfaasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaasite
            #add-point:BEFORE FIELD sfaasite name="construct.b.sfaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaasite
            
            #add-point:AFTER FIELD sfaasite name="construct.a.sfaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno name="construct.c.sfaadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF cl_null(g_master.xcbq001) THEN
               LET g_qryparam.where = #" EXISTS ( SELECT 1 FROM sfeb_t,sfea_t WHERE sfaadocno = sfeb001 AND sfaaent = sfebent AND sfeaent = sfebent AND sfeadocno = sfebdocno AND sfeastus = 'Y' ) ",
                                      "  EXISTS ( SELECT 1 FROM sffb_t WHERE sfaadocno = sffb005 AND sfaaent = sffbent AND sffbstus = 'Y' ) "
#            ELSE
#               CALL axcp203_get_glaa('')
#               LET g_qryparam.where = #" EXISTS ( SELECT 1 FROM sfeb_t,sfea_t WHERE sfaadocno = sfeb001 AND sfaaent = sfebent AND sfeaent = sfebent AND sfeadocno = sfebdocno AND sfeastus = 'Y' AND sfeadocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'  ) ",
#                                      "  EXISTS ( SELECT 1 FROM sffb_t WHERE sfaadocno = sffb005 AND sfaaent = sffbent  AND sffbstus = 'Y' AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"' ) "
            END IF

            CALL q_sfaadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
            NEXT FIELD sfaadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocno
            #add-point:BEFORE FIELD sfaadocno name="construct.b.sfaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocno
            
            #add-point:AFTER FIELD sfaadocno name="construct.a.sfaadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010 name="construct.c.sfaa010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上
            NEXT FIELD sfaa010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa010
            #add-point:BEFORE FIELD sfaa010 name="construct.b.sfaa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa010
            
            #add-point:AFTER FIELD sfaa010 name="construct.a.sfaa010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocdt
            #add-point:BEFORE FIELD sfaadocdt name="construct.b.sfaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocdt
            
            #add-point:AFTER FIELD sfaadocdt name="construct.a.sfaadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocdt
            #add-point:ON ACTION controlp INFIELD sfaadocdt name="construct.c.sfaadocdt"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc_comp ON comp
            BEFORE CONSTRUCT
            
                     #Ctrlp:construct.c.comp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD comp
            #add-point:ON ACTION controlp INFIELD comp
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO comp  #顯示到畫面上
#            LET g_compp = g_qryparam.return1
            NEXT FIELD comp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD comp
            #add-point:BEFORE FIELD comp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD comp
            
            #add-point:AFTER FIELD comp
            CALL GET_FLDBUF(comp) RETURNING g_compp
            #END add-point
         END CONSTRUCT
 
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
            CALL axcp203_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            #170219-00001#1-s
            #LET g_master.xcbq001 = g_today
            CALL axcp203_get_glaa('')
            CALL cl_get_para(g_enterprise,g_site,'S-FIN-6010') RETURNING g_glaa010
            CALL cl_get_para(g_enterprise,g_site,'S-FIN-6011') RETURNING g_glaa011
            CALL s_fin_date_get_period_range(g_glaa003,g_glaa010,g_glaa011)
                 RETURNING g_bdate,g_edate
            LET g_master.xcbq001 = g_edate
            DISPLAY BY NAME g_master.xcbq001
            #170219-00001#1-e
            LET g_master.Outsourcing = 'N'
            DISPLAY g_site TO sfaasite
            DISPLAY g_site TO comp
            LET g_compp = g_site
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
         CALL axcp203_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
#      LET g_wc_comp = cl_replace_str(g_wc_comp,"comp=","")
#      LET g_wc_comp = cl_replace_str(g_wc_comp,"'","")      
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
                 CALL axcp203_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp203_transfer_argv(ls_js)
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
 
{<section id="axcp203.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp203_transfer_argv(ls_js)
 
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
 
{<section id="axcp203.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp203_process(ls_js)
 
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
   LET g_flag = FALSE   #170217-00025#6 add

   

   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(2)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp203_process_cs CURSOR FROM ls_sql
#  FOREACH axcp203_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_transaction_begin()  #事务开始
      CALL cl_err_collect_init()  #汇总错误讯息初始化
      LET g_success = 'Y'
      
      CALL axcp203_execute()
      
      
      #CALL s_transaction_end(g_success,0)  #事务结束
      
      #170217-00025#6 add-S
      IF g_flag = FALSE THEN
         CALL cl_err_collect_show()  #显示错误讯息汇总
         CALL s_transaction_end('N','0')  #事务结束
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN        
      END IF
      #170217-00025#6 add-E
      IF g_success = 'N' THEN
         CALL cl_err_collect_show()  #显示错误讯息汇总
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_transaction_begin()  #事务开始
      CALL cl_err_collect_init()  #汇总错误讯息初始化
      LET g_success = 'Y'
      CALL axcp203_execute()
      
      #170217-00025#6 add-S
      IF g_flag = FALSE THEN
         CALL cl_err_collect_show()  #显示错误讯息汇总
         CALL s_transaction_end('N','0')  #事务结束
         RETURN        
      END IF
      #170217-00025#6 add-E
      IF g_success = 'N' THEN
         CALL cl_err_collect_show()  #显示错误讯息汇总
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp203_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp203.get_buffer" >}
PRIVATE FUNCTION axcp203_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcbqdocno = p_dialog.getFieldBuffer('xcbqdocno')
   LET g_master.xcbq001 = p_dialog.getFieldBuffer('xcbq001')
   LET g_master.Outsourcing = p_dialog.getFieldBuffer('Outsourcing')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp203.msgcentre_notify" >}
PRIVATE FUNCTION axcp203_msgcentre_notify()
 
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
 
{<section id="axcp203.other_function" readonly="Y" >}
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
PRIVATE FUNCTION axcp203_execute()
DEFINE l_count LIKE type_t.num5
#DEFINE l_xcbr  RECORD  LIKE xcbr_t.*  #161124-00048#17  2016/12/16  By 08734 mark
#161124-00048#17  2016/12/16  By 08734 add(S)
DEFINE l_xcbr RECORD  #製程成本工時單身檔
       xcbrent LIKE xcbr_t.xcbrent, #企业编号
       xcbrsite LIKE xcbr_t.xcbrsite, #营运据点
       xcbrcomp LIKE xcbr_t.xcbrcomp, #法人组织
       xcbrdocno LIKE xcbr_t.xcbrdocno, #单据编号
       xcbrseq LIKE xcbr_t.xcbrseq, #行序
       xcbr001 LIKE xcbr_t.xcbr001, #成本中心
       xcbr002 LIKE xcbr_t.xcbr002, #工单编号
       xcbr003 LIKE xcbr_t.xcbr003, #作业编号
       xcbr004 LIKE xcbr_t.xcbr004, #工艺序
       xcbr009 LIKE xcbr_t.xcbr009, #备注
       xcbr099 LIKE xcbr_t.xcbr099, #良品数量
       xcbr100 LIKE xcbr_t.xcbr100, #报废数量
       xcbr101 LIKE xcbr_t.xcbr101, #期末在制数量
       xcbr102 LIKE xcbr_t.xcbr102, #期末在制约当率
       xcbr103 LIKE xcbr_t.xcbr103, #期末在制约当量
       xcbr104 LIKE xcbr_t.xcbr104, #报工数量
       xcbr201 LIKE xcbr_t.xcbr201, #实际工时
       xcbr202 LIKE xcbr_t.xcbr202, #实际机时
       xcbr203 LIKE xcbr_t.xcbr203, #标准工时
       xcbr204 LIKE xcbr_t.xcbr204 #标准机时
END RECORD
#161124-00048#17  2016/12/16  By 08734 add(E)
#DEFINE l_xcbq  RECORD  LIKE xcbq_t.*  #161124-00048#17  2016/12/16  By 08734 mark
#161124-00048#17  2016/12/16  By 08734 add(S)
DEFINE l_xcbq RECORD  #製程成本工時單頭檔
       xcbqent LIKE xcbq_t.xcbqent, #企业编号
       xcbqsite LIKE xcbq_t.xcbqsite, #营运组织
       xcbqcomp LIKE xcbq_t.xcbqcomp, #法人组织
       xcbqdocno LIKE xcbq_t.xcbqdocno, #单据编号
       xcbq001 LIKE xcbq_t.xcbq001, #日期
       xcbq002 LIKE xcbq_t.xcbq002, #备注
       xcbqownid LIKE xcbq_t.xcbqownid, #资料所有者
       xcbqowndp LIKE xcbq_t.xcbqowndp, #资料所有部门
       xcbqcrtid LIKE xcbq_t.xcbqcrtid, #资料录入者
       xcbqcrtdp LIKE xcbq_t.xcbqcrtdp, #资料录入部门
       xcbqcrtdt LIKE xcbq_t.xcbqcrtdt, #资料创建日
       xcbqmodid LIKE xcbq_t.xcbqmodid, #资料更改者
       xcbqmoddt LIKE xcbq_t.xcbqmoddt, #最近更改日
       xcbqcnfid LIKE xcbq_t.xcbqcnfid, #资料审核者
       xcbqcnfdt LIKE xcbq_t.xcbqcnfdt, #数据审核日
       xcbqstus LIKE xcbq_t.xcbqstus #状态码
END RECORD
#161124-00048#17  2016/12/16  By 08734 add(E)
DEFINE l_seq     LIKE type_t.num5
DEFINE l_sfaa068 LIKE sfaa_t.sfaa068
DEFINE l_sfaa010 LIKE sfaa_t.sfaa010
DEFINE l_success LIKE type_t.num5
DEFINE l_flag    LIKE type_t.chr1 
 TYPE type_sffb RECORD
  sffbsite LIKE sffb_t.sffbsite, 
   sffb005 LIKE sffb_t.sffb005,
   sffb007 LIKE sffb_t.sffb007,
   sffb008 LIKE sffb_t.sffb008,
   sffb014 LIKE sffb_t.sffb014,
   sffb015 LIKE sffb_t.sffb015,
   sffb017 LIKE sffb_t.sffb017,
   sffb018 LIKE sffb_t.sffb018
  ,sffb030 LIKE sffb_t.sffb030  #170219-00001#1
       END RECORD
DEFINE l_sffb type_sffb
DEFINE l_cnt  LIKE type_t.num5
DEFINE l_msg     STRING
DEFINE l_site_t   LIKE sffb_t.sffbsite
DEFINE l_xcbqdocno  LIKE xcbq_t.xcbqdocno
DEFINE l_comp     STRING
#170219-00001#1-s
DEFINE l_sfcb024    LIKE sfcb_t.sfcb024
DEFINE l_sfcb026    LIKE sfcb_t.sfcb026
DEFINE l_sfcb027    LIKE sfcb_t.sfcb027
DEFINE l_qty        LIKE sfcb_t.sfcb027
DEFINE l_ld         LIKE glaa_t.glaald
DEFINE l_docno      LIKE xcbq_t.xcbqdocno
DEFINE l_date       LIKE xcbq_t.xcbq001
DEFINE l_prog       LIKE gzzz_t.gzzz001
#170219-00001#1-e

   WHENEVER ERROR CONTINUE
   
   IF cl_null(g_compp) THEN LET g_success = 'N' RETURN END IF
   
   #170327-00098#1--add--e
   LET g_tmp = " SELECT UNIQUE xcbrdocno,xcbrseq FROM xcbr_t,xcbq_t,sffb_t ",
               "   LEFT JOIN sfaa_t ON sfaadocno = sffb005 AND sfaaent = sffbent ",
               "  WHERE sffbent = '",g_enterprise,"'",
               "    AND sffb012 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND sffbstus = 'Y' ",
               "    AND ",g_master.wc,
               "    AND xcbqent = xcbrent AND xcbqdocno = xcbrdocno AND xcbqstus = 'Y' ",
               "    AND xcbrent = sffbent AND xcbrsite = sffbsite ",
               "    AND xcbr002 = sffb005 AND xcbr003 = sffb007 AND xcbr004 = sffb008 "

   IF g_wc_comp <> " 1=1" THEN
      LET g_wc_comp = cl_replace_str(g_wc_comp,"comp","xcbrcomp")
      LET g_tmp = g_tmp CLIPPED,"    AND  ",g_wc_comp
   END IF
   IF g_master.Outsourcing = 'N' THEN
      LET g_tmp = g_tmp," AND sfaa057 != '2'"
   END IF
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM (",g_tmp,") "
   PREPARE cursor_cnt_pre_2 FROM g_sql
   EXECUTE cursor_cnt_pre_2 INTO l_cnt
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00830'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   #170327-00098#1--add--e
   
#DELETE
   #刪除舊值
   LET l_msg = cl_getmsg("axc-00499",g_dlang)  #删除旧值
   CALL cl_progress_no_window_ing(l_msg)
   
   LET g_tmp = " SELECT UNIQUE xcbrdocno,xcbrseq FROM xcbr_t,xcbq_t,sffb_t ",
               "   LEFT JOIN sfaa_t ON sfaadocno = sffb005 AND sfaaent = sffbent ",
               "  WHERE sffbent = '",g_enterprise,"'", 
               #170219-00001#1-s
               #"    AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND sffb012 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               #170219-00001#1-e
               "    AND sffbstus = 'Y' ",
               "    AND ",g_master.wc,
               "    AND xcbqent = xcbrent AND xcbqdocno = xcbrdocno AND xcbqstus = 'N' ",
               "    AND xcbrent = sffbent AND xcbrsite = sffbsite ",
               "    AND xcbr002 = sffb005 AND xcbr003 = sffb007 AND xcbr004 = sffb008 "
               
   IF g_wc_comp <> " 1=1" THEN
      #LET g_wc_comp = cl_replace_str(g_wc_comp,"comp","xcbrcomp")     #170330-00022#1 mark  
#      LET g_tmp = g_tmp CLIPPED,"    AND xcbrcomp = '",g_wc_comp,"'"
      LET g_tmp = g_tmp CLIPPED,"    AND  ",g_wc_comp
   END IF
   IF g_master.Outsourcing = 'N' THEN 
      LET g_tmp = g_tmp," AND sfaa057 != '2'"
   END IF   
   
   LET g_sql = " SELECT COUNT(*) FROM (",g_tmp,") "   
   PREPARE cursor_cnt_pre FROM g_sql
   DECLARE cursor_cnt_cs CURSOR FOR cursor_cnt_pre 


   LET g_sql = "DELETE FROM xcbr_t a",
               " WHERE a.xcbrent = '",g_enterprise,"'",
               "   AND EXISTS ( SELECT 1 FROM (",g_tmp,") b WHERE a.xcbrdocno = b.xcbrdocno AND a.xcbrseq = b.xcbrseq )"
   PREPARE cursor_pre_1 FROM g_sql 

   LET g_sql = "DELETE FROM xcbq_t ",
               " WHERE xcbqent = '",g_enterprise,"'",
               "   AND xcbq001 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "   AND xcbqstus = 'N' ",
               "   AND NOT EXISTS ( SELECT 1 FROM xcbr_t WHERE xcbrent = xcbqent AND xcbrdocno = xcbqdocno )"
   PREPARE cursor_pre_2 FROM g_sql 

   #170219-00001#1-s
   LET g_sql = " SELECT glaald,xcbqdocno,xcbq001 FROM xcbq_t ",
               "   LEFT JOIN glaa_t ON glaaent = xcbqent AND glaacomp = xcbqcomp AND glaa014 = 'Y' ",
               "  WHERE xcbqent = ",g_enterprise,
               "    AND xcbq001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
               "    AND xcbqstus = 'N' ",
               "    AND NOT EXISTS ( SELECT 1 FROM xcbr_t WHERE xcbrent = xcbqent AND xcbrdocno = xcbqdocno ) ",
               "  ORDER BY xcbqdocno DESC "
   PREPARE del_docno_pre FROM g_sql
   DECLARE del_docno_cur CURSOR FOR del_docno_pre
   #170219-00001#1-e

   LET l_cnt = 0
   OPEN cursor_cnt_cs
   FETCH cursor_cnt_cs INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'FETCH cursor_cnt_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'      
      RETURN 
   END IF
   
   IF l_cnt > 0 THEN
      IF cl_ask_confirm('axc-00717') THEN
         EXECUTE cursor_pre_1  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'DELETE xcbr FILE'
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET g_success = 'N'
            RETURN
         END IF
         FOREACH del_docno_cur INTO l_ld,l_docno,l_date
            LET l_prog = g_prog
            LET g_prog = 'axct203'
            CALL s_aooi200_fin_del_docno(l_ld,l_docno,l_date) RETURNING l_success
            LET g_prog = l_prog
         END FOREACH
         EXECUTE cursor_pre_2 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'DELETE xcbq FILE'
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET g_success = 'N'
            RETURN
         END IF   
      ELSE
         RETURN      
      END IF
   END IF

#generate
   #從報工單抓取
   LET l_msg = cl_getmsg("axc-00688",g_dlang)  #从报工单抓取
   CALL cl_progress_no_window_ing(l_msg)
   #170219-00001#1-s
   #LET g_sql = " SELECT sffbsite,sffb005,sffb007,sffb008,SUM(sffb014),SUM(sffb015),SUM(sffb017),SUM(sffb018) FROM sffb_t ",
   LET g_sql = " SELECT sffbsite,sffb005,sffb007,sffb008,SUM(sffb014),SUM(sffb015),SUM(sffb017),SUM(sffb018),sffb030, ",
               "        SUM(sffb017*sfcb024),SUM(sffb017*sfcb026),SUM(sfcb027) ",
               "   FROM sfcb_t,sffb_t ",
   #170219-00001#1-e
               "   LEFT JOIN sfaa_t ON sfaadocno = sffb005 AND sfaaent = sffbent ",
               "  WHERE sffbent = '",g_enterprise,"'",
               #170219-00001#1-s
               #"    AND sffbdocdt BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               "    AND sffb012 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
               #170219-00001#1-e
               "    AND sffbstus = 'Y' ",
               "    AND sffb001 ='3'",  #160929-00005#3
               #170219-00001#1-s
               "    AND sfcbent = sffbent ",
               "    AND sfcbdocno = sffb005 ",  #工單單號
               "    AND sfcb001 = sffb006 ",    #Run Card
               "    AND sfcb003 = sffb007 ",    #作業編號
               "    AND sfcb004 = sffb008 ",    #製程式
               #170219-00001#1-e
               "    AND ",g_master.wc
               
   IF g_master.Outsourcing = 'N' THEN 
      LET g_sql = g_sql," AND sfaa057 != '2'"
   END IF
   #170219-00001#1-s
   #LET g_sql = g_sql," GROUP BY sffbsite,sffb005,sffb007,sffb008 ",
   LET g_sql = g_sql," GROUP BY sffbsite,sffb005,sffb007,sffb008,sffb030 ",
   #170219-00001#1-e
                     " ORDER BY sffbsite "
   PREPARE sffb_pre FROM g_sql
   DECLARE sffb_cur CURSOR FOR sffb_pre
    

   
   LET g_token = base.StringTokenizer.create(g_compp,"|")
   WHILE g_token.hasMoreTokens() 
      LET l_comp =g_token.nextToken()
      LET l_site_t = ''
      #170219-00001#1-s
      #FOREACH sffb_cur INTO l_sffb.*
      FOREACH sffb_cur INTO l_sffb.*,l_sfcb024,l_sfcb026,l_sfcb027
      #170219-00001#1-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:sffb"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'         
            EXIT FOREACH
            RETURN
         END IF
         
         IF cl_null(l_site_t) OR l_sffb.sffbsite <> l_site_t THEN 
            LET l_flag = 'N' 
            #xcdqdocno 单号 自动编号
            CALL axcp203_get_glaa(l_sffb.sffbsite)            
#            CALL s_aooi200_fin_chk_docno(g_glaald,g_glaa024,g_glaa003,g_master.xcbqdocno,g_master.xcbq001,'axct203') RETURNING l_success
#            IF l_success  = 0  THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'amm-00001'
#               LET g_errparam.extend = l_sffb.sffbsite
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = 'N'         
#               EXIT FOREACH
#               RETURN
#            END IF
            CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_master.xcbqdocno,g_master.xcbq001,'axct203')
            RETURNING l_success,l_xcbqdocno
            IF l_success  = 0  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00003'
               LET g_errparam.extend = l_xcbqdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL cl_err_collect_show()
               LET g_success = 'N'         
               EXIT FOREACH
               RETURN
            END IF
            
            LET l_xcbq.xcbqent = g_enterprise
            LET l_xcbq.xcbqsite = l_sffb.sffbsite
#            IF g_wc_comp = " 1=1" THEN 
#               LET l_xcbq.xcbqcomp = l_sffb.sffbsite 
#            ELSE
               LET l_xcbq.xcbqcomp = l_comp         
#            END IF
            LET l_xcbq.xcbqdocno = l_xcbqdocno
            LET l_xcbq.xcbq001 = g_master.xcbq001
            LET l_xcbq.xcbq002 = ' '
            LET l_xcbq.xcbqownid = g_user
            LET l_xcbq.xcbqowndp = g_dept
            LET l_xcbq.xcbqcrtid = g_user
            LET l_xcbq.xcbqcrtdp = g_dept 
            LET l_xcbq.xcbqcrtdt = cl_get_current()
            LET l_xcbq.xcbqmodid = ""
            LET l_xcbq.xcbqmoddt = ""      
            LET l_xcbq.xcbqcnfid = ""
            LET l_xcbq.xcbqcnfdt = ""  
            LET l_xcbq.xcbqstus = 'N'
            
            #INSERT INTO xcbq_t VALUES(l_xcbq.*)  #161124-00048#17  2016/12/16  By 08734 mark
            INSERT INTO xcbq_t(xcbqent,xcbqsite,xcbqcomp,xcbqdocno,xcbq001,xcbq002,xcbqownid,
            xcbqowndp,xcbqcrtid,xcbqcrtdp,xcbqcrtdt,xcbqmodid,xcbqmoddt,xcbqcnfid,xcbqcnfdt,xcbqstus )  #161124-00048#17  2016/12/16  By 08734 add
               VALUES(l_xcbq.xcbqent,l_xcbq.xcbqsite,l_xcbq.xcbqcomp,l_xcbq.xcbqdocno,l_xcbq.xcbq001,l_xcbq.xcbq002,l_xcbq.xcbqownid,
            l_xcbq.xcbqowndp,l_xcbq.xcbqcrtid,l_xcbq.xcbqcrtdp,l_xcbq.xcbqcrtdt,l_xcbq.xcbqmodid,l_xcbq.xcbqmoddt,l_xcbq.xcbqcnfid,l_xcbq.xcbqcnfdt,l_xcbq.xcbqstus )
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "insert xcbq"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
               EXIT FOREACH
               RETURN
            ELSE
               #170217-00025#6 add-S
               IF SQLCA.sqlerrd[3] > 0 THEN
                  LET g_flag = TRUE
               END IF
               #170217-00025#6 add-E
               LET l_site_t = l_sffb.sffbsite
               LET l_seq = 1
               LET l_flag = 'Y'            
            END IF
         END IF 
         
         IF l_flag = 'Y' THEN            
            LET l_xcbr.xcbrent = g_enterprise
            LET l_xcbr.xcbrsite = l_sffb.sffbsite
#            IF g_wc_comp = " 1=1" THEN 
#               LET l_xcbr.xcbrcomp = l_sffb.sffbsite 
#            ELSE
               LET l_xcbr.xcbrcomp = l_comp         
#            END IF
            LET l_xcbr.xcbrdocno = l_xcbqdocno
            LET l_xcbr.xcbrseq = l_seq
            #170219-00001#1-s
            #SELECT sfaa068,sfaa010 INTO l_sfaa068,l_sfaa010 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_sffb.sffb005
            #IF cl_null(l_sfaa068) THEN LET l_sfaa068 = ' ' END IF
            #LET l_xcbr.xcbr001 = l_sfaa068  #成本中心
            LET l_xcbr.xcbr001 = l_sffb.sffb030  #成本中心
            #170219-00001#1-e
            LET l_xcbr.xcbr002 = l_sffb.sffb005  #工單編號
            LET l_xcbr.xcbr003 = l_sffb.sffb007  #作業編號
            LET l_xcbr.xcbr004 = l_sffb.sffb008  #製程式
            LET l_xcbr.xcbr009 = ''       #備註
            IF cl_null(l_sffb.sffb017) THEN LET l_sffb.sffb017 = 0 END IF
            IF cl_null(l_sffb.sffb018) THEN LET l_sffb.sffb018 = 0 END IF
            LET l_xcbr.xcbr099 = l_sffb.sffb017  #良品数量
            LET l_xcbr.xcbr100 = l_sffb.sffb018  #报废数量
            LET l_xcbr.xcbr101 = 0        #期末在制数量
            LET l_xcbr.xcbr102 = 0        #期末在制约当率
            LET l_xcbr.xcbr103 = 0        #期末在制约当量
            LET l_xcbr.xcbr104 = l_xcbr.xcbr099+l_xcbr.xcbr100+l_xcbr.xcbr103     #报工数量
            IF cl_null(l_sffb.sffb014) THEN LET l_sffb.sffb014 = 0 END IF
            IF cl_null(l_sffb.sffb015) THEN LET l_sffb.sffb015 = 0 END IF         
            LET l_xcbr.xcbr201 = l_sffb.sffb014  #实际工时
            LET l_xcbr.xcbr202 = l_sffb.sffb015  #实际机时
            #170219-00001#1-s
            #SELECT imae051,imae052 INTO l_xcbr.xcbr203,l_xcbr.xcbr204
            #  FROM imae_t
            # WHERE imaeent  = g_enterprise
            #   AND imaesite = l_sffb.sffbsite 
            #   AND imae001  = l_sfaa010
            #IF cl_null(l_xcbr.xcbr203) THEN LET l_xcbr.xcbr203 = 0 END IF
            #IF cl_null(l_xcbr.xcbr204) THEN LET l_xcbr.xcbr204 = 0 END IF                              
            #LET l_xcbr.xcbr203 = l_xcbr.xcbr104 * l_xcbr.xcbr203 #标准工时 = 报工数量*工单生产主件的单位标准工时
            #LET l_xcbr.xcbr204 = l_xcbr.xcbr104 * l_xcbr.xcbr204 #标准机时 = 报工数量*工单生产主件的单位标准机时
            SELECT SUM(xcbr104) INTO l_qty FROM xcbr_t
             WHERE xcbrent = l_xcbr.xcbrent AND xcbrsite = l_xcbr.xcbrsite AND xcbrcomp = l_xcbr.xcbrcomp
               AND xcbr001 = l_xcbr.xcbr001 AND xcbr002 = l_xcbr.xcbr002 AND xcbr003 = l_xcbr.xcbr003 AND xcbr004 = l_xcbr.xcbr004
            IF cl_null(l_qty) THEN LET l_qty = 0 END IF
            #期末在制数量=標準產出量加總-到目前為止axct203上相同條件的報工數量加總（含本身這次的）
            LET l_xcbr.xcbr101 = l_sfcb027 - l_qty - l_xcbr.xcbr104
            LET l_xcbr.xcbr203 = l_sfcb024
            LET l_xcbr.xcbr204 = l_sfcb026
            #170219-00001#1-e
            
            #INSERT INTO xcbr_t VALUES(l_xcbr.*)  #161124-00048#17  2016/12/16  By 08734 mark
            INSERT INTO xcbr_t(xcbrent,xcbrsite,xcbrcomp,xcbrdocno,xcbrseq,xcbr001,xcbr002,xcbr003,xcbr004,xcbr009,
                               xcbr099,xcbr100,xcbr101,xcbr102,xcbr103,xcbr104,xcbr201,xcbr202,xcbr203,xcbr204)  #161124-00048#17  2016/12/16  By 08734 add
               VALUES(l_xcbr.xcbrent,l_xcbr.xcbrsite,l_xcbr.xcbrcomp,l_xcbr.xcbrdocno,l_xcbr.xcbrseq,l_xcbr.xcbr001,l_xcbr.xcbr002,l_xcbr.xcbr003,l_xcbr.xcbr004,l_xcbr.xcbr009,
                      l_xcbr.xcbr099,l_xcbr.xcbr100,l_xcbr.xcbr101,l_xcbr.xcbr102,l_xcbr.xcbr103,l_xcbr.xcbr104,l_xcbr.xcbr201,l_xcbr.xcbr202,l_xcbr.xcbr203,l_xcbr.xcbr204   )
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "insert xcbr"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
               EXIT FOREACH
               RETURN
            END IF
            #170217-00025#6 add-S
            IF SQLCA.sqlerrd[3] > 0 THEN
               LET g_flag = TRUE
            END IF
            #170217-00025#6 add-E
         END IF  
         LET l_seq = l_seq + 1
      END FOREACH
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
PRIVATE FUNCTION axcp203_get_glaa(p_comp)
DEFINE p_comp LIKE xcbq_t.xcbqcomp
#DEFINE r_success LIKE type_t.num5

IF cl_null(p_comp) THEN
   LET p_comp = g_site
END IF 
#抓出会计周期参考表号  glaa003
   SELECT glaa003,glaald INTO g_glaa003,g_glaald
      FROM glaa_t
      WHERE glaaent = g_enterprise
       AND glaacomp = p_comp
       AND glaa014= 'Y' 
CALL s_ld_sel_glaa(g_glaald,'glaa024') RETURNING g_sub_success,g_glaa024 
#取得画面上年期
   CALL s_get_accdate(g_glaa003,g_master.xcbq001,'','')
     RETURNING g_flag1,g_errno,g_glav002,g_glav005,g_sdate_s,g_sdate_e,
               g_glav006,g_bdate,g_edate,g_glav007,g_wdate_s,g_wdate_e

END FUNCTION

#end add-point
 
{</section>}
 
