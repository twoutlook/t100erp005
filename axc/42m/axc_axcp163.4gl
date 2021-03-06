#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp163.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-11-28 14:14:23), PR版次:0006(2017-04-19 11:27:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcp163
#+ Description: 工單製程順序計算作業
#+ Creator....: 02294(2016-11-28 10:14:17)
#+ Modifier...: 02294 -SD/PR- 02295
 
{</section>}
 
{<section id="axcp163.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161121-00018#13    2017/02/23 By lixiang  修改非報工站不需產生，轉出站需判斷往下移到報工站(需要报工的那一站)
#170217-00025#7     2017/03/10 By zhujing  整批调整未产生数据时，提示消息修正。
#170407-00041#1     2017/04/07 By lixiang  axcp163 制程工单第一道工艺不报工时，未产生xcbt_t的资料
#170411-00037#1     2017/04/07 By lixiang  非工艺的工单只产生一笔END  转出是STORAGE的资料
#170418-00026#1     2017/04/19 By 02295    增加S-FIN-6007 当站报废转出方式为1.结案月转出时axcp163不再计算出报废数量
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
       xcbtcomp LIKE type_t.chr10, 
   xcbtcomp_desc LIKE type_t.chr80, 
   xcbt001 LIKE type_t.num5, 
   xcbt002 LIKE type_t.num5, 
   sfaadocno LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_t  type_master

DEFINE g_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE g_edate      LIKE glav_t.glav004
DEFINE g_success    LIKE type_t.chr1
DEFINE g_glaa003    LIKE glaa_t.glaa003
DEFINE g_wc_comp    STRING
DEFINE g_n          LIKE type_t.num10
DEFINE g_n_t        LIKE type_t.num10
DEFINE g_flag       LIKE type_t.num5   #170217-00025#7 add  用來記錄是否數據異動
DEFINE g_sys_6007   LIKE type_t.chr1   #170418-00026#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp163.main" >}
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
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_axc_get_authcomp() RETURNING g_wc_comp     
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp163_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp163 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp163_init()
 
      #進入選單 Menu (="N")
      CALL axcp163_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp163
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp163.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp163_init()
 
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
 
{<section id="axcp163.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp163_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      LET g_errshow = 1
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcbtcomp,g_master.xcbt001,g_master.xcbt002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
               IF cl_null(g_master.xcbtcomp) THEN
                  LET g_master.xcbtcomp = l_comp
                  CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp
                  SELECT glaa003 INTO g_glaa003 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                     AND glaacomp = g_master.xcbtcomp                     
               END IF
               IF cl_null(g_master.xcbt001) THEN
                  LET g_master.xcbt001 = l_year
                  DISPLAY BY NAME g_master.xcbt001    
               END IF
               IF cl_null(g_master.xcbt002) THEN
                  LET g_master.xcbt002 = l_period
                  DISPLAY BY NAME g_master.xcbt002
               END IF
               IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                      RETURNING g_bdate,g_edate               
               END IF 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbtcomp
            
            #add-point:AFTER FIELD xcbtcomp name="input.a.xcbtcomp"
            CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
            DISPLAY BY NAME g_master.xcbtcomp_desc
            IF NOT cl_null(g_master.xcbtcomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcbtcomp
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_ooef001_15') THEN
                  #檢查失敗時後續處理
                  LET g_master.xcbtcomp = g_master_t.xcbtcomp
                  CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp_desc
                  NEXT FIELD xcbtcomp
               END IF  
               IF s_chr_get_index_of(g_wc_comp,g_master.xcbtcomp,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00342'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xcbtcomp = g_master_t.xcbtcomp
                  CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp_desc
                  NEXT FIELD xcbtcomp
               END IF
               SELECT glaa003 INTO g_glaa003 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                  AND glaacomp = g_master.xcbtcomp                
               IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                  CALL s_fin_date_get_period_range(g_glaa003,g_master.xcbt001,g_master.xcbt002)
                   RETURNING g_bdate,g_edate               
               END IF
               DISPLAY BY NAME g_master.xcbt001,g_master.xcbt002                                       
            END IF            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbtcomp
            #add-point:BEFORE FIELD xcbtcomp name="input.b.xcbtcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbtcomp
            #add-point:ON CHANGE xcbtcomp name="input.g.xcbtcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbt001
            #add-point:BEFORE FIELD xcbt001 name="input.b.xcbt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbt001
            
            #add-point:AFTER FIELD xcbt001 name="input.a.xcbt001"
            IF NOT cl_null(g_master.xcbt001) THEN
               IF NOT s_fin_date_chk_year(g_master.xcbt001) THEN
                  LET g_master.xcbt001 = g_master_t.xcbt001
                  DISPLAY BY NAME g_master.xcbt001
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_master.xcbt001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
                                                    
            END IF  
            IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                   RETURNING g_bdate,g_edate               
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbt001
            #add-point:ON CHANGE xcbt001 name="input.g.xcbt001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbt002
            #add-point:BEFORE FIELD xcbt002 name="input.b.xcbt002"
            IF cl_null(g_master.xcbt001) THEN
               NEXT FIELD xcbt001
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbt002
            
            #add-point:AFTER FIELD xcbt002 name="input.a.xcbt002"
            IF NOT cl_null(g_master.xcbt002) THEN                      
               IF NOT s_fin_date_chk_period(g_glaa003,g_master.xcbt001,g_master.xcbt002) THEN
                  LET g_master.xcbt002 = g_master_t.xcbt002
                  DISPLAY BY NAME g_master.xcbt002
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00106'
                  LET g_errparam.extend = g_master.xcbt002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                   RETURNING g_bdate,g_edate               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbt002
            #add-point:ON CHANGE xcbt002 name="input.g.xcbt002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcbtcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbtcomp
            #add-point:ON ACTION controlp INFIELD xcbtcomp name="input.c.xcbtcomp"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.xcbtcomp             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #

            #增加法人過濾條件
            IF NOT cl_null(g_wc_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_comp
            END IF
            CALL q_ooef001_2()                                #呼叫開窗
 
            LET g_master.xcbtcomp = g_qryparam.return1   
            DISPLAY g_master.xcbtcomp TO xcbtcomp              #
            CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
            DISPLAY BY NAME g_master.xcbtcomp_desc
            NEXT FIELD xcbtcomp                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.xcbt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbt001
            #add-point:ON ACTION controlp INFIELD xcbt001 name="input.c.xcbt001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbt002
            #add-point:ON ACTION controlp INFIELD xcbt002 name="input.c.xcbt002"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON sfaadocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno name="construct.c.sfaadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfaa003 <> '3' AND (sfaastus = 'F' OR sfaastus = 'M' ) "
            CALL q_sfcadocno()                           #呼叫開窗
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
            CALL axcp163_get_buffer(l_dialog)
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
         CALL axcp163_init()
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
                 CALL axcp163_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp163_transfer_argv(ls_js)
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
 
{<section id="axcp163.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp163_transfer_argv(ls_js)
 
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
 
{<section id="axcp163.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp163_process(ls_js)
 
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
   CALL cl_err_showmsg_init()
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET g_sql = " SELECT COUNT(DISTINCT sfcadocno) FROM sfca_t,sfaa_t,sfcb_t ",
                  "   LEFT JOIN sfcc_t ON sfcbent = sfccent AND sfcbdocno = sfccdocno AND sfccsite = sfcbsite AND sfcc001 = sfcb001 AND sfcc002 = sfcb002 ",
                  "   WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcasite = sfaasite AND sfaasite = '",g_site,"' ",
                  "     AND sfcaent = sfcbent AND sfcadocno = sfcbdocno AND sfcasite = sfcbsite AND sfca001 = sfcb001",
                  "     AND sfaa003 <> '3' AND sfca001 = 0 AND sfaastus IN ('F','M') ",
                  "     AND sfcbent = ",g_enterprise,
                  "     AND sfaadocdt <= '",g_edate,"' ",
                  "     AND (sfaa048 IS NULL OR sfaa048 >= '",g_bdate,"' ) "
                  
      IF NOT cl_null(g_master.wc) THEN
         LET g_sql = g_sql , " AND ", g_master.wc
      END IF
      PREPARE axcp163_count_pb FROM g_sql
      EXECUTE axcp163_count_pb INTO li_count
      CALL cl_progress_bar_no_window(li_count) 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp163_process_cs CURSOR FROM ls_sql
#  FOREACH axcp163_process_cs INTO
   #add-point:process段process name="process.process"
   CALL axcp163_date_chk()
   IF NOT cl_null(g_errno) THEN
      LET g_errparam.extend = g_master.xcbt001," / ",g_master.xcbt002
      LET g_errparam.code   = g_errno
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF      
   LET g_flag = FALSE   #170217-00025#7 add
   LET g_sys_6007 = cl_get_para(g_enterprise,g_master.xcbtcomp,'S-FIN-6007')  #系统参数[S-FINC6001]:當站報廢轉出方式  #170418-00026#1
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axcp163_gen_xcbt()
      IF g_success THEN
         CALL s_transaction_end('Y','1')
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      CALL cl_err_collect_show()
      #170217-00025#7 mod-S
      IF g_flag = FALSE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN  
      END IF   
      #170217-00025#7 mod-E
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL axcp163_gen_xcbt()
      IF g_success THEN
         CALL s_transaction_end('Y','1')
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp163_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp163.get_buffer" >}
PRIVATE FUNCTION axcp163_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcbtcomp = p_dialog.getFieldBuffer('xcbtcomp')
   LET g_master.xcbt001 = p_dialog.getFieldBuffer('xcbt001')
   LET g_master.xcbt002 = p_dialog.getFieldBuffer('xcbt002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp163.msgcentre_notify" >}
PRIVATE FUNCTION axcp163_msgcentre_notify()
 
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
 
{<section id="axcp163.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#写入xcbt_t表中
PRIVATE FUNCTION axcp163_gen_xcbt()
DEFINE l_sfcb003    LIKE sfcb_t.sfcb003
DEFINE l_sfcb004    LIKE sfcb_t.sfcb004
DEFINE l_sfcb006    LIKE sfcb_t.sfcb006
DEFINE l_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE l_sfcb_d      DYNAMIC ARRAY OF RECORD
           sfcb003  LIKE sfcb_t.sfcb003,
           sfcb004  LIKE sfcb_t.sfcb004,
           sfcb006  LIKE sfcb_t.sfcb006,
           sfcb016  LIKE sfcb_t.sfcb016  #161121-00018#13 add sfcb016
                END RECORD
DEFINE l_ac         LIKE type_t.num10
DEFINE l_i          LIKE type_t.num10
DEFINE l_sfaa061    LIKE sfaa_t.sfaa061
DEFINE l_n          LIKE type_t.num10  #161121-00018#13
DEFINE l_sfcc003    LIKE sfcc_t.sfcc003 #170407-00041#1
DEFINE l_sfcc004    LIKE sfcc_t.sfcc004 #170407-00041#1
DEFINE l_sfcb006_1  LIKE sfcb_t.sfcb006
DEFINE l_cnt        LIKE type_t.num10   #170407-00041#1

    LET g_sql = " SELECT DISTINCT sfcbdocno,sfaa061 FROM sfca_t,sfaa_t,sfcb_t ",
                "   LEFT JOIN sfcc_t ON sfcbent = sfccent AND sfcbdocno = sfccdocno AND sfccsite = sfcbsite AND sfcc001 = sfcb001 AND sfcc002 = sfcb002 ",
                "   WHERE sfcaent = sfaaent AND sfcadocno = sfaadocno AND sfcasite = sfaasite AND sfaasite = '",g_site,"' ",
                "     AND sfcaent = sfcbent AND sfcadocno = sfcbdocno AND sfcasite = sfcbsite AND sfca001 = sfcb001",
                "     AND sfaa003 <> '3' AND sfca001 = 0 AND sfaastus IN ('F','M','C') ",  #161121-00018#13 增加'C'状态
                "     AND sfcbent = ",g_enterprise,
                "     AND sfaadocdt <= '",g_edate,"' ",
                "     AND (sfaa048 IS NULL OR sfaa048 >= '",g_bdate,"' ) "
                
    IF NOT cl_null(g_master.wc) THEN
       LET g_sql = g_sql , " AND ", g_master.wc
    END IF
    LET g_sql = g_sql , " ORDER BY sfcbdocno "  #161121-00018#13
    
    PREPARE axcp163_sfcadocno_pb FROM g_sql
    DECLARE axcp163_sfcadocno_cs CURSOR FOR axcp163_sfcadocno_pb
    
    #找出上站是INIT站的制程资料
    LET g_sql = " SELECT DISTINCT sfcb003,sfcb004,sfcb006,sfcb016 FROM sfcb_t,sfcc_t ",  #161121-00018#13 add sfcb016
                "   WHERE sfcbent = sfccent AND sfcbdocno = sfccdocno AND sfccsite = sfcbsite AND sfcc001 = sfcb001 AND sfcc002 = sfcb002 ",
                "     AND sfcbent = ",g_enterprise," AND sfcbdocno = ? ",
                #"     AND sfcc003 = 'INIT' AND sfcc004 = '0' " #170407-00041#1 mark
                "     AND (sfcc003 = ? OR sfcc003 = ? ) ",      #170407-00041#1 add
                "     AND (sfcc004 = ? OR sfcc004 = '0' ) "     #170407-00041#1 add              
    PREPARE axcp163_init_pb FROM g_sql
    DECLARE axcp163_init_cs CURSOR FOR axcp163_init_pb

    CALL axcp163_create_tmp_table()  #170407-00041#1 add
    #170407-00041#1---s
    LET g_sql = " SELECT DISTINCT sfcb003,sfcb004,sfcb006 FROM sfcb_tmp  WHERE sfcbdocno = ? "
    PREPARE axcp163_init_pb2 FROM g_sql
    DECLARE axcp163_init_cs2 CURSOR FOR axcp163_init_pb2
    #170407-00041#1---e
    
    CALL s_transaction_begin()
    
    LET g_success = TRUE
    
    FOREACH axcp163_sfcadocno_cs INTO l_sfcbdocno,l_sfaa061
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          LET g_success = FALSE
          EXIT FOREACH
       END IF
       
       ##畫面顯示處理進度 
       IF g_bgjob <> "Y" THEN
          CALL cl_progress_no_window_ing(l_sfcbdocno)
       END IF
       
       LET g_n = 0
       LET g_n_t = 0
       
       DELETE FROM xcbt_t WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp 
                            AND xcbt001 = g_master.xcbt001 AND xcbt002 = g_master.xcbt002
                            AND xcbt003 = l_sfcbdocno
       
       IF l_sfaa061 = 'N' THEN  #非工艺工单
          #寫入一筆作業是空格，跟下站是END
          #再寫入一筆作業是END，下站是STORAGE
          #CALL axcp163_ins_xcbt_2(l_sfcbdocno) #170411-00037#1 mark
          CALL axcp163_ins_xcbt_end(l_sfcbdocno)  #170411-00037#1 add
       ELSE
       
          LET l_sfcc003 = 'INIT'  #170407-00041#1 add    
          LET l_sfcc004 = '0'     #170407-00041#1 add    
          LET l_sfcb006_1 = 'INIT'  #170407-00041#1 add    
    
          DELETE FROM sfcb_tmp WHERE sfcbdocno =  l_sfcbdocno
          
          WHILE TRUE   #170407-00041#1 add
             LET l_ac = 1
             FOREACH axcp163_init_cs USING l_sfcbdocno,l_sfcc003,l_sfcb006_1,l_sfcc004 #170407-00041#1 add l_sfcc003,l_sfcc004
                   INTO l_sfcb_d[l_ac].sfcb003,l_sfcb_d[l_ac].sfcb004,l_sfcb_d[l_ac].sfcb006,l_sfcb_d[l_ac].sfcb016 #161121-00018#13 add sfcb016
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
                   LET g_errparam.code   = SQLCA.sqlcode 
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   LET g_success = FALSE
                   EXIT FOREACH
                END IF 
                LET l_ac = l_ac + 1
             END FOREACH
             CALL l_sfcb_d.deleteElement(l_ac)
             
             #170407-00041#1---modify--s
             #若当前初始站为非报工资料，则一直找到下一个报工的制程资料
             #A-B-C,A、B不报工，则一直找到报工站C
             #FOR l_i = 1 TO l_sfcb_d.getLength() 
             #   IF NOT cl_null(l_sfcb_d[l_i].sfcb003) AND NOT cl_null(l_sfcb_d[l_i].sfcb004)  THEN 
             #      CALL axcp163_ins_xcbt(l_sfcbdocno,l_sfcb_d[l_i].sfcb003,l_sfcb_d[l_i].sfcb004,l_sfcb_d[l_i].sfcb006) 
             #   END IF
             #   LET g_n_t = g_n_t + 1
             #   LET g_n = g_n_t
             #END FOR
             
             FOR l_i = 1 TO l_sfcb_d.getLength() 
                IF l_sfcb_d[l_i].sfcb016 = 'Y' THEN
                   SELECT COUNT(1) INTO l_n FROM sfcb_tmp WHERE sfcbdocno = l_sfcbdocno AND sfcb003 = l_sfcb_d[l_i].sfcb003 AND sfcb004 = l_sfcb_d[l_i].sfcb004
                   IF l_n = 0 OR cl_null(l_n) THEN
                      INSERT INTO sfcb_tmp (sfcbdocno,sfcb003,sfcb004,sfcb006) 
                         VALUES (l_sfcbdocno,l_sfcb_d[l_i].sfcb003,l_sfcb_d[l_i].sfcb004,l_sfcb_d[l_i].sfcb006)
                   END IF
                ELSE
                   #若当前站不报工，则继续找下一站
                   LET l_sfcc003 = l_sfcb_d[l_i].sfcb003
                   LET l_sfcc004 = l_sfcb_d[l_i].sfcb004
                   LET l_sfcb006_1 = l_sfcb_d[l_i].sfcb006
                   CONTINUE WHILE
                END IF
             END FOR
             EXIT WHILE
          END WHILE
          
          #如果整单都没有报工的话，就写入END 0  STORAGE 0 这一笔资料
          SELECT COUNT(1) INTO l_n FROM sfcb_tmp WHERE sfcbdocno = l_sfcbdocno 
          IF l_n = 0 OR cl_null(l_n) THEN
             CALL axcp163_ins_xcbt_end(l_sfcbdocno)
          ELSE
             FOREACH axcp163_init_cs2 USING l_sfcbdocno INTO l_sfcb003,l_sfcb004,l_sfcb006
                IF NOT cl_null(l_sfcb003) AND NOT cl_null(l_sfcb004)  THEN 
                   CALL axcp163_ins_xcbt(l_sfcbdocno,l_sfcb003,l_sfcb004,l_sfcb006) 
                END IF
                LET g_n_t = g_n_t + 1
                LET g_n = g_n_t
             END FOREACH
          END IF
          #170407-00041#1---modify--e
       END IF
    END FOREACH
    
    CALL axcp163_drop_tmp_table()  #170407-00041#1 add
    
END FUNCTION

PRIVATE FUNCTION axcp163_ins_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,p_sfcb006)
DEFINE l_xcbt       RECORD LIKE xcbt_t.*
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE p_sfcc003    LIKE sfcc_t.sfcc003
DEFINE p_sfcc004    LIKE sfcc_t.sfcc004
DEFINE p_sfcb006    LIKE sfcb_t.sfcb006
DEFINE l_sfcb003    LIKE sfcb_t.sfcb003
DEFINE l_sfcb004    LIKE sfcb_t.sfcb004
DEFINE l_sfcb006    LIKE sfcb_t.sfcb006
DEFINE l_sfcb007    LIKE sfcb_t.sfcb007
DEFINE l_sfcb008    LIKE sfcb_t.sfcb008
DEFINE l_sfcb009    LIKE sfcb_t.sfcb009
DEFINE l_sfcb010    LIKE sfcb_t.sfcb010
DEFINE l_n          LIKE type_t.num5
DEFINE l_sfdb007    LIKE sfdb_t.sfdb007
DEFINE l_sffb017    LIKE sffb_t.sffb017
DEFINE l_sffb018    LIKE sffb_t.sffb018
DEFINE l_sffb019    LIKE sffb_t.sffb019
DEFINE l_sffb020    LIKE sffb_t.sffb020
DEFINE l_xcbt008    LIKE xcbt_t.xcbt008
DEFINE l_sfcb      DYNAMIC ARRAY OF RECORD
           sfcb003  LIKE sfcb_t.sfcb003,
           sfcb004  LIKE sfcb_t.sfcb004,
           sfcb006  LIKE sfcb_t.sfcb006,
           sfcb007  LIKE sfcb_t.sfcb007,
           sfcb008  LIKE sfcb_t.sfcb008,
           sfcb009  LIKE sfcb_t.sfcb009,
           sfcb010  LIKE sfcb_t.sfcb010,
           sfcb021  LIKE sfcb_t.sfcb021,
           sfcb022  LIKE sfcb_t.sfcb022,
           sfcb016  LIKE sfcb_t.sfcb016  #161121-00018#13 add sfcb016
                END RECORD
DEFINE l_ac         LIKE type_t.num10
DEFINE l_i          LIKE type_t.num10
DEFINE l_sfcb021    LIKE sfcb_t.sfcb021
DEFINE l_sfcb022    LIKE sfcb_t.sfcb022
DEFINE l_sfaa010    LIKE sfaa_t.sfaa010
DEFINE l_sfaa013    LIKE sfaa_t.sfaa013
DEFINE l_imaa006    LIKE imaa_t.imaa006
DEFINE l_success    LIKE type_t.num5
DEFINE l_sfaa057    LIKE sfaa_t.sfaa057
DEFINE l_sfcb016    LIKE sfcb_t.sfcb016  #161121-00018#13
DEFINE l_sfcc003_t  LIKE sfcc_t.sfcc003  #161121-00018#13
DEFINE l_sfcc004_t  LIKE sfcc_t.sfcc004  #161121-00018#13
DEFINE l_sfcb016_t  LIKE sfcc_t.sfcc004  #161121-00018#13

    LET g_sql = " SELECT DISTINCT sfcb003,sfcb004,sfcb006,sfcb007,sfcb008,sfcb009,sfcb010,sfcb021,sfcb022,sfcb016 FROM sfcb_t,sfcc_t ",  #161121-00018#13 add sfcb016
                "   WHERE sfcbent = sfccent AND sfcbdocno = sfccdocno AND sfccsite = sfcbsite AND sfcc001 = sfcb001 AND sfcc002 = sfcb002 ",
                "     AND sfcb001 = 0  ",  #161121-00018#13
                "     AND sfcbent = ? AND sfcbdocno = ? ",
                "     AND (sfcc003 = ? OR sfcc003 = ? ) ",
                "     AND (sfcc004 = ? OR sfcc004 = '0' ) "

    PREPARE axcp163_sfcc_pb FROM g_sql
    DECLARE axcp163_sfcc_cs CURSOR FOR axcp163_sfcc_pb
    
    #161121-00018#13--s
    LET l_sfcc003_t = p_sfcc003
    LET l_sfcc004_t = p_sfcc004
    SELECT sfcb016 INTO l_sfcb016_t FROM sfcb_t
          WHERE sfcbent = g_enterprise AND sfcbdocno = p_sfcbdocno AND sfcb003 = p_sfcc003 AND sfcb004 = p_sfcc004
    #161121-00018#13--e
    
    WHILE TRUE
       
       LET l_ac = 1
       #161121-00018#13--S
       SELECT sfcb007,sfcb009 INTO l_sfcb007,l_sfcb009 FROM sfcb_t
          WHERE sfcbent = g_enterprise AND sfcbdocno = p_sfcbdocno AND sfcb003 = p_sfcc003 AND sfcb004 = p_sfcc004
       #161121-00018#13---E
       FOREACH axcp163_sfcc_cs USING g_enterprise,p_sfcbdocno,p_sfcc003,p_sfcb006,p_sfcc004
          INTO l_sfcb[l_ac].sfcb003,l_sfcb[l_ac].sfcb004,l_sfcb[l_ac].sfcb006,l_sfcb[l_ac].sfcb007,l_sfcb[l_ac].sfcb008,l_sfcb[l_ac].sfcb009,l_sfcb[l_ac].sfcb010,
               l_sfcb[l_ac].sfcb021,l_sfcb[l_ac].sfcb022,l_sfcb[l_ac].sfcb016  #161121-00018#13 add sfcb016
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "axcp163_sfcc_cs:",SQLERRMESSAGE
             LET g_errparam.code   = SQLCA.sqlcode
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             EXIT FOREACH
          END IF
          #如果当前站的上站来源不是MULT,且已存在xcbt_t中，代表上站作业只有一笔，因为已经循环过，不再写入
          #若是MULT,则需要重新计算当前站的计算顺序
          
          IF l_sfcb016_t = 'Y' THEN  #161121-00018#13 ADD   
             LET l_n = 0
             SELECT COUNT(1) INTO l_n FROM xcbt_t 
                WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                  AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
                  AND xcbt006 = l_sfcb[l_ac].sfcb003 AND xcbt007 = l_sfcb[l_ac].sfcb004
             #161121-00018#13--mark--s
             #SELECT sfcb007 INTO l_sfcb007  FROM sfcb_t
             #   WHERE sfcbent = g_enterprise AND sfcbdocno = p_sfcbdocno AND sfcb003 = p_sfcc003 AND sfcb004 = p_sfcc004
             #161121-00018#13--mark--e
             IF l_n > 0 THEN
                IF l_sfcb007 = 'MULT' THEN
                   LET g_n = g_n + 1
                   CALL axcp163_upd_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,l_sfcb[l_ac].sfcb003,l_sfcb[l_ac].sfcb004)
                   LET g_n = g_n - 1
                END IF
                CONTINUE FOREACH
             END IF
          END IF  #161121-00018#13 ADD   
          LET l_ac = l_ac + 1
       END FOREACH

       CALL l_sfcb.deleteElement(l_ac)
       
       #没有抓到符合条件的资料，再判断当前站的下一站是否是END
       #既是起始站，又是结束站，如果是，把当前站的资料写入
       IF l_sfcb.getLength() = 0 THEN
          #161121-00018#13--mark--s
          #SELECT sfcb007,sfcb009 INTO l_sfcb007,l_sfcb009 FROM sfcb_t 
          #   WHERE sfcbent = g_enterprise AND sfcbdocno = p_sfcbdocno AND sfcb003 = p_sfcc003 AND sfcb004 = p_sfcc004
          #161121-00018#13--mark--e
          #IF (l_sfcb007 = 'INIT' AND l_sfcb009 = 'END') THEN  #170407-00041#1 mark
          IF l_sfcb009 = 'END' THEN #170407-00041#1 add
             CALL axcp163_default_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,l_sfcb009,'0') RETURNING l_xcbt.*
             LET l_xcbt.xcbt008 = 1
             INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                              xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                              xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                              xcbt011,xcbt012,xcbt013)
             VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                     l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                     l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                     l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
             #170217-00025#7 add-S
             IF SQLCA.sqlerrd[3] > 0 THEN
                LET g_flag = TRUE
             END IF
             #170217-00025#7 add-E
             #每張工單固定寫入一筆最後的作業站為END的資料，轉出為STORAGE，
             #轉入數量=製程中最後一站的轉出數量
             #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
             #END站写入资料
             LET l_xcbt.xcbtent = g_enterprise
             LET l_xcbt.xcbtsite = g_site
             LET l_xcbt.xcbtcomp = g_master.xcbtcomp
             LET l_xcbt.xcbt001 = g_master.xcbt001
             LET l_xcbt.xcbt002 = g_master.xcbt002
             LET l_xcbt.xcbt003 = p_sfcbdocno
             LET l_xcbt.xcbt004 = l_sfcb009
             LET l_xcbt.xcbt005 = '0'
             LET l_xcbt.xcbt006 = 'STORAGE'
             LET l_xcbt.xcbt007 = '0'
             LET l_xcbt.xcbt009 = l_xcbt.xcbt010
             #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
             SELECT sfaa010,sfaa013,sfaa057 INTO l_sfaa010,l_sfaa013,l_sfaa057 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
             SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
             IF l_sfaa057 = '1' THEN #厂内
                SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
                    WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
                      AND inaj015 = 'asft340'   #异动单据性质
                      AND inaj035 = 'asft340'   #异动作业编号
                      AND inaj022 <= g_edate AND inaj022 >= g_bdate
             ELSE
                #委外
                SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
                    WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
                      AND (inaj015 = 'apmt571' OR inaj015 = 'apmt531')    #异动单据性质
                      AND (inaj035 = 'apmt571' OR inaj035 = 'apmt531')    #异动作业编号
                      AND inaj022 <= g_edate AND inaj022 >= g_bdate
             END IF
             
             IF cl_null(l_xcbt.xcbt010) THEN
                LET l_xcbt.xcbt010 = 0
             END IF
             IF NOT cl_null(l_imaa006) THEN  #161121-00018#13 ADD   
                CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
             END IF   #161121-00018#13 ADD   
             LET l_xcbt.xcbt011 = 0
             LET l_xcbt.xcbt012 = 0
             LET l_xcbt.xcbt013 = 0
             
             LET l_xcbt.xcbt008 = 2
             INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                                 xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                                 xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                                 xcbt011,xcbt012,xcbt013)
                VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                        l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                        l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                        l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
                        
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ins xcbt_t"
                CALL cl_err()          
                LET g_success=FALSE
             END IF       
             #170217-00025#7 add-S
             IF SQLCA.sqlerrd[3] > 0 THEN
                LET g_flag = TRUE
             END IF
             #170217-00025#7 add-E     
          END IF
       END IF

       FOR l_i = 1 TO l_sfcb.getLength()
          IF cl_null(l_sfcb[l_i].sfcb003) OR cl_null(l_sfcb[l_i].sfcb004) THEN
             EXIT FOR
          END IF
          #161121-00018#13--s
          IF l_sfcb016_t = 'N' AND l_sfcb[l_i].sfcb009 <> 'END' THEN
             CONTINUE FOR
          END IF
          IF l_sfcb[l_i].sfcb016 = 'N' AND l_sfcb[l_i].sfcb009 <> 'END' THEN #找到指导需要报工的下一站制程作为转出
             LET p_sfcc003 = l_sfcb[l_i].sfcb003
             LET p_sfcb006 = l_sfcb[l_i].sfcb006
             LET p_sfcc004 = l_sfcb[l_i].sfcb004
             CONTINUE WHILE
          END IF
          LET p_sfcc003 = l_sfcc003_t
          LET p_sfcc004 = l_sfcc004_t 
          #161121-00018#13--e
          
          LET l_sfcb003 = l_sfcb[l_i].sfcb003
          LET l_sfcb004 = l_sfcb[l_i].sfcb004
          LET l_sfcb006 = l_sfcb[l_i].sfcb006
          LET l_sfcb009 = l_sfcb[l_i].sfcb009
          LET l_sfcb010 = l_sfcb[l_i].sfcb010
          LET l_sfcb021 = l_sfcb[l_i].sfcb021
          LET l_sfcb022 = l_sfcb[l_i].sfcb022
          
          #161121-00018#13---s
          #如果当前站为报工，而转出站不为报工，且转出站的下站是END
          IF l_sfcb016_t = 'Y' AND l_sfcb[l_i].sfcb016 = 'N' AND l_sfcb[l_i].sfcb009 = 'END' THEN
             LET l_sfcb003 = 'END'
             LET l_sfcb004 = '0'
             LET l_sfcb006 = l_sfcb[l_i].sfcb006
             LET l_sfcb009 = l_sfcb[l_i].sfcb009
             LET l_sfcb010 = l_sfcb[l_i].sfcb010
             LET l_sfcb021 = l_sfcb[l_i].sfcb021
             LET l_sfcb022 = l_sfcb[l_i].sfcb022
          END IF
          #161121-00018#13--e
          
          IF l_sfcb016_t = 'Y' THEN   #161121-00018#13
             CALL axcp163_default_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,l_sfcb003,l_sfcb004) RETURNING l_xcbt.*
             
             LET g_n = g_n + 1
             
             SELECT MAX(xcbt008) INTO l_xcbt008 FROM xcbt_t 
                   WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                     AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
                     AND xcbt006 = l_sfcb003 AND xcbt007 = l_sfcb004
                     
             IF l_xcbt008 > 0 THEN
                #若当前的计算顺序大于数据库中已存在的，则更新计算顺序栏位，同时后面关联的计算顺序都应同步更新
                IF l_xcbt008 < g_n THEN
                   UPDATE xcbt_t SET xcbt008 = g_n,
                                   xcbt009 = xcbt009 + l_xcbt.xcbt009,
                                   xcbt010 = xcbt010 + l_xcbt.xcbt010,
                                   xcbt011 = xcbt011 + l_xcbt.xcbt011,
                                   xcbt012 = xcbt012 + l_xcbt.xcbt012,
                                   xcbt013 = xcbt013 + l_xcbt.xcbt013
                      WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                        AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
                        AND xcbt006 = l_sfcb003 AND xcbt007 = l_sfcb004
             
                   UPDATE xcbt_t SET xcbt008 = xcbt008 + ( g_n - l_xcbt008)
                        WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                          AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt008 > l_xcbt008
                ELSE
                   UPDATE xcbt_t SET xcbt009 = xcbt009 + l_xcbt.xcbt009,
                                     xcbt010 = xcbt010 + l_xcbt.xcbt010,
                                     xcbt011 = xcbt011 + l_xcbt.xcbt011,
                                     xcbt012 = xcbt012 + l_xcbt.xcbt012,
                                     xcbt013 = xcbt013 + l_xcbt.xcbt013
                      WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                        AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
                        AND xcbt006 = l_sfcb003 AND xcbt007 = l_sfcb004
                       
                END IF  
                CONTINUE FOR              
             ELSE
                SELECT COUNT(1) INTO l_n FROM xcbt_t 
                   WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                     AND xcbt002 = g_master.xcbt002 AND xcbt003 = l_xcbt.xcbt003 AND xcbt004 = l_xcbt.xcbt004 AND xcbt005 = l_xcbt.xcbt005
                     AND xcbt006 = l_xcbt.xcbt006 AND xcbt007 = l_xcbt.xcbt007
                IF cl_null(l_n) OR l_n = 0 THEN  
                   IF cl_null(l_xcbt008) OR l_xcbt008 = 0 THEN
                      #找出当前站的上站资料有多笔下站时，找已经存在xcbt中的最大计算顺序
                      LET l_xcbt008 = 0
                      SELECT MAX(xcbt008) INTO l_xcbt008 FROM xcbt_t 
                         WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                           AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno 
                           AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
                      IF cl_null(l_xcbt008) OR l_xcbt008 = 0 THEN
                         LET l_xcbt.xcbt008 = g_n
                      ELSE
                        LET l_xcbt.xcbt008 = l_xcbt008
                      END IF
                      LET g_n = l_xcbt.xcbt008
                      
                      INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                                          xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                                          xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                                          xcbt011,xcbt012,xcbt013)
                         VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                                 l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                                 l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                                 l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
                   END IF
                END IF
             END IF
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ins xcbt_t"
                CALL cl_err()          
                LET g_success=FALSE
             END IF
          END IF #161121-00018#13
          #判断是否为最后一站
          IF l_sfcb009 = 'END' THEN
             IF l_sfcb[l_i].sfcb016 = 'Y' THEN  #161121-00018#13
                #良品數量 #報發數量  #當站下線數量  #回收數量
                SELECT SUM(sffb017),SUM(sffb018),SUM(sffb019),SUM(sffb020) INTO l_sffb017,l_sffb018,l_sffb019,l_sffb020 FROM sffb_t,sfca_t 
                   WHERE sffbent = sfcaent AND sffb005 = sfcadocno AND sffb006 = sfca001 AND sfca005 <> '2'
                     AND sffbent = g_enterprise AND sffb001 = '3' AND sffbstus = 'Y'
                     AND sffb005 = p_sfcbdocno AND sffb006 = 0 AND sffb007 = l_sfcb003 AND sffb008 = l_sfcb004
                     AND sffb012 <= g_edate AND sffb012 >= g_bdate
                IF cl_null(l_sfdb007) THEN
                   LET l_sfdb007 = 0
                END IF
                IF cl_null(l_sffb017) THEN
                   LET l_sffb017 = 0
                END IF
                IF cl_null(l_sffb018) THEN
                   LET l_sffb018 = 0
                END IF
                IF cl_null(l_sffb019) THEN
                   LET l_sffb019 = 0
                END IF
                IF cl_null(l_sffb020) THEN
                   LET l_sffb020 = 0
                END IF
                
                #轉出分子
                IF cl_null(l_sfcb021) OR l_sfcb021 = 0 THEN
                   LET l_sfcb021 = 1
                END IF
                #轉出分母
                IF cl_null(l_sfcb022) OR l_sfcb022 = 0 THEN
                   LET l_sfcb022 = 1
                END IF
                
                LET l_xcbt.xcbtent = g_enterprise
                LET l_xcbt.xcbtsite = g_site
                LET l_xcbt.xcbtcomp = g_master.xcbtcomp
                LET l_xcbt.xcbt001 = g_master.xcbt001
                LET l_xcbt.xcbt002 = g_master.xcbt002
                LET l_xcbt.xcbt003 = p_sfcbdocno
                LET l_xcbt.xcbt004 = l_sfcb003
                LET l_xcbt.xcbt005 = l_sfcb004
                LET l_xcbt.xcbt006 = l_sfcb009
                LET l_xcbt.xcbt007 = l_sfcb010
                LET l_xcbt.xcbt009 = l_xcbt.xcbt010
                #計算方式=報工單上的數量*轉出分母/轉出分子,轉出來是工單單位
                #如果工單單位跟基礎單位不一樣，再转基礎單位對應的數量
                LET l_xcbt.xcbt010 = l_sffb017*l_sfcb022/l_sfcb021
                #170418-00026#1---add---s
                IF g_sys_6007 = '1' THEN
                   LET l_xcbt.xcbt011 = 0
                   LET l_xcbt.xcbt012 = 0                
                ELSE
                #170418-00026#1---add---e
                   LET l_xcbt.xcbt011 = l_sffb018
                   LET l_xcbt.xcbt012 = l_sffb019
                END IF   #170418-00026#1
                LET l_xcbt.xcbt013 = l_sffb020
                
                SELECT sfaa010,sfaa013 INTO l_sfaa010,l_sfaa013 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
                SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
                IF NOT cl_null(l_sfaa013) AND NOT cl_null(l_imaa006) THEN
                   IF l_sfaa013 <> l_imaa006 THEN
                      CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
                      CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt011) RETURNING l_success,l_xcbt.xcbt011
                      CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt012) RETURNING l_success,l_xcbt.xcbt012
                      CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt013) RETURNING l_success,l_xcbt.xcbt013
                   ELSE
                      CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
                      CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt011) RETURNING l_success,l_xcbt.xcbt011
                      CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt012) RETURNING l_success,l_xcbt.xcbt012
                      CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt013) RETURNING l_success,l_xcbt.xcbt013
                   END IF
                END IF
                
                SELECT COUNT(1) INTO l_n FROM xcbt_t 
                   WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                     AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = l_sfcb003 AND xcbt005 = l_sfcb004
                     AND xcbt006 = l_sfcb009 AND xcbt007 = l_sfcb010
                IF cl_null(l_n) OR l_n = 0 THEN  
                   LET g_n = g_n + 1
                   LET l_xcbt.xcbt008 = g_n
                   INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                                       xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                                       xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                                       xcbt011,xcbt012,xcbt013)
                      VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                              l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                              l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                              l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
                              
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = "ins xcbt_t"
                      CALL cl_err()          
                      LET g_success=FALSE
                   END IF    
                ELSE
                   LET g_n = g_n + 1
                   LET l_xcbt.xcbt008 = g_n
                   UPDATE xcbt_t SET xcbt008 = l_xcbt.xcbt008,
                                     xcbt009 = xcbt009 + l_xcbt.xcbt009,
                                     xcbt010 = xcbt010 + l_xcbt.xcbt010,
                                     xcbt011 = xcbt011 + l_xcbt.xcbt011,
                                     xcbt012 = xcbt012 + l_xcbt.xcbt012,
                                     xcbt013 = xcbt013 + l_xcbt.xcbt013
                     WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                       AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = l_sfcb003 AND xcbt005 = l_sfcb004
                       AND xcbt006 = l_sfcb009 AND xcbt007 = l_sfcb010              
                END IF
             END IF  #161121-00018#13
             #每張工單固定寫入一筆最後的作業站為END的資料，轉出為STORAGE，
             #轉入數量=製程中最後一站的轉出數量
             #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
             #END站写入资料
             LET l_xcbt.xcbtent = g_enterprise
             LET l_xcbt.xcbtsite = g_site
             LET l_xcbt.xcbtcomp = g_master.xcbtcomp
             LET l_xcbt.xcbt001 = g_master.xcbt001
             LET l_xcbt.xcbt002 = g_master.xcbt002
             LET l_xcbt.xcbt003 = p_sfcbdocno
             LET l_xcbt.xcbt004 = l_sfcb009
             LET l_xcbt.xcbt005 = '0'
             LET l_xcbt.xcbt006 = 'STORAGE'
             LET l_xcbt.xcbt007 = '0'
             LET l_xcbt.xcbt009 = l_xcbt.xcbt010
             #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
             SELECT sfaa057 INTO l_sfaa057 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
             IF l_sfaa057 = '1' THEN #厂内
                SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
                    WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
                      AND inaj015 = 'asft340'   #异动单据性质
                      AND inaj035 = 'asft340'   #异动作业编号
                      AND inaj022 <= g_edate AND inaj022 >= g_bdate
             ELSE
                #委外
                SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
                    WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
                      AND (inaj015 = 'apmt571' OR inaj015 = 'apmt531')    #异动单据性质
                      AND (inaj035 = 'apmt571' OR inaj035 = 'apmt531')    #异动作业编号
                      AND inaj022 <= g_edate AND inaj022 >= g_bdate
             END IF
             
             IF cl_null(l_xcbt.xcbt010) THEN
                LET l_xcbt.xcbt010 = 0
             END IF
             IF NOT cl_null(l_imaa006) THEN  #161121-00018#13 ADD   
                CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
             END IF   #161121-00018#13 ADD   
             LET l_xcbt.xcbt011 = 0
             LET l_xcbt.xcbt012 = 0
             LET l_xcbt.xcbt013 = 0
             
             SELECT COUNT(1) INTO l_n FROM xcbt_t 
                WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                  AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = l_xcbt.xcbt004 AND xcbt005 = l_xcbt.xcbt005
                  AND xcbt006 = l_xcbt.xcbt006 AND xcbt007 = l_xcbt.xcbt007
             IF cl_null(l_n) OR l_n = 0 THEN  
                LET g_n = g_n + 1
                LET l_xcbt.xcbt008 = g_n
                INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                                    xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                                    xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                                    xcbt011,xcbt012,xcbt013)
                   VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                           l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                           l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                           l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
                           
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "ins xcbt_t"
                   CALL cl_err()          
                   LET g_success=FALSE
                END IF    
                #170217-00025#7 add-S
                IF SQLCA.sqlerrd[3] > 0 THEN
                   LET g_flag = TRUE
                END IF
                #170217-00025#7 add-E
             ELSE
                LET g_n = g_n + 1
                LET l_xcbt.xcbt008 = g_n
                UPDATE xcbt_t SET xcbt008 = l_xcbt.xcbt008,
                                  xcbt009 = xcbt009 + l_xcbt.xcbt009,
                                  xcbt010 = xcbt010 + l_xcbt.xcbt010,
                                  xcbt011 = xcbt011 + l_xcbt.xcbt011,
                                  xcbt012 = xcbt012 + l_xcbt.xcbt012,
                                  xcbt013 = xcbt013 + l_xcbt.xcbt013
                  WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                    AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = l_xcbt.xcbt004 AND xcbt005 = l_xcbt.xcbt005
                    AND xcbt006 = l_xcbt.xcbt006 AND xcbt007 = l_xcbt.xcbt007  
             END IF
          ELSE
             CALL axcp163_ins_xcbt(p_sfcbdocno,l_sfcb003,l_sfcb004,l_sfcb006) 
          END IF
       END FOR
       
       EXIT WHILE
    END WHILE
    
