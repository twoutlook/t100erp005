#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp450.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-07-05 17:03:40), PR版次:0003(2016-10-24 11:01:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: aisp450
#+ Description: 收款單轉核銷作業
#+ Creator....: 04152(2016-06-30 17:55:18)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp450.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160920-00019#6  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#26 2016/10/21 By Reanna     帳務中心(xrdasite)開窗改用q_ooef001_46()
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
       xrdasite LIKE xrda_t.xrdasite, 
   xrdasite_desc LIKE type_t.chr80, 
   xrdald LIKE xrda_t.xrdald, 
   xrdald_desc LIKE type_t.chr80, 
   xrdacomp LIKE xrda_t.xrdacomp, 
   xrdacomp_desc LIKE type_t.chr80, 
   xrdadocno LIKE xrda_t.xrdadocno, 
   xrdadocno_desc LIKE type_t.chr80, 
   xrda003 LIKE xrda_t.xrda003, 
   xrda003_desc LIKE type_t.chr80, 
   xrdadocdt LIKE xrda_t.xrdadocdt, 
   isbadocno LIKE isba_t.isbadocno, 
   isbadocdt LIKE isba_t.isbadocdt, 
   isba002 LIKE isba_t.isba002, 
   isba003 LIKE isba_t.isba003, 
   isba001 LIKE isba_t.isba001, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_t            type_master
DEFINE g_wc_ld               STRING
DEFINE g_glaa                RECORD
                             glaa024   LIKE glaa_t.glaa024
                         END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp450.main" >}
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
   CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
   CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success
   CALL s_fin_continue_no_tmp()
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisp450_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp450 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp450_init()
 
      #進入選單 Menu (="N")
      CALL aisp450_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp450
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp450.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp450_init()
 
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
 
