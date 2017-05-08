#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-12-30 10:31:49), PR版次:0006(2016-10-24 09:48:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000063
#+ Filename...: afmp500
#+ Description: 計提投資收益
#+ Creator....: 02097(2015-04-28 11:32:21)
#+ Modifier...: 02097 -SD/PR- 06814
 
{</section>}
 
{<section id="afmp500.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151029-00012#14  2015/11/01  By Reanna   寫入afmt560時增加計算本幣金額(依主帳套本位幣取位)
#151117-00001#3   2015/11/20  By 02097    1.投資類型= '2' 不計息,則不納入計算/2.寫入計息檔時, 計息來源='3' 應計利息
#160321-00016#26  2016/03/24  By Jessy    修正azzi920重複定義之錯誤訊息
#161006-00005#24  2016/10/24  By 06814    1.法人需azzi800控卡 
#                                         2.投資組織(fmmj002)開窗改用q_ooef001_33( )，where條件拿掉(q_ooef001_33已經有條件)
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
       l_glaacomp LIKE type_t.chr10, 
   glaacomp_desc LIKE type_t.chr80, 
   l_yy LIKE type_t.chr500, 
   l_mm LIKE type_t.chr500, 
   l_docno1 LIKE type_t.chr500, 
   docno1_desc LIKE type_t.chr80, 
   fmmjsite LIKE fmmj_t.fmmjsite, 
   fmmjdocno LIKE fmmj_t.fmmjdocno, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaald         LIKE glaa_t.glaald
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_glaa024        LIKE glaa_t.glaa024
DEFINE g_accdate_s      LIKE glav_t.glav004   #當期起始日
DEFINE g_accdate_e      LIKE glav_t.glav004   #當期起始日
DEFINE g_ar             DYNAMIC ARRAY OF RECORD
                  chr   LIKE type_t.chr100,
                  dat   LIKE type_t.dat,
                  num   LIKE type_t.num5
                    END RECORD
DEFINE g_wc_cs_comp         STRING   #161006-00005#24 20161024 add by beckxie
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmp500.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL afmp500_cre_tmp()
   #161006-00005#24 20161024 add by beckxie---S
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #161006-00005#24 20161024 add by beckxie---E
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afmp500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp500 WITH FORM cl_ap_formpath("afm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afmp500_init()
 
      #進入選單 Menu (="N")
      CALL afmp500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE afmp500_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp500.init" >}
#+ 初始化作業
PRIVATE FUNCTION afmp500_init()
 
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
 
{<section id="afmp500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp500_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt    LIKE type_t.num5   #161006-00005#24 20161024 add by beckxie
   DEFINE l_sql    STRING             #161006-00005#24 20161024 add by beckxie
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_glaacomp,g_master.l_yy,g_master.l_mm,g_master.l_docno1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_glaacomp
            #add-point:BEFORE FIELD l_glaacomp name="input.b.l_glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_glaacomp
            
            #add-point:AFTER FIELD l_glaacomp name="input.a.l_glaacomp"
            IF NOT cl_null(g_master.l_glaacomp) THEN
               CALL s_fin_comp_chk(g_master.l_glaacomp) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = g_errno 
                  #160321-00016#26 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#26 --e add
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#24 20161024 add by beckxie---S
               #檢查是否存在於temp table之中 
               LET l_sql = "SELECT COUNT(1) ",
                           "  FROM ooef_t ",
                           " WHERE ooefent = ",g_enterprise,
                           "   AND ooef001 = '",g_master.l_glaacomp,"' ",
                           "   AND ooef001 IN ",g_wc_cs_comp
               PREPARE afmp500_comp_chk_pre FROM l_sql
               LET l_cnt = 0
               EXECUTE afmp500_comp_chk_pre INTO l_cnt
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'azz-00088'   #角色配置要先設定才能設定可拜訪據點
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD l_glaacomp
               END IF
               #161006-00005#24 20161024 add by beckxie---E
               CALL afmp500_set_ld_info()
               CALL s_desc_get_department_desc(g_master.l_glaacomp) RETURNING g_master.glaacomp_desc
               DISPLAY BY NAME g_master.glaacomp_desc
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_glaacomp
            #add-point:ON CHANGE l_glaacomp name="input.g.l_glaacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_yy
            #add-point:BEFORE FIELD l_yy name="input.b.l_yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_yy
            
            #add-point:AFTER FIELD l_yy name="input.a.l_yy"
            IF NOT cl_null(g_master.l_yy) THEN
               IF g_master.l_yy < 1900 OR g_master.l_yy > 2999 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'afa-00310' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL afmp500_set_ld_info()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_yy
            #add-point:ON CHANGE l_yy name="input.g.l_yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_mm
            #add-point:BEFORE FIELD l_mm name="input.b.l_mm"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_mm
            
            #add-point:AFTER FIELD l_mm name="input.a.l_mm"
            IF NOT cl_null(g_master.l_mm) THEN
               IF g_master.l_mm < 1 OR g_master.l_mm > 13 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'acr-00044' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL afmp500_set_ld_info()
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_mm
            #add-point:ON CHANGE l_mm name="input.g.l_mm"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_docno1
            #add-point:BEFORE FIELD l_docno1 name="input.b.l_docno1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_docno1
            
            #add-point:AFTER FIELD l_docno1 name="input.a.l_docno1"
            IF NOT cl_null(g_master.l_docno1) THEN
               
               IF NOT s_aooi200_fin_chk_docno(g_glaald,'','',g_master.l_docno1,g_today,'afmt560') THEN
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.l_docno1) RETURNING g_master.docno1_desc
            DISPLAY BY NAME g_master.docno1_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_docno1
            #add-point:ON CHANGE l_docno1 name="input.g.l_docno1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_glaacomp
            #add-point:ON ACTION controlp INFIELD l_glaacomp name="input.c.l_glaacomp"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef003 = 'Y'"                               #161006-00005#24 20161024 mark by beckxie
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161006-00005#24 20161024  add by beckxie
            CALL q_ooef001()
            LET g_master.l_glaacomp = g_qryparam.return1  
            DISPLAY BY NAME g_master.l_glaacomp
            NEXT FIELD l_glaacomp
            #END add-point
 
 
         #Ctrlp:input.c.l_yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_yy
            #add-point:ON ACTION controlp INFIELD l_yy name="input.c.l_yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_mm
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_mm
            #add-point:ON ACTION controlp INFIELD l_mm name="input.c.l_mm"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_docno1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_docno1
            #add-point:ON ACTION controlp INFIELD l_docno1 name="input.c.l_docno1"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_docno1
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = "afmt560"     #计提投资收益维护
            CALL q_ooba002_1()
            LET g_master.l_docno1 = g_qryparam.return1    
            CALL s_aooi200_fin_get_slip_desc(g_master.l_docno1) RETURNING g_master.docno1_desc
            DISPLAY BY NAME g_master.l_docno1,g_master.docno1_desc
            NEXT FIELD CURRENT
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON fmmjsite,fmmjdocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.fmmjsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmjsite
            #add-point:ON ACTION controlp INFIELD fmmjsite name="construct.c.fmmjsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161006-00005#24 20161024 mark by beckxie---S
            #LET g_qryparam.where = " ooef206 = 'Y' AND ooef017 = '",g_master.l_glaacomp,"'"
            #CALL q_ooef001()                           #呼叫開窗
            #161006-00005#24 20161024 mark by beckxie---E
            #161006-00005#24 20161024 add by beckxie---S
            LET g_qryparam.where = " ooef017 = '",g_master.l_glaacomp,"'"
            CALL q_ooef001_33()   
            #161006-00005#24 20161024 add by beckxie---E
            DISPLAY g_qryparam.return1 TO fmmjsite  #顯示到畫面上
            NEXT FIELD fmmjsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmjsite
            #add-point:BEFORE FIELD fmmjsite name="construct.b.fmmjsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmjsite
            
            #add-point:AFTER FIELD fmmjsite name="construct.a.fmmjsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmmjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmjdocno
            #add-point:ON ACTION controlp INFIELD fmmjdocno name="construct.c.fmmjdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL g_ar.clear()
            LET g_ar[1].dat = g_accdate_s
            LET g_ar[2].dat = g_accdate_e
            LET g_ar[1].num = g_master.l_yy
            LET g_ar[2].num = g_master.l_mm
            LET g_ar[1].chr = g_master.l_glaacomp
            CALL s_afmp500_get_wc('1',g_ar) RETURNING g_qryparam.where
            CALL q_fmmjdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmmjdocno  #顯示到畫面上
            NEXT FIELD fmmjdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmjdocno
            #add-point:BEFORE FIELD fmmjdocno name="construct.b.fmmjdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmjdocno
            
            #add-point:AFTER FIELD fmmjdocno name="construct.a.fmmjdocno"
            
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
            CALL afmp500_get_buffer(l_dialog)
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
         CALL afmp500_init()
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
                 CALL afmp500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afmp500_transfer_argv(ls_js)
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
 
{<section id="afmp500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afmp500_transfer_argv(ls_js)
 
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
 
{<section id="afmp500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afmp500_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_fmms        RECORD
            fmmsownid	LIKE fmms_t.fmmsownid,
            fmmsowndp	LIKE fmms_t.fmmsowndp,
            fmmscrtid	LIKE fmms_t.fmmscrtid,
            fmmscrtdp	LIKE fmms_t.fmmscrtdp,
            fmmscrtdt	LIKE fmms_t.fmmscrtdt,
            fmmsmodid	LIKE fmms_t.fmmsmodid,
            fmmsmoddt	LIKE fmms_t.fmmsmoddt,
            fmmscnfid	LIKE fmms_t.fmmscnfid,
            fmmscnfdt	LIKE fmms_t.fmmscnfdt,
            fmmspstid	LIKE fmms_t.fmmspstid,
            fmmspstdt	LIKE fmms_t.fmmspstdt,
            fmmsstus	   LIKE fmms_t.fmmsstus,	 
            fmmscomp	   LIKE fmms_t.fmmscomp, 
            fmmsdocno	LIKE fmms_t.fmmsdocno,
            fmms001	   LIKE fmms_t.fmms001,	 
            fmms002	   LIKE fmms_t.fmms002
                    END RECORD
   DEFINE l_fmmt        RECORD
            fmmtdocno   LIKE fmmt_t.fmmtdocno,  #計息單號	
            fmmtseq     LIKE fmmt_t.fmmtseq,    #項次
            fmmt001     LIKE fmmt_t.fmmt001,    #投資組織		
            fmmt002     LIKE fmmt_t.fmmt002,    #投資單號		
            fmmt003     LIKE fmmt_t.fmmt003,    #幣別
            fmmt004     LIKE fmmt_t.fmmt004,    #本金
            fmmt005     LIKE fmmt_t.fmmt005,    #起算日期		
            fmmt006     LIKE fmmt_t.fmmt006,    #止算日期		
            fmmt007     LIKE fmmt_t.fmmt007,    #天數
            fmmt008     LIKE fmmt_t.fmmt008,    #年利率
            fmmt009     LIKE fmmt_t.fmmt009,    #計息方式(由投資類型afmi510:計息方式fmma002)
            fmmt010     LIKE fmmt_t.fmmt010,    #本期計提金額
            #fmmt011     LIKE fmmt_t.fmmt010,    #利息調整  #151029-00012#14 mark
            #fmmt012     LIKE fmmt_t.fmmt010     #投資收益  #151029-00012#14 mark
            #151029-00012#14 add ------
            fmmt011     LIKE fmmt_t.fmmt011,    #利息調整
            fmmt012     LIKE fmmt_t.fmmt012,    #投資收益
            fmmt013     LIKE fmmt_t.fmmt013,    #匯率
            fmmt014     LIKE fmmt_t.fmmt014,    #計提本幣金額
            fmmt015     LIKE fmmt_t.fmmt015,    #本幣利息調整
            fmmt016     LIKE fmmt_t.fmmt016     #本幣投資收益
            #151029-00012#14 add end---
                    END RECORD
   DEFINE l_date        DATETIME YEAR TO SECOND
   DEFINE l_ecom0005    LIKE type_t.num5
   DEFINE l_glav006     LIKE glav_t.glav006     #最大期別
   DEFINE l_fmma004     LIKE fmma_t.fmma004     #期末計量
   DEFINE l_fmmj        RECORD
            fmmjdocdt   LIKE fmmj_t.fmmjdocdt,
            fmmj017     LIKE fmmj_t.fmmj017,
            fmmj018     LIKE fmmj_t.fmmj018,
            fmmj019     LIKE fmmj_t.fmmj019,
            fmmj021     LIKE fmmj_t.fmmj021,
            fmmj022     LIKE fmmj_t.fmmj022
                    END RECORD
   DEFINE l_string      LIKE type_t.chr1000
   DEFINE l_docdt       LIKE type_t.dat         #150401-00001#33
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
#  DECLARE afmp500_process_cs CURSOR FROM ls_sql
#  FOREACH afmp500_process_cs INTO
   #add-point:process段process name="process.process"
   DELETE FROM afmp500_tmp
   SELECT MAX(glav006) INTO l_glav006
     FROM glav_t
    WHERE glavent = g_enterprise 
      AND glav001 = g_glaa003 AND glav002 = g_master.l_yy
   IF cl_null(l_glav006) THEN RETURN END IF
   CALL g_ar.clear()
   LET g_ar[1].dat = g_accdate_s
   LET g_ar[2].dat = g_accdate_e
   LET g_ar[1].num = g_master.l_yy
   LET g_ar[2].num = g_master.l_mm
   LET g_ar[1].chr = g_master.l_glaacomp
   CALL s_afmp500_get_wc('1',g_ar) RETURNING l_string
   #1.整理資料/避免迴圈處理時間過長 使得單據搶號 因此先將資料整理到TEMP TABLE  
   LET ls_sql = " SELECT fmmjsite,fmmjdocno,fmmj006,fmmj008,",
                "        fmma002,fmma004,",
                "        fmmjdocdt,fmmj017,fmmj018,fmmj019,fmmj021,fmmj022 ",
                "   FROM fmmj_t,fmma_t ",
                "  WHERE fmmjent = fmmaent AND fmmjent = ",g_enterprise,
                "    AND fmma001 = fmmj003 AND ",l_string,
                "    AND fmma002 = '1' ",
                "    AND ",g_master.wc CLIPPED
  
   PREPARE sel_afmp500_tmp_p1 FROM ls_sql
   DECLARE sel_afmp500_tmp_c1 CURSOR FOR sel_afmp500_tmp_p1
   FOREACH sel_afmp500_tmp_c1 INTO l_fmmt.fmmt001,l_fmmt.fmmt002,l_fmmt.fmmt003,l_fmmt.fmmt004,
                                   l_fmmt.fmmt009,l_fmma004,
                                   l_fmmj.fmmjdocdt,l_fmmj.fmmj017,l_fmmj.fmmj018,l_fmmj.fmmj019,l_fmmj.fmmj021,
                                   l_fmmj.fmmj022
                                   
      LET l_fmmt.fmmt005 = g_accdate_s
      LET l_fmmt.fmmt006 = g_accdate_e
      CALL s_afmp500_clac_fmmt(g_glaald,l_fmma004,l_glav006,g_master.l_yy,g_master.l_mm,l_fmmt.*,l_fmmj.*)
           RETURNING l_fmmt.fmmt005,l_fmmt.fmmt006,l_fmmt.fmmt007,l_fmmt.fmmt008,
                     l_fmmt.fmmt010,l_fmmt.fmmt011,l_fmmt.fmmt012,
                     l_fmmt.fmmt013,l_fmmt.fmmt014,l_fmmt.fmmt015,l_fmmt.fmmt016  #151029-00012#14
      
      #151029-00012#14 add fmmt013/fmmt014/fmmt015/fmmt016
      INSERT INTO afmp500_tmp(fmmt001,fmmt002,fmmt003,fmmt004,fmmt005,
                              fmmt006,fmmt007,fmmt008,fmmt009,fmmt010,
                              fmmt011,fmmt012,
                              fmmt013,fmmt014,fmmt015,fmmt016)
                      VALUES (l_fmmt.fmmt001,l_fmmt.fmmt002,l_fmmt.fmmt003,l_fmmt.fmmt004,l_fmmt.fmmt005,
                              l_fmmt.fmmt006,l_fmmt.fmmt007,l_fmmt.fmmt008,l_fmmt.fmmt009,l_fmmt.fmmt010,
                              l_fmmt.fmmt011,l_fmmt.fmmt012,
                              l_fmmt.fmmt013,l_fmmt.fmmt014,l_fmmt.fmmt015,l_fmmt.fmmt016)
   END FOREACH
  
   SELECT count(*) INTO li_count
     FROM afmp500_tmp
   IF li_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()  
      RETURN
   END IF
   #2.寫入單頭
   INITIALIZE l_fmms.* TO NULL
   LET l_date = cl_get_current()
   LET l_fmms.fmmsownid = g_user
   LET l_fmms.fmmsowndp = g_dept
   LET l_fmms.fmmscrtid = g_user
   LET l_fmms.fmmscrtdp = g_dept
   LET l_fmms.fmmscrtdt = l_date
   LET l_fmms.fmmsmodid = g_user
   LET l_fmms.fmmsmoddt = l_date
   LET l_fmms.fmmscnfid = g_user
   LET l_fmms.fmmscnfdt = l_date
   LET l_fmms.fmmspstid = g_user
   LET l_fmms.fmmspstdt = l_date
   LET l_fmms.fmmsstus	= 'Y'
   LET l_fmms.fmmscomp	= g_master.l_glaacomp
   LET l_fmms.fmms001	= g_master.l_yy
   LET l_fmms.fmms002	= g_master.l_mm
   LET l_ecom0005 = cl_get_para(g_enterprise,'','E-COM-0005')
   CALL s_transaction_begin()      
   #150401-00001#33
   LET l_docdt = MDY(g_master.l_mm,1,g_master.l_yy)
   LET l_docdt =s_date_get_last_date(l_docdt)
   #150401-00001#33
   CALL s_aooi200_fin_gen_docno(g_glaald,'','',g_master.l_docno1,l_docdt,'afmt560') RETURNING g_sub_success,l_fmms.fmmsdocno     #150401-00001#33
   IF l_ecom0005 <> LENGTH(l_fmms.fmmsdocno) THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   INSERT INTO fmms_t (fmmsent,fmmsownid,fmmsowndp,fmmscrtid,fmmscrtdp,fmmscrtdt,
                       fmmsmodid,fmmsmoddt,fmmscnfid,fmmscnfdt,fmmspstid,fmmspstdt,
                       fmmscomp,fmmsdocno,fmms001,fmms002,fmmsstus)
               VALUES (g_enterprise    ,l_fmms.fmmsownid,l_fmms.fmmsowndp,l_fmms.fmmscrtid,l_fmms.fmmscrtdp,l_fmms.fmmscrtdt,
                       l_fmms.fmmsmodid,l_fmms.fmmsmoddt,l_fmms.fmmscnfid,l_fmms.fmmscnfdt,l_fmms.fmmspstid,l_fmms.fmmspstdt,
                       l_fmms.fmmscomp ,l_fmms.fmmsdocno,l_fmms.fmms001  ,l_fmms.fmms002  ,l_fmms.fmmsstus) 
   #3.寫入單身
   LET ls_sql = " SELECT fmmt001,fmmt002,fmmt003,fmmt004,fmmt005," ,
                "        fmmt006,fmmt007,fmmt008,fmmt009,fmmt010," ,
               #"        fmmt011,fmmt012",                           #151029-00012#14 mark
                "        fmmt011,fmmt012,fmmt013,fmmt014,fmmt015,",  #151029-00012#14
                "        fmmt016",                                   #151029-00012#14
                "  FROM afmp500_tmp "
   PREPARE sel_afmp500_tmp_p2 FROM ls_sql
   DECLARE sel_afmp500_tmp_c2 CURSOR FOR sel_afmp500_tmp_p2
   LET l_fmmt.fmmtdocno = l_fmms.fmmsdocno
   LET l_fmmt.fmmtseq   = 0 
   FOREACH sel_afmp500_tmp_c2 INTO l_fmmt.fmmt001,l_fmmt.fmmt002,l_fmmt.fmmt003,l_fmmt.fmmt004,l_fmmt.fmmt005,
                                   l_fmmt.fmmt006,l_fmmt.fmmt007,l_fmmt.fmmt008,l_fmmt.fmmt009,l_fmmt.fmmt010,
                                  #l_fmmt.fmmt011,l_fmmt.fmmt012                                               #151029-00012#14 mark
                                   l_fmmt.fmmt011,l_fmmt.fmmt012,l_fmmt.fmmt013,l_fmmt.fmmt014,l_fmmt.fmmt015, #151029-00012#14
                                   l_fmmt.fmmt016                                                              #151029-00012#14

       LET l_fmmt.fmmtseq = l_fmmt.fmmtseq + 1
       #151029-00012#14 add fmmt013/fmmt014/fmmt015/fmmt016
       #151117-00001#3 add fmmt017
       INSERT INTO fmmt_t (fmmtent,fmmtdocno,fmmtseq,
                           fmmt001,fmmt002,fmmt003,fmmt004,fmmt005,
                           fmmt006,fmmt007,fmmt008,fmmt009,fmmt010,
                           fmmt011,fmmt012,
                           fmmt013,fmmt014,fmmt015,fmmt016,fmmt017      
                           )
                   VALUES (g_enterprise,l_fmmt.fmmtdocno,l_fmmt.fmmtseq,
                           l_fmmt.fmmt001,l_fmmt.fmmt002,l_fmmt.fmmt003,l_fmmt.fmmt004,l_fmmt.fmmt005,
                           l_fmmt.fmmt006,l_fmmt.fmmt007,l_fmmt.fmmt008,l_fmmt.fmmt009,l_fmmt.fmmt010,
                           l_fmmt.fmmt011,l_fmmt.fmmt012,
                           l_fmmt.fmmt013,l_fmmt.fmmt014,l_fmmt.fmmt015,l_fmmt.fmmt016,'3'
                           )
   END FOREACH
   SELECT count(*) INTO li_count
     FROM fmmt_t
    WHERE fmmtent = g_enterprise AND fmmtdocno = l_fmms.fmmsdocno
   IF li_count = 0 THEN
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   ELSE
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = l_fmms.fmmsdocno
      LET g_errparam.replace[2] = l_fmms.fmmsdocno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
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
   CALL afmp500_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afmp500.get_buffer" >}
PRIVATE FUNCTION afmp500_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_glaacomp = p_dialog.getFieldBuffer('l_glaacomp')
   LET g_master.l_yy = p_dialog.getFieldBuffer('l_yy')
   LET g_master.l_mm = p_dialog.getFieldBuffer('l_mm')
   LET g_master.l_docno1 = p_dialog.getFieldBuffer('l_docno1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmp500.msgcentre_notify" >}
PRIVATE FUNCTION afmp500_msgcentre_notify()
 
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
 
{<section id="afmp500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 設帳套預設值
# Memo...........:
# Date & Author..: 15/05/14 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp500_set_ld_info()
DEFINE l_num      LIKE type_t.num5
DEFINE l_glav004  LIKE glav_t.glav004

   WHENEVER ERROR CONTINUE
   IF cl_null(g_master.l_glaacomp) THEN
      RETURN   
   END IF
   
   CALL s_fin_get_major_ld(g_master.l_glaacomp) RETURNING g_glaald
   CALL s_ld_sel_glaa(g_glaald,'glaa003|glaa024')
        RETURNING g_sub_success,g_glaa003,g_glaa024
   #取得會計當期起始日
   CALL s_get_accdate(g_glaa003,'',g_master.l_yy,g_master.l_mm)
         RETURNING g_sub_success,g_errno,l_num,
                   l_num,l_glav004,l_glav004,
                   l_num,g_accdate_s,g_accdate_e,
                   l_num,l_glav004,l_glav004
END FUNCTION

################################################################################
# Descriptions...: 對應到fmmt_t
# Memo...........:
# Date & Author..: 15/05/15 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp500_cre_tmp()
   
   WHENEVER ERROR CONTINUE
   DROP TABLE afmp500_tmp

   CREATE TEMP TABLE afmp500_tmp(
      fmmtdocno       VARCHAR(20),       #計息單號	
      fmmtseq         INTEGER,         #項次
      fmmt001         VARCHAR(10),         #投資組織		
      fmmt002         VARCHAR(20),         #投資單號		
      fmmt003         VARCHAR(10),         #幣別
      fmmt004         DECIMAL(20,6),         #本金
      fmmt005         DATE,         #起算日期		
      fmmt006         DATE,         #止算日期		
      fmmt007         SMALLINT,         #天數
      fmmt008         DECIMAL(10,6),         #年利率
      fmmt009         VARCHAR(1),         #計息方式
      fmmt010         DECIMAL(20,6),         #本期計提金額
      fmmt011         DECIMAL(20,6),         #
      fmmt012         DECIMAL(20,6),         #
      #151029-00012#14 add ------
      fmmt013         DECIMAL(20,10),         #匯率
      fmmt014         DECIMAL(20,6),         #計提本幣金額
      fmmt015         DECIMAL(20,6),         #本幣利息調整
      fmmt016         DECIMAL(20,6)     #本幣投資收益
      #151029-00012#14 add end---
   );
   IF SQLCA.sqlcode THEN                    
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create afmp500_tmp'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