END FUNCTION

#预设xcbt数组的值
PRIVATE FUNCTION axcp163_default_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,p_sfcb003,p_sfcb004)
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE p_sfcc003    LIKE sfcc_t.sfcc003
DEFINE p_sfcc004    LIKE sfcc_t.sfcc004
DEFINE p_sfcb003    LIKE sfcb_t.sfcb003
DEFINE p_sfcb004    LIKE sfcb_t.sfcb004
DEFINE l_sfcb007    LIKE sfcb_t.sfcb007
DEFINE l_sfcb008    LIKE sfcb_t.sfcb008
DEFINE r_xcbt       RECORD LIKE xcbt_t.*
DEFINE l_sfdb007    LIKE sfdb_t.sfdb007
DEFINE l_sffb017    LIKE sffb_t.sffb017
DEFINE l_sffb018    LIKE sffb_t.sffb018
DEFINE l_sffb019    LIKE sffb_t.sffb019
DEFINE l_sffb020    LIKE sffb_t.sffb020
DEFINE l_sfcb021    LIKE sfcb_t.sfcb021
DEFINE l_sfcb022    LIKE sfcb_t.sfcb022
DEFINE l_sfaa010    LIKE sfaa_t.sfaa010
DEFINE l_sfaa013    LIKE sfaa_t.sfaa013
DEFINE l_imaa006    LIKE imaa_t.imaa006
DEFINE l_success    LIKE type_t.num5

    #起始站：
    #轉入數量=工單成套發料單的實際套數(sfdb007)，
    #條件為作業編號sfdb004、sfb005=此作業編號+作業序，
    #如果沒有則取作業編號相等的sfdb004
    #再沒有的取空sfdb004是空白的
    #
    #轉出數量：
    #良品數量=當月已確認報工檔sffb017 （各數計算取報工檔都只計算sffb010=3.報工，且需排除runcard類型=重工的sfca005<>'2')
    #報發數量=當月已確認報工檔sffb018
    #當站下線數量=sffb019
    #回收數量=sffb020
    #
    #非起始站的轉入數量,取上站的轉出數量最大數量者
     
    #判断当前站是否为起始站
    SELECT sfcb007,sfcb008,sfcb021,sfcb022 INTO l_sfcb007,l_sfcb008,l_sfcb021,l_sfcb022 FROM sfcb_t
       WHERE sfcbent = g_enterprise AND sfcbdocno = p_sfcbdocno AND sfcb003 = p_sfcc003 AND sfcb004 = p_sfcc004
    IF l_sfcb007 = 'INIT' THEN
       #轉入數量
       SELECT SUM(sfdb007) INTO l_sfdb007 FROM sfda_t,sfdb_t 
           WHERE sfdaent = sfdbent AND sfdadocno = sfdbdocno AND sfdbent = g_enterprise AND sfda002 = '11'  #成套發料 
             AND sfdastus = 'S' AND sfdb001 = p_sfcbdocno AND sfdb002 = 0 AND sfdb004 = p_sfcc003 AND sfdb005 = p_sfcc004
             AND sfda001 <= g_edate AND sfda001 >= g_bdate
       IF cl_null(l_sfdb007) OR l_sfdb007 = 0 THEN
          SELECT SUM(sfdb007) INTO l_sfdb007 FROM sfda_t,sfdb_t 
             WHERE sfdaent = sfdbent AND sfdadocno = sfdbdocno AND sfdbent = g_enterprise AND sfda002 = '11'  #成套發料 
               AND sfdastus = 'S' AND sfdb001 = p_sfcbdocno AND sfdb002 = 0 AND sfdb004 = p_sfcc003
               AND sfda001 <= g_edate AND sfda001 >= g_bdate
       END IF
       IF cl_null(l_sfdb007) OR l_sfdb007 = 0 THEN
          SELECT SUM(sfdb007) INTO l_sfdb007 FROM sfda_t,sfdb_t 
             WHERE sfdaent = sfdbent AND sfdadocno = sfdbdocno AND sfdbent = g_enterprise AND sfda002 = '11'  #成套發料 
               AND sfdastus = 'S' AND sfdb001 = p_sfcbdocno AND sfdb002 = 0 AND (sfdb004 = ' ' OR sfdb004 IS NULL)
               AND sfda001 <= g_edate AND sfda001 >= g_bdate
       END IF
    ELSE
       SELECT MAX(xcbt010) INTO l_sfdb007 FROM xcbt_t 
         WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
           AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt006 = p_sfcc003 AND xcbt007 = p_sfcc004
    END IF
    
    #良品數量 #報發數量  #當站下線數量  #回收數量
    SELECT SUM(sffb017),SUM(sffb018),SUM(sffb019),SUM(sffb020) INTO l_sffb017,l_sffb018,l_sffb019,l_sffb020 FROM sffb_t,sfca_t 
       WHERE sffbent = sfcaent AND sffb005 = sfcadocno AND sffb006 = sfca001 AND sfca005 <> '2'
         AND sffbent = g_enterprise AND sffb001 = '3' AND sffbstus = 'Y'
         AND sffb005 = p_sfcbdocno AND sffb006 = 0 AND sffb007 = p_sfcc003 AND sffb008 = p_sfcc004
         AND sffb012 <= g_edate AND sffb012 >= g_bdate
    IF cl_null(l_sfdb007) THEN
       LET l_sfdb007 = 0
    END IF
    IF cl_null(l_sffb017) THEN
       LET l_sffb017 = 0
    END IF
    IF cl_null(l_sffb018) THEN
       LET l_sffb018 = 0
    END IF
    IF cl_null(l_sffb019) THEN
       LET l_sffb019 = 0
    END IF
    IF cl_null(l_sffb020) THEN
       LET l_sffb020 = 0
    END IF
    
    #轉出分子
    IF cl_null(l_sfcb021) OR l_sfcb021 = 0 THEN
       LET l_sfcb021 = 1
    END IF
    #轉出分母
    IF cl_null(l_sfcb022) OR l_sfcb022 = 0 THEN
       LET l_sfcb022 = 1
    END IF
             
    LET r_xcbt.xcbtent = g_enterprise
    LET r_xcbt.xcbtsite = g_site
    LET r_xcbt.xcbtcomp = g_master.xcbtcomp
    LET r_xcbt.xcbt001 = g_master.xcbt001
    LET r_xcbt.xcbt002 = g_master.xcbt002
    LET r_xcbt.xcbt003 = p_sfcbdocno
    LET r_xcbt.xcbt004 = p_sfcc003
    LET r_xcbt.xcbt005 = p_sfcc004
    LET r_xcbt.xcbt006 = p_sfcb003
    LET r_xcbt.xcbt007 = p_sfcb004
        
    LET r_xcbt.xcbt009 = l_sfdb007
    #計算方式=報工單上的數量*轉出分母/轉出分子,轉出來是工單單位
    #如果工單單位跟基礎單位不一樣，再转基礎單位對應的數量
    LET r_xcbt.xcbt010 = l_sffb017*l_sfcb022/l_sfcb021
    #170418-00026#1---add---s
    IF g_sys_6007 = '1' THEN
       LET r_xcbt.xcbt011 = 0
       LET r_xcbt.xcbt012 = 0                
    ELSE
    #170418-00026#1---add---e
       LET r_xcbt.xcbt011 = l_sffb018
       LET r_xcbt.xcbt012 = l_sffb019
    END IF   ##170418-00026#1
    LET r_xcbt.xcbt013 = l_sffb020
    
    SELECT sfaa010,sfaa013 INTO l_sfaa010,l_sfaa013 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
    SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
    IF NOT cl_null(l_sfaa013) AND NOT cl_null(l_imaa006) THEN
       IF l_sfaa013 <> l_imaa006 THEN
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,r_xcbt.xcbt009) RETURNING l_success,r_xcbt.xcbt009
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,r_xcbt.xcbt010) RETURNING l_success,r_xcbt.xcbt010
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,r_xcbt.xcbt011) RETURNING l_success,r_xcbt.xcbt011
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,r_xcbt.xcbt012) RETURNING l_success,r_xcbt.xcbt012
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,r_xcbt.xcbt013) RETURNING l_success,r_xcbt.xcbt013
       ELSE
          CALL s_aooi250_take_decimals(l_imaa006,r_xcbt.xcbt009) RETURNING l_success,r_xcbt.xcbt009
          CALL s_aooi250_take_decimals(l_imaa006,r_xcbt.xcbt010) RETURNING l_success,r_xcbt.xcbt010
          CALL s_aooi250_take_decimals(l_imaa006,r_xcbt.xcbt011) RETURNING l_success,r_xcbt.xcbt011
          CALL s_aooi250_take_decimals(l_imaa006,r_xcbt.xcbt012) RETURNING l_success,r_xcbt.xcbt012
          CALL s_aooi250_take_decimals(l_imaa006,r_xcbt.xcbt013) RETURNING l_success,r_xcbt.xcbt013
       END IF
    END IF
    
    RETURN r_xcbt.*
    
