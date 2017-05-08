#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp850.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2014-07-08 11:10:50), PR版次:0011(2017-01-04 14:25:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000168
#+ Filename...: ainp850
#+ Description: 盤點標籤產生作業
#+ Creator....: 01534(2014-06-25 17:25:54)
#+ Modifier...: 01534 -SD/PR- 01258
 
{</section>}
 
{<section id="ainp850.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#29 16/04/07 by 07959   將重複內容的錯誤訊息置換為公用錯誤訊息
#160504-00019#3  16/05/10 By lixh    参考数量给值inpd013 = inag025
#160517-00016#1  16/05/17 By lixh    更新inpd002
#160517-00029#1  16/05/24 By earl    新增條碼盤點資訊
#160512-00004#1  16/06/20 By Whitney inai012製造日期改抓inae010
#161124-00048#4  16/12/09 By 08734   星号整批调整
#170103-00007#1  17/01/04 By wuxja   画面无勾选时不应提示产生成功
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
       inpadocno LIKE inpa_t.inpadocno, 
   inpa002 LIKE inpa_t.inpa002, 
   inpa002_desc LIKE type_t.chr80, 
   inpadocno_desc LIKE type_t.chr80, 
   freeze LIKE type_t.chr1, 
   inpa005 LIKE inpa_t.inpa005, 
   inpa006 LIKE inpa_t.inpa006, 
   stock LIKE type_t.chr1, 
   blank1 LIKE type_t.chr1, 
   number1 LIKE type_t.num10, 
   work LIKE type_t.chr1, 
   blank2 LIKE type_t.chr1, 
   number2 LIKE type_t.num10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 type type_g_inpa_m        RECORD
             inpadocno       LIKE inpa_t.inpadocno, 
             inpadocno_desc  LIKE type_t.chr500,
             inpa002      LIKE inpa_t.inpa002,
             inpa002_desc LIKE type_t.chr500,
             freeze       LIKE type_t.chr1,
             stock        LIKE type_t.chr1,
             inpa005      LIKE inpa_t.inpa005,    
             blank1       LIKE type_t.chr1,             
             inpa006      LIKE inpa_t.inpa006, 
             number1      LIKE type_t.chr1,    
             work         LIKE type_t.chr1,
             blank2       LIKE type_t.chr1,
             number2      LIKE type_t.chr1
                              END RECORD
#DEFINE g_inpa_m          type_g_inpa_m   
#DEFINE g_inpa_m_t        type_g_inpa_m  
DEFINE g_master_t        type_master
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_sql1            STRING        #組 sql 用
DEFINE g_sql2            STRING        #組 sql 用
DEFINE g_sql3            STRING        #組 sql 用
DEFINE g_sql4            STRING        #組 sql 用
DEFINE g_stagecomplete   LIKE type_t.num5
DEFINE g_count           LIKE type_t.num5
DEFINE g_count2          LIKE type_t.num5
DEFINE l_ac              LIKE type_t.num5

DEFINE g_datetime        DATETIME YEAR TO SECOND  #160517-00029#1   2016/05/24 By earl add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp850.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainp850_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp850 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp850_init()
 
      #進入選單 Menu (="N")
      CALL ainp850_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp850
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp850.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp850_init()
 
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
#    LET g_master.inpa005 = g_today 
#    LET g_master.inpa006 = g_today 
    LET g_master.inpa005 = '' 
    LET g_master.inpa006 = ''
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp850.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp850_ui_dialog()
 
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
   LET g_errshow = 1 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.inpadocno,g_master.inpa002,g_master.freeze,g_master.inpa005,g_master.inpa006, 
             g_master.stock,g_master.blank1,g_master.number1,g_master.work,g_master.blank2,g_master.number2  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.freeze = 'N'
               LET g_master.stock = 'N'
               LET g_master.work = 'N'
               LET g_master.blank1 = 'N'
               LET g_master.blank2 = 'N'
               LET g_master.number1 = ''
               LET g_master.number2 = ''
#               LET g_master.inpa005 = g_today 
#               LET g_master.inpa006 = g_today 
               LET g_master.inpa005 = '' 
               LET g_master.inpa006 = ''
               CALL ainp850_set_entry()
               CALL ainp850_set_no_required()
               CALL ainp850_set_required()               
               CALL ainp850_set_no_entry()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpadocno
            
            #add-point:AFTER FIELD inpadocno name="input.a.inpadocno"
               CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc
               IF NOT cl_null(g_master.inpadocno) THEN 

                  INITIALIZE g_chkparam.* TO NULL
               
                  LET g_chkparam.arg1 = g_master.inpadocno
                  
                  IF cl_chk_exist("v_inpadocno") THEN
                  ELSE
                     LET g_master.inpadocno = g_master_t.inpadocno
                     CALL ainp850_inpa002_desc()
                     NEXT FIELD inpadocno
                  END IF 
                  CALL s_aooi200_get_slip_desc(g_master.inpadocno) RETURNING g_master.inpadocno_desc                  
                  CALL ainp850_inpa002_desc()
               ELSE 
                  LET g_master.inpa002 = ''
                  LET g_master.inpa002_desc = ''                     
               END IF
               CALL ainp850_set_entry()
               CALL ainp850_set_no_required()
               CALL ainp850_set_required()
               CALL ainp850_set_no_entry()
               NEXT FIELD freeze
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpadocno
            #add-point:BEFORE FIELD inpadocno name="input.b.inpadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpadocno
            #add-point:ON CHANGE inpadocno name="input.g.inpadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpa002
            
            #add-point:AFTER FIELD inpa002 name="input.a.inpa002"
            IF NOT cl_null(g_master.inpa002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               #設定g_chkparam.*的參數

               LET g_chkparam.arg1 = g_master.inpa002  
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#29  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.inpa002 = g_master_t.inpa002
                  CALL s_desc_get_person_desc(g_master.inpa002) RETURNING g_master.inpa002_desc
                  NEXT FIELD CURRENT
               END IF           
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.inpa002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_master.inpa002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.inpa002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpa002
            #add-point:BEFORE FIELD inpa002 name="input.b.inpa002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpa002
            #add-point:ON CHANGE inpa002 name="input.g.inpa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD freeze
            #add-point:BEFORE FIELD freeze name="input.b.freeze"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD freeze
            
            #add-point:AFTER FIELD freeze name="input.a.freeze"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE freeze
            #add-point:ON CHANGE freeze name="input.g.freeze"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpa005
            #add-point:BEFORE FIELD inpa005 name="input.b.inpa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpa005
            
            #add-point:AFTER FIELD inpa005 name="input.a.inpa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpa005
            #add-point:ON CHANGE inpa005 name="input.g.inpa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inpa006
            #add-point:BEFORE FIELD inpa006 name="input.b.inpa006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inpa006
            
            #add-point:AFTER FIELD inpa006 name="input.a.inpa006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inpa006
            #add-point:ON CHANGE inpa006 name="input.g.inpa006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stock
            #add-point:BEFORE FIELD stock name="input.b.stock"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stock
            
            #add-point:AFTER FIELD stock name="input.a.stock"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stock
            #add-point:ON CHANGE stock name="input.g.stock"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD blank1
            #add-point:BEFORE FIELD blank1 name="input.b.blank1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank1
            
            #add-point:AFTER FIELD blank1 name="input.a.blank1"
            CALL ainp850_set_entry()
            CALL ainp850_set_no_required()
            CALL ainp850_set_required()
            CALL ainp850_set_no_entry()
            IF g_master.blank1 = 'N' THEN
               NEXT FIELD  work
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank1
            #add-point:ON CHANGE blank1 name="input.g.blank1"
            CALL ainp850_set_entry()
            CALL ainp850_set_no_required()
            CALL ainp850_set_required()
            CALL ainp850_set_no_entry()
            IF g_master.blank1 = 'N' THEN 
               LET g_master.number1 = ''
               DISPLAY g_master.number1 TO number1
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number1,"0","1","","","azz-00079",1) THEN
               NEXT FIELD number1
            END IF 
 
 
 
            #add-point:AFTER FIELD number1 name="input.a.number1"
            IF NOT cl_null(g_master.number1) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD number1
            #add-point:BEFORE FIELD number1 name="input.b.number1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE number1
            #add-point:ON CHANGE number1 name="input.g.number1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD work
            #add-point:BEFORE FIELD work name="input.b.work"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD work
            
            #add-point:AFTER FIELD work name="input.a.work"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE work
            #add-point:ON CHANGE work name="input.g.work"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD blank2
            #add-point:BEFORE FIELD blank2 name="input.b.blank2"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD blank2
            
            #add-point:AFTER FIELD blank2 name="input.a.blank2"
            CALL ainp850_set_entry()
            CALL ainp850_set_no_required()
            CALL ainp850_set_required()            
            CALL ainp850_set_no_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE blank2
            #add-point:ON CHANGE blank2 name="input.g.blank2"
            CALL ainp850_set_entry()
            CALL ainp850_set_no_required()
            CALL ainp850_set_required()            
            CALL ainp850_set_no_entry()
            IF g_master.blank2 = 'N' THEN 
               LET g_master.number2 = ''
               DISPLAY g_master.number2 TO number2
            END IF            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD number2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.number2,"0","1","","","azz-00079",1) THEN
               NEXT FIELD number2
            END IF 
 
 
 
            #add-point:AFTER FIELD number2 name="input.a.number2"
            IF NOT cl_null(g_master.number2) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD number2
            #add-point:BEFORE FIELD number2 name="input.b.number2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE number2
            #add-point:ON CHANGE number2 name="input.g.number2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.inpadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpadocno
            #add-point:ON ACTION controlp INFIELD inpadocno name="input.c.inpadocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.inpadocno             #給予default值

            #給予arg

            
            CALL q_inpadocno_3()                                #呼叫開窗

            LET g_master.inpadocno = g_qryparam.return1              

            DISPLAY g_master.inpadocno TO inpadocno              #

            NEXT FIELD inpadocno                          #返回原欄位            

            #END add-point
 
 
         #Ctrlp:input.c.inpa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpa002
            #add-point:ON ACTION controlp INFIELD inpa002 name="input.c.inpa002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.inpa002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_master.inpa002 = g_qryparam.return1              

            DISPLAY g_master.inpa002 TO inpa002              #

            NEXT FIELD inpa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.freeze
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD freeze
            #add-point:ON ACTION controlp INFIELD freeze name="input.c.freeze"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpa005
            #add-point:ON ACTION controlp INFIELD inpa005 name="input.c.inpa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.inpa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inpa006
            #add-point:ON ACTION controlp INFIELD inpa006 name="input.c.inpa006"
            
            #END add-point
 
 
         #Ctrlp:input.c.stock
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stock
            #add-point:ON ACTION controlp INFIELD stock name="input.c.stock"
            
            #END add-point
 
 
         #Ctrlp:input.c.blank1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD blank1
            #add-point:ON ACTION controlp INFIELD blank1 name="input.c.blank1"
            
            #END add-point
 
 
         #Ctrlp:input.c.number1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD number1
            #add-point:ON ACTION controlp INFIELD number1 name="input.c.number1"
            
            #END add-point
 
 
         #Ctrlp:input.c.work
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD work
            #add-point:ON ACTION controlp INFIELD work name="input.c.work"
            
            #END add-point
 
 
         #Ctrlp:input.c.blank2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD blank2
            #add-point:ON ACTION controlp INFIELD blank2 name="input.c.blank2"
            
            #END add-point
 
 
         #Ctrlp:input.c.number2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD number2
            #add-point:ON ACTION controlp INFIELD number2 name="input.c.number2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
#         INPUT BY NAME g_inpa_m.inpadocno,g_inpa_m.inpa002,g_inpa_m.freeze,g_inpa_m.stock,g_inpa_m.inpa005,g_inpa_m.blank1,
#                       g_inpa_m.inpa006,g_inpa_m.number1,g_inpa_m.work,g_inpa_m.blank2,g_inpa_m.number2
#               ATTRIBUTE(WITHOUT DEFAULTS)
#
#            BEFORE INPUT
#               LET g_inpa_m.freeze = 'N'
#               LET g_inpa_m.stock = 'N'
#               LET g_inpa_m.work = 'N'
#               LET g_inpa_m.blank1 = 'N'
#               LET g_inpa_m.blank2 = 'N'
#            
#            AFTER FIELD inpadocno
#               CALL s_aooi200_get_slip_desc(g_inpa_m.inpadocno) RETURNING g_inpa_m.inpadocno_desc
#               IF NOT cl_null(g_inpa_m.inpadocno) THEN 
#
#                  INITIALIZE g_chkparam.* TO NULL
#               
#                  LET g_chkparam.arg1 = g_inpa_m.inpadocno
#                  
#                  IF cl_chk_exist("v_inpadocno") THEN
#                  ELSE
#                     LET g_inpa_m.inpadocno = g_inpa_m_t.inpadocno
#                     CALL ainp850_inpa002_desc()
#                     NEXT FIELD inpadocno
#                  END IF 
#                  CALL s_aooi200_get_slip_desc(g_inpa_m.inpadocno) RETURNING g_inpa_m.inpadocno_desc                  
#                  CALL ainp850_inpa002_desc()
#               ELSE 
#                  LET g_inpa_m.inpa002 = ''
#                  LET g_inpa_m.inpa002_desc = ''                     
#               END IF
#               
#            
#            ON ACTION controlp INFIELD inpadocno
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#               LET g_qryparam.reqry = FALSE
#
#               LET g_qryparam.default1 = g_inpa_m.inpadocno             #給予default值
#            
#               CALL q_inpadocno_3()                                #呼叫開窗
#
#               LET g_inpa_m.inpadocno = g_qryparam.return1              
#
#               DISPLAY g_inpa_m.inpadocno TO inpadocno             
#
#               NEXT FIELD inpadocno                
#         END INPUT              
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL ainp850_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY BY NAME g_master.inpa005,g_master.inpa006
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
         CALL ainp850_init()
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
                 CALL ainp850_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp850_transfer_argv(ls_js)
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
 
