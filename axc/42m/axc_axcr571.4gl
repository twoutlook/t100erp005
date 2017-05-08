#該程式未解開Section, 採用最新樣板產出!
{<section id="axcr571.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-08 15:09:52), PR版次:0001(2016-12-08 16:04:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcr571
#+ Description: 製程在製元件成本表
#+ Creator....: 01996(2016-12-05 16:40:31)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="axcr571.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
 
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       xchacomp LIKE xcha_t.xchacomp, 
   xchacomp_desc LIKE type_t.chr80, 
   xcha004 LIKE xcha_t.xcha004, 
   xcha005 LIKE xcha_t.xcha005, 
   xchald LIKE xcha_t.xchald, 
   xchald_desc LIKE type_t.chr80, 
   xcha004_e LIKE type_t.num5, 
   xcha005_e LIKE type_t.num5, 
   xcha001 LIKE xcha_t.xcha001, 
   xcha001_desc LIKE type_t.chr80, 
   xcha003 LIKE xcha_t.xcha003, 
   xcha003_desc LIKE type_t.chr80, 
   xcha006 LIKE xcha_t.xcha006, 
   xcbb006 LIKE xcbb_t.xcbb006, 
   xcha009 LIKE xcha_t.xcha009, 
   imag011 LIKE imag_t.imag011, 
   sfaa003 LIKE sfaa_t.sfaa003, 
   imaa003 LIKE imaa_t.imaa003, 
   chk2 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcr571.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
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
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcr571_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcr571 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcr571_init()
 
      #進入選單 Menu (="N")
      CALL axcr571_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcr571
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcr571.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcr571_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL cl_set_combo_scc('xcha001','8914')
   CALL cl_set_combo_scc_part('sfaa003','8923','1,2')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcr571.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcr571_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xchacomp,g_master.xcha004,g_master.xcha005,g_master.xchald,g_master.xcha004_e, 
             g_master.xcha005_e,g_master.xcha001,g_master.xcha003,g_master.chk2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               IF cl_null(g_master.xchacomp) AND cl_null(g_master.xchald) AND cl_null(g_master.xcha001) AND cl_null(g_master.xcha003) AND cl_null(g_master.xcha004) AND cl_null(g_master.xcha005) THEN
                  CALL axcr571_set_default()
               END IF
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xchacomp
            
            #add-point:AFTER FIELD xchacomp name="input.a.xchacomp"
             IF NOT cl_null(g_master.xchacomp) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xchacomp
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#11--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_15") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xchacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent="||g_enterprise||" AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xchacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xchacomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xchacomp
            #add-point:BEFORE FIELD xchacomp name="input.b.xchacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xchacomp
            #add-point:ON CHANGE xchacomp name="input.g.xchacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha004
            #add-point:BEFORE FIELD xcha004 name="input.b.xcha004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha004
            
            #add-point:AFTER FIELD xcha004 name="input.a.xcha004"
            IF NOT cl_null(g_master.xcha004) AND NOT cl_null(g_master.xcha004_e) 
               AND g_master.xcha004>g_master.xcha004_e THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'acr-00064'   #  起始年度不能大于截止年度！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha004
            #add-point:ON CHANGE xcha004 name="input.g.xcha004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha005
            #add-point:BEFORE FIELD xcha005 name="input.b.xcha005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha005
            
            #add-point:AFTER FIELD xcha005 name="input.a.xcha005"
            IF NOT cl_null(g_master.xcha005) AND NOT cl_null(g_master.xcha004)
               AND NOT cl_null(g_master.xcha005_e) AND NOT cl_null(g_master.xcha004_e)
               AND g_master.xcha004=g_master.xcha004_e AND g_master.xcha005>g_master.xcha005_e THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'agl-00227'   #  起始期别不可大于截止期别！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha005
            #add-point:ON CHANGE xcha005 name="input.g.xcha005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xchald
            
            #add-point:AFTER FIELD xchald name="input.a.xchald"
             IF NOT cl_null(g_master.xchald) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xchald
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#11--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xchald
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent="||g_enterprise||" AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xchald_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xchald_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xchald
            #add-point:BEFORE FIELD xchald name="input.b.xchald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xchald
            #add-point:ON CHANGE xchald name="input.g.xchald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha004_e
            #add-point:BEFORE FIELD xcha004_e name="input.b.xcha004_e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha004_e
            
            #add-point:AFTER FIELD xcha004_e name="input.a.xcha004_e"
            IF NOT cl_null(g_master.xcha004) AND NOT cl_null(g_master.xcha004_e) 
               AND g_master.xcha004>g_master.xcha004_e THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'agl-00373'   #  截止年度不可小于起始年度
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha004_e
            #add-point:ON CHANGE xcha004_e name="input.g.xcha004_e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha005_e
            #add-point:BEFORE FIELD xcha005_e name="input.b.xcha005_e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha005_e
            
            #add-point:AFTER FIELD xcha005_e name="input.a.xcha005_e"
            IF NOT cl_null(g_master.xcha005) AND NOT cl_null(g_master.xcha004)
               AND NOT cl_null(g_master.xcha005_e) AND NOT cl_null(g_master.xcha004_e)
               AND g_master.xcha004=g_master.xcha004_e AND g_master.xcha005>g_master.xcha005_e THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'agl-00228'   #  截止期别不可小于起始期别！
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha005_e
            #add-point:ON CHANGE xcha005_e name="input.g.xcha005_e"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha001
            
            #add-point:AFTER FIELD xcha001 name="input.a.xcha001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcha001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent="||g_enterprise||" AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcha001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcha001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha001
            #add-point:BEFORE FIELD xcha001 name="input.b.xcha001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha001
            #add-point:ON CHANGE xcha001 name="input.g.xcha001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha003
            
            #add-point:AFTER FIELD xcha003 name="input.a.xcha003"
            IF NOT cl_null(g_master.xcha003) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xcha003
               #160318-00025#11--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#11--add--end
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
            LET g_ref_fields[1] = g_master.xcha003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent="||g_enterprise||" AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcha003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcha003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha003
            #add-point:BEFORE FIELD xcha003 name="input.b.xcha003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcha003
            #add-point:ON CHANGE xcha003 name="input.g.xcha003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk2
            #add-point:BEFORE FIELD chk2 name="input.b.chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk2
            
            #add-point:AFTER FIELD chk2 name="input.a.chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk2
            #add-point:ON CHANGE chk2 name="input.g.chk2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xchacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xchacomp
            #add-point:ON ACTION controlp INFIELD xchacomp name="input.c.xchacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xchacomp             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001_2()                                #呼叫開窗   #161019-00017#11   2016/10/20 By 08734

            LET g_master.xchacomp = g_qryparam.return1              
            DISPLAY g_master.xchacomp TO xchacomp              #
            NEXT FIELD xchacomp   
            #END add-point
 
 
         #Ctrlp:input.c.xcha004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha004
            #add-point:ON ACTION controlp INFIELD xcha004 name="input.c.xcha004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcha005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha005
            #add-point:ON ACTION controlp INFIELD xcha005 name="input.c.xcha005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xchald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xchald
            #add-point:ON ACTION controlp INFIELD xchald name="input.c.xchald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xchald             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_master.xchald = g_qryparam.return1              

            DISPLAY g_master.xchald TO xchald              #

            NEXT FIELD xchald    
            #END add-point
 
 
         #Ctrlp:input.c.xcha004_e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha004_e
            #add-point:ON ACTION controlp INFIELD xcha004_e name="input.c.xcha004_e"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcha005_e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha005_e
            #add-point:ON ACTION controlp INFIELD xcha005_e name="input.c.xcha005_e"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcha001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha001
            #add-point:ON ACTION controlp INFIELD xcha001 name="input.c.xcha001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcha003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha003
            #add-point:ON ACTION controlp INFIELD xcha003 name="input.c.xcha003"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcha003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcat001()                                #呼叫開窗

            LET g_master.xcha003 = g_qryparam.return1              

            DISPLAY g_master.xcha003 TO xcha003              #

            NEXT FIELD xcha003     
            #END add-point
 
 
         #Ctrlp:input.c.chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk2
            #add-point:ON ACTION controlp INFIELD chk2 name="input.c.chk2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xcha006,xcbb006,xcha009,imag011,sfaa003,imaa003
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha006
            #add-point:BEFORE FIELD xcha006 name="construct.b.xcha006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha006
            
            #add-point:AFTER FIELD xcha006 name="construct.a.xcha006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcha006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha006
            #add-point:ON ACTION controlp INFIELD xcha006 name="construct.c.xcha006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " sfaa061 = 'Y' "
            CALL q_sfaadocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcha006  #顯示到畫面上
            NEXT FIELD xcha006  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcbb006
            #add-point:BEFORE FIELD xcbb006 name="construct.b.xcbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcbb006
            
            #add-point:AFTER FIELD xcbb006 name="construct.a.xcbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcbb006
            #add-point:ON ACTION controlp INFIELD xcbb006 name="construct.c.xcbb006"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcha009
            #add-point:BEFORE FIELD xcha009 name="construct.b.xcha009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcha009
            
            #add-point:AFTER FIELD xcha009 name="construct.a.xcha009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcha009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcha009
            #add-point:ON ACTION controlp INFIELD xcha009 name="construct.c.xcha009"
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcha009  #顯示到畫面上
            NEXT FIELD xcha009            
            #END add-point
 
 
         #Ctrlp:construct.c.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.imag011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imag011  #顯示到畫面上
            NEXT FIELD imag011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imag011
            #add-point:BEFORE FIELD imag011 name="construct.b.imag011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imag011
            
            #add-point:AFTER FIELD imag011 name="construct.a.imag011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa003
            #add-point:BEFORE FIELD sfaa003 name="construct.b.sfaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa003
            
            #add-point:AFTER FIELD sfaa003 name="construct.a.sfaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa003
            #add-point:ON ACTION controlp INFIELD sfaa003 name="construct.c.sfaa003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imck001()                           #呼叫開窗
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL axcr571_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axcr571_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
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
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL axcr571_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL axcr571_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcr571_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcr571.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcr571_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axcr571.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcr571_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_flag1      LIKE type_t.chr1
   DEFINE l_flag2     LIKE type_t.chr1
   DEFINE l_flag3     LIKE type_t.chr1
   DEFINE l_flag4     LIKE type_t.chr1 
   DEFINE l_wc        STRING
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xcha006,xcbb006,xcha009,imag011,sfaa003,imaa003")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
#   CALL axcr571_input_chk() RETURNING l_success
#   IF (l_success) THEN
#      IF cl_null(lc_param.wc) THEN 
#         LET g_master.wc="1=1"
#      END IF
#      LET l_wc=g_master.wc
#      LET l_wc=l_wc CLIPPED ,"AND xccicomp='",g_master.xchacomp,"' AND xccild='",g_master.xchald,"' AND xcci001='",g_master.xcha001,"' AND xcci004=",g_master.xcha004," AND xcci005=",g_master.xcha005," AND xcci003='",g_master.xcha003,"' AND xccient=",g_enterprise
#      LET g_master.wc=g_master.wc CLIPPED ," AND xccecomp='",g_master.xchacomp,"' AND xcceld='",g_master.xchald,"' AND xcce001='",g_master.xcha001,"' AND xcce004=",g_master.xcha004," AND xcce005=",g_master.xcha005," AND xcce003='",g_master.xcha003,"' AND xcceent=",g_enterprise
#      IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN   #成本域
#         LET l_flag1 = 'N'
#      ELSE
#         LET l_flag1 = 'Y'
#      END IF 
#      IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN    #特性
#         LET l_flag2 = 'N'
#      ELSE
#         LET l_flag2 = 'Y'
#      END IF 
#      
#      IF g_master.chk1 = 'N' OR cl_null(g_master.chk1) THEN          #明细
#         LET l_flag4 = 'N'
#      ELSE
#         LET l_flag4 = 'Y'
#      END IF
#      
#      IF g_master.chk2 = 'N' OR cl_null(g_master.chk2) THEN          #要素
#         LET l_flag3 = 'N'
#      ELSE
#         LET l_flag3 = 'Y'
#      END IF
#      
#      
#      #CALL 报表元件
#      CALL axcr571_x01(g_master.wc,l_flag1,l_flag2,l_flag3,l_flag4,l_wc)
#   END IF
   IF cl_null(lc_param.wc) THEN 
      LET g_master.wc="1=1"
   END IF
   LET l_wc=g_master.wc
   LET l_wc=l_wc CLIPPED ,"AND xchacomp='",g_master.xchacomp,"' AND xchald = '",g_master.xchald,"' AND xcha001='",g_master.xcha001,"' AND xcha003 = '",g_master.xcha003,"' AND xchaent = ",g_enterprise
   LET g_master.wc= l_wc CLIPPED ," AND (xcha004*12+xcha005 BETWEEN ",g_master.xcha004*12+g_master.xcha005," AND ",g_master.xcha004_e*12+g_master.xcha005_e,") "
   #CALL 报表元件
   CALL axcr571_x01(g_master.wc,g_master.chk2)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcr571_process_cs CURSOR FROM ls_sql
#  FOREACH axcr571_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcr571.get_buffer" >}
PRIVATE FUNCTION axcr571_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xchacomp = p_dialog.getFieldBuffer('xchacomp')
   LET g_master.xcha004 = p_dialog.getFieldBuffer('xcha004')
   LET g_master.xcha005 = p_dialog.getFieldBuffer('xcha005')
   LET g_master.xchald = p_dialog.getFieldBuffer('xchald')
   LET g_master.xcha004_e = p_dialog.getFieldBuffer('xcha004_e')
   LET g_master.xcha005_e = p_dialog.getFieldBuffer('xcha005_e')
   LET g_master.xcha001 = p_dialog.getFieldBuffer('xcha001')
   LET g_master.xcha003 = p_dialog.getFieldBuffer('xcha003')
   LET g_master.chk2 = p_dialog.getFieldBuffer('chk2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcr571.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值設置
# Date & Author..: 2015/3/4 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcr571_set_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_master.xchacomp,g_master.xchald,g_master.xcha004,g_master.xcha005,g_master.xcha003
   DISPLAY BY NAME g_master.xchacomp,g_master.xchald,g_master.xcha004,g_master.xcha005,g_master.xcha003
   
   LET g_master.xcha004_e = g_master.xcha004
   LET g_master.xcha005_e = g_master.xcha005
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xchacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xchacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xchacomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xchald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xchald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xchald_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcha003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcha003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcha003_desc
      
   LET g_master.xcha001 = '1'
   DISPLAY BY NAME g_master.xcha001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xchald

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcha001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcha001_desc      

   LET g_master.chk2 = 'Y'
   DISPLAY BY NAME g_master.chk2
END FUNCTION

################################################################################
# Descriptions...: 检查输入资料是否有效
# Memo...........:
# Usage..........: CALL axcr571_input_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/3/4 liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcr571_input_chk()
DEFINE r_success               LIKE type_t.num5
DEFINE l_sql                   STRING 
DEFINE l_n                     LIKE type_t.num5

   LET r_success = FALSE
   
   LET l_sql = "SELECT COUNT(*) FROM xcce_t WHERE xcceent = ",g_enterprise
  
   IF NOT cl_null(g_master.xchacomp) THEN
      LET l_sql = l_sql," AND xccecomp = '",g_master.xchacomp,"'"
   END IF
   IF NOT cl_null(g_master.xchald) THEN
      LET l_sql = l_sql," AND xcceld = '",g_master.xchald,"'"
   END IF
   IF NOT cl_null(g_master.xcha001) THEN
      LET l_sql = l_sql," AND xcce001 = '",g_master.xcha001,"'"
   END IF
   IF NOT cl_null(g_master.xcha003) THEN
      LET l_sql = l_sql," AND xcce003 = '",g_master.xcha003,"'"
   END IF
   IF NOT cl_null(g_master.xcha004) THEN
      LET l_sql = l_sql," AND xcce004 = ",g_master.xcha004
   END IF
   IF NOT cl_null(g_master.xcha005) THEN
      LET l_sql = l_sql," AND xcce005 = ",g_master.xcha005
   END IF 
   PREPARE axcr510_input_chk_pre FROM l_sql
   EXECUTE axcr510_input_chk_pre INTO l_n
   
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = '-100'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
