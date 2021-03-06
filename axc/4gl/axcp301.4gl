#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp301.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2017-02-10 16:56:27), PR版次:0006(2017-02-28 18:25:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcp301
#+ Description: 期初在製明細數量成本開帳檔（項次+項序）
#+ Creator....: 08108(2016-06-06 18:05:46)
#+ Modifier...: 00768 -SD/PR- 05423
 
{</section>}
 
{<section id="axcp301.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#170210-00043#1   2017/02/10  By 00768       修正all错误
#170215-00060#1   2017/02/17  By zhujing     修正进度条不动的问题
#170217-00025#6   2017/02/28  By zhujing     整批调整未产生数据时，提示消息修正。
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
       xccb006 LIKE type_t.chr20, 
   xccb007 LIKE type_t.chr500, 
   xccbcomp LIKE type_t.chr10, 
   xccbcomp_desc LIKE type_t.chr80, 
   xccbld LIKE type_t.chr5, 
   xccbld_desc LIKE type_t.chr80, 
   xccb004 LIKE type_t.num5, 
   xccb005 LIKE type_t.num5, 
   xccb003 LIKE type_t.chr10, 
   xccb003_desc LIKE type_t.chr80, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_flag                LIKE type_t.num5   #170217-00025#6 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp301.main" >}
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
      #排程參數由06開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[06]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL axcp301_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp301 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp301_init()
 
      #進入選單 Menu (="N")
      CALL axcp301_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
 #zhouhuaa 
 LET ls_js = axcp301_transfer_argv(ls_js)
 CALL cl_cmdrun(ls_js)
 #zhouhuaa
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp301
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp301.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp301_init()
 
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
   #161122-00034#1---add---s
   LET g_master.xccbcomp = g_argv[02]
   LET g_master.xccbld = g_argv[01]
   LET g_master.xccb004 = g_argv[04]
   LET g_master.xccb005 = g_argv[05]
   LET g_master.xccb003 = g_argv[03]
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccbcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccbcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xccbcomp_desc
   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccbld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccbld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xccbld_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccb003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccb003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xccb003_desc 
   #161122-00034#1---add---e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp301.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp301_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xccbcomp,g_master.xccbld,g_master.xccb004,g_master.xccb005,g_master.xccb003  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #161122-00036#1---add---s
               IF cl_null(g_argv[01]) THEN  #161122-00034#1
                  CALL s_axc_set_site_default() RETURNING g_master.xccbcomp,g_master.xccbld,g_master.xccb004,g_master.xccb005,g_master.xccb003
               
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xccbcomp
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xccbcomp_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xccbcomp_desc
                  
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xccbld
                  CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xccbld_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xccbld_desc
                  
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_master.xccb003
                  CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_master.xccb003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_master.xccb003_desc
               #161122-00036#1---add---e
               END IF   #161122-00034#1
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccbcomp
            
            #add-point:AFTER FIELD xccbcomp name="input.a.xccbcomp"
            IF NOT cl_null(g_master.xccbcomp) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xccbcomp
                  
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
            
            SELECT glaald INTO g_master.xccbld
              FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_master.xccbcomp
               AND glaa014 = 'Y'
 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccbld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccbld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccbld_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccbcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccbcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccbcomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccbcomp
            #add-point:BEFORE FIELD xccbcomp name="input.b.xccbcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccbcomp
            #add-point:ON CHANGE xccbcomp name="input.g.xccbcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccbld
            
            #add-point:AFTER FIELD xccbld name="input.a.xccbld"
            IF NOT cl_null(g_master.xccbld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xccbld

               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_ld_chk_authorization(g_user,g_master.xccbld) RETURNING l_success
                  IF l_success = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_master.xccbld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_master.xccbld = ''
                     NEXT FIELD CURRENT
                  END IF 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccbld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccbld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccbld_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccbld
            #add-point:BEFORE FIELD xccbld name="input.b.xccbld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccbld
            #add-point:ON CHANGE xccbld name="input.g.xccbld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccb004
            #add-point:BEFORE FIELD xccb004 name="input.b.xccb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccb004
            
            #add-point:AFTER FIELD xccb004 name="input.a.xccb004"
            CALL axcp301_date_chk()
            IF NOT cl_null(g_errno) THEN
               LET g_errparam.extend = g_master.xccb004
               LET g_errparam.code   = g_errno
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT                       
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccb004
            #add-point:ON CHANGE xccb004 name="input.g.xccb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccb005
            #add-point:BEFORE FIELD xccb005 name="input.b.xccb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccb005
            
            #add-point:AFTER FIELD xccb005 name="input.a.xccb005"
            CALL axcp301_date_chk()
            IF NOT cl_null(g_errno) THEN
               LET g_errparam.extend = g_master.xccb005
               LET g_errparam.code   = g_errno
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT                       
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccb005
            #add-point:ON CHANGE xccb005 name="input.g.xccb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccb003
            
            #add-point:AFTER FIELD xccb003 name="input.a.xccb003"
            IF NOT cl_null(g_master.xccb003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xccb003
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
  
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
            LET g_ref_fields[1] = g_master.xccb003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccb003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccb003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccb003
            #add-point:BEFORE FIELD xccb003 name="input.b.xccb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccb003
            #add-point:ON CHANGE xccb003 name="input.g.xccb003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xccbcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccbcomp
            #add-point:ON ACTION controlp INFIELD xccbcomp name="input.c.xccbcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccbcomp             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #
            CALL q_ooef001_2()                                #呼叫開窗
            LET g_master.xccbcomp = g_qryparam.return1              
            #LET g_master.ooef001 = g_qryparam.return2 
            DISPLAY g_master.xccbcomp TO xccbcomp              #
            #DISPLAY g_master.ooef001 TO ooef001 #组织编号
            NEXT FIELD xccbcomp                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccbld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccbld
            #add-point:ON ACTION controlp INFIELD xccbld name="input.c.xccbld"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccbld             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF g_master.xccbcomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_master.xccbcomp,"'"
            END IF
            CALL q_authorised_ld()                                #呼叫開窗
            LET g_master.xccbld = g_qryparam.return1              
            DISPLAY g_master.xccbld TO xccbld              #
            NEXT FIELD xccbld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccb004
            #add-point:ON ACTION controlp INFIELD xccb004 name="input.c.xccb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccb005
            #add-point:ON ACTION controlp INFIELD xccb005 name="input.c.xccb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccb003
            #add-point:ON ACTION controlp INFIELD xccb003 name="input.c.xccb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccb003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #s
            CALL q_xcat001()                                #呼叫開窗
            LET g_master.xccb003 = g_qryparam.return1              
            DISPLAY g_master.xccb003 TO xccb003              #
            NEXT FIELD xccb003                          #返回原欄位
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xccb006,xccb007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccb006
            #add-point:BEFORE FIELD xccb006 name="construct.b.xccb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccb006
            
            #add-point:AFTER FIELD xccb006 name="construct.a.xccb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccb006
            #add-point:ON ACTION controlp INFIELD xccb006 name="construct.c.xccb006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaj020()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccb006  #顯示到畫面上
            NEXT FIELD xccb006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccb007
            #add-point:BEFORE FIELD xccb007 name="construct.b.xccb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccb007
            
            #add-point:AFTER FIELD xccb007 name="construct.a.xccb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccb007
            #add-point:ON ACTION controlp INFIELD xccb007 name="construct.c.xccb007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccb007  #顯示到畫面上
            NEXT FIELD xccb007                     #返回原欄位
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
            CALL axcp301_get_buffer(l_dialog)
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
         CALL axcp301_init()
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
                 CALL axcp301_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp301_transfer_argv(ls_js)
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
 
{<section id="axcp301.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp301_transfer_argv(ls_js)
 
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
 
{<section id="axcp301.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp301_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_value    STRING     #170215-00060#1 add
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
      LET g_flag = FALSE   #170217-00025#6 add
      #170215-00060#1 add-S
      LET li_count = 4
      CALL cl_progress_bar_no_window(li_count) 
      #170215-00060#1 add-E
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp301_process_cs CURSOR FROM ls_sql
#  FOREACH axcp301_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
         
      CALL axcp301_crt_tmp()
      CALL s_transaction_begin()
      LET g_success = 'Y'
      #170215-00060#1 add-S
      LET ls_value = 'del xcgb_t'
      CALL cl_progress_no_window_ing(ls_value)
      #170215-00060#1 add-E
      
      CALL axcq301_del_xcgb()   #删除旧资料
      
      #170215-00060#1 add-S
      LET ls_value = 'ins sfba_t'
      CALL cl_progress_no_window_ing(ls_value)
      #170215-00060#1 add-E
      
      CALL axcp301_ins_sfbatmp()  #xccb中有的工单明细信息写入到axcp301_sfba临时表
      
      #170215-00060#1 add-S
      LET ls_value = 'ins xcgb_t'
      CALL cl_progress_no_window_ing(ls_value)
      #170215-00060#1 add-E
      
      CALL axcp301_ins_xcgb()   #插入到在制开账明细档
      #170217-00025#6 add-S
      IF g_flag = FALSE THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN   
      END IF
      #170217-00025#6 add-E
      
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      CALL axcp301_drp_tmp()
      #170215-00060#1 add-S
      LET ls_value = 'complete'
      CALL cl_progress_no_window_ing(ls_value)
      #170215-00060#1 add-E
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp301_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp301.get_buffer" >}
PRIVATE FUNCTION axcp301_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xccbcomp = p_dialog.getFieldBuffer('xccbcomp')
   LET g_master.xccbld = p_dialog.getFieldBuffer('xccbld')
   LET g_master.xccb004 = p_dialog.getFieldBuffer('xccb004')
   LET g_master.xccb005 = p_dialog.getFieldBuffer('xccb005')
   LET g_master.xccb003 = p_dialog.getFieldBuffer('xccb003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp301.msgcentre_notify" >}
PRIVATE FUNCTION axcp301_msgcentre_notify()
 
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
 
{<section id="axcp301.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 创建临时表
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
PRIVATE FUNCTION axcp301_crt_tmp()
 #工单料号项次项序明细量
   DROP TABLE axcp301_sfba;
   CREATE TEMP TABLE axcp301_sfba(
      xccb001     LIKE xccb_t.xccb001,    #帐套本位币顺序--key
      xccb002     LIKE xccb_t.xccb002,    #成本域--key
      sfbadocno   LIKE sfaa_t.sfaadocno,  #工单单号--key
      sfba006     LIKE sfba_t.sfba006,    #发料料号--key
      sfba021     LIKE sfba_t.sfba021,    #特征------key
      sfbaseq     LIKE sfba_t.sfbaseq,    #项次------key
      sfbaseq1    LIKE sfba_t.sfbaseq1,   #项序------key
      sfba013     LIKE sfba_t.sfba013,    #总应发量
      sfba013_tot LIKE sfba_t.sfba013,    #总应发量 有相同料的汇总
      qty         LIKE xcgb_t.xcgb101 #xccb分摊到此处的数量
   );
   CREATE UNIQUE INDEX axcp301_sfba_01 on axcp301_sfba (xccb001,xccb002,sfbadocno,sfba006,sfba021,sfbaseq,sfbaseq1)     
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
PRIVATE FUNCTION axcp301_drp_tmp()
   DROP TABLE axcp301_sfba;
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
PRIVATE FUNCTION axcq301_del_xcgb()
   DEFINE l_sql    STRING
   DEFINE l_wc     STRING
   
   
   LET l_wc = cl_replace_str(g_master.wc,"xccb","xcgb")
   
   LET l_sql = " DELETE FROM xcgb_t ",
               "  WHERE xcgbent = ",g_enterprise,
               "    AND xcgbld  ='",g_master.xccbld,"' ",
               "    AND xcgbcomp='",g_master.xccbcomp,"' ",
               "    AND xcgb003 ='",g_master.xccb003,"' ",
               "    AND xcgb004 = ",g_master.xccb004,
               "    AND xcgb005 = ",g_master.xccb005,
               "    AND ",l_wc
   PREPARE axcq301_del_xcgb_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcq301_del_xcgb_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcq301_del_xcgb_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcq301_del_xcgb_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
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
PRIVATE FUNCTION axcp301_ins_sfbatmp()
   DEFINE l_sql    STRING
   
   #xccb中有的工单明细信息写入到axcp301_sfba临时表
   LET l_sql = " INSERT INTO axcp301_sfba ",
               " SELECT UNIQUE xccb001,xccb002,sfbadocno,sfba006,sfba021,sfbaseq,sfbaseq1,sfba013,0,0 ",
               "   FROM sfba_t,xccb_t ",
               "  WHERE sfbaent = xccbent AND sfbadocno = xccb006 ",
               "    AND xccbent = ",g_enterprise,
               "    AND xccbld  ='",g_master.xccbld,"' ",
               "    AND xccbcomp='",g_master.xccbcomp,"' ",
               "    AND xccb003 ='",g_master.xccb003,"' ",
               "    AND xccb004 = ",g_master.xccb004,
               "    AND xccb005 = ",g_master.xccb005,
               "    AND ",g_master.wc
   PREPARE axcp301_ins_sfbatmp_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp301_ins_sfbatmp_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcp301_ins_sfbatmp_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp301_ins_sfbatmp_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   #有相同料的汇总
   LET l_sql = " MERGE INTO axcp301_sfba a  ",
               " USING (SELECT xccb001,xccb002,sfbadocno,sfba006,sfba021,NVL(SUM(sfba013),0)  sfba013 ",
               "          FROM axcp301_sfba ",
               "         GROUP BY xccb001,xccb002,sfbadocno,sfba006,sfba021 ) b ",
               "    ON (a.xccb001   = b.xccb001 ",
               "   AND a.xccb002   = b.xccb002 ",
               "   AND a.sfbadocno = b.sfbadocno ",
               "   AND a.sfba006   = b.sfba006 ",
               "   AND a.sfba021   = b.sfba021) ",
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET sfba013_tot  =  b.sfba013   "
   PREPARE axcp301_ins_sfbatmp_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp301_ins_sfbatmp_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcp301_ins_sfbatmp_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp301_ins_sfbatmp_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   #进行xccb的分摊
   LET l_sql = " MERGE INTO axcp301_sfba a  ",
               " USING xccb_t b ",
               "    ON (b.xccbent   = ",g_enterprise,
               "   AND b.xccbld    ='",g_master.xccbld,"' ",
               "   AND b.xccb001   = a.xccb001 ",   #帐套本位币顺序
               "   AND b.xccb002   = a.xccb002 ",   #成本域
               "   AND b.xccb003   ='",g_master.xccb003,"' ", #成本计算类型
               "   AND b.xccb004   = ",g_master.xccb004,  #年度
               "   AND b.xccb005   = ",g_master.xccb005,  #期别
               "   AND b.xccb006   = a.sfbadocno ", #工单单号
               "   AND b.xccb007   = a.sfba006 ",   #发料料号
               "   AND b.xccb008   = a.sfba021) ",   #特征
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET a.qty  =  b.xccb101 * a.sfba013 / a.sfba013_tot   ", #开账数量*本笔应发量/应发量汇总
               "      WHERE a.sfba013_tot != 0 "
   PREPARE axcp301_ins_sfbatmp_p3 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp301_ins_sfbatmp_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcp301_ins_sfbatmp_p3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp301_ins_sfbatmp_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
   #将分摊小数误差部分认领到某笔
   LET l_sql = " MERGE INTO axcp301_sfba d  ",
               " USING ( ",  #sum有差异的资料及差异数
                        #帐套本位币顺序,  成本域,   工单单号,     发料料号, 特征       开账数量差异
               "        SELECT a.xccb001 xccb001,a.xccb002 xccb002, ",
               "               a.sfbadocno sfbadocno,a.sfba006 sfba006,a.sfba021 sfba021,a.qty-b.qty qty ",
               "          FROM (SELECT xccb001,xccb002,sfbadocno,sfba006,sfba021,sum(qty) qty FROM axcp301_sfba ",
               "                 GROUP BY xccb001,xccb002,sfbadocno,sfba006,sfba021) a, ",
               "               (SELECT xccb001,xccb002,xccb006,  xccb007,xccb008,xccb101 qty  FROM xccb_t ",
               "                 WHERE xccbent   = ",g_enterprise ,
               "                   AND xccbld    ='",g_master.xccbld,"' ",
               "                   AND xccb003   ='",g_master.xccb003,"' ",       #成本计算类型
               "                   AND xccb004   = ",g_master.xccb004,            #年度
               "                   AND xccb005   = ",g_master.xccb005,"  ) b ",   #期别
               "        WHERE a.xccb001  = b.xccb001  ",
               "          AND a.xccb002  = b.xccb002  ",
               "          AND a.sfbadocno= b.xccb006  ",
               "          AND a.sfba006  = b.xccb007  ",
               "          AND a.sfba021  = b.xccb008  ",
               "          AND a.qty-b.qty !=0         ",  #只抓取有差异的
               "       ) c ",
               "    ON (    d.xccb001  = c.xccb001 ",
               "        AND d.xccb002  = c.xccb002 ",
               "        AND d.sfbadocno= c.sfbadocno ",
               "        AND d.sfba006  = c.sfba006 ",
               "        AND d.sfba021  = c.sfba021 ) ",
               "  WHEN MATCHED THEN    ",
               "     UPDATE SET d.qty  =  d.qty - c.qty   ",  #开账数量=现有开账数-小数误差数
               "      WHERE ROWNUM = 1 "  #只更新一笔
               #zll  最后检查下算的值和xccb是不是一致，一致就没问题了
   PREPARE axcp301_ins_sfbatmp_p4 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp301_ins_sfbatmp_p4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcp301_ins_sfbatmp_p4
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp301_ins_sfbatmp_p4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   
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
PRIVATE FUNCTION axcp301_ins_xcgb()
 DEFINE l_sql    STRING
   
   LET l_sql = " INSERT INTO xcgb_t(xcgbent,xcgbld,xcgbcomp, ",
               "                      xcgb001,xcgb002,xcgb003,xcgb004,xcgb005, ",
               "                      xcgb006,xcgb007,xcgb008,xcgb009, ",
               "                      xcgb010,xcgb011,xcgb101 ) ",
               " SELECT ",g_enterprise,",'",g_master.xccbld,"','",g_master.xccbcomp,"', ",
               "        xccb001,xccb002,'",g_master.xccb003,"',",g_master.xccb004,",",g_master.xccb005,", ",
               "        sfbadocno,sfba006,NVL(sfba021,' '),' ', ",  #批号浔兴没有，就直接给空格了
               "        sfbaseq,sfbaseq1,qty ",
               "  FROM axcp301_sfba "
   PREPARE axcp301_ins_xcgb_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp301_ins_xcgb_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   EXECUTE axcp301_ins_xcgb_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp301_ins_xcgb_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   #170217-00025#6 add-S
   IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
   END IF
   #170217-00025#6 add-E
END FUNCTION

################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2016/12/29 By 02295
# Modify.........: #161122-00036#1 
################################################################################
PRIVATE FUNCTION axcp301_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   IF cl_null(g_master.xccbcomp) THEN RETURN END IF

   IF cl_null(g_master.xccb004) THEN RETURN END IF

   IF cl_null(g_master.xccb005) THEN RETURN END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.xccbcomp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > g_master.xccb004 THEN
      LET g_errno = 'axc-00303'
   END IF

   IF l_yy = g_master.xccb004 AND l_pp > g_master.xccb005 THEN 
      LET g_errno = 'axc-00304'
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
