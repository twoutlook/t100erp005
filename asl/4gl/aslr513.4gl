#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr513.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-12-21 15:47:20), PR版次:0001(2017-01-11 17:04:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr513
#+ Description: 
#+ Creator....: 02346(2016-12-21 15:47:20)
#+ Modifier...: 02346 -SD/PR- 02346
 
{</section>}
 
{<section id="aslr513.global" >}
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
       inbp005 LIKE type_t.chr500, 
   imaa154 LIKE type_t.num5, 
   imaa133 LIKE type_t.chr10, 
   imaa126 LIKE type_t.chr10, 
   imaa132 LIKE type_t.chr10, 
   inbmsite LIKE type_t.chr10, 
   indj015 LIKE type_t.chr10, 
   inbm008 LIKE type_t.chr10, 
   inbm003 LIKE type_t.chr10, 
   inbm001 LIKE type_t.chr10, 
   inbmdocno LIKE type_t.chr20, 
   inbmstus LIKE type_t.chr10, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   l_diff LIKE type_t.chr500,
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
 
{<section id="aslr513.main" >}
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
   CALL cl_ap_init("asl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aslr513_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslr513 WITH FORM cl_ap_formpath("asl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aslr513_init()
 
      #進入選單 Menu (="N")
      CALL aslr513_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aslr513
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aslr513.init" >}
#+ 初始化作業
PRIVATE FUNCTION aslr513_init()
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
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aslr513.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr513_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
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
         INPUT BY NAME g_master.inbmstus,g_master.bdate,g_master.edate,g_master.l_diff 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #161129-00027#5 add by sunxh 161221(S)
               LET g_master.inbmstus = GET_FLDBUF(inbmstus)
               IF g_master.inbmstus = 'Y' THEN 
                  CALL cl_set_comp_visible("bdate,edate", TRUE) 
               ELSE
                  CALL cl_set_comp_visible("bdate,edate", FALSE) 
               END IF 
               #161129-00027#5 add by sunxh 161221(E)
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmstus
            #add-point:BEFORE FIELD inbmstus name="input.b.inbmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmstus
            
            #add-point:AFTER FIELD inbmstus name="input.a.inbmstus"
            #161129-00027#5 add by sunxh 161221(S)
            LET g_master.inbmstus = GET_FLDBUF(inbmstus)
            IF g_master.inbmstus = 'Y' THEN 
               CALL cl_set_comp_visible("bdate,edate", TRUE) 
            ELSE
               CALL cl_set_comp_visible("bdate,edate", FALSE) 
            END IF 
            #161129-00027#5 add by sunxh 161221(E)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmstus
            #add-point:ON CHANGE inbmstus name="input.g.inbmstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_diff
            #add-point:BEFORE FIELD l_diff name="input.b.l_diff"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_diff
            
            #add-point:AFTER FIELD l_diff name="input.a.l_diff"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_diff
            #add-point:ON CHANGE l_diff name="input.g.l_diff"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.inbmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmstus
            #add-point:ON ACTION controlp INFIELD inbmstus name="input.c.inbmstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_diff
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_diff
            #add-point:ON ACTION controlp INFIELD l_diff name="input.c.l_diff"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON inbp005,imaa154,imaa133,imaa126,imaa132,inbmsite,indj015,inbm008, 
             inbm003,inbm001,inbmdocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.inbp005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbp005
            #add-point:ON ACTION controlp INFIELD inbp005 name="construct.c.inbp005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp005  #顯示到畫面上
            NEXT FIELD inbp005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbp005
            #add-point:BEFORE FIELD inbp005 name="construct.b.inbp005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbp005
            
            #add-point:AFTER FIELD inbp005 name="construct.a.inbp005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="construct.b.imaa154"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            
            #add-point:AFTER FIELD imaa154 name="construct.a.imaa154"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="construct.c.imaa154"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa133
            #add-point:ON ACTION controlp INFIELD imaa133 name="construct.c.imaa133"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161129-00027#5 add by sunxh 161223(S)
            #給予arg
            LET g_qryparam.arg1 = '2007' #應用分類
            #161129-00027#5 add by sunxh 161223(E)
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa133  #顯示到畫面上
            NEXT FIELD imaa133                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa133
            #add-point:BEFORE FIELD imaa133 name="construct.b.imaa133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa133
            
            #add-point:AFTER FIELD imaa133 name="construct.a.imaa133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD imaa126 name="construct.c.imaa126"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161129-00027#5 add by sunxh 161223(S)
            #給予arg
            LET g_qryparam.arg1 = '2002' #應用分類
            #161129-00027#5 add by sunxh 161223(E)
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
            NEXT FIELD imaa126                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa126
            #add-point:BEFORE FIELD imaa126 name="construct.b.imaa126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa126
            
            #add-point:AFTER FIELD imaa126 name="construct.a.imaa126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="construct.c.imaa132"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #161129-00027#5 add by sunxh 161223(S)
            #給予arg
            LET g_qryparam.arg1 = '2006' #應用分類
            #161129-00027#5 add by sunxh 161223(E)
            
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa132  #顯示到畫面上
            NEXT FIELD imaa132                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="construct.b.imaa132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="construct.a.imaa132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmsite
            #add-point:ON ACTION controlp INFIELD inbmsite name="construct.c.inbmsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmsite  #顯示到畫面上
            NEXT FIELD inbmsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmsite
            #add-point:BEFORE FIELD inbmsite name="construct.b.inbmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmsite
            
            #add-point:AFTER FIELD inbmsite name="construct.a.inbmsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indj015
            #add-point:ON ACTION controlp INFIELD indj015 name="construct.c.indj015"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj015  #顯示到畫面上
            NEXT FIELD indj015                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indj015
            #add-point:BEFORE FIELD indj015 name="construct.b.indj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indj015
            
            #add-point:AFTER FIELD indj015 name="construct.a.indj015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm008
            #add-point:BEFORE FIELD inbm008 name="construct.b.inbm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm008
            
            #add-point:AFTER FIELD inbm008 name="construct.a.inbm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm008
            #add-point:ON ACTION controlp INFIELD inbm008 name="construct.c.inbm008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm003
            #add-point:BEFORE FIELD inbm003 name="construct.b.inbm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm003
            
            #add-point:AFTER FIELD inbm003 name="construct.a.inbm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm003
            #add-point:ON ACTION controlp INFIELD inbm003 name="construct.c.inbm003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm001
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz062()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm001  #顯示到畫面上
            NEXT FIELD inbm001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm001
            #add-point:BEFORE FIELD inbm001 name="construct.b.inbm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm001
            
            #add-point:AFTER FIELD inbm001 name="construct.a.inbm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmdocno
            #add-point:ON ACTION controlp INFIELD inbmdocno name="construct.c.inbmdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbmdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmdocno  #顯示到畫面上
            NEXT FIELD inbmdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmdocno
            #add-point:BEFORE FIELD inbmdocno name="construct.b.inbmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmdocno
            
            #add-point:AFTER FIELD inbmdocno name="construct.a.inbmdocno"
            
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
            CALL aslr513_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aslr513_get_buffer(l_dialog)
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
         CALL aslr513_init()
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
                 CALL aslr513_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aslr513_transfer_argv(ls_js)
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
 
{<section id="aslr513.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aslr513_transfer_argv(ls_js)
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
 
{<section id="aslr513.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aslr513_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"inbp005,imaa154,imaa133,imaa126,imaa132,inbmsite,indj015,inbm008,inbm003,inbm001,inbmdocno")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #161129-00027#5 add by sunxh 2016/12/22--str--
   IF cl_null(g_master.wc) THEN
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         IF l_cnt>1 THEN
            LET ls_next = ls_next.subString(ls_next.getIndexOf("'",1)+1,ls_next.getLength())
            LET ls_next = ls_next.subString(1,ls_next.getIndexOf("'",1)-1)
         END IF
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET  g_master.wc = l_arg[01]     
   ELSE
      IF cl_null(g_master.wc) THEN
         LET g_master.wc = " 1=1"
      END IF
   END IF 
   LET g_master.wc = g_master.wc CLIPPED 
   IF NOT cl_null(g_master.inbmstus) THEN
      LET g_master.wc = g_master.wc CLIPPED," AND inbmsite='",g_site,"' AND inbmstus='",g_master.inbmstus,"' "
   END IF 
   IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN
      
      LET g_master.wc = g_master.wc CLIPPED," AND inbmcnfdt BETWEEN to_date('",g_master.bdate,"','yy/mm/dd') AND to_date('",g_master.edate,"','yy/mm/dd')+1 "
   END IF
#   CALL aslr513_x01(g_master.wc,g_master.l_diff)
   #161129-00027#5 add by sunxh 2016/12/22--end--
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aslr513_process_cs CURSOR FROM ls_sql
#  FOREACH aslr513_process_cs INTO
   #add-point:process段process name="process.process"
   CALL aslr513_x01(g_master.wc,g_master.l_diff)
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
 
{<section id="aslr513.get_buffer" >}
PRIVATE FUNCTION aslr513_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.inbmstus = p_dialog.getFieldBuffer('inbmstus')
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.l_diff = p_dialog.getFieldBuffer('l_diff')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   #161129-00027#5 add by sunxh 161221(S)
   LET g_master.inbmstus = 'Y'
   LET g_master.l_diff = 'N'
   LET g_master.bdate = g_today
   LET g_master.edate = g_today
   #161129-00027#5 add by sunxh 161221(E)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aslr513.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
