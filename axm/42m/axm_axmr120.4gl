#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-05-17 19:01:43), PR版次:0003(2016-11-09 14:11:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axmr120
#+ Description: 集團多期銷售分析表
#+ Creator....: 05384(2016-05-09 14:59:47)
#+ Modifier...: 05384 -SD/PR- 07024
 
{</section>}
 
{<section id="axmr120.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160727-00019#25  2016/08/5 By 08742        系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                           Mod   axmr120_site_tmp--> axmr120_tmp01
#161108-00013#1   2016/11/08 By 07024       與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
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
       xmda002 LIKE xmda_t.xmda002, 
   xmda003 LIKE xmda_t.xmda003, 
   imaf111 LIKE imaf_t.imaf111, 
   xmda004 LIKE xmda_t.xmda004, 
   pmaa090 LIKE pmaa_t.pmaa090, 
   xmdc001 LIKE xmdc_t.xmdc001, 
   imaa009 LIKE imaa_t.imaa009, 
   datum LIKE type_t.chr500, 
   order_confirm LIKE type_t.chr500, 
   shipper_posting LIKE type_t.chr500, 
   exclude_aic LIKE type_t.chr500, 
   currency LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
 DEFINE g_cons         STRING
 TYPE type_master2 RECORD
   imaf125 LIKE imaf_t.imaf125,  
       wc               STRING
       END RECORD
 DEFINE g_master2 type_master2
 TYPE type_g_other_d        RECORD
   b_other        LIKE type_t.num5,
   b_other_desc   LIKE type_t.chr1000,
   b_datumdate_s  LIKE type_t.dat,
   b_datumdate_e  LIKE type_t.dat,
   b_actualdate_s LIKE type_t.dat,
   b_actualdate_e LIKE type_t.dat
END RECORD
TYPE type_wc RECORD
   wc    STRING
END RECORD

DEFINE l_wc              DYNAMIC ARRAY OF type_wc             
 
DEFINE g_other_d          DYNAMIC ARRAY OF type_g_other_d
DEFINE g_other_d_t        type_g_other_d
#161108-00013#1-s-mod
#DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
#DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
#DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
#DEFINE l_count         LIKE type_t.num5
#DEFINE l_insert        LIKE type_t.num5
#DEFINE l_cmd           LIKE type_t.chr5
# 
#DEFINE l_forupd_sql    STRING
#DEFINE l_sql           STRING
#DEFINE l_result        LIKE type_t.chr80
#DEFINE l_n             LIKE type_t.num5
#
#DEFINE g_cnt                 LIKE type_t.num10
#DEFINE g_current_idx         LIKE type_t.num10
#DEFINE g_jump                LIKE type_t.num10
#DEFINE g_no_ask              LIKE type_t.num5
#DEFINE g_rec_b               LIKE type_t.num5
#DEFINE l_ac                  LIKE type_t.num5
#DEFINE ls_cnt                 LIKE type_t.num10
#
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數  
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
# 
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
#DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
DEFINE l_count         LIKE type_t.num10
DEFINE l_insert        LIKE type_t.num10
DEFINE l_cmd           LIKE type_t.chr10
 
DEFINE l_forupd_sql    STRING
DEFINE l_sql           STRING
DEFINE l_result        LIKE type_t.chr80
DEFINE l_n             LIKE type_t.num10

DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE ls_cnt                 LIKE type_t.num10

DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數  
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
 
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
#161108-00013#1-e-mod
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmr120.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axmr120_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmr120 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmr120_init()
 
      #進入選單 Menu (="N")
      CALL axmr120_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmr120
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axmr120_tmp
   DROP TABLE axmr120_tmp01        #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmr120.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmr120_init()
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
   CALL axmr120_crete_tmp()
   LET g_master.datum = '0'
   LET g_master.currency = '1'
   LET g_master.order_confirm = 'Y'
   LET g_master.shipper_posting = 'Y'
   LET g_master.exclude_aic = 'Y'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmr120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr120_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_xmdasite   STRING
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
         INPUT BY NAME g_master.datum,g_master.order_confirm,g_master.shipper_posting,g_master.exclude_aic, 
             g_master.currency 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD datum
            #add-point:BEFORE FIELD datum name="input.b.datum"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD datum
            
            #add-point:AFTER FIELD datum name="input.a.datum"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE datum
            #add-point:ON CHANGE datum name="input.g.datum"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order_confirm
            #add-point:BEFORE FIELD order_confirm name="input.b.order_confirm"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order_confirm
            
            #add-point:AFTER FIELD order_confirm name="input.a.order_confirm"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order_confirm
            #add-point:ON CHANGE order_confirm name="input.g.order_confirm"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD shipper_posting
            #add-point:BEFORE FIELD shipper_posting name="input.b.shipper_posting"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD shipper_posting
            
            #add-point:AFTER FIELD shipper_posting name="input.a.shipper_posting"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE shipper_posting
            #add-point:ON CHANGE shipper_posting name="input.g.shipper_posting"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD exclude_aic
            #add-point:BEFORE FIELD exclude_aic name="input.b.exclude_aic"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD exclude_aic
            
            #add-point:AFTER FIELD exclude_aic name="input.a.exclude_aic"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE exclude_aic
            #add-point:ON CHANGE exclude_aic name="input.g.exclude_aic"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD currency
            #add-point:BEFORE FIELD currency name="input.b.currency"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD currency
            
            #add-point:AFTER FIELD currency name="input.a.currency"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE currency
            #add-point:ON CHANGE currency name="input.g.currency"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.datum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD datum
            #add-point:ON ACTION controlp INFIELD datum name="input.c.datum"
            
            #END add-point
 
 
         #Ctrlp:input.c.order_confirm
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order_confirm
            #add-point:ON ACTION controlp INFIELD order_confirm name="input.c.order_confirm"
            
            #END add-point
 
 
         #Ctrlp:input.c.shipper_posting
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD shipper_posting
            #add-point:ON ACTION controlp INFIELD shipper_posting name="input.c.shipper_posting"
            
            #END add-point
 
 
         #Ctrlp:input.c.exclude_aic
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD exclude_aic
            #add-point:ON ACTION controlp INFIELD exclude_aic name="input.c.exclude_aic"
            
            #END add-point
 
 
         #Ctrlp:input.c.currency
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD currency
            #add-point:ON ACTION controlp INFIELD currency name="input.c.currency"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xmda002,xmda003,imaf111,xmda004,pmaa090,xmdc001,imaa009
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmda002
            #add-point:ON ACTION controlp INFIELD xmda002 name="construct.c.xmda002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
            NEXT FIELD xmda002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmda002
            #add-point:BEFORE FIELD xmda002 name="construct.b.xmda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmda002
            
            #add-point:AFTER FIELD xmda002 name="construct.a.xmda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmda003
            #add-point:ON ACTION controlp INFIELD xmda003 name="construct.c.xmda003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda003  #顯示到畫面上
            NEXT FIELD xmda003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmda003
            #add-point:BEFORE FIELD xmda003 name="construct.b.xmda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmda003
            
            #add-point:AFTER FIELD xmda003 name="construct.a.xmda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf111
            #add-point:ON ACTION controlp INFIELD imaf111 name="construct.c.imaf111"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imcd111()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf111  #顯示到畫面上
            NEXT FIELD imaf111                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf111
            #add-point:BEFORE FIELD imaf111 name="construct.b.imaf111"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf111
            
            #add-point:AFTER FIELD imaf111 name="construct.a.imaf111"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmda004
            #add-point:ON ACTION controlp INFIELD xmda004 name="construct.c.xmda004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda004  #顯示到畫面上
            NEXT FIELD xmda004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmda004
            #add-point:BEFORE FIELD xmda004 name="construct.b.xmda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmda004
            
            #add-point:AFTER FIELD xmda004 name="construct.a.xmda004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa090
            #add-point:ON ACTION controlp INFIELD pmaa090 name="construct.c.pmaa090"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa090  #顯示到畫面上
            NEXT FIELD pmaa090                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa090
            #add-point:BEFORE FIELD pmaa090 name="construct.b.pmaa090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa090
            
            #add-point:AFTER FIELD pmaa090 name="construct.a.pmaa090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdc001
            #add-point:ON ACTION controlp INFIELD xmdc001 name="construct.c.xmdc001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdc001  #顯示到畫面上
            NEXT FIELD xmdc001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdc001
            #add-point:BEFORE FIELD xmdc001 name="construct.b.xmdc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdc001
            
            #add-point:AFTER FIELD xmdc001 name="construct.a.xmdc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:3)
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
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master2.wc ON xmdasite
            BEFORE CONSTRUCT
            
               #應用 a01 樣板自動產生(Version:1)
            ON ACTION controlp INFIELD xmdasite
               #add-point:ON ACTION controlp INFIELD xmdasite name="construct.c.xmdasite"
               #應用 a08 樣板自動產生(Version:3)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_gzxc004_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmdasite  #顯示到畫面上
               NEXT FIELD xmdasite                     #返回原欄位
            
            
            
            
               #END add-point
            
            
            #應用 a01 樣板自動產生(Version:2)
            BEFORE FIELD xmdasite
               #add-point:BEFORE FIELD xmdasite name="construct.b.xmdasite"
            
               #END add-point
            
            
            #應用 a02 樣板自動產生(Version:2)
            AFTER FIELD xmdasite
               
               #add-point:AFTER FIELD xmdasite name="construct.a.xmdasite"
            
               #END add-point
            
               #add-point:其他管控
            
               #end add-point
            AFTER CONSTRUCT
               LET l_xmdasite = GET_FLDBUF(xmdasite)
               CONSTRUCT g_cons ON gzxc004
                              FROM xmdasite
                  
                  BEFORE CONSTRUCT
                     CALL cl_qbe_init()
                     DISPLAY l_xmdasite TO xmdasite
                     
                     EXIT CONSTRUCT
               END CONSTRUCT
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_other_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = TRUE,
                  DELETE ROW = TRUE,
                  APPEND ROW = TRUE)
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_other_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
           LET g_rec_b = g_other_d.getLength()



         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
                        
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
 
            LET g_rec_b = g_other_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_other_d[l_ac].b_other IS NOT NULL
 
            THEN
               
               LET g_other_d_t.* = g_other_d[l_ac].*  #BACKUP
 
