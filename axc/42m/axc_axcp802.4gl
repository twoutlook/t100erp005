#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp802.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-12-18 14:16:52), PR版次:0015(2017-02-22 12:37:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000079
#+ Filename...: axcp802
#+ Description: 存貨貨齡計算作業
#+ Creator....: 00537(2014-09-28 10:12:17)
#+ Modifier...: 00537 -SD/PR- 02111
 
{</section>}
 
{<section id="axcp802.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161109-00085#25   2016/11/16  By 08993      整批調整系統星號寫法
#161109-00085#63   2016/12/01  By 08171      整批調整系統星號寫法
#161109-00085#79   2016/12/12  By 08171      BUG修正
#170221-00055#1    2017/02/22  By 02111      修正 SQL 語法字串錯誤。
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
#160318-00025#52 2016/04/27 By 07673      將重複內容的錯誤訊息置換為公用錯誤訊息
#160929-00027#1  2016/09/29 By charles4m  1. axcp802_ins_xcfj() 少了右括號 2. l_sql 少了 AND 
#161011-00027#1  2016/10/12 By zhaoqya    调拨入库 
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
       xcccld LIKE type_t.chr5, 
   xcccld_desc LIKE type_t.chr80, 
   xccccomp LIKE type_t.chr10, 
   xccccomp_desc LIKE type_t.chr80, 
   xccc004 LIKE type_t.num5, 
   xccc005 LIKE type_t.num5, 
   xccc003 LIKE type_t.chr10, 
   xccc003_desc LIKE type_t.chr80, 
   date1 LIKE type_t.chr500, 
   date2 LIKE type_t.chr500, 
   storein1 LIKE type_t.chr500, 
   storein2 LIKE type_t.chr500, 
   storein3 LIKE type_t.chr500, 
   xccc006 LIKE type_t.chr500, 
   xccc008 LIKE type_t.chr30, 
   xccc002 LIKE type_t.chr30, 
   xccc007 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80, 
   p1 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_xcfk                DYNAMIC ARRAY OF RECORD
                             xccc006  LIKE   xccc_t.xccc006, 
                             xccc007  LIKE   xccc_t.xccc007,
                             xccc008  LIKE   xccc_t.xccc008,
                             xccc002  LIKE   xccc_t.xccc002,
                             inaj022  LIKE   inaj_t.inaj022,
                             inaj011  LIKE   inaj_t.inaj011,
                             amt02    LIKE   inaj_t.inaj011
                             END RECORD
DEFINE g_msg                 STRING
#end add-point
 
{</section>}
 
{<section id="axcp802.main" >}
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
      CALL axcp802_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp802 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp802_init()
 
      #進入選單 Menu (="N")
      CALL axcp802_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp802
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp802.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp802_init()
 
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
 
{<section id="axcp802.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp802_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_xccc004     LIKE xccc_t.xccc004
   DEFINE l_xccc005     LIKE xccc_t.xccc005
   DEFINE l_bdate       LIKE type_t.dat
   DEFINE l_edate       LIKE type_t.dat
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_success     LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcccld,g_master.xccccomp,g_master.xccc004,g_master.xccc005,g_master.xccc003, 
             g_master.date1,g_master.date2,g_master.storein1,g_master.storein2,g_master.storein3 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axcp802_default()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            IF NOT cl_null(g_master.xcccld) THEN
               IF NOT s_axc_chk_ld_comp(g_master.xccccomp,g_master.xcccld) THEN
                  LET g_master.xcccld = NULL
                  NEXT FIELD CURRENT
               END IF
               #库存异动起始日期取账套+成本类型最早年期的第一天
               LET l_xccc004 = NULL
               LET l_xccc005 = NULL
               LET l_glaa003 = NULL
               LET l_bdate   = NULL
               LET l_edate   = NULL
               SELECT xccc004,xccc005 INTO l_xccc004,l_xccc005
                 FROM xccc_t
                WHERE xcccent = g_enterprise
                  AND xcccld  = g_master.xcccld
                  AND ROWNUM = 1
                ORDER BY xccc004,xccc005
               CALL s_ld_sel_glaa(g_master.xcccld,'glaa003') RETURNING l_success,l_glaa003
               CALL s_fin_date_get_period_range(l_glaa003,l_xccc004,l_xccc005) RETURNING l_bdate,l_edate
               LET g_master.date1 = l_bdate
               #库存异动截止日期取画面年期的最后一天
               CALL s_fin_date_get_lastday(g_master.xcccld,'',g_master.xccc004,g_master.xccc005,'') RETURNING l_success,g_master.date2
               DISPLAY BY NAME g_master.date1,g_master.date2
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcccld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcccld_desc    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcccld
            #add-point:BEFORE FIELD xcccld name="input.b.xcccld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcccld
            #add-point:ON CHANGE xcccld name="input.g.xcccld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccccomp
            
            #add-point:AFTER FIELD xccccomp name="input.a.xccccomp"
            IF NOT cl_null(g_master.xccccomp) THEN
               IF NOT s_axc_chk_ld_comp(g_master.xccccomp,g_master.xcccld) THEN
                  LET g_master.xccccomp = NULL
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccccomp_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccccomp
            #add-point:BEFORE FIELD xccccomp name="input.b.xccccomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccccomp
            #add-point:ON CHANGE xccccomp name="input.g.xccccomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
            IF NOT cl_null(g_master.xccc004) THEN
               IF NOT s_axc_chk_year_period(g_master.xcccld,g_master.xccc004,g_master.xccc005) THEN
                  LET g_master.xccc004 = NULL
                  NEXT FIELD CURRENT
               END IF
               #库存异动起始日期取账套+成本类型最早年期的第一天
               LET l_xccc004 = NULL
               LET l_xccc005 = NULL
               LET l_glaa003 = NULL
               LET l_bdate   = NULL
               LET l_edate   = NULL
               SELECT xccc004,xccc005 INTO l_xccc004,l_xccc005
                 FROM xccc_t
                WHERE xcccent = g_enterprise
                  AND xcccld  = g_master.xcccld
                  AND ROWNUM = 1
                ORDER BY xccc004,xccc005
               CALL s_ld_sel_glaa(g_master.xcccld,'glaa003') RETURNING l_success,l_glaa003
               CALL s_fin_date_get_period_range(l_glaa003,l_xccc004,l_xccc005) RETURNING l_bdate,l_edate
               LET g_master.date1 = l_bdate
               #库存异动截止日期取画面年期的最后一天
               CALL s_fin_date_get_lastday(g_master.xcccld,'',g_master.xccc004,g_master.xccc005,'') RETURNING l_success,g_master.date2
               DISPLAY BY NAME g_master.date1,g_master.date2
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc004
            #add-point:ON CHANGE xccc004 name="input.g.xccc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc005
            #add-point:BEFORE FIELD xccc005 name="input.b.xccc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc005
            
            #add-point:AFTER FIELD xccc005 name="input.a.xccc005"
            IF NOT cl_null(g_master.xccc005) THEN
               IF NOT s_axc_chk_year_period(g_master.xcccld,g_master.xccc004,g_master.xccc005) THEN
                  LET g_master.xccc005 = NULL
                  NEXT FIELD CURRENT
               END IF
               #库存异动起始日期取账套+成本类型最早年期的第一天
               LET l_xccc004 = NULL
               LET l_xccc005 = NULL
               LET l_glaa003 = NULL
               LET l_bdate   = NULL
               LET l_edate   = NULL
               SELECT xccc004,xccc005 INTO l_xccc004,l_xccc005
                 FROM xccc_t
                WHERE xcccent = g_enterprise
                  AND xcccld  = g_master.xcccld
                  AND ROWNUM = 1
                ORDER BY xccc004,xccc005
               CALL s_ld_sel_glaa(g_master.xcccld,'glaa003') RETURNING l_success,l_glaa003
               CALL s_fin_date_get_period_range(l_glaa003,l_xccc004,l_xccc005) RETURNING l_bdate,l_edate
               LET g_master.date1 = l_bdate
               #库存异动截止日期取画面年期的最后一天
               CALL s_fin_date_get_lastday(g_master.xcccld,'',g_master.xccc004,g_master.xccc005,'') RETURNING l_success,g_master.date2
               DISPLAY BY NAME g_master.date1,g_master.date2
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            IF NOT cl_null(g_master.xccc003) THEN 
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xccc003 
               LET g_errshow = TRUE   #160318-00025#52
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"    #160318-00025#52
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.xccc003 = NULL
                  NEXT FIELD CURRENT
               END IF
            
            
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xccc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xccc003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc003
            #add-point:BEFORE FIELD xccc003 name="input.b.xccc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc003
            #add-point:ON CHANGE xccc003 name="input.g.xccc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date1
            #add-point:BEFORE FIELD date1 name="input.b.date1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date1
            
            #add-point:AFTER FIELD date1 name="input.a.date1"
            IF NOT cl_null(g_master.date1) AND cl_null(g_master.date2) THEN
               LET g_master.date2 = s_date_get_last_date(g_master.date1)
            END IF
            DISPLAY BY NAME g_master.date2
            IF NOT cl_null(g_master.date1) AND NOT cl_null(g_master.date2) THEN
               IF g_master.date2 < g_master.date1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axm-00397' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.date1 = NULL
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date1
            #add-point:ON CHANGE date1 name="input.g.date1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date2
            #add-point:BEFORE FIELD date2 name="input.b.date2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date2
            
            #add-point:AFTER FIELD date2 name="input.a.date2"
            IF NOT cl_null(g_master.date1) AND NOT cl_null(g_master.date2) THEN
               IF g_master.date2 < g_master.date1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'axm-00397' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.date2 = NULL
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date2
            #add-point:ON CHANGE date2 name="input.g.date2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD storein1
            #add-point:BEFORE FIELD storein1 name="input.b.storein1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD storein1
            
            #add-point:AFTER FIELD storein1 name="input.a.storein1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE storein1
            #add-point:ON CHANGE storein1 name="input.g.storein1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD storein2
            #add-point:BEFORE FIELD storein2 name="input.b.storein2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD storein2
            
            #add-point:AFTER FIELD storein2 name="input.a.storein2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE storein2
            #add-point:ON CHANGE storein2 name="input.g.storein2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD storein3
            #add-point:BEFORE FIELD storein3 name="input.b.storein3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD storein3
            
            #add-point:AFTER FIELD storein3 name="input.a.storein3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE storein3
            #add-point:ON CHANGE storein3 name="input.g.storein3"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_master.xcccld             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            IF g_master.xccccomp IS NOT NULL THEN
               LET g_qryparam.where = " glaacomp = '",g_master.xccccomp,"'"
            END IF
            
            CALL q_authorised_ld()                                #呼叫開窗
            
            LET g_master.xcccld = g_qryparam.return1              
            
            DISPLAY g_master.xcccld TO xcccld              #
            
            NEXT FIELD xcccld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccccomp
            #add-point:ON ACTION controlp INFIELD xccccomp name="input.c.xccccomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_master.xccccomp             #給予default值
            
            #給予arg
            
            CALL q_ooef001_2()                                      #呼叫開窗
            
            LET g_master.xccccomp = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_master.xccccomp TO xccccomp                   #顯示到畫面上
            
            NEXT FIELD xccccomp                                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc004
            #add-point:ON ACTION controlp INFIELD xccc004 name="input.c.xccc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc005
            #add-point:ON ACTION controlp INFIELD xccc005 name="input.c.xccc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_master.xccc003             #給予default值
            
            #給予arg
            CALL q_xcat001()                                #呼叫開窗
            
            LET g_master.xccc003 = g_qryparam.return1              
            
            DISPLAY g_master.xccc003 TO xccc003              #
            
            NEXT FIELD xccc003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.date1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date1
            #add-point:ON ACTION controlp INFIELD date1 name="input.c.date1"
            
            #END add-point
 
 
         #Ctrlp:input.c.date2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date2
            #add-point:ON ACTION controlp INFIELD date2 name="input.c.date2"
            
            #END add-point
 
 
         #Ctrlp:input.c.storein1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD storein1
            #add-point:ON ACTION controlp INFIELD storein1 name="input.c.storein1"
            
            #END add-point
 
 
         #Ctrlp:input.c.storein2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD storein2
            #add-point:ON ACTION controlp INFIELD storein2 name="input.c.storein2"
            
            #END add-point
 
 
         #Ctrlp:input.c.storein3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD storein3
            #add-point:ON ACTION controlp INFIELD storein3 name="input.c.storein3"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xccc006,xccc008,xccc002,xccc007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xccc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc006
            #add-point:ON ACTION controlp INFIELD xccc006 name="construct.c.xccc006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_imaf001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc006  #顯示到畫面上
            NEXT FIELD xccc006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc006
            #add-point:BEFORE FIELD xccc006 name="construct.b.xccc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc006
            
            #add-point:AFTER FIELD xccc006 name="construct.a.xccc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc008
            #add-point:ON ACTION controlp INFIELD xccc008 name="construct.c.xccc008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc008  #顯示到畫面上
            NEXT FIELD xccc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc008
            #add-point:BEFORE FIELD xccc008 name="construct.b.xccc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc008
            
            #add-point:AFTER FIELD xccc008 name="construct.a.xccc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="construct.c.xccc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc002  #顯示到畫面上
            NEXT FIELD xccc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="construct.b.xccc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="construct.a.xccc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xccc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc007
            #add-point:ON ACTION controlp INFIELD xccc007 name="construct.c.xccc007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc007  #顯示到畫面上
            NEXT FIELD xccc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc007
            #add-point:BEFORE FIELD xccc007 name="construct.b.xccc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc007
            
            #add-point:AFTER FIELD xccc007 name="construct.a.xccc007"
            
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
            CALL axcp802_get_buffer(l_dialog)
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
         CALL axcp802_init()
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
                 CALL axcp802_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp802_transfer_argv(ls_js)
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
 
{<section id="axcp802.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp802_transfer_argv(ls_js)
 
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
 
{<section id="axcp802.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp802_process(ls_js)
 
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
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp802_process_cs CURSOR FROM ls_sql
#  FOREACH axcp802_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
#先按INPUT的条件法人、账套、年度、账套、成本计算类型、主本位币顺序和QBE的料件、特性、成本域、批号等范围
#从料件庫存成本期異動統計檔xccc_t取出明细资料，取出的资料放入axcp802_xccc_tmp

#用以下条件先筛选出inaj资料，放入axcp802_inaj_tmp
# 1、库存进出的时间范围在库存进出起始日期(tm.date1)和截至日期之间(tm.date2)
# 2、排除参数中的设置的排除仓库(xcfd_t)的库存进出和非成本仓的库存进出。
# 3、库存入库的类型根据画面设置的入库范围(tm.storein)的范围内。
      CALL s_transaction_begin()
      IF NOT axcp802_del_xcfj() THEN
         CALL s_transaction_end('N',0)
         CALL axcp802_drop_tmp_table()
         RETURN
      END IF      
      IF NOT axcp802_ins_tmp() THEN
         CALL s_transaction_end('N',0)
         CALL axcp802_drop_tmp_table()
         RETURN
      END IF

#根据料件、特性、批号、成本域的条件关联axcp802_xccc_tmp和axcp802_inaj_tmp，找出库存扣账日期和SUM（交易数量*交易单位对成本单位换算率）
#按日期降序从大到小排列
#成本域按照参数取组织或仓库，做sql字串的替换
      IF NOT axcp802_ins_xcfj() THEN
         CALL s_transaction_end('N',0)
         CALL axcp802_drop_tmp_table()
         RETURN
      END IF
      CALL s_transaction_end('Y',0)
      CALL axcp802_drop_tmp_table()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_transaction_begin()
      IF NOT axcp802_ins_tmp() THEN
         CALL s_transaction_end('N',0)
         CALL axcp802_drop_tmp_table()
         RETURN
      END IF
      
      IF NOT axcp802_ins_xcfj() THEN
         CALL s_transaction_end('N',0)
         CALL axcp802_drop_tmp_table()
         RETURN
      END IF
      CALL s_transaction_end('Y',0)
      CALL axcp802_drop_tmp_table()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp802_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp802.get_buffer" >}
PRIVATE FUNCTION axcp802_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcccld = p_dialog.getFieldBuffer('xcccld')
   LET g_master.xccccomp = p_dialog.getFieldBuffer('xccccomp')
   LET g_master.xccc004 = p_dialog.getFieldBuffer('xccc004')
   LET g_master.xccc005 = p_dialog.getFieldBuffer('xccc005')
   LET g_master.xccc003 = p_dialog.getFieldBuffer('xccc003')
   LET g_master.date1 = p_dialog.getFieldBuffer('date1')
   LET g_master.date2 = p_dialog.getFieldBuffer('date2')
   LET g_master.storein1 = p_dialog.getFieldBuffer('storein1')
   LET g_master.storein2 = p_dialog.getFieldBuffer('storein2')
   LET g_master.storein3 = p_dialog.getFieldBuffer('storein3')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp802.msgcentre_notify" >}
PRIVATE FUNCTION axcp802_msgcentre_notify()
 
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
 
{<section id="axcp802.other_function" readonly="Y" >}
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
PRIVATE FUNCTION axcp802_default()
DEFINE l_xccccomp    LIKE xccc_t.xccccomp
DEFINE l_xcccld      LIKE xccc_t.xcccld
DEFINE l_xccc003     LIKE xccc_t.xccc003
DEFINE l_xccc004     LIKE xccc_t.xccc004
DEFINE l_xccc005     LIKE xccc_t.xccc005
DEFINE l_bdate       LIKE type_t.dat
DEFINE l_edate       LIKE type_t.dat
DEFINE l_glaa003     LIKE glaa_t.glaa003
DEFINE l_success     LIKE type_t.num5

   LET l_xccccomp = ''
   LET l_xcccld   = ''
   LET l_xccc003  = ''
   LET l_xccc004  = ''
   LET l_xccc005  = ''
   
#预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING l_xccccomp,l_xcccld,l_xccc004,l_xccc005,l_xccc003
   IF g_master.xccccomp IS NULL THEN LET g_master.xccccomp = l_xccccomp END IF
   IF g_master.xcccld IS NULL THEN LET g_master.xcccld = l_xcccld END IF
   IF g_master.xccc003 IS NULL THEN LET g_master.xccc003 = l_xccc003 END IF
   IF g_master.xccc004 IS NULL THEN LET g_master.xccc004 = l_xccc004 END IF
   IF g_master.xccc005 IS NULL THEN LET g_master.xccc005 = l_xccc005 END IF
   DISPLAY BY NAME g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xccccomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcccld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcccld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xccc003_desc
      
   LET g_master.storein1 = 'Y'
   LET g_master.storein2 = 'N'
   LET g_master.storein3 = 'N'
   
   DISPLAY BY NAME g_master.storein1,g_master.storein2,g_master.storein3

#库存异动起始日期取账套+成本类型最早年期的第一天
   LET l_xccc004 = NULL
   LET l_xccc005 = NULL
   LET l_glaa003 = NULL
   LET l_bdate   = NULL
   LET l_edate   = NULL
   SELECT xccc004,xccc005 INTO l_xccc004,l_xccc005 
     FROM xccc_t
    WHERE xcccent = g_enterprise
      AND xcccld  = g_master.xcccld
      AND ROWNUM = 1
    ORDER BY xccc004,xccc005
 
   CALL s_ld_sel_glaa(g_master.xcccld,'glaa003') RETURNING l_success,l_glaa003
   CALL s_fin_date_get_period_range(l_glaa003,l_xccc004,l_xccc005) RETURNING l_bdate,l_edate
   LET g_master.date1 = l_bdate
     
#库存异动截止日期取画面年期的最后一天
   CALL s_fin_date_get_lastday(g_master.xcccld,'',g_master.xccc004,g_master.xccc005,'') RETURNING l_success,g_master.date2
   
   DISPLAY BY NAME g_master.date1,g_master.date2
 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axcp802_ins_tmp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_ins_tmp()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_where         STRING
   DEFINE l_xcat005       LIKE xcat_t.xcat005   #wujie 150515
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
 
   DROP TABLE axcp802_xccc_tmp
   LET g_msg = cl_getmsg("axc-00605",g_dlang)  #创建临时表axcp802_xccc_tmp,axcp802_inaj_tmp
   CALL cl_progress_no_window_ing(g_msg)
   
   LET l_sql =  " CREATE GLOBAL TEMPORARY TABLE axcp802_xccc_tmp AS ",
                #161109-00085#25-s mod
#                " SELECT * FROM xccc_t WHERE 1 = 2 "  #161109-00085#25-s mark
                " SELECT xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008,
                         xccc010,xccc101,xccc102,xccc102a,xccc102b,xccc102c,xccc102d,xccc102e,xccc102f,xccc102g,
                         xccc102h,xccc201,xccc202,xccc202a,xccc202b,xccc202c,xccc202d,xccc202e,xccc202f,xccc202g,
                         xccc202h,xccc203,xccc204,xccc204a,xccc204b,xccc204c,xccc204d,xccc204e,xccc204f,xccc204g,
                         xccc204h,xccc205,xccc206,xccc206a,xccc206b,xccc206c,xccc206d,xccc206e,xccc206f,xccc206g,
                         xccc206h,xccc207,xccc208,xccc208a,xccc208b,xccc208c,xccc208d,xccc208e,xccc208f,xccc208g,
                         xccc208h,xccc209,xccc210,xccc210a,xccc210b,xccc210c,xccc210d,xccc210e,xccc210f,xccc210g,
                         xccc210h,xccc211,xccc212,xccc212a,xccc212b,xccc212c,xccc212d,xccc212e,xccc212f,xccc212g,
                         xccc212h,xccc213,xccc214,xccc214a,xccc214b,xccc214c,xccc214d,xccc214e,xccc214f,xccc214g,
                         xccc214h,xccc215,xccc216,xccc216a,xccc216b,xccc216c,xccc216d,xccc216e,xccc216f,xccc216g,
                         xccc216h,xccc217,xccc218,xccc218a,xccc218b,xccc218c,xccc218d,xccc218e,xccc218f,xccc218g,
                         xccc218h,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,
                         xccc301,xccc302,xccc302a,xccc302b,xccc302c,xccc302d,xccc302e,xccc302f,xccc302g,xccc302h,
                         xccc303,xccc304,xccc304a,xccc304b,xccc304c,xccc304d,xccc304e,xccc304f,xccc304g,xccc304h,
                         xccc305,xccc306,xccc306a,xccc306b,xccc306c,xccc306d,xccc306e,xccc306f,xccc306g,xccc306h,
                         xccc307,xccc308,xccc308a,xccc308b,xccc308c,xccc308d,xccc308e,xccc308f,xccc308g,xccc308h,
                         xccc309,xccc310,xccc310a,xccc310b,xccc310c,xccc310d,xccc310e,xccc310f,xccc310g,xccc310h,
                         xccc311,xccc312,xccc312a,xccc312b,xccc312c,xccc312d,xccc312e,xccc312f,xccc312g,xccc312h,
                         xccc313,xccc314,xccc314a,xccc314b,xccc314c,xccc314d,xccc314e,xccc314f,xccc314g,xccc314h,
                         xccc401,xccc402,xccc901,xccc902,xccc902a,xccc902b,xccc902c,xccc902d,xccc902e,xccc902f,
                         xccc902g,xccc902h,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,
                         xccc903h,xccctime 
                     FROM xccc_t WHERE 1 = 2 "
                #161109-00085#25-e mod

   PREPARE axcp802_xccc_tbl FROM l_sql
   EXECUTE axcp802_xccc_tbl

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcp802_xccc_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   FREE axcp802_xccc_tbl

   DROP TABLE axcp802_inaj_tmp

   LET l_sql = " CREATE GLOBAL TEMPORARY TABLE axcp802_inaj_tmp AS ",
                #161109-00085#25-s mod
#                " SELECT * FROM inaj_t WHERE 1 = 2 "   #161109-00085#25-s mark
                #161109-00085#63 --s mark
                #" SELECT inajent,inajsite,inaj001,inaj002,inaj003,inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,
                #         inaj010,inaj011,inaj012,inaj013,inaj014,inaj015,inaj016,inaj017,inaj018,inaj019,inaj020,
                #         inaj021,inaj022,inaj023,inaj024,inaj025,inaj026,inaj027,inaj028,inaj036,inaj029,inaj030,
                #         inaj031,inaj032,inaj033,inaj034,inaj035,inaj037,inaj038,inaj039,inaj040,inaj041,inaj042,
                #         inaj043,inaj044,inaj200,inaj201,inaj202,inaj203,inaj204,inaj205,inaj206,inaj207,inaj208,
                #         inaj209,inaj045,inaj046,inaj047,inaj048,inaj049,inaj050,inaj051,inaj210,inaj211 
                #     FROM inaj_t WHERE 1 = 2 "
                #161109-00085#63 --e mark
                #161109-00085#63 --s add
                #" SELEST inajent,inajsite,inaj001,inaj002,inaj003, ", #161109-00085#79 mark
                " SELECT inajent,inajsite,inaj001,inaj002,inaj003, ",  #161109-00085#79 add
                "        inaj004,inaj005,inaj006,inaj007,inaj008, ",
                "        inaj009,inaj010,inaj011,inaj012,inaj013, ",
                "        inaj014,inaj015,inaj016,inaj017,inaj018, ",
                "        inaj019,inaj020,inaj021,inaj022,inaj023, ",
                "        inaj024,inaj025,inaj026,inaj027,inaj028, ",
                "        inaj036,inaj029,inaj030,inaj031,inaj032, ",
                "        inaj033,inaj034,inaj035,inaj037,inaj038, ",
                "        inaj039,inaj040,inaj041,inaj042,inaj043, ",
                "        inaj044,inaj200,inaj201,inaj202,inaj203, ",
                "        inaj204,inaj205,inaj206,inaj207,inaj208, ",
                "        inaj209,inajud001,inajud002,inajud003,inajud004, ",
                "        inajud005,inajud006,inajud007,inajud008,inajud009, ",
                "        inajud010,inajud011,inajud012,inajud013,inajud014, ",
                "        inajud015,inajud016,inajud017,inajud018,inajud019, ",
                "        inajud020,inajud021,inajud022,inajud023,inajud024, ",
                "        inajud025,inajud026,inajud027,inajud028,inajud029, ",
                "        inajud030,inaj045,inaj046,inaj047,inaj048, ",
                "        inaj049,inaj050,inaj051,inaj210,inaj211 ",
                "   FROM inaj_t WHERE 1 = 2 "
                #161109-00085#63 --e add
                #161109-00085#25-e mod

   PREPARE axcp802_inaj_tbl FROM l_sql
   EXECUTE axcp802_inaj_tbl

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcp802_inaj_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   FREE axcp802_inaj_tbl
   
   LET l_sql =  " INSERT INTO axcp802_xccc_tmp ",
                #161109-00085#25-s mod
#                " SELECT * FROM xccc_t ",   #161109-00085#25-s mark
                " SELECT xcccent,xccccomp,xcccld,xccc001,xccc002,xccc003,xccc004,xccc005,xccc006,xccc007,xccc008,
                         xccc010,xccc101,xccc102,xccc102a,xccc102b,xccc102c,xccc102d,xccc102e,xccc102f,xccc102g,
                         xccc102h,xccc201,xccc202,xccc202a,xccc202b,xccc202c,xccc202d,xccc202e,xccc202f,xccc202g,
                         xccc202h,xccc203,xccc204,xccc204a,xccc204b,xccc204c,xccc204d,xccc204e,xccc204f,xccc204g,
                         xccc204h,xccc205,xccc206,xccc206a,xccc206b,xccc206c,xccc206d,xccc206e,xccc206f,xccc206g,
                         xccc206h,xccc207,xccc208,xccc208a,xccc208b,xccc208c,xccc208d,xccc208e,xccc208f,xccc208g,
                         xccc208h,xccc209,xccc210,xccc210a,xccc210b,xccc210c,xccc210d,xccc210e,xccc210f,xccc210g,
                         xccc210h,xccc211,xccc212,xccc212a,xccc212b,xccc212c,xccc212d,xccc212e,xccc212f,xccc212g,
                         xccc212h,xccc213,xccc214,xccc214a,xccc214b,xccc214c,xccc214d,xccc214e,xccc214f,xccc214g,
                         xccc214h,xccc215,xccc216,xccc216a,xccc216b,xccc216c,xccc216d,xccc216e,xccc216f,xccc216g,
                         xccc216h,xccc217,xccc218,xccc218a,xccc218b,xccc218c,xccc218d,xccc218e,xccc218f,xccc218g,
                         xccc218h,xccc280,xccc280a,xccc280b,xccc280c,xccc280d,xccc280e,xccc280f,xccc280g,xccc280h,
                         xccc301,xccc302,xccc302a,xccc302b,xccc302c,xccc302d,xccc302e,xccc302f,xccc302g,xccc302h,
                         xccc303,xccc304,xccc304a,xccc304b,xccc304c,xccc304d,xccc304e,xccc304f,xccc304g,xccc304h,
                         xccc305,xccc306,xccc306a,xccc306b,xccc306c,xccc306d,xccc306e,xccc306f,xccc306g,xccc306h,
                         xccc307,xccc308,xccc308a,xccc308b,xccc308c,xccc308d,xccc308e,xccc308f,xccc308g,xccc308h,
                         xccc309,xccc310,xccc310a,xccc310b,xccc310c,xccc310d,xccc310e,xccc310f,xccc310g,xccc310h,
                         xccc311,xccc312,xccc312a,xccc312b,xccc312c,xccc312d,xccc312e,xccc312f,xccc312g,xccc312h,
                         xccc313,xccc314,xccc314a,xccc314b,xccc314c,xccc314d,xccc314e,xccc314f,xccc314g,xccc314h,
                         xccc401,xccc402,xccc901,xccc902,xccc902a,xccc902b,xccc902c,xccc902d,xccc902e,xccc902f,
                         xccc902g,xccc902h,xccc903,xccc903a,xccc903b,xccc903c,xccc903d,xccc903e,xccc903f,xccc903g,
                         xccc903h,xccctime 
                     FROM xccc_t ",
                #161109-00085#25-e mod
                "  WHERE xcccent  = '",g_enterprise,"'",
                "    AND xcccld   = '",g_master.xcccld,"'",
                "    AND xccccomp = '",g_master.xccccomp,"'",
                "    AND xccc001  = '1'",
                "    AND xccc003  = '",g_master.xccc003,"'",
                "    AND xccc004  = '",g_master.xccc004,"'",
                "    AND xccc005  = '",g_master.xccc005,"'",
                "    AND ",g_master.wc
                
   PREPARE axcp802_ins_xccc_tbl FROM l_sql
   EXECUTE axcp802_ins_xccc_tbl

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT axcp802_xccc_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE axcp802_ins_xccc_tbl

   
   LET l_sql = " INSERT INTO axcp802_inaj_tmp  ",
                #161109-00085#25-s mod
#                " SELECT * FROM inaj_t ",   #161109-00085#25-s mark
                #161109-00085#63 --s mark
                #" SELECT inajent,inajsite,inaj001,inaj002,inaj003,inaj004,inaj005,inaj006,inaj007,inaj008,inaj009,
                #         inaj010,inaj011,inaj012,inaj013,inaj014,inaj015,inaj016,inaj017,inaj018,inaj019,inaj020,
                #         inaj021,inaj022,inaj023,inaj024,inaj025,inaj026,inaj027,inaj028,inaj036,inaj029,inaj030,
                #         inaj031,inaj032,inaj033,inaj034,inaj035,inaj037,inaj038,inaj039,inaj040,inaj041,inaj042,
                #         inaj043,inaj044,inaj200,inaj201,inaj202,inaj203,inaj204,inaj205,inaj206,inaj207,inaj208,
                #         inaj209,inaj045,inaj046,inaj047,inaj048,inaj049,inaj050,inaj051,inaj210,inaj211 
                #     FROM inaj_t ",
                #161109-00085#63 --e mark
                #161109-00085#25-e mod
                #161109-00085#63 --s add
                #" SELEST inajent,inajsite,inaj001,inaj002,inaj003, ", #170221-00055#1 mark
                " SELECT inajent,inajsite,inaj001,inaj002,inaj003, ",  #170221-00055#1 add
                "        inaj004,inaj005,inaj006,inaj007,inaj008, ",
                "        inaj009,inaj010,inaj011,inaj012,inaj013, ",
                "        inaj014,inaj015,inaj016,inaj017,inaj018, ",
                "        inaj019,inaj020,inaj021,inaj022,inaj023, ",
                "        inaj024,inaj025,inaj026,inaj027,inaj028, ",
                "        inaj036,inaj029,inaj030,inaj031,inaj032, ",
                "        inaj033,inaj034,inaj035,inaj037,inaj038, ",
                "        inaj039,inaj040,inaj041,inaj042,inaj043, ",
                "        inaj044,inaj200,inaj201,inaj202,inaj203, ",
                "        inaj204,inaj205,inaj206,inaj207,inaj208, ",
                "        inaj209,inajud001,inajud002,inajud003,inajud004, ",
                "        inajud005,inajud006,inajud007,inajud008,inajud009, ",
                "        inajud010,inajud011,inajud012,inajud013,inajud014, ",
                "        inajud015,inajud016,inajud017,inajud018,inajud019, ",
                "        inajud020,inajud021,inajud022,inajud023,inajud024, ",
                "        inajud025,inajud026,inajud027,inajud028,inajud029, ",
                "        inajud030,inaj045,inaj046,inaj047,inaj048, ",
                "        inaj049,inaj050,inaj051,inaj210,inaj211 ",
                "   FROM inaj_t ",
                #161109-00085#63 --e add
                "  WHERE inajent = '",g_enterprise,"'",
                "    AND inaj209 = '",g_master.xccccomp,"'",
                "    AND inaj022 BETWEEN '",g_master.date1,"' AND '",g_master.date2,"'",
                "    AND inaj004 = 1 "  #货龄只抓入库的
   
   LET l_where = NULL
   IF g_master.storein1 = 'Y' THEN 
      IF l_where IS NULL THEN
         #LET l_where = " AND inaj036 IN ('110','111','112','102','103','104','105'"    #正常入库（工单，采购，委外入库）   #wujie 150515 add 102~105 #170221-00055#1 mark
         LET l_where = " AND (inaj036 IN ('110','111','112','102','103','104','105'"    #正常入库（工单，采购，委外入库）   #wujie 150515 add 102~105  #170221-00055#1 add
      ELSE
         LET l_where = l_where,",'110','111','112','102','103','104','105'"           #wujie 150515 add 102~105
      END IF
   END IF
   IF g_master.storein2 = 'Y' THEN 
      IF l_where IS NULL THEN
         LET l_where = " AND (inaj036 IN ('101','501'"                #杂项入库（杂收，盘盈） #161011-00027#1 wujie 160926 add ( 加在inaj036前
      ELSE
         LET l_where = l_where,",'101','501'"
      END IF
   END IF 
   IF g_master.storein3 = 'Y' THEN 
      IF l_where IS NULL THEN
         LET l_where = " AND （inaj036 IN ('113','202','303'"          #其他入库（销退，工单退料，拆件入库）  #161011-00027#1 wujie 160926 add ( 加在inaj036前
      ELSE
         LET l_where = l_where,",'113','202','303'"
      END IF          
   END IF
   IF l_where IS NOT NULL THEN
      LET l_where = l_where,")"
      #LET l_sql = l_sql,l_where  #161011-00027#1 mark by wujie
   END IF
   
   #161011-00027#1 add by wujie --begin  调拨算进去,只要是不同库之间的调拨入库就算
   LET l_where = l_where," OR (inaj036 ='401' AND EXISTS (SELECT 1 FROM indd_t WHERE inddent = inajent AND indddocno = inaj001 AND inddseq = inaj002 AND indd022 <> indd032)))"
   LET l_sql = l_sql,l_where   
   #161011-00027#1 add by wujie --end
   
   PREPARE axcp802_ins_inaj_tbl FROM l_sql
   EXECUTE axcp802_ins_inaj_tbl

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT axcp802_inaj_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   FREE axcp802_inaj_tbl
   
#把xcfd的排除掉
   DELETE FROM axcp802_inaj_tmp
    WHERE inaj008 IN
     ( SELECT xcfd010 FROM xcfd_t
        WHERE inajent = xcfdent
          AND inaj209 = xcfdcomp 
          AND xcfdld  = g_master.xcccld
          AND xcfd001 = g_master.xccc004 
          AND xcfd002 = g_master.xccc005)

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete axcp802_inaj_tmp with xcfd'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
 
#把非成本仓的排除掉
   DELETE FROM axcp802_inaj_tmp
    WHERE inaj008 IN
     (SELECT inaa001 FROM inaa_t
       WHERE inajent  = inaaent
         AND inajsite = inaasite 
         AND inaa010  <> 'Y')

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete axcp802_inaj_tmp with inaa'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
#wujie 150515 --begin
#若没有使用批次成本，则把批号改为空格 
   LET l_xcat005 = NULL
   SELECT xcat005 INTO l_xcat005 FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_master.xccc003
      
   IF l_xcat005 <> '3' THEN   #不是批次成本
      UPDATE axcp802_inaj_tmp SET inaj010 = ' '
   END IF
#wujie 150515 --end   
#把交易数量按交易单位和成本单位换算
   UPDATE axcp802_inaj_tmp SET inaj011 = inaj011 * inaj014

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd inaj011'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axcp802_ins_xcfj()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_ins_xcfj()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE l_xccc002       LIKE xccc_t.xccc002
   DEFINE l_xccc006       LIKE xccc_t.xccc006
   DEFINE l_xccc007       LIKE xccc_t.xccc007
   DEFINE l_xccc008       LIKE xccc_t.xccc008
   DEFINE l_xccc901       LIKE xccc_t.xccc901
   DEFINE l_inaj022       LIKE inaj_t.inaj022
   DEFINE l_inaj011       LIKE inaj_t.inaj011
   DEFINE l_xccc002_last  LIKE xccc_t.xccc002
   DEFINE l_xccc006_last  LIKE xccc_t.xccc006
   DEFINE l_xccc007_last  LIKE xccc_t.xccc007
   DEFINE l_xccc008_last  LIKE xccc_t.xccc008
   DEFINE l_amt01         LIKE xccc_t.xccc901
   DEFINE l_amt02         LIKE xccc_t.xccc901
   DEFINE l_amt03         LIKE xccc_t.xccc901
   DEFINE l_flag          LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET g_msg = cl_getmsg("axc-00606",g_dlang)  #关联axcp802_xccc_tmp,axcp802_inaj_tmp产生货龄资料（xcfj_t）
   CALL cl_progress_no_window_ing(g_msg)
   
#FOREACH axcp802_xccc_tmp join axcp802_inaj_tmp INTO 料号，特性，批号，成本域，库存扣帐日期，inaj交易数量（交易单位/成本单位换算已在axcp802_ins_tmp()中做掉了），xccc库存结余数量 
#   IF 料号，特性，批号，成本域，xccc年度，xccc期别  <> 上一笔 THEN
#      LET 已计算量 = 0      #已计算量在本次最后累加更新
#      IF 剩余数量 > 0 THEN   #说明这个料，特性批号啥的inaj已经都扣完了还有剩余，要到开账档继续扣
#         保存进临时表，用来等会和库存账龄开账档xcfk_t继续扣数量
#      END IF
#   END IF
#   LET 剩余数量 = xccc库存结余数量 - 已计算量 - inaj交易数量    #注意这里的已计算量是不含本次的，inaj交易数量是换算过单位换算率的
#   IF 剩余数量 > 0 THEN  #说明本次还没扣完
#      LET 本次计算量 = inaj交易数量
#   ELSE                 #全扣完了，要是按这次交易量扣，可能还倒欠，所以要按一开始的结余-已计算量
#      LET 本次计算量 = xccc库存结余 - 已计算量
#   END IF
#   IF 本次计算量 <= 0 THEN   #扣完之后剩余的都不算了
#      CONTINUE FOREACH
#   END IF
#   计算出本次计算量之后，就开始插入xcfj了
#        新增LCM存货货龄计算明细档(xcfj_t)
#              集团(xcfjent)=集团
#              法人(xcfjcomp)=法人
#              账套(xcfjld)=账套
#              成本域(xcfj001)=成本域
#              成本计算类型(xcfj002)=成本计算类型
#              年度(xcfj003)=年度
#              期别(xcfj004)=期别
#              料号(xcfj005)=料号
#              批号(xcfj006)=特性
#              项目号(xcfj007)=批号
#              日期(xcfj008)=库存扣账日期
#              数量(xcfj009)=本次计算量 = 
#   END IF
#   LET 已计算量 = 已计算量 + 本次计算量   #更新最新的已计算量
#END FOREACH 
   LET l_sql = " SELECT inaj022,SUM(inaj011) ",
               "   FROM axcp802_inaj_tmp ",
               "  WHERE inaj005 = ? ",
               "    AND inaj006 = ? ",
               "    AND inaj010 = ? "
   
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'Y' THEN   #采用成本域
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '1' THEN   #组织作为成本域
         LET l_sql = l_sql," AND inajsite IN (SELECT DISTINCT xcbf002 FROM xcbf_t", #160929-00027#1 add AND
                           "               WHERE xcbfent = '",g_enterprise,"'",
                           "                 AND xcbfcomp = '",g_master.xccccomp,"'",
                           "                 AND xcbf003 = 1",   #add   150527-00044#1  wangxina20150605                           
                           "                 AND xcbf001 = ?)"  #160929-00027#1 add )
      END IF
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '2' THEN   #仓库作为成本域
         LET l_sql = l_sql," AND inaj008 IN ((SELECT DISTINCT xcbf002 FROM xcbf_t", #160929-00027#1 add AND
                           "               WHERE xcbfent = '",g_enterprise,"'",
                           "                 AND xcbfcomp = '",g_master.xccccomp,"'",
                           "                 AND xcbf003 = 2",   #add   150527-00044#1  wangxina20150605
                           "                 AND xcbf001 = ?))"      #160929-00027#1 add ))    
      END IF
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '3' THEN   #库存管理特征作为成本域
         LET l_sql = l_sql," AND inaj006 IN (SELECT DISTINCT xcbf002 FROM xcbf_t", #160929-00027#1 add AND
                           "               WHERE xcbfent = '",g_enterprise,"'",
                           "                 AND xcbfcomp = '",g_master.xccccomp,"'",
                           "                 AND xcbf003 = 3",   #add   150527-00044#1  wangxina20150605
                           "                 AND xcbf001 = ?)"        #160929-00027#1 add )
       END IF
   END IF
   LET l_sql = l_sql ," GROUP BY inaj022 ",
                      " ORDER BY inaj022 DESC"

   PREPARE inaj_pb FROM l_sql   
   DECLARE inaj_cs CURSOR FOR inaj_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ' PREPARE inaj_pb'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_sql = " SELECT DISTINCT xccc006,xccc007,xccc008,xccc002 ",
               "   FROM axcp802_xccc_tmp ",
               " ORDER BY xccc006,xccc007,xccc008,xccc002 "
               
   PREPARE xccc_pb FROM l_sql   
   DECLARE xccc_cs CURSOR FOR xccc_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ' PREPARE xccc_pb'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
      
   LET l_xccc002 = NULL
   LET l_xccc006 = NULL
   LET l_xccc007 = NULL
   LET l_xccc008 = NULL
   LET l_xccc901 = 0
   LET l_inaj022 = NULL
   LET l_inaj011 = 0
   LET l_xccc002_last = NULL
   LET l_xccc006_last = NULL
   LET l_xccc007_last = NULL
   LET l_xccc008_last = NULL
   LET l_amt01 = 0  #已计算量
   LET l_amt02 = 0  #剩余数量
   LET l_amt03 = 0  #本次计算量
   CALL g_xcfk.clear()

   FOREACH xccc_cs INTO l_xccc006,l_xccc007,l_xccc008,l_xccc002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         LET r_success = FALSE
         RETURN r_success
      END IF 
#wujie 151116 --begin
#假设有多个料在外层foreach循环，前一个料如果l_amt02没用完，需要记录到tmp2的，但是下面会把l_amt02=0，导致丢失这笔，所以在重置l_amt02之前，抢先记录到tmp2
#这样内层foreach里判断l_xccc006_last其实没用了
      IF l_amt02>0 THEN
         CALL axcp802_ins_tmp2(l_xccc006_last,l_xccc007_last,l_xccc008_last,l_xccc002_last,'','',l_amt02)
         LET l_amt02 = 0   #wujie 151116   记录到tmp2了，就要重置l_amt02不能影响下一笔
      END IF
#wujie 151116 --end  
#wujie 150515 --begin
      LET l_amt01 = 0  #已计算量
      LET l_amt02 = 0  #剩余数量
      LET l_amt03 = 0  #本次计算量
#wujie 150515 --end
      SELECT SUM(xccc901) INTO l_xccc901  #库存结余不放foreach的sql是因为它的group条件与inaj011不同
        FROM axcp802_xccc_tmp
       WHERE xccc006 = l_xccc006
         AND xccc007 = l_xccc007
         AND xccc008 = l_xccc008
         AND xccc002 = l_xccc002
         AND xccc004 = g_master.xccc004
         AND xccc005 = g_master.xccc005
         
      LET l_flag = FALSE   #初始化,FALSE表示没有进过下面第二层的FOREACH
      DISPLAY l_xccc006 TO FORMONLY.p1
      FOREACH inaj_cs USING l_xccc006,l_xccc007,l_xccc008,l_xccc002 INTO l_inaj022,l_inaj011   #wujie 150515 #161011-00027 add by wujie add l_xccc002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
      
            LET r_success = FALSE
            RETURN r_success
         END IF

         IF l_inaj011 IS NULL THEN LET l_inaj011 = 0 END IF
         IF l_xccc901 IS NULL THEN LET l_xccc901 = 0 ENd IF
   #初始时上一笔资料给当前值
         IF l_xccc006_last IS NULL THEN LET l_xccc006_last = l_xccc006 END IF 
         IF l_xccc007_last IS NULL THEN LET l_xccc007_last = l_xccc007 END IF
         IF l_xccc008_last IS NULL THEN LET l_xccc008_last = l_xccc008 END IF
         IF l_xccc002_last IS NULL THEN LET l_xccc002_last = l_xccc002 END IF   
   #   IF 料号，特性，批号，成本域，xccc年度，xccc期别  <> 上一笔 THEN
   #      LET 已计算量 = 0      #已计算量在本次最后累加更新
   #      IF 剩余数量 > 0 THEN   #说明这个料，特性批号啥的inaj已经都扣完了还有剩余，要到开账档继续扣
   #         保存进临时表，用来等会和库存账龄开账档xcfk_t继续扣数量
   #      END IF
   #   END IF
         IF l_xccc006 <> l_xccc006_last OR l_xccc007 <> l_xccc007_last OR l_xccc008 <> l_xccc008_last OR l_xccc002 <> l_xccc002_last THEN
            LET l_xccc006_last = l_xccc006 
            LET l_xccc007_last = l_xccc007
            LET l_xccc008_last = l_xccc008
            LET l_xccc002_last = l_xccc002 
            LET l_amt01 = 0   #已计算量   不含本次的，含本次的在最后更新
            IF l_amt02 > 0 THEN   #如果切换料件了，剩余数量还大于0，说明扣不完，没扣完的要去开账档继续扣
               CALL axcp802_ins_tmp2(l_xccc006,l_xccc007,l_xccc008,l_xccc002,l_inaj022,l_inaj011,l_amt02)
               LET l_amt02 = 0   #wujie 151116   记录到tmp2了，就要重置l_amt02不能影响下一笔
            END IF
         END IF
   #   LET 剩余数量 = xccc库存结余数量 - 已计算量 - inaj交易数量    #注意这里的已计算量是不含本次的，inaj交易数量是换算过单位换算率的
         LET l_amt02 = l_xccc901 - l_amt01 - l_inaj011
   #   IF 剩余数量 > 0 THEN  #说明本次还没扣完
   #      LET 本次计算量 = inaj交易数量
   #   ELSE                 #全扣完了，要是按这次交易量扣，可能还倒欠，所以要按一开始的结余-已计算量
   #      LET 本次计算量 = xccc库存结余 - 已计算量
   #   END IF
         IF l_amt02 > 0 THEN
            LET l_amt03 = l_inaj011
         ELSE
            LET l_amt03 = l_xccc901 - l_amt01
         END IF
         IF l_amt03 IS NULL THEN LET l_amt03 = 0 END IF
   #   IF 剩余数量 < 0 THEN   #扣完之后剩余的都不算了
   #      CONTINUE FOREACH
   #   END IF
         IF l_amt03 <= 0 THEN  #wujie 150515 amt02  -->amt03 
            CONTINUE FOREACH
         END IF
   #   计算出本次计算量之后，就开始插入xcfj了
   #        新增LCM存货货龄计算明细档(xcfj_t)
   #              集团(xcfjent)=集团
   #              法人(xcfjcomp)=法人
   #              账套(xcfjld)=账套
   #              成本域(xcfj001)=成本域
   #              成本计算类型(xcfj002)=成本计算类型
   #              年度(xcfj003)=年度
   #              期别(xcfj004)=期别
   #              料号(xcfj005)=料号
   #              批号(xcfj006)=特性
   #              项目号(xcfj007)=批号
   #              日期(xcfj008)=库存扣账日期
   #              数量(xcfj009)=本次计算量 
   #   END IF
         INSERT INTO xcfj_t (xcfjent,xcfjcomp,xcfjld,xcfj001,xcfj002,xcfj003,xcfj004,xcfj005,xcfj006,xcfj007,xcfj008,xcfj009)
                     VALUES (g_enterprise,g_master.xccccomp,g_master.xcccld,l_xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,l_xccc006,l_xccc007,l_xccc008,l_inaj022,l_amt03)
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert xcfj_t1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF
   #   LET 已计算量 = 已计算量 + 本次计算量   #更新最新的已计算量   
         LET l_amt01 = l_amt01 + l_amt03
         LET l_amt02 = l_xccc901 - l_amt01   #本次之后的剩余量   #wujie 150515
         LET l_flag = TRUE
      END FOREACH
#没有进以上FOREACH的,说明有xccc没有inaj,需要从货龄开账去扣
      IF NOT l_flag THEN
         CALL axcp802_ins_tmp2(l_xccc006,l_xccc007,l_xccc008,l_xccc002,'','',l_xccc901)
         LET l_amt02 = 0   #wujie 151116   记录到tmp2了，就要重置l_amt02不能影响下一笔
      END IF
   END FOREACH
#wujie 150515 --begin
#除了上面没进foreach的情况，还有进了但是没有扣完的,比如库存1000，但是inaj进项只找到一笔600的，那剩余的400就只能在这里被记录，去开账里扣
      IF l_amt02>0 THEN
         CALL axcp802_ins_tmp2(l_xccc006,l_xccc007,l_xccc008,l_xccc002,'','',l_amt02)
         LET l_amt02 = 0   #wujie 151116   记录到tmp2了，就要重置l_amt02不能影响下一笔
      END IF
#wujie 150515 --end   
#再对未扣完的资料进行处理，从期初开账资料里继续扣
   IF NOT axcp802_ins_xcfj_xcfk() THEN
      LET r_success = FALSE
      RETURN r_success   
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axcp802_drop_tmp_table()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_drop_tmp_table()

   DROP TABLE axcp802_xccc_tmp
   DROP TABLE axcp802_inaj_tmp
END FUNCTION

################################################################################
# Descriptions...: 将未扣完的资料在开账档里继续扣
# Memo...........:
# Usage..........: CALL axcp802_ins_tmp2(p_xccc006,p_xccc007,p_xccc008,p_xccc002,p_inaj022,p_inaj011,p_amt02)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_ins_tmp2(p_xccc006,p_xccc007,p_xccc008,p_xccc002,p_inaj022,p_inaj011,p_amt02)
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE p_xccc006  LIKE xccc_t.xccc006 
   DEFINE p_xccc007  LIKE xccc_t.xccc007
   DEFINE p_xccc008  LIKE xccc_t.xccc008
   DEFINE p_xccc002  LIKE xccc_t.xccc002
   DEFINE p_inaj022  LIKE inaj_t.inaj022
   DEFINE p_inaj011  LIKE inaj_t.inaj011
   DEFINE p_amt02    LIKE inaj_t.inaj011

   IF p_amt02 = 0 THEN RETURN END IF    #wujie 150515
   LET l_cnt = g_xcfk.getLength() + 1
   IF l_cnt = 0 OR l_cnt IS NULL THEN LET l_cnt = 1 END IF
   LET g_xcfk[l_cnt].xccc006 = p_xccc006
   LET g_xcfk[l_cnt].xccc007 = p_xccc007
   LET g_xcfk[l_cnt].xccc008 = p_xccc008
   LET g_xcfk[l_cnt].xccc002 = p_xccc002
   LET g_xcfk[l_cnt].inaj022 = p_inaj022
   LET g_xcfk[l_cnt].inaj011 = p_inaj011
   LET g_xcfk[l_cnt].amt02   = p_amt02
END FUNCTION

################################################################################
# Descriptions...: 没扣完的从期初开账里继续扣
# Memo...........:
# Usage..........: CALL axcp802_ins_xcfj_xcfk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_ins_xcfj_xcfk()
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE i,j,l_length    LIKE type_t.num5    #161011-00027 add by wujie 160926 add j
   #161109-00085#25-s mod
#   DEFINE l_xcfk          RECORD LIKE xcfk_t.*   #161109-00085#25-s mark
   DEFINE l_xcfk          RECORD  #存貨貨齡數量期初開帳檔
       xcfkent LIKE xcfk_t.xcfkent, #企業編號
       xcfkcomp LIKE xcfk_t.xcfkcomp, #法人組織
       xcfksite LIKE xcfk_t.xcfksite, #營運組織
       xcfk001 LIKE xcfk_t.xcfk001, #料件
       xcfk002 LIKE xcfk_t.xcfk002, #特性
       xcfk003 LIKE xcfk_t.xcfk003, #倉庫
       xcfk004 LIKE xcfk_t.xcfk004, #儲位
       xcfk005 LIKE xcfk_t.xcfk005, #批號
       xcfk006 LIKE xcfk_t.xcfk006, #異動日期
       xcfk007 LIKE xcfk_t.xcfk007, #成本單位
      #xcfk008 LIKE xcfk_t.xcfk008  #數量 #161109-00085#63 mark
       #161109-00085#63 --s add
       xcfk008 LIKE xcfk_t.xcfk008, #數量
       xcfkud001 LIKE xcfk_t.xcfkud001, #自定義欄位(文字)001
       xcfkud002 LIKE xcfk_t.xcfkud002, #自定義欄位(文字)002
       xcfkud003 LIKE xcfk_t.xcfkud003, #自定義欄位(文字)003
       xcfkud004 LIKE xcfk_t.xcfkud004, #自定義欄位(文字)004
       xcfkud005 LIKE xcfk_t.xcfkud005, #自定義欄位(文字)005
       xcfkud006 LIKE xcfk_t.xcfkud006, #自定義欄位(文字)006
       xcfkud007 LIKE xcfk_t.xcfkud007, #自定義欄位(文字)007
       xcfkud008 LIKE xcfk_t.xcfkud008, #自定義欄位(文字)008
       xcfkud009 LIKE xcfk_t.xcfkud009, #自定義欄位(文字)009
       xcfkud010 LIKE xcfk_t.xcfkud010, #自定義欄位(文字)010
       xcfkud011 LIKE xcfk_t.xcfkud011, #自定義欄位(數字)011
       xcfkud012 LIKE xcfk_t.xcfkud012, #自定義欄位(數字)012
       xcfkud013 LIKE xcfk_t.xcfkud013, #自定義欄位(數字)013
       xcfkud014 LIKE xcfk_t.xcfkud014, #自定義欄位(數字)014
       xcfkud015 LIKE xcfk_t.xcfkud015, #自定義欄位(數字)015
       xcfkud016 LIKE xcfk_t.xcfkud016, #自定義欄位(數字)016
       xcfkud017 LIKE xcfk_t.xcfkud017, #自定義欄位(數字)017
       xcfkud018 LIKE xcfk_t.xcfkud018, #自定義欄位(數字)018
       xcfkud019 LIKE xcfk_t.xcfkud019, #自定義欄位(數字)019
       xcfkud020 LIKE xcfk_t.xcfkud020, #自定義欄位(數字)020
       xcfkud021 LIKE xcfk_t.xcfkud021, #自定義欄位(日期時間)021
       xcfkud022 LIKE xcfk_t.xcfkud022, #自定義欄位(日期時間)022
       xcfkud023 LIKE xcfk_t.xcfkud023, #自定義欄位(日期時間)023
       xcfkud024 LIKE xcfk_t.xcfkud024, #自定義欄位(日期時間)024
       xcfkud025 LIKE xcfk_t.xcfkud025, #自定義欄位(日期時間)025
       xcfkud026 LIKE xcfk_t.xcfkud026, #自定義欄位(日期時間)026
       xcfkud027 LIKE xcfk_t.xcfkud027, #自定義欄位(日期時間)027
       xcfkud028 LIKE xcfk_t.xcfkud028, #自定義欄位(日期時間)028
       xcfkud029 LIKE xcfk_t.xcfkud029, #自定義欄位(日期時間)029
       xcfkud030 LIKE xcfk_t.xcfkud030  #自定義欄位(日期時間)030
       #161109-00085#63 --e add
          END RECORD
   #161109-00085#25-e mod
   
   DEFINE l_amt01         LIKE xccc_t.xccc901
   DEFINE l_amt02         LIKE xccc_t.xccc901
   DEFINE l_amt03         LIKE xccc_t.xccc901
   DEFINE l_amt03_sum     LIKE xccc_t.xccc901
   
  
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   LET g_msg = cl_getmsg("axc-00607",g_dlang)  #从货龄开账档中抓取资料
   CALL cl_progress_no_window_ing(g_msg)
   
   IF g_xcfk.getLength() = 0 THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   #161109-00085#25-s mod
#   LET l_sql = " SELECT * FROM xcfk_t ",   #161109-00085#25-s mark
   #161109-00085#63 --s mark
   #LET l_sql = " SELECT xcfkent,xcfkcomp,xcfksite,xcfk001,xcfk002,xcfk003,xcfk004,xcfk005,xcfk006,xcfk007,xcfk008 
   #                 FROM xcfk_t ",
   #161109-00085#63 --e mark
   #161109-00085#63 --s add
   LET l_sql = " SELECT xcfkent,xcfkcomp,xcfksite,xcfk001,xcfk002, ",
               "        xcfk003,xcfk004,xcfk005,xcfk006,xcfk007, ",
               "        xcfk008,xcfkud001,xcfkud002,xcfkud003,xcfkud004, ",
               "        xcfkud005,xcfkud006,xcfkud007,xcfkud008,xcfkud009, ",
               "        xcfkud010,xcfkud011,xcfkud012,xcfkud013,xcfkud014, ",
               "        xcfkud015,xcfkud016,xcfkud017,xcfkud018,xcfkud019, ",
               "        xcfkud020,xcfkud021,xcfkud022,xcfkud023,xcfkud024, ",
               "        xcfkud025,xcfkud026,xcfkud027,xcfkud028,xcfkud029, ",
               "        xcfkud030 ",
               "   FROM xcfk_t ",
   #161109-00085#63 --e add
   #161109-00085#25-e mod
               "  WHERE xcfkent ='",g_enterprise,"'",
               "    AND xcfkcomp = '",g_master.xccccomp,"'",
               "    AND xcfk001 = ?",   #料件
               "    AND xcfk002 = ?",   #特性
               "    AND xcfk005 = ?"    #批号
 
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'Y' THEN   #采用成本域
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '1' THEN   #组织作为成本域
         LET l_sql = l_sql," AND xcfksite = ? "                    
      END IF
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '2' THEN   #仓库作为成本域
         LET l_sql = l_sql," AND xcfk003 = ? "                   
      END IF
      IF cl_get_para(g_enterprise,g_site,'S-FIN-6002') = '3' THEN   #库存管理特征作为成本域
         #xcfk目前还没有对应的栏位，先预留                     
      END IF
   END IF
   #LET l_sql = l_sql," AND xcfk002 = ? ORDER BY xcfk006 DESC"    #wujie 150515 
   LET l_sql = l_sql,"  ORDER BY xcfk006 DESC"    #wujie 150515   #161011-00027 modify by wujie  remove xcfk002
   PREPARE xcfk_pb FROM l_sql   
   DECLARE xcfk_cs CURSOR FOR xcfk_pb
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ' PREPARE xcfk_pb'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF

   LET l_length = g_xcfk.getLength()
   FOR j = 1 TO l_length  #161011-00027 i->j mod by wujie
       LET i = j          #161011-00027 add by wujie
       DISPLAY g_xcfk[i].xccc006 TO FORMONLY.p1
       LET l_amt01 = 0  #已计算量
       LET l_amt02 = 0  #剩余数量
       LET l_amt03 = 0  #本次计算量
       LET l_amt03_sum = 0 #用来总计每一类开账资料的总量，来计算第一阶段剩余库存是否继续还有剩余
       INITIALIZE l_xcfk.* TO NULL
       OPEN xcfk_cs USING g_xcfk[i].xccc006,g_xcfk[i].xccc007,g_xcfk[i].xccc008,g_xcfk[i].xccc002
       #161109-00085#25-s mod
#       FOREACH xcfk_cs INTO l_xcfk.*   #161109-00085#25-s mark
       #161109-00085#63 --s mark
       #FOREACH xcfk_cs INTO l_xcfk.xcfkent,l_xcfk.xcfkcomp,l_xcfk.xcfksite,l_xcfk.xcfk001,l_xcfk.xcfk002,
       #                     l_xcfk.xcfk003,l_xcfk.xcfk004,l_xcfk.xcfk005,l_xcfk.xcfk006,l_xcfk.xcfk007,l_xcfk.xcfk008
       #161109-00085#63 --e mark
       #161109-00085#25-e mod
       #161109-00085#63 --s add
       FOREACH xcfk_cs INTO l_xcfk.xcfkent,l_xcfk.xcfkcomp,l_xcfk.xcfksite,l_xcfk.xcfk001,l_xcfk.xcfk002,
                            l_xcfk.xcfk003,l_xcfk.xcfk004,l_xcfk.xcfk005,l_xcfk.xcfk006,l_xcfk.xcfk007,
                            l_xcfk.xcfk008,l_xcfk.xcfkud001,l_xcfk.xcfkud002,l_xcfk.xcfkud003,l_xcfk.xcfkud004,
                            l_xcfk.xcfkud005,l_xcfk.xcfkud006,l_xcfk.xcfkud007,l_xcfk.xcfkud008,l_xcfk.xcfkud009,
                            l_xcfk.xcfkud010,l_xcfk.xcfkud011,l_xcfk.xcfkud012,l_xcfk.xcfkud013,l_xcfk.xcfkud014,
                            l_xcfk.xcfkud015,l_xcfk.xcfkud016,l_xcfk.xcfkud017,l_xcfk.xcfkud018,l_xcfk.xcfkud019,
                            l_xcfk.xcfkud020,l_xcfk.xcfkud021,l_xcfk.xcfkud022,l_xcfk.xcfkud023,l_xcfk.xcfkud024,
                            l_xcfk.xcfkud025,l_xcfk.xcfkud026,l_xcfk.xcfkud027,l_xcfk.xcfkud028,l_xcfk.xcfkud029,
                            l_xcfk.xcfkud030
       #161109-00085#63 --e add
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL 
             LET g_errparam.extend = 'foreach:' 
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = TRUE 
             CALL cl_err()
          
             LET r_success = FALSE
             RETURN r_success
          END IF  
                    
          IF l_xcfk.xcfk008 IS NULL THEN LET l_xcfk.xcfk008 = 0 END IF
#             剩余量=总库存量(指在第2种的剩余量)-已计算量-本笔库存数量
          LET l_amt02 = g_xcfk[i].amt02 - l_amt01 - l_xcfk.xcfk008
#             如果剩余量大于0
#                本次计算量=本笔库存数量
#             如果剩余量小于0
#                本次计算量=总库存量(指在第2种的剩余量)-已计算量
          IF l_amt02 > 0 THEN
             LET l_amt03 = l_xcfk.xcfk008
          ELSE
             LET l_amt03 = g_xcfk[i].amt02 - l_amt01
          END IF
          IF l_amt03 IS NULL THEN LET l_amt03 = 0 END IF
          IF l_amt03 <= 0 THEN
             CONTINUE FOREACH
          END IF
          LET l_amt03_sum = l_amt03_sum + l_amt03
#             新增LCM存货货龄计算明细档(xcfj_t)
#                集团(xcfjent)=集团
#                法人(xcfjcomp)=法人
#                账套(xcfjld)=账套
#                成本域(xcfj001)=成本域
#                成本计算类型(xcfj002)=成本计算类型
#                年度(xcfj003)=年度
#                期别(xcfj004)=期别
#                料号(xcfj005)=料号
#                批号(xcfj006)=特性
#                项目号(xcfj007)=批号
#                日期(xcfj008)=库存扣账日期
#                数量(xcfj009)=本次计算量
          
          INSERT INTO xcfj_t (xcfjent,xcfjcomp,xcfjld,xcfj001,xcfj002,xcfj003,xcfj004,xcfj005,xcfj006,xcfj007,xcfj008,xcfj009)
                      VALUES (g_enterprise,g_master.xccccomp,g_master.xcccld,g_xcfk[i].xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,g_xcfk[i].xccc006,g_xcfk[i].xccc007,g_xcfk[i].xccc008,l_xcfk.xcfk006,l_amt03)
#161011-00027 add by wujie begin
          IF cl_err_sql_dup_value(SQLCA.sqlcode) THEN   #若重复插入则更新
             UPDATE xcfj_t SET xcfj009 = xcfj009 + l_amt03
              WHERE xcfjent = g_enterprise
                AND xcfjld  = g_master.xcccld
                AND xcfj001 = g_xcfk[i].xccc002
                AND xcfj002 = g_master.xccc003
                AND xcfj003 = g_master.xccc004
                AND xcfj004 = g_master.xccc005
                AND xcfj005 = g_xcfk[i].xccc006
                AND xcfj006 = g_xcfk[i].xccc007
                AND xcfj007 = g_xcfk[i].xccc008
                AND xcfj008 = l_xcfk.xcfk006
                
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'update xcfj_t31'
                LET g_errparam.popup = TRUE
                CALL cl_err()
             
                LET r_success = FALSE
                RETURN r_success                
             END IF
          END IF
#161011-00027 add by wujie  --end        
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert xcfj_t2'
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             LET r_success = FALSE
             RETURN r_success
          END IF
          
#             已计算量=己计算量(初始为0)+本笔库存数量
          LET l_amt01 = l_amt01 + l_amt03
          
       END FOREACH
       LET g_xcfk[i].amt02 = g_xcfk[i].amt02 - l_amt03_sum
   END FOR
   FOR j = 1 TO g_xcfk.getLength() #161011-00027 mod by wujie i->j
      LET i = j                    #161011-00027 add by wujie
      IF g_xcfk[i].amt02 <= 0 THEN
         CALL g_xcfk.deleteElement(i)   #库存扣光的删除，剩下开账也没抵扣光的，最后处理
      END IF
   END FOR
   LET l_length = g_xcfk.getLength()
   IF l_length > 0 THEN    #还有开账档里找不到或者没扣完的
#把剩余数量归属日期设为库存异动起始日期，存入LCM存货货龄计算明细档(xcfj_t)
      FOR j = 1 TO l_length   #161011-00027 mod by wujie i->j
        LET i = j             #161011-00027 add by wujie
          IF g_xcfk[i].amt02 <=0 THEN CONTINUE FOR END IF    #wujie 150515
          INSERT INTO xcfj_t (xcfjent,xcfjcomp,xcfjld,xcfj001,xcfj002,xcfj003,xcfj004,xcfj005,xcfj006,xcfj007,xcfj008,xcfj009)
                      VALUES (g_enterprise,g_master.xccccomp,g_master.xcccld,g_xcfk[i].xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,g_xcfk[i].xccc006,g_xcfk[i].xccc007,g_xcfk[i].xccc008,g_master.date1,g_xcfk[i].amt02)

          IF cl_err_sql_dup_value(SQLCA.sqlcode) THEN   #若重复插入则更新
             UPDATE xcfj_t SET xcfj009 = xcfj009 + g_xcfk[i].amt02
              WHERE xcfjent = g_enterprise
                AND xcfjld  = g_master.xcccld
                AND xcfj001 = g_xcfk[i].xccc002
                AND xcfj002 = g_master.xccc003
                AND xcfj003 = g_master.xccc004
                AND xcfj004 = g_master.xccc005
                AND xcfj005 = g_xcfk[i].xccc006
                AND xcfj006 = g_xcfk[i].xccc007
                AND xcfj007 = g_xcfk[i].xccc008
                AND xcfj008 = g_master.date1
                
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = 'update xcfj_t3'
                LET g_errparam.popup = TRUE
                CALL cl_err()
             
                LET r_success = FALSE
                RETURN r_success                
             END IF
          END IF
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = 'insert xcfj_t3'
             LET g_errparam.popup = TRUE
             CALL cl_err()
          
             LET r_success = FALSE
             RETURN r_success
          END IF          
      END FOR 
   END IF   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axcp802_del_xcfj()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp802_del_xcfj()
DEFINE l_cnt                LIKE type_t.num5
DEFINE r_success            LIKE type_t.num5
DEFINE l_wc                 STRING
DEFINE l_sql                STRING

   LET r_success = TRUE
   LET l_cnt = 0 
   IF g_master.wc IS NOT NULL THEN
      LET l_wc = g_master.wc
      LET l_wc = s_chr_replace(l_wc,'xccc002','xcfj001',0)
      LET l_wc = s_chr_replace(l_wc,'xccc006','xcfj005',0)
      LET l_wc = s_chr_replace(l_wc,'xccc007','xcfj006',0)
      LET l_wc = s_chr_replace(l_wc,'xccc008','xcfj007',0)
   END IF
   IF l_wc IS NULL THEN LET l_wc = ' 1=1' END IF
   LET l_sql = " SELECT COUNT(*) FROM xcfj_t ",
               "  WHERE xcfjent = ? ",
               "    AND xcfjld  = ? ",
               "    AND xcfj002 = ? ",
               "    AND xcfj003 = ? ",
               "    AND xcfj004 = ? ",
               "    AND ",l_wc

   PREPARE axcp802_xcfj_cnt_pb FROM l_sql   
   DECLARE axcp802_xcfj_cnt_cs CURSOR FOR axcp802_xcfj_cnt_pb
  
   OPEN axcp802_xcfj_cnt_cs USING g_enterprise,g_master.xcccld,g_master.xccc003,g_master.xccc004,g_master.xccc005
   FETCH axcp802_xcfj_cnt_cs INTO l_cnt
     
   IF l_cnt > 0  THEN  
      IF cl_ask_confirm('axc-00594') THEN
         LET l_sql = " DELETE FROM xcfj_t ",
                     "  WHERE xcfjent = ? ",
                     "    AND xcfjld  = ? ",
                     "    AND xcfj002 = ? ",
                     "    AND xcfj003 = ? ",
                     "    AND xcfj004 = ? ",
                     "    AND ",l_wc
         
         PREPARE axcp802_xcfj_del_pb FROM l_sql   
         EXECUTE axcp802_xcfj_del_pb USING g_enterprise,g_master.xcccld,g_master.xccc003,g_master.xccc004,g_master.xccc005

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'delete xcfj_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_success = FALSE
            RETURN r_success
         END IF 
      END IF
   ELSE
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