{<section id="ainp850.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp850_transfer_argv(ls_js)
 
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
 
{<section id="ainp850.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp850_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_cnt_xd    LIKE type_t.num5   
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.chr1   
   DEFINE l_flag2     LIKE type_t.chr1     #add by lixh 20150723
   DEFINE l_inpc001   LIKE inpc_t.inpc001
   #DEFINE l_inag      RECORD LIKE inag_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inag RECORD  #庫存明細檔
       inagent LIKE inag_t.inagent, #企业编号
       inagsite LIKE inag_t.inagsite, #营运据点
       inag001 LIKE inag_t.inag001, #料件编号
       inag002 LIKE inag_t.inag002, #产品特征
       inag003 LIKE inag_t.inag003, #库存管理特征
       inag004 LIKE inag_t.inag004, #库位编号
       inag005 LIKE inag_t.inag005, #储位编号
       inag006 LIKE inag_t.inag006, #批号
       inag007 LIKE inag_t.inag007, #库存单位
       inag008 LIKE inag_t.inag008, #账面库存数量
       inag009 LIKE inag_t.inag009, #实际库存数量
       inag010 LIKE inag_t.inag010, #库存可用否
       inag011 LIKE inag_t.inag011, #MRP可用否
       inag012 LIKE inag_t.inag012, #成本库否
       inag013 LIKE inag_t.inag013, #拣货优先序
       inag014 LIKE inag_t.inag014, #最近一次盘点日期
       inag015 LIKE inag_t.inag015, #最后异动日期
       inag016 LIKE inag_t.inag016, #呆滞日期
       inag017 LIKE inag_t.inag017, #第一次入库日期
       inag018 LIKE inag_t.inag018, #No Use
       inag019 LIKE inag_t.inag019, #留置否
       inag020 LIKE inag_t.inag020, #留置原因
       inag021 LIKE inag_t.inag021, #备置数量
       inag022 LIKE inag_t.inag022, #No Use
       inag023 LIKE inag_t.inag023, #Tag二进位码
       inag024 LIKE inag_t.inag024, #参考单位
       inag025 LIKE inag_t.inag025, #参考数量
       inag026 LIKE inag_t.inag026, #最近一次检验日期
       inag027 LIKE inag_t.inag027, #下次检验日期
       inag028 LIKE inag_t.inag028, #留置日期
       inag029 LIKE inag_t.inag029, #留置人员
       inag030 LIKE inag_t.inag030, #留置部门
       inag031 LIKE inag_t.inag031, #留置单号
       inag032 LIKE inag_t.inag032, #基础单位
       inag033 LIKE inag_t.inag033 #基础单位数量
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_inpd      RECORD LIKE inpd_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpd RECORD  #盤點明細檔
       inpdent LIKE inpd_t.inpdent, #企业编号
       inpdsite LIKE inpd_t.inpdsite, #营运据点
       inpddocno LIKE inpd_t.inpddocno, #标签编号
       inpdseq LIKE inpd_t.inpdseq, #项次
       inpd001 LIKE inpd_t.inpd001, #料件编号
       inpd002 LIKE inpd_t.inpd002, #产品特征
       inpd003 LIKE inpd_t.inpd003, #库存管理特征
       inpd004 LIKE inpd_t.inpd004, #包装容器编号
       inpd005 LIKE inpd_t.inpd005, #库位编号
       inpd006 LIKE inpd_t.inpd006, #储位编号
       inpd007 LIKE inpd_t.inpd007, #批号
       inpd008 LIKE inpd_t.inpd008, #盘点计划单号
       inpd009 LIKE inpd_t.inpd009, #空白标签
       inpd010 LIKE inpd_t.inpd010, #库存单位
       inpd011 LIKE inpd_t.inpd011, #现有库存量
       inpd012 LIKE inpd_t.inpd012, #参考单位
       inpd013 LIKE inpd_t.inpd013, #参考单位现有库存量
       inpd014 LIKE inpd_t.inpd014, #理由码
       inpd015 LIKE inpd_t.inpd015, #备注
       inpd016 LIKE inpd_t.inpd016, #生成人员
       inpd017 LIKE inpd_t.inpd017, #生成日期
       inpd018 LIKE inpd_t.inpd018, #打印日期
       inpd019 LIKE inpd_t.inpd019, #打印次数
       inpd030 LIKE inpd_t.inpd030, #盘点数量-初盘(一)
       inpd031 LIKE inpd_t.inpd031, #参考单位盘点量-初盘(一)
       inpd032 LIKE inpd_t.inpd032, #录入人员-初盘(一)
       inpd033 LIKE inpd_t.inpd033, #录入日期-初盘(一)
       inpd034 LIKE inpd_t.inpd034, #盘点人员-初盘(一)
       inpd035 LIKE inpd_t.inpd035, #盘点日期-初盘(一)
       inpd036 LIKE inpd_t.inpd036, #盘点数量-初盘(二)
       inpd037 LIKE inpd_t.inpd037, #参考单位盘点量-初盘(二)
       inpd038 LIKE inpd_t.inpd038, #录入人员-初盘(二)
       inpd039 LIKE inpd_t.inpd039, #录入日期-初盘(二)
       inpd040 LIKE inpd_t.inpd040, #盘点人员-初盘(二)
       inpd041 LIKE inpd_t.inpd041, #盘点日期-初盘(二)
       inpd050 LIKE inpd_t.inpd050, #盘点数量-复盘(一)
       inpd051 LIKE inpd_t.inpd051, #参考单位盘点量-复盘(一)
       inpd052 LIKE inpd_t.inpd052, #录入人员-复盘(一)
       inpd053 LIKE inpd_t.inpd053, #录入日期-复盘(一)
       inpd054 LIKE inpd_t.inpd054, #盘点人员-复盘(一)
       inpd055 LIKE inpd_t.inpd055, #盘点日期-复盘(一)
       inpd056 LIKE inpd_t.inpd056, #盘点数量-复盘(二)
       inpd057 LIKE inpd_t.inpd057, #参考单位盘点量-复盘(二)
       inpd058 LIKE inpd_t.inpd058, #录入人员-复盘(二)
       inpd059 LIKE inpd_t.inpd059, #录入日期-复盘(二)
       inpd060 LIKE inpd_t.inpd060, #盘点人员-复盘(二)
       inpd061 LIKE inpd_t.inpd061, #盘点日期-复盘(二)
       inpdownid LIKE inpd_t.inpdownid, #资料所有者
       inpdowndp LIKE inpd_t.inpdowndp, #资料所有部门
       inpdcrtid LIKE inpd_t.inpdcrtid, #资料录入者
       inpdcrtdp LIKE inpd_t.inpdcrtdp, #资料录入部门
       inpdcrtdt LIKE inpd_t.inpdcrtdt, #资料创建日
       inpdmodid LIKE inpd_t.inpdmodid, #资料更改者
       inpdmoddt LIKE inpd_t.inpdmoddt, #最近更改日
       inpdcnfid LIKE inpd_t.inpdcnfid, #资料审核者
       inpdcnfdt LIKE inpd_t.inpdcnfdt, #数据审核日
       inpdpstid LIKE inpd_t.inpdpstid, #资料过账者
       inpdpstdt LIKE inpd_t.inpdpstdt, #资料过账日
       inpdstus LIKE inpd_t.inpdstus #状态码
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_inpa      RECORD LIKE inpa_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpa RECORD  #盤點計劃單頭檔
       inpaent LIKE inpa_t.inpaent, #企业编号
       inpasite LIKE inpa_t.inpasite, #营运据点
       inpadocno LIKE inpa_t.inpadocno, #计划单号
       inpadocdt LIKE inpa_t.inpadocdt, #录入日期
       inpa001 LIKE inpa_t.inpa001, #盘点类型
       inpa002 LIKE inpa_t.inpa002, #计划人员
       inpa003 LIKE inpa_t.inpa003, #计划部门
       inpa004 LIKE inpa_t.inpa004, #总负责人
       inpa005 LIKE inpa_t.inpa005, #存货预计冻结日
       inpa006 LIKE inpa_t.inpa006, #存货实际冻结日
       inpa007 LIKE inpa_t.inpa007, #备注
       inpa008 LIKE inpa_t.inpa008, #盘点录入方式
       inpa009 LIKE inpa_t.inpa009, #现有库存初盘一
       inpa010 LIKE inpa_t.inpa010, #现有库存初盘二
       inpa011 LIKE inpa_t.inpa011, #现有库存复盘一
       inpa012 LIKE inpa_t.inpa012, #现有库存复盘二
       inpa013 LIKE inpa_t.inpa013, #在制工单初盘一
       inpa014 LIKE inpa_t.inpa014, #在制工单初盘二
       inpa015 LIKE inpa_t.inpa015, #在制工单复盘一
       inpa016 LIKE inpa_t.inpa016, #在制工单复盘二
       inpa017 LIKE inpa_t.inpa017, #包含已无库存量
       inpa018 LIKE inpa_t.inpa018, #存货盘点单别
       inpa019 LIKE inpa_t.inpa019, #存货空白单别
       inpa020 LIKE inpa_t.inpa020, #生成方式
       inpa021 LIKE inpa_t.inpa021, #在制盘点单别
       inpa022 LIKE inpa_t.inpa022, #在制空白单别
       inpa023 LIKE inpa_t.inpa023, #盘点打印方式
       inpa024 LIKE inpa_t.inpa024, #显示账上库存数
       inpa025 LIKE inpa_t.inpa025, #存货排序一
       inpa026 LIKE inpa_t.inpa026, #存货排序二
       inpa027 LIKE inpa_t.inpa027, #存货排序三
       inpa028 LIKE inpa_t.inpa028, #存货排序四
       inpa029 LIKE inpa_t.inpa029, #存货排序五
       inpa030 LIKE inpa_t.inpa030, #存货排序六
       inpa031 LIKE inpa_t.inpa031, #分群码选项
       inpa032 LIKE inpa_t.inpa032, #在制排序一
       inpa033 LIKE inpa_t.inpa033, #在制排序二
       inpa034 LIKE inpa_t.inpa034, #在制排序三
       inpa035 LIKE inpa_t.inpa035, #在制排序四
       inpa036 LIKE inpa_t.inpa036, #在制排序五
       inpa037 LIKE inpa_t.inpa037, #在制排序六
       inpa038 LIKE inpa_t.inpa038, #开始日期
       inpa039 LIKE inpa_t.inpa039, #截止日期
       inpa050 LIKE inpa_t.inpa050, #盘点杂收单别
       inpa051 LIKE inpa_t.inpa051, #盘点杂发单别
       inpa052 LIKE inpa_t.inpa052, #盘点发料单别
       inpa053 LIKE inpa_t.inpa053, #盘点退料单别
       inpa054 LIKE inpa_t.inpa054, #盘点超领单别
       inpaownid LIKE inpa_t.inpaownid, #资料所有者
       inpaowndp LIKE inpa_t.inpaowndp, #资料所有部门
       inpacrtid LIKE inpa_t.inpacrtid, #资料录入者
       inpacrtdp LIKE inpa_t.inpacrtdp, #资料录入部门
       inpacrtdt LIKE inpa_t.inpacrtdt, #资料创建日
       inpamodid LIKE inpa_t.inpamodid, #资料更改者
       inpamoddt LIKE inpa_t.inpamoddt, #最近更改日
       inpacnfid LIKE inpa_t.inpacnfid, #资料审核者
       inpacnfdt LIKE inpa_t.inpacnfdt, #数据审核日
       inpapstid LIKE inpa_t.inpapstid, #资料过账者
       inpapstdt LIKE inpa_t.inpapstdt, #资料过账日
       inpastus LIKE inpa_t.inpastus, #状态码
       inpa040 LIKE inpa_t.inpa040, #盘点日期
       inpa041 LIKE inpa_t.inpa041, #最近重计日
       inpa042 LIKE inpa_t.inpa042, #在制盘差处理仓
       inpa043 LIKE inpa_t.inpa043 #在制盘差处理储位
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   DEFINE g_inpddocno LIKE inpa_t.inpadocno
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   #DEFINE l_inpe      RECORD LIKE inpe_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpe RECORD  #盤點單製造批序號明細檔
       inpeent LIKE inpe_t.inpeent, #企业编号
       inpesite LIKE inpe_t.inpesite, #营运据点
       inpedocno LIKE inpe_t.inpedocno, #盘点编号
       inpeseq LIKE inpe_t.inpeseq, #项次
       inpeseq2 LIKE inpe_t.inpeseq2, #序号
       inpe001 LIKE inpe_t.inpe001, #料件编号
       inpe002 LIKE inpe_t.inpe002, #产品特征
       inpe003 LIKE inpe_t.inpe003, #库存管理特征
       inpe004 LIKE inpe_t.inpe004, #包装容器编号
       inpe005 LIKE inpe_t.inpe005, #库位
       inpe006 LIKE inpe_t.inpe006, #储位
       inpe007 LIKE inpe_t.inpe007, #批号
       inpe008 LIKE inpe_t.inpe008, #制造批号
       inpe009 LIKE inpe_t.inpe009, #制造序号
       inpe010 LIKE inpe_t.inpe010, #制造日期
       inpe011 LIKE inpe_t.inpe011, #有效日期
       inpe012 LIKE inpe_t.inpe012, #现有库存量
       inpe030 LIKE inpe_t.inpe030, #盘点数量-初盘(一)
       inpe031 LIKE inpe_t.inpe031, #录入人员-初盘(一)
       inpe032 LIKE inpe_t.inpe032, #录入日期-初盘(一)
       inpe033 LIKE inpe_t.inpe033, #盘点人员-初盘(一)
       inpe034 LIKE inpe_t.inpe034, #盘点日期-初盘(一)
       inpe035 LIKE inpe_t.inpe035, #盘点数量-初盘(二)
       inpe036 LIKE inpe_t.inpe036, #录入人员-初盘(二)
       inpe037 LIKE inpe_t.inpe037, #录入日期-初盘(二)
       inpe038 LIKE inpe_t.inpe038, #盘点人员-初盘(二)
       inpe039 LIKE inpe_t.inpe039, #盘点日期-初盘(二)
       inpe050 LIKE inpe_t.inpe050, #盘点数量-复盘(一)
       inpe051 LIKE inpe_t.inpe051, #录入人员-复盘(一)
       inpe052 LIKE inpe_t.inpe052, #录入日期-复盘(一)
       inpe053 LIKE inpe_t.inpe053, #盘点人员-复盘(一)
       inpe054 LIKE inpe_t.inpe054, #盘点日期-复盘(一)
       inpe055 LIKE inpe_t.inpe055, #盘点数量-复盘(二)
       inpe056 LIKE inpe_t.inpe056, #录入人员-复盘(二)
       inpe057 LIKE inpe_t.inpe057, #录入日期-复盘(二)
       inpe058 LIKE inpe_t.inpe058, #盘点人员-复盘(二)
       inpe059 LIKE inpe_t.inpe059 #盘点日期-复盘(二)
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_inpf      RECORD LIKE inpf_t.*   #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpf RECORD  #在製工單盤點單頭檔
       inpfent LIKE inpf_t.inpfent, #企业编号
       inpfsite LIKE inpf_t.inpfsite, #营运据点
       inpfdocno LIKE inpf_t.inpfdocno, #标签编号
       inpfseq LIKE inpf_t.inpfseq, #项次
       inpf001 LIKE inpf_t.inpf001, #工单单号
       inpf002 LIKE inpf_t.inpf002, #作业编号
       inpf003 LIKE inpf_t.inpf003, #生产料号
       inpf004 LIKE inpf_t.inpf004, #盘点计划单号
       inpf005 LIKE inpf_t.inpf005, #空白标签
       inpf006 LIKE inpf_t.inpf006, #部门供应商
       inpf007 LIKE inpf_t.inpf007, #生产数量
       inpf008 LIKE inpf_t.inpf008, #生产单位
       inpf009 LIKE inpf_t.inpf009, #工艺编号
       inpf010 LIKE inpf_t.inpf010, #已发料套数
       inpf011 LIKE inpf_t.inpf011, #已入库合格量
       inpf012 LIKE inpf_t.inpf012, #已入库不合格量
       inpf013 LIKE inpf_t.inpf013, #报废量
       inpf014 LIKE inpf_t.inpf014, #备注
       inpf015 LIKE inpf_t.inpf015, #生成人员
       inpf016 LIKE inpf_t.inpf016, #生成日期
       inpf017 LIKE inpf_t.inpf017, #打印日期
       inpf018 LIKE inpf_t.inpf018, #打印次数
       inpf020 LIKE inpf_t.inpf020, #录入人员-初盘一
       inpf021 LIKE inpf_t.inpf021, #录入日期-初盘一
       inpf022 LIKE inpf_t.inpf022, #录入人员-初盘二
       inpf023 LIKE inpf_t.inpf023, #录入日期-初盘二
       inpf024 LIKE inpf_t.inpf024, #录入人员-复盘一
       inpf025 LIKE inpf_t.inpf025, #录入日期-复盘一
       inpf026 LIKE inpf_t.inpf026, #录入人员-复盘二
       inpf027 LIKE inpf_t.inpf027, #录入日期-复盘二
       inpfownid LIKE inpf_t.inpfownid, #资料所有者
       inpfowndp LIKE inpf_t.inpfowndp, #资料所有部门
       inpfcrtid LIKE inpf_t.inpfcrtid, #资料录入者
       inpfcrtdp LIKE inpf_t.inpfcrtdp, #资料录入部门
       inpfcrtdt LIKE inpf_t.inpfcrtdt, #资料创建日
       inpfmodid LIKE inpf_t.inpfmodid, #资料更改者
       inpfmoddt LIKE inpf_t.inpfmoddt, #最近更改日
       inpfcnfid LIKE inpf_t.inpfcnfid, #资料审核者
       inpfcnfdt LIKE inpf_t.inpfcnfdt, #数据审核日
       inpfpstid LIKE inpf_t.inpfpstid, #资料过账者
       inpfpstdt LIKE inpf_t.inpfpstdt, #资料过账日
       inpfstus LIKE inpf_t.inpfstus #状态码
END RECORD 
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_inpg      RECORD LIKE inpg_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inpg RECORD  #在製工單盤點明細檔
       inpgent LIKE inpg_t.inpgent, #企业编号
       inpgsite LIKE inpg_t.inpgsite, #营运据点
       inpgdocno LIKE inpg_t.inpgdocno, #标签编号
       inpgseq LIKE inpg_t.inpgseq, #项次
       inpgseq1 LIKE inpg_t.inpgseq1, #项序
       inpgseq2 LIKE inpg_t.inpgseq2, #序号
       inpg001 LIKE inpg_t.inpg001, #发料料号
       inpg002 LIKE inpg_t.inpg002, #作业编号
       inpg003 LIKE inpg_t.inpg003, #工艺序
       inpg004 LIKE inpg_t.inpg004, #标准QPA
       inpg005 LIKE inpg_t.inpg005, #实际QPA
       inpg006 LIKE inpg_t.inpg006, #应发数量
       inpg007 LIKE inpg_t.inpg007, #单位
       inpg008 LIKE inpg_t.inpg008, #已发数量
       inpg009 LIKE inpg_t.inpg009, #报废数量
       inpg010 LIKE inpg_t.inpg010, #库存管理特征
       inpg011 LIKE inpg_t.inpg011, #超领数量
       inpg012 LIKE inpg_t.inpg012, #应盘数量
       inpg013 LIKE inpg_t.inpg013, #理由码
       inpg014 LIKE inpg_t.inpg014, #备注
       inpg030 LIKE inpg_t.inpg030, #盘点数量-初盘(一)
       inpg031 LIKE inpg_t.inpg031, #盘点人员-初盘(一)
       inpg032 LIKE inpg_t.inpg032, #盘点日期-初盘(一)
       inpg033 LIKE inpg_t.inpg033, #盘点数量-初盘(二)
       inpg034 LIKE inpg_t.inpg034, #盘点人员-初盘(二)
       inpg035 LIKE inpg_t.inpg035, #盘点日期-初盘(二)
       inpg050 LIKE inpg_t.inpg050, #盘点数量-复盘(一)
       inpg051 LIKE inpg_t.inpg051, #盘点人员-复盘(一)
       inpg052 LIKE inpg_t.inpg052, #盘点日期-复盘(一)
       inpg053 LIKE inpg_t.inpg053, #盘点数量-复盘(二)
       inpg054 LIKE inpg_t.inpg054, #盘点人员-复盘(二)
       inpg055 LIKE inpg_t.inpg055, #盘点日期-复盘(二)
       inpg015 LIKE inpg_t.inpg015 #产品特征
END RECORD   
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_sfaa      RECORD LIKE sfaa_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企业编号
       sfaaownid LIKE sfaa_t.sfaaownid, #资料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #资料所有部门
       sfaacrtid LIKE sfaa_t.sfaacrtid, #资料录入者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #资料录入部门
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #资料创建日
       sfaamodid LIKE sfaa_t.sfaamodid, #资料更改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近更改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #资料审核者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #数据审核日
       sfaapstid LIKE sfaa_t.sfaapstid, #资料过账者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #资料过账日
       sfaastus LIKE sfaa_t.sfaastus, #状态码
       sfaasite LIKE sfaa_t.sfaasite, #营运据点
       sfaadocno LIKE sfaa_t.sfaadocno, #单号
       sfaadocdt LIKE sfaa_t.sfaadocdt, #单据日期
       sfaa001 LIKE sfaa_t.sfaa001, #变更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人员
       sfaa003 LIKE sfaa_t.sfaa003, #工单类型
       sfaa004 LIKE sfaa_t.sfaa004, #发料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工单来源
       sfaa006 LIKE sfaa_t.sfaa006, #来源单号
       sfaa007 LIKE sfaa_t.sfaa007, #来源项次
       sfaa008 LIKE sfaa_t.sfaa008, #来源项序
       sfaa009 LIKE sfaa_t.sfaa009, #参考客户
       sfaa010 LIKE sfaa_t.sfaa010, #生产料号
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生产数量
       sfaa013 LIKE sfaa_t.sfaa013, #生产单位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #工艺编号
       sfaa017 LIKE sfaa_t.sfaa017, #部门供应商
       sfaa018 LIKE sfaa_t.sfaa018, #协作据点
       sfaa019 LIKE sfaa_t.sfaa019, #预计开工日
       sfaa020 LIKE sfaa_t.sfaa020, #预计完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工单单号
       sfaa022 LIKE sfaa_t.sfaa022, #参考原始单号
       sfaa023 LIKE sfaa_t.sfaa023, #参考原始项次
       sfaa024 LIKE sfaa_t.sfaa024, #参考原始项序
       sfaa025 LIKE sfaa_t.sfaa025, #前工单单号
       sfaa026 LIKE sfaa_t.sfaa026, #料表批号(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #项目编号
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活动
       sfaa031 LIKE sfaa_t.sfaa031, #理由码
       sfaa032 LIKE sfaa_t.sfaa032, #紧急比率
       sfaa033 LIKE sfaa_t.sfaa033, #优先级
       sfaa034 LIKE sfaa_t.sfaa034, #预计入库库位
       sfaa035 LIKE sfaa_t.sfaa035, #预计入库储位
       sfaa036 LIKE sfaa_t.sfaa036, #手册编号
       sfaa037 LIKE sfaa_t.sfaa037, #保税核准文号
       sfaa038 LIKE sfaa_t.sfaa038, #保税核销
       sfaa039 LIKE sfaa_t.sfaa039, #备料已生成
       sfaa040 LIKE sfaa_t.sfaa040, #生产工艺路线已审核
       sfaa041 LIKE sfaa_t.sfaa041, #冻结
       sfaa042 LIKE sfaa_t.sfaa042, #返工
       sfaa043 LIKE sfaa_t.sfaa043, #备置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #实际开始发料日
       sfaa046 LIKE sfaa_t.sfaa046, #最后入库日
       sfaa047 LIKE sfaa_t.sfaa047, #生管结案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本结案日
       sfaa049 LIKE sfaa_t.sfaa049, #已发料套数
       sfaa050 LIKE sfaa_t.sfaa050, #已入库合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入库不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工单转入数量
       sfaa054 LIKE sfaa_t.sfaa054, #工单转出数量
       sfaa055 LIKE sfaa_t.sfaa055, #下线数量
       sfaa056 LIKE sfaa_t.sfaa056, #报废数量
       sfaa057 LIKE sfaa_t.sfaa057, #委外类型
       sfaa058 LIKE sfaa_t.sfaa058, #参考数量
       sfaa059 LIKE sfaa_t.sfaa059, #预计入库批号
       sfaa060 LIKE sfaa_t.sfaa060, #参考单位
       sfaa061 LIKE sfaa_t.sfaa061, #工艺
       sfaa062 LIKE sfaa_t.sfaa062, #纳入APS计算
       sfaa063 LIKE sfaa_t.sfaa063, #来源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #参考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管结案状态
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程编号
       sfaa067 LIKE sfaa_t.sfaa067, #多角流进程号
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供给量
       sfaa070 LIKE sfaa_t.sfaa070, #原始预计完工日期
       sfaaud001 LIKE sfaa_t.sfaaud001, #自定义字段(文本)001
       sfaaud002 LIKE sfaa_t.sfaaud002, #自定义字段(文本)002
       sfaaud003 LIKE sfaa_t.sfaaud003, #自定义字段(文本)003
       sfaaud004 LIKE sfaa_t.sfaaud004, #自定义字段(文本)004
       sfaaud005 LIKE sfaa_t.sfaaud005, #自定义字段(文本)005
       sfaaud006 LIKE sfaa_t.sfaaud006, #自定义字段(文本)006
       sfaaud007 LIKE sfaa_t.sfaaud007, #自定义字段(文本)007
       sfaaud008 LIKE sfaa_t.sfaaud008, #自定义字段(文本)008
       sfaaud009 LIKE sfaa_t.sfaaud009, #自定义字段(文本)009
       sfaaud010 LIKE sfaa_t.sfaaud010, #自定义字段(文本)010
       sfaaud011 LIKE sfaa_t.sfaaud011, #自定义字段(数字)011
       sfaaud012 LIKE sfaa_t.sfaaud012, #自定义字段(数字)012
       sfaaud013 LIKE sfaa_t.sfaaud013, #自定义字段(数字)013
       sfaaud014 LIKE sfaa_t.sfaaud014, #自定义字段(数字)014
       sfaaud015 LIKE sfaa_t.sfaaud015, #自定义字段(数字)015
       sfaaud016 LIKE sfaa_t.sfaaud016, #自定义字段(数字)016
       sfaaud017 LIKE sfaa_t.sfaaud017, #自定义字段(数字)017
       sfaaud018 LIKE sfaa_t.sfaaud018, #自定义字段(数字)018
       sfaaud019 LIKE sfaa_t.sfaaud019, #自定义字段(数字)019
       sfaaud020 LIKE sfaa_t.sfaaud020, #自定义字段(数字)020
       sfaaud021 LIKE sfaa_t.sfaaud021, #自定义字段(日期时间)021
       sfaaud022 LIKE sfaa_t.sfaaud022, #自定义字段(日期时间)022
       sfaaud023 LIKE sfaa_t.sfaaud023, #自定义字段(日期时间)023
       sfaaud024 LIKE sfaa_t.sfaaud024, #自定义字段(日期时间)024
       sfaaud025 LIKE sfaa_t.sfaaud025, #自定义字段(日期时间)025
       sfaaud026 LIKE sfaa_t.sfaaud026, #自定义字段(日期时间)026
       sfaaud027 LIKE sfaa_t.sfaaud027, #自定义字段(日期时间)027
       sfaaud028 LIKE sfaa_t.sfaaud028, #自定义字段(日期时间)028
       sfaaud029 LIKE sfaa_t.sfaaud029, #自定义字段(日期时间)029
       sfaaud030 LIKE sfaa_t.sfaaud030, #自定义字段(日期时间)030
       sfaa071 LIKE sfaa_t.sfaa071, #齐料套数
       sfaa072 LIKE sfaa_t.sfaa072 #保税否
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_sfba      RECORD LIKE sfba_t.*   #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_sfba RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
       sfbaud030 LIKE sfba_t.sfbaud030, #自定義欄位(日期時間)030
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035 #SET替代套數
END RECORD  
#161124-00048#4  16/12/09 By 08734 add(E)
   #DEFINE l_inai      RECORD LIKE inai_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_inai RECORD  #製造批序號庫存明細檔
       inaient LIKE inai_t.inaient, #企业编号
       inaisite LIKE inai_t.inaisite, #营运据点
       inai001 LIKE inai_t.inai001, #料件编号
       inai002 LIKE inai_t.inai002, #产品特征
       inai003 LIKE inai_t.inai003, #库存管理特征
       inai004 LIKE inai_t.inai004, #库位编号
       inai005 LIKE inai_t.inai005, #储位编号
       inai006 LIKE inai_t.inai006, #批号
       inai007 LIKE inai_t.inai007, #制造批号
       inai008 LIKE inai_t.inai008, #制造序号
       inai009 LIKE inai_t.inai009, #库存单位
       inai010 LIKE inai_t.inai010, #账面基础单位库存数量
       inai011 LIKE inai_t.inai011, #实际基础单位库存数量
       inai012 LIKE inai_t.inai012, #制造日期
       inai013 LIKE inai_t.inai013, #Tag二进位码
       inai014 LIKE inai_t.inai014 #基础单位
END RECORD 
#161124-00048#4  16/12/09 By 08734 add(E)
   DEFINE l_imaf071   LIKE imaf_t.imaf071
   DEFINE l_imaf081   LIKE imaf_t.imaf081
   #DEFINE l_imaf      RECORD LIKE imaf_t.*  #161124-00048#4  16/12/09 By 08734 mark
   #161124-00048#4  16/12/09 By 08734 add(S)
   DEFINE l_imaf RECORD  #料件據點進銷存檔
       imafent LIKE imaf_t.imafent, #企业编号
       imafsite LIKE imaf_t.imafsite, #营运据点
       imaf001 LIKE imaf_t.imaf001, #料件编号
       imaf011 LIKE imaf_t.imaf011, #主分群
       imaf012 LIKE imaf_t.imaf012, #存货控制方法
       imaf013 LIKE imaf_t.imaf013, #补给策略
       imaf014 LIKE imaf_t.imaf014, #需求计算方法
       imaf015 LIKE imaf_t.imaf015, #参考单位
       imaf016 LIKE imaf_t.imaf016, #据点生命周期
       imaf017 LIKE imaf_t.imaf017, #税种
       imaf018 LIKE imaf_t.imaf018, #使用附属零件
       imaf021 LIKE imaf_t.imaf021, #期间采购月数
       imaf022 LIKE imaf_t.imaf022, #期间采购日数
       imaf023 LIKE imaf_t.imaf023, #期间补足量
       imaf024 LIKE imaf_t.imaf024, #再订货点
       imaf025 LIKE imaf_t.imaf025, #再订货点量
       imaf026 LIKE imaf_t.imaf026, #安全库存量
       imaf027 LIKE imaf_t.imaf027, #警戒库存量
       imaf031 LIKE imaf_t.imaf031, #有效期月数
       imaf032 LIKE imaf_t.imaf032, #有效期加天数
       imaf033 LIKE imaf_t.imaf033, #检疫/隔离天数
       imaf034 LIKE imaf_t.imaf034, #保税料件
       imaf035 LIKE imaf_t.imaf035, #对应非保税料号
       imaf051 LIKE imaf_t.imaf051, #库存分群
       imaf052 LIKE imaf_t.imaf052, #仓管员
       imaf053 LIKE imaf_t.imaf053, #据点库存单位
       imaf054 LIKE imaf_t.imaf054, #库存多单位
       imaf055 LIKE imaf_t.imaf055, #库存管理特微
       imaf056 LIKE imaf_t.imaf056, #no use
       imaf057 LIKE imaf_t.imaf057, #ABC码
       imaf058 LIKE imaf_t.imaf058, #存货备置策略
       imaf059 LIKE imaf_t.imaf059, #捡货策略
       imaf061 LIKE imaf_t.imaf061, #库存批号控管方式
       imaf062 LIKE imaf_t.imaf062, #库存批号自动编码否
       imaf063 LIKE imaf_t.imaf063, #库存批号编码方式
       imaf064 LIKE imaf_t.imaf064, #库存批号唯一性检查控管
       imaf071 LIKE imaf_t.imaf071, #制造批号控管方式
       imaf072 LIKE imaf_t.imaf072, #制造批号自动编码否
       imaf073 LIKE imaf_t.imaf073, #制造批号编码方式
       imaf074 LIKE imaf_t.imaf074, #制造批号唯一性检查控管
       imaf081 LIKE imaf_t.imaf081, #序号控管方式
       imaf082 LIKE imaf_t.imaf082, #序号自动编码否
       imaf083 LIKE imaf_t.imaf083, #序号编码方式
       imaf084 LIKE imaf_t.imaf084, #序号唯一性检查控管
       imaf091 LIKE imaf_t.imaf091, #默认库位
       imaf092 LIKE imaf_t.imaf092, #默认储位
       imaf093 LIKE imaf_t.imaf093, #no use
       imaf094 LIKE imaf_t.imaf094, #盘点容差数
       imaf095 LIKE imaf_t.imaf095, #盘点容差率
       imaf096 LIKE imaf_t.imaf096, #开账呆滞日期
       imaf097 LIKE imaf_t.imaf097, #no use
       imaf101 LIKE imaf_t.imaf101, #调拨批量
       imaf102 LIKE imaf_t.imaf102, #最小调拨数量
       imaf111 LIKE imaf_t.imaf111, #销售分群
       imaf112 LIKE imaf_t.imaf112, #销售单位
       imaf113 LIKE imaf_t.imaf113, #销售计价单位
       imaf114 LIKE imaf_t.imaf114, #销售批量
       imaf115 LIKE imaf_t.imaf115, #最小销售数量
       imaf116 LIKE imaf_t.imaf116, #销售批量控管方式
       imaf117 LIKE imaf_t.imaf117, #保证(固)月数
       imaf118 LIKE imaf_t.imaf118, #保证(固)天数
       imaf121 LIKE imaf_t.imaf121, #默认内外销
       imaf122 LIKE imaf_t.imaf122, #订单子件拆解方式
       imaf123 LIKE imaf_t.imaf123, #惯用包装容器
       imaf124 LIKE imaf_t.imaf124, #销售备货提前天数
       imaf125 LIKE imaf_t.imaf125, #预测料号
       imaf126 LIKE imaf_t.imaf126, #出货替代
       imaf127 LIKE imaf_t.imaf127, #统计除外商品
       imaf128 LIKE imaf_t.imaf128, #销售超交率
       imaf141 LIKE imaf_t.imaf141, #采购分群
       imaf142 LIKE imaf_t.imaf142, #采购员
       imaf143 LIKE imaf_t.imaf143, #采购单位
       imaf144 LIKE imaf_t.imaf144, #采购计价单位
       imaf145 LIKE imaf_t.imaf145, #采购单位批量
       imaf146 LIKE imaf_t.imaf146, #最小采购数量
       imaf147 LIKE imaf_t.imaf147, #采购批量控管方式
       imaf148 LIKE imaf_t.imaf148, #经济订购量
       imaf149 LIKE imaf_t.imaf149, #平均订购量
       imaf151 LIKE imaf_t.imaf151, #默认内外购
       imaf152 LIKE imaf_t.imaf152, #供应商选择方式
       imaf153 LIKE imaf_t.imaf153, #主要供应商
       imaf154 LIKE imaf_t.imaf154, #主供应商分配限量
       imaf155 LIKE imaf_t.imaf155, #分配进位倍数
       imaf156 LIKE imaf_t.imaf156, #供货模式
       imaf157 LIKE imaf_t.imaf157, #惯用包装容器
       imaf158 LIKE imaf_t.imaf158, #接单拆解方式(采购)
       imaf161 LIKE imaf_t.imaf161, #采购替代
       imaf162 LIKE imaf_t.imaf162, #采购收货替代
       imaf163 LIKE imaf_t.imaf163, #采购合同冲销
       imaf164 LIKE imaf_t.imaf164, #采购时损耗率
       imaf165 LIKE imaf_t.imaf165, #采购时备品率
       imaf166 LIKE imaf_t.imaf166, #采购超交率
       imaf171 LIKE imaf_t.imaf171, #采购文档前置时间
       imaf172 LIKE imaf_t.imaf172, #采购交货前置时间
       imaf173 LIKE imaf_t.imaf173, #采购到厂前置时间
       imaf174 LIKE imaf_t.imaf174, #采购入库前置时间
       imaf175 LIKE imaf_t.imaf175, #严守交期前置时间
       imaf176 LIKE imaf_t.imaf176, #收货时段
       imafownid LIKE imaf_t.imafownid, #资料所有者
       imafowndp LIKE imaf_t.imafowndp, #资料所有部门
       imafcrtid LIKE imaf_t.imafcrtid, #资料录入者
       imafcrtdp LIKE imaf_t.imafcrtdp, #资料录入部门
       imafcrtdt LIKE imaf_t.imafcrtdt, #资料创建日
       imafmodid LIKE imaf_t.imafmodid, #资料更改者
       imafmoddt LIKE imaf_t.imafmoddt, #最近更改日
       imafcnfid LIKE imaf_t.imafcnfid, #资料审核者
       imafcnfdt LIKE imaf_t.imafcnfdt, #数据审核日
       imafstus LIKE imaf_t.imafstus, #状态码
       imafud001 LIKE imaf_t.imafud001, #自定义字段(文本)001
       imafud002 LIKE imaf_t.imafud002, #自定义字段(文本)002
       imafud003 LIKE imaf_t.imafud003, #自定义字段(文本)003
       imafud004 LIKE imaf_t.imafud004, #自定义字段(文本)004
       imafud005 LIKE imaf_t.imafud005, #自定义字段(文本)005
       imafud006 LIKE imaf_t.imafud006, #自定义字段(文本)006
       imafud007 LIKE imaf_t.imafud007, #自定义字段(文本)007
       imafud008 LIKE imaf_t.imafud008, #自定义字段(文本)008
       imafud009 LIKE imaf_t.imafud009, #自定义字段(文本)009
       imafud010 LIKE imaf_t.imafud010, #自定义字段(文本)010
       imafud011 LIKE imaf_t.imafud011, #自定义字段(数字)011
       imafud012 LIKE imaf_t.imafud012, #自定义字段(数字)012
       imafud013 LIKE imaf_t.imafud013, #自定义字段(数字)013
       imafud014 LIKE imaf_t.imafud014, #自定义字段(数字)014
       imafud015 LIKE imaf_t.imafud015, #自定义字段(数字)015
       imafud016 LIKE imaf_t.imafud016, #自定义字段(数字)016
       imafud017 LIKE imaf_t.imafud017, #自定义字段(数字)017
       imafud018 LIKE imaf_t.imafud018, #自定义字段(数字)018
       imafud019 LIKE imaf_t.imafud019, #自定义字段(数字)019
       imafud020 LIKE imaf_t.imafud020, #自定义字段(数字)020
       imafud021 LIKE imaf_t.imafud021, #自定义字段(日期时间)021
       imafud022 LIKE imaf_t.imafud022, #自定义字段(日期时间)022
       imafud023 LIKE imaf_t.imafud023, #自定义字段(日期时间)023
       imafud024 LIKE imaf_t.imafud024, #自定义字段(日期时间)024
       imafud025 LIKE imaf_t.imafud025, #自定义字段(日期时间)025
       imafud026 LIKE imaf_t.imafud026, #自定义字段(日期时间)026
       imafud027 LIKE imaf_t.imafud027, #自定义字段(日期时间)027
       imafud028 LIKE imaf_t.imafud028, #自定义字段(日期时间)028
       imafud029 LIKE imaf_t.imafud029, #自定义字段(日期时间)029
       imafud030 LIKE imaf_t.imafud030, #自定义字段(日期时间)030
       imaf177 LIKE imaf_t.imaf177, #箱盒号条码管理
       imaf178 LIKE imaf_t.imaf178, #条码编码方式
       imaf179 LIKE imaf_t.imaf179, #条码包装数量
       imaf129 LIKE imaf_t.imaf129, #销售合同冲销
       imaf130 LIKE imaf_t.imaf130 #销售时备品率
END RECORD
#161124-00048#4  16/12/09 By 08734 add(E)
   DEFINE l_sfbadocno_t  LIKE sfba_t.sfbadocno
   DEFINE l_sfba003_t    LIKE sfba_t.sfba003
   DEFINE l_sfaa020      LIKE sfaa_t.sfaa020
   DEFINE l_sfaastus     LIKE sfaa_t.sfaastus
   DEFINE l_sfaa003      LIKE sfaa_t.sfaa003
   DEFINE l_sql       STRING  
   DEFINE l_sql1      STRING  
   DEFINE l_slip      STRING 
   DEFINE l_yes       LIKE type_t.chr1 
   DEFINE l_inpt001   LIKE inpt_t.inpt001   
   
   #160517-00029#1   2016/05/24 By earl add s
   DEFINE l_sub_js    STRING
   
   DEFINE l_sub_param  RECORD
      cmd         LIKE type_t.chr1,        #1.INSERT 2.UPDATE
      inpa017     LIKE inpa_t.inpa017,     #包含已無庫存量
      inpa008     LIKE inpa_t.inpa008,     #盤點輸入方式
      inpa009     LIKE inpa_t.inpa009,     #現有庫存初盤一
      inpa010     LIKE inpa_t.inpa010,     #現有庫存初盤二
      inpa011     LIKE inpa_t.inpa011,     #現有庫存複盤一
      inpa012     LIKE inpa_t.inpa012,     #現有庫存複盤二
      datatime    DATETIME YEAR TO SECOND, #異動時間
      inpddocno   LIKE inpd_t.inpddocno,   #標籤編號
      inpdseq     LIKE inpd_t.inpdseq,     #項次
      inpd008     LIKE inpd_t.inpd008,     #盤點計畫單號
      inpd009     LIKE inpd_t.inpd009,     #空白標籤
      inpdownid   LIKE inpd_t.inpdownid,
      inpdowndp   LIKE inpd_t.inpdowndp,
      inpdcrtid   LIKE inpd_t.inpdcrtid,
      inpdcrtdp   LIKE inpd_t.inpdcrtdp,
      inpd001     LIKE inpd_t.inpd001,     #料件編號
      inpd002     LIKE inpd_t.inpd002,     #產品特徵
      inpd003     LIKE inpd_t.inpd003,     #庫存管理特徵
      inpd005     LIKE inpd_t.inpd005,     #庫位編號
      inpd006     LIKE inpd_t.inpd006,     #儲位編號
      inpd007     LIKE inpd_t.inpd007,     #批號
      inpd010     LIKE inpd_t.inpd010,     #庫存單位
      inpd012     LIKE inpd_t.inpd012      #參考單位
                       END RECORD
   #160517-00029#1   2016/05/24 By earl add e
   
   DEFINE l_inae010   LIKE inae_t.inae010  #160512-00004#1 by whitney add
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   DISPLAY '' TO stagenow 
   DISPLAY 0 TO stagecomplete  
   CALL ui.Interface.refresh() 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
#15/10/06 Sarah add
      LET li_count = 0

      #現有庫存-存貨凍結資料筆數
      LET l_cnt_xd = 0
      IF g_master.freeze = 'Y' THEN      
         SELECT COUNT(*) INTO l_cnt_xd FROM inpc_t
          WHERE inpcent = g_enterprise
            AND inpcsite = g_site
            AND inpcdocno = g_master.inpadocno
         IF cl_null(l_cnt_xd) THEN LET l_cnt_xd = 0 END IF
         LET li_count = li_count + l_cnt_xd
      END IF

      #現有庫存-產生盤點資料
      LET g_count = 0
      IF g_master.stock = 'Y' THEN
         LET g_sql3 = " SELECT COUNT(*) FROM inag_t,imaf_t ",
                      "  WHERE inagent = imafent ",
                      "    AND inagsite = imafsite ",
                      "    AND inag001 = imaf001 ",
                      "    AND inagent = '",g_enterprise,"'",
                      "    AND inagsite = '",g_site,"'"
         IF l_cnt_xd > 0 THEN
            LET g_sql3 = g_sql3," AND inag004 IN (",
                              " SELECT inpc001 FROM inpc_t ",
                              "  WHERE inpcent = '",g_enterprise,"'",
                              "    AND inpcsite = '",g_site,"'",
                              "    AND inpcdocno = '",g_master.inpadocno,"')"
         END IF
         IF l_inpa.inpa017 = 'N' THEN
            LET g_sql3 = g_sql3," AND inag008 > 0"
         END IF
         PREPARE ainp850_inag_count1 FROM g_sql3
         EXECUTE ainp850_inag_count1 INTO g_count
         IF cl_null(g_count) THEN LET g_count = 0 END IF
         LET li_count = li_count + g_count
      END IF

      #在製工單-產生在製工單盤點資料資料筆數
      LET g_count2 = 0
      IF g_master.work = 'Y' THEN
         LET g_sql4 = " SELECT COUNT(*) FROM sfaa_t,sfba_t ",
                      "  WHERE sfaaent = sfbaent ",
                      "    AND sfaadocno = sfbadocno ",
                      "    AND sfaaent = '",g_enterprise,"'",
                      "    AND sfaasite = '",g_site,"'",
                      "    AND sfaa065 = '0' ",
                      "    AND sfba013 > 0 "
         PREPARE ainp850_sfaa_count1 FROM g_sql4
         EXECUTE ainp850_sfaa_count1 INTO g_count2
         IF cl_null(g_count2) THEN LET g_count2 = 0 END IF
         LET li_count = li_count + g_count2
      END IF

      #現有庫存-產生空白標籤資料筆數
      IF g_master.number1 <> 0 THEN
         LET li_count = li_count + g_master.number1
      END IF
    
      #在製工單-產生空白標籤資料筆數
      IF g_master.number2 <> 0 THEN
         LET li_count = li_count + g_master.number2
      END IF

      CALL cl_progress_bar_no_window(li_count)
#15/10/06 Sarah add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ainp850_process_cs CURSOR FROM ls_sql
#  FOREACH ainp850_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET l_flag = 'Y'
   LET l_success = TRUE
   
   LET l_cnt_xd = 0
   SELECT COUNT(*) INTO l_cnt_xd FROM inpc_t
    WHERE inpcent = g_enterprise
     AND inpcsite = g_site
     AND inpcdocno = g_master.inpadocno
   IF cl_null(l_cnt_xd) THEN LET l_cnt_xd = 0 END IF   
      
   IF g_master.freeze = 'Y' THEN    #存貨凍結

      IF l_cnt_xd > 0 THEN   #有限定
         LET l_sql = " SELECT inpc001 FROM inpc_t ",
                     "  WHERE inpcent = '",g_enterprise,"'",
                     "    AND inpcdocno = '",g_master.inpadocno,"'"
         PREPARE ainp850_inpc_pre FROM l_sql
         DECLARE ainp850_inpc_cur CURSOR FOR ainp850_inpc_pre   
         FOREACH ainp850_inpc_cur INTO l_inpc001
            CALL ainp850_progress_show('1')   #15/10/06 Sarah add
            UPDATE inaa_t SET inaa017 = 'Y'
             WHERE inaaent = g_enterprise
               AND inaasite = g_site   
               AND inaa001 = l_inpc001
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inaa_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()               
               CALL s_transaction_end('N','0')
               LET l_flag = 'N'              
               EXIT FOREACH
            END IF                
         END FOREACH 
      ELSE
         UPDATE inaa_t SET inaa017 = 'Y'
          WHERE inaaent = g_enterprise
            AND inaasite = g_site

         IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inaa_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()              
            CALL s_transaction_end('N','0')
            RETURN 
         END IF         
      END IF
      IF l_flag = 'N' THEN
         RETURN  
      END IF
      UPDATE inpa_t SET inpa006 = g_today   
       WHERE inpaent = g_enterprise
         AND inpadocno = g_master.inpadocno
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "inpa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()           
         CALL s_transaction_end('N','0')
         RETURN 
      ELSE
         #160517-00016#1
         UPDATE inpb_t SET inpb002 = 'Y'
          WHERE inpbent = g_enterprise
            AND inpbdocno = g_master.inpadocno
            AND inpb001 = '4'  #存貨凍結            
         #160517-00016#1
      END IF 
      #存貨凍結更新成功
      UPDATE inpb_t SET inpb002 = 'Y',
                        inpb003 = 100,
                        inpb006 = g_user,
                        inpb007 = g_today
       WHERE inpbent = g_enterprise
         AND inpbsite = g_site
         AND inpbdocno = g_master.inpadocno
         AND inpb001 = '4'
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00009"
         LET g_errparam.extend = "inpb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()           
         CALL s_transaction_end('N','0')
         RETURN 
      END IF          
   END IF

   #SELECT * INTO l_inpa.* FROM inpa_t   #161124-00048#4  16/12/09 By 08734 mark
   SELECT inpaent,inpasite,inpadocno,inpadocdt,inpa001,inpa002,inpa003,inpa004,inpa005,inpa006,inpa007,inpa008,inpa009,inpa010,inpa011,inpa012,inpa013,inpa014,inpa015,inpa016,inpa017,inpa018,inpa019,inpa020,inpa021,inpa022,inpa023,inpa024,inpa025,inpa026,inpa027,inpa028,inpa029,
       inpa030,inpa031,inpa032,inpa033,inpa034,inpa035,inpa036,inpa037,inpa038,inpa039,inpa050,inpa051,inpa052,inpa053,inpa054,inpaownid,inpaowndp,inpacrtid,inpacrtdp,inpacrtdt,inpamodid,inpamoddt,inpacnfid,inpacnfdt,inpapstid,inpapstdt,inpastus,inpa040,inpa041,inpa042,inpa043  #161124-00048#4  16/12/09 By 08734 add 
    INTO l_inpa.* FROM inpa_t
    WHERE inpaent = g_enterprise
      AND inpasite = g_site
      AND inpadocno = g_master.inpadocno
   LET l_ac = 1   
   IF g_master.stock = 'Y' THEN   #現有庫存盤點
      LET g_sql3 = " SELECT COUNT(*) FROM inag_t,imaf_t ",
                   "  WHERE inagent = imafent ",
                   "    AND inagsite = imafsite ",
                   "    AND inag001 = imaf001 ",
                   "    AND inagent = '",g_enterprise,"'",
                   "    AND inagsite = '",g_site,"'" 
      IF l_cnt_xd > 0 THEN 
         LET g_sql3 = g_sql3," AND inag004 IN (",
                           " SELECT inpc001 FROM inpc_t ",
                           "  WHERE inpcent = '",g_enterprise,"'",
                           "    AND inpcsite = '",g_site,"'",
                           "    AND inpcdocno = '",g_master.inpadocno,"'",
                           " )"      
      END IF
      IF l_inpa.inpa017 = 'N' THEN
         LET g_sql3 = g_sql3," AND inag008 > 0"
      END IF 
      PREPARE ainp850_inag_count FROM g_sql3
      EXECUTE ainp850_inag_count INTO g_count
      FREE ainp850_inag_count
      IF cl_null(g_count) THEN LET g_count = 0 END IF
   END IF
   
   IF g_master.work = 'Y' THEN   #在製工單盤點
      LET g_sql4 = " SELECT COUNT(*) FROM sfaa_t,sfba_t ",
                   "  WHERE sfaaent = sfbaent ",
                   "    AND sfaadocno = sfbadocno ",
                   "    AND sfaaent = '",g_enterprise,"'",
                   "    AND sfaasite = '",g_site,"'",
                   "    AND sfaa065 = '0' ",
                   "    AND sfba013 > 0 "
      PREPARE ainp850_sfaa_count FROM g_sql4
      EXECUTE ainp850_sfaa_count INTO g_count2
      IF cl_null(g_count2) THEN LET g_count2 = 0 END IF      
   END IF    
   LET g_count = g_count + g_count2   
   IF g_master.number1 <> 0 THEN
      LET g_count = g_count + g_master.number1
   END IF
    IF g_master.number2 <> 0 THEN
       LET g_count = g_count + g_master.number2
   END IF  
   IF g_master.stock = 'Y' AND NOT cl_null(l_inpa.inpa018) THEN   #現有庫存盤點
      #LET g_sql = " SELECT * FROM inag_t,imaf_t ",  #161124-00048#4  16/12/09 By 08734 mark
      LET g_sql = " SELECT inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,inag009,inag010,inag011,inag012,inag013,inag014,inag015,inag016,inag017,inag018,inag019,inag020,inag021,inag022,inag023,inag024,inag025,inag026,inag027,inag028,inag029,inag030,inag031,inag032,inag033,imafent,imafsite,imaf001,imaf011,imaf012,imaf013,imaf014,imaf015,imaf016,imaf017,imaf018,imaf021,imaf022,imaf023,imaf024,imaf025,imaf026,imaf027,imaf031,imaf032,imaf033,imaf034,imaf035,imaf051,imaf052,imaf053,imaf054,imaf055,imaf056,imaf057,imaf058,",  #161124-00048#4  16/12/09 By 08734 add
                  "imaf059,imaf061,imaf062,imaf063,imaf064,imaf071,imaf072,imaf073,imaf074,imaf081,imaf082,imaf083,imaf084,imaf091,imaf092,imaf093,imaf094,imaf095,imaf096,imaf097,imaf101,imaf102,imaf111,imaf112,imaf113,imaf114,imaf115,imaf116,imaf117,imaf118,imaf121,imaf122,imaf123,imaf124,imaf125,imaf126,imaf127,imaf128,imaf141,imaf142,imaf143,imaf144,imaf145,",
                  "imaf146,imaf147,imaf148,imaf149,imaf151,imaf152,imaf153,imaf154,imaf155,imaf156,imaf157,imaf158,imaf161,imaf162,imaf163,imaf164,imaf165,imaf166,imaf171,imaf172,imaf173,imaf174,imaf175,imaf176,imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt,imafstus,imafud001,imafud002,imafud003,imafud004,imafud005,imafud006,imafud007,imafud008,imafud009,imafud010,imafud011,imafud012,imafud013,imafud014,imafud015,imafud016,imafud017,imafud018,imafud019,imafud020,imafud021,imafud022,imafud023,imafud024,imafud025,imafud026,imafud027,imafud028,imafud029,imafud030,imaf177,imaf178,imaf179,imaf129,imaf130 FROM inag_t,imaf_t ",
                  "  WHERE inagent = imafent ",
                  "    AND inagsite = imafsite ",
                  "    AND inag001 = imaf001 ",
                  "    AND inagent = '",g_enterprise,"'",
                  "    AND inagsite = '",g_site,"'"
                  
      IF l_cnt_xd > 0 THEN             
         LET g_sql = g_sql," AND inag004 IN (",
                           " SELECT inpc001 FROM inpc_t ",
                           "  WHERE inpcent = '",g_enterprise,"'",
                           "    AND inpcsite = '",g_site,"'",
                           "    AND inpcdocno = '",g_master.inpadocno,"'",
                           " )"
                     
      END IF         
      IF l_inpa.inpa017 = 'N' THEN
         LET g_sql = g_sql," AND inag008 > 0"
      END IF   
      CALL ainp850_inpd_order(l_inpa.inpa025,TRUE,l_inpa.inpa031)
      CALL ainp850_inpd_order(l_inpa.inpa026,FALSE,l_inpa.inpa031)
      CALL ainp850_inpd_order(l_inpa.inpa027,FALSE,l_inpa.inpa031)
      CALL ainp850_inpd_order(l_inpa.inpa028,FALSE,l_inpa.inpa031)
      CALL ainp850_inpd_order(l_inpa.inpa029,FALSE,l_inpa.inpa031)
      CALL ainp850_inpd_order(l_inpa.inpa030,FALSE,l_inpa.inpa031)
      
      PREPARE ainp850_inag_pre FROM g_sql
      DECLARE ainp850_inag_cur CURSOR FOR ainp850_inag_pre    
      IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
         IF NOT cl_null(l_inpa.inpa018) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa018,g_today,'aint830') 
                 RETURNING r_success,g_inpddocno            
         END IF
      END IF
      
      FOREACH ainp850_inag_cur INTO l_inag.*,l_imaf.*
         CALL ainp850_progress_show('2')   #15/10/06 Sarah add
         INITIALIZE l_inpd.* TO NULL
         IF l_inpa.inpa020 = '2' THEN   #同盤點卡號用項次呈現  
            LET l_inpd.inpddocno = g_inpddocno 
            SELECT MAX(inpdseq)+1 INTO l_inpd.inpdseq FROM inpd_t
             WHERE inpdent = g_enterprise
               AND inpdsite = g_site
               AND inpddocno = g_inpddocno
            IF cl_null(l_inpd.inpdseq) THEN LET l_inpd.inpdseq = 1 END IF   
         ELSE     #一料一卡號
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa018,g_today,'aint830') 
                 RETURNING r_success,l_inpd.inpddocno     
            LET l_inpd.inpdseq = 0     
         END IF  
         LET l_inpd.inpd001 = l_inag.inag001
         LET l_inpd.inpd002 = l_inag.inag002
         LET l_inpd.inpd003 = l_inag.inag003     
         LET l_inpd.inpd005 = l_inag.inag004
         LET l_inpd.inpd006 = l_inag.inag005
         LET l_inpd.inpd007 = l_inag.inag006   
         LET l_inpd.inpd008 = g_master.inpadocno       
         LET l_inpd.inpd009 = 'N'    
         LET l_inpd.inpd010 = l_inag.inag007
         LET l_inpd.inpd012 = l_inag.inag024
         LET l_inpd.inpd013 = l_inag.inag025  #160504-00019#3  #参考数量
         LET l_inpd.inpd011 = l_inag.inag008    
         LET l_inpd.inpd016 = g_user
         LET l_inpd.inpd017 = g_today   
        
         IF l_inpa.inpa008 = '2' THEN   #盤差輸入
            IF l_inpa.inpa009 = 'Y' THEN
               LET l_inpd.inpd030 = l_inag.inag008
               LET l_inpd.inpd031 = l_inag.inag025
            END IF
            IF l_inpa.inpa010 = 'Y' THEN
               LET l_inpd.inpd036 = l_inag.inag008
               LET l_inpd.inpd037 = l_inag.inag025
            END IF       
            IF l_inpa.inpa011 = 'Y' THEN
               LET l_inpd.inpd050 = l_inag.inag008
               LET l_inpd.inpd051 = l_inag.inag025            
            END IF   
            IF l_inpa.inpa012 = 'Y' THEN
               LET l_inpd.inpd056 = l_inag.inag008
               LET l_inpd.inpd057= l_inag.inag025            
            END IF
         ELSE    #全輸入
            #mark by lixh 20150324