{<section id="aisp450.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp450_ui_dialog()
 
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
   CALL aisp450_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrdasite,g_master.xrdald,g_master.xrdacomp,g_master.xrdadocno,g_master.xrda003, 
             g_master.xrdadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master_t.* = g_master.*
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdasite
            
            #add-point:AFTER FIELD xrdasite name="input.a.xrdasite"
            IF NOT cl_null(g_master.xrdasite) THEN
               #以目前的資料重展結構,避免[帳套]有值時會比對錯誤,在s_fin_account_center_with_ld_chk做勾稽時會依據這個結構做是否有符合的帳套
               CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'1')
               #如果帳務中心不同 且帳套有值 先依據現在的帳務中心跟帳套勾稽一次---(S)---
               #避免USER 在帳務中心跟帳套卡住走不了 增加對帳套有資料的處理
               IF g_master.xrdasite != g_master_t.xrdasite OR cl_null(g_master_t.xrdasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                     CALL s_fin_orga_get_comp_ld(g_master.xrdasite) RETURNING g_sub_success,g_errno,g_master.xrdacomp,g_master.xrdald
                     #判斷這個主帳套使用者是否有權限
                     CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING g_sub_success,g_errno
                  END IF
                  #判斷完成後 若勾稽失敗則回復舊值
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xrdasite = g_master_t.xrdasite
                     CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
                     LET g_master.xrdald = g_master_t.xrdald
                     CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
                     DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #帳務中心與帳套關係
               CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING g_sub_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.xrdasite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xrdasite = g_master_t.xrdasite
                  CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
                  LET g_master.xrdald = g_master_t.xrdald
                  CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
                  DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                  NEXT FIELD CURRENT
               END IF
               #關帳日檢核
               CALL s_axrt300_date_chk(g_master.xrdasite,g_master.xrdadocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_master.xrdasite = g_master_t.xrdasite
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
               DISPLAY BY NAME g_master.xrdasite_desc
               CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別
               CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
               #將取回的字串轉換為SQL條件
               CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
               LET g_master_t.xrdasite = g_master.xrdasite
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdasite
            #add-point:BEFORE FIELD xrdasite name="input.b.xrdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdasite
            #add-point:ON CHANGE xrdasite name="input.g.xrdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdald
            
            #add-point:AFTER FIELD xrdald name="input.a.xrdald"
            IF NOT cl_null(g_master.xrdald) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_master.xrdadocdt) RETURNING g_sub_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.xrdald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xrdald = g_master_t.xrdald
                  CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
                  DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
                  NEXT FIELD CURRENT
               END IF
               
               #檢查輸入帳套是否存在帳務中心下帳套範圍內
               IF s_chr_get_index_of(g_wc_ld,g_master.xrdald,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00033'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xrdald = g_master_t.xrdald
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_ld_sel_glaa(g_master.xrdald,'glaa024')
                    RETURNING g_sub_success,g_glaa.*
               #取得法人
               SELECT glaacomp INTO g_master.xrdacomp
                 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
               CALL s_desc_get_department_desc(g_master.xrdacomp) RETURNING g_master.xrdacomp_desc
               DISPLAY BY NAME g_master.xrdacomp_desc
               LET g_master_t.xrdald = g_master.xrdald
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdald
            #add-point:BEFORE FIELD xrdald name="input.b.xrdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdald
            #add-point:ON CHANGE xrdald name="input.g.xrdald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdacomp
            
            #add-point:AFTER FIELD xrdacomp name="input.a.xrdacomp"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdacomp
            #add-point:BEFORE FIELD xrdacomp name="input.b.xrdacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdacomp
            #add-point:ON CHANGE xrdacomp name="input.g.xrdacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdadocno
            
            #add-point:AFTER FIELD xrdadocno name="input.a.xrdadocno"
            IF NOT cl_null(g_master.xrdald) THEN
               IF NOT s_aooi200_fin_chk_docno(g_master.xrdald,'','',g_master.xrdadocno,g_master.xrdadocdt,'axrt400') THEN
                  LET g_master.xrdadocno = g_master_t.xrdadocno
                  NEXT FIELD CURRENT
               END IF
               CALL s_aooi200_fin_get_slip_desc(g_master.xrdadocno) RETURNING g_master.xrdadocno_desc
               DISPLAY BY NAME g_master.xrdadocno_desc
               LET g_master_t.xrdadocno = g_master.xrdadocno
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdadocno
            #add-point:BEFORE FIELD xrdadocno name="input.b.xrdadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdadocno
            #add-point:ON CHANGE xrdadocno name="input.g.xrdadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda003
            
            #add-point:AFTER FIELD xrda003 name="input.a.xrda003"
            IF NOT cl_null(g_master.xrda003) THEN
               CALL s_voucher_glaq013_chk(g_master.xrda003)
               IF NOT cl_null(g_errno)THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#21 --s add
                  LET g_errparam.replace[1] = 'aooi130'
                  LET g_errparam.replace[2] = cl_get_progname('aooi130',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi130'
                  #160321-00016#21 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.xrda003 = g_master_t.xrda003
                  LET g_master.xrda003_desc = s_desc_get_person_desc(g_master.xrda003)
                  DISPLAY BY NAME g_master.xrda003_desc
                  NEXT FIELD CURRENT
               END IF
               LET g_master.xrda003_desc = s_desc_get_person_desc(g_master.xrda003)
               DISPLAY BY NAME g_master.xrda003_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda003
            #add-point:BEFORE FIELD xrda003 name="input.b.xrda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrda003
            #add-point:ON CHANGE xrda003 name="input.g.xrda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdadocdt
            #add-point:BEFORE FIELD xrdadocdt name="input.b.xrdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdadocdt
            
            #add-point:AFTER FIELD xrdadocdt name="input.a.xrdadocdt"
            IF NOT cl_null(g_master.xrdadocdt) THEN
               CALL s_axrt300_date_chk(g_master.xrdasite,g_master.xrdadocdt) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "axr-00299"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_master.xrdadocdt = g_master_t.xrdadocdt
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdadocdt
            #add-point:ON CHANGE xrdadocdt name="input.g.xrdadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdasite
            #add-point:ON ACTION controlp INFIELD xrdasite name="input.c.xrdasite"
            #開窗i段-帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrdasite
            #CALL q_ooef001()      #161006-00005#26 mark
            CALL q_ooef001_46()    #161006-00005#26
            LET g_master.xrdasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
            DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
            NEXT FIELD xrdasite
            #END add-point
 
 
         #Ctrlp:input.c.xrdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdald
            #add-point:ON ACTION controlp INFIELD xrdald name="input.c.xrdald"
            #開窗i段-帳套
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrdald
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_ld
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.xrdald = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
            DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
            NEXT FIELD xrdald
            #END add-point
 
 
         #Ctrlp:input.c.xrdacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdacomp
            #add-point:ON ACTION controlp INFIELD xrdacomp name="input.c.xrdacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdadocno
            #add-point:ON ACTION controlp INFIELD xrdadocno name="input.c.xrdadocno"
            #開窗i段-核銷單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrdadocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = "axrt400"
            CALL q_ooba002_1()
            LET g_master.xrdadocno = g_qryparam.return1
            CALL s_aooi200_fin_get_slip_desc(g_master.xrdadocno) RETURNING g_master.xrdadocno_desc
            DISPLAY BY NAME g_master.xrdadocno,g_master.xrdadocno_desc
            NEXT FIELD xrdadocno
            #END add-point
 
 
         #Ctrlp:input.c.xrda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda003
            #add-point:ON ACTION controlp INFIELD xrda003 name="input.c.xrda003"
            #開窗i段-帳務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrda003
            CALL q_ooag001()
            LET g_master.xrda003 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_master.xrda003) RETURNING g_master.xrda003_desc
            DISPLAY BY NAME g_master.xrda003,g_master.xrda003_desc
            NEXT FIELD xrda003
            #END add-point
 
 
         #Ctrlp:input.c.xrdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdadocdt
            #add-point:ON ACTION controlp INFIELD xrdadocdt name="input.c.xrdadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isbadocno,isbadocdt,isba002,isba003,isba001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isbadocno
            #add-point:BEFORE FIELD isbadocno name="construct.b.isbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isbadocno
            
            #add-point:AFTER FIELD isbadocno name="construct.a.isbadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isbadocno
            #add-point:ON ACTION controlp INFIELD isbadocno name="construct.c.isbadocno"
            #開窗c段-#收款單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isbastus = 'Y' AND isbacomp = '",g_master.xrdacomp,"'",
                                   " AND EXISTS (SELECT 1 FROM isbc_t ",
                                   "              WHERE isbcent=isbaent AND isbccomp=isbacomp AND isbcdocno=isbadocno",
                                   "                AND isbc005 IS NULL AND isbc006 IS NULL)"
            CALL q_isbadocno()
            DISPLAY g_qryparam.return1 TO isbadocno
            NEXT FIELD isbadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isbadocdt
            #add-point:BEFORE FIELD isbadocdt name="construct.b.isbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isbadocdt
            
            #add-point:AFTER FIELD isbadocdt name="construct.a.isbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isbadocdt
            #add-point:ON ACTION controlp INFIELD isbadocdt name="construct.c.isbadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isba002
            #add-point:BEFORE FIELD isba002 name="construct.b.isba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isba002
            
            #add-point:AFTER FIELD isba002 name="construct.a.isba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isba002
            #add-point:ON ACTION controlp INFIELD isba002 name="construct.c.isba002"
            #開窗c段-收款部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM isba_t ",
                                   "          WHERE isbaent=ooegent AND isba002=ooeg001 ",
                                   "            AND isbacomp = '",g_master.xrdacomp,"')"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO isba002
            NEXT FIELD isba002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isba003
            #add-point:BEFORE FIELD isba003 name="construct.b.isba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isba003
            
            #add-point:AFTER FIELD isba003 name="construct.a.isba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isba003
            #add-point:ON ACTION controlp INFIELD isba003 name="construct.c.isba003"
            #開窗c段-收款客戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM isba_t ",
                                   "          WHERE isbaent=pmaaent AND isba003=pmaa001 ",
                                   "            AND isbacomp = '",g_master.xrdacomp,"')"
            #CALL q_pmaa001()  #呼叫開窗   #160920-00019#6--mark   
            CALL q_pmaa001_13()           #160920-00019#6--add
            DISPLAY g_qryparam.return1 TO isba003
            NEXT FIELD isba003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isba001
            #add-point:BEFORE FIELD isba001 name="construct.b.isba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isba001
            
            #add-point:AFTER FIELD isba001 name="construct.a.isba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isba001
            #add-point:ON ACTION controlp INFIELD isba001 name="construct.c.isba001"
            #開窗c段-收款人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM isba_t ",
                                   "          WHERE isbaent=ooagent AND isba001=ooag001 ",
                                   "            AND isbacomp = '",g_master.xrdacomp,"')"
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO isba001
            NEXT FIELD isba001
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
            CALL aisp450_get_buffer(l_dialog)
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
            CALL aisp450_qbe_clear()
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
         CALL aisp450_init()
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
                 CALL aisp450_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp450_transfer_argv(ls_js)
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
 
{<section id="aisp450.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp450_transfer_argv(ls_js)
 
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
 
{<section id="aisp450.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp450_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_array       DYNAMIC ARRAY OF RECORD
                           chr  STRING,
                           dat  LIKE type_t.dat
                        END RECORD
   DEFINE l_exist       LIKE type_t.chr1
   DEFINE l_strno       LIKE apda_t.apdadocno
   DEFINE l_endno       LIKE apda_t.apdadocno
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
#  DECLARE aisp450_process_cs CURSOR FROM ls_sql
#  FOREACH aisp450_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_exist = "N"
   
   LET l_array[1].chr  = g_master.xrdasite    #帳務中心
   LET l_array[2].chr  = g_master.xrdald      #帳套
   LET l_array[3].chr  = g_master.xrdacomp    #法人
   LET l_array[4].chr  = g_master.xrdadocno   #單別
   LET l_array[1].dat  = g_master.xrdadocdt   #單據日期
   LET l_array[5].chr  = g_master.xrda003     #帳務人員
   LET l_array[6].chr  = g_master.wc          #g_master.wc
   
   CALL cl_err_collect_init()
   CALL s_aisp450_ins_axrt400(l_array) RETURNING g_sub_success,l_exist,l_strno,l_endno
   IF l_exist = "N" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      IF g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00251'
         LET g_errparam.replace[1] = l_strno
         LET g_errparam.replace[2] = l_endno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00187'   #單據產生失敗
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   CALL cl_err_collect_show()
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
   CALL aisp450_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp450.get_buffer" >}
PRIVATE FUNCTION aisp450_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xrdasite = p_dialog.getFieldBuffer('xrdasite')
   LET g_master.xrdald = p_dialog.getFieldBuffer('xrdald')
   LET g_master.xrdacomp = p_dialog.getFieldBuffer('xrdacomp')
   LET g_master.xrdadocno = p_dialog.getFieldBuffer('xrdadocno')
   LET g_master.xrda003 = p_dialog.getFieldBuffer('xrda003')
   LET g_master.xrdadocdt = p_dialog.getFieldBuffer('xrdadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp450.msgcentre_notify" >}
PRIVATE FUNCTION aisp450_msgcentre_notify()
 
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
 
{<section id="aisp450.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aisp450_qbe_clear()
# Date & Author..: 2016/07/01 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp450_qbe_clear()

   #取得預設帳務中心
   CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_master.xrdasite,g_master.xrdald,g_master.xrdacomp
   CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
   CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
   CALL s_desc_get_department_desc(g_master.xrdacomp) RETURNING g_master.xrdacomp_desc
   
   LET g_master.xrda003 = g_user
   LET g_master.xrda003_desc = s_desc_get_person_desc(g_master.xrda003)
   LET g_master.xrdadocdt = g_today
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_master.xrdadocdt,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
   
   CALL s_ld_sel_glaa(g_master.xrdald,'glaa024')
        RETURNING g_sub_success,g_glaa.*
   
   DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc,g_master.xrdacomp,
                   g_master.xrdacomp_desc,g_master.xrda003,g_master.xrda003_desc,g_master.xrdadocdt
   
END FUNCTION

#end add-point
 
{</section>}
 
