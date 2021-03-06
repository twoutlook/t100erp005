#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp800.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2016-07-13 10:35:30), PR版次:0010(2016-12-01 16:13:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000138
#+ Filename...: apsp800
#+ Description: 集團MRP計算作業
#+ Creator....: 01588(2014-04-14 10:10:32)
#+ Modifier...: 07024 -SD/PR- 08993
 
{</section>}
 
{<section id="apsp800.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#51 2016/04/27 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160512-00016#10 2016/05/25 By ming     增加欄位 psgb029 保稅否，資料來源為psoz043
#160602-00006#1  2016/06/06 By ming     psgb009 在驗量改抓 psoz041 
#150707-00043#1  2016/06/20 By 02097    修正背景執行問題
#160711-00013#1  2016/07/13 By dorislai 將#160512-00016#10加psgb029、psoz043的部分mark
#                                       原因：原先規劃psoz_t中會拆分保稅非保稅的數量，但因考量大部份客戶會拆保稅料非保稅料成不同料號，
#                                             所以psoz_t中的數量保持總量不拆分保稅非保稅
#160727-00019#15 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   transfer_site_temp -->trf_site_tmp01
#161109-00085#17 2016/11/15 By 08993    整批調整系統星號寫法
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
        psfa001          LIKE psfa_t.psfa001,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       psfa001 LIKE psfa_t.psfa001, 
   psfa001_desc LIKE type_t.chr80, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#mod--161109-00085#17 By 08993--(s)
#DEFINE g_psfa            RECORD LIKE psfa_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE g_psfa            RECORD  #集團MRP版本單頭檔
       psfaent LIKE psfa_t.psfaent, #企業編號
       psfa001 LIKE psfa_t.psfa001, #集團MRP版本
       psfa002 LIKE psfa_t.psfa002, #庫存保留天數
       psfa003 LIKE psfa_t.psfa003, #固定保留天數
       psfa004 LIKE psfa_t.psfa004, #建議撥入順序
       psfa005 LIKE psfa_t.psfa005, #建議撥出順序
       psfa006 LIKE psfa_t.psfa006, #考慮最小調撥量與調撥批量
       psfa007 LIKE psfa_t.psfa007, #合併時距
       psfa008 LIKE psfa_t.psfa008, #產生庫存調撥建議
       psfaownid LIKE psfa_t.psfaownid, #資料所有者
       psfaowndp LIKE psfa_t.psfaowndp, #資料所屬部門
       psfacrtid LIKE psfa_t.psfacrtid, #資料建立者
       psfacrtdp LIKE psfa_t.psfacrtdp, #資料建立部門
       psfacrtdt LIKE psfa_t.psfacrtdt, #資料創建日
       psfamodid LIKE psfa_t.psfamodid, #資料修改者
       psfamoddt LIKE psfa_t.psfamoddt, #最近修改日
       psfastus LIKE psfa_t.psfastus  #狀態碼
          END RECORD
#mod--161109-00085#17 By 08993--(e)

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp800.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apsp800_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp800 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp800_init()
 
      #進入選單 Menu (="N")
      CALL apsp800_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp800
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp800.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp800_init()
 
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
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp800.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp800_ui_dialog()
 
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
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT lc_param.psfa001 FROM psfa001
               ATTRIBUTE(WITHOUT DEFAULTS)
            
            AFTER FIELD psfa001
               CALL apsp800_psfa001_ref(lc_param.psfa001)
               IF NOT cl_null(lc_param.psfa001) THEN
                  IF NOT apsp800_psfa001_chk(lc_param.psfa001) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            ON ACTION controlp INFIELD psfa001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = lc_param.psfa001
               CALL q_psfa001()
               LET lc_param.psfa001 = g_qryparam.return1
               DISPLAY lc_param.psfa001 TO psfa001
               CALL apsp800_psfa001_ref(lc_param.psfa001)
               NEXT FIELD psfa001
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apsp800_get_buffer(l_dialog)
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
         CALL apsp800_init()
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
                 CALL apsp800_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp800_transfer_argv(ls_js)
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
 
{<section id="apsp800.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp800_transfer_argv(ls_js)
 
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
   #LET la_cmdrun.param[1] = la_param.psfa001         #150707-00043#1
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apsp800.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp800_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   #mod--161109-00085#17 By 08993--(s)
#   DEFINE l_psoz      RECORD LIKE psoz_t.*   #mark--161109-00085#17 By 08993--(s)
   DEFINE l_psoz      RECORD  #MRP結果檔
       psozent LIKE psoz_t.psozent, #企業編號
       psozsite LIKE psoz_t.psozsite, #營運據點
       psoz001 LIKE psoz_t.psoz001, #APS版本
       psoz002 LIKE psoz_t.psoz002, #執行日期時間
       psoz003 LIKE psoz_t.psoz003, #流水編號
       psoz004 LIKE psoz_t.psoz004, #供需日期
       psoz005 LIKE psoz_t.psoz005, #訂單未交量
       psoz006 LIKE psoz_t.psoz006, #計畫出貨量
       psoz007 LIKE psoz_t.psoz007, #安全庫存量
       psoz008 LIKE psoz_t.psoz008, #ATP需求量
       psoz009 LIKE psoz_t.psoz009, #訂單未交替他需求量
       psoz010 LIKE psoz_t.psoz010, #預測替他需求量
       psoz011 LIKE psoz_t.psoz011, #ATP替他需求量
       psoz012 LIKE psoz_t.psoz012, #計劃備料量
       psoz013 LIKE psoz_t.psoz013, #計劃備料替他需求量
       psoz014 LIKE psoz_t.psoz014, #工單備料量
       psoz015 LIKE psoz_t.psoz015, #工單備料替他需求量
       psoz016 LIKE psoz_t.psoz016, #備料重排減少量
       psoz017 LIKE psoz_t.psoz017, #備料重排增加量
       psoz018 LIKE psoz_t.psoz018, #庫存單位數量
       psoz019 LIKE psoz_t.psoz019, #採購待入庫數量
       psoz020 LIKE psoz_t.psoz020, #替代庫存量
       psoz021 LIKE psoz_t.psoz021, #請購量
       psoz022 LIKE psoz_t.psoz022, #待進貨量
       psoz023 LIKE psoz_t.psoz023, #待撥入量
       psoz024 LIKE psoz_t.psoz024, #未發放在製量
       psoz025 LIKE psoz_t.psoz025, #已發放在製量
       psoz026 LIKE psoz_t.psoz026, #替代請購量
       psoz027 LIKE psoz_t.psoz027, #替代採購進貨數量
       psoz028 LIKE psoz_t.psoz028, #替代在製量
       psoz029 LIKE psoz_t.psoz029, #重排減少量
       psoz030 LIKE psoz_t.psoz030, #重排增加量
       psoz031 LIKE psoz_t.psoz031, #預估結存
       psoz032 LIKE psoz_t.psoz032, #規劃採購量
       psoz033 LIKE psoz_t.psoz033, #替代規劃採購量
       psoz034 LIKE psoz_t.psoz034, #規劃製造量
       psoz035 LIKE psoz_t.psoz035, #替代規劃製造量
       psoz036 LIKE psoz_t.psoz036, #預計結存
       psoz037 LIKE psoz_t.psoz037, #規劃結存
       psoz038 LIKE psoz_t.psoz038, #品號
       psoz039 LIKE psoz_t.psoz039, #品號特徵碼
       psoz040 LIKE psoz_t.psoz040, #時距編號(GUID)
       psoz041 LIKE psoz_t.psoz041, #採購在驗數量
       psoz042 LIKE psoz_t.psoz042, #行政保留量
       psoz043 LIKE psoz_t.psoz043, #保稅否
       psoz044 LIKE psoz_t.psoz044  #替代採購在驗數量
          END RECORD
   #mod--161109-00085#17 By 08993--(e)
   #mod--161109-00085#17 By 08993--(s)
#   DEFINE l_psgb      RECORD LIKE psgb_t.*   #mark--161109-00085#17 By 08993--(s)
   DEFINE l_psgb      RECORD  #集團MRP明細檔
       psgbent LIKE psgb_t.psgbent, #企業編號
       psgb001 LIKE psgb_t.psgb001, #集團MRP版本
       psgb002 LIKE psgb_t.psgb002, #料件編號
       psgb003 LIKE psgb_t.psgb003, #產品特徵
       psgb004 LIKE psgb_t.psgb004, #日期
       psgbsite LIKE psgb_t.psgbsite, #營運據點
       psgb005 LIKE psgb_t.psgb005, #+庫存量
       psgb006 LIKE psgb_t.psgb006, #+替代量
       psgb007 LIKE psgb_t.psgb007, #+請購量
       psgb008 LIKE psgb_t.psgb008, #+採購量
       psgb009 LIKE psgb_t.psgb009, #+在驗量
       psgb010 LIKE psgb_t.psgb010, #+在製量
       psgb011 LIKE psgb_t.psgb011, #+交期重排供給增加量
       psgb012 LIKE psgb_t.psgb012, #+備料重排需求減少量
       psgb013 LIKE psgb_t.psgb013, #-安全庫存量
       psgb014 LIKE psgb_t.psgb014, #-訂單未交量
       psgb015 LIKE psgb_t.psgb015, #-預測需求量
       psgb016 LIKE psgb_t.psgb016, #-工單備料量
       psgb017 LIKE psgb_t.psgb017, #-計畫備料量
       psgb018 LIKE psgb_t.psgb018, #-交期重排減少量
       psgb019 LIKE psgb_t.psgb019, #-備料重排增加量
       psgb020 LIKE psgb_t.psgb020, #結存量
       psgb021 LIKE psgb_t.psgb021, #+建議採購量
       psgb022 LIKE psgb_t.psgb022, #+建議生產量
       psgb023 LIKE psgb_t.psgb023, #預計結存量
       psgb024 LIKE psgb_t.psgb024, #-建議撥出量
       psgb025 LIKE psgb_t.psgb025, #+建議撥入量
       psgb026 LIKE psgb_t.psgb026, #+可挪動庫存量
       psgb027 LIKE psgb_t.psgb027, #已轉請採購
       psgb028 LIKE psgb_t.psgb028, #已轉工單
       psgbud001 LIKE psgb_t.psgbud001, #自定義欄位(文字)001
       psgbud002 LIKE psgb_t.psgbud002, #自定義欄位(文字)002
       psgbud003 LIKE psgb_t.psgbud003, #自定義欄位(文字)003
       psgbud004 LIKE psgb_t.psgbud004, #自定義欄位(文字)004
       psgbud005 LIKE psgb_t.psgbud005, #自定義欄位(文字)005
       psgbud006 LIKE psgb_t.psgbud006, #自定義欄位(文字)006
       psgbud007 LIKE psgb_t.psgbud007, #自定義欄位(文字)007
       psgbud008 LIKE psgb_t.psgbud008, #自定義欄位(文字)008
       psgbud009 LIKE psgb_t.psgbud009, #自定義欄位(文字)009
       psgbud010 LIKE psgb_t.psgbud010, #自定義欄位(文字)010
       psgbud011 LIKE psgb_t.psgbud011, #自定義欄位(數字)011
       psgbud012 LIKE psgb_t.psgbud012, #自定義欄位(數字)012
       psgbud013 LIKE psgb_t.psgbud013, #自定義欄位(數字)013
       psgbud014 LIKE psgb_t.psgbud014, #自定義欄位(數字)014
       psgbud015 LIKE psgb_t.psgbud015, #自定義欄位(數字)015
       psgbud016 LIKE psgb_t.psgbud016, #自定義欄位(數字)016
       psgbud017 LIKE psgb_t.psgbud017, #自定義欄位(數字)017
       psgbud018 LIKE psgb_t.psgbud018, #自定義欄位(數字)018
       psgbud019 LIKE psgb_t.psgbud019, #自定義欄位(數字)019
       psgbud020 LIKE psgb_t.psgbud020, #自定義欄位(數字)020
       psgbud021 LIKE psgb_t.psgbud021, #自定義欄位(日期時間)021
       psgbud022 LIKE psgb_t.psgbud022, #自定義欄位(日期時間)022
       psgbud023 LIKE psgb_t.psgbud023, #自定義欄位(日期時間)023
       psgbud024 LIKE psgb_t.psgbud024, #自定義欄位(日期時間)024
       psgbud025 LIKE psgb_t.psgbud025, #自定義欄位(日期時間)025
       psgbud026 LIKE psgb_t.psgbud026, #自定義欄位(日期時間)026
       psgbud027 LIKE psgb_t.psgbud027, #自定義欄位(日期時間)027
       psgbud028 LIKE psgb_t.psgbud028, #自定義欄位(日期時間)028
       psgbud029 LIKE psgb_t.psgbud029, #自定義欄位(日期時間)029
       psgbud030 LIKE psgb_t.psgbud030, #自定義欄位(日期時間)030
       psgb029 LIKE psgb_t.psgb029  #No Use
               END RECORD
   #mod--161109-00085#17 By 08993--(e)
   DEFINE l_day       LIKE type_t.num5
   DEFINE l_date      LIKE type_t.dat
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_msg       STRING
   DEFINE l_ooef008   LIKE ooef_t.ooef008
   DEFINE l_ooef009   LIKE ooef_t.ooef009
   DEFINE l_oogc008   LIKE oogc_t.oogc008
   DEFINE l_oogc015   LIKE oogc_t.oogc015
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_success = TRUE
   #mod--161109-00085#17 By 08993--(s)
#   SELECT * INTO g_psfa.*   #mark--161109-00085#17 By 08993--(s) 
   SELECT psfaent,psfa001,psfa002,psfa003,psfa004,psfa005,psfa006,psfa007,psfa008,
          psfaownid,psfaowndp,psfacrtid,psfacrtdp,psfacrtdt,psfamodid,psfamoddt,psfastus 
     INTO g_psfa.psfaent,g_psfa.psfa001,g_psfa.psfa002,g_psfa.psfa003,g_psfa.psfa004,g_psfa.psfa005,
          g_psfa.psfa006,g_psfa.psfa007,g_psfa.psfa008,g_psfa.psfaownid,g_psfa.psfaowndp,g_psfa.psfacrtid,
          g_psfa.psfacrtdp,g_psfa.psfacrtdt,g_psfa.psfamodid,g_psfa.psfamoddt,g_psfa.psfastus
   #mod--161109-00085#17 By 08993--(e)
     FROM psfa_t
    WHERE psfaent = g_enterprise
      AND psfa001 = lc_param.psfa001
    
   CALL apsp800_create_temptable()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN 
   END IF
   
   #mod--161109-00085#17 By 08993--(s)
#   LET ls_sql = "SELECT DISTINCT psoz_t.* FROM psfa_t,psfb_t,psoz_t, ",   #mark--161109-00085#17 By 08993--(s)
   LET ls_sql = "SELECT DISTINCT psoz_t.psozent,psoz_t.psozsite,psoz_t.psoz001,psoz_t.psoz002,psoz_t.psoz003,
                                 psoz_t.psoz004,psoz_t.psoz005,psoz_t.psoz006,psoz_t.psoz007,psoz_t.psoz008,
                                 psoz_t.psoz009,psoz_t.psoz010,psoz_t.psoz011,psoz_t.psoz012,psoz_t.psoz013,
                                 psoz_t.psoz014,psoz_t.psoz015,psoz_t.psoz016,psoz_t.psoz017,psoz_t.psoz018,
                                 psoz_t.psoz019,psoz_t.psoz020,psoz_t.psoz021,psoz_t.psoz022,psoz_t.psoz023,
                                 psoz_t.psoz024,psoz_t.psoz025,psoz_t.psoz026,psoz_t.psoz027,psoz_t.psoz028,
                                 psoz_t.psoz029,psoz_t.psoz030,psoz_t.psoz031,psoz_t.psoz032,psoz_t.psoz033,
                                 psoz_t.psoz034,psoz_t.psoz035,psoz_t.psoz036,psoz_t.psoz037,psoz_t.psoz038,
                                 psoz_t.psoz039,psoz_t.psoz040,psoz_t.psoz041,psoz_t.psoz042,psoz_t.psoz043,psoz_t.psoz044 
                    FROM psfa_t,psfb_t,psoz_t, ",
   #mod--161109-00085#17 By 08993--(e)
                "       (SELECT MAX(psoz002) a,psozsite b FROM psoz_t,psfa_t,psfb_t ",
                "               WHERE psfaent = psfbent ",
                "                 AND psfa001 = psfb001 ",
                "                 AND psfaent = ",g_enterprise,
                "                 AND psfa001 = '",lc_param.psfa001,"'",
                "                 AND psozent = psfaent ",
                "                 AND psoz001 = psfb004 ",
                "               GROUP BY psozsite)",
                " WHERE psfaent = psfbent ",
                "   AND psfa001 = psfb001 ",
                "   AND psfaent = ",g_enterprise,
                "   AND psfa001 = '",lc_param.psfa001,"'",
                "   AND psozent = psfaent ",
                "   AND psoz001 = psfb004 ",
                "   AND psoz002 = a ",
                "   AND psozsite= b "
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = 3
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsp800_process_cs CURSOR FROM ls_sql
#  FOREACH apsp800_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET l_success = TRUE
   
   #刪除集團MRP匯總檔(psga_t)、集團MRP明細檔(psgb_t)及集團MRP建議調撥明細檔(psgc_t)
   #part1
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('aps-00095',g_dlang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   IF NOT apsp800_del_data() THEN
      LET l_success = FALSE
   END IF
   
   #抓取各site的MRP結果檔(psoz_t)。(每個site取執行日期時間(psoz002)最大的資料)
   #將取出的資料，依照合併時距(psfa007)匯總後，寫入集團MRP明細檔(psgb_t)
   #part2
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('aps-00096',g_dlang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   DECLARE apsp800_process_cs CURSOR FROM ls_sql
   FOREACH apsp800_process_cs INTO l_psoz.psozent,l_psoz.psozsite,l_psoz.psoz001,l_psoz.psoz002,l_psoz.psoz003,l_psoz.psoz004,
                                   l_psoz.psoz005,l_psoz.psoz006,l_psoz.psoz007,l_psoz.psoz008,l_psoz.psoz009,l_psoz.psoz010,
                                   l_psoz.psoz011,l_psoz.psoz012,l_psoz.psoz013,l_psoz.psoz014,l_psoz.psoz015,l_psoz.psoz016,
                                   l_psoz.psoz017,l_psoz.psoz018,l_psoz.psoz019,l_psoz.psoz020,l_psoz.psoz021,l_psoz.psoz022,
                                   l_psoz.psoz023,l_psoz.psoz024,l_psoz.psoz025,l_psoz.psoz026,l_psoz.psoz027,l_psoz.psoz028,
                                   l_psoz.psoz029,l_psoz.psoz030,l_psoz.psoz031,l_psoz.psoz032,l_psoz.psoz033,l_psoz.psoz034,
                                   l_psoz.psoz035,l_psoz.psoz036,l_psoz.psoz037,l_psoz.psoz038,l_psoz.psoz039,l_psoz.psoz040,
                                   l_psoz.psoz041,l_psoz.psoz042,l_psoz.psoz043,l_psoz.psoz044
   
      CASE g_psfa.psfa007
         WHEN '1'   #日 
              LET l_date = l_psoz.psoz004
         WHEN '2'   #週
              SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009
                FROM ooef_t
               WHERE ooefent = g_enterprise
                 AND ooef001 = l_psoz.psozsite
              #本日的週別
              SELECT oogc008,oogc015 INTO l_oogc008,l_oogc015
                FROM oogc_t
               WHERE oogcent = g_enterprise
                 AND oogc001 = l_ooef008
                 AND oogc002 = l_ooef009
                 AND oogc003 = l_psoz.psoz004
              #本週的第一天
              SELECT MIN(oogc003)
                INTO l_date
                FROM oogc_t
               WHERE oogcent = g_enterprise
                 AND oogc001 = l_ooef008
                 AND oogc002 = l_ooef009
                 AND oogc008 = l_oogc008
                 AND oogc015 = l_oogc015
         WHEN '3'   #旬
              CALL s_date_get_day(l_psoz.psoz004)
                   RETURNING l_day
              CASE 
                 WHEN l_day <= 10
                      LET l_date = MDY(MONTH(l_psoz.psoz004),1,YEAR(l_psoz.psoz004))
                 WHEN l_day > 10 AND l_day <= 20
                      LET l_date = MDY(MONTH(l_psoz.psoz004),11,YEAR(l_psoz.psoz004))
                 WHEN l_day > 20
                      LET l_date = MDY(MONTH(l_psoz.psoz004),21,YEAR(l_psoz.psoz004))
              END CASE
         WHEN '4'   #月
              LET l_date = MDY(MONTH(l_psoz.psoz004),1,YEAR(l_psoz.psoz004))
      END CASE
      
      INITIALIZE l_psgb.* TO NULL
      LET l_psgb.psgbent = g_enterprise
      LET l_psgb.psgb001 = g_psfa.psfa001
      LET l_psgb.psgb002 = l_psoz.psoz038
      LET l_psgb.psgb003 = l_psoz.psoz039
      LET l_psgb.psgb004 = l_date
      LET l_psgb.psgbsite= l_psoz.psozsite
      LET l_psgb.psgb005 = l_psoz.psoz018
      LET l_psgb.psgb006 = l_psoz.psoz009 + l_psoz.psoz010 + l_psoz.psoz013 + l_psoz.psoz015
                         + l_psoz.psoz020 + l_psoz.psoz026 + l_psoz.psoz027 + l_psoz.psoz028
      LET l_psgb.psgb007 = l_psoz.psoz021
      LET l_psgb.psgb008 = l_psoz.psoz022
      #160602-00006#1 20160606 modify by ming -----(S) 
      #LET l_psgb.psgb009 = l_psoz.psoz019
      LET l_psgb.psgb009 = l_psoz.psoz041
      #160602-00006#1 20160606 modify by ming -----(E) 
      LET l_psgb.psgb010 = l_psoz.psoz024 + l_psoz.psoz025
      LET l_psgb.psgb011 = l_psoz.psoz030
      LET l_psgb.psgb012 = l_psoz.psoz016
      LET l_psgb.psgb013 = l_psoz.psoz007
      LET l_psgb.psgb014 = l_psoz.psoz005
      LET l_psgb.psgb015 = l_psoz.psoz006
      LET l_psgb.psgb016 = l_psoz.psoz014
      LET l_psgb.psgb017 = l_psoz.psoz012
      LET l_psgb.psgb018 = l_psoz.psoz029
      LET l_psgb.psgb019 = l_psoz.psoz017
      LET l_psgb.psgb020 = 0
      LET l_psgb.psgb021 = 0
      LET l_psgb.psgb022 = 0
      LET l_psgb.psgb023 = 0
      LET l_psgb.psgb024 = 0
      LET l_psgb.psgb025 = 0
      LET l_psgb.psgb026 = 0
      LET l_psgb.psgb027 = 'N'
      LET l_psgb.psgb028 = 'N' 
      
      #160512-00016#10 20160525 add by ming -----(S) 
      LET l_psgb.psgb029 = l_psoz.psoz043     #保稅否 
      IF cl_null(l_psgb.psgb029) THEN 
         LET l_psgb.psgb029 = 'N' 
      END IF 
      #160512-00016#10 20160525 add by ming -----(E) 
      
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt 
        FROM psgb_t
       WHERE psgbent = l_psgb.psgbent
         AND psgb001 = l_psgb.psgb001
         AND psgb002 = l_psgb.psgb002
         AND psgb003 = l_psgb.psgb003
         AND psgb004 = l_psgb.psgb004
         AND psgbsite= l_psgb.psgbsite 
#         AND psgb029 = l_psgb.psgb029     #160512-00016#10 20160525 add by ming #160711-00013#1-mark
      IF cl_null(l_cnt) OR l_cnt = 0 THEN
         #新增資料到psgb_t 
         #160512-00016#10 20160525 modify by ming -----(S) 
         #INSERT INTO psgb_t (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb005,
         #                    psgb006,psgb007,psgb008,psgb009,psgb010,psgb011,psgb012,
         #                    psgb013,psgb014,psgb015,psgb016,psgb017,psgb018,psgb019,
         #                    psgb020,psgb021,psgb022,psgb023,psgb024,psgb025,psgb026,
         #                    psgb027,psgb028)
         #   VALUES (l_psgb.psgbent,l_psgb.psgb001,l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb004,
         #           l_psgb.psgbsite,l_psgb.psgb005,l_psgb.psgb006,l_psgb.psgb007,l_psgb.psgb008,
         #           l_psgb.psgb009,l_psgb.psgb010,l_psgb.psgb011,l_psgb.psgb012,l_psgb.psgb013,
         #           l_psgb.psgb014,l_psgb.psgb015,l_psgb.psgb016,l_psgb.psgb017,l_psgb.psgb018,
         #           l_psgb.psgb019,l_psgb.psgb020,l_psgb.psgb021,l_psgb.psgb022,l_psgb.psgb023,
         #           l_psgb.psgb024,l_psgb.psgb025,l_psgb.psgb026,l_psgb.psgb027,l_psgb.psgb028)     
        #mod--161109-00085#17 By 08993--(s)         
#        INSERT INTO psgb_t (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb005,
#                            psgb006,psgb007,psgb008,psgb009,psgb010,psgb011,psgb012,
#                            psgb013,psgb014,psgb015,psgb016,psgb017,psgb018,psgb019,
#                            psgb020,psgb021,psgb022,psgb023,psgb024,psgb025,psgb026,
#                            psgb027,psgb028,psgb029)
        INSERT INTO psgb_t (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb005,
                            psgb006,psgb007,psgb008,psgb009,psgb010,psgb011,psgb012,
                            psgb013,psgb014,psgb015,psgb016,psgb017,psgb018,psgb019,
                            psgb020,psgb021,psgb022,psgb023,psgb024,psgb025,psgb026,
                            psgb027,psgb028,psgbud001,psgbud002,psgbud003,psgbud004,
                            psgbud005,psgbud006,psgbud007,psgbud008,psgbud009,psgbud010,
                            psgbud011,psgbud012,psgbud013,psgbud014,psgbud015,psgbud016,
                            psgbud017,psgbud018,psgbud019,psgbud020,psgbud021,psgbud022,
                            psgbud023,psgbud024,psgbud025,psgbud026,psgbud027,psgbud028,
                            psgbud029,psgbud030,psgb029)                    
        #mod--161109-00085#17 By 08993--(e)    
        #mod--161109-00085#17 By 08993--(s)
#                     VALUES (l_psgb.psgbent,l_psgb.psgb001,l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb004,
#                             l_psgb.psgbsite,l_psgb.psgb005,l_psgb.psgb006,l_psgb.psgb007,l_psgb.psgb008,
#                             l_psgb.psgb009,l_psgb.psgb010,l_psgb.psgb011,l_psgb.psgb012,l_psgb.psgb013,
#                             l_psgb.psgb014,l_psgb.psgb015,l_psgb.psgb016,l_psgb.psgb017,l_psgb.psgb018,
#                             l_psgb.psgb019,l_psgb.psgb020,l_psgb.psgb021,l_psgb.psgb022,l_psgb.psgb023,
#                             l_psgb.psgb024,l_psgb.psgb025,l_psgb.psgb026,l_psgb.psgb027,l_psgb.psgb028, 
#                             l_psgb.psgb029) 
                     VALUES (l_psgb.psgbent,l_psgb.psgb001,l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb004,
                             l_psgb.psgbsite,l_psgb.psgb005,l_psgb.psgb006,l_psgb.psgb007,l_psgb.psgb008,
                             l_psgb.psgb009,l_psgb.psgb010,l_psgb.psgb011,l_psgb.psgb012,l_psgb.psgb013,
                             l_psgb.psgb014,l_psgb.psgb015,l_psgb.psgb016,l_psgb.psgb017,l_psgb.psgb018,
                             l_psgb.psgb019,l_psgb.psgb020,l_psgb.psgb021,l_psgb.psgb022,l_psgb.psgb023,
                             l_psgb.psgb024,l_psgb.psgb025,l_psgb.psgb026,l_psgb.psgb027,l_psgb.psgb028, 
                             l_psgb.psgbud001,l_psgb.psgbud002,l_psgb.psgbud003,l_psgb.psgbud004,
                             l_psgb.psgbud005,l_psgb.psgbud006,l_psgb.psgbud007,l_psgb.psgbud008,l_psgb.psgbud009,l_psgb.psgbud010,
                             l_psgb.psgbud011,l_psgb.psgbud012,l_psgb.psgbud013,l_psgb.psgbud014,l_psgb.psgbud015,l_psgb.psgbud016,
                             l_psgb.psgbud017,l_psgb.psgbud018,l_psgb.psgbud019,l_psgb.psgbud020,l_psgb.psgbud021,l_psgb.psgbud022,
                             l_psgb.psgbud023,l_psgb.psgbud024,l_psgb.psgbud025,l_psgb.psgbud026,l_psgb.psgbud027,l_psgb.psgbud028,
                             l_psgb.psgbud029,l_psgb.psgbud030,l_psgb.psgb029)         
         #160512-00016#10 20160525 modify by ming -----(E)
         #mod--161109-00085#17 By 08993--(s)         
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_errmsg('ins psgb','','',SQLCA.sqlcode,1)
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      ELSE
         UPDATE psgb_t SET psgb005 = psgb005 + l_psgb.psgb005,
                           psgb006 = psgb006 + l_psgb.psgb006,
                           psgb007 = psgb007 + l_psgb.psgb007,
                           psgb008 = psgb008 + l_psgb.psgb008,
                           psgb009 = psgb009 + l_psgb.psgb009,
                           psgb010 = psgb010 + l_psgb.psgb010,
                           psgb011 = psgb011 + l_psgb.psgb011,
                           psgb012 = psgb012 + l_psgb.psgb012,
                           psgb013 = psgb013 + l_psgb.psgb013,
                           psgb014 = psgb014 + l_psgb.psgb014,
                           psgb015 = psgb015 + l_psgb.psgb015,
                           psgb016 = psgb016 + l_psgb.psgb016,
                           psgb017 = psgb017 + l_psgb.psgb017,
                           psgb018 = psgb018 + l_psgb.psgb018,
                           psgb019 = psgb019 + l_psgb.psgb019,
                           psgb020 = psgb020 + l_psgb.psgb020,
                           psgb021 = psgb021 + l_psgb.psgb021,
                           psgb022 = psgb022 + l_psgb.psgb022,
                           psgb023 = psgb023 + l_psgb.psgb023,
                           psgb024 = psgb024 + l_psgb.psgb024,
                           psgb025 = psgb025 + l_psgb.psgb025,
                           psgb026 = psgb026 + l_psgb.psgb026
          WHERE psgbent = l_psgb.psgbent
            AND psgb001 = l_psgb.psgb001
            AND psgb002 = l_psgb.psgb002
            AND psgb003 = l_psgb.psgb003
            AND psgb004 = l_psgb.psgb004
            AND psgbsite= l_psgb.psgbsite 
#            AND psgb029 = l_psgb.psgb029     #160512-00016#10 20160525 add by ming   #160711-00013#1-mark
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_errmsg('upd psgb','','',SQLCA.sqlcode,1)
            LET l_success = FALSE
            EXIT FOREACH
         END IF
      END IF
   
   END FOREACH
   
   #2015/02/14 by stellar add ----- (S)
   #判斷每個日期各site是否皆有一筆資料，沒有的話則新增一筆
   IF l_success THEN
      CALL apsp800_ins_psgb_1()
           RETURNING l_success
   END IF
   #2015/02/14 by stellar add ----- (E)
   
   IF l_success THEN
      #part3
      IF g_bgjob <> "Y" THEN
         LET l_msg = cl_getmsg('aps-00097',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      #呼叫函式計算各site的結存量、可挪動的庫存量、調撥數量、建議採購量、建議生產量及預計結存量
      CALL apsp800_quantity()
           RETURNING l_success
   END IF
   
   CALL cl_showmsg()
   
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
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apsp800_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp800.get_buffer" >}
PRIVATE FUNCTION apsp800_get_buffer(p_dialog)
 
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
 
{<section id="apsp800.msgcentre_notify" >}
PRIVATE FUNCTION apsp800_msgcentre_notify()
 
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
 
{<section id="apsp800.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 帶出集團MRP版本的說明
# Memo...........:
# Usage..........: CALL apsp800_psfa001_ref(p_psfa001)
#                  
# Input parameter: p_psfa001      集團MRP版本
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/04/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_psfa001_ref(p_psfa001)
DEFINE p_psfa001         LIKE psfa_t.psfa001
DEFINE l_psfa001_desc    LIKE psfal_t.psfal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_psfa001
   CALL ap_ref_array2(g_ref_fields,"SELECT psfal003 FROM psfal_t WHERE psfalent='"||g_enterprise||"' AND psfal001=? AND psfal002='"||g_dlang||"'","")
        RETURNING g_rtn_fields
   LET l_psfa001_desc = '', g_rtn_fields[1] , ''
   DISPLAY l_psfa001_desc TO psfa001_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查集團MRP版本是否存在
# Memo...........:
# Usage..........: CALL apsp800_psfa001_chk(p_psfa001)
#                  RETURNING r_success
# Input parameter: p_psfa001      集團MRP版本
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_psfa001_chk(p_psfa001)
DEFINE p_psfa001         LIKE psfa_t.psfa001
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_psfa001) THEN
      RETURN r_success
   END IF

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_psfa001
   LET g_errshow = TRUE   #160318-00025#51
   LET g_chkparam.err_str[1] = "aps-00092:sub-01302|apsi800|",cl_get_progname("apsi800",g_lang,"2"),"|:EXEPROGapsi800"    #160318-00025#51
   IF NOT cl_chk_exist("v_psfa001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除集團MRP匯總檔(psga_t)及集團MRP明細檔(psgb_t)
# Memo...........:
# Usage..........: CALL apsp800_del_data()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/16 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_del_data()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM psga_t
    WHERE psgaent = g_enterprise
      AND psga001 = g_psfa.psfa001
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('del psga',g_psfa.psfa001,'',SQLCA.sqlcode,1)
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM psgb_t
    WHERE psgbent = g_enterprise
      AND psgb001 = g_psfa.psfa001
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('del psgb',g_psfa.psfa001,'',SQLCA.sqlcode,1)
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DELETE FROM psgc_t
    WHERE psgcent = g_enterprise
      AND psgc001 = g_psfa.psfa001
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('del psgc',g_psfa.psfa001,'',SQLCA.sqlcode,1)
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 調撥處理
# Memo...........:
# Usage..........: CALL apsp800_transfer(p_psgb002,p_psgb003,p_psgb004)
#                  RETURNING r_success
# Input parameter: p_psgb002      料件編號
#                : p_psgb003      產品特徵
#                : p_psgb004      日期
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/17 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_transfer(p_psgb002,p_psgb003,p_psgb004)
DEFINE p_psgb002         LIKE psgb_t.psgb002
DEFINE p_psgb003         LIKE psgb_t.psgb003
DEFINE p_psgb004         LIKE psgb_t.psgb004
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_psfc002         LIKE psfc_t.psfc002

   LET r_success = TRUE
 
   #若有設定群組，則只能調撥至同群組的據點
   #若沒設定群組，則可調撥存在於集團MRP版本單身檔(psfb_t)的據點
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM psfc_t
    WHERE psfcent = g_enterprise
      AND psfc001 = g_psfa.psfa001
   IF NOT cl_null(l_cnt) AND l_cnt > 0 THEN
      #判斷同群組內的是否需要調撥
      DECLARE psfc_cs CURSOR FOR
       SELECT psfc002 
         FROM psfc_t
        WHERE psfcent = g_enterprise
          AND psfc001 = g_psfa.psfa001
        ORDER BY psfc002
      FOREACH psfc_cs INTO l_psfc002
         DELETE FROM trf_site_temp01         #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
         INSERT INTO trf_site_temp01         #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
            SELECT psfd003,psfd004
              FROM psfd_t
             WHERE psfdent = g_enterprise
               AND psfd001 = g_psfa.psfa001
               AND psfd002 = l_psfc002
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('ins trf_site_temp01','','',SQLCA.sqlcode,1)         #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         CALL apsp800_transfer_1(p_psgb002,p_psgb003,p_psgb004)
              RETURNING r_success
         IF NOT r_success THEN
            EXIT FOREACH
         END IF
      END FOREACH
   ELSE
      DELETE FROM trf_site_temp01          #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
      INSERT INTO trf_site_temp01          #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
         SELECT psfb002,psfb003
           FROM psfb_t
          WHERE psfbent = g_enterprise
            AND psfb001 = g_psfa.psfa001
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('ins trf_site_temp01','','',SQLCA.sqlcode,1)            #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      CALL apsp800_transfer_1(p_psgb002,p_psgb003,p_psgb004)
           RETURNING r_success  
      IF NOT r_success THEN
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算結存量、可挪動的庫存量、調撥數量、建議採購量、建議生產量及預計結存量
# Memo...........:
# Usage..........: CALL apsp800_quantity()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/17 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_quantity()
DEFINE r_success         LIKE type_t.num5
DEFINE l_psgb002         LIKE psgb_t.psgb002
DEFINE l_psgb003         LIKE psgb_t.psgb003
DEFINE l_psgb004         LIKE psgb_t.psgb004

   LET r_success = TRUE
   
   DECLARE quantity_cs CURSOR FOR
    SELECT psgb002,psgb003,psgb004 FROM psgb_t
     WHERE psgbent = g_enterprise
       AND psgb001 = g_psfa.psfa001
     GROUP BY psgb002,psgb003,psgb004
     ORDER BY psgb004
   FOREACH quantity_cs INTO l_psgb002,l_psgb003,l_psgb004
      #先依各site去計算結存量及可挪動的庫存量
      CALL apsp800_psgb020_psgb026(l_psgb002,l_psgb003,l_psgb004)
           RETURNING r_success
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
           
      #調撥處理
      IF g_psfa.psfa008 = 'Y' THEN
         CALL apsp800_transfer(l_psgb002,l_psgb003,l_psgb004)
              RETURNING r_success
         IF NOT r_success THEN
            EXIT FOREACH
         END IF
      END IF
      
      #建議採購量、建議生產量、預計結存量的計算
      CALL apsp800_other_quantity(l_psgb002,l_psgb003,l_psgb004)
           RETURNING r_success
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      #匯總資料到集團MRP匯總檔(psga_t)
      CALL apsp800_collect_psga(l_psgb002,l_psgb003,l_psgb004)
           RETURNING r_success
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 調撥處理-續(存在於temptable內的據點做調撥)
# Memo...........:
# Usage..........: CALL apsp800_transfer_1(p_psgb002,p_psgb003,p_psgb004)
#                  RETURNING r_success
# Input parameter: p_psgb002      料件編號
#                : p_psgb003      產品特徵
#                : p_psgb004      日期
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/17 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_transfer_1(p_psgb002,p_psgb003,p_psgb004)
DEFINE p_psgb002         LIKE psgb_t.psgb002
DEFINE p_psgb003         LIKE psgb_t.psgb003
DEFINE p_psgb004         LIKE psgb_t.psgb004
DEFINE r_success         LIKE type_t.num5
DEFINE l_psgbsite        LIKE psgb_t.psgbsite
DEFINE l_psgb026         LIKE psgb_t.psgb026
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_imaf101         LIKE imaf_t.imaf101
DEFINE l_imaf102         LIKE imaf_t.imaf102
DEFINE l_product         LIKE type_t.num5
DEFINE l_carry           LIKE type_t.num20_6
DEFINE l_site            LIKE psgb_t.psgbsite
DEFINE l_qty             LIKE psgb_t.psgb025
DEFINE l_psgb024         LIKE psgb_t.psgb024
DEFINE l_transfer_qty    LIKE psgb_t.psgb024
DEFINE l_psgcseq         LIKE psgc_t.psgcseq
DEFINE l_sql             STRING

   LET r_success = TRUE
   
   #撥出順序
   LET l_sql = "SELECT psgbsite,psgb026 ",
               "  FROM psgb_t,trf_site_temp01 ",          #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
               " WHERE psgbent = ",g_enterprise,
               "   AND psgb001 = '",g_psfa.psfa001,"'",
               "   AND psgb002 = '",p_psgb002,"'",
               "   AND psgb003 = '",p_psgb003,"'",
               "   AND psgb004 = '",p_psgb004,"'",
               "   AND psgbsite= site1 "
   CASE g_psfa.psfa005
      WHEN '1' 
           LET l_sql = l_sql," AND psgb026 > 0 ORDER BY psgb026 "
      WHEN '2' 
           LET l_sql = l_sql," AND psgb026 > 0 ORDER BY psgb026 DESC "
      WHEN '3'
           LET l_sql = l_sql," AND psgb026 > 0 ORDER BY order1 "
   END CASE
   PREPARE transfer_out_pre FROM l_sql
   DECLARE transfer_out_cs CURSOR FOR transfer_out_pre
   
   #撥入順序
   LET l_sql = "SELECT psgbsite,psgb020+psgb025 ",
               "  FROM psgb_t,trf_site_temp01 ",         #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
               " WHERE psgbent = ",g_enterprise,
               "   AND psgb001 = '",g_psfa.psfa001,"'",
               "   AND psgb002 = '",p_psgb002,"'",
               "   AND psgb003 = '",p_psgb003,"'",
               "   AND psgb004 = '",p_psgb004,"'",
               "   AND psgbsite= site1 "
   CASE g_psfa.psfa004
      WHEN '1'
           LET l_sql = l_sql," AND (psgb020+psgb025) < 0 ORDER BY psgb020 "
      WHEN '2'
           LET l_sql = l_sql," AND (psgb020+psgb025) < 0 ORDER BY psgb020 DESC "
      WHEN '3'
           LET l_sql = l_sql," AND (psgb020+psgb025) < 0 ORDER BY order1 "
   END CASE
   PREPARE transfer_in_pre FROM l_sql
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE transfer_in_count_pre FROM l_sql
   
   FOREACH transfer_out_cs INTO l_psgbsite,l_psgb026
   
      #檢查營運據點是否有需要撥入
      LET l_cnt = 0
      EXECUTE transfer_in_count_pre INTO l_cnt
      IF l_cnt = 0 THEN
         CONTINUE FOREACH
      END IF
      
      #判斷是否考慮調撥批量與最小調撥數量
      IF g_psfa.psfa006 = 'Y' THEN
         LET l_imaf101 = 0
         LET l_imaf102 = 0
         #調撥批量、最小調撥數量
         SELECT imaf101,imaf102 INTO l_imaf101,l_imaf102
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite= l_psgbsite
            AND imaf001 = p_psgb002
         #依調撥批量、最小調撥數量去計算最小調撥數量
         CASE
            WHEN l_imaf101 = 0 AND l_imaf102 = 0 
                 LET l_carry = 1
            WHEN l_imaf101 = 0 AND l_imaf102 > 0 
                 LET l_carry = l_imaf102
            WHEN l_imaf101 > 0 AND l_imaf102 = 0 
                 LET l_carry = l_imaf101
            WHEN l_imaf101 > 0 AND l_imaf102 > 0 
                 CALL s_num_round('4',l_imaf102/l_imaf101,0)
                      RETURNING l_product
                 LET l_carry = l_imaf101 * l_product
         END CASE
      ELSE
         LET l_carry = 1
      END IF
      
      LET l_psgb024 = 0
      DECLARE transfer_in_cs CURSOR FOR transfer_in_pre
      FOREACH transfer_in_cs INTO l_site,l_qty
         LET l_qty = l_qty * (-1)
      
         #調撥數量
         CASE 
            #若可挪動庫存量<最小調撥數量，則調撥數量=可挪動的庫存量
            WHEN l_psgb026 < l_carry
                 LET l_transfer_qty = l_psgb026
            #若可挪動庫存量<需求量，則用調撥批量去計算調撥數量
            WHEN l_psgb026 < l_qty
                 IF l_imaf101 = 0 THEN   #不使用調撥批量
                    LET l_transfer_qty = l_psgb026
                 ELSE
                    #無條件捨去
                    CALL s_num_round('3',l_psgb026/l_carry,0)
                         RETURNING l_product
                    LET l_transfer_qty = l_carry * l_product
                 END IF
            #若可挪動庫存量>需求量
            WHEN l_psgb026 > l_qty
                 IF l_imaf101 = 0 THEN   #不使用調撥批量
                    LET l_transfer_qty = l_qty
                 ELSE
                    #先用調撥批量計算應調撥數量
                    CALL s_num_round('4',l_qty/l_carry,0)
                         RETURNING l_product
                    LET l_transfer_qty = l_carry * l_product
                 END IF
                 #判斷可挪動庫存量與應調撥數量；若應調撥數量>可挪動庫存量，則只調撥可挪動庫存量
                 IF l_transfer_qty > l_psgb026 THEN
                    LET l_transfer_qty = l_psgb026
                 END IF
         END CASE
         
         #更新撥入的營運據點的建議撥入量
         UPDATE psgb_t SET psgb025 = psgb025 + l_transfer_qty
          WHERE psgbent = g_enterprise
            AND psgb001 = g_psfa.psfa001
            AND psgb002 = p_psgb002
            AND psgb003 = p_psgb003
            AND psgb004 = p_psgb004
            AND psgbsite= l_site
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_errmsg('upd psgb025','','',SQLCA.sqlcode,1)
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #新增集團MRP建議調撥明細檔(psgc_t)
         SELECT MAX(psgcseq)+1 INTO l_psgcseq 
           FROM psgc_t
          WHERE psgcent = g_enterprise
            AND psgc001 = g_psfa.psfa001
         IF cl_null(l_psgcseq) THEN
            LET l_psgcseq = 1
         END IF
         
         INSERT INTO psgc_t(psgcent,psgc001,psgcseq,psgc002,psgc003,psgc004,
                            psgc005,psgc006,psgc007,psgc008)
            VALUES(g_enterprise,g_psfa.psfa001,l_psgcseq,p_psgb002,p_psgb003,p_psgb004,
                   l_psgbsite,l_site,l_transfer_qty,'N')
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_errmsg('ins psgc_t','','',SQLCA.sqlcode,1)
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #撥出量
         LET l_psgb024 = l_psgb024 + l_transfer_qty
         
         #尚可挪動的庫存量
         LET l_psgb026 = l_psgb026 - l_transfer_qty
         IF l_psgb026 <= 0 THEN
            EXIT FOREACH
         END IF
      END FOREACH
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
      
      #更新建議撥出量
      UPDATE psgb_t SET psgb024 = l_psgb024
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 = p_psgb004
         AND psgbsite= l_psgbsite
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_errmsg('upd psgb024','','',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算各site的結存量及可挪動的庫存量
# Memo...........:
# Usage..........: CALL apsp800_psgb020_psgb026(p_psgb002,p_psgb003,p_psgb004)
#                  RETURNING r_success
# Input parameter: p_psgb002      料件編號
#                : p_psgb003      產品特徵
#                : p_psgb004      日期
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/17 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_psgb020_psgb026(p_psgb002,p_psgb003,p_psgb004)
DEFINE p_psgb002         LIKE psgb_t.psgb002
DEFINE p_psgb003         LIKE psgb_t.psgb003
DEFINE p_psgb004         LIKE psgb_t.psgb004
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_psgb      RECORD LIKE psgb_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_psgb      RECORD  #集團MRP明細檔
       psgbent LIKE psgb_t.psgbent, #企業編號
       psgb001 LIKE psgb_t.psgb001, #集團MRP版本
       psgb002 LIKE psgb_t.psgb002, #料件編號
       psgb003 LIKE psgb_t.psgb003, #產品特徵
       psgb004 LIKE psgb_t.psgb004, #日期
       psgbsite LIKE psgb_t.psgbsite, #營運據點
       psgb005 LIKE psgb_t.psgb005, #+庫存量
       psgb006 LIKE psgb_t.psgb006, #+替代量
       psgb007 LIKE psgb_t.psgb007, #+請購量
       psgb008 LIKE psgb_t.psgb008, #+採購量
       psgb009 LIKE psgb_t.psgb009, #+在驗量
       psgb010 LIKE psgb_t.psgb010, #+在製量
       psgb011 LIKE psgb_t.psgb011, #+交期重排供給增加量
       psgb012 LIKE psgb_t.psgb012, #+備料重排需求減少量
       psgb013 LIKE psgb_t.psgb013, #-安全庫存量
       psgb014 LIKE psgb_t.psgb014, #-訂單未交量
       psgb015 LIKE psgb_t.psgb015, #-預測需求量
       psgb016 LIKE psgb_t.psgb016, #-工單備料量
       psgb017 LIKE psgb_t.psgb017, #-計畫備料量
       psgb018 LIKE psgb_t.psgb018, #-交期重排減少量
       psgb019 LIKE psgb_t.psgb019, #-備料重排增加量
       psgb020 LIKE psgb_t.psgb020, #結存量
       psgb021 LIKE psgb_t.psgb021, #+建議採購量
       psgb022 LIKE psgb_t.psgb022, #+建議生產量
       psgb023 LIKE psgb_t.psgb023, #預計結存量
       psgb024 LIKE psgb_t.psgb024, #-建議撥出量
       psgb025 LIKE psgb_t.psgb025, #+建議撥入量
       psgb026 LIKE psgb_t.psgb026, #+可挪動庫存量
       psgb027 LIKE psgb_t.psgb027, #已轉請採購
       psgb028 LIKE psgb_t.psgb028, #已轉工單
       psgbud001 LIKE psgb_t.psgbud001, #自定義欄位(文字)001
       psgbud002 LIKE psgb_t.psgbud002, #自定義欄位(文字)002
       psgbud003 LIKE psgb_t.psgbud003, #自定義欄位(文字)003
       psgbud004 LIKE psgb_t.psgbud004, #自定義欄位(文字)004
       psgbud005 LIKE psgb_t.psgbud005, #自定義欄位(文字)005
       psgbud006 LIKE psgb_t.psgbud006, #自定義欄位(文字)006
       psgbud007 LIKE psgb_t.psgbud007, #自定義欄位(文字)007
       psgbud008 LIKE psgb_t.psgbud008, #自定義欄位(文字)008
       psgbud009 LIKE psgb_t.psgbud009, #自定義欄位(文字)009
       psgbud010 LIKE psgb_t.psgbud010, #自定義欄位(文字)010
       psgbud011 LIKE psgb_t.psgbud011, #自定義欄位(數字)011
       psgbud012 LIKE psgb_t.psgbud012, #自定義欄位(數字)012
       psgbud013 LIKE psgb_t.psgbud013, #自定義欄位(數字)013
       psgbud014 LIKE psgb_t.psgbud014, #自定義欄位(數字)014
       psgbud015 LIKE psgb_t.psgbud015, #自定義欄位(數字)015
       psgbud016 LIKE psgb_t.psgbud016, #自定義欄位(數字)016
       psgbud017 LIKE psgb_t.psgbud017, #自定義欄位(數字)017
       psgbud018 LIKE psgb_t.psgbud018, #自定義欄位(數字)018
       psgbud019 LIKE psgb_t.psgbud019, #自定義欄位(數字)019
       psgbud020 LIKE psgb_t.psgbud020, #自定義欄位(數字)020
       psgbud021 LIKE psgb_t.psgbud021, #自定義欄位(日期時間)021
       psgbud022 LIKE psgb_t.psgbud022, #自定義欄位(日期時間)022
       psgbud023 LIKE psgb_t.psgbud023, #自定義欄位(日期時間)023
       psgbud024 LIKE psgb_t.psgbud024, #自定義欄位(日期時間)024
       psgbud025 LIKE psgb_t.psgbud025, #自定義欄位(日期時間)025
       psgbud026 LIKE psgb_t.psgbud026, #自定義欄位(日期時間)026
       psgbud027 LIKE psgb_t.psgbud027, #自定義欄位(日期時間)027
       psgbud028 LIKE psgb_t.psgbud028, #自定義欄位(日期時間)028
       psgbud029 LIKE psgb_t.psgbud029, #自定義欄位(日期時間)029
       psgbud030 LIKE psgb_t.psgbud030, #自定義欄位(日期時間)030
       psgb029 LIKE psgb_t.psgb029  #No Use
               END RECORD
#mod--161109-00085#17 By 08993--(e)
DEFINE l_psgb005         LIKE psgb_t.psgb005
DEFINE l_psgb023         LIKE psgb_t.psgb023
DEFINE l_psgb020         LIKE psgb_t.psgb020
DEFINE l_psgb026         LIKE psgb_t.psgb026
DEFINE l_imaf013         LIKE imaf_t.imaf013
DEFINE l_imaf171         LIKE imaf_t.imaf171
DEFINE l_imaf172         LIKE imaf_t.imaf172
DEFINE l_imaf173         LIKE imaf_t.imaf173
DEFINE l_imaf174         LIKE imaf_t.imaf174
DEFINE l_psph026         LIKE psph_t.psph026
DEFINE l_psph026_1       LIKE psph_t.psph026
DEFINE l_keep_day        LIKE type_t.num5
DEFINE l_psgb024         LIKE psgb_t.psgb024
DEFINE l_storage_qty     LIKE psgb_t.psgb020
DEFINE l_imae075         LIKE imae_t.imae075

   LET r_success = TRUE
   
   DECLARE psgb020_psgb026_cs CURSOR FOR
    #mod--161109-00085#17 By 08993--(s)
#    SELECT * FROM psgb_t   #mark--161109-00085#17 By 08993--(s)
    SELECT psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb005,psgb006,
           psgb007,psgb008,psgb009,psgb010,psgb011,psgb012,psgb013,psgb014,
           psgb015,psgb016,psgb017,psgb018,psgb019,psgb020,psgb021,psgb022,
           psgb023,psgb024,psgb025,psgb026,psgb027,psgb028,
           psgbud001,psgbud002,psgbud003,psgbud004,psgbud005,
           psgbud006,psgbud007,psgbud008,psgbud009,psgbud010,
           psgbud011,psgbud012,psgbud013,psgbud014,psgbud015,
           psgbud016,psgbud017,psgbud018,psgbud019,psgbud020,
           psgbud021,psgbud022,psgbud023,psgbud024,psgbud025,
           psgbud026,psgbud027,psgbud028,psgbud029,psgbud030,psgb029 
      FROM psgb_t 
    #mod--161109-00085#17 By 08993--(e)
     WHERE psgbent = g_enterprise
       AND psgb001 = g_psfa.psfa001
       AND psgb002 = p_psgb002
       AND psgb003 = p_psgb003
       AND psgb004 = p_psgb004
   #mod--161109-00085#17 By 08993--(s)    
#   FOREACH psgb020_psgb026_cs INTO l_psgb.*   #mark--161109-00085#17 By 08993--(s)
   FOREACH psgb020_psgb026_cs INTO l_psgb.psgbent,l_psgb.psgb001,l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb004,
                                   l_psgb.psgbsite,l_psgb.psgb005,l_psgb.psgb006,l_psgb.psgb007,l_psgb.psgb008,
                                   l_psgb.psgb009,l_psgb.psgb010,l_psgb.psgb011,l_psgb.psgb012,l_psgb.psgb013,
                                   l_psgb.psgb014,l_psgb.psgb015,l_psgb.psgb016,l_psgb.psgb017,l_psgb.psgb018,
                                   l_psgb.psgb019,l_psgb.psgb020,l_psgb.psgb021,l_psgb.psgb022,l_psgb.psgb023,
                                   l_psgb.psgb024,l_psgb.psgb025,l_psgb.psgb026,l_psgb.psgb027,l_psgb.psgb028,
                                   l_psgb.psgbud001,l_psgb.psgbud002,l_psgb.psgbud003,l_psgb.psgbud004,l_psgb.psgbud005,
                                   l_psgb.psgbud006,l_psgb.psgbud007,l_psgb.psgbud008,l_psgb.psgbud009,l_psgb.psgbud010,
                                   l_psgb.psgbud011,l_psgb.psgbud012,l_psgb.psgbud013,l_psgb.psgbud014,l_psgb.psgbud015,
                                   l_psgb.psgbud016,l_psgb.psgbud017,l_psgb.psgbud018,l_psgb.psgbud019,l_psgb.psgbud020,
                                   l_psgb.psgbud021,l_psgb.psgbud022,l_psgb.psgbud023,l_psgb.psgbud024,l_psgb.psgbud025,
                                   l_psgb.psgbud026,l_psgb.psgbud027,l_psgb.psgbud028,l_psgb.psgbud029,l_psgb.psgbud030,l_psgb.psgb029
   #mod--161109-00085#17 By 08993--(e)
      #結存量：
      #a.先抓取最近一筆的預計結存量
      LET l_psgb023 = 0
      SELECT psgb023 INTO l_psgb023 
        FROM psgb_t
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 = (SELECT MAX(psgb004) FROM psgb_t
                         WHERE psgbent = g_enterprise
                           AND psgb001 = g_psfa.psfa001
                           AND psgb002 = p_psgb002
                           AND psgb003 = p_psgb003
                           AND psgb004 < p_psgb004
                           AND psgbsite= l_psgb.psgbsite)
         AND psgbsite= l_psgb.psgbsite
      IF cl_null(l_psgb023) THEN
         LET l_psgb023 = 0 
      END IF
      
      #b.結存量=將1抓到的預計結存量(psgb023)+庫存量(psgb005)+替代量(psgb006)+請購量(psgb007)+採購量(psgb008)
      #        +在驗量(psgb009)+在製量(psgb010)+交期重排供給增加量(psgb011)+備料重排需求減少量(psgb012)
      #        - 安全庫存量(psgb013)-訂單未交量(psgb014)-預測需求量(psgb015)-工單備料量(psgb016)
      #        - 計畫備料量(psgb017)-交期重排減少量(psgb018)-備料重排增加量(psgb019)
      LET l_psgb020 = l_psgb023 + l_psgb.psgb005 + l_psgb.psgb006 + l_psgb.psgb007 + l_psgb.psgb008
                    + l_psgb.psgb009 + l_psgb.psgb010 + l_psgb.psgb011 + l_psgb.psgb012
                    - l_psgb.psgb013 - l_psgb.psgb014 - l_psgb.psgb015 - l_psgb.psgb016
                    - l_psgb.psgb017 - l_psgb.psgb018 - l_psgb.psgb019
      IF cl_null(l_psgb020) THEN
         LET l_psgb020 = 0
      END IF
      
      #可挪動的庫存量：
      #a.取得料號+產品特徵的保留天數
      CASE g_psfa.psfa002
         WHEN '1'   #依各料件的前置時間
              SELECT imaf013,imaf171,imaf172,imaf173,imaf174
                INTO l_imaf013,l_imaf171,l_imaf172,l_imaf173,l_imaf174
                FROM imaf_t
               WHERE imafent = g_enterprise
                 AND imaf001 = p_psgb002
                 AND imafsite= l_psgb.psgbsite
              CASE
                 WHEN l_imaf013 = '1' OR l_imaf013 = '4'   #採購或無
                      #保留天數=文件前置時間(imaf171)+交貨前置時間(imaf172)+到廠前置時間(imaf173)+入庫前置時間(imaf174)
                      LET l_keep_day = l_imaf171 + l_imaf172 + l_imaf173 + l_imaf174
                 WHEN l_imaf013 = '2' OR l_imaf013 = '3'   #自製或委外
                      #保留天數=累計前置時間(imae075)
                      LET l_imae075 = ''
                      SELECT imae075 INTO l_imae075 FROM imae_t
                       WHERE imaeent = g_enterprise
                         AND imae001 = p_psgb002
                         AND imaesite= l_psgb.psgbsite
                      LET l_keep_day = l_imae075
              END CASE
         WHEN '2'   #依固定時間
              LET l_keep_day = g_psfa.psfa003
      END CASE
      
      #b.保留天數佔用庫存數
      LET l_psph026 = 0
      SELECT SUM(NVL(psph026,0)) INTO l_psph026
        FROM psph_t
       WHERE psphent = g_enterprise
         AND psphsite= l_psgb.psgbsite
         AND psph038 = p_psgb002
         AND psph039 = p_psgb003
         AND psph016 = 'I'
         AND psph019 BETWEEN p_psgb004 AND (p_psgb004+l_keep_day)
         AND psph001 IN (SELECT psfb004 FROM psfa_t,psfb_t
                          WHERE psfaent = psfbent
                            AND psfa001 = psfb001
                            AND psfaent = g_enterprise
                            AND psfa001 = g_psfa.psfa001
                            AND psfb003 = l_psgb.psgbsite)
      IF cl_null(l_psph026) THEN
         LET l_psph026 = 0
      END IF
         
      #c.計算日期庫存數
      #c.1第一天庫存數
      LET l_psgb005 = 0
      #2015/02/14 by stellar modify ----- (S)
#      SELECT psgb005 INTO l_psgb005
#        FROM psgb_t
#       WHERE psgbent = g_enterprise
#         AND psgb001 = g_psfa.psfa001
#         AND psgb002 = p_psgb002
#         AND psgb003 = p_psgb003
#         AND psgb004 = (SELECT MIN(psgb004) FROM psgb_t
#                         WHERE psgbent = g_enterprise
#                           AND psgb001 = g_psfa.psfa001
#                           AND psgb002 = p_psgb002
#                           AND psgb003 = p_psgb003
#                           AND psgbsite= l_psgb.psgbsite)
#         AND psgbsite= l_psgb.psgbsite
      SELECT SUM(psgb005) INTO l_psgb005
        FROM psgb_t
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgbsite= l_psgb.psgbsite
      #2015/02/14 by stellar modify ----- (E)
      IF cl_null(l_psgb005) THEN 
         LET l_psgb005 = 0
      END IF
      
      #c.2該日期以前的可供給量
      LET l_psph026_1 = 0
      SELECT SUM(NVL(psph026,0)) INTO l_psph026_1
        FROM psph_t,(SELECT psph001 a,MAX(psph002) b FROM psph_t WHERE psphent = g_enterprise AND psphsite = l_psgb.psgbsite GROUP BY psph001) 
       WHERE psphent = g_enterprise
         AND psphsite= l_psgb.psgbsite
         AND psph038 = p_psgb002
         AND psph039 = p_psgb003
         AND psph016 = 'I'
         AND psph019 < p_psgb004
         AND psph001 IN (SELECT psfb004 FROM psfa_t,psfb_t
                          WHERE psfaent = psfbent
                            AND psfa001 = psfb001
                            AND psfaent = g_enterprise
                            AND psfa001 = g_psfa.psfa001
                            AND psfb003 = l_psgb.psgbsite)
         AND psph001 = a
         AND psph002 = b
      IF cl_null(l_psph026_1) THEN
         LET l_psph026_1 = 0
      END IF
      
      #c.3該日期以前的建議撥出量
      LET l_psgb024 = 0
      SELECT SUM(psgb024) INTO l_psgb024
        FROM psgb_t
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 < p_psgb004
         AND psgbsite= l_psgb.psgbsite
      IF cl_null(l_psgb024) THEN
         LET l_psgb024 = 0
      END IF
      
      #計算日期庫存數=第一天庫存量-該日期以前的可供給量-該日期以前的建議撥出量
      LET l_storage_qty = l_psgb005 - l_psph026_1 - l_psgb024
      
      #d.可挪動的庫存數=計算日期庫存數-保留天數佔用庫存數
      LET l_psgb026 = l_storage_qty - l_psph026
      IF cl_null(l_psgb026) OR l_psgb026 < 0 THEN
         LET l_psgb026 = 0
      END IF
      
      #更新結存量、可挪動的庫存數
      UPDATE psgb_t SET psgb020 = l_psgb020,
                        psgb026 = l_psgb026
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 = p_psgb004
         AND psgbsite= l_psgb.psgbsite
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_errmsg('upd psgb','','',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: CREATE TEMP TABLE
# Memo...........:
# Usage..........: CALL apsp800_create_temptable()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/17 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_create_temptable()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE trf_site_temp01             #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
   CREATE TEMP TABLE trf_site_temp01(     #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
      order1         LIKE psfb_t.psfb002,
      site1          LIKE psfb_t.psfb003)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create trf_site_temp01'            #160727-00019#15 Mod   transfer_site_temp -->trf_site_temp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算建議採購量、建議生產量、預計結存量
# Memo...........:
# Usage..........: CALL apsp800_other_quantity(p_psgb002,p_psgb003,p_psgb004)
#                  RETURNING r_success
# Input parameter: p_psgb002      料件編號
#                : p_psgb003      產品特徵
#                : p_psgb004      日期
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_other_quantity(p_psgb002,p_psgb003,p_psgb004)
DEFINE p_psgb002         LIKE psgb_t.psgb002
DEFINE p_psgb003         LIKE psgb_t.psgb003
DEFINE p_psgb004         LIKE psgb_t.psgb004
DEFINE r_success         LIKE type_t.num5
DEFINE l_psgbsite        LIKE psgb_t.psgbsite
DEFINE l_psgb020         LIKE psgb_t.psgb020
DEFINE l_psgb021         LIKE psgb_t.psgb021
DEFINE l_psgb022         LIKE psgb_t.psgb022
DEFINE l_psgb023         LIKE psgb_t.psgb023
DEFINE l_psgb024         LIKE psgb_t.psgb024
DEFINE l_psgb025         LIKE psgb_t.psgb025
DEFINE l_quantity        LIKE psgb_t.psgb023
DEFINE l_imaf013         LIKE imaf_t.imaf013
DEFINE l_imaf145         LIKE imaf_t.imaf145
DEFINE l_imaf146         LIKE imaf_t.imaf146
DEFINE l_imae017         LIKE imae_t.imae017
DEFINE l_imae018         LIKE imae_t.imae018
DEFINE l_product         LIKE type_t.num5
DEFINE l_carry           LIKE type_t.num20_6

   LET r_success = TRUE
   
   DECLARE apsp800_other_quantity_cs CURSOR FOR
    SELECT psgbsite,psgb020,psgb024,psgb025
      FROM psgb_t
     WHERE psgbent = g_enterprise
       AND psgb001 = g_psfa.psfa001
       AND psgb002 = p_psgb002
       AND psgb003 = p_psgb003
       AND psgb004 = p_psgb004
   FOREACH apsp800_other_quantity_cs INTO l_psgbsite,l_psgb020,l_psgb024,l_psgb025
      #a.數量
      LET l_quantity = l_psgb020 - l_psgb024 + l_psgb025

      LET l_psgb021 = 0
      LET l_psgb022 = 0
      IF l_quantity < 0 THEN
         LET l_quantity = l_quantity * (-1)
         #補貨策略
         LET l_imaf013 = ''
         SELECT imaf013,imaf145,imaf146 
           INTO l_imaf013,l_imaf145,l_imaf146
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite= l_psgbsite
            AND imaf001 = p_psgb002

         IF STATUS = 100 THEN
            LET l_imaf013 = '1'
            LET l_imaf145 = '1'
            LET l_imaf146 = '1'
         END IF
            
         CASE 
            WHEN l_imaf013 = '1' OR l_imaf013 = '4'
                 #採購或無時，建議採購量=a.數量
                 #依採購批量、最小採購批量進位
                 CALL s_num_round('4',l_imaf146/l_imaf145,0)
                      RETURNING l_product
                 LET l_carry = l_imaf145 * l_product
                 CALL s_num_round('4',l_quantity/l_carry,0)
                      RETURNING l_product
                 LET l_psgb021 = l_carry * l_product
            WHEN l_imaf013 = '2' OR l_imaf013 = '3'
                 #自製或委外時，建議生產量=a.數量
                 #依生產批量、最小生產數量進位
                 SELECT imae017,imae018 
                   INTO l_imae017,l_imae018
                   FROM imae_t
                  WHERE imaeent = g_enterprise
                    AND imaesite= l_psgbsite
                    AND imae001 = p_psgb002
                 CALL s_num_round('4',l_imae018/l_imae017,0)
                      RETURNING l_product
                 LET l_carry = l_imae017 * l_product
                 CALL s_num_round('4',l_quantity/l_carry,0)
                      RETURNING l_product
                 LET l_psgb022 = l_carry * l_product
         END CASE
      END IF

      #預計結存量
      LET l_psgb023 = l_psgb020 - l_psgb024 + l_psgb025 + l_psgb021 + l_psgb022
      
      #更新建議採購量、建議生產量、預計結存量
      UPDATE psgb_t SET psgb021 = l_psgb021,
                        psgb022 = l_psgb022,
                        psgb023 = l_psgb023
       WHERE psgbent = g_enterprise
         AND psgb001 = g_psfa.psfa001
         AND psgb002 = p_psgb002
         AND psgb003 = p_psgb003
         AND psgb004 = p_psgb004
         AND psgbsite= l_psgbsite
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_errmsg('upd psgb023','','',SQLCA.sqlcode,1)
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 匯總資料到集團MRP匯總檔(psga_t)
# Memo...........:
# Usage..........: CALL apsp800_collect_psga(p_psgb002,p_psgb003,p_psgb004)
#                  RETURNING r_success
# Input parameter: p_psgb002      料件編號
#                : p_psgb003      產品特徵
#                : p_psgb004      日期
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/04/21 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_collect_psga(p_psgb002,p_psgb003,p_psgb004)
DEFINE p_psgb002         LIKE psgb_t.psgb002
DEFINE p_psgb003         LIKE psgb_t.psgb003
DEFINE p_psgb004         LIKE psgb_t.psgb004
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_psga            RECORD LIKE psga_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_psga           RECORD  #集團MRP匯總檔
       psgaent LIKE psga_t.psgaent, #企業編號
       psga001 LIKE psga_t.psga001, #集團MRP版本
       psga002 LIKE psga_t.psga002, #料件編號
       psga003 LIKE psga_t.psga003, #產品特徵
       psga004 LIKE psga_t.psga004, #日期
       psga005 LIKE psga_t.psga005, #+庫存量
       psga006 LIKE psga_t.psga006, #+替代量
       psga007 LIKE psga_t.psga007, #+請購量
       psga008 LIKE psga_t.psga008, #+採購量
       psga009 LIKE psga_t.psga009, #+在驗量
       psga010 LIKE psga_t.psga010, #+在製量
       psga011 LIKE psga_t.psga011, #+交期重排供給增加量
       psga012 LIKE psga_t.psga012, #+備料重排需求減少量
       psga013 LIKE psga_t.psga013, #-安全庫存量
       psga014 LIKE psga_t.psga014, #-訂單未交量
       psga015 LIKE psga_t.psga015, #-預測需求量
       psga016 LIKE psga_t.psga016, #-工單備料量
       psga017 LIKE psga_t.psga017, #-計畫備料量
       psga018 LIKE psga_t.psga018, #-交期重排減少量
       psga019 LIKE psga_t.psga019, #-備料重排增加量
       psga020 LIKE psga_t.psga020, #結存量
       psga021 LIKE psga_t.psga021, #+建議採購量
       psga022 LIKE psga_t.psga022, #+建議生產量
       psga023 LIKE psga_t.psga023, #預計結存量
       psga024 LIKE psga_t.psga024  #建議調撥量
          END RECORD
#mod--161109-00085#17 By 08993--(e)

   LET r_success = TRUE
   
   INITIALIZE l_psga.* TO NULL
   LET l_psga.psgaent = g_enterprise
   LET l_psga.psga001 = g_psfa.psfa001
   LET l_psga.psga002 = p_psgb002
   LET l_psga.psga003 = p_psgb003
   LET l_psga.psga004 = p_psgb004
   
   SELECT SUM(psgb005),SUM(psgb006),SUM(psgb007),SUM(psgb008),SUM(psgb009),
          SUM(psgb010),SUM(psgb011),SUM(psgb012),SUM(psgb013),SUM(psgb014),
          SUM(psgb015),SUM(psgb016),SUM(psgb017),SUM(psgb018),SUM(psgb019),
          SUM(psgb020),SUM(psgb021),SUM(psgb022),SUM(psgb023),SUM(psgb025)
     INTO l_psga.psga005,l_psga.psga006,l_psga.psga007,l_psga.psga008,l_psga.psga009,
          l_psga.psga010,l_psga.psga011,l_psga.psga012,l_psga.psga013,l_psga.psga014,
          l_psga.psga015,l_psga.psga016,l_psga.psga017,l_psga.psga018,l_psga.psga019,
          l_psga.psga020,l_psga.psga021,l_psga.psga022,l_psga.psga023,l_psga.psga024
     FROM psgb_t
    WHERE psgbent = g_enterprise
      AND psgb001 = g_psfa.psfa001
      AND psgb002 = p_psgb002
      AND psgb003 = p_psgb003
      AND psgb004 = p_psgb004
     
   INSERT INTO psga_t(psgaent,psga001,psga002,psga003,psga004,psga005,psga006,psga007,
                      psga008,psga009,psga010,psga011,psga012,psga013,psga014,psga015,
                      psga016,psga017,psga018,psga019,psga020,psga021,psga022,psga023,
                      psga024)
      VALUES(l_psga.psgaent,l_psga.psga001,l_psga.psga002,l_psga.psga003,
             l_psga.psga004,l_psga.psga005,l_psga.psga006,l_psga.psga007,
             l_psga.psga008,l_psga.psga009,l_psga.psga010,l_psga.psga011,
             l_psga.psga012,l_psga.psga013,l_psga.psga014,l_psga.psga015,
             l_psga.psga016,l_psga.psga017,l_psga.psga018,l_psga.psga019,
             l_psga.psga020,l_psga.psga021,l_psga.psga022,l_psga.psga023,
             l_psga.psga024)
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      CALL cl_errmsg('ins psga_t','','',SQLCA.sqlcode,1)
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 判斷每個日期各site是否皆有一筆資料，沒有的話則新增一筆
# Memo...........:
# Usage..........: CALL apsp800_ins_psgb_1()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/02/14 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp800_ins_psgb_1()
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#17 By 08993--(s)
#DEFINE l_psgb      RECORD LIKE psgb_t.*   #mark--161109-00085#17 By 08993--(s)
DEFINE l_psgb      RECORD  #集團MRP明細檔
       psgbent LIKE psgb_t.psgbent, #企業編號
       psgb001 LIKE psgb_t.psgb001, #集團MRP版本
       psgb002 LIKE psgb_t.psgb002, #料件編號
       psgb003 LIKE psgb_t.psgb003, #產品特徵
       psgb004 LIKE psgb_t.psgb004, #日期
       psgbsite LIKE psgb_t.psgbsite, #營運據點
       psgb005 LIKE psgb_t.psgb005, #+庫存量
       psgb006 LIKE psgb_t.psgb006, #+替代量
       psgb007 LIKE psgb_t.psgb007, #+請購量
       psgb008 LIKE psgb_t.psgb008, #+採購量
       psgb009 LIKE psgb_t.psgb009, #+在驗量
       psgb010 LIKE psgb_t.psgb010, #+在製量
       psgb011 LIKE psgb_t.psgb011, #+交期重排供給增加量
       psgb012 LIKE psgb_t.psgb012, #+備料重排需求減少量
       psgb013 LIKE psgb_t.psgb013, #-安全庫存量
       psgb014 LIKE psgb_t.psgb014, #-訂單未交量
       psgb015 LIKE psgb_t.psgb015, #-預測需求量
       psgb016 LIKE psgb_t.psgb016, #-工單備料量
       psgb017 LIKE psgb_t.psgb017, #-計畫備料量
       psgb018 LIKE psgb_t.psgb018, #-交期重排減少量
       psgb019 LIKE psgb_t.psgb019, #-備料重排增加量
       psgb020 LIKE psgb_t.psgb020, #結存量
       psgb021 LIKE psgb_t.psgb021, #+建議採購量
       psgb022 LIKE psgb_t.psgb022, #+建議生產量
       psgb023 LIKE psgb_t.psgb023, #預計結存量
       psgb024 LIKE psgb_t.psgb024, #-建議撥出量
       psgb025 LIKE psgb_t.psgb025, #+建議撥入量
       psgb026 LIKE psgb_t.psgb026, #+可挪動庫存量
       psgb027 LIKE psgb_t.psgb027, #已轉請採購
       psgb028 LIKE psgb_t.psgb028, #已轉工單
       psgbud001 LIKE psgb_t.psgbud001, #自定義欄位(文字)001
       psgbud002 LIKE psgb_t.psgbud002, #自定義欄位(文字)002
       psgbud003 LIKE psgb_t.psgbud003, #自定義欄位(文字)003
       psgbud004 LIKE psgb_t.psgbud004, #自定義欄位(文字)004
       psgbud005 LIKE psgb_t.psgbud005, #自定義欄位(文字)005
       psgbud006 LIKE psgb_t.psgbud006, #自定義欄位(文字)006
       psgbud007 LIKE psgb_t.psgbud007, #自定義欄位(文字)007
       psgbud008 LIKE psgb_t.psgbud008, #自定義欄位(文字)008
       psgbud009 LIKE psgb_t.psgbud009, #自定義欄位(文字)009
       psgbud010 LIKE psgb_t.psgbud010, #自定義欄位(文字)010
       psgbud011 LIKE psgb_t.psgbud011, #自定義欄位(數字)011
       psgbud012 LIKE psgb_t.psgbud012, #自定義欄位(數字)012
       psgbud013 LIKE psgb_t.psgbud013, #自定義欄位(數字)013
       psgbud014 LIKE psgb_t.psgbud014, #自定義欄位(數字)014
       psgbud015 LIKE psgb_t.psgbud015, #自定義欄位(數字)015
       psgbud016 LIKE psgb_t.psgbud016, #自定義欄位(數字)016
       psgbud017 LIKE psgb_t.psgbud017, #自定義欄位(數字)017
       psgbud018 LIKE psgb_t.psgbud018, #自定義欄位(數字)018
       psgbud019 LIKE psgb_t.psgbud019, #自定義欄位(數字)019
       psgbud020 LIKE psgb_t.psgbud020, #自定義欄位(數字)020
       psgbud021 LIKE psgb_t.psgbud021, #自定義欄位(日期時間)021
       psgbud022 LIKE psgb_t.psgbud022, #自定義欄位(日期時間)022
       psgbud023 LIKE psgb_t.psgbud023, #自定義欄位(日期時間)023
       psgbud024 LIKE psgb_t.psgbud024, #自定義欄位(日期時間)024
       psgbud025 LIKE psgb_t.psgbud025, #自定義欄位(日期時間)025
       psgbud026 LIKE psgb_t.psgbud026, #自定義欄位(日期時間)026
       psgbud027 LIKE psgb_t.psgbud027, #自定義欄位(日期時間)027
       psgbud028 LIKE psgb_t.psgbud028, #自定義欄位(日期時間)028
       psgbud029 LIKE psgb_t.psgbud029, #自定義欄位(日期時間)029
       psgbud030 LIKE psgb_t.psgbud030, #自定義欄位(日期時間)030
       psgb029 LIKE psgb_t.psgb029  #No Use
               END RECORD
#mod--161109-00085#17 By 08993--(e)
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_psfb            DYNAMIC ARRAY OF RECORD
         psfb003         LIKE psfb_t.psfb003
                         END RECORD
DEFINE l_psgb002         LIKE psgb_t.psgb002
DEFINE l_psgb003         LIKE psgb_t.psgb003
DEFINE l_psgb004         LIKE psgb_t.psgb004 
#160512-00016#10 20160525 add by ming -----(S) 
DEFINE l_psgb029         LIKE psgb_t.psgb029 
#160512-00016#10 20160525 add by ming -----(E) 

   LET r_success = TRUE
   
   #MRP版本的各site
   DECLARE apsp800_ins_psgb_1_cs1 CURSOR FOR
    SELECT psfb003 FROM psfb_t
     WHERE psfbent = g_enterprise
       AND psfb001 = g_psfa.psfa001
       
   LET l_cnt = 1
   #161109-00085#17-s mod
#   FOREACH apsp800_ins_psgb_1_cs1 INTO l_psfb[l_cnt].*   #161109-00085#17-s mark
   FOREACH apsp800_ins_psgb_1_cs1 INTO l_psfb[l_cnt].psfb003
   #161109-00085#17-e mod
   
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   CALL l_psfb.deleteElement(l_psfb.getLength())
   
   #該MRP版本下，料號+產品特徵+日期判斷MRP版本內的每個site是否都有
   DECLARE apsp800_ins_psgb_1_cs CURSOR FOR
    SELECT DISTINCT psgb002,psgb003,psgb004,psgb029   #160512-00016#10 20160525 add psgb029 by ming 
      FROM psgb_t
     WHERE psgbent = g_enterprise
       AND psgb001 = g_psfa.psfa001
       
   FOREACH apsp800_ins_psgb_1_cs INTO l_psgb002,l_psgb003,l_psgb004,l_psgb029  #160512-00016#10 20160525 add l_psgb029 by ming  
   
      INITIALIZE l_psgb.* TO NULL
      LET l_psgb.psgbent = g_enterprise
      LET l_psgb.psgb001 = g_psfa.psfa001
      LET l_psgb.psgb002 = l_psgb002
      LET l_psgb.psgb003 = l_psgb003
      LET l_psgb.psgb004 = l_psgb004
      LET l_psgb.psgb005 = 0
      LET l_psgb.psgb006 = 0
      LET l_psgb.psgb007 = 0
      LET l_psgb.psgb008 = 0
      LET l_psgb.psgb009 = 0
      LET l_psgb.psgb010 = 0
      LET l_psgb.psgb011 = 0
      LET l_psgb.psgb012 = 0
      LET l_psgb.psgb013 = 0
      LET l_psgb.psgb014 = 0
      LET l_psgb.psgb015 = 0
      LET l_psgb.psgb016 = 0
      LET l_psgb.psgb017 = 0
      LET l_psgb.psgb018 = 0
      LET l_psgb.psgb019 = 0
      LET l_psgb.psgb020 = 0
      LET l_psgb.psgb021 = 0
      LET l_psgb.psgb022 = 0
      LET l_psgb.psgb023 = 0
      LET l_psgb.psgb024 = 0
      LET l_psgb.psgb025 = 0
      LET l_psgb.psgb026 = 0      #160711-00013#1 mod 'N'->0
      LET l_psgb.psgb027 = 'N' 
      LET l_psgb.psgb028 = 'N'    #160711-00013#1 add

      #160512-00016#10 20160525 add by ming -----(S) 
      LET l_psgb.psgb029 = l_psgb029 
      #160512-00016#10 20160525 add by ming -----(E) 
      
      FOR l_i = 1 TO l_psfb.getLength()
         IF cl_null(l_psfb[l_i].psfb003) THEN
            CONTINUE FOR
         END IF
         
         #判斷此據點是否已有該料號+產品特徵+日期的資料了
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM psgb_t
          WHERE psgbent = g_enterprise
            AND psgb001 = g_psfa.psfa001
            AND psgb002 = l_psgb002
            AND psgb003 = l_psgb003
            AND psgb004 = l_psgb004
            AND psgbsite= l_psfb[l_i].psfb003 
#            AND psgb029 = l_psgb029     #160512-00016#10 20160525 add by ming  #160711-00013#1-mark
         IF cl_null(l_cnt) OR l_cnt <= 0 THEN
            #若沒有，則新增一筆資料進去
            LET l_psgb.psgbsite = l_psfb[l_i].psfb003
            
            #mod--161109-00085#17 By 08993--(s)
#            INSERT INTO psgb_t VALUES (l_psgb.*)   #mark--161109-00085#17 By 08993--(s)
            INSERT INTO psgb_t (psgbent,psgb001,psgb002,psgb003,psgb004,psgbsite,psgb005,psgb006,psgb007,psgb008,
                                psgb009,psgb010,psgb011,psgb012,psgb013,psgb014,psgb015,psgb016,psgb017,psgb018,
                                psgb019,psgb020,psgb021,psgb022,psgb023,psgb024,psgb025,psgb026,psgb027,psgb028,
                                psgbud001,psgbud002,psgbud003,psgbud004,psgbud005,psgbud006,psgbud007,psgbud008,
                                psgbud009,psgbud010,psgbud011,psgbud012,psgbud013,psgbud014,psgbud015,psgbud016,
                                psgbud017,psgbud018,psgbud019,psgbud020,psgbud021,psgbud022,psgbud023,psgbud024,
                                psgbud025,psgbud026,psgbud027,psgbud028,psgbud029,psgbud030,psgb029)
                        VALUES (l_psgb.psgbent,l_psgb.psgb001,l_psgb.psgb002,l_psgb.psgb003,l_psgb.psgb004,
                                l_psgb.psgbsite,l_psgb.psgb005,l_psgb.psgb006,l_psgb.psgb007,l_psgb.psgb008,
                                l_psgb.psgb009,l_psgb.psgb010,l_psgb.psgb011,l_psgb.psgb012,l_psgb.psgb013,
                                l_psgb.psgb014,l_psgb.psgb015,l_psgb.psgb016,l_psgb.psgb017,l_psgb.psgb018,
                                l_psgb.psgb019,l_psgb.psgb020,l_psgb.psgb021,l_psgb.psgb022,l_psgb.psgb023,
                                l_psgb.psgb024,l_psgb.psgb025,l_psgb.psgb026,l_psgb.psgb027,l_psgb.psgb028,
                                l_psgb.psgbud001,l_psgb.psgbud002,l_psgb.psgbud003,l_psgb.psgbud004,l_psgb.psgbud005,
                                l_psgb.psgbud006,l_psgb.psgbud007,l_psgb.psgbud008,l_psgb.psgbud009,l_psgb.psgbud010,
                                l_psgb.psgbud011,l_psgb.psgbud012,l_psgb.psgbud013,l_psgb.psgbud014,l_psgb.psgbud015,
                                l_psgb.psgbud016,l_psgb.psgbud017,l_psgb.psgbud018,l_psgb.psgbud019,l_psgb.psgbud020,
                                l_psgb.psgbud021,l_psgb.psgbud022,l_psgb.psgbud023,l_psgb.psgbud024,l_psgb.psgbud025,
                                l_psgb.psgbud026,l_psgb.psgbud027,l_psgb.psgbud028,l_psgb.psgbud029,l_psgb.psgbud030,l_psgb.psgb029)
            #mod--161109-00085#17 By 08993--(e)
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
               LET r_success = FALSE
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'INS psgb_t'
               LET g_errparam.popup = TRUE
               
               CALL cl_err()
               EXIT FOR
            END IF
         END IF
      END FOR
      
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
