#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-02-19 15:21:22), PR版次:0004(2016-12-15 11:49:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: aisp520
#+ Description: 電子發票匯出作業-財政部
#+ Creator....: 05016(2016-02-03 14:41:39)
#+ Modifier...: 05016 -SD/PR- 08732
 
{</section>}
 
{<section id="aisp520.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160516-00011#2  2016/05/16  By Hans  若目地資料夾不存在則建立該目錄
#161104-00024#10 2016/11/08  By 08171 程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
#161108-00017#6  2016/11/10  By 08171 程式中INSERT時不可以用*的寫法，要一個一個欄位定義
#161208-00026#17 2016/12/15  By 08732 SUB_程式中DEFINE / INSERT INTO 有星號整批調整(針對SELECT *的部份)
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
      isaa001          LIKE isaa_t.isaa001,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       isaa001 LIKE type_t.chr10, 
   isaa001_desc LIKE type_t.chr80, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE   g_path_C0401           STRING
DEFINE   g_path_C0501           STRING
DEFINE   g_path_C0701           STRING
DEFINE   g_path_D0401           STRING
DEFINE   g_path_D0501           STRING

DEFINE   g_path_A0401           STRING
DEFINE   g_path_A0501           STRING
DEFINE   g_path_B0401           STRING

DEFINE   g_path_A0101           STRING
DEFINE   g_path_A0201           STRING
DEFINE   g_path_B0101           STRING

DEFINE   g_path                 STRING

DEFINE g_isaa002 LIKE isaa_t.isaa002
DEFINE g_isaa003 LIKE isaa_t.isaa003
DEFINE g_isaa031 LIKE isaa_t.isaa031

#DEFINE g_isat        DYNAMIC ARRAY OF RECORD LIKE isat_t.* #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE g_isat DYNAMIC ARRAY OF RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE g_idx         LIKE type_t.num5
DEFINE g_doc_old     LIKE type_t.chr100
DEFINE g_filename    LIKE isat_t.isat209
DEFINE g_ooefl006    LIKE ooefl_t.ooefl006
DEFINE g_ooef002     LIKE ooef_t.ooef002
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp520.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisp520_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp520 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp520_init()
 
      #進入選單 Menu (="N")
      CALL aisp520_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp520
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp520.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp520_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_path        STRING   
   DEFINE l_str         STRING
   DEFINE l_cmd         STRING #160516-00011#2
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
   
   # 檢查檔案存放目錄是否存在
   LET g_path = os.Path.join(os.Path.join(FGL_GETENV("TEMPDIR"),"eInvoice"),"UpCast")              
   LET g_path_C0401 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2CSTORAGE"),"C0401"),"SRC")  
   LET g_path_C0501 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2CSTORAGE"),"C0501"),"SRC")  
   LET g_path_C0701 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2CSTORAGE"),"C0701"),"SRC")  
   LET g_path_D0401 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2CSTORAGE"),"D0401"),"SRC")  
   LET g_path_D0501 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2CSTORAGE"),"D0501"),"SRC")  
   LET g_path_A0401 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BSTORAGE"),"A0401"),"SRC")  
   LET g_path_A0501 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BSTORAGE"),"A0501"),"SRC")  
   LET g_path_B0401 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BSTORAGE"),"B0401"),"SRC")  
   LET g_path_A0101 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BEXCHANGE"),"A0101"),"SRC") 
   LET g_path_A0201 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BEXCHANGE"),"A0201"),"SRC") 
   LET g_path_B0101 = os.Path.join(os.Path.join(os.Path.join(g_path,"B2BEXCHANGE"),"B0101"),"SRC")
   FOR l_i = 1 TO 11                                 
       CASE l_i
          WHEN 1   LET l_path = g_path_C0401
          WHEN 2   LET l_path = g_path_C0501
          WHEN 3   LET l_path = g_path_C0701
          WHEN 4   LET l_path = g_path_D0401
          WHEN 5   LET l_path = g_path_D0501
          WHEN 6   LET l_path = g_path_A0401
          WHEN 7   LET l_path = g_path_A0501
          WHEN 8   LET l_path = g_path_B0401
          WHEN 9   LET l_path = g_path_A0101
          WHEN 10  LET l_path = g_path_A0201
          WHEN 11  LET l_path = g_path_B0101
      END CASE
      IF NOT os.Path.exists(l_path) THEN
          #160516-00011#2 ---s---
          LET l_cmd = "cd tmp  " 
          RUN l_cmd
          CASE l_i
             WHEN 1
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2CSTORAGE/C0401/SRC"                              
             WHEN 2 
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2CSTORAGE/C0501/SRC" 
             WHEN 3    
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2CSTORAGE/C0701/SRC"  
             WHEN 4
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2CSTORAGE/D0401/SRC"  
             WHEN 5
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2CSTORAGE/D0501/SRC"  
             WHEN 6
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BSTORAGE/A0401/SRC"  
             WHEN 7
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BSTORAGE/A0501/SRC"  
             WHEN 8
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BSTORAGE/B0401/SRC"  
             WHEN 9
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BEXCHANGE/A0101/SRC"
             WHEN 10
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BEXCHANGE/A0201/SRC" 
             WHEN 11
                LET l_cmd = "mkdir -p eInvoice/UpCast/B2BEXCHANGE/B0101/SRC"                 
          END CASE          
          RUN l_cmd        
          #LET l_str = l_str CLIPPED,"\n",l_path
          #160516-00011#2 ---e---
       END IF
   END FOR
   IF NOT cl_null(l_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-02917'
      LET g_errparam.extend =  l_str
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      EXIT PROGRAM
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp520_ui_dialog()
 
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
         INPUT BY NAME g_master.isaa001 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa001
            
            #add-point:AFTER FIELD isaa001 name="input.a.isaa001"
            IF NOT cl_null(g_master.isaa001) THEN 
               CALL aisp520_isaa001_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN               
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.isaa001 = ''
                  LET g_master.isaa001_desc = ''
                  DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc
               END IF
               CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc               
               DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc
               SELECT ooefl006 INTO g_ooefl006 
                 FROM ooefl_t 
                WHERE ooeflent = g_enterprise AND ooefl001 = g_master.isaa001
                  AND ooefl002 = g_dlang      
               SELECT ooef002 INTO g_ooef002 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.isaa001                  
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa001
            #add-point:ON ACTION controlp INFIELD isaa001 name="input.c.isaa001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_isaa001()                   
            LET g_master.isaa001  = g_qryparam.return1 
            CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc            
            DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc             
            NEXT FIELD isaa001                          
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
            CALL aisp520_get_buffer(l_dialog)
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
         CALL aisp520_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.isaa001 = g_master.isaa001
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
                 CALL aisp520_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp520_transfer_argv(ls_js)
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
 
{<section id="aisp520.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp520_transfer_argv(ls_js)
 
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
 
{<section id="aisp520.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp520_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql STRING
   DEFINE l_tot_cnt          LIKE type_t.num5 
   DEFINE l_suc_cnt          LIKE type_t.num5 
   DEFINE l_err_cnt          LIKE type_t.num5    
   DEFINE l_C0401_tot_cnt    LIKE type_t.num5   
   DEFINE l_C0401_suc_cnt    LIKE type_t.num5  
   DEFINE l_C0401_err_cnt    LIKE type_t.num5  
   DEFINE l_C0501_tot_cnt    LIKE type_t.num5  
   DEFINE l_C0501_suc_cnt    LIKE type_t.num5  
   DEFINE l_C0501_err_cnt    LIKE type_t.num5  
   DEFINE l_C0701_tot_cnt    LIKE type_t.num5  
   DEFINE l_C0701_suc_cnt    LIKE type_t.num5  
   DEFINE l_C0701_err_cnt    LIKE type_t.num5  
   DEFINE l_D0401_tot_cnt    LIKE type_t.num5  
   DEFINE l_D0401_suc_cnt    LIKE type_t.num5  
   DEFINE l_D0401_err_cnt    LIKE type_t.num5  
   DEFINE l_D0501_tot_cnt    LIKE type_t.num5  
   DEFINE l_D0501_suc_cnt    LIKE type_t.num5  
   DEFINE l_D0501_err_cnt    LIKE type_t.num5   
   DEFINE l_A0101_tot_cnt    LIKE type_t.num5   
   DEFINE l_A0101_suc_cnt    LIKE type_t.num5  
   DEFINE l_A0101_err_cnt    LIKE type_t.num5 
   DEFINE l_A0401_tot_cnt    LIKE type_t.num5   
   DEFINE l_A0401_suc_cnt    LIKE type_t.num5  
   DEFINE l_A0401_err_cnt    LIKE type_t.num5 
   DEFINE l_A0201_tot_cnt    LIKE type_t.num5   
   DEFINE l_A0201_suc_cnt    LIKE type_t.num5  
   DEFINE l_A0201_err_cnt    LIKE type_t.num5 
   DEFINE l_A0501_tot_cnt    LIKE type_t.num5   
   DEFINE l_A0501_suc_cnt    LIKE type_t.num5  
   DEFINE l_A0501_err_cnt    LIKE type_t.num5 
   DEFINE l_B0101_tot_cnt    LIKE type_t.num5   
   DEFINE l_B0101_suc_cnt    LIKE type_t.num5  
   DEFINE l_B0101_err_cnt    LIKE type_t.num5 
   DEFINE l_B0401_tot_cnt    LIKE type_t.num5   
   DEFINE l_B0401_suc_cnt    LIKE type_t.num5  
   DEFINE l_B0401_err_cnt    LIKE type_t.num5

   DEFINE l_t                LIKE type_t.num5
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_k                LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.chr1
   DEFINE l_isat026          LIKE isat_t.isat026
   DEFINE l_isat014          LIKE isat_t.isat014
   DEFINE l_isat008          CHAR(6)
   DEFINE l_str              STRING
   DEFINE l_str_act          base.StringTokenizer 
   DEFINE l_str_temp         STRING
   DEFINE l_filename         STRING
   DEFINE l_type             LIKE type_t.chr30
   DEFINE l_mesg             STRING
   DEFINE l_cmd1             STRING
   DEFINE l_suc_cnt_str  LIKE type_t.chr100
   DEFINE l_err_cnt_str  LIKE type_t.chr100
   DEFINE l_tot_cnt_str  LIKE type_t.chr100
   DEFINE l_cnt_str      LIKE type_t.chr100
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp520_process_cs CURSOR FROM ls_sql
#  FOREACH aisp520_process_cs INTO
   #add-point:process段process name="process.process"
    
   LET l_tot_cnt = 0
   LET l_suc_cnt = 0
   LET l_err_cnt = 0
   LET l_C0401_tot_cnt = 0
   LET l_C0401_suc_cnt = 0
   LET l_C0401_err_cnt = 0
   LET l_C0501_tot_cnt = 0
   LET l_C0501_suc_cnt = 0
   LET l_C0501_err_cnt = 0
   LET l_C0701_tot_cnt = 0
   LET l_C0701_suc_cnt = 0
   LET l_C0701_err_cnt = 0
   LET l_D0401_tot_cnt = 0
   LET l_D0401_suc_cnt = 0
   LET l_D0401_err_cnt = 0
   LET l_D0501_tot_cnt = 0
   LET l_D0501_suc_cnt = 0
   LET l_D0501_err_cnt = 0
   LET l_A0101_tot_cnt = 0
   LET l_A0101_suc_cnt = 0
   LET l_A0101_err_cnt = 0
   LET l_A0401_tot_cnt = 0
   LET l_A0401_suc_cnt = 0
   LET l_A0401_err_cnt = 0
   LET l_A0201_tot_cnt = 0
   LET l_A0201_suc_cnt = 0
   LET l_A0201_err_cnt = 0
   LET l_A0501_tot_cnt = 0
   LET l_A0501_suc_cnt = 0
   LET l_A0501_err_cnt = 0
   LET l_B0101_tot_cnt = 0
   LET l_B0101_suc_cnt = 0
   LET l_B0101_err_cnt = 0
   LET l_B0401_tot_cnt = 0
   LET l_B0401_suc_cnt = 0
   LET l_B0401_err_cnt = 0
   
   
   
   SELECT isaa002,isaa031,isaa003 
      INTO g_isaa002,g_isaa031,g_isaa003
      FROM isaa_t
     WHERE isaaent = g_enterprise AND isaa001 = g_master.isaa001
   
   FOR l_t = 1 TO 3  #發票使用類型
      IF l_t = 1 THEN LET l_isat026 = '1' END IF
      IF l_t = 2 THEN LET l_isat026 = '2' END IF
      IF l_t = 3 THEN LET l_isat026 = '6' END IF
      FOR l_k = 1 TO 2                    #銷項發票與銷項發票(折讓)要分開處理，因為資料處理方式不同
         LET l_flag = 'Y'
         IF l_k = 1 THEN 
            LET l_isat014 = '11' 
         ELSE
            LET l_isat014 = '21' #折讓
         END IF        
         CALL aisp520_get_isat(l_isat014,l_isat026)
         FOR l_i = 1 TO g_idx
            LET l_mesg = "" 
            IF l_isat014 = '11' THEN
               #若同一發票號碼匯出失敗，往下同一發票號碼的不繼續匯出，以避免後續錯誤
               IF l_i = 1 THEN
                  LET g_doc_old = g_isat[l_i].isat004
               END IF
               IF g_doc_old = g_isat[l_i].isat004 AND l_flag = 'N' THEN
                  CONTINUE FOR
               ELSE 
                  LET l_flag = 'Y'
                  LET g_doc_old = g_isat[l_i].isat004 
               END IF
            ELSE
               #若同一折讓單號匯出失敗，往下同一折讓單號的不繼續匯出，以避免後續錯誤
               LET g_doc_old = g_isat[l_i].isatdocno
               IF g_doc_old = g_isat[l_i].isatdocno AND l_flag = 'N' THEN
                  CONTINUE FOR
               ELSE
                  LET l_flag = 'Y' 
                  LET g_doc_old = g_isat[l_i].isatdocno
               END IF
            END IF                         
            LET l_tot_cnt = l_tot_cnt + 1
            # 轉換時間格式，將:去除
            LET l_str = g_isat[l_i].isat008
            LET l_str = l_str.subString(12,19)
            LET l_str_act = base.StringTokenizer.create(l_str CLIPPED,":")
            LET l_isat008 = null
            WHILE l_str_act.hasMoreTokens()
               LET l_str_temp = l_str_act.nextToken()
               LET l_isat008 = l_isat008 CLIPPED,l_str_temp.trim()
            END WHILE
            # xml格式：
            # 銷項發票：訊息類型+門店代號+發票號碼+發票日期時間+發票歷程項次
            #           ex:C0401-TWA1-UP09790561-20130906153025-00001.xml
            # 銷項發票(折讓)：訊息類型+門店代號+折讓單號+折讓日期時間+第一筆發票的歷程項次
            #                 ex:D0401-TWA1-VN1-07040001-20130906000000-00001.xml
            
            IF g_isat[l_i].isat025 = '11' THEN
               LET l_filename = g_isat[l_i].isatsite CLIPPED,'-',g_isat[l_i].isat004,'-',
                                g_isat[l_i].isat007 USING 'YYYYMMDD',l_isat008 CLIPPED,'-',
                                g_isat[l_i].isatseq USING '&&&&&'
            ELSE
               LET l_filename = g_isat[l_i].isatsite CLIPPED,'-',g_isat[l_i].isatdocno,'-',
                                g_isat[l_i].isat007 USING 'YYYYMMDD',l_isat008 CLIPPED,'-',
                                g_isat[l_i].isatseq USING '&&&&&'
            END IF
            
            CASE g_isat[l_i].isat025  #發票最終狀態     
               WHEN 11  #發票開立
                  CASE                   
                     WHEN g_isat[l_i].isat026 = '1'    # B2B交換發票
                          LET l_A0101_tot_cnt = l_A0101_tot_cnt + 1
                          LET l_type = 'A0101'
                          LET g_filename = 'A0101','-',l_filename CLIPPED
                     WHEN g_isat[l_i].isat026 = '2'    # B2B存證發票
                          LET l_A0401_tot_cnt = l_A0401_tot_cnt + 1
                          LET l_type = 'A0401'
                          LET g_filename = 'A0401','-',l_filename CLIPPED
                     WHEN g_isat[l_i].isat026 = '6'    # B2C發票   
                        LET l_C0401_tot_cnt = l_C0401_tot_cnt + 1
                        LET l_type = 'C0401'
                        LET g_filename = 'C0401','-',l_filename CLIPPED
                  END CASE 
                  # 檢核必填欄位是否都有值
                  CALL aisp520_chk_field(l_type,g_isat[l_i].*) RETURNING g_sub_success,l_mesg 
                  IF g_sub_success THEN   # 匯出實體xml檔
                     CALL aisp520_xml_C0401(g_filename,g_isat[l_i].*) RETURNING g_sub_success
                  END IF                               
                WHEN 21 #折讓開立
                   CASE 
                      WHEN g_isat[l_i].isat026 = '1'    # B2B交換發票
                           LET l_B0101_tot_cnt = l_B0101_tot_cnt + 1
                           LET l_type = 'B0101'
                           LET g_filename = 'B0101','-',l_filename CLIPPED
                      WHEN g_isat[l_i].isat026 = '2'    # B2B存證發票
                           LET l_B0401_tot_cnt = l_B0401_tot_cnt + 1
                           LET l_type = 'B0401'
                           LET g_filename = 'B0401','-',l_filename CLIPPED
                      WHEN g_isat[l_i].isat026 = '6'    # B2C發票   
                         LET l_D0401_tot_cnt = l_D0401_tot_cnt + 1
                         LET l_type = 'D0401'
                         LET g_filename = 'D0401','-',l_filename CLIPPED
                   END CASE     
                   # 檢核必填欄位是否都有值
                   CALL aisp520_chk_field(l_type,g_isat[l_i].*) RETURNING g_sub_success,l_mesg 
                   IF g_sub_success THEN
                      # 匯出實體xml檔
                      CALL aisp520_xml_D0401(g_filename,g_isat[l_i].*) RETURNING g_sub_success 
                   END IF                                                     
               WHEN 12 #發票作廢
                  CASE
                     WHEN g_isat[l_i].isat026 = '1'        # B2B交換發票
                        LET l_A0201_tot_cnt = l_A0201_tot_cnt + 1
                        LET l_type = 'A0201'
                        LET g_filename = 'A0201','-',l_filename CLIPPED
                     WHEN g_isat[l_i].isat026  = '2'        # B2B存證發票
                        LET l_A0501_tot_cnt = l_A0501_tot_cnt + 1
                        LET l_type = 'A0501'
                        LET g_filename = 'A0501','-',l_filename CLIPPED
                     WHEN g_isat[l_i].isat026  = '6'        # B2C發票    
                        LET l_C0501_tot_cnt = l_C0501_tot_cnt + 1
                        LET l_type = 'C0501'
                        LET g_filename = 'C0501','-',l_filename CLIPPED
                  END CASE           
                  # 檢核必填欄位是否都有值
                  CALL aisp520_chk_field(l_type,g_isat[l_i].*) RETURNING g_sub_success,l_mesg
                  IF g_sub_success THEN
                     # 匯出實體xml檔
                     CALL aisp520_xml_C0501(g_filename,g_isat[l_i].*) RETURNING g_sub_success     
                  END IF   
                  
               WHEN '22'  #折讓作廢             
                  LET l_D0501_tot_cnt = l_D0501_tot_cnt + 1
                  LET l_type = 'D0501'
                  LET g_filename = 'D0501','-',l_filename CLIPPED
                  # 檢核必填欄位是否都有值
                  CALL aisp520_chk_field(l_type,g_isat[l_i].*) RETURNING g_sub_success,l_mesg
                  IF g_sub_success THEN 
                     # 匯出實體xml檔
                     CALL aisp520_xml_D0501(g_filename,g_isat[l_i].*) RETURNING g_sub_success     
                  END IF                       
               WHEN '23' #發票註銷       
                  LET l_C0701_tot_cnt = l_C0701_tot_cnt + 1
                  LET l_type = 'C0701'
                  LET g_filename = 'C0701','-',l_filename CLIPPED                  
                  # 檢核必填欄位是否都有值
                  CALL aisp520_chk_field(l_type,g_isat[l_i].*) RETURNING g_sub_success,l_mesg 
                  IF g_sub_success THEN
                     # 匯出實體xml檔
                     CALL aisp520_xml_C0701(g_filename,g_isat[l_i].*) RETURNING g_sub_success     
                  END IF                       
            END CASE
            IF NOT g_sub_success  THEN  #表示失敗
               LET l_cmd1 = 'rm '||g_path||'/'||g_filename||'.xml > /dev/null'
               RUN l_cmd1
            END IF
            
            IF g_sub_success THEN
               CALL s_transaction_begin()            
               UPDATE isat_t SET isat209 = g_filename,
                                 isat208 = '2'
                WHERE isatent = g_enterprise
                  AND isatdocno = g_isat[l_i].isatdocno      
                  AND isatseq = g_isat[l_i].isatseq
                  AND isat004 = g_isat[l_i].isat004 
               IF SQLCA.sqlcode THEN
                  CALL s_transaction_end('N','0')
                  LET l_mesg = "Update omea_file status error. The errorcode:",SQLCA.SQLCODE
                  LET g_sub_success = FALSE
                  LET l_flag = 'N'
                  LET l_err_cnt = l_err_cnt + 1
                  UPDATE isat_t SET isat209 = '',
                                 isat208 = '1'
                   WHERE isatent = g_enterprise
                     AND isatdocno = g_isat[l_i].isatdocno      
                     AND isatseq = g_isat[l_i].isatseq
                     AND isat004 = g_isat[l_i].isat004 
               ELSE
                  CALL s_transaction_end('Y','0')
                  LET l_mesg = "Export ",l_type," xml file success." 
                  LET l_flag = 'Y' 
                  LET l_suc_cnt = l_suc_cnt + 1
               END IF
            ELSE
               LET l_mesg = "Export ",l_type," xml file Fail. ",l_mesg
               LET l_err_cnt = l_err_cnt + 1
               LET l_flag = 'N'
               LET g_sub_success = FALSE
               UPDATE isat_t SET isat209 = '',
                                isat208 = '1'
                  WHERE isatent = g_enterprise
                    AND isatdocno = g_isat[l_i].isatdocno      
                    AND isatseq = g_isat[l_i].isatseq
                    AND isat004 = g_isat[l_i].isat004 
            END IF
            # 寫入log檔
            CALL aisp520_ins_isav(g_sub_success,l_type,g_isat[l_i].isatsite,g_isat[l_i].isat004,
                                  g_isat[l_i].isat007,g_isat[l_i].isat008,g_filename,l_mesg)  
            # 計算錯誤及成功筆數
            CASE
               WHEN l_type = 'C0401'
                  IF l_flag = 'Y' THEN
                     LET l_C0401_suc_cnt = l_C0401_suc_cnt + 1
                  ELSE
                     LET l_C0401_err_cnt = l_C0401_err_cnt + 1
                  END IF
               WHEN l_type = 'C0501'
                  IF l_flag = 'Y' THEN
                     LET l_C0501_suc_cnt = l_C0501_suc_cnt + 1
                  ELSE
                     LET l_C0501_err_cnt = l_C0501_err_cnt + 1
                  END IF
               WHEN l_type = 'C0701'
                  IF l_flag = 'Y' THEN
                     LET l_C0701_suc_cnt = l_C0701_suc_cnt + 1
                  ELSE
                     LET l_C0701_err_cnt = l_C0701_err_cnt + 1
                  END IF
               WHEN l_type = 'D0401'
                  IF l_flag = 'Y' THEN
                     LET l_D0401_suc_cnt = l_D0401_suc_cnt + 1
                  ELSE
                     LET l_D0401_err_cnt = l_D0401_err_cnt + 1
                  END IF
               WHEN l_type = 'D0501'
                  IF l_flag = 'Y' THEN
                     LET l_D0501_suc_cnt = l_D0501_suc_cnt + 1
                  ELSE
                     LET l_D0501_err_cnt = l_D0501_err_cnt + 1
                  END IF
               WHEN l_type = 'A0101'
                  IF l_flag = 'Y' THEN
                     LET l_A0101_suc_cnt = l_A0101_suc_cnt + 1
                  ELSE
                     LET l_A0101_err_cnt = l_A0101_err_cnt + 1
                  END IF
               WHEN l_type = 'A0401'
                  IF l_flag = 'Y' THEN
                     LET l_A0401_suc_cnt = l_A0401_suc_cnt + 1
                  ELSE
                     LET l_A0401_err_cnt = l_A0401_err_cnt + 1
                  END IF
               WHEN l_type = 'A0201'
                  IF l_flag = 'Y' THEN
                     LET l_A0201_suc_cnt = l_A0201_suc_cnt + 1
                  ELSE
                     LET l_A0201_err_cnt = l_A0201_err_cnt + 1
                  END IF
               WHEN l_type = 'A0501'
                  IF l_flag = 'Y' THEN
                     LET l_A0501_suc_cnt = l_A0501_suc_cnt + 1
                  ELSE
                     LET l_A0501_err_cnt = l_A0501_err_cnt + 1
                  END IF
               WHEN l_type = 'B0101'
                  IF l_flag = 'Y' THEN
                     LET l_B0101_suc_cnt = l_B0101_suc_cnt + 1
                  ELSE
                     LET l_B0101_err_cnt = l_B0101_err_cnt + 1
                  END IF
               WHEN l_type = 'B0401'
                  IF l_flag = 'Y' THEN
                     LET l_B0401_suc_cnt = l_B0401_suc_cnt + 1
                  ELSE
                     LET l_B0401_err_cnt = l_B0401_err_cnt + 1
                  END IF
            END CASE 
         END FOR               
      END FOR
   END FOR
   IF l_tot_cnt > 0 AND g_bgjob = 'N' THEN
   SELECT gzzd005 INTO l_suc_cnt_str FROM gzzd_t WHERE gzzd003 = 'lbl_suc_cnt' AND gzzd002 = g_dlang AND gzzd001 = 'aisp520'
   SELECT gzzd005 INTO l_err_cnt_str FROM gzzd_t WHERE gzzd003 = 'lbl_err_cnt' AND gzzd002 = g_dlang AND gzzd001 = 'aisp520'
   SELECT gzzd005 INTO l_tot_cnt_str FROM gzzd_t WHERE gzzd003 = 'lbl_tot_cnt' AND gzzd002 = g_dlang AND gzzd001 = 'aisp520'
   SELECT gzzd005 INTO l_cnt_str FROM gzzd_t WHERE gzzd003 = 'lbl_cnt' AND gzzd002 = g_dlang AND gzzd001 = 'aisp520'
      LET l_str = cl_getmsg("ais-00287",g_dlang),"\n",          
         'A0101'||l_tot_cnt_str||l_A0101_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_A0101_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_A0101_err_cnt||l_cnt_str,"\n",
         'A0201'||l_tot_cnt_str||l_A0201_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_A0201_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_A0201_err_cnt||l_cnt_str,"\n",
         'A0401'||l_tot_cnt_str||l_A0401_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_A0401_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_A0401_err_cnt||l_cnt_str,"\n",
         'A0501'||l_tot_cnt_str||l_A0501_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_A0501_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_A0501_err_cnt||l_cnt_str,"\n",
         'B0101'||l_tot_cnt_str||l_B0101_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_B0101_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_B0101_err_cnt||l_cnt_str,"\n",
         'B0401'||l_tot_cnt_str||l_B0401_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_B0401_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_B0401_err_cnt||l_cnt_str,"\n",
         'C0401'||l_tot_cnt_str||l_C0401_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_C0401_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_C0401_err_cnt||l_cnt_str,"\n",
         'C0501'||l_tot_cnt_str||l_C0501_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_C0501_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_C0501_err_cnt||l_cnt_str,"\n",
         'C0701'||l_tot_cnt_str||l_C0701_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_C0701_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_C0701_err_cnt||l_cnt_str,"\n",
         'D0401'||l_tot_cnt_str||l_D0401_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_D0401_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_D0401_err_cnt||l_cnt_str,"\n",
         'D0501'||l_tot_cnt_str||l_D0501_tot_cnt||l_cnt_str||'，'||l_suc_cnt_str||l_D0501_suc_cnt||l_cnt_str||'，'||l_err_cnt_str||l_D0501_err_cnt||l_cnt_str
    CALL cl_ask_confirm3('',l_str)
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
   CALL aisp520_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp520.get_buffer" >}
PRIVATE FUNCTION aisp520_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.isaa001 = p_dialog.getFieldBuffer('isaa001')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp520.msgcentre_notify" >}
PRIVATE FUNCTION aisp520_msgcentre_notify()
 
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
 
{<section id="aisp520.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 檢查申報單位是否存在
# Memo...........:
# Usage..........: CALL aisp520_isaa001_chk()
# Date & Author..: 2016/02/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_isaa001_chk()
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_isaastus   LIKE isaa_t.isaastus


   LET r_success = TRUE
   
   
   SELECT isaastus INTO l_isaastus
     FROM isaa_t 
    WHERE isaaent = g_enterprise
      AND isaa001 = g_master.isaa001
   
   CASE 
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno  = 'ais-00119'
         RETURN r_success,r_errno
      WHEN l_isaastus <> 'Y'
         LET r_success = FALSE
         LET r_errno  = 'ais-00120'
         RETURN r_success,r_errno
   END CASE
   
   RETURN r_success,r_errno

END FUNCTION

################################################################################
# Descriptions...: 取得發票資料
# Memo...........:
# Usage..........: CALL aisp520_get_isat(p_isat014,p_isat026)
# Date & Author..: 2016/02/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_get_isat(p_isat014,p_isat026)
DEFINE p_isat014     LIKE isat_t.isat014 #是否折讓
DEFINE p_isat026     LIKE isat_t.isat026 #發票使用類型
DEFINE l_isatdocno   LIKE isat_t.isatdocno
DEFINE l_count       LIKE type_t.num5
DEFINE l_sql  STRING

   CALL g_isat.clear()   
   
   CALL s_transaction_begin()
   UPDATE isat_t
      SET isat208 = 3 #電子發票匯出狀態
    WHERE isatent = g_enterprise AND isat002 = 'Y' #電子發票否
      AND isat014 = p_isat014 AND isat026 = p_isat026
      AND isatsite IN (SELECT ooef001 FROM ooef_t 
                        WHERE ooef001 = isatsite 
                          AND ooefent = g_enterprise AND ooef017 = g_master.isaa001)
      AND isat002 = 'Y' 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.SQLCODE
      LET g_errparam.extend =  'Update isat_t'
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')   
   END IF
   
   LET g_idx = 1
   
   IF p_isat014 = '11' THEN #非折讓
      #LET l_sql = "   SELECT * FROM isat_t ",   #161208-00026#17   mark
      #161208-00026#17   add---s
      LET l_sql ="    SELECT isatent,isatcomp,isatdocno,isatseq,isat001,
                             isat002,isat003,isat004,isat005,isat006,
                             isat007,isat008,isat009,isat010,isat011,
                             isat012,isat013,isat014,isat015,isat016,
                             isat017,isat018,isat019,isat020,isat021,
                             isat022,isat023,isat024,isat100,isat101,
                             isat103,isat104,isat105,isat106,isat107,
                             isat113,isat114,isat115,isat201,isat202,
                             isat203,isat204,isat205,isat206,isat207,
                             isat208,isat209,isatud001,isatud002,isatud003,
                             isatud004,isatud005,isatud006,isatud007,isatud008,
                             isatud009,isatud010,isatud011,isatud012,isatud013,
                             isatud014,isatud015,isatud016,isatud017,isatud018,
                             isatud019,isatud020,isatud021,isatud022,isatud023,
                             isatud024,isatud025,isatud026,isatud027,isatud028,
                             isatud029,isatud030,isatsite,isatdocdt,isat025,
                             isat026,isat027,isat028,isat029,isat108,
                             isat118
                        FROM isat_t ",
      #161208-00026#17   add---e
                  "    WHERE isatent = '",g_enterprise,"' AND isat014 = '",p_isat014,"'    ",
                  "      AND isat208 = '3' AND isat026 = '",p_isat026,"' AND isat002 = 'Y' ",
                  "      AND isatsite IN (SELECT ooef001 FROM ooef_t                       ",
                  "                        WHERE ooef001 = isatsite                        ",
                  "                          AND ooefent = '",g_enterprise,"' AND ooef017 = '",g_master.isaa001,"') ",
                  "    ORDER BY isatdocno    "
      PREPARE aisp520_isat_prep01 FROM l_sql
      DECLARE aisp520_isat_curs01 CURSOR FOR aisp520_isat_prep01
      #FOREACH aisp520_isat_curs01 INTO g_isat[g_idx].*   #161208-00026#17   mark
      #161208-00026#17   add---s
      FOREACH aisp520_isat_curs01 
         INTO g_isat[g_idx].isatent,g_isat[g_idx].isatcomp,g_isat[g_idx].isatdocno,g_isat[g_idx].isatseq,g_isat[g_idx].isat001,
              g_isat[g_idx].isat002,g_isat[g_idx].isat003,g_isat[g_idx].isat004,g_isat[g_idx].isat005,g_isat[g_idx].isat006,
              g_isat[g_idx].isat007,g_isat[g_idx].isat008,g_isat[g_idx].isat009,g_isat[g_idx].isat010,g_isat[g_idx].isat011,
              g_isat[g_idx].isat012,g_isat[g_idx].isat013,g_isat[g_idx].isat014,g_isat[g_idx].isat015,g_isat[g_idx].isat016,
              g_isat[g_idx].isat017,g_isat[g_idx].isat018,g_isat[g_idx].isat019,g_isat[g_idx].isat020,g_isat[g_idx].isat021,
              g_isat[g_idx].isat022,g_isat[g_idx].isat023,g_isat[g_idx].isat024,g_isat[g_idx].isat100,g_isat[g_idx].isat101,
              g_isat[g_idx].isat103,g_isat[g_idx].isat104,g_isat[g_idx].isat105,g_isat[g_idx].isat106,g_isat[g_idx].isat107,
              g_isat[g_idx].isat113,g_isat[g_idx].isat114,g_isat[g_idx].isat115,g_isat[g_idx].isat201,g_isat[g_idx].isat202,
              g_isat[g_idx].isat203,g_isat[g_idx].isat204,g_isat[g_idx].isat205,g_isat[g_idx].isat206,g_isat[g_idx].isat207,
              g_isat[g_idx].isat208,g_isat[g_idx].isat209,g_isat[g_idx].isatud001,g_isat[g_idx].isatud002,g_isat[g_idx].isatud003,
              g_isat[g_idx].isatud004,g_isat[g_idx].isatud005,g_isat[g_idx].isatud006,g_isat[g_idx].isatud007,g_isat[g_idx].isatud008,
              g_isat[g_idx].isatud009,g_isat[g_idx].isatud010,g_isat[g_idx].isatud011,g_isat[g_idx].isatud012,g_isat[g_idx].isatud013,
              g_isat[g_idx].isatud014,g_isat[g_idx].isatud015,g_isat[g_idx].isatud016,g_isat[g_idx].isatud017,g_isat[g_idx].isatud018,
              g_isat[g_idx].isatud019,g_isat[g_idx].isatud020,g_isat[g_idx].isatud021,g_isat[g_idx].isatud022,g_isat[g_idx].isatud023,
              g_isat[g_idx].isatud024,g_isat[g_idx].isatud025,g_isat[g_idx].isatud026,g_isat[g_idx].isatud027,g_isat[g_idx].isatud028,
              g_isat[g_idx].isatud029,g_isat[g_idx].isatud030,g_isat[g_idx].isatsite,g_isat[g_idx].isatdocdt,g_isat[g_idx].isat025,
              g_isat[g_idx].isat026,g_isat[g_idx].isat027,g_isat[g_idx].isat028,g_isat[g_idx].isat029,g_isat[g_idx].isat108,
              g_isat[g_idx].isat118
      #161208-00026#17   add---e
         LET l_count = 0      
         SELECT COUNT(*) INTO l_count FROM isat_t
          WHERE isatent = g_enterprise AND isatdocno = g_isat[g_idx].isatdocno
            AND isat004 = g_isat[g_idx].isat004 AND isat014 = '12' #作廢
         IF l_count > 0 THEN         
            UPDATE isat_t  SET isat208 = 1
             WHERE isatent = g_enterprise 
               AND isatdocno = g_isat[g_idx].isatdocno 
               AND isat004 = g_isat[g_idx].isat004 AND isat014 = '11'
               
            UPDATE isat_t  SET isat208 = 3
             WHERE isatent = g_enterprise 
               AND isatdocno = g_isat[g_idx].isatdocno
               AND isat004 = g_isat[g_idx].isat004 AND isat014 = '12'
               
           #LET l_sql ="  SELECT * FROM isat_t ",   #161208-00026#17   mark
           #161208-00026#17   add---s
           LET l_sql =" SELECT isatent,isatcomp,isatdocno,isatseq,isat001,
                               isat002,isat003,isat004,isat005,isat006,
                               isat007,isat008,isat009,isat010,isat011,
                               isat012,isat013,isat014,isat015,isat016,
                               isat017,isat018,isat019,isat020,isat021,
                               isat022,isat023,isat024,isat100,isat101,
                               isat103,isat104,isat105,isat106,isat107,
                               isat113,isat114,isat115,isat201,isat202,
                               isat203,isat204,isat205,isat206,isat207,
                               isat208,isat209,isatud001,isatud002,isatud003,
                               isatud004,isatud005,isatud006,isatud007,isatud008,
                               isatud009,isatud010,isatud011,isatud012,isatud013,
                               isatud014,isatud015,isatud016,isatud017,isatud018,
                               isatud019,isatud020,isatud021,isatud022,isatud023,
                               isatud024,isatud025,isatud026,isatud027,isatud028,
                               isatud029,isatud030,isatsite,isatdocdt,isat025,
                               isat026,isat027,isat028,isat029,isat108,
                               isat118
                          FROM isat_t ",
           #161208-00026#17   add---e
                      "  WHERE isatent = '",g_enterprise,"' AND isat004 = '",g_isat[g_idx].isat004,"' AND isat014 = '12' "
           PREPARE aisp520_ins_prep01 FROM l_sql
           #EXECUTE aisp520_ins_prep01 INTO g_isat[g_idx].*   #161208-00026#17   mark
           #161208-00026#17   add---s
           EXECUTE aisp520_ins_prep01 
              INTO g_isat[g_idx].isatent,g_isat[g_idx].isatcomp,g_isat[g_idx].isatdocno,g_isat[g_idx].isatseq,g_isat[g_idx].isat001,
                   g_isat[g_idx].isat002,g_isat[g_idx].isat003,g_isat[g_idx].isat004,g_isat[g_idx].isat005,g_isat[g_idx].isat006,
                   g_isat[g_idx].isat007,g_isat[g_idx].isat008,g_isat[g_idx].isat009,g_isat[g_idx].isat010,g_isat[g_idx].isat011,
                   g_isat[g_idx].isat012,g_isat[g_idx].isat013,g_isat[g_idx].isat014,g_isat[g_idx].isat015,g_isat[g_idx].isat016,
                   g_isat[g_idx].isat017,g_isat[g_idx].isat018,g_isat[g_idx].isat019,g_isat[g_idx].isat020,g_isat[g_idx].isat021,
                   g_isat[g_idx].isat022,g_isat[g_idx].isat023,g_isat[g_idx].isat024,g_isat[g_idx].isat100,g_isat[g_idx].isat101,
                   g_isat[g_idx].isat103,g_isat[g_idx].isat104,g_isat[g_idx].isat105,g_isat[g_idx].isat106,g_isat[g_idx].isat107,
                   g_isat[g_idx].isat113,g_isat[g_idx].isat114,g_isat[g_idx].isat115,g_isat[g_idx].isat201,g_isat[g_idx].isat202,
                   g_isat[g_idx].isat203,g_isat[g_idx].isat204,g_isat[g_idx].isat205,g_isat[g_idx].isat206,g_isat[g_idx].isat207,
                   g_isat[g_idx].isat208,g_isat[g_idx].isat209,g_isat[g_idx].isatud001,g_isat[g_idx].isatud002,g_isat[g_idx].isatud003,
                   g_isat[g_idx].isatud004,g_isat[g_idx].isatud005,g_isat[g_idx].isatud006,g_isat[g_idx].isatud007,g_isat[g_idx].isatud008,
                   g_isat[g_idx].isatud009,g_isat[g_idx].isatud010,g_isat[g_idx].isatud011,g_isat[g_idx].isatud012,g_isat[g_idx].isatud013,
                   g_isat[g_idx].isatud014,g_isat[g_idx].isatud015,g_isat[g_idx].isatud016,g_isat[g_idx].isatud017,g_isat[g_idx].isatud018,
                   g_isat[g_idx].isatud019,g_isat[g_idx].isatud020,g_isat[g_idx].isatud021,g_isat[g_idx].isatud022,g_isat[g_idx].isatud023,
                   g_isat[g_idx].isatud024,g_isat[g_idx].isatud025,g_isat[g_idx].isatud026,g_isat[g_idx].isatud027,g_isat[g_idx].isatud028,
                   g_isat[g_idx].isatud029,g_isat[g_idx].isatud030,g_isat[g_idx].isatsite,g_isat[g_idx].isatdocdt,g_isat[g_idx].isat025,
                   g_isat[g_idx].isat026,g_isat[g_idx].isat027,g_isat[g_idx].isat028,g_isat[g_idx].isat029,g_isat[g_idx].isat108,
                   g_isat[g_idx].isat118
           #161208-00026#17   add---e
         END IF
         
         LET g_idx = g_idx + 1            
      END FOREACH      
      CALL g_isat.deleteElement(g_idx)
      LET g_idx = g_idx - 1
   ELSE
      #若是銷項發票aist310可能會有多張發票，因此要先取出折讓單號，再依折讓單號取出第一筆發票資料當代表
      LET l_sql = "   SELECT DISTINCT isatdocno FROM isat_t ", 
                  "    WHERE isatent = '",g_enterprise,"' AND isat014 = '",p_isat014,"'    ",
                  "      AND isat208 = '3' AND isat026 = '",p_isat026,"'                   ",
                  "      AND isatsite IN (SELECT ooef001 FROM ooef_t                       ",
                  "                        WHERE ooef001 = isatsite                        ",
                  "                          AND ooefent = '",g_enterprise,"' AND ooef017 = '",g_master.isaa001,"') ",
                  "    ORDER BY isatdocno   "
      PREPARE aisp520_isat_prep02 FROM l_sql
      DECLARE aisp520_isat_curs02 CURSOR FOR aisp520_isat_prep02
      FOREACH aisp520_isat_curs02 INTO l_isatdocno
          #LET l_sql = "   SELECT * FROM isat_t ",   #161208-00026#17   mark
          #161208-00026#17   add---s
          LET l_sql ="    SELECT isatent,isatcomp,isatdocno,isatseq,isat001,
                                 isat002,isat003,isat004,isat005,isat006,
                                 isat007,isat008,isat009,isat010,isat011,
                                 isat012,isat013,isat014,isat015,isat016,
                                 isat017,isat018,isat019,isat020,isat021,
                                 isat022,isat023,isat024,isat100,isat101,
                                 isat103,isat104,isat105,isat106,isat107,
                                 isat113,isat114,isat115,isat201,isat202,
                                 isat203,isat204,isat205,isat206,isat207,
                                 isat208,isat209,isatud001,isatud002,isatud003,
                                 isatud004,isatud005,isatud006,isatud007,isatud008,
                                 isatud009,isatud010,isatud011,isatud012,isatud013,
                                 isatud014,isatud015,isatud016,isatud017,isatud018,
                                 isatud019,isatud020,isatud021,isatud022,isatud023,
                                 isatud024,isatud025,isatud026,isatud027,isatud028,
                                 isatud029,isatud030,isatsite,isatdocdt,isat025,
                                 isat026,isat027,isat028,isat029,isat108,
                                 isat118
                            FROM isat_t ",
          #161208-00026#17   add---e
                      "    WHERE isatent = '",g_enterprise,"' AND isat014 = '",p_isat014,"'    ",
                      "      AND isat208 = '3' AND isat026 = '",p_isat026,"' AND isat002 = 'Y' ",
                      "      AND isatsite IN (SELECT ooef001 FROM ooef_t                       ",
                      "                        WHERE ooef001 = isatsite                        ",
                      "                          AND ooefent = '",g_enterprise,"' AND ooef017 = '",g_master.isaa001,"') ",
                      "      AND isatdocno = '",l_isatdocno,"'                                 ",
                      "    ORDER BY isatdocno   "
          PREPARE aisp520_isat_prep03 FROM l_sql
          DECLARE aisp520_isat_curs03 CURSOR FOR aisp520_isat_prep03
          #FOREACH aisp520_isat_curs03 INTO g_isat[g_idx].*   #161208-00026#17   mark
          #161208-00026#17   add---s
          FOREACH aisp520_isat_curs03 
             INTO g_isat[g_idx].isatent,g_isat[g_idx].isatcomp,g_isat[g_idx].isatdocno,g_isat[g_idx].isatseq,g_isat[g_idx].isat001,
                  g_isat[g_idx].isat002,g_isat[g_idx].isat003,g_isat[g_idx].isat004,g_isat[g_idx].isat005,g_isat[g_idx].isat006,
                  g_isat[g_idx].isat007,g_isat[g_idx].isat008,g_isat[g_idx].isat009,g_isat[g_idx].isat010,g_isat[g_idx].isat011,
                  g_isat[g_idx].isat012,g_isat[g_idx].isat013,g_isat[g_idx].isat014,g_isat[g_idx].isat015,g_isat[g_idx].isat016,
                  g_isat[g_idx].isat017,g_isat[g_idx].isat018,g_isat[g_idx].isat019,g_isat[g_idx].isat020,g_isat[g_idx].isat021,
                  g_isat[g_idx].isat022,g_isat[g_idx].isat023,g_isat[g_idx].isat024,g_isat[g_idx].isat100,g_isat[g_idx].isat101,
                  g_isat[g_idx].isat103,g_isat[g_idx].isat104,g_isat[g_idx].isat105,g_isat[g_idx].isat106,g_isat[g_idx].isat107,
                  g_isat[g_idx].isat113,g_isat[g_idx].isat114,g_isat[g_idx].isat115,g_isat[g_idx].isat201,g_isat[g_idx].isat202,
                  g_isat[g_idx].isat203,g_isat[g_idx].isat204,g_isat[g_idx].isat205,g_isat[g_idx].isat206,g_isat[g_idx].isat207,
                  g_isat[g_idx].isat208,g_isat[g_idx].isat209,g_isat[g_idx].isatud001,g_isat[g_idx].isatud002,g_isat[g_idx].isatud003,
                  g_isat[g_idx].isatud004,g_isat[g_idx].isatud005,g_isat[g_idx].isatud006,g_isat[g_idx].isatud007,g_isat[g_idx].isatud008,
                  g_isat[g_idx].isatud009,g_isat[g_idx].isatud010,g_isat[g_idx].isatud011,g_isat[g_idx].isatud012,g_isat[g_idx].isatud013,
                  g_isat[g_idx].isatud014,g_isat[g_idx].isatud015,g_isat[g_idx].isatud016,g_isat[g_idx].isatud017,g_isat[g_idx].isatud018,
                  g_isat[g_idx].isatud019,g_isat[g_idx].isatud020,g_isat[g_idx].isatud021,g_isat[g_idx].isatud022,g_isat[g_idx].isatud023,
                  g_isat[g_idx].isatud024,g_isat[g_idx].isatud025,g_isat[g_idx].isatud026,g_isat[g_idx].isatud027,g_isat[g_idx].isatud028,
                  g_isat[g_idx].isatud029,g_isat[g_idx].isatud030,g_isat[g_idx].isatsite,g_isat[g_idx].isatdocdt,g_isat[g_idx].isat025,
                  g_isat[g_idx].isat026,g_isat[g_idx].isat027,g_isat[g_idx].isat028,g_isat[g_idx].isat029,g_isat[g_idx].isat108,
                  g_isat[g_idx].isat118
          #161208-00026#17   add---e
             LET l_count = 0
             SELECT COUNT(*) INTO l_count FROM isat_t
              WHERE isatent = g_enterprise AND isatdocno = g_isat[g_idx].isatdocno
                AND isat004 = g_isat[g_idx].isat004 AND isat014 = '22' #作廢
             IF l_count > 0 THEN         
                UPDATE isat_t  SET isat208 = 1
                 WHERE isatent = g_enterprise 
                   AND isatdocno = g_isat[g_idx].isatdocno 
                   AND isat004 = g_isat[g_idx].isat004 AND isat014 = '21'
                   
                UPDATE isat_t  SET isat208 = 3
                 WHERE isatent = g_enterprise 
                   AND isatdocno = g_isat[g_idx].isatdocno
                   AND isat004 = g_isat[g_idx].isat004 AND isat014 = '22'
                   
               #LET l_sql ="  SELECT * FROM isat_t ",   #161208-00026#17   mark
               #161208-00026#17   add---s
               LET l_sql =" SELECT isatent,isatcomp,isatdocno,isatseq,isat001,
                                   isat002,isat003,isat004,isat005,isat006,
                                   isat007,isat008,isat009,isat010,isat011,
                                   isat012,isat013,isat014,isat015,isat016,
                                   isat017,isat018,isat019,isat020,isat021,
                                   isat022,isat023,isat024,isat100,isat101,
                                   isat103,isat104,isat105,isat106,isat107,
                                   isat113,isat114,isat115,isat201,isat202,
                                   isat203,isat204,isat205,isat206,isat207,
                                   isat208,isat209,isatud001,isatud002,isatud003,
                                   isatud004,isatud005,isatud006,isatud007,isatud008,
                                   isatud009,isatud010,isatud011,isatud012,isatud013,
                                   isatud014,isatud015,isatud016,isatud017,isatud018,
                                   isatud019,isatud020,isatud021,isatud022,isatud023,
                                   isatud024,isatud025,isatud026,isatud027,isatud028,
                                   isatud029,isatud030,isatsite,isatdocdt,isat025,
                                   isat026,isat027,isat028,isat029,isat108,
                                   isat118
                              FROM isat_t ",
               #161208-00026#17   add---e
                          "  WHERE isatent = '",g_enterprise,"' AND isat004 = '",g_isat[g_idx].isat004,"' AND isat014 = '22' "
               PREPARE aisp520_ins_prep02 FROM l_sql
               #EXECUTE aisp520_ins_prep02 INTO g_isat[g_idx].*   #161208-00026#17   mark
               #161208-00026#17   add---s
               EXECUTE aisp520_ins_prep02 
                  INTO g_isat[g_idx].isatent,g_isat[g_idx].isatcomp,g_isat[g_idx].isatdocno,g_isat[g_idx].isatseq,g_isat[g_idx].isat001,
                       g_isat[g_idx].isat002,g_isat[g_idx].isat003,g_isat[g_idx].isat004,g_isat[g_idx].isat005,g_isat[g_idx].isat006,
                       g_isat[g_idx].isat007,g_isat[g_idx].isat008,g_isat[g_idx].isat009,g_isat[g_idx].isat010,g_isat[g_idx].isat011,
                       g_isat[g_idx].isat012,g_isat[g_idx].isat013,g_isat[g_idx].isat014,g_isat[g_idx].isat015,g_isat[g_idx].isat016,
                       g_isat[g_idx].isat017,g_isat[g_idx].isat018,g_isat[g_idx].isat019,g_isat[g_idx].isat020,g_isat[g_idx].isat021,
                       g_isat[g_idx].isat022,g_isat[g_idx].isat023,g_isat[g_idx].isat024,g_isat[g_idx].isat100,g_isat[g_idx].isat101,
                       g_isat[g_idx].isat103,g_isat[g_idx].isat104,g_isat[g_idx].isat105,g_isat[g_idx].isat106,g_isat[g_idx].isat107,
                       g_isat[g_idx].isat113,g_isat[g_idx].isat114,g_isat[g_idx].isat115,g_isat[g_idx].isat201,g_isat[g_idx].isat202,
                       g_isat[g_idx].isat203,g_isat[g_idx].isat204,g_isat[g_idx].isat205,g_isat[g_idx].isat206,g_isat[g_idx].isat207,
                       g_isat[g_idx].isat208,g_isat[g_idx].isat209,g_isat[g_idx].isatud001,g_isat[g_idx].isatud002,g_isat[g_idx].isatud003,
                       g_isat[g_idx].isatud004,g_isat[g_idx].isatud005,g_isat[g_idx].isatud006,g_isat[g_idx].isatud007,g_isat[g_idx].isatud008,
                       g_isat[g_idx].isatud009,g_isat[g_idx].isatud010,g_isat[g_idx].isatud011,g_isat[g_idx].isatud012,g_isat[g_idx].isatud013,
                       g_isat[g_idx].isatud014,g_isat[g_idx].isatud015,g_isat[g_idx].isatud016,g_isat[g_idx].isatud017,g_isat[g_idx].isatud018,
                       g_isat[g_idx].isatud019,g_isat[g_idx].isatud020,g_isat[g_idx].isatud021,g_isat[g_idx].isatud022,g_isat[g_idx].isatud023,
                       g_isat[g_idx].isatud024,g_isat[g_idx].isatud025,g_isat[g_idx].isatud026,g_isat[g_idx].isatud027,g_isat[g_idx].isatud028,
                       g_isat[g_idx].isatud029,g_isat[g_idx].isatud030,g_isat[g_idx].isatsite,g_isat[g_idx].isatdocdt,g_isat[g_idx].isat025,
                       g_isat[g_idx].isat026,g_isat[g_idx].isat027,g_isat[g_idx].isat028,g_isat[g_idx].isat029,g_isat[g_idx].isat108,
                       g_isat[g_idx].isat118
               #161208-00026#17   add---e
             END IF
             EXIT FOREACH        
          END FOREACH
          LET g_idx = g_idx + 1          
      END FOREACH
      CALL g_isat.deleteElement(g_idx)
      LET g_idx = g_idx - 1
   END IF     
    
END FUNCTION

################################################################################
# Descriptions...: 欄位資訊檢核
# Memo...........:
# Usage..........: CALL aisp520_chk_field(p_type,p_isat)
# Date & Author..: 2015/02/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_chk_field(p_type,p_isat)
DEFINE p_type LIKE type_t.chr30
#DEFINE p_isat RECORD LIKE isat_t.* #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE r_success LIKE type_t.num5
DEFINE r_mesg    STRING 
DEFINE l_isah RECORD
   isahseq  LIKE isah_t.isahseq,
   isah004  LIKE isah_t.isah004,
   isah005  LIKE isah_t.isah005,
   isah006  LIKE isah_t.isah006,
   isah007  LIKE isah_t.isah007,
   isah101  LIKE isah_t.isah101,
   isah113  LIKE isah_t.isah113,
   isah114  LIKE isah_t.isah114,
   isah115  LIKE isah_t.isah115
    END RECORD
    
   LET r_success = TRUE LET r_mesg = ''
   
   CASE 
      WHEN p_type = "A0101" OR p_type = "A0401" OR p_type = "C0401" # 開立
         IF cl_null(p_isat.isat004) THEN # 發票號碼
            LET r_success = 'N'
            LET r_mesg =  " Type:",p_type CLIPPED," Reason:InvoiceNumber(isat004) is null."
            RETURN r_success,r_mesg
         END IF
         
         IF cl_null(p_isat.isat007) THEN # 發票號碼
            LET r_success = 'N'
            LET r_mesg =  " Type:",p_type CLIPPED," Reason:InvoiceDate(isat007) is null."
            RETURN r_success,r_mesg
         END IF
        
         IF cl_null(p_isat.isat012) THEN # 統一編號(賣方)
            LET r_success = 'N'
            LET r_mesg =  " Type:",p_type CLIPPED," Reason:Identifier(isat012) is null."
            RETURN r_success,r_mesg
         END IF
         
         IF cl_null(p_isat.isat005) THEN # 發票類別
            LET r_success = 'N'
            LET r_mesg =  " Type:",p_type CLIPPED," Reason:InvoiceType(isat005) is null."
            RETURN r_success,r_mesg
         END IF
         
         IF cl_null(p_isat.isat021) THEN # 紙本電子發票已列印註記
            LET r_success = 'N'
            LET r_mesg =  " Type:",p_type CLIPPED," Reason:PrintMark(isat021) is null."
            RETURN r_success,r_mesg
         END IF
         
         IF cl_null(p_isat.isat006) THEN    # 發票防偽隨機碼
            LET r_success = 'N'
            LET r_mesg = " Type:",p_type CLIPPED," Reason:RandoNumber(isat006) is null."
            RETURN r_success,r_mesg
         END IF
         
         # 明細資料
         LET g_sql = " SELECT isahseq,isah004,isah006,isah101,isah115 ",
                     "   FROM isah_t ",
                     "  WHERE isahent = '",g_enterprise,"'    ",
                     "    AND isahdocno = '",p_isat.isatdocno,"'  "
          
         PREPARE aisp520_getisah_prep01 FROM g_sql
         DECLARE aisp520_getisah_curs01 CURSOR FOR aisp520_getisah_prep01
         FOREACH aisp520_getisah_curs01 INTO l_isah.isahseq,l_isah.isah004,l_isah.isah006,l_isah.isah101,l_isah.isah115
            IF cl_null(l_isah.isahseq) THEN        # 明細排列序號
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:SequenceNumber(isahseq) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah004) THEN        # 品名
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Description(ogb06) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah006) THEN        # 數量
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Quantity(isah006) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah115) THEN        # 明細排列序號
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Amount(isah115) is null."
               RETURN r_success,r_mesg
            END IF                           
            IF cl_null(l_isah.isah101) THEN        # 單價
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Amount(isah101) is null."
               RETURN r_success,r_mesg
            END IF             
         END FOREACH
         
         
         # 彙總資料
         IF cl_null(p_isat.isat201) THEN # 應稅銷售額合計(新台幣)
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:SalesAmount(isat201) is null."
            RETURN r_success,r_mesg
         END IF  
         IF cl_null(p_isat.isat203) THEN # 免稅銷售額合計(新台幣)
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:FreeTaxSalesAmount(isat203) is null."
            RETURN r_success,r_mesg
         END IF 
         IF cl_null(p_isat.isat202) THEN # 零稅率銷售額合計(新台幣)
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:ZeroTaxSalesAmount(isat202) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat022) THEN # 課稅別
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TaxType(isat022) is null."
            RETURN r_success,r_mesg
         END IF 
         IF cl_null(p_isat.isat023) THEN # 課稅別
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TaxRate(isat023) is multiple tax rate error."
            RETURN r_success,r_mesg
         END IF  
         IF cl_null(p_isat.isat114) THEN # 營業稅額
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TaxAmount(isat114) is null."
            RETURN r_success,r_mesg
         END IF         
         IF cl_null(p_isat.isat115) THEN # 營業稅額
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TotalAmount(isat115) is null."
            RETURN r_success,r_mesg
         END IF 
         
      WHEN p_type = "A0201" OR p_type = "A0501" OR p_type = "C0501"     # 作廢       
         IF cl_null(p_isat.isat004) THEN # 作廢發票號碼
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelInvoiceNumber(isat004) is null."
             RETURN r_success,r_mesg
         END IF 
         IF cl_null(p_isat.isat007) THEN # 發票日期
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:InvoiceDate(isat007) is null."
             RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat012) THEN # 賣方統一編號
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:SellerId(isat012) is null."
             RETURN r_success,r_mesg
         END IF 
         IF cl_null(p_isat.isat017) THEN # 作廢日期
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelDate(isat017) is null."
             RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat018) THEN # 作廢日期
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelTime(isat018) is null."
             RETURN r_success,r_mesg
         END IF         
         IF cl_null(p_isat.isat015) THEN # 作廢原因
             LET r_success = FALSE
             LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelReason(isat015) is null."
             RETURN r_success,r_mesg
         END IF
      
      WHEN p_type = "C0701"  # 註銷
         IF cl_null(p_isat.isat004) THEN # 註銷發票號碼
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:VoidInvoiceNumber(isat004) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat004) THEN # 發票日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:VoidInvoiceNumber(isat004) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat012) THEN # 賣方統一編號
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:SellerId(isat012) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat017) THEN # 註銷日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:VoidDate(isat017) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat018) THEN # 註銷時間
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:VoidTime(isat018) is null."
            RETURN r_success,r_mesg
         END IF         
         IF cl_null(p_isat.isat015) THEN # 註銷原因
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:VoidReason(isat015) is null."
            RETURN r_success,r_mesg
         END IF
         
      WHEN p_type = "B0101" OR p_type = "B0401" OR p_type = "D0401" # 折讓
         IF cl_null(p_isat.isatdocno) THEN       # 折讓證明單號碼
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:AllowanceNumber(isatrocno) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isatdocdt) THEN       # 折讓證明單日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:AllowanceDate(isatdocdt) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat012) THEN       # 統一編號(賣方)
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:Identifier(isat012) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(g_ooefl006) THEN       #   營業人名稱(賣方)
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:Name(ooefl006) is null."
            RETURN r_success,r_mesg
         END IF
         
         # 明細資料
         IF cl_null(p_isat.isat004) THEN       # 原發票號碼
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:OriginalInvoiceNumber(isat004) is null."
            RETURN r_success,r_mesg
         END IF
         # 原發票日期
         IF cl_null(p_isat.isat027) THEN       # 原發票日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:OriginalInvoiceDate(isat029) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat022) THEN       # 課稅別
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TaxType(isat022) is null."
            RETURN r_success,r_mesg
         END IF
          
         LET g_sql = " SELECT isah004,isah005,isah006,isah101,isah113,isah114 ",
                     "   FROM isah_t ",
                     "  WHERE isahent = '",g_enterprise,"'                    ",
                     "    AND isahdocno = '",p_isat.isatdocno,"'              "
         PREPARE aisp520_getisah_prep02 FROM g_sql
         DECLARE aisp520_getisah_curs02 CURSOR FOR aisp520_getisah_prep02
         FOREACH aisp520_getisah_curs02 INTO l_isah.isah004,l_isah.isah005,l_isah.isah006,
                                             l_isah.isah101,l_isah.isah113,l_isah.isah114
            IF cl_null(l_isah.isah004) THEN       # 原品名
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:OriginalDescription(isah004) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah006) THEN       # 數量
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Quantity(isah006) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah005) THEN       # 單位
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Unit(isah005) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah101) THEN       # 單價
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:UnitPrice(isah101) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah113) THEN       # 金額(不含稅之進貨額)
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Amount(isah113) is null."
               RETURN r_success,r_mesg
            END IF
            IF cl_null(l_isah.isah114) THEN       # 營業稅額
               LET r_success = FALSE
               LET r_mesg = " Type:",p_type CLIPPED," Reason:Amount(isah114) is null."
               RETURN r_success,r_mesg
            END IF                         
         END FOREACH      
         # 彙總資料                 
         IF cl_null(p_isat.isat114) THEN       # 營業稅額合計
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TaxAmount(isat114) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat113) THEN       # 金額(不含稅之進貨額)合計
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:TotalAmount(isat113) is null."
            RETURN r_success,r_mesg
         END IF
         
      WHEN p_type = "D0501"
         IF cl_null(p_isat.isat007) THEN       # 折讓證明單日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:AllowanceDate(isat007) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat012) THEN       # 賣方統一編號
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:SellerId(isat012) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat017) THEN       # 折讓證明單作廢日期
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelDate(isat017) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat018) THEN       # 折讓證明單作廢時間
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelTime(isat018) is null."
            RETURN r_success,r_mesg
         END IF
         IF cl_null(p_isat.isat015) THEN       # 折讓證明單作廢原因
            LET r_success = FALSE
            LET r_mesg = " Type:",p_type CLIPPED," Reason:CancelReason(isat015) is null."
            RETURN r_success,r_mesg
         END IF         
   END CASE

   RETURN r_success,r_mesg