#            LET l_inpd.inpd030 = 0
#            LET l_inpd.inpd031 = 0
#            LET l_inpd.inpd036 = 0
#            LET l_inpd.inpd037 = 0
#            LET l_inpd.inpd050 = 0
#            LET l_inpd.inpd051 = 0
#            LET l_inpd.inpd056 = 0
#            LET l_inpd.inpd057 = 0
            #mark by lixh 20150324
            #add by lixh 20150324
            LET l_inpd.inpd030 = ''
            LET l_inpd.inpd031 = ''
            LET l_inpd.inpd036 = ''
            LET l_inpd.inpd037 = ''
            LET l_inpd.inpd050 = ''
            LET l_inpd.inpd051 = ''
            LET l_inpd.inpd056 = ''
            LET l_inpd.inpd057 = ''
            #add by lixh 20150324            
         END IF
         LET l_inpd.inpdownid = g_user
         LET l_inpd.inpdowndp = g_dept
         LET l_inpd.inpdcrtid = g_user
         LET l_inpd.inpdcrtdp = g_dept  
         LET l_inpd.inpdcrtdt = g_today
         LET l_inpd.inpdstus = 'N'           
         INSERT INTO inpd_t (inpdent,inpdsite,inpddocno,inpdseq,inpd001,inpd002,inpd003,inpd005,inpd006,inpd007,inpd008,inpd009,
                             inpd010,inpd011,inpd012,inpd013,inpd016,inpd017,inpd030,inpd031,inpd036,inpd037,inpd050,inpd051,inpd056,inpd057,
                             inpdownid,inpdowndp,inpdcrtid,inpdcrtdp,inpdcrtdt,inpdstus) 
                             
                     VALUES (g_enterprise,g_site,l_inpd.inpddocno,l_inpd.inpdseq,l_inpd.inpd001,l_inpd.inpd002,l_inpd.inpd003,l_inpd.inpd005,l_inpd.inpd006,l_inpd.inpd007,l_inpd.inpd008,l_inpd.inpd009,
                             l_inpd.inpd010,l_inpd.inpd011,l_inpd.inpd012,l_inpd.inpd013,l_inpd.inpd016,l_inpd.inpd017,l_inpd.inpd030,l_inpd.inpd031,l_inpd.inpd036,l_inpd.inpd037,l_inpd.inpd050,l_inpd.inpd051,l_inpd.inpd056,l_inpd.inpd057,
                             l_inpd.inpdownid,l_inpd.inpdowndp,l_inpd.inpdcrtid,l_inpd.inpdcrtdp,l_inpd.inpdcrtdt,l_inpd.inpdstus)   #160504-00019#3  #add 参考数量

         IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpe_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()              
            CALL s_transaction_end('N','0')
            RETURN                
         END IF 

         SELECT imaf071,imaf081
           INTO l_imaf071,l_imaf081
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_inpd.inpd001

         #160517-00029#1   2016/05/24 By earl add s
         LET g_datetime = cl_get_current()
         
         INITIALIZE l_sub_param.* TO NULL
         LET l_sub_param.cmd       = '1'              #1.INSERT 2.UPDATE
         LET l_sub_param.inpa017   = l_inpa.inpa017   #包含已無庫存量
         LET l_sub_param.inpa008   = l_inpa.inpa008   #盤點輸入方式
         LET l_sub_param.inpa009   = l_inpa.inpa009   #現有庫存初盤一
         LET l_sub_param.inpa010   = l_inpa.inpa010   #現有庫存初盤二
         LET l_sub_param.inpa011   = l_inpa.inpa011   #現有庫存複盤一
         LET l_sub_param.inpa012   = l_inpa.inpa012   #現有庫存複盤二
         LET l_sub_param.datatime  = g_datetime       #異動時間
         LET l_sub_param.inpddocno = l_inpd.inpddocno #標籤編號
         LET l_sub_param.inpdseq   = l_inpd.inpdseq   #項次
         LET l_sub_param.inpd008   = l_inpd.inpd008   #盤點計畫單號
         LET l_sub_param.inpd009   = l_inpd.inpd009   #空白標籤
         LET l_sub_param.inpdownid = l_inpd.inpdownid  
         LET l_sub_param.inpdowndp = l_inpd.inpdowndp  
         LET l_sub_param.inpdcrtid = l_inpd.inpdcrtid  
         LET l_sub_param.inpdcrtdp = l_inpd.inpdcrtdp  
         LET l_sub_param.inpd001   = l_inpd.inpd001   #料件編號
         LET l_sub_param.inpd002   = l_inpd.inpd002   #產品特徵
         LET l_sub_param.inpd003   = l_inpd.inpd003   #庫存管理特徵
         LET l_sub_param.inpd005   = l_inpd.inpd005   #庫位編號
         LET l_sub_param.inpd006   = l_inpd.inpd006   #儲位編號
         LET l_sub_param.inpd007   = l_inpd.inpd007   #批號
         LET l_sub_param.inpd010   = l_inpd.inpd010   #庫存單位
         LET l_sub_param.inpd012   = l_inpd.inpd012   #參考單位
         
         LET l_sub_js = util.JSON.stringify(l_sub_param)
         IF NOT s_abci200_bcah(l_sub_js) THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         #160517-00029#1   2016/05/24 By earl add e

         IF l_imaf071 <>'2' OR l_imaf081 <>'2' THEN   #批序號管理
            #160512-00004#1 by whitney modify start
            #LET l_sql = " SELECT * FROM inai_t ",
            #LET l_sql = " SELECT inae010,inai_t.* FROM inai_t ",  #161124-00048#4  16/12/09 By 08734 mark
            LET l_sql = " SELECT inae010,inaient,inaisite,inai001,inai002,inai003,inai004,inai005,inai006,inai007,inai008,inai009,inai010,inai011,inai012,inai013,inai014 FROM inai_t ",  #161124-00048#4  16/12/09 By 08734 add
                        "   LEFT JOIN inae_t ON inaeent=inaient AND inae001=inai001 AND inaesite=inaisite AND inae002=inai002 AND inae003=inai007 AND inae004=inai008 ",
            #160512-00004#1 by whitney modify end
                        "  WHERE inaient = '",g_enterprise,"'",
                        "    AND inai001 = '",l_inpd.inpd001,"'",
                        "    AND inai002 = '",l_inpd.inpd002,"'",
                        "    AND inai003 = '",l_inpd.inpd003,"'",
                        "    AND inai004 = '",l_inpd.inpd005,"'",
                        "    AND inai005 = '",l_inpd.inpd006,"'",
                        "    AND inai006 = '",l_inpd.inpd007,"'",
                        "    AND inai009 = '",l_inpd.inpd010,"'"
            PREPARE ainp850_inai_pre FROM l_sql
            DECLARE ainp850_inai_cur CURSOR FOR ainp850_inai_pre
            LET l_inpe.inpeent = g_enterprise
            LET l_inpe.inpesite = g_site
            LET l_inpe.inpedocno = l_inpd.inpddocno
            LET l_inpe.inpeseq = l_inpd.inpdseq
            LET l_inpe.inpe001 = l_inpd.inpd001
            LET l_inpe.inpe002 = l_inpd.inpd002
            LET l_inpe.inpe003 = l_inpd.inpd003
            LET l_inpe.inpe004 = l_inpd.inpd004
            LET l_inpe.inpe005 = l_inpd.inpd005
            LET l_inpe.inpe006 = l_inpd.inpd006
            LET l_inpe.inpe007 = l_inpd.inpd007
            FOREACH ainp850_inai_cur INTO l_inae010,l_inai.*  #160512-00004#1 by whitney add l_inae010
               SELECT MAX(inpeseq2)+1 INTO l_inpe.inpeseq2 FROM inpe_t
                WHERE inpeent = g_enterprise
                  AND inpesite = g_site
                  AND inpedocno = l_inpe.inpedocno
                  AND inpeseq = l_inpe.inpeseq
               IF cl_null(l_inpe.inpeseq2) THEN
                  LET l_inpe.inpeseq2 = 1
               END IF 
               LET l_inpe.inpe008 = l_inai.inai007
               LET l_inpe.inpe009 = l_inai.inai008
               LET l_inpe.inpe012 = l_inai.inai011
               LET l_inpe.inpe010 = l_inae010  #160512-00004#1 by whitney modify l_inai.inai012->l_inae010
               IF l_inpa.inpa008 = '2' THEN   #盤差輸入
                  LET l_inpe.inpe030 = l_inai.inai010
                  IF l_inpa.inpa010 = 'Y' THEN
                     LET l_inpe.inpe035 = l_inai.inai010
                  END IF
                  IF l_inpa.inpa011 = 'Y' THEN
                     LET l_inpe.inpe050 = l_inai.inai010
                  END IF 
                  IF l_inpa.inpa012 = 'Y' THEN
                     LET l_inpe.inpe055 = l_inai.inai010
                  END IF  
               ELSE
                  #mark by lixh 20150324
