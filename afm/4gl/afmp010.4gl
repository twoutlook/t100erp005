#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-11-30 09:45:05), PR版次:0008(2016-10-28 16:50:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: afmp010
#+ Description: 融資計提利息
#+ Creator....: 02291(2015-11-27 15:14:15)
#+ Modifier...: 02291 -SD/PR- 08171
 
{</section>}
 
{<section id="afmp010.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160302-00029#2   2016/03/03 By 01727   1.融资费用加已摊销费用栏位,計提利息的时候要回写
#                                       2.加利息調整档案,在产生利息调整的时候把利息调整的资料写入利息調整档
#160318-00025#44  2016/04/26 By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160415-00018#1   2016/04/27 By 01531   当月融资到帐，单月有已还利息，在计算当期利息时，只能计算未还日期内的利息
#160427-00006#1   2016/05/02 By 01531   afmp010在删除已有资料时，只能删除满足QBE条件的afmt180资料。
#160727-00019#4   2016/07/28 By 08742   系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#160824-00045#1   2016/07/24 By Reanna  調整產生afmt180金額bug
#161006-00005#24  2016/10/24 By 06814   1.資金中心(fmcysite)開窗改用q_ooef001_33()，where條件拿掉(q_ooef001_33已經有條件) 
#                                       2.法人(fmcycomp)增加where條件ooef003 = 'Y' 和azzi800控卡
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
       fmcysite LIKE type_t.chr10, 
   fmcysite_desc LIKE type_t.chr80, 
   fmcycomp LIKE type_t.chr10, 
   fmcycomp_desc LIKE type_t.chr80, 
   fmcydocdt LIKE type_t.dat, 
   fmcy001 LIKE type_t.num5, 
   fmcy002 LIKE type_t.num5, 
   fmcydocno LIKE type_t.chr20, 
   fmcrdocno LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE  g_glaald     LIKE glaa_t.glaald
DEFINE  g_glaa003    LIKE glaa_t.glaa003
DEFINE  g_glaa024    LIKE glaa_t.glaa024
DEFINE  g_glaa001    LIKE glaa_t.glaa001
DEFINE  g_glaa015    LIKE glaa_t.glaa015
DEFINE  g_glaa016    LIKE glaa_t.glaa016
DEFINE  g_glaa018    LIKE glaa_t.glaa018
DEFINE  g_glaa019    LIKE glaa_t.glaa019
DEFINE  g_glaa020    LIKE glaa_t.glaa020
DEFINE  g_glaa022    LIKE glaa_t.glaa022
DEFINE  g_glaa025    LIKE glaa_t.glaa025
DEFINE  g_fmcycomp_str   STRING
DEFINE  g_lastday    LIKE type_t.dat
DEFINE  g_firstday    LIKE type_t.dat

#單身 type 宣告
 TYPE type_g_detail RECORD
       
       fmcrdocno       LIKE fmcr_t.fmcrdocno,
       fmcrdocdt       LIKE fmcr_t.fmcrdocdt,
       fmcrsite        LIKE fmcr_t.fmcrsite,
       fmcsseq         LIKE fmcs_t.fmcsseq,
       fmcs001         LIKE fmcs_t.fmcs001,
       fmcs002         LIKE fmcs_t.fmcs002,
       fmcs003         LIKE fmcs_t.fmcs003,
       fmcs007         LIKE fmcs_t.fmcs007,
       fmcs008         LIKE fmcs_t.fmcs008,
       fmcs015         LIKE fmcs_t.fmcs015
       END RECORD
       
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_fmcydocno         LIKE fmcy_t.fmcydocno
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmp010.main" >}
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
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afmp010_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp010 WITH FORM cl_ap_formpath("afm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afmp010_init()
 
      #進入選單 Menu (="N")
      CALL afmp010_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp010
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp010.init" >}
#+ 初始化作業
PRIVATE FUNCTION afmp010_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_ld      LIKE glaa_t.glaald
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
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   CALL afmp010_create_tmp()
   LET g_master.fmcysite = g_site
   CALL s_fin_orga_get_comp_ld(g_master.fmcysite) RETURNING l_success,g_errno,g_master.fmcycomp,l_ld
   CALL s_fin_account_center_sons_query('6',g_master.fmcysite,g_today,'')
   CALL s_fin_account_center_comp_str()  RETURNING g_fmcycomp_str
   CALL s_fin_get_wc_str(g_fmcycomp_str) RETURNING g_fmcycomp_str
   LET g_master.fmcysite_desc = s_desc_get_department_desc(g_master.fmcysite)
   LET g_master.fmcycomp_desc = s_desc_get_department_desc(g_master.fmcycomp)
   DISPLAY BY NAME g_master.fmcysite,g_master.fmcysite_desc,g_master.fmcycomp,g_master.fmcycomp_desc
   LET g_master.fmcydocdt = g_today
   LET g_master.fmcy001 = YEAR(g_today)
   LET g_master.fmcy002 = MONTH(g_today)
   DISPLAY BY NAME g_master.fmcydocdt,g_master.fmcy001,g_master.fmcy002
   CALL s_date_get_ymtodate(g_master.fmcy001,g_master.fmcy002,g_master.fmcy001,g_master.fmcy002)
    RETURNING g_firstday,g_lastday
   CALL afmp010_fmcycomp_ref()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp010.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp010_ui_dialog()
 
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
   DEFINE l_sql     STRING
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_ld      LIKE glaa_t.glaald
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.fmcysite,g_master.fmcycomp,g_master.fmcydocdt,g_master.fmcy001,g_master.fmcy002, 
             g_master.fmcydocno 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcysite
            
            #add-point:AFTER FIELD fmcysite name="input.a.fmcysite"

            IF NOT cl_null(g_master.fmcysite) THEN
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.fmcysite


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  CALL s_fin_orga_get_comp_ld(g_master.fmcysite) RETURNING l_success,g_errno,g_master.fmcycomp,l_ld
                  CALL s_fin_account_center_sons_query('6',g_master.fmcysite,g_today,'')
                  CALL s_fin_account_center_comp_str()  RETURNING g_fmcycomp_str
                  CALL s_fin_get_wc_str(g_fmcycomp_str) RETURNING g_fmcycomp_str
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.fmcysite_desc = s_desc_get_department_desc(g_master.fmcysite)
            LET g_master.fmcycomp_desc = s_desc_get_department_desc(g_master.fmcycomp)
            DISPLAY BY NAME g_master.fmcysite,g_master.fmcysite_desc,g_master.fmcycomp,g_master.fmcycomp_desc
            #161028-00032#1 --s add
            CALL s_fin_orga_get_comp_ld(g_master.fmcysite) RETURNING l_success,g_errno,g_master.fmcycomp,l_ld
            CALL s_fin_account_center_sons_query('6',g_master.fmcysite,g_today,'')
            CALL s_fin_account_center_comp_str()  RETURNING g_fmcycomp_str
            CALL s_fin_get_wc_str(g_fmcycomp_str) RETURNING g_fmcycomp_str
            #161028-00032#1 --e add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcysite
            #add-point:BEFORE FIELD fmcysite name="input.b.fmcysite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcysite
            #add-point:ON CHANGE fmcysite name="input.g.fmcysite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcycomp
            
            #add-point:AFTER FIELD fmcycomp name="input.a.fmcycomp"
            IF NOT cl_null(g_master.fmcycomp) THEN
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.fmcycomp


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  IF NOT cl_null(g_master.fmcysite) THEN
                     LET l_n = 0
                     LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise
                     IF NOT cl_null(g_fmcycomp_str) THEN
                        LET l_sql = l_sql CLIPPED," AND ooef001 IN ",g_fmcycomp_str CLIPPED,
                                                  " AND ooef001 = '",g_master.fmcycomp,"'"
                     ELSE
                        LET l_sql = l_sql CLIPPED," AND ooef001 IN(SELECT ooef017 FROM ooef_t
                                    WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_master.fmcysite,"')",
                                    " AND ooef001 = '",g_master.fmcycomp,"'"
                     END IF
                     PREPARE ooef001_prep FROM l_sql
                     EXECUTE ooef001_prep INTO l_n
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.fmcycomp
                        LET g_errparam.code   = 'afm-00137'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        NEXT FIELD fmcycomp
                     END IF
                  END IF
                  CALL afmp010_fmcycomp_ref()
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               LET g_master.fmcycomp_desc = s_desc_get_department_desc(g_master.fmcycomp)
               DISPLAY BY NAME g_master.fmcycomp,g_master.fmcycomp_desc

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcycomp
            #add-point:BEFORE FIELD fmcycomp name="input.b.fmcycomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcycomp
            #add-point:ON CHANGE fmcycomp name="input.g.fmcycomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcydocdt
            #add-point:BEFORE FIELD fmcydocdt name="input.b.fmcydocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcydocdt
            
            #add-point:AFTER FIELD fmcydocdt name="input.a.fmcydocdt"
            CALL s_anm_date_chk(g_master.fmcysite,g_master.fmcydocdt) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "afm-00207"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcydocdt
            #add-point:ON CHANGE fmcydocdt name="input.g.fmcydocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcy001
            #add-point:BEFORE FIELD fmcy001 name="input.b.fmcy001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcy001
            
            #add-point:AFTER FIELD fmcy001 name="input.a.fmcy001"
            IF NOT cl_null(g_master.fmcy001) AND NOT cl_null(g_master.fmcy001) THEN
               CALL s_date_get_ymtodate(g_master.fmcy001,g_master.fmcy002,g_master.fmcy001,g_master.fmcy002)
                RETURNING g_firstday,g_lastday
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcy001
            #add-point:ON CHANGE fmcy001 name="input.g.fmcy001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcy002
            #add-point:BEFORE FIELD fmcy002 name="input.b.fmcy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcy002
            
            #add-point:AFTER FIELD fmcy002 name="input.a.fmcy002"
            IF NOT cl_null(g_master.fmcy001) AND NOT cl_null(g_master.fmcy001) THEN
               CALL s_date_get_ymtodate(g_master.fmcy001,g_master.fmcy002,g_master.fmcy001,g_master.fmcy002)
                RETURNING g_firstday,g_lastday
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcy002
            #add-point:ON CHANGE fmcy002 name="input.g.fmcy002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcydocno
            #add-point:BEFORE FIELD fmcydocno name="input.b.fmcydocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcydocno
            
            #add-point:AFTER FIELD fmcydocno name="input.a.fmcydocno"
            IF NOT cl_null(g_master.fmcydocno) THEN
               CALL s_aooi200_fin_chk_slip(g_glaald,g_glaa024,g_master.fmcydocno,'afmt180') RETURNING l_success
               IF l_success = FALSE THEN
                  LET g_master.fmcydocno = ''
                  NEXT FIELD fmcydocno
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmcydocno
            #add-point:ON CHANGE fmcydocno name="input.g.fmcydocno"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.fmcysite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcysite
            #add-point:ON ACTION controlp INFIELD fmcysite name="input.c.fmcysite"
            #應用 a07 樣板自動產生(Version:2)
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fmcysite             #給予default值
            #161006-00005#24 20161024 mark by beckxie---S
            #LET g_qryparam.where = " ooef206 = 'Y'"
            ##給予arg
            #LET g_qryparam.arg1 = "" #
            #CALL q_ooef001()                                #呼叫開窗
            #161006-00005#24 20161024 mark  by beckxie---E
            CALL q_ooef001_33()   #161006-00005#24 20161024 add by beckxie
            LET g_master.fmcysite = g_qryparam.return1
            DISPLAY g_master.fmcysite TO fmcysite              #
            LET g_master.fmcysite_desc = s_desc_get_department_desc(g_master.fmcysite)
            DISPLAY BY NAME g_master.fmcysite_desc
            LET g_qryparam.where = ""
            NEXT FIELD fmcysite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fmcycomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcycomp
            #add-point:ON ACTION controlp INFIELD fmcycomp name="input.c.fmcycomp"
            #應用 a07 樣板自動產生(Version:2)
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fmcycomp             #給予default值
            IF NOT cl_null(g_fmcycomp_str) THEN
               LET g_qryparam.where = " ooef206 = 'Y' AND ooef001 IN ",g_fmcycomp_str CLIPPED
            ELSE
               LET g_qryparam.where = " ooef206 = 'Y' AND ooef001 IN(SELECT ooef017 FROM ooef_t
                                      WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_master.fmcysite,"')"
            END IF

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooef001()                                #呼叫開窗

            LET g_master.fmcycomp = g_qryparam.return1
            LET g_master.fmcycomp_desc = s_desc_get_department_desc(g_master.fmcycomp)
            CALL afmp010_fmcycomp_ref()
            DISPLAY BY NAME g_master.fmcycomp_desc
            DISPLAY g_master.fmcycomp TO fmcycomp              #
            LET g_qryparam.where = " "
            NEXT FIELD fmcycomp                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fmcydocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcydocdt
            #add-point:ON ACTION controlp INFIELD fmcydocdt name="input.c.fmcydocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcy001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcy001
            #add-point:ON ACTION controlp INFIELD fmcy001 name="input.c.fmcy001"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcy002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcy002
            #add-point:ON ACTION controlp INFIELD fmcy002 name="input.c.fmcy002"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmcydocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcydocno
            #add-point:ON ACTION controlp INFIELD fmcydocno name="input.c.fmcydocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.fmcydocno
            LET g_qryparam.where = "ooba001 = '",g_glaa024,"' AND oobx003 = 'afmt180'"
            CALL q_ooba002_4()
            LET g_master.fmcydocno = g_qryparam.return1
            DISPLAY g_master.fmcydocno TO fmcydocno
            NEXT FIELD fmcydocno
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON fmcrdocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmcrdocno
            #add-point:BEFORE FIELD fmcrdocno name="construct.b.fmcrdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmcrdocno
            
            #add-point:AFTER FIELD fmcrdocno name="construct.a.fmcrdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmcrdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmcrdocno
            #add-point:ON ACTION controlp INFIELD fmcrdocno name="construct.c.fmcrdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where  = " fmcrstus = 'Y' AND fmcrcomp = '",g_master.fmcycomp,"' AND fmcrdocdt <='",g_lastday,"'"
            CALL q_fmcrdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmcrdocno  #顯示到畫面上
            NEXT FIELD fmcrdocno                     #返回原欄位
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
            CALL afmp010_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY BY NAME g_master.fmcysite,g_master.fmcysite_desc,g_master.fmcycomp,g_master.fmcycomp_desc
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
         CALL afmp010_init()
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
                 CALL afmp010_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afmp010_transfer_argv(ls_js)
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
 
{<section id="afmp010.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afmp010_transfer_argv(ls_js)
 
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
 
{<section id="afmp010.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afmp010_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_n           LIKE type_t.num5
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
#  DECLARE afmp010_process_cs CURSOR FROM ls_sql
#  FOREACH afmp010_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   CALL afmp010_p()
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM fmcz_t WHERE fmczent = g_enterprise AND fmczdocno = g_fmcydocno
   IF g_success = 'Y' AND l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      LET g_fmcydocno =''
   END IF
   IF g_success = 'N' THEN
      LET g_fmcydocno =''
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF
   IF NOT cl_null(g_fmcydocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = g_fmcydocno
      LET g_errparam.replace[2] = g_fmcydocno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

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
   CALL afmp010_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="afmp010.get_buffer" >}
PRIVATE FUNCTION afmp010_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.fmcysite = p_dialog.getFieldBuffer('fmcysite')
   LET g_master.fmcycomp = p_dialog.getFieldBuffer('fmcycomp')
   LET g_master.fmcydocdt = p_dialog.getFieldBuffer('fmcydocdt')
   LET g_master.fmcy001 = p_dialog.getFieldBuffer('fmcy001')
   LET g_master.fmcy002 = p_dialog.getFieldBuffer('fmcy002')
   LET g_master.fmcydocno = p_dialog.getFieldBuffer('fmcydocno')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmp010.msgcentre_notify" >}
PRIVATE FUNCTION afmp010_msgcentre_notify()
 
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
 
{<section id="afmp010.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 獲取法人主帳套資料
# Memo...........:
# Usage..........: CALL afmp010_fmcycomp_ref()
# Date & Author..: 2015/11/27 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_fmcycomp_ref()
   SELECT glaald,glaa003,glaa024,glaa001,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022,glaa025
     INTO g_glaald,g_glaa003,g_glaa024,g_glaa001,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,
          g_glaa022,g_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_master.fmcycomp
      AND glaa014 = 'Y'
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
PRIVATE FUNCTION afmp010_p()
DEFINE l_sql            STRING
DEFINE l_year           LIKE type_t.num5
DEFINE l_month          LIKE type_t.num5
DEFINE l_ac             LIKE type_t.num5
DEFINE l_fmck008        LIKE fmck_t.fmck008
DEFINE l_fmck010        LIKE fmck_t.fmck010
DEFINE l_fmcydocno      LIKE fmcy_t.fmcydocno
DEFINE l_fmcyownid      LIKE fmcy_t.fmcyownid
DEFINE l_fmcyowndp      LIKE fmcy_t.fmcyowndp
DEFINE l_fmcycrtid      LIKE fmcy_t.fmcycrtid
DEFINE l_fmcycrtdp      LIKE fmcy_t.fmcycrtdp
DEFINE l_fmcycrtdt      LIKE fmcy_t.fmcycrtdt
DEFINE l_fmcymodid      LIKE fmcy_t.fmcymodid
DEFINE l_fmcymoddt      LIKE fmcy_t.fmcymoddt
DEFINE l_fmcz010        LIKE fmcz_t.fmcz010
DEFINE l_fmcz011        LIKE fmcz_t.fmcz011
DEFINE l_fmcz012        LIKE fmcz_t.fmcz012
DEFINE l_fmcz013        LIKE fmcz_t.fmcz013
DEFINE l_fmcz014        LIKE fmcz_t.fmcz014
DEFINE l_fmcz015        LIKE fmcz_t.fmcz015
DEFINE l_n              LIKE type_t.num5
DEFINE l_fmcj009        LIKE fmcj_t.fmcj009
DEFINE l_fmcz016        LIKE fmcz_t.fmcz016
DEFINE l_fmcz017        LIKE fmcz_t.fmcz017
DEFINE l_fmcz018        LIKE fmcz_t.fmcz018
DEFINE l_fmcz001        LIKE fmcz_t.fmcz001
DEFINE l_fmcz002        LIKE fmcz_t.fmcz002
DEFINE l_fmcz003        LIKE fmcz_t.fmcz003
DEFINE l_fmcz004        LIKE fmcz_t.fmcz004
DEFINE l_fmcz005        LIKE fmcz_t.fmcz005
DEFINE l_fmcz006        LIKE fmcz_t.fmcz006
DEFINE l_fmcz007        LIKE fmcz_t.fmcz007
DEFINE l_fmcz008        LIKE fmcz_t.fmcz008
DEFINE l_fmcz009        LIKE fmcz_t.fmcz009
DEFINE l_fmcz019        LIKE fmcz_t.fmcz019
DEFINE l_fmcz020        LIKE fmcz_t.fmcz020
DEFINE l_fmcz021        LIKE fmcz_t.fmcz021
DEFINE l_fmcz022        LIKE fmcz_t.fmcz022
DEFINE l_fmczseq        LIKE fmcz_t.fmczseq
DEFINE l_success        LIKE type_t.num5
DEFINE l_glaald         LIKE glaa_t.glaald
DEFINE l_fmcydocdt      LIKE fmcy_t.fmcydocdt
DEFINE l_wc             STRING                #160427-00006#1
DEFINE l_cnt            LIKE type_t.num5      #160427-00006#1
DEFINE l_wc2            STRING                #160427-00006#1
DEFINE l_sql2           STRING                #160427-00006#1
DEFINE l_fmcrdocno      LIKE fmcr_t.fmcrdocno #160427-00006#1

   LET g_success = 'Y'
   CALL s_date_get_ymtodate(g_master.fmcy001,g_master.fmcy002,g_master.fmcy001,g_master.fmcy002)
    RETURNING g_firstday,g_lastday
   
   LET l_n = 0
   #判断下期有没资料，没有就报错
   SELECT COUNT(*) INTO l_n FROM fmcy_t
    WHERE fmcyent = g_enterprise 
      AND ((fmcy001 = g_master.fmcy001 AND fmcy002 > g_master.fmcy002)
      OR (fmcy001 > g_master.fmcy001))
      AND fmcycomp = g_master.fmcycomp
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afm-00214'
      LET g_errparam.extend = g_master.fmcy001||g_master.fmcy002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   #160427-00006#1 add--str--
   LET l_wc = NULL
   #因开窗可多选，故如下替换方式
   LET l_wc = cl_replace_str(g_master.wc,"fmcrdocno in","fmcz016 not in")
   LET l_wc = cl_replace_str(g_master.wc,"fmcrdocno=","fmcz016!=")
   LET l_sql = " SELECT COUNT(*) FROM fmcz_t ", 
               "  WHERE fmczent = ",g_enterprise, 
               "    AND fmczdocno = ? ",
               "    AND ",l_wc  
   PREPARE afmp010_prep FROM l_sql
   DECLARE afmp010_curs CURSOR FOR afmp010_prep  

   LET l_wc2 = cl_replace_str(g_master.wc,"fmcrdocno","fmcz016")
   LET l_sql2 = "SELECT fmcz016 FROM fmcz_t ", 
                "  WHERE fmczent = ",g_enterprise, 
                "    AND fmczdocno = ? ",
                "    AND ",l_wc2 
   PREPARE afmp010_prep2 FROM l_sql2
   DECLARE afmp010_curs2 CURSOR FOR afmp010_prep2                  
   #160427-00006#1 add--end--
            
   
   CALL s_transaction_begin()
   LET l_n = 0
   #判断本期有没资料，没有就报错
   SELECT COUNT(*) INTO l_n FROM fmcy_t
    WHERE fmcyent = g_enterprise AND fmcy001 = g_master.fmcy001
      AND fmcy002 = g_master.fmcy002 
      AND fmcycomp = g_master.fmcycomp
   IF l_n > 0 THEN
      IF cl_ask_confirm('afm-00217') THEN
         SELECT fmcydocno,fmcydocdt INTO l_fmcydocno,l_fmcydocdt FROM fmcy_t
          WHERE fmcyent = g_enterprise AND fmcy001 = g_master.fmcy001
            AND fmcy002 = g_master.fmcy002 AND fmcycomp = g_master.fmcycomp
         
         #160427-00006#1 add--str--
         LET l_cnt = 0 
         OPEN afmp010_curs USING l_fmcydocno
         FETCH afmp010_curs INTO l_cnt
         CLOSE afmp010_curs
         
         #若单身就一笔当前查询资料则单头单身一起删除，否只删除对应的单身资料，另新增一笔
         IF l_cnt = 0 THEN 
         #160427-00006#1 add--end--
         
            DELETE FROM fmcy_t WHERE fmcyent = g_enterprise 
                                 AND fmcy001 = g_master.fmcy001
                                 AND fmcy002 = g_master.fmcy002
                                 AND fmcycomp = g_master.fmcycomp
                                 
            SELECT glaald INTO l_glaald FROM glaa_t
             WHERE glaaent = g_enterprise AND glaacomp = g_master.fmcycomp
               AND glaa014 = 'Y'
            LET g_prog = 'afmt180'
            IF NOT s_aooi200_fin_del_docno(l_glaald,l_fmcydocno,g_lastday) THEN
               LET g_success = 'N'
               LET g_prog = 'afmp010'
               RETURN
            END IF
            LET g_prog = 'afmp010'
            
            DELETE FROM fmcz_t WHERE fmczent = g_enterprise 
                                 AND fmczdocno = l_fmcydocno
         #160427-00006#1 add--str--                        
         ELSE
            FOREACH afmp010_curs2 USING l_fmcydocno INTO l_fmcrdocno
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "FOREACH: afmp010_curs2" 
                 LET g_errparam.code   = SQLCA.sqlcode 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 EXIT FOREACH
              END IF            
              DELETE FROM fmcz_t WHERE fmczent = g_enterprise 
                                   AND fmczdocno = l_fmcydocno
                                   AND fmcz016 = l_fmcrdocno
            END FOREACH                       
         END IF         
         #160427-00006#1 add--end--                                                      
                                                         
      ELSE
         LET g_success = 'N'
         RETURN
      END IF
   END IF

   
   CALL afmp010_get_data()
   IF g_success = 'N' THEN
      RETURN
   END IF
   
   CALL s_aooi200_fin_gen_docno(g_glaald,g_glaa024,g_glaa003,g_master.fmcydocno,g_lastday,'afmt180')
         RETURNING l_success,g_fmcydocno
   IF l_success  = 0  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_master.fmcydocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   LET l_fmcyownid = g_user
   LET l_fmcyowndp = g_dept
   LET l_fmcycrtid = g_user
   LET l_fmcycrtdp = g_dept
   LET l_fmcycrtdt = cl_get_current()
   LET l_fmcymodid = g_user
   LET l_fmcymoddt = cl_get_current()
   
   INSERT INTO fmcy_t(fmcyent,fmcydocno,fmcysite,fmcycomp,fmcydocdt,fmcy001,fmcy002,fmcystus,
                      fmcyownid,fmcyowndp,fmcycrtid,fmcycrtdp,fmcycrtdt,fmcymodid,fmcymoddt) 
               VALUES(g_enterprise,g_fmcydocno,g_master.fmcysite,g_master.fmcycomp,g_master.fmcydocdt,
                      g_master.fmcy001,g_master.fmcy002,'N',l_fmcyownid,l_fmcyowndp,l_fmcycrtid,l_fmcycrtdp,
                      l_fmcycrtdt,l_fmcymodid,l_fmcymoddt)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "fmcy_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      RETURN
   END IF
   
   LET l_sql = " SELECT * FROM afmp010_tmp01 "            #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
   PREPARE afmp010_fmcz_ins_prep FROM l_sql
   DECLARE afmp010_fmcz_ins_curs CURSOR FOR afmp010_fmcz_ins_prep
   
   FOREACH afmp010_fmcz_ins_curs INTO l_fmcz016,l_fmcz017,l_fmcz018,l_fmcz001,l_fmcz002,l_fmcz003,l_fmcz004,
                                      l_fmcz005,l_fmcz006,l_fmcz007,l_fmcz008,l_fmcz009,l_fmcz019,
                                      l_fmcz020,l_fmcz021,l_fmcz022,l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,
                                      l_fmcz014,l_fmcz015
      SELECT MAX(fmczseq) INTO l_fmczseq
        FROM fmcz_t
       WHERE fmczent = g_enterprise
         AND fmczdocno = g_fmcydocno
      
      IF cl_null(l_fmczseq) THEN
         LET l_fmczseq = 1
      ELSE
         LET l_fmczseq = l_fmczseq + 1
      END IF
      INSERT INTO fmcz_t(fmczent,fmczdocno,fmczseq,fmcz016,fmcz017,fmcz018,fmcz001,fmcz002,fmcz003,fmcz004,fmcz005,
                         fmcz006,fmcz007,fmcz008,fmcz009,fmcz010,fmcz011,fmcz012,fmcz013,fmcz014,fmcz015,
                         fmcz019,fmcz020,fmcz021,fmcz022) 
                  VALUES(g_enterprise,g_fmcydocno,l_fmczseq,l_fmcz016,l_fmcz017,l_fmcz018,l_fmcz001,l_fmcz002,
                         l_fmcz003,l_fmcz004,l_fmcz005,l_fmcz006,l_fmcz007,l_fmcz008,l_fmcz009,l_fmcz010,l_fmcz011,
                         l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015,l_fmcz019,l_fmcz020,l_fmcz021,l_fmcz022)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "fmcz_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
   
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL afmp010_create_tmp()
# Date & Author..: 15/12/03 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_create_tmp()
   DROP TABLE afmp010_tmp01                   #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
   CREATE TEMP TABLE afmp010_tmp01(           #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
   fmcz016      LIKE fmcz_t.fmcz016,
   fmcz017      LIKE fmcz_t.fmcz017,
   fmcz018      LIKE fmcz_t.fmcz018,
   fmcz001      LIKE fmcz_t.fmcz001,  #融資組織
   fmcz002      LIKE fmcz_t.fmcz002,  #融資合同號
   fmcz003      LIKE fmcz_t.fmcz003,  #融資合同項次
   fmcz004      LIKE fmcz_t.fmcz004,  #類別
   fmcz005      LIKE fmcz_t.fmcz005,  #幣別
   fmcz006      LIKE fmcz_t.fmcz006,  #本金/費用金額
   fmcz007      LIKE fmcz_t.fmcz007,  #未還利息
   fmcz008      LIKE fmcz_t.fmcz008,  #利率
   fmcz009      LIKE fmcz_t.fmcz009,  #利息金額
   fmcz019      LIKE fmcz_t.fmcz019,
   fmcz020      LIKE fmcz_t.fmcz020,
   fmcz021      LIKE fmcz_t.fmcz021,
   fmcz022      LIKE fmcz_t.fmcz022,
   fmcz010      LIKE fmcz_t.fmcz010,
   fmcz011      LIKE fmcz_t.fmcz011,
   fmcz012      LIKE fmcz_t.fmcz012,
   fmcz013      LIKE fmcz_t.fmcz013,
   fmcz014      LIKE fmcz_t.fmcz014,
   fmcz015      LIKE fmcz_t.fmcz015
    );
END FUNCTION

################################################################################
# Descriptions...: 计提利息资料插入临时表
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
PRIVATE FUNCTION afmp010_get_data()
DEFINE l_sql           STRING
DEFINE l_year          LIKE type_t.num5
DEFINE l_month         LIKE type_t.num5
DEFINE l_day1          LIKE type_t.num5
DEFINE l_ac            LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_n1            LIKE type_t.num5
DEFINE l_fmck008       LIKE fmck_t.fmck008
DEFINE l_fmck010       LIKE fmck_t.fmck010 
DEFINE l_fmcj001       LIKE fmcj_t.fmcj001
DEFINE l_fmcj007       LIKE fmcj_t.fmcj007
DEFINE l_fmcj008       LIKE fmcj_t.fmcj008
DEFINE l_fmcj009       LIKE fmcj_t.fmcj009
DEFINE l_fmcw006       LIKE fmcw_t.fmcw006
DEFINE l_fmcw006_1     LIKE fmcw_t.fmcw006
DEFINE l_fmcw006_2     LIKE fmcw_t.fmcw006
DEFINE l_fmcw006_3     LIKE fmcw_t.fmcw006
DEFINE l_fmcw006_4     LIKE fmcw_t.fmcw006
DEFINE l_fmcw006_5     LIKE fmcw_t.fmcw006  #160415-00018#1
DEFINE l_fmcz009       LIKE fmcz_t.fmcz009
DEFINE l_fmcz018       LIKE fmcz_t.fmcz018
DEFINE l_fmcz019       LIKE fmcz_t.fmcz019
DEFINE l_fmcz020       LIKE fmcz_t.fmcz020
DEFINE l_fmcz021       LIKE fmcz_t.fmcz021
DEFINE l_fmcz022       LIKE fmcz_t.fmcz022
DEFINE l_fmcs015       LIKE fmcs_t.fmcs015
DEFINE l_fmcs015_1     LIKE fmcs_t.fmcs015
DEFINE l_fmcvdocdt     LIKE fmcv_t.fmcvdocdt
DEFINE l_bdate1        LIKE fmcv_t.fmcvdocdt
DEFINE l_bdate1_t      LIKE fmcv_t.fmcvdocdt
DEFINE l_edate1        LIKE fmcv_t.fmcvdocdt
DEFINE l_amt1          LIKE type_t.num20_6
DEFINE l_amt2          LIKE type_t.num20_6
DEFINE l_amt2_1        LIKE type_t.num20_6
DEFINE l_amt3          LIKE type_t.num20_6
DEFINE l_amt4          LIKE type_t.num20_6
DEFINE l_fmcz004       LIKE fmcz_t.fmcz004
DEFINE l_fmcz010       LIKE fmcz_t.fmcz010
DEFINE l_fmcz011       LIKE fmcz_t.fmcz011
DEFINE l_fmcz012       LIKE fmcz_t.fmcz012
DEFINE l_fmcz013       LIKE fmcz_t.fmcz013
DEFINE l_fmcz014       LIKE fmcz_t.fmcz014
DEFINE l_fmcz015       LIKE fmcz_t.fmcz015
DEFINE l_fmcq008       LIKE fmcq_t.fmcq008
DEFINE l_fmaa003       LIKE fmaa_t.fmaa003
DEFINE l_fmaa004       LIKE fmaa_t.fmaa004
DEFINE l_fmcvdocdt_min LIKE type_t.dat 
DEFINE l_bdate_t       LIKE type_t.dat 
DEFINE l_bdate         LIKE type_t.dat
DEFINE l_success       LIKE type_t.num5

   
   DELETE FROM afmp010_tmp01          #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
   LET l_sql = " SELECT DISTINCT fmcrdocno,fmcrdocdt,fmcrsite,fmcsseq,fmcs001,fmcs002,fmcs003,fmcs007,fmcs008,fmcs015 ",
               "   FROM fmcr_t,fmcs_t ",
               "  WHERE fmcrent = fmcsent AND fmcrdocno = fmcsdocno ",
               "    AND fmcrstus = 'Y' AND fmcrdocdt <='",g_lastday,"'",
               "    AND fmcrcomp = '",g_master.fmcycomp,"'",
               "    AND ",g_master.wc CLIPPED
   PREPARE afmp010_fmcr_prep FROM l_sql
   DECLARE afmp010_fmcr_curs CURSOR FOR afmp010_fmcr_prep 
   
   LET l_ac = 1
   LET l_n1 = 0
   LET l_amt1 = 0
   LET l_amt2 = 0
   
   LET l_amt4 = 0
   FOREACH afmp010_fmcr_curs INTO g_detail[l_ac].*
      IF NOT afmp010_fmcy_chk(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcrdocdt) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_detail[l_ac].fmcrdocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      LET l_fmck008 = ''
      LET l_fmck010 = ''
      LET l_fmcs015_1 = g_detail[l_ac].fmcs015
      #融資類型，贷款期限截止日期，计算基础，取逾期利率，复利计算
      SELECT fmcj001,fmcj007,fmcj009,fmck008,fmck010 
        INTO l_fmcj001,l_fmcj007,l_fmcj009,l_fmck008,l_fmck010 FROM fmcj_t,fmck_t
       WHERE fmckent = fmcjent AND fmckdocno = fmcjdocno
         AND fmckent = g_enterprise AND fmckdocno = g_detail[l_ac].fmcs001
         AND fmckseq = g_detail[l_ac].fmcs002
    
      #上月已偿还金额,afmt170
      SELECT SUM(fmcw006) INTO l_fmcw006_1 FROM fmcw_t,fmcv_t
       WHERE fmcvdocno = fmcwdocno AND fmcvent = fmcwent 
         AND fmcwent = g_enterprise AND fmcw021 = g_detail[l_ac].fmcrdocno
         AND fmcw022 = g_detail[l_ac].fmcsseq AND fmcw004 = '1'
        #AND fmcvdocdt < g_firstday
         
      #本月以及之后已偿还金额,afmt170
      SELECT SUM(fmcw006) INTO l_fmcw006_2 FROM fmcw_t,fmcv_t
       WHERE fmcvdocno = fmcwdocno AND fmcvent = fmcwent
         AND fmcwent = g_enterprise AND fmcw021 = g_detail[l_ac].fmcrdocno
         AND fmcw022 = g_detail[l_ac].fmcsseq AND fmcw004 = '1'
         AND fmcvdocdt > g_firstday
         
      #160415-00018#1 add--str--
      #本月以及之后已偿还利息,afmt170
      SELECT SUM(fmcw006) INTO l_fmcw006_5 FROM fmcw_t,fmcv_t
       WHERE fmcvdocno = fmcwdocno AND fmcvent = fmcwent
         AND fmcwent = g_enterprise AND fmcw021 = g_detail[l_ac].fmcrdocno
         AND fmcw022 = g_detail[l_ac].fmcsseq AND fmcw004 = '2'
         AND fmcvdocdt > g_firstday      
      #160415-00018#1 add--end--      
      
      IF cl_null(l_fmcw006_1) THEN LET l_fmcw006_1 = 0 END IF
      IF cl_null(l_fmcw006_2) THEN LET l_fmcw006_2 = 0 END IF
     #IF cl_null(l_fmcw006_5) THEN LET l_fmcw006_2 = 0 END IF #160415-00018#1 #160824-00045#1 mark
      IF cl_null(l_fmcw006_5) THEN LET l_fmcw006_5 = 0 END IF #160824-00045#1
      
      #若本月及之前已偿还本金额（afmt170）=到账单金额，不计提利息
      SELECT SUM(fmcw006) INTO l_fmcw006_3 FROM fmcw_t,fmcv_t
       WHERE fmcvdocno = fmcwdocno AND fmcvent = fmcwent
         AND fmcwent = g_enterprise AND fmcw021 = g_detail[l_ac].fmcrdocno
         AND fmcw022 = g_detail[l_ac].fmcsseq AND fmcw004 = '1'
         AND fmcvdocdt < g_firstday
      IF cl_null(l_fmcw006_3) THEN LET l_fmcw006_3 = 0 END IF
      IF l_fmcw006_3 = g_detail[l_ac].fmcs008 THEN
         CONTINUE FOREACH
      END IF
      
      #未偿清本息
      #amt1=本金-已还款金额
      #amt2=amt1+大于等于本期第一天做还款的金额
      SELECT fmaa003,fmaa004 INTO l_fmaa003,l_fmaa004 FROM fmaa_t WHERE fmaaent = g_enterprise AND fmaa001 = l_fmcj001
      #如果融資類型的類別=5.發行債券，本金=SUM(fmcq008)
      #如果融資類型的類別<>5.發行債券，本金=到帳金額(fmcs008)
      IF l_fmaa003 = '5' THEN
         SELECT SUM(fmcq008) INTO l_fmcq008 FROM fmcq_t
          WHERE fmcqent = g_enterprise AND fmcqdocno = g_detail[l_ac].fmcs001
            AND fmcqseq = g_detail[l_ac].fmcs002
         IF cl_null(l_fmcq008) THEN LET l_fmcq008 = 0 END IF
         LET g_detail[l_ac].fmcs008 = l_fmcq008
      END IF
      IF cl_null(g_detail[l_ac].fmcs008) THEN LET g_detail[l_ac].fmcs008 = 0 END IF
      LET l_amt1 = g_detail[l_ac].fmcs008 - l_fmcw006_1
      LET l_amt2 = l_amt1 + l_fmcw006_2
      
      #复利='Y'
      IF l_fmck010 = 'Y' THEN 
         #往年利息金额
         SELECT SUM(fmcz009) INTO l_fmcz009 FROM fmcz_t,fmcy_t
          WHERE fmczent = fmcyent AND fmczdocno = fmcydocno
            AND fmczent = g_enterprise AND fmcz015 = g_detail[l_ac].fmcrdocno
            AND fmcz016 = g_detail[l_ac].fmcsseq AND fmcz004 = '2'
            AND fmcy001 < g_master.fmcy001 AND fmcystus = 'Y'
         IF cl_null(l_fmcz009) THEN LET l_fmcz009 = 0 END IF
         LET l_amt2 = l_amt2 + l_fmcz009
      END IF
      
      #到款日与本期第一天比，取大
      IF g_detail[l_ac].fmcrdocdt > g_firstday THEN
         LET l_bdate1 = g_detail[l_ac].fmcrdocdt
      ELSE
         LET l_bdate1 = g_firstday
      END IF
      
      #当融资合同中的复利(amft035)计算=N时
      #应计本金利息=本金（amt2）*利率*本期占用天数1/计息基础
      #利率=融资到帐资料的利率确定,（fmcs015）
      LET l_sql = " SELECT UNIQUE SUM(fmcw006) FROM fmcv_t,fmcw_t ",
                  "  WHERE fmcvent = fmcwent AND fmcvdocno = fmcwdocno",
                  "    AND fmcvent = ",g_enterprise ," AND fmcw021 = '",g_detail[l_ac].fmcrdocno,"'",
                  "    AND fmcw022 = '",g_detail[l_ac].fmcsseq,"' AND fmcw004 = '1'",
                  "    AND fmcvdocdt < '",g_firstday,"'"
      PREPARE fmcvdocdt_prep FROM l_sql

      EXECUTE fmcvdocdt_prep INTO l_fmcw006
      
      IF cl_null(l_fmcw006) THEN LET l_fmcw006 = 0 END IF
      LET l_amt2 = l_amt2 - l_fmcw006
      
      LET l_sql = " SELECT UNIQUE fmcvdocdt,SUM(fmcw006) FROM fmcv_t,fmcw_t ",
                  "  WHERE fmcvent = fmcwent AND fmcvdocno = fmcwdocno",
                  "    AND fmcvent = ",g_enterprise ," AND fmcw021 = '",g_detail[l_ac].fmcrdocno,"'",
                  "    AND fmcw022 = '",g_detail[l_ac].fmcsseq,"' AND fmcw004 = '1'",
                  "    AND fmcvdocdt >= '",g_firstday,"' AND fmcvdocdt <= '",g_lastday,"'",
                  "  GROUP BY fmcvdocdt",
                  "  ORDER BY fmcvdocdt"
      PREPARE fmcvdocdt_prep1 FROM l_sql
      DECLARE fmcvdocdt_curs1 CURSOR FOR fmcvdocdt_prep1
      LET l_bdate_t= ''
      LET l_amt3 = 0
      LET l_amt2_1 = l_amt2
      LET l_n1 = 0
      FOREACH fmcvdocdt_curs1 INTO l_fmcvdocdt,l_fmcw006_4
         LET l_n1 = 1
         #利率
         IF l_fmcvdocdt > l_fmcj007 THEN  #还款日>贷款期限截止日，利率用afmt035的逾期利率fmck008
            LET l_fmcs015_1 = l_fmck008
         ELSE
            LET l_fmcs015_1 = l_fmcs015_1
         END IF
         
        #EXECUTE fmcvdocdt_min USING g_detail[l_ac].fmcs001,g_detail[l_ac].fmcs002 INTO l_fmcvdocdt_min   #本期最早日期
            #融资到期日(afmt035,fmcj007)与期别最大日比较取小

            #融资到帐日(或本期内有归还利息的，还款日期）与期别最小日比较取大
            CASE
               WHEN DAY(l_fmcvdocdt) - DAY(g_firstday) > 0 
                  LET l_bdate  = l_fmcvdocdt
               WHEN DAY(l_fmcvdocdt) - DAY(g_firstday) < 0
                  LET l_bdate  = g_firstday
               WHEN DAY(l_fmcvdocdt) - DAY(g_firstday) = 0
                  LET l_bdate  = g_firstday
            END CASE
            IF NOT cl_null(l_bdate_t) THEN
               LET l_day1 = DAY(l_bdate) - DAY(l_bdate_t) + 1 
            ELSE
               LET l_day1 = DAY(l_bdate) - DAY(l_bdate1) + 1  #还款日-到账日或本期第一天
            END IF

         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
         #应计本金利息之和=本金（amt2）*利率*本期占用天数1
         LET l_amt3 = l_amt3 + l_amt2_1 * l_day1 * l_fmcs015_1 /100
         
          IF cl_null(l_fmcw006_4) THEN LET l_fmcw006_4 = 0 END IF                   
         LET l_bdate_t = l_bdate   #
         LET l_amt2_1 = l_amt2_1 - l_fmcw006_4
      END FOREACH
      #未还利息
      SELECT SUM(fmcz009-fmcz018),SUM(fmcz019),SUM(fmcz020),SUM(fmcz021),SUM(fmcz022) 
        INTO l_amt4,l_fmcz019,l_fmcz020,l_fmcz021,l_fmcz022
        FROM fmcy_t,fmcz_t
       WHERE fmczent = fmcyent AND fmczdocno = fmcydocno
         AND fmczent = g_enterprise AND fmcz015 = g_detail[l_ac].fmcrdocno
         AND fmcz016 = g_detail[l_ac].fmcsseq AND fmcystus = 'Y'
      IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF 
      IF cl_null(l_fmcz019) THEN LET l_fmcz019 = 0 END IF 
      IF cl_null(l_fmcz020) THEN LET l_fmcz020 = 0 END IF 
      IF cl_null(l_fmcz021) THEN LET l_fmcz021 = 0 END IF 
      IF cl_null(l_fmcz022) THEN LET l_fmcz022 = 0 END IF 
      IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF 
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_amt4,2) RETURNING l_success,g_errno,l_amt4
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_amt2,2) RETURNING l_success,g_errno,l_amt2
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_fmcz019,2) RETURNING l_success,g_errno,l_fmcz019
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_fmcz020,2) RETURNING l_success,g_errno,l_fmcz020
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_fmcz021,2) RETURNING l_success,g_errno,l_fmcz021
      CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_fmcz022,2) RETURNING l_success,g_errno,l_fmcz022
      #本期有还款
      IF l_n1 > 0 THEN
         #还款日非本期最大日
         IF l_bdate_t <> g_lastday THEN
            LET l_day1 = DAY(g_lastday) - DAY(l_bdate_t)
            #LET l_amt3 = (l_amt3 + l_amt2_1 * l_day1 * l_fmcs015_1/100)/l_fmcj009               #160415-00018#1
            LET l_amt3 = (l_amt3 + l_amt2_1 * l_day1 * l_fmcs015_1/100)/l_fmcj009 - l_fmcw006_5  #160415-00018#1
            #本位币金额，汇率
            CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa001,0,g_glaa025)
                 RETURNING l_fmcz010
            LET l_fmcz011 = l_amt3 * l_fmcz010
            CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_amt3,2) RETURNING l_success,g_errno,l_amt3
            CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_fmcz011,2) RETURNING l_success,g_errno,l_fmcz011
            IF g_glaa015 = 'Y' THEN
               #本位币二金额，汇率
               CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa016,0,g_glaa018)
                              RETURNING l_fmcz012
               LET l_fmcz013 = l_amt3 * l_fmcz012
               CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_fmcz013,2) RETURNING l_success,g_errno,l_fmcz013
            END IF
            IF g_glaa019 = 'Y' THEN
               #本位币三金额，汇率
               CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa020,0,g_glaa022)
                              RETURNING l_fmcz014
               LET l_fmcz015 = l_amt3 * l_fmcz014
               CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_fmcz015,2) RETURNING l_success,g_errno,l_fmcz015
            END IF
            #将资料插入临时表
            INSERT INTO afmp010_tmp01 VALUES(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcsseq,NULL,g_detail[l_ac].fmcs003,g_detail[l_ac].fmcs001,                 #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
                               g_detail[l_ac].fmcs002,'1',g_detail[l_ac].fmcs007,l_amt2,l_amt4,l_fmcs015_1,l_amt3,l_fmcz019,l_fmcz020,l_fmcz021,l_fmcz022,
                               l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015)
         ELSE
            #本位币金额，汇率
            CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa001,0,g_glaa025)
                           RETURNING l_fmcz010
            LET l_fmcz011 = l_amt3 * l_fmcz010
            CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_amt3,2) RETURNING l_success,g_errno,l_amt3
            CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_fmcz011,2) RETURNING l_success,g_errno,l_fmcz011
            IF g_glaa015 = 'Y' THEN
               #本位币二金额，汇率
               CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa016,0,g_glaa018)
                              RETURNING l_fmcz012
               LET l_fmcz013 = l_amt3 * l_fmcz012
               CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_fmcz013,2) RETURNING l_success,g_errno,l_fmcz013
            END IF
            IF g_glaa019 = 'Y' THEN
               #本位币三金额，汇率
               CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa020,0,g_glaa022)
                              RETURNING l_fmcz014
               LET l_fmcz015 = l_amt3 * l_fmcz014
               CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_fmcz015,2) RETURNING l_success,g_errno,l_fmcz015
            END IF
            #将资料插入临时表
            INSERT INTO afmp010_tmp01 VALUES(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcsseq,NULL,g_detail[l_ac].fmcs003,g_detail[l_ac].fmcs001,g_detail[l_ac].fmcs002,    #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
                               '1',g_detail[l_ac].fmcs007,l_amt2,l_amt4,l_fmcs015_1,l_amt3,l_fmcz019,l_fmcz020,l_fmcz021,l_fmcz022,
                               l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015)
         END IF
      
      ELSE #本期无还款
         #若到账日为当期
         IF MONTH(g_detail[l_ac].fmcrdocdt) = g_master.fmcy002 THEN
            LET l_day1 = s_date_get_max_day(g_master.fmcy001,g_master.fmcy002) - DAY(g_detail[l_ac].fmcrdocdt) + 1
         ELSE
            LET l_day1 = s_date_get_max_day(g_master.fmcy001,g_master.fmcy002)
         END IF
         #LET l_amt3 = l_amt2 * l_day1 * l_fmcs015_1/l_fmcj009/100              #160415-00018#1
         LET l_amt3 = l_amt2 * l_day1 * l_fmcs015_1/l_fmcj009/100 - l_fmcw006_5 #160415-00018#1
         #本位币金额，汇率
         CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa001,0,g_glaa025)
                        RETURNING l_fmcz010
         LET l_fmcz011 = l_amt3 * l_fmcz010
         CALL s_curr_round_ld('1',g_glaald,g_detail[l_ac].fmcs007,l_amt3,2) RETURNING l_success,g_errno,l_amt3
         CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_fmcz011,2) RETURNING l_success,g_errno,l_fmcz011
         IF g_glaa015 = 'Y' THEN
            #本位币二金额，汇率
            CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa016,0,g_glaa018)
                           RETURNING l_fmcz012
            LET l_fmcz013 = l_amt3 * l_fmcz012
            CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_fmcz013,2) RETURNING l_success,g_errno,l_fmcz013
         END IF
         IF g_glaa019 = 'Y' THEN
            #本位币三金额，汇率
            CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,g_detail[l_ac].fmcs007,g_glaa020,0,g_glaa022)
                           RETURNING l_fmcz014
            LET l_fmcz015 = l_amt3 * l_fmcz014
            CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_fmcz015,2) RETURNING l_success,g_errno,l_fmcz015
         END IF  
         #将资料插入临时表
         INSERT INTO afmp010_tmp01 VALUES(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcsseq,NULL,g_detail[l_ac].fmcs003,g_detail[l_ac].fmcs001,g_detail[l_ac].fmcs002,     #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
                            '1',g_detail[l_ac].fmcs007,l_amt2,l_amt4,l_fmcs015_1,l_amt3,l_fmcz019,l_fmcz020,l_fmcz021,l_fmcz022,
                            l_fmcz010,l_fmcz011,l_fmcz012,l_fmcz013,l_fmcz014,l_fmcz015)
      END IF
     
      #融资类型的融资费用处理方式='2'融资期间分销摊销时，摊销费用
      IF l_fmaa004 = '2' THEN
         CALL afmp010_get_fmdc_data(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcrdocdt,g_detail[l_ac].fmcsseq,l_fmcj007,g_detail[l_ac].fmcs003)
      END IF
      #融资类型的类别=5.发行债券，计算利息调整，利息调整本金=到账金额-债券总金额(fmcq008)
      IF l_fmaa003 = '5' THEN
         CALL afmp010_get_data1(g_detail[l_ac].fmcrdocno,g_detail[l_ac].fmcrdocdt,g_detail[l_ac].fmcsseq,l_fmcj007,l_fmcq008)
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 融资费用分摊
# Memo...........:
# Usage..........: CALL afmp010_get_fmdc_data(p_fmcrdocno,p_fmcrdocdt,p_fmdcseq,p_fmcj007)
# Date & Author..: 2015/12/4 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_get_fmdc_data(p_fmcrdocno,p_fmcrdocdt,p_fmdcseq,p_fmcj007,p_fmcs003)
DEFINE p_fmcrdocno    LIKE fmcr_t.fmcrdocno  #到账单号
DEFINE p_fmcrdocdt    LIKE fmcr_t.fmcrdocdt  #到账日期
DEFINE p_fmdcseq      LIKE fmdc_t.fmdcseq    #到账单项次
DEFINE p_fmcj007      LIKE fmcj_t.fmcj007    #贷款截止日
DEFINE p_fmcs003      LIKE fmcs_t.fmcs003    #融资组织
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_year1        LIKE type_t.num5
DEFINE l_month1       LIKE type_t.num5
DEFINE l_day1         LIKE type_t.num5
DEFINE l_year2        LIKE type_t.num5
DEFINE l_month2       LIKE type_t.num5
DEFINE l_day          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_fmdcseq2     LIKE fmdc_t.fmdcseq
DEFINE l_fmdc001      LIKE fmdc_t.fmdc001
DEFINE l_fmdc002      LIKE fmdc_t.fmdc002
DEFINE l_fmdc003      LIKE fmdc_t.fmdc003
DEFINE l_fmdc004      LIKE fmdc_t.fmdc004
DEFINE l_fmdc006      LIKE fmdc_t.fmdc006
DEFINE l_amt1         LIKE type_t.num20_6
DEFINE l_fmcz006      LIKE fmcz_t.fmcz006
DEFINE l_fmcz010      LIKE fmcz_t.fmcz010
DEFINE l_fmcz011      LIKE fmcz_t.fmcz011
DEFINE l_fmcz012      LIKE fmcz_t.fmcz012
DEFINE l_fmcz013      LIKE fmcz_t.fmcz013
DEFINE l_fmcz014      LIKE fmcz_t.fmcz014
DEFINE l_fmcz015      LIKE fmcz_t.fmcz015
DEFINE l_success      LIKE type_t.num5
DEFINE l_date1        LIKE type_t.dat
DEFINE l_fmcz004      LIKE fmcz_t.fmcz004
DEFINE l_fmcs008      LIKE fmcs_t.fmcs008
DEFINE l_fmcs017      LIKE fmcs_t.fmcs017
DEFINE l_fmcw006      LIKE fmcw_t.fmcw006

   LET l_year1 = YEAR(p_fmcrdocdt)   #到账日
   LET l_month1 = MONTH(p_fmcrdocdt)
   LET l_year2 = YEAR(p_fmcj007)     #截止日
   LET l_month2 = MONTH(p_fmcj007)

   
   LET l_sql = " SELECT fmdcseq2,fmdc001,fmdc002,fmdc003,fmdc004,fmdc006 ",
               "   FROM fmdc_t ",
               "  WHERE fmdcent = ",g_enterprise," AND fmdcdocno = '",p_fmcrdocno,"'",
               "    AND fmdcseq = ",p_fmdcseq
   PREPARE afmp010_fmdc_prep FROM l_sql
   DECLARE afmp010_fmdc_curs CURSOR FOR afmp010_fmdc_prep
   FOREACH afmp010_fmdc_curs INTO l_fmdcseq2,l_fmdc001,l_fmdc002,l_fmdc003,l_fmdc004,l_fmdc006
     #IF g_master.fmcy001 <= l_year1 THEN
         SELECT SUM(fmcz006) INTO l_fmcz006 FROM fmcz_t,fmcy_t
          WHERE fmcyent = fmczent AND fmcydocno = fmczdocno
            AND fmczent = g_enterprise AND fmcz016 = p_fmcrdocno 
            AND fmcz017 = p_fmdcseq AND fmcz004 = l_fmdc003
            AND fmcz018 = l_fmdcseq2
         IF cl_null(l_fmcz006) THEN LET l_fmcz006 = 0 END IF
         SELECT fmcs008,fmcs017 INTO l_fmcs008,l_fmcs017 FROM fmcs_t
          WHERE fmcsent = g_enterprise AND fmcsdocno = p_fmcrdocno
            AND fmcsseq = p_fmdcseq
         IF cl_null(l_fmcs008) THEN LET l_fmcs008 = 0 END IF
         IF cl_null(l_fmcs017) THEN LET l_fmcs017 = 0 END IF
         #小于等于当前的已还款金额
         SELECT SUM(fmcw006) INTO l_fmcw006 FROM fmcw_t,fmcv_t
          WHERE fmcvent = fmcwent AND fmcwdocno = fmcvdocno
            AND fmcvstus = 'Y' AND fmcw021 = p_fmcedocno
            AND fmcw022 = p_fmdcseq AND fmcvdocdt <= g_lastday
         IF cl_null(l_fmcw006) THEN LET l_fmcw006 = 0 END IF
         CASE
            WHEN g_master.fmcy001 = l_year1 AND g_master.fmcy002 = l_month1  #第一期费用
               LET l_day = DAY(g_lastday) - DAY(p_fmcrdocdt) + 1
               CALL afmp010_get_date(p_fmcrdocdt,p_fmcj007) RETURNING l_day1
               IF cl_null(l_day1) THEN LET l_day1 = 0 END IF
               LET l_amt1 = l_fmdc006 * l_day /l_day1
            WHEN g_master.fmcy001 = l_year2 AND g_master.fmcy002 = l_month2  #为最后一期时，进行尾插处理：总的金额-往期金额
               LET l_amt1 = l_fmdc006 - l_fmcz006
            OTHERWISE #g_master.fmcy002 > l_month1 AND g_master.fmcy002 < l_month2  #月份大于到账日，小于截止日
               #如果已还本金额=到账金额，费用摊销金额当最后一起处理
               IF l_fmcs008 = l_fmcw006 THEN
                  LET l_amt1 = l_fmdc006 - l_fmcz006
               ELSE
                  LET l_day = s_date_get_max_day(g_master.fmcy001,g_master.fmcy002)
                  LET l_date1 = MDY(g_master.fmcy002,1,g_master.fmcy001)
                  CALL afmp010_get_date(l_date1,p_fmcj007) RETURNING l_day1
                  IF cl_null(l_day1) THEN LET l_day1 = 0 END IF
                  LET l_amt1 = (l_fmdc006 - l_fmcz006)*l_day/l_day1
               END IF
         END CASE 
     #END IF
      #本位币金额，汇率
      CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmdc004,g_glaa001,0,g_glaa025)
                     RETURNING l_fmcz010
      LET l_fmcz011 = l_amt1 * l_fmcz010
      CALL s_curr_round_ld('1',g_glaald,l_fmdc004,l_amt1,2) RETURNING l_success,g_errno,l_amt1
      CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_fmcz011,2) RETURNING l_success,g_errno,l_fmcz011
      IF g_glaa015 = 'Y' THEN
         #本位币二金额，汇率
         CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmdc004,g_glaa016,0,g_glaa018)
                        RETURNING l_fmcz012
         LET l_fmcz013 = l_amt1 * l_fmcz012
         CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_fmcz013,2) RETURNING l_success,g_errno,l_fmcz013
      END IF
      IF g_glaa019 = 'Y' THEN
         #本位币三金额，汇率
         CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmdc004,g_glaa020,0,g_glaa022)
                        RETURNING l_fmcz014
         LET l_fmcz015 = l_amt1 * l_fmcz014
         CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_fmcz015,2) RETURNING l_success,g_errno,l_fmcz015
      END IF

      CASE l_fmdc003 
         WHEN '1' LET l_fmcz004 = '3'
         WHEN '2' LET l_fmcz004 = '4'
         WHEN '3' LET l_fmcz004 = '5'
         WHEN '4' LET l_fmcz004 = '6'
         WHEN '5' LET l_fmcz004 = '7'
      END CASE
      #将资料插入临时表
      INSERT INTO afmp010_tmp01 VALUES(p_fmcrdocno,p_fmdcseq,l_fmdcseq2,p_fmcs003,l_fmdc001,l_fmdc002,   #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
                         l_fmcz004,l_fmdc004,0,0,0,l_amt1,0,0,0,0,l_fmcz010,l_fmcz011,l_fmcz012,
                         l_fmcz013,l_fmcz014,l_fmcz015)

     #160302-00029#2 Add  ---(S)---
       UPDATE fmdc_t SET fmdc019 = DECODE(fmdc019,'',0,fmdc019) + l_amt1,
                         fmdc020 = DECODE(fmdc020,'',0,fmdc020) + l_fmcz011,
                         fmdc021 = DECODE(fmdc021,'',0,fmdc021) + l_fmcz013,
                         fmdc022 = DECODE(fmdc022,'',0,fmdc022) + l_fmcz015
        WHERE fmdcent = g_enterprise
          AND fmdcdocno = p_fmcrdocno
          AND fmdcseq = p_fmdcseq
          AND fmdcseq2= l_fmdcseq2
     #160302-00029#2 Add  ---(E)---

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 抓取两个日期间的天数
# Memo...........:
# Usage..........: CALL afmp010_get_date(p_date1,p_date2)
# Date & Author..: 2015/12/04 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_get_date(p_date1,p_date2)
DEFINE p_date1        LIKE type_t.dat  #起始日
DEFINE p_date2        LIKE type_t.dat  #截止日
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_year1        LIKE type_t.num5
DEFINE l_month1       LIKE type_t.num5
DEFINE l_day1         LIKE type_t.num5
DEFINE l_day2         LIKE type_t.num5
DEFINE l_day3         LIKE type_t.num5
DEFINE l_year2        LIKE type_t.num5
DEFINE l_month2       LIKE type_t.num5
DEFINE l_day          LIKE type_t.num5
DEFINE l_date1        LIKE type_t.dat  #起始日
DEFINE l_date2        LIKE type_t.dat  #截止日
DEFINE l_success      LIKE type_t.num5

   LET l_year1 = YEAR(p_date1)   #起始日
   LET l_month1 = MONTH(p_date1)
   LET l_year2 = YEAR(p_date2)     #截止日
   LET l_month2 = MONTH(p_date2)
   #同年
   LET l_day1 = 0
   LET l_day2 = 0
   LET l_day3 = 0
   IF l_year1 = l_year2 THEN
      CALL afmp010_get_sameyear_day(p_date1,p_date2) RETURNING l_day1
   ELSE #跨年
      IF l_year2 - l_year1 > 1 THEN  #跨几年
         FOR l_year = l_year1 + 1 TO l_year2 - 1
             CALL s_date_chk_leap_year(l_year) RETURNING l_success
             IF l_success THEN
                LET l_day1 = l_day1 + 366
             ELSE
                LET l_day1 = l_day1 + 365
             END IF
         END FOR
         
      END IF
      LET l_date1 = MDY(12,31,l_year1)
      CALL afmp010_get_sameyear_day(p_date1,l_date1) RETURNING l_day2
      LET l_date2 = MDY(1,1,l_year2)
      CALL afmp010_get_sameyear_day(l_date2,p_date2) RETURNING l_day3
      LET l_day1 = l_day1 + l_day2 + l_day3
   END IF
   
   RETURN l_day1