END FUNCTION

################################################################################
# Descriptions...: 擷取固定字元
# Memo...........:
# Usage..........: CALL aisp520_train(p_n,p_str)
# Date & Author..: 2016/02/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_train(p_n,p_str)
DEFINE p_n          LIKE type_t.num5
DEFINE p_str        STRING
DEFINE l_length     LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5

    LET l_length = p_str.getLength()   #總長度
    IF l_length > p_n THEN
       LET p_str = p_str.subString(1,p_n)
       LET l_length = p_n
    END IF
    LET p_str = p_str CLIPPED
    LET p_str = p_str.trim()
    RETURN p_str
    
END FUNCTION

################################################################################
# Descriptions...: 數字轉文字
# Memo...........: 數值固定最多取到小數點後4位數
# Usage..........: CALL aisp520_train2(p_lum)
# Date & Author..: 2016/02/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_train2(p_lum)
DEFINE l_n          LIKE type_t.num5
DEFINE p_lum        LIKE type_t.num20_6
DEFINE l_int        LIKE type_t.num20 
DEFINE l_int_str    STRING
DEFINE l_int2       LIKE type_t.num5
DEFINE l_int2_str   STRING
DEFINE r_str        STRING
DEFINE l_fillin     STRING
DEFINE l_a          LIKE type_t.num5
DEFINE l_dot_length LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_length     LIKE type_t.num5
DEFINE l_length2    LIKE type_t.num5
DEFINE l_sp         LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
   
 
    LET l_fillin = p_lum 
    LET l_a = l_fillin.getIndexOf('.',1)           #小數點所在位置
    LET l_int = l_fillin.subString(1,l_a-1)        #整數
    LET l_int2 = l_fillin.subString(l_a+1,l_a+4)   #小數值
    LET l_int2_str = l_int2 USING "&&&&"
    LET l_i = 4
    WHILE TRUE
       IF l_int2_str.subString(l_i,l_i) = 0  THEN
          LET l_int2_str = l_int2_str.subString(1,l_i-1)
       ELSE
          EXIT WHILE
       END IF
       LET l_i = l_i - 1
       IF l_i = 0 THEN
          EXIT WHILE
       END IF  
    END WHILE
    LET l_int_str = l_int
    LET l_int_str = l_int_str.trim()
    LET l_int2_str = l_int2_str.trim()
    IF l_int = 0  THEN
       IF l_int2 = 0 THEN
          LET r_str = "0"
       ELSE
          LET r_str =  "0.",l_int2_str.trim()
       END IF
    ELSE
       IF l_int2 = 0 THEN
          LET r_str = l_int_str.trim()
       ELSE
          LET r_str = l_int_str.trim() ,".",l_int2_str.trim()  
       END IF
    END IF
    LET r_str = r_str CLIPPED
    RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 新增紀錄檔