#               CALL cl_set_comp_entry("b_other,bmaa002,bmfa012,bmfa005",TRUE)
               #add-point:modify段after_set_entry_b

               #end add-point  

            END IF
         
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_other_d[l_ac].* TO NULL 
            INITIALIZE g_other_d_t.* TO NULL 
            
            IF l_ac = 1 THEN
               LET g_other_d[l_ac].b_other = l_ac
            ELSE
               LET g_other_d[l_ac].b_other = g_other_d[l_ac - 1].b_other + 1
            END IF
            LET g_other_d[l_ac].b_datumdate_s = g_today
            LET g_other_d[l_ac].b_datumdate_e = g_today
            LET g_other_d[l_ac].b_actualdate_s = g_today
            LET g_other_d[l_ac].b_actualdate_e = g_today
            LET g_other_d_t.* = g_other_d[l_ac].*     #新輸入資料
         
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
           END IF
           IF cl_null(g_other_d[l_ac].b_other) THEN
               CANCEL INSERT
           END IF

               CALL s_transaction_end('Y','0')
               
               LET g_rec_b = g_rec_b + 1
             

         
         AFTER FIELD b_other            
         
         BEFORE FIELD b_other
                     
         
         AFTER FIELD b_other_desc
         
         BEFORE FIELD b_other_desc
         
         
         AFTER FIELD b_datumdate_s
            IF NOT axmr120_date_chk(g_other_d[l_ac].b_datumdate_s,g_other_d[l_ac].b_datumdate_e) THEN
               NEXT FIELD CURRENT
            END IF
         BEFORE FIELD b_datumdate_s
         
         AFTER FIELD b_datumdate_e
            IF NOT axmr120_date_chk(g_other_d[l_ac].b_datumdate_s,g_other_d[l_ac].b_datumdate_e) THEN
               NEXT FIELD CURRENT
            END IF
         BEFORE FIELD b_datumdate_e
         
         
         AFTER FIELD b_actualdate_s
            IF NOT axmr120_date_chk(g_other_d[l_ac].b_actualdate_s,g_other_d[l_ac].b_actualdate_e) THEN
               NEXT FIELD CURRENT
            END IF
         BEFORE FIELD b_actualdate_s
         
         AFTER FIELD b_actualdate_e
            IF NOT axmr120_date_chk(g_other_d[l_ac].b_actualdate_s,g_other_d[l_ac].b_actualdate_e) THEN
               NEXT FIELD CURRENT
            END IF
         BEFORE FIELD b_actualdate_e
         
         AFTER ROW
            CALL s_transaction_end('Y','0')
               
         AFTER INPUT
            IF cl_null(g_other_d[l_ac].b_other) THEN 
               INITIALIZE g_other_d[l_ac].* TO NULL
               CALL g_other_d.deleteElement(l_ac)               
            END IF
      
      
            ON ACTION l_delete
               LET g_action_choice="l_delete"
                  IF cl_ask_del_detail() THEN
                     INITIALIZE g_other_d[g_detail_idx].*  TO NULL
                     CALL g_other_d.deleteElement(g_detail_idx)

                  END IF
               
               
            ON ACTION controlo    
               CALL FGL_SET_ARR_CURR(g_other_d.getLength()+1)


 
         END INPUT
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
            CALL axmr120_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axmr120_get_buffer(l_dialog)
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
         CALL axmr120_init()
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
                 CALL axmr120_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmr120_transfer_argv(ls_js)
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
 
