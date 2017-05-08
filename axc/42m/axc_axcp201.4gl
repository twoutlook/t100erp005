#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp201.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2014-09-12 13:35:28), PR版次:0009(2017-02-28 17:47:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000079
#+ Filename...: axcp201
#+ Description: 期末人工製費金額統計作業
#+ Creator....: 00537(2014-07-28 09:16:12)
#+ Modifier...: 00537 -SD/PR- 05423
 
{</section>}
 
{<section id="axcp201.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#8   2016/04/21 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160819-00003#1   2016/08/24 By Ann_Huang   補上分摊方式4.报工数量*分摊权数的逻辑
#161019-00033#1   2016/10/20 By 02295      应检查计算的年度+期别在成本关账日期之后（S-FIN-6012）
#161117-00031#1   2016/11/18 By 02295    将判断条件小于等于改成等于
#170217-00025#6   2017/02/28 By zhujing  整批调整未产生数据时，提示消息修正。
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
       xcbjcomp LIKE type_t.chr10, 
   xcbjcomp_desc LIKE type_t.chr80, 
   xcbjld LIKE type_t.chr5, 
   xcbjld_desc LIKE type_t.chr80, 
   xcbj001 LIKE type_t.chr10, 
   xcbj001_desc LIKE type_t.chr80, 
   xcbj002 LIKE type_t.num5, 
   xcbj003 LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_sql1                STRING        #組 sql 用
DEFINE g_flag                LIKE type_t.num5   #170217-00025#6 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp201.main" >}
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
      CALL axcp201_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp201 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp201_init()
 
      #進入選單 Menu (="N")
      CALL axcp201_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp201
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp201.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp201_init()
 
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
 
{<section id="axcp201.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp201_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcbjcomp,g_master.xcbjld,g_master.xcbj001,g_master.xcbj002,g_master.xcbj003  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL s_axc_set_site_default() RETURNING g_master.xcbjcomp,g_master.xcbjld,g_master.xcbj002,g_master.xcbj003,g_master.xcbj001
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcbjcomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcbjcomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcbjcomp_desc
               
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcbjld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcbjld_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcbjld_desc
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcbj001
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcbj001_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcbj001_desc             
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjcomp
            
            #add-point:AFTER FIELD xcbjcomp name="input.a.xcbjcomp"
            IF NOT cl_null(g_master.xcbjcomp) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcbjcomp
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            
            END IF 
            
            SELECT glaald INTO g_master.xcbjld
              FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_master.xcbjcomp
               AND glaa014 = 'Y'
 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcbjld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcbjld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcbjld_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcbjcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcbjcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcbjcomp_desc
           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjcomp
            #add-point:BEFORE FIELD xcbjcomp name="input.b.xcbjcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbjcomp
            #add-point:ON CHANGE xcbjcomp name="input.g.xcbjcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbjld
            
            #add-point:AFTER FIELD xcbjld name="input.a.xcbjld"
            IF NOT cl_null(g_master.xcbjld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcbjld
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#8--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_ld_chk_authorization(g_user,g_master.xcbjld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_master.xcbjld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_master.xcbjld = ''
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcbjld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcbjld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcbjld_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbjld
            #add-point:BEFORE FIELD xcbjld name="input.b.xcbjld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbjld
            #add-point:ON CHANGE xcbjld name="input.g.xcbjld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj001
            
            #add-point:AFTER FIELD xcbj001 name="input.a.xcbj001"
            IF NOT cl_null(g_master.xcbj001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcbj001
               #160318-00025#8--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#8--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcbj001
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcbj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcbj001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj001
            #add-point:BEFORE FIELD xcbj001 name="input.b.xcbj001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj001
            #add-point:ON CHANGE xcbj001 name="input.g.xcbj001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj002
            #add-point:BEFORE FIELD xcbj002 name="input.b.xcbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj002
            
            #add-point:AFTER FIELD xcbj002 name="input.a.xcbj002"
            #161019-00033#1---add---s
            CALL axcp201_date_chk()
            IF NOT cl_null(g_errno) THEN
               LET g_errparam.extend = g_master.xcbj002
               LET g_errparam.code   = g_errno
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT                       
            END IF      
            #161019-00033#1---add---e  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj002
            #add-point:ON CHANGE xcbj002 name="input.g.xcbj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbj003
            #add-point:BEFORE FIELD xcbj003 name="input.b.xcbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbj003
            
            #add-point:AFTER FIELD xcbj003 name="input.a.xcbj003"
            #161019-00033#1---add---s
            CALL axcp201_date_chk()
            IF NOT cl_null(g_errno) THEN
               LET g_errparam.extend = g_master.xcbj003
               LET g_errparam.code   = g_errno
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT                       
            END IF      
            #161019-00033#1---add---e  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcbj003
            #add-point:ON CHANGE xcbj003 name="input.g.xcbj003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcbjcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjcomp
            #add-point:ON ACTION controlp INFIELD xcbjcomp name="input.c.xcbjcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcbjcomp             #給予default值

            #給予arg
            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_master.xcbjcomp = g_qryparam.return1              

            DISPLAY g_master.xcbjcomp TO xcbjcomp              #

            NEXT FIELD xcbjcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbjld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbjld
            #add-point:ON ACTION controlp INFIELD xcbjld name="input.c.xcbjld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcbjld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF g_master.xcbjcomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_master.xcbjcomp,"'"
            END IF            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.xcbjld = g_qryparam.return1              

            DISPLAY g_master.xcbjld TO xcbjld              #

            NEXT FIELD xcbjld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj001
            #add-point:ON ACTION controlp INFIELD xcbj001 name="input.c.xcbj001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcbj001             #給予default值

            #給予arg
            
            CALL q_xcat001()                                #呼叫開窗

            LET g_master.xcbj001 = g_qryparam.return1              

            DISPLAY g_master.xcbj001 TO xcbj001              #

            NEXT FIELD xcbj001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj002
            #add-point:ON ACTION controlp INFIELD xcbj002 name="input.c.xcbj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbj003
            #add-point:ON ACTION controlp INFIELD xcbj003 name="input.c.xcbj003"
            
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
            CALL axcp201_get_buffer(l_dialog)
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
            INITIALIZE g_master.* TO NULL
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
         CALL axcp201_init()
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
                 CALL axcp201_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp201_transfer_argv(ls_js)
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
 
{<section id="axcp201.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp201_transfer_argv(ls_js)
 
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
 
{<section id="axcp201.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp201_process(ls_js)
 
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
      CALL cl_progress_bar_no_window(5)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp201_process_cs CURSOR FROM ls_sql
#  FOREACH axcp201_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF NOT axcp201_create_tmp_table() THEN
         RETURN
      END IF
      CALL s_transaction_begin()
      LET g_flag = FALSE   #170217-00025#6 add
      IF NOT axcp201_gen() THEN
         CALL s_transaction_end('N',1)
         CALL axcp201_drop_tmp_table()
         RETURN
      END IF
      #170217-00025#6 add-S
      IF g_flag = FALSE THEN
         CALL s_transaction_end('N',1)  #事务结束
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN        
      END IF
      #170217-00025#6 add-E
      CALL s_transaction_end('Y',1)
      CALL axcp201_drop_tmp_table()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      IF NOT axcp201_create_tmp_table() THEN
         RETURN
      END IF
      CALL s_transaction_begin()
      IF NOT axcp201_gen() THEN
         CALL s_transaction_end('N',0)
         CALL axcp201_drop_tmp_table()
         RETURN
      END IF
      #170217-00025#6 add-S
      IF g_flag = FALSE THEN
         CALL s_transaction_end('N',1)  #事务结束
         RETURN        
      END IF
      #170217-00025#6 add-E
      CALL s_transaction_end('Y',0)
      CALL axcp201_drop_tmp_table()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp201_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp201.get_buffer" >}
PRIVATE FUNCTION axcp201_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcbjcomp = p_dialog.getFieldBuffer('xcbjcomp')
   LET g_master.xcbjld = p_dialog.getFieldBuffer('xcbjld')
   LET g_master.xcbj001 = p_dialog.getFieldBuffer('xcbj001')
   LET g_master.xcbj002 = p_dialog.getFieldBuffer('xcbj002')
   LET g_master.xcbj003 = p_dialog.getFieldBuffer('xcbj003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp201.msgcentre_notify" >}
PRIVATE FUNCTION axcp201_msgcentre_notify()
 
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
 
{<section id="axcp201.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 删除，再产生下一步使用的成本资料
# Memo...........:
# Usage..........: CALL axcp201_gen()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/07/31 By wujie
# Modify.........: 因为集中情况的处理逻辑除了table有差异，别的完全一样，所以只写一个公用的函数
################################################################################
PRIVATE FUNCTION axcp201_gen()
   DEFINE r_success         LIKE type_t.num5
   DEFINE g_time1           DATETIME YEAR TO SECOND
   DEFINE l_flag1           LIKE type_t.chr1
   DEFINE l_errno           LIKE type_t.chr100
   DEFINE l_glav002         LIKE glav_t.glav002
   DEFINE l_glav005         LIKE glav_t.glav005
   DEFINE l_bdate           LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_edate           LIKE glav_t.glav004
   DEFINE l_sdate_s         LIKE glav_t.glav004
   DEFINE l_sdate_e         LIKE glav_t.glav004
   DEFINE l_glav006         LIKE glav_t.glav006
   DEFINE l_glav007         LIKE glav_t.glav007
   DEFINE l_wdate_s         LIKE glav_t.glav004
   DEFINE l_wdate_e         LIKE glav_t.glav004
   DEFINE l_glaa003         LIKE glaa_t.glaa003



   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET g_time1 = cl_get_current()
   #检查是否在事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

#1:删除旧资料
#      删除条件：帐套+成本计算类型+年度+期别
   LET g_sql = "DELETE FROM xcbj_t",
               " WHERE xcbjent = '",g_enterprise,"'",
               "   AND xcbjld  = '",g_master.xcbjld,"'",
               "   AND xcbj001 = '",g_master.xcbj001,"'",
               "   AND xcbj002 = '",g_master.xcbj002,"'",
               "   AND xcbj003 = '",g_master.xcbj003,"'"

   PREPARE axcp201_del_pb FROM g_sql 

   EXECUTE axcp201_del_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'DELETE xcbj FILE'
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素
      CALL axcp201_replace_sql()
      PREPARE axcp201_del_pb1 FROM g_sql 
      
      EXECUTE axcp201_del_pb1
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'DELETE xcdr FILE'
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   CALL cl_progress_no_window_ing("delete original file")               
#2:抓取费用金额
#      抓取条件：集团+帐套+年度+期别
#      分组条件：集团+帐套+年度+期别+成本中心+成本主（次）要素(费用分类)+分摊方式
#      抓取来源：“人工制费收集作业axct201”，档案为xcbl_t
#      抓取对象：抓取分摊成本SUM(xcbl100\xcbl110\xcbl120)
#      存入对象：存入费用总额(三个费用总额以xcbj为例：xcbj101\xcbj111\xcbj121)
   LET g_sql1= " SELECT xcblent,xcblld,xcbl001,xcbl002,xcbl003,xcbl004,xcbl005,SUM(xcbl100) xcbl100,SUM(xcbl110) xcbl110,SUM(xcbl120) xcbl120 ",
               "   FROM xcbl_t ",
               "  WHERE xcblent = '",g_enterprise,"'",
               "    AND xcblld  = '",g_master.xcbjld,"'",
               "    AND xcbl002 = '",g_master.xcbj002,"'",
               "    AND xcbl003 = '",g_master.xcbj003,"'",
               "  GROUP BY xcblent,xcblld,xcbl001,xcbl002,xcbl003,xcbl004,xcbl005 "               
#更新的sql分两段写，为了debug方便，可以直接拿上端的sql来检查是否能查到资料，分两段写对最后sql执行效率没影响               
   LET g_sql1= " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcblent AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbj005 = T2.xcbl001 AND T1.xcbj002 = T2.xcbl002 ",
               "        AND T1.xcbj003 = T2.xcbl003 AND T1.xcbj004  = T2.xcbl004 ",
               "        AND T1.xcbj006 = T2.xcbl005 ) ",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj101 = T2.xcbl100,",  #正常不该走进这里，因为前面删除了xcbj了！
               "                              T1.xcbj111 = T2.xcbl110,",
               "                              T1.xcbj121 = T2.xcbl120 ",
               " WHEN NOT MATCHED THEN INSERT VALUES(T2.xcblent,'",g_master.xcbjcomp,"',T2.xcblld,'",g_master.xcbj001,"',",
               "                                     T2.xcbl002,T2.xcbl003,T2.xcbl004,T2.xcbl001,T2.xcbl005,2,' ',",                 #截止为会计科目栏位，写这个是为了便于分辨插入栏位的对应位置，不然从头数起太累了
               "                                     0,0,T2.xcbl100,0,0,0,0,T2.xcbl110,0,0,0,0,T2.xcbl120,0,0,0,0 "     #从分摊基础指标总和到单位成本栏位，共17个
               
   LET g_sql = g_sql1,",'",g_user,"','",g_dept,"','",g_user,"','",g_dept,"','",g_today,"','','','N',",
               "'','','','','',",   #追加自定义栏位
               "'','','','','',",
               "'','','','','',",
               "'','','','','',",
               "'','','','','',",
               "'','','','',''",
               ")"

   PREPARE axcp201_merge_pb FROM g_sql 

   EXECUTE axcp201_merge_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD COST xcbj'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   UPDATE axcp201_xcbj_tmp SET xcbj005 = ' ' WHERE xcbj005 IS NULL   #预防万一传入null的成本要素   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      LET g_sql = g_sql1,               
               ",'','','','','',",   #追加自定义栏位
               "'','','','','',",
               "'','','','','',",
               "'','','','','',",
               "'','','','','',",
               "'','','','',''",
               ")"
      CALL axcp201_replace_sql()
      PREPARE axcp201_merge_pb1 FROM g_sql 
      
      EXECUTE axcp201_merge_pb1
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD COST xcdr'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      UPDATE axcp201_xcdr_tmp SET xcdr005 = ' ' WHERE xcdr005 IS NULL   #预防万一传入null的成本要素
   END IF
   CALL cl_progress_no_window_ing("get tmp file")
#3:抓取分摊指标数
#      抓取条件：集团+法人+年度+期别(与日期xcbh001对应)+成本中心（与xcbj关联时需要）
#      分组条件：集团+法人+成本中心
#      抓取来源：axct200工时收集档(xcbh_t/xcbi_t)/axct203工时收集档(xcbq_t/xcbr_t)
#      抓取对象：实际工时sum(xcbi201)/机时sum(xcbi202)和标准工时sum(xcbi203)/机时(xcbi204)
#      存入对象：  如果"分摊方式xcbj006"="实际工时"，则分摊基础指标总数xcbj020=实际工时SUM（xcbi201）
#                 如果"分摊方式xcbj006"="实际机时"，则分摊基础指标总数xcbj020=实际机时SUM（xcbi202）
#                 如果"分摊方式xcbj006"="标准工时"，则分摊基础指标总数xcbj020=标准工时SUM（xcbi203）
#                 如果"分摊方式xcbj006"="标准机时"，则分摊基础指标总数xcbj020=标准机时SUM（xcbi204）
#                 如果"分摊方式xcbj006"="实际工时"，则标准产能xcbj021=标准工时SUM（xcbi203）
#                 如果"分摊方式xcbj006"="标准工时"，则标准产能xcbj021=标准工时SUM（xcbi203)
#                 如果"分摊方式xcbj006"="实际机时"，则标准产能xcbj021=标准工时SUM（xcbi204)
#                 如果"分摊方式xcbj006"="标准机时"，则标准产能xcbj021=标准工时SUM（xcbi204)

#抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_master.xcbjcomp
      AND glaa014  = 'Y'  
#取得画面上年期的开始截止日期
   CALL s_get_accdate(l_glaa003,'',g_master.xcbj002,g_master.xcbj003)
     RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
               l_glav006,l_bdate,l_edate,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = 'get bdate/edate'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
      RETURN r_success
   END IF 

   
  #LET g_sql1 = " SELECT xcbient,xcbicomp,xcbi001,SUM(xcbi201) xcbi201,SUM(xcbi202) xcbi202,SUM(xcbi203) xcbi203,SUM(xcbi204) xcbi204 ", #160819-00003#1 mark
   LET g_sql1 = " SELECT xcbient,xcbicomp,xcbi001,SUM(xcbi201) xcbi201,SUM(xcbi202) xcbi202,SUM(xcbi203) xcbi203,SUM(xcbi204) xcbi204,SUM(xcbi104) xcbi104 ",  #160819-00003#1 add
               "   FROM xcbh_t,xcbi_t ",
               "  WHERE xcbhent   = xcbient ",
               "    AND xcbhdocno = xcbidocno ",
               "    AND xcbhstus  = 'Y' ",
               "    AND xcbient   = '",g_enterprise,"'",
               "    AND xcbicomp  = '",g_master.xcbjcomp,"'",
               "    AND xcbh001 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               "  GROUP BY xcbient,xcbicomp,xcbi001 "

#实际工时 xcbj006 = 1
   LET g_sql = " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcbient ",#AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbjcomp = T2.xcbicomp AND T1.xcbj004 = T2.xcbi001 ",
               "        AND T1.xcbj002 = '",g_master.xcbj002,"' AND T1.xcbj003  = '",g_master.xcbj003,"' )",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj020 = T2.xcbi201,T1.xcbj021 = T2.xcbi203",  
               "                    WHERE T1.xcbj006 = '1' "  

   
   PREPARE axcp201_merge_pb2 FROM g_sql 

   EXECUTE axcp201_merge_pb2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj020/xcbj021'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时        
      CALL axcp201_replace_sql()
      
      PREPARE axcp201_merge_pb3 FROM g_sql 
      
      EXECUTE axcp201_merge_pb3
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr020/xcdr021'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF
#标准工时 xcbj006 = 2  
   LET g_sql = " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcbient ",#AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbjcomp = T2.xcbicomp AND T1.xcbj004 = T2.xcbi001 ",
               "        AND T1.xcbj002 = '",g_master.xcbj002,"' AND T1.xcbj003  = '",g_master.xcbj003,"' )",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj020 = T2.xcbi203,T1.xcbj021 = T2.xcbi203",  
               "                    WHERE T1.xcbj006 = '2' "  

   PREPARE axcp201_merge_pb4 FROM g_sql 

   EXECUTE axcp201_merge_pb4
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj020/xcbj021'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_merge_pb5 FROM g_sql 
      
      EXECUTE axcp201_merge_pb5
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr020/xcdr021'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF
#标准机时 xcbj006 = 3 
   LET g_sql = " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcbient ",#AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbjcomp = T2.xcbicomp AND T1.xcbj004 = T2.xcbi001 ",
               "        AND T1.xcbj002 = '",g_master.xcbj002,"' AND T1.xcbj003  = '",g_master.xcbj003,"' )",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj020 = T2.xcbi204,T1.xcbj021 = T2.xcbi204",  
               "                    WHERE T1.xcbj006 = '3' "  
  
   PREPARE axcp201_merge_pb6 FROM g_sql 

   EXECUTE axcp201_merge_pb6
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj020/xcbj021'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_merge_pb7 FROM g_sql 
      
      EXECUTE axcp201_merge_pb7
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr020/xcdr021'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END IF
   
   
   #160819-00003#1-(S) add
#标准机时 xcbj006 = 4 
   LET g_sql = " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcbient ",#AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbjcomp = T2.xcbicomp AND T1.xcbj004 = T2.xcbi001 ",
               "        AND T1.xcbj002 = '",g_master.xcbj002,"' AND T1.xcbj003  = '",g_master.xcbj003,"' )",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj020 = T2.xcbi104,T1.xcbj021 = T2.xcbi104",
               "                    WHERE T1.xcbj006 = '4' "

   PREPARE axcp201_merge_pb4_1 FROM g_sql

   EXECUTE axcp201_merge_pb4_1

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj020/xcbj021'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_merge_pb4_2 FROM g_sql

      EXECUTE axcp201_merge_pb4_2

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr020/xcdr021'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   #160819-00003#1-(E) add
   
#实际机时 xcbj006 = 5 
   LET g_sql = " MERGE INTO  axcp201_xcbj_tmp T1 ",
               " USING (",g_sql1,") T2 ",
               "    ON (T1.xcbjent = T2.xcbient ",#AND T1.xcbjld = T2.xcblld ",
               "        AND T1.xcbjcomp = T2.xcbicomp AND T1.xcbj004 = T2.xcbi001 ",
               "        AND T1.xcbj002 = '",g_master.xcbj002,"' AND T1.xcbj003  = '",g_master.xcbj003,"' )",
               " WHEN MATCHED THEN UPDATE SET T1.xcbj020 = T2.xcbi202,T1.xcbj021 = T2.xcbi204",  
               "                    WHERE T1.xcbj006 = '5' "  
   
   PREPARE axcp201_merge_pb8 FROM g_sql 

   EXECUTE axcp201_merge_pb8
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj020/xcbj021'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_merge_pb9 FROM g_sql 
      
      EXECUTE axcp201_merge_pb9
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr020/xcdr021'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF
   CALL cl_progress_no_window_ing("upd tmp file")

#4:计算分摊费用和单位成本
#固定费用（已在步骤2更新）
#闲置费用=0 同上

#分摊金额(xcbj103/xcbj113/xcbj123)=费用总额(xcbj101/xcbj111/xcbj121)-闲置费用(xcbj104/xcbj114/xcbj124)
   LET g_sql = " UPDATE axcp201_xcbj_tmp SET xcbj103 = xcbj101-xcbj104,xcbj113 = xcbj111-xcbj114,xcbj123 = xcbj121-xcbj124 "

   PREPARE axcp201_upd_pb4 FROM g_sql 

   EXECUTE axcp201_upd_pb4
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj103/xcbj113/xcbj123'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
     CALL axcp201_replace_sql()
     PREPARE axcp201_upd_pb5 FROM g_sql 

     EXECUTE axcp201_upd_pb5
   
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'UPD xcdr103/xcdr113/xcdr123'
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success
    END IF   
   END IF
#单位成本(xcbj105/xcbj115/xcbj125)=分摊金额(xcbj104/xcbj114/xcbj124)/分摊基础指标总数(xcbj020)
   LET g_sql = " UPDATE axcp201_xcbj_tmp SET xcbj105 = xcbj103/xcbj020,xcbj115 = xcbj113/xcbj020,xcbj125 = xcbj123/xcbj020 ",
               "  WHERE xcbj020 <> 0 "   #因为0不能做分母，xcbj020 = 0 的那些资料，默认已经处理成本单位= 0 了，所以这里排除也不影响

   PREPARE axcp201_upd_pb6 FROM g_sql 

   EXECUTE axcp201_upd_pb6
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPD xcbj105/xcbj115/xcbj125'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_upd_pb7 FROM g_sql 
      
      EXECUTE axcp201_upd_pb7
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD xcdr105/xcdr115/xcdr125'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF
   CALL cl_progress_no_window_ing("upd tmp file")
#5:其他字段给值逻辑  制费类别(xcbj010)/会计科目(xcbj011)
#已在步骤2处理
   
#将临时表插入正式表
   LET g_sql = " INSERT INTO xcbj_t SELECT * FROM axcp201_xcbj_tmp "

   PREPARE axcp201_ins_pb FROM g_sql 

   EXECUTE axcp201_ins_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INS xcbj'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #170217-00025#6 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag =TRUE
   END IF
   #170217-00025#6 add-E
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #启用成本次要素时
      CALL axcp201_replace_sql()
      PREPARE axcp201_ins_pb1 FROM g_sql 
      
      EXECUTE axcp201_ins_pb1
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INS xcdr'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
      #170217-00025#6 add-S
      IF SQLCA.sqlerrd[3] > 0 THEN
         LET g_flag =TRUE
      END IF
      #170217-00025#6 add-E
   END IF
   CALL cl_progress_no_window_ing("insert from tmp file")
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
PRIVATE FUNCTION axcp201_create_tmp_table()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE axcp201_xcbj_tmp;
   CREATE TEMP TABLE axcp201_xcbj_tmp(
         xcbjent             SMALLINT,                         #企業編號
         xcbjcomp            VARCHAR(10),                        #組織編號
         xcbjld              VARCHAR(5),                          #帳別    
         xcbj001             VARCHAR(10),                         #一般編號
         xcbj002             SMALLINT,                         #年度    
         xcbj003             SMALLINT,                         #期別    
         xcbj004             VARCHAR(10),                         #一般編號
         xcbj005             VARCHAR(1),                         #一般flag
         xcbj006             VARCHAR(1),                         #一般flag
         xcbj010             VARCHAR(1),                         #一般flag
         xcbj011             VARCHAR(24),                         #科目編號
         xcbj020             DECIMAL(20,6),                         #數量    
         xcbj021             DECIMAL(20,6),                         #數量    
         xcbj101             DECIMAL(20,6),                         #金額    
         xcbj102             DECIMAL(20,6),                         #金額    
         xcbj103             DECIMAL(20,6),                         #金額    
         xcbj104             DECIMAL(20,6),                         #金額    
         xcbj105             DECIMAL(20,6),                         #金額    
         xcbj111             DECIMAL(20,6),                         #金額    
         xcbj112             DECIMAL(20,6),                         #金額    
         xcbj113             DECIMAL(20,6),                         #金額    
         xcbj114             DECIMAL(20,6),                         #金額    
         xcbj115             DECIMAL(20,6),                         #金額    
         xcbj121             DECIMAL(20,6),                         #金額    
         xcbj122             DECIMAL(20,6),                         #金額            
         xcbj123             DECIMAL(20,6),                         #金額          
         xcbj124             DECIMAL(20,6),                         #金額     
         xcbj125             DECIMAL(20,6),                         #金額     
         xcbjownid           VARCHAR(20),                       #人員代碼 
         xcbjowndp           VARCHAR(10),                       #組織編號 
         xcbjcrtid           VARCHAR(20),                       #人員代碼 
         xcbjcrtdp           VARCHAR(10),                       #組織編號 
         xcbjcrtdt           DATETIME YEAR TO SECOND,                       #日期時間 
         xcbjmodid           VARCHAR(20),                       #人員代碼 
         xcbjmoddt           DATETIME YEAR TO SECOND,                       #日期時間 
         xcbjstus            VARCHAR(10),                        #狀態碼
         xcbjud001           VARCHAR(40),
         xcbjud002           VARCHAR(40),
         xcbjud003           VARCHAR(40),
         xcbjud004           VARCHAR(40),
         xcbjud005           VARCHAR(40),
         xcbjud006           VARCHAR(40),
         xcbjud007           VARCHAR(40),
         xcbjud008           VARCHAR(40),
         xcbjud009           VARCHAR(40),
         xcbjud010           VARCHAR(40),
         xcbjud011           DECIMAL(20,6),
         xcbjud012           DECIMAL(20,6),
         xcbjud013           DECIMAL(20,6),
         xcbjud014           DECIMAL(20,6),
         xcbjud015           DECIMAL(20,6),
         xcbjud016           DECIMAL(20,6),
         xcbjud017           DECIMAL(20,6),
         xcbjud018           DECIMAL(20,6),
         xcbjud019           DECIMAL(20,6),
         xcbjud020           DECIMAL(20,6),
         xcbjud021           DATETIME YEAR TO SECOND,
         xcbjud022           DATETIME YEAR TO SECOND,
         xcbjud023           DATETIME YEAR TO SECOND,
         xcbjud024           DATETIME YEAR TO SECOND,
         xcbjud025           DATETIME YEAR TO SECOND,
         xcbjud026           DATETIME YEAR TO SECOND,
         xcbjud027           DATETIME YEAR TO SECOND,
         xcbjud028           DATETIME YEAR TO SECOND,
         xcbjud029           DATETIME YEAR TO SECOND,
         xcbjud030           DATETIME YEAR TO SECOND
   );
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   
   DROP TABLE axcp201_xcdr_tmp;
   CREATE TEMP TABLE axcp201_xcdr_tmp(
         xcdrent             SMALLINT,                         #企業編號
         xcdrcomp            VARCHAR(10),                        #組織編號
         xcdrld              VARCHAR(5),                          #帳別    
         xcdr001             VARCHAR(10),                         #一般編號
         xcdr002             SMALLINT,                         #年度    
         xcdr003             SMALLINT,                         #期別    
         xcdr004             VARCHAR(10),                         #一般編號
         xcdr005             VARCHAR(10),                         #一般flag
         xcdr006             VARCHAR(1),                         #一般flag
         xcdr010             VARCHAR(1),                         #一般flag
         xcdr011             VARCHAR(24),                         #科目編號
         xcdr020             DECIMAL(20,6),                         #數量    
         xcdr021             DECIMAL(20,6),                         #數量    
         xcdr101             DECIMAL(20,6),                         #金額    
         xcdr102             DECIMAL(20,6),                         #金額    
         xcdr103             DECIMAL(20,6),                         #金額    
         xcdr104             DECIMAL(20,6),                         #金額    
         xcdr105             DECIMAL(20,6),                         #金額    
         xcdr111             DECIMAL(20,6),                         #金額    
         xcdr112             DECIMAL(20,6),                         #金額    
         xcdr113             DECIMAL(20,6),                         #金額    
         xcdr114             DECIMAL(20,6),                         #金額    
         xcdr115             DECIMAL(20,6),                         #金額    
         xcdr121             DECIMAL(20,6),                         #金額    
         xcdr122             DECIMAL(20,6),                         #金額            
         xcdr123             DECIMAL(20,6),                         #金額          
         xcdr124             DECIMAL(20,6),                         #金額     
         xcdr125             DECIMAL(20,6),                         #金額 
         xcdrud001           VARCHAR(40),
         xcdrud002           VARCHAR(40),
         xcdrud003           VARCHAR(40),
         xcdrud004           VARCHAR(40),
         xcdrud005           VARCHAR(40),
         xcdrud006           VARCHAR(40),
         xcdrud007           VARCHAR(40),
         xcdrud008           VARCHAR(40),
         xcdrud009           VARCHAR(40),
         xcdrud010           VARCHAR(40),
         xcdrud011           DECIMAL(20,6),
         xcdrud012           DECIMAL(20,6),
         xcdrud013           DECIMAL(20,6),
         xcdrud014           DECIMAL(20,6),
         xcdrud015           DECIMAL(20,6),
         xcdrud016           DECIMAL(20,6),
         xcdrud017           DECIMAL(20,6),
         xcdrud018           DECIMAL(20,6),
         xcdrud019           DECIMAL(20,6),
         xcdrud020           DECIMAL(20,6),
         xcdrud021           DATETIME YEAR TO SECOND,
         xcdrud022           DATETIME YEAR TO SECOND,
         xcdrud023           DATETIME YEAR TO SECOND,
         xcdrud024           DATETIME YEAR TO SECOND,
         xcdrud025           DATETIME YEAR TO SECOND,
         xcdrud026           DATETIME YEAR TO SECOND,
         xcdrud027           DATETIME YEAR TO SECOND,
         xcdrud028           DATETIME YEAR TO SECOND,
         xcdrud029           DATETIME YEAR TO SECOND,
         xcdrud030           DATETIME YEAR TO SECOND
   );
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 
  
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
PRIVATE FUNCTION axcp201_drop_tmp_table()
   WHENEVER ERROR CONTINUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN 
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE axcp201_xcbj_tmp
   DROP TABLE axcp201_xcdr_tmp
END FUNCTION

################################################################################
# Descriptions...: 根据成本参数替换sql里的字段
# Memo...........:
# Usage..........: CALL axcp201_replace_sql()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp201_replace_sql()

   IF cl_get_para(g_enterprise,g_site,'S-FIN-6003') = 'Y' THEN         #启用工艺成本
      CALL s_chr_replace(g_sql,'xcbh','xcbq',0) RETURNING g_sql
      CALL s_chr_replace(g_sql,'xcbi','xcbr',0) RETURNING g_sql
   END IF
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN         #启用成本次要素
      CALL s_chr_replace(g_sql,'xcbj','xcdr',0) RETURNING g_sql
      CALL s_chr_replace(g_sql,'xcbl001','xcbl023',0) RETURNING g_sql
   END IF
END FUNCTION

################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2016/10/20 By 02295
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp201_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   IF cl_null(g_master.xcbjcomp) THEN RETURN END IF

   IF cl_null(g_master.xcbj002) THEN RETURN END IF

   IF cl_null(g_master.xcbj003) THEN RETURN END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.xcbjcomp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > g_master.xcbj002 THEN
      LET g_errno = 'axc-00303'
   END IF

   #IF l_yy <= g_master.xcbj002 AND l_pp > g_master.xcbj003 THEN  #161117-00031#1 mark
   IF l_yy = g_master.xcbj002 AND l_pp > g_master.xcbj003 THEN  #161117-00031#1 
      LET g_errno = 'axc-00304'
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