# Memo...........:
# Usage..........: CALL aisp520_ins_isav(p_flag,p_type,p_isatsite,p_isav007,p_file_name,p_mesg)
# Input parameter: p_flag         成功/失敗
#                : p_type         種類
#                : p_isatsite     營運據點
#                : p_p_file_name  檔案名稱
#                : p_filename     訊息
# Date & Author..: 2016/02/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_ins_isav(p_flag,p_type,p_isatsite,p_isav007,p_isav008,p_isav009,p_file_name,p_mesg)
DEFINE p_flag     LIKE type_t.chr1
DEFINE p_type     LIKE type_t.chr10
DEFINE p_isav007  LIKE isav_t.isav007   #isat004發票號碼
DEFINE p_isav008  LIKE isav_t.isav008   #isat007發票日期
DEFINE p_isav009  LIKE isav_t.isav009   #isat008發票時間
DEFINE p_isatsite LIKE isat_t.isatsite
DEFINE p_file_name     STRING
DEFINE l_date          DATETIME YEAR TO FRACTION(5)
#DEFINE l_isav  RECORD LIKE isav_t.* #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE l_isav RECORD  #電子發票匯出記錄檔
       isavent LIKE isav_t.isavent, #企業編號
       isavcomp LIKE isav_t.isavcomp, #法人
       isavsite LIKE isav_t.isavsite, #營運據點
       isavseq LIKE isav_t.isavseq, #發票歷程項次
       isav001 LIKE isav_t.isav001, #申報單位
       isav002 LIKE isav_t.isav002, #法人統編
       isav003 LIKE isav_t.isav003, #檔案格式
       isav004 LIKE isav_t.isav004, #匯出日期
       isav005 LIKE isav_t.isav005, #匯出時間
       isav006 LIKE isav_t.isav006, #發票編號
       isav007 LIKE isav_t.isav007, #發票號碼
       isav008 LIKE isav_t.isav008, #發票日期
       isav009 LIKE isav_t.isav009, #發票時間
       isav010 LIKE isav_t.isav010, #執行人員
       isav011 LIKE isav_t.isav011, #匯出xml檔名
       isav012 LIKE isav_t.isav012, #處理成功否
       isav013 LIKE isav_t.isav013  #訊息