{<section id="axmr120.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmr120_transfer_argv(ls_js)
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
 
{<section id="axmr120.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmr120_process(ls_js)
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
   DEFINE l_ac       LIKE type_t.num5
   DEFINE l_count    LIKE type_t.num5
   DEFINE l_tmp_name STRING
   DEFINE l_tmp_site STRING
   DEFINE l_sql      STRING
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xmda002,xmda003,imaf111,xmda004,pmaa090,xmdc001,imaa009")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   DELETE FROM axmr120_tmp
   DELETE FROM axmr120_tmp01        #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
   CALL axmr120_site()
   IF NOT cl_null(g_cons) THEN
      LET l_sql = " DELETE FROM axmr120_tmp01 ",       #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
                  " WHERE (NOT ",g_cons,") "
      PREPARE axmr172_del_site FROM l_sql
      EXECUTE axmr172_del_site
   END IF
   LET l_count = g_other_d.getLength()
   IF l_count > 0 THEN
      FOR l_ac = 1 TO l_count
         IF NOT cl_null(g_other_d[l_ac].b_other) THEN
            INSERT INTO axmr120_tmp(other,other_desc,datumdate_s,datumdate_e,actualdate_s,actualdate_e)
                             VALUES(g_other_d[l_ac].b_other,g_other_d[l_ac].b_other_desc,g_other_d[l_ac].b_datumdate_s,
                                    g_other_d[l_ac].b_datumdate_e,g_other_d[l_ac].b_actualdate_s,g_other_d[l_ac].b_actualdate_e)
         END IF   
      END FOR
      LET l_tmp_name = "axmr120_tmp"
      LET l_tmp_site = "axmr120_tmp01"           #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
      CALL axmr120_x01(g_master.wc,l_tmp_name,l_tmp_site,g_master.datum,g_master.currency,g_master.order_confirm,g_master.shipper_posting,g_master.exclude_aic)
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'axm-00783'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axmr120_process_cs CURSOR FROM ls_sql
#  FOREACH axmr120_process_cs INTO
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
 
{<section id="axmr120.get_buffer" >}
PRIVATE FUNCTION axmr120_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.datum = p_dialog.getFieldBuffer('datum')
   LET g_master.order_confirm = p_dialog.getFieldBuffer('order_confirm')
   LET g_master.shipper_posting = p_dialog.getFieldBuffer('shipper_posting')
   LET g_master.exclude_aic = p_dialog.getFieldBuffer('exclude_aic')
   LET g_master.currency = p_dialog.getFieldBuffer('currency')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION axmr120_date_chk(p_date_s,p_date_e)
DEFINE p_date_s   LIKE type_t.dat
DEFINE p_date_e   LIKE type_t.dat
DEFINE r_success  LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_date_s) AND NOT cl_null(p_date_e) THEN
      IF p_date_s > p_date_e THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'acr-00068'    #起始日期不能大于截止日期！  
         LET g_errparam.popup  = TRUE
         CALL cl_err()
    
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION axmr120_crete_tmp()
   
   WHENEVER ERROR CONTINUE
   DROP TABLE axmr120_tmp
   CREATE TEMP TABLE axmr120_tmp(
      other         SMALLINT,
      other_desc    VARCHAR(1000),
      datumdate_s   DATE,
      datumdate_e   DATE,
      actualdate_s  DATE,
      actualdate_e  DATE
   )
   
   DROP TABLE axmr120_tmp01           #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
   CREATE TEMP TABLE axmr120_tmp01(   #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
       gzxcent     SMALLINT,
       gzxc004     VARCHAR(10)
   )

END FUNCTION

################################################################################
# Descriptions...: 取使用者可使用據點
# Memo...........:
# Usage..........: CALL axmr120_site()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/11 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr120_site()
   DEFINE l_gzxc004  LIKE gzxc_t.gzxc004  #據點編號
   DEFINE l_gzxc007  LIKE gzxc_t.gzxc007  #據點允許下展
   DEFINE l_stus     LIKE type_t.num5
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_sql      STRING

   #清空可用據點
   DELETE FROM axmr120_tmp01        #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
   
   LET l_sql = "SELECT DISTINCT ooed004 FROM ooed_t ",
                " WHERE ooedent = ",g_enterprise USING "<<<<<",
                  " AND ooed001 = '2' ",  #限定只能用營運組織
                  " AND ooed005 = ? ",
                  " AND (ooed006 IS NULL OR ooed006 <= '",g_today USING "yyyy/mm/dd","') ",  #生效日期
                  " AND (ooed007 IS NULL OR ooed007 > '",g_today USING "yyyy/mm/dd","') "    #失效日期
   DECLARE get_ooed_cs CURSOR FROM l_sql
   
   #確認登入的營運據點狀況 (有否下展)
   LET l_sql = "SELECT gzxc004,gzxc007 FROM gzxc_t ",
                " WHERE gzxcent = ",g_enterprise USING "<<<<<",
                  " AND gzxc001 = '",g_user CLIPPED,"' ",
                  " AND (gzxc005 IS NULL OR gzxc005 <= '",g_today USING "yyyy/mm/dd","') ", 
                  " AND (gzxc006 IS NULL OR gzxc006 > '",g_today USING "yyyy/mm/dd","') ",
                  " AND gzxcstus = 'Y' "
   DECLARE get_gzxc_cs CURSOR FROM l_sql
   
   #存在本作業權限項目時, 展開營運據點(全部)
   FOREACH get_gzxc_cs INTO l_gzxc004,l_gzxc007
   
      
      #可以展開的話
      IF l_gzxc007 = 'Y' THEN
         CALL axmr120_site_expand(l_gzxc004)
      ELSE
         LET l_cnt = 0
         SELECT COUNT (*) INTO l_cnt
           FROM axmr120_tmp01          #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
          WHERE gzxc004 = l_gzxc004
         IF l_cnt = 0 THEN
            INSERT INTO axmr120_tmp01 VALUES(g_enterprise,l_gzxc004)        #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
         END IF
      END IF
      
   END FOREACH

   CLOSE get_ooed_cs
   CLOSE get_gzxc_cs
   FREE get_ooed_cs
   FREE get_gzxc_cs
END FUNCTION

################################################################################
# Descriptions...: 下展營運據點
# Memo...........:
# Usage..........: CALL axmr120_site_expand(p_ooed005)
# Input parameter: p_ooed005   上層據點
# Return code....: 
# Date & Author..: 2016/05/11 By shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION axmr120_site_expand(p_ooed005)
   DEFINE p_ooed005  LIKE ooed_t.ooed005  #上層組織編號
   DEFINE l_ooed004  LIKE ooed_t.ooed004  #組織編號
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_cnt2     LIKE type_t.num5
   DEFINE l_site     DYNAMIC ARRAY OF LIKE ooed_t.ooed004

   LET l_cnt = 0
   SELECT COUNT (*) INTO l_cnt
     FROM axmr120_tmp01           #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
    WHERE gzxc004 = p_ooed005
   IF l_cnt = 0 THEN
      INSERT INTO axmr120_tmp01 VALUES(g_enterprise,p_ooed005)        #160727-00019#25 Mod  axmr120_site_tmp--> axmr120_tmp01
      
      LET l_cnt = 0
      SELECT count(*) INTO l_cnt
        FROM ooed_t
       WHERE ooedent = g_enterprise
         AND ooed001 = "8"
         AND ooed004 = p_ooed005
         AND (ooed006 IS NULL OR ooed006 <= g_today)
         AND (ooed007 IS NULL OR ooed007 >= g_today)
      IF l_cnt > 0 THEN
         LET l_cnt = 1
         FOREACH get_ooed_cs USING p_ooed005 INTO l_ooed004
            LET l_site[l_cnt] = l_ooed004 CLIPPED
            LET l_cnt = l_cnt + 1
         END FOREACH
         IF l_site.getLength() > 0 THEN
            FOR l_cnt2 = 1 TO l_site.getLength()
               CALL axmr120_site_expand(l_site[l_cnt2])
            END FOR
         END IF
      END IF
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
