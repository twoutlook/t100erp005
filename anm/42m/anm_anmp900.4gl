#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp900.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-02-23 15:47:20), PR版次:0003(2016-05-05 13:48:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: anmp900
#+ Description: 資金模擬作業
#+ Creator....: 02114(2016-02-22 17:48:37)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="anmp900.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#+ Modifier...:   No.160318-00025#36 2016/04/20 By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...:   NO.160430-00002#1  2016/05/05 BY 07900  若录入的模拟方案编号存在于anmi932时，需要判断该方案是否有效。无效时不可使用。
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
       nmfa009 LIKE nmfa_t.nmfa009, 
   nmfa009_desc LIKE type_t.chr80, 
   nmfa002 LIKE nmfa_t.nmfa002, 
   nmfa002_desc LIKE type_t.chr80, 
   nmfa003 LIKE nmfa_t.nmfa003, 
   nmfa001 LIKE nmfa_t.nmfa001, 
   nmfal001 LIKE type_t.chr500, 
   nmfa005 LIKE nmfa_t.nmfa005, 
   nmfa006 LIKE nmfa_t.nmfa006, 
   nmfa007 LIKE nmfa_t.nmfa007, 
   nmfa008 LIKE nmfa_t.nmfa008, 
   nmfa004 LIKE nmfa_t.nmfa004, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_flag               LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmp900.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL anmp900_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp900 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmp900_init()
 
      #進入選單 Menu (="N")
      CALL anmp900_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      DELETE FROM s_anmp900_tmp;
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp900
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_anmp900_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp900.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmp900_init()
 
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
 