END RECORD
#161104-00024#10 --e add
DEFINE p_mesg   STRING
DEFINE l_ooef017 LIKE ooef_t.ooef017

   IF p_flag = 1 THEN 
     LET p_flag = 'Y'
   ELSE 
     LET p_flag = 'N'
   END IF
   
   LET l_date = cl_get_timestamp()
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.isaa001
   LET l_isav.isavent  = g_enterprise
   LET l_isav.isavcomp = l_ooef017
   LET l_isav.isavsite = p_isatsite            
   LET l_isav.isavseq  = 0
   LET l_isav.isav001  = g_master.isaa001
   LET l_isav.isav002  = g_ooef002
   LET l_isav.isav003  = p_type
   LET l_isav.isav004  = g_today
   LET l_isav.isav005  = l_date
   LET l_isav.isav006  = ''
   LET l_isav.isav007  = p_isav007  #isat004發票號碼
   LET l_isav.isav008  = p_isav008  #isat007發票日期
   LET l_isav.isav009  = p_isav009  #isat008發票時間
   LET l_isav.isav010  = g_user
   LET l_isav.isav011  = p_file_name
   LET l_isav.isav012  = p_flag
   LET l_isav.isav013  = p_mesg
   
  #INSERT INTO isav_t VALUES(l_isav.*) #161108-00017#6 mark
   #161108-00017#6 --s add
   INSERT INTO isav_t(isavent,isavcomp,isavsite,isavseq,isav001,
                      isav002,isav003,isav004,isav005,isav006,
                      isav007,isav008,isav009,isav010,isav011,
                      isav012,isav013)
   VALUES(l_isav.isavent,l_isav.isavcomp,l_isav.isavsite,l_isav.isavseq,l_isav.isav001,
          l_isav.isav002,l_isav.isav003,l_isav.isav004,l_isav.isav005,l_isav.isav006,
          l_isav.isav007,l_isav.isav008,l_isav.isav009,l_isav.isav010,l_isav.isav011,
          l_isav.isav012,l_isav.isav013)
   #161108-00017#6 --e add
