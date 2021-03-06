#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-07-01 10:00:50), PR版次:0015(2017-05-07 23:09:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000118
#+ Filename...: ainp110
#+ Description: 庫存月結計算作業
#+ Creator....: 02295(2014-06-26 10:05:44)
#+ Modifier...: 02295 -SD/PR- TOPSTD
 
{</section>}
 
{<section id="ainp110.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160311-00022#1  2016/03/11 By xianghui 本期入庫統計量/本期銷貨統計量/本期領用統計量/本期轉撥統計量/本期調整統計量的计算，代码调整
#160419-00020#1  2016/04/19 By Ann_Huang  調整 inat015,inat021 小數統一在最後取位
#160620-00006#1  2016/06/20 By xianghui   調整 inat015,inat021在INSERT段的小數取位
#161107-00010#1  2016/11/08 By 02295      效能优化
#161122-00004#1  2016/11/22 By 02295      对每一笔数据进行小數取位
#161122-00042#1  2016/11/23 By 02295      将小数取位整合到sql中执行
#161123-00061#1  2016/11/25 By 02295      最新效能优化，如需追单到客户家此单之前的modify无需追单
#161212-00017#1  2016/12/13 By 02295      小数取位调整
#170210-00058#1  2017/02/13 By wuxja      p110_ins_inat1的SQL缺少inat007=inaj045的条件，需补上
#170314-00018#1  2017/03/14 By lixh       INSERT INTO inau_t出错
#170324-00036#1  2017/03/28 By liuym      inaj_t、inal_t 关联字段错误，应该为inaj004=inal005
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
       imaa001 LIKE imaa_t.imaa001, 
   imaa009 LIKE imaa_t.imaa009, 
   glav002 LIKE glav_t.glav002, 
   glav006 LIKE glav_t.glav006, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_stagecomplete LIKE type_t.num10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainp110.main" >}
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
      CALL ainp110_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp110 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp110_init()
 
      #進入選單 Menu (="N")
      CALL ainp110_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp110
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp110.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp110_init()
 
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
   CALL ainp110_get_glaa003()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp110.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp110_ui_dialog()
 
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
   LET g_master.glav002 = ''
   LET g_master.glav006 = ''
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glav002,g_master.glav006 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav002
            #add-point:BEFORE FIELD glav002 name="input.b.glav002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav002
            
            #add-point:AFTER FIELD glav002 name="input.a.glav002"
            IF NOT cl_null(g_master.glav002) THEN 
               IF NOT s_fin_date_chk_year(g_master.glav002) THEN 
                  NEXT FIELD glav002
               END IF
            END IF
            IF NOT cl_null(g_master.glav002) AND NOT cl_null(g_master.glav006) THEN 
               IF NOT s_fin_date_chk_period(g_glaa003,g_master.glav002,g_master.glav006) THEN 
                  NEXT FIELD glav002
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav002
            #add-point:ON CHANGE glav002 name="input.g.glav002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav006
            #add-point:BEFORE FIELD glav006 name="input.b.glav006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav006
            
            #add-point:AFTER FIELD glav006 name="input.a.glav006"
            IF NOT cl_null(g_master.glav002) AND NOT cl_null(g_master.glav006) THEN 
               IF NOT s_fin_date_chk_period(g_glaa003,g_master.glav002,g_master.glav006) THEN 
                  NEXT FIELD glav006
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav006
            #add-point:ON CHANGE glav006 name="input.g.glav006"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glav002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav002
            #add-point:ON ACTION controlp INFIELD glav002 name="input.c.glav002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav006
            #add-point:ON ACTION controlp INFIELD glav006 name="input.c.glav006"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa001,imaa009
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_2()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
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
            CALL ainp110_get_buffer(l_dialog)
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
         CALL ainp110_init()
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
                 CALL ainp110_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp110_transfer_argv(ls_js)
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
 
{<section id="ainp110.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp110_transfer_argv(ls_js)
 
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
 
{<section id="ainp110.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp110_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
#161212-00017#1---mark----s
#   DEFINE l_count    LIKE type_t.num10
#   DEFINE l_bdate     LIKE type_t.dat
#   DEFINE l_edate     LIKE type_t.dat
#   DEFINE l_inat      RECORD LIKE inat_t.*  
#   DEFINE n_inat      RECORD LIKE inat_t.*  
#   DEFINE l_inau      RECORD LIKE inau_t.*  
#   DEFINE n_inau      RECORD LIKE inau_t.*  
#   DEFINE l_success   LIKE type_t.num5
#   DEFINE l_inat015   LIKE inat_t.inat015,
#          l_inat021   LIKE inat_t.inat021,
#          l_glav002   LIKE glav_t.glav002,
#          l_glav006   LIKE glav_t.glav006,
#          l_inaj004   LIKE inaj_t.inaj004,
#          l_inaj011   LIKE inaj_t.inaj011,
#          l_inaj013   LIKE inaj_t.inaj013,
#          l_inaj027   LIKE inaj_t.inaj027,
#          l_inaj036   LIKE inaj_t.inaj036,
#          l_inai007   LIKE inai_t.inai007,
#          l_inai008   LIKE inai_t.inai008,
#          l_inau017   LIKE inau_t.inau017,
#          l_inal014   LIKE inal_t.inal014,
#          l_imaf071   LIKE imaf_t.imaf071,
#          l_imaf081   LIKE imaf_t.imaf081,
#          l_inab008   LIKE inab_t.inab008
#   DEFINE l_inaj012   LIKE inaj_t.inaj012
##   DEFINE l_imaf054   LIKE imaf_t.imaf054   #150325---earl---mark
##150325---earl---add---s
#   DEFINE l_inaj045   LIKE inaj_t.inaj045
#   DEFINE l_inaj046   LIKE inaj_t.inaj046
#   DEFINE l_inaj047   LIKE inaj_t.inaj047
#   DEFINE l_inaj026   LIKE inaj_t.inaj026
##150325---earl---add---e
#   #161122-00004#1--add--s
#   DEFINE l_inau012   LIKE inau_t.inau012,
#          l_inau013   LIKE inau_t.inau013,
#          l_inau014   LIKE inau_t.inau014,
#          l_inau015   LIKE inau_t.inau015,
#          l_inau016   LIKE inau_t.inau016,
#          l_inat010   LIKE inat_t.inat010,
#          l_inat011   LIKE inat_t.inat011,
#          l_inat012   LIKE inat_t.inat012,
#          l_inat013   LIKE inat_t.inat013,
#          l_inat014   LIKE inat_t.inat014,
#          l_inat016   LIKE inat_t.inat016,
#          l_inat017   LIKE inat_t.inat017,
#          l_inat018   LIKE inat_t.inat018,
#          l_inat019   LIKE inat_t.inat019,
#          l_inat020   LIKE inat_t.inat020 
#   #161122-00004#1--add--e
#161212-00017#1---mark----s
   
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
#  DECLARE ainp110_process_cs CURSOR FROM ls_sql
#  FOREACH ainp110_process_cs INTO
   #add-point:process段process name="process.process"
   
   #161123-00061#1---add---s
   CALL ainp110_process_new()  
   RETURN 
   #161123-00061#1---add---e
#161212-00017#1---mark----s
#   
#   CALL s_transaction_begin()       
#   
#   ##抓取期別起迄日期
#   CALL s_fin_date_get_period_range(g_glaa003,g_master.glav002,g_master.glav006) RETURNING l_bdate,l_edate
#
##150325---earl---mod---s
##   LET g_sql = "SELECT inaj004,inaj011,inaj013,inaj027,inaj036 ",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =?",
##               "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
##   PREPARE p110_per2 FROM g_sql 
##   DECLARE p110_cur2 CURSOR FOR p110_per2 
#
##     LET g_sql = "SELECT inaj004,inaj011,inaj013,inaj027,inaj036 ",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =? AND inaj012=?",
##               "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
##   PREPARE p110_per22 FROM g_sql 
##   DECLARE p110_cur22 CURSOR FOR p110_per22
#     
#   
#   #161107-00010#1---mod---s               
#   #LET g_sql = "SELECT inaj004,inaj011,inaj013,inaj027,inaj036,",
#   #            "       inaj046,inaj047,",
#   #            "       inaj026",           #150416---earl---add
#   #            "  FROM inaj_t ",
#   #            " WHERE inajent = '",g_enterprise,"'",
#   #            "   AND inajsite = '",g_site,"'",
#   #            "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =? AND inaj045=?",
#   #            "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
#   #            
##161122-00004#1---mark---s
##   LET g_sql = "SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM(COALESCE(inaj011*inaj046/inaj047*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM(COALESCE(inaj027*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM(COALESCE(inaj011*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM(COALESCE(inaj027*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM(COALESCE(inaj011*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM(COALESCE(inaj027*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM(COALESCE(inaj011*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM(COALESCE(inaj027*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM(COALESCE(inaj011*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM(COALESCE(inaj027*inaj004,0)) END",
##               "  FROM inaj_t ",
##               " WHERE inajent = '",g_enterprise,"'",
##               "   AND inajsite = '",g_site,"'",
##               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =? AND inaj045=?",
##               "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
##               " GROUP BY inaj036 "                
##   #161107-00010#1---mod---e               
##161122-00004#1---mark---e
#   #161122-00042#1---mark---s
#   ##161122-00004#1---add---s
#   #LET g_sql = "SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN COALESCE(inaj011*inaj046/inaj047*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='1' THEN COALESCE(inaj027*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN COALESCE(inaj011*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN COALESCE(inaj027*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN COALESCE(inaj011*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN COALESCE(inaj027*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN COALESCE(inaj011*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN COALESCE(inaj027*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN COALESCE(inaj011*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN COALESCE(inaj027*inaj004,0) END,inaj026",
#   #            "  FROM inaj_t ",
#   #            " WHERE inajent = '",g_enterprise,"'",
#   #            "   AND inajsite = '",g_site,"'",
#   #            "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =? AND inaj045=?",
#   #            "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#   #            " ORDER BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045 "     
#   ##161122-00004#1---add---e
#   #161122-00042#1---mark---e
#   #161122-00042#1---add---s
#   LET g_sql = " SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                         WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                        ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                    END )",
#               "                                                         WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                         WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                     END ))",
#               "         END a,",
#               "        CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                         WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                        ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                    END )",
#               "                                                         WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                         WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                     END ))",
#               "         END a1,",
#               "        CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                          WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                          WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                      END ))",
#               "          END b,",
#               "         CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                          WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                          WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                      END ))",
#               "          END b1,",
#               "        CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                          WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                          WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                      END ))",
#               "          END c,",
#               "         CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                          WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                          WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                      END ))",
#               "          END c1,", 
#               "        CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                          WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                          WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                      END ))",
#               "          END d,",
#               "         CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                          WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                          WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                      END ))",
#               "          END d1,",  
#               "        CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                          WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                          WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                      END ))",
#               "          END e,",
#               "         CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                          WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                         ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                     END )",
#               "                                                          WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                          WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                      END ))",
#               "          END e1",               
#               "  FROM inaj_t ",
#               "  LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
#               "  LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
#               " WHERE inajent = '",g_enterprise,"'",
#               "   AND inajsite = '",g_site,"'",
#               "   AND inaj005 =? AND inaj006 =? AND inaj007 =? AND inaj008 =? AND inaj009 = ? AND inaj010 =? AND inaj045=?",
#               "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               " GROUP BY inaj036 "     
#   #161122-00042#1---add---e
#   PREPARE p110_per2 FROM g_sql 
#   DECLARE p110_cur2 CURSOR FOR p110_per2 
##150325---earl---mod---e 
#   
#   LET g_sql = "SELECT * FROM inat_t ",  
#               " WHERE inatent = '",g_enterprise,"'",
#               "   AND inatsite = '",g_site,"'",
#               "   AND inat001 =? AND inat002 =? AND inat003 =? AND inat004 =? AND inat005 =?",
#               "   AND inat006 =? AND inat007 =? ",
#               "   AND (inat008 > ",g_master.glav002," OR (inat008 = ",g_master.glav002," AND inat009 > ",g_master.glav006,"))",
#               " ORDER BY inat008,inat009 "
#   PREPARE p110_pre3 FROM g_sql
#   DECLARE p110_cur3 CURSOR FOR p110_pre3   
#   
#   LET g_sql = "SELECT DISTINCT inai007,inai008 FROM inai_t ",
#               " WHERE inaient = '",g_enterprise,"'",
#               "   AND inaisite = '",g_site,"'",
#               "   AND inai001=? AND inai002=? AND inai003=? AND inai004=? AND inai005=? AND inai006=? AND inai009=?"
#   PREPARE p110_pre4 FROM g_sql
#   DECLARE p110_cur4 CURSOR FOR p110_pre4
#   
##150325---earl---mod---s         
##   LET g_sql = "SELECT inaj004,inal014,inaj013,inaj036 ",
##               "  FROM inaj_t,inal_t ",
##               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
##               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
##               "   AND inalent = '",g_enterprise,"'",
##               "   AND inalsite = '",g_site,"'",
##               "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
##               "   AND inal011 =? AND inal012 =? AND inal013 =? ",
##               "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
##   PREPARE p110_pre5 FROM g_sql
##   DECLARE p110_cur5 CURSOR FOR p110_pre5
#
##   LET g_sql = "SELECT inaj004,inal014,inaj013,inaj036 ",
##               "  FROM inaj_t,inal_t ",
##               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
##               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
##               "   AND inalent = '",g_enterprise,"'",
##               "   AND inalsite = '",g_site,"'",
##               "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
##               "   AND inal011 =? AND inal012 =? AND inal013 =? AND inaj012 = ? ",
##               "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
##   PREPARE p110_pre52 FROM g_sql
##   DECLARE p110_cur52 CURSOR FOR p110_pre52
#
#   #161107-00010#1---mod---s
#   #LET g_sql = "SELECT inaj004,inal014,inaj013,inaj036,",
#   #            "       inaj046,inaj047",
#   #            "  FROM inaj_t,inal_t ",
#   #            " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
#   #            "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
#   #            "   AND inalent = '",g_enterprise,"'",
#   #            "   AND inalsite = '",g_site,"'",
#   #            "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
#   #            "   AND inal011 =? AND inal012 =? AND inal013 =? AND inaj045 = ? ",
#   #            "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'"
##161122-00004#1---mark---e            
##   LET g_sql = "SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM(COALESCE(inal014*inaj046/inaj047*inaj004,0)) END,",
##               "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM(COALESCE(inal014*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM(COALESCE(inal014*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM(COALESCE(inal014*inaj046/inaj047*inaj004,0)) END,",   
##               "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM(COALESCE(inal014*inaj046/inaj047*inaj004,0)) END",   
##               "  FROM inaj_t,inal_t ",
##               " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
##               "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
##               "   AND inalent = '",g_enterprise,"'",
##               "   AND inalsite = '",g_site,"'",
##               "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
##               "   AND inal011 =? AND inal012 =? AND inal013 =? AND inaj045 = ? ",
##               "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'" ,
##               " GROUP BY inaj036 "               
##   #161107-00010#1---mod---e
##161122-00004#1---mark---e            
#   #161122-00042#1---mark---s 
#   ##161122-00004#1---add---s            
#   #LET g_sql = "SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN COALESCE(inal014*inaj046/inaj047*inaj004,0) END,",
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='2' THEN COALESCE(inal014*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='3' THEN COALESCE(inal014*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='4' THEN COALESCE(inal014*inaj046/inaj047*inaj004,0) END,",   
#   #            "       CASE WHEN SUBSTR(inaj036,1,1)='5' THEN COALESCE(inal014*inaj046/inaj047*inaj004,0) END",   
#   #            "  FROM inaj_t,inal_t ",
#   #            " WHERE inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
#   #            "   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
#   #            "   AND inalent = '",g_enterprise,"'",
#   #            "   AND inalsite = '",g_site,"'",
#   #            "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
#   #            "   AND inal011 =? AND inal012 =? AND inal013 =? AND inaj045 = ? ",
#   #            "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'" ,
#   #            " ORDER BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045 " 
#   ##161122-00004#1---add---e            
#   #161122-00042#1---mark---e 
#   #161122-00042#1---add---s 
#   LET g_sql = " SELECT CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                         WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                      ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                  END )",
#               "                                                         WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                         WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                     END ))",  
#               "         END a,",                                              
#               "        CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                         WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                      ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                  END )",
#               "                                                         WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                         WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                      END ))",
#               "          END b,",                                             
#               "        CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                         WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                      ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                  END )",
#               "                                                         WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                         WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                      END ))",
#               "          END c,",                                             
#               "        CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                         WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                      ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                  END )",
#               "                                                         WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                         WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                      END ))",
#               "          END d,",                                             
#               "        CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                         WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                      ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                  END )",
#               "                                                         WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                         WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                      END ))",
#               "          END e",               
#               "  FROM inaj_t ",
#               "  LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
#               "  INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
#               "                   AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
#               " WHERE inalent = '",g_enterprise,"'",
#               "   AND inalsite = '",g_site,"'",
#               "   AND inal006 =? AND inal007 =? AND inal008 =? AND inal009 = ? AND inal010 =? ",
#               "   AND inal011 =? AND inal012 =? AND inal013 =? AND inaj045 = ? ",
#               "   AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'" ,
#               " GROUP BY inaj036 "    
#   #161122-00042#1---add---e
#   PREPARE p110_pre5 FROM g_sql
#   DECLARE p110_cur5 CURSOR FOR p110_pre5
##150325---earl---mod---e
#   
#   LET g_sql = "SELECT * FROM inau_t ", 
#               " WHERE inauent = '",g_enterprise,"'",
#               "   AND inausite = '",g_site,"'",
#               "   AND inau001 =? AND inau002 =? AND inau003 =? AND inau004 =? AND inau005 =?",
#               "   AND inau006 =? AND inau007 =? AND inau008 =? AND inau009 =?",
#               "   AND (inau010 > ",g_master.glav002," OR (inau010 = ",g_master.glav002," AND inau011 > ",g_master.glav006,"))",
#               " ORDER BY inat008,inat009 "
#   PREPARE p110_pre6 FROM g_sql
#   DECLARE p110_cur6 CURSOR FOR p110_pre6 
#    
#   ##抓取前一期的年度與期別
#   CALL s_fin_date_get_last_period(g_glaa003,'',g_master.glav002,g_master.glav006) RETURNING l_success,l_glav002,l_glav006
#   
#   #161107-00010#1---mod---s
#   #LET g_sql = " SELECT COUNT(*) ",
#   #            "   FROM (SELECT COUNT(*) ",
#   #            "   FROM inaj_t ",
#   #            "        LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
#   #            "        LEFT OUTER JOIN imaf_t ON inajent = imafent AND inajsite = imafsite AND inaj005 = imaf001",
#   #            "  WHERE inajent = '",g_enterprise,"'",
#   #            "    AND inajsite = '",g_site,"' AND ",g_master.wc,
#   #            "    AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#   #            "    AND inaj004 <>0 ",
#   #            "  GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010)" 
#   #PREPARE p110_count_pre FROM g_sql
#   #EXECUTE p110_count_pre INTO l_count
#   #LET li_count = 1  
#   IF g_bgjob <> "Y" THEN   
#      LET g_sql = " SELECT COUNT(1) FROM (",
#                  " SELECT DISTINCT inaj045,",
#                  "                 inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj012,imaf053 ",
#                  "   FROM inaj_t ",
#                  "        LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
#                  "        LEFT OUTER JOIN imaf_t ON inajent = imafent AND inajsite = imafsite AND inaj005 = imaf001",
#                  "  WHERE inajent = '",g_enterprise,"'",
#                  "    AND inajsite = '",g_site,"' AND ",g_master.wc,
#                  "    AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#                  "    AND inaj004 <>0 ",
#                  " UNION ",
#                  " SELECT inat007,",
#                  "        inat001,inat002,inat003,inat004,inat005,inat006,inat007,inat007",
#                  "   FROM inat_t ",
#                  "        LEFT OUTER JOIN imaa_t ON inatent = imaaent AND inat001 = imaa001", 
#                  "  WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"' AND ",g_master.wc,
#                  "    AND (inat008*12+inat009) = ",g_master.glav002*12+g_master.glav006-1,
#                  "    AND inat015 <>0)"               
#      PREPARE p110_count_pre FROM g_sql
#      EXECUTE p110_count_pre INTO li_count
#      CALL cl_progress_bar_no_window(li_count) 
#   END IF   
#   #161107-00010#1---mod---e
#   
##150325---earl---mod---s
##   LET g_sql = " SELECT DISTINCT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj012,imaf053 ",
##               "   FROM inaj_t ",
##               "        LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
##               "        LEFT OUTER JOIN imaf_t ON inajent = imafent AND inajsite = imafsite AND inaj005 = imaf001",
##               "  WHERE inajent = '",g_enterprise,"'",
##               "    AND inajsite = '",g_site,"' AND ",g_master.wc,
##               "    AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
##               "    AND inaj004 <>0 ",
##               " UNION ",
##               " SELECT inat001,inat002,inat003,inat004,inat005,inat006,inat007,inat007 FROM inat_t ",
##               "        LEFT OUTER JOIN imaa_t ON inatent = imaaent AND inat001 = imaa001", 
##               "  WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"' AND ",g_master.wc,
##               "    AND (inat008*12+inat009) = ",g_master.glav002*12+g_master.glav006-1,
##               "    AND inat015 <>0"
#   LET g_sql = " SELECT DISTINCT inaj045,",
#               "                 inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj012,imaf053 ",
#               "   FROM inaj_t ",
#               "        LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
#               "        LEFT OUTER JOIN imaf_t ON inajent = imafent AND inajsite = imafsite AND inaj005 = imaf001",
#               "  WHERE inajent = '",g_enterprise,"'",
#               "    AND inajsite = '",g_site,"' AND ",g_master.wc,
#               "    AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               "    AND inaj004 <>0 ",
#               " UNION ",
#               " SELECT inat007,",
#               "        inat001,inat002,inat003,inat004,inat005,inat006,inat007,inat007",
#               "   FROM inat_t ",
#               "        LEFT OUTER JOIN imaa_t ON inatent = imaaent AND inat001 = imaa001", 
#               "  WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"' AND ",g_master.wc,
#               "    AND (inat008*12+inat009) = ",g_master.glav002*12+g_master.glav006-1,
#               "    AND inat015 <>0"
##150325---earl---mod---e
#   PREPARE p110_pre FROM g_sql
#   DECLARE p110_cur CURSOR FOR p110_pre
#   
##20150302
#   ##刪除[T.料件庫存期間/月統計檔(inat_t)]中該年度期別之符合條件資料
#   LET g_sql ="DELETE FROM inat_t ",
#              " WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"'",
#              " AND inat008 =", g_master.glav002, 
#              " AND inat009 =", g_master.glav006,
#              "   AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inatent AND imaa001 = inat001 AND ",g_master.wc,")" 
#   PREPARE p110_dpre FROM g_sql
#   EXECUTE p110_dpre 
#   
#   ##刪除[T.製造批序號庫存期間/月統計檔(inas_t)]中該年度期別之符合條件資料   
#   LET g_sql = "DELETE FROM inau_t ",
#               " WHERE inauent ='",g_enterprise,"' AND inausite='",g_site,"'",
#               " AND inau010 =", g_master.glav002, 
#               " AND inau011 =", g_master.glav006,
#               "   AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inauent AND imaa001 = inau001 AND ",g_master.wc,")" 
#   PREPARE p110_dpre2 FROM g_sql
#   EXECUTE p110_dpre2 
##20150302 END
#
#   #161107-00010#1---add---s
#   LET g_sql = "SELECT inab008", 
#               "  FROM inab_t",
#               " WHERE inabent = ",g_enterprise,
#               "   AND inabsite = '",g_site,"'",
#               "   AND inab001 = ? ",
#               "   AND inab002 = ? "
#   PREPARE p110_get_inab008 FROM g_sql
#   
#   LET g_sql = "SELECT inat015,inat021 ",
#               "  FROM inat_t ",
#               " WHERE inatent = ",g_enterprise,
#               "   AND inatsite = '",g_site,"'",
#               "   AND inat001 = ?", 
#               "   AND inat002 = ?",
#               "   AND inat003 = ?",
#               "   AND inat004 = ?",
#               "   AND inat005 = ?",
#               "   AND inat006 = ?",
#               "   AND inat007 = ?",
#               "   AND inat008 = ",l_glav002,
#               "   AND inat009 = ",l_glav006
#   PREPARE p110_get_inat FROM g_sql 
#
#   LET g_sql = "SELECT inau017 ",
#               "  FROM inau_t",
#               " WHERE inauent = ",g_enterprise,
#               "   AND inausite = '",g_site,"'",
#               "   AND inau001 = ?", 
#               "   AND inau002 = ?",
#               "   AND inau003 = ?",
#               "   AND inau004 = ?",
#               "   AND inau005 = ?",
#               "   AND inau006 = ?",
#               "   AND inau007 = ?",
#               "   AND inau008 = ?",
#               "   AND inau009 = ?",
#               "   AND inau010 = ",l_glav002,
#               "   AND inau011 = ",l_glav006
#   PREPARE p110_get_inau017 FROM g_sql 
#
#   #161107-00010#1---add---e
#
##150325---earl---mod---s
##   FOREACH p110_cur INTO l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                         l_inat.inat005,l_inat.inat006,l_inaj012,l_inat.inat007  
#   FOREACH p110_cur INTO l_inaj045,
#                         l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                         l_inat.inat005,l_inat.inat006,l_inaj012,l_inat.inat007  
#
#      #161107-00010#1---add---s
#      ##畫面顯示處理進度 
#      IF g_bgjob <> "Y" THEN
#         CALL cl_progress_no_window_ing(l_inat.inat001)
#      END IF     
#      #161107-00010#1---add---e
#      
##      SELECT imaf054 INTO l_imaf054 FROM imaf_t
##       WHERE imafent = g_enterprise
##         AND imafsite = g_site
##         AND imaf001 = l_inat.inat001
##      IF l_imaf054 = 'Y' THEN 
##         LET l_inat.inat007 = l_inaj012
##      END IF  
#      LET l_inat.inat007 = l_inaj045
##150325---earl---mod---e
#
#      #161107-00010#1---mark---e
#      #LET g_master.stagenow = l_inat.inat001
#      #DISPLAY BY NAME g_master.stagenow
#      #LET g_stagecomplete = li_count* 100/l_count
#      #DISPLAY g_stagecomplete TO stagecomplete
#      #161107-00010#1---mark---e
##      ##刪除[T.料件庫存期間/月統計檔(inat_t)]中該年度期別之符合條件資料
##      DELETE FROM inat_t 
##       WHERE inatent = g_enterprise 
##         AND inatsite = g_site 
##         AND inat001 = l_inat.inat001            
##         AND inat002 = l_inat.inat002
##         AND inat003 = l_inat.inat003
##         AND inat004 = l_inat.inat004
##         AND inat005 = l_inat.inat005
##         AND inat006 = l_inat.inat006
##         AND inat007 = l_inat.inat007        
##         AND inat008 = g_master.glav002 
##         AND inat009 = g_master.glav006
#      
#
#      LET l_inat.inatent = g_enterprise
#      LET l_inat.inatsite = g_site
#      LET l_inat.inat008 = g_master.glav002
#      LET l_inat.inat009 = g_master.glav006
#      
#      LET l_inab008 =''
#      #161107-00010#1---mod---s
#      #SELECT inab008 INTO l_inab008 
#      #  FROM inab_t
#      # WHERE inabent = g_enterprise
#      #   AND inabsite = g_site
#      #   AND inab001 = l_inat.inat004
#      #   AND inab002 = l_inat.inat005
#      EXECUTE p110_get_inab008 USING l_inat.inat004,l_inat.inat005
#                                INTO l_inab008
#      #161107-00010#1---mod---e
#      LET l_inat.inat022 = l_inab008         
#      ##抓取前一期的期末數量
#      LET l_inat015 = 0
#      LET l_inat021 = 0      
#      #161107-00010#1---mod---s
#      #SELECT inat015,inat021 INTO l_inat015,l_inat021
#      #  FROM inat_t
#      # WHERE inatent = g_enterprise
#      #   AND inatsite = g_site
#      #   AND inat001 = l_inat.inat001 
#      #   AND inat002 = l_inat.inat002
#      #   AND inat003 = l_inat.inat003
#      #   AND inat004 = l_inat.inat004
#      #   AND inat005 = l_inat.inat005
#      #   AND inat006 = l_inat.inat006
#      #   AND inat007 = l_inat.inat007
#      #   AND inat008 = l_glav002
#      #   AND inat009 = l_glav006
#      EXECUTE p110_get_inat USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,l_inat.inat005,
#                                  l_inat.inat006,l_inat.inat007
#                             INTO l_inat015,l_inat021                                   
#      #161107-00010#1---mod---e
#      IF cl_null(l_inat015) THEN LET l_inat015 = 0 END IF 
#      IF cl_null(l_inat021) THEN LET l_inat021 = 0 END IF 
#      LET l_inat.inat015 = l_inat015
#      LET l_inat.inat021 = l_inat021
#      
#      LET l_inat.inat010 = 0
#      LET l_inat.inat016 = 0
#      LET l_inat.inat011 = 0
#      LET l_inat.inat017 = 0
#      LET l_inat.inat012 = 0
#      LET l_inat.inat018 = 0
#      LET l_inat.inat013 = 0
#      LET l_inat.inat019 = 0
#      LET l_inat.inat014 = 0
#      LET l_inat.inat020 = 0
#      
##150325---earl---mod---s      
##      -------------------------------------------------------------------------------------
##      IF l_imaf054 = 'Y' THEN
##         FOREACH p110_cur22 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                                 l_inat.inat005,l_inat.inat006,l_inat.inat007
##                           INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027,l_inaj036      
##            CASE l_inaj036[1,1]
##               WHEN '1'
##                  LET l_inat.inat010 = l_inat.inat010 + l_inaj011 * l_inaj004
##                  LET l_inat.inat016 = l_inat.inat016 + l_inaj027 * l_inaj004
##               WHEN '2'
##                  LET l_inat.inat011 = l_inat.inat011 + l_inaj011 * l_inaj004
##                  LET l_inat.inat017 = l_inat.inat017 + l_inaj027 * l_inaj004            
##               WHEN '3'
##                  LET l_inat.inat012 = l_inat.inat012 + l_inaj011 * l_inaj004
##                  LET l_inat.inat018 = l_inat.inat018 + l_inaj027 * l_inaj004            
##               WHEN '4'
##                  LET l_inat.inat013 = l_inat.inat013 + l_inaj011 * l_inaj004
##                  LET l_inat.inat019 = l_inat.inat019 + l_inaj027 * l_inaj004            
##               WHEN '5'
##                  LET l_inat.inat014 = l_inat.inat014 + l_inaj011 * l_inaj004
##                  LET l_inat.inat020 = l_inat.inat020 + l_inaj027 * l_inaj004 
##            END CASE
##            IF cl_null(l_inat.inat010) THEN LET l_inat.inat010 = 0 END IF
##            IF cl_null(l_inat.inat016) THEN LET l_inat.inat016 = 0 END IF
##            IF cl_null(l_inat.inat011) THEN LET l_inat.inat011 = 0 END IF
##            IF cl_null(l_inat.inat017) THEN LET l_inat.inat017 = 0 END IF
##            IF cl_null(l_inat.inat012) THEN LET l_inat.inat012 = 0 END IF
##            IF cl_null(l_inat.inat018) THEN LET l_inat.inat018 = 0 END IF
##            IF cl_null(l_inat.inat013) THEN LET l_inat.inat013 = 0 END IF
##            IF cl_null(l_inat.inat019) THEN LET l_inat.inat019 = 0 END IF
##            IF cl_null(l_inat.inat014) THEN LET l_inat.inat014 = 0 END IF
##            IF cl_null(l_inat.inat020) THEN LET l_inat.inat020 = 0 END IF          
##         END FOREACH       
##      ELSE
##         FOREACH p110_cur2 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                                 l_inat.inat005,l_inat.inat006
##                           INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027,l_inaj036      
##            CASE l_inaj036[1,1]
##               WHEN '1'
##                  LET l_inat.inat010 = l_inat.inat010 + l_inaj011 * l_inaj013 * l_inaj004
##                  LET l_inat.inat016 = l_inat.inat016 + l_inaj027 * l_inaj004
##               WHEN '2'
##                  LET l_inat.inat011 = l_inat.inat011 + l_inaj011 * l_inaj013 * l_inaj004
##                  LET l_inat.inat017 = l_inat.inat017 + l_inaj027 * l_inaj004            
##               WHEN '3'
##                  LET l_inat.inat012 = l_inat.inat012 + l_inaj011 * l_inaj013 * l_inaj004
##                  LET l_inat.inat018 = l_inat.inat018 + l_inaj027 * l_inaj004            
##               WHEN '4'
##                  LET l_inat.inat013 = l_inat.inat013 + l_inaj011 * l_inaj013 * l_inaj004
##                  LET l_inat.inat019 = l_inat.inat019 + l_inaj027 * l_inaj004            
##               WHEN '5'
##                  LET l_inat.inat014 = l_inat.inat014 + l_inaj011 * l_inaj013 * l_inaj004
##                  LET l_inat.inat020 = l_inat.inat020 + l_inaj027 * l_inaj004 
##            END CASE
##            IF cl_null(l_inat.inat010) THEN LET l_inat.inat010 = 0 END IF
##            IF cl_null(l_inat.inat016) THEN LET l_inat.inat016 = 0 END IF
##            IF cl_null(l_inat.inat011) THEN LET l_inat.inat011 = 0 END IF
##            IF cl_null(l_inat.inat017) THEN LET l_inat.inat017 = 0 END IF
##            IF cl_null(l_inat.inat012) THEN LET l_inat.inat012 = 0 END IF
##            IF cl_null(l_inat.inat018) THEN LET l_inat.inat018 = 0 END IF
##            IF cl_null(l_inat.inat013) THEN LET l_inat.inat013 = 0 END IF
##            IF cl_null(l_inat.inat019) THEN LET l_inat.inat019 = 0 END IF
##            IF cl_null(l_inat.inat014) THEN LET l_inat.inat014 = 0 END IF
##            IF cl_null(l_inat.inat020) THEN LET l_inat.inat020 = 0 END IF          
##         END FOREACH 
##      END IF
##      ------------------------------------------------------------------------------------- 
#
##161122-00004#1---mark---s
##      #161107-00010#1---mod---s
##      EXECUTE p110_cur2 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                              l_inat.inat005,l_inat.inat006,l_inat.inat007
##                         INTO l_inat.inat010,l_inat.inat016,
##                              l_inat.inat011,l_inat.inat017,
##                              l_inat.inat012,l_inat.inat018,
##                              l_inat.inat013,l_inat.inat019,
##                              l_inat.inat014,l_inat.inat020
##      IF cl_null(l_inat.inat010) THEN LET l_inat.inat010 = 0 END IF
##      IF cl_null(l_inat.inat016) THEN LET l_inat.inat016 = 0 END IF
##      IF cl_null(l_inat.inat011) THEN LET l_inat.inat011 = 0 END IF
##      IF cl_null(l_inat.inat017) THEN LET l_inat.inat017 = 0 END IF
##      IF cl_null(l_inat.inat012) THEN LET l_inat.inat012 = 0 END IF
##      IF cl_null(l_inat.inat018) THEN LET l_inat.inat018 = 0 END IF
##      IF cl_null(l_inat.inat013) THEN LET l_inat.inat013 = 0 END IF
##      IF cl_null(l_inat.inat019) THEN LET l_inat.inat019 = 0 END IF
##      IF cl_null(l_inat.inat014) THEN LET l_inat.inat014 = 0 END IF
##      IF cl_null(l_inat.inat020) THEN LET l_inat.inat020 = 0 END IF                              
##      #FOREACH p110_cur2 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##      #                        l_inat.inat005,l_inat.inat006,l_inat.inat007
##      #                  INTO l_inaj004,l_inaj011,l_inaj013,l_inaj027,l_inaj036,
##      #                       l_inaj046,l_inaj047,
##      #                       l_inaj026
##      #      CASE l_inaj036[1,1]
##      #         WHEN '1'
##      #            LET l_inat.inat010 = l_inat.inat010 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
##      #            LET l_inat.inat016 = l_inat.inat016 + l_inaj027 * l_inaj004
##      #         WHEN '2'
##      #            LET l_inat.inat011 = l_inat.inat011 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
##      #            LET l_inat.inat017 = l_inat.inat017 + l_inaj027 * l_inaj004            
##      #         WHEN '3'
##      #            LET l_inat.inat012 = l_inat.inat012 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
##      #            LET l_inat.inat018 = l_inat.inat018 + l_inaj027 * l_inaj004            
##      #         WHEN '4'
##      #            LET l_inat.inat013 = l_inat.inat013 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
##      #            LET l_inat.inat019 = l_inat.inat019 + l_inaj027 * l_inaj004            
##      #         WHEN '5'
##      #            LET l_inat.inat014 = l_inat.inat014 + l_inaj011 * l_inaj046 / l_inaj047 * l_inaj004
##      #            LET l_inat.inat020 = l_inat.inat020 + l_inaj027 * l_inaj004
##      #      END CASE
##      #      IF cl_null(l_inat.inat010) THEN LET l_inat.inat010 = 0 END IF
##      #      IF cl_null(l_inat.inat016) THEN LET l_inat.inat016 = 0 END IF
##      #      IF cl_null(l_inat.inat011) THEN LET l_inat.inat011 = 0 END IF
##      #      IF cl_null(l_inat.inat017) THEN LET l_inat.inat017 = 0 END IF
##      #      IF cl_null(l_inat.inat012) THEN LET l_inat.inat012 = 0 END IF
##      #      IF cl_null(l_inat.inat018) THEN LET l_inat.inat018 = 0 END IF
##      #      IF cl_null(l_inat.inat013) THEN LET l_inat.inat013 = 0 END IF
##      #      IF cl_null(l_inat.inat019) THEN LET l_inat.inat019 = 0 END IF
##      #      IF cl_null(l_inat.inat014) THEN LET l_inat.inat014 = 0 END IF
##      #      IF cl_null(l_inat.inat020) THEN LET l_inat.inat020 = 0 END IF
##      #      
##      #      #取位
##      #      #160419-00020#1  By Ann_Huang   mark Start ---
##      #      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat010) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat010) RETURNING l_success,l_inat.inat010
##      #      #END IF            
##      #      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat011) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat011) RETURNING l_success,l_inat.inat011
##      #      #END IF
##      #      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat012) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat012) RETURNING l_success,l_inat.inat012
##      #      #END IF
##      #      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat013) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat013) RETURNING l_success,l_inat.inat013
##      #      #END IF
##      #      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat014) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat014) RETURNING l_success,l_inat.inat014
##      #      #END IF            
##      #      #
##      #      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat016) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat016) RETURNING l_success,l_inat.inat016
##      #      #END IF
##      #      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat017) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat017) RETURNING l_success,l_inat.inat017
##      #      #END IF
##      #      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat018) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat018) RETURNING l_success,l_inat.inat018
##      #      #END IF
##      #      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat019) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat019) RETURNING l_success,l_inat.inat019
##      #      #END IF
##      #      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat020) THEN
##      #      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat020) RETURNING l_success,l_inat.inat020
##      #      #END IF
##      #      #160419-00020#1  By Ann_Huang   mark End --- 
##      #
##      #END FOREACH       
##      ##160620-00006#1---add---s
##      #161107-00010#1---mod---s
##      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat010) THEN
##         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat010) RETURNING l_success,l_inat.inat010
##      END IF            
##      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat011) THEN
##         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat011) RETURNING l_success,l_inat.inat011
##      END IF
##      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat012) THEN
##         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat012) RETURNING l_success,l_inat.inat012
##      END IF
##      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat013) THEN
##         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat013) RETURNING l_success,l_inat.inat013
##      END IF
##      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat014) THEN
##         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat014) RETURNING l_success,l_inat.inat014
##      END IF            
##      
##      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat016) THEN
##         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat016) RETURNING l_success,l_inat.inat016
##      END IF
##      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat017) THEN
##         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat017) RETURNING l_success,l_inat.inat017
##      END IF
##      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat018) THEN
##         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat018) RETURNING l_success,l_inat.inat018
##      END IF
##      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat019) THEN
##         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat019) RETURNING l_success,l_inat.inat019
##      END IF
##      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat020) THEN
##         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat020) RETURNING l_success,l_inat.inat020
##      END IF      
##      #160620-00006#1---add---e
##161122-00004#1---mark---e
#      #161122-00042#1---mark---s
#      ##161122-00004#1---add---s
#      #FOREACH p110_cur2 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#      #                        l_inat.inat005,l_inat.inat006,l_inat.inat007
#      #                   INTO l_inat010,l_inat016,
#      #                        l_inat011,l_inat017,
#      #                        l_inat012,l_inat018,
#      #                        l_inat013,l_inat019,
#      #                        l_inat014,l_inat020
#      #   IF cl_null(l_inat010) THEN LET l_inat010 = 0 END IF
#      #   IF cl_null(l_inat016) THEN LET l_inat016 = 0 END IF
#      #   IF cl_null(l_inat011) THEN LET l_inat011 = 0 END IF
#      #   IF cl_null(l_inat017) THEN LET l_inat017 = 0 END IF
#      #   IF cl_null(l_inat012) THEN LET l_inat012 = 0 END IF
#      #   IF cl_null(l_inat018) THEN LET l_inat018 = 0 END IF
#      #   IF cl_null(l_inat013) THEN LET l_inat013 = 0 END IF
#      #   IF cl_null(l_inat019) THEN LET l_inat019 = 0 END IF
#      #   IF cl_null(l_inat014) THEN LET l_inat014 = 0 END IF
#      #   IF cl_null(l_inat020) THEN LET l_inat020 = 0 END IF
#      #   IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat010) THEN
#      #      CALL s_aooi250_take_decimals(l_inat.inat007,l_inat010) RETURNING l_success,l_inat010
#      #   END IF                                                                           
#      #   IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat011) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inat.inat007,l_inat011) RETURNING l_success,l_inat011
#      #   END IF                                                                           
#      #   IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat012) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inat.inat007,l_inat012) RETURNING l_success,l_inat012
#      #   END IF                                                                           
#      #   IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat013) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inat.inat007,l_inat013) RETURNING l_success,l_inat013
#      #   END IF                                                                           
#      #   IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat014) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inat.inat007,l_inat014) RETURNING l_success,l_inat014
#      #   END IF            
#      #   
#      #   IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat016) THEN
#      #      CALL s_aooi250_take_decimals(l_inaj026,l_inat016) RETURNING l_success,l_inat016
#      #   END IF                                                                      
#      #   IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat017) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inaj026,l_inat017) RETURNING l_success,l_inat017
#      #   END IF                                                                      
#      #   IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat018) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inaj026,l_inat018) RETURNING l_success,l_inat018
#      #   END IF                                                                      
#      #   IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat019) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inaj026,l_inat019) RETURNING l_success,l_inat019
#      #   END IF                                                                      
#      #   IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat020) THEN                   
#      #      CALL s_aooi250_take_decimals(l_inaj026,l_inat020) RETURNING l_success,l_inat020
#      #   END IF 
#      #   LET l_inat.inat010 = l_inat.inat010 + l_inat010
#      #   LET l_inat.inat016 = l_inat.inat016 + l_inat016
#      #   LET l_inat.inat011 = l_inat.inat011 + l_inat011
#      #   LET l_inat.inat017 = l_inat.inat017 + l_inat017
#      #   LET l_inat.inat012 = l_inat.inat012 + l_inat012
#      #   LET l_inat.inat018 = l_inat.inat018 + l_inat018
#      #   LET l_inat.inat013 = l_inat.inat013 + l_inat013
#      #   LET l_inat.inat019 = l_inat.inat019 + l_inat019
#      #   LET l_inat.inat014 = l_inat.inat014 + l_inat014
#      #   LET l_inat.inat020 = l_inat.inat020 + l_inat020
#      #END FOREACH         
#      ##161122-00004#1---add---e
#      #161122-00042#1---mark---e
#      
#      #161122-00042#1---add---s
#      EXECUTE p110_cur2 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                              l_inat.inat005,l_inat.inat006,l_inat.inat007
#                         INTO l_inat.inat010,l_inat.inat016,
#                              l_inat.inat011,l_inat.inat017,
#                              l_inat.inat012,l_inat.inat018,
#                              l_inat.inat013,l_inat.inat019,
#                              l_inat.inat014,l_inat.inat020  
#      IF cl_null(l_inat.inat010) THEN LET l_inat.inat010 = 0 END IF
#      IF cl_null(l_inat.inat016) THEN LET l_inat.inat016 = 0 END IF
#      IF cl_null(l_inat.inat011) THEN LET l_inat.inat011 = 0 END IF
#      IF cl_null(l_inat.inat017) THEN LET l_inat.inat017 = 0 END IF
#      IF cl_null(l_inat.inat012) THEN LET l_inat.inat012 = 0 END IF
#      IF cl_null(l_inat.inat018) THEN LET l_inat.inat018 = 0 END IF
#      IF cl_null(l_inat.inat013) THEN LET l_inat.inat013 = 0 END IF
#      IF cl_null(l_inat.inat019) THEN LET l_inat.inat019 = 0 END IF
#      IF cl_null(l_inat.inat014) THEN LET l_inat.inat014 = 0 END IF
#      IF cl_null(l_inat.inat020) THEN LET l_inat.inat020 = 0 END IF                               
#      #161122-00042#1---add---e
#      LET l_inat.inat015 = l_inat.inat015 + l_inat.inat010 + l_inat.inat011 + l_inat.inat012
#                           + l_inat.inat013 + l_inat.inat014
#      LET l_inat.inat021 = l_inat.inat021 + l_inat.inat016 + l_inat.inat017 + l_inat.inat018
#                              + l_inat.inat019 + l_inat.inat020
#
#      #160419-00020#1  By Ann_Huang   mark Start ---
#      #IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat015) THEN
#      #   CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat015) RETURNING l_success,l_inat.inat015
#      #END IF      
#      #
#      #IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat021) THEN
#      #   CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat021) RETURNING l_success,l_inat.inat021
#      #END IF
#      #160419-00020#1  By Ann_Huang   mark End ---
#      #150325---earl---mod---e  
#
#      #160620-00006#1---add---s
#      IF NOT cl_null(l_inat.inat007) AND NOT cl_null(l_inat.inat015) THEN
#         CALL s_aooi250_take_decimals(l_inat.inat007,l_inat.inat015) RETURNING l_success,l_inat.inat015
#      END IF      
#      
#      IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat.inat021) THEN
#         CALL s_aooi250_take_decimals(l_inaj026,l_inat.inat021) RETURNING l_success,l_inat.inat021
#      END IF
#      #160620-00006#1---add---e
#      IF cl_null(l_inat.inat002) THEN LET l_inat.inat002 = ' ' END IF
#      IF cl_null(l_inat.inat003) THEN LET l_inat.inat003 = ' ' END IF
#      IF cl_null(l_inat.inat004) THEN LET l_inat.inat004 = ' ' END IF
#      IF cl_null(l_inat.inat005) THEN LET l_inat.inat005 = ' ' END IF
#      IF cl_null(l_inat.inat006) THEN LET l_inat.inat006 = ' ' END IF   
#
#      ##寫入[T.料件庫存期間/月統計檔(inat_t)]，數量欄位空白者需給0
#      INSERT INTO inat_t VALUES(l_inat.*)        
#
#      ##更新重計期別後之期末庫存量
#      LET l_inat015 = l_inat.inat015
#      LET l_inat021 = l_inat.inat021
#            
#      FOREACH p110_cur3 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                              l_inat.inat005,l_inat.inat006,l_inat.inat007 
#                          INTO n_inat.*
#         LET l_inat015 = l_inat015 + n_inat.inat010 + n_inat.inat011 + n_inat.inat012 + n_inat.inat013 + n_inat.inat014 
#         LET l_inat021 = l_inat021 + n_inat.inat016 + n_inat.inat017 + n_inat.inat018 + n_inat.inat019 + n_inat.inat020
#         
#         #150416---earl---add---s
#         #取位
#         IF NOT cl_null(n_inat.inat007) AND NOT cl_null(l_inat015) THEN
#            CALL s_aooi250_take_decimals(n_inat.inat007,l_inat015) RETURNING l_success,l_inat015
#         END IF
#         
#         IF NOT cl_null(l_inaj026) AND NOT cl_null(l_inat021) THEN
#            CALL s_aooi250_take_decimals(l_inaj026,l_inat021) RETURNING l_success,l_inat021
#         END IF
#         #150416---earl---add---e
#         
#         UPDATE inat_t
#            SET inat015 = l_inat015,
#                inat021 = l_inat021
#          WHERE inatent = g_enterprise
#            AND inatsite = g_site
#            AND inat001 = n_inat.inat001            
#            AND inat002 = n_inat.inat002
#            AND inat003 = n_inat.inat003
#            AND inat004 = n_inat.inat004
#            AND inat005 = n_inat.inat005
#            AND inat006 = n_inat.inat006
#            AND inat007 = n_inat.inat007
#            AND inat008 = n_inat.inat008
#            AND inat009 = n_inat.inat009 
#      END FOREACH
#      
#      
#      ##判斷符合條件的料件是否有用製造批號管理或製造序號管理，有的話繼續進行製造批序號月結
#      SELECT imaf071,imaf081 INTO l_imaf071,l_imaf081 FROM imaf_t
#       WHERE imafent = g_enterprise AND imafsite = g_site
#         AND imaf001 = l_inat.inat001
#      IF l_imaf071 <> '2' AND l_imaf081 <> '2' THEN 
#
#         FOREACH p110_cur4 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                                 l_inat.inat005,l_inat.inat006,l_inat.inat007
#                            INTO l_inai007,l_inai008
#                            
##            ##刪除[T.製造批序號庫存期間/月統計檔(inas_t)]中該年度期別之符合條件資料
##            DELETE FROM inau_t 
##             WHERE inauent = g_enterprise 
##               AND inausite = g_site 
##               AND inau001 = l_inat.inat001            
##               AND inau002 = l_inat.inat002
##               AND inau003 = l_inat.inat003
##               AND inau004 = l_inat.inat004
##               AND inau005 = l_inat.inat005
##               AND inau006 = l_inat.inat006
##               AND inau007 = l_inai007        
##               AND inau008 = l_inai008 
##               AND inau009 = l_inat.inat007
##               AND inau010 = g_master.glav002 
##               AND inau011 = g_master.glav006
#               
#            LET l_inau.inauent = g_enterprise
#            LET l_inau.inausite = g_site
#            LET l_inau.inau001 = l_inat.inat001
#            LET l_inau.inau002 = l_inat.inat002
#            LET l_inau.inau003 = l_inat.inat003
#            LET l_inau.inau004 = l_inat.inat004
#            LET l_inau.inau005 = l_inat.inat005
#            LET l_inau.inau006 = l_inat.inat006
#            LET l_inau.inau007 = l_inai007
#            LET l_inau.inau008 = l_inai008
#            LET l_inau.inau009 = l_inat.inat007
#            LET l_inau.inau010 = g_master.glav002
#            LET l_inau.inau011 = g_master.glav006  
#            LET l_inau.inau018 = l_inab008
#            LET l_inau.inau012 = 0
#            LET l_inau.inau013 = 0
#            LET l_inau.inau014 = 0
#            LET l_inau.inau015 = 0
#            LET l_inau.inau016 = 0
#            LET l_inau.inau017 = 0
#            ##抓取前一期的期末數量
#            LET l_inau017 = 0 
#            #161107-00010#1---mod---s
#            #SELECT inau017 INTO l_inau017
#            #  FROM inau_t
#            # WHERE inauent = g_enterprise
#            #   AND inausite = g_site
#            #   AND inau001 = l_inat.inat001 
#            #   AND inau002 = l_inat.inat002
#            #   AND inau003 = l_inat.inat003
#            #   AND inau004 = l_inat.inat004
#            #   AND inau005 = l_inat.inat005
#            #   AND inau006 = l_inat.inat006
#            #   AND inau007 = l_inai007
#            #   AND inau008 = l_inai008
#            #   AND inau009 = l_inat.inat007
#            #   AND inau010 = l_glav002
#            #   AND inau011 = l_glav006
#            EXECUTE p110_get_inau017 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,l_inat.inat005,
#                                           l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
#                                      INTO l_inau017
#            #161107-00010#1---mod---e            
#            IF cl_null(l_inau017) THEN LET l_inau017 = 0 END IF
#            LET l_inau.inau017 = l_inau017
#            
##150325---earl---mod---s
##            IF l_imaf054 = 'Y' THEN 
##               FOREACH p110_cur52 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                                       l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
##                                  INTO l_inaj004,l_inal014,l_inaj013,l_inaj036       
##                  CASE l_inaj036[1,1]
##                     WHEN '1'
##                        LET l_inau.inau012 = l_inau.inau010 + l_inal014 * l_inaj004
##                     WHEN '2'
##                        LET l_inau.inau013 = l_inau.inau011 + l_inal014 * l_inaj004          
##                     WHEN '3'
##                        LET l_inau.inau014 = l_inau.inau012 + l_inal014 * l_inaj004         
##                     WHEN '4'
##                        LET l_inau.inau015 = l_inau.inau013 + l_inal014 * l_inaj004          
##                     WHEN '5'
##                        LET l_inau.inau016 = l_inau.inau014 + l_inal014 * l_inaj004
##                  END CASE
##                  IF cl_null(l_inau.inau012) THEN LET l_inau.inau012 = 0 END IF
##                  IF cl_null(l_inau.inau013) THEN LET l_inau.inau013 = 0 END IF
##                  IF cl_null(l_inau.inau014) THEN LET l_inau.inau014 = 0 END IF
##                  IF cl_null(l_inau.inau015) THEN LET l_inau.inau015 = 0 END IF
##                  IF cl_null(l_inau.inau016) THEN LET l_inau.inau016 = 0 END IF         
##               END FOREACH             
##            ELSE
##               FOREACH p110_cur5 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                                       l_inat.inat005,l_inat.inat006,l_inai007,l_inai008
##                                  INTO l_inaj004,l_inal014,l_inaj013,l_inaj036       
##                  CASE l_inaj036[1,1]
##                     WHEN '1'
##                        LET l_inau.inau012 = l_inau.inau010 + l_inal014 * l_inaj013 * l_inaj004
##                     WHEN '2'
##                        LET l_inau.inau013 = l_inau.inau011 + l_inal014 * l_inaj013 * l_inaj004          
##                     WHEN '3'
##                        LET l_inau.inau014 = l_inau.inau012 + l_inal014 * l_inaj013 * l_inaj004         
##                     WHEN '4'
##                        LET l_inau.inau015 = l_inau.inau013 + l_inal014 * l_inaj013 * l_inaj004          
##                     WHEN '5'
##                        LET l_inau.inau016 = l_inau.inau014 + l_inal014 * l_inaj013 * l_inaj004
##                  END CASE
##                  IF cl_null(l_inau.inau012) THEN LET l_inau.inau012 = 0 END IF
##                  IF cl_null(l_inau.inau013) THEN LET l_inau.inau013 = 0 END IF
##                  IF cl_null(l_inau.inau014) THEN LET l_inau.inau014 = 0 END IF
##                  IF cl_null(l_inau.inau015) THEN LET l_inau.inau015 = 0 END IF
##                  IF cl_null(l_inau.inau016) THEN LET l_inau.inau016 = 0 END IF         
##               END FOREACH 
##            END IF
##161122-00004#1---mark---e            
##            #161107-00010#1---mod---s
##            EXECUTE p110_cur5 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##                                    l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
##                               INTO l_inau.inau012,l_inau.inau013,l_inau.inau014,l_inau.inau015,l_inau.inau016  
##            IF cl_null(l_inau.inau012) THEN LET l_inau.inau012 = 0 END IF
##            IF cl_null(l_inau.inau013) THEN LET l_inau.inau013 = 0 END IF
##            IF cl_null(l_inau.inau014) THEN LET l_inau.inau014 = 0 END IF
##            IF cl_null(l_inau.inau015) THEN LET l_inau.inau015 = 0 END IF
##            IF cl_null(l_inau.inau016) THEN LET l_inau.inau016 = 0 END IF                               
##            #FOREACH p110_cur5 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
##            #                        l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
##            #                   INTO l_inaj004,l_inal014,l_inaj013,l_inaj036,
##            #                        l_inaj046,l_inaj047
##            #   CASE l_inaj036[1,1]
##            #      WHEN '1'
##            #         #LET l_inau.inau012 = l_inau.inau010 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #         LET l_inau.inau012 = l_inau.inau012 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #      WHEN '2'
##            #         #LET l_inau.inau013 = l_inau.inau011 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #         LET l_inau.inau013 = l_inau.inau013 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1                     
##            #      WHEN '3'
##            #         #LET l_inau.inau014 = l_inau.inau012 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1 
##            #         LET l_inau.inau014 = l_inau.inau014 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1                     
##            #      WHEN '4'
##            #         #LET l_inau.inau015 = l_inau.inau013 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #         LET l_inau.inau015 = l_inau.inau015 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1                      
##            #      WHEN '5'
##            #         #LET l_inau.inau016 = l_inau.inau014 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #         LET l_inau.inau016 = l_inau.inau016 + l_inal014 * l_inaj046 / l_inaj047 * l_inaj004 #160311-00022#1
##            #   END CASE
##            #   
##            #   IF cl_null(l_inau.inau012) THEN LET l_inau.inau012 = 0 END IF
##            #   IF cl_null(l_inau.inau013) THEN LET l_inau.inau013 = 0 END IF
##            #   IF cl_null(l_inau.inau014) THEN LET l_inau.inau014 = 0 END IF
##            #   IF cl_null(l_inau.inau015) THEN LET l_inau.inau015 = 0 END IF
##            #   IF cl_null(l_inau.inau016) THEN LET l_inau.inau016 = 0 END IF
##            #   #160620-00006#1---mark---s
##            #   ##取位
##            #   #IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau012) THEN
##            #   #   CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau012) RETURNING l_success,l_inau.inau012
##            #   #END IF 
##            #   #IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau013) THEN
##            #   #   CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau013) RETURNING l_success,l_inau.inau013
##            #   #END IF 
##            #   #IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau014) THEN
##            #   #   CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau014) RETURNING l_success,l_inau.inau014
##            #   #END IF 
##            #   #IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau015) THEN
##            #   #   CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau015) RETURNING l_success,l_inau.inau015
##            #   #END IF 
##            #   #IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau016) THEN
##            #   #   CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau016) RETURNING l_success,l_inau.inau016
##            #   #END IF
##            #   #160620-00006#1---mark---e               
##            #END FOREACH 
##            ##160620-00006#1---add---s
##            #161107-00010#1---mod---e
##            #取位
##            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau012) THEN
##               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau012) RETURNING l_success,l_inau.inau012
##            END IF 
##            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau013) THEN
##               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau013) RETURNING l_success,l_inau.inau013
##            END IF 
##            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau014) THEN
##               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau014) RETURNING l_success,l_inau.inau014
##            END IF 
##            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau015) THEN
##               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau015) RETURNING l_success,l_inau.inau015
##            END IF 
##            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau016) THEN
##               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau016) RETURNING l_success,l_inau.inau016
##            END IF
##            #160620-00006#1---add---e
##161122-00004#1---mark---e            
#            #161122-00042#1---mark---s
#            ##161122-00004#1---add---s
#            #FOREACH p110_cur5 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#            #                        l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
#            #                   INTO l_inau012,l_inau013,l_inau014,l_inau015,l_inau016  
#            #   IF cl_null(l_inau012) THEN LET l_inau012 = 0 END IF
#            #   IF cl_null(l_inau013) THEN LET l_inau013 = 0 END IF
#            #   IF cl_null(l_inau014) THEN LET l_inau014 = 0 END IF
#            #   IF cl_null(l_inau015) THEN LET l_inau015 = 0 END IF
#            #   IF cl_null(l_inau016) THEN LET l_inau016 = 0 END IF 
#            #   #取位
#            #   IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau012) THEN
#            #      CALL s_aooi250_take_decimals(l_inau.inau009,l_inau012) RETURNING l_success,l_inau012
#            #   END IF                                                                           
#            #   IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau013) THEN                   
#            #      CALL s_aooi250_take_decimals(l_inau.inau009,l_inau013) RETURNING l_success,l_inau013
#            #   END IF                                                                           
#            #   IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau014) THEN                   
#            #      CALL s_aooi250_take_decimals(l_inau.inau009,l_inau014) RETURNING l_success,l_inau014
#            #   END IF                                                                           
#            #   IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau015) THEN                   
#            #      CALL s_aooi250_take_decimals(l_inau.inau009,l_inau015) RETURNING l_success,l_inau015
#            #   END IF                                                                           
#            #   IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau016) THEN                   
#            #      CALL s_aooi250_take_decimals(l_inau.inau009,l_inau016) RETURNING l_success,l_inau016
#            #   END IF
#            #   LET l_inau.inau012 = l_inau.inau012 + l_inau012             
#            #   LET l_inau.inau013 = l_inau.inau013 + l_inau013             
#            #   LET l_inau.inau014 = l_inau.inau014 + l_inau014             
#            #   LET l_inau.inau015 = l_inau.inau015 + l_inau015             
#            #   LET l_inau.inau016 = l_inau.inau016 + l_inau016             
#            #END FOREACH               
#            ##161122-00004#1---add---e
#            #161122-00042#1---mark---e
#            #161122-00042#1---add---s
#            EXECUTE p110_cur5 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                                    l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
#                               INTO l_inau.inau012,l_inau.inau013,l_inau.inau014,l_inau.inau015,l_inau.inau016  
#            IF cl_null(l_inau.inau012) THEN LET l_inau.inau012 = 0 END IF
#            IF cl_null(l_inau.inau013) THEN LET l_inau.inau013 = 0 END IF
#            IF cl_null(l_inau.inau014) THEN LET l_inau.inau014 = 0 END IF
#            IF cl_null(l_inau.inau015) THEN LET l_inau.inau015 = 0 END IF
#            IF cl_null(l_inau.inau016) THEN LET l_inau.inau016 = 0 END IF            
#            #161122-00042#1---add---e 
#            
#            LET l_inau.inau017 = l_inau.inau017 +l_inau.inau012+l_inau.inau013+l_inau.inau014
#                                 +l_inau.inau015+l_inau.inau016
#
#            IF NOT cl_null(l_inau.inau009) AND NOT cl_null(l_inau.inau017) THEN
#               CALL s_aooi250_take_decimals(l_inau.inau009,l_inau.inau017) RETURNING l_success,l_inau.inau017
#            END IF 
#
##150325---earl---mod---e
#            IF cl_null(l_inau.inau002) THEN LET l_inau.inau002 = ' ' END IF
#            IF cl_null(l_inau.inau003) THEN LET l_inau.inau003 = ' ' END IF
#            IF cl_null(l_inau.inau004) THEN LET l_inau.inau004 = ' ' END IF
#            IF cl_null(l_inau.inau005) THEN LET l_inau.inau005 = ' ' END IF
#            IF cl_null(l_inau.inau006) THEN LET l_inau.inau006 = ' ' END IF
#            IF cl_null(l_inau.inau007) THEN LET l_inau.inau007 = ' ' END IF
#            IF cl_null(l_inau.inau008) THEN LET l_inau.inau008 = ' ' END IF             
#            INSERT INTO inau_t VALUES(l_inau.*) 
#            #INSERT INTO inau_t(inauent,inausite,inau001,inau002,inau003,inau004,inau005,inau006,inau007,inau008,inau009,inau010,inau011,inau012,inau013,inau014,inau015,inau016,inau017,inau018)
#               #VALUES(l_inau.inauent,l_inau.inausite,l_inau.inau001,l_inau.inau002,l_inau.inau003,l_inau.inau004,l_inau.inau005,l_inau.inau006,l_inau.inau007,l_inau.inau008,l_inau.inau009,l_inau.inau010,l_inau.inau011,l_inau.inau012,l_inau.inau013,l_inau.inau014,l_inau.inau015,l_inau.inau016,l_inau.inau017,l_inau.inau018)            
#            
#            ##更新重計期別後之期末庫存量
#            LET l_inau017 = l_inau.inau017
#                        
#            FOREACH p110_cur6 USING l_inat.inat001,l_inat.inat002,l_inat.inat003,l_inat.inat004,
#                                    l_inat.inat005,l_inat.inat006,l_inai007,l_inai008,l_inat.inat007
#                               INTO n_inat.*      
#               LET l_inau017 = l_inau017 + n_inau.inau012 + n_inau.inau013 + n_inau.inau014 + n_inau.inau015 + n_inau.inau016 
#               
#               #150416---earl---add---s
#               #取位
#               IF NOT cl_null(n_inau.inau009) AND NOT cl_null(l_inau017) THEN
#                  CALL s_aooi250_take_decimals(n_inau.inau009,l_inau017) RETURNING l_success,l_inau017
#               END IF
#               #150416---earl---add---e
#               
#               UPDATE inau_t
#                  SET inau017 = l_inat017
#                WHERE inauent = g_enterprise
#                  AND inausite = g_site
#                  AND inau001 = n_inau.inau001            
#                  AND inau002 = n_inau.inau002
#                  AND inau003 = n_inau.inau003
#                  AND inau004 = n_inau.inau004
#                  AND inau005 = n_inau.inau005
#                  AND inau006 = n_inau.inau006
#                  AND inau007 = n_inau.inau007
#                  AND inau008 = n_inau.inau008
#                  AND inau009 = n_inau.inau009
#                  AND inau010 = n_inau.inau010
#                  AND inau011 = n_inau.inau011                   
#            END FOREACH            
#         END FOREACH                          
#      END IF
#      #LET li_count = li_count + 1   #161107-00010#1 mark
#   END FOREACH
#   
#   #161107-00010#1---mark---s
#   #LET g_stagecomplete = 100
#   #DISPLAY g_stagecomplete TO stagecomplete
#   #161107-00010#1---mark---e
#
#   IF l_success THEN 
#      CALL s_transaction_end('Y','0')
#   ELSE
#      CALL s_transaction_end('N','0')
#   END IF 
#161212-00017#1---mark----s
   
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
   CALL ainp110_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp110.get_buffer" >}
PRIVATE FUNCTION ainp110_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glav002 = p_dialog.getFieldBuffer('glav002')
   LET g_master.glav006 = p_dialog.getFieldBuffer('glav006')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp110.msgcentre_notify" >}
PRIVATE FUNCTION ainp110_msgcentre_notify()
 
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
 
{<section id="ainp110.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION ainp110_get_glaa003()
   SELECT DISTINCT glaa003 INTO g_glaa003
     FROM glaa_t,ooef_t
    WHERE glaacomp = ooef017
      AND glaaent = ooefent
      AND ooefent = g_enterprise
      AND ooef001 = g_site
      AND glaa014 = 'Y'
END FUNCTION

################################################################################
# Descriptions...: Precess优化版
# Memo...........:
# Usage..........: CALL ainp110_process_new()
# Date & Author..: 2016/11/24 By 02295
# Modify.........: #161123-00061#1
################################################################################
PRIVATE FUNCTION ainp110_process_new()
DEFINE li_p01_status LIKE type_t.num5
DEFINE li_count      LIKE type_t.num10
DEFINE l_bdate       LIKE type_t.dat
DEFINE l_edate       LIKE type_t.dat

   CALL s_transaction_begin()       
   LET g_success = TRUE
   ##抓取期別起迄日期
   CALL s_fin_date_get_period_range(g_glaa003,g_master.glav002,g_master.glav006) RETURNING l_bdate,l_edate
   
   IF g_bgjob <> "Y" THEN   
      LET g_sql = " SELECT 8 FROM dual "            
      PREPARE p110_count FROM g_sql
      EXECUTE p110_count INTO li_count
      CALL cl_progress_bar_no_window(li_count) 
   END IF   

   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF
   
   ##刪除[T.料件庫存期間/月統計檔(inat_t)]中該年度期別之符合條件資料
   LET g_sql ="DELETE FROM inat_t ",
              " WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"'",
              " AND inat008 =", g_master.glav002, 
              " AND inat009 =", g_master.glav006,
              "   AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inatent AND imaa001 = inat001 AND ",g_master.wc,")" 
   PREPARE p110_del_inat FROM g_sql
   EXECUTE p110_del_inat 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_del_inat"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF
   
   #本期库存异动数据的，新增本期inat资料
   LET g_sql = " INSERT INTO inat_t(inatent,inatsite,inat001,inat002,inat003,",
               "                     inat004,inat005,inat006,inat007,inat008,",
               "                     inat009,inat010,inat011,inat012,inat013,",
               "                     inat014,inat015,inat016,inat017,inat018,",
               "                     inat019,inat020,inat021,inat022)",
               " SELECT DISTINCT inajent,inajsite,inaj005,inaj006,inaj007,",
               "        inaj008,inaj009,inaj010,inaj045,",g_master.glav002,",",
               "       ",g_master.glav006,",0,0,0,0,",
               "        0,COALESCE(inat015,0),0,0,0,",
               "        0,0,COALESCE(inat021,0),inab008 ", 
               "   FROM inaj_t ",
               "   LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
               "   LEFT OUTER JOIN inab_t ON inabent = inajent AND inabsite = inajsite AND inab001 = inaj008 AND inab002 = inaj009 " ,
               "   LEFT OUTER JOIN inat_t ON inatent = inajent AND inatsite = inajsite AND inat001 = inaj005 AND inat002 = inaj006 AND inat003 = inaj007 ",
               "                         AND inat004 = inaj008 AND inat005 = inaj009 AND inat006 = inaj010 AND (inat008*12+inat009) = ",g_master.glav002*12+g_master.glav006-1,   
               "                         AND inat007 = inaj045 ",     #170210-00058#1 add               
               "  WHERE inajent = '",g_enterprise,"'",
               "    AND inajsite = '",g_site,"' AND ",g_master.wc,
               "    AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               "    AND inaj004 <>0 "
   PREPARE p110_ins_inat1 FROM g_sql
   EXECUTE p110_ins_inat1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_ins_inat1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF 

   #本期没有库存异动数据，但是前期有期末库存的，需要复制一笔前期资料到本期
   LET g_sql = " INSERT INTO inat_t(inatent,inatsite,inat001,inat002,inat003,",
               "                     inat004,inat005,inat006,inat007,inat008,",
               "                     inat009,inat010,inat011,inat012,inat013,",
               "                     inat014,inat015,inat016,inat017,inat018,",
               "                     inat019,inat020,inat021,inat022)",
               " SELECT DISTINCT inatent,inatsite,inat001,inat002,inat003,",
               "                     inat004,inat005,inat006,inat007,",g_master.glav002,",",
               "                     ",g_master.glav006,",0,0,0,0,",
               "                     0,COALESCE(inat015,0),0,0,0,",
               "                     0,0,COALESCE(inat021,0),inat022 ", 
               "   FROM inat_t ",
               "   LEFT OUTER JOIN imaa_t ON inatent = imaaent AND inat001 = imaa001",
               "   LEFT OUTER JOIN inab_t ON inabent = inatent AND inabsite = inatsite AND inab001 = inat004 AND inab002 = inat005 ",               
               "  WHERE inatent ='",g_enterprise,"' AND inatsite='",g_site,"' AND ",g_master.wc,
               "    AND (inat008*12+inat009) = ",g_master.glav002*12+g_master.glav006-1,
               "    AND inat015 <>0 ",
               "    AND NOT EXISTS(SELECT 1 FROM inaj_t WHERE inatent = inajent AND inatsite = inajsite AND inat001 = inaj005 AND inat002 = inaj006 AND inat003 = inaj007 ",
               "                                          AND inat004 = inaj008 AND inat005 = inaj009 AND inat006 = inaj010 AND inat007 = inaj045 ",
               "                                          AND inaj004 <> 0 AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"')"
   PREPARE p110_ins_inat2 FROM g_sql
   EXECUTE p110_ins_inat2   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_ins_inat2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF      
   
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF
   
   #更新符合条件资料的本期入库统计量等
#   LET g_sql = " MERGE INTO inat_t ",
#               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                            END ))",
#               "                END a,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                            END ))",
#               "                END a1,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                            END ))",
#               "                END b,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                            END ))",
#               "                END b1,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                            END ))",
#               "                END c,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                            END ))",
#               "                END c1,", 
#               "               CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                            END ))",
#               "                END d,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                            END ))",
#               "                END d1,",  
#               "               CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
#               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
#               "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
#               "                                                            END ))",
#               "                END e,",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
#               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
#               "                                                                                               ELSE round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
#               "                                                                                           END )",
#               "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
#               "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
#               "                                                           END ))",
#               "                END e1",               
#               "            FROM inaj_t ",
#               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
#               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
#               "           WHERE inajent = '",g_enterprise,"'",
#               "             AND inajsite = '",g_site,"'",
#               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
#               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,inaj036) ",
#               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
#               " WHEN MATCHED THEN ",
#               " UPDATE ",
#               "    SET inat010 = a,",
#               "        inat011 = b,",               
#               "        inat012 = c,",               
#               "        inat013 = d,",               
#               "        inat014 = e,",
#               "        inat015 = inat015 +a+b+c+d+e,",               
#               "        inat016 = a1,",               
#               "        inat017 = b1,",               
#               "        inat018 = c1,",               
#               "        inat019 = d1,",               
#               "        inat020 = e1,",               
#               "        inat021 = inat021 +a1+b1+c1+d1+e1",
#               "  WHERE inatent = '",g_enterprise,"'",
#               "    AND inatsite = '",g_site,"'",
#               "    AND inat008 = ",g_master.glav002,
#               "    AND inat009 = ",g_master.glav006              
#   PREPARE p110_upd_inat FROM g_sql 
#   EXECUTE p110_upd_inat       
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "p110_upd_inat"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
   ############################临时拆分处理##############################
   #161212-00017#1---mod---e               
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
   #            "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
   #            "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
   #            "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
   #            "                                                            END ))",
   #            "                a",  
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)  ",
               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN a.ooca004 = '3'  THEN trunc(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)",
               "                                                                WHEN a.ooca004 = '4'  THEN ceil(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6)*power(10,a.ooca002))/power(10,a.ooca002) ",
               "                                                            END ))",
               "                a",                 
   #161212-00017#1---mod---e               
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='1'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat010 = a",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat1 FROM g_sql 
   EXECUTE p110_upd_inat1       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
   #            "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
   #            "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
   #            "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
   #            "                                                            END ))",
   #            "                a1", 
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)  ",
               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN b.ooca004 = '3'  THEN trunc(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)",
               "                                                                WHEN b.ooca004 = '4'  THEN ceil(round(COALESCE(inaj027*inaj004,0),6)*power(10,b.ooca002))/power(10,b.ooca002) ",
               "                                                            END ))",
               "                a1",                
   #161212-00017#1---mod---e                
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='1'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat016 = a1",               
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat2 FROM g_sql 
   EXECUTE p110_upd_inat2       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #161212-00017#1---mod---e               
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
   #            "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
   #            "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
   #            "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
   #            "                                                            END ))",
   #            "                a",  
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)  ",
               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN a.ooca004 = '3'  THEN trunc(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)",
               "                                                                WHEN a.ooca004 = '4'  THEN ceil(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6)*power(10,a.ooca002))/power(10,a.ooca002) ",
               "                                                            END ))",
               "                a",                 
   #161212-00017#1---mod---e                  
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='2'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat011 = a",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat3 FROM g_sql 
   EXECUTE p110_upd_inat3       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat3"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
   #            "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
   #            "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
   #            "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
   #            "                                                            END ))",
   #            "                a1", 
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)  ",
               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN b.ooca004 = '3'  THEN trunc(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)",
               "                                                                WHEN b.ooca004 = '4'  THEN ceil(round(COALESCE(inaj027*inaj004,0),6)*power(10,b.ooca002))/power(10,b.ooca002) ",
               "                                                            END ))",
               "                a1",                
   #161212-00017#1---mod---e              
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='2'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat017 = a1",               
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat4 FROM g_sql 
   EXECUTE p110_upd_inat4       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat4"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---e               
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
   #            "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
   #            "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
   #            "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
   #            "                                                            END ))",
   #            "                a",  
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)  ",
               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN a.ooca004 = '3'  THEN trunc(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)",
               "                                                                WHEN a.ooca004 = '4'  THEN ceil(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6)*power(10,a.ooca002))/power(10,a.ooca002) ",
               "                                                            END ))",
               "                a",                 
   #161212-00017#1---mod---e               
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='3'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat012 = a",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat5 FROM g_sql 
   EXECUTE p110_upd_inat5       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat5"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
   #            "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
   #            "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
   #            "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
   #            "                                                            END ))",
   #            "                a1", 
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)  ",
               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN b.ooca004 = '3'  THEN trunc(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)",
               "                                                                WHEN b.ooca004 = '4'  THEN ceil(round(COALESCE(inaj027*inaj004,0),6)*power(10,b.ooca002))/power(10,b.ooca002) ",
               "                                                            END ))",
               "                a1",                
   #161212-00017#1---mod---e                 
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='3'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat018 = a1",               
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat6 FROM g_sql 
   EXECUTE p110_upd_inat6       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat6"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #161212-00017#1---mod---e               
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
   #            "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
   #            "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
   #            "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
   #            "                                                            END ))",
   #            "                a",  
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)  ",
               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN a.ooca004 = '3'  THEN trunc(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)",
               "                                                                WHEN a.ooca004 = '4'  THEN ceil(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6)*power(10,a.ooca002))/power(10,a.ooca002) ",
               "                                                            END ))",
               "                a",                 
   #161212-00017#1---mod---e                
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='4'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat013 = a",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat7 FROM g_sql 
   EXECUTE p110_upd_inat7       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat7"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
   #            "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
   #            "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
   #            "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
   #            "                                                            END ))",
   #            "                a1", 
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)  ",
               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN b.ooca004 = '3'  THEN trunc(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)",
               "                                                                WHEN b.ooca004 = '4'  THEN ceil(round(COALESCE(inaj027*inaj004,0),6)*power(10,b.ooca002))/power(10,b.ooca002) ",
               "                                                            END ))",
               "                a1",                
   #161212-00017#1---mod---e                
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='4'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat019 = a1",               
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat8 FROM g_sql 
   EXECUTE p110_upd_inat8       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat8"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #161212-00017#1---mod---e               
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)  ",
   #            "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002) ",
   #            "                                                                                               ELSE round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN a.ooca004 = '3'  THEN trunc(COALESCE(inaj011*inaj046/inaj047*inaj004,0),a.ooca002)",
   #            "                                                                WHEN a.ooca004 = '4'  THEN ceil(COALESCE(inaj011*inaj046/inaj047*inaj004,0)*power(10,a.ooca002))/power(10,a.ooca002) ",
   #            "                                                            END ))",
   #            "                a",  
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN a.ooca004 = '1'  THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)  ",
               "                                                                WHEN a.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002),(2/power(10,a.ooca002)))=0 THEN round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)-(inaj004*1/power(10,a.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN a.ooca004 = '3'  THEN trunc(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6),a.ooca002)",
               "                                                                WHEN a.ooca004 = '4'  THEN ceil(round(COALESCE(inaj011*inaj046/inaj047*inaj004,0),6)*power(10,a.ooca002))/power(10,a.ooca002) ",
               "                                                            END ))",
               "                a",                 
   #161212-00017#1---mod---e                 
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='5'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat014 = a",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat9 FROM g_sql 
   EXECUTE p110_upd_inat9       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat9"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inat_t ",
   #            " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
   #            "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(COALESCE(inaj027*inaj004,0),b.ooca002)  ",
   #            "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(COALESCE(inaj027*inaj004,0),b.ooca002) ",
   #            "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
   #            "                                                                                           END )",
   #            "                                                                WHEN b.ooca004 = '3'  THEN trunc(COALESCE(inaj027*inaj004,0),b.ooca002)",
   #            "                                                                WHEN b.ooca004 = '4'  THEN ceil(COALESCE(inaj027*inaj004,0)*power(10,b.ooca002))/power(10,b.ooca002) ",
   #            "                                                            END ))",
   #            "                a1", 
   LET g_sql = " MERGE INTO inat_t ",
               " USING (SELECT inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045,",
               "               SUM((CASE WHEN b.ooca004 = '1'  THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)  ",
               "                                                                WHEN b.ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002),(2/power(10,b.ooca002)))=0 THEN round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002) ",
               "                                                                                               ELSE round(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)-(inaj004*1/power(10,b.ooca002)) ",
               "                                                                                           END )",
               "                                                                WHEN b.ooca004 = '3'  THEN trunc(round(COALESCE(inaj027*inaj004,0),6),b.ooca002)",
               "                                                                WHEN b.ooca004 = '4'  THEN ceil(round(COALESCE(inaj027*inaj004,0),6)*power(10,b.ooca002))/power(10,b.ooca002) ",
               "                                                            END ))",
               "                a1",                
   #161212-00017#1---mod---e                
               "            FROM inaj_t ",
               "            LEFT OUTER JOIN ooca_t a ON a.oocaent = inajent AND a.ooca001 = inaj045 ",
               "            LEFT OUTER JOIN ooca_t b ON b.oocaent = inajent AND b.ooca001 = inaj026 ",
               "           WHERE inajent = '",g_enterprise,"'",
               "             AND inajsite = '",g_site,"'",
               "             AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='5'",
               "             AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "           GROUP BY inaj005,inaj006,inaj007,inaj008,inaj009,inaj010,inaj045) ",
               "   ON (inaj005 = inat001 AND inaj006 = inat002 AND inaj007 = inat003 AND inaj008 = inat004 AND inaj009 = inat005 AND inaj010 = inat006 AND inaj045 = inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inat020 = a1",               
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006              
   PREPARE p110_upd_inat10 FROM g_sql 
   EXECUTE p110_upd_inat10       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat10"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF  
   LET g_sql = " UPDATE inat_t ",
               "    SET inat015 = inat015 + inat010 + inat011 + inat012 + inat013 +inat014,",  
               "        inat021 = inat021 + inat016 + inat017 + inat018 + inat019 +inat020" ,
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008 = ",g_master.glav002,
               "    AND inat009 = ",g_master.glav006,
               "    AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inatent AND imaa001 = inat001 AND ",g_master.wc,")"               
   PREPARE p110_upd_inat11 FROM g_sql 
   EXECUTE p110_upd_inat11       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat11"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF                   
   ############################临时拆分处理##############################
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF
   
   #更新当期之后的期別，重計其期末庫存量
   CALL ainp110_upd_inat(g_master.glav002*12+g_master.glav006)
   IF NOT g_success THEN 
      CALL s_transaction_end('N','0')
      RETURN      
   END IF
   #################分割线####################
   #制造批序号段处理
   
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF

   ##刪除[T.製造批序號庫存期間/月統計檔(inas_t)]中該年度期別之符合條件資料   
   LET g_sql = "DELETE FROM inau_t ",
               " WHERE inauent ='",g_enterprise,"' AND inausite='",g_site,"'",
               " AND inau010 =", g_master.glav002, 
               " AND inau011 =", g_master.glav006,
               " AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inauent AND imaa001 = inau001 AND ",g_master.wc,")" 
   PREPARE p110_del_inau FROM g_sql
   EXECUTE p110_del_inau    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_del_inau"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF

   #本期库存异动数据的，新增本期inau资料
   LET g_sql = " INSERT INTO inau_t(inauent,inausite,inau001,inau002,inau003,",
               "                    inau004,inau005,inau006,inau007,inau008,",
               "                    inau009,inau010,inau011,inau012,inau013,",
               "                    inau014,inau015,inau016,inau017,inau018)",
               " SELECT DISTINCT inalent,inalsite,inal006,inal007,inal008,",            #170314-00018#1 add DISTINCT
               "        inal009,inal010,inal011,inal012,inal013,",
               "        inaj045,",g_master.glav002,",",g_master.glav006,",0,0,",
               "        0,0,0,COALESCE(inau017,0),inab008",
               "   FROM inal_t ",
              # "   INNER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal004 ", #170324-00036#1 mark
              "   INNER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",    #170324-00036#1 add
               "   LEFT OUTER JOIN imaa_t ON inajent = imaaent AND inaj005 = imaa001",
               "   LEFT OUTER JOIN inab_t ON inabent = inalent AND inabsite = inalsite AND inab001 = inal009 AND inab002 = inal010 " ,
               "   LEFT OUTER JOIN inau_t ON inalent = inauent AND inalsite = inausite AND inal006 = inau001 AND inal007 = inau002 ",
               "                         AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "                         AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009  ",
               "                         AND (inau010*12+inau011) = ",g_master.glav002*12+g_master.glav006-1,               
               "  WHERE inalent = '",g_enterprise,"'",
               "    AND inalsite = '",g_site,"' AND ",g_master.wc,
               "    AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               "    AND inal005 <>0 "
   PREPARE p110_ins_inau1 FROM g_sql
   EXECUTE p110_ins_inau1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_ins_inau1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #本期没有库存异动数据，但是前期有期末库存的，需要复制一笔前期资料到本期
   LET g_sql = " INSERT INTO inau_t(inauent,inausite,inau001,inau002,inau003,",
               "                    inau004,inau005,inau006,inau007,inau008,",
               "                    inau009,inau010,inau011,inau012,inau013,",
               "                    inau014,inau015,inau016,inau017,inau018)",
               " SELECT DISTINCT inauent,inausite,inau001,inau002,inau003,",                #170314-00018#1 add DISTINCT
               "        inau004,inau005,inau006,inau007,inau008,",
               "        inau009,",g_master.glav002,",",g_master.glav006,",0,0,",
               "        0,0,0,COALESCE(inau017,0),inau018",
               "   FROM inau_t ",
               "   LEFT OUTER JOIN imaa_t ON inauent = imaaent AND inau001 = imaa001",
               "   LEFT OUTER JOIN inab_t ON inabent = inauent AND inabsite = inausite AND inab001 = inau004 AND inab002 = inau005 " ,               
               "  WHERE inauent ='",g_enterprise,"' AND inausite='",g_site,"' AND ",g_master.wc,
               "    AND (inau010*12+inau011) = ",g_master.glav002*12+g_master.glav006-1,
               "    AND inau017 <>0 ",
               "    AND NOT EXISTS(SELECT 1 FROM inal_t ",
            #   "                           INNER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal004 ",#170324-00036#1 mark
             "                           INNER JOIN inaj_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",  #170324-00036#1 mark  
               "                           WHERE inalent = inauent AND inalsite = inausite AND inal006 = inau001 AND inal007 = inau002 ",
               "                             AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "                             AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 ",
               "                             AND inaj045 = inau009 AND inal005 <> 0 AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"')"
   PREPARE p110_ins_inau2 FROM g_sql
   EXECUTE p110_ins_inau2   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_ins_inau2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF

   #更新符合条件资料的本期入库统计量等