END FUNCTION

################################################################################
# Descriptions...: 年份相同，获取天数
# Memo...........:
# Usage..........: CALL get_sameyear_day(p_date1,p_date2)
#                  RETURNING r_day1
# Date & Author..: 2015/12/04 By yanttt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_get_sameyear_day(p_date1,p_date2)
DEFINE p_date1        LIKE type_t.dat  #起始日
DEFINE p_date2        LIKE type_t.dat  #截止日
DEFINE l_year1        LIKE type_t.num5
DEFINE l_month1       LIKE type_t.num5
DEFINE l_day1         LIKE type_t.num5
DEFINE l_year2        LIKE type_t.num5
DEFINE l_month2       LIKE type_t.num5
DEFINE l_day          LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5

   LET l_year1 = YEAR(p_date1)   #起始日
   LET l_month1 = MONTH(p_date1)
   LET l_year2 = YEAR(p_date2)     #截止日
   LET l_month2 = MONTH(p_date2)
   #同年
   LET l_day1 = 0
   FOR l_month = l_month1 TO l_month2
       IF l_day1 = 0 THEN
          LET l_day1 = s_date_get_max_day(l_year1,l_month)
       ELSE
          LET l_day1 = l_day1 + s_date_get_max_day(l_year1,l_month)
       END IF
   END FOR
   LET l_day1 = l_day1 - DAY(p_date1) + 1 -  (s_date_get_max_day(l_year2,l_month2) - DAY(p_date2))
   RETURN l_day1