END FUNCTION

################################################################################
# Descriptions...: 產生xml檔案
# Memo...........:
# Usage..........: CALL aisp520_xml_c0401(p_filename,p_isat)
# Date & Author..: 2016/02/16 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_C0401(p_filename,p_isat)
DEFINE p_filename        STRING
#DEFINE p_isat RECORD     LIKE isat_t.*  #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE lc_channe1              base.Channel
DEFINE l_str  STRING     
DEFINE l_isat007         STRING
DEFINE l_isat009         LIKE isat_t.isat009
DEFINE l_isat010         LIKE isat_t.isat010
DEFINE l_buyer_remark    LIKE type_t.chr1
DEFINE l_invoicetype     LIKE gzcb_t.gzcb002
DEFINE l_printmark       LIKE type_t.chr1
DEFINE l_invoice_time    STRING
DEFINE l_detail_qty_str  STRING
DEFINE l_detail_amt_str  STRING
DEFINE l_unitprice_str   STRING
DEFINE l_detail_no_str   STRING
DEFINE l_salesamount_str STRING
DEFINE l_taxrate_str     STRING
DEFINE l_isah  RECORD
          isahseq LIKE isah_t.isahseq,
          isah004 LIKE isah_t.isah004,
          isah006 LIKE isah_t.isah006,
          isah005 LIKE isah_t.isah005,
          isah101 LIKE isah_t.isah101,
          isah115 LIKE isah_t.isah115
     END RECORD  