#   LET g_sql = " MERGE INTO inau_t",
#               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
#               "               CASE WHEN SUBSTR(inaj036,1,1)='1' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                         END )",
#               "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                            END ))",  
#               "                END a,",                                              
#               "               CASE WHEN SUBSTR(inaj036,1,1)='2' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                         END )",
#               "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                             END ))",
#               "                 END b,",                                             
#               "               CASE WHEN SUBSTR(inaj036,1,1)='3' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                         END )",
#               "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                             END ))",
#               "                 END c,",                                             
#               "               CASE WHEN SUBSTR(inaj036,1,1)='4' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                         END )",
#               "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                             END ))",
#               "                 END d,",                                             
#               "               CASE WHEN SUBSTR(inaj036,1,1)='5' THEN SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
#               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
#               "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
#               "                                                                                         END )",
#               "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
#               "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
#               "                                                             END ))",
#               "                 END e",               
#               "          FROM inaj_t ",
#               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
#               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
#               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
#               "         WHERE inalent = '",g_enterprise,"'",
#               "           AND inalsite = '",g_site,"'",
#               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"'" ,
#               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
#               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045,inaj036) ",
#               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
#               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
#               " WHEN MATCHED THEN ",
#               " UPDATE ",
#               "    SET inau012 = a,",
#               "        inau013 = b,",               
#               "        inau014 = c,",               
#               "        inau015 = d,",               
#               "        inau016 = e,",
#               "        inau017 = inau017 + a + b + c + d + e,",
#               "  WHERE inauent = '",g_enterprise,"'",
#               "    AND inausite = '",g_site,"'",
#               "    AND inau010 = ",g_master.glav002,
#               "    AND inau011 = ",g_master.glav006                 
#   PREPARE p110_upd_inau FROM g_sql
#   EXECUTE p110_upd_inau 
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "p110_upd_inau"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
   #################临时处理##################
   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inau_t",
   #            " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
   #            "               SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
   #            "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
   #            "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
   #            "                                                                                         END )",
   #            "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
   #            "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
   #            "                                                            END ))",  
   #            "                a",                
   LET g_sql = " MERGE INTO inau_t",
               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
               "               SUM((CASE WHEN ooca004 = '1'  THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)  ",
               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002),(2/power(10,ooca002)))=0 THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002) ",
               "                                                                                             ELSE round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)-(inaj004*1/power(10,ooca002)) ",
               "                                                                                         END )",
               "                                                                WHEN ooca004 = '3'  THEN trunc(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)",
               "                                                                WHEN ooca004 = '4'  THEN ceil(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6)*power(10,ooca002))/power(10,ooca002) ",
               "                                                            END ))",  
               "                a",                
   #161212-00017#1---mod---e                    
               "          FROM inaj_t ",
               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "         WHERE inalent = '",g_enterprise,"'",
               "           AND inalsite = '",g_site,"'",
               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='1'" ,
               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045) ",
               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inau012 = a",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006                 
   PREPARE p110_upd_inau1 FROM g_sql
   EXECUTE p110_upd_inau1 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF   

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inau_t",
   #            " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
   #            "               SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
   #            "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
   #            "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
   #            "                                                                                         END )",
   #            "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
   #            "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
   #            "                                                            END ))",  
   #            "                a",                
   LET g_sql = " MERGE INTO inau_t",
               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
               "               SUM((CASE WHEN ooca004 = '1'  THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)  ",
               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002),(2/power(10,ooca002)))=0 THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002) ",
               "                                                                                             ELSE round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)-(inaj004*1/power(10,ooca002)) ",
               "                                                                                         END )",
               "                                                                WHEN ooca004 = '3'  THEN trunc(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)",
               "                                                                WHEN ooca004 = '4'  THEN ceil(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6)*power(10,ooca002))/power(10,ooca002) ",
               "                                                            END ))",  
               "                a",                
   #161212-00017#1---mod---e                                                           
               "          FROM inaj_t ",
               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "         WHERE inalent = '",g_enterprise,"'",
               "           AND inalsite = '",g_site,"'",
               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='2'" ,
               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045) ",
               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inau013 = a",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006                 
   PREPARE p110_upd_inau2 FROM g_sql
   EXECUTE p110_upd_inau2 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inau_t",
   #            " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
   #            "               SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
   #            "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
   #            "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
   #            "                                                                                         END )",
   #            "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
   #            "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
   #            "                                                            END ))",  
   #            "                a",                
   LET g_sql = " MERGE INTO inau_t",
               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
               "               SUM((CASE WHEN ooca004 = '1'  THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)  ",
               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002),(2/power(10,ooca002)))=0 THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002) ",
               "                                                                                             ELSE round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)-(inaj004*1/power(10,ooca002)) ",
               "                                                                                         END )",
               "                                                                WHEN ooca004 = '3'  THEN trunc(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)",
               "                                                                WHEN ooca004 = '4'  THEN ceil(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6)*power(10,ooca002))/power(10,ooca002) ",
               "                                                            END ))",  
               "                a",                
   #161212-00017#1---mod---e                                                            
               "          FROM inaj_t ",
               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "         WHERE inalent = '",g_enterprise,"'",
               "           AND inalsite = '",g_site,"'",
               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='3'" ,
               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045) ",
               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inau014 = a",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006                 
   PREPARE p110_upd_inau3 FROM g_sql
   EXECUTE p110_upd_inau3 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau3"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF  

   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inau_t",
   #            " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
   #            "               SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
   #            "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
   #            "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
   #            "                                                                                         END )",
   #            "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
   #            "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
   #            "                                                            END ))",  
   #            "                a",                
   LET g_sql = " MERGE INTO inau_t",
               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
               "               SUM((CASE WHEN ooca004 = '1'  THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)  ",
               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002),(2/power(10,ooca002)))=0 THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002) ",
               "                                                                                             ELSE round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)-(inaj004*1/power(10,ooca002)) ",
               "                                                                                         END )",
               "                                                                WHEN ooca004 = '3'  THEN trunc(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)",
               "                                                                WHEN ooca004 = '4'  THEN ceil(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6)*power(10,ooca002))/power(10,ooca002) ",
               "                                                            END ))",  
               "                a",                
   #161212-00017#1---mod---e                                                            
               "          FROM inaj_t ",
               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "         WHERE inalent = '",g_enterprise,"'",
               "           AND inalsite = '",g_site,"'",
               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='4'" ,
               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045) ",
               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inau015 = a",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006                 
   PREPARE p110_upd_inau4 FROM g_sql
   EXECUTE p110_upd_inau4 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau4"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF  
   
   #161212-00017#1---mod---s                
   #LET g_sql = " MERGE INTO inau_t",
   #            " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
   #            "               SUM((CASE WHEN ooca004 = '1'  THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)  ",
   #            "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002),(2/power(10,ooca002)))=0 THEN round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002) ",
   #            "                                                                                             ELSE round(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)-(inaj004*1/power(10,ooca002)) ",
   #            "                                                                                         END )",
   #            "                                                                WHEN ooca004 = '3'  THEN trunc(COALESCE(inal014*inaj046/inaj047*inaj004,0),ooca002)",
   #            "                                                                WHEN ooca004 = '4'  THEN ceil(COALESCE(inal014*inaj046/inaj047*inaj004,0)*power(10,ooca002))/power(10,ooca002) ",
   #            "                                                            END ))",  
   #            "                a",                
   LET g_sql = " MERGE INTO inau_t",
               " USING (SELECT inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045, ",
               "               SUM((CASE WHEN ooca004 = '1'  THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)  ",
               "                                                                WHEN ooca004 = '2'  THEN (CASE WHEN MOD(round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002),(2/power(10,ooca002)))=0 THEN round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002) ",
               "                                                                                             ELSE round(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)-(inaj004*1/power(10,ooca002)) ",
               "                                                                                         END )",
               "                                                                WHEN ooca004 = '3'  THEN trunc(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6),ooca002)",
               "                                                                WHEN ooca004 = '4'  THEN ceil(round(COALESCE(inal014*inaj046/inaj047*inaj004,0),6)*power(10,ooca002))/power(10,ooca002) ",
               "                                                            END ))",  
               "                a",                
   #161212-00017#1---mod---e                                                            
               "          FROM inaj_t ",
               "          LEFT OUTER JOIN ooca_t ON oocaent = inajent AND ooca001 = inaj045 ",
               "          INNER JOIN inal_t ON inajent = inalent AND inajsite = inalsite AND inaj001 = inal001 ",
               "                           AND inaj002 = inal002 AND inaj003 = inal003 AND inaj004 = inal005 ",
               "         WHERE inalent = '",g_enterprise,"'",
               "           AND inalsite = '",g_site,"'",
               "           AND inal016 BETWEEN '",l_bdate,"' AND '",l_edate,"' AND SUBSTR(inaj036,1,1)='5'" ,
               "           AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inajent AND imaa001 = inaj005 AND ",g_master.wc,")",
               "         GROUP BY inal006,inal007,inal008,inal009,inal010,inal011,inal012,inal013,inaj045) ",
               "   ON (inal006 = inau001 AND inal007 = inau002 AND inal008 = inau003 AND inal009 = inau004 AND inal010 = inau005 ",
               "       AND inal011 = inau006 AND inal012 = inau007 AND inal013 = inau008 AND inaj045 = inau009 )", 
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET inau016 = a",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006                 
   PREPARE p110_upd_inau5 FROM g_sql
   EXECUTE p110_upd_inau5 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau5"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF     
   LET g_sql = " UPDATE inau_t ",
               "    SET inau017 = inau017 + inau012 + inau013 + inau014 + inau015 +inau016",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010 = ",g_master.glav002,
               "    AND inau011 = ",g_master.glav006,  
               "    AND EXISTS (SELECT 1 FROM imaa_t WHERE imaaent=inauent AND imaa001 = inau001 AND ",g_master.wc,")"               
   PREPARE p110_upd_inau6 FROM g_sql 
   EXECUTE p110_upd_inau6       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inau6"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF     
   #################临时处理##################
   ##畫面顯示處理進度 
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_no_window_ing('')
   END IF

   #更新当期之后的期別，重計其期末庫存量
   CALL ainp110_upd_inau(g_master.glav002*12+g_master.glav006)              
   IF NOT g_success THEN 
      CALL s_transaction_end('N','0')
      RETURN      
   END IF
   
   CALL s_transaction_end('Y','0')
   
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
   CALL ainp110_msgcentre_notify()   
