#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp610.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-05-03 17:22:51), PR版次:0002(2016-10-21 10:36:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: awsp610
#+ Description: 組織基本資料檔批次作業
#+ Creator....: 07556(2016-03-22 16:20:54)
#+ Modifier...: 07556 -SD/PR- 02702
 
{</section>}
 
{<section id="awsp610.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#+ Modifier...: 02702 需求單號:161021-00008 執行組織的批次時,有時會出現-391的錯誤訊息
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
       ooefent LIKE type_t.num5, 
   ooef001 LIKE type_t.chr10, 
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
 
{<section id="awsp610.main" >}
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
   CALL cl_ap_init("aws","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL awsp610_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp610 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp610_init()
 
      #進入選單 Menu (="N")
      CALL awsp610_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp610
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp610.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp610_init()
 
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
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="awsp610.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp610_ui_dialog()
 
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
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON ooefent,ooef001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooefent
            #add-point:BEFORE FIELD ooefent name="construct.b.ooefent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooefent
            
            #add-point:AFTER FIELD ooefent name="construct.a.ooefent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ooefent
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooefent
            #add-point:ON ACTION controlp INFIELD ooefent name="construct.c.ooefent"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_wseg001()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO ooefent  #顯示到畫面上
            #NEXT FIELD ooefent                     #返回原欄位
    



            #END add-point
 
 
         #Ctrlp:construct.c.ooef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooef001
            #add-point:ON ACTION controlp INFIELD ooef001 name="construct.c.ooef001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooef001  #顯示到畫面上
            NEXT FIELD ooef001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooef001
            #add-point:BEFORE FIELD ooef001 name="construct.b.ooef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooef001
            
            #add-point:AFTER FIELD ooef001 name="construct.a.ooef001"
            
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
            CALL awsp610_get_buffer(l_dialog)
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
         CALL awsp610_init()
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
                 CALL awsp610_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp610_transfer_argv(ls_js)
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
 
{<section id="awsp610.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp610_transfer_argv(ls_js)
 
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
 
{<section id="awsp610.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp610_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_wseh_sql   STRING
   DEFINE ls_ins_sql    STRING
   DEFINE ls_upd_sql    STRING
   DEFINE ls_middb      STRING
   DEFINE ls_s_time     LIKE type_t.chr20
   DEFINE ls_e_time     LIKE type_t.chr20
   DEFINE ls_temp_sql   STRING
   DEFINE ls_data_sql   STRING
   DEFINE ls_err_sql    STRING
   DEFINE ls_key        STRING
   DEFINE l_count       LIKE type_t.num10
   DEFINE ls_ooefent    LIKE ooef_t.ooefent   
   DEFINE ls_ooefstus   LIKE ooef_t.ooefstus    
   DEFINE ls_ooef001    LIKE ooef_t.ooef001   
   DEFINE ls_ooef002    LIKE ooef_t.ooef002   
   DEFINE ls_ooef004    LIKE ooef_t.ooef004   
   DEFINE ls_ooef005    LIKE ooef_t.ooef005   
   DEFINE ls_ooef006    LIKE ooef_t.ooef006   
   DEFINE ls_ooef007    LIKE ooef_t.ooef007   
   DEFINE ls_ooef008    LIKE ooef_t.ooef008   
   DEFINE ls_ooef009    LIKE ooef_t.ooef009   
   DEFINE ls_ooef010    LIKE ooef_t.ooef010   
   DEFINE ls_ooef011    LIKE ooef_t.ooef011   
   DEFINE ls_ooef012    LIKE ooef_t.ooef012   
   DEFINE ls_ooef013    LIKE ooef_t.ooef013   
   DEFINE ls_ooefownid  LIKE ooef_t.ooefownid     
   DEFINE ls_ooefowndp  LIKE ooef_t.ooefowndp     
   DEFINE ls_ooefcrtid  LIKE ooef_t.ooefcrtid     
   DEFINE ls_ooefcrtdp  LIKE ooef_t.ooefcrtdp     
   DEFINE ls_ooefcrtdt  LIKE ooef_t.ooefcrtdt     
   DEFINE ls_ooefmodid  LIKE ooef_t.ooefmodid     
   DEFINE ls_ooefmoddt  LIKE ooef_t.ooefmoddt     
   DEFINE ls_ooef014    LIKE ooef_t.ooef014   
   DEFINE ls_ooef015    LIKE ooef_t.ooef015   
   DEFINE ls_ooef016    LIKE ooef_t.ooef016   
   DEFINE ls_ooef017    LIKE ooef_t.ooef017   
   DEFINE ls_ooef018    LIKE ooef_t.ooef018   
   DEFINE ls_ooef019    LIKE ooef_t.ooef019   
   DEFINE ls_ooef020    LIKE ooef_t.ooef020   
   DEFINE ls_ooef021    LIKE ooef_t.ooef021   
   DEFINE ls_ooef022    LIKE ooef_t.ooef022   
   DEFINE ls_ooef003    LIKE ooef_t.ooef003   
   DEFINE ls_ooef023    LIKE ooef_t.ooef023   
   DEFINE ls_ooef024    LIKE ooef_t.ooef024   
   DEFINE ls_ooef025    LIKE ooef_t.ooef025   
   DEFINE ls_ooef026    LIKE ooef_t.ooef026   
   DEFINE ls_ooef100    LIKE ooef_t.ooef100   
   DEFINE ls_ooef101    LIKE ooef_t.ooef101   
   DEFINE ls_ooef102    LIKE ooef_t.ooef102   
   DEFINE ls_ooef103    LIKE ooef_t.ooef103   
   DEFINE ls_ooef104    LIKE ooef_t.ooef104   
   DEFINE ls_ooef105    LIKE ooef_t.ooef105   
   DEFINE ls_ooef106    LIKE ooef_t.ooef106   
   DEFINE ls_ooef107    LIKE ooef_t.ooef107   
   DEFINE ls_ooef108    LIKE ooef_t.ooef108   
   DEFINE ls_ooef109    LIKE ooef_t.ooef109   
   DEFINE ls_ooef110    LIKE ooef_t.ooef110   
   DEFINE ls_ooef111    LIKE ooef_t.ooef111   
   DEFINE ls_ooef112    LIKE ooef_t.ooef112   
   DEFINE ls_ooef113    LIKE ooef_t.ooef113   
   DEFINE ls_ooef114    LIKE ooef_t.ooef114   
   DEFINE ls_ooef115    LIKE ooef_t.ooef115   
   DEFINE ls_ooef120    LIKE ooef_t.ooef120   
   DEFINE ls_ooef121    LIKE ooef_t.ooef121   
   DEFINE ls_ooef122    LIKE ooef_t.ooef122   
   DEFINE ls_ooef123    LIKE ooef_t.ooef123   
   DEFINE ls_ooef124    LIKE ooef_t.ooef124   
   DEFINE ls_ooef125    LIKE ooef_t.ooef125   
   DEFINE ls_ooef150    LIKE ooef_t.ooef150   
   DEFINE ls_ooef151    LIKE ooef_t.ooef151   
   DEFINE ls_ooef152    LIKE ooef_t.ooef152   
   DEFINE ls_ooef153    LIKE ooef_t.ooef153   
   DEFINE ls_ooef154    LIKE ooef_t.ooef154   
   DEFINE ls_ooef155    LIKE ooef_t.ooef155   
   DEFINE ls_ooef156    LIKE ooef_t.ooef156   
   DEFINE ls_ooef157    LIKE ooef_t.ooef157   
   DEFINE ls_ooef158    LIKE ooef_t.ooef158   
   DEFINE ls_ooef159    LIKE ooef_t.ooef159   
   DEFINE ls_ooef160    LIKE ooef_t.ooef160   
   DEFINE ls_ooef161    LIKE ooef_t.ooef161   
   DEFINE ls_ooef162    LIKE ooef_t.ooef162   
   DEFINE ls_ooef163    LIKE ooef_t.ooef163   
   DEFINE ls_ooef164    LIKE ooef_t.ooef164   
   DEFINE ls_ooef165    LIKE ooef_t.ooef165   
   DEFINE ls_ooef166    LIKE ooef_t.ooef166   
   DEFINE ls_ooef167    LIKE ooef_t.ooef167   
   DEFINE ls_ooef168    LIKE ooef_t.ooef168   
   DEFINE ls_ooef169    LIKE ooef_t.ooef169   
   DEFINE ls_ooef170    LIKE ooef_t.ooef170   
   DEFINE ls_ooef171    LIKE ooef_t.ooef171   
   DEFINE ls_ooef172    LIKE ooef_t.ooef172   
   DEFINE ls_ooef173    LIKE ooef_t.ooef173   
   DEFINE ls_ooefunit   LIKE ooef_t.ooefunit    
   DEFINE ls_ooef200    LIKE ooef_t.ooef200   
   DEFINE ls_ooef201    LIKE ooef_t.ooef201   
   DEFINE ls_ooef202    LIKE ooef_t.ooef202   
   DEFINE ls_ooef203    LIKE ooef_t.ooef203   
   DEFINE ls_ooef204    LIKE ooef_t.ooef204   
   DEFINE ls_ooef205    LIKE ooef_t.ooef205   
   DEFINE ls_ooef206    LIKE ooef_t.ooef206   
   DEFINE ls_ooef207    LIKE ooef_t.ooef207   
   DEFINE ls_ooef208    LIKE ooef_t.ooef208   
   DEFINE ls_ooef209    LIKE ooef_t.ooef209   
   DEFINE ls_ooef210    LIKE ooef_t.ooef210   
   DEFINE ls_ooef211    LIKE ooef_t.ooef211   
   DEFINE ls_ooef212    LIKE ooef_t.ooef212   
   DEFINE ls_ooef213    LIKE ooef_t.ooef213   
   DEFINE ls_ooef214    LIKE ooef_t.ooef214   
   DEFINE ls_ooef215    LIKE ooef_t.ooef215   
   DEFINE ls_ooef216    LIKE ooef_t.ooef216   
   DEFINE ls_ooef217    LIKE ooef_t.ooef217   
   DEFINE ls_ooef301    LIKE ooef_t.ooef301   
   DEFINE ls_ooef302    LIKE ooef_t.ooef302   
   DEFINE ls_ooef303    LIKE ooef_t.ooef303   
   DEFINE ls_ooef304    LIKE ooef_t.ooef304   
   DEFINE ls_ooef305    LIKE ooef_t.ooef305   
   DEFINE ls_ooef306    LIKE ooef_t.ooef306   
   DEFINE ls_ooef307    LIKE ooef_t.ooef307   
   DEFINE ls_ooef308    LIKE ooef_t.ooef308   
   DEFINE ls_ooef309    LIKE ooef_t.ooef309   
   DEFINE ls_ooef310    LIKE ooef_t.ooef310   
   DEFINE ls_ooef126    LIKE ooef_t.ooef126   
   DEFINE ls_ooef127    LIKE ooef_t.ooef127   
   DEFINE ls_ooef128    LIKE ooef_t.ooef128   
   DEFINE ls_ooef116    LIKE ooef_t.ooef116  
   DEFINE ls_ooefl002   LIKE ooefl_t.ooefl002
   DEFINE ls_ooefl003   LIKE ooefl_t.ooefl003 
   DEFINE ls_oofb011    LIKE oofb_t.oofb011  
   DEFINE ls_oofc012    LIKE oofc_t.oofc012   
   DEFINE ls_trantime   LIKE type_t.chr20
   DEFINE ls_status     LIKE type_t.chr10
   DEFINE ls_erpold_stus LIKE type_t.chr10
   DEFINE ls_tran_status LIKE type_t.chr2
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
#  DECLARE awsp610_process_cs CURSOR FROM ls_sql
#  FOREACH awsp610_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_middb = cl_eai_get_middb(g_dbs)
   SELECT TO_CHAR(SYSDATE-1,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_s_time FROM dual
   SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_e_time FROM dual
   #DISPLAY 'g_master.wc:',lc_param.wc
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   
   #建立TEMP TABLE
   DROP TABLE ooef_temp
   LET ls_temp_sql = "CREATE GLOBAL TEMPORARY TABLE ooef_temp ",
                     "AS SELECT * FROM ",ls_middb CLIPPED,".tra_ooef_t WHERE 1 = 0"
   EXECUTE IMMEDIATE ls_temp_sql
   
   #把這次要轉的資料依KEY值取唯一先抓到TEMP TABLE
   LET ls_sql = "INSERT INTO ooef_temp ",  
               "SELECT tra.ooefent,tra.ooef001,tra.ooefmodid,tra.status,tra.erpold_stus,tra.tran_status,tra.tran_time,tra.ooef203 ",
               "FROM ",ls_middb CLIPPED,".tra_ooef_t tra, ", 
               "(SELECT ooefent,ooef001,max(tran_time) tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_ooef_t a ",
               "WHERE NOT EXISTS (",
               	 "SELECT 'x' ",
               	 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
               	 "WHERE wseh001 = 'tra_ooef_t'", 
               	 "   AND wseh002 = a.tran_time", 
               	 "   AND wseh004 = 'awsp610'",
               	 "   AND wseh003 = trim(a.ooefent)||'|'||trim(a.ooef001))",
               " AND a.tran_time < '",ls_e_time CLIPPED,"'",
               " AND a.tran_time > '",ls_s_time CLIPPED,"'",
               " AND ",lc_param.wc,     
               " GROUP BY ooefent,ooef001 ) d_tra",
               " WHERE tra.ooefent = d_tra.ooefent",
               " AND tra.ooef001 = d_tra.ooef001",
               " AND tra.tran_time = d_tra.tran_time"
             #DISPLAY 'ls_sql:',ls_sql  
   EXECUTE IMMEDIATE ls_sql            
   
   #select count(*) into l_count1 from ooef_temp
   #DISPLAY 'l_count1:',l_count1
   
   #組出判斷all_ooef_t是否有同樣待轉資料的語法
   LET ls_sql = "SELECT count(1) ",  
               "FROM ",ls_middb CLIPPED,".all_ooef_t a ",
               "WHERE NOT EXISTS ( ",
                      "SELECT 'x'", 
                      "  FROM ",ls_middb CLIPPED,".m_wsee_t", 
                      " WHERE wsee002 = a.tran_time", 
                      "   AND wsee003 = trim(a.ooefent)||'|'||trim(a.ooef001))",
               "  AND a.ooefent = ?",
               "  AND a.ooef001 = ?" 
      #DISPLAY 'ls_count_sql:',ls_sql          
   PREPARE sql_chk_count FROM ls_sql

   #把資料先抓出來
   LET ls_data_sql ="SELECT ooef_t.ooefstus,ooef_t.ooef002,",
   "ooef_t.ooef004,ooef_t.ooef005,ooef_t.ooef006,ooef_t.ooef007,ooef_t.ooef008,",
   "ooef_t.ooef009,ooef_t.ooef010,ooef_t.ooef011,ooef_t.ooef012,ooef_t.ooef013,",
   "ooef_t.ooefownid,ooef_t.ooefowndp,ooef_t.ooefcrtid,ooef_t.ooefcrtdp,ooef_t.ooefcrtdt,",
   "ooef_t.ooefmodid,ooef_t.ooefmoddt,",
   "ooef_t.ooef014,ooef_t.ooef015,ooef_t.ooef016,ooef_t.ooef017,ooef_t.ooef018,",
   "ooef_t.ooef019,ooef_t.ooef020,ooef_t.ooef021,ooef_t.ooef022,ooef_t.ooef003,",
   "ooef_t.ooef023,ooef_t.ooef024,ooef_t.ooef025,ooef_t.ooef026,ooef_t.ooef100,",
   "ooef_t.ooef101,ooef_t.ooef102,ooef_t.ooef103,ooef_t.ooef104,ooef_t.ooef105,",
   "ooef_t.ooef106,ooef_t.ooef107,ooef_t.ooef108,ooef_t.ooef109,ooef_t.ooef110,",
   "ooef_t.ooef111,ooef_t.ooef112,ooef_t.ooef113,ooef_t.ooef114,ooef_t.ooef115,",
   "ooef_t.ooef120,ooef_t.ooef121,ooef_t.ooef122,ooef_t.ooef123,ooef_t.ooef124,",
   "ooef_t.ooef125,ooef_t.ooef150,ooef_t.ooef151,ooef_t.ooef152,ooef_t.ooef153,",
   "ooef_t.ooef154,ooef_t.ooef155,ooef_t.ooef156,ooef_t.ooef157,ooef_t.ooef158,",
   "ooef_t.ooef159,ooef_t.ooef160,ooef_t.ooef161,ooef_t.ooef162,ooef_t.ooef163,",
   "ooef_t.ooef164,ooef_t.ooef165,ooef_t.ooef166,ooef_t.ooef167,ooef_t.ooef168,",
   "ooef_t.ooef169,ooef_t.ooef170,ooef_t.ooef171,ooef_t.ooef172,ooef_t.ooef173,",
   "ooef_t.ooefunit,",
   "ooef_t.ooef200,ooef_t.ooef201,ooef_t.ooef202,tra.ooef203,ooef_t.ooef204,",
   "ooef_t.ooef205,ooef_t.ooef206,ooef_t.ooef207,ooef_t.ooef208,ooef_t.ooef209,",
   "ooef_t.ooef210,ooef_t.ooef211,ooef_t.ooef212,ooef_t.ooef213,ooef_t.ooef214,",
   "ooef_t.ooef215,ooef_t.ooef216,ooef_t.ooef217,ooef_t.ooef301,ooef_t.ooef302,",
   "ooef_t.ooef303,ooef_t.ooef304,ooef_t.ooef305,ooef_t.ooef306,ooef_t.ooef307,",
   "ooef_t.ooef308,ooef_t.ooef309,ooef_t.ooef310,ooef_t.ooef126,ooef_t.ooef127,",
   "ooef_t.ooef128,ooef_t.ooef116,",
   "tra.status,tra.erpold_stus,tra.tran_status ",      
   "FROM ooef_temp tra LEFT OUTER JOIN ooef_t ON ",
   " ooef_t.ooefent = tra.ooefent",
   " AND ooef_t.ooef001 = tra.ooef001",
   " WHERE tra.ooefent = ?",
   " AND tra.ooef001 = ?",
   " AND tra.tran_time = ?"
   #DISPLAY 'ls_data_sql:',ls_data_sql
   PREPARE sql_select_data FROM ls_data_sql
   
   #組出最後INSERT all_ooef_t資料的語法 
   LET ls_ins_sql = "INSERT INTO ",ls_middb CLIPPED,".all_ooef_t(",
   "ooefent,ooef001,ooef203,ooefstus,ooef002,",
   "ooef004,ooef005,ooef006,ooef007,ooef008,",
   "ooef009,ooef010,ooef011,ooef012,ooef013,",
   "ooefownid,ooefowndp,ooefcrtid,ooefcrtdp,ooefcrtdt,",
   "ooefmodid,ooefmoddt,",
   "ooef014,ooef015,ooef016,ooef017,ooef018,",
   "ooef019,ooef020,ooef021,ooef022,ooef003,",
   "ooef023,ooef024,ooef025,ooef026,ooef100,",
   "ooef101,ooef102,ooef103,ooef104,ooef105,",
   "ooef106,ooef107,ooef108,ooef109,ooef110,",
   "ooef111,ooef112,ooef113,ooef114,ooef115,",
   "ooef120,ooef121,ooef122,ooef123,ooef124,",
   "ooef125,ooef150,ooef151,ooef152,ooef153,",
   "ooef154,ooef155,ooef156,ooef157,ooef158,",
   "ooef159,ooef160,ooef161,ooef162,ooef163,",
   "ooef164,ooef165,ooef166,ooef167,ooef168,",
   "ooef169,ooef170,ooef171,ooef172,ooef173,",
   "ooefunit,",
   "ooef200,ooef201,ooef202,ooef204,ooef205,",
   "ooef206,ooef207,ooef208,ooef209,ooef210,",
   "ooef211,ooef212,ooef213,ooef214,ooef215,",
   "ooef216,ooef217,ooef301,ooef302,ooef303,",
   "ooef304,ooef305,ooef306,ooef307,ooef308,",
   "ooef309,ooef310,ooef126,ooef127,ooef128,",
   "ooef116,ooefl002,ooefl003,oofb011,oofc012,",
   "status,erpold_stus,tran_status,tran_time) ",
   "VALUES(?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?)"
   #DISPLAY 'ls_ins_sql:',ls_ins_sql
   PREPARE sql_insert_data FROM ls_ins_sql
   
   #組出最後UPDATE all_ooef_t資料的語法                              
   LET ls_upd_sql = "UPDATE ",ls_middb CLIPPED,".all_ooef_t",
                    " SET ooefstus = ?,ooef002 = ?,",
                    "     ooef004 = ?,ooef005 = ?,ooef006 = ?,ooef007 = ?,ooef008 = ?,",
                    "     ooef009 = ?,ooef010 = ?,ooef011 = ?,ooef012 = ?,ooef013 = ?,",
                    "     ooefownid = ?,ooefowndp = ?,ooefmodid = ?,ooefmoddt = ?,",
                    "     ooef014 = ?,ooef015 = ?,ooef016 = ?,ooef017 = ?,ooef018 = ?,",
                    "     ooef019 = ?,ooef020 = ?,ooef021 = ?,ooef022 = ?,ooef003 = ?,",
                    "     ooef023 = ?,ooef024 = ?,ooef025 = ?,ooef026 = ?,ooef100 = ?,",
                    "     ooef101 = ?,ooef102 = ?,ooef103 = ?,ooef104 = ?,ooef105 = ?,",
                    "     ooef106 = ?,ooef107 = ?,ooef108 = ?,ooef109 = ?,ooef110 = ?,",
                    "     ooef111 = ?,ooef112 = ?,ooef113 = ?,ooef114 = ?,ooef115 = ?,",
                    "     ooef120 = ?,ooef121 = ?,ooef122 = ?,ooef123 = ?,ooef124 = ?,",
                    "     ooef125 = ?,ooef150 = ?,ooef151 = ?,ooef152 = ?,ooef153 = ?,",
                    "     ooef154 = ?,ooef155 = ?,ooef156 = ?,ooef157 = ?,ooef158 = ?,",
                    "     ooef159 = ?,ooef160 = ?,ooef161 = ?,ooef162 = ?,ooef163 = ?,",
                    "     ooef164 = ?,ooef165 = ?,ooef166 = ?,ooef167 = ?,ooef168 = ?,",
                    "     ooef169 = ?,ooef170 = ?,ooef171 = ?,ooef172 = ?,ooef173 = ?,",
                    "     ooefunit = ?,",
                    "     ooef200 = ?,ooef201 = ?,ooef202 = ?,ooef203 = ?,ooef204 = ?,",
                    "     ooef205 = ?,ooef206 = ?,ooef207 = ?,ooef208 = ?,ooef209 = ?,",
                    "     ooef210 = ?,ooef211 = ?,ooef212 = ?,ooef213 = ?,ooef214 = ?,",
                    "     ooef215 = ?,ooef216 = ?,ooef217 = ?,ooef301 = ?,ooef302 = ?,",
                    "     ooef303 = ?,ooef304 = ?,ooef305 = ?,ooef306 = ?,ooef307 = ?,",
                    "     ooef308 = ?,ooef309 = ?,ooef310 = ?,ooef126 = ?,ooef127 = ?,",
                    "     ooef128 = ?,ooef116 = ?,",
                    "     ooefl002 = ?,ooefl003 = ?,oofb011 = ?,oofc012 = ?,",
                    "      status = ?,",
                    " erpold_stus = ?,",
                    " tran_status = ? ",
                    " WHERE ooefent = ?",
                    " AND ooef001 = ?",
                    " AND tran_time > ?",
                    " AND tran_time < ?"               
  
   #DISPLAY 'ls_upd_sql:',ls_upd_sql
   PREPARE sql_update_data FROM ls_upd_sql   

   #把TEMP TABLE資料抓出來   
   LET ls_sql = "SELECT ooefent,ooef001,ooef203,tran_time FROM ooef_temp"
   PREPARE sql_select_temptb FROM ls_sql   
   DECLARE sql_fetch_data CURSOR WITH HOLD FOR sql_select_temptb  
   OPEN sql_fetch_data
   FOREACH sql_fetch_data INTO ls_ooefent,ls_ooef001,ls_ooef203,ls_trantime
   
           #DISPLAY 'chk_count:',ls_ooefent,"|",ls_ooef001,"|",ls_trantime               
           #判斷all_ooef_t是否有同樣待轉資料
           EXECUTE sql_chk_count USING ls_ooefent,ls_ooef001 INTO l_count
           
           #先把資料抓出來
           EXECUTE sql_select_data USING ls_ooefent,ls_ooef001,ls_trantime    
              INTO ls_ooefstus,ls_ooef002,
                   ls_ooef004,ls_ooef005,ls_ooef006,ls_ooef007,ls_ooef008,
                   ls_ooef009,ls_ooef010,ls_ooef011,ls_ooef012,ls_ooef013,
                   ls_ooefownid,ls_ooefowndp,ls_ooefcrtid,ls_ooefcrtdp,ls_ooefcrtdt,
                   ls_ooefmodid,ls_ooefmoddt,
                   ls_ooef014,ls_ooef015,ls_ooef016,ls_ooef017,ls_ooef018,
                   ls_ooef019,ls_ooef020,ls_ooef021,ls_ooef022,ls_ooef003,
                   ls_ooef023,ls_ooef024,ls_ooef025,ls_ooef026,ls_ooef100,
                   ls_ooef101,ls_ooef102,ls_ooef103,ls_ooef104,ls_ooef105,
                   ls_ooef106,ls_ooef107,ls_ooef108,ls_ooef109,ls_ooef110,
                   ls_ooef111,ls_ooef112,ls_ooef113,ls_ooef114,ls_ooef115,
                   ls_ooef120,ls_ooef121,ls_ooef122,ls_ooef123,ls_ooef124,
                   ls_ooef125,ls_ooef150,ls_ooef151,ls_ooef152,ls_ooef153,
                   ls_ooef154,ls_ooef155,ls_ooef156,ls_ooef157,ls_ooef158,
                   ls_ooef159,ls_ooef160,ls_ooef161,ls_ooef162,ls_ooef163,
                   ls_ooef164,ls_ooef165,ls_ooef166,ls_ooef167,ls_ooef168,
                   ls_ooef169,ls_ooef170,ls_ooef171,ls_ooef172,ls_ooef173,
                   ls_ooefunit,
                   ls_ooef200,ls_ooef201,ls_ooef202,ls_ooef203,ls_ooef204,
                   ls_ooef205,ls_ooef206,ls_ooef207,ls_ooef208,ls_ooef209,
                   ls_ooef210,ls_ooef211,ls_ooef212,ls_ooef213,ls_ooef214,
                   ls_ooef215,ls_ooef216,ls_ooef217,ls_ooef301,ls_ooef302,
                   ls_ooef303,ls_ooef304,ls_ooef305,ls_ooef306,ls_ooef307,
                   ls_ooef308,ls_ooef309,ls_ooef310,ls_ooef126,ls_ooef127,
                   ls_ooef128,ls_ooef116,
                   ls_status,ls_erpold_stus,ls_tran_status               
           
           SELECT ooefl002,ooefl003 INTO ls_ooefl002,ls_ooefl003 FROM　ooefl_t WHERE ooeflent = ls_ooefent AND ooefl001 = ls_ooef001 AND ooefl002 = g_lang
           SELECT oofb011 INTO ls_oofb011 FROM oofb_t WHERE oofbent = ls_ooefent AND oofb001 = ls_ooef012 
           SELECT oofc012 INTO ls_oofc012 FROM oofc_t WHERE oofcent = ls_ooefent AND oofc001 = ls_ooef012 
           
           #161021 modify 不可空白欄位給一個' ' 161021-00008 -- S --
           IF cl_null(ls_ooef004) THEN LET ls_ooef004 = ' ' END IF
           IF cl_null(ls_ooef005) THEN LET ls_ooef005 = ' ' END IF
           IF cl_null(ls_ooef006) THEN LET ls_ooef006 = ' ' END IF
           IF cl_null(ls_ooef008) THEN LET ls_ooef008 = ' ' END IF
           IF cl_null(ls_ooefl002) THEN LET ls_ooefl002 = ' ' END IF
           #161021 modify 不可空白欄位給一個' ' 161021-00008 -- E --

           #沒同樣資料就INSERT
           IF l_count = 0 THEN

              #執行INSERT動作
              EXECUTE sql_insert_data USING ls_ooefent,ls_ooef001,ls_ooef203,  
                      ls_ooefstus,ls_ooef002,
                      ls_ooef004,ls_ooef005,ls_ooef006,ls_ooef007,ls_ooef008,
                      ls_ooef009,ls_ooef010,ls_ooef011,ls_ooef012,ls_ooef013,
                      ls_ooefownid,ls_ooefowndp,ls_ooefcrtid,ls_ooefcrtdp,ls_ooefcrtdt,
                      ls_ooefmodid,ls_ooefmoddt,
                      ls_ooef014,ls_ooef015,ls_ooef016,ls_ooef017,ls_ooef018,
                      ls_ooef019,ls_ooef020,ls_ooef021,ls_ooef022,ls_ooef003,
                      ls_ooef023,ls_ooef024,ls_ooef025,ls_ooef026,ls_ooef100,
                      ls_ooef101,ls_ooef102,ls_ooef103,ls_ooef104,ls_ooef105,
                      ls_ooef106,ls_ooef107,ls_ooef108,ls_ooef109,ls_ooef110,
                      ls_ooef111,ls_ooef112,ls_ooef113,ls_ooef114,ls_ooef115,
                      ls_ooef120,ls_ooef121,ls_ooef122,ls_ooef123,ls_ooef124,
                      ls_ooef125,ls_ooef150,ls_ooef151,ls_ooef152,ls_ooef153,
                      ls_ooef154,ls_ooef155,ls_ooef156,ls_ooef157,ls_ooef158,
                      ls_ooef159,ls_ooef160,ls_ooef161,ls_ooef162,ls_ooef163,
                      ls_ooef164,ls_ooef165,ls_ooef166,ls_ooef167,ls_ooef168,
                      ls_ooef169,ls_ooef170,ls_ooef171,ls_ooef172,ls_ooef173,
                      ls_ooefunit,
                      ls_ooef200,ls_ooef201,ls_ooef202,ls_ooef204,ls_ooef205,
                      ls_ooef206,ls_ooef207,ls_ooef208,ls_ooef209,ls_ooef210,
                      ls_ooef211,ls_ooef212,ls_ooef213,ls_ooef214,ls_ooef215,
                      ls_ooef216,ls_ooef217,ls_ooef301,ls_ooef302,ls_ooef303,
                      ls_ooef304,ls_ooef305,ls_ooef306,ls_ooef307,ls_ooef308,
                      ls_ooef309,ls_ooef310,ls_ooef126,ls_ooef127,ls_ooef128,
                      ls_ooef116,ls_ooefl002,ls_ooefl003,ls_oofb011,ls_oofc012,
                      ls_status,ls_erpold_stus,ls_tran_status,ls_trantime

              DISPLAY 'insert:',ls_ooefent,"|",ls_ooef001,"|",ls_status,"|",ls_trantime              
           ELSE
              #有待轉資料就UPDATE
                                  
              #執行UPDATE動作
              EXECUTE sql_update_data USING ls_ooefstus,ls_ooef002,
                      ls_ooef004,ls_ooef005,ls_ooef006,ls_ooef007,ls_ooef008,
                      ls_ooef009,ls_ooef010,ls_ooef011,ls_ooef012,ls_ooef013,
                      ls_ooefownid,ls_ooefowndp,ls_ooefmodid,ls_ooefmoddt,
                      ls_ooef014,ls_ooef015,ls_ooef016,ls_ooef017,ls_ooef018,
                      ls_ooef019,ls_ooef020,ls_ooef021,ls_ooef022,ls_ooef003,
                      ls_ooef023,ls_ooef024,ls_ooef025,ls_ooef026,ls_ooef100,
                      ls_ooef101,ls_ooef102,ls_ooef103,ls_ooef104,ls_ooef105,
                      ls_ooef106,ls_ooef107,ls_ooef108,ls_ooef109,ls_ooef110,
                      ls_ooef111,ls_ooef112,ls_ooef113,ls_ooef114,ls_ooef115,
                      ls_ooef120,ls_ooef121,ls_ooef122,ls_ooef123,ls_ooef124,
                      ls_ooef125,ls_ooef150,ls_ooef151,ls_ooef152,ls_ooef153,
                      ls_ooef154,ls_ooef155,ls_ooef156,ls_ooef157,ls_ooef158,
                      ls_ooef159,ls_ooef160,ls_ooef161,ls_ooef162,ls_ooef163,
                      ls_ooef164,ls_ooef165,ls_ooef166,ls_ooef167,ls_ooef168,
                      ls_ooef169,ls_ooef170,ls_ooef171,ls_ooef172,ls_ooef173,
                      ls_ooefunit,
                      ls_ooef200,ls_ooef201,ls_ooef202,ls_ooef203,ls_ooef204,
                      ls_ooef205,ls_ooef206,ls_ooef207,ls_ooef208,ls_ooef209,
                      ls_ooef210,ls_ooef211,ls_ooef212,ls_ooef213,ls_ooef214,
                      ls_ooef215,ls_ooef216,ls_ooef217,ls_ooef301,ls_ooef302,
                      ls_ooef303,ls_ooef304,ls_ooef305,ls_ooef306,ls_ooef307,
                      ls_ooef308,ls_ooef309,ls_ooef310,ls_ooef126,ls_ooef127,
                      ls_ooef128,ls_ooef116,  
                      ls_ooefl002,ls_ooefl003,ls_oofb011,ls_oofc012,                      
                      ls_status,ls_erpold_stus,ls_tran_status,
                      ls_ooefent,ls_ooef001,ls_s_time,ls_e_time
              DISPLAY 'update:',ls_ooefent,"|",ls_ooef001,"|",ls_status,"|",ls_trantime                      
           END IF
           
           IF SQLCA.SQLCODE THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE 
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              
              #先把key值欄位組出來
              LET ls_key = ls_ooefent CLIPPED,'|',ls_ooef001             
              #把錯誤寫入m_wsei_t
              LET ls_err_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wsei_t ",
                               "(wsei001,wsei002,wsei003,wsei004,wsei005,wsei006,wsei007) ",
                               "VALUES('tra_ooef_t','",ls_trantime CLIPPED,"','",ls_key CLIPPED,"',",
                               "'awsp610','",ls_e_time,"','",SQLCA.SQLCODE,"','",SQLERRMESSAGE,"')"
              EXECUTE IMMEDIATE ls_err_sql                 
              #DISPLAY 'ls_err_sql:',ls_err_sql                
              CALL cl_err()
               
           ELSE
              #寫入all_ooef_t後依KEY值條件把所有待轉的記錄寫入m_wseh_t      
               LET ls_wseh_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wseh_t ",
                                 "SELECT 'tra_ooef_t',a.tran_time,trim(a.ooefent)||'|'||trim(a.ooef001),'awsp610' ",
                                 "FROM ",ls_middb CLIPPED,".tra_ooef_t a ",
                                 "WHERE NOT EXISTS (",
                                 "SELECT 'x' ",
                                 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
                                 "WHERE wseh001 = 'tra_ooef_t'", 
                                 "   AND wseh002 = a.tran_time", 
                                 "   AND wseh004 = 'awsp610'",
                                 "   AND wseh003 = trim(a.ooefent)||'|'||trim(a.ooef001))", 
                                 " AND a.ooefent = ",ls_ooefent CLIPPED,
                                 " AND a.ooef001 = '",ls_ooef001 CLIPPED,"'",
                                 " AND a.tran_time < '",ls_e_time CLIPPED,"'",
                                 " AND a.tran_time > '",ls_s_time CLIPPED,"'"
               #DISPLAY 'ls_wseh_sql:',ls_wseh_sql                  
               EXECUTE IMMEDIATE ls_wseh_sql
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()         
         
               END IF 

           END IF
   
   END FOREACH
  
   FREE sql_chk_count
   FREE sql_select_data
   FREE sql_select_temptb
   FREE sql_fetch_data
   FREE sql_insert_data
   FREE sql_update_data
   DROP TABLE ooef_temp 
   CALL s_transaction_end('Y','0')
   CALL cl_err_collect_show()
      
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      #完成%數
      LET li_count = 100
      DISPLAY li_count TO FORMONLY.stagecomplete
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL awsp610_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp610.get_buffer" >}
PRIVATE FUNCTION awsp610_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsp610.msgcentre_notify" >}
PRIVATE FUNCTION awsp610_msgcentre_notify()
 
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
 
{<section id="awsp610.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