DEFINE l_isat202  STRING     
DEFINE l_isat203  STRING
DEFINE l_isat204  STRING
DEFINE l_isat114  STRING
DEFINE l_isat115  STRING
DEFINE l_isat008  STRING
DEFINE r_success  LIKE type_t.num5

   LET r_success =TRUE
   LET p_filename = p_filename,".xml"
   
   IF p_isat.isat026 = '1' THEN
      LET p_filename = os.Path.join(g_path_A0101,p_filename)
      LET g_path = g_path_A0101
   END IF 
   IF p_isat.isat026 = '2' THEN
      LET p_filename = os.Path.join(g_path_A0401,p_filename)
      LET g_path = g_path_A0401 
   END IF
   IF p_isat.isat026 = '6' THEN
      LET p_filename = os.Path.join(g_path_C0401,p_filename)
      LET g_path = g_path_C0401 
   END IF   
   
   LET lc_channe1 = base.Channel.create()
   CALL lc_channe1.openFile(p_filename,"w")
   IF STATUS THEN 
      LET r_success = FALSE
      RETURN r_success
   END IF
   CALL lc_channe1.setDelimiter("")
        
   LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
   CALL lc_channe1.write(l_str)
   CASE p_isat.isat026 
      WHEN 1
         LET l_str = '<Invoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:A0101:3.1 A0101.xsd" xmlns="urn:GEINV:eInvoiceMessage:A0101:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
      WHEN 2
         LET l_str = '<Invoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:A0401:3.1 A0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:A0401:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
      WHEN 6
         LET l_str = '<Invoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:C0401:3.1 C0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:C0401:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
   END CASE
   CALL lc_channe1.write(l_str)
   CALL aisp520_train(10,p_isat.isat004)RETURNING p_isat.isat004 #發票號碼
   LET l_isat007 = p_isat.isat007 USING 'YYYYMMDD'               #發票日期
   CALL aisp520_train(60,g_ooefl006)RETURNING g_ooefl006
   CALL aisp520_train(100,g_isaa031)RETURNING g_isaa031
   CALL aisp520_xml_replaceStr(g_isaa031) RETURNING g_isaa031
   CALL aisp520_train(30,g_isaa003)RETURNING g_isaa003
   CALL aisp520_train(10,g_isaa002)RETURNING g_isaa002
   CALL aisp520_train(10,p_isat.isat010)RETURNING p_isat.isat010
   CALL aisp520_train(60,p_isat.isat009)RETURNING p_isat.isat009
   CALL aisp520_train(100,p_isat.isat011)RETURNING p_isat.isat011
   CALL aisp520_train(6,p_isat.isat205)RETURNING p_isat.isat205
   CALL aisp520_train(64,p_isat.isat206)RETURNING p_isat.isat206
   CALL aisp520_train(64,p_isat.isat207)RETURNING p_isat.isat207
   CALL aisp520_train(10,p_isat.isat204)RETURNING p_isat.isat204
   CALL aisp520_train(4,p_isat.isat006)RETURNING p_isat.isat006
   LET l_isat008 = p_isat.isat008
   LET l_isat008 = l_isat008.subString(12,19)
   
   # 買方統編
   IF cl_null(p_isat.isat010) THEN
      LET l_isat010 = '0000000000'
      LET l_isat009 = "散客"
      LET l_buyer_remark = '3'   # 買受人註記
   ELSE
      LET l_isat010 = p_isat.isat010
      LET l_isat009 = p_isat.isat009
      LET l_buyer_remark = '1'
   END IF
   # 發票類型
   CASE p_isat.isat026
       WHEN '1'    LET l_invoicetype = '01'
       WHEN '2'    LET l_invoicetype = '02'
       WHEN '3'    LET l_invoicetype = '03'
       WHEN '6'    LET l_invoicetype = '06'
       WHEN '7'    LET l_invoicetype = '07'
   END CASE
   #紙本發票已列印否註記
   IF p_isat.isat021 = 0 OR cl_null(p_isat.isat021) THEN
      LET l_printmark = 'N'
   ELSE
      LET l_printmark = 'Y'
   END IF
   LET l_invoice_time = p_isat.isat004
   LET l_invoice_time = l_invoice_time.subString(12,19)
   
   #發票資料
   LET l_str = '    <Main> ' 
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceNumber>",p_isat.isat004 CLIPPED,"</InvoiceNumber>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceDate>",l_isat007 CLIPPED,"</InvoiceDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceTime>",l_isat008 CLIPPED,"</InvoiceTime>"   
   CALL lc_channe1.write(l_str)
   LET l_str = "        <Seller>   " 
   CALL lc_channe1.write(l_str)
   LET l_str = "            <Identifier>",g_ooef002 CLIPPED,"</Identifier>"
   CALL lc_channe1.write(l_str)
   LET l_str = "            <Name>",g_ooefl006 CLIPPED,"</Name>"
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(g_isaa031) THEN   
      LET l_str = "            <Address>",g_isaa031 CLIPPED,"</Address>"               #地址
      CALL lc_channe1.write(l_str)
   END IF
   IF NOT cl_null(g_isaa003) THEN    
      LET l_str = "            <PersonInCharge>",g_isaa003 CLIPPED,"</PersonInCharge>" #負責人姓名
      CALL lc_channe1.write(l_str)
   END IF 
   LET l_str = "        </Seller> "
   CALL lc_channe1.write(l_str)  
   LET l_str = "        <Buyer>   "
   CALL lc_channe1.write(l_str)
   LET l_str = "            <Identifier>",l_isat010 CLIPPED,"</Identifier>"
   CALL lc_channe1.write(l_str)
   LET l_str = "            <Name>",l_isat009 CLIPPED,"</Name>"        
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(p_isat.isat011) THEN   
      LET l_str = "            <Address>",p_isat.isat011 CLIPPED,"</Address>"  #地址	Address
      CALL lc_channe1.write(l_str)
   END IF 
   LET l_str = "        </Buyer> "
   CALL lc_channe1.write(l_str)
   IF p_isat.isat026 = '2' THEN
      LET l_str = "        <BuyerRemark>1</BuyerRemark>"
      CALL lc_channe1.write(l_str)
   END IF
   LET l_str = "        <CustomsClearanceMark>1</CustomsClearanceMark>"   
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceType>",l_invoicetype CLIPPED,"</InvoiceType>"
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(p_isat.isat204)  THEN  
      LET l_str = "        <DonateMark>1</DonateMark>"
   ELSE 
      LET l_str = "        <DonateMark>0</DonateMark>"
   END IF  
   CALL lc_channe1.write(l_str)
   IF p_isat.isat026 = '6' THEN
      IF NOT cl_null(p_isat.isat205) THEN   
         LET l_str = "        <CarrierType>",p_isat.isat205 CLIPPED,"</CarrierType>"
         CALL lc_channe1.write(l_str)
      END IF
      IF NOT cl_null(p_isat.isat205) THEN  
         LET l_str = "        <CarrierId1>",p_isat.isat206 CLIPPED,"</CarrierId1>"
         CALL lc_channe1.write(l_str)
      END IF
      IF NOT cl_null(p_isat.isat206) THEN   
         LET l_str = "        <CarrierId2>",p_isat.isat206 CLIPPED,"</CarrierId2>"
         CALL lc_channe1.write(l_str)
      END IF
      LET l_str = "        <PrintMark>",l_printmark CLIPPED,"</PrintMark>"
      CALL lc_channe1.write(l_str)
      IF NOT cl_null(p_isat.isat204) THEN
         LET l_str = "        <NPOBAN>",p_isat.isat204 CLIPPED,"</NPOBAN>"
         CALL lc_channe1.write(l_str)
      END IF
      LET l_str = "        <RandomNumber>",p_isat.isat006 CLIPPED,"</RandomNumber>"
      CALL lc_channe1.write(l_str)         
   END IF
   LET l_str = '    </Main> '
   CALL lc_channe1.write(l_str)
   
   #單身資料
   LET l_str = '    <Details> '
   CALL lc_channe1.write(l_str)
   INITIALIZE l_isah.* TO NULL
   LET g_sql = " SELECT isahseq,isah004,isah005,isah006,isah101,isah115 ",
               "   FROM isah_t                                          ",
               "   WHERE isahent = '",g_enterprise,"'                   ",
               "     AND isahdocno = '",p_isat.isatdocno,"'             "
   PREPARE aisp520_getisah_prep03 FROM g_sql
   DECLARE aisp520_getisah_curs03 CURSOR FOR aisp520_getisah_prep03
   FOREACH aisp520_getisah_curs03 INTO l_isah.isahseq,l_isah.isah004,l_isah.isah005,
                                       l_isah.isah006,l_isah.isah101,l_isah.isah115
      CALL aisp520_train(256,l_isah.isah004) RETURNING l_isah.isah004
      CALL aisp520_train(6,l_isah.isah005) RETURNING l_isah.isah005
      CALL aisp520_train(3,l_isah.isahseq) RETURNING l_detail_no_str
      CALL aisp520_train2(l_isah.isah115) RETURNING l_detail_amt_str
      CALL aisp520_train2(l_isah.isah006) RETURNING l_detail_qty_str
      
      LET l_str = '        <ProductItem> '
      CALL lc_channe1.write(l_str)
      LET l_str = "            <Description>",l_isah.isah004 CLIPPED,"</Description>"
      CALL lc_channe1.write(l_str)
      LET l_str = "            <Quantity>",l_detail_qty_str CLIPPED,"</Quantity>"         #數量
      CALL lc_channe1.write(l_str)
      IF NOT cl_null(l_isah.isah005) THEN
         LET l_str = "            <Unit>",l_isah.isah005 CLIPPED,"</Unit>"
         CALL lc_channe1.write(l_str)
      END IF
      IF p_isat.isat029 = 'Y' THEN 
         LET l_isah.isah101 = l_isah.isah101 * (1+ p_isat.isat023/100)
      END IF
      CALL aisp520_train2(l_isah.isah101) RETURNING l_unitprice_str
      LET l_str = "            <UnitPrice>",l_unitprice_str CLIPPED,"</UnitPrice>"      #單價
      CALL lc_channe1.write(l_str)
      LET l_str = "            <Amount>",l_detail_amt_str CLIPPED,"</Amount>"
      CALL lc_channe1.write(l_str)
      LET l_str = "            <SequenceNumber>",l_detail_no_str CLIPPED,"</SequenceNumber>"
      CALL lc_channe1.write(l_str)
      LET l_str = '        </ProductItem> '
      CALL lc_channe1.write(l_str)
   END FOREACH
   LET l_str = '    </Details> '
   CALL lc_channe1.write(l_str)

   
   #匯總資料
    
   CALL aisp520_train2(p_isat.isat201) RETURNING l_salesamount_str
   CALL aisp520_train2(p_isat.isat203) RETURNING l_isat203
   CALL aisp520_train2(p_isat.isat202) RETURNING l_isat202
   CALL aisp520_train2(p_isat.isat114) RETURNING l_isat114
   CALL aisp520_train2(p_isat.isat115) RETURNING l_isat115
   CALL aisp520_train2(p_isat.isat023) RETURNING l_taxrate_str
   LET l_str = '    <Amount> '
   CALL lc_channe1.write(l_str)
   LET l_str = "        <SalesAmount>",l_salesamount_str CLIPPED,"</SalesAmount>" 
   CALL lc_channe1.write(l_str)
   IF p_isat.isat026 = '6' THEN  #限 C0401 
       LET l_str = "        <FreeTaxSalesAmount>",l_isat203 CLIPPED,"</FreeTaxSalesAmount>"
       CALL lc_channe1.write(l_str)
       LET l_str = "        <ZeroTaxSalesAmount>",l_isat202 CLIPPED,"</ZeroTaxSalesAmount>"
       CALL lc_channe1.write(l_str) 
   END IF
   LET l_str = "        <TaxType>",p_isat.isat022 CLIPPED,"</TaxType>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <TaxRate>",l_taxrate_str CLIPPED,"</TaxRate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <TaxAmount>",l_isat114 CLIPPED,"</TaxAmount>" #營業稅額
   CALL lc_channe1.write(l_str)
   LET l_str = "        <TotalAmount>",l_isat115 CLIPPED,"</TotalAmount>" #總計
   CALL lc_channe1.write(l_str)
   LET l_str = '    </Amount> '
   CALL lc_channe1.write(l_str)
   LET l_str = '</Invoice>'
   CALL lc_channe1.write(l_str)
   
   CALL lc_channe1.close()
   IF os.Path.chrwx(p_filename, 511) THEN END IF #chmod 666 => 6*8^2 +6*8^1 +6*8^
   IF NOT os.Path.exists(p_filename) THEN LET r_success = FALSE END IF
   RETURN r_success 
   
END FUNCTION

################################################################################
# Descriptions...: 產生B0101/B0401/D0401之xml檔
# Memo...........:
# Usage..........: CALL aisp520_xml_D0401
# Date & Author..: 2016/02/19 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_D0401(p_filename,p_isat)
DEFINE p_filename        STRING
#DEFINE p_isat RECORD     LIKE isat_t.*  #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE r_success         LIKE type_t.num5
DEFINE lc_channe1        base.Channel
DEFINE l_isat010         LIKE isat_t.isat010
DEFINE l_isat009         LIKE isat_t.isat009
DEFINE l_isat027         STRING #原發票日期
DEFINE l_isah  RECORD
          isahseq LIKE isah_t.isahseq,
          isah004 LIKE isah_t.isah004,
          isah005 LIKE isah_t.isah005,
          isah006 LIKE isah_t.isah006,
          isah101 LIKE isah_t.isah101,
          isah113 LIKE isah_t.isah113,
          isah114 LIKE isah_t.isah114
     END RECORD  
