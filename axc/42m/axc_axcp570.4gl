#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp570.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-04-16 13:35:05), PR版次:0003(2016-06-28 14:42:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: axcp570
#+ Description: 資源標準費率批量修改作業
#+ Creator....: 05426(2015-04-14 16:55:44)
#+ Modifier...: 05426 -SD/PR- 02040
 
{</section>}
 
{<section id="axcp570.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00005#46  20160328   by pengxin  修正azzi920重复定义之错误讯息
#160328-00022#8   20160628   By 02040    增加progressbar顯示計算進度條
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
       xcac001 LIKE xcac_t.xcac001, 
   xcacsite LIKE xcac_t.xcacsite, 
   xcacsite_desc LIKE type_t.chr80, 
   xcac002 LIKE type_t.chr20, 
   xcac002_desc LIKE type_t.chr80, 
   xcac004 LIKE xcac_t.xcac004, 
   xcac004_desc LIKE type_t.chr80, 
   mrba010 LIKE mrba_t.mrba010, 
   mrba010_desc LIKE type_t.chr80, 
   fixed LIKE type_t.num20_6, 
   mrba024 LIKE mrba_t.mrba024, 
   percent LIKE type_t.num20_6, 
   xcac003 LIKE xcac_t.xcac003, 
   amount LIKE type_t.num20_6, 
   stagenow LIKE type_t.chr80,
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

#end add-point
 
{</section>}
 
{<section id="axcp570.main" >}
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
      CALL axcp570_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp570 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp570_init()
 
      #進入選單 Menu (="N")
      CALL axcp570_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp570
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp570.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp570_init()
 
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
   CALL cl_set_combo_scc_part('xcac003','8901','2,3,4,5,6,7,8')
   CALL cl_set_combo_scc('mrba024','5204')
   CALL cl_set_comp_required('xcac002',FALSE)   #画面档已设置为非必要栏位和可为空栏位，但程序运行时还是会提示栏位不能为空，所以强制转化
   LET g_master.xcac003=''    #栏位初始值在不做任何操作时候，画面显示为空，但实际值不为空
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp570.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp570_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcac002,g_master.xcac004,g_master.mrba010,g_master.fixed,g_master.mrba024, 
             g_master.percent,g_master.xcac003,g_master.amount 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.xcac003=''
               CALL cl_set_comp_required('xcac002',FALSE)
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac002
            
            #add-point:AFTER FIELD xcac002 name="input.a.xcac002"
            IF NOT cl_null(g_master.xcac002) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mrba_t
                WHERE mrbaent = g_enterprise AND mrba001 = g_master.xcac002
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amr-00001'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD xcac002
               END IF               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mrba_t
                WHERE mrbaent = g_enterprise AND mrba001 =g_master.xcac002
                  AND mrbastus = 'Y'                
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'amr-00004'  #160318-00005#46  mark
                  LET g_errparam.code = 'sub-01302'   #160318-00005#46  add
                  LET g_errparam.extend = ''
                  #160318-00005#46 --s add
                  LET g_errparam.replace[1] = 'amrm200'
                  LET g_errparam.replace[2] = cl_get_progname('amrm200',g_lang,"2")
                  LET g_errparam.exeprog = 'amrm200'
                  #160318-00005#46 --e add
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD xcac002
               END IF 
            END IF
            #资源编码说明
            SELECT mrba004 INTO g_master.xcac002_desc FROM mrba_t 
            WHERE mrbaent = g_enterprise AND mrba001 = g_master.xcac002 AND mrbastus='Y'
            DISPLAY BY NAME g_master.xcac002_desc
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.xcacsite
#            LET g_ref_fields[2] = g_master.xcac002
#            CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mabasite=? AND mrba001=? ","") RETURNING g_rtn_fields
#            LET g_master.xcac002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_master.xcac002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac002
            #add-point:BEFORE FIELD xcac002 name="input.b.xcac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac002
            #add-point:ON CHANGE xcac002 name="input.g.xcac002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac004
            
            #add-point:AFTER FIELD xcac004 name="input.a.xcac004"
            IF NOT cl_null(g_master.xcac004) THEN
               LET g_master.xcac003=''
               CALL cl_set_comp_entry("xcac003",FALSE)

               IF NOT axcp570_xcac004_chk(g_master.xcac004) THEN
                  NEXT FIELD xcac004
               END IF
            ELSE 
               CALL cl_set_comp_entry("xcac003",TRUE)
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.xcac004
            CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.xcac004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.xcac004_desc            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac004
            #add-point:BEFORE FIELD xcac004 name="input.b.xcac004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac004
            #add-point:ON CHANGE xcac004 name="input.g.xcac004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba010
            
            #add-point:AFTER FIELD mrba010 name="input.a.mrba010"
            IF NOT cl_null(g_master.mrba010) THEN 
            
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mrba_t
                WHERE mrbaent = g_enterprise AND mrba010 = g_master.mrba010
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amr-00001'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD mrba010
               END IF               
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mrba_t
                WHERE mrbaent = g_enterprise AND mrba010 =g_master.mrba010
                  AND mrbastus = 'Y'                
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'amr-00004'   #160318-00005#46 mark
                  LET g_errparam.code = 'sub-01302'    #160318-00005#46 add
                  LET g_errparam.extend = ''
                  #160318-00005#46 --s add
                  LET g_errparam.replace[1] = 'amrm200'
                  LET g_errparam.replace[2] = cl_get_progname('amrm200',g_lang,"2")
                  LET g_errparam.exeprog = 'amrm200'
                  #160318-00005#46 --e add
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD mrba010
               END IF              
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.mrba010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.mrba010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.mrba010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba010
            #add-point:BEFORE FIELD mrba010 name="input.b.mrba010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba010
            #add-point:ON CHANGE mrba010 name="input.g.mrba010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fixed
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.fixed,"0","1","","","azz-00079",1) THEN
               NEXT FIELD fixed
            END IF 
 
 
 
            #add-point:AFTER FIELD fixed name="input.a.fixed"
            IF NOT cl_null(g_master.fixed) THEN
               LET g_master.percent=''      
               LET g_master.amount=''               
               CALL cl_set_comp_entry("percent,amount",FALSE)
            ELSE 
               CALL cl_set_comp_entry("percent,amount",TRUE)
            END IF 



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fixed
            #add-point:BEFORE FIELD fixed name="input.b.fixed"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fixed
            #add-point:ON CHANGE fixed name="input.g.fixed"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba024
            #add-point:BEFORE FIELD mrba024 name="input.b.mrba024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba024
            
            #add-point:AFTER FIELD mrba024 name="input.a.mrba024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba024
            #add-point:ON CHANGE mrba024 name="input.g.mrba024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD percent
            #add-point:BEFORE FIELD percent name="input.b.percent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD percent
            
            #add-point:AFTER FIELD percent name="input.a.percent"
            IF NOT cl_null(g_master.percent) THEN              
               CALL cl_set_comp_entry("fixed,amount",FALSE)
            ELSE 
               CALL cl_set_comp_entry("fixed,amount",TRUE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE percent
            #add-point:ON CHANGE percent name="input.g.percent"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac003
            #add-point:BEFORE FIELD xcac003 name="input.b.xcac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac003
            
            #add-point:AFTER FIELD xcac003 name="input.a.xcac003"
            IF NOT cl_null(g_master.xcac003) THEN 
               LET g_master.xcac004=''
               CALL cl_set_comp_entry("xcac004",FALSE)
            ELSE
               CALL cl_set_comp_entry("xcac004",TRUE)            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac003
            #add-point:ON CHANGE xcac003 name="input.g.xcac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD amount
            #add-point:BEFORE FIELD amount name="input.b.amount"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD amount
            
            #add-point:AFTER FIELD amount name="input.a.amount"
            IF NOT cl_null(g_master.amount) THEN              
               CALL cl_set_comp_entry("fixed,percent",FALSE)
            ELSE 
               CALL cl_set_comp_entry("fixed,percent",TRUE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE amount
            #add-point:ON CHANGE amount name="input.g.amount"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac002
            #add-point:ON ACTION controlp INFIELD xcac002 name="input.c.xcac002"
             #add-point:ON ACTION controlp INFIELD xcac002
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcac002             #給予default值
            LET g_qryparam.default2 = "" #g_master.mrba001 #資源編號/車輛編號
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_mrba001_3()                                #呼叫開窗

            LET g_master.xcac002 = g_qryparam.return1              
            #LET g_master.mrba001 = g_qryparam.return2 
            DISPLAY g_master.xcac002 TO xcac002              #
            #DISPLAY g_master.mrba001 TO mrba001 #資源編號/車輛編號
            NEXT FIELD xcac002                         #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcac004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac004
            #add-point:ON ACTION controlp INFIELD xcac004 name="input.c.xcac004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xcac004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_xcau001()                                #呼叫開窗

            LET g_master.xcac004 = g_qryparam.return1              

            DISPLAY g_master.xcac004 TO xcac004              #

            NEXT FIELD xcac004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba010
            #add-point:ON ACTION controlp INFIELD mrba010 name="input.c.mrba010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "1101" #
            CALL q_oocq002()                                #呼叫開窗
            LET g_master.mrba010 = g_qryparam.return1              
            #LET g_master.oocql004 = g_qryparam.return2 
            DISPLAY g_master.mrba010 TO mrba010              #
            #DISPLAY g_master.oocql004 TO oocql004 #說明
            NEXT FIELD mrba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fixed
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fixed
            #add-point:ON ACTION controlp INFIELD fixed name="input.c.fixed"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba024
            #add-point:ON ACTION controlp INFIELD mrba024 name="input.c.mrba024"
            
            #END add-point
 
 
         #Ctrlp:input.c.percent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD percent
            #add-point:ON ACTION controlp INFIELD percent name="input.c.percent"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac003
            #add-point:ON ACTION controlp INFIELD xcac003 name="input.c.xcac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.amount
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD amount
            #add-point:ON ACTION controlp INFIELD amount name="input.c.amount"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF cl_null(g_master.xcac002) AND cl_null(g_master.mrba010) AND  cl_null(g_master.mrba024) AND cl_null(g_master.xcac004) AND cl_null(g_master.xcac003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00684'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcac002
               END IF
               IF cl_null(g_master.percent) AND cl_null(g_master.fixed) AND  cl_null(g_master.amount) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00686'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fixed           
               END IF 
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xcac001,xcacsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xcac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac001
            #add-point:ON ACTION controlp INFIELD xcac001 name="construct.c.xcac001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcac001  #顯示到畫面上
            NEXT FIELD xcac001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac001
            #add-point:BEFORE FIELD xcac001 name="construct.b.xcac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac001
            
            #add-point:AFTER FIELD xcac001 name="construct.a.xcac001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcacsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcacsite
            #add-point:ON ACTION controlp INFIELD xcacsite name="construct.c.xcacsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcacsite  #顯示到畫面上
            NEXT FIELD xcacsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcacsite
            #add-point:BEFORE FIELD xcacsite name="construct.b.xcacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcacsite
            
            #add-point:AFTER FIELD xcacsite name="construct.a.xcacsite"
            
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
            CALL axcp570_get_buffer(l_dialog)
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
         CALL axcp570_init()
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
                 CALL axcp570_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp570_transfer_argv(ls_js)
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
 
{<section id="axcp570.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp570_transfer_argv(ls_js)
 
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
 
{<section id="axcp570.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp570_process(ls_js)
 
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
   DEFINE l_success_1   LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #160328-00022#8-s-add
   CALL axcp570_input_chk() RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   IF cl_null(g_wc) THEN LET g_wc = ' 1=1' END IF
   IF cl_null(g_master.wc) THEN LET g_master.wc = ' 1=1' END IF
   LET ls_sql = "SELECT COUNT(*) ",
                "  FROM xcac_t LEFT JOIN mrba_t ON mrbaent = xcacent AND mrbasite = xcacsite AND mrba001 = xcac002 ",
                " WHERE xcacent = ",g_enterprise," AND xcacstus='N' AND ",g_wc CLIPPED ," AND ",g_master.wc CLIPPED
   PREPARE axcp570_count_pre FROM ls_sql
   DECLARE axcp570_count_cur CURSOR WITH HOLD FOR axcp570_count_pre
   LET li_count = 0
   OPEN axcp570_count_cur
   FETCH axcp570_count_cur INTO li_count
   CLOSE axcp570_count_cur   
   #160328-00022#8-e-add
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count)   #160328-00022#8
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp570_process_cs CURSOR FROM ls_sql
#  FOREACH axcp570_process_cs INTO
   #add-point:process段process name="process.process"
   #CALL axcp570_input_chk() RETURNING l_success  #160328-00022#8 mark
   #IF l_success THEN                             #160328-00022#8 mark
    CALL axcp570_update_xcac() RETURNING l_success_1
    IF l_success_1 THEN
       INITIALIZE g_master.* TO NULL
       DISPLAY BY NAME g_master.*
       CALL cl_set_comp_entry("xcac004,xcac003,percent,fixed,amount",TRUE) 
    END IF
   #160328-00022#8-s-mark
   #ELSE 
   #  RETURN      
   #END IF
   #160328-00022#8-e-mark
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
   CALL axcp570_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp570.get_buffer" >}
PRIVATE FUNCTION axcp570_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcac002 = p_dialog.getFieldBuffer('xcac002')
   LET g_master.xcac004 = p_dialog.getFieldBuffer('xcac004')
   LET g_master.mrba010 = p_dialog.getFieldBuffer('mrba010')
   LET g_master.fixed = p_dialog.getFieldBuffer('fixed')
   LET g_master.mrba024 = p_dialog.getFieldBuffer('mrba024')
   LET g_master.percent = p_dialog.getFieldBuffer('percent')
   LET g_master.xcac003 = p_dialog.getFieldBuffer('xcac003')
   LET g_master.amount = p_dialog.getFieldBuffer('amount')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp570.msgcentre_notify" >}
PRIVATE FUNCTION axcp570_msgcentre_notify()
 
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
 
{<section id="axcp570.other_function" readonly="Y" >}
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
PRIVATE FUNCTION axcp570_xcac004_chk(p_xcac004)
DEFINE  l_n             LIKE type_t.num5  
DEFINE  p_xcac004       LIKE xcac_t.xcac004
DEFINE  r_success       LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_xcac004) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcac004,"SELECT COUNT(*) FROM xcau_t WHERE xcauent = '"
            ||g_enterprise||"' AND xcau001 = ? ","axc-00055",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_xcac004,"SELECT COUNT(*) FROM xcau_t WHERE xcauent = '"
#            ||g_enterprise||"' AND xcau001 = ? AND xcaustus = 'Y' ","axc-00056",0 ) THEN    #160318-00005#46  mark
            ||g_enterprise||"' AND xcau001 = ? AND xcaustus = 'Y' ","sub-01302",'axci111') THEN     #160318-00005#46  add
            LET r_success = FALSE
         END IF
      END IF
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
PRIVATE FUNCTION axcp570_input_chk()
DEFINE r_success               LIKE type_t.num5
DEFINE l_sql                   STRING 
DEFINE l_n                     LIKE type_t.num5
   LET r_success = FALSE
   IF cl_null(g_master.xcac002) AND cl_null(g_master.mrba010) AND  cl_null(g_master.mrba024) AND cl_null(g_master.xcac004) AND cl_null(g_master.xcac003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00684'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   IF cl_null(g_master.percent) AND cl_null(g_master.fixed) AND  cl_null(g_master.amount) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00686'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      RETURN r_success      
   END IF 

   LET g_wc=" 1=1 "
   LET l_sql = "SELECT COUNT(*) FROM xcac_t LEFT JOIN mrba_t ON mrbaent=xcacent AND mrbasite=xcacsite AND mrba001=xcac002
      WHERE xcacstus='N' AND xcacent = ",g_enterprise
  
   IF NOT cl_null(g_master.xcac002) THEN
      LET g_wc=g_wc," AND xcac002 = '",g_master.xcac002,"'"
   END IF
   IF NOT cl_null(g_master.mrba010) THEN
      LET g_wc = g_wc," AND mrba010 = '",g_master.mrba010,"'"
   END IF
   IF NOT cl_null(g_master.mrba024) THEN
      LET g_wc = g_wc," AND mrba024 = '",g_master.mrba024,"'"
   END IF
   IF NOT cl_null(g_master.xcac003) THEN
      LET g_wc = g_wc," AND xcac003 = '",g_master.xcac003,"'"
   END IF
   IF NOT cl_null(g_master.xcac004) THEN
      LET g_wc = g_wc," AND xcac004 = '",g_master.xcac004,"'"
   END IF
   LET l_sql=l_sql," AND ",g_wc ," AND ",g_master.wc
   PREPARE axcp570_input_chk_pre FROM l_sql
   EXECUTE axcp570_input_chk_pre INTO l_n
   
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00685'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   LET r_success = TRUE
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
PRIVATE FUNCTION axcp570_update_xcac()
DEFINE l_sql         STRING
DEFINE l_xcac001       LIKE xcac_t.xcac001
DEFINE l_xcac002       LIKE xcac_t.xcac002
DEFINE l_xcac003       LIKE xcac_t.xcac003
DEFINE l_xcac004       LIKE xcac_t.xcac004
DEFINE l_xcac006       LIKE xcac_t.xcac004
DEFINE l_success       LIKE type_t.num5
#160328-00022#8-s-add
DEFINE l_str           STRING           
DEFINE l_str1          STRING   
DEFINE l_str2          STRING   
DEFINE l_msg           STRING
#160328-00022#8-s-add

   LET l_success=TRUE
   LET l_sql=" SELECT xcac001,xcac002,xcac003,xcac004,xcac006 FROM xcac_t LEFT JOIN mrba_t ON mrbaent=xcacent AND mrbasite=xcacsite AND mrba001=xcac002",
            " WHERE xcacstus='N' AND  xcacent=? AND ",g_wc CLIPPED ," AND ",g_master.wc CLIPPED

   PREPARE axcp570_pb_upd FROM l_sql
   DECLARE axcp570_pb_upd_cs CURSOR FOR axcp570_pb_upd
   OPEN axcp570_pb_upd_cs USING g_enterprise
   CALL s_transaction_begin()  #事务开始
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   FOREACH axcp570_pb_upd_cs INTO l_xcac001,l_xcac002,l_xcac003,l_xcac004,l_xcac006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success=FALSE
         EXIT FOREACH
      END IF
      #160328-00022#8-s-add
      IF g_bgjob <> "Y" THEN 
         LET l_str1 = l_xcac001
         LET l_str2 = l_xcac002
         LET l_str = l_str1.trim(),'|',l_str2.trim()         
         LET l_msg = cl_getmsg_parm("axc-00778",g_lang,l_str )             
         CALL cl_progress_no_window_ing(l_msg)                                            
      END IF      
      #160328-00022#8-e-add
      #固定金额
      IF NOT cl_null(g_master.fixed) AND cl_null(g_master.percent) AND cl_null(g_master.amount) THEN
         UPDATE xcac_t SET xcac006=g_master.fixed WHERE xcacent=g_enterprise AND xcac002=l_xcac002 AND xcac001=l_xcac001
      END IF 
      #变更百分比
      IF cl_null(g_master.fixed) AND NOT cl_null(g_master.percent) AND cl_null(g_master.amount) THEN
         UPDATE xcac_t SET xcac006=l_xcac006*(1+g_master.percent) WHERE xcacent=g_enterprise AND xcac002=l_xcac002 AND xcac001=l_xcac001
      END IF
      #变更金额
      IF cl_null(g_master.fixed) AND cl_null(g_master.percent) AND NOT cl_null(g_master.amount) THEN
         UPDATE xcac_t SET xcac006=l_xcac006+g_master.amount WHERE xcacent=g_enterprise AND xcac002=l_xcac002 AND xcac001=l_xcac001
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE:",l_xcac001,"-",l_xcac002
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success=FALSE
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      END IF      
   END FOREACH 
   CALL cl_err_collect_show()
   CALL s_transaction_end('Y','0')
   RETURN l_success
END FUNCTION

#end add-point
 
{</section>}
 