END FUNCTION

#更新xcbt
PRIVATE FUNCTION axcp163_upd_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,p_sfcb003,p_sfcb004)
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE p_sfcc003    LIKE sfcc_t.sfcc003
DEFINE p_sfcc004    LIKE sfcc_t.sfcc004
DEFINE p_sfcb003    LIKE sfcb_t.sfcb003
DEFINE p_sfcb004    LIKE sfcb_t.sfcb004
DEFINE l_xcbt008    LIKE xcbt_t.xcbt008
DEFINE l_xcbt       RECORD LIKE xcbt_t.*
    SELECT MAX(xcbt008) INTO l_xcbt008 FROM xcbt_t 
          WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
            AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
            AND xcbt006 = p_sfcb003 AND xcbt007 = p_sfcb004
            
    IF l_xcbt008 > 0 THEN
       CALL axcp163_default_xcbt(p_sfcbdocno,p_sfcc003,p_sfcc004,p_sfcb003,p_sfcb004) RETURNING l_xcbt.*
       #若当前的计算顺序大于数据库中已存在的，则更新计算顺序栏位，同时后面关联的计算顺序都应同步更新
       IF l_xcbt008 < g_n THEN
          UPDATE xcbt_t SET xcbt008 = xcbt008 + ( g_n - l_xcbt008)
               WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
                 AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt008 > l_xcbt008
                 
          UPDATE xcbt_t SET xcbt008 = g_n,
                          xcbt009 = xcbt009 + l_xcbt.xcbt009,
                          xcbt010 = xcbt010 + l_xcbt.xcbt010,
                          xcbt011 = xcbt011 + l_xcbt.xcbt011,
                          xcbt012 = xcbt012 + l_xcbt.xcbt012,
                          xcbt013 = xcbt013 + l_xcbt.xcbt013
             WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
               AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
               AND xcbt006 = p_sfcb003 AND xcbt007 = p_sfcb004
    
          
       ELSE
          UPDATE xcbt_t SET xcbt009 = xcbt009 + l_xcbt.xcbt009,
                            xcbt010 = xcbt010 + l_xcbt.xcbt010,
                            xcbt011 = xcbt011 + l_xcbt.xcbt011,
                            xcbt012 = xcbt012 + l_xcbt.xcbt012,
                            xcbt013 = xcbt013 + l_xcbt.xcbt013
             WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
               AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = p_sfcc003 AND xcbt005 = p_sfcc004
               AND xcbt006 = p_sfcb003 AND xcbt007 = p_sfcb004
              
       END IF  
    END IF     
             