DEFINE l_detail_qty_str          STRING
DEFINE l_unitprice_str           STRING
DEFINE l_detail_amt_str          STRING
DEFINE l_detail_tax_str          STRING
DEFINE l_detail_allowance_no_str STRING
DEFINE l_isatdocdt    STRING
DEFINE l_isat113      STRING
DEFINE l_isat114      STRING
DEFINE l_isat115      STRING
DEFINE l_str          STRING

   LET r_success =TRUE
   LET p_filename = p_filename,".xml"
   IF p_isat.isat026 = '1' THEN
      LET p_filename = os.Path.join(g_path_B0101,p_filename)
      LET g_path = g_path_B0101
   END IF 
   IF p_isat.isat026 = '2' THEN
      LET p_filename = os.Path.join(g_path_B0401,p_filename)
      LET g_path = g_path_B0401 
   END IF
   IF p_isat.isat026 = '6' THEN
      LET p_filename = os.Path.join(g_path_D0401,p_filename)
      LET g_path = g_path_D0401 
   END IF   
   
   LET lc_channe1 = base.Channel.create()
   CALL lc_channe1.openFile(p_filename,"w")   
   IF STATUS THEN 
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_isatdocdt = p_isat.isatdocdt USING 'YYYYMMDD'  
   CALL aisp520_train(10,g_isaa002) RETURNING g_isaa002
   CALL aisp520_train(60,g_ooefl006) RETURNING g_ooefl006
   CALL aisp520_train(100,g_isaa031) RETURNING g_isaa031
   CALL aisp520_xml_replaceStr(g_isaa031) RETURNING g_isaa031
   CALL aisp520_train(30,g_isaa003) RETURNING g_isaa003
   CALL aisp520_train(60,p_isat.isat009) RETURNING p_isat.isat009
   CALL aisp520_train(100,p_isat.isat011) RETURNING  p_isat.isat011
   
    IF cl_null(p_isat.isat010) THEN
      LET l_isat010 = '0000000000'
      LET l_isat009 = "散客"
   ELSE
      LET l_isat010 = p_isat.isat010
      LET l_isat009 = p_isat.isat009
   END IF
   LET l_isat027 = p_isat.isat027 USING 'YYYYMMDD'
   
   CALL lc_channe1.setDelimiter("")
   LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
   CALL lc_channe1.write(l_str)
   CASE p_isat.isat026 
      WHEN 1
         LET l_str = '<Allowance xsi:schemaLocation="urn:GEINV:eInvoiceMessage:B0101:3.1 B0101.xsd" xmlns="urn:GEINV:eInvoiceMessage:B0101:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'  
      WHEN 2
         LET l_str = '<Allowance xsi:schemaLocation="urn:GEINV:eInvoiceMessage:B0401:3.1 B0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:B0401:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'  
      WHEN 6
         LET l_str = '<Allowance xsi:schemaLocation="urn:GEINV:eInvoiceMessage:D0401:3.1 D0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:D0401:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'  
   END CASE
   CALL lc_channe1.write(l_str)
   
   #發票資料
    LET l_str = "    <Main> " 
    CALL lc_channe1.write(l_str)
    LET l_str = "        <AllowanceNumber>",p_isat.isatdocno CLIPPED,"</AllowanceNumber>"
    CALL lc_channe1.write(l_str)
    LET l_str = "        <AllowanceDate>",l_isatdocdt CLIPPED,"</AllowanceDate>"
    CALL lc_channe1.write(l_str)
    LET l_str = "        <Seller>   " 
    CALL lc_channe1.write(l_str)
    LET l_str = "            <Identifier>",g_ooef002 CLIPPED,"</Identifier>"
    CALL lc_channe1.write(l_str)
    LET l_str = "            <Name>",g_ooefl006 CLIPPED,"</Name>"
    CALL lc_channe1.write(l_str)
    IF NOT cl_null(g_isaa031) THEN
       LET l_str = "            <Address>",g_isaa031 CLIPPED,"</Address>"
       CALL lc_channe1.write(l_str)
    END IF
    IF NOT cl_null(g_isaa003) THEN
       LET l_str = "            <PersonInCharge>",g_isaa003 CLIPPED,"</PersonInCharge>"
       CALL lc_channe1.write(l_str)
    END IF
    LET l_str = "        </Seller> "
    CALL lc_channe1.write(l_str)  
    LET l_str = "        <Buyer>   "
    CALL lc_channe1.write(l_str)
    LET l_str = "            <Identifier>",l_isat010 CLIPPED,"</Identifier>"
    CALL lc_channe1.write(l_str)
    LET l_str = "            <Name>",l_isat009 CLIPPED,"</Name>"        
    CALL lc_channe1.write(l_str)
    IF NOT cl_null(p_isat.isat011) THEN
       LET l_str = "            <Address>",p_isat.isat011 CLIPPED,"</Address>"
       CALL lc_channe1.write(l_str)
    END IF
    LET l_str = "        </Buyer> "
    CALL lc_channe1.write(l_str)
    LET l_str = "        <AllowanceType>1</AllowanceType>"
    CALL lc_channe1.write(l_str)
    LET l_str = '    </Main> '
    CALL lc_channe1.write(l_str)
    #購買商品資料
    LET l_str = '    <Details> '
    CALL lc_channe1.write(l_str)
    #取折讓單明細資料
    INITIALIZE l_isah.* TO NULL
    LET g_sql = " SELECT isahseq,isah004,isah005, ",
                "        isah006,isah101,isah113,isah114  ",
                "   FROM isah_t                                          ",
                "   WHERE isahent = '",g_enterprise,"'                   ",
                "     AND isahdocno = '",p_isat.isatdocno,"'             "
    PREPARE aisp520_getisah_prep04 FROM g_sql
    DECLARE aisp520_getisah_curs04 CURSOR FOR aisp520_getisah_prep04
    FOREACH aisp520_getisah_curs04 INTO l_isah.isahseq,l_isah.isah004,l_isah.isah005,
                                        l_isah.isah006,l_isah.isah101,l_isah.isah113,l_isah.isah114
                                        
      IF SQLCA.SQLCODE THEN
         LET r_success = FALSE               
         RETURN r_success
      END IF                     
      CALL aisp520_train2(l_isah.isah006) RETURNING l_detail_qty_str 
      CALL aisp520_train2(l_isah.isah101) RETURNING l_unitprice_str
      CALL aisp520_train2(l_isah.isah113) RETURNING l_detail_amt_str
      CALL aisp520_train2(l_isah.isah114) RETURNING l_detail_tax_str
      CALL aisp520_train2(l_isah.isahseq) RETURNING l_detail_allowance_no_str
      CALL aisp520_train(6,l_isah.isah005) RETURNING l_isah.isah005
      
      LET l_str = '        <ProductItem> '
      CALL lc_channe1.write(l_str)                                  
      LET l_str = "            <OriginalInvoiceDate>",l_isat027 CLIPPED,"</OriginalInvoiceDate>"
      CALL lc_channe1.write(l_str)
      LET l_str = "            <OriginalSequenceNumber>",p_isat.isat004 CLIPPED,"</OriginalSequenceNumber>"   
      CALL lc_channe1.write(l_str)   
      LET l_str = "            <OriginalSequenceNumber>1</OriginalSequenceNumber>"  
      CALL lc_channe1.write(l_str)  
      LET l_isah.isah004 = aisp520_xml_replaceStr(l_isah.isah004)
      LET l_str = "            <OriginalDescription>",l_isah.isah004 CLIPPED,"</OriginalDescription>"
      CALL lc_channe1.write(l_str) 
      LET l_str = "            <Quantity>",l_detail_qty_str CLIPPED,"</Quantity>"    
      CALL lc_channe1.write(l_str)
      IF NOT cl_null(l_isah.isah005) THEN
         LET l_str = "            <Unit>",l_isah.isah005 CLIPPED,"</Unit>"
         CALL lc_channe1.write(l_str)
      END IF
      LET l_str = "            <UnitPrice>",l_unitprice_str CLIPPED,"</UnitPrice>"
      CALL lc_channe1.write(l_str)
      LET l_str = "            <Amount>",l_detail_amt_str CLIPPED,"</Amount>"      
      CALL lc_channe1.write(l_str)                                    
      LET l_str = "            <Tax>",l_detail_tax_str CLIPPED,"</Tax>"             
      CALL lc_channe1.write(l_str)
      LET l_str = "            <AllowanceSequenceNumber>",l_detail_allowance_no_str CLIPPED,"</AllowanceSequenceNumber>"   
      CALL lc_channe1.write(l_str)
      LET l_str = "            <TaxType>",p_isat.isat022 CLIPPED,"</TaxType>"
      CALL lc_channe1.write(l_str)
      LET l_str = '        </ProductItem> '
      CALL lc_channe1.write(l_str)      
   END FOREACH
   LET l_str = '    </Details> '
   CALL lc_channe1.write(l_str)
   
   #匯總資料   
   CALL aisp520_train2(p_isat.isat114) RETURNING l_isat114
   CALL aisp520_train2(p_isat.isat113) RETURNING l_isat113
   LET l_str = '    <Amount> '
   CALL lc_channe1.write(l_str)
   LET l_str = "        <TaxAmount>",l_isat114 CLIPPED,"</TaxAmount>"  
   CALL lc_channe1.write(l_str)
   LET l_str = "        <TotalAmount>",l_isat113 CLIPPED,"</TotalAmount>"  
   CALL lc_channe1.write(l_str)
   LET l_str = '    </Amount> '
   CALL lc_channe1.write(l_str)
   LET l_str = '</Allowance>'
   CALL lc_channe1.write(l_str)
   
   CALL lc_channe1.close()      
   IF os.Path.chrwx(p_filename, 511) THEN END IF #chmod 666 => 6*8^2 +6*8^1 +6*8^  
   IF NOT os.Path.exists(p_filename) THEN LET r_success = FALSE END IF    
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 產生A0201/A0501/C0501之XML檔案
# Memo...........:
# Usage..........: CALL aisp520_xml_C0501(p_filename,p_isat)
# Date & Author..: 2016/02/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_C0501(p_filename,p_isat)
DEFINE p_filename        STRING
#DEFINE p_isat RECORD     LIKE isat_t.*  #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE r_success         LIKE type_t.num5
DEFINE lc_channe1        base.Channel
DEFINE l_isat007         STRING
DEFINE l_isat017         STRING
DEFINE l_oocql004        LIKE type_t.chr100
DEFINE l_str STRING

   LET r_success =TRUE
   LET p_filename = p_filename,".xml"
   CASE p_isat.isat026 
      WHEN 1
        LET p_filename = os.Path.join(g_path_A0201,p_filename)
        LET g_path = g_path_A0201  
      WHEN 2
        LET p_filename = os.Path.join(g_path_A0501,p_filename)
        LET g_path = g_path_A0501 
      WHEN 6
         LET p_filename = os.Path.join(g_path_C0501,p_filename)   
         LET g_path = g_path_C0501 
   END CASE  

   LET lc_channe1 = base.Channel.create()
   CALL lc_channe1.openFile(p_filename,"w")
   IF STATUS THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL lc_channe1.setDelimiter("")
   LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
   CALL lc_channe1.write(l_str)
   
   CASE p_isat.isat026
      WHEN 1
         LET l_str = '<CancelInvoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:A0201:3.1 A0201.xsd" xmlns="urn:GEINV:eInvoiceMessage:A0201:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
      WHEN 2
         LET l_str = '<CancelInvoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:A0501:3.1 A0501.xsd" xmlns="urn:GEINV:eInvoiceMessage:A0501:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
      WHEN 6
         LET l_str = '<CancelInvoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:C0501:3.1 C0501.xsd" xmlns="urn:GEINV:eInvoiceMessage:C0501:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
   END CASE
   CALL lc_channe1.write(l_str)
   
   CALL aisp520_train(10,p_isat.isat004) RETURNING p_isat.isat004
   LET l_isat007 = p_isat.isat007 USING 'YYYYMMDD'
   IF cl_null(p_isat.isat010) THEN LET p_isat.isat010 = '0000000000' END IF
   CALL aisp520_train(10,p_isat.isat012) RETURNING p_isat.isat012  
   LET l_isat017 = p_isat.isat017 USING 'YYYYMMDD'
   SELECT oocql004 INTO l_oocql004 FROM oocql_t 
    WHERE oocqlent = g_enterprise AND oocql003 = g_dlang AND oocql001 = '3804' AND oocql002 = p_isat.isat015 
   CALL aisp520_train(20,l_oocql004) RETURNING l_oocql004
   CALL aisp520_xml_replaceStr(l_oocql004) RETURNING l_oocql004
   CALL aisp520_train(200,p_isat.isat016) RETURNING p_isat.isat016
   CALL aisp520_xml_replaceStr(p_isat.isat016) RETURNING p_isat.isat016
   
   LET l_str = "        <CancelInvoiceNumber>", p_isat.isat004 CLIPPED,"</CancelInvoiceNumber>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceDate>",l_isat007 CLIPPED,"</InvoiceDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <BuyerId>",p_isat.isat010 CLIPPED,"</BuyerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <SellerId>",p_isat.isat012 CLIPPED,"</SellerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelDate>",l_isat017 CLIPPED,"</CancelDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelTime>",p_isat.isat018 CLIPPED,"</CancelTime>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelReason>",l_oocql004 CLIPPED,"</CancelReason>"
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(p_isat.isat020) THEN  
      LET l_str = "        <ReturnTaxDocumentNumber>",p_isat.isat020 CLIPPED,"</ReturnTaxDocumentNumber>"
      CALL lc_channe1.write(l_str)
   END IF
   IF NOT cl_null(p_isat.isat016) THEN   
      LET l_str = "        <Remark>",p_isat.isat016 CLIPPED,"</Remark>"
      CALL lc_channe1.write(l_str)
   END IF
   LET l_str = '</CancelInvoice>'
   CALL lc_channe1.write(l_str)
   CALL lc_channe1.close()
   
   IF os.Path.chrwx(p_filename, 511) THEN END IF #chmod 666 => 6*8^2 +6*8^1 +6*8^
   IF NOT os.Path.exists(p_filename) THEN LET r_success = FALSE END IF    
   RETURN r_success
   
   