END FUNCTION

################################################################################
# Descriptions...: 检查是否存在下期资料，如果存在则更新下期数据
# Memo...........:
# Usage..........: CALL ainp110_upd_inat(p_new)
# Input parameter: p_new   当期年度*12+期別
# Date & Author..: 2016/11/24 By 02295
# Modify.........: #161123-00061#1
################################################################################
PRIVATE FUNCTION ainp110_upd_inat(p_new)
DEFINE p_new      LIKE type_t.num10
DEFINE l_last     LIKE type_t.num10
DEFINE l_cnt      LIKE type_t.num10


   #先检查是否存在下期的资料，如不存在就无须进行更新
   LET l_last = p_new + 1
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(1) FROM inat_t ",
               "  WHERE inatent = '",g_enterprise,"'",
               "    AND inatsite = '",g_site,"'",
               "    AND inat008*12+inat009 = ",l_last,
               "    AND EXISTS(SELECT 1 FROM imaa_t WHERE imaaent = inatent AND imaa001 = inat001 AND ",g_master.wc,")"
   PREPARE p110_chk_inat_last FROM g_sql
   EXECUTE p110_chk_inat_last INTO l_cnt 
   IF l_cnt = 0 THEN
      RETURN
   END IF
   
   LET g_sql = " MERGE INTO inat_t a ",
               " USING (SELECT inat001,inat002,inat003,inat004,inat005,",
               "               inat006,inat007,inat015,inat021 ",
               "          FROM inat_t ",
               "         WHERE inatent = '",g_enterprise,"'",
               "           AND inatsite = '",g_site,"'",
               "           AND inat008*12+inat009 = ",p_new,
               "           AND EXISTS(SELECT 1 FROM imaa_t WHERE imaaent=inatent AND imaa001 = inat001 AND ",g_master.wc,")) b ",
               " ON (a.inat001 = b.inat001 AND a.inat002 = b.inat002 AND a.inat003 = b.inat003 AND a.inat004 = b.inat004 ",
               "     AND a.inat005 = b.inat005 AND a.inat006 = b.inat006 AND a.inat007 = b.inat007)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET a.inat015 = b.inat015 + a.inat010 + a.inat011 + a.inat012 + a.inat013 + a.inat014,",
               "        a.inat021 = b.inat021 + a.inat016 + a.inat017 + a.inat018 + a.inat019 + a.inat020 ",
               "  WHERE a.inatent = '",g_enterprise,"'",
               "    AND a.inatsite = '",g_site,"'",
               "    AND a.inat008*12+a.inat009 = ",l_last
   PREPARE p110_upd_inat_last FROM g_sql
   EXECUTE p110_upd_inat_last   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat_last"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      RETURN
   END IF
   IF g_success THEN
      CALL ainp110_upd_inat(l_last)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 检查是否存在下期资料，如果存在则更新下期数据