#                  LET l_inpe.inpe030 = 0
#                  LET l_inpe.inpe035 = 0
#                  LET l_inpe.inpe050 = 0
#                  LET l_inpe.inpe055 = 0
                  #mark by lixh 20150324               
                  #add by lixh 20150324
                  LET l_inpe.inpe030 = ''
                  LET l_inpe.inpe035 = ''
                  LET l_inpe.inpe050 = ''
                  LET l_inpe.inpe055 = ''
                  #add by lixh 20150324
               END IF         
               INSERT INTO inpe_t (inpeent,inpesite,inpedocno,inpeseq,inpeseq2,inpe001,inpe002,inpe003,inpe004,inpe005,
                                   inpe006,inpe007,inpe008,inpe009,inpe010,inpe012,inpe030,inpe035,inpe050,inpe055)                                  
                           VALUES (l_inpe.inpeent,l_inpe.inpesite,l_inpe.inpedocno,l_inpe.inpeseq,l_inpe.inpeseq2,l_inpe.inpe001,
                                   l_inpe.inpe002,l_inpe.inpe003,l_inpe.inpe004,l_inpe.inpe005,l_inpe.inpe006,l_inpe.inpe007,l_inpe.inpe008,
                                   l_inpe.inpe009,l_inpe.inpe010,l_inpe.inpe012,l_inpe.inpe030,l_inpe.inpe035,l_inpe.inpe050,l_inpe.inpe055)      
               IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "inpe_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
                  CALL s_transaction_end('N','0')
                  RETURN                
               END IF                                    
            END FOREACH            
         END IF     
         LET g_master.stagenow = l_inpd.inpd001
         DISPLAY g_master.stagenow TO stagenow 
         LET g_stagecomplete = l_ac/g_count 
         IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
            LET g_stagecomplete = 40
         END IF   
         IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
            DISPLAY g_stagecomplete TO stagecomplete
         END IF   
         CALL ui.Interface.refresh() 
         LET l_ac = l_ac + 1         
         INITIALIZE l_inag.* TO NULL
         INITIALIZE l_inai.* TO NULL
      END FOREACH
      END IF  #add by lixh 1024
      IF g_master.blank1 = 'Y' AND g_master.number1 > 0 AND NOT cl_null(l_inpa.inpa019) THEN   #產生空白標籤
         IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
            IF NOT cl_null(l_inpa.inpa019) THEN
               CALL s_aooi200_gen_docno(g_site,l_inpa.inpa019,g_today,'aint830') 
                    RETURNING r_success,g_inpddocno            
            END IF
         END IF   
         FOR l_i = 1 TO g_master.number1
             CALL ainp850_progress_show('3')   #15/10/06 Sarah add
             INITIALIZE l_inpd.* TO NULL
             
             IF l_inpa.inpa020 = '2' THEN  #同盤點卡號用項次呈現
                LET l_inpd.inpddocno = g_inpddocno 
                SELECT MAX(inpdseq)+1 INTO l_inpd.inpdseq FROM inpd_t
                 WHERE inpdent = g_enterprise
                   AND inpdsite = g_site
                   AND inpddocno = g_inpddocno    
                IF cl_null(l_inpd.inpdseq) THEN LET l_inpd.inpdseq = 1 END IF      
             ELSE
                #一料一盤點卡號 =>不同資料，依序增加   
                LET g_inpddocno = ''
                CALL s_aooi200_gen_docno(g_site,l_inpa.inpa019,g_today,'aint830')    
                     RETURNING r_success,g_inpddocno      
                LET l_inpd.inpddocno = g_inpddocno    
                LET l_inpd.inpdseq = 0                   
             END IF
             
             LET l_inpd.inpd008 = g_master.inpadocno
             LET l_inpd.inpd009 ='Y'
             LET l_inpd.inpd016 = g_user
             LET l_inpd.inpd017 = g_today   
             LET l_inpd.inpdownid = g_user
             LET l_inpd.inpdowndp = g_dept
             LET l_inpd.inpdcrtid = g_user
             LET l_inpd.inpdcrtdp = g_dept  
             LET l_inpd.inpdcrtdt = g_today
             LET l_inpd.inpdstus = 'N'
             #20150929 DSC.liquor add-------
             LET l_inpd.inpd030 = ''
             LET l_inpd.inpd031 = ''
             LET l_inpd.inpd036 = ''
             LET l_inpd.inpd037 = ''
             LET l_inpd.inpd050 = ''
             LET l_inpd.inpd051 = ''
             LET l_inpd.inpd056 = ''
             LET l_inpd.inpd057 = ''
             #20150929 add end--------------
             INSERT INTO inpd_t (inpdent,inpdsite,inpddocno,inpdseq,inpd008,inpd009,inpd016,inpd017,inpdownid,inpdowndp,
                                 inpdcrtid,inpdcrtdp,inpdcrtdt,inpdstus,
                                 inpd030,inpd031,inpd036,inpd037,inpd050,inpd051,inpd056,inpd057)  #20150929 DSC.liquor add
                         VALUES (g_enterprise,g_site,l_inpd.inpddocno,l_inpd.inpdseq,l_inpd.inpd008,l_inpd.inpd009,
                                 l_inpd.inpd016,l_inpd.inpd017,l_inpd.inpdownid,l_inpd.inpdowndp,l_inpd.inpdcrtid,
                                 l_inpd.inpdcrtdp,l_inpd.inpdcrtdt,l_inpd.inpdstus,
                                 l_inpd.inpd030,l_inpd.inpd031,l_inpd.inpd036,l_inpd.inpd037,l_inpd.inpd050,l_inpd.inpd051,l_inpd.inpd056,l_inpd.inpd057)  #20150929 DSC.liquor add 
             IF SQLCA.sqlerrd[3] = 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = "std-00009"
                LET g_errparam.extend = "inpd_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()                     
                CALL s_transaction_end('N','0')
                RETURN                
             END IF      
            LET g_stagecomplete = l_ac/g_count    
            IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
               LET g_stagecomplete = 40
            END IF                
            IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
               DISPLAY g_stagecomplete TO stagecomplete
            END IF   
            CALL ui.Interface.refresh() 
            LET l_ac = l_ac + 1                 
         END FOR        
      END IF 
