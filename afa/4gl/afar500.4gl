#該程式未解開Section, 採用最新樣板產出!
{<section id="afar500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-05-25 17:47:44), PR版次:0006(2016-10-28 14:32:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: afar500
#+ Description: 資產異動憑證列印作業
#+ Creator....: 02003(2015-04-09 16:37:46)
#+ Modifier...: 06821 -SD/PR- 05016
 
{</section>}
 
{<section id="afar500.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#140721-00004#15   2015/10/10             新增afat4*異動類型列印（外送，外送收回，合併，分割）
#151210-00006#1    2015/12/10             单据作业动态设定打印报表元件
#151202-00004#5    2015/12/14             单据作业动态设定打印报表元件(5,7,27)
#160426-00014#33   2016/08/17 BY 02114    修改权限的问题
#161006-00005#35   2016/10/24 By 06814    资产中心开窗调整为q_ooef001_47 
#161024-00008#6    2016/10/8  By Hans     AFA組織類型與職能開窗清單調整。 
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
       fabgsite LIKE type_t.chr10, 
   fabgsite_desc LIKE type_t.chr80, 
   fabg005 LIKE type_t.num10, 
   fabgld LIKE type_t.chr5, 
   fabgld_desc LIKE type_t.chr80, 
   fabgdocno LIKE type_t.chr20, 
   fabg002 LIKE type_t.chr20, 
   fabgdocdt LIKE type_t.dat, 
   fabg003 LIKE type_t.chr10, 
   fabg001 LIKE type_t.chr20, 
   fabgstus LIKE type_t.chr1,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afar500.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL afar500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afar500 WITH FORM cl_ap_formpath("afa",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL afar500_init()
 
      #進入選單 Menu (="N")
      CALL afar500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afar500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afar500.init" >}
#+ 初始化作業
PRIVATE FUNCTION afar500_init()
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
  #CALL cl_set_combo_scc_part('fabg005','9910','4,6,8,9,14,21')   #140721-00004#15 mark
#   CALL cl_set_combo_scc_part('fabg005','9910','4,6,8,9,10,11,18,19,14,21') #140721-00004#15 add
   CALL cl_set_combo_scc_part('fabg005','9910','4,5,6,7,8,9,10,11,18,19,14,21,27') #151202-00004
   CALL cl_set_combo_scc_part('fabgstus','13','N,Y,S,X')
   LET g_master.fabg005 = '4' 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afar500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar500_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp      #160426-00014#33 add lujh
   DEFINE l_success       LIKE type_t.num5          #160426-00014#33 add lujh
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.fabgstus = 'N'
   LET g_master.fabgsite = g_site
   CALL afar500_glaald_get()
   #160426-00014#33--add--str--lujh
   CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
   CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
   DISPLAY BY NAME g_master.fabgsite_desc,g_master.fabgld_desc
   #160426-00014#33--add--end--lujh
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.fabgsite,g_master.fabg005,g_master.fabgstus 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
#160426-00014#33--mark--str--lujh
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_master.fabgsite
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_master.fabgsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_master.fabgsite_desc
#            #带出默认主帐套
#            CALL afar500_glaald_get()
#160426-00014#33--mark--end--lujh
            
#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_master.fabgsite) THEN
               CALL s_afa_site_chk(g_master.fabgsite,'','',g_master.fabgld,g_today)
               RETURNING l_success,l_glaacomp,g_master.fabgld
               
               IF l_success = FALSE THEN 
                  LET g_master.fabgsite = ''
                  LET g_master.fabgld = ''
                  CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
                  CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
                  DISPLAY BY NAME g_master.fabgsite_desc,g_master.fabgld_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_master.fabgsite,g_today,'1')
            CALL s_desc_get_department_desc(g_master.fabgsite) RETURNING g_master.fabgsite_desc
            CALL s_desc_get_ld_desc(g_master.fabgld) RETURNING g_master.fabgld_desc
            DISPLAY BY NAME g_master.fabgsite_desc,g_master.fabgld_desc
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="input.b.fabgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgsite
            #add-point:ON CHANGE fabgsite name="input.g.fabgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="input.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="input.a.fabg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg005
            #add-point:ON CHANGE fabg005 name="input.g.fabg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgstus
            #add-point:BEFORE FIELD fabgstus name="input.b.fabgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgstus
            
            #add-point:AFTER FIELD fabgstus name="input.a.fabgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgstus
            #add-point:ON CHANGE fabgstus name="input.g.fabgstus"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="input.c.fabgsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.fabgsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            #161006-00005#35 20161024 add by beckxie---S
            ##160426-00014#33--add--str--lujh
			   #LET g_qryparam.where =" ooef207='Y'"    
            #CALL q_ooef001()                        #呼叫開窗
            ##160426-00014#33--add--end--lujh
            ##CALL q_faab001()                       #呼叫開窗    #160426-00014#33 mark lujh
            #161006-00005#35 20161024 add by beckxie---E
            CALL q_ooef001_47()   #161006-00005#35 20161024 add by beckxie

            LET g_master.fabgsite = g_qryparam.return1              

            DISPLAY g_master.fabgsite TO fabgsite              #

            NEXT FIELD fabgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="input.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgstus
            #add-point:ON ACTION controlp INFIELD fabgstus name="input.c.fabgstus"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON fabgdocno,fabg002,fabgdocdt,fabg003,fabg001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="construct.c.fabgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #140721-00004#15---add---str
            IF  g_master.fabg005 = "5" OR g_master.fabg005= " 7" OR g_master.fabg005 = '10' OR g_master.fabg005 = '11' OR g_master.fabg005 = '18' OR g_master.fabg005 = '19' OR g_master.fabg005 = '27' THEN
               LET g_qryparam.where = " faba003 = '",g_master.fabg005,"' AND fabasite = '",g_master.fabgsite,"'"
               CALL q_fabadocno()                           #呼叫開窗
            ELSE
            #140721-00004#15---add---end
               LET g_qryparam.where = " fabg005 = '",g_master.fabg005,"' AND fabgsite = '",g_master.fabgsite,"'"
               CALL q_fabgdocno()                           #呼叫開窗
            END IF  #140721-00004#15
            DISPLAY g_qryparam.return1 TO fabgdocno  #顯示到畫面上
            NEXT FIELD fabgdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="construct.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="construct.a.fabgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="construct.c.fabg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg002  #顯示到畫面上
            NEXT FIELD fabg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="construct.b.fabg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="construct.a.fabg002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="construct.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="construct.a.fabgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="construct.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="construct.c.fabg003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001_9()                           #呼叫開窗 161024-00008#6 
            CALL q_ooeg001_4()                            #161024-00008#6 
            DISPLAY g_qryparam.return1 TO fabg003  #顯示到畫面上
            NEXT FIELD fabg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="construct.b.fabg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="construct.a.fabg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="construct.c.fabg001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg001  #顯示到畫面上
            NEXT FIELD fabg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="construct.b.fabg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="construct.a.fabg001"
            
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
            CALL afar500_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL afar500_get_buffer(l_dialog)
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
         CALL afar500_init()
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
                 CALL afar500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = afar500_transfer_argv(ls_js)
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
 
{<section id="afar500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION afar500_transfer_argv(ls_js)
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
 
{<section id="afar500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION afar500_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"fabgdocno,fabg002,fabgdocdt,fabg003,fabg001")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #151210-00006#1---add----str--
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
      LET  g_master.fabg005 = l_arg[02]
   ELSE
      IF g_master.fabg005 = '6' OR g_master.fabg005 = '21' OR g_master.fabg005 = '8' OR 
         g_master.fabg005 = '9' OR g_master.fabg005 = '14' OR g_master.fabg005 = '4' THEN
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabadocno','fabgdocno')
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabadocdt','fabgdocdt')
         LET g_master.wc = cl_replace_str(g_master.wc, 'faba001','fabg001')
         LET g_master.wc = cl_replace_str(g_master.wc, 'faba004','fabg002')
         LET g_master.wc = cl_replace_str(g_master.wc, 'faba005','fabg003')
      ELSE
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabgdocno','fabadocno')
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabgdocdt','fabadocdt')
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg001','faba001')
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg002','faba004')
         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg003','faba005')
      END IF
      CASE 
         #销帐/报废，重估，改良，减值准备，出售
         WHEN g_master.fabg005 = '6' OR g_master.fabg005 = '21' OR g_master.fabg005 = '8' OR g_master.fabg005 = '9'
            OR g_master.fabg005 = '14' OR g_master.fabg005 = '4' 
            LET g_rep_wc = " fabgsite ='"||g_master.fabgsite||"' AND fabg005 = '"||g_master.fabg005||
                           "' AND fabgstus = '"||g_master.fabgstus||"' AND fabgld = '"||g_master.fabgld||
                           "' AND fabgdocno = '"||g_master.fabgdocno||"'"
         #外送，外送收回，合併，分割
         WHEN g_master.fabg005 = '10' OR g_master.fabg005 = '11' OR g_master.fabg005 = '18' OR g_master.fabg005 = '19' OR g_master.fabg005 = '5' OR g_master.fabg005 = '7' OR g_master.fabg005 = '27'
            LET g_master.wc = g_master.wc CLIPPED," AND fabasite='",g_master.fabgsite,"' AND faba003='",g_master.fabg005,"'",
                              " AND fabastus = '",g_master.fabgstus,"'"
      END CASE
   END IF
   CASE 
      
      #销帐/报废
      WHEN g_master.fabg005 = '6' OR g_master.fabg005 = '21'
         CALL afar500_g01(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
      #重估
      WHEN g_master.fabg005 = '8'  
         CALL afar500_g02(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
      #改良
      WHEN g_master.fabg005 = '9'
         CALL afar500_g03(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
      #减值准备
      WHEN g_master.fabg005 = '14'
         CALL afar500_g04(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
      #出售
      WHEN g_master.fabg005 = '4'
         CALL afar500_g05(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
      #外送
      WHEN g_master.fabg005 = '10'
         CALL afar500_g06(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #外送收回
      WHEN g_master.fabg005 = '11'
         CALL afar500_g07(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #合併
      WHEN g_master.fabg005 = '18'
         CALL afar500_g08(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #分割
      WHEN g_master.fabg005 = '19'
         CALL afar500_g08(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #停用
      WHEN g_master.fabg005 = '7'
         CALL afar500_g09(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #部门转移
      WHEN g_master.fabg005 = '27'
         CALL afar500_g10(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
      #工作量
      WHEN g_master.fabg005 = '5'
         CALL afar500_g11(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
     
   END CASE
   #151210-00006#1---add----end--
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #151210-00006#1---mark----str--
#      IF g_master.fabg005 = '6' OR g_master.fabg005 = '21' OR g_master.fabg005 = '8' OR 
#         g_master.fabg005 = '9' OR g_master.fabg005 = '14' OR g_master.fabg005 = '4' THEN
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabadocno','fabgdocno')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabadocdt','fabgdocdt')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'faba001','fabg001')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'faba004','fabg002')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'faba005','fabg003')
#      ELSE
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabgdocno','fabadocno')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabgdocdt','fabadocdt')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg001','faba001')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg002','faba004')
#         LET g_master.wc = cl_replace_str(g_master.wc, 'fabg003','faba005')
#      END IF
#      CASE 
#         #销帐/报废
#         WHEN g_master.fabg005 = '6' OR g_master.fabg005 = '21'
#            CALL afar500_g01(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
#         #重估
#         WHEN g_master.fabg005 = '8'  
#            CALL afar500_g02(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
#         #改良
#         WHEN g_master.fabg005 = '9'
#            CALL afar500_g03(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
#         #减值准备
#         WHEN g_master.fabg005 = '14'
#            CALL afar500_g04(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
#         #出售
#         WHEN g_master.fabg005 = '4'
#            CALL afar500_g05(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus,g_master.fabgld)
#         #外送
#         WHEN g_master.fabg005 = '10'
#            CALL afar500_g06(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
#         #外送收回
#         WHEN g_master.fabg005 = '11'
#            CALL afar500_g07(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
#         #合併
#         WHEN g_master.fabg005 = '18'
#            CALL afar500_g08(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
#         #分割
#         WHEN g_master.fabg005 = '19'
#            CALL afar500_g08(g_master.wc,g_master.fabgsite,g_master.fabg005,g_master.fabgstus)
#      END CASE 
      #151210-00006#1---mark----end--
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE afar500_process_cs CURSOR FROM ls_sql
#  FOREACH afar500_process_cs INTO
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
 
{<section id="afar500.get_buffer" >}
PRIVATE FUNCTION afar500_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.fabgsite = p_dialog.getFieldBuffer('fabgsite')
   LET g_master.fabg005 = p_dialog.getFieldBuffer('fabg005')
   LET g_master.fabgstus = p_dialog.getFieldBuffer('fabgstus')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afar500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 获取主帐套
# Memo...........:
# Usage..........: CALL afar500_glaald_get
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/04/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afar500_glaald_get()

   SELECT glaald INTO g_master.fabgld
     FROM glaa_t,ooef_t
    WHERE glaacomp = ooef017
      AND ooef001 = g_master.fabgsite
      AND glaa014 = 'Y'
      AND glaaent = ooefent
      AND glaaent = g_enterprise 
   DISPLAY BY NAME g_master.fabgld
END FUNCTION

#end add-point
 
{</section>}
 
