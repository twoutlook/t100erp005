#該程式未解開Section, 採用最新樣板產出!
{<section id="adep220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2017-01-09 18:02:54), PR版次:0019(2017-01-09 17:12:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000393
#+ Filename...: adep220
#+ Description: 門店庫存日結批次處理作業
#+ Creator....: 02748(2014-03-24 09:13:06)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="adep220.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161017-00050#1  2016/10/21  By 06137  修正adep220 產生 "多庫儲批出貨明細(rtin_t)" 時,在"產品特徵 沒有給值, 造成扣帳錯誤(常春藤測試)
#161026-00058#1  2016/10/26  by geza   adep220门店库存日结后产生的artt610门店销售单部分栏位资料缺失（与手工录入artt610单据做的对比）
#161104-00002#3  2016/11/04  By 06137  調整系統*寫法
#161123-00042#3  2016/11/24  By 06137  161104-00002 星號寫法, 應補上自定義欄位
#161206-00005#3  2016/12/07  by 02481  若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
#160118-00008#4  2016/12/23  by lori   扣帳套用批次扣帳s_inventory_batch元件
#161216-00004#2  2016/12/23  By  lori  1.增加支援跨門店、跨日期日結
#                                      2.增加程式背景執行時參數:rtjadocdt_end
#                                      3.調整進度條的計量與顯示
#                                      4.補充各函式描述
#170106-00034#1  2017/01/09  by sakura 日結扣帳後,於回押"扣帳日期(rtja006)"時,一併更新"實際扣帳單據(rtja067)"為此次產生的日結扣帳"單據編號(rtiadocno)"
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
       #rtjasite         LIKE type_t.chr10,           #160804-00060#1 160906 by lori add   #161216-00004#2 161230 by lori mark:無此參數需求
        rtjadocdt        LIKE rtja_t.rtjadocdt,
        rtjadocdt_end    LIKE rtja_t.rtjadocdt,       #161216-00004#2 161226 by lori add
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjasite LIKE type_t.chr10, 
   rtjadocdt LIKE type_t.dat, 
   rtjadocdt_end LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_datetime           DATETIME YEAR TO SECOND
DEFINE g_errno              LIKE type_t.chr50        #150601-00026#1 15/06/01  by s983961---add
DEFINE g_rtia006            DATETIME YEAR TO SECOND  #150805  
#160804-00060#1 160809 by lori add---(S)
DEFINE g_exitstus           LIKE type_t.num5
DEFINE g_muti_org           LIKE type_t.chr10    #跨門店結算參數值
DEFINE g_muti_dat           LIKE type_t.chr10    #跨日期結算參數
#160804-00060#1 160809 by lori add---(E)
DEFINE g_master_o           type_master          #161216-00004#2 161228 by lori add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adep220.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #Create Tmp Table 在MAIN段 前景與背景才都會跑到
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   
   #150427-00001#9 150604 By pomelo add(S)
   LET l_success = ''
   CALL s_lot_auto_create_tmp('artt610') RETURNING l_success

   LET l_success = ''
   CALL s_aooi390_cre_tmp_table() RETURNING l_success
   #150427-00001#9 150604 By pomelo add(E)  
   
   #160129-00014#2 160223 By pomelo add(S)
   #LET l_success = ''
   #CALL s_lot_no_batch_create_tmp() RETURNING l_success
   #160129-00014#2 160223 By pomelo add(E)
   
   LET g_datetime = cl_get_current()
   #LET lc_param.wc = g_argv[1]
   #LET lc_param.rtjadocdt = DATE(g_argv[2])
   #LET ls_js = util.JSON.stringify(lc_param)
   #
   #IF lc_param.rtjadocdt IS NOT NULL THEN
   #   LET g_bgjob = "Y"
   #ELSE
   #   LET g_bgjob = "N"
   #END IF
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep220_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep220 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep220_init()
 
      #進入選單 Menu (="N")
      CALL adep220_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep220
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   ##150427-00001#9 150604s By pomelo add(S)
   CALL s_lot_auto_drop_tmp('artt610')
   CALL s_aooi390_drop_tmp_table()
   ##150427-00001#9 150604 By pomelo add(E)
   
   #160804-00060#1 160809 by lori add---(S)
   IF NOT g_exitstus THEN
      CALL cl_ap_exitprogram("1")
   END IF   
   #160804-00060#1 160809 by lori add---(E)
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep220.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep220_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success     LIKE type_t.num5   #150308-00001#1  By Ken 150309
   DEFINE l_dat_label   STRING             #161216-00004#2 161223 by lori add
   DEFINE l_comment     STRING             #161216-00004#2 161223 by lori add     
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
   #CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   ##150427-00001#9 150604 By pomelo add(S)
   #LET l_success = ''
   #CALL s_lot_auto_create_tmp('artt610') RETURNING l_success
   #
   #LET l_success = ''
   #CALL s_aooi390_cre_tmp_table() RETURNING l_success
   ##150427-00001#9 150604 By pomelo add(E)
   
   #161216-00004#2 161223 by lori add---(S)
   #跨門店
   LET g_muti_org = cl_get_para(g_enterprise,"","E-CIR-0078")
   #跨日期
   LET g_muti_dat = cl_get_para(g_enterprise,"","E-CIR-0079")
   IF g_muti_dat = 'Y' THEN
      LET l_dat_label = ''
      LET l_comment = ''
      CALL s_azzi902_get_gzzd(g_prog,"lbl_rtjadocdt_str") RETURNING l_dat_label, l_comment
      CALL cl_set_comp_att_text("lbl_rtjadate",l_dat_label)
   ELSE
      CALL cl_set_comp_visible("lbl_rtjadocdt_end,rtjadocdt_end",FALSE)  
   END IF
   #161216-00004#2 161223 by lori add---(E)
   #end add-point   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adep220.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep220_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_bus_date    LIKE rtja_t.rtjadocdt    #記錄參數值:營業日期   #161216-00004#2 161228 by lori add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.rtjadocdt,g_master.rtjadocdt_end 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               IF cl_null(g_master.rtjadocdt) THEN
                  #161216-00004#2 161223 by lori mod---(S)
                  ##LET g_master.rtjadocdt = g_today              #160804-00060#1 160808 by lori mark
                  ##LET g_master.rtjadocdt = g_today-1            #160804-00060#1 160808 by lori add   
               
                  IF g_muti_org = 'Y' THEN
                     LET g_master.rtjadocdt = g_today - 1
                     LET g_master.rtjadocdt_end = g_today - 1
                  ELSE       
                     LET l_bus_date = cl_get_para(g_enterprise,g_site,"S-CIR-0003")            
                     LET g_master.rtjadocdt = l_bus_date - 1
                     LET g_master.rtjadocdt_end = l_bus_date - 1
                  END IF  

                  IF g_muti_dat <> 'Y' THEN
                     LET g_master.rtjadocdt_end = ''
                  END IF
                  #161216-00004#2 161223 by lori mod---(E)
               END IF
               
               DISPLAY BY NAME g_master.rtjadocdt
               DISPLAY BY NAME g_master.rtjadocdt_end           #161216-00004#2 161223 by lori add
               
               INITIALIZE g_master_o.* TO NULL
               LET g_master_o.* = g_master.*
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt
            #add-point:BEFORE FIELD rtjadocdt name="input.b.rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt
            
            #add-point:AFTER FIELD rtjadocdt name="input.a.rtjadocdt"
            #161216-00004#2 161223 by lori add---(S)
            IF NOT cl_null(g_master.rtjadocdt) THEN
               IF cl_null(g_master_o.rtjadocdt) OR g_master.rtjadocdt <> g_master_o.rtjadocdt THEN
                  IF NOT cl_null(g_master.rtjadocdt_end) THEN
                     IF g_master.rtjadocdt > g_master.rtjadocdt_end THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00786"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                     
                        
                        LET g_master.rtjadocdt = g_master_o.rtjadocdt
                        DISPLAY g_master.rtjadocdt TO rtjadocdt
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  
                  IF (g_muti_org = 'Y' AND g_master.rtjadocdt >= g_today) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00742"   #輸入日期必須小於系統日！
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     
                     LET g_master.rtjadocdt_end = g_master_o.rtjadocdt_end
                     DISPLAY g_master.rtjadocdt_end TO rtjadocdt_end
                     NEXT FIELD CURRENT                      
                  END IF
                  
                  IF (g_muti_org = 'N' OR cl_null(g_muti_dat)) AND g_master.rtjadocdt >= l_bus_date THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00855"   #指定的銷售日期必須小於營業日期！
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     
                     LET g_master.rtjadocdt = g_master_o.rtjadocdt
                     DISPLAY g_master.rtjadocdt TO rtjadocdt
                     NEXT FIELD CURRENT                  
                  END IF
               END IF   
            END IF
            
            LET g_master_o.rtjadocdt = g_master.rtjadocdt
            #161216-00004#2 161223 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt
            #add-point:ON CHANGE rtjadocdt name="input.g.rtjadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt_end
            #add-point:BEFORE FIELD rtjadocdt_end name="input.b.rtjadocdt_end"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt_end
            
            #add-point:AFTER FIELD rtjadocdt_end name="input.a.rtjadocdt_end"
            #161216-00004#2 161223 by lori add---(S)
            IF NOT cl_null(g_master.rtjadocdt_end) THEN
               IF cl_null(g_master_o.rtjadocdt_end) OR g_master.rtjadocdt_end <> g_master_o.rtjadocdt_end THEN
                  IF NOT cl_null(g_master.rtjadocdt) THEN
                     IF g_master.rtjadocdt > g_master.rtjadocdt_end THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "ast-00786"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()  
                        
                        LET g_master.rtjadocdt_end = g_master_o.rtjadocdt_end
                        DISPLAY g_master.rtjadocdt_end TO rtjadocdt_end
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  
                  IF (g_muti_org = 'Y' AND g_master.rtjadocdt_end >= g_today) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00742"   #輸入日期必須小於系統日！
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     
                     LET g_master.rtjadocdt_end = g_master_o.rtjadocdt_end
                     DISPLAY g_master.rtjadocdt_end TO rtjadocdt_end
                     NEXT FIELD CURRENT                   
                  END IF
                  
                  IF (g_muti_org = 'N' OR cl_null(g_muti_dat)) AND g_master.rtjadocdt_end >= l_bus_date THEN                  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00855"   #指定的銷售日期必須小於營業日期！
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     
                     LET g_master.rtjadocdt_end = g_master_o.rtjadocdt_end
                     DISPLAY g_master.rtjadocdt_end TO rtjadocdt_end
                     NEXT FIELD CURRENT                  
                  END IF 
               END IF                  
            END IF
            
            LET g_master_o.rtjadocdt_end = g_master.rtjadocdt_end
            #161216-00004#2 161223 by lori add---(E)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt_end
            #add-point:ON CHANGE rtjadocdt_end name="input.g.rtjadocdt_end"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt
            #add-point:ON ACTION controlp INFIELD rtjadocdt name="input.c.rtjadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtjadocdt_end
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt_end
            #add-point:ON ACTION controlp INFIELD rtjadocdt_end name="input.c.rtjadocdt_end"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               #161216-00004#2 161223 by lori add---(S)
               IF NOT cl_null(g_master.rtjadocdt) AND  NOT cl_null(g_master.rtjadocdt_end) THEN
                  IF g_master.rtjadocdt > g_master.rtjadocdt_end THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00786"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                     
                     NEXT FIELD rtjadocdt_end
                  END IF
               END IF
               #161216-00004#2 161223 by lori add---(E)
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               #161216-00004#2 161223 by lori add---(S)
               #跨部門結算
               IF g_muti_org = "N" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ade-00187"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()            
                  NEXT FIELD rtjadocdt
               END IF   
               #161216-00004#2 161223 by lori add---(E) 
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE 
#	     	   LET g_qryparam.arg1 = g_site
#	     	   LET g_qryparam.arg2 = '2'
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO rtjasite   #顯示到畫面上
	     
            NEXT FIELD rtjasite                        #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjasite
            #add-point:BEFORE FIELD rtjasite name="construct.b.rtjasite"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjasite
            
            #add-point:AFTER FIELD rtjasite name="construct.a.rtjasite"
            
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
            CALL adep220_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_site TO rtjasite
           #LET g_master.rtjadocdt = g_today     #160804-00060#1 160808 by lori mark
           #LET g_master.rtjadocdt = g_today-1   #160804-00060#1 160808 by lori add    #161216-00004#2 161223 by lori mark
            
            #161216-00004#2 161223 by lori add---(S)
            IF g_muti_org = 'Y' THEN
               LET g_master.rtjadocdt = g_today - 1
               LET g_master.rtjadocdt_end = g_today - 1
            ELSE       
               LET l_bus_date = cl_get_para(g_enterprise,g_site,"S-CIR-0003")            
               LET g_master.rtjadocdt = l_bus_date - 1
               LET g_master.rtjadocdt_end = l_bus_date - 1
            END IF   
            
            IF g_muti_dat <> 'Y' THEN
               LET g_master.rtjadocdt_end = ''
            END IF 
            #跨組織結算
            IF g_muti_org = "N" THEN
               NEXT FIELD rtjadocdt
            ELSE
               NEXT FIELD rtjasite
            END IF
            #161216-00004#2 161223 by lori add---(E)            
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
         #160804-00060#1 160906 by lori add---(S)
         AFTER DIALOG
           #LET g_master.rtjasite = GET_FLDBUF(rtjasite) #161216-00004#2 161226 by lori mark
           
            #161216-00004#2 161226 by lori add---(S)
            IF cl_null(g_master.wc) OR g_master.wc = "rtjasite like '%'" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "ade-00182"   #門店編號不可為空或「*」
               LET g_errparam.popup = TRUE
               CALL cl_err()                     
               NEXT FIELD rtjasite               
            END IF  
            #161216-00004#2 161226 by lori add---(E)             
         #160804-00060#1 160906 by lori add---(E)          
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
         CALL adep220_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
     #LET lc_param.rtjasite = g_master.rtjasite              #160804-00060#1 160906 by lori add  #161216-00004#2 161230 by lori:無此參數需求
      LET lc_param.rtjadocdt = g_master.rtjadocdt
      LET lc_param.rtjadocdt_end = g_master.rtjadocdt_end    #161216-00004#2 161226 by lori add
      LET lc_param.wc = g_master.wc 
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
                 CALL adep220_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep220_transfer_argv(ls_js)
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
         #160804-00060#1 160809 by lori add---(S)
         IF NOT g_exitstus THEN  
            CALL cl_ask_confirm3("std-00012","")
         END IF   
         #160804-00060#1 160809 by lori add---(E)
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
 
{<section id="adep220.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep220_transfer_argv(ls_js)
 
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
   #背景處理時不需另外傳參數
   #LET la_cmdrun.param[1] = la_param.wc
   #LET la_cmdrun.param[2] = la_param.rtjadocdt
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="adep220.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep220_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql         STRING
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_str         STRING
   DEFINE l_where       STRING
   DEFINE l_date_tmp    STRING                   #150805 
  #161216-00004#2 161226 by lori mod---(S)
  #筆數變數型態改用num10;ProgressBar計量改回標準變數 li_count(原為l_loop)  
  #DEFINE l_cnt         LIKE type_t.num5         #150515-00023#6 150903 by lori add
  #DEFINE l_err_cnt     LIKE type_t.num5         #150515-00023#6 150903 by lori add
  #DEFINE l_succ_cnt    LIKE type_t.num5         #150515-00023#6 150903 by lori add   
  #DEFINE l_log         STRING                   #150515-00023#6 150903 by lori add  
  #DEFINE l_loop        LIKE type_t.num5         #160225-00040#4 Add By Ken 160401
  #DEFINE l_msg         STRING                   #160225-00040#4 Add By Ken 160401 
   DEFINE l_cnt         LIKE type_t.num10       
   DEFINE l_err_cnt     LIKE type_t.num10       
   DEFINE l_succ_cnt    LIKE type_t.num10       
   DEFINE l_log         STRING                      
   DEFINE l_msg         STRING    
  #161216-00004#2 161226 by lori mod---(E) 
   #160804-00060#1 160809 by lori add---(S)
   DEFINE l_source      STRING  
   DEFINE l_ins_source  STRING  
   DEFINE l_chk_source  STRING  
   DEFINE l_rtjbsite    LIKE rtjb_t.rtjbsite
   DEFINE l_rtjbdocno   LIKE rtjb_t.rtjbdocno
   DEFINE l_rtjbseq     LIKE rtjb_t.rtjbseq
   DEFINE l_rtjb004     LIKE rtjb_t.rtjb004
   DEFINE l_rtjb013     LIKE rtjb_t.rtjb013
   DEFINE l_rtjb015     LIKE rtjb_t.rtjb015
   DEFINE l_rtjb025     LIKE rtjb_t.rtjb025
   DEFINE l_code        LIKE gzze_t.gzze001
   DEFINE l_checkpos    LIKE type_t.chr1   #161206-00005#3--add 
   DEFINE l_flag        LIKE type_t.chr1   #161206-00005#3--add 失败则返回
   #160804-00060#1 160809 by lori add---(E)  
   #161216-00004#2 161226 by lori add---(S)
   DEFINE l_i           LIKE type_t.num10   
   DEFINE l_j           LIKE type_t.num10
   DEFINE l_dat_cnt     LIKE type_t.num10        #統計結算天數
   DEFINE l_process_cnt LIKE type_t.num10        #統計處理步驟數,用於補齊procress   
   DEFINE l_date        LIKE rtja_t.rtjadocdt    #結算日 
   DEFINE l_bus_date    LIKE rtja_t.rtjadocdt    #記錄參數值:營業日期
   DEFINE l_org_where   STRING                   #記錄要結算的門店條件(SQL語法) 
   DEFINE l_continue    LIKE type_t.num5         #記錄是否繼續結算,ProgressBBar輔助變數
   DEFINE l_site_t      LIKE rtja_t.rtjasite     #備份g_site 
   DEFINE l_colname_1   STRING                   #錯誤訊息title
   DEFINE l_comment_1   STRING                   #錯誤訊息comment
   DEFINE l_colname_2   STRING                   #錯誤訊息title
   DEFINE l_comment_2   STRING                   #錯誤訊息comment
   #161216-00004#2 161226 by lori add---(E)   


   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #160530-00032#1 Add By Ken 160608(S)
   LET l_log = "process_id:",FGL_GETPID()
   CALL cl_log_write(l_log)
   DISPLAY l_log
   #160530-00032#1 Add By Ken 160608(E) 

#161216-00004#2 161226 by lori mark---(S)
##整理邏輯並調整支援跨門店與日期進行結算,註解保留原邏輯段
#   #160804-00060#1 160808 by lori add---(S)
#   IF g_master.rtjadocdt >= cl_get_para(g_enterprise,lc_param.rtjasite,"S-CIR-0003") THEN
#      #指定的銷售日期必須小於營業日期！
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = "ast-00855"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      
#      RETURN
#   END IF            
#   #160804-00060#1 160808 by lori add---(E)
#   
#   #161206-00005#3---add--begin-------------
#   #若勾选参数检查门店日结是否上传，则门店必须要有值
#   LET l_checkpos = cl_get_para(g_enterprise,g_site,'S-CIR-2037') 
#   IF l_checkpos = 'Y' THEN
#      IF cl_null(lc_param.wc) OR lc_param.wc = " 1=1"  THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'sub-00772'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err() 
#         RETURN 
#      END IF
#   END IF
#   
#   #若aoos020参数S-CIR-2037勾选，则呼叫pos服务，检查门店日结是否有上传
#   #参数=Y 需呼叫POS 服务。若返回值等于N，则不继续往下走逻辑
#   #参数=N 则不呼叫POS服务。走原来逻辑
#   IF l_checkpos = 'Y' THEN
#      IF NOT cl_null(lc_param.wc) THEN
#         LET l_str = cl_replace_str(lc_param.wc,"rtjasite","ooef001")  #参数值替换
#      END IF
#   
#      LET l_flag = 'Y'
#      CALL cl_err_collect_init()
#      IF NOT s_check_pos_upload_json('c',l_str,g_master.rtjadocdt) THEN
#         LET l_flag = 'N'
#      END IF
#      CALL cl_err_collect_show()
#      IF l_flag = 'N' THEN
#         RETURN
#      END IF
#   END IF
#   #161206-00005#3---add--end---------------
#   
#   #160225-00040#4 Add By Ken 160401(S)  資料準備 
#   LET l_msg = cl_getmsg('ade-00114',g_lang)   
#   CALL cl_progress_no_window_ing(l_msg)   
#   #160225-00040#4 Add By Ken 160401(E)    
#   
#   #151027-00016#5 151130 by lori add---(S)
#   LET l_log = "Start adep220_process... ",cl_get_timestamp()
#   CALL cl_log_write(l_log)                                                                    
#   DISPLAY l_log
#   #151027-00016#5 151130 by lori add---(S)
#   
#   #150515-00023#6 150903 by lori add---(S)
#   LET l_cnt = 0
#   LET l_err_cnt = 0
#   LET l_succ_cnt = 0
#   #150515-00023#6 150903 by lori add---(E)
#   
#   ##150804-00018#1 Add By Ken 150805(S)
#   LET l_date_tmp = YEAR(lc_param.rtjadocdt) USING "<<<<","-",MONTH(lc_param.rtjadocdt) USING "&#","-",DAY(lc_param.rtjadocdt) USING "<<<<" ," 23:59:59"
#   LET g_rtia006 = l_date_tmp   
#   ##150804-00018#1 Add By Ken 150805(E)
#   
#   #建temp table
#   #150515-00023#6 150903 by lori add---(S)
#   CALL adep220_create_temp()   
#   CREATE INDEX adep220_tmp_01 ON adep220_tmp(rtjadocdt,rtjbsite)
#   #150515-00023#6 150903 by lori add---(E)
#   
#   ##################################### 筛选出符合关帐日期的营运组织
#   IF NOT cl_null(lc_param.wc) THEN
#      LET l_str = cl_replace_str(lc_param.wc,"rtjasite","ooef001")
#   END IF
#   
#   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where    #150526
#   
#   LET l_sql  = "SELECT ooef001 ",
#                "  FROM ooef_t ",
#                " WHERE ooefent = '",g_enterprise,"' ",
#                "   AND ",l_str
#   PREPARE sel_ooef FROM l_sql
#   DECLARE cur_ooef CURSOR FOR sel_ooef
#   
#   LET l_str = ''
#   CALL cl_err_collect_init()
#
#   #151027-00016#5 151130 by lori add---(S)
#   LET l_log = "-Foreach: cur_ooef, Start: ",cl_get_timestamp()
#   CALL cl_log_write(l_log)                                                                    
#   DISPLAY l_log
#   #151027-00016#5 151130 by lori add---(E)
#   
#   FOREACH cur_ooef INTO l_ooef001
#      LET l_cnt = l_cnt + 1                                        #150515-00023#6 150903 by lori add 
#      
#      IF NOT s_settledate_chk(l_ooef001,lc_param.rtjadocdt) THEN
#         LET l_err_cnt = l_err_cnt + 1                             #150515-00023#6 150903 by lori add
#         CONTINUE FOREACH
#      END IF
#      
#      IF cl_null(l_str) THEN
#         LET l_str = "'",l_ooef001,"'"
#      ELSE
#         LET l_str = l_str,",'",l_ooef001,"'"
#      END IF
# 
#      LET l_succ_cnt = l_succ_cnt + 1                              #150515-00023#6 150903 by lori add 
#   END FOREACH   
#   CALL cl_err_collect_show()  
#   
#   #151027-00016#5 151130 by lori add---(S)
#   LET l_log = "-Foreach: cur_ooef, End: ",cl_get_timestamp()
#   CALL cl_log_write(l_log)                                                                    
#   DISPLAY l_log
#   #151027-00016#5 151130 by lori add---(E)
#   
#   #150515-00023#6 150903 by lori add---(S)
#   LET l_log = "-Before Process, check parameter setting for date, ",
#               "organization totle(",l_cnt,"), success(",l_succ_cnt,"), error(",l_cnt,") "       
#   CALL cl_log_write(l_log)  
#   DISPLAY l_log
#   #150515-00023#6 150903 by lori add---(E)
#   
#   IF NOT cl_null(l_str) THEN
#      LET lc_param.wc = " rtjasite IN (",l_str,")"
#   #150515-00023#6 150903 by lori add---(S)
#   ELSE
#      RETURN
#   #150515-00023#6 150903 by lori add---(E)      
#   END IF    
#   #####################################
#   #CALL adep220_create_temp()   #150515-00023#6 150903 by lori mark
#   
#   #塞入組織
#   #150525 s983961 mark---s
#   # LET g_sql = "INSERT INTO adep220_ooed004_tmp ",
#   #             "SELECT DISTINCT ooed004 ",
#   #             "  FROM ooed_t ",
#   #             " WHERE     ooedent = '",g_enterprise,"'",
#   #             "       AND ooed001 = '2' ",
#   #             "       AND ooed006 <= '",g_today,"'",
#   #             "       AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#   #             "       AND ooed004 IN ",
#   #             "              (    SELECT ooed004 ",
#   #             "                     FROM ooed_t ",
#   #             "               START WITH     ooed005 = '",g_site,"'",
#   #             "                          AND ooed001 = '2' ",
#   #             "                          AND ooed006 <= '",g_today,"'",
#   #             "                          AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#   #             "               CONNECT BY NOCYCLE     PRIOR ooed004 = ooed005 ",
#   #             "                                  AND ooed001 = '2' ",
#   #             "                                  AND ooed006 <= '",g_today,"'",
#   #             "                                  AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#   #             "               UNION ",
#   #             "               SELECT ooed004 ",
#   #             "                 FROM ooed_t ",
#   #             "                WHERE ooed004 = '",g_site,"') "
#   #PREPARE adep220_p2 FROM g_sql           
#   #EXECUTE adep220_p2
#   #150525 s983961 mark---e  
#
#   #160804-00060#1 160809 by lori add---(S)   
#   #先檢查可能造成扣帳錯誤的資料, 如有符合就不往下執行
#   IF g_bgjob <> "Y" THEN
#      LET l_loop = 5
#      CALL cl_progress_bar_no_window(l_loop) 
#   END IF
#   
#   LET l_err_cnt  = 0 
#   LET g_exitstus = TRUE
#   CALL cl_err_collect_init()
#   
#   #資料來源:資料檢查與寫入暫存檔均用此來源&過濾條件為基礎
#   LET l_source = "  FROM rtjb_t, rtja_t ",
#                  " WHERE rtjbent = rtjaent ",
#                  "   AND rtjbdocno = rtjadocno ",
#                  "   AND rtjastus <> 'X' ",
#                  "   AND rtja032 <> '1' ",
#                  "   AND rtja006 IS NULL ",
#                  "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
#                  "   AND rtjaent = '",g_enterprise,"'",
#                  "   AND COALESCE(rtjb101,'Y') <> 'N' ",         
#                  "   AND ",lc_param.wc,                           
#                  "  AND ",l_where   
#     
#   LET l_ins_source = "SELECT rtjbent,rtjbsite,             rtjbunit,rtjborga,rtjadocdt,",
#                      "       rtjb004,COALESCE(rtjb005,' '),rtjb012, rtjb013,rtjb014, ",   
#                      "       rtjb015,rtjb017,              rtjb018, rtjb021,rtjb025,",    
#                      "       rtjb026,rtjb027,              rtjb032, rtjb010,rtjb022, ",   
#                      "       rtjb008,rtjb020, ",                                                  
#                      "       rtjb028 ",l_source
#                      
#   #1.商品編號為空白
#   IF g_bgjob <> "Y" THEN
#      #正在檢查商品是否為空
#      LET l_msg = cl_getmsg('art-00803',g_lang)
#      CALL cl_progress_no_window_ing(l_msg) 
#   END IF   
#   
#   LET l_chk_source = "SELECT rtjbdocno,rtjbseq ",
#                      l_source,
#                      "   AND rtjb004 IS NULL ",
#                      " ORDER BY rtjbdocno,rtjbseq "                      
#   PREPARE adep220_sour_chk_pre1 FROM l_chk_source  
#   DECLARE adep220_sour_chk_cur1 CURSOR FOR adep220_sour_chk_pre1
#  #DISPLAY "adep220_sour_chk_pre1 SQL:",l_chk_source
#   
#   LET l_code = 'art-00799'
#   LET l_rtjbdocno = ''
#   LET l_rtjbseq = ''
#   FOREACH adep220_sour_chk_cur1 INTO l_rtjbdocno,l_rtjbseq
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur1"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()   
#         LET l_err_cnt = l_err_cnt + 1 
#      END IF 
#      
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = l_code
#      LET g_errparam.replace[1] = l_rtjbdocno
#      LET g_errparam.replace[2] = l_rtjbseq
#      LET g_errparam.popup = TRUE
#      CALL cl_err()  
#      LET l_err_cnt = l_err_cnt + 1
#            
#      LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code
#      CALL cl_log_write(l_log)                                                                    
#      DISPLAY l_log 
#
#      LET l_rtjbdocno = ''
#      LET l_rtjbseq = ''
#   END FOREACH
#   
#   #2.商品不存在門店清單
#   IF g_bgjob <> "Y" THEN
#     LET l_msg = cl_getmsg('art-00804',g_lang)
#     CALL cl_progress_no_window_ing(l_msg)
#   END IF
#   
#   LET l_chk_source = "SELECT UNIQUE rtjbdocno,rtjbseq,rtjbsite,rtjb004 ",
#                      l_source,
#                      "   AND rtjb004 IS NOT NULL ",
#                      "   AND NOT EXISTS(SELECT 1 FROM rtdx_t ",
#                      "                   WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004) ",
#                      " ORDER BY rtjbdocno,rtjbseq " 
#   PREPARE adep220_sour_chk_pre2 FROM l_chk_source
#   DECLARE adep220_sour_chk_cur2 CURSOR FOR adep220_sour_chk_pre2
#  #DISPLAY "adep220_sour_chk_pre2 SQL:",l_chk_source
#
#   LET l_rtjbdocno = ''
#   LET l_rtjbseq = ''
#   LET l_rtjbsite = ''
#   LET l_rtjb004 = ''
#   LET l_code = 'art-00800'
#   FOREACH adep220_sour_chk_cur2 INTO l_rtjbdocno,l_rtjbseq,l_rtjbsite,l_rtjb004
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur2"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()   
#         LET l_err_cnt = l_err_cnt + 1 
#      END IF 
#
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = l_code
#      LET g_errparam.replace[1] = l_rtjbdocno
#      LET g_errparam.replace[2] = l_rtjbseq
#      LET g_errparam.replace[3] = l_rtjbsite
#      LET g_errparam.replace[4] = l_rtjb004
#      LET g_errparam.popup = TRUE
#      CALL cl_err()  
#      LET l_err_cnt = l_err_cnt + 1
#
#      LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Site: ",l_rtjbsite," Production: ",l_rtjb004
#      CALL cl_log_write(l_log)                                                                    
#      DISPLAY l_log
#      
#      LET l_rtjbdocno = ''
#      LET l_rtjbseq = ''      
#      LET l_rtjbsite = ''
#      LET l_rtjb004 = ''      
#   END FOREACH
#   
#   #3.商品單位轉換率問題
#   IF g_bgjob <> "Y" THEN
#      #正在檢查銷售單位與庫存單位轉換率設定
#      LET l_msg = cl_getmsg('art-00805',g_lang)
#      CALL cl_progress_no_window_ing(l_msg)
#   END IF
#   
#   LET l_chk_source = "SELECT rtjbdocno,rtjbseq,rtjb004,rtjb013,rtjb015 ",
#                      l_source,
#                      "   AND rtjb004 IS NOT NULL ",
#                      "   AND rtjb013 <> rtjb015 ",
#                      "   AND EXISTS(SELECT 1 FROM imaa_t ",
#                      "               WHERE imaaent = rtjbent AND imaa001 = rtjb004 AND imaa004 <> 'E') ",
#                      "   AND EXISTS(SELECT 1 FROM rtdx_t ",
#                      "                   WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite ",
#                      "                     AND rtdx001 = rtjb004 AND rtdx003 <> '4' AND rtdx003 <> '5') ",                      
#                      "   AND NOT EXISTS(SELECT 1 FROM imad_t ",
#                      "                   WHERE imadent = rtjbent AND imad001 = rtjb004 ",
#                      "                     AND ((imad002 = rtjb013 AND imad004 = rtjb015) OR (imad002 = rtjb015 AND imad004 = rtjb013))",
#                      "                     AND imadstus = 'Y' ",
#                      "                     AND (COALESCE(imad003,0) <> 0 OR COALESCE(imad005,0) <> 0)) ",
#                      "   AND NOT EXISTS(SELECT 1 FROM oocc_t ",
#                      "                   WHERE ooccent = rtjbent ",
#                      "                     AND ((oocc001 = rtjb013 AND oocc003 = rtjb015) OR (oocc001 = rtjb015 AND oocc003 = rtjb013)) ",
#                      "                     AND ooccstus = 'Y' ",
#                      "                     AND  (COALESCE(oocc002,0) <> 0 OR COALESCE(oocc004,0) <> 0)) "
#   PREPARE adep220_sour_chk_pre3 FROM l_chk_source
#   DECLARE adep220_sour_chk_cur3 CURSOR FOR adep220_sour_chk_pre3
#  #DISPLAY "adep220_sour_chk_pre3 SQL:",l_chk_source  
#  
#   LET l_rtjbdocno = ''
#   LET l_rtjbseq = ''
#   LET l_rtjb004 = ''
#   LET l_rtjb013 = ''
#   LET l_rtjb015 = ''
#   LET l_code = 'art-00813'
#   FOREACH adep220_sour_chk_cur3 INTO l_rtjbdocno,l_rtjbseq,l_rtjb004,l_rtjb013,l_rtjb015
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur3"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()   
#         LET l_err_cnt = l_err_cnt + 1 
#      END IF 
#
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = l_code
#      LET g_errparam.replace[1] = l_rtjbdocno
#      LET g_errparam.replace[2] = l_rtjbseq
#      LET g_errparam.replace[3] = l_rtjb004
#      LET g_errparam.replace[4] = l_rtjb013
#      LET g_errparam.replace[5] = l_rtjb015
#      LET g_errparam.popup = TRUE
#      CALL cl_err()  
#      LET l_err_cnt = l_err_cnt + 1
#
#      LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Production: ",l_rtjb004," SaleUnit: ",l_rtjb013," InvUnit:",l_rtjb015
#      CALL cl_log_write(l_log)                                                                    
#      DISPLAY l_log   
#      
#      LET l_rtjbdocno = ''
#      LET l_rtjbseq = ''      
#      LET l_rtjb004 = ''
#      LET l_rtjb013 = ''
#      LET l_rtjb015 = ''
#      LET l_log = ""      
#   END FOREACH   
#   
#   #4.庫區不存在
#   IF g_bgjob <> "Y" THEN
#      #正在檢查庫位是否存在
#      LET l_msg = cl_getmsg('art-00806',g_lang)
#      CALL cl_progress_no_window_ing(l_msg)
#   END IF
#   
#   LET l_chk_source = "SELECT rtjbdocno,rtjbseq,rtjbsite,rtjb025 ",
#                      l_source,
#                      "   AND EXISTS(SELECT 1 FROM imaa_t ",
#                      "               WHERE imaaent = rtjbent AND imaa001 = rtjb004 AND imaa004 <> 'E') ",
#                      "   AND EXISTS(SELECT 1 FROM rtdx_t ",
#                      "               WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite ",
#                      "                 AND rtdx001 = rtjb004 AND rtdx003 <> '4' AND rtdx003 <> '5') ",                      
#                      "   AND NOT EXISTS(SELECT 1 FROM inaa_t ",
#                      "                   WHERE inaaent = rtjbent AND inaasite = rtjbsite AND inaa001 = rtjb025) "
#   PREPARE adep220_sour_chk_pre4 FROM l_chk_source
#   DECLARE adep220_sour_chk_cur4 CURSOR FOR adep220_sour_chk_pre4  
#  #DISPLAY "adep220_sour_chk_pre4 SQL:",l_chk_source
#   
#   LET l_rtjbdocno = ''
#   LET l_rtjbseq = ''
#   LET l_rtjbsite = ''
#   LET l_rtjb025 = ''
#   LET l_code = 'art-00801'
#   FOREACH adep220_sour_chk_cur4 INTO l_rtjbdocno,l_rtjbseq,l_rtjbsite,l_rtjb025
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur4"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()   
#         LET l_err_cnt = l_err_cnt + 1 
#      END IF 
#
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = l_code
#      LET g_errparam.replace[1] = l_rtjbdocno
#      LET g_errparam.replace[2] = l_rtjbseq
#      LET g_errparam.replace[3] = l_rtjbsite
#      LET g_errparam.replace[4] = l_rtjb025
#      LET g_errparam.popup = TRUE
#      CALL cl_err()  
#      LET l_err_cnt = l_err_cnt + 1
#
#      LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Site: ",l_rtjbsite," Subinv: ",l_rtjb025
#      CALL cl_log_write(l_log)                                                                    
#      DISPLAY l_log
#      
#      LET l_rtjbdocno = ''
#      LET l_rtjbseq = ''      
#      LET l_rtjbsite = ''
#      LET l_rtjb025 = ''     
#   END FOREACH
#   
#  ##5.商品取到兩筆以上協議或查無協議 
#  #IF g_bgjob <> "Y" THEN
#  #   #正在檢查商品是否有對應的採購協議或是對應多筆協議
#  #   LET l_msg = cl_getmsg('art-00807',g_lang)
#  #   CALL cl_progress_no_window_ing(l_msg)
#  #END IF
#  #
#  #LET l_chk_source = "SELECT rtjbdocno,rtjbseq,rtjbsite,rtjb004  ", 
#  #                   " FROM (SELECT rtjbdocno,rtjbseq,rtjbsite,rtjb004,COUNT(star001) cnt_star001 ",
#  #                   "             FROM (SELECT rtjbent,rtjbdocno,rtjbseq,rtjbsite,rtjb004,rtjadocdt,star001 ",                                                                              
#  #                   "                     FROM (SELECT rtjbent,rtjbdocno,rtjbseq,rtjbsite,rtjb004,rtjadocdt, ",
#  #                   "                                  (SELECT imaf153 FROM imaf_t WHERE imafent = rtjbent AND imafsite = rtjbsite AND imaf001 = rtjb004) imaf153, ",
#  #                   "                                  (SELECT rtdx003 FROM rtdx_t WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004) rtdx003 ",
#  #                   "                          ",l_source,
#  #                   "                              AND rtjb004 IS NOT NULL) ",
#  #                   "                     LEFT JOIN (SELECT stas003,stas018,stas019, starent,star001,star003,star005,starsite ",
#  #                   "                                  FROM stas_t,star_t WHERE stasent = starent AND stas001 = star001) ",
#  #                   "                            ON starent = rtjbent AND starsite = rtjbsite AND star003 = imaf153 AND star005 = rtdx003 ",
#  #                   "                           AND stas003 = rtjb004   AND stas018 <= rtjadocdt AND (stas019 >= rtjadocdt OR stas019 IS NULL)) ",
#  #                   "        GROUP BY rtjbdocno,rtjbseq, rtjbsite,rtjb004) ",
#  #                   "  WHERE cnt_star001 <> 1 "
#  #PREPARE adep220_sour_chk_pre5 FROM l_chk_source
#  #DECLARE adep220_sour_chk_cur5 CURSOR FOR adep220_sour_chk_pre5 
#  #DISPLAY "adep220_sour_chk_pre5 SQL:",l_chk_source 
#  #
#  #LET l_rtjbdocno = ''
#  #LET l_rtjbseq = ''
#  #LET l_rtjbsite = ''
#  #LET l_rtjb004 = ''
#  #LET l_code = 'art-00802'
#  #FOREACH adep220_sour_chk_cur5 INTO l_rtjbsite,l_rtjb004
#  #   IF SQLCA.sqlcode THEN
#  #      INITIALIZE g_errparam TO NULL
#  #      LET g_errparam.code = SQLCA.sqlcode
#  #      LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur5"
#  #      LET g_errparam.popup = TRUE
#  #      CALL cl_err()   
#  #      LET l_err_cnt = l_err_cnt + 1 
#  #   END IF 
#  # 
#  #   INITIALIZE g_errparam TO NULL
#  #   LET g_errparam.code = l_code
#  #   LET g_errparam.replace[1] = l_rtjbsite
#  #   LET g_errparam.replace[2] = l_rtjb004
#  #   LET g_errparam.popup = TRUE
#  #   CALL cl_err()  
#  #   LET l_err_cnt = l_err_cnt + 1
#  # 
#  #   LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Site: ",l_rtjbsite," Production: ",l_rtjb004
#  #   CALL cl_log_write(l_log)                                                                    
#  #   DISPLAY l_log
#  #   
#  #   LET l_rtjbdocno = ''
#  #   LET l_rtjbseq = ''      
#  #   LET l_rtjbsite = ''
#  #   LET l_rtjb004 = ''
#  #END FOREACH
#   CALL cl_err_collect_show() 
#   
#   IF l_err_cnt > 0 THEN
#      LET g_exitstus = FALSE  
#      IF g_bgjob <> "Y" THEN
#         LET l_msg = cl_getmsg('std-00012',g_lang)
#         CALL cl_progress_no_window_ing(l_msg) 
#      END IF   
#      RETURN
#   ELSE
#      IF g_bgjob <> "Y" THEN
#         LET l_msg = cl_getmsg('art-00808',g_lang)
#         CALL cl_progress_no_window_ing(l_msg)
#      END IF   
#   END IF
#   #160804-00060#1 160809 by lori add---(S)
#
#   #塞資料
#   LET g_sql = "INSERT INTO adep220_tmp ", l_ins_source    #160804-00060#1 160809 by lori add:l_ins_source                
#             #160804-00060#1 160809 by lori mark--(S)  
#             # "SELECT rtjbent,rtjbsite,             rtjbunit,rtjborga,rtjadocdt,",
#             # "       rtjb004,COALESCE(rtjb005,' '),rtjb012, rtjb013,rtjb014, ",   #ken---modify 150108-00008#1 rtjb005改為COALESCE(rtjb005,' ')
#             # "       rtjb015,rtjb017,              rtjb018, rtjb021,rtjb025,",                     
#             # "       rtjb026,rtjb027,              rtjb032, rtjb010,rtjb022, ",   #150616-00044#1 15/06/17 s983961---add(rtjb032) 
#             # "       rtjb008,rtjb020, ",                                          #150623-00021#1 15/06/24 s983961--add 沒有標準售價rtjb008 所以帶不出 總銷貨金額                  
#             # "       rtjb028 ",                                                   #151029-00011#4 Add By Ken 151102 加(rtjb028)
#             # "  FROM rtjb_t, rtja_t ",
#             # " WHERE rtjbent = rtjaent ",
#             # "   AND rtjbdocno = rtjadocno ",
#             # "   AND rtjastus <> 'X' ",
#             # "   AND rtja032 <> '1' ",
#             # "   AND rtja006 IS NULL ",
#             ##"   AND EXISTS (SELECT ooed004 ",               #150525 s983961 mark
#             ##"                 FROM adep220_ooed004_tmp ",   #150525 s983961 mark
#             ##"                WHERE ooed004 = rtjasite) ",   #150525 s983961 mark
#             # "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
#             # "   AND rtjaent = '",g_enterprise,"'",
#             # "   AND COALESCE(rtjb101,'Y') != 'N' ",         #160506-00009#13 20160511 add by beckxie
#             # "   AND ",lc_param.wc,
#             # "  AND ",l_where                                #150525 s983961 add
#             #160804-00060#1 160809 by lori mark--(E)  
#   PREPARE adep220_p1 FROM g_sql
#  #DISPLAY "[adep220_p1]SQL: ",g_sql   
#   EXECUTE adep220_p1   
#   IF SQLCA.SQLcode THEN
#      #151027-00016#5 151130 by lori mark and add---(S)
#      ##寫入Log檔_(s)
#      #CALL cl_log_write("Error:INSERT INTO adep220_tmp")
#      #CALL cl_log_write(g_sql)
#      
#      ##寫入Log檔_(e)
#      LET l_log = "-Error#01 : Insert adep220_tmp fail, SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160111-00006#2 160111 By pomelo add#01
#      CALL cl_log_write(l_log)                                                                    
#      DISPLAY l_log
#      
#      LET l_log = "--SQL: ",g_sql
#      CALL cl_log_write(l_log)
#      DISPLAY l_log
#      #151027-00016#5 151130 by lori mark and add---(E)
#
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "ins temp"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      LET g_exitstus = FALSE   #160804-00060#1 160809 by lori add
#      RETURN            
#   END IF
#  #CREATE INDEX adep220_tmp_01 on adep220_tmp(rtjadocdt,rtjbsite)   #150515-00023#6 150903 by lori mark           
#               
#   LET g_sql = "SELECT rtjbent,rtjbsite,rtjbunit,rtjborga,rtjadocdt,",
#               #"       rtjb004,rtjb005,SUM(rtjb012),rtjb013,SUM(rtjb014),rtjb015,",               #161017-00050#1 Mark By Ken 161021  
#               "       rtjb004,COALESCE(rtjb005,' '),SUM(rtjb012),rtjb013,SUM(rtjb014),rtjb015,",  #161017-00050#1 Add By Ken 161021  
#               "       SUM(rtjb017),rtjb018,SUM(rtjb021),rtjb025,rtjb026,rtjb027,rtjb032,",   #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補 rtjb032
#               "       rtjb010,SUM(rtjb022),rtjb008,SUM(rtjb020),",                           #150623-00021#1 15/06/24 s983961--add  
#               "       rtjb028 ",                                                             #151029-00011#4 Add By Ken 151102 加rtjb028
#               "  FROM adep220_tmp ",
#               " GROUP BY rtjbent,rtjbsite,rtjbunit,rtjborga,rtjadocdt,",
#               #"          rtjb004,rtjb005,rtjb013,rtjb015,",               #161017-00050#1 Mark By Ken 161021
#               "          rtjb004,COALESCE(rtjb005,' '),rtjb013,rtjb015,",  #161017-00050#1 Add By Ken 161021 
#               "          rtjb018,rtjb025,rtjb026,rtjb027,rtjb032,",  #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補 rtjb032
#               "          rtjb010,rtjb008,",                          #150623-00021#1 15/06/24 s983961--add 
#               "          rtjb028 ",                                  #151029-00011#4 Add By Ken 151102 加(rtjb028)  
#               " ORDER BY rtjadocdt,rtjbsite"
#               
#   DECLARE adep220_cl2 CURSOR FROM g_sql   
#   #回填過帳日
#   LET g_sql = "UPDATE rtja_t ",
#               "   SET rtja006 = ? ",
#               " WHERE rtjastus <> 'X' ",
#               "   AND rtja032 <> '1' ",
#               "   AND rtja006 IS NULL ",
#              #"   AND EXISTS (SELECT ooed004 ",               #150525 s983961 mark
#              #"                 FROM adep220_ooed004_tmp ",   #150525 s983961 mark
#              #"                WHERE ooed004 = rtjasite) ",   #150525 s983961 mark
#               "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
#               "   AND rtjaent = '",g_enterprise,"'",
#               "   AND ",lc_param.wc
#               ,"  AND ",l_where   #150525 s983961 add
#   PREPARE adep220_p FROM g_sql
#161216-00004#2 161226 by lori mark---(E)   

   #161216-00004#2 161226 by lori add---(S) 
   #(1)整理邏輯並調整支援跨門店與日期進行結算,一併整理原單註記
   #(2)匯總錯誤訊息增加門店與日期的資訊
   #(3)處理流程有異動時,須留意ProgressBar狀態
   
   #LOG紀錄,參考原單:151027-00016#5
   LET l_log = "Start adep220_process... ",cl_get_timestamp()
   CALL cl_log_write(l_log)                                                                    
   DISPLAY l_log
   
   #ProgressBar處理,參考原單:160225-00040#4
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('ade-00114',g_lang)      #資料準備
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   
   #0.前置處理
   #0.1.檢查門店編號是否為空或為*(即1=1)
   IF cl_null(lc_param.wc) OR lc_param.wc = "rtjasite like '%'" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ade-00182"   #門店編號不可為空或「*」
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      LET g_exitstus = FALSE      
      RETURN      
   END IF  
            
   #0.2.結算截止日為空時給予預設
   IF cl_null(lc_param.rtjadocdt_end) THEN
      LET lc_param.rtjadocdt_end = lc_param.rtjadocdt   
   END IF
   
   #0.3.統計需要結算的天數
   LET l_dat_cnt = 0
   LET l_dat_cnt = lc_param.rtjadocdt_end - lc_param.rtjadocdt + 1    
   
   #0.4.取得aooi500組織管控的過濾條件
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where    #150526
      
   #0.5.替換過濾條件的欄位名稱
   LET l_str = ''
   LET l_str = cl_replace_str(lc_param.wc,"rtjasite","ooef001")," AND ",cl_replace_str(l_where,"rtjasite","ooef001")    
   
   #0.6.準備需處理的門店清單,參考原CURSOR:sel_ooef   
   LET l_sql = "SELECT ooef001 FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND ",l_str      
   PREPARE adep220_sel_ooef_pre FROM l_sql               
   DECLARE adep220_sel_ooef_cur CURSOR WITH HOLD FOR adep220_sel_ooef_pre
   
   #0.7.建temp table和index,參考原單:150515-00023#6
   CALL adep220_create_temp()   
   CREATE INDEX adep220_tmp_01 ON adep220_tmp(rtjadocdt,rtjbsite)

   #0.8.SQL準備:檢查可能造成扣帳錯誤的資料,參考原單:160804-00060#1---(S)
   #資料來源:資料檢查與寫入暫存檔均用此來源&過濾條件為基礎
   LET l_source = "  FROM rtjb_t, rtja_t ",
                  " WHERE rtjbent = rtjaent ",
                  "   AND rtjbdocno = rtjadocno ",
                  "   AND rtjastus <> 'X' ",
                  "   AND rtja032 <> '1' ",
                  "   AND rtja006 IS NULL ",
                  "   AND rtjadocdt = ? ",                   #改傳日期變數
                  "   AND rtjaent = '",g_enterprise,"'",
                  "   AND COALESCE(rtjb101,'Y') <> 'N' ",         
                  "   AND rtjasite = ? ",                    #改傳門店編號變數
                  "   AND ",l_where   
     
   LET l_ins_source = "SELECT rtjbent,rtjbsite,             rtjbunit,rtjborga,rtjadocdt,",
                      "       rtjb004,COALESCE(rtjb005,' '),rtjb012, rtjb013, rtjb014, ",   
                      "       rtjb015,rtjb017,              rtjb018, rtjb021, rtjb025,",    
                      "       rtjb026,rtjb027,              rtjb032, rtjb010, rtjb022, ",   
                      "       rtjb008,rtjb020, ",                                                  
                      "       rtjb028 ",l_source
   
   #檢查是否有符合的資料,新PREPARE:161216-00004#2 add
   LET g_sql = "SELECT COUNT(rtjbdocno) ",l_source  
   PREPARE adep220_cnt_source FROM g_sql
   
   #0.8.1.檢查:商品編號為空白
   LET l_chk_source = "SELECT rtjbdocno,rtjbseq ",
                      l_source,
                      "   AND rtjb004 IS NULL ",
                      " ORDER BY rtjbdocno,rtjbseq "                      
   PREPARE adep220_sour_chk_pre1 FROM l_chk_source  
   DECLARE adep220_sour_chk_cur1 CURSOR FOR adep220_sour_chk_pre1
  #DISPLAY "adep220_sour_chk_pre1 SQL:",l_chk_source    

   #0.8.2.商品不存在門店清單
   LET l_chk_source = "SELECT UNIQUE rtjbdocno,rtjbseq,rtjbsite,rtjb004 ",
                      l_source,
                      "   AND rtjb004 IS NOT NULL ",
                      "   AND NOT EXISTS(SELECT 1 FROM rtdx_t ",
                      "                   WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004) ",
                      " ORDER BY rtjbdocno,rtjbseq " 
   PREPARE adep220_sour_chk_pre2 FROM l_chk_source
   DECLARE adep220_sour_chk_cur2 CURSOR FOR adep220_sour_chk_pre2
  #DISPLAY "adep220_sour_chk_pre2 SQL:",l_chk_source

   #0.8.3.商品單位轉換率問題
   LET l_chk_source = "SELECT rtjbdocno,rtjbseq,rtjb004,rtjb013,rtjb015 ",
                      l_source,
                      "   AND rtjb004 IS NOT NULL ",
                      "   AND rtjb013 <> rtjb015 ",
                      "   AND EXISTS(SELECT 1 FROM imaa_t ",
                      "               WHERE imaaent = rtjbent AND imaa001 = rtjb004 AND imaa004 <> 'E') ",
                      "   AND EXISTS(SELECT 1 FROM rtdx_t ",
                      "                   WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite ",
                      "                     AND rtdx001 = rtjb004 AND rtdx003 <> '4' AND rtdx003 <> '5') ",                      
                      "   AND NOT EXISTS(SELECT 1 FROM imad_t ",
                      "                   WHERE imadent = rtjbent AND imad001 = rtjb004 ",
                      "                     AND ((imad002 = rtjb013 AND imad004 = rtjb015) OR (imad002 = rtjb015 AND imad004 = rtjb013))",
                      "                     AND imadstus = 'Y' ",
                      "                     AND (COALESCE(imad003,0) <> 0 OR COALESCE(imad005,0) <> 0)) ",
                      "   AND NOT EXISTS(SELECT 1 FROM oocc_t ",
                      "                   WHERE ooccent = rtjbent ",
                      "                     AND ((oocc001 = rtjb013 AND oocc003 = rtjb015) OR (oocc001 = rtjb015 AND oocc003 = rtjb013)) ",
                      "                     AND ooccstus = 'Y' ",
                      "                     AND  (COALESCE(oocc002,0) <> 0 OR COALESCE(oocc004,0) <> 0)) "
   PREPARE adep220_sour_chk_pre3 FROM l_chk_source
   DECLARE adep220_sour_chk_cur3 CURSOR FOR adep220_sour_chk_pre3
  #DISPLAY "adep220_sour_chk_pre3 SQL:",l_chk_source    
  
   #0.8.4.庫區不存在
   LET l_chk_source = "SELECT rtjbdocno,rtjbseq,rtjbsite,rtjb025 ",
                      l_source,
                      "   AND EXISTS(SELECT 1 FROM imaa_t ",
                      "               WHERE imaaent = rtjbent AND imaa001 = rtjb004 AND imaa004 <> 'E') ",
                      "   AND EXISTS(SELECT 1 FROM rtdx_t ",
                      "               WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite ",
                      "                 AND rtdx001 = rtjb004 AND rtdx003 <> '4' AND rtdx003 <> '5') ",                      
                      "   AND NOT EXISTS(SELECT 1 FROM inaa_t ",
                      "                   WHERE inaaent = rtjbent AND inaasite = rtjbsite AND inaa001 = rtjb025) "
   PREPARE adep220_sour_chk_pre4 FROM l_chk_source
   DECLARE adep220_sour_chk_cur4 CURSOR FOR adep220_sour_chk_pre4  
  #DISPLAY "adep220_sour_chk_pre4 SQL:",l_chk_source  
   #SQL準備:檢查可能造成扣帳錯誤的資料,參考原單:160804-00060#1---(E)
   
   #0.9.SQL準備:寫入暫存檔
   LET g_sql = "INSERT INTO adep220_tmp ", l_ins_source    #160804-00060#1 160809 by lori add:l_ins_source                 
   PREPARE adep220_p1 FROM g_sql
  #DISPLAY "[adep220_p1]SQL: ",g_sql   
   
   #0.10.SQL準備:寫入實際銷售單據               
   LET g_sql = "SELECT rtjbent,rtjbsite,rtjbunit,rtjborga,rtjadocdt,",
               "       rtjb004,COALESCE(rtjb005,' '),SUM(rtjb012),rtjb013,SUM(rtjb014),rtjb015,",  #161017-00050#1 Add By Ken 161021  
               "       SUM(rtjb017),rtjb018,SUM(rtjb021),rtjb025,rtjb026,rtjb027,rtjb032,",        #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補 rtjb032
               "       rtjb010,SUM(rtjb022),rtjb008,SUM(rtjb020),",                                #150623-00021#1 15/06/24 s983961--add  
               "       rtjb028 ",                                                                  #151029-00011#4 Add By Ken 151102 加rtjb028
               "  FROM adep220_tmp ",
               " GROUP BY rtjbent,rtjbsite,rtjbunit,rtjborga,rtjadocdt,",
               "          rtjb004,COALESCE(rtjb005,' '),rtjb013,rtjb015,",  #161017-00050#1 Add By Ken 161021 
               "          rtjb018,rtjb025,rtjb026,rtjb027,rtjb032,",        #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補 rtjb032
               "          rtjb010,rtjb008,",                                #150623-00021#1 15/06/24 s983961--add 
               "          rtjb028 ",                                        #151029-00011#4 Add By Ken 151102 加(rtjb028)  
               " ORDER BY rtjadocdt,rtjbsite"               
   DECLARE adep220_cl2 CURSOR FROM g_sql   
   
   #0.11.SQL準備:更新過帳日
   LET g_sql = "UPDATE rtja_t ",
               "   SET rtja006 = ?, ",
               "       rtja067 = ?  ",   #170106-00034#1 by sakura add
               " WHERE rtjastus <> 'X' ",
               "   AND rtja032 <> '1' ",
               "   AND rtja006 IS NULL ",
               "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND ",lc_param.wc
               ,"  AND ",l_where   #150525 s983961 add
   PREPARE adep220_p FROM g_sql
   #161216-00004#2 161226 by lori add---(E) 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #161216-00004#2 161226 by lori mark---(S)
      ##160225-00040#4 Add By Ken 160401(S)
      #LET l_loop = 4
      #CALL cl_progress_bar_no_window(l_loop)  
      ##160225-00040#4 Add By Ken 160401(E)      
      #LET li_count = 0
      #SELECT COUNT(rtjbsite) INTO li_count
      #  FROM adep220_tmp 
      #161216-00004#2 161226 by lori mark---(E)  
      
      #161216-00004#2 161226 by lori add---(S) 
      LET l_cnt = 0  
      LET li_count = 0   
      LET l_sql = "SELECT COUNT(ooef001) FROM ooef_t ",
                  " WHERE ooefent = ",g_enterprise,
                  "   AND ",l_str
      PREPARE adep220_cnt_ooef FROM l_sql
      EXECUTE adep220_cnt_ooef INTO l_cnt
      
      #ProgressBar計量統計      
      LET li_count =  ((l_cnt * l_dat_cnt) * 8 ) + 1      #ProgressBar計量:((門店數*結算天數)*步驟數)+完成提示
      CALL cl_progress_bar_no_window(li_count)  
      #161216-00004#2 161226 by lori add---(E) 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep220_process_cs CURSOR FROM ls_sql
#  FOREACH adep220_process_cs INTO
   #add-point:process段process name="process.process"
  #CALL adep220_ins_table()   #161216-00004#2 161226 by lori mark
   
   #161216-00004#2 161226 by lori add---(S)
   LET g_exitstus  = TRUE
   LET l_cnt       = 0
   LET l_err_cnt   = 0
   LET l_succ_cnt  = 0
   LET l_ooef001   = ''
   LET l_date      = ''
   LET l_checkpos  = ''
   LET l_org_where = ""
   LET l_site_t    = g_site
   LET l_colname_1 = ""
   LET l_comment_1 = ""
   LET l_colname_2 = ""
   LET l_comment_2 = ""   
   
  #匯總訊息初始化
  CALL cl_err_collect_init()
  #匯總訊息增加顯示欄位:門店編號
  CALL s_azzi902_get_gzzd(g_prog,"lbl_rtjasite") RETURNING l_colname_1, l_comment_1
  LET g_coll_title[1] = l_colname_1
  #匯總訊息增加顯示欄位:銷售日期
  CALL s_azzi902_get_gzzd(g_prog,"lbl_rtjadate") RETURNING l_colname_2, l_comment_2
  LET g_coll_title[2] = l_colname_2   
   
   #LOG紀錄,參考原單:151027-00016#5
   LET l_log = "-Foreach: adep220_sel_ooef_cur, Start: ",cl_get_timestamp()
   CALL cl_log_write(l_log)                                                                    
   DISPLAY l_log
   
   #結算資料檢查與產生銷售單據
   #SQL異常錯誤,g_exitstus=FALSE,中斷執行程式
   #資料檢查有誤或新增資料失敗,l_continue=FALSE,繼續執行迴圈記數ProgressBar
   FOREACH adep220_sel_ooef_cur INTO l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:adep220_sel_ooef_cur"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = ""
         LET g_errparam.coll_vals[2] = ""
         CALL cl_err()   
         
         LET g_exitstus = FALSE
      END IF  
      
      LET l_bus_date    = cl_get_para(g_enterprise,l_ooef001,"S-CIR-0003")   #參考原單:160804-00060#1
      LET l_checkpos    = cl_get_para(g_enterprise,l_ooef001,'S-CIR-2037')   #參考原單:161206-00005#3
      LET l_org_where   = " ooef001 IN ('",l_ooef001,"')"      
      LET l_continue    = TRUE
      LET l_process_cnt = 0
      LET g_site        = l_ooef001
      
      FOR l_i = 1 TO l_dat_cnt STEP 1
         LET l_err_cnt   = 0
      
         IF l_i = 1 THEN
            LET l_date = lc_param.rtjadocdt
         ELSE
            LET l_date = l_date + 1
         END IF
         LET l_str       = l_ooef001,",",l_date,":"
        #DISPLAY "Org.:",l_ooef001," AmountDate:",l_date," BussineDate:",l_bus_date," CheckPOS:",l_checkpos
         
         #1.檢查是否繼續結算(ProgressBar=1)
         IF NOT l_continue THEN
            IF g_bgjob <> "Y" THEN
               #前一天的結算有問題,不繼續往下計算,僅顯示ProgressBar
               LET l_msg = l_str,cl_getmsg('ade-00179',g_lang)   #在結算日以前有門店庫存結算異常，請先排除！
               CALL cl_progress_no_window_ing(l_msg) 
               LET l_process_cnt = l_process_cnt + 1
            END IF
            
            LET l_err_cnt = l_err_cnt + 1
            CONTINUE FOR  
         ELSE
            IF g_bgjob <> "Y" THEN
               #步驟2~4不另外顯示ProgressBar訊息
               LET l_msg = l_str,cl_getmsg('ade-00180',g_lang) #正在檢查參數設定與結算條件
               CALL cl_progress_no_window_ing(l_msg)
               LET l_process_cnt = l_process_cnt + 1               
            END IF         
         END IF
            
         #2.檢查銷售日期是否小於營業日期,參考原單:160804-00060#1
         IF l_date >= l_bus_date THEN      
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ast-00855"   #指定的銷售日期必須小於營業日期！
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()
            
            LET l_err_cnt = l_err_cnt + 1
            LET l_continue = FALSE
         END IF            
            
         #3.檢查POS資料,參考原單:161206-00005#3
         IF l_checkpos = 'Y' THEN
            #3.1.檢查參數設定:POS資料須上傳時,門店不可為空
            #    (門店編號調整為必填且不可為*,此檢查改為批次執行的第一項檢查)
            #3.2.參數設定POS資料須上傳時,檢查門店日結資料是否有上傳
            #    (調整檢查方式為一次一筆)
            IF NOT s_check_pos_upload_json('i',l_ooef001,l_date) THEN
               LET l_err_cnt = l_err_cnt + 1
               LET l_continue = FALSE
            END IF      
         END IF
         
         #4.檢查銷售日期是否大於門店關帳日期
         IF NOT s_settledate_chk(l_ooef001,l_date) THEN
            LET l_err_cnt = l_err_cnt + 1
            LET l_continue = FALSE
         END IF  
            
         #5.檢查是否有需要進行庫存日結的筆數
         LET l_cnt = 0 
         EXECUTE adep220_cnt_source USING l_date,l_ooef001 INTO l_cnt
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ade-00183"
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()  
             
            CONTINUE FOR             
         END IF
            
         #6.檢查可能造成扣帳錯誤的資料, 如有符合就產生單據,參考原單:160804-00060#1---(S)            
         #6.1.商品編號為空白(ProgressBar=2)
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_str,cl_getmsg('art-00803',g_lang)   #正在檢查商品是否為空
            CALL cl_progress_no_window_ing(l_msg) 
            LET l_process_cnt = l_process_cnt + 1
         END IF   
         
         LET l_code = 'art-00799'
         LET l_rtjbdocno = ''
         LET l_rtjbseq   = ''
         FOREACH adep220_sour_chk_cur1 USING l_date,l_ooef001 
                                        INTO l_rtjbdocno,l_rtjbseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur1"
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_ooef001
               LET g_errparam.coll_vals[2] = l_date
               CALL cl_err()                
               
               LET l_err_cnt = l_err_cnt + 1
               LET g_exitstus = FALSE
            END IF 
            
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_code
            LET g_errparam.replace[1] = l_rtjbdocno
            LET g_errparam.replace[2] = l_rtjbseq
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()  
            LET l_err_cnt = l_err_cnt + 1
                  
            LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code
            CALL cl_log_write(l_log)                                                                    
            DISPLAY l_log 
         
            LET l_rtjbdocno = ''
            LET l_rtjbseq = ''
         END FOREACH
         
         #6.2.商品不存在門店清單(ProgressBar=3)
         IF g_bgjob <> "Y" THEN
           LET l_msg = l_str,cl_getmsg('art-00804',g_lang)   #正在檢查商品是否存在門店清單
           CALL cl_progress_no_window_ing(l_msg)
           LET l_process_cnt = l_process_cnt + 1
         END IF
         
         LET l_rtjbdocno = ''
         LET l_rtjbseq   = ''
         LET l_rtjbsite  = ''
         LET l_rtjb004   = ''
         LET l_code      = 'art-00800'
         FOREACH adep220_sour_chk_cur2 USING l_date,l_ooef001 
                                        INTO l_rtjbdocno,l_rtjbseq,l_rtjbsite,l_rtjb004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur2"
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_ooef001
               LET g_errparam.coll_vals[2] = l_date
               CALL cl_err()   
               
               LET l_err_cnt = l_err_cnt + 1
               LET g_exitstus = FALSE
            END IF 
         
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_code
            LET g_errparam.replace[1] = l_rtjbdocno
            LET g_errparam.replace[2] = l_rtjbseq
            LET g_errparam.replace[3] = l_rtjbsite
            LET g_errparam.replace[4] = l_rtjb004
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()  
            LET l_err_cnt = l_err_cnt + 1
         
            LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Site: ",l_rtjbsite," Production: ",l_rtjb004
            CALL cl_log_write(l_log)                                                                    
            DISPLAY l_log
            
            LET l_rtjbdocno = ''
            LET l_rtjbseq = ''      
            LET l_rtjbsite = ''
            LET l_rtjb004 = ''      
         END FOREACH
         
         #6.3.商品單位轉換率問題(ProgressBar=4)
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_str,cl_getmsg('art-00805',g_lang)   #正在檢查銷售單位與庫存單位轉換率設定
            CALL cl_progress_no_window_ing(l_msg)
            LET l_process_cnt = l_process_cnt + 1
         END IF
         
         LET l_rtjbdocno = ''
         LET l_rtjbseq = ''
         LET l_rtjb004 = ''
         LET l_rtjb013 = ''
         LET l_rtjb015 = ''
         LET l_code = 'art-00813'
         FOREACH adep220_sour_chk_cur3 USING l_date,l_ooef001 
                                        INTO l_rtjbdocno,l_rtjbseq,l_rtjb004,l_rtjb013,l_rtjb015
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur3"
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_ooef001
               LET g_errparam.coll_vals[2] = l_date
               CALL cl_err()   
               
               LET l_err_cnt = l_err_cnt + 1
               LET g_exitstus = FALSE
            END IF 
         
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_code
            LET g_errparam.replace[1] = l_rtjbdocno
            LET g_errparam.replace[2] = l_rtjbseq
            LET g_errparam.replace[3] = l_rtjb004
            LET g_errparam.replace[4] = l_rtjb013
            LET g_errparam.replace[5] = l_rtjb015
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()  
            LET l_err_cnt = l_err_cnt + 1
         
            LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Production: ",l_rtjb004," SaleUnit: ",l_rtjb013," InvUnit:",l_rtjb015
            CALL cl_log_write(l_log)                                                                    
            DISPLAY l_log   
            
            LET l_rtjbdocno = ''
            LET l_rtjbseq = ''      
            LET l_rtjb004 = ''
            LET l_rtjb013 = ''
            LET l_rtjb015 = ''
            LET l_log = ""      
         END FOREACH   
         
         #6.4.庫區不存在(ProgressBar=5)
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_str,cl_getmsg('art-00806',g_lang)   #正在檢查庫位是否存在
            CALL cl_progress_no_window_ing(l_msg)
            LET l_process_cnt = l_process_cnt + 1
         END IF
         
         LET l_rtjbdocno = ''
         LET l_rtjbseq = ''
         LET l_rtjbsite = ''
         LET l_rtjb025 = ''
         LET l_code = 'art-00801'
         FOREACH adep220_sour_chk_cur4 USING l_date,l_ooef001 
                                        INTO l_rtjbdocno,l_rtjbseq,l_rtjbsite,l_rtjb025
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:adep220_sour_chk_cur4"
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_ooef001
               LET g_errparam.coll_vals[2] = l_date
               CALL cl_err()   
               
               LET l_err_cnt = l_err_cnt + 1
               LET g_exitstus = FALSE
            END IF 
         
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_code
            LET g_errparam.replace[1] = l_rtjbdocno
            LET g_errparam.replace[2] = l_rtjbseq
            LET g_errparam.replace[3] = l_rtjbsite
            LET g_errparam.replace[4] = l_rtjb025
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()  
            LET l_err_cnt = l_err_cnt + 1
         
            LET l_log = "-ErrorCode(Doc.",l_rtjbdocno,"#",l_rtjbseq,") : ",l_code," Site: ",l_rtjbsite," Subinv: ",l_rtjb025
            CALL cl_log_write(l_log)                                                                    
            DISPLAY l_log
            
            LET l_rtjbdocno = ''
            LET l_rtjbseq = ''      
            LET l_rtjbsite = ''
            LET l_rtjb025 = ''     
         END FOREACH    
         
         #檢查結果(ProgressBar=6)
         IF l_err_cnt > 0 THEN   
            IF g_bgjob <> "Y" THEN
               LET l_msg = l_str,cl_getmsg('ade-00181',g_lang)   #資料檢查有異常，不進行門店庫存結算！
               CALL cl_progress_no_window_ing(l_msg)
               LET l_process_cnt = l_process_cnt + 1
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ade-00181'
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_ooef001
               LET g_errparam.coll_vals[2] = l_date
               CALL cl_err() 
            END IF 
            
            LET l_continue = FALSE
            CONTINUE FOR
         ELSE
            IF g_bgjob <> "Y" THEN
               LET l_msg = l_str,cl_getmsg('art-00808',g_lang)   #資料檢查完畢
               CALL cl_progress_no_window_ing(l_msg)
               LET l_process_cnt = l_process_cnt + 1
            END IF   
         END IF
         #檢查可能造成扣帳錯誤的資料, 如有符合就產生單據,參考原單:160804-00060#1---(E)
         
         #7.將銷售資料寫入暫存檔(ProgressBar=7)
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_str,cl_getmsg('ade-00114',g_lang)   #批次資料準備
            CALL cl_progress_no_window_ing(l_msg)
            LET l_process_cnt = l_process_cnt + 1
         END IF   
         
         DELETE FROM adep220_tmp         
         
         EXECUTE adep220_p1 USING l_date,l_ooef001
         IF SQLCA.SQLcode THEN
            #LOG紀錄,參考原單:151027-00016#5
            LET l_log = "-Error#01 : Insert adep220_tmp fail, SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160111-00006#2 160111 By pomelo add#01
            CALL cl_log_write(l_log)                                                                    
            DISPLAY l_log
         
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins temp"
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_ooef001
            LET g_errparam.coll_vals[2] = l_date
            CALL cl_err()   
            
            LET g_exitstus = FALSE
         END IF         
            
         #8.將庫存日結資料寫入正式的銷售單據(ProgressBar=8)
         IF g_bgjob <> "Y" THEN
            LET l_msg = l_str,cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            LET l_process_cnt = l_process_cnt + 1            
         END IF   
         #8.1.扣帳日期處理,參考原單:150804-00018#1
         LET l_date_tmp = YEAR(l_date) USING "<<<<","-",MONTH(l_date) USING "&#","-",DAY(l_date) USING "<<<<" ," 23:59:59"
         LET g_rtia006 = l_date_tmp  
         
         #8.2.寫入正式的銷售單據並確認、扣帳
         DELETE FROM adep220_tmp1
         IF NOT adep220_ins_table() THEN            
            IF l_date < lc_param.rtjadocdt_end THEN
               LET l_continue = FALSE   #ProgressBar計量處理判斷
            END IF
         END IF 
      END FOR
            
      IF NOT g_exitstus THEN
         EXIT FOREACH
      ELSE
         IF g_bgjob <> "Y" THEN
            LET l_process_cnt = (l_dat_cnt * 8) - l_process_cnt
            IF l_process_cnt > 0 THEN
               FOR l_j = 1 TO l_process_cnt STEP 1 
                  CALL cl_progress_counter_increase()
               END FOR
            END IF
         END IF
      END IF 
     
      LET l_ooef001   = ''
      LET l_date      = ''
      LET l_checkpos  = ''
      LET g_site      = l_site_t
   END FOREACH
   
   LET g_site = l_site_t    #還原g_site
   
   IF g_bgjob <> "Y" THEN
      LET l_msg = cl_getmsg('std-00012',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
   END IF
   
   CALL cl_err_collect_show()
   
   #LOG紀錄,參考原單:151027-00016#5
   LET l_log = "-Foreach: adep220_sel_ooef_cur, End: ",cl_get_timestamp()
   CALL cl_log_write(l_log)                                                                    
   DISPLAY l_log
   #161216-00004#2 161226 by lori add---(E)
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
   CALL adep220_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep220.get_buffer" >}
PRIVATE FUNCTION adep220_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.rtjadocdt = p_dialog.getFieldBuffer('rtjadocdt')
   LET g_master.rtjadocdt_end = p_dialog.getFieldBuffer('rtjadocdt_end')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep220.msgcentre_notify" >}
PRIVATE FUNCTION adep220_msgcentre_notify()
 
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
 
{<section id="adep220.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL adep220_create_temp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 
# Modify.........: 
################################################################################
PRIVATE FUNCTION adep220_create_temp()
   #組織資訊
   #150525 s983961 mark---s   
   #   DROP TABLE adep220_ooed004_tmp    
   #
   #   CREATE TEMP TABLE adep220_ooed004_tmp
   #   (
   #      ooed004   VARCHAR(10)
   #   )
   #   CREATE INDEX adep220_ooed004_tmp_01 on adep220_ooed004_tmp(ooed004)
   #150525 s983961 mark---e
   
   #暫存檔
   DROP TABLE adep220_tmp
   
   #單頭  #150616-00044#1 15/06/17 s983961---add(rtjb032)   #150623-00021#1 15/06/24 s983961--add(rtjb010/rtjb022/rtjb008/rtjb020) 
   #151029-00011#4 Add By Ken 151102 加(rtjb028)
   CREATE TEMP TABLE adep220_tmp (  
      rtjbent     SMALLINT,
      rtjbsite    VARCHAR(10),
      rtjbunit    VARCHAR(10),
      rtjborga    VARCHAR(10),
      rtjadocdt   DATE,
      rtjb004     VARCHAR(40),
      rtjb005     VARCHAR(256),
      rtjb012     DECIMAL(20,6),
      rtjb013     VARCHAR(10),
      rtjb014     DECIMAL(20,6),
      rtjb015     VARCHAR(10),
      rtjb017     DECIMAL(20,6),
      rtjb018     VARCHAR(10),
      rtjb021     DECIMAL(20,6),
      rtjb025     VARCHAR(10),
      rtjb026     VARCHAR(10),
      rtjb027     VARCHAR(30),
      rtjb032     VARCHAR(30),
      rtjb010     DECIMAL(20,6),
      rtjb022     DECIMAL(20,6),
      rtjb008     DECIMAL(20,6),
      rtjb020     DECIMAL(20,6),
      rtjb028     VARCHAR(20)
   );
   
   DROP TABLE adep220_tmp1
   CREATE TEMP TABLE adep220_tmp1 (  
      rtiadocno   VARCHAR(20)
   );
END FUNCTION
################################################################################
# Descriptions...: 新增暫存表資料
# Memo...........:
# Usage..........: CALL adep220_ins_table()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   處理結果:TRUE成功,FALSE失敗
# Date & Author..: 
# Modify.........: 2016/12/26 by lori    1.新增回傳值:r_success
#                                        2.錯誤訊息對應adep220_process()匯總訊息增加顯示門店/日期
#                                        3.取消ProgressBar處理,統一由adep220_process()處理
#                                        4.取消匯總訊息,統一由adep220_process()宣告初始化與顯示
################################################################################
PRIVATE FUNCTION adep220_ins_table()
   DEFINE r_success     LIKE type_t.num5    #161216-00004#2 161226 by lori add
   DEFINE l_rtjb_d      RECORD
      rtjbent    LIKE rtjb_t.rtjbent,
      rtjbsite   LIKE rtjb_t.rtjbsite,
      rtjbunit   LIKE rtjb_t.rtjbunit,
      rtjborga   LIKE rtjb_t.rtjborga,
      rtjadocdt  LIKE rtja_t.rtjadocdt,
      rtjb004    LIKE rtjb_t.rtjb004,
      rtjb005    LIKE rtjb_t.rtjb005,
      rtjb012    LIKE rtjb_t.rtjb012,
      rtjb013    LIKE rtjb_t.rtjb013,
      rtjb014    LIKE rtjb_t.rtjb014,
      rtjb015    LIKE rtjb_t.rtjb015,
      rtjb017    LIKE rtjb_t.rtjb017,
      rtjb018    LIKE rtjb_t.rtjb018,
      rtjb021    LIKE rtjb_t.rtjb021,
      rtjb025    LIKE rtjb_t.rtjb025,
      rtjb026    LIKE rtjb_t.rtjb026,
      rtjb027    LIKE rtjb_t.rtjb027,
      rtjb032    LIKE rtjb_t.rtjb032,       #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補
      rtjb010    LIKE rtjb_t.rtjb010,       #150623-00021#1 15/06/24 s983961--add(s) 
      rtjb022    LIKE rtjb_t.rtjb022,        
      rtjb008    LIKE rtjb_t.rtjb008,        
      rtjb020    LIKE rtjb_t.rtjb020,       #150623-00021#1 15/06/24 s983961--add(e)       
      rtjb028    LIKE rtjb_t.rtjb028        #151029-00011#4 Add By Ken 151102(專櫃編號)
      END RECORD                               
   DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt  
   DEFINE l_rtjbsite    LIKE rtjb_t.rtjbsite   
   DEFINE l_success     LIKE type_t.num5       
   DEFINE l_doctype     LIKE rtai_t.rtai004    
   DEFINE l_rtibdocno   LIKE rtib_t.rtibdocno  
   DEFINE l_rtia002     LIKE rtia_t.rtia002    
   DEFINE l_seq         LIKE rtib_t.rtibseq    
   DEFINE l_rtib016     LIKE rtib_t.rtib016    
   DEFINE l_rtib019     LIKE rtib_t.rtib019    
   DEFINE l_rtia035     LIKE rtia_t.rtia035
   
   #151015-00010#1 Add By Ken 151015(S)
   DEFINE l_pmab083     LIKE pmab_t.pmab083   #慣用交易幣別
   DEFINE l_pmab087     LIKE pmab_t.pmab087   #慣用交易條件
   #151015-00010#1 Add By Ken 151015(E)
   
   #150623-00021#1 15/06/24 s983961--add(s)    
   DEFINE l_rtjb004     LIKE rtia_t.rtia004    
   DEFINE l_ooef001     LIKE ooef_t.ooef001    
   DEFINE l_ermsg       STRING                
   DEFINE l_ermsg2      STRING                
   #150623-00021#1 15/06/24 s983961--add(e)
   
   DEFINE l_rtib035     LIKE rtib_t.rtib035      #150804-00018#3 Add By Ken 150814  1:銷售 2:銷退
   DEFINE l_log         STRING                   #150826 Add By Ken
   DEFINE l_err_seq     LIKE type_t.num5         #150515-00023#6 150903 by lori add
   DEFINE l_where       STRING                   #160129-00014#2 160223 By pomelo add
   DEFINE l_loop        LIKE type_t.num5         #160225-00040#4 Add By Ken 160401
   DEFINE l_msg         STRING                   #160225-00040#4 Add By Ken 160401    
   
   #add by geza 20161026 #161026-00058#1(S) 
   DEFINE l_rtia025     LIKE rtia_t.rtia025
   DEFINE l_rtia026     LIKE rtia_t.rtia026
   DEFINE l_rtia027     LIKE rtia_t.rtia027
   DEFINE l_rtia028     LIKE rtia_t.rtia028
   DEFINE l_rtia029     LIKE rtia_t.rtia029
   DEFINE l_rtia030     LIKE rtia_t.rtia030
   DEFINE l_ooef015     LIKE ooef_t.ooef015
   DEFINE l_ooef016     LIKE ooef_t.ooef016
   DEFINE l_ooam005     LIKE ooam_t.ooam005
   DEFINE l_gzsz008     LIKE gzsz_t.gzsz008
   DEFINE l_rtib006     LIKE rtib_t.rtib006
   DEFINE l_rtib021     LIKE rtib_t.rtib021
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_xrcd103     LIKE xrcd_t.xrcd103
   DEFINE l_xrcd104     LIKE xrcd_t.xrcd104
   DEFINE l_xrcd105     LIKE xrcd_t.xrcd105
   DEFINE l_xrcd113     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115     LIKE xrcd_t.xrcd115
   DEFINE l_imaa005     LIKE imaa_t.imaa005
   DEFINE l_xrcd123     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd124     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd125     LIKE xrcd_t.xrcd115
   DEFINE l_xrcd133     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd134     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd135     LIKE xrcd_t.xrcd115
   #add by geza 20161026 #161026-00058#1(E)
   DEFINE l_rtia067     LIKE rtia_t.rtia067   #170106-00034#1 by sakura add

   LET r_success = TRUE                                          #161216-00004#2 161226 by lori add
   
   LET l_log = "Start adep220_ins_table...",cl_get_timestamp()   #150515-00023#6 150903 by lori add
   CALL cl_log_write(l_log)                                      #150515-00023#6 150903 by lori add
   DISPLAY l_log                                                 #151027-00016#5 151130 by lori add 

   #160118-00008#4 1612/23 by lori add---(S)
   IF NOT s_inventory_batch_create_temp() THEN
      LET l_log = "Error:s_inv_batch Create Temp Table Fail"
      CALL cl_log_write(l_log)    
      DISPLAY l_log
      RETURN
   END IF
   #160118-00008#4 161223 by lori add---(E)
   
   CALL s_transaction_begin()   
  #CALL cl_showmsg_init()        #150515-00023#6 150903 by lori mark
  #CALL cl_err_collect_init()    #150515-00023#6 150903 by lori add    #161216-00004#2 161226 by lori mark
                                 
   LET l_rtjbsite = NULL         
   LET l_rtjadocdt = NULL        
   LET l_err_seq = 0             #150515-00023#6 150903 by lori add

   #151027-00016#5 151130 by lori add---(S)
   LET l_log = "-Foreach: adep220_cl2 , Start: ",cl_get_timestamp()  
   CALL cl_log_write(l_log)                                                                        
   DISPLAY l_log
   #151027-00016#5 151130 by lori add---(E)
   
   #160225-00040#4 Add By Ken 160401(S)   產生資料
   #LET l_msg = cl_getmsg('ast-00330',g_lang)   #161216-00004#2 1226 by lori mark
   #CALL cl_progress_no_window_ing(l_msg)       #161216-00004#2 1226 by lori mark
   #160225-00040#4 Add By Ken 160401(E)      
   
   #FOREACH adep220_cl2 INTO l_rtjb_d.*  #161104-00002#3 Mark by Ken 161104
   #161104-00002#3 Add By Ken 161104(S)
   FOREACH adep220_cl2 INTO l_rtjb_d.rtjbent  ,l_rtjb_d.rtjbsite  ,l_rtjb_d.rtjbunit  ,l_rtjb_d.rtjborga  ,l_rtjb_d.rtjadocdt ,
                            l_rtjb_d.rtjb004  ,l_rtjb_d.rtjb005   ,l_rtjb_d.rtjb012   ,l_rtjb_d.rtjb013   ,l_rtjb_d.rtjb014   ,
                            l_rtjb_d.rtjb015  ,l_rtjb_d.rtjb017   ,l_rtjb_d.rtjb018   ,l_rtjb_d.rtjb021   ,l_rtjb_d.rtjb025   ,
                            l_rtjb_d.rtjb026  ,l_rtjb_d.rtjb027   ,l_rtjb_d.rtjb032   ,l_rtjb_d.rtjb010   ,l_rtjb_d.rtjb022   ,
                            l_rtjb_d.rtjb008  ,l_rtjb_d.rtjb020   ,l_rtjb_d.rtjb028   
   #161104-00002#3 Add By Ken 161104(E)
      #151027-00016#5 151130 by lori mark---(S)
      #LET l_log = "-Foreach.site(",l_rtjb_d.rtjbsite,"), date(",l_rtjb_d.rtjadocdt,") "   #150515-00023#6 150903 by lori add
      #CALL cl_log_write(l_log)                                                            #150515-00023#6 150903 by lori add
      #151027-00016#5 151130 by lori mark---(E)
      
      #單頭
      IF (cl_null(l_rtjbsite) AND cl_null(l_rtjadocdt))
         OR l_rtjbsite <> l_rtjb_d.rtjbsite
         OR l_rtjadocdt <> l_rtjb_d.rtjadocdt THEN
         
         #預設單據的單別
         LET l_success = ''
         LET l_doctype = ''
         CALL s_arti200_get_def_doc_type(l_rtjb_d.rtjbsite,"artt610",'2') 
            RETURNING l_success,l_doctype
         IF NOT l_success THEN
            #寫入Log檔_(s)
            #150515-00023#6 150903 by lori add and mod---(S)
            LET l_err_seq = l_err_seq + 1                                                           
            LET l_log = "--Error#02(",l_err_seq,"): Call s_arti200_get_def_doc_type fail! Parameters :Site(",l_rtjb_d.rtjbsite,") ,Prog(artt610),(2) " #160111-00006#2 160111 By pomelo add#02
            #150515-00023#6 150903 by lori add and mod---(E)
            CALL cl_log_write(l_log)
            DISPLAY l_log                   #151027-00016#5 151130 by lori add
            #寫入Log檔_(e)  
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')   
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
         END IF
         
         LET l_rtibdocno = l_doctype
         IF NOT s_aooi200_chk_slip(l_rtjb_d.rtjbsite,'',l_rtibdocno,"artt610") THEN
            #寫入Log檔_(s)
            #150515-00023#6 150903 by lori add and mod---(S)
            LET l_err_seq = l_err_seq + 1                                                                          
            LET l_log = "--Error#03(",l_err_seq,"): Call s_aooi200_chk_slip fail! Parameters: rtjbsite(",l_rtjb_d.rtjbsite,"), slip tpye(",l_rtibdocno,"), prog(artt610) " #160111-00006#2 160111 By pomelo add#03
            #150515-00023#6 150903 by lori add and mod---(E)                        
            CALL cl_log_write(l_log)
            DISPLAY l_log    #151027-00016#5 151130 by lori add
            #寫入Log檔_(e)          
            
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add 
            CALL s_transaction_end('N','0')        
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
         END IF
         
         #單號
         CALL s_aooi200_gen_docno(l_rtjb_d.rtjbsite,l_rtibdocno,l_rtjb_d.rtjadocdt,"artt610") 
            RETURNING l_success,l_rtibdocno
         IF NOT l_success THEN
            #寫入Log檔_(s)
            #150515-00023#6 150903 by lori add and mod---(S)
            LET l_err_seq = l_err_seq + 1                                                             
            LET l_log = "--Error#04(",l_err_seq,"): Call s_aooi200_gen_docn fail! Parameters: rtjbsite(",l_rtjb_d.rtjbsite,"), slip tpye(",l_rtibdocno,"), " , #160111-00006#2 160111 By pomelo add#04
                        "date(",l_rtjb_d.rtjadocdt,"), prog(artt610)" 
            #150515-00023#6 150903 by lori add and mod---(E)
            CALL cl_log_write(l_log)
            DISPLAY l_log                   #151027-00016#5 151130 by lori add
            #寫入Log檔_(e) 
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')             
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
            
         #151027-00016#5 151130 by lori mark---(S)
         ##150515-00023#6 150903 by lori add--(S)
         #ELSE
         #   LET l_log = "--Get slip numbrt: ",l_rtibdocno 
         #   CALL cl_log_write(l_log) 
         #   DISPLAY l_log    #151027-00016#5 151130 by lori add             
         ##150515-00023#6 150903 by lori add--(E)
         #151027-00016#5 151130 by lori mark---(E)         
         END IF
         
         #散客編號
         LET l_rtia002 = ''
         SELECT ooef108 INTO l_rtia002
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_rtjb_d.rtjbsite
         IF cl_null(l_rtia002) THEN
            ##150515-00023#6 150903 by lori mark and add---(S)
            #寫入Log檔_(s)
            LET l_err_seq = l_err_seq + 1 
            LET l_log = "--Error#05(",l_err_seq,"): Getting customer(ooef108) by ooef001(",l_rtjb_d.rtjbsite,") is fail! "   #151027-00016#5 151130 by lori mod #160111-00006#2 160111 By pomelo add#05
            CALL cl_log_write(l_log)
            DISPLAY l_log    #151027-00016#5 151130 by lori add
            #寫入Log檔_(e)
            
            #CALL cl_errmsg(l_rtjb_d.rtjbsite,'','','ade-00058',1)    
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "ade-00058"   
            LET g_errparam.extend = l_rtjb_d.rtjbsite 
            LET g_errparam.popup = TRUE 
            LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
            LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            CALL cl_err()
            ##150515-00023#6 150903 by lori mark and add---(E)
            CONTINUE FOREACH            
            
         #151027-00016#5 151130 by lori mark---(S)
         ##150515-00023#6 150903 by lori add--(S)
         #ELSE
         #   LET l_log = "--Getting customer(",l_rtia002,") for site(",l_rtjb_d.rtjbsite,")" 
         #   CALL cl_log_write(l_log)        
         #   DISPLAY l_log    #151027-00016#5 151130 by lori add            
         ##150515-00023#6 150903 by lori add--(E) 
         #151027-00016#5 151130 by lori mark---(E)
         END IF   
         
         #mark by geza 20161026 161026-00058#1 (S)
         #151015-00010#1 Add By Ken 151015(S) 補上客戶慣用幣別及交易條件
         #LET l_pmab083 = ''
         #LET l_pmab087 = ''
         #SELECT pmab083,pmab087 INTO l_pmab083,l_pmab087
         #  FROM pmab_t
         # WHERE pmabent = g_enterprise
         #   AND pmabsite = l_rtjb_d.rtjbsite
         #   AND pmab001 = l_rtia002
         #151015-00010#1 Add By Ken 151015(E)
         #mark by geza 20161026 161026-00058#1 (E)
         
         #add by geza 20161026 161026-00058#1 (S)
         LET l_rtia025 = ''
         SELECT pmad002 INTO l_rtia025
           FROM pmad_t
          WHERE pmadent = g_enterprise
            AND pmad001 = l_rtia002
            AND pmad004 = 'Y'
            AND pmadstus = 'Y'
            AND pmad003 = '2'
         #抓取客户惯用币别
         LET l_rtia026 = ''
         SELECT pmab083 INTO l_rtia026
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = 'ALL'                   
            AND pmab001 = l_rtia002
         IF NOT cl_null(l_rtia026) THEN
            #取匯率參照表號、主幣別
            SELECT ooef015,ooef016 INTO l_ooef015,l_ooef016 FROM ooef_t  
             WHERE ooefent = g_enterprise AND ooef001 = l_rtjb_d.rtjbsite
         
            #取交易貨幣批量
            SELECT ooam005 INTO l_ooam005 FROM ooam_t
             WHERE ooament = g_enterprise AND ooam001 = l_ooef015
               AND ooam003 = l_rtia026 AND ooam004 = l_rtjb_d.rtjadocdt
         
            #取匯率類型   
            CALL cl_get_para(g_enterprise,l_rtjb_d.rtjbsite,'S-BAS-0010') RETURNING l_gzsz008
            CALL s_aooi160_get_exrate('1',l_rtjb_d.rtjbsite,l_rtjb_d.rtjadocdt,l_rtia026,l_ooef016,l_ooam005,l_gzsz008)
               RETURNING l_rtia027
         END IF 
         #抓取客户惯用税别
         SELECT pmab084 INTO l_rtia028
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = 'ALL'                 
            AND pmab001 = l_rtia002
         IF NOT cl_null(l_rtia028) THEN 
            SELECT DISTINCT oodb005,oodb006
              INTO l_rtia030,l_rtia029
              FROM ooef_t,oodb_t 
             WHERE oodbent = g_enterprise
               AND ooef019 = oodb001
               AND ooefent = oodbent
               AND oodb002 = l_rtia028
               AND ooef001 = l_rtjb_d.rtjbsite
               AND oodbstus = 'Y'
         END IF 
         #add by geza 20161026 161026-00058#1 (E)
         
         LET l_rtia035 = cl_get_time()
         LET l_rtia067 = l_rtibdocno   #170106-00034#1 by sakura add
         INSERT INTO rtia_t(rtiaent,  rtiasite,  rtiadocno, rtiadocdt, rtiastus,
                            rtiaunit, rtia000,   rtia002,   rtia032,   rtia034,
                            rtia035,  rtiaownid, rtiaowndp, rtiacrtid, rtiacrtdp,
                            rtiacrtdt,rtia017,   rtia006,                           #150603 s983961 add---rtia017 #150804-00018#1 Add By Ken 加rtia006
                            #rtia026,  rtia025)   #151015-00010#1 Add By Ken 151015 補上客戶慣用幣別及交易條件 #mark by geza 20161026 #161026-00058#1
                            rtia025,  rtia026 ,  rtia027    ,rtia028,  rtia029 ,rtia030,rtia067 )  #add by geza 20161026 #161026-00058#1   #170106-00034#1 by sakura add rtia067
              VALUES (l_rtjb_d.rtjbent,  l_rtjb_d.rtjbsite , l_rtibdocno, l_rtjb_d.rtjadocdt, 'N',
                      l_rtjb_d.rtjbunit, 'artt610',          l_rtia002,   '4',                g_today,
                      l_rtia035,         g_user,             g_dept,      g_user,             g_dept,
                      g_datetime,        '1',                g_rtia006,             #150603 s983961 add---rtia017 '1' #150804-00018#1 Add By Ken 加rtia006
                      #l_pmab083,         l_pmab087)  #151015-00010#1 Add By Ken 151015 補上客戶慣用幣別及交易條件 #mark by geza 20161026 #161026-00058#1
                      l_rtia025,  l_rtia026 ,  l_rtia027    , l_rtia028,  l_rtia029 , l_rtia030 , l_rtia067 )  #add by geza 20161026 #161026-00058#   #170106-00034#1 by sakura add l_rtia067
         IF SQLCA.SQLcode THEN
            #寫入Log檔_(s)
            #150515-00023#6 150903 by lori add and mod---(S)
            LET l_err_seq = l_err_seq + 1                                       
            LET l_log = "--Error#06(",l_err_seq,"): Insert rtia_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160111-00006#2 160111 By pomelo add#06
            CALL cl_log_write(l_log)
            DISPLAY l_log    #151027-00016#5 151130 by lori add
            
            LET l_log = "---Data: rtjbsite(",l_rtjb_d.rtjbsite,"), rtibdocno(",l_rtibdocno,"),rtjadocdt(",l_rtjb_d.rtjadocdt,") "   
            #150515-00023#6 150903 by lori add and mod---(E)
            CALL cl_log_write(l_log) 
            DISPLAY l_log    #151027-00016#5 151130 by lori add
            #寫入Log檔_(e)        
            
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Insert rtia_t Error!"
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
            LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            CALL cl_err()            
            
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')              
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
            
         #151027-00016#5 151130 by lori mark---(S)   
         ##150515-00023#6 150903 by lori add---(S)            
         #ELSE
         #   LET l_log = "--Insert rtia_t success, rtibdocno(",l_rtibdocno,"): ",cl_get_timestamp()    
         #   CALL cl_log_write(l_log)            
         ##150515-00023#6 150903 by lori add---(E) 
         #151027-00016#5 151130 by lori mark---(E)           
         END IF
         
         INSERT INTO adep220_tmp1(rtiadocno) VALUES (l_rtibdocno)
         IF SQLCA.SQLcode THEN
            #寫入Log檔_(s)
            #150515-00023#6 150903 by lori add and mod---(S)
            LET l_err_seq = l_err_seq + 1                                      
            LET l_log = "--Error#07(",l_err_seq,"): Insert adep220_tmp1 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160111-00006#2 160111 By pomelo add#07
            CALL cl_log_write(l_log)                                      
            DISPLAY l_log    #151027-00016#5 151130 by lori add
            
            LET l_log = "---Insert data: rtibdocno(",l_rtibdocno,") "             
            #150515-00023#6 150903 by lori add and mod---(E)
            CALL cl_log_write(l_log)    
            DISPLAY l_log    #151027-00016#5 151130 by lori add            
            #寫入Log檔_(e)   
            
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Insert adep220_tmp1 Error!"
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
            LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            CALL cl_err()            
            
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')            
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)     
         END IF
         
         LET l_rtjbsite = l_rtjb_d.rtjbsite
         LET l_rtjadocdt = l_rtjb_d.rtjadocdt
         LET l_seq = 1
      END IF
      
      #單身
      #單位換算
      LET l_success = NULL
      LET l_rtib016 = NULL
      LET l_rtib019 = NULL
      CALL s_aimi190_get_convert(l_rtjb_d.rtjb004,l_rtjb_d.rtjb013,l_rtjb_d.rtjb015) RETURNING l_success,l_rtib016
      CALL s_aimi190_get_convert(l_rtjb_d.rtjb004,l_rtjb_d.rtjb013,l_rtjb_d.rtjb018) RETURNING l_success,l_rtib019
      
      #150525  s983961 add---s  
      #先抓門店清單上的庫位(rtdx044), 抓不到或沒有值時，進一步抓大店出貨庫位ooef124
      
      SELECT rtdx044,rtdx001 
        INTO l_rtjb_d.rtjb025,l_rtjb004
        FROM rtdx_t
       WHERE rtdxent  = l_rtjb_d.rtjbent 
         AND rtdxsite = l_rtjb_d.rtjbsite 
         AND rtdx001  = l_rtjb_d.rtjb004  
      
      IF cl_null(l_rtjb_d.rtjb025) THEN    
         SELECT ooef124,ooef001 
           INTO l_rtjb_d.rtjb025,l_ooef001
           FROM ooef_t
          WHERE ooefent = l_rtjb_d.rtjbent
            AND ooef001 = l_rtjb_d.rtjbsite
      
      #151027-00016#5 151130 by lori mark---(S)
      ##150515-00023#6 150903 by lori add---(S)
      #ELSE
      #   LET l_log = "--Getting subinventory(rtdx044): ",l_rtjb_d.rtjb025
      #   CALL cl_log_write(l_log) 
      #   DISPLAY l_log    #151027-00016#5 151130 by lori add         
      ##150515-00023#6 150903 by lori add---(E)
      #151027-00016#5 151130 by lori mark---(E)
      END IF
      
      #150623-00021#1 15/06/24 s983961--add(s)  錯誤訊息 如果取不到就擋住   
      IF cl_null(l_rtjb_d.rtjb025) THEN
         #寫入Log檔_(s)
         #150515-00023#6 150903 by lori add and mod---(S)
         LET l_err_seq = l_err_seq + 1   
         LET l_log = "--Error#08(",l_err_seq,"): Subinventory(rtdx044/ooef124) is NULL! ", #160111-00006#2 160111 By pomelo add#08
                     "Souece data: rtjbsite(",l_rtjb_d.rtjbsite,"), rtjb004(",l_rtjb_d.rtjb004,") "
         #150515-00023#6 150903 by lori add and mod---(E)            
         CALL cl_log_write(l_log)
         DISPLAY l_log    #151027-00016#5 151130 by lori add  
         #寫入Log檔_(e) 
         
         LET l_ermsg = '[',l_rtjb004,']'
         LET l_ermsg2 = '[',l_ooef001,']'
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 'ade-00115' 
         LET g_errparam.popup  = TRUE 
         LET g_errparam.replace[1] = l_ermsg
         LET g_errparam.replace[2] = l_ermsg2 
         LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
         LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
         CALL cl_err()          
         
        #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
         LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
         CALL s_transaction_end('N','0')        
         #161216-00004#2 161226 by lori mod---(S)            
         #RETURN                          
         LET r_success = FALSE
         RETURN r_success                
         #161216-00004#2 161226 by lori mod---(E)
         
      #151027-00016#5 151130 by lori mark---(S)
      ##150515-00023#6 150903 by lori add---(S)
      #ELSE
      #   LET l_log = "--Get subinventory(ooef124): ",l_rtjb_d.rtjb025
      #   CALL cl_log_write(l_log)      
      #   DISPLAY l_log    #151027-00016#5 151130 by lori add  
      ##150515-00023#6 150903 by lori add---(E)
      #151027-00016#5 151130 by lori mark---(E)      
      END IF 

      IF cl_null(l_rtjb_d.rtjb026) THEN LET l_rtjb_d.rtjb026 = ' ' END IF
      IF cl_null(l_rtjb_d.rtjb027) THEN LET l_rtjb_d.rtjb027 = ' ' END IF 
      #150623-00021#1 15/06/24 s983961--add(e)     
      #150525 s983961 add---e 
      
      #150804-00018#3 Add By Ken 150814(s)
      LET l_rtib035 = ''
     #IF l_rtjb_d.rtjb012 > 0 THEN      ##150904 By pomelo mark
      IF l_rtjb_d.rtjb012 >= 0 THEN     ##150904 By pomelo add
         LET l_rtib035 = '1'   #銷售
      END IF
      IF l_rtjb_d.rtjb012 < 0 THEN
         LET l_rtib035 = '2'   #銷退  
         
         #160129-00014#2 160223 By pomelo mark(S)
         #150820-00001#1 Add By Ken 150820(s)
         LET l_success = ''
         CALL s_lot_out_get_batch_no(l_rtjb_d.rtjb004)  #傳入商品編號
            RETURNING l_success,l_rtjb_d.rtjb027        #取得批號
         #150820-00001#1 Add By Ken 150820(e)
         #160129-00014#2 160223 By pomelo mark(E)
         
         ##150904 By pomelo add(S)
         IF l_success = FALSE THEN
            #寫入Log檔_(s)
            LET l_err_seq = l_err_seq + 1
            LET l_log = "---Error#09(",l_err_seq,"): Call s_lot_out_get_batch_no fail! (",l_rtibdocno,",",l_rtjb_d.rtjb004,") " #160111-00006#2 160111 By pomelo add#09
            CALL cl_log_write(l_log)
            DISPLAY l_log    #151027-00016#5 151130 by lori add  
            #寫入Log檔_(e)

            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.EXTEND = ""
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
            LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            CALL cl_err()            
            
           #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
            LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')
            #161216-00004#2 161226 by lori mod---(S)            
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
         END IF
         ##150904 By pomelo add(E)         
      END IF
         
      #150804-00018#3 Add By Ken 150814(e)
      
      #add by geza 20161026 #161026-00058#1(S)
      SELECT oodb011 INTO l_oodb011
        FROM oodb_t,ooef_t
       WHERE oodbent = ooefent
         AND oodb001 = ooef019
         AND oodb002 = l_rtia028
         AND ooef001 = l_rtiasite   
      IF l_oodb011 = '1' THEN 
         LET l_rtib006 = l_rtia028
      ELSE
         #带出税别
         SELECT rtdx014 INTO l_rtib006
           FROM rtdx_t
          WHERE rtdxent = g_enterprise 
            AND rtdxsite = l_rtjb_d.rtjbsite
            AND rtdx001 = l_rtjb_d.rtjb004       
      END IF    
      #add by geza 20161026 #161026-00058#1(E)
      
      INSERT INTO rtib_t(rtibent, rtibsite, rtibunit, rtiborga, rtibdocno,
                         rtibseq, rtib004,  rtib005,  rtib012,  rtib013,
                         rtib014, rtib015,  rtib016,  rtib017,  rtib018,
                         rtib019, rtib021,  rtib025,  rtib026,  rtib027,
                         rtib010, rtib022,  rtib008,  rtib020,             #150623-00021#1 15/06/24 s983961--add rtib010,rtib022,rtib008,rtib020 
                         rtib035, rtib006,                                 #150804-00018#3 Add By Ken 150814 #add by geza 20161027 #161026-00058#1
                         rtib028 )                                         #151029-00011#4 Add By Ken 151102 加(rtib028)
            VALUES (l_rtjb_d.rtjbent, l_rtjb_d.rtjbsite, l_rtjb_d.rtjbunit, l_rtjb_d.rtjborga, l_rtibdocno,
                    l_seq,            l_rtjb_d.rtjb004,  l_rtjb_d.rtjb005,  l_rtjb_d.rtjb012,  l_rtjb_d.rtjb013,
                    l_rtjb_d.rtjb014, l_rtjb_d.rtjb015,  l_rtib016,         l_rtjb_d.rtjb017,  l_rtjb_d.rtjb018,
                    l_rtib019,        l_rtjb_d.rtjb021,  l_rtjb_d.rtjb025,  l_rtjb_d.rtjb026,  l_rtjb_d.rtjb027,
                    l_rtjb_d.rtjb010, l_rtjb_d.rtjb022,  l_rtjb_d.rtjb008,  l_rtjb_d.rtjb020,    #150623-00021#1 15/06/24 s983961--add 
                    l_rtib035,        l_rtib006,                                                 #150804-00018#3 Add By Ken 150814 #add by geza 20161027 #161026-00058#1
                    l_rtjb_d.rtjb028 )                                                           #151029-00011#4 Add By Ken 151102 加(rtjb028) 
      IF SQLCA.SQLcode THEN
         #寫入Log檔_(s)
         #150515-00023#6 150903 by lori add and mod---(S)
         LET l_err_seq = l_err_seq + 1                                      
         LET l_log = "--Error#10(",l_err_seq,"): Insert rtib_t fail! SQLCA.sqlerrd[2] : ",SQLCA.sqlerrd[2] #160111-00006#2 160111 By pomelo add#10
         CALL cl_log_write(l_log)  
         DISPLAY l_log    #151027-00016#5 151130 by lori add           
                                                                       
         LET l_log = "---Insert data: rtibdocno(",l_rtibdocno,"), rtjb004(",l_rtjb_d.rtjb004,") "            
         #150515-00023#6 150903 by lori add and mod---(E)         
         CALL cl_log_write(l_log)
         DISPLAY l_log    #151027-00016#5 151130 by lori add  
         #寫入Log檔_(e)    
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert rtib_t Error!"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
         LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
         CALL cl_err()
         
        #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
         LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
         CALL s_transaction_end('N','0')       
         #161216-00004#2 161226 by lori mod---(S)            
         #RETURN                          
         LET r_success = FALSE
         RETURN r_success                
         #161216-00004#2 161226 by lori mod---(E)
            
      #151027-00016#5 151130 by lori mark---(S)
      ##150515-00023#6 150903 by lori add---(S) 
      #ELSE      
      #   LET l_log = "--Insert rtib_t success, rtibdocno(",l_rtibdocno,"), rtibseq(",l_seq,"), ",
      #               "rtjb004(",l_rtjb_d.rtjb004,"): ",cl_get_timestamp()    
      #   CALL cl_log_write(l_log)                                      
      ##150515-00023#6 150903 by lori add---(E)      
      #151027-00016#5 151130 by lori mark---(E)
      END IF
      #150603 s983961---add(s) 
      
      #160129-00014#2 160223 By pomelo mark(S)
      INSERT INTO rtin_t(rtinent, rtinsite, rtindocno, rtinseq, rtinseq1,
                         rtin001, rtin002,  rtin003,   rtin004, rtin005,
                         rtin006, rtin007,  rtin008,   rtin009, rtin010)
           VALUES (l_rtjb_d.rtjbent, l_rtjb_d.rtjbsite, l_rtibdocno,      l_seq,
                   '1',              l_rtjb_d.rtjb004,  l_rtjb_d.rtjb005,    '',     #161017-00050#1 Modify By Ken 161021 加上rtjb005  #150616-00021#1 150616 s983961---add INTO rtin_t語法錯誤 補
                   '',               l_rtjb_d.rtjb025,  l_rtjb_d.rtjb026, l_rtjb_d.rtjb027,
                   l_rtjb_d.rtjb015, l_rtjb_d.rtjb014,  l_rtjb_d.rtjb032) 
      IF SQLCA.SQLcode THEN
         #寫入Log檔_(s)
         #150515-00023#6 150903 by lori add and mod---(S)
         LET l_err_seq = l_err_seq + 1                                      
         LET l_log = "--Error#11(",l_err_seq,"): Insert rtin_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160111-00006#2 160111 By pomelo add#11
         CALL cl_log_write(l_log)                                      
                                                                       
         LET l_log = "---Insert data: rtibdocno(",l_rtibdocno,"), rtjb004(",l_rtjb_d.rtjb004,") "            
         #150515-00023#6 150903 by lori add and mod---(E)           
         CALL cl_log_write(l_log)
         DISPLAY l_log    #151027-00016#5 151130 by lori add  
         #寫入Log檔_(e)          
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Insert rtin_t Error!"
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
         LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
         CALL cl_err()
        #CALL adep220_msg_show(2)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
         CALL s_transaction_end('N','0')          
         #161216-00004#2 161226 by lori mod---(S)            
         #RETURN                          
         LET r_success = FALSE
         RETURN r_success                
         #161216-00004#2 161226 by lori mod---(E)
      
      #151027-00016#5 151130 by lori add  mark---(S)
      ##150515-00023#6 150903 by lori add---(S) 
      #ELSE      
      #   LET l_log = "--Insert rtin_t success, rtibdocno(",l_rtibdocno,"), rtibseq(",l_seq,"), ",
      #               "rtjb004(",l_rtjb_d.rtjb004,"): ",cl_get_timestamp()    
      #   CALL cl_log_write(l_log)                                      
      ##150515-00023#6 150903 by lori add---(E)  
      #151027-00016#5 151130 by lori add  mark---(E)
      END IF
      #160129-00014#2 160223 By pomelo mark(E)
      #150603 s983961---add(e)             

      #add by geza 20161027  (S)
      #交易單據交易稅明細檔計算及寫入
                     #單號            項次         項次2        營運據點        應收金額
      CALL s_tax_ins(l_rtibdocno,l_seq,'0',   l_rtjb_d.rtjbsite,l_rtjb_d.rtjb021,
                     #稅別              计价數量       幣別             匯率      帳套 匯率2 匯率3
                     l_rtib006,l_rtjb_d.rtjb017,l_rtia026,l_rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
      #add by geza 20161027  (E)
      LET l_seq = l_seq + 1 
      
   END FOREACH
   #151027-00016#5 151130 by lori add---(S)
   LET l_log = "-Foreach: adep220_cl2 ,  End: ",cl_get_timestamp()  
   CALL cl_log_write(l_log)                                                                        
   DISPLAY l_log
   #151027-00016#5 151130 by lori add---(E)
   
   #160129-00014#2 160223 By pomelo add(S)
   #LET l_where = " COALESCE(rtib012,0) < 0"
   #IF NOT s_lot_no_batch('rtib_t', 'rtibent', 'rtibdocno', 'rtibseq',
   #                      '',       'rtib004', 'rtib027',   l_rtibdocno,
   #                      l_where) THEN
   #   LET l_log = "--Error#17 - s_lot_no_batch fail!"
   #   CALL cl_log_write(l_log) 
   #   DISPLAY l_log
   #   CALL s_transaction_end('N','0')
   #   RETURN 
   #END IF
   #INSERT INTO rtin_t(rtinent, rtinsite, rtindocno, rtinseq, rtinseq1,
   #                   rtin001, rtin002,  rtin003,   rtin004, rtin005,
   #                   rtin006, rtin007,  rtin008,   rtin009, rtin010)
   #SELECT rtibent, rtibsite, rtibdocno, rtibseq, 1,
   #       rtib004, '',       '',        '',      rtib025,
   #       rtib026, rtib027,  rtib015,   rtib014, rtib032
   #  FROM rtib_t
   # WHERE rtibent = g_enterprise
   #   AND rtibdocno = l_rtibdocno
   #IF SQLCA.sqlcode THEN
   #   LET l_log = "--Error#11 - Insert rtin_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
   #   CALL cl_log_write(l_log) 
   #   DISPLAY l_log
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "Insert rtin_t Error!"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CALL s_transaction_end('N','0')
   #   RETURN 
   #END IF
   #160129-00014#2 160223 By pomelo add(E)
   #庫存過帳
   #150601-00026#1 15/06/01  by s983961---mark(e)   
   # IF NOT adep220_post() THEN               
   #    CALL s_transaction_end('N','0')
   #    RETURN
   # END IF   
   #150601-00026#1 15/06/01  by s983961---mark(e) 
   #150601-00026#1 15/06/01  by s983961---add(s)
   
   #160225-00040#4 Add By Ken 160401(S)   產生資料
   #LET l_msg = cl_getmsg('ast-00330',g_lang)   #161216-00004#2 161226 by lori mark
   #CALL cl_progress_no_window_ing(l_msg)       #161216-00004#2 161226 by lori mark
   #160225-00040#4 Add By Ken 160401(E) 
   
   LET g_prog = 'artt610'       #150427-00001#9 150604 By pomelo add
   IF NOT cl_null(l_rtibdocno) THEN
      CALL s_artt600_conf_chk(l_rtibdocno,'N') RETURNING l_success,g_errno
      IF l_success THEN 
         LET l_log = "-Start with artt600 for confirmed...",cl_get_timestamp()   #150515-00023#6 150903 by lori add   
         CALL cl_log_write(l_log)                                                #150515-00023#6 150903 by lori add
         DISPLAY l_log                                                           #151027-00016#5 151130 by lori add  
         
         CALL s_artt600_conf_upd(l_rtibdocno) RETURNING l_success
         LET l_log = "-End with artt600 for confirmed...",cl_get_timestamp()     #150515-00023#6 150903 by lori add   
         CALL cl_log_write(l_log)                                                #150515-00023#6 150903 by lori add
         DISPLAY l_log                                                           #151027-00016#5 151130 by lori add 
         
         IF NOT l_success THEN
            #寫入Log檔_(s)
            LET l_log = "-Error#12:s_artt600_conf_upd,l_rtibdocno:",l_rtibdocno  #160111-00006#2 160111 By pomelo add#12
            CALL cl_log_write(l_log)
            DISPLAY l_log                    #151027-00016#5 151130 by lori add  
            #寫入Log檔_(e)   
            LET g_exitstus = FALSE           #160804-00060#1 160809 by lori add
            CALL s_transaction_end('N','0')  
            LET g_prog = 'adep220'           #150427-00001#9 150604 By pomelo add
            
            #161216-00004#2 161226 by lori mod---(S)            
            #CALL adep220_msg_show(1)        #160225-00040#4 Add By Ken 160401
            #RETURN                          
            LET r_success = FALSE
            RETURN r_success                
            #161216-00004#2 161226 by lori mod---(E)
         ELSE  
            CALL s_artt600_post_chk(l_rtibdocno,'Y') RETURNING l_success,g_errno
            IF l_success THEN      
               LET l_log = "-Start with artt600 for posted...",cl_get_timestamp()    #150515-00023#6 150903 by lori add   
               CALL cl_log_write(l_log)                                              #150515-00023#6 150903 by lori add  
               DISPLAY l_log                                                         #151027-00016#5 151130 by lori add
               
               CALL s_artt600_post_upd(l_rtibdocno) RETURNING l_success
               
               LET l_log = "-End with artt600 for posted...",cl_get_timestamp()      #150515-00023#6 150903 by lori add   
               CALL cl_log_write(l_log)                                              #150515-00023#6 150903 by lori add                
               DISPLAY l_log                                                         #151027-00016#5 151130 by lori add
               
               IF NOT l_success THEN
                  #寫入Log檔_(s)
                  LET l_log = "-Error#13:s_artt600_post_upd,l_rtibdocno:",l_rtibdocno #160111-00006#2 160111 By pomelo add#13
                  CALL cl_log_write(l_log)
                  DISPLAY l_log                    #151027-00016#5 151130 by lori add
                  #寫入Log檔_(e) 
                  LET g_exitstus = FALSE           #160804-00060#1 160809 by lori add
                  CALL s_transaction_end('N','0')
                  LET g_prog = 'adep220'           #150427-00001#9 150604 By pomelo add
                  
                  #161216-00004#2 161226 by lori mod---(S)            
                  #CALL adep220_msg_show(1)        #160225-00040#4 Add By Ken 160401
                  #RETURN                          
                  LET r_success = FALSE
                  RETURN r_success                
                  #161216-00004#2 161226 by lori mod---(E)
               END IF
            ELSE
               #寫入Log檔_(s)
               LET l_log = "-Error#14:s_artt600_post_chk,l_rtibdocno:",l_rtibdocno   #160111-00006#2 160111 By pomelo add#14
               CALL cl_log_write(l_log)
               DISPLAY l_log                       #151027-00016#5 151130 by lori add
               #寫入Log檔_(e)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = l_rtibdocno
               LET g_errparam.popup = TRUE
               LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
               LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            
              #CALL adep220_msg_show(1)        #160225-00040#4 Add By Ken 160401  #161216-00004#2 161226 by lori mark
               CALL cl_err()
               LET g_prog = 'adep220'          #150427-00001#9 150604 By pomelo add
                     
               #161216-00004#2 161226 by lori mod---(S)            
               #RETURN                          
               LET r_success = FALSE
               RETURN r_success                
               #161216-00004#2 161226 by lori mod---(E)
            END IF          
         END IF
         
      ELSE
         #寫入Log檔_(s)
         LET l_log = "-Error#15:s_artt600_conf_chk, l_rtibdocno:",l_rtibdocno   #160111-00006#2 160111 By pomelo add#15
         CALL cl_log_write(l_log)
         DISPLAY l_log                        #151027-00016#5 151130 by lori add
         #寫入Log檔_(e)        
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = l_rtibdocno
         LET g_errparam.popup = TRUE
         LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
         LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            
        #CALL adep220_msg_show(1)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
         CALL cl_err()
         LET g_prog = 'adep220'          #150427-00001#9 150604 By pomelo add
          
         #161216-00004#2 161226 by lori mod---(S)            
         #RETURN                          
         LET r_success = FALSE
         RETURN r_success                
         #161216-00004#2 161226 by lori mod---(E)
      END IF 
   END IF
   LET g_prog = 'adep220'            #150427-00001#9 150604 By pomelo add
   #150601-00026#1 15/06/01  by s983961---add(e)    

   #160225-00040#4 Add By Ken 160401(S)   產生資料
   #LET l_msg = cl_getmsg('ast-00330',g_lang)   #161216-00004#2 161226 by lori mark
   #CALL cl_progress_no_window_ing(l_msg)       #161216-00004#2 161226 by lori mark
   #160225-00040#4 Add By Ken 160401(E)   
   #EXECUTE adep220_p USING g_datetime    #160617-00001#1 Mark by Ken 160621 原取系統日期時間 改取rtia006
   EXECUTE adep220_p USING g_rtia006,l_rtia067      #160617-00001#1 Add by Ken 160621 原取系統日期時間 改取rtia006   #170106-00034#1 by sakura add l_rtia067
   IF SQLCA.SQLcode  THEN
      #寫入Log檔_(s)
      LET l_log = "-Error#16:EXECUTE adep220_p USING g_datetime,g_datetime:",g_datetime  #160111-00006#2 160111 By pomelo add#16
      CALL cl_log_write(l_log)
      DISPLAY l_log                        #151027-00016#5 151130 by lori add
      #寫入Log檔_(e)         
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd rtja_t"
      LET g_errparam.popup = TRUE
      LET g_errparam.coll_vals[1] = l_rtjb_d.rtjbsite
      LET g_errparam.coll_vals[2] = l_rtjb_d.rtjadocdt
            
     #CALL adep220_msg_show(0)        #160225-00040#4 Add By Ken 160401   #161216-00004#2 161226 by lori mark
      CALL cl_err()
  
      LET g_exitstus = FALSE          #160804-00060#1 160809 by lori add
      CALL s_transaction_end('N','0')
      #161216-00004#2 161226 by lori mod---(S)            
      #RETURN                          
      LET r_success = FALSE
      RETURN r_success                
      #161216-00004#2 161226 by lori mod---(E)
   ELSE
      CALL s_transaction_end('Y','0') 
   END IF

   #160118-00008#4 1612/23 by lori add---(S)
   IF NOT s_inventory_batch_drop_temp() THEN
      LET l_log = "Error:s_inv_batch Drop Temp Table Fail"
      CALL cl_log_write(l_log)    
      DISPLAY l_log
      #161216-00004#2 161226 by lori mod---(S)            
      #RETURN                          
      LET r_success = FALSE
      RETURN r_success                
      #161216-00004#2 161226 by lori mod---(E)
   END IF
   #160118-00008#4 161223 by lori add---(E)
            
   #161216-00004#2 161226 by lori add---(S)
   ##150515-00023#6 150903 by lori mark and add---(S) 
   ##CALL cl_showmsg()    
   ##160225-00040#4 Add By Ken 160401(S)
   #LET l_msg = cl_getmsg('std-00012',g_lang)
   #CALL cl_progress_no_window_ing(l_msg) 
   ##160225-00040#4 Add By Ken 160401(E)    
   #CALL cl_err_collect_show()                                   
   #161216-00004#2 161226 by lori mark---(E)      
   
   LET l_log = "End adep220_ins_table...",cl_get_timestamp()    
   CALL cl_log_write(l_log)                                      
   #150515-00023#6 150903 by lori mark and add---(E)
   
   RETURN r_success                #161216-00004#2 161226 by lori add
END FUNCTION
################################################################################
# Descriptions...: 扣帳
# Memo...........: #150601-00026#1 2015/06/01   已停止使用本函式
# Usage..........: CALL adep220_post()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success    處理結果
# Date & Author..: 
# Modify.........: 
################################################################################
PRIVATE FUNCTION adep220_post()
   DEFINE l_rtiadocno    LIKE rtia_t.rtiadocno
   DEFINE r_success       LIKE type_t.num5
   
   LET r_success = TRUE
   
   DECLARE adep2200_post_cs CURSOR FOR
      SELECT rtiadocno FROM adep220_tmp1
   
   FOREACH adep2200_post_cs INTO l_rtiadocno
      IF NOT adep220_inag_upd(l_rtiadocno) THEN
         LET g_exitstus = FALSE   #160804-00060#1 160809 by lori add
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 庫存異動更新
# Memo...........: #150601-00026#1 2015/06/01   已停止使用本函式
# Usage..........: CALL adep220_inag_upd(p_rtiadocno)
#                  RETURNING r_success
# Input parameter: p_rtiadocno  銷售單號
# Return code....: r_success    處理結果
# Date & Author..: 
# Modify.........: 
################################################################################
PRIVATE FUNCTION adep220_inag_upd(p_rtiadocno)
   DEFINE p_rtiadocno   LIKE rtia_t.rtiadocno
   DEFINE r_success     LIKE type_t.num5          #161216-00004#3 161226 by lori add
   #161104-00002#3 Mark By Ken 161105(S)
   #DEFINE l_rtib        RECORD LIKE rtib_t.*
   #DEFINE l_rtia        RECORD LIKE rtia_t.*
   #161104-00002#3 Mark By Ken 161105(E)
   #161104-00002#3 Add By Ken 161105(S)
   DEFINE l_rtib RECORD  #銷售交易商品明細檔
          rtibent LIKE rtib_t.rtibent, #企業編號
          rtibsite LIKE rtib_t.rtibsite, #營運據點
          rtibunit LIKE rtib_t.rtibunit, #應用組織
          rtiborga LIKE rtib_t.rtiborga, #帳務組織
          rtibdocno LIKE rtib_t.rtibdocno, #單據編號
          rtibseq LIKE rtib_t.rtibseq, #項次
          rtib001 LIKE rtib_t.rtib001, #來源單號
          rtib002 LIKE rtib_t.rtib002, #來源單號項次
          rtib003 LIKE rtib_t.rtib003, #商品條碼
          rtib004 LIKE rtib_t.rtib004, #商品編號
          rtib005 LIKE rtib_t.rtib005, #特徵碼
          rtib006 LIKE rtib_t.rtib006, #稅別編號
          rtib007 LIKE rtib_t.rtib007, #銷售開立發票
          rtib008 LIKE rtib_t.rtib008, #標準售價
          rtib009 LIKE rtib_t.rtib009, #促銷售價
          rtib010 LIKE rtib_t.rtib010, #交易售價
          rtib011 LIKE rtib_t.rtib011, #成本售價
          rtib012 LIKE rtib_t.rtib012, #銷售數量
          rtib013 LIKE rtib_t.rtib013, #銷售單位
          rtib014 LIKE rtib_t.rtib014, #庫存數量
          rtib015 LIKE rtib_t.rtib015, #庫存單位
          rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
          rtib017 LIKE rtib_t.rtib017, #計價數量
          rtib018 LIKE rtib_t.rtib018, #計價單位
          rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
          rtib020 LIKE rtib_t.rtib020, #折價金額
          rtib021 LIKE rtib_t.rtib021, #應收金額
          rtib022 LIKE rtib_t.rtib022, #未稅金額
          rtib023 LIKE rtib_t.rtib023, #成本金額
          rtib024 LIKE rtib_t.rtib024, #理由碼
          rtib025 LIKE rtib_t.rtib025, #庫區
          rtib026 LIKE rtib_t.rtib026, #儲位
          rtib027 LIKE rtib_t.rtib027, #批號
          rtib028 LIKE rtib_t.rtib028, #專櫃編號
          rtib029 LIKE rtib_t.rtib029, #分攤積點
          rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
          rtib031 LIKE rtib_t.rtib031, #本幣應收金額
          rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
          rtib033 LIKE rtib_t.rtib033, #營業員
          rtib034 LIKE rtib_t.rtib034, #掃描碼
          rtib035 LIKE rtib_t.rtib035, #交易類型
          rtib036 LIKE rtib_t.rtib036, #商品屬性
          rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
          rtib038 LIKE rtib_t.rtib038, #結算扣率
          rtib039 LIKE rtib_t.rtib039, #贈品否
          rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
          rtib041 LIKE rtib_t.rtib041, #卡號/券號
          rtib101 LIKE rtib_t.rtib101, #退貨退回商品(租賃)
          rtib102 LIKE rtib_t.rtib102, #產品品類(租賃)
          rtib103 LIKE rtib_t.rtib103, #品牌(租賃)
          rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
          rtib105 LIKE rtib_t.rtib105, #合約編號(租賃)
          rtib106 LIKE rtib_t.rtib106, #單位兌換積分
          rtib107 LIKE rtib_t.rtib107, #促銷單位兌換積分
          rtib108 LIKE rtib_t.rtib108, #總兌換積分
          rtib042 LIKE rtib_t.rtib042, #退貨方式
          rtib043 LIKE rtib_t.rtib043, #發票編號
          rtib044 LIKE rtib_t.rtib044, #發票號碼
          rtib109 LIKE rtib_t.rtib109, #返現金額
          #161123-00042#3 Add By Ken 161124(S)
          rtibud001 LIKE rtib_t.rtibud001, #自定義欄位(文字)001
          rtibud002 LIKE rtib_t.rtibud002, #自定義欄位(文字)002
          rtibud003 LIKE rtib_t.rtibud003, #自定義欄位(文字)003
          rtibud004 LIKE rtib_t.rtibud004, #自定義欄位(文字)004
          rtibud005 LIKE rtib_t.rtibud005, #自定義欄位(文字)005
          rtibud006 LIKE rtib_t.rtibud006, #自定義欄位(文字)006
          rtibud007 LIKE rtib_t.rtibud007, #自定義欄位(文字)007
          rtibud008 LIKE rtib_t.rtibud008, #自定義欄位(文字)008
          rtibud009 LIKE rtib_t.rtibud009, #自定義欄位(文字)009
          rtibud010 LIKE rtib_t.rtibud010, #自定義欄位(文字)010
          rtibud011 LIKE rtib_t.rtibud011, #自定義欄位(數字)011
          rtibud012 LIKE rtib_t.rtibud012, #自定義欄位(數字)012
          rtibud013 LIKE rtib_t.rtibud013, #自定義欄位(數字)013
          rtibud014 LIKE rtib_t.rtibud014, #自定義欄位(數字)014
          rtibud015 LIKE rtib_t.rtibud015, #自定義欄位(數字)015
          rtibud016 LIKE rtib_t.rtibud016, #自定義欄位(數字)016
          rtibud017 LIKE rtib_t.rtibud017, #自定義欄位(數字)017
          rtibud018 LIKE rtib_t.rtibud018, #自定義欄位(數字)018
          rtibud019 LIKE rtib_t.rtibud019, #自定義欄位(數字)019
          rtibud020 LIKE rtib_t.rtibud020, #自定義欄位(數字)020
          rtibud021 LIKE rtib_t.rtibud021, #自定義欄位(日期時間)021
          rtibud022 LIKE rtib_t.rtibud022, #自定義欄位(日期時間)022
          rtibud023 LIKE rtib_t.rtibud023, #自定義欄位(日期時間)023
          rtibud024 LIKE rtib_t.rtibud024, #自定義欄位(日期時間)024
          rtibud025 LIKE rtib_t.rtibud025, #自定義欄位(日期時間)025
          rtibud026 LIKE rtib_t.rtibud026, #自定義欄位(日期時間)026
          rtibud027 LIKE rtib_t.rtibud027, #自定義欄位(日期時間)027
          rtibud028 LIKE rtib_t.rtibud028, #自定義欄位(日期時間)028
          rtibud029 LIKE rtib_t.rtibud029, #自定義欄位(日期時間)029
          rtibud030 LIKE rtib_t.rtibud030  #自定義欄位(日期時間)030
          #161123-00042#3 Add By Ken 161124(E)
   END RECORD   
   DEFINE l_rtia RECORD  #銷售交易單頭檔
          rtiaent LIKE rtia_t.rtiaent, #企業編號
          rtiasite LIKE rtia_t.rtiasite, #營運據點
          rtiaunit LIKE rtia_t.rtiaunit, #應用組織
          rtiadocno LIKE rtia_t.rtiadocno, #單據編號
          rtiadocdt LIKE rtia_t.rtiadocdt, #單據日期
          rtiastus LIKE rtia_t.rtiastus, #狀態
          rtia000 LIKE rtia_t.rtia000, #程式作業編號
          rtia001 LIKE rtia_t.rtia001, #會員卡號
          rtia002 LIKE rtia_t.rtia002, #客戶編號
          rtia003 LIKE rtia_t.rtia003, #一次性交易對象識別碼
          rtia004 LIKE rtia_t.rtia004, #業務人員
          rtia005 LIKE rtia_t.rtia005, #業務部門
          rtia006 LIKE rtia_t.rtia006, #過帳日期
          rtia007 LIKE rtia_t.rtia007, #來源單號
          rtia008 LIKE rtia_t.rtia008, #來源版本
          rtia009 LIKE rtia_t.rtia009, #銷售分類
          rtia010 LIKE rtia_t.rtia010, #送貨客戶編號
          rtia011 LIKE rtia_t.rtia011, #帳款客戶編號
          rtia012 LIKE rtia_t.rtia012, #發票客戶編號
          rtia013 LIKE rtia_t.rtia013, #整單折扣
          rtia014 LIKE rtia_t.rtia014, #起始發票\折讓號碼
          rtia015 LIKE rtia_t.rtia015, #截止發票\折讓號碼
          rtia016 LIKE rtia_t.rtia016, #交易積點
          rtia017 LIKE rtia_t.rtia017, #送貨類型
          rtia018 LIKE rtia_t.rtia018, #送貨營運組織
          rtia019 LIKE rtia_t.rtia019, #收貨郵政編號
          rtia020 LIKE rtia_t.rtia020, #收貨地址
          rtia021 LIKE rtia_t.rtia021, #收貨人
          rtia022 LIKE rtia_t.rtia022, #收貨聯絡電話
          rtia023 LIKE rtia_t.rtia023, #提貨類別
          rtia024 LIKE rtia_t.rtia024, #取貨營運組織
          rtia025 LIKE rtia_t.rtia025, #收款條件
          rtia026 LIKE rtia_t.rtia026, #交易幣別
          rtia027 LIKE rtia_t.rtia027, #交易匯率
          rtia028 LIKE rtia_t.rtia028, #稅別
          rtia029 LIKE rtia_t.rtia029, #稅率
          rtia030 LIKE rtia_t.rtia030, #含稅
          rtia031 LIKE rtia_t.rtia031, #含稅應收金額
          rtia032 LIKE rtia_t.rtia032, #資料來源
          rtia033 LIKE rtia_t.rtia033, #資料來源單號
          rtia034 LIKE rtia_t.rtia034, #來源交易日期
          rtia035 LIKE rtia_t.rtia035, #來源交易時間
          rtia036 LIKE rtia_t.rtia036, #收銀機號
          rtia037 LIKE rtia_t.rtia037, #收銀人員
          rtia038 LIKE rtia_t.rtia038, #班別
          rtia039 LIKE rtia_t.rtia039, #收銀方式
          rtia040 LIKE rtia_t.rtia040, #拋轉
          rtia041 LIKE rtia_t.rtia041, #備註
          rtia042 LIKE rtia_t.rtia042, #卡種編號
          rtia043 LIKE rtia_t.rtia043, #卡積點餘額
          rtia044 LIKE rtia_t.rtia044, #贈品兌換規則編號
          rtia045 LIKE rtia_t.rtia045, #贈品兌換規則版本
          rtia046 LIKE rtia_t.rtia046, #贈品兌換該規則計算總積點
          rtia047 LIKE rtia_t.rtia047, #贈品兌換此次積點
          rtia048 LIKE rtia_t.rtia048, #結帳否
          rtia049 LIKE rtia_t.rtia049, #本幣含稅應收金額
          rtiaownid LIKE rtia_t.rtiaownid, #資料所屬者
          rtiaowndp LIKE rtia_t.rtiaowndp, #資料所有部門
          rtiacrtid LIKE rtia_t.rtiacrtid, #資料建立者
          rtiacrtdp LIKE rtia_t.rtiacrtdp, #資料建立部門
          rtiacrtdt LIKE rtia_t.rtiacrtdt, #資料創建日
          rtiamodid LIKE rtia_t.rtiamodid, #資料修改者
          rtiamoddt LIKE rtia_t.rtiamoddt, #最近修改日
          rtiacnfid LIKE rtia_t.rtiacnfid, #資料確認者
          rtiacnfdt LIKE rtia_t.rtiacnfdt, #資料確認日
          rtiapstid LIKE rtia_t.rtiapstid, #資料過帳者
          rtiapstdt LIKE rtia_t.rtiapstdt, #資料過帳日
          rtia050 LIKE rtia_t.rtia050, #組織贈送
          rtia051 LIKE rtia_t.rtia051, #應收尾款金額
          rtia052 LIKE rtia_t.rtia052, #立帳單號
          rtia053 LIKE rtia_t.rtia053, #出納收款
          rtia054 LIKE rtia_t.rtia054, #處理積分否
          rtia055 LIKE rtia_t.rtia055, #找零轉儲否
          rtia056 LIKE rtia_t.rtia056, #會員編號批量產生否
          rtia057 LIKE rtia_t.rtia057, #退貨原銷售單日期
          rtia058 LIKE rtia_t.rtia058, #會員消費回寫否
          rtia059 LIKE rtia_t.rtia059, #顧客姓名
          rtia060 LIKE rtia_t.rtia060, #顧客電話
          rtia101 LIKE rtia_t.rtia101, #鋪位編號(租賃)
          rtia102 LIKE rtia_t.rtia102, #商戶編號(租賃)
          rtia103 LIKE rtia_t.rtia103, #no use
          rtia104 LIKE rtia_t.rtia104, #no use
          rtia105 LIKE rtia_t.rtia105, #合約編號(租賃)
          rtia106 LIKE rtia_t.rtia106, #銷售合約金額(租賃)
          rtia107 LIKE rtia_t.rtia107, #是否訂單代採購
          rtia061 LIKE rtia_t.rtia061, #國家
          rtia062 LIKE rtia_t.rtia062, #省
          rtia063 LIKE rtia_t.rtia063, #市
          rtia064 LIKE rtia_t.rtia064, #區
          rtia065 LIKE rtia_t.rtia065, #街道
          rtia108 LIKE rtia_t.rtia108, #促銷規則編號
          rtia066 LIKE rtia_t.rtia066,  #兌換業態
          #161123-00042#3 Add By Ken 161124(S)
          rtiaud001 LIKE rtia_t.rtiaud001, #自定義欄位(文字)001
          rtiaud002 LIKE rtia_t.rtiaud002, #自定義欄位(文字)002
          rtiaud003 LIKE rtia_t.rtiaud003, #自定義欄位(文字)003
          rtiaud004 LIKE rtia_t.rtiaud004, #自定義欄位(文字)004
          rtiaud005 LIKE rtia_t.rtiaud005, #自定義欄位(文字)005
          rtiaud006 LIKE rtia_t.rtiaud006, #自定義欄位(文字)006
          rtiaud007 LIKE rtia_t.rtiaud007, #自定義欄位(文字)007
          rtiaud008 LIKE rtia_t.rtiaud008, #自定義欄位(文字)008
          rtiaud009 LIKE rtia_t.rtiaud009, #自定義欄位(文字)009
          rtiaud010 LIKE rtia_t.rtiaud010, #自定義欄位(文字)010
          rtiaud011 LIKE rtia_t.rtiaud011, #自定義欄位(數字)011
          rtiaud012 LIKE rtia_t.rtiaud012, #自定義欄位(數字)012
          rtiaud013 LIKE rtia_t.rtiaud013, #自定義欄位(數字)013
          rtiaud014 LIKE rtia_t.rtiaud014, #自定義欄位(數字)014
          rtiaud015 LIKE rtia_t.rtiaud015, #自定義欄位(數字)015
          rtiaud016 LIKE rtia_t.rtiaud016, #自定義欄位(數字)016
          rtiaud017 LIKE rtia_t.rtiaud017, #自定義欄位(數字)017
          rtiaud018 LIKE rtia_t.rtiaud018, #自定義欄位(數字)018
          rtiaud019 LIKE rtia_t.rtiaud019, #自定義欄位(數字)019
          rtiaud020 LIKE rtia_t.rtiaud020, #自定義欄位(數字)020
          rtiaud021 LIKE rtia_t.rtiaud021, #自定義欄位(日期時間)021
          rtiaud022 LIKE rtia_t.rtiaud022, #自定義欄位(日期時間)022
          rtiaud023 LIKE rtia_t.rtiaud023, #自定義欄位(日期時間)023
          rtiaud024 LIKE rtia_t.rtiaud024, #自定義欄位(日期時間)024
          rtiaud025 LIKE rtia_t.rtiaud025, #自定義欄位(日期時間)025
          rtiaud026 LIKE rtia_t.rtiaud026, #自定義欄位(日期時間)026
          rtiaud027 LIKE rtia_t.rtiaud027, #自定義欄位(日期時間)027
          rtiaud028 LIKE rtia_t.rtiaud028, #自定義欄位(日期時間)028
          rtiaud029 LIKE rtia_t.rtiaud029, #自定義欄位(日期時間)029
          rtiaud030 LIKE rtia_t.rtiaud030  #自定義欄位(日期時間)030
          #161123-00042#3 Add By Ken 161124(E)
   END RECORD
   #161104-00002#3 Add By Ken 161105(E)
   DEFINE l_sql         STRING
   
   LET r_success = TRUE
   
   SELECT rtia000,rtia002
     INTO l_rtia.rtia000,l_rtia.rtia002
     FROM rtia_t
    WHERE rtiaent = g_enterprise
      AND rtiadocno = p_rtiadocno
   
   
   LET l_sql = "SELECT rtibsite,rtibseq,rtib004,rtib005,rtib025, ",
               "       rtib026,rtib027,rtib012,rtib013",
               "  FROM rtib_t",
               " WHERE rtibent = '",g_enterprise,"'",
               "   AND rtibdocno = '",p_rtiadocno,"'",
               " ORDER BY rtibseq"
   PREPARE s_adep220_pre11 FROM l_sql
   DECLARE s_adep220_cs11 CURSOR FOR s_adep220_pre11
   
   FOREACH s_adep220_cs11 INTO l_rtib.rtibsite,l_rtib.rtibseq,l_rtib.rtib004,l_rtib.rtib005,l_rtib.rtib025,
                               l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib012,l_rtib.rtib013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #蒐集不存在inag_t的資料
      #160512-00004#1 by whitney modify start
      ##料件編號,產品特徵,庫存管理特徵,庫位,儲位,批號,有效日期,備註,第一次入庫日期,單位
      #CALL s_inventory_ins_inag_collect(l_rtib.rtib004,l_rtib.rtib005,' ',l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,'','',g_today,l_rtib.rtib013,'ALL')      
      #                                 料件编号        产品特征       库存管理特征    库位
      CALL s_inventory_ins_inag_collect(l_rtib.rtib004,l_rtib.rtib005,' '           ,l_rtib.rtib025,
      #                                 储位           批号            单位           备注
                                        l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib013,''            ,
      #                                 第一次入库日期  製造日期        有效日期        營運據點
                                        g_today       ,''            ,''            ,'ALL')
      #160512-00004#1 by whitney modify end
   END FOREACH

   #INSERT庫儲批資料
   CALL s_inventory_ins_inag('ALL') RETURNING r_success

   IF NOT r_success THEN
      RETURN r_success
   END IF
             
   FOREACH s_adep220_cs11 INTO l_rtib.rtibsite,l_rtib.rtibseq,l_rtib.rtib004,l_rtib.rtib005,l_rtib.rtib025,
                               l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib012,l_rtib.rtib013  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         LET g_exitstus = FALSE   #160804-00060#1 160809 by lori add 
         EXIT FOREACH
      END IF
      IF l_rtib.rtib012 >= 0 THEN 
         #更新庫存明細檔      
          #CALL s_inventory_upd_inag(l_rtib.rtib004,' ',' ',l_rtib.rtib025,l_rtib.rtib026,          ##150525 s83961 add---s
         CALL s_inventory_upd_inag(l_rtib.rtib004,l_rtib.rtib005,' ',l_rtib.rtib025,l_rtib.rtib026, 
                                  # l_rtib.rtib027,'-1',l_rtib.rtib012,g_today,l_rtib.rtibdocno,       
                                   l_rtib.rtib027,'-1',l_rtib.rtib012,g_today,p_rtiadocno,          ##150525 s83961 add---e
                                   l_rtib.rtibseq,'0',l_rtib.rtib013,l_rtib.rtib012,'1','ALL') RETURNING r_success
      ELSE
         #更新庫存明細檔      
  #CALL s_inventory_upd_inag(l_rtib.rtib004,' ',' ',l_rtib.rtib025,l_rtib.rtib026,                  ##150525 s83961 add---s
         CALL s_inventory_upd_inag(l_rtib.rtib004,l_rtib.rtib005,' ',l_rtib.rtib025,l_rtib.rtib026,  
                                   #l_rtib.rtib027, '1',l_rtib.rtib012*(-1),g_today,l_rtib.rtibdocno,  
                                   l_rtib.rtib027, '1',l_rtib.rtib012*(-1),g_today,p_rtiadocno,     ##150525 s83961 add---e
                                   l_rtib.rtibseq,'0',l_rtib.rtib013,l_rtib.rtib012,'2','ALL') RETURNING r_success
      END IF
      IF NOT r_success THEN 
         LET g_exitstus = FALSE   #160804-00060#1 160809 by lori add
         EXIT FOREACH
      END IF
      
      INITIALIZE g_inaj.* TO NULL
      LET g_inaj.inajent   = g_enterprise      #企業代碼                    
      LET g_inaj.inajsite  = l_rtib.rtibsite   #營運據點                    
      LET g_inaj.inaj001   = p_rtiadocno       #單據編號                    
      LET g_inaj.inaj002   = l_rtib.rtibseq    #項次                        
      LET g_inaj.inaj003   = '0'               #項序       
      IF l_rtib.rtib012 >= 0 THEN
         LET g_inaj.inaj004   = '-1'              #出入庫碼 
      ELSE
         LET g_inaj.inaj004   = '1'
      END IF 
      LET g_inaj.inaj005   = l_rtib.rtib004    #料件編號                    
      LET g_inaj.inaj006   = l_rtib.rtib005    #產品特徵                    
      LET g_inaj.inaj007   = ' '               #庫存管理特徵                
      LET g_inaj.inaj008   = l_rtib.rtib025    #庫位編號                    
      LET g_inaj.inaj009   = l_rtib.rtib026    #儲位編號                    
      LET g_inaj.inaj010   = l_rtib.rtib027    #批號     
      IF l_rtib.rtib012 < 0 THEN 
         LET g_inaj.inaj011   = l_rtib.rtib012*(-1)
      ELSE          
         LET g_inaj.inaj011   = l_rtib.rtib012    #交易數量
      END IF             
      LET g_inaj.inaj012   = l_rtib.rtib013    #交易單位 
#      #inaj的KEY已经到单位了，所以库存单位就是异动单位
#      LET g_inaj.inaj013   = 1                 #交易單位與庫存單位換算率  
#      SELECT imaa006 INTO l_imaa006 FROM imaa_t
#       WHERE imaaent = g_enterprise
#         AND imaa001 = g_inaj.inaj005
#      IF l_imaa006 = g_inaj.inaj012 THEN
#         LET l_rate = 1
#      ELSE
#         CALL s_aimi190_get_convert(g_inaj.inaj005,g_inaj.inaj012,l_imaa006)
#              RETURNING r_success,l_rate
#         IF NOT r_success THEN
#            RETURN r_success
#         END IF
#      END IF
#      LET g_inaj.inaj014   = l_rate            #交易單位與料件基本單位換算率
      LET g_inaj.inaj015   = l_rtia.rtia000    #異動命令代號      
#      LET g_inaj.inaj016   = l_rtib.rtib024    #理由碼      
      LET g_inaj.inaj017   = g_dept            #異動部門編號                
      LET g_inaj.inaj018   = l_rtia.rtia002    #異動廠商/客戶編號           
#      LET g_inaj.inaj019   = l_rtia.rtia041    #備註                        
#      LET g_inaj.inaj020   = ''                #工單單號/料號               
#      LET g_inaj.inaj021   = ''                #多角序號                                         
      LET g_inaj.inaj022   = cl_get_current()  #單據扣帳日期
      LET g_inaj.inaj023   = cl_get_today()    #實際執行扣帳日期
      LET g_inaj.inaj024   = cl_get_time()     #資料產生時間
      LET g_inaj.inaj025   = g_user            #異動資料產生者
       
      CALL s_inventory_ins_inaj('ALL') RETURNING r_success
      IF NOT r_success THEN
         LET g_exitstus = FALSE   #160804-00060#1 160809 by lori add
         EXIT FOREACH
      END IF
   END FOREACH
             
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 批次產生資料的進度條顯示次數
# Memo...........: #1161216-00004#2 2016/12/26   已停止使用本函式
# Usage..........: CALL adep220_msg_show(p_cnt)
# Input parameter: p_cnt          要顯示的次數
# Return code....: 
# Date & Author..: 2016/5/5 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep220_msg_show(p_cnt)
DEFINE p_cnt            LIKE type_t.num5
DEFINE l_min_cnt        LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_msg            STRING            

   LET l_min_cnt = 1
   FOR l_i = l_min_cnt TO p_cnt
      LET l_msg = cl_getmsg('ast-00330',g_lang)
      CALL cl_progress_no_window_ing(l_msg)     
   END FOR
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
END FUNCTION

#end add-point
 
{</section>}
 