#   END IF
   IF g_master.work = 'Y' AND NOT cl_null(l_inpa.inpa021) THEN   #在製工單盤點
#      LET g_sql1 = " SELECT * FROM sfaa_t,sfba_t ",
      LET g_sql1 = " SELECT DISTINCT sfaadocno,sfaa010,sfaa017,sfaa012,sfaa013,sfaa016,sfaa049,sfaa050,sfaa051,sfaa056,NVL(sfba003,' ') AS sfba003,sfaa020,sfaastus,sfaa003 FROM sfaa_t,sfba_t ",   #add by lixh 20151217 sfba003 => NVL(sfba003,' ') AS sfba003
                   "  WHERE sfaaent = sfbaent ",
                   "    AND sfaadocno = sfbadocno ",
                   "    AND sfaaent = '",g_enterprise,"'",
                   "    AND sfaasite = '",g_site,"'",
                   "    AND sfaa065 = '0' ",
                   "    AND sfba013 > 0 ",
                   "    AND sfba003 is not null ",  #151222-00007 DSC.liquor add
                   "  ORDER BY sfaadocno,sfba003"
      CALL ainp850_inpf_order(l_inpa.inpa032,TRUE) 
      CALL ainp850_inpf_order(l_inpa.inpa033,FALSE)      
      CALL ainp850_inpf_order(l_inpa.inpa034,FALSE) 
      CALL ainp850_inpf_order(l_inpa.inpa035,FALSE) 
      CALL ainp850_inpf_order(l_inpa.inpa036,FALSE) 
      CALL ainp850_inpf_order(l_inpa.inpa037,FALSE) 
      
      PREPARE ainp850_sfaa_pre FROM g_sql1
      DECLARE ainp850_sfaa_cur CURSOR FOR ainp850_sfaa_pre  
      IF l_inpa.inpa020 = '2' THEN  #同盤點卡號，用項次呈現
         IF NOT cl_null(l_inpa.inpa021) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa021,g_today,'aint835')    
                RETURNING r_success,g_inpddocno         
         END IF
      END IF      
      LET l_sfbadocno_t = ''
      LET l_sfba003_t = ''