END FUNCTION
################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2016/12/7 By 02294
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp163_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   DEFINE l_comp         LIKE glaa_t.glaacomp
   
   IF cl_null(g_master.xcbtcomp) THEN RETURN END IF

   IF cl_null(g_master.xcbt001) THEN RETURN END IF

   IF cl_null(g_master.xcbt002) THEN RETURN END IF

   LET l_flag = cl_get_para(g_enterprise,g_master.xcbtcomp,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > g_master.xcbt001 THEN
      LET g_errno = 'axc-00303'
   END IF

   IF l_yy = g_master.xcbt001 AND l_pp > g_master.xcbt002 THEN     
      LET g_errno = 'axc-00304'
   END IF
   
END FUNCTION

#非制程工单的写入
PRIVATE FUNCTION axcp163_ins_xcbt_2(p_sfcbdocno)
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE l_xcbt       RECORD LIKE xcbt_t.*
DEFINE l_sfdb007    LIKE sfdb_t.sfdb007
DEFINE l_sffb017    LIKE sffb_t.sffb017
DEFINE l_sffb018    LIKE sffb_t.sffb018
DEFINE l_sffb019    LIKE sffb_t.sffb019
DEFINE l_sffb020    LIKE sffb_t.sffb020
DEFINE l_sfcb021    LIKE sfcb_t.sfcb021
DEFINE l_sfcb022    LIKE sfcb_t.sfcb022
DEFINE l_sfaa010    LIKE sfaa_t.sfaa010
DEFINE l_sfaa013    LIKE sfaa_t.sfaa013
DEFINE l_imaa006    LIKE imaa_t.imaa006
DEFINE l_success    LIKE type_t.num5
DEFINE l_sfaa057    LIKE sfaa_t.sfaa057

    #寫入一筆作業是空格，跟下站是END
    #起始站：
    #轉入數量=工單成套發料單的實際套數(sfdb007)，
    #
    #轉出數量：
    #良品數量=當月已確認報工檔sffb017 （各數計算取報工檔都只計算sffb010=3.報工，且需排除runcard類型=重工的sfca005<>'2')
    #報發數量=當月已確認報工檔sffb018
    #當站下線數量=sffb019
    #回收數量=sffb020

    #轉入數量
    SELECT SUM(sfdb007) INTO l_sfdb007 FROM sfda_t,sfdb_t 
        WHERE sfdaent = sfdbent AND sfdadocno = sfdbdocno AND sfdbent = g_enterprise AND sfda002 = '11'  #成套發料 
          AND sfdastus = 'S' AND sfdb001 = p_sfcbdocno AND sfdb002 = 0 
          AND sfda001 <= g_edate AND sfda001 >= g_bdate
    
    #良品數量 #報發數量  #當站下線數量  #回收數量
    SELECT SUM(sffb017),SUM(sffb018),SUM(sffb019),SUM(sffb020) INTO l_sffb017,l_sffb018,l_sffb019,l_sffb020 FROM sffb_t,sfca_t 
       WHERE sffbent = sfcaent AND sffb005 = sfcadocno AND sffb006 = sfca001 AND sfca005 <> '2'
         AND sffbent = g_enterprise AND sffb001 = '3' AND sffbstus = 'Y'
         AND sffb005 = p_sfcbdocno AND sffb006 = 0 AND (sffb007 IS NULL OR sffb007 = ' ') AND (sffb008 IS NULL OR sffb008 = ' ')
         AND sffb012 <= g_edate AND sffb012 >= g_bdate
    IF cl_null(l_sfdb007) THEN
       LET l_sfdb007 = 0
    END IF
    IF cl_null(l_sffb017) THEN
       LET l_sffb017 = 0
    END IF
    IF cl_null(l_sffb018) THEN
       LET l_sffb018 = 0
    END IF
    IF cl_null(l_sffb019) THEN
       LET l_sffb019 = 0
    END IF
    IF cl_null(l_sffb020) THEN
       LET l_sffb020 = 0
    END IF
    
    #轉出分子
    IF cl_null(l_sfcb021) OR l_sfcb021 = 0 THEN
       LET l_sfcb021 = 1
    END IF
    #轉出分母
    IF cl_null(l_sfcb022) OR l_sfcb022 = 0 THEN
       LET l_sfcb022 = 1
    END IF
             
    LET l_xcbt.xcbtent = g_enterprise
    LET l_xcbt.xcbtsite = g_site
    LET l_xcbt.xcbtcomp = g_master.xcbtcomp
    LET l_xcbt.xcbt001 = g_master.xcbt001
    LET l_xcbt.xcbt002 = g_master.xcbt002
    LET l_xcbt.xcbt003 = p_sfcbdocno
    LET l_xcbt.xcbt004 = ' '
    LET l_xcbt.xcbt005 = ' '
    LET l_xcbt.xcbt006 = 'END'
    LET l_xcbt.xcbt007 = '0'
        
    LET l_xcbt.xcbt009 = l_sfdb007
    #計算方式=報工單上的數量*轉出分母/轉出分子,轉出來是工單單位
    #如果工單單位跟基礎單位不一樣，再转基礎單位對應的數量
    LET l_xcbt.xcbt010 = l_sffb017*l_sfcb022/l_sfcb021
    #170418-00026#1---add---s
    IF g_sys_6007 = '1' THEN
       LET l_xcbt.xcbt011 = 0
       LET l_xcbt.xcbt012 = 0                
    ELSE
    #170418-00026#1---add---e
       LET l_xcbt.xcbt011 = l_sffb018
       LET l_xcbt.xcbt012 = l_sffb019
    END IF   #170418-00026#1
    LET l_xcbt.xcbt013 = l_sffb020
    
    SELECT sfaa010,sfaa013 INTO l_sfaa010,l_sfaa013 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
    SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_sfaa010
    IF NOT cl_null(l_sfaa013) AND NOT cl_null(l_imaa006) THEN
       IF l_sfaa013 <> l_imaa006 THEN
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt009) RETURNING l_success,l_xcbt.xcbt009
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt011) RETURNING l_success,l_xcbt.xcbt011
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt012) RETURNING l_success,l_xcbt.xcbt012
          CALL s_aooi250_convert_qty(l_sfaa010,l_sfaa013,l_imaa006,l_xcbt.xcbt013) RETURNING l_success,l_xcbt.xcbt013
       ELSE
          CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt009) RETURNING l_success,l_xcbt.xcbt009
          CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
          CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt011) RETURNING l_success,l_xcbt.xcbt011
          CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt012) RETURNING l_success,l_xcbt.xcbt012
          CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt013) RETURNING l_success,l_xcbt.xcbt013
       END IF
    END IF
    
    LET l_xcbt.xcbt008 = 1
    INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                        xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                        xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                        xcbt011,xcbt012,xcbt013)
       VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
               l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
               l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
               l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins xcbt_t"
       CALL cl_err()          
       LET g_success=FALSE
    END IF
    #170217-00025#7 add-S
    IF SQLCA.sqlerrd[3] > 0 THEN
       LET g_flag = TRUE
    END IF
    #170217-00025#7 add-E
    
    #寫入一筆作業是END，下站是STORAGE    
    LET l_xcbt.xcbtent = g_enterprise
    LET l_xcbt.xcbtsite = g_site
    LET l_xcbt.xcbtcomp = g_master.xcbtcomp
    LET l_xcbt.xcbt001 = g_master.xcbt001
    LET l_xcbt.xcbt002 = g_master.xcbt002
    LET l_xcbt.xcbt003 = p_sfcbdocno
    LET l_xcbt.xcbt004 = 'END'
    LET l_xcbt.xcbt005 = '0'
    LET l_xcbt.xcbt006 = 'STORAGE'
    LET l_xcbt.xcbt007 = '0'
    LET l_xcbt.xcbt009 = l_xcbt.xcbt010
    #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
    SELECT sfaa057 INTO l_sfaa057 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
    IF l_sfaa057 = '1' THEN #厂内
       SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
           WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
             AND inaj015 = 'asft340'   #异动单据性质
             AND inaj035 = 'asft340'   #异动作业编号
             AND inaj022 <= g_edate AND inaj022 >= g_bdate
    ELSE
       #委外
       SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
           WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
             AND (inaj015 = 'apmt571' OR inaj015 = 'apmt531')    #异动单据性质
             AND (inaj035 = 'apmt571' OR inaj035 = 'apmt531')    #异动作业编号
             AND inaj022 <= g_edate AND inaj022 >= g_bdate
    END IF
    
    IF cl_null(l_xcbt.xcbt010) THEN
       LET l_xcbt.xcbt010 = 0
    END IF
    IF NOT cl_null(l_imaa006) THEN #161121-00018#13 ADD   
       CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
    END IF  #161121-00018#13 ADD   
    LET l_xcbt.xcbt011 = 0
    LET l_xcbt.xcbt012 = 0
    LET l_xcbt.xcbt013 = 0
    
    LET l_xcbt.xcbt008 = 2
    INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                        xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                        xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                        xcbt011,xcbt012,xcbt013)
       VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
               l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
               l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
               l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
               
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins xcbt_t"
       CALL cl_err()          
       LET g_success=FALSE
    END IF  
    #170217-00025#7 add-S
    IF SQLCA.sqlerrd[3] > 0 THEN
       LET g_flag = TRUE
    END IF
    #170217-00025#7 add-E 
    
