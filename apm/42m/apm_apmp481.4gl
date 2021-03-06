#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp481.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-04-01 16:27:46), PR版次:0005(2016-12-15 14:18:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: apmp481
#+ Description: 採購合約累積量計算作業
#+ Creator....: 02295(2015-02-26 14:46:22)
#+ Modifier...: 02295 -SD/PR- 05423
 
{</section>}
 
{<section id="apmp481.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160127-00036#1   2016/04/29 By lixiang   合約結算時，關聯到合約項次，不關聯到料件（取採購合約价時，有可能會用合約替代料取價）
#160816-00001#7  16/08/17 By 08742        抓取理由碼改CALL sub
#160420-00007#1   2016/10/09 By 02295     在计算跨阶的时候，应该需要先减去跨阶的数量对应的金额，再重新计算跨阶的数量和金额
#161124-00048#8   2016/12/14 By zhujing   .*整批调整
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
       pmdxdocno LIKE type_t.chr20, 
   pmdx004 LIKE type_t.chr10, 
   pmdy002 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   imaf141 LIKE type_t.chr10, 
   pmdx002 LIKE type_t.chr20, 
   pmdx003 LIKE type_t.chr10, 
   pmdx014 LIKE type_t.dat, 
   pmdx015 LIKE type_t.dat, 
   chk LIKE type_t.chr500, 
   pmeo026 LIKE pmeo_t.pmeo026, 
   pmeo027 LIKE pmeo_t.pmeo027, 
   pmeo027_desc LIKE type_t.chr80, 
   pmdt051 LIKE pmdt_t.pmdt051, 
   pmdt051_desc LIKE type_t.chr80, 
   imaf001 LIKE imaf_t.imaf001, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_acc          LIKE gzcb_t.gzcb007
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_master_o type_master
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp481.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apmp481_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp481 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp481_init()
 
      #進入選單 Menu (="N")
      CALL apmp481_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp481
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp481.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp481_init()
 
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
   CALL s_apmp482_create_table()
   LET g_master.chk='N'
   LET g_master.pmeo026='1'
   IF g_master.pmeo026 = '1' AND g_master.chk = 'Y' THEN 
      CALL cl_set_comp_required("imaf001",TRUE)
   ELSE
      CALL cl_set_comp_required("imaf001",FALSE)
   END IF   
   CALL cl_set_combo_scc("pmeo026",'4056')
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位]
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'apmt580'   #160816-00001#7 mark
   LET g_acc = s_fin_get_scc_value('24','apmt580','2')  #160816-00001#7  Add
   
   SELECT ooef004 INTO g_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp481.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp481_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_flag             LIKE type_t.num5
   DEFINE l_where            STRING
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.chk,g_master.pmeo026,g_master.pmeo027,g_master.pmdt051,g_master.imaf001  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master_o.* = g_master.*
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            IF g_master.chk = 'Y' THEN 
               CALL cl_set_comp_required("pmeo027,pmdt051",TRUE)
            ELSE
               CALL cl_set_comp_required("pmeo027,pmdt051",FALSE)
            END IF
            IF g_master.pmeo026 = '1' AND g_master.chk = 'Y' THEN 
               CALL cl_set_comp_required("imaf001",TRUE)
            ELSE
               CALL cl_set_comp_required("imaf001",FALSE)
            END IF            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeo026
            #add-point:BEFORE FIELD pmeo026 name="input.b.pmeo026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeo026
            
            #add-point:AFTER FIELD pmeo026 name="input.a.pmeo026"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeo026
            #add-point:ON CHANGE pmeo026 name="input.g.pmeo026"
            IF g_master.pmeo026 = '1' AND g_master.chk = 'Y' THEN 
               CALL cl_set_comp_required("imaf001",TRUE)
            ELSE
               CALL cl_set_comp_required("imaf001",FALSE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeo027
            
            #add-point:AFTER FIELD pmeo027 name="input.a.pmeo027"
            CALL s_aooi200_get_slip_desc(g_master.pmeo027) RETURNING g_master.pmeo027_desc
            DISPLAY BY NAME g_master.pmeo027_desc
            IF NOT cl_null(g_master.pmeo027) THEN
               IF g_master.pmeo027 <> g_master_o.pmeo027 OR cl_null(g_master_o.pmeo027) THEN
                  #檢查單別
                  IF NOT s_aooi200_chk_slip(g_site,'',g_master.pmeo027,'apmt580') THEN
                     LET g_master.pmeo027 = g_master_o.pmeo027
                     NEXT FIELD CURRENT
                  END IF            
               END IF
               IF NOT cl_null(g_master.pmdt051) THEN 
                  #檢核輸入的理由碼是否在單據別限制範圍內
                  CALL s_control_chk_doc('8',g_master.pmeo027,g_master.pmdt051,'','','','') RETURNING l_success,l_flag
                  IF NOT l_success OR NOT l_flag THEN
                     LET g_master.pmdt051 = g_master_o.pmdt051
                     NEXT FIELD pmdt051
                  END IF
               END IF               
            END IF

            LET g_master_o.pmeo027 = g_master.pmeo027
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeo027
            #add-point:BEFORE FIELD pmeo027 name="input.b.pmeo027"
            CALL s_aooi200_get_slip_desc(g_master.pmeo027) RETURNING g_master.pmeo027_desc
            DISPLAY BY NAME g_master.pmeo027_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeo027
            #add-point:ON CHANGE pmeo027 name="input.g.pmeo027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt051
            
            #add-point:AFTER FIELD pmdt051 name="input.a.pmdt051"
            CALL apmp481_reason_ref(g_master.pmdt051) RETURNING g_master.pmdt051_desc
            DISPLAY BY NAME g_master.pmdt051_desc           
            IF NOT cl_null(g_master.pmdt051) THEN
               IF g_master.pmdt051 <> g_master_o.pmdt051 OR cl_null(g_master_o.pmdt051) THEN
                  IF NOT s_azzi650_chk_exist(g_acc,g_master.pmdt051) THEN
                     LET g_master.pmdt051 = g_master_o.pmdt051
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.pmeo027) THEN 
                     #檢核輸入的理由碼是否在單據別限制範圍內
                     CALL s_control_chk_doc('8',g_master.pmeo027,g_master.pmdt051,'','','','') RETURNING l_success,l_flag
                     IF NOT l_success OR NOT l_flag THEN
                        LET g_master.pmdt051 = g_master_o.pmdt051
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.pmdt051 = g_master.pmdt051
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt051
            #add-point:BEFORE FIELD pmdt051 name="input.b.pmdt051"
            CALL apmp481_reason_ref(g_master.pmdt051) RETURNING g_master.pmdt051_desc
            DISPLAY BY NAME g_master.pmdt051_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdt051
            #add-point:ON CHANGE pmdt051 name="input.g.pmdt051"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf001
            #add-point:BEFORE FIELD imaf001 name="input.b.imaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf001
            
            #add-point:AFTER FIELD imaf001 name="input.a.imaf001"
            IF NOT cl_null(g_master.imaf001) THEN 
               IF g_master.imaf001 <> g_master_o.imaf001 OR cl_null(g_master_o.imaf001) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.imaf001
                  IF NOT cl_chk_exist("v_imaf001_16") THEN
                     LET g_master.imaf001 = g_master_o.imaf001 
                     DISPLAY BY NAME g_master.imaf001
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF 
            LET g_master_o.imaf001 = g_master.imaf001
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaf001
            #add-point:ON CHANGE imaf001 name="input.g.imaf001"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeo026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeo026
            #add-point:ON ACTION controlp INFIELD pmeo026 name="input.c.pmeo026"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeo027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeo027
            #add-point:ON ACTION controlp INFIELD pmeo027 name="input.c.pmeo027"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.pmeo027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004
            LET g_qryparam.arg2 = "apmt580" 

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_master.pmeo027 = g_qryparam.return1              

            DISPLAY g_master.pmeo027 TO pmeo027              #

            NEXT FIELD pmeo027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdt051
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt051
            #add-point:ON ACTION controlp INFIELD pmdt051 name="input.c.pmdt051"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.pmdt051             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = g_acc #s
            IF NOT cl_null(g_master.pmeo027) THEN 
               CALL s_control_get_doc_sql('oocq002',g_master.pmeo027,'8')
                    RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
               END IF
            END IF
            CALL q_oocq002()                                #呼叫開窗

            LET g_master.pmdt051 = g_qryparam.return1              
            #LET g_master.oocq002 = g_qryparam.return2 
            DISPLAY g_master.pmdt051 TO pmdt051              #
            #DISPLAY g_master.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD pmdt051                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf001
            #add-point:ON ACTION controlp INFIELD imaf001 name="input.c.imaf001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
         
            LET g_qryparam.default1 = g_master.imaf001             #給予default值
            CALL s_control_get_item_sql('2',g_site,g_user,g_dept,g_master.pmeo027)
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = l_where
            END IF
            #給予arg
            CALL q_imaf001_17()                                #呼叫開窗
            LET g_master.imaf001 = g_qryparam.return1              
            DISPLAY g_master.imaf001 TO imaf001              
            NEXT FIELD imaf001                          #返回原欄位


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmdxdocno,pmdx004,pmdy002,imaa009,imaf141,pmdx002,pmdx003, 
             pmdx014,pmdx015
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmdxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdxdocno
            #add-point:ON ACTION controlp INFIELD pmdxdocno name="construct.c.pmdxdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdxdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdxdocno  #顯示到畫面上
            NEXT FIELD pmdxdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdxdocno
            #add-point:BEFORE FIELD pmdxdocno name="construct.b.pmdxdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdxdocno
            
            #add-point:AFTER FIELD pmdxdocno name="construct.a.pmdxdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdx004
            #add-point:ON ACTION controlp INFIELD pmdx004 name="construct.c.pmdx004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdx004  #顯示到畫面上
            NEXT FIELD pmdx004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdx004
            #add-point:BEFORE FIELD pmdx004 name="construct.b.pmdx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdx004
            
            #add-point:AFTER FIELD pmdx004 name="construct.a.pmdx004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdy002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdy002
            #add-point:ON ACTION controlp INFIELD pmdy002 name="construct.c.pmdy002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdy002  #顯示到畫面上
            NEXT FIELD pmdy002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdy002
            #add-point:BEFORE FIELD pmdy002 name="construct.b.pmdy002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdy002
            
            #add-point:AFTER FIELD pmdy002 name="construct.a.pmdy002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="construct.c.imaf141"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="construct.b.imaf141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="construct.a.imaf141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdx002
            #add-point:ON ACTION controlp INFIELD pmdx002 name="construct.c.pmdx002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdx002  #顯示到畫面上
            NEXT FIELD pmdx002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdx002
            #add-point:BEFORE FIELD pmdx002 name="construct.b.pmdx002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdx002
            
            #add-point:AFTER FIELD pmdx002 name="construct.a.pmdx002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdx003
            #add-point:ON ACTION controlp INFIELD pmdx003 name="construct.c.pmdx003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdx003  #顯示到畫面上
            NEXT FIELD pmdx003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdx003
            #add-point:BEFORE FIELD pmdx003 name="construct.b.pmdx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdx003
            
            #add-point:AFTER FIELD pmdx003 name="construct.a.pmdx003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdx014
            #add-point:BEFORE FIELD pmdx014 name="construct.b.pmdx014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdx014
            
            #add-point:AFTER FIELD pmdx014 name="construct.a.pmdx014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdx014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdx014
            #add-point:ON ACTION controlp INFIELD pmdx014 name="construct.c.pmdx014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdx015
            #add-point:BEFORE FIELD pmdx015 name="construct.b.pmdx015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdx015
            
            #add-point:AFTER FIELD pmdx015 name="construct.a.pmdx015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdx015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdx015
            #add-point:ON ACTION controlp INFIELD pmdx015 name="construct.c.pmdx015"
            
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
            CALL apmp481_get_buffer(l_dialog)
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
         CALL apmp481_init()
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
                 CALL apmp481_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp481_transfer_argv(ls_js)
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
 