END FUNCTION

################################################################################
# Descriptions...: 產生C0701之xml檔
# Memo...........:
# Usage..........: CALL aisp520_xml_C0701(p_filename,p_isat)
# Date & Author..: 2016/02/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_C0701(p_filename,p_isat)
DEFINE p_filename        STRING
#DEFINE p_isat RECORD     LIKE isat_t.*  #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE r_success         LIKE type_t.num5
DEFINE lc_channe1        base.Channel
DEFINE l_isat007         STRING
DEFINE l_isat017         STRING
DEFINE l_oocql004        LIKE oocql_t.oocql004
DEFINE l_str STRING

   LET r_success = TRUE
   LET p_filename = p_filename,".xml"
   LET p_filename = os.Path.join(g_path_C0701,p_filename)
   LET g_path = g_path_C0701
  
   LET lc_channe1 = base.Channel.create()
   CALL lc_channe1.openFile(p_filename,"w") 
   IF STATUS THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL lc_channe1.setDelimiter("")
   LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
   CALL lc_channe1.write(l_str)
   LET l_str = '<VoidInvoice xsi:schemaLocation="urn:GEINV:eInvoiceMessage:C0701:3.1 C0701.xsd" xmlns="urn:GEINV:eInvoiceMessage:C0701:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' 
   CALL lc_channe1.write(l_str)
   CALL aisp520_train(10,p_isat.isat004) RETURNING p_isat.isat004
   LET l_isat007 = p_isat.isat007 USING 'YYYYMMDD'
   IF cl_null(p_isat.isat010) THEN LET p_isat.isat010 = '0000000000' END IF
   CALL aisp520_train(10,p_isat.isat012) RETURNING p_isat.isat012  
   LET l_isat017 = p_isat.isat017 USING 'YYYYMMDD'
  SELECT oocql004 INTO l_oocql004 FROM oocql_t 
   WHERE oocqlent = g_enterprise AND oocql003 = g_dlang AND oocql001 = '3804' AND oocql002 = p_isat.isat015 
   CALL aisp520_xml_replaceStr(l_oocql004) RETURNING l_oocql004
   CALL aisp520_train(200,p_isat.isat016) RETURNING p_isat.isat016
   CALL aisp520_xml_replaceStr(p_isat.isat016) RETURNING p_isat.isat016
      
   LET l_str = "        <VoidInvoiceNumber>",p_isat.isat004 CLIPPED,"</VoidInvoiceNumber>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <InvoiceDate>",l_isat007 CLIPPED,"</InvoiceDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <BuyerId>",p_isat.isat010 CLIPPED,"</BuyerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <SellerId>",p_isat.isat012  CLIPPED,"</SellerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <VoidDate>",l_isat017 CLIPPED,"</VoidDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <VoidTime>",p_isat.isat018 CLIPPED,"</VoidTime>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <VoidReason>",l_oocql004 CLIPPED,"</VoidReason>"
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(p_isat.isat016) THEN  
      LET l_str = "        <Remark>",p_isat.isat016 CLIPPED,"</Remark>"
      CALL lc_channe1.write(l_str)
   END IF
   LET l_str = '</VoidInvoice>'
   CALL lc_channe1.write(l_str)
   
   CALL lc_channe1.close()
   IF os.Path.chrwx(p_filename, 511) THEN END IF #chmod 666 => 6*8^2 +6*8^1 +6*8^
   IF NOT os.Path.exists(p_filename) THEN LET r_success = FALSE END IF    
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 產生D0501之xml
# Memo...........:
# Usage..........: CALL aisp520_xml_D0501(p_filename,p_isat)
# Date & Author..: 2016/02/18 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_D0501(p_filename,p_isat)
DEFINE p_filename        STRING
#DEFINE p_isat RECORD     LIKE isat_t.*  #161104-00024#10 mark
#161104-00024#10 --s add
DEFINE p_isat RECORD  #發票歷程檔
       isatent LIKE isat_t.isatent, #企業編碼
       isatcomp LIKE isat_t.isatcomp, #法人
       isatdocno LIKE isat_t.isatdocno, #開票單號
       isatseq LIKE isat_t.isatseq, #發票歷程項次
       isat001 LIKE isat_t.isat001, #發票類型
       isat002 LIKE isat_t.isat002, #電子發票否
       isat003 LIKE isat_t.isat003, #發票編號
       isat004 LIKE isat_t.isat004, #發票號碼
       isat005 LIKE isat_t.isat005, #發票聯別
       isat006 LIKE isat_t.isat006, #發票防偽隨機碼
       isat007 LIKE isat_t.isat007, #發票日期
       isat008 LIKE isat_t.isat008, #發票時間
       isat009 LIKE isat_t.isat009, #發票客戶全名
       isat010 LIKE isat_t.isat010, #購貨方統一編號
       isat011 LIKE isat_t.isat011, #購貨方地址
       isat012 LIKE isat_t.isat012, #銷方統一編號
       isat013 LIKE isat_t.isat013, #POS單號
       isat014 LIKE isat_t.isat014, #發票異動狀態
       isat015 LIKE isat_t.isat015, #異動理由碼
       isat016 LIKE isat_t.isat016, #異動備註
       isat017 LIKE isat_t.isat017, #異動日期
       isat018 LIKE isat_t.isat018, #異動時間
       isat019 LIKE isat_t.isat019, #異動人員
       isat020 LIKE isat_t.isat020, #專案作廢核准文號
       isat021 LIKE isat_t.isat021, #列印次數
       isat022 LIKE isat_t.isat022, #課稅別
       isat023 LIKE isat_t.isat023, #稅率
       isat024 LIKE isat_t.isat024, #檢查碼
       isat100 LIKE isat_t.isat100, #幣別
       isat101 LIKE isat_t.isat101, #匯率
       isat103 LIKE isat_t.isat103, #發票原幣未稅金額
       isat104 LIKE isat_t.isat104, #發票原幣稅額
       isat105 LIKE isat_t.isat105, #發票原幣含稅金額
       isat106 LIKE isat_t.isat106, #已折讓本幣未稅金額
       isat107 LIKE isat_t.isat107, #已折讓本幣稅額
       isat113 LIKE isat_t.isat113, #發票本幣未稅金額
       isat114 LIKE isat_t.isat114, #發票本幣稅額
       isat115 LIKE isat_t.isat115, #發票本幣含稅金額
       isat201 LIKE isat_t.isat201, #帳款應稅金額
       isat202 LIKE isat_t.isat202, #帳款零稅金額
       isat203 LIKE isat_t.isat203, #帳款免稅金額
       isat204 LIKE isat_t.isat204, #愛心碼
       isat205 LIKE isat_t.isat205, #載具類別號碼
       isat206 LIKE isat_t.isat206, #載具顯碼 ID
       isat207 LIKE isat_t.isat207, #載具隱碼 ID
       isat208 LIKE isat_t.isat208, #電子發票匯出狀態
       isat209 LIKE isat_t.isat209, #電子發票匯出序號
       isatud001 LIKE isat_t.isatud001, #自定義欄位(文字)001
       isatud002 LIKE isat_t.isatud002, #自定義欄位(文字)002
       isatud003 LIKE isat_t.isatud003, #自定義欄位(文字)003
       isatud004 LIKE isat_t.isatud004, #自定義欄位(文字)004
       isatud005 LIKE isat_t.isatud005, #自定義欄位(文字)005
       isatud006 LIKE isat_t.isatud006, #自定義欄位(文字)006
       isatud007 LIKE isat_t.isatud007, #自定義欄位(文字)007
       isatud008 LIKE isat_t.isatud008, #自定義欄位(文字)008
       isatud009 LIKE isat_t.isatud009, #自定義欄位(文字)009
       isatud010 LIKE isat_t.isatud010, #自定義欄位(文字)010
       isatud011 LIKE isat_t.isatud011, #自定義欄位(數字)011
       isatud012 LIKE isat_t.isatud012, #自定義欄位(數字)012
       isatud013 LIKE isat_t.isatud013, #自定義欄位(數字)013
       isatud014 LIKE isat_t.isatud014, #自定義欄位(數字)014
       isatud015 LIKE isat_t.isatud015, #自定義欄位(數字)015
       isatud016 LIKE isat_t.isatud016, #自定義欄位(數字)016
       isatud017 LIKE isat_t.isatud017, #自定義欄位(數字)017
       isatud018 LIKE isat_t.isatud018, #自定義欄位(數字)018
       isatud019 LIKE isat_t.isatud019, #自定義欄位(數字)019
       isatud020 LIKE isat_t.isatud020, #自定義欄位(數字)020
       isatud021 LIKE isat_t.isatud021, #自定義欄位(日期時間)021
       isatud022 LIKE isat_t.isatud022, #自定義欄位(日期時間)022
       isatud023 LIKE isat_t.isatud023, #自定義欄位(日期時間)023
       isatud024 LIKE isat_t.isatud024, #自定義欄位(日期時間)024
       isatud025 LIKE isat_t.isatud025, #自定義欄位(日期時間)025
       isatud026 LIKE isat_t.isatud026, #自定義欄位(日期時間)026
       isatud027 LIKE isat_t.isatud027, #自定義欄位(日期時間)027
       isatud028 LIKE isat_t.isatud028, #自定義欄位(日期時間)028
       isatud029 LIKE isat_t.isatud029, #自定義欄位(日期時間)029
       isatud030 LIKE isat_t.isatud030, #自定義欄位(日期時間)030
       isatsite LIKE isat_t.isatsite, #營運據點
       isatdocdt LIKE isat_t.isatdocdt, #單據日期
       isat025 LIKE isat_t.isat025, #發票最終狀態
       isat026 LIKE isat_t.isat026, #電子發票類型
       isat027 LIKE isat_t.isat027, #原發票日期
       isat028 LIKE isat_t.isat028, #稅別
       isat029 LIKE isat_t.isat029, #含稅否
       isat108 LIKE isat_t.isat108, #留抵原幣稅額
       isat118 LIKE isat_t.isat118  #留抵本幣稅額
END RECORD
#161104-00024#10 --e add
DEFINE r_success         LIKE type_t.num5
DEFINE lc_channe1        base.Channel
DEFINE l_isat007         STRING
DEFINE l_isat017         STRING
DEFINE l_oocql004        LIKE oocql_t.oocql004
DEFINE l_str STRING

   LET r_success =TRUE
   LET p_filename = p_filename,".xml"
   LET p_filename = os.Path.join(g_path_D0501,p_filename)
   LET g_path = g_path_D0501 

   LET lc_channe1 = base.Channel.create()
   CALL lc_channe1.openFile(p_filename,"w") 
   IF STATUS THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL lc_channe1.setDelimiter("")
   LET l_str = '<?xml version="1.0" encoding="UTF-8"?>'
   CALL lc_channe1.write(l_str)
   LET l_str = '<CancelAllowance xsi:schemaLocation="urn:GEINV:eInvoiceMessage:D0501:3.1 D0501.xsd" xmlns="urn:GEINV:eInvoiceMessage:D0501:3.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' #FUN-EC0040 add
   CALL lc_channe1.write(l_str)
   CALL aisp520_train(10,p_isat.isat004) RETURNING p_isat.isat004
   IF cl_null(p_isat.isat010) THEN LET p_isat.isat010 = '0000000000' END IF
   CALL aisp520_train(10,p_isat.isat012) RETURNING p_isat.isat012  
   LET l_isat017 = p_isat.isat017 USING 'YYYYMMDD'
   SELECT oocql004 INTO l_oocql004 FROM oocql_t 
    WHERE oocqlent = g_enterprise AND oocql003 = g_dlang AND oocql001 = '3804' AND oocql002 = p_isat.isat015 
   CALL aisp520_xml_replaceStr(l_oocql004) RETURNING l_oocql004
   CALL aisp520_train(200,p_isat.isat016) RETURNING p_isat.isat016
   CALL aisp520_xml_replaceStr(p_isat.isat016) RETURNING p_isat.isat016

   LET l_str = "        <CancelAllowanceNumber>",p_isat.isatdocno CLIPPED,"</CancelAllowanceNumber>" 
   CALL lc_channe1.write(l_str)
   LET l_str = "        <AllowanceDate>",l_isat017 CLIPPED,"</AllowanceDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <BuyerId>",p_isat.isat010 CLIPPED,"</BuyerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <SellerId>",p_isat.isat012 CLIPPED,"</SellerId>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelDate>",l_isat017 CLIPPED,"</CancelDate>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelTime>",p_isat.isat018 CLIPPED,"</CancelTime>"
   CALL lc_channe1.write(l_str)
   LET l_str = "        <CancelReason>",l_oocql004 CLIPPED,"</CancelReason>"
   CALL lc_channe1.write(l_str)
   IF NOT cl_null(p_isat.isat016) THEN  
      LET l_str = "        <Remark>",p_isat.isat016 CLIPPED,"</Remark>"
      CALL lc_channe1.write(l_str)
   END IF
   LET l_str = '</CancelAllowance>'
   CALL lc_channe1.write(l_str)
   
   CALL lc_channe1.close()
   IF os.Path.chrwx(p_filename, 511) THEN END IF #chmod 666 => 6*8^2 +6*8^1 +6*8^
   IF NOT os.Path.exists(p_filename) THEN LET r_success = FALSE END IF       
   RETURN r_success



END FUNCTION

################################################################################
# Descriptions...: 去除不標準之符號
# Memo...........:
# Usage..........: CALL aisp520_xml_replaceStr(p_str)
# Date & Author..: 2016/02/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp520_xml_replaceStr(p_str)
DEFINE p_str  STRING
DEFINE l_str  STRING
DEFINE l_buf  base.StringBuffer

  LET l_buf = base.StringBuffer.create()
  CALL l_buf.append(p_str)
  CALL l_buf.replace("&","&amp;",0)
  CALL l_buf.replace("'","&apos;",0)
  CALL l_buf.replace("\"","&quot;",0)
  CALL l_buf.replace("<","&lt;",0)
  CALL l_buf.replace(">","&gt;",0)

  LET l_str = l_buf.toString()

  RETURN l_str
END FUNCTION

#end add-point
 
{</section>}
 
