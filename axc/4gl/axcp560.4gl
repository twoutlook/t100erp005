#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp560.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-07-22 10:43:40), PR版次:0001(2016-07-28 16:41:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: axcp560
#+ Description: 材料標準成本批量修改作業
#+ Creator....: 02040(2016-07-22 10:43:40)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axcp560.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
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
       xcab001 LIKE type_t.chr10, 
   change_type LIKE type_t.chr5, 
   imaa001 LIKE type_t.chr500, 
   imag011 LIKE type_t.chr10, 
   imaa003 LIKE type_t.chr10, 
   xcax002 LIKE type_t.chr10, 
   price LIKE type_t.chr2, 
   pmdnsite LIKE type_t.chr10, 
   pmdnsite_desc LIKE type_t.chr80, 
   real_cost LIKE type_t.chr500, 
   xcccld LIKE type_t.chr5, 
   xcccld_desc LIKE type_t.chr80, 
   xccc002 LIKE type_t.chr30, 
   xccc002_desc LIKE type_t.chr80, 
   xccc003 LIKE type_t.chr10, 
   xccc003_desc LIKE type_t.chr80, 
   xccc004 LIKE type_t.num5, 
   xccc005 LIKE type_t.num5, 
   standard LIKE type_t.chr500, 
   xcab001_1 LIKE type_t.chr10, 
   per LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp560.main" >}
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
      CALL axcp560_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp560 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp560_init()
 
      #進入選單 Menu (="N")
      CALL axcp560_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp560
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp560.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp560_init()
 
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
   CALL cl_set_combo_scc("change_type","9981")
   LET g_master.change_type = '1'
   LET g_master.price = 'Y'
   LET g_master.pmdnsite = g_site 
   CALL s_desc_get_department_desc(g_master.pmdnsite) RETURNING g_master.pmdnsite_desc
   DISPLAY BY NAME g_master.pmdnsite_desc
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('lbl_xccc002,xccc002',FALSE)
   END IF
   LET g_master.xccc004 = ''
   LET g_master.xccc005 = ''
   CALL axcp560_set_entry_b()
   CALL axcp560_set_no_entry_b()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp560.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp560_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_xccccomp LIKE xccc_t.xccccomp
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcab001,g_master.change_type,g_master.price,g_master.pmdnsite,g_master.real_cost, 
             g_master.xcccld,g_master.xccc002,g_master.xccc003,g_master.xccc004,g_master.xccc005,g_master.standard, 
             g_master.xcab001_1,g_master.per 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcab001
            
            #add-point:AFTER FIELD xcab001 name="input.a.xcab001"
            IF NOT cl_null(g_master.xcab001) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.arg1 = g_master.xcab001  
               LET g_chkparam.where = " xcabsite = '",g_site,"' "               
               IF NOT cl_chk_exist("v_xcab001_1") THEN
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcab001
            #add-point:BEFORE FIELD xcab001 name="input.b.xcab001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcab001
            #add-point:ON CHANGE xcab001 name="input.g.xcab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD change_type
            #add-point:BEFORE FIELD change_type name="input.b.change_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD change_type
            
            #add-point:AFTER FIELD change_type name="input.a.change_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE change_type
            #add-point:ON CHANGE change_type name="input.g.change_type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD price
            #add-point:BEFORE FIELD price name="input.b.price"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD price
            
            #add-point:AFTER FIELD price name="input.a.price"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE price
            #add-point:ON CHANGE price name="input.g.price"
            IF g_master.price = 'Y' THEN
               LET g_master.real_cost = ''
               LET g_master.standard = ''
               LET g_master.pmdnsite = g_site
               CALL s_desc_get_department_desc(g_master.pmdnsite) RETURNING g_master.pmdnsite_desc
               LET g_master.xcccld = ''
               LET g_master.xcccld_desc = ''
               LET g_master.xccc003 = ''
               LET g_master.xccc003_desc = ''
               LET g_master.xccc004 = ''
               LET g_master.xccc005 = ''
               LET g_master.xccc002 = ''
               LET g_master.xccc002_desc = ''
               LET g_master.xcab001_1 = ''               
            ELSE
               LET g_master.price = ''
               LET g_master.pmdnsite = ''    
               LET g_master.pmdnsite_desc = ''   
            END IF
            DISPLAY BY NAME g_master.pmdnsite_desc,g_master.xcccld_desc,g_master.xccc003_desc,g_master.xccc002_desc            
            CALL axcp560_set_entry_b()
            CALL axcp560_set_no_entry_b()
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdnsite
            
            #add-point:AFTER FIELD pmdnsite name="input.a.pmdnsite"
            IF NOT axcp560_chk_pmdnsite(g_master.pmdnsite) THEN
               NEXT FIELD pmdnsite
            END IF         
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdnsite
            #add-point:BEFORE FIELD pmdnsite name="input.b.pmdnsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdnsite
            #add-point:ON CHANGE pmdnsite name="input.g.pmdnsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD real_cost
            #add-point:BEFORE FIELD real_cost name="input.b.real_cost"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD real_cost
            
            #add-point:AFTER FIELD real_cost name="input.a.real_cost"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE real_cost
            #add-point:ON CHANGE real_cost name="input.g.real_cost"
            IF g_master.real_cost = 'Y' THEN
               LET g_master.price = ''
               LET g_master.standard = '' 
               LET g_master.pmdnsite = ''
               LET g_master.pmdnsite_desc = ''         
               CALL s_axc_set_site_default() 
                 RETURNING l_xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003
               CALL s_desc_get_ld_desc(g_master.xcccld) RETURNING g_master.xcccld_desc 
               CALL axcp560_xccc003_desc(g_master.xccc003) RETURNING g_master.xccc003_desc
               LET g_master.xcab001_1 = ''               
            ELSE
               LET g_master.real_cost = ''
               LET g_master.xcccld = ''
               LET g_master.xcccld_desc = ''
               LET g_master.xccc003 = ''
               LET g_master.xccc003_desc = ''
               LET g_master.xccc004 = ''
               LET g_master.xccc005 = ''
               LET g_master.xccc002 = ''
               LET g_master.xccc002_desc = ''
            END IF  
            DISPLAY BY NAME g_master.pmdnsite_desc,g_master.xcccld_desc,g_master.xccc003_desc,g_master.xccc002_desc            
            CALL axcp560_set_entry_b()
            CALL axcp560_set_no_entry_b()            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcccld
            
            #add-point:AFTER FIELD xcccld name="input.a.xcccld"
            IF NOT cl_null(g_master.xcccld) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xcccld
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               IF NOT cl_chk_exist("v_glaald") THEN
                  LET g_master.xcccld = ''                  
                  NEXT FIELD xcccld
               END IF
               CALL s_desc_get_ld_desc(g_master.xcccld) RETURNING g_master.xcccld_desc 
               DISPLAY BY NAME g_master.xcccld_desc 
            END IF 
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
         AFTER FIELD xccc002
            
            #add-point:AFTER FIELD xccc002 name="input.a.xccc002"



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xccc002
            #add-point:BEFORE FIELD xccc002 name="input.b.xccc002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc002
            #add-point:ON CHANGE xccc002 name="input.g.xccc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc003
            
            #add-point:AFTER FIELD xccc003 name="input.a.xccc003"
            IF NOT cl_null(g_master.xccc003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master.xccc003 
               LET g_errshow = TRUE   
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"                 
               IF NOT cl_chk_exist("v_xcat001") THEN
                  LET g_master.xccc003 = NULL
                  NEXT FIELD CURRENT
               END IF
               CALL axcp560_xccc003_desc(g_master.xccc003) RETURNING g_master.xccc003_desc
               DISPLAY BY NAME g_master.xccc003_desc
            END IF   
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
         BEFORE FIELD xccc004
            #add-point:BEFORE FIELD xccc004 name="input.b.xccc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xccc004
            
            #add-point:AFTER FIELD xccc004 name="input.a.xccc004"
            
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
               IF g_master.xccc005 > 13 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00261'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                  
                  NEXT FIELD xccc005                  
               END IF           
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xccc005
            #add-point:ON CHANGE xccc005 name="input.g.xccc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD standard
            #add-point:BEFORE FIELD standard name="input.b.standard"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD standard
            
            #add-point:AFTER FIELD standard name="input.a.standard"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE standard
            #add-point:ON CHANGE standard name="input.g.standard"
            IF g_master.standard = 'Y' THEN
               LET g_master.price = ''
               LET g_master.real_cost = ''
               LET g_master.pmdnsite = ''
               LET g_master.pmdnsite_desc = ''               
               LET g_master.xcccld = ''
               LET g_master.xcccld_desc = ''
               LET g_master.xccc003 = ''
               LET g_master.xccc003_desc = ''
               LET g_master.xccc004 = ''
               LET g_master.xccc005 = ''
               LET g_master.xccc002 = ''
               LET g_master.xccc002_desc = ''
               LET g_master.xcab001_1 = ''               
            ELSE   
               LET g_master.standard = '' 
               LET g_master.xcab001_1 = ''               
            END IF     
            DISPLAY BY NAME g_master.pmdnsite_desc,g_master.xcccld_desc,g_master.xccc003_desc,g_master.xccc002_desc            
            CALL axcp560_set_entry_b()
            CALL axcp560_set_no_entry_b()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcab001_1
            #add-point:BEFORE FIELD xcab001_1 name="input.b.xcab001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcab001_1
            
            #add-point:AFTER FIELD xcab001_1 name="input.a.xcab001_1"
            IF NOT cl_null(g_master.xcab001_1) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.arg1 = g_master.xcab001_1               
               IF NOT cl_chk_exist("v_xcab001") THEN
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcab001_1
            #add-point:ON CHANGE xcab001_1 name="input.g.xcab001_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD per
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.per,"-100","1","100","1","azz-00087",1) THEN
               NEXT FIELD per
            END IF 
 
 
 
            #add-point:AFTER FIELD per name="input.a.per"
            IF NOT cl_null(g_master.per) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD per
            #add-point:BEFORE FIELD per name="input.b.per"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE per
            #add-point:ON CHANGE per name="input.g.per"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcab001
            #add-point:ON ACTION controlp INFIELD xcab001 name="input.c.xcab001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_master.xcab001          #給予default值            
            LET g_qryparam.where = " xcabsite ='",g_site,"'"
            CALL q_xcab001_1()                                    #呼叫開窗 
            LET g_master.xcab001 = g_qryparam.return1              
            DISPLAY g_master.xcab001 TO xcab001                 #
            NEXT FIELD xcab001                                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.change_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD change_type
            #add-point:ON ACTION controlp INFIELD change_type name="input.c.change_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.price
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD price
            #add-point:ON ACTION controlp INFIELD price name="input.c.price"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdnsite
            #add-point:ON ACTION controlp INFIELD pmdnsite name="input.c.pmdnsite"
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.pmdnsite
            LET g_qryparam.where = " (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y')"
            CALL q_ooef001()
            LET g_master.pmdnsite = g_qryparam.return1
            DISPLAY g_master.pmdnsite TO pmdnsite            
            CALL s_desc_get_department_desc(g_master.pmdnsite) RETURNING g_master.pmdnsite_desc
            DISPLAY BY NAME g_master.pmdnsite_desc
            NEXT FIELD pmdnsite
            #END add-point
 
 
         #Ctrlp:input.c.real_cost
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD real_cost
            #add-point:ON ACTION controlp INFIELD real_cost name="input.c.real_cost"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcccld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcccld
            #add-point:ON ACTION controlp INFIELD xcccld name="input.c.xcccld"
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcccld           #給予default值
            CALL q_glaald_01() #呼叫開窗
            LET g_master.xcccld = g_qryparam.return1   #將開窗取得的值回傳到變數            
            DISPLAY g_master.xcccld TO xcccld          #顯示到畫面上            
            CALL s_desc_get_ld_desc(g_master.xcccld) RETURNING g_master.xcccld_desc 
            DISPLAY BY NAME g_master.xcccld_desc 
            NEXT FIELD xcccld                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc002
            #add-point:ON ACTION controlp INFIELD xccc002 name="input.c.xccc002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccc002  #顯示到畫面上
            NEXT FIELD xccc002                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xccc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xccc003
            #add-point:ON ACTION controlp INFIELD xccc003 name="input.c.xccc003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xccc003
            CALL q_xcat001()
            LET g_master.xccc003 = g_qryparam.return1
            DISPLAY g_master.xccc003 TO xccc003
            CALL axcp560_xccc003_desc(g_master.xccc003) RETURNING g_master.xccc003_desc
            DISPLAY BY NAME g_master.xccc003_desc
            NEXT FIELD xccc003
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
 
 
         #Ctrlp:input.c.standard
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD standard
            #add-point:ON ACTION controlp INFIELD standard name="input.c.standard"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcab001_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcab001_1
            #add-point:ON ACTION controlp INFIELD xcab001_1 name="input.c.xcab001_1"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.default1 = g_master.xcab001_1             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" # 
            CALL q_xcab001()                                #呼叫開窗 
            LET g_master.xcab001_1 = g_qryparam.return1      
            DISPLAY g_master.xcab001_1 TO xcab001_1         #
            NEXT FIELD xcab001_1                            #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.per
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD per
            #add-point:ON ACTION controlp INFIELD per name="input.c.per"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa001,imag011,imaa003,xcax002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imaa004 = 'M' AND imaastus = 'Y'"
            CALL q_imaa001_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imag011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imag011
            #add-point:ON ACTION controlp INFIELD imag011 name="construct.c.imag011"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imag011_2()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE            
            CALL q_imca001_1()                     #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.xcax002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcax002
            #add-point:ON ACTION controlp INFIELD xcax002 name="construct.c.xcax002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xcax002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcax002  #顯示到畫面上
            NEXT FIELD xcax002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcax002
            #add-point:BEFORE FIELD xcax002 name="construct.b.xcax002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcax002
            
            #add-point:AFTER FIELD xcax002 name="construct.a.xcax002"
            
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
            CALL axcp560_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"