{<section id="anmp900.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp900_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_stus   LIKE nmfa_t.nmfastus   #判断是否有效
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL anmp900_clear()
   CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",TRUE)
   LET g_errshow = 1
   LET g_flag = 'N'
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.nmfa009,g_master.nmfa002,g_master.nmfa003,g_master.nmfa001,g_master.nmfal001, 
             g_master.nmfa005,g_master.nmfa006,g_master.nmfa007,g_master.nmfa008,g_master.nmfa004 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               CALL s_transaction_begin()
               IF NOT cl_null(g_master.nmfa001)  THEN
                  CALL n_nmfal(g_master.nmfa001)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.nmfa001
                  CALL ap_ref_array2(g_ref_fields," SELECT nmfal003 FROM nmfal_t WHERE nmfalent = '"
                      ||g_enterprise||"' AND nmfal001 = ? AND nmfal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.nmfal001 = g_rtn_fields[1]

                  DISPLAY BY NAME g_master.nmfal001
               END IF
               CALL s_transaction_end('Y','0')
               #END add-point
            END IF
 
 
 
 
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa009
            
            #add-point:AFTER FIELD nmfa009 name="input.a.nmfa009"
            IF NOT cl_null(g_master.nmfa009) THEN    
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmfa009
               
               #160318-00025#36  2016/04/20  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#36  2016/04/20  by pengxin  add(E)
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
             
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.nmfa009 = ''
                  LET g_master.nmfa009_desc = ''
                  DISPLAY g_master.nmfa009_desc TO nmfa009_desc              
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            CALL s_desc_get_department_desc(g_master.nmfa009) RETURNING g_master.nmfa009_desc
            DISPLAY g_master.nmfa009_desc TO nmfa009_desc              
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa009
            #add-point:BEFORE FIELD nmfa009 name="input.b.nmfa009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa009
            #add-point:ON CHANGE nmfa009 name="input.g.nmfa009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa002
            
            #add-point:AFTER FIELD nmfa002 name="input.a.nmfa002"
            IF NOT cl_null(g_master.nmfa002) THEN    
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmfa002
            
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeb005_1") THEN
                  #檢查成功時後續處理
             
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.nmfa002 = ''
                  LET g_master.nmfa002_desc = ''
                  DISPLAY g_master.nmfa002_desc TO nmfa002_desc              
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            CALL s_desc_get_department_desc(g_master.nmfa002) RETURNING g_master.nmfa002_desc
            DISPLAY g_master.nmfa002_desc TO nmfa002_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa002
            #add-point:BEFORE FIELD nmfa002 name="input.b.nmfa002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa002
            #add-point:ON CHANGE nmfa002 name="input.g.nmfa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa003
            #add-point:BEFORE FIELD nmfa003 name="input.b.nmfa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa003
            
            #add-point:AFTER FIELD nmfa003 name="input.a.nmfa003"
            IF NOT cl_null(g_master.nmfa002) AND NOT cl_null(g_master.nmfa003)  THEN    
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmfa002
               LET g_chkparam.arg2 = g_master.nmfa003
            
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeb006") THEN
                  #檢查成功時後續處理
             
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.nmfa003 = ''           
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa003
            #add-point:ON CHANGE nmfa003 name="input.g.nmfa003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa001
            #add-point:BEFORE FIELD nmfa001 name="input.b.nmfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa001
            
            #add-point:AFTER FIELD nmfa001 name="input.a.nmfa001"
            IF NOT cl_null(g_master.nmfa001) THEN 
               #160430-00002#1  by 07900 -add-str
                  LET  l_stus = ''
                  LET  l_n = 0
                  SELECT COUNT(*),nmfastus INTO l_n,l_stus
                    FROM nmfa_t
                   WHERE nmfaent = g_enterprise
                     AND nmfa001 = g_master.nmfa001
                group by nmfastus 
               IF l_n > 0 THEN      
                  IF l_stus ='N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00152'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmfa001 = ''
                     LET g_master.nmfal001 = ''
                     LET g_master.nmfa005 = ''
                     LET g_master.nmfa006 = ''
                     LET g_master.nmfa007 = ''
                     LET g_master.nmfa008 = ''
                     LET g_master.nmfa004 = ''
                     CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",TRUE)
                     NEXT FIELD CURRENT
                  END IF 
               END IF                  
               #160430-00002#1  by 07900 -add-end 
               IF g_master.nmfa001 = 'ALL' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-02978'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.nmfa001 = ''
                  NEXT FIELD CURRENT
               END IF              
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM nmeg_t
                WHERE nmegent = g_enterprise
                  AND nmeg001 = g_master.nmfa001
                  
               IF l_n = 0 THEN 
                  IF cl_ask_confirm("anm-02977") THEN 
                     LET g_master.nmfal001 = ''
                     LET g_master.nmfa005 = ''
                     LET g_master.nmfa006 = ''
                     LET g_master.nmfa007 = ''
                     LET g_master.nmfa008 = ''
                     LET g_master.nmfa004 = ''
                     CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",TRUE)
                     NEXT FIELD nmfa001 
                  END IF
               END IF
               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n 
                 FROM nmfa_t
                WHERE nmfaent = g_enterprise
                  AND nmfa001 = g_master.nmfa001
                  
               IF l_n > 0 THEN
                                 
                  LET g_master.nmfa005 = 0      LET g_master.nmfa006 = 0
                  LET g_master.nmfa007 = 0      LET g_master.nmfa008 = 0
                  LET g_master.nmfa004 = 0
                  SELECT nmfa005,nmfa006,nmfa007,nmfa008,nmfa004
                    INTO g_master.nmfa005,g_master.nmfa006,g_master.nmfa007,
                         g_master.nmfa008,g_master.nmfa004
                    FROM nmfa_t
                   WHERE nmfaent = g_enterprise
                     AND nmfa001 = g_master.nmfa001

                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.nmfa001
                  CALL ap_ref_array2(g_ref_fields,"SELECT nmfal003 FROM nmfal_t WHERE nmfalent = '"||g_enterprise||"' AND nmfal001 = ? AND nmfal002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.nmfal001 = '', g_rtn_fields[1] , ''
                  
                  CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",FALSE)
               ELSE
                  LET g_master.nmfal001 = ''
                  LET g_master.nmfa005 = ''
                  LET g_master.nmfa006 = ''
                  LET g_master.nmfa007 = ''
                  LET g_master.nmfa008 = ''
                  LET g_master.nmfa004 = ''
                  CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",TRUE)
               END IF
               
               #如果有资料,是否删除重新产生
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM nmfd_t
                WHERE nmfdent = g_enterprise
                  AND nmfd001 = g_master.nmfa001
                  
               IF l_n > 0 THEN 
                  IF NOT cl_ask_confirm("anm-02979") THEN
                     LET g_master.nmfal001 = ''
                     LET g_master.nmfa005 = ''
                     LET g_master.nmfa006 = ''
                     LET g_master.nmfa007 = ''
                     LET g_master.nmfa008 = ''
                     LET g_master.nmfa004 = ''
                     CALL cl_set_comp_entry("nmfa004,nmfa005,nmfa006,nmfa007,nmfa008",TRUE)
                     NEXT FIELD nmfa001 
                  ELSE
                     LET g_flag = 'Y'
                  END IF
               END IF
               
               DISPLAY g_master.nmfa005,g_master.nmfa006,g_master.nmfa007,
                       g_master.nmfa008,g_master.nmfa004,g_master.nmfal001
                    TO nmfa005,nmfa006,nmfa007,nmfa008,nmfa004,nmfal001
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa001
            #add-point:ON CHANGE nmfa001 name="input.g.nmfa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfal001
            #add-point:BEFORE FIELD nmfal001 name="input.b.nmfal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfal001
            
            #add-point:AFTER FIELD nmfal001 name="input.a.nmfal001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfal001
            #add-point:ON CHANGE nmfal001 name="input.g.nmfal001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa005
            #add-point:BEFORE FIELD nmfa005 name="input.b.nmfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa005
            
            #add-point:AFTER FIELD nmfa005 name="input.a.nmfa005"
            IF NOT cl_null(g_master.nmfa005) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmfa005

               #160318-00025#36  2016/04/20  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#36  2016/04/20  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_master.nmfa005 = ''
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa005
            #add-point:ON CHANGE nmfa005 name="input.g.nmfa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa006
            #add-point:BEFORE FIELD nmfa006 name="input.b.nmfa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa006
            
            #add-point:AFTER FIELD nmfa006 name="input.a.nmfa006"
            IF NOT cl_null(g_master.nmfa006) AND NOT cl_null(g_master.nmfa007) THEN 
               IF g_master.nmfa006 > g_master.nmfa007 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00116'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.nmfa006 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa006
            #add-point:ON CHANGE nmfa006 name="input.g.nmfa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa007
            #add-point:BEFORE FIELD nmfa007 name="input.b.nmfa007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa007
            
            #add-point:AFTER FIELD nmfa007 name="input.a.nmfa007"
            IF NOT cl_null(g_master.nmfa006) AND NOT cl_null(g_master.nmfa007) THEN 
               IF g_master.nmfa007 < g_master.nmfa006 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00117'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.nmfa007 = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa007
            #add-point:ON CHANGE nmfa007 name="input.g.nmfa007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.nmfa008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD nmfa008
            END IF 
 
 
 
            #add-point:AFTER FIELD nmfa008 name="input.a.nmfa008"
            IF NOT cl_null(g_master.nmfa008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa008
            #add-point:BEFORE FIELD nmfa008 name="input.b.nmfa008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa008
            #add-point:ON CHANGE nmfa008 name="input.g.nmfa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfa004
            #add-point:BEFORE FIELD nmfa004 name="input.b.nmfa004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfa004
            
            #add-point:AFTER FIELD nmfa004 name="input.a.nmfa004"
            IF NOT cl_null(g_master.nmfa004) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.nmfa004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmbd001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_master.nmfa004 = ''
                  NEXT FIELD CURRENT
               END IF
            

            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmfa004
            #add-point:ON CHANGE nmfa004 name="input.g.nmfa004"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.nmfa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa009
            #add-point:ON ACTION controlp INFIELD nmfa009 name="input.c.nmfa009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.nmfa009       
            CALL q_ooef001()                                
            LET g_master.nmfa009 = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_master.nmfa009) RETURNING g_master.nmfa009_desc
            DISPLAY BY NAME g_master.nmfa009,g_master.nmfa009_desc 
            NEXT FIELD nmfa009
            #END add-point
 
 
         #Ctrlp:input.c.nmfa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa002
            #add-point:ON ACTION controlp INFIELD nmfa002 name="input.c.nmfa002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.nmfa002       
            CALL q_ooeb005_3()                                
            LET g_master.nmfa002 = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_master.nmfa002) RETURNING g_master.nmfa002_desc
            DISPLAY BY NAME g_master.nmfa009,g_master.nmfa002_desc 
            NEXT FIELD nmfa002
            #END add-point
 
 
         #Ctrlp:input.c.nmfa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa003
            #add-point:ON ACTION controlp INFIELD nmfa003 name="input.c.nmfa003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.nmfa003 
            LET g_qryparam.where = " ooeb004 = '6' AND ooeb005 = '",g_master.nmfa002,"'"
            CALL q_ooeb006_1()                                
            LET g_master.nmfa003 = g_qryparam.return1        
            NEXT FIELD nmfa003
            #END add-point
 
 
         #Ctrlp:input.c.nmfa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa001
            #add-point:ON ACTION controlp INFIELD nmfa001 name="input.c.nmfa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmfal001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfal001
            #add-point:ON ACTION controlp INFIELD nmfal001 name="input.c.nmfal001"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa005
            #add-point:ON ACTION controlp INFIELD nmfa005 name="input.c.nmfa005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.nmfa005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_aooi001_1()                                #呼叫開窗

            LET g_master.nmfa005 = g_qryparam.return1              

            DISPLAY g_master.nmfa005 TO nmfa005              #

            NEXT FIELD nmfa005       
            #END add-point
 
 
         #Ctrlp:input.c.nmfa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa006
            #add-point:ON ACTION controlp INFIELD nmfa006 name="input.c.nmfa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmfa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa007
            #add-point:ON ACTION controlp INFIELD nmfa007 name="input.c.nmfa007"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmfa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa008
            #add-point:ON ACTION controlp INFIELD nmfa008 name="input.c.nmfa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmfa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfa004
            #add-point:ON ACTION controlp INFIELD nmfa004 name="input.c.nmfa004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.nmfa004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_nmbd001()                                #呼叫開窗

            LET g_master.nmfa004 = g_qryparam.return1              

            DISPLAY g_master.nmfa004 TO nmfa004              #

            NEXT FIELD nmfa004    
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON nmfal001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmfal001
            #add-point:BEFORE FIELD nmfal001 name="construct.b.nmfal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmfal001
            
            #add-point:AFTER FIELD nmfal001 name="construct.a.nmfal001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmfal001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmfal001
            #add-point:ON ACTION controlp INFIELD nmfal001 name="construct.c.nmfal001"
            
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
            CALL anmp900_get_buffer(l_dialog)
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
         CALL anmp900_init()
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
                 CALL anmp900_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmp900_transfer_argv(ls_js)
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
 
{<section id="anmp900.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmp900_transfer_argv(ls_js)
 
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
 
{<section id="anmp900.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmp900_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
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
#  DECLARE anmp900_process_cs CURSOR FROM ls_sql
#  FOREACH anmp900_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_transaction_begin()
      #IF s_transaction_chk("N",0) THEN
      #   CALL s_transaction_begin()
      #END IF 
      CALL cl_err_collect_init()
      
      IF g_flag = 'Y' THEN 
         DELETE FROM nmfd_t
          WHERE nmfdent = g_enterprise
            AND nmfd001 = g_master.nmfa001
            
         IF SQLCA.SQLCODE THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
      END IF
      
      CALL s_anmp900_p(g_master.*) RETURNING l_success
      IF l_success = TRUE THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      CALL cl_err_collect_show()
      CALL anmp900_clear()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL anmp900_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp900.get_buffer" >}
PRIVATE FUNCTION anmp900_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.nmfa009 = p_dialog.getFieldBuffer('nmfa009')
   LET g_master.nmfa002 = p_dialog.getFieldBuffer('nmfa002')
   LET g_master.nmfa003 = p_dialog.getFieldBuffer('nmfa003')
   LET g_master.nmfa001 = p_dialog.getFieldBuffer('nmfa001')
   LET g_master.nmfal001 = p_dialog.getFieldBuffer('nmfal001')
   LET g_master.nmfa005 = p_dialog.getFieldBuffer('nmfa005')
   LET g_master.nmfa006 = p_dialog.getFieldBuffer('nmfa006')
   LET g_master.nmfa007 = p_dialog.getFieldBuffer('nmfa007')
   LET g_master.nmfa008 = p_dialog.getFieldBuffer('nmfa008')
   LET g_master.nmfa004 = p_dialog.getFieldBuffer('nmfa004')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmp900.msgcentre_notify" >}
PRIVATE FUNCTION anmp900_msgcentre_notify()
 
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
 
{<section id="anmp900.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 給默認值/清空畫面重新給默認值
PRIVATE FUNCTION anmp900_clear()
   WHENEVER ERROR CONTINUE
   INITIALIZE g_master.* TO NULL
   
   LET g_master.nmfa009 = g_site
   CALL s_desc_get_department_desc(g_master.nmfa009) RETURNING g_master.nmfa009_desc
   DISPLAY g_master.nmfa009_desc TO nmfa009_desc
   
   LET g_master.nmfa002 = g_site
   CALL s_desc_get_department_desc(g_master.nmfa002) RETURNING g_master.nmfa002_desc
   DISPLAY g_master.nmfa009_desc TO nmfa002_desc
   
   SELECT MAX(ooeb006) INTO g_master.nmfa003
     FROM ooeb_t
    WHERE ooebent = g_enterprise
      AND ooeb004 = '6'
      AND ooeb005 = g_master.nmfa002
END FUNCTION

#end add-point
 
{</section>}
 