# Memo...........:
# Usage..........: CALL ainp110_upd_inau(p_new)
# Input parameter: p_new   当期年度*12+期別
# Date & Author..: 2016/11/24 By 02295
# Modify.........: #161123-00061#1
################################################################################
PRIVATE FUNCTION ainp110_upd_inau(p_new)
DEFINE p_new      LIKE type_t.num10
DEFINE l_last     LIKE type_t.num10
DEFINE l_cnt      LIKE type_t.num10


   #先检查是否存在下期的资料，如不存在就无须进行更新
   LET l_last = p_new + 1
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(1) FROM inau_t ",
               "  WHERE inauent = '",g_enterprise,"'",
               "    AND inausite = '",g_site,"'",
               "    AND inau010*12+inau011 = ",l_last,
               "    AND EXISTS(SELECT 1 FROM imaa_t WHERE imaaent = inauent AND imaa001 = inau001 AND ",g_master.wc,")"
   PREPARE p110_chk_inau_last FROM g_sql
   EXECUTE p110_chk_inau_last INTO l_cnt 
   IF l_cnt = 0 THEN
      RETURN
   END IF
   
   LET g_sql = " MERGE INTO inau_t a ",
               " USING (SELECT inau001,inau002,inau003,inau004,inau005,",
               "               inau006,inau007,inau008,inau009,inau017 ",
               "          FROM inau_t",
               "         WHERE inauent = '",g_enterprise,"'",
               "           AND inausite = '",g_site,"'",
               "           AND inau010*12+inau011 = ",p_new,
               "           AND EXISTS(SELECT 1 FROM imaa_t WHERE imaaent=inauent AND imaa001 = inau001 AND ",g_master.wc,")) b ",
               " ON (a.inau001 = b.inau001 AND a.inau002 = b.inau002 AND a.inau003 = b.inau003 AND a.inau004 = b.inau004 ",
               "    AND a.inau005 = b.inau005 AND a.inau006 = b.inau006 AND a.inau007 = b.inau007 AND a.inau008 = b.inau008 AND a.inau009 = b.inau009)",
               " WHEN MATCHED THEN ",
               " UPDATE ",
               "    SET a.inau017 = b.inau017 + a.inau012 + a.inau013 + a.inau014 + a.inau015 + a.inau016",
               "  WHERE a.inauent = '",g_enterprise,"'",
               "    AND a.inausite = '",g_site,"'",
               "    AND a.inau010*12+a.inau011 = ",l_last
   PREPARE p110_upd_inau_last FROM g_sql
   EXECUTE p110_upd_inau_last   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "p110_upd_inat_last"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      RETURN
   END IF
   IF g_success THEN
      CALL ainp110_upd_inau(l_last)
   END IF   
END FUNCTION

#end add-point
 
{</section>}
 