END FUNCTION

################################################################################
# Descriptions...: 资料检核
# Memo...........:
# Usage..........: CALL afmp010_fmcy_chk(p_fmcrdocno,p_fmcrdocdt)
#                  RETURNING r_success
# Date & Author..: 15/12/08 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_fmcy_chk(p_fmcrdocno,p_fmcrdocdt)
DEFINE p_fmcrdocno      LIKE fmcr_t.fmcrdocno
DEFINE p_fmcrdocdt      LIKE fmcr_t.fmcrdocdt
DEFINE l_year           LIKE type_t.num5
DEFINE l_month          LIKE type_t.num5
DEFINE l_n              LIKE type_t.num5
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   #取上期期别
   IF g_master.fmcy002 = 1 THEN
      LET l_month = 12
      LET l_year = g_master.fmcy001 - 1
   ELSE
      LET l_month = g_master.fmcy002 - 1
      LET l_year = g_master.fmcy001
   END IF
   
   IF YEAR(p_fmcrdocdt) = g_master.fmcy001 AND MONTH(p_fmcrdocdt) = g_master.fmcy002 THEN
   ELSE
      LET l_n = 0
      #判断上期有没资料，没有就报错
      SELECT COUNT(*) INTO l_n FROM fmcy_t,fmcz_t
       WHERE fmczent = fmcyent AND fmcydocno= fmczdocno
         AND fmcyent = g_enterprise AND fmcy001 = l_year
         AND fmcy002 = l_month AND fmcz016 = p_fmcrdocno
         AND fmcycomp = g_master.fmcycomp
      IF l_n = 0 THEN
         LET g_errno = 'afm-00213'
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 利息調整計算
# Memo...........:
# Usage..........: CALL afmp010_get_data1(p_fmcrdocno,p_fmcrdocdt,p_fmcsseq,p_fmcj007,p_fmcq008)
# Date & Author..: 2016/1/7 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp010_get_data1(p_fmcrdocno,p_fmcrdocdt,p_fmcsseq,p_fmcj007,p_fmcq008)
DEFINE p_fmcrdocno    LIKE fmcr_t.fmcrdocno  #到账单号
DEFINE p_fmcrdocdt    LIKE fmcr_t.fmcrdocdt  #到账日期
DEFINE p_fmcsseq      LIKE fmcs_t.fmcsseq    #到账单项次
DEFINE p_fmcj007      LIKE fmcj_t.fmcj007    #贷款截止日
DEFINE p_fmcq008      LIKE fmcq_t.fmcq008    #债券本金总额
DEFINE l_fmcs003      LIKE fmcs_t.fmcs003    #融资组织
DEFINE l_fmcs008      LIKE fmcs_t.fmcs008    #到账单金额
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_year1        LIKE type_t.num5
DEFINE l_month1       LIKE type_t.num5
DEFINE l_day1         LIKE type_t.num5
DEFINE l_year2        LIKE type_t.num5
DEFINE l_month2       LIKE type_t.num5
DEFINE l_day          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_fmdcseq2     LIKE fmcs_t.fmcsseq
DEFINE l_fmcs001      LIKE fmcs_t.fmcs001
DEFINE l_fmcs002      LIKE fmcs_t.fmcs002
DEFINE l_fmcs007      LIKE fmcs_t.fmcs007
DEFINE l_amt1         LIKE type_t.num20_6
DEFINE l_fmcz006      LIKE fmcz_t.fmcz006
DEFINE l_fmcz010      LIKE fmcz_t.fmcz010
DEFINE l_fmcz011      LIKE fmcz_t.fmcz011
DEFINE l_fmcz012      LIKE fmcz_t.fmcz012
DEFINE l_fmcz013      LIKE fmcz_t.fmcz013
DEFINE l_fmcz014      LIKE fmcz_t.fmcz014
DEFINE l_fmcz015      LIKE fmcz_t.fmcz015
DEFINE l_success      LIKE type_t.num5
DEFINE l_date1        LIKE type_t.dat
DEFINE l_fmdh015      LIKE fmdh_t.fmdh015   #160302-00029#2 Add
DEFINE l_count        LIKE type_t.num5      #160302-00029#2 Add

   LET l_year1 = YEAR(p_fmcrdocdt)   #到账日
   LET l_month1 = MONTH(p_fmcrdocdt)
   LET l_year2 = YEAR(p_fmcj007)     #截止日
   LET l_month2 = MONTH(p_fmcj007)
   
   SELECT fmcs001,fmcs002,fmcs003,fmcs007,fmcs008 
     INTO l_fmcs001,l_fmcs002,l_fmcs003,l_fmcs007,l_fmcs008
     FROM fmcs_t
    WHERE fmcsent = g_enterprise AND fmcsdocno = p_fmcrdocno
      AND fmcsseq = p_fmcsseq    
   
   #往期已攤銷利息調整金額
   SELECT SUM(fmcz006) INTO l_fmcz006 FROM fmcz_t,fmcy_t
    WHERE fmcyent = fmczent AND fmcydocno = fmczdocno
      AND fmczent = g_enterprise AND fmcz016 = p_fmcrdocno 
      AND fmcz017 = p_fmcsseq AND fmcz004 = '2'

   #融资类型的类别=5.发行债券，利息调整本金=到账金额-债券总金额(fmcq008)
   LET l_fmcs008 = l_fmcs008 - p_fmcq008
   
   IF cl_null(l_fmcz006) THEN LET l_fmcz006 = 0 END IF
   CASE
      WHEN g_master.fmcy001 = l_year1 AND g_master.fmcy002 = l_month1  #第一期费用
         LET l_day = DAY(g_lastday) - DAY(p_fmcrdocdt) + 1
         CALL afmp010_get_date(p_fmcrdocdt,p_fmcj007) RETURNING l_day1
         IF cl_null(l_day1) THEN LET l_day1 = 0 END IF
         LET l_amt1 = l_fmcs008 * l_day /l_day1
      WHEN g_master.fmcy001 = l_year2 AND g_master.fmcy002 = l_month2  #为最后一期时，进行尾插处理：总的金额-往期金额
         LET l_amt1 = l_fmcs008 - l_fmcz006
      OTHERWISE #g_master.fmcy002 > l_month1 AND g_master.fmcy002 < l_month2  #月份大于到账日，小于截止日
         LET l_day = s_date_get_max_day(g_master.fmcy001,g_master.fmcy002)
         LET l_date1 = MDY(g_master.fmcy002,1,g_master.fmcy001)
         CALL afmp010_get_date(l_date1,p_fmcj007) RETURNING l_day1
         IF cl_null(l_day1) THEN LET l_day1 = 0 END IF
         LET l_amt1 = (l_fmcs008 - l_fmcz006)*l_day/l_day1
   END CASE 
   #本位币金额，汇率
   CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmcs007,g_glaa001,0,g_glaa025)
                  RETURNING l_fmcz010
   LET l_fmcz011 = l_amt1 * l_fmcz010
   CALL s_curr_round_ld('1',g_glaald,l_fmcs007,l_amt1,2) RETURNING l_success,g_errno,l_amt1
   CALL s_curr_round_ld('1',g_glaald,g_glaa001,l_fmcz011,2) RETURNING l_success,g_errno,l_fmcz011
   IF g_glaa015 = 'Y' THEN
      #本位币二金额，汇率
      CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmcs007,g_glaa016,0,g_glaa018)
                     RETURNING l_fmcz012
      LET l_fmcz013 = l_amt1 * l_fmcz012
      CALL s_curr_round_ld('1',g_glaald,g_glaa016,l_fmcz013,2) RETURNING l_success,g_errno,l_fmcz013
   END IF
   IF g_glaa019 = 'Y' THEN
      #本位币三金额，汇率
      CALL s_aooi160_get_exrate('1',g_master.fmcycomp,g_master.fmcydocdt,l_fmcs007,g_glaa020,0,g_glaa022)
                     RETURNING l_fmcz014
      LET l_fmcz015 = l_amt1 * l_fmcz014
      CALL s_curr_round_ld('1',g_glaald,g_glaa020,l_fmcz015,2) RETURNING l_success,g_errno,l_fmcz015
   END IF
   
   #将资料插入临时表
   INSERT INTO afmp010_tmp01 VALUES(p_fmcrdocno,p_fmcsseq,'',l_fmcs003,l_fmcs001,l_fmcs002,    #160727-00019#4 Mod  afmp010_fmcz_tmp--> afmp010_tmp01
                      '2',l_fmcs007,0,0,0,l_amt1,0,0,0,0,l_fmcz010,l_fmcz011,l_fmcz012,
                      l_fmcz013,l_fmcz014,l_fmcz015)

  #160302-00029#2 Add  ---(S)---
    SELECT COUNT(1) INTO l_count FROM fmdh_t WHERE fmdhent = g_enterprise
       AND fmdhdocno = p_fmcrdocno
       AND fmdhseq   = p_fmcsseq
    IF g_master.fmcy002 < 10 THEN
       LET l_fmdh015 = g_master.fmcy001,'0',g_master.fmcy002 USING '<<<<<'
    ELSE
       LET l_fmdh015 = g_master.fmcy001,g_master.fmcy002 USING '<<<<<'
    END IF
    IF l_count = 0 THEN
       INSERT INTO fmdh_t (fmdhent,fmdhdocno,fmdhcomp,fmdhseq,
                           fmdh001,fmdh002,fmdh003,fmdh004,fmdh005,fmdh006,
                           fmdh007,fmdh008,fmdh009,fmdh010,fmdh011,fmdh012,
                           fmdh013,fmdh014,fmdh015,fmdh016,fmdh017,fmdh018
                          )
                   VALUES (g_enterprise,p_fmcrdocno,g_master.fmcycomp,p_fmcsseq,
                           l_fmcs001,l_fmcs002,g_master.fmcy001,g_master.fmcy002,p_fmcq008,l_fmcs008 + p_fmcq008,
                           l_fmcs008,l_amt1,l_fmcz010,l_fmcz012,l_fmcz014,l_fmcs008 * l_fmcz010,
                           l_fmcs008 * l_fmcz012,l_fmcs008 * l_fmcz014,l_fmdh015,l_amt1 * l_fmcz010,l_amt1 * l_fmcz012,l_amt1 * l_fmcz014
                          )
    ELSE
       UPDATE fmdh_t SET fmdh008 = fmdh008 + l_amt1,
                         fmdh016 = fmdh016 + l_fmcz013,
                         fmdh017 = fmdh017 + l_fmcz014,
                         fmdh018 = fmdh018 + l_fmcz015,
                         fmdh015 = l_fmdh015
        WHERE fmdhent = g_enterprise
          AND fmdhdocno = p_fmcrdocno
          AND fmdhseq = p_fmcsseq
    END IF
  #160302-00029#2 Add  ---(E)---


END FUNCTION

#end add-point
 
{</section>}
 
