#該程式未解開Section, 採用最新樣板產出!
{<section id="adep230.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-05-12 11:41:10), PR版次:0003(2016-10-21 16:49:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: adep230
#+ Description: 門店客戶貨款對帳批次作業
#+ Creator....: 06137(2016-04-13 11:14:50)
#+ Modifier...: 06137 -SD/PR- 08729
 
{</section>}
 
{<section id="adep230.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjd_tmp ——> adep230_tmp01,adep230_rtjq_tmp ——> adep230_tmp02,adep230_isaf_tmp ——> adep230_tmp03
#161006-00008#5    16/10/18 By 08729 處理組織開窗及補aooi500管控相關元件
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
        rtjadocdt        LIKE rtja_t.rtjadocdt,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjasite LIKE rtja_t.rtjasite, 
   rtjadocdt LIKE type_t.dat, 
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
 
{<section id="adep230.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5  #161006-00008#5 add
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success #161006-00008#5 add
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep230_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep230 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep230_init()
 
      #進入選單 Menu (="N")
      CALL adep230_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep230
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #161006-00008#5 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep230.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep230_init()
 
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
 
{<section id="adep230.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep230_ui_dialog()
 
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
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.rtjadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               IF cl_null(g_master.rtjadocdt) THEN
                  LET g_master.rtjadocdt = g_today
               END IF
               DISPLAY BY NAME g_master.rtjadocdt
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt
            #add-point:BEFORE FIELD rtjadocdt name="input.b.rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt
            
            #add-point:AFTER FIELD rtjadocdt name="input.a.rtjadocdt"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt
            #add-point:ON CHANGE rtjadocdt name="input.g.rtjadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt
            #add-point:ON ACTION controlp INFIELD rtjadocdt name="input.c.rtjadocdt"
 
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c') 
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上
            NEXT FIELD rtjasite                     #返回原欄位
    



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
            CALL adep230_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_site TO rtjasite
            LET g_master.rtjadocdt = g_today
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
         CALL adep230_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.rtjadocdt = g_master.rtjadocdt
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
                 CALL adep230_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep230_transfer_argv(ls_js)
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
 
{<section id="adep230.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep230_transfer_argv(ls_js)
 
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
 
{<section id="adep230.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep230_process(ls_js)
 
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
   DEFINE l_date_tmp    STRING                  
   DEFINE l_cnt         LIKE type_t.num5        
   DEFINE l_err_cnt     LIKE type_t.num5        
   DEFINE l_succ_cnt    LIKE type_t.num5        
   DEFINE l_log         STRING                  
   DEFINE l_loop        LIKE type_t.num5        
   DEFINE l_msg         STRING           

   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_isafsite    LIKE isaf_t.isafsite
   DEFINE l_num         LIKE type_t.num10
   DEFINE l_vo          LIKE type_t.chr10
   DEFINE l_vo1         LIKE type_t.chr10
   DEFINE l_rtjq002_o   LIKE rtjq_t.rtjq002
   DEFINE l_rtjq003_o   LIKE rtjq_t.rtjq003
   DEFINE l_rtjq002     LIKE type_t.num10
   DEFINE l_rtjq003     LIKE type_t.num10
   DEFINE l_rtjq002_s   LIKE type_t.chr10
   DEFINE l_rtjq003_s   LIKE type_t.chr10
   DEFINE l_rtjq002_n   LIKE rtjq_t.rtjq002 
   DEFINE l_i           LIKE type_t.num10
   DEFINE l_j           LIKE type_t.num10     
   DEFINE i             LIKE type_t.num10
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
      LET l_loop = 3
      CALL cl_progress_bar_no_window(l_loop) 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep230_process_cs CURSOR FROM ls_sql
#  FOREACH adep230_process_cs INTO
   #add-point:process段process name="process.process"
   #資料準備 
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg) 
   
   #建立暫存檔
   CALL adep230_create_tmp()      
   
   # 筛选出符合关帐日期的营运组织
   IF NOT cl_null(lc_param.wc) THEN
      LET l_str = cl_replace_str(lc_param.wc,"rtjasite","ooef001")
   END IF
   
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where    
   
   LET l_sql  = "SELECT ooef001 ",
                "  FROM ooef_t ",
                " WHERE ooefent = '",g_enterprise,"' ",
                "   AND ",l_str
   PREPARE adep230_sel_ooef FROM l_sql
   DECLARE adep230_cur_ooef CURSOR FOR adep230_sel_ooef
   
   LET l_str = ''
   CALL cl_err_collect_init()
   
   FOREACH adep230_cur_ooef INTO l_ooef001
      LET l_cnt = l_cnt + 1                                        
      IF NOT s_settledate_chk(l_ooef001,lc_param.rtjadocdt) THEN
         LET l_err_cnt = l_err_cnt + 1                             
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_str) THEN
         LET l_str = "'",l_ooef001,"'"
      ELSE
         LET l_str = l_str,",'",l_ooef001,"'"
      END IF
 
      LET l_succ_cnt = l_succ_cnt + 1                              
   END FOREACH   
   CALL cl_err_collect_show()  
   
   #檢查組織加日期是否已存在aist310
   LET lc_param.wc = " ooef001 IN (",l_str,")"
   LET l_sql  = " SELECT COUNT(*) ",
                "   FROM isaf_t ",
                "  WHERE isafent = ",g_enterprise,
                "    AND isafsite = ? ",
                "    AND isafdocdt = '",lc_param.rtjadocdt,"'",
                "    AND isaf050 = '3' "
   PREPARE adep230_isaf_cnt FROM l_sql
                
   LET l_sql  = "SELECT ooef001 ",
                "  FROM ooef_t ",
                " WHERE ooefent = '",g_enterprise,"' ",
                "   AND ",lc_param.wc
   PREPARE adep230_sel_ooef1 FROM l_sql
   DECLARE adep230_cur_ooef1 CURSOR FOR adep230_sel_ooef1
   FOREACH adep230_cur_ooef1 INTO l_ooef001
      EXECUTE adep230_isaf_cnt USING l_ooef001 INTO l_cnt
      IF l_cnt > 0 THEN
         LET l_flag = 'Y'
      ELSE
         LET l_flag = 'N'
      END IF
      INSERT INTO adep230_tmp03(isafent,isafsite,flag)  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_isaf_tmp ——> adep230_tmp03
           VALUES (g_enterprise,l_ooef001,l_flag)
   END FOREACH
   
   IF NOT cl_null(l_str) THEN
      LET lc_param.wc = " rtjasite IN (",l_str,")"
   ELSE
      RETURN     
   END IF       
   
   
   #塞資料(rtjd_tmp)
   LET g_sql = "INSERT INTO adep230_tmp01 ",  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjd_tmp ——> adep230_tmp01
               "SELECT rtjaent, rtjasite,rtjdsite, rtjadocdt, rtjadocno,rtjdseq, ",
               "       rtjdseq1,rtjd002, rtjd005,  rtjd006,   rtjd007  ,rtjd008, ",
               "       rtjd009 ",
               "  FROM rtja_t,rtjd_t ",
               " WHERE rtjaent   = rtjdent ",
               "   AND rtjadocno = rtjddocno ",
               "   AND rtjastus <> 'X' ",
               "   AND rtja032 <> '1' ",
               #"   AND rtja006 IS NULL ",
               "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND ",lc_param.wc,
               "   AND ",l_where                 

   PREPARE adep230_ins_rtjd FROM g_sql
   DISPLAY "[adep230_ins_rtjd]SQL: ",g_sql   
   EXECUTE adep230_ins_rtjd   
   DISPLAY "rtjd異動筆數:",SQLCA.sqlerrd[3]
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep230_ins_rtjd"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN            
   END IF
   
   #塞資料(rtjq_tmp)
   LET g_sql = "INSERT INTO adep230_tmp02 ",  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjq_tmp ——> adep230_tmp02
               "SELECT rtjaent,  rtjasite,  ooef017,  rtjadocdt,  rtjadocno, ",
               "       rtjq001,  rtjq002,   rtjq003,  rtjq004,    rtjq005, ",
               "       rtjq006,  rtjq007,   rtjq008,  rtjq009,    rtjq011, ",
               "       rtjq012,  rtjq013,   rtjq014,  rtjq015,    rtjq016, ",
               "       rtjq017,  rtjq018,   rtjq019,  rtjq021,    rtjq022, ",
               "       rtjq023,  rtjq024,   rtjq025,  rtjq026,    rtjq027, ",
               "       rtjq030,  ooef108,   pmab084,  ooefl006,   ooef016  ",
               "  FROM rtja_t,rtjq_t,ooef_t ",
               "  LEFT JOIN pmab_t ON ooefent = pmabent AND ooef001 = pmabsite AND ooef108 = pmab001 ",
               "  LEFT JOIN ooefl_t ON ooefent = ooeflent AND ooef001 = ooefl001 AND ooefl002 = '"||g_dlang||"' ", 
               " WHERE rtjaent   = rtjqent ",
               "   AND rtjadocno = rtjqdocno ",
               "   AND rtjaent   = ooefent ",
               "   AND rtjasite  = ooef001 ",
               "   AND rtjastus <> 'X' ",
               "   AND rtja032 <> '1' ",
               #"   AND rtja006 IS NULL ",
               "   AND rtjadocdt = '",lc_param.rtjadocdt,"'",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND ",lc_param.wc,
               "  AND ",l_where                                           

   PREPARE adep230_ins_rtjq FROM g_sql
   DISPLAY "[adep230_ins_rtjq]SQL: ",g_sql   
   EXECUTE adep230_ins_rtjq   
   DISPLAY "rtjq異動筆數:",SQLCA.sqlerrd[3]
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep230_ins_rtjq"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN            
   END IF   
   
   #SELECT tmp資料開始產生主檔、歷程檔
   LET g_sql = "SELECT rtjaent,      rtjasite,     ooef017,      rtjadocdt,    rtjadocno, ",
               "       rtjq001,      rtjq002,      rtjq003,      rtjq004,      rtjq005,   ",
               "       rtjq006,      rtjq007,      rtjq008,      rtjq009,      rtjq011,   ",
               "       rtjq012,      rtjq013,      rtjq014,      rtjq015,      rtjq016,   ",
               "       rtjq017,      rtjq018,      rtjq019,      rtjq021,      rtjq022,   ",
               "       rtjq023,      rtjq024,      rtjq025,      rtjq026,      rtjq027,   ",
               "       rtjq030,      ooef108,      pmab084,      ooefl006,     ooef016    ",
               "  FROM adep230_tmp02 ",   #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjq_tmp ——> adep230_tmp02
               " WHERE EXISTS (SELECT isafsite FROM adep230_tmp03 ",  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_isaf_tmp ——> adep230_tmp03
               "                    WHERE rtjaent = isafent ",
               "                      AND rtjasite = isafsite ",
               "                      AND flag = 'N') ",               
               " ORDER BY rtjasite,rtjadocdt,rtjq001,rtjq002 "               
   DECLARE adep230_cl2 CURSOR FROM g_sql 
   
   #SELECT rtjd_tmp資料
   LET g_sql = "SELECT rtjaent,      rtjasite,         rtjdsite,         rtjadocdt,        rtjadocno, ",
               "       rtjdseq,      rtjdseq1,         rtjd002,          rtjd005,          rtjd006,   ",
               "       rtjd007,      rtjd008,          rtjd009  ",
               "  FROM adep230_tmp01 ",  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjd_tmp ——> adep230_tmp01
               " WHERE rtjaent = ? ",
               "   AND rtjasite = ? ",
               "   AND rtjadocdt = ? ",
               #"   AND rtjadocno = ? ",
               " ORDER BY rtjaent,rtjasite,rtjasite,rtjadocdt,rtjadocno,rtjdseq "
   DECLARE adep230_cl3 CURSOR FROM g_sql 
   
   #準備rtia_t,rtib_t資料SQL
   LET g_sql = "SELECT rtiadocno,SUM(rtib021)rtib021,SUM(rtib022)rtib022,SUM(rtib021)-SUM(rtib022)rtib021n ",
               "  FROM rtia_t,rtib_t ",
               " WHERE rtiaent = rtibent ",
               "   AND rtiadocno = rtibdocno ",
               "   AND rtiaent = ? ",
               "   AND rtiadocdt = ? ",
               "   AND rtiasite  = ? ",
               "   AND rtia032 = '4' ",
               " GROUP BY rtiadocno "
   DECLARE adep230_cl4 CURSOR FROM g_sql                
   
   
   #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   
   #產生資料寫入table
   CALL adep230_ins_table()
   
   #把已存在aist310的資料報錯
   LET l_sql = " SELECT isafsite ",
               "   FROM adep230_tmp03 ",  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_isaf_tmp ——> adep230_tmp03
               "  WHERE flag = 'Y' "
   PREPARE adep230_sel_isaftmp FROM l_sql
   DECLARE adep230_sel_isaftmp_cur CURSOR FOR adep230_sel_isaftmp
   FOREACH adep230_sel_isaftmp_cur INTO l_isafsite
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00172'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_isafsite
      LET g_errparam.replace[2] = lc_param.rtjadocdt
      CALL cl_err()      
   END FOREACH
   
   CALL cl_err_collect_show()   
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
   CALL adep230_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep230.get_buffer" >}
PRIVATE FUNCTION adep230_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.rtjadocdt = p_dialog.getFieldBuffer('rtjadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep230.msgcentre_notify" >}
PRIVATE FUNCTION adep230_msgcentre_notify()
 
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
 
{<section id="adep230.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建新暫存Table
# Memo...........:
# Usage..........: CALL adep230_create_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 20160503 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep230_create_tmp()
   #刪除暫存檔
   DROP TABLE adep230_tmp01  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjd_tmp ——> adep230_tmp01
   
   #建立暫存檔
   CREATE TEMP TABLE adep230_tmp01 (    #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjd_tmp ——> adep230_tmp01
      rtjaent     SMALLINT,
      rtjasite    VARCHAR(10),
      rtjdsite    VARCHAR(10),
      rtjadocdt   DATE,
      rtjadocno   VARCHAR(20),
      rtjdseq     INTEGER,
      rtjdseq1    INTEGER,
      rtjd002     DECIMAL(5,2),
      rtjd005     DECIMAL(20,6),
      rtjd006     DECIMAL(20,6),
      rtjd007     DECIMAL(20,6),
      rtjd008     DECIMAL(20,6),
      rtjd009     VARCHAR(20));   
      
      
   #刪除暫存檔
   DROP TABLE adep230_tmp02  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjq_tmp ——> adep230_tmp02
   
   #建立暫存檔
   CREATE TEMP TABLE adep230_tmp02 (   #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_rtjq_tmp ——> adep230_tmp02
      rtjaent     SMALLINT,
      rtjasite    VARCHAR(10),
      ooef017     VARCHAR(10),
      rtjadocdt   DATE,
      rtjadocno   VARCHAR(20),
      rtjq001     DATE,
      rtjq002     VARCHAR(20),
      rtjq003     VARCHAR(20),
      rtjq004     VARCHAR(20),
      rtjq005     VARCHAR(1),
      rtjq006     DECIMAL(20,6),
      rtjq007     DECIMAL(20,6),
      rtjq008     DECIMAL(20,6),
      rtjq009     DECIMAL(20,6),
      rtjq011     DECIMAL(20,6),
      rtjq012     VARCHAR(10),
      rtjq013     SMALLINT,
      rtjq014     VARCHAR(10),
      rtjq015     VARCHAR(10),
      rtjq016     VARCHAR(20),
      rtjq017     DATE,
      rtjq018     DATETIME YEAR TO FRACTION(5),
      rtjq019     VARCHAR(10),
      rtjq021     VARCHAR(20),
      rtjq022     VARCHAR(20),
      rtjq023     VARCHAR(10),
      rtjq024     VARCHAR(10),
      rtjq025     VARCHAR(80),
      rtjq026     VARCHAR(80),
      rtjq027     VARCHAR(10),
      rtjq030     VARCHAR(20),
      ooef108     VARCHAR(10),
      pmab084     VARCHAR(10),
      ooefl006    VARCHAR(500),
      ooef016     VARCHAR(10));   

   #刪除暫存檔
   DROP TABLE adep230_tmp03  #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_isaf_tmp ——> adep230_tmp03
   
   #建立暫存檔
   CREATE TEMP TABLE adep230_tmp03 (   #160727-00019#09   16/08/05 By 08734 临时表长度超过15码的减少到15码以下 adep230_isaf_tmp ——> adep230_tmp03
      isafent     SMALLINT,
      isafsite    VARCHAR(10),
      flag        VARCHAR(1));       
END FUNCTION

################################################################################
# Descriptions...: 資料處理段
# Memo...........:
# Usage..........: CALL adep230_ins_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 20160503 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep230_ins_table()
   DEFINE l_rtjq_d   RECORD               #寫入isaf,isat
      rtjaent    LIKE rtja_t.rtjaent,
      rtjasite   LIKE rtja_t.rtjasite,
      ooef017    LIKE ooef_t.ooef017,
      rtjadocdt  LIKE rtja_t.rtjadocdt,
      rtjadocno  LIKE rtja_t.rtjadocno,
      rtjq001    LIKE rtjq_t.rtjq001,
      rtjq002    LIKE rtjq_t.rtjq002,
      rtjq003    LIKE rtjq_t.rtjq003,
      rtjq004    LIKE rtjq_t.rtjq004,
      rtjq005    LIKE rtjq_t.rtjq005,
      rtjq006    LIKE rtjq_t.rtjq006,
      rtjq007    LIKE rtjq_t.rtjq007,
      rtjq008    LIKE rtjq_t.rtjq008,
      rtjq009    LIKE rtjq_t.rtjq009,
      rtjq011    LIKE rtjq_t.rtjq011,
      rtjq012    LIKE rtjq_t.rtjq012,
      rtjq013    LIKE rtjq_t.rtjq013,
      rtjq014    LIKE rtjq_t.rtjq014,
      rtjq015    LIKE rtjq_t.rtjq015,
      rtjq016    LIKE rtjq_t.rtjq016,
      rtjq017    LIKE rtjq_t.rtjq017,
      rtjq018    LIKE rtjq_t.rtjq018,
      rtjq019    LIKE rtjq_t.rtjq019,
      rtjq021    LIKE rtjq_t.rtjq021,
      rtjq022    LIKE rtjq_t.rtjq022,
      rtjq023    LIKE rtjq_t.rtjq023,
      rtjq024    LIKE rtjq_t.rtjq024,
      rtjq025    LIKE rtjq_t.rtjq025,
      rtjq026    LIKE rtjq_t.rtjq026,
      rtjq027    LIKE rtjq_t.rtjq027,
      rtjq030    LIKE rtjq_t.rtjq030,
      ooef108    LIKE ooef_t.ooef108,
      pmab084    LIKE pmab_t.pmab084,
      ooefl006   LIKE ooefl_t.ooefl006,
      ooef016    LIKE ooef_t.ooef016
      END RECORD     

   DEFINE l_rtjd_d   RECORD               #寫入isah
      rtjaent    LIKE rtja_t.rtjaent,
      rtjasite   LIKE rtja_t.rtjasite,
      rtjdsite   LIKE rtjd_t.rtjdsite,
      rtjadocdt  LIKE rtja_t.rtjadocdt,
      rtjadocno  LIKE rtja_t.rtjadocno,
      rtjdseq    LIKE rtjd_t.rtjdseq,
      rtjdseq1   LIKE rtjd_t.rtjdseq1,
      rtjd002    LIKE rtjd_t.rtjd002,
      rtjd005    LIKE rtjd_t.rtjd005,
      rtjd006    LIKE rtjd_t.rtjd006,
      rtjd007    LIKE rtjd_t.rtjd007,
      rtjd008    LIKE rtjd_t.rtjd008,
      rtjd009    LIKE rtjd_t.rtjd009
      END RECORD     
      
   DEFINE l_rtia_d   RECORD               #寫入isag
      rtiadocno   LIKE rtia_t.rtiadocno,
      rtib021     LIKE rtib_t.rtib021,
      rtib022     LIKE rtib_t.rtib022,
      rtib021n    LIKE rtib_t.rtib021
      END RECORD   
      
   #isah_t   
   DEFINE l_isahseq     LIKE isah_t.isahseq  

   #isag_t
   DEFINE l_isagseq     LIKE isag_t.isagseq
   DEFINE l_isag010     LIKE isag_t.isag010
   
   #isaf_t
   DEFINE l_rtjadocdt   LIKE rtja_t.rtjadocdt  
   DEFINE l_rtjasite    LIKE rtja_t.rtjasite   
   DEFINE l_success     LIKE type_t.num5       
   DEFINE l_doctype     LIKE rtai_t.rtai004   
   DEFINE l_isafdocno   LIKE isaf_t.isafdocno  #aist310的單號 
   DEFINE l_isaf001     LIKE isaf_t.isaf001    #aist310的發票來源
   DEFINE l_isaf002     LIKE isaf_t.isaf002    #aist310的發票客戶
   DEFINE l_isaf027     LIKE isaf_t.isaf027    #aist310的銷貨方對外全名
   DEFINE l_isaf050     LIKE isaf_t.isaf050    #aist310的產生方式
   DEFINE l_isaf056     LIKE isaf_t.isaf056    #aist310的發票性質
   DEFINE l_isaf100     LIKE isaf_t.isaf100    #aist310的幣別
   DEFINE l_isaf016     LIKE isaf_t.isaf016    #aist310的稅別
   DEFINE l_isaf017     LIKE isaf_t.isaf017    #aist310的含稅否
   DEFINE l_isaf018     LIKE isaf_t.isaf018    #aist310的稅率
   DEFINE l_isafcrtdt   LIKE isaf_t.isafcrtdt  #創建日期
   DEFINE l_isafcomp    LIKE isaf_t.isafcomp   #法人
   DEFINE l_seq         LIKE isat_t.isatseq   
   
   #isat_t
   DEFINE l_isat029     LIKE isat_t.isat029    #含稅否
   DEFINE l_isat023     LIKE isat_t.isat023    #稅率
   
   #組合發票號碼用(目前使用10碼發票，前二碼文字，後8碼數字)
   DEFINE l_i           LIKE type_t.num10
   DEFINE l_j           LIKE type_t.num10
   DEFINE i             LIKE type_t.num10   
   DEFINE l_rtjq002     LIKE type_t.num10
   DEFINE l_rtjq003     LIKE type_t.num10
   DEFINE l_rtjq002_s   LIKE type_t.chr10
   DEFINE l_rtjq003_s   LIKE type_t.chr10
   DEFINE l_rtjq002_n   LIKE rtjq_t.rtjq002 
   
   DEFINE l_msg         STRING 
   DEFINE l_isaf_cnt    LIKE type_t.num5

   CALL s_transaction_begin()   
   CALL cl_err_collect_init()                                  
   
   LET l_rtjasite = NULL                                         
   LET l_rtjadocdt = NULL                                          

   FOREACH adep230_cl2 INTO l_rtjq_d.*
      #單頭
      LET l_rtjq_d.rtjq012 = 'Y'
      IF (cl_null(l_rtjasite) AND cl_null(l_rtjadocdt))
         OR l_rtjasite <> l_rtjq_d.rtjasite
         OR l_rtjadocdt <> l_rtjq_d.rtjadocdt THEN
         
         #檢查日期加組織是否已經有產生aist310資料(產生方式為3：日結產生)
         SELECT COUNT(*) INTO l_isaf_cnt 
           FROM isaf_t 
          WHERE isafent  = g_enterprise 
            AND isafsite = l_rtjq_d.rtjasite
            AND isafdocdt= l_rtjq_d.rtjadocdt 
            AND isaf050  = '3'
         
         #預設單據的單別
         LET l_success = ''
         LET l_doctype = ''
         CALL s_arti200_get_def_doc_type(l_rtjq_d.rtjasite,"aist310",'2') 
            RETURNING l_success,l_doctype
         IF NOT l_success THEN           
            CALL s_transaction_end('N','0')         
            RETURN  
         END IF
         
         LET l_isafdocno = l_doctype
         IF NOT s_aooi200_chk_slip(l_rtjq_d.rtjasite,'',l_isafdocno,"aist310") THEN
            CALL s_transaction_end('N','0')        
            RETURN  
         END IF
         
         #單號
         CALL s_aooi200_gen_docno(l_rtjq_d.rtjasite,l_isafdocno,l_rtjq_d.rtjadocdt,"aist310") 
            RETURNING l_success,l_isafdocno
         IF NOT l_success THEN           
            CALL s_transaction_end('N','0')             
            RETURN        
         END IF
         
         #散客編號
         LET l_isaf002 = l_rtjq_d.ooef108
         IF cl_null(l_isaf002) THEN             
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "ade-00058"   
            LET g_errparam.extend = l_rtjq_d.rtjasite 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            CONTINUE FOREACH            
         END IF   
         
         LET l_isaf016 = l_rtjq_d.pmab084            #客戶慣用稅別    
         CALL adep230_get_oodb005(l_rtjq_d.rtjasite,l_isaf016)
            RETURNING l_isaf017,l_isaf018
         LET l_isaf001 = '1'                         #發票來源                 
         LET l_isaf027 = l_rtjq_d.ooefl006           #銷貨方對外全名                   
         LET l_isaf050 = '3'                         #產生方式     #20160518 改成3 日結產生
         LET l_isaf056 = '1'                         #發票性質                  
         LET l_isaf100 = l_rtjq_d.ooef016            #幣別         
         LET l_isafcomp = l_rtjq_d.ooef017           #法人         
         LET l_isafcrtdt = cl_get_current()
         
         INSERT INTO isaf_t(isafent,  isafsite,  isafcomp,  isafdocno, isafdocdt,
                            isaf001,  isaf002,   isaf007,   isaf011,   isaf014,
                            isaf016,  isaf017,   isaf018,   isaf019,   isaf020,
                            isaf027,  isaf028,   isaf050,   isaf052,   isaf056,
                            isaf100,  isaf101,   isafstus,  isafownid, isafowndp, 
                            isafcrtid,isafcrtdp, isafcrtdt, isaf003)  
              VALUES (l_rtjq_d.rtjaent,  l_rtjq_d.rtjasite,  l_isafcomp,         l_isafdocno,       l_rtjq_d.rtjadocdt,
                      l_isaf001,         l_isaf002,          l_rtjq_d.rtjadocdt, '',                l_rtjq_d.rtjq001,
                      l_isaf016,         l_isaf017,          l_isaf018,          l_rtjq_d.rtjq023,  '',
                      l_isaf027,         l_rtjq_d.rtjq022,   l_isaf050,          l_rtjq_d.rtjasite, l_isaf056,
                      l_isaf100,         1,                  'N',                g_user,            g_dept,
                      g_user,            g_dept,             l_isafcrtdt,        l_isaf002)
         IF SQLCA.SQLcode THEN   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Insert isaf_t Error!"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')              
            RETURN          
         END IF
                          
         LET l_rtjasite = l_rtjq_d.rtjasite
         LET l_rtjadocdt = l_rtjq_d.rtjadocdt
         LET l_isahseq = 1
         LET l_isagseq = 1
         LET l_seq = 1
         
         #單身之一
         #寫入銷項發票明細 來源：rtjd_tmp　　寫入：isah_t
         FOREACH adep230_cl3 USING l_rtjq_d.rtjaent,l_rtjq_d.rtjasite,l_rtjq_d.rtjadocdt  #,l_rtjq_d.rtjadocno
                              INTO l_rtjd_d.*

            INSERT INTO isah_t(isahent,  isahcomp,  isahdocno,  isahseq,  isahorga,
                               isah001,  isah002,   isah007,    isah103,  isah104,
                               isah105,  isah113,   isah114,    isah115)  
                 VALUES (l_rtjd_d.rtjaent,  l_isafcomp,         l_isafdocno,        l_isahseq,         l_rtjd_d.rtjdsite,
                         '',                l_rtjd_d.rtjd009,   l_rtjd_d.rtjd002,   l_rtjd_d.rtjd006,  l_rtjd_d.rtjd005,
                         l_rtjd_d.rtjd007,  l_rtjd_d.rtjd006,   l_rtjd_d.rtjd005,   l_rtjd_d.rtjd007)
            IF SQLCA.SQLcode THEN   
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Insert isah_t Error!"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')              
               RETURN          
            END IF
         LET l_isahseq = l_isahseq + 1 
         END FOREACH  

         #單身之一
         LET l_isag010 = cl_getmsg('ade-00171',g_dlang)
         #賽入銷項發票來源明細　來源：rtia_t,rtib_t  寫入isag_t
         FOREACH adep230_cl4 USING l_rtjq_d.rtjaent,l_rtjq_d.rtjadocdt,l_rtjq_d.rtjasite
                              INTO l_rtia_d.*
            INSERT INTO isag_t(isagent,  isagcomp,  isagdocno,  isagseq,   isagorga,  isag001,
                               isag002,  isag010,   isag101,    isag103,   isag104,
                               isag105,  isag113,   isag114,    isag115)  
                 VALUES (l_rtjq_d.rtjaent,  l_isafcomp,         l_isafdocno,        l_isagseq,         l_rtjq_d.rtjasite,  '11',
                         l_rtia_d.rtiadocno,l_isag010,          l_rtia_d.rtib021,   l_rtia_d.rtib022,  l_rtia_d.rtib021n,
                         l_rtia_d.rtib021,  l_rtia_d.rtib022,   l_rtia_d.rtib021n,  l_rtia_d.rtib021)
            IF SQLCA.SQLcode THEN   
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Insert isag_t Error!"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')              
               RETURN          
            END IF          
         END FOREACH
      END IF   
   
      #單身之一
      #寫入發票歷程檔　來源：rtjq_tmp  寫入：isat_t
      CALL adep230_get_oodb005(l_rtjq_d.rtjasite,l_rtjq_d.rtjq012)
         RETURNING l_isat029,l_isat023

      LET l_rtjq002 = l_rtjq_d.rtjq002[3,10]      
      LET l_rtjq003 = l_rtjq_d.rtjq003[3,10]
      LET l_rtjq002_s = l_rtjq_d.rtjq002[1,2]
      
      LET l_i = 1
      LET l_j = l_rtjq003 - l_rtjq002 + 1
      
      FOR i = l_i TO l_j
         LET l_rtjq002_n = l_rtjq002_s,l_rtjq002 + i -1 USING "&&&&&&&&"
         IF i = l_j THEN  #發票起迄最後一筆  填入相關金額欄位，其他的填發票號跟其他資料
            INSERT INTO isat_t(isatent, isatcomp, isatdocno, isatseq,  isat001,
                               isat002, isat003,  isat004,   isat005,  isat006,
                               isat007, isat010,  isat012,   isat014,  isat015,
                               isat017, isat018,  isat019,   isat021,  isat022,
                               isat023, isat100,  isat101,   isat103,  isat104,
                               isat105, isat113,  isat114,   isat115,  isat204,
                               isat205, isat206,  isat207,   isat028,  isat029,
                               isat108, isat118 )                                         
                  VALUES (l_rtjq_d.rtjaent, l_rtjq_d.ooef017,  l_isafdocno,       l_seq,             '',
                          l_rtjq_d.rtjq005, l_rtjq_d.rtjq030,  l_rtjq002_n,       l_rtjq_d.rtjq019,  l_rtjq_d.rtjq004,
                          l_rtjq_d.rtjq001, l_rtjq_d.rtjq021,  l_rtjq_d.rtjq022,  l_rtjq_d.rtjq014,  l_rtjq_d.rtjq015,
                          l_rtjq_d.rtjq017, l_rtjq_d.rtjq018,  l_rtjq_d.rtjq016,  l_rtjq_d.rtjq013,  l_rtjq_d.rtjq012,
                          l_isat023,        l_rtjq_d.ooef016,  1,                 l_rtjq_d.rtjq006,  l_rtjq_d.rtjq007,
                          l_rtjq_d.rtjq008, l_rtjq_d.rtjq006,  l_rtjq_d.rtjq007,  l_rtjq_d.rtjq008,  l_rtjq_d.rtjq027,
                          l_rtjq_d.rtjq024, l_rtjq_d.rtjq025,  l_rtjq_d.rtjq026,  l_rtjq_d.rtjq012,  l_isat029,
                          l_rtjq_d.rtjq011, l_rtjq_d.rtjq011)                                        
            IF SQLCA.SQLcode THEN         
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Insert isat_t Error!"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')       
               RETURN   
            END IF  
         ELSE            
            INSERT INTO isat_t(isatent, isatcomp, isatdocno, isatseq,  isat001,
                               isat002, isat003,  isat004,   isat005,  isat006,
                               isat007, isat010,  isat012,   isat014,  isat015,
                               isat017, isat018,  isat019,   isat021,  isat022,
                               isat023, isat100,  isat101,   isat204,
                               isat205, isat206,  isat207,   isat028,  isat029)                                         
                  VALUES (l_rtjq_d.rtjaent, l_rtjq_d.ooef017,  l_isafdocno,       l_seq,             '',
                          l_rtjq_d.rtjq005, l_rtjq_d.rtjq030,  l_rtjq002_n,       l_rtjq_d.rtjq019,  l_rtjq_d.rtjq004,
                          l_rtjq_d.rtjq001, l_rtjq_d.rtjq021,  l_rtjq_d.rtjq022,  l_rtjq_d.rtjq014,  l_rtjq_d.rtjq015,
                          l_rtjq_d.rtjq017, l_rtjq_d.rtjq018,  l_rtjq_d.rtjq016,  l_rtjq_d.rtjq013,  l_rtjq_d.rtjq012,
                          l_isat023,        l_rtjq_d.ooef016,  1,                 l_rtjq_d.rtjq027,
                          l_rtjq_d.rtjq024, l_rtjq_d.rtjq025,  l_rtjq_d.rtjq026,  l_rtjq_d.rtjq012,  l_isat029 )                                        
            IF SQLCA.SQLcode THEN         
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "Insert isat_t Error!"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')       
               RETURN   
            END IF  
         END IF
         LET l_seq = l_seq + 1 
      END FOR
   END FOREACH
      
   CALL s_transaction_end('Y','0') 
  
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)    

END FUNCTION

################################################################################
# Descriptions...: 取得含稅否、稅率
# Memo...........:
# Usage..........: CALL adep230_get_oodb005(p_site,p_oodb002)
#                  RETURNING r_oodb005,r_oodb006
# Input parameter: p_site         營運組織
#                : p_oodb002      稅別編號
# Return code....: r_oodb005      含稅否
#                : r_oodb006      稅率
# Date & Author..: 20160503 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep230_get_oodb005(p_site,p_oodb002)
DEFINE p_site           LIKE rtja_t.rtjasite
DEFINE p_oodb002        LIKE oodb_t.oodb002
DEFINE r_oodb005        LIKE oodb_t.oodb005
DEFINE r_oodb006        LIKE oodb_t.oodb006

    SELECT oodb005,oodb006 
      INTO r_oodb005,r_oodb006
      FROM ooef_t,oodb_t
     WHERE ooefent = oodbent
       AND ooef019 = oodb001
       AND ooef001 = p_site
       AND oodb002 = p_oodb002
       
   
   RETURN r_oodb005,r_oodb006
END FUNCTION

#end add-point
 
{</section>}
 