{#此段batch_execute mark(s)
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
#此段batch_execute mark(e)}



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
         ON ACTION batch_execute
            IF NOT axcp560_execute_chk() THEN
               NEXT FIELD xcab001
            END IF
            LET g_action_choice = "batch_execute"             
            ACCEPT DIALOG               
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
         CALL axcp560_init()
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
                 CALL axcp560_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp560_transfer_argv(ls_js)
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
 
{<section id="axcp560.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp560_transfer_argv(ls_js)
 
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
 
{<section id="axcp560.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp560_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_xcab002      LIKE xcab_t.xcab002
   DEFINE l_xcab003      LIKE xcab_t.xcab003
   DEFINE l_xcab004      LIKE xcab_t.xcab004
   DEFINE l_glaa001      LIKE glaa_t.glaa001
   DEFINE l_xcabcrtdt    DATETIME YEAR TO SECOND
   DEFINE l_xcabstus     LIKE xcab_t.xcabstus
   DEFINE l_sql          STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_per          LIKE type_t.num5
   DEFINE l_msg          STRING 
   DEFINE l_cnt_ok       LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_success = TRUE
   LET l_xcabcrtdt = cl_get_current()
   LET l_xcabstus = 'N'
   CASE
     WHEN g_master.price = 'Y'
       LET l_glaa001 = ''
       SELECT glaa001 INTO l_glaa001
         FROM glaa_t
        WHERE glaaent = g_enterprise AND glaacomp = g_site AND glaa014 = 'Y'
       #最新採購單價
       LET l_sql = "SELECT imai001,imai021,'",l_glaa001,"' glaa001 ",
                   "  FROM imai_t LEFT JOIN imaa_t ON imaaent = imaient AND imaa001 = imai001 ",
                   "              LEFT JOIN imag_t ON imagent = imaient AND imagsite = '",g_site,"' AND imag001 = imai001 ",
                   "              LEFT JOIN xcax_t ON xcaxent = imaient AND xcaxsite = '",g_site,"' AND xcax001 = imai001 ",                        
                   " WHERE imaient = ",g_enterprise," AND imaisite = '",g_master.pmdnsite,"' AND imai021 > 0 AND imaistus = 'Y' ",
                   "   AND ",g_master.wc       
       IF g_master.change_type = '1' THEN
          LET l_sql = "SELECT imai001,imai021,glaa001 ",
                      "  FROM ",
                      "       (SELECT xcab002,xcab003 FROM xcab_t ",
                      "         WHERE xcabent = ",g_enterprise," AND xcab001 = '",g_master.xcab001,"' AND xcabstus = 'N' ),",
                      "       (",l_sql,")",
                      " WHERE xcab002 = imai001 AND xcab003 = glaa001 "        
       END IF       
     WHEN g_master.real_cost = 'Y'
       #實際成本
       #抓取账套主本位币、批号、特性的值为空的成本数据
       LET l_sql = "SELECT xccc006,xccc280,xccc010 ",
                   "  FROM xccc_t LEFT JOIN imaa_t ON imaaent = xcccent AND imaa001 = xccc006 ",
                   "              LEFT JOIN imag_t ON imagent = xcccent AND imagsite = '",g_site,"' AND imag001 = xccc006 ",
                   "              LEFT JOIN xcax_t ON xcaxent = xcccent AND xcaxsite = '",g_site,"' AND xcax001 = xccc006 ", 
                   " WHERE xcccent = ",g_enterprise," AND xccccomp = '",g_site,"' AND xcccld = '",g_master.xcccld,"' AND xccc001 = '1' ",
                   "   AND xccc003 = '",g_master.xccc003,"' AND xccc004 = ",g_master.xccc004," AND xccc005 = ",g_master.xccc005,
                   "   AND trim(xccc007) IS NULL AND trim(xccc008) IS NULL AND xccc280 > 0 "       
       IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
          LET l_sql = l_sql," AND trim(xccc002) IS NULL "
       ELSE
          LET l_sql = l_sql," AND xccc002 ='",g_master.xccc002,"'"
       END IF  
       IF g_master.change_type = '1' THEN
          LET l_sql = "SELECT xccc006,xccc280,xccc010 ",
                      "  FROM ",
                      "       (SELECT xcab002,xcab003 FROM xcab_t ",
                      "         WHERE xcabent = ",g_enterprise," AND xcab001 = '",g_master.xcab001,"' AND xcabstus = 'N'), ",
                      "        (",l_sql,")",          
                      " WHERE xcab002 = xccc006 AND xcab003 = xccc010 "
       END IF
     WHEN g_master.standard = 'Y'
       #標準成本基礎數據
          LET l_sql = "SELECT xcab002,xcab004,xcab003 ",
                      "  FROM xcab_t LEFT JOIN imaa_t ON imaaent = xcabent AND imaa001 = xcab002 ",
                      "              LEFT JOIN imag_t ON imagent = xcabent AND imagsite = '",g_site,"' AND imag001 = xcab002 ",
                      "              LEFT JOIN xcax_t ON xcaxent = xcabent AND xcaxsite = '",g_site,"' AND xcax001 = xcab002 ",       
                      "  WHERE xcabent = ",g_enterprise," AND xcab001 = '",g_master.xcab001_1,"' AND xcab004 > 0 "
          IF g_master.change_type = '1' THEN
             LET l_sql = "SELECT b.xcab002,b.xcab004,b.xcab003 ",
                         "  FROM ",
                         "       (SELECT xcab002,xcab003 FROM xcab_t ",
                         "         WHERE xcabent = ",g_enterprise," AND xcab001 = '",g_master.xcab001,"' AND xcabstus = 'N')a, ",
                         "       (",l_sql,")b ",
                         " WHERE a.xcab002 = b.xcab002 AND a.xcab003 = b.xcab003 "
          END IF

     OTHERWISE
       #只變更百分比 
       LET l_sql = "SELECT xcab002,xcab004,xcab003 ",
                   "  FROM xcab_t ",
                   " WHERE xcabent = ",g_enterprise,
                   "   AND xcab001 = '",g_master.xcab001,"'",
                   "   AND xcabstus = 'N' "                   
   END CASE
   PREPARE axcp560_process_pr FROM l_sql
   DECLARE axcp560_process_cs CURSOR FOR axcp560_process_pr


   LET li_count = 0
   LET ls_sql = "SELECT COUNT(*) FROM (",l_sql,")"
   PREPARE axcp560_progressbar_cs FROM ls_sql
   EXECUTE axcp560_progressbar_cs INTO li_count
   FREE axcp560_progressbar_cs
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp560_process_cs CURSOR FROM ls_sql
#  FOREACH axcp560_process_cs INTO
   #add-point:process段process name="process.process"


   LET l_sql = " UPDATE xcab_t ",
               "    SET xcab004 = ?, ",
               "        xcabmodid = '",g_user,"',",
               "        xcabmoddt = to_date('",l_xcabcrtdt,"','YYYY-MM-DD hh24:mi:ss') ",
               "  WHERE xcabent = ",g_enterprise,
               "    AND xcab001 = '",g_master.xcab001,"'",
               "    AND xcab002 = ? ",
               "    AND xcab003 = ? "
   PREPARE axcp560_upd_xcab_cs FROM l_sql

   LET l_sql = " INSERT INTO xcab_t (xcabent,xcabsite,xcab001,xcab002,xcab003, ",
               "                     xcab004,xcabstus,xcabownid,xcabowndp,xcabcrtid, ",
               "                     xcabcrtdp,xcabcrtdt,xcabmodid,xcabmoddt) ",      
               "            VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?) " 

   PREPARE axcp560_ins_xcab_cs FROM l_sql
   
   LET l_sql = "SELECT COUNT(*) FROM xcab_t ",
               " WHERE xcabent = ",g_enterprise,
               "   AND xcab001 = '",g_master.xcab001,"'",
               "   AND xcab002 = ? AND xcab003 = ? "
   PREPARE axcp560_count_cs FROM l_sql

   IF cl_null(g_master.per) THEN
      LET l_per = 100
   ELSE
      LET l_per = 100 + g_master.per
   END IF    

   LET l_cnt_ok = 0
   
   CALL s_transaction_begin()

   FOREACH axcp560_process_cs INTO l_xcab002,l_xcab004,l_xcab003
      IF g_bgjob <> "Y" THEN                                                              
         LET l_msg = cl_getmsg_parm("axc-00786", g_lang,l_xcab002)  #變更%1材料標準單價           
         CALL cl_progress_no_window_ing(l_msg)                                            
      END IF          
      
      #百分比     
      LET l_xcab004 = l_xcab004 * (l_per/100)
      #依幣別做單價取位
      CALL s_curr_round(g_site,l_xcab003,l_xcab004,'1') RETURNING l_xcab004       
       
      LET l_cnt = 0
      EXECUTE axcp560_count_cs USING l_xcab002,l_xcab003 INTO l_cnt       
      IF l_cnt = 0 THEN          
         EXECUTE axcp560_ins_xcab_cs USING g_enterprise,g_site,g_master.xcab001,l_xcab002,l_xcab003,
                                           l_xcab004,l_xcabstus,g_user,g_dept,g_user,
                                           g_dept,l_xcabcrtdt,g_user,l_xcabcrtdt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "EXECUTE:axcp560_ins_xcab_cs"
            LET g_errparam.popup = TRUE
            CALL cl_err()          
            LET l_success = FALSE
            CONTINUE FOREACH
         ELSE
            LET l_cnt_ok = l_cnt_ok + 1         
         END IF                                            
      ELSE
         EXECUTE axcp560_upd_xcab_cs USING l_xcab004,l_xcab002,l_xcab003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "EXECUTE:axcp560_upd_xcab_cs"
            LET g_errparam.popup = TRUE
            CALL cl_err()          
            LET l_success = FALSE
            CONTINUE FOREACH
         ELSE
            LET l_cnt_ok = l_cnt_ok + 1         
         END IF            
      END IF
   END FOREACH
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF   
   FREE axcp560_count_cs
   FREE axcp560_ins_xcab_cs
   FREE axcp560_upd_xcab_cs
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF l_cnt_ok = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00491'   #輸入的條件無資料產生！
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_cnt_ok
         CALL cl_err()      
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apr-00209'   #價格調整成功，更新%1筆數據！
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_cnt_ok
         CALL cl_err()
      END IF   
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp560_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp560.get_buffer" >}
PRIVATE FUNCTION axcp560_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcab001 = p_dialog.getFieldBuffer('xcab001')
   LET g_master.change_type = p_dialog.getFieldBuffer('change_type')
   LET g_master.price = p_dialog.getFieldBuffer('price')
   LET g_master.pmdnsite = p_dialog.getFieldBuffer('pmdnsite')
   LET g_master.real_cost = p_dialog.getFieldBuffer('real_cost')
   LET g_master.xcccld = p_dialog.getFieldBuffer('xcccld')
   LET g_master.xccc002 = p_dialog.getFieldBuffer('xccc002')
   LET g_master.xccc003 = p_dialog.getFieldBuffer('xccc003')
   LET g_master.xccc004 = p_dialog.getFieldBuffer('xccc004')
   LET g_master.xccc005 = p_dialog.getFieldBuffer('xccc005')
   LET g_master.standard = p_dialog.getFieldBuffer('standard')
   LET g_master.xcab001_1 = p_dialog.getFieldBuffer('xcab001_1')
   LET g_master.per = p_dialog.getFieldBuffer('per')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp560.msgcentre_notify" >}
PRIVATE FUNCTION axcp560_msgcentre_notify()
 
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
 
{<section id="axcp560.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 欄位控卡
# Memo...........:
# Usage..........: CALL axcp560_set_entry_b()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160722 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp560_set_entry_b()

  CALL cl_set_comp_entry('pmdnsite,xcccld,xccc003,xccc004,xccc005,xccc002,xcab001_1',TRUE)

END FUNCTION

################################################################################
# Descriptions...: 欄位控卡
# Memo...........:
# Usage..........: CALL axcp560_set_no_entry_b()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160722 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp560_set_no_entry_b()

  IF g_master.price = 'Y' THEN
     CALL cl_set_comp_entry('xcccld,xccc003,xccc004,xccc005,xccc002,xcab001_1',FALSE)
  ELSE
     CALL cl_set_comp_entry('pmdnsite',FALSE)
  END IF
  IF g_master.real_cost = 'Y' THEN
     CALL cl_set_comp_entry('pmdnsite,xcab001_1',FALSE)
  ELSE
     CALL cl_set_comp_entry('xcccld,xccc003,xccc004,xccc005,xccc002',FALSE)  
  END IF
  IF g_master.standard = 'Y' THEN
     CALL cl_set_comp_entry('pmdnsite,xcccld,xccc003,xccc004,xccc005,xccc002',FALSE)
  ELSE
     CALL cl_set_comp_entry('xcab001_1',FALSE)  
  END IF

END FUNCTION

################################################################################
# Descriptions...: 執行前資料檢查
# Memo...........:
# Usage..........: CALL axcp560_execute_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 160727 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp560_execute_chk()
DEFINE r_success LIKE type_t.num5

    LET r_success = TRUE
   
    IF cl_null(g_master.price) AND cl_null(g_master.real_cost) AND cl_null(g_master.standard) AND
       cl_null(g_master.per) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'axc-00693'   #變更百分比不可為空
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()         
       LET r_success = FALSE
       RETURN r_success
    END IF
    IF g_master.wc = ' 1=1' OR cl_null(g_master.wc) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'axc-00690'   #料號、主分群碼、成本分群碼、成本次元素至少需選擇一項
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()         
       LET r_success = FALSE
       RETURN r_success    
    END IF    
   
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 營運據點檢查
# Memo...........:
# Usage..........: CALL axcp560_chk_pmdnsite(p_site)
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 160727 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp560_chk_pmdnsite(p_site)
DEFINE p_site     LIKE pmdn_t.pmdnsite
DEFINE r_success  LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5 

   LET r_success = TRUE
   #輸入值須存在[T:组织档]
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_site
      AND ooefent = g_enterprise
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'axc-00005'  #此資料不存在於[T:組織檔]中,請檢查！
      LET g_errparam.popup  = TRUE
      CALL cl_err()           
      LET r_success = FALSE            
      RETURN r_success                          
   END IF
   #輸入值須在[T:组织档]里有效
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_site
      AND ooefent = g_enterprise
      AND ooefstus = 'Y'
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'axc-00006'  #此資料在[T:組織檔]中無效,請檢查！
      LET g_errparam.popup  = TRUE
      CALL cl_err()           
      LET r_success = FALSE            
      RETURN r_success      
   END IF 
   #輸入值須在[T:组织档]里為"法人組織"or"营运組織否"or"核算組織否"
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_site
      AND ooefent = g_enterprise
      AND (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y')
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'axc-00058'  #輸入資料必須為法人組織或營運組織或核算組織！
      LET g_errparam.popup  = TRUE
      CALL cl_err()           
      LET r_success = FALSE            
      RETURN r_success     
   END IF   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 計算類型說明
# Memo...........:
# Usage..........: CALL axcp560_xccc003_desc(p_xccc003)
#                  RETURNING 
# Input parameter: 
# Return code....: r_xcatl003
# Date & Author..: 160728 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp560_xccc003_desc(p_xccc003)
DEFINE p_xccc003   LIKE xccc_t.xccc003
DEFINE r_xcatl003  LIKE xcatl_t.xcatl003

 LET r_xcatl003 = ''
 
 SELECT xcatl003 INTO r_xcatl003
   FROM xcatl_t 
  WHERE xcatlent = g_enterprise
    AND xcatl001 = p_xccc003
    AND xcatl002 = g_dlang
   
 RETURN  r_xcatl003 
 
END FUNCTION

#end add-point
 
{</section>}
 