END FUNCTION

#161121-00018#13 add
#每張工單固定寫入一筆最後的作業站為END的資料，轉出為STORAGE，
#轉入數量=製程中最後一站的轉出數量
#轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
#END站写入资料
PRIVATE FUNCTION axcp163_ins_xcbt_end(p_sfcbdocno)
DEFINE l_xcbt       RECORD LIKE xcbt_t.*
DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno
DEFINE l_imaa006    LIKE imaa_t.imaa006
DEFINE l_success    LIKE type_t.num5
DEFINE l_sfaa057    LIKE sfaa_t.sfaa057
DEFINE l_n          LIKE type_t.num5

      #每張工單固定寫入一筆最後的作業站為END的資料，轉出為STORAGE，
      #轉入數量=製程中最後一站的轉出數量
      #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
      #END站写入资料
      LET l_xcbt.xcbtent = g_enterprise
      LET l_xcbt.xcbtsite = g_site
      LET l_xcbt.xcbtcomp = g_master.xcbtcomp
      LET l_xcbt.xcbt001 = g_master.xcbt001
      LET l_xcbt.xcbt002 = g_master.xcbt002
      LET l_xcbt.xcbt003 = p_sfcbdocno
      LET l_xcbt.xcbt004 = 'END'
      LET l_xcbt.xcbt005 = '0'
      LET l_xcbt.xcbt006 = 'STORAGE'
      LET l_xcbt.xcbt007 = '0'
      LET l_xcbt.xcbt009 = 0
      LET l_xcbt.xcbt010 = 0
      
      #170411-00037#1---s
      ##轉入數量=工單成套發料單的實際套數(sfdb007)
      #轉入數量
      SELECT SUM(sfdb007) INTO l_xcbt.xcbt009 FROM sfda_t,sfdb_t 
          WHERE sfdaent = sfdbent AND sfdadocno = sfdbdocno AND sfdbent = g_enterprise AND sfda002 = '11'  #成套發料 
            AND sfdastus = 'S' AND sfdb001 = p_sfcbdocno AND sfdb002 = 0 
            AND sfda001 <= g_edate AND sfda001 >= g_bdate
      IF cl_null(l_xcbt.xcbt009) THEN
         LET l_xcbt.xcbt009 = 0
      END IF
      #170411-00037#1---e
      
      #轉出數量=當月完工入庫的數量（注意一般工單的入庫是asft340的inaj、委外工單是apmt571或apmt531的inaj)
      SELECT sfaa057 INTO l_sfaa057 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcbdocno
      IF l_sfaa057 = '1' THEN #厂内
         SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
             WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
               AND inaj015 = 'asft340'   #异动单据性质
               AND inaj035 = 'asft340'   #异动作业编号
               AND inaj022 <= g_edate AND inaj022 >= g_bdate
      ELSE
         #委外
         SELECT SUM(inaj011*inaj014) INTO l_xcbt.xcbt010 FROM inaj_t 
             WHERE inajent = g_enterprise AND inajsite = g_site AND inaj020 = p_sfcbdocno 
               AND (inaj015 = 'apmt571' OR inaj015 = 'apmt531')    #异动单据性质
               AND (inaj035 = 'apmt571' OR inaj035 = 'apmt531')    #异动作业编号
               AND inaj022 <= g_edate AND inaj022 >= g_bdate
      END IF
      
      IF cl_null(l_xcbt.xcbt010) THEN
         LET l_xcbt.xcbt010 = 0
      END IF
      IF NOT cl_null(l_imaa006) THEN
         CALL s_aooi250_take_decimals(l_imaa006,l_xcbt.xcbt010) RETURNING l_success,l_xcbt.xcbt010
      END IF
      
      LET l_xcbt.xcbt011 = 0
      LET l_xcbt.xcbt012 = 0
      LET l_xcbt.xcbt013 = 0

      SELECT COUNT(1) INTO l_n FROM xcbt_t 
         WHERE xcbtent = g_enterprise AND xcbtcomp = g_master.xcbtcomp AND xcbt001 = g_master.xcbt001
           AND xcbt002 = g_master.xcbt002 AND xcbt003 = p_sfcbdocno AND xcbt004 = l_xcbt.xcbt004 AND xcbt005 = l_xcbt.xcbt005
           AND xcbt006 = l_xcbt.xcbt006 AND xcbt007 = l_xcbt.xcbt007
      IF cl_null(l_n) OR l_n = 0 THEN  
         LET l_xcbt.xcbt008 = 1
         INSERT INTO xcbt_t (xcbtent,xcbtsite,xcbtcomp,
                             xcbt001,xcbt002,xcbt003,xcbt004,xcbt005,
                             xcbt006,xcbt007,xcbt008,xcbt009,xcbt010,
                             xcbt011,xcbt012,xcbt013)
            VALUES (l_xcbt.xcbtent,l_xcbt.xcbtsite,l_xcbt.xcbtcomp,
                    l_xcbt.xcbt001,l_xcbt.xcbt002,l_xcbt.xcbt003,l_xcbt.xcbt004,l_xcbt.xcbt005,
                    l_xcbt.xcbt006,l_xcbt.xcbt007,l_xcbt.xcbt008,l_xcbt.xcbt009,l_xcbt.xcbt010,
                    l_xcbt.xcbt011,l_xcbt.xcbt012,l_xcbt.xcbt013)
                    
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xcbt_t"
            CALL cl_err()          
            LET g_success=FALSE
         END IF 
         #170217-00025#7 add-S
         IF SQLCA.sqlerrd[3] > 0 THEN
            LET g_flag = TRUE
         END IF
         #170217-00025#7 add-E    
      END IF
END FUNCTION

#建立临时表
#170407-00041#1 add
PRIVATE FUNCTION axcp163_create_tmp_table()

   DROP TABLE sfcb_tmp;
   CREATE TEMP TABLE sfcb_tmp(
   sfcbdocno  VARCHAR(20),
   sfcb003    VARCHAR(10),
   sfcb004    VARCHAR(10),
   sfcb006    VARCHAR(10)
    );
   
END FUNCTION

#删除临时表
#170407-00041#1 add
PRIVATE FUNCTION axcp163_drop_tmp_table()

   DROP TABLE sfcb_tmp
   
END FUNCTION

#end add-point
 
{</section>}
 