#      FOREACH ainp850_sfaa_cur INTO l_sfaa.*,l_sfba.*
      FOREACH ainp850_sfaa_cur INTO l_sfaa.sfaadocno,l_sfaa.sfaa010,l_sfaa.sfaa017,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa016,l_sfaa.sfaa049,l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa056,l_sfba.sfba003,
                                    l_sfaa020,l_sfaastus,l_sfaa003
         CALL ainp850_progress_show('4')   #15/10/06 Sarah add
         LET l_flag2  = 'N'   #add by lixh 20150723                           
         IF cl_null(l_sfba.sfba003) THEN LET l_sfba.sfba003 = ' ' END IF
         #add by lixh 20151013
         CALL s_aooi200_get_slip(l_sfaa.sfaadocno) RETURNING l_success,l_slip
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM inpt_t
          WHERE inptent = g_enterprise
            AND inptdocno = g_master.inpadocno 
         IF l_cnt > 0 THEN
            LET l_sql = " SELECT DISTINCT inpt001 FROM inpt_t ",
                        "  WHERE inptent = ",g_enterprise,
                        "    AND inptdocno = '",g_master.inpadocno,"'"
            PREPARE ainp850_inpt_sel FROM l_sql
            DECLARE ainp850_inpt_cur CURSOR FOR ainp850_inpt_sel   
            LET l_yes = 'N' 
            FOREACH ainp850_inpt_cur INTO l_inpt001
               IF l_slip = l_inpt001 THEN
                  LET l_yes = 'Y'
                  EXIT FOREACH
               END IF
            END FOREACH
            IF l_yes = 'N' THEN
               CONTINUE FOREACH
            END IF
         END IF
         #add by lixh 20151013
         IF l_inpa.inpa020 = '2' THEN 
            LET l_inpf.inpfdocno = g_inpddocno