{<section id="apmp481.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp481_transfer_argv(ls_js)
 
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
 
{<section id="apmp481.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp481_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE la_param       RECORD
          prog           STRING,
          param          DYNAMIC ARRAY OF STRING
                         END RECORD   
   DEFINE l_str STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE l_pmdsdocno LIKE pmds_t.pmdsdocno
   DEFINE l_pmdxdocno LIKE pmdx_t.pmdxdocno
   DEFINE l_pmdy     RECORD 
            pmdydocno  LIKE pmdy_t.pmdydocno,
            pmdyseq    LIKE pmdy_t.pmdyseq,
            pmdy002    LIKE pmdy_t.pmdy002,
            pmdy003    LIKE pmdy_t.pmdy003,
            pmdy008    LIKE pmdy_t.pmdy008,
            pmdy010    LIKE pmdy_t.pmdy010,
            pmdy011    LIKE pmdy_t.pmdy011,
            pmdy012    LIKE pmdy_t.pmdy012,
            pmdy024    LIKE pmdy_t.pmdy024,
            pmdx005    LIKE pmdx_t.pmdx005,
            pmdx007    LIKE pmdx_t.pmdx007,
            pmdx008    LIKE pmdx_t.pmdx008
            END RECORD
   #161124-00048#8 mod-S            
#   DEFINE l_pmeo      RECORD LIKE pmeo_t.*
#   DEFINE l_pmep      RECORD LIKE pmep_t.*
   DEFINE l_pmeo RECORD  #採購合約/核價結算來源單據明細檔
          pmeoent LIKE pmeo_t.pmeoent, #企业编号
          pmeosite LIKE pmeo_t.pmeosite, #营运据点
          pmeo000 LIKE pmeo_t.pmeo000, #数据类型
          pmeo001 LIKE pmeo_t.pmeo001, #合同/核价单号
          pmeo002 LIKE pmeo_t.pmeo002, #项次
          pmeo003 LIKE pmeo_t.pmeo003, #关联单号
          pmeo004 LIKE pmeo_t.pmeo004, #关联项次
          pmeo005 LIKE pmeo_t.pmeo005, #结算日期
          pmeo006 LIKE pmeo_t.pmeo006, #料件编号
          pmeo007 LIKE pmeo_t.pmeo007, #产品特征
          pmeo008 LIKE pmeo_t.pmeo008, #交易数量
          pmeo009 LIKE pmeo_t.pmeo009, #交易单位
          pmeo010 LIKE pmeo_t.pmeo010, #原始单价
          pmeo011 LIKE pmeo_t.pmeo011, #原始税前金额
          pmeo012 LIKE pmeo_t.pmeo012, #原始含税金额
          pmeo013 LIKE pmeo_t.pmeo013, #原始税额
          pmeo014 LIKE pmeo_t.pmeo014, #建议调整后税前金额
          pmeo015 LIKE pmeo_t.pmeo015, #建议调整后含税金额
          pmeo016 LIKE pmeo_t.pmeo016, #建议调整后税额
          pmeo017 LIKE pmeo_t.pmeo017, #差异税前金额
          pmeo018 LIKE pmeo_t.pmeo018, #差异含税金额
          pmeo019 LIKE pmeo_t.pmeo019, #差异税额
          pmeo020 LIKE pmeo_t.pmeo020, #差异数量单价
          pmeo021 LIKE pmeo_t.pmeo021, #差异数量
          pmeo022 LIKE pmeo_t.pmeo022, #来源单号
          pmeo023 LIKE pmeo_t.pmeo023, #来源项次
          pmeo024 LIKE pmeo_t.pmeo024, #来源据点
          pmeo025 LIKE pmeo_t.pmeo025, #差异处理否
          pmeo026 LIKE pmeo_t.pmeo026, #差异处理方式
          pmeo027 LIKE pmeo_t.pmeo027, #差异处理单号
          pmeo028 LIKE pmeo_t.pmeo028, #差异处理项次
          pmeo029 LIKE pmeo_t.pmeo029  #建议调整单价
   END RECORD
   DEFINE l_pmep RECORD  #採購合約結算歷程檔
          pmepent LIKE pmep_t.pmepent, #企业编号
          pmepsite LIKE pmep_t.pmepsite, #营运据点
          pmep001 LIKE pmep_t.pmep001, #合同单号
          pmep002 LIKE pmep_t.pmep002, #项次
          pmep003 LIKE pmep_t.pmep003, #结算日期
          pmep004 LIKE pmep_t.pmep004, #本期新增数量
          pmep005 LIKE pmep_t.pmep005, #本期新增税前金额
          pmep006 LIKE pmep_t.pmep006, #本期新增含税金额
          pmep007 LIKE pmep_t.pmep007, #本期新增税额
          pmep008 LIKE pmep_t.pmep008, #本期累积数量
          pmep009 LIKE pmep_t.pmep009, #本期累积税前金额
          pmep010 LIKE pmep_t.pmep010, #本期累积含税金额
          pmep011 LIKE pmep_t.pmep011, #本期累积税额
          pmep012 LIKE pmep_t.pmep012, #结算人员
          pmep013 LIKE pmep_t.pmep013  #结算部门
   END RECORD
   #161124-00048#8 mod-E            
   DEFINE l_pmdt      RECORD 
             pmds000 LIKE pmds_t.pmds000,
             pmds037 LIKE pmds_t.pmds037,
             pmds038 LIKE pmds_t.pmds038,
             pmds048 LIKE pmds_t.pmds048,
             pmdtsite LIKE pmdt_t.pmdtsite,
             pmdtdocno LIKE pmdt_t.pmdtdocno,
             pmdtseq LIKE pmdt_t.pmdtseq,
             pmdt001 LIKE pmdt_t.pmdt001,
             pmdt002 LIKE pmdt_t.pmdt002,
             pmdt019 LIKE pmdt_t.pmdt019,
             pmdt020 LIKE pmdt_t.pmdt020,
             pmdt024 LIKE pmdt_t.pmdt024,
             pmdt038 LIKE pmdt_t.pmdt038,
             pmdt039 LIKE pmdt_t.pmdt039,
             pmdt047 LIKE pmdt_t.pmdt047,
             pmdt046 LIKE pmdt_t.pmdt046,
             pmdt036 LIKE pmdt_t.pmdt036
          END RECORD 
   DEFINE l_datetime  DATETIME YEAR TO SECOND        
   DEFINE l_qty LIKE pmep_t.pmep004       #每笔单据交易数量对应合约单单位的数量
   DEFINE l_flag LIKE type_t.num5   
   DEFINE l_xrcd103_1    LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104_1    LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105_1    LIKE xrcd_t.xrcd105
   DEFINE l_xrcd103_2    LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104_2    LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105_2    LIKE xrcd_t.xrcd105
   DEFINE l_xrcd103      LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104      LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105      LIKE xrcd_t.xrcd105
   DEFINE l_xrcd113      LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114      LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115      LIKE xrcd_t.xrcd115   
   DEFINE l_price        LIKE xmdy_t.xmdy010
   DEFINE l_dw_price     LIKE xmdy_t.xmdy010
   DEFINE l_up_price     LIKE xmdy_t.xmdy010
   DEFINE l_down         LIKE pmdt_t.pmdt024
   DEFINE l_up           LIKE pmdt_t.pmdt024
   DEFINE l_pmdz001      LIKE pmdz_t.pmdz001
   DEFINE l_dw_pmdz001   LIKE pmdz_t.pmdz001
   DEFINE l_up_pmdz001   LIKE pmdz_t.pmdz001
   DEFINE l_pmdzseq1     LIKE pmdz_t.pmdzseq1
   DEFINE l_dw_pmdzseq1  LIKE pmdz_t.pmdzseq1
   DEFINE l_up_pmdzseq1  LIKE pmdz_t.pmdzseq1 
   DEFINE l_pmep008 LIKE pmep_t.pmep008
   DEFINE l_pmdspstdt LIKE pmds_t.pmdspstdt
   DEFINE l_pmdz001_t    LIKE pmdz_t.pmdz001   #160420-00007#1
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
#  DECLARE apmp481_process_cs CURSOR FROM ls_sql
#  FOREACH apmp481_process_cs INTO
   #add-point:process段process name="process.process"
   
   CALL cl_err_collect_init()
   LET l_success = FALSE
   LET ls_sql = " SELECT pmdz001,pmdzseq1 ",
               "   FROM pmdz_t ",
               "  WHERE pmdzdocno = ? ",
               "    AND pmdzseq = ? ",
               "    AND pmdz001 <= ? ",
               "    AND pmdzent = '",g_enterprise,"' ",
               "    AND pmdzsite = '",g_site,"' ",
               "    AND pmdz001 = (SELECT MAX(pmdz001) FROM pmdz_t ",
               "                    WHERE pmdzdocno = ? ",
               "                      AND pmdzseq = ? ",
               "                      AND pmdz001 <= ? ",
               "                      AND pmdzent = '",g_enterprise,"' ",
               "                      AND pmdzsite = '",g_site,"')"                        
   PREPARE apmp481_max FROM ls_sql
   
   LET ls_sql = " SELECT pmdzseq1,pmdz001 ",
               "   FROM pmdz_t ",
               "  WHERE pmdzdocno = ? ",
               "    AND pmdzseq = ? ",
               "    AND pmdz001 > ? ",
               "    AND pmdz001 < ? ",
               "    AND pmdzent = '",g_enterprise,"' ",
               "    AND pmdzsite = '",g_site,"' ",
               "  ORDER BY pmdz001 DESC "
   PREPARE apmp481_process_sel_pmdz_pre FROM ls_sql
   DECLARE apmp481_process_sel_pmdz_cs CURSOR FOR apmp481_process_sel_pmdz_pre
      
   #合约单+项次
   LET ls_sql = "SELECT DISTINCT pmdydocno,pmdyseq,pmdy002,pmdy003,pmdy008,",
                "       pmdy010,pmdy011,pmdy012,pmdy024,pmdx005,pmdx007,pmdx008 ",
                "  FROM pmdy_t,pmdx_t ",
                " WHERE pmdyent = pmdxent AND pmdydocno=pmdxdocno ",
                "   AND pmdyent='",g_enterprise,"' AND pmdxstus='Y' AND pmdxdocno =? AND ",g_master.wc,
                " ORDER BY pmdydocno,pmdyseq "
   DECLARE apmp481_process_cs CURSOR WITH HOLD FROM ls_sql
      
   LET li_count = 0  
   LET ls_sql = "SELECT COUNT(pmdxdocno) ",
                "  FROM pmdx_t ",
                " WHERE pmdxent='",g_enterprise,"' AND pmdxstus='Y' AND ",g_master.wc,
                " ORDER BY pmdxdocno "
   PREPARE apmp481_process_count FROM ls_sql
   EXECUTE apmp481_process_count INTO li_count     
      
   #合约单
   LET ls_sql = "SELECT DISTINCT pmdxdocno ",
                "  FROM pmdx_t ",
                " WHERE pmdxent='",g_enterprise,"' AND pmdxstus='Y' AND ",g_master.wc,
                " ORDER BY pmdxdocno "
   DECLARE apmp481_process_c CURSOR WITH HOLD FROM ls_sql
   FOREACH apmp481_process_c INTO l_pmdxdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF   
      CALL s_transaction_begin()
      LET g_success = TRUE
      FOREACH apmp481_process_cs USING l_pmdxdocno
           INTO l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_pmdy.pmdy002,l_pmdy.pmdy003,
                l_pmdy.pmdy008,l_pmdy.pmdy010,l_pmdy.pmdy011,l_pmdy.pmdy012,
                l_pmdy.pmdy024,l_pmdy.pmdx005,l_pmdy.pmdx007,l_pmdy.pmdx008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         LET l_datetime = cl_get_current()
         
         LET l_pmep.pmepent = g_enterprise
         LET l_pmep.pmepsite = g_site
         LET l_pmep.pmep001 = l_pmdy.pmdydocno
         LET l_pmep.pmep002 = l_pmdy.pmdyseq
         LET l_pmep.pmep003 = l_datetime
         LET l_pmep.pmep004 = 0
         LET l_pmep.pmep005 = 0
         LET l_pmep.pmep006 = 0
         LET l_pmep.pmep007 = 0
         LET l_pmep.pmep008 = 0
         LET l_pmep.pmep009 = 0
         LET l_pmep.pmep010 = 0
         LET l_pmep.pmep011 = 0
         LET l_pmep.pmep012 = g_user
         LET l_pmep.pmep013 = g_dept      
         #抓取上次累计数量
         SELECT pmep008,pmep009,pmep010,pmep011 
           INTO l_pmep.pmep008,l_pmep.pmep009,l_pmep.pmep010,l_pmep.pmep011
           FROM pmep_t
          WHERE pmepent = g_enterprise
            AND pmepsite = g_site
            AND pmep001 = l_pmdy.pmdydocno
            AND pmep002 = l_pmdy.pmdyseq
            AND pmep003 =(SELECT MAX(pmep003) 
                            FROM pmep_t 
                           WHERE pmepent = g_enterprise
                             AND pmepsite = g_site
                             AND pmep001 = l_pmdy.pmdydocno
                             AND pmep002 = l_pmdy.pmdyseq)
         IF cl_null(l_pmep.pmep008) THEN LET l_pmep.pmep008 = 0 END IF
         IF cl_null(l_pmep.pmep009) THEN LET l_pmep.pmep009 = 0 END IF 
         IF cl_null(l_pmep.pmep010) THEN LET l_pmep.pmep010 = 0 END IF 
         IF cl_null(l_pmep.pmep011) THEN LET l_pmep.pmep011 = 0 END IF 
   
         LET l_pmep008 = l_pmep.pmep008
         
         #根据合约单号抓取相应的入庫單、無採購入庫單、倉退單
         LET ls_sql = " SELECT pmds000,pmds037,pmds038,pmds048,pmdtsite,pmdtdocno,pmdtseq,pmdt001,",
                      "        pmdt002,pmdt019,pmdt020,pmdt024,pmdt038,pmdt039,pmdt047,pmdt046,pmdt036,pmdspstdt ",
                      #"   FROM pmdt_t,pmds_t,pmdn_t ",   #160513-00010#1  mark
                      "   FROM pmdt_t,pmds_t ",   #160513-00010#1 add
                      "  WHERE pmdtent=pmdsent AND pmdtdocno=pmdsdocno ",
                      #"    AND pmdt001=pmdndocno AND pmdt002 = pmdnseq AND pmdtent=pmdnent ",  #160513-00010#1  mark
                      "    AND pmdsent = '",g_enterprise,"'",
                      #160513-00010#1---mod---begin
                      #"    AND pmdsstus='S' AND pmdn040 ='7' ",
                      #"    AND pmdn041 = '",l_pmdy.pmdydocno,"'",
                      ##"    AND pmdt006 = '",l_pmdy.pmdy002,"'",  #160127-00036#1 mark
                      #"    AND pmdn042 = '",l_pmdy.pmdyseq,"'",   #160127-00036#1 add
                      #"    AND pmds000 IN ('4','6','7') ",
                      "    AND pmdsstus='S' AND pmdt042 ='7' ",
                      "    AND pmdt043 = '",l_pmdy.pmdydocno,"'",
                      "    AND pmdt048 = '",l_pmdy.pmdyseq,"'", 
                      "    AND pmds000 IN ('3','4','6','7') ",                      
                      #160513-00010#1---mod---end
                      "    AND NOT EXISTS(SELECT * FROM pmeo_t WHERE pmeoent=pmdtent AND pmeosite=pmdtsite ",
                      #"                   AND pmeo001=pmdt043 AND pmeo003 = pmdtdocno AND pmeo004 = pmdtseq ) ",  #160513-00010#1  mark
                      "                   AND pmeo001=pmdt043 AND pmeo002 = pmdt048 AND pmeo003 = pmdtdocno AND pmeo004 = pmdtseq ) ",  #160513-00010#1 add
                      "  ORDER BY pmdspstdt "
         DECLARE apmp481_process_cs2 CURSOR FROM ls_sql
         FOREACH apmp481_process_cs2 INTO l_pmdt.*,l_pmdspstdt
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #逐筆計算當期的新增量、新增金額、累積量、累積金額等值
            IF l_pmdt.pmds000 = '7' THEN  #銷退是屬於減項
               LET l_pmep.pmep004  = l_pmep.pmep004 - l_pmdt.pmdt024
               LET l_pmep.pmep005  = l_pmep.pmep005 - l_pmdt.pmdt038
               LET l_pmep.pmep006  = l_pmep.pmep006 - l_pmdt.pmdt039
               LET l_pmep.pmep007  = l_pmep.pmep007 - l_pmdt.pmdt047
               LET l_pmep.pmep008  = l_pmep.pmep008 - l_pmdt.pmdt024
               LET l_pmep.pmep009  = l_pmep.pmep009 - l_pmdt.pmdt038
               LET l_pmep.pmep010  = l_pmep.pmep010 - l_pmdt.pmdt039
               LET l_pmep.pmep011  = l_pmep.pmep011 - l_pmdt.pmdt047
            ELSE
               LET l_pmep.pmep004  = l_pmep.pmep004 + l_pmdt.pmdt024
               LET l_pmep.pmep005  = l_pmep.pmep005 + l_pmdt.pmdt038
               LET l_pmep.pmep006  = l_pmep.pmep006 + l_pmdt.pmdt039
               LET l_pmep.pmep007  = l_pmep.pmep007 + l_pmdt.pmdt047
               LET l_pmep.pmep008  = l_pmep.pmep008 + l_pmdt.pmdt024
               LET l_pmep.pmep009  = l_pmep.pmep009 + l_pmdt.pmdt038
               LET l_pmep.pmep010  = l_pmep.pmep010 + l_pmdt.pmdt039
               LET l_pmep.pmep011  = l_pmep.pmep011 + l_pmdt.pmdt047
            END IF
            
            LET l_pmeo.pmeoent = g_enterprise
            LET l_pmeo.pmeosite = g_site
            LET l_pmeo.pmeo000 = '1'
            LET l_pmeo.pmeo001 = l_pmdy.pmdydocno
            LET l_pmeo.pmeo002 = l_pmdy.pmdyseq         
            LET l_pmeo.pmeo003 = l_pmdt.pmdtdocno
            LET l_pmeo.pmeo004 = l_pmdt.pmdtseq
            LET l_pmeo.pmeo005 = l_datetime
            LET l_pmeo.pmeo006 = l_pmdy.pmdy002
            LET l_pmeo.pmeo007 = l_pmdy.pmdy003          
            LET l_pmeo.pmeo008 = l_pmdt.pmdt020     #交易数量
            LET l_pmeo.pmeo009 = l_pmdt.pmdt019     #交易单位
            LET l_pmeo.pmeo010 = l_pmdt.pmdt036
            LET l_pmeo.pmeo011 = l_pmdt.pmdt038
            LET l_pmeo.pmeo012 = l_pmdt.pmdt039 
            LET l_pmeo.pmeo013 = l_pmdt.pmdt047 
            LET l_pmeo.pmeo014 = l_pmdt.pmdt038
            LET l_pmeo.pmeo015 = l_pmdt.pmdt039
            LET l_pmeo.pmeo016 = l_pmdt.pmdt047          
            LET l_pmeo.pmeo017 = 0
            LET l_pmeo.pmeo018 = 0
            LET l_pmeo.pmeo019 = 0 
            LET l_pmeo.pmeo020 = l_pmdt.pmdt036         
            LET l_pmeo.pmeo021  = 0 
            LET l_pmeo.pmeo022 = l_pmdt.pmdt001
            LET l_pmeo.pmeo023 = l_pmdt.pmdt002 
            LET l_pmeo.pmeo024 = l_pmdt.pmdtsite
            LET l_pmeo.pmeo025 = '0'
            IF g_master.chk = 'Y' THEN 
               LET l_pmeo.pmeo026 = g_master.pmeo026
               LET l_pmeo.pmeo027 = g_master.pmeo027  
               LET l_pmeo.pmeo028 = 1 
            ELSE
               LET l_pmeo.pmeo026 = ''
               LET l_pmeo.pmeo027 = ''  
               LET l_pmeo.pmeo028 = ''                    
            END IF 
   
            #交易单位换算成合约单单位后数量
            CALL s_aooi250_convert_qty(l_pmeo.pmeo006,l_pmeo.pmeo009,l_pmdy.pmdy008,l_pmeo.pmeo008) RETURNING g_success,l_qty
            ------------------
            IF l_pmdt.pmds000 = '7' THEN
               LET l_down = l_pmep008 - l_qty
               LET l_up = l_pmep008
            ELSE
               LET l_down = l_pmep008
               LET l_up = l_pmep008 + l_qty
            END IF
            ------------------
            LET l_dw_pmdz001 =''
            LET l_dw_pmdzseq1 =''
            LET l_up_pmdz001 =''
            LET l_up_pmdzseq1 =''
            EXECUTE apmp481_max USING l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_down,l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_down
                INTO l_dw_pmdz001,l_dw_pmdzseq1
            EXECUTE apmp481_max USING l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_up,l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_up
                INTO l_up_pmdz001,l_up_pmdzseq1    
            IF cl_null(l_dw_pmdz001) THEN LET l_dw_pmdz001 = 0 END IF
            IF cl_null(l_up_pmdz001) THEN LET l_up_pmdz001 = 0 END IF
            IF cl_null(l_dw_pmdzseq1) THEN LET l_dw_pmdzseq1 = 0 END IF
            IF cl_null(l_up_pmdzseq1) THEN LET l_up_pmdzseq1 = 0 END IF         
            #IF l_dw_pmdzseq1 <> l_up_pmdzseq1 THEN 
               IF l_dw_pmdzseq1 = 0 THEN
                  LET l_dw_price = l_pmdy.pmdy010
               ELSE
                  CALL apmp481_get_price(l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_dw_pmdzseq1,l_pmdy.pmdx005,l_pmdy.pmdx007,l_pmdy.pmdx008,l_pmdt.pmds037,l_pmdt.pmds048,l_pmdt.pmdt046)
                       RETURNING l_dw_price
               END IF         
               CALL s_tax_count(g_site,l_pmdt.pmdt046,((l_up_pmdz001-l_down)*l_dw_price),(l_up_pmdz001-l_down),l_pmdt.pmds037,l_pmdt.pmds038)
                    RETURNING l_xrcd103_1,l_xrcd104_1,l_xrcd105_1,l_xrcd113,l_xrcd114,l_xrcd115
               IF l_up_pmdzseq1 = 0 THEN
                  LET l_up_price = l_pmdy.pmdy010
               ELSE
                  CALL apmp481_get_price(l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_up_pmdzseq1,l_pmdy.pmdx005,l_pmdy.pmdx007,l_pmdy.pmdx008,l_pmdt.pmds037,l_pmdt.pmds048,l_pmdt.pmdt046)
                       RETURNING l_up_price 
               END IF                    
               CALL s_tax_count(g_site,l_pmdt.pmdt046,((l_up - l_up_pmdz001) * l_up_price),(l_up - l_up_pmdz001),l_pmdt.pmds037,l_pmdt.pmds038)
                    RETURNING l_xrcd103_2,l_xrcd104_2,l_xrcd105_2,l_xrcd113,l_xrcd114,l_xrcd115
               LET l_pmeo.pmeo014 = l_xrcd103_1 + l_xrcd103_2
               LET l_pmeo.pmeo016 = l_xrcd104_1 + l_xrcd104_2
               LET l_pmeo.pmeo015 = l_xrcd105_1 + l_xrcd105_2         
   
               #跨階
               LET l_pmdzseq1 = ''
               LET l_pmdz001 = ''
               LET l_pmdz001_t = l_up_pmdz001  #160420-00007#1
               FOREACH apmp481_process_sel_pmdz_cs USING l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_dw_pmdz001,l_up_pmdz001
                  INTO l_pmdzseq1,l_pmdz001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "FOREACH:" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     EXIT FOREACH
                  END IF
                  CALL apmp481_get_price(l_pmdy.pmdydocno,l_pmdy.pmdyseq,l_pmdzseq1,l_pmdy.pmdx005,l_pmdy.pmdx007,l_pmdy.pmdx008,l_pmdt.pmds037,l_pmdt.pmds048,l_pmdt.pmdt046)
                       RETURNING l_price                 
                  #CALL s_tax_count(g_site,l_pmdt.pmdt046,((l_up_pmdz001-l_pmdz001)*l_price),(l_up_pmdz001-l_pmdz001),l_pmdt.pmds037,l_pmdt.pmds038)   #160420-00007#1
                  CALL s_tax_count(g_site,l_pmdt.pmdt046,((l_pmdz001_t-l_pmdz001)*(l_dw_price-l_price)),(l_up_pmdz001-l_pmdz001),l_pmdt.pmds037,l_pmdt.pmds038)   #160420-00007#1
                       RETURNING l_xrcd103,l_xrcd104,l_xrcd105,l_xrcd113,l_xrcd114,l_xrcd115
                  LET l_pmeo.pmeo014 = l_pmeo.pmeo014 + l_xrcd103
                  LET l_pmeo.pmeo016 = l_pmeo.pmeo016 + l_xrcd104
                  LET l_pmeo.pmeo015 = l_pmeo.pmeo015 + l_xrcd105
                  #LET l_up = l_pmdz001   #160420-00007#1
                  LET l_pmdz001_t = l_pmdz001   #160420-00007#1
               END FOREACH
               #若不一樣則須在pmeo_t中的建議調整單價、金額等欄位紀錄新的單價與金額，並計算新金額與來源單據的原始金額的差異
               IF l_pmeo.pmeo014 <> l_pmeo.pmeo011 THEN
                  LET l_pmeo.pmeo025  = '1'  #未處理
                  LET l_pmeo.pmeo020  = l_up_price
                  #LET l_pmeo.pmeo021  = l_up - l_up_pmdz001    #160420-00007#1
                  LET l_pmeo.pmeo021  = l_up_pmdz001 - l_dw_pmdz001    #160420-00007#1
#                  LET l_pmeo.pmeo017 = l_pmeo.pmeo011 - l_pmeo.pmeo014
#                  LET l_pmeo.pmeo018 = l_pmeo.pmeo012 - l_pmeo.pmeo015
#                  LET l_pmeo.pmeo019 = l_pmeo.pmeo013 - l_pmeo.pmeo016
                  IF l_pmdt.pmds000 = '7' THEN
                     LET l_pmeo.pmeo017 = l_pmeo.pmeo014 - l_pmeo.pmeo011 
                     LET l_pmeo.pmeo018 = l_pmeo.pmeo015 - l_pmeo.pmeo012 
                     LET l_pmeo.pmeo019 = l_pmeo.pmeo016 - l_pmeo.pmeo013 
                  ELSE
                     LET l_pmeo.pmeo017 = l_pmeo.pmeo011 - l_pmeo.pmeo014
                     LET l_pmeo.pmeo018 = l_pmeo.pmeo012 - l_pmeo.pmeo015
                     LET l_pmeo.pmeo019 = l_pmeo.pmeo013 - l_pmeo.pmeo016
                  END IF                  
               END IF            
            #END IF
       
            INSERT INTO pmeo_t(pmeoent,pmeosite,pmeo000,pmeo001,pmeo002,
                               pmeo003,pmeo004,pmeo005,pmeo006,pmeo007,
                               pmeo008,pmeo009,pmeo010,pmeo011,pmeo012,
                               pmeo013,pmeo014,pmeo015,pmeo016,pmeo017,
                               pmeo018,pmeo019,pmeo020,pmeo021,pmeo022,
                               pmeo023,pmeo024,pmeo025,pmeo026,pmeo027,
                               pmeo028)
                       VALUES(l_pmeo.pmeoent,l_pmeo.pmeosite,l_pmeo.pmeo000,l_pmeo.pmeo001,l_pmeo.pmeo002,
                              l_pmeo.pmeo003,l_pmeo.pmeo004,l_pmeo.pmeo005,l_pmeo.pmeo006,l_pmeo.pmeo007,
                              l_pmeo.pmeo008,l_pmeo.pmeo009,l_pmeo.pmeo010,l_pmeo.pmeo011,l_pmeo.pmeo012,
                              l_pmeo.pmeo013,l_pmeo.pmeo014,l_pmeo.pmeo015,l_pmeo.pmeo016,l_pmeo.pmeo017,
                              l_pmeo.pmeo018,l_pmeo.pmeo019,l_pmeo.pmeo020,l_pmeo.pmeo021,l_pmeo.pmeo022,
                              l_pmeo.pmeo023,l_pmeo.pmeo024,l_pmeo.pmeo025,l_pmeo.pmeo026,l_pmeo.pmeo027,
                              l_pmeo.pmeo028) 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "INSERT pmeo_t:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            IF g_master.chk = 'Y' AND (l_pmeo.pmeo017 <> 0 OR l_pmeo.pmeo018<>0) THEN
               CALL s_apmp482_upd_pmds('Y',l_pmeo.pmeo001,l_pmeo.pmeo002,l_pmeo.pmeo003,l_pmeo.pmeo004,
                                       l_pmeo.pmeo006,l_pmeo.pmeo017,l_pmeo.pmeo018,
                                        g_master.pmeo026,g_master.imaf001,g_master.pmdt051)
            END IF
            LET l_pmep008 = l_pmep.pmep008
         END FOREACH
             
         INSERT INTO pmep_t(pmepent,pmepsite,pmep001,pmep002,pmep003,pmep004,pmep005,pmep006,pmep007,
                            pmep008,pmep009,pmep010,pmep011,pmep012,pmep013)
                     VALUES(l_pmep.pmepent,l_pmep.pmepsite,l_pmep.pmep001,l_pmep.pmep002,l_pmep.pmep003,
                            l_pmep.pmep004,l_pmep.pmep005,l_pmep.pmep006,l_pmep.pmep007,l_pmep.pmep008,
                            l_pmep.pmep009,l_pmep.pmep010,l_pmep.pmep011,l_pmep.pmep012,l_pmep.pmep013) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INSERT pmep_t:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
       
      END FOREACH
      
      IF g_master.chk = 'Y' THEN
         CALL s_apmp482(g_master.pmeo027,'1') RETURNING l_pmdsdocno
         IF NOT cl_null(l_pmdsdocno) THEN 
            LET l_success = TRUE
            IF cl_null(l_str) THEN
               LET l_str = " pmdsdocno IN('",l_pmdsdocno,"'"
            ELSE
               LET l_str = l_str,",'",l_pmdsdocno,"' "
            END IF
         END IF         
      END IF 
      IF g_success THEN 
         CALL s_transaction_end('Y','0') 
      ELSE
         CALL s_transaction_end('N','0') 
      END IF
      DELETE FROM apmp482_pmeo;
      DELETE FROM apmp482_detail_pmds;
      DELETE FROM apmp482_detail_pmdt; 
   END FOREACH      
   
   CALL cl_err_collect_show()
   
   IF l_success THEN
      IF NOT cl_null(l_str) THEN
         LET l_str = l_str,")"
         LET la_param.prog = 'apmt580'
         LET la_param.param[4] = l_str
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
   END IF 
   IF li_count = 0 THEN 
      CALL cl_ask_confirm3("sub-00491","")
      RETURN
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
   CALL apmp481_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp481.get_buffer" >}
PRIVATE FUNCTION apmp481_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
   LET g_master.pmeo026 = p_dialog.getFieldBuffer('pmeo026')
   LET g_master.pmeo027 = p_dialog.getFieldBuffer('pmeo027')
   LET g_master.pmdt051 = p_dialog.getFieldBuffer('pmdt051')
   LET g_master.imaf001 = p_dialog.getFieldBuffer('imaf001')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmp481.msgcentre_notify" >}
PRIVATE FUNCTION apmp481_msgcentre_notify()
 
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
 
{<section id="apmp481.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp481_reason_ref(p_pmdt051)
DEFINE p_pmdt051    LIKE pmdt_t.pmdt051
DEFINE r_oocql004   LIKE oocql_t.oocql004

   LET r_oocql004 = ''
   SELECT oocql004 INTO r_oocql004
     FROM oocql_t
    WHERE oocqlent = g_enterprise
      AND oocql001 = g_acc
      AND oocql002 = p_pmdt051
      AND oocql003 = g_dlang
   
   RETURN r_oocql004
END FUNCTION

################################################################################
# Descriptions...: 有累積量定價
# Memo...........:
# Usage..........: CALL apmp481_get_price(p_pmdzdocno,p_pmdzseq,p_pmdzseq1,p_pmdx005,p_pmdx007,p_pmdx008,p_curr,p_export,p_tax)
#                  RETURNING r_price
# Input parameter: p_pmdzdocno   合約單號
#                : p_pmdzseq     項次
#                : p_pmdzseq1    項序
#                : p_pmdx005     幣別
#                : p_pmdx007     稅率
#                : p_pmdx008     單價含稅否
#                : p_curr        幣別
#                : p_export      內外購
#                : p_tax         稅別
# Return code....: r_price       單價
# Date & Author..: 2015/05/12 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp481_get_price(p_pmdzdocno,p_pmdzseq,p_pmdzseq1,p_pmdx005,p_pmdx007,p_pmdx008,p_curr,p_export,p_tax)
DEFINE p_pmdzdocno  LIKE pmdz_t.pmdzdocno
DEFINE p_pmdzseq    LIKE pmdz_t.pmdzseq
DEFINE p_pmdzseq1   LIKE pmdz_t.pmdzseq1
DEFINE p_pmdx005    LIKE pmdx_t.pmdx005
DEFINE p_pmdx007    LIKE pmdx_t.pmdx007
DEFINE p_pmdx008    LIKE pmdx_t.pmdx008
DEFINE p_curr       LIKE pmdx_t.pmdx005
DEFINE p_export     LIKE pmds_t.pmds048
DEFINE p_tax        LIKE pmdx_t.pmdx006
DEFINE r_price      LIKE pmdy_t.pmdy010
DEFINE l_pmdz002    LIKE pmdz_t.pmdz002
DEFINE l_pmdz003    LIKE pmdz_t.pmdz003
DEFINE l_oodb005    LIKE oodb_t.oodb005
DEFINE l_oodb006    LIKE oodb_t.oodb006
DEFINE l_scc40      LIKE type_t.chr2
DEFINE l_rate       LIKE ooan_t.ooan005

   LET r_price = ''
   
   LET l_pmdz002 = ''
   LET l_pmdz003 = ''
   SELECT pmdz002,pmdz003
    INTO l_pmdz002,l_pmdz003
     FROM pmdz_t
    WHERE pmdzent = g_enterprise
      AND pmdzsite = g_site
      AND pmdzdocno = p_pmdzdocno
      AND pmdzseq = p_pmdzseq
      AND pmdzseq1 = p_pmdzseq1
   IF NOT cl_null(l_pmdz002) THEN
      IF cl_null(l_pmdz003) THEN LET l_pmdz003 = 0 END IF
      LET r_price = l_pmdz002 * (1 - l_pmdz003/100)
   END IF
   
   IF cl_null(r_price) THEN
      RETURN r_price
   END IF
   
   LET l_oodb005 = ''
   LET l_oodb006 = ''
   SELECT oodb005,oodb006 INTO l_oodb005,l_oodb006
     FROM oodb_t,ooef_t
    WHERE oodb002 = p_tax
      AND oodb001 = ooef019
      AND oodbent = ooefent
      AND oodbent = g_enterprise
      AND ooef001 = g_site
   #若取到的合約稅別的單價含稅否與稅率與傳入的稅別不一樣時，需對單價進行轉換
   IF p_pmdx007 <> l_oodb006 OR p_pmdx008 <> l_oodb005 THEN
      IF p_pmdx008 = 'Y' THEN  #單價含稅否
         LET r_price = r_price / (1 + p_pmdx007/100)
      END IF
      IF l_oodb005 = 'Y' THEN
         LET r_price = r_price * (1 + l_oodb006/100)
      END IF
   END IF
   
   #若取到的合約單幣別與傳入幣別不一樣時，需對取到的單價進行匯率轉換
   IF p_pmdx005 <> p_curr THEN
      CASE p_export
         WHEN '1'  #內購外幣採用匯率類型
            CALL cl_get_para(g_enterprise,g_site,'S-BAS-0014') RETURNING l_scc40
         WHEN '2'  #外購外幣採用匯率類型
            CALL cl_get_para(g_enterprise,g_site,'S-BAS-0015') RETURNING l_scc40
         OTHERWISE EXIT CASE
      END CASE
      LET l_rate = ''
      CALL s_aooi160_get_exrate('1',g_site,g_today,p_pmdx005,p_curr,0,l_scc40) RETURNING l_rate
      IF NOT cl_null(l_rate) THEN
         LET r_price = r_price * l_rate
      END IF
   END IF
   CALL s_curr_round(g_site,p_curr,r_price,'1') RETURNING r_price

   RETURN r_price
END FUNCTION

#end add-point
 
{</section>}
 
