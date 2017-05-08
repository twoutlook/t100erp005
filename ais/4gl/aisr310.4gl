#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-11 17:36:06), PR版次:0001(2016-11-22 12:00:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aisr310
#+ Description: 客戶貨款對帳憑證單列印
#+ Creator....: 08732(2016-11-11 17:36:06)
#+ Modifier...: 08732 -SD/PR- 08732
 
{</section>}
 
{<section id="aisr310.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
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
       isafsite LIKE isaf_t.isafsite, 
   l_isafsite_desc LIKE type_t.chr80, 
   isafcomp LIKE isaf_t.isafcomp, 
   l_isafcomp_desc LIKE type_t.chr80, 
   isaf001 LIKE isaf_t.isaf001, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf057 LIKE isaf_t.isaf057, 
   isaf004 LIKE isaf_t.isaf004, 
   isaf003 LIKE isaf_t.isaf003, 
   isaf044 LIKE isaf_t.isaf044, 
   isafstus LIKE isaf_t.isafstus,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_sql_ctrl     STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisr310.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisr310_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisr310 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisr310_init()
 
      #進入選單 Menu (="N")
      CALL aisr310_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisr310
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisr310.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisr310_init()
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
   CALL s_fin_create_account_center_tmp()
   CALL cl_set_combo_scc("isaf001","9715")
   CALL cl_set_combo_scc("isaf044","9959")
   CALL cl_set_combo_scc("isafstus","9962")
   CALL aisr310_qbe_clear()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisr310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr310_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_sql          STRING
   DEFINE g_wc_cs_comp   STRING
   DEFINE l_cnt_comp     LIKE type_t.num10
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
         INPUT BY NAME g_master.isafsite,g_master.isafcomp,g_master.isaf001,g_master.isaf044,g_master.isafstus  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafsite
            
            #add-point:AFTER FIELD isafsite name="input.a.isafsite"
            LET g_master.l_isafsite_desc = ''
            LET g_master.l_isafcomp_desc = ''
            IF NOT cl_null(g_master.isafsite) THEN
               CALL s_fin_account_center_sons_query('3',g_master.isafsite,g_today,'')
               CALL s_fin_account_center_chk(g_master.isafsite,'','3',g_today)  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.isafsite = ''
                  LET g_master.l_isafsite_desc = ''
                  LET g_master.isafcomp = ''
                  LET g_master.l_isafcomp_desc = ''
                  DISPLAY BY NAME g_master.isafsite,g_master.l_isafsite_desc,
                                  g_master.isafcomp,g_master.l_isafcomp_desc
                  NEXT FIELD CURRENT
               END IF
               
            END IF
            LET g_master.l_isafsite_desc = s_desc_get_department_desc(g_master.isafsite)
            CALL aisr310_ooef017(g_master.isafsite)  RETURNING g_master.isafcomp,g_master.l_isafcomp_desc
               
            DISPLAY BY NAME g_master.isafsite,g_master.l_isafsite_desc,
                            g_master.isafcomp,g_master.l_isafcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafsite
            #add-point:BEFORE FIELD isafsite name="input.b.isafsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafsite
            #add-point:ON CHANGE isafsite name="input.g.isafsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafcomp
            
            #add-point:AFTER FIELD isafcomp name="input.a.isafcomp"
            LET g_master.l_isafcomp_desc = ''
            IF NOT cl_null(g_master.isafcomp) THEN
               CALL s_fin_azzi800_sons_query(g_today)
               IF NOT cl_null(g_master.isafsite) THEN 
                  CALL s_fin_account_center_sons_query('3',g_master.isafsite,g_today,'')
               END IF 
               CALL s_fin_account_center_comp_str()RETURNING g_wc_cs_comp
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               
               CALL s_fin_comp_chk(g_master.isafcomp)  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.isafcomp = ''
                  LET g_master.l_isafcomp_desc = s_desc_get_department_desc(g_master.isafcomp)
                  DISPLAY BY NAME g_master.isafcomp,g_master.l_isafcomp_desc
                  NEXT FIELD CURRENT
               END IF
               
               #比對輸入的法人是否在帳務組織下
               CALL s_fin_site_belong_to_comp_chk(g_master.isafsite,g_master.isafcomp)  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.isafcomp = ''
                  LET g_master.l_isafcomp_desc = s_desc_get_department_desc(g_master.isafcomp)
                  DISPLAY BY NAME g_master.isafcomp,g_master.l_isafcomp_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.l_isafcomp_desc = s_desc_get_department_desc(g_master.isafcomp)
            DISPLAY BY NAME g_master.isafcomp,g_master.l_isafcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafcomp
            #add-point:BEFORE FIELD isafcomp name="input.b.isafcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafcomp
            #add-point:ON CHANGE isafcomp name="input.g.isafcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf001
            #add-point:BEFORE FIELD isaf001 name="input.b.isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf001
            
            #add-point:AFTER FIELD isaf001 name="input.a.isaf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaf001
            #add-point:ON CHANGE isaf001 name="input.g.isaf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf044
            #add-point:BEFORE FIELD isaf044 name="input.b.isaf044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf044
            
            #add-point:AFTER FIELD isaf044 name="input.a.isaf044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaf044
            #add-point:ON CHANGE isaf044 name="input.g.isaf044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafstus
            #add-point:BEFORE FIELD isafstus name="input.b.isafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafstus
            
            #add-point:AFTER FIELD isafstus name="input.a.isafstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafstus
            #add-point:ON CHANGE isafstus name="input.g.isafstus"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isafsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafsite
            #add-point:ON ACTION controlp INFIELD isafsite name="input.c.isafsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.isafsite             #給予default值
            LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_46()                                #呼叫開窗
 
            LET g_master.isafsite = g_qryparam.return1              
            #LET g_master.ooef001 = g_qryparam.return2 
            DISPLAY g_master.isafsite TO isafsite              #
            #DISPLAY g_master.ooef001 TO ooef001 #组织编号
            CALL s_desc_get_department_desc(g_master.isafsite) RETURNING g_master.l_isafsite_desc
            DISPLAY BY NAME g_master.l_isafsite_desc
            NEXT FIELD isafsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafcomp
            #add-point:ON ACTION controlp INFIELD isafcomp name="input.c.isafcomp"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
   
            LET g_qryparam.default1 = g_master.isafcomp             #給予default值
            IF NOT cl_null(g_master.isafsite) THEN 
               CALL s_fin_azzi800_sons_query(g_today)                 
               CALL s_fin_account_center_sons_query('3',g_master.isafsite,g_today,'')
               CALL s_fin_account_center_comp_str()RETURNING g_wc_cs_comp
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp CLIPPED
            ELSE
               CALL s_fin_azzi800_sons_query(g_today)
               CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
               CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
               LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp CLIPPED
            END IF 
            
            CALL q_ooef001_2()                                #呼叫開窗
            LET g_master.isafcomp = g_qryparam.return1              
            DISPLAY g_master.isafcomp TO isafcomp  
            CALL s_desc_get_department_desc(g_master.isafcomp) RETURNING g_master.l_isafcomp_desc
            DISPLAY BY NAME g_master.l_isafcomp_desc            
            NEXT FIELD isafcomp                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf001
            #add-point:ON ACTION controlp INFIELD isaf001 name="input.c.isaf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf044
            #add-point:ON ACTION controlp INFIELD isaf044 name="input.c.isaf044"
            
            #END add-point
 
 
         #Ctrlp:input.c.isafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafstus
            #add-point:ON ACTION controlp INFIELD isafstus name="input.c.isafstus"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isafdocno,isafdocdt,isaf057,isaf004,isaf003
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocno
            #add-point:ON ACTION controlp INFIELD isafdocno name="construct.c.isafdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isafcomp = '",g_master.isafcomp,"' ",
                                   " AND isafsite = '", g_master.isafsite,"' ",
                                   " AND isaf001 = '", g_master.isaf001,"' ",
                                   " AND isafstus != 'X'"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = isafent ",
                                                       "                AND pmaa001 = isaf003 )"
            END IF
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isafdocno  #顯示到畫面上
            NEXT FIELD isafdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocno
            #add-point:BEFORE FIELD isafdocno name="construct.b.isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocno
            
            #add-point:AFTER FIELD isafdocno name="construct.a.isafdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocdt
            #add-point:BEFORE FIELD isafdocdt name="construct.b.isafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocdt
            
            #add-point:AFTER FIELD isafdocdt name="construct.a.isafdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocdt
            #add-point:ON ACTION controlp INFIELD isafdocdt name="construct.c.isafdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf057
            #add-point:BEFORE FIELD isaf057 name="construct.b.isaf057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf057
            
            #add-point:AFTER FIELD isaf057 name="construct.a.isaf057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf057
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf057
            #add-point:ON ACTION controlp INFIELD isaf057 name="construct.c.isaf057"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf057  #顯示到畫面上
            NEXT FIELD isaf057                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.isaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf004
            #add-point:ON ACTION controlp INFIELD isaf004 name="construct.c.isaf004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf004  #顯示到畫面上
            NEXT FIELD isaf004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf004
            #add-point:BEFORE FIELD isaf004 name="construct.b.isaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf004
            
            #add-point:AFTER FIELD isaf004 name="construct.a.isaf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf003
            #add-point:ON ACTION controlp INFIELD isaf003 name="construct.c.isaf003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_sql_ctrl
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO isaf003  #顯示到畫面上
            NEXT FIELD isaf003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf003
            #add-point:BEFORE FIELD isaf003 name="construct.b.isaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf003
            
            #add-point:AFTER FIELD isaf003 name="construct.a.isaf003"
            
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
            CALL aisr310_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aisr310_get_buffer(l_dialog)
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
            LET g_master.isaf001 = "1"
            LET g_master.isaf044 = "1"
            LET g_master.isafstus = "2"
            CALL aisr310_qbe_clear()
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
         CALL aisr310_init()
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
                 CALL aisr310_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisr310_transfer_argv(ls_js)
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
 
{<section id="aisr310.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisr310_transfer_argv(ls_js)
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
 
{<section id="aisr310.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisr310_process(ls_js)
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
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"isafdocno,isafdocdt,isaf057,isaf004,isaf003")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN  ## 若是t類進來 會是傳字串參數的方式
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
            LET ls_next = l_token.nextToken()
            LET l_arg[l_cnt] = ls_next
            LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET g_master.wc = l_arg[01]
   ELSE
      
      CASE g_master.isafstus
        WHEN '1'
              LET g_master.wc = g_master.wc CLIPPED,"AND isafstus = 'N' "	
        WHEN '2'
              LET g_master.wc = g_master.wc CLIPPED,"AND isafstus = 'Y' "
        WHEN '3'
              LET g_master.wc = g_master.wc CLIPPED,"AND isafstus != 'X' "              
      END CASE
      CASE g_master.isaf044
         WHEN '1'
               LET g_master.wc = g_master.wc CLIPPED,"AND isaf044 = 0 "	
         WHEN '2'
               LET g_master.wc = g_master.wc CLIPPED,"AND isaf044 > 0 "			
      END CASE
       
	   LET g_master.wc = g_master.wc CLIPPED, " AND isafent = '",g_enterprise,"' ",
                                             " AND isafcomp = '",g_master.isafcomp,"' ",
                                             " AND isafsite = '",g_master.isafsite,"' ",
                                             " AND isaf001 = '",g_master.isaf001,"' ",
                                             " AND isafent = isagent AND isafcomp = isagcomp AND isafdocno = isagdocno "
   END IF
   CALL aisr310_g01(g_master.wc)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisr310_process_cs CURSOR FROM ls_sql
#  FOREACH aisr310_process_cs INTO
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
 
{<section id="aisr310.get_buffer" >}
PRIVATE FUNCTION aisr310_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.isafsite = p_dialog.getFieldBuffer('isafsite')
   LET g_master.isafcomp = p_dialog.getFieldBuffer('isafcomp')
   LET g_master.isaf001 = p_dialog.getFieldBuffer('isaf001')
   LET g_master.isaf044 = p_dialog.getFieldBuffer('isaf044')
   LET g_master.isafstus = p_dialog.getFieldBuffer('isafstus')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr310.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 歸屬法人及說明
# Memo...........:
# Usage..........: CALL aisr310_ooef017(p_site)
#                  RETURNING r_ooef017,r_ooef017_desc
# Input parameter: p_site         組織
# Return code....: r_ooef017      法人
#                : r_ooef017_desc 法人說明
# Date & Author..: 2016/11/14 By  08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr310_ooef017(p_site)
DEFINE p_site           LIKE ooef_t.ooef001
DEFINE r_ooef017        LIKE ooef_t.ooef017
DEFINE r_ooef017_desc   LIKE type_t.chr500

   SELECT ooef017,ooefl003 INTO r_ooef017,r_ooef017_desc FROM ooef_t
     LEFT OUTER JOIN ooefl_t ON ooeflent = ooefent AND ooefl001 = ooef017 AND ooefl002 = g_dlang
    WHERE ooefent = g_enterprise AND ooef001 = p_site
   
   RETURN r_ooef017,r_ooef017_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aisr310_qbe_clear()
# Date & Author..: 2016/11/17 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr310_qbe_clear()
DEFINE l_isafcomp         LIKE isaf_t.isafcomp
DEFINE l_glaald           LIKE glaa_t.glaald
   
   #帳務組織預設
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_master.isafsite,g_errno
   #帳務中心說明                                                     
   CALL s_desc_get_department_desc(g_master.isafsite)RETURNING g_master.l_isafsite_desc                                                       
   #抓法人
   LET g_master.isafcomp = ''
   SELECT ooef017 INTO g_master.isafcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.isafsite
   #法人說明
   CALL s_desc_get_department_desc(g_master.isafcomp)RETURNING g_master.l_isafcomp_desc 
   
   LET g_master.isaf001 = "1"
   LET g_master.isaf044 = "1"
   LET g_master.isafstus = "2"
   CALL s_fin_azzi800_sons_query(g_today)

   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   
   DISPLAY BY NAME g_master.l_isafcomp_desc,g_master.l_isafsite_desc
END FUNCTION

#end add-point
 
{</section>}
 