#            IF l_sfbadocno_t <> l_sfba.sfbadocno OR l_sfbadocno_t IS NULL OR (l_sfbadocno_t = l_sfba.sfbadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
            IF l_sfbadocno_t <> l_sfaa.sfaadocno OR l_sfbadocno_t IS NULL OR (l_sfbadocno_t = l_sfaa.sfaadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN  
               SELECT MAX(inpfseq)+1 INTO l_inpf.inpfseq FROM inpf_t
                WHERE inpfent = g_enterprise
                  AND inpfsite = g_site
                  AND inpfdocno = g_inpddocno
               IF cl_null(l_inpf.inpfseq) THEN LET l_inpf.inpfseq = 1 END IF
               LET l_sfbadocno_t = l_sfaa.sfaadocno
               LET l_sfba003_t = l_sfba.sfba003
               LET l_flag2  = 'Y'   #add by lixh 20150723
            END IF
         ELSE
            IF NOT cl_null(l_inpa.inpa021) THEN
               IF l_sfbadocno_t <> l_sfaa.sfaadocno OR l_sfbadocno_t IS NULL OR (l_sfbadocno_t = l_sfaa.sfaadocno  AND (l_sfba003_t <> l_sfba.sfba003)) THEN
                  CALL s_aooi200_gen_docno(g_site,l_inpa.inpa021,g_today,'aint835')    
                       RETURNING r_success,g_inpddocno 
                  LET l_sfbadocno_t = l_sfaa.sfaadocno
                  LET l_sfba003_t = l_sfba.sfba003
                  LET l_flag2  = 'Y'   #add by lixh 20150723                  
               END IF                   
            END IF      
            LET l_inpf.inpfdocno = g_inpddocno
            LET l_inpf.inpfseq = 0
         END IF  
         IF l_flag2  = 'Y' THEN  #add by lixh 20150723
            LET l_inpf.inpf001 = l_sfaa.sfaadocno
            LET l_inpf.inpf002 = l_sfba.sfba003
            LET l_inpf.inpf003 = l_sfaa.sfaa010
            LET l_inpf.inpf004 = g_master.inpadocno
            LET l_inpf.inpf005 = 'N'
            LET l_inpf.inpf006 = l_sfaa.sfaa017
            LET l_inpf.inpf007 = l_sfaa.sfaa012
            LET l_inpf.inpf008 = l_sfaa.sfaa013
            LET l_inpf.inpf009 = l_sfaa.sfaa016
            LET l_inpf.inpf010 = l_sfaa.sfaa049
            LET l_inpf.inpf011 = l_sfaa.sfaa050
            LET l_inpf.inpf012 = l_sfaa.sfaa051
            LET l_inpf.inpf013 = l_sfaa.sfaa056
            LET l_inpf.inpf015 = g_user
            LET l_inpf.inpf016 = g_today
            LET l_inpf.inpfownid = g_user
            LET l_inpf.inpfowndp = g_dept
            LET l_inpf.inpfcrtid = g_user
            LET l_inpf.inpfcrtdp = g_dept
            LET l_inpf.inpfcrtdt = g_today
            LET l_inpf.inpfstus = 'N'
            INSERT INTO inpf_t (inpfent,inpfsite,inpfdocno,inpfseq,inpf001,inpf002,inpf003,inpf004,inpf005,inpf006,inpf007,inpf008,inpf009,
                                inpf010,inpf011,inpf012,inpf013,inpf015,inpf016,inpfownid,inpfowndp,inpfcrtid,inpfcrtdp,inpfcrtdt,inpfstus)
                        VALUES (g_enterprise,g_site,l_inpf.inpfdocno,l_inpf.inpfseq,l_inpf.inpf001,l_inpf.inpf002,l_inpf.inpf003,l_inpf.inpf004,
                                l_inpf.inpf005,l_inpf.inpf006,l_inpf.inpf007,l_inpf.inpf008,l_inpf.inpf009,l_inpf.inpf010,l_inpf.inpf011,l_inpf.inpf012,
                                l_inpf.inpf013,l_inpf.inpf015,l_inpf.inpf016,l_inpf.inpfownid,l_inpf.inpfowndp,l_inpf.inpfcrtid,l_inpf.inpfcrtdp,l_inpf.inpfcrtdt,
                                l_inpf.inpfstus)
            IF SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "inpf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
               CALL s_transaction_end('N','0')
               RETURN                
            END IF  
         END IF  #add by lixh 20150723 
         LET g_master.stagenow = l_inpf.inpf003
         DISPLAY g_master.stagenow TO stagenow   
         
         #LET g_sql2 = " SELECT * FROM sfba_t",  #161124-00048#4  16/12/09 By 08734 mark
         LET g_sql2 = " SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005,sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015,sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025,sfba026,sfba027,sfba028,sfba029,sfba030,sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005,sfbaud006,sfbaud007,",
                      " sfbaud008,sfbaud009,sfbaud010,sfbaud011,sfbaud012,sfbaud013,sfbaud014,sfbaud015,sfbaud016,sfbaud017,sfbaud018,sfbaud019,sfbaud020,sfbaud021,sfbaud022,sfbaud023,sfbaud024,sfbaud025,sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030,sfba031,sfba032,sfba033,sfba034,sfba035 FROM sfba_t",  #161124-00048#4  16/12/09 By 08734 add
                      "  WHERE sfbaent = '",g_enterprise,"'",
                      "    AND sfbadocno = '",l_inpf.inpf001,"'",
                      "    AND sfba003 = '",l_sfba.sfba003,"'",
                      "    AND sfbasite = '",g_site,"'"

         PREPARE ainp850_sfba_pre FROM g_sql2
         DECLARE ainp850_sfba_cur CURSOR FOR ainp850_sfba_pre   
         FOREACH ainp850_sfba_cur INTO l_sfba.*
            LET l_inpg.inpgdocno = l_inpf.inpfdocno
            LET l_inpg.inpgseq = l_inpf.inpfseq
            LET l_inpg.inpgseq1 = l_sfba.sfbaseq   #151222-00007 DSC.liquor 取消mark
            LET l_inpg.inpgseq2 = l_sfba.sfbaseq1  #151222-00007 DSC.liquor 取消mark
            #151222-00007 DSC.liquor mark 項次、項序應該直接抓工單的
            #add by lixh 20151023
            #LET l_inpg.inpgseq1 = l_sfba.sfbaseq1    
            #SELECT MAX(inpgseq2)+1 INTO l_inpg.inpgseq2 FROM inpg_t
            # WHERE inpgent = g_enterprise
            #   AND inpgsite = g_site
            #   AND inpgdocno = l_inpg.inpgdocno
            #   AND inpgseq = l_inpg.inpgseq
            #   AND inpgseq1 = l_inpg.inpgseq1
            #IF cl_null(l_inpg.inpgseq2) THEN LET l_inpg.inpgseq2 = 1 END IF   
            #add by lixh 20151023 
            #151222-00007 mark end----------
            LET l_inpg.inpg001 = l_sfba.sfba006
            LET l_inpg.inpg002 = l_sfba.sfba003
            LET l_inpg.inpg003 = l_sfba.sfba004
            #20150929 DSC.liquor add---
            #替代料的QPA要抓主料的
            IF l_sfba.sfbaseq1 <> 0 THEN
               SELECT sfba010,sfba011 INTO l_sfba.sfba010,l_sfba.sfba011
                 FROM sfba_t
                  WHERE sfbadocno=l_sfba.sfbadocno
                    AND sfbaent=l_sfba.sfbaent
                    AND sfbasite=l_sfba.sfbasite
                    AND sfbaseq=l_sfba.sfbaseq
                    AND sfbaseq1=0
            END IF
            #20150929 add end----------
            #151222-00007 DSC.liquor 調整標準QPA、實際QPA算法
            #LET l_inpg.inpg004 = l_sfba.sfba010
            #LET l_inpg.inpg005 = l_sfba.sfba011
            LET l_inpg.inpg004 = l_sfba.sfba010 / l_sfba.sfba011 #標準QPA分子/分母
            LET l_inpg.inpg005 = l_sfba.sfba010 / l_sfba.sfba011 #標準QPA分子/分母
            #151222-00007 mod end--------------------------            
            LET l_inpg.inpg006 = l_sfba.sfba013
            LET l_inpg.inpg007 = l_sfba.sfba014
            LET l_inpg.inpg008 = l_sfba.sfba016
            LET l_inpg.inpg009 = l_sfba.sfba017
            LET l_inpg.inpg010 = l_sfba.sfba030   #指定庫存管理特征
            LET l_inpg.inpg011 = l_sfba.sfba025
            IF cl_null(l_sfaa.sfaa050) THEN LET l_sfaa.sfaa050 = 0 END IF
            IF cl_null(l_sfaa.sfaa056) THEN LET l_sfaa.sfaa056 = 0 END IF
            IF cl_null(l_sfba.sfba010) THEN LET l_sfba.sfba010 = 0 END IF
            IF cl_null(l_sfba.sfba011) THEN LET l_sfba.sfba011 = 0 END IF
            IF cl_null(l_sfba.sfba017) THEN LET l_sfba.sfba017 = 0 END IF            
            LET l_inpg.inpg012 = (l_sfaa.sfaa050+l_sfaa.sfaa056)*(l_sfba.sfba010/l_sfba.sfba011)+l_sfba.sfba017
            LET l_inpg.inpg012 = l_inpg.inpg008 + l_inpg.inpg011 - l_inpg.inpg012
            #20150929 DSC.liquor add
            IF l_inpg.inpg012 < 0 THEN
               LET l_inpg.inpg012 = 0
            END IF
            #20150929 add end-----
            IF l_inpa.inpa008 = '1' THEN   #全盤輸入
               #mark by lixh 20150324
#               LET l_inpg.inpg030 = 0
#               LET l_inpg.inpg033 = 0
#               LET l_inpg.inpg050 = 0
#               LET l_inpg.inpg053 = 0
               #mark by lixh 20150324
               #add by lixh 20150324
               LET l_inpg.inpg030 = ''
               LET l_inpg.inpg033 = ''
               LET l_inpg.inpg050 = ''
               LET l_inpg.inpg053 = ''
               #add by lixh 20150324               
            END IF
            IF l_inpa.inpa008 = '2' THEN   #盘差输入
               IF l_inpa.inpa013 = 'Y' THEN  #add by lixh 20150402
                  LET l_inpg.inpg030 = l_inpg.inpg012
               END IF   #add by lixh 20150402
               IF l_inpa.inpa014 = 'Y' THEN  #add by lixh 20150402
                  LET l_inpg.inpg033 = l_inpg.inpg012
               END IF
               IF l_inpa.inpa015 = 'Y' THEN  #add by lixh 20150402               
                  LET l_inpg.inpg050 = l_inpg.inpg012
               END IF
               IF l_inpa.inpa016 = 'Y' THEN  #add by lixh 20150402               
                  LET l_inpg.inpg053 = l_inpg.inpg012  
               END IF                  
            END IF
            LET l_inpg.inpg015 = l_sfba.sfba021 #產品特徵            
            INSERT INTO inpg_t (inpgent,inpgsite,inpgdocno,inpgseq,inpgseq1,inpgseq2,inpg001,inpg002,inpg003,inpg004,
                               inpg005,inpg006,inpg007,inpg008,inpg009,inpg010,inpg011,inpg012,inpg015,inpg030,inpg033,inpg050,inpg053)
                                  
                        VALUES(g_enterprise,g_site,l_inpg.inpgdocno,l_inpg.inpgseq,l_inpg.inpgseq1,l_inpg.inpgseq2,l_inpg.inpg001,l_inpg.inpg002,l_inpg.inpg003,l_inpg.inpg004,
                               l_inpg.inpg005,l_inpg.inpg006,l_inpg.inpg007,l_inpg.inpg008,l_inpg.inpg009,l_inpg.inpg010,l_inpg.inpg011,l_inpg.inpg012,l_inpg.inpg015,
                               l_inpg.inpg030,l_inpg.inpg033,l_inpg.inpg050,l_inpg.inpg053) 
         LET g_master.stagenow = l_inpf.inpf003   #add by lixh 20150125
         DISPLAY g_master.stagenow TO stagenow                                
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpg_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
               CALL s_transaction_end('N','0')
               RETURN                
            END IF                               
         END FOREACH  
         LET g_master.stagenow = l_inpf.inpf003
         DISPLAY g_master.stagenow TO stagenow 
         LET g_stagecomplete = l_ac/g_count 
         IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
            LET g_stagecomplete = 40
         END IF          
         IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
            DISPLAY g_stagecomplete TO stagecomplete
         END IF   
         CALL ui.Interface.refresh() 
         LET l_ac = l_ac + 1           
      END FOREACH
      END IF    #add by lixh 1024
      IF g_master.blank2 = 'Y' AND NOT cl_null(l_inpa.inpa022) THEN   #產生在製程工單空白標籤
         LET g_inpddocno = ''
         IF NOT cl_null(l_inpa.inpa022) THEN
            CALL s_aooi200_gen_docno(g_site,l_inpa.inpa022,g_today,'aint835')    
                 RETURNING r_success,g_inpddocno            
         END IF
      　 FOR l_i = 1 TO g_master.number2
             CALL ainp850_progress_show('5')   #15/10/06 Sarah add
             IF l_inpa.inpa020 = '2' THEN    #同盤點卡
                LET l_inpf.inpfdocno = g_inpddocno
                LET l_inpf.inpfseq = l_i
             END IF
             IF l_inpa.inpa020 = '1' THEN    #一料一盤點卡
                CALL s_aooi200_gen_docno(g_site,l_inpa.inpa022,g_today,'aint835')    
                     RETURNING r_success,g_inpddocno 
                LET l_inpf.inpfdocno = g_inpddocno     
                LET l_inpf.inpfseq = 0
             END IF   
             LET l_inpf.inpf004 = g_master.inpadocno             
             LET l_inpf.inpf005 = 'Y'
             LET l_inpf.inpf015 = g_user
             LET l_inpf.inpf016 = g_today     
             LET l_inpf.inpfownid = g_user
             LET l_inpf.inpfowndp = g_dept
             LET l_inpf.inpfcrtid = g_user
             LET l_inpf.inpfcrtdp = g_dept
             LET l_inpf.inpfcrtdt = g_today
             LET l_inpf.inpfstus = 'N'       
             INSERT INTO inpf_t (inpfent,inpfsite,inpfdocno,inpfseq,inpf004,inpf005,inpf015,inpf016,inpfownid,inpfowndp,inpfcrtid,
                                 inpfcrtdp,inpfcrtdt,inpfstus)
                         VALUES (g_enterprise,g_site,l_inpf.inpfdocno,l_inpf.inpfseq,l_inpf.inpf004,l_inpf.inpf005,l_inpf.inpf015,l_inpf.inpf016,
                                 l_inpf.inpfownid,l_inpf.inpfowndp,l_inpf.inpfcrtid,l_inpf.inpfcrtdp,l_inpf.inpfcrtdt,l_inpf.inpfstus) 
            IF SQLCA.sqlerrd[3] = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inpf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
               CALL s_transaction_end('N','0')
               RETURN                
            END IF   
            LET g_stagecomplete = l_ac/g_count 
            IF g_stagecomplete >= 20 AND g_stagecomplete < = 40 THEN
               LET g_stagecomplete = 40
            END IF             
            IF g_stagecomplete = 40 OR g_stagecomplete = 60 OR g_stagecomplete = 80 OR g_stagecomplete = 100 THEN
               DISPLAY g_stagecomplete TO stagecomplete
            END IF   
            CALL ui.Interface.refresh() 
            LET l_ac = l_ac + 1             
         END FOR
      END IF
#   END IF   
    DISPLAY 100 TO stagecomplete
    
    #170103-00007#1 add  --begin--
    IF g_master.freeze = 'N' AND g_master.stock = 'N' AND g_master.blank1 = 'N' AND g_master.work = 'N' AND g_master.blank2 = 'N' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "ain-00869"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()  
       CALL s_transaction_end('N','0')
       RETURN   
    END IF
    #170103-00007#1 add  --end--
        
   #盤點資料產生執行成功
   IF NOT (g_master.stock = 'N' AND g_master.blank1 = 'N' AND g_master.work = 'N' AND g_master.blank2 = 'N') THEN  #170103-00007#1 add
   UPDATE inpb_t SET inpb002 = 'Y',
                     inpb003 = 100,
                     inpb006 = g_user,
                     inpb007 = g_today
    WHERE inpbent = g_enterprise
      AND inpbsite = g_site
      AND inpbdocno = g_master.inpadocno
      AND inpb001 = '2'
   END IF      #170103-00007#1 add
    #mark by lixh 20150325  
#   IF SQLCA.sqlerrd[3] = 0 THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = "std-00009"
#      LET g_errparam.extend = "inpb_t"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()  
#      CALL s_transaction_end('N','0')
#      RETURN 
#   END IF   
    #mark by lixh 20150325 
   CALL s_transaction_end('Y','0')   
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
   CALL ainp850_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp850.get_buffer" >}
PRIVATE FUNCTION ainp850_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.inpadocno = p_dialog.getFieldBuffer('inpadocno')
   LET g_master.inpa002 = p_dialog.getFieldBuffer('inpa002')
   LET g_master.freeze = p_dialog.getFieldBuffer('freeze')
   LET g_master.inpa005 = p_dialog.getFieldBuffer('inpa005')
   LET g_master.inpa006 = p_dialog.getFieldBuffer('inpa006')
   LET g_master.stock = p_dialog.getFieldBuffer('stock')
   LET g_master.blank1 = p_dialog.getFieldBuffer('blank1')
   LET g_master.number1 = p_dialog.getFieldBuffer('number1')
   LET g_master.work = p_dialog.getFieldBuffer('work')
   LET g_master.blank2 = p_dialog.getFieldBuffer('blank2')
   LET g_master.number2 = p_dialog.getFieldBuffer('number2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp850.msgcentre_notify" >}
PRIVATE FUNCTION ainp850_msgcentre_notify()
 
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
 
{<section id="ainp850.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 人員说明
# Memo...........:
# Usage..........: CALL ainp850_inpa002_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_inpa002_desc()
   SELECT inpa002,inpa005,inpa006 INTO g_master.inpa002,g_master.inpa005,g_master.inpa006 FROM inpa_t 
    WHERE inpaent = g_enterprise
      AND inpadocno = g_master.inpadocno
   CALL s_desc_get_person_desc(g_master.inpa002) RETURNING g_master.inpa002_desc
   DISPLAY BY NAME g_master.inpa002_desc
   DISPLAY BY NAME g_master.inpa005
   DISPLAY BY NAME g_master.inpa006
END FUNCTION

################################################################################
# Descriptions...: 開啟欄位
# Memo...........:
# Usage..........: CALL ainp850_set_entry()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_set_entry()
   CALL cl_set_comp_entry("freeze,stock,work,number1,number2",TRUE) 
END FUNCTION

################################################################################
# Descriptions...: 關閉欄位
# Memo...........:
# Usage..........: CALL ainp850_set_no_entry()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_set_no_entry()
DEFINE   l_inpb002     LIKE inpb_t.inpb002  
DEFINE   l_cnt         LIKE type_t.num5

   IF NOT cl_null(g_master.inpadocno) THEN
      SELECT inpa006 INTO g_master.inpa006 FROM inpa_t
       WHERE inpaent = g_enterprise
         AND inpadocno = g_master.inpadocno
      IF NOT cl_null(g_master.inpa006) THEN
         CALL cl_set_comp_entry("freeze",FALSE) 
      END IF 
      LET l_inpb002 = ''      
      SELECT inpb002 INTO l_inpb002 FROM inpb_t
       WHERE inpbent = g_enterprise
         AND inpbdocno = g_master.inpadocno
         AND inpb001 = '2'
         
      IF l_inpb002 = 'Y' THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM inpd_t 
          WHERE inpdent = g_enterprise
            AND inpdsite = g_site
            AND inpd008 = g_master.inpadocno
         IF l_cnt > 0 THEN   
            CALL cl_set_comp_entry("stock",FALSE)
         END IF   
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM inpf_t 
          WHERE inpfent = g_enterprise
            AND inpfsite = g_site
            AND inpf004 = g_master.inpadocno
         IF l_cnt > 0 THEN   
            CALL cl_set_comp_entry("work",FALSE)
         END IF           
      END IF  
      IF g_master.blank1 <> 'Y' THEN
         CALL cl_set_comp_entry("number1",FALSE)
      END IF  
      IF g_master.blank2 <> 'Y' THEN
         CALL cl_set_comp_entry("number2",FALSE)
      END IF       
   END IF
END FUNCTION

################################################################################
# Descriptions...: 資料排序
# Memo...........:
# Usage..........: CALL ainp850_inpd_order(p_order,p_flag,p_inpa031)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_inpd_order(p_order,p_flag,p_inpa031)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5
DEFINE p_inpa031 LIKE inpa_t.inpa031

   IF cl_null(p_order) OR p_order = '7' THEN
      RETURN
   END IF    
   IF cl_null(g_sql) THEN LET g_sql = " 1=1 " END IF
   IF p_flag THEN
      LET g_sql = g_sql ," ORDER BY "
   END IF
   IF p_order = '1' THEN
      IF p_flag THEN 
         LET g_sql = g_sql," imaf052"
      ELSE
         LET g_sql = g_sql,",imaf052"  
      END IF         
   END IF
   IF p_order = '2' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag004"
      ELSE
         LET g_sql = g_sql,",inag004"
      END IF   
   END IF  
   IF p_order = '3' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag005"
      ELSE
         LET g_sql = g_sql,",inag005"
      END IF   
   END IF    
   IF p_order = '4' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag006"
      ELSE         
         LET g_sql = g_sql,",inag006"
      END IF
   END IF
   IF p_order = '5' THEN
      IF p_flag THEN   
         LET g_sql = g_sql," inag001"
      ELSE   
         LET g_sql = g_sql,",inag001"
      END IF   
   END IF 
   IF p_order = '6' THEN
      IF p_inpa031 = '1' THEN    #產品分群
         IF p_flag THEN 
            LET g_sql = g_sql," imaf011"
         ELSE            
            LET g_sql = g_sql,",imaf011"
         END IF   
      END IF
      IF p_inpa031 = '2' THEN    #庫存分群
         IF p_flag THEN 
            LET g_sql = g_sql," imaf051"
         ELSE   
            LET g_sql = g_sql,",imaf051"
         END IF   
      END IF
   END IF   
   IF p_order = '8' THEN
      IF p_flag THEN 
         LET g_sql = g_sql," imaf057"
      ELSE
         LET g_sql = g_sql,",imaf057"
      END IF    
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 排序
# Memo...........:
# Usage..........: CALL ainp850_inpf_order(p_order,p_flag)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_inpf_order(p_order,p_flag)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5

   IF cl_null(p_order) OR p_order = '7' THEN
      RETURN
   END IF      
   IF cl_null(g_sql1) THEN LET g_sql1 = " 1=1 " END IF
#   IF p_flag THEN
#      LET g_sql1= g_sql1 ," ORDER BY "
#   END IF
   IF p_order = '1' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa010"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa010"      
#      END IF 
      LET g_sql1 = g_sql1,",sfaa010" 
   END IF
   IF p_order = '2' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa020"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa020"
#      END IF  
      LET g_sql1 = g_sql1,",sfaa020"
   END IF   
   IF p_order = '3' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaastus"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaastus" 
#      END IF   
      LET g_sql1 = g_sql1,",sfaastus" 
   END IF   
   IF p_order = '4' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa003"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa003"  
#      END IF   
      LET g_sql1 = g_sql1,",sfaa003"  
   END IF   
   IF p_order = '5' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaadocno"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaadocno"     
#      END IF   
      LET g_sql1 = g_sql1,",sfaadocno"     
   END IF  
   IF p_order = '6' THEN
#      IF p_flag THEN 
#         LET g_sql1 = g_sql1," sfaa017"
#      ELSE
#         LET g_sql1 = g_sql1,",sfaa017"  
#      END IF   
      LET g_sql1 = g_sql1,",sfaa017"
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 必要欄位
# Memo...........:
# Usage..........: CALL ainp850_set_no_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_set_no_required()
   CALL cl_set_comp_required("number1",FALSE)
   CALL cl_set_comp_required("number2",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 必要欄位
# Memo...........:
# Usage..........: CALL ainp850_set_required()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_set_required()
   IF g_master.blank1 = 'Y' THEN  
      CALL cl_set_comp_required("number1",TRUE)
   END IF
   IF g_master.blank2 = 'Y' THEN    
      CALL cl_set_comp_required("number2",TRUE)
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 抓取progress bar顯示文字並顯示
# Memo...........:
# Usage..........: CALL ainp850_progress_show(p_item)
# Input parameter: p_item         抓取順序
# Return code....: 無
# Date & Author..: 15/10/06 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION ainp850_progress_show(p_item)
DEFINE p_item    LIKE type_t.chr1
DEFINE l_sql     STRING
DEFINE l_lbl     LIKE gzzd_t.gzzd003
DEFINE l_str1    LIKE gzzd_t.gzzd005
DEFINE l_str2    LIKE gzzd_t.gzzd005
DEFINE l_str     STRING

   LET l_sql = "SELECT gzzd005 FROM gzzd_t",
               " WHERE gzzd001 = 'ainp850'",
               "   AND gzzd002 = '",g_dlang,"'",
               "   AND gzzd003 = ?",
               "   AND gzzd004 = 's'"
   PREPARE ainp850_show_word FROM l_sql
   
   IF p_item = '1' OR p_item = '2' OR p_item = '3' THEN   #現有庫存      
      LET l_lbl = 'group_qbe'      
   ELSE                                                   #在製工單
      LET l_lbl = 'ainp850.group_1'
   END IF
   EXECUTE ainp850_show_word USING l_lbl INTO l_str1
   
   CASE p_item
      WHEN "1"   #存貨凍結
         LET l_lbl = 'lbl_freezz'
      WHEN "2"   #產生盤點資料
         LET l_lbl = 'lbl_stock'
      WHEN "3"   #產生空白標籤
         LET l_lbl = 'lbl_blank1'
      WHEN "4"   #產生在製工單盤點資料
         LET l_lbl = 'lbl_work'
      WHEN "5"   #產生空白標籤
         LET l_lbl = 'lbl_blank2'
   END CASE
   EXECUTE ainp850_show_word USING l_lbl INTO l_str2

   LET l_str = l_str1 , '-' , l_str2
   
   CALL cl_progress_no_window_ing(l_str)
#依傳入的p_item的值會分別顯示底下的字眼
#   1=>現有庫存-存貨凍結
#   2=>現有庫存-產生盤點資料
#   3=>現有庫存-產生空白標籤
#   4=>在製工單-產生在製工單盤點資料
#   5=>在製工單-產生空白標籤

END FUNCTION

#end add-point
 
{</section>}
 
