#該程式未解開Section, 採用最新樣板產出!
{<section id="adep990.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-12-13 15:50:14), PR版次:0012(2016-12-13 17:55:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: adep990
#+ Description: 門店銷售單品日結批次處理作業
#+ Creator....: 01752(2015-07-21 16:46:54)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="adep990.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#9   2016/08/02 By 08734  临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06,adep990_rtjb_tmp ——> adep990_tmp01,adep990_deba_tmp ——> adep990_tmp02,adep990_debb_tmp ——> adep990_tmp03,adep990_debk_tmp ——> adep990_tmp07,adep990_debl_tmp ——> adep990_tmp08,adep990_debm_tmp ——> adep990_tmp09
#                                                                      adep990_deca_tmp ——> adep990_tmp10,adep990_decb_tmp ——> adep990_tmp11,adep990_decc_tmp ——> adep990_tmp12,adep990_debf_tmp ——> adep990_tmp13,adep990_rtib_tmp ——> adep990_tmp14,adep990_rtje_tmp1 ——> adep990_tmp15,adep990_decx_tmp ——> adep990_tmp16
#                                                                      adep990_site_tmp ——> adep990_tmp04,adep990_rtje_tmp ——> adep990_tmp05
#160902-00006#1   2016/09/02 by 06137  日結處理租賃內容時,會取租賃合約上的"管理品類"更新,此次增加條件,如果租賃合約沒取到管理品類時,即不更新日結"管理品類"的欄位,以原本商品取到的管理品類為主
#160922-00005#1   2016/09/22 by 06137  調整 adep990_rtjb_s_p8 ,adep990_rtjb_p8,adep990_rtjb_s_p7 和 adep990_rtjb_p7 的內容
#                                      加入 star_t 與 stas_t 關聯 與 stbh_t 與stbi_t 的關聯
#160819-00054#23  2016/10/13 By lori   1.deca_t/decb_t/decc_t新增欄位:客單價、會員卡號(為PK)
#                                      2.deca_t/decb_t/decc_t計算客單數時需增加會員卡號的維度
#161031-00001#5   2016/11/15 By lori   deca_t新增deca036,deca037, adep990_tmp10對應調整增加此二欄位
#161031-00001#6   2016/11/21 By lori   1.decb_t新增decb021,decb022, adep990_tmp11對應調整增加此二欄位
#                                      2.decc_t新增decb024, adep990_tmp11對應調整增加此欄位
#160819-00054#48  2016/12/13 by sakura 整理 adep990_tmp01 與 adep990_tmp06 的資料時,如該筆資料對應的 "會員編號mmaq003" 為一格空白時,則 "會員卡號rtja001" 也要更新為一格空白
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
        l_type           LIKE type_t.chr10,
        rtjadocdt        LIKE rtja_t.rtjadocdt,
        l_del            LIKE type_t.chr1,
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
   rtjadocdt LIKE rtja_t.rtjadocdt, 
   l_del LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_where         STRING   
DEFINE g_exitstus      LIKE type_t.chr1
DEFINE g_log           STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adep990.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success
   #160111-00006#1 s983961 --add(s)
   IF NOT l_success THEN 
      LET g_log = "-Error#01 : s_aooi500_create_temp() is fail! "
      CALL cl_log_write(g_log)                                                                    
      DISPLAY g_log
   END IF
   #160111-00006#1 s983961 --add(e)
   LET g_exitstus  = 'Y'
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由02開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[02]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      DISPLAY "ls_js:",ls_js
      #end add-point
      CALL adep990_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep990 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep990_init()
 
      #進入選單 Menu (="N")
      CALL adep990_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep990
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #160111-00006#1 s983961 --add(s)
   IF NOT l_success THEN 
      LET g_log = "-Error#02 : s_aooi500_drop_temp() is fail! "
      CALL cl_log_write(g_log)                                                                    
      DISPLAY g_log
   END IF
   #160111-00006#1 s983961 --add(e)
   CALL adep990_drop_temp()
   CALL s_adep101_drop_tmp()  
   IF g_exitstus  = 'N' THEN
      CALL cl_ap_exitprogram("1")
   END IF
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep990.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep990_init()
 
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
   IF g_argv[1] = '7' THEN   
      CALL cl_set_comp_visible("group_qbe,rtjasite",FALSE)
   END IF

   IF g_argv[1] = '0' THEN   
      CALL cl_set_comp_visible("l_del",FALSE)
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adep990.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep990_ui_dialog()
 
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
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjasite
            #add-point:BEFORE FIELD rtjasite name="construct.b.rtjasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjasite
            
            #add-point:AFTER FIELD rtjasite name="construct.a.rtjasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c') 
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO rtjasite  #顯示到畫面上
            NEXT FIELD rtjasite                     #返回原欄位
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.l_del
            BEFORE INPUT
            
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
            CALL adep990_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            IF cl_null(g_master.l_del) THEN
               LET g_master.l_del = 'N'
            END IF
            LET g_master.rtjadocdt = g_today
            DISPLAY BY NAME g_master.l_del,g_master.rtjadocdt
            
            IF g_argv[1] = '7' THEN
               NEXT FIELD rtjadocdt
            END IF
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
         CALL adep990_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_type    = g_argv[1]
      LET lc_param.wc        = g_master.wc
      LET lc_param.rtjadocdt = g_master.rtjadocdt
      LET lc_param.l_del     = g_master.l_del
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
                 CALL adep990_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep990_transfer_argv(ls_js)
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
 
{<section id="adep990.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep990_transfer_argv(ls_js)
 
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
 
{<section id="adep990.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep990_process(ls_js)
 
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
   DEFINE l_wc          STRING
   DEFINE l_where       STRING
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_recountflag LIKE type_t.chr1
   DEFINE l_loop        LIKE type_t.num5
   DEFINE l_msg         STRING
  
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #依aooi500(注意:g_where內容勿更改,如有需要請用l_where)   
   IF lc_param.l_type = '7' THEN
      LET g_where = " 1=1"
   ELSE
      CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING g_where   
   END IF
   CALL adep990_create_temp(ls_js) RETURNING l_success 
   #160111-00006#1 s983961 --add(s)   
   IF NOT l_success THEN   
       LET g_log = "-Error#03: adep990_create_temp fail! Parameters: ls_js(",ls_js,") "   #151027-00016#5 151130 by lori mod #160111-00006#2 160111 By pomelo add#05
       CALL cl_log_write(g_log)
       DISPLAY g_log
   END IF
   #160111-00006#1 s983961 --add(s)
   IF lc_param.l_type = "1" THEN
      CALL s_adep101_create_tmp() RETURNING l_success 
      #160111-00006#1 s983961 --add(s)
      IF NOT l_success THEN 
         LET g_log = "-Error#04 : s_adep101_create_tmp() is fail! "
         CALL cl_log_write(g_log)                                                                    
         DISPLAY g_log
      END IF
      #160111-00006#1 s983961 --add(e)
      CALL s_astp501_create_temp() RETURNING l_success     
      #160111-00006#1 s983961 --add(s)
      IF NOT l_success THEN 
         LET g_log = "-Error#05 : s_astp501_create_temp() is fail! "
         CALL cl_log_write(g_log)                                                                    
         DISPLAY g_log
      END IF
      #160111-00006#1 s983961 --add(e)
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CASE lc_param.l_type
         WHEN '1'
            LET l_loop = 4
         OTHERWISE
            LET l_loop = 3
      END CASE
      CALL cl_progress_bar_no_window(l_loop)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep990_process_cs CURSOR FROM ls_sql
#  FOREACH adep990_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_success = ''
   LET g_exitstus  = 'Y'
   CALL cl_err_collect_init()
     
   CASE lc_param.l_type
      WHEN "0"   #門店日結客單數與客單價批次處理作業(adep102)
         LET l_msg = cl_getmsg('ade-00114',g_lang)   
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            CALL s_transaction_begin()
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','ALL') RETURNING l_success      #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06     
            IF l_success THEN               
               LET l_msg = cl_getmsg('std-00012',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_end('Y','0')
            ELSE
               #160111-00006#1 s983961 --add(s)
               #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               LET g_log = "-Error#06 : CALL s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"), adep990_tmp06, ALL "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'
            END IF
         ELSE 
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#90 : CALL adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e)
            LET g_exitstus  = 'N'
         END IF
      WHEN "1"   #單品日結批次(原adep100)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp(ls_js) THEN
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            IF adep990_ins_temp_1(ls_js) THEN
               CALL adep990_ins_table_1(ls_js) RETURNING l_success,l_recountflag
               IF NOT l_success THEN              
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#07 : CALL adep990_ins_table_1 fail! Parameters: ls_js(",ls_js,")  "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e)               
                  LET g_exitstus  = 'N'               
                  EXIT CASE
               END IF
            ELSE
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#91 : CALL adep990_ins_temp_1 fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)  
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
         ELSE
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#92 : CALL adep990_ins_temp fail! Parameters: ls_js(",ls_js,")  "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e)
            LET g_exitstus  = 'N'
            EXIT CASE
         END IF  
         
         IF ( lc_param.l_del = 'Y' AND l_recountflag = 'Y' ) OR
            lc_param.l_del = 'X' THEN 
            LET l_msg = cl_getmsg('ade-00159',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            
            LET l_wc = cl_replace_str(lc_param.wc,'rtjasite','debasite')
            CALL s_astp501_extand_data(l_wc,lc_param.rtjadocdt)
            #IF NOT s_astp501_data_process('2',l_wc,lc_param.rtjadocdt,lc_param.l_del) THEN   #151029-00011#15 2015/11/30 by benson
            IF NOT s_astp501_data_process('2',l_wc,lc_param.rtjadocdt,'Y') THEN               #151029-00011#15 2015/11/30 by benson
               #160111-00006#1 s983961 --add(s)   
               LET g_log = "-Error#86: CALL s_astp501_data_process fail! Parameters: 專櫃促銷扣率成本(2),QBE條件(",l_wc,"),統計日期(",lc_param.rtjadocdt,"),是否刪除已結算過的資料(Y) "   
               CALL cl_log_write(g_log)
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)   
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF

            #IF NOT s_astp501_data_process('1',l_wc,lc_param.rtjadocdt,lc_param.l_del) THEN   #151029-00011#15 2015/11/30 by benson
            IF NOT s_astp501_data_process('1',l_wc,lc_param.rtjadocdt,'Y') THEN               #151029-00011#15 2015/11/30 by benson
               #160111-00006#1 s983961 --add(s)   
               LET g_log = "-Error#87: CALL s_astp501_data_process fail! Parameters: 專櫃合同扣率成本(1),QBE條件(",l_wc,"),統計日期(",lc_param.rtjadocdt,"),是否刪除已結算過的資料(Y) "   
               CALL cl_log_write(g_log)
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)  
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
            
            IF NOT adep990_ins_temp_rtje(ls_js) THEN
               #160111-00006#1 s983961 --add(s)   
               LET g_log = "-Error#88: CALL adep990_ins_temp_rtje fail! Parameters: ls_js(",ls_js,") "   
               CALL cl_log_write(g_log)
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)  
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
            
            IF NOT s_adep103_ins_temp(ls_js) THEN
               #160111-00006#1 s983961 --add(s)   
               LET g_log = "-Error#89: CALL s_adep103_ins_temp fail! Parameters: ls_js(",ls_js,") "   
               CALL cl_log_write(g_log)
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)  
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
            
            #160512-00019#1 Add By Ken 160517(S)   
            IF NOT s_adep103_ins_decx_tmp(ls_js) THEN  
               LET g_log = "-Error#89: CALL s_adep103_ins_decx_temp fail! Parameters: ls_js(",ls_js,") "   
               CALL cl_log_write(g_log)
               DISPLAY g_log
            
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF            
            #160512-00019#1 Add By Ken 160517(E)  
            
            CALL s_transaction_begin()
            CALL s_adep991_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#08 : CALL s_adep991_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF 
            
            CALL s_adep994_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#09 : CALL s_adep994_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF 
            
            CALL s_adep995_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#10 : CALL s_adep995_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF
            
            CALL s_adep996_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#11 : CALL s_adep996_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'               
               EXIT CASE 
            END IF
            
            CALL s_adep997_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#12 : CALL s_adep997_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'               
               EXIT CASE 
            END IF
            
            CALL s_adep998_ins_table(ls_js) RETURNING l_success  
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#13 : CALL s_adep998_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF  
    
            CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp01','ALL') RETURNING l_success   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#14 : CALL s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp01,prog(ALL)  "  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF
            
            CALL s_adep103_ins_table(ls_js) RETURNING l_success               
            IF NOT l_success THEN   
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#15 : CALL s_adep103_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF 
                        
            #160512-00019#1 Add By Ken 160517(S)   
            CALL s_adep103_ins_decx(ls_js) RETURNING l_success               
            IF NOT l_success THEN   
               LET g_log = "-Error#15 : CALL s_adep103_ins_decx fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF            
            #160512-00019#1 Add By Ken 160517(E) 
            
            CALL s_transaction_end('Y','0')
         ELSE
            #呼叫兩次 是為了讓結束後,可以達到100%
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         LET l_msg = cl_getmsg('std-00012',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
      WHEN "2"   #品類日結批次(原adep105)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_begin()
            CALL s_adep991_ins_table(ls_js) RETURNING l_success         
            IF NOT l_success THEN
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#16 : CALL s_adep991_ins_table fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
            CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','adep105') RETURNING l_success   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               LET g_log = "-Error#17 : CALL s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp06,prog(adep105) "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','0')
         ELSE 
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#93 : CALL adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,")  "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e) 
            LET g_exitstus  = 'N'
         END IF 

      WHEN "3"   #庫區日結批次(原adep110)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            IF adep990_ins_temp_rtje(ls_js) THEN
               LET l_msg = cl_getmsg('ast-00330',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_begin()
               CALL s_adep994_ins_table(ls_js) RETURNING l_success               
               IF NOT l_success THEN   
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#18 : CALL s_adep994_ins_table fail! Parameters: ls_js(",ls_js,") "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0')
                  LET g_exitstus  = 'N'
                  EXIT CASE
               END IF    
               CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','adep110') RETURNING l_success   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               IF NOT l_success THEN 
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#19 : s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp06,prog(adep110) "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0') 
                  LET g_exitstus  = 'N'
                  EXIT CASE 
               END IF
               LET l_msg = cl_getmsg('std-00012',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_end('Y','0')
            ELSE
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#94 : CALL adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,")  "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e)
               LET g_exitstus  = 'N'
            END IF
         ELSE
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#100 : CALL adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e) 
            LET g_exitstus  = 'N'
         END IF
      WHEN "4"   #門店銷售專櫃日結批次(原adep120)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            IF adep990_ins_temp_rtje(ls_js) THEN
               LET l_msg = cl_getmsg('ast-00330',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_begin()
               CALL s_adep995_ins_table(ls_js) RETURNING l_success               
               IF NOT l_success THEN   
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#20 : s_adep995_ins_table fail! Parameters: ls_js(",ls_js,") "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0')
                  LET g_exitstus  = 'N'
                  EXIT CASE
               END IF    
               CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','adep120') RETURNING l_success  
               IF NOT l_success THEN 
                  #160111-00006#1 s983961 --add(s)
                  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
                  LET g_log = "-Error#21 : s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp06,prog(adep120) "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0') 
                  LET g_exitstus  = 'N'
                  EXIT CASE 
               END IF
               LET l_msg = cl_getmsg('std-00012',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_end('Y','0')
            ELSE
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#95 : CALL adep990_ins_temp_rtje fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               LET g_exitstus  = 'N'
            END IF
         ELSE
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#96 : adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e) 
            LET g_exitstus  = 'N'
         END IF
      WHEN "5"   #門店銷售部門日結批次(原adep125)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp(ls_js) THEN
            IF adep990_ins_temp_rtje(ls_js) THEN
               LET l_msg = cl_getmsg('ast-00330',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_begin()
               CALL s_adep996_ins_table(ls_js) RETURNING l_success               
               IF NOT l_success THEN   
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#22 : CALL s_adep996_ins_table fail! Parameters: ls_js(",ls_js,") "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0')
                  LET g_exitstus  = 'N'
                  EXIT CASE
               END IF 
               LET l_msg = cl_getmsg('std-00012',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_end('Y','0')
            ELSE 
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#97 : CALL adep990_ins_temp_rtje fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               LET g_exitstus  = 'N'
            END IF
         ELSE 
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#98 : CALL adep990_ins_temp fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e) 
            LET g_exitstus  = 'N'
         END IF
      WHEN "6"   #門店日結批次(原adep130)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            IF adep990_ins_temp_rtje(ls_js) THEN
               LET l_msg = cl_getmsg('ast-00330',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_begin()
               CALL s_adep997_ins_table(ls_js) RETURNING l_success               
               IF NOT l_success THEN   
                  #160111-00006#1 s983961 --add(s)
                  LET g_log = "-Error#23 : s_adep997_ins_table fail! Parameters: ls_js(",ls_js,") "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0')
                  LET g_exitstus  = 'N'
                  EXIT CASE
               END IF    
               CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','adep130') RETURNING l_success   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               IF NOT l_success THEN 
                  #160111-00006#1 s983961 --add(s)
                  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
                  LET g_log = "-Error#24 : s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp06,prog(adep130) "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  #160111-00006#1 s983961 --add(e) 
                  CALL s_transaction_end('N','0') 
                  LET g_exitstus  = 'N'
                  EXIT CASE 
               END IF
               LET l_msg = cl_getmsg('std-00012',g_lang)
               CALL cl_progress_no_window_ing(l_msg)
               CALL s_transaction_end('Y','0')
            ELSE
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#99 : CALL adep990_ins_temp_rtje fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               LET g_exitstus  = 'N'
            END IF
         ELSE
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#101 : CALL adep990_ins_temp_s fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e)
            LET g_exitstus  = 'N'
         END IF           
      WHEN "7"   #會員日結批次(原adep135)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp(ls_js) THEN
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_begin()
            CALL s_adep999_ins_table(ls_js) RETURNING l_success               
            IF NOT l_success THEN   
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#25 : s_adep999_ins_table fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF 
            
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','0')
         ELSE
            #160111-00006#1 s983961 --add(s)
            LET g_log = "-Error#102 : CALL s_adep999_ins_table fail! Parameters: ls_js(",ls_js,") "
            CALL cl_log_write(g_log)                                                                    
            DISPLAY g_log
            #160111-00006#1 s983961 --add(e) 
            LET g_exitstus  = 'N'
         END IF            
      WHEN "8"   #門店商品品類日結批次(原adep108)
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF adep990_ins_temp_s(ls_js) THEN
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_begin()
            CALL s_adep998_ins_table(ls_js) RETURNING l_success         
            IF NOT l_success THEN
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#26 :CALL adep990_ins_temp fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF
            CALL s_adep990_upd_doc_qty_price(ls_js,'adep990_tmp06','adep108') RETURNING l_success   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
            IF NOT l_success THEN 
               #160111-00006#1 s983961 --add(s)
               #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               LET g_log = "-Error#27 : s_adep990_upd_doc_qty_price fail! Parameters: ls_js(",ls_js,"),adep990_tmp06,prog(adep108) "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0') 
               LET g_exitstus  = 'N'
               EXIT CASE 
            END IF
           
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','0')
         ELSE
            LET g_exitstus  = 'N'
         END IF 
         
      WHEN "10"   #門店單品銷售核銷供應商日結批次作業
         LET l_msg = cl_getmsg('ade-00114',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
         IF s_adep103_ins_temp(ls_js) THEN
            LET l_msg = cl_getmsg('ast-00330',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_begin()
            CALL s_adep103_ins_table(ls_js) RETURNING l_success               
            IF NOT l_success THEN   
               #160111-00006#1 s983961 --add(s)
               LET g_log = "-Error#28 : CALL s_adep103_ins_table fail! Parameters: ls_js(",ls_js,") "
               CALL cl_log_write(g_log)                                                                    
               DISPLAY g_log
               #160111-00006#1 s983961 --add(e) 
               CALL s_transaction_end('N','0')
               LET g_exitstus  = 'N'
               EXIT CASE
            END IF 
            
            LET l_msg = cl_getmsg('std-00012',g_lang)
            CALL cl_progress_no_window_ing(l_msg)
            CALL s_transaction_end('Y','0')
            
            #160512-00019#1 Add By Ken 160517(S)    
            IF s_adep103_ins_decx_tmp(ls_js) THEN
               CALL s_transaction_begin()
               CALL s_adep103_ins_decx(ls_js) RETURNING l_success               
               IF NOT l_success THEN   
                  LET g_log = "-Error#28 : CALL s_adep103_ins_decx fail! Parameters: ls_js(",ls_js,") "
                  CALL cl_log_write(g_log)                                                                    
                  DISPLAY g_log
                  CALL s_transaction_end('N','0')
                  LET g_exitstus  = 'N'
                  EXIT CASE
               END IF  
               CALL s_transaction_end('Y','0')               
            END IF
            #160512-00019#1 Add By Ken 160517(E)   
         ELSE
            LET g_exitstus  = 'N'
         END IF  

   END CASE
   
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
   CALL adep990_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep990.get_buffer" >}
PRIVATE FUNCTION adep990_get_buffer(p_dialog)
 
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
 
{<section id="adep990.msgcentre_notify" >}
PRIVATE FUNCTION adep990_msgcentre_notify()
 
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
 
{<section id="adep990.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION adep990_create_temp(ps_js)
   DEFINE ps_js        STRING
   DEFINE r_success    LIKE type_t.num5
   DEFINE lc_param    type_parameter
   
   CALL util.JSON.parse(ps_js,lc_param)
   
   LET r_success = TRUE
   
   CALL adep990_drop_temp()  
   
   IF lc_param.l_type = '1' OR lc_param.l_type = '5' OR lc_param.l_type = '7' THEN              
      CREATE TEMP TABLE adep990_tmp01(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
         rtjbent        SMALLINT,
         rtjbsite       VARCHAR(10),
         rtjadocdt      DATE,  
         rtjbdocno      VARCHAR(20),  
         rtjbseq        INTEGER,    
         mmag004        VARCHAR(10),    
         mmaq002        VARCHAR(10),    
         mmaq003        VARCHAR(30),    
         rtja005        VARCHAR(10),    
         rtja032        VARCHAR(10),    
         rtjb003        VARCHAR(40),    
         rtjb004        VARCHAR(40),    
         imaa126        VARCHAR(10),    
         imaa009        VARCHAR(10),         #商品品類 
         imaf153        VARCHAR(10),    
         rtjb006        VARCHAR(10),    
         rtjb008        DECIMAL(20,6),    
         rtjb009        DECIMAL(20,6),    
         rtjb010        DECIMAL(20,6),    
         rtjb011        DECIMAL(20,6),    
         rtjb012        DECIMAL(20,6),    
         rtjb013        VARCHAR(10),    
         rtjb020        DECIMAL(20,6),    
         rtjb021        DECIMAL(20,6),    
         rtjb022        DECIMAL(20,6),    
         rtjb023        DECIMAL(20,6),    
         rtjb025        VARCHAR(10),    
         rtjb028        VARCHAR(20),    
         rtjb029        DECIMAL(15,3),    
         rtje006        DECIMAL(20,6),    
         rtja026        VARCHAR(10),    
         rtjb005        VARCHAR(256),    
         rtdx003        VARCHAR(10),    
         rtdx034        DECIMAL(20,6),         #最新進價      
         stbh001        VARCHAR(20),         #促銷協議-合约编号 
         stbh004        VARCHAR(10),         #促銷協議-結算方式
         stbi017        DECIMAL(20,6),         #促銷協議-結算扣率
         star004        VARCHAR(20),         #採購協議-合約編號
         star006        VARCHAR(10),         #採購協議-结算方式
         stas025        DECIMAL(20,6),         #採購協議-結算扣率
         rtax001        VARCHAR(10),         #管理品類
         rtja001        VARCHAR(30),         #會員卡號
         rtjf031        DECIMAL(20,6),         #抵扣券金額 
         rtjc013        DECIMAL(20,6),         #折讓金額      
         rtib023        DECIMAL(20,6),         #銷售成本
         imaa104        VARCHAR(10),         #庫存單位(主條碼單位)                #160107-00021#1 2016/01/08 By benson
         mainqty        DECIMAL(20,6)     #庫存單位銷售數量(主條碼單位銷售數量)  #160107-00021#1 2016/01/08 By benson
      )                                       
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#29 : CREATE TEMP adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)        
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   IF lc_param.l_type = '1' THEN
      CREATE TEMP TABLE adep990_tmp02(    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         debaent         SMALLINT,
         debasite        VARCHAR(10),
         deba001         VARCHAR(10),
         deba002         DATE,
         deba003         SMALLINT,
         deba004         SMALLINT,
         deba005         VARCHAR(10),
         deba006         VARCHAR(10),
         deba007         VARCHAR(10),
         deba008         VARCHAR(10),
         deba009         VARCHAR(40),
         deba010         VARCHAR(40),
         deba011         VARCHAR(255),
         deba012         VARCHAR(255),
         deba013         VARCHAR(20),
         deba014         VARCHAR(10),
         deba015         VARCHAR(10),
         deba016         VARCHAR(10),
         deba017         VARCHAR(20),
         deba018         VARCHAR(10),
         deba019         DECIMAL(20,6),
         deba020         VARCHAR(10),
         deba021         DECIMAL(20,6),
         deba022         DECIMAL(20,6),
         deba023         DECIMAL(20,6),
         deba024         DECIMAL(20,6),
         deba025         DECIMAL(20,6),
         deba026         DECIMAL(20,6),
         deba027         DECIMAL(20,6),
         deba028         DECIMAL(20,6),
         deba029         DECIMAL(20,6),
         deba030         DECIMAL(20,6),
         deba031         DECIMAL(20,6),
         deba032         DECIMAL(20,6),
         deba033         DECIMAL(20,6),
         deba034         DECIMAL(20,6),
         deba035         DECIMAL(20,6),
         deba036         DECIMAL(20,6),
         deba037         DECIMAL(20,6),
         deba038         DECIMAL(20,6),
         deba039         DECIMAL(20,6),
         deba040         DECIMAL(20,6),
         deba041         SMALLINT,    
         deba042         SMALLINT,    
         deba043         VARCHAR(256),    
         deba044         DECIMAL(20,6),    
         deba045         DECIMAL(20,6),    
         deba046         DECIMAL(20,6),    
         deba047         DECIMAL(20,6),    
         deba048         DECIMAL(20,6),    
         deba050         DECIMAL(20,6),   
         deba051         DECIMAL(20,6),   
         deba052         DECIMAL(20,6),
         deba053         VARCHAR(10),
         rtdx003         VARCHAR(10),
         stbh001         VARCHAR(20)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#30 : adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)       
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp02"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #建index
      CREATE INDEX adep990_tmp02_01 on adep990_tmp02(debaent,debasite,deba002)   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02         
         LET g_log = "--Error#31 : CREATE INDEX adep990_tmp02_01 on adep990_tmp02(debaent,debasite,deba002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)   
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp02_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      CREATE TEMP TABLE adep990_tmp03(     #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
         debbent      SMALLINT,
         debbsite     VARCHAR(10),
         debb001      VARCHAR(10),
         debb002      DATE,
         debb003      SMALLINT,
         debb004      SMALLINT,
         debb005      VARCHAR(10),
         debb006      VARCHAR(10),
         debb007      VARCHAR(10),
         debb008      VARCHAR(10),
         debb009      VARCHAR(40),
         debb010      VARCHAR(40),
         debb011      VARCHAR(255),
         debb012      VARCHAR(255),
         debb013      VARCHAR(20),
         debb014      VARCHAR(10),
         debb015      VARCHAR(10),
         debb016      VARCHAR(10),
         debb017      VARCHAR(20),
         debb018      VARCHAR(10),
         debb019      VARCHAR(10),
         debb020      VARCHAR(10),
         debb021      VARCHAR(10),
         debb022      DECIMAL(20,6),
         debb023      DECIMAL(20,6),
         debb024      DECIMAL(20,6),
         debb025      DECIMAL(20,6),
         debb026      DECIMAL(20,6),
         debb027      DECIMAL(20,6),
         debb028      DECIMAL(20,6),
         debb029      DECIMAL(20,6),
         debb030      DECIMAL(22,2),
         debb031      DECIMAL(20,6),
         debb032      DECIMAL(20,6),
         debb033      DECIMAL(20,6),
         debb034      DECIMAL(20,6),
         debb035      VARCHAR(256),
         debb036      DECIMAL(20,6),
         debb038      VARCHAR(10),
         rtdx003      VARCHAR(10),
         stbh001      VARCHAR(20)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#32 : adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp03"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp03_01 on adep990_tmp03(debbent,debbsite,debb002)   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)  
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03         
         LET g_log = "--Error#33 : CREATE INDEX adep990_tmp03_01 on adep990_tmp03(debbent,debbsite,debb002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)   
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp03_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
   END IF
   
   CREATE TEMP TABLE adep990_tmp04(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04
      ls_site       VARCHAR(10)
   )
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#34 : CREATE TEMP adep990_tmp04 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE TEMP adep990_tmp04"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #建index
   CREATE INDEX adep990_tmp04_01 on adep990_tmp04(ls_site)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s) 
      #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04      
      LET g_log = "--Error#35 : CREATE INDEX adep990_tmp04_01 on adep990_tmp04(ls_site) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep990_tmp04_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF        

   IF lc_param.l_type = '1' OR lc_param.l_type = '3' OR lc_param.l_type = '4' OR
      lc_param.l_type = '5' OR lc_param.l_type = '6' THEN
      CREATE TEMP TABLE adep990_tmp05(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
        rtjeent     SMALLINT,
        rtjesite    VARCHAR(10),
        rtjadocdt   DATE,
        rtjb025     VARCHAR(10),     
        rtja005     VARCHAR(10),     
        imaa009     VARCHAR(10),     
        rtjb028     VARCHAR(20),     
        rtjb006     VARCHAR(10),     
        rtje001     VARCHAR(10),     
        rtje002     VARCHAR(10),     
        rtje006     DECIMAL(20,6),     
        rtja026     VARCHAR(10)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#36 : CREATE TEMP adep990_tmp05 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05 
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp05"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp05_01 on adep990_tmp05(rtjeent,rtjadocdt,rtjesite)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp05_01"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   
   IF lc_param.l_type = '0' OR lc_param.l_type = '2' OR lc_param.l_type = '3' OR
      lc_param.l_type = '4' OR lc_param.l_type = '6' OR lc_param.l_type = '8' THEN
      CREATE TEMP TABLE adep990_tmp06(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
         rtjbent        SMALLINT,          #企業
         rtjbsite       VARCHAR(10),         #組織
         rtjadocdt      DATE,        #單據
         rtjbdocno      VARCHAR(20),        #日期
         rtjbseq        INTEGER,          #項次
         rtja001        VARCHAR(30),          #會員卡號
         mmag004        VARCHAR(10),          #會員等級
         mmaq002        VARCHAR(10),          #會員卡種
         mmaq003        VARCHAR(30),          #會員編號
         rtja005        VARCHAR(10),          #業務部門 
         rtjb004        VARCHAR(40),          #商品編號
         imaa126        VARCHAR(10),          #品牌
         imaa009        VARCHAR(10),          #品類
         imaf153        VARCHAR(10),          #供應商
         rtjb006        VARCHAR(10),          #稅別編號
         rtjb013        VARCHAR(10),          #銷售單位
         rtjb025        VARCHAR(10),          #庫區
         rtjb028        VARCHAR(20),          #專櫃編號
         rtja026        VARCHAR(10),          #交易幣別
         rtjb005        VARCHAR(256),          #特徵碼 
         rtdx003        VARCHAR(10),          #經營方式   
         stbh001        VARCHAR(20),          #合约编号 
         stbh004        VARCHAR(10),          #結算方式
         rtax001        VARCHAR(10),          #品類編號 
         rtjb012        DECIMAL(20,6)
      )                                       
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#37 : CREATE TEMP adep990_tmp06 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e) 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp06"    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   IF lc_param.l_type = '1' OR lc_param.l_type = '5' THEN
      CREATE TEMP TABLE adep990_tmp07(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
         debkent   SMALLINT,
         debksite  VARCHAR(10),  
         debk001   VARCHAR(10),
         debk002   DATE, 
         debk003   SMALLINT, 
         debk004   SMALLINT, 
         debk005   VARCHAR(10), 
         debk006   DECIMAL(20,6), 
         debk007   DECIMAL(20,6),
         debk008   DECIMAL(20,6), 
         debk009   DECIMAL(20,6), 
         debk010   DECIMAL(20,6), 
         debk011   DECIMAL(20,6), 
         debk012   DECIMAL(20,6), 
         debk013   DECIMAL(20,6),
         debk014   DECIMAL(20,6),
         debk015   DECIMAL(20,6),
         debk016   DECIMAL(20,6), 
         debk017   DECIMAL(20,6),
         debk018   DECIMAL(20,6), 
         debk019   DECIMAL(20,6), 
         debk020   DECIMAL(20,6),
         debk021   DECIMAL(20,6), 
         debk022   DECIMAL(20,6), 
         debk023   DECIMAL(20,6)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#38 : CREATE TEMP adep990_tmp07 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp07"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp07_01 on adep990_tmp07(debkent,debksite,debk002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)  
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07         
         LET g_log = "--Error#39 : CREATE INDEX adep990_tmp07_01 on adep990_tmp07(debkent,debksite,debk002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp07_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
   
      CREATE TEMP TABLE adep990_tmp08(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
         deblent   SMALLINT,
         deblsite  VARCHAR(10),  
         debl001   VARCHAR(10),
         debl002   DATE, 
         debl003   SMALLINT, 
         debl004   SMALLINT, 
         debl005   VARCHAR(10), 
         debl006   VARCHAR(10), 
         debl007   VARCHAR(10),
         debl008   DECIMAL(20,6), 
         debl009   DECIMAL(20,6), 
         debl010   DECIMAL(20,6), 
         debl011   DECIMAL(20,6), 
         debl012   DECIMAL(20,6), 
         debl013   DECIMAL(20,6),
         debl014   DECIMAL(20,6),
         debl015   DECIMAL(20,6),
         debl016   DECIMAL(22,2), 
         debl017   DECIMAL(20,6),
         debl018   DECIMAL(20,6), 
         debl019   DECIMAL(20,6), 
         debl020   DECIMAL(20,6)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#40 : CREATE TEMP adep990_tmp08 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp08"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp08_01 on adep990_tmp08(deblent,deblsite,debl002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s) 
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08         
         LET g_log = "--Error#41 : CREATE INDEX adep990_tmp08_01 on adep990_tmp08(deblent,deblsite,debl002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp08_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
      CREATE TEMP TABLE adep990_tmp09(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
         debment   SMALLINT,
         debmsite  VARCHAR(10),  
         debm001   VARCHAR(10),
         debm002   DATE, 
         debm003   SMALLINT, 
         debm004   SMALLINT, 
         debm005   VARCHAR(10), 
         debm006   VARCHAR(10), 
         debm007   VARCHAR(10),
         debm008   DECIMAL(20,6)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#42 : CREATE TEMP adep990_tmp09 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp09"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF

      #建index
      CREATE INDEX adep990_tmp09_01 on adep990_tmp09(debment,debmsite,debm002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09         
         LET g_log = "--Error#43 : CREATE INDEX adep990_tmp09_01 on adep990_tmp09(debment,debmsite,debm002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp09_01"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
   END IF
   
   IF lc_param.l_type = '7' THEN
      CREATE TEMP TABLE adep990_tmp10(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
         decaent   SMALLINT,
         decasite  VARCHAR(10),  
         deca001   VARCHAR(10),
         deca002   DATE, 
         deca003   SMALLINT, 
         deca004   SMALLINT, 
         deca005   VARCHAR(10), 
         deca006   VARCHAR(10), 
         deca007   VARCHAR(10),
         deca008   VARCHAR(10), 
         deca009   VARCHAR(40), 
         deca010   VARCHAR(40), 
         deca011   VARCHAR(255), 
         deca012   VARCHAR(255), 
         deca013   VARCHAR(20),
         deca014   VARCHAR(10),
         deca015   VARCHAR(10),
         deca016   VARCHAR(10), 
         deca017   VARCHAR(20),
         deca018   VARCHAR(10), 
         deca019   VARCHAR(10), 
         deca020   VARCHAR(30),
         deca021   VARCHAR(10), 
         deca022   DECIMAL(20,6), 
         deca023   DECIMAL(20,6),
         deca024   DECIMAL(20,6),
         deca025   DECIMAL(20,6),
         deca026   DECIMAL(20,6),
         deca027   DECIMAL(20,6),
         deca028   DECIMAL(20,6),
         deca029   DECIMAL(20,6),
         deca030   DECIMAL(22,2),
         deca031   DECIMAL(20,6),
         deca032   DECIMAL(20,6),
         deca033   DECIMAL(20,6),
         deca034   DECIMAL(20,6),        #160819-00054#23 161013 by lori add       
         deca035   VARCHAR(30),        #160819-00054#23 161013 by lori add         
         deca036   DECIMAL(20,6),        #161031-00001#5  161116 by lori add
         deca037   DECIMAL(20,6)     #161031-00001#5  161116 by lori add
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#44 : CREATE TEMP adep990_tmp10 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp10"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp10_01 on adep990_tmp10(decaent,decasite,deca002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)  
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10         
         LET g_log = "--Error#45 : CREATE INDEX adep990_tmp10_01 on adep990_tmp10(decaent,decasite,deca002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp10_01"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
      #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
      CREATE INDEX adep990_tmp10_02 on adep990_tmp10(decaent,decasite,deca002,deca005,deca009,deca017,deca018,deca019,deca020)
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10         
         LET g_log = "--Error#46 : CREATE INDEX adep990_tmp10_02 on adep990_tmp10(decaent,decasite,deca002,deca005,deca009,deca017,deca018,deca019,deca020) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp10_02"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
      
      #EXECUTE IMMEDIATE "analyze table adep990_deca_tmp estimate statistics"
      IF cl_db_generate_analyze("adep990_tmp10") THEN END IF  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
      
      CREATE TEMP TABLE adep990_tmp11(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
         decbent   SMALLINT,
         decbsite  VARCHAR(10),  
         decb001   VARCHAR(10),
         decb002   DATE, 
         decb003   SMALLINT, 
         decb004   SMALLINT, 
         decb005   VARCHAR(30), 
         decb006   VARCHAR(10), 
         decb007   DECIMAL(20,6),
         decb008   DECIMAL(20,6), 
         decb009   DECIMAL(20,6), 
         decb010   DECIMAL(20,6), 
         decb011   DECIMAL(20,6), 
         decb012   DECIMAL(20,6), 
         decb013   DECIMAL(20,6),
         decb014   DECIMAL(20,6),
         decb015   DECIMAL(22,2),
         decb016   DECIMAL(20,6), 
         decb017   DECIMAL(20,6),
         decb018   DECIMAL(20,6),
         decb019   DECIMAL(20,6),        #160819-00054#23 161013 by lori add       
         decb020   VARCHAR(30),        #160819-00054#23 161013 by lori add       
         decb021   DECIMAL(20,6),        #161031-00001#6  161121 by lori add
         decb022   DECIMAL(20,6)     #161031-00001#6  161121 by lori add
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#47 : CREATE TEMP adep990_tmp11 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11 
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp11"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp11_01 on adep990_tmp11(decbent,decbsite,decb002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11         
         LET g_log = "--Error#48 : CREATE INDEX adep990_tmp11_01 on adep990_tmp11(decbent,decbsite,decb002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp11_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF     
      
      CREATE TEMP TABLE adep990_tmp12(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
         deccent   SMALLINT, 
         decc001   VARCHAR(30),
         decc002   DATE, 
         decc003   SMALLINT, 
         decc004   SMALLINT, 
         decc005   DECIMAL(20,6), 
         decc006   DECIMAL(20,6), 
         decc007   DECIMAL(20,6),
         decc008   DECIMAL(20,6), 
         decc009   DECIMAL(20,6), 
         decc010   DECIMAL(20,6), 
         decc011   DECIMAL(20,6), 
         decc012   DECIMAL(20,6), 
         decc013   DECIMAL(20,6),
         decc014   DECIMAL(20,6),
         decc015   DECIMAL(20,6),
         decc016   DECIMAL(20,6), 
         decc017   DECIMAL(20,6),
         decc018   DECIMAL(20,6),
         decc019   DECIMAL(20,6), 
         decc020   DECIMAL(20,6), 
         decc021   DECIMAL(20,6),
         decc022   DECIMAL(20,6),        #160819-00054#23 161013 by lori add       
         decc023   VARCHAR(30),        #160819-00054#23 161013 by lori add   
         decc024   DECIMAL(20,6)     #161031-00001#6  161121 by lori add         
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#49 : CREATE TEMP adep990_tmp12 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12 
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp12"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      #建index
      CREATE INDEX adep990_tmp12_01 on adep990_tmp12(deccent,decc002)  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s) 
         #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12         
         LET g_log = "--Error#50 : CREATE INDEX adep990_tmp12_01 on adep990_tmp12(deccent,decc002) fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE INDEX adep990_tmp12_01"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF   
   END IF      
   
   IF lc_param.l_type = '1' OR lc_param.l_type = '10' THEN 
      CREATE TEMP TABLE adep990_tmp13(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debf_tmp ——> adep990_tmp13
         debfent         SMALLINT,
         debfsite        VARCHAR(10),
         debf001         VARCHAR(10),
         debf002         DATE,
         debf003         SMALLINT,
         debf004         SMALLINT,
         debf005         VARCHAR(10),
         debf006         VARCHAR(10),
         debf007         VARCHAR(10),
         debf008         VARCHAR(10),
         debf009         VARCHAR(40),
         debf010         VARCHAR(40),
         debf011         VARCHAR(255),
         debf012         VARCHAR(255),
         debf013         VARCHAR(20),
         debf014         VARCHAR(10),
         debf015         VARCHAR(10),
         debf016         VARCHAR(10),
         debf017         VARCHAR(20),
         debf018         VARCHAR(10),
         debf019         DECIMAL(20,6),
         debf020         VARCHAR(10),
         debf021         DECIMAL(20,6),
         debf022         DECIMAL(20,6),
         debf023         DECIMAL(20,6),
         debf024         DECIMAL(20,6),
         debf025         DECIMAL(20,6),
         debf026         DECIMAL(20,6),
         debf027         DECIMAL(20,6),
         debf028         DECIMAL(20,6),
         debf030         DECIMAL(20,6),
         debf031         DECIMAL(20,6),
         debf032         DECIMAL(20,6),
         debf033         DECIMAL(20,6),
         debf034         DECIMAL(20,6),
         debf035         DECIMAL(20,6),
         debf036         DECIMAL(20,6),
         debf037         DECIMAL(20,6),
         debf038         DECIMAL(20,6),
         debf039         DECIMAL(20,6),
         debf040         DECIMAL(20,6),
         debf041         SMALLINT,    
         debf042         SMALLINT,    
         debf043         VARCHAR(256),      
         debf045         DECIMAL(20,6),    
         debf046         DECIMAL(20,6),    
         debf047         DECIMAL(20,6),    
         debf049         VARCHAR(10),    
         debf053         VARCHAR(10),
         seq             SMALLINT
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#51 : CREATE TEMP adep990_tmp13 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debf_tmp ——> adep990_tmp13
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp13"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debf_tmp ——> adep990_tmp13
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      CREATE TEMP TABLE adep990_tmp14(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtib_tmp ——> adep990_tmp14
         rtibent         SMALLINT,
         rtibsite        VARCHAR(10),
         rtiadocdt       DATE,
         seq             SMALLINT,            #和adep990_debf_temp對應
         seq1            SMALLINT,            #rtin匯總後,不同供應商的項序 
         lastone         VARCHAR(1),            #條件相同下的最後一筆
         rtib004         VARCHAR(40),
         rtib006         VARCHAR(10),
         rtib005         VARCHAR(256),
         rtib013         VARCHAR(10),
         rtib012         DECIMAL(20,6),
         rtin009         DECIMAL(20,6),
         inad010         VARCHAR(10),
         totqty          DECIMAL(20,6)
      )
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#52 : CREATE TEMP adep990_tmp14 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtib_tmp ——> adep990_tmp14
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp14"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtib_tmp ——> adep990_tmp14
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      
      #160512-00019#1 Add By Ken 160517(S)
      CREATE TEMP TABLE adep990_tmp15(   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp1 ——> adep990_tmp15
         rtjaent         SMALLINT,
         rtjasite        VARCHAR(10),
         rtjadocdt       DATE,
         rtjb004         VARCHAR(40),         #商品編號
         rtjb005         VARCHAR(256),         #產品特微
         rtjb013         VARCHAR(10),         #銷售單位
         rtje001         VARCHAR(10),         #款別分類
         rtje002         VARCHAR(10),         #款別編號
         rtje003         DECIMAL(20,6),         #收款金額
         rtjb012         DECIMAL(20,6),         #銷售數量
         s_rtjb012       DECIMAL(20,6)     #銷售數量(商品總量)
      )
      IF SQLCA.SQLcode THEN                                  
         LET g_log = "--Error#52 : CREATE TEMP adep990_tmp15 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp1 ——> adep990_tmp15
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp15"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp1 ——> adep990_tmp15
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      
      CREATE TEMP TABLE adep990_tmp16(  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decx_tmp ——> adep990_tmp16
         decxent         SMALLINT, 
         decxsite        VARCHAR(10), 
         decx001         VARCHAR(10),
         decx002         DATE, 
         decx003         SMALLINT,  
         decx004         SMALLINT, 
         decx005         VARCHAR(10),  
         decx006         VARCHAR(10), 
         decx007         VARCHAR(10), 
         decx008         DECIMAL(20,6),
         imaa001         VARCHAR(40)
      )
      IF SQLCA.SQLcode THEN                                  
         LET g_log = "--Error#52 : CREATE TEMP adep990_tmp16 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decx_tmp ——> adep990_tmp16
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "CREATE TEMP adep990_tmp16"  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decx_tmp ——> adep990_tmp16
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF       
      #160512-00019#1 Add By Ken 160517(E)      
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adep990_ins_temp(ps_js)
   DEFINE ps_js       STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE lc_param    type_parameter
   DEFINE l_cnt       LIKE type_t.num20_6
   DEFINE l_rtjb    RECORD
            rtjbent     LIKE rtjb_t.rtjbent,   #160107-00021#1 2016/01/08 By benson
            rtjbsite    LIKE rtjb_t.rtjbsite,
            rtjadocdt   LIKE rtja_t.rtjadocdt,
            #160107-00021#1 2016/01/08 By benson --- S
            rtjbdocno   LIKE rtjb_t.rtjbdocno,                         
            rtjbseq     LIKE rtjb_t.rtjbseq,   
            rtjb004     LIKE rtjb_t.rtjb004,   
            rtjb012     LIKE rtjb_t.rtjb012,   
            rtjb013     LIKE rtjb_t.rtjb013,   
            #160107-00021#1 2016/01/08 By benson --- E
            imaf153     LIKE imaf_t.imaf153,
            rtdx003     LIKE rtdx_t.rtdx003,
            imaa104     LIKE imaa_t.imaa104,    #160107-00021#1 2016/01/08 By benson
            rtjb028     LIKE rtjb_t.rtjb028     #160513-00037#24 Add By Ken 160602 針對經營方式為租賃 專櫃/鋪位編號 
          END RECORD    
   DEFINE l_stbh001     LIKE stbh_t.stbh001
   DEFINE l_stbh004     LIKE stbh_t.stbh004
   DEFINE l_stbi017     LIKE stbi_t.stbi017
   DEFINE l_rtaw_para   LIKE type_t.chr10
   DEFINE l_success     LIKE type_t.num5     #160107-00021#1 2016/01/08 By benson
   DEFINE l_mainqty     LIKE rtjb_t.rtjb012  #160107-00021#1 2016/01/08 By benson
   DEFINE l_para_scc    LIKE type_t.chr10    #160323-00029#2 Add By Ken 160331
   DEFINE l_rtax001     LIKE rtax_t.rtax001  #160513-00037#24 Add By Ken 160602 針對經營方式為租賃 更新管理品類(來源astm801)
   

   CALL util.JSON.parse(ps_js,lc_param)

   LET r_success = TRUE
   
   DELETE FROM adep990_tmp01   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
   
   LET l_rtaw_para = cl_get_para(g_enterprise,g_site,'E-CIR-0001')   
   
   DISPLAY "1:",cl_get_current()
   #塞資料
   LET g_sql = "INSERT INTO adep990_tmp01(rtjbent,rtjbsite,rtjadocdt,rtjbdocno,rtjbseq, ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "                             mmag004,mmaq002, mmaq003,  rtja005,  rtja032, ",
               "                             rtjb003,rtjb004, imaa126,  imaa009,  imaf153, ",
               "                             rtjb006,rtjb008, rtjb009,  rtjb010,  rtjb011, ",
               "                             rtjb012,rtjb013, rtjb020,  rtjb021,  rtjb022, ", 
               "                             rtjb023,rtjb025, rtjb028,  rtjb029,  rtje006, ", 
               "                             rtja026,rtjb005, rtdx003,  stbh001,  stbi017, ",   
               "                             rtax001,rtja001, rtjf031,  rtjc013,  rtdx034, ",                   
               "                             imaa104,mainqty) ",   #160107-00021#1 2016/01/08 By benson
               "SELECT rtjbent,rtjbsite,rtjadocdt,rtjbdocno,rtjbseq,",
               "       COALESCE((SELECT mmag004 FROM mmag_t ",
               "                  WHERE mmagent = rtjaent ",
               "                    AND mmag001 = (SELECT mmaq003 FROM mmaq_t ",
               "                                    WHERE mmaqent = rtjaent ",
               "                                      AND mmaq001 = rtja001) ",
               "                    AND mmagent = ",g_enterprise,
               "                    AND mmag002 = '09' ",
               "                    AND mmag003 = '2024'),' '),",
               "       COALESCE((SELECT mmaq002 FROM mmaq_t WHERE mmaqent = rtjaent AND mmaq001 = rtja001),' '),",
               "       COALESCE((SELECT mmaq003 FROM mmaq_t WHERE mmaqent = rtjaent AND mmaq001 = rtja001),' '),",
               "       rtja005,rtja032, ",
               "       (SELECT imaa014 FROM imaa_t WHERE imaaent = rtjbent AND imaa001 = rtjb004), ",
               "       COALESCE(rtjb004,' '), '', '', '', ", 
               "       COALESCE(rtjb006,' '), COALESCE(rtjb008,0),   COALESCE(rtjb009,0),   COALESCE(rtjb010,0), COALESCE(rtjb011,0),", 
               "       COALESCE(rtjb012,0),   COALESCE(rtjb013,' '), COALESCE(rtjb020,0),   COALESCE(rtjb021,0), COALESCE(rtjb022,0), ",
               "       COALESCE(rtjb023,0),   COALESCE(rtjb025,' '), COALESCE(rtjb028,' '), rtjb029,             0, ",  
               "       rtja026,               COALESCE(rtjb005,' '), '',                    '',                 '', ",  
               "       '',COALESCE(rtja001,' '), ",   
               #6/12號 抵扣券金額邏輯 - S
               #"       (SELECT SUM(COALESCE(rtjf031,0)) FROM rtjf_t ",
               #"         WHERE rtjbent = rtjfent  AND rtjbdocno = rtjfdocno ",
               #"           AND rtjbseq = rtjfseq ",
               #"           AND EXISTS(SELECT 1 FROM ooie_t ",
               #"                       WHERE ooieent = rtjfent AND ooiesite = rtjfsite ",
               #"                         AND ooie001 = rtjf002 AND ooie012 = 'Y')), ",
               #6/12號 抵扣券金額邏輯 - E
               #8/11號 抵扣券金額邏輯 - S
               "       (SELECT SUM(COALESCE(rtjc013,0)) FROM rtjc_t ",
               "         WHERE rtjbent = rtjcent  AND rtjbdocno = rtjcdocno ",
               "           AND rtjbseq = rtjcseq ",       #160516-00014#14 add by ken  160620 修正pos上傳折扣金額在寫入deba時會重覆計算
               "           AND rtjc006 = '4' AND rtjc007 = '1' AND rtjc002 = '5'),  ",
               #8/11號 抵扣券金額邏輯 - E
               "       (SELECT SUM(COALESCE(rtjc013,0)) FROM rtjc_t ",
               "         WHERE rtjbent = rtjcent  AND rtjbdocno = rtjcdocno ",
               "           AND rtjbseq = rtjcseq ",       #160516-00014#14 add by ken  160620 修正pos上傳折扣金額在寫入deba時會重覆計算
               "           AND rtjc002 = '9' ),  ",
               "       COALESCE((SELECT COALESCE(rtdx034,0) FROM rtdx_t ",
               "                  WHERE rtdxent = rtjbent ",
               "                    AND rtdxsite = rtjbsite ",                     
               "                    AND rtdx001 = rtjb004 ) ,0), ",
               "       (SELECT imaa104 FROM imaa_t WHERE imaaent = rtjbent AND imaa001 = rtjb004), ",   #160107-00021#1 2016/01/08 By benson
               #"       COALESCE(rtjb012,0) ",  #160107-00021#1 2016/01/08 By benson  先給一樣的值,後續只需針對不同的商品進行數量轉換
               "       COALESCE(rtjb014,0) ",  #160323-00029#2 Add By Ken 160331 從天和追回( #mod by dengdd 160317)
               "  FROM rtjb_t, rtja_t ",
               " WHERE rtjbent = rtjaent ",
               "   AND rtjbdocno = rtjadocno ",
               "   AND rtjastus <> 'X' ",
               "   AND rtjaent = ",g_enterprise,
               "   AND ",lc_param.wc,
               "   AND ",g_where    
   IF NOT cl_null(lc_param.rtjadocdt) THEN
      LET g_sql = g_sql," AND rtjadocdt ='",lc_param.rtjadocdt,"'"
   END IF

   PREPARE adep990_rtjb_p1 FROM g_sql           
   EXECUTE adep990_rtjb_p1 
   DISPLAY "2:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#53 : adep990_rtjb_p1 : INSERT INTO adep990_rtjb_tmpp fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success    
   END IF   
   FREE adep990_rtjb_p1

   LET g_sql = "UPDATE adep990_tmp01 ",    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET imaf153 = (SELECT imaf153 FROM imaf_t ",
               "                   WHERE imafent = rtjbent ",
               "                     AND imafsite = rtjbsite ",
               "                     AND imaf001 = rtjb004 ",
               "                     AND imafent = ",g_enterprise,"), ", 
               "       (imaa126,imaa009) = (SELECT imaa126,imaa009 FROM imaa_t ",
               "                             WHERE imaaent = rtjbent ",
               "                               AND imaa001 = rtjb004 ",
               "                               AND imaaent = ",g_enterprise,") "               
   
   PREPARE adep990_rtjb_p2 FROM g_sql 
   EXECUTE adep990_rtjb_p2 
   DISPLAY "3:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#54 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF   
   FREE adep990_rtjb_p2
   
   #補資料2
   #1.取營運組織商品清單[經營方式]
   LET g_sql = "UPDATE adep990_tmp01 ",    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtdx003 = (SELECT rtdx003 FROM rtdx_t WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004), ",
               "       rtax001 = (SELECT rtaw001 FROM rtaw_t WHERE rtawent = rtjbent AND rtaw002 = imaa009 AND rtaw003 = '",l_rtaw_para,"' )"
   PREPARE adep990_rtjb_p3 FROM g_sql           
   EXECUTE adep990_rtjb_p3 
   
   IF lc_param.l_type != "7" THEN   #160607-00014#2 Add By ken 160622  如遇到adep999時不執行取協議資料
      DISPLAY "4:",cl_get_current()
      IF SQLCA.SQLcode THEN
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#55 : adep990_rtjb_p3: UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01  
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",g_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "adep990_rtjb_p3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         RETURN r_success  
      END IF
      FREE adep990_rtjb_p3
      
      #2.先取促銷協議[合同編號][扣率],無促銷協議則取採購協議[合同編號][扣率]
      #促銷協議
      LET l_sql = "SELECT stbh001,stbh004,stbi017 ",
                  "  FROM stbh_t,stbi_t ",
                  " WHERE stbhent   = ",g_enterprise,
                  "   AND stbhsite  = ? ",
                  "   AND stbhent = stbient ",      #160922-00005#1 Add By ken 160922
                  "   AND stbhdocno = stbidocno",
                  "   AND stbh002   = ? ",   #供應商
                  "   AND stbh003   = ? ",   #經營方式
                  "   AND stbi001   = ? ",   #商品編號
                  "   AND stbi011  <= ? ",
                  "   AND (stbi012 >= ? OR stbi012 IS NULL) ",
                  "   AND stbhstus  = 'Y' ",
                  " ORDER BY stbhcnfdt DESC "
                  
      PREPARE adep990_rtjb_p7 FROM l_sql
      DECLARE adep990_rtjb_cs7 SCROLL CURSOR FOR adep990_rtjb_p7
      #採購協議
      LET l_sql = "SELECT star004,star006,stas025 ",
                  "  FROM star_t,stas_t ",
                  " WHERE starent  = ",g_enterprise,
                  "   AND starsite =  ? ",    
                  "   AND starent = stasent ",    #160922-00005#1 Add By ken 160922
                  "   AND starsite = stassite ",  #160922-00005#1 Add By ken 160922                
                  "   AND star001  =  stas001 ",           
                  "   AND star003  =  ? ",   #供應商 
                  "   AND star005  =  ? ",   #經營方式 
                  "   AND stas003  =  ? ",   #商品編號               
                  "   AND stas018  <= ? ",  
                  "   AND (stas019 >= ? OR stas019 IS NULL) ",
                  "   AND starstus  = 'Y' ",
                  " ORDER BY starcnfdt DESC " 
      PREPARE adep990_rtjb_p8 FROM l_sql
      DECLARE adep990_rtjb_cs8 SCROLL CURSOR FOR adep990_rtjb_p8
      
      #160513-00037#24 Add By Ken 160602 針對經營方式為租賃  更新管理品類、合約編號、結算方式(來源astm801)(s)
      #租賃合約
      LET l_sql = "SELECT stje031,stje028,stje001 ",   #結算方式、管理品類、合約編號
                  "  FROM stje_t ",
                  " WHERE stjeent = ",g_enterprise,
                  "   AND stjesite = ? ",
                  "   AND stje007 = ? ",     #商戶編號
                  "   AND stje008 = ? ",     #鋪位編號
                  "   AND stjestus = 'Y' ",
                  "   AND stje004 = ? ",    #經營方式 :5租賃
                  "   AND stje012 >= ? ",   #租賃結束日期
                  "   AND (stje045 >= ? OR stje045 IS NULL) ",
                  "   AND stje005 < '6' ",  #合同狀態
                  " ORDER BY stjecnfdt DESC "
      PREPARE adep990_rtjb_p81 FROM l_sql
      DECLARE adep990_rtjb_cs81 SCROLL CURSOR FOR adep990_rtjb_p81
      
      LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
                  "   SET stbh004 = ? ,",
                  "       rtax001 = ? ,",
                  "       stbh001 = ? ",
                  " WHERE rtjbent = ",g_enterprise,
                  "   AND rtjbsite = ? ",
                  "   AND rtjadocdt = ? ",
                  "   AND rtjb028 = ? ",    #鋪位編號
                  "   AND imaf153 = ? ",    #商戶編號
                  "   AND rtdx003 = ? "     #經營方式
      PREPARE adep990_rtjb_p101 FROM g_sql   
      #160513-00037#24 Add By Ken 160602 針對經營方式為租賃  更新管理品類、合約編號、結算方式(來源astm801)(e)
      
      #160902-00006#1 Add By Ken 160902(S) 針對經營方式為租賃  更新合約編號、結算方式(來源astm801)
      LET g_sql = "UPDATE adep990_tmp01 ",   
                  "   SET stbh004 = ? ,",
                  "       stbh001 = ? ",
                  " WHERE rtjbent = ",g_enterprise,
                  "   AND rtjbsite = ? ",
                  "   AND rtjadocdt = ? ",
                  "   AND rtjb028 = ? ",    #鋪位編號
                  "   AND imaf153 = ? ",    #商戶編號
                  "   AND rtdx003 = ? "     #經營方式
      PREPARE adep990_rtjb_p102 FROM g_sql           
      #160902-00006#1 Add By Ken 160902(E)
      
      LET g_sql = "SELECT UNIQUE rtjbsite,rtjadocdt,rtjb004,imaf153,rtdx003,rtjb028 ",   #160513-00037#24 Add By Ken 160602加上專櫃/鋪位編號rtjb028
                  "  FROM adep990_tmp01 "   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      PREPARE adep990_rtjb_p9 FROM g_sql
      DECLARE adep990_rtjb_cs9 CURSOR FOR adep990_rtjb_p9
      
      LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
                  "   SET stbh001 = ? ,",
                  "       stbh004 = ? ,",
                  "       stbi017 = ?  ",
                  " WHERE rtjbent = ",g_enterprise,
                  "   AND rtjbsite = ? ",
                  "   AND rtjadocdt = ? ",
                  "   AND rtjb004 = ? ",
                  "   AND imaf153 = ? ",
                  "   AND rtdx003 = ? "
      PREPARE adep990_rtjb_p10 FROM g_sql           
      IF lc_param.l_type = '0' OR  lc_param.l_type = '1' OR  lc_param.l_type = '2' OR  lc_param.l_type = '7' THEN
         FOREACH adep990_rtjb_cs9 INTO l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb004, 
                                       l_rtjb.imaf153, l_rtjb.rtdx003,l_rtjb.rtjb028    #160513-00037#24 Add By Ken 160602加上專櫃/鋪位編號rtjb028
            LET l_stbh001 = ''
            LET l_stbh004 = ''
            LET l_stbi017 = ''
            LET l_rtax001 = ''     #160513-00037#24 Add By Ken 160602 針對經營方式為租賃 更新管理品類(來源astm801)
            
            #160513-00037#24 Add By Ken 160602 針對經營方式為租賃  更新管理品類、合約編號、結算方式(來源astm801)(S)
            IF l_rtjb.rtdx003 = '5' THEN   
               OPEN adep990_rtjb_cs81 USING l_rtjb.rtjbsite,l_rtjb.imaf153,l_rtjb.rtjb028,       #營運組織、商戶編號、鋪位編號
                                            l_rtjb.rtdx003, l_rtjb.rtjadocdt,l_rtjb.rtjadocdt    #經營方式、租賃結束日期、清退日期 
               FETCH FIRST adep990_rtjb_cs81 INTO l_stbh004,l_rtax001,l_stbh001  
      
               #160902-00006#1 Add By Ken 160902(S) 如取不到租賃的管理品類就不更新管理品類
               IF cl_null(l_rtax001) THEN
                  #更新[結算方式][合同編號]
                  EXECUTE adep990_rtjb_p102 USING l_stbh004,      l_stbh001,
                                                  l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb028, 
                                                  l_rtjb.imaf153, l_rtjb.rtdx003   
               #160902-00006#1 Add By Ken 160902(E)
               ELSE                                                  
                  #更新[結算方式][管理品類][合同編號]
                  EXECUTE adep990_rtjb_p101 USING l_stbh004,      l_rtax001,       l_stbh001,
                                                  l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb028, 
                                                  l_rtjb.imaf153, l_rtjb.rtdx003 
               END IF
               IF SQLCA.SQLcode THEN 
                  LET g_log = "-Error#56 : EXECUTE adep990_rtjb_p101 USING stbh004(",l_stbh004,"),rtax001(",l_rtax001,"),stbh001(",l_stbh001,"),rtjbsite(",l_rtjb.rtjbsite,"),rtjadocdt(",l_rtjb.rtjadocdt,"),rtjb028(",l_rtjb.rtjb028,"),imaf153(",l_rtjb.imaf153,"),rtdx003(",l_rtjb.rtdx003,") fail! ",
                              " SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]           
                  CALL cl_log_write(g_log)
                  DISPLAY g_log                                 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "adep990_rtjb_p101"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  LET r_success = FALSE
                  RETURN r_success
               END IF                                            
            #160513-00037#24 Add By Ken 160602 針對經營方式為租賃  更新管理品類、合約編號、結算方式(來源astm801)(E)          
            ELSE         
               OPEN adep990_rtjb_cs7 USING l_rtjb.rtjbsite,l_rtjb.imaf153,  l_rtjb.rtdx003,
                                           l_rtjb.rtjb004, l_rtjb.rtjadocdt,l_rtjb.rtjadocdt
               FETCH FIRST adep990_rtjb_cs7 INTO l_stbh001,l_stbh004,l_stbi017
               
               IF cl_null(l_stbh001) THEN
                  OPEN adep990_rtjb_cs8 USING l_rtjb.rtjbsite,l_rtjb.imaf153,  l_rtjb.rtdx003,
                                              l_rtjb.rtjb004, l_rtjb.rtjadocdt,l_rtjb.rtjadocdt
                  FETCH FIRST adep990_rtjb_cs8 INTO l_stbh001,l_stbh004,l_stbi017   
               END IF
               
               #更新[合同編號][扣率]
               EXECUTE adep990_rtjb_p10 USING l_stbh001,l_stbh004,l_stbi017,
                                              l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb004, 
                                              l_rtjb.imaf153, l_rtjb.rtdx003
               IF SQLCA.SQLcode THEN
                  #160111-00006#1 s983961 --add(s)   
                  LET g_log = "-Error#56 : EXECUTE adep990_rtjb_p10 USING stbh001(",l_stbh001,"),stbh004(",l_stbh004,"),stbi017(",l_stbi017,"),rtjbsite(",l_rtjb.rtjbsite,"),rtjadocdt(",l_rtjb.rtjadocdt,"),rtjb004(",l_rtjb.rtjb004,"),imaf153(",l_rtjb.imaf153,"),rtdx003(",l_rtjb.rtdx003,") fail! ",
                              " SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]           
                  CALL cl_log_write(g_log)
                  DISPLAY g_log                        
                  #160111-00006#1 s983961 --add(e)           
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "adep990_rtjb_p10"
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  LET r_success = FALSE
                  RETURN r_success
               END IF            
            END IF                                    
         END FOREACH  
      END IF
   END IF   
      
   FREE adep990_rtjb_p7
   FREE adep990_rtjb_cs7
   FREE adep990_rtjb_p8
   FREE adep990_rtjb_cs8
   FREE adep990_rtjb_p9
   FREE adep990_rtjb_cs9
   FREE adep990_rtjb_p10
   #160513-00037#24 Add By Ken 160602(S)
   FREE adep990_rtjb_p81
   FREE adep990_rtjb_cs81
   FREE adep990_rtjb_p101
   #160513-00037#24 Add By Ken 160602(E)   
   
   DISPLAY "8:",cl_get_current()
   #[經營方式]非3.扣率代銷時,扣率為null時給予0
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET stbi017 = 0 ",
               " WHERE rtdx003 != '3'"
   PREPARE adep990_rtjb_p11 FROM g_sql
   EXECUTE adep990_rtjb_p11
   DISPLAY "9:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#57 : adep990_rtjb_p11 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p11"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p11
   
   #4.聯營 未稅金額 = 實收金額 - 稅額
   #註：稅額來源需重新評估
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtjb022 = (COALESCE(rtjb021,0) - COALESCE(rtjf031,0)) -  ",  #實收金額 = 應收金額-抵扣券金額
               "                 (COALESCE(rtjb021,0) - COALESCE(rtjb022,0))  ",    #稅額 = 應收金額 - 未稅金額
               " WHERE rtdx003 = '4'"
   PREPARE adep990_rtjb_p12 FROM g_sql
   EXECUTE adep990_rtjb_p12
   DISPLAY "10:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#57 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p12"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   FREE adep990_rtjb_p12
   
   #非ERP單據,屬於自營的資料,庫區取值方式調整
   #1.產生的artt610單據為主
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtjb025 = (SELECT UNIQUE rtib025 FROM rtia_t,rtib_t ",
               "                   WHERE rtiaent = rtibent  AND rtiadocno = rtibdocno ", 
               "                     AND rtjbent = rtibent  AND rtjb004 = rtib004 ",
               "                     AND rtiadocdt = rtjadocdt AND rtiasite = rtjbsite ",
               "                     AND rtia032 = '4' )",
              #" WHERE rtdx003 IN ('1','3')",
              #聯營的庫區 以POS上傳的為主,因為聯營會分常規庫區和促銷庫區 
              #不能用標準的取庫區方式 (先取門店清單的庫區(rtdx044),取不到再取門店預設的出貨庫區(ooef124))
               " WHERE rtdx003 != '4'",
               "   AND rtja032 != '1'"
   PREPARE adep990_rtjb_p13 FROM g_sql
   EXECUTE adep990_rtjb_p13

   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#58 : adep990_rtjb_p13 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p13"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p13
   
   #2.找組織商品清單的資料
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtjb025 = (SELECT UNIQUE rtdx044 FROM rtdx_t ",
               "                   WHERE rtjbent = rtdxent  AND rtjbsite = rtdxsite AND rtjb004 = rtdx001) ",
              #" WHERE rtdx003 IN ('1','3')",
               " WHERE rtdx003 != '4'",
               "   AND rtja032 != '1'",
               "   AND rtjb025 IS NULL "
   PREPARE adep990_rtjb_p14 FROM g_sql
   EXECUTE adep990_rtjb_p14

   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#59 : adep990_rtjb_p14 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p14"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p14

   #3.取組織預設出貨倉
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtjb025 = COALESCE((SELECT UNIQUE ooef124 FROM ooef_t ",
               "                   WHERE rtjbent = ooefent  AND rtjbsite = ooef001),' ') ",
              #" WHERE rtdx003 IN ('1','3')",
               " WHERE rtdx003 != '4'",
               "   AND rtja032 != '1'",
               "   AND rtjb025 IS NULL "
   PREPARE adep990_rtjb_p15 FROM g_sql
   EXECUTE adep990_rtjb_p15

   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#60 : adep990_rtjb_p15 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p15"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p15
   
   #取組織商品清單稅別為的資料來源
   LET g_sql = "UPDATE adep990_tmp01 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "   SET rtjb006 = COALESCE((SELECT UNIQUE rtdx014 FROM rtdx_t ",
               "                   WHERE rtjbent = rtdxent  AND rtjbsite = rtdxsite AND rtjb004 = rtdx001),' ') "
   PREPARE adep990_rtjb_p16 FROM g_sql
   EXECUTE adep990_rtjb_p16

   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#61 : adep990_rtjb_p16 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e) 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p16"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p16
   
   #160819-00054#48 by sakura add(S)
   #對應的 "會員編號mmaq003" 為一格空白時,則 "會員卡號rtja001" 也要更新為一格空白
   LET g_sql = "UPDATE adep990_tmp01 ",
               "   SET rtja001 = ' ' ",
               " WHERE mmaq003 = ' ' "
   PREPARE adep990_rtjb_p19 FROM g_sql
   EXECUTE adep990_rtjb_p19

   IF SQLCA.SQLcode THEN
      LET g_log = "--Error#86 : adep990_rtjb_p19 : UPDATE adep990_tmp01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_p19"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_rtjb_p19   
   #160819-00054#48 by sakura add(E)
   
   #160107-00021#1 2016/01/08 By benson --- S
   #計算主條碼單位數量(mainqty)
   #第一階段 於主SQL已調整
   #第二階段 把 rtjb013 與imaa104 不同的資料 重新計算單位轉換
   
   #160323-00029#2 Mark By Ken 160331(因在insert into adep990_rtjb_tmp時，已經把rtjb014直接給mainqty，所以不需轉換
      #LET g_sql = "SELECT UNIQUE rtjbent,rtjbsite,rtjbdocno,rtjbseq,rtjb004,rtjb013,imaa104,rtjb012 ",    
      #            "  FROM adep990_rtjb_tmp ",
      #            " WHERE rtjb013 != imaa104 "
      #PREPARE adep990_rtjb_p17 FROM g_sql
      #DECLARE adep990_rtjb_cs17 CURSOR FOR adep990_rtjb_p17
      #
      #LET g_sql = "UPDATE adep990_rtjb_tmp ",
      #            "   SET mainqty = ? ",
      #            " WHERE rtjbent = ?  AND rtjbsite = ? AND rtjbdocno = ? ",
      #            "   AND rtjbseq = ? "
      #PREPARE adep990_rtjb_p18 FROM g_sql
      #
      #INITIALIZE l_rtjb.* TO NULL
      #FOREACH adep990_rtjb_cs17 INTO l_rtjb.rtjbent,l_rtjb.rtjbsite,l_rtjb.rtjbdocno,l_rtjb.rtjbseq,
      #                               l_rtjb.rtjb004,l_rtjb.rtjb013, l_rtjb.imaa104,  l_rtjb.rtjb012
      #   
      #   CALL s_aooi250_convert_qty(l_rtjb.rtjb004,l_rtjb.rtjb013,l_rtjb.imaa104, l_rtjb.rtjb012)
      #    RETURNING l_success,l_mainqty
      #    
      #   IF NOT l_success THEN
      #      #160111-00006#1 s983961 --add(s)                                   
      #      LET g_log = "--Error#62 : CALL s_aooi250_convert_qty fail! Parameters : ",
      #                  "  商品:",l_rtjb.rtjb004," 銷售單位:",l_rtjb.rtjb013," 主條碼(庫存)單位:",l_rtjb.imaa104," 銷售數量:",l_rtjb.rtjb012,"單位轉換率沒有維護!"                        
      #      CALL cl_log_write(g_log)
      #      DISPLAY g_log       
      #      #160111-00006#1 s983961 --add(e) 
      #      LET r_success = FALSE 
      #      #160111-00006#1 s983961 --mark(s) 
      #      #LET g_log = "Error - 商品:",l_rtjb.rtjb004," 銷售單位:",l_rtjb.rtjb013," 主條碼(庫存)單位:",l_rtjb.imaa104,
      #      #            "單位轉換率沒有維護!"
      #      #CALL cl_log_write(g_log)
      #      #DISPLAY g_log
      #      #160111-00006#1 s983961 --mark(e) 
      #   END IF
      #      
      #   EXECUTE adep990_rtjb_p18 USING l_mainqty,
      #                                  l_rtjb.rtjbent,l_rtjb.rtjbsite,l_rtjb.rtjbdocno,l_rtjb.rtjbseq
      #   
      #   IF SQLCA.SQLcode THEN
      #      #160111-00006#1 s983961 --add(s)                                   
      #      LET g_log = "--Error#63 : EXECUTE adep990_rtjb_p18 USING mainqty(",l_mainqty,"), ",
      #                  "  rtjbent(",l_rtjb.rtjbent,"),rtjbsite(",l_rtjb.rtjbsite,"),rtjbdocno(",l_rtjb.rtjbdocno,"),rtjbseq(",l_rtjb.rtjbseq,") fail!",
      #                  "   SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
      #      CALL cl_log_write(g_log)
      #      DISPLAY g_log                
      #      #160111-00006#1 s983961 --add(e) 
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "adep990_rtjb_p18"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #      RETURN r_success
      #   END IF      
      #END FOREACH
      #  
      #FREE adep990_rtjb_p17
      #FREE adep990_rtjb_cs17
      #FREE adep990_rtjb_p18
   #160323-00029#2 Add By Ken 160331
   
   IF NOT r_success THEN
      RETURN r_success 
   END IF
   #160107-00021#1 2016/01/08 By benson --- E
      
   ##150805-00003#28 150826 By benson --- S
   ##“在倍换活动时，（rtjb031-本币应收金额不包括抵扣券金额”。而实收金额=应收金额-抵扣券金额。
   ##将“应收金额”=应收金额+抵扣券金额。这样才能体现倍换活动的原价销售金额是多少。
   #LET g_sql = "UPDATE adep990_rtjb_tmp ",
   #            "   SET rtjb022 = (COALESCE(rtjb021,0) - COALESCE(rtjf031,0)) -  ",  #實收金額 = 應收金額-抵扣券金額
   #            "                 (COALESCE(rtjb021,0) - COALESCE(rtjb022,0))  ",    #稅額 = 應收金額 - 未稅金額
   #            " WHERE rtdx003 = '4'"
   #PREPARE adep990_rtjb_p12 FROM g_sql
   #EXECUTE adep990_rtjb_p12
   ##DISPLAY "10:",cl_get_current()
   #IF SQLCA.SQLcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "adep990_rtjb_p12"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF  
   ##150805-00003#28 150826 By benson --- E
   
   #CREATE INDEX adep990_rtjb_tmp_01 ON adep990_rtjb_tmp(rtjbent,rtjadocdt,rtjbsite,rtjb004,rtjb025,
   #                                                     rtjb028,rtjb013,  rtjb006, rtjb012,mmaq002,
   #                                                     mmaq003,mmag004)
   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
   EXECUTE IMMEDIATE "CREATE INDEX adep990_tmp01_01    
                          ON adep990_tmp01(rtjbent,rtjadocdt,rtjbsite,COALESCE(rtjb004,' '),COALESCE(rtjb025,' '),
                                              COALESCE(rtjb028,' '), COALESCE(rtjb013,' '),    COALESCE(rtjb006,' '), rtjb012,COALESCE(mmaq002,' '),
                                              COALESCE(mmaq003,' '), COALESCE(mmag004,' '))"                                        
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#64 : CREATE INDEX adep990_tmp01_01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01                
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e)       
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep990_tmp01_01"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #CREATE INDEX adep990_rtjb_tmp_02 ON adep990_rtjb_tmp(rtjbent,rtjbsite,rtjadocdt,rtax001,imaa126,imaf153,
   #                                                     stbh004,rtjb006,mmaq002,mmag004,rtjb012)
   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
   EXECUTE IMMEDIATE "CREATE INDEX adep990_tmp01_02 ON adep990_tmp01(rtjbent,rtjbsite,rtjadocdt,COALESCE(rtax001,' '),COALESCE(imaa126,' '),COALESCE(imaf153,' '),
                                                                           COALESCE(stbh004,' '),COALESCE(rtjb006,' '),COALESCE(mmaq002,' '),COALESCE(mmag004,' '),rtjb012)"
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#65 : CREATE INDEX adep990_tmp01_02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01                
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e)   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep990_tmp01_02"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #EXECUTE IMMEDIATE "analyze table adep990_rtjb_tmp estimate statistics"
   IF cl_db_generate_analyze("adep990_tmp01") THEN END IF   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
   RETURN r_success 
   
END FUNCTION

PRIVATE FUNCTION adep990_ins_temp_1(ps_js)
   DEFINE ps_js       STRING
   DEFINE r_success   LIKE type_t.num5   
   DEFINE lc_param    type_parameter     
   DEFINE l_para_scc  LIKE type_t.chr10   
   
   CALL util.JSON.parse(ps_js,lc_param)   
   
   LET r_success = TRUE
   
   DELETE FROM adep990_tmp02   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
   DELETE FROM adep990_tmp03   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
   #匯總資料 
   #經營方式對應的計算方式
   #扣率代銷
   #1.銷售成本=應收金額*(1-(扣率/100))
   #2.毛利=應收金額-銷售成本
   #3.毛利率=扣率*100
   #自營購銷(2015/06/23 Vivian提出修改,全部以含稅金額計算)
   #1.銷售成本=成本金額
   #2.毛利=應收金額-成本金額
   #3.毛利率=((應收金額-成本金額)/應收金額)*100
   #DISPLAY "A:",cl_get_current()
   
   #160107-00021#1 2016/01/08 By benson --- S
   LET l_para_scc = cl_get_para(g_enterprise,g_site,'E-CIR-0061')
   LET g_sql = " INSERT INTO adep990_tmp02( ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
               "    debaent  , debasite , deba001  , deba002  , deba003  , deba004  , deba005  , deba006  , deba007  , deba008  , ",
               "    deba009  , deba010  , deba011  , deba012  , deba013  , deba014  , deba015  , deba016  , deba017  , deba018  , ",
               "    deba019  , deba020  , deba021  , deba022  , deba023  , deba024  , deba025  , deba026  , deba030  , deba031  , ",
               "    deba032  , deba033  , deba034  , deba035  , deba036  , deba037  , deba038  , deba039  , deba040  , deba043  , ",
               "    rtdx003  , stbh001  , deba045  , deba046  , deba047  , deba050  , deba051  , deba052  , deba053  ) ",
               " SELECT rtjbent,             rtjbsite,'',          rtjadocdt,'','',rtjb025,'','',     '', ",     #企业编号,营运据点,层级类型,统计日期,会计周,会计期,库区编号,库区类型,存货管理方式,库区业态
               "        rtjb004,             rtjb003, '',          '',       '','',stbh004,     '',rtjb028,rtjb006, ",   #商品编号,商品条码,商品品名,商品规格,品牌,主供应商,结算方式,品类编号,专柜编号,税别编号
               "        SUM(COALESCE(rtjb021,0) - COALESCE(rtjb022,0)), "            #税额  
   #銷售單位,銷售數量       
   IF l_para_scc = '1' THEN                          
      LET g_sql = g_sql,  "        imaa104,   ", 
                          "        SUM(COALESCE(mainqty,0)),      "       
   ELSE
      LET g_sql = g_sql,  "        rtjb013,   ",
                          "        SUM(COALESCE(rtjb012,0)),      "
   END IF
   
   LET g_sql = g_sql,                            
               "        SUM(COALESCE(rtib023,0)),      ",                             #銷售成本
               "        SUM(COALESCE(rtdx034,0) * COALESCE(mainqty,0)),",             #進價金額               
               "        SUM(COALESCE(rtjb008,0) * COALESCE(mainqty,0)),",             #原价金额  
               "        SUM(COALESCE(rtjb022,0)),",                                   #未税金额 
               "        SUM(COALESCE(rtjb021,0)),",                                   #应收金额
               "        SUM(CASE WHEN COALESCE(rtjb009,0) < COALESCE(rtjb008,0) THEN COALESCE(mainqty,0) ELSE 0 END),",  #促销销售数量
               "        SUM(CASE WHEN COALESCE(rtjb009,0) < COALESCE(rtjb008,0) THEN COALESCE(rtjb021,0) ELSE 0 END),",  #促销应收金额
               "        SUM(COALESCE(rtjb020,0)),",                                                #打折金额                        
               "        SUM((COALESCE(rtjb009,0)-COALESCE(rtjb010,0))*COALESCE(mainqty,0)),",      #变价金额                    
               "        SUM(CASE WHEN rtjb021 < 0 THEN COALESCE(rtjb021,0)*-1 ELSE 0 END),",       #退货金额                   
               "        SUM(CASE WHEN rtja032 = '1' THEN mainqty ELSE 0 END),",  
               "        SUM(CASE WHEN rtja032 = '1' THEN ", 
               "                   COALESCE(rtdx034,0) * (CASE WHEN rtja032 = '1' THEN COALESCE(mainqty,0) ELSE 0 END) ",                                                        
               "                 ELSE 0  ",                                                                              
               "            END), ",                                                                                   
               "        SUM(CASE WHEN rtja032 = '1' THEN COALESCE(rtjb021,0) ELSE 0 END), ",    
               "        SUM(CASE WHEN rtja032 = '2' OR rtja032 = '3' THEN COALESCE(mainqty,0) ELSE 0 END), ",  
               "        SUM(CASE WHEN rtja032 = '2' OR rtja032 = '3' THEN ",                               
               "                    COALESCE(rtdx034,0) * COALESCE(mainqty,0) ",                                                    
               "                 ELSE 0 ",                                                                            
               "            END), ",                                                                                
               "        SUM(CASE WHEN rtja032 = '2' OR rtja032 = '3' THEN COALESCE(rtjb021,0) ELSE 0 END), ",    
               "        COALESCE(rtjb005,' '), ",                                                  #产品特征    
               "        rtdx003,stbh001, ",                                                        #經營方式,合同編號    
               "        SUM(COALESCE(rtjf031,0)), SUM(COALESCE(rtjc013,0)), SUM(COALESCE(rtjb021,0)) , AVG(COALESCE(stbi017,0)), 0,0,",
               "        rtax001 ",                                                                  #管理品類   
               "FROM adep990_tmp01 "    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               
   IF l_para_scc = '1' THEN                          
      LET g_sql = g_sql,
               "GROUP BY rtjbent,rtjbsite,rtjadocdt,rtjb025,rtjb004, ",   
               "         rtjb003,rtjb028, rtjb006,  imaa104,rtjb005, ",    
               "         rtdx003,stbh001, stbh004,  rtax001 "      
   ELSE
      LET g_sql = g_sql,     
               "GROUP BY rtjbent,rtjbsite,rtjadocdt,rtjb025,rtjb004, ",   
               "         rtjb003,rtjb028, rtjb006,  rtjb013,rtjb005, ",    
               "         rtdx003,stbh001, stbh004,  rtax001 "  
   END IF

   PREPARE adep990_ins_deba_p FROM g_sql 
   EXECUTE adep990_ins_deba_p   
   #160107-00021#1 2016/01/08 By benson --- E
   
   #DISPLAY "B:",cl_get_current()             
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#66 : adep990_ins_deba_p : INSERT INTO adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins deba_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_ins_deba_p  #160107-00021#1 2016/01/08 By benson
   
   #補資料
   LET g_sql = "UPDATE adep990_tmp02 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
               "   SET deba001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = debaent AND ooef001 = debasite), ",
               "       (deba003,deba004) = (SELECT oogc008,oogc006 FROM oogc_t,ooef_t WHERE oogcent = debaent AND oogc002 = '4' AND oogc003 = deba002 AND ooefent = debaent AND ooef001 = debasite AND oogc001 = ooef008), ",
               "       (deba006,deba007,deba008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t WHERE inaaent = debaent AND inaasite = debasite AND inaa001 = deba005), ",
               "       (deba011,deba012) = (SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = debaent AND imaal001 = deba009 AND imaal002 = '",g_lang,"'), ",
               "       (deba013,deba016) = (SELECT imaa126,imaa009 FROM imaa_t WHERE imaaent = debaent AND imaa001 = deba009), ",
               "       deba014 = (SELECT imaf153 FROM imaf_t WHERE imafent = debaent AND imafsite = debasite AND imaf001 = deba009), ",
               "       deba010 = COALESCE(deba010,' '),deba017 = COALESCE(deba017,' ') "
   
   PREPARE adep990_deba_p1 FROM g_sql 
   EXECUTE adep990_deba_p1
   #DISPLAY "C:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#66 : adep990_deba_p1 : UPDATE adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_deba_p1"
      LET g_errparam.popup = TRUE
      CALL cl_err()     
      LET r_success = FALSE
      RETURN r_success
   END IF 
   FREE adep990_deba_p1
   
   LET g_sql = " UPDATE adep990_tmp02 "   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
               #160107-00021#1 2016/01/08 By benson 調整成本計算方式 --- S               
               #rtib_t 無區分稅別, deba_t 有區分稅別
               #在此做調整,計算出來的銷售成本趨近於真實數據
               #公式：(成本金額(rtib023) / 銷售數量(rtib012)) * 銷售數量(deba021)
   #160323-00029#2 Modify By Ken 160331(S)  從天和追回 (原天和修改#mod by dengdd 160322)      
   IF l_para_scc = '1' THEN    #主條碼(庫存數量)
      LET g_sql = g_sql,  "    SET deba022 = (SELECT SUM(COALESCE(rtib023,0)) * COALESCE(deba021,0) / CASE WHEN SUM(COALESCE(rtib014,0)) = 0 THEN 1 ELSE SUM(COALESCE(rtib014,0)) END" #mod by dengdd 160322
   ELSE                        #銷售數量
      LET g_sql = g_sql,  "    SET deba022 = (SELECT SUM(COALESCE(rtib023,0)) * COALESCE(deba021,0) / CASE WHEN SUM(COALESCE(rtib012,0)) = 0 THEN 1 ELSE SUM(COALESCE(rtib012,0)) END"                                        #成本金額
   END IF               
               #"    SET deba022 = (SELECT SUM(COALESCE(rtib023,0)) * COALESCE(deba021,0) / CASE WHEN SUM(COALESCE(rtib012,0)) = 0 THEN 1 ELSE SUM(COALESCE(rtib012,0)) END",                                        #成本金額
               #"    SET deba022 = (SELECT SUM(COALESCE(rtib023,0)) * COALESCE(deba021,0) / CASE WHEN SUM(COALESCE(rtib014,0)) = 0 THEN 1 ELSE SUM(COALESCE(rtib014,0)) END", #mod by dengdd 160322
   #160323-00029#2 Modify By Ken 160331(E)
               #160107-00021#1 2016/01/08 By benson 調整成本計算方式 --- E
   LET g_sql = g_sql, "                     FROM rtib_t,rtia_t ",
               "                    WHERE rtibent = rtiaent ",
               "                      AND rtibdocno = rtiadocno ",
               "                      AND rtibent = debaent ",
               "                      AND rtibsite = debasite ",                                              #營運據點
              #"                      AND rtiadocdt = deba002 ",                                              #單據日期  #160107-00021#1 2016/01/08 By benson mark 单据日期跟过账日期不一致的情况,就会抓不到成本
               "                      AND TRUNC(rtia006,'dd') = deba002 ",                                    #扣帳日期  #160107-00021#1 2016/01/08 By benson 改為看扣帳日期   #160218-00012#1 160218 by lori mod 語法錯誤
               "                      AND rtib004 = deba009 ",                                                #商品編號
               "                      AND rtib025 = deba005  ",                                               #庫區編號
               "                      AND COALESCE(rtib028,' ') = COALESCE(deba017,COALESCE(rtib028,' ')) "  #專櫃編號
              #"                      AND COALESCE(rtib006,' ') = COALESCE(deba018,COALESCE(rtib006,' ')) ",  #稅別編號  
   #160323-00029#2 Modify By Ken 160331(S)  從天和追回 (原天和修改#mod by dengdd 160322)
   IF l_para_scc = '1' THEN    #主條碼(庫存數量)   
      LET g_sql = g_sql, "            AND rtib015 = deba020  "      #库存單位  #mod by dengdd 160322                      
   ELSE
      LET g_sql = g_sql, "            AND rtib013 = deba020  "                                               #銷售單位   
   END IF
   #160323-00029#2 Modify By Ken 160331(E)
              #"                      AND COALESCE(rtib005,' ') = COALESCE(deba043,COALESCE(rtib005,' ')) ",  #產品特徵  
   LET g_sql = g_sql,    "            AND rtibent = ", g_enterprise,
               "                      AND rtiastus <>'X')  "
   PREPARE adep990_deba_p2 FROM g_sql
   EXECUTE adep990_deba_p2
   #DISPLAY "D:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#67 : adep990_deba_p2 : UPDATE adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_deba_p2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_deba_p2

   LET g_sql = "UPDATE adep990_tmp02 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
               "   SET (deba003,deba004) = (SELECT oogc008, oogc006        ",                 #會計周,會計期
               "                              FROM ooef_t, glaa_t, oogc_t  ",
               "                             WHERE     ooefent = debaent   ",
               "                                   AND ooef001 = debasite  ",
               "                                   AND ooefent = glaaent   ",
               "                                   AND ooef017 = glaacomp  ",
               "                                   AND glaa014 = 'Y'       ",
               "                                   AND glaaent = oogcent   ",
               "                                   AND glaa003 = oogc001   ",
               "                                   AND oogc002 = '4'       ",
               "                                   AND oogc003 = deba002), ",
               #150826 by benson 毛利 從 應收金額 - 銷售成本 改成 實收金額 - 銷售成本 --- S
               #"       deba027 = (COALESCE(deba026,0) - COALESCE(deba022,0)),                 ",          #应收金额-销售成本
               #"       deba028 = (CASE WHEN COALESCE(deba026,0) = 0 THEN 100      ",          #(应收金额-销售成本/应收金额)*100
               #"                      ELSE ((COALESCE(deba026,0) - COALESCE(deba022,0))/COALESCE(deba026,1))*100 ",
               #"                  END), ",
               "       deba027 = (COALESCE(deba047,0) - COALESCE(deba022,0)),                 ",          #应收金额-销售成本
               "       deba028 = (CASE WHEN COALESCE(deba047,0) = 0 THEN 100      ",          #(应收金额-销售成本/应收金额)*100
               "                      ELSE ((COALESCE(deba047,0) - COALESCE(deba022,0))/COALESCE(deba047,1))*100 ",
               "                  END), ",
               #150826 by benson 毛利 從 應收金額 - 銷售成本 改成 實收金額 - 銷售成本 --- E
               "       deba041 = TO_CHAR(deba002,'YYYY'), ",                                  #統計年
               "       deba042 = TO_CHAR(deba002,'MM'),",                                     #統計月
               "       deba029 = (SELECT COUNT(UNIQUE rtjbdocno) FROM adep990_tmp01 ",     #客單數::來源單據   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "                   WHERE rtjbent = debaent ",
               "                     AND rtjbsite = debasite ",
               "                     AND rtjadocdt = deba002 ",
               "                     AND COALESCE(rtjb004,' ') = COALESCE(deba009,' ') ",      #商品編號
               "                     AND COALESCE(rtjb025,' ') = COALESCE(deba005,' ') ",      #庫區編號
               "                     AND COALESCE(rtjb028,' ') = COALESCE(deba017,' ') "       #專櫃編號
   #160323-00029#2 Modify By Ken 160331(S)  從天和追回 (原天和修改#mod by dengdd 160322)   
   IF l_para_scc = '1' THEN    #主條碼(庫存數量)               
      LET g_sql = g_sql , "          AND COALESCE(imaa104,' ') = COALESCE(deba020,' ')),"     #库存單位               
   ELSE
      LET g_sql = g_sql , "          AND COALESCE(rtjb013,' ') = COALESCE(deba020,' ')),"     #銷售單位                
   END IF
   #160323-00029#2 Modify By Ken 160331(E) 
      LET g_sql = g_sql ,               
               "       deba044 = (SELECT COUNT(UNIQUE rtjbdocno) FROM adep990_tmp01 ",     #退货单据数::來源單據銷售數量<0    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "                   WHERE rtjbent = debaent ",
               "                     AND rtjbsite = debasite ",
               "                     AND rtjadocdt = deba002 ",
               "                     AND COALESCE(rtjb004,' ') = COALESCE(deba009,' ') ",      #商品編號
               "                     AND COALESCE(rtjb025,' ') = COALESCE(deba005,' ') ",      #庫區編號
               "                     AND COALESCE(rtjb028,' ') = COALESCE(deba017,' ') "       #專櫃編號
   #160323-00029#2 Modify By Ken 160331(S)  從天和追回 (原天和修改#mod by dengdd 160322)   
   IF l_para_scc = '1' THEN    #主條碼(庫存數量)                 
      LET g_sql = g_sql , "          AND COALESCE(imaa104,' ') = COALESCE(deba020,' ') "      #库存單位
   ELSE
      LET g_sql = g_sql , "          AND COALESCE(rtjb013,' ') = COALESCE(deba020,' ') "      #銷售單位  
   END IF
   #160323-00029#2 Modify By Ken 160331(E)
      LET g_sql = g_sql , "          AND rtjb012 < 0) " 
               
   PREPARE adep990_deba_p3 FROM g_sql 
   EXECUTE adep990_deba_p3      
   #DISPLAY "E:",cl_get_current()   
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#68 : adep990_deba_p3 : UPDATE adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_deba_p3"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   FREE adep990_deba_p3
   
   LET g_sql = "UPDATE adep990_tmp02 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
               "   SET deba048 = (COALESCE(deba026,0) / CASE WHEN COALESCE(deba029,0) = 0 THEN 1 ELSE deba029 END) "           
   PREPARE adep990_deba_p4 FROM g_sql
   EXECUTE adep990_deba_p4
   #DISPLAY "F:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#69 : adep990_deba_p4 : UPDATE adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_deba_p4"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   FREE adep990_deba_p4
   
   #匯總資料 
   #160107-00021#1 2016/01/08 By benson --- S
   LET g_sql = "INSERT INTO adep990_tmp03( ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
               "   debbent , debbsite , debb001 , debb002 , debb003 , debb004 , debb005 , debb006 , debb007 , debb008 , ",  
               "   debb009 , debb010  , debb011 , debb012 , debb013 , debb014 , debb015 , debb016 , debb017 , debb018 , ",
               "   debb020 , debb021  , debb019 , debb022 , debb023 , debb024 , debb025 , debb026 , debb027 , debb030 , ",
               "   debb031 , debb032  , debb033 , debb034 , debb035 , rtdx003 , stbh001 , debb038) ",
               "SELECT rtjbent, rtjbsite, '',      rtjadocdt, '', '', rtjb025, '', '',     '',  ",            #企业编号,营运据点,层级类型,统计日期,会计周,会计期,库区编号,库区类型,存货管理方式,库区业态
               "       rtjb004, rtjb003,  '',      '',        '', '', stbh004,      '', rtjb028, rtjb006, ",  #商品编号,商品条码,商品品名,商品规格,品牌,主供应商,结算方式,品类编号,专柜编号,税别编号         
               "        mmaq002,  mmag004, "                                                              #会员卡种,会员等级

   IF l_para_scc = '1' THEN                          
      LET g_sql = g_sql,  "        imaa104,   ", 
                          "        SUM(COALESCE(mainqty,0)),      "       
   ELSE
      LET g_sql = g_sql,  "        rtjb013,   ",
                          "        SUM(COALESCE(rtjb012,0)),      "
   END IF
   
   LET g_sql = g_sql,
               "       0, ",                                                      #銷售成本    
               "       SUM(COALESCE(rtdx034,0) * COALESCE(mainqty,0)), ",         #進價金額                       
               "       SUM(COALESCE(rtjb008,0) * COALESCE(mainqty,0)), ",         #原价金额     
               "       SUM(COALESCE(rtjb022,0)), ",                               #未税金额    
               "       SUM(COALESCE(rtjb021,0)), ",                               #应收金额   
               "       SUM(COALESCE(rtjb029,0)), ",                               #会员积分
               "       0, ",                                                      #单据数 
               "       SUM(COALESCE(rtjf031,0)), ",                               #抵扣券金額
               "       SUM(COALESCE(rtjc013,0)), ",                               #會員折扣金額
               "       SUM(COALESCE(rtjb021,0)), ",                               #實收金額
               "       COALESCE(rtjb005,' '), ",                                  #產品特徵 
               "       rtdx003,stbh001,rtax001 ",                                 #經營方式,合同編號,管理品類
               "  FROM adep990_tmp01 "    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               
   IF l_para_scc = '1' THEN                          
      LET g_sql = g_sql,  
               " GROUP BY rtjbent,rtjadocdt,rtjbsite,rtjb025,rtjb004, ",
               "          rtjb003,rtjb028,  rtjb006, imaa104,rtjb005, ",
               "          rtdx003,stbh001,  stbh004, mmaq002,mmag004, ",
               "          rtax001 "      
   ELSE
      LET g_sql = g_sql,            
               " GROUP BY rtjbent,rtjadocdt,rtjbsite,rtjb025,rtjb004, ",
               "          rtjb003,rtjb028,  rtjb006, rtjb013,rtjb005, ",
               "          rtdx003,stbh001,  stbh004, mmaq002,mmag004, ",
               "          rtax001 "
   END IF
   PREPARE adep990_ins_debb_p FROM g_sql 
   EXECUTE adep990_ins_debb_p   
   #160107-00021#1 2016/01/08 By benson --- E
   
   #DISPLAY "G:",cl_get_current()             
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#70 : adep990_ins_debb_p : INSERT INTO adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03                  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins debb_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success
   END IF 
   FREE adep990_ins_debb_p  #160107-00021#1 2016/01/08 By benson
   
   #補資料
   LET g_sql = "UPDATE adep990_tmp03 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
               "   SET debb001 = (SELECT ooef101 FROM ooef_t WHERE ooefent = debbent AND ooef001 = debbsite), ",
               "       (debb003,debb004) = (SELECT oogc008,oogc006 FROM oogc_t,ooef_t WHERE oogcent = debbent AND oogc002 = '4' AND oogc003 = debb002 AND ooefent = debbent AND ooef001 = debbsite AND oogc001 = ooef008), ",
               "       (debb006,debb007,debb008) = (SELECT inaa102,inaa111,inaa105 FROM inaa_t WHERE inaaent = debbent AND inaasite = debbsite AND inaa001 = debb005), ",
               "       (debb011,debb012) = (SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent = debbent AND imaal001 = debb009 AND imaal002 = '",g_lang,"'), ",
               "       (debb013,debb016) = (SELECT imaa126,imaa009 FROM imaa_t WHERE imaaent = debbent AND imaa001 = debb009), ",
               "       debb014 = (SELECT imaf153 FROM imaf_t WHERE imafent = debbent AND imafsite = debbsite AND imaf001 = debb009), ",
               "       debb010 = COALESCE(debb010,' '),debb017 = COALESCE(debb017,' '),debb020 = COALESCE(debb020,' '),debb021 = COALESCE(debb021,' ') "

   PREPARE adep990_debb_p1 FROM g_sql 
   EXECUTE adep990_debb_p1
   #DISPLAY "H:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#71 : adep990_debb_p1 : UPDATE adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03                  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_debb_p1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF   
   FREE adep990_debb_p1
   
   LET g_sql = "UPDATE adep990_tmp03 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
               "   SET debb031 = (SELECT COUNT(UNIQUE rtjbdocno) FROM adep990_tmp01 ",     #客單數   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
               "                   WHERE rtjbent = debbent ",
               "                     AND rtjbsite = debbsite ",
               "                     AND rtjadocdt = debb002 ",
               "                     AND COALESCE(mmaq002,' ') = COALESCE(debb020,' ') ",
               "                     AND COALESCE(mmag004,' ') = COALESCE(debb021,' ') ",
               "                     AND COALESCE(rtjb004,' ') = COALESCE(debb009,' ') ",      #商品編號
               "                     AND COALESCE(rtjb025,' ') = COALESCE(debb005,' ') ",      #庫區編號
               "                     AND COALESCE(rtjb028,' ') = COALESCE(debb017,' ') ",      #專櫃編號
               "                     AND COALESCE(rtjb013,' ') = COALESCE(debb019,' ')) "      #銷售單位  
   PREPARE adep990_debb_p2 FROM g_sql
   EXECUTE adep990_debb_p2
   
   #DISPLAY "I:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#72 : adep990_debb_p2 : UPDATE adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_debb_p2"
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE
      RETURN r_success      
   END IF  
   FREE adep990_debb_p2
   
   #會員取成本還有問題
   #LET g_sql = "UPDATE adep990_debb_tmp ",
   #            "   SET debb023 = (SELECT COALESCE(SUM(COALESCE(rtib023,0)),0)     ",               #成本金額
   #            "                    FROM rtib_t,rtia_t ",
   #            "                   WHERE rtibent = rtiaent ",
   #            "                     AND rtibdocno = rtiadocno ",
   #            "                     AND rtibent = debbent ",
   #            "                     AND rtibsite = debbsite ",                           #營運據點
   #            "                     AND rtiadocdt = debb002 ",                           #單據日期
   #            "                     AND rtib004 = debb009 ",                             #商品編號
   #           #"                     AND COALESCE(rtib005,' ') = COALESCE(debb035,' ') ", #產品特徵  #POS上傳無此資料
   #            "                     AND rtib025 = debb005 ",                             #庫區編號
   #            "                     AND COALESCE(rtib028,' ') = COALESCE(debb017,' ') ", #專櫃編號
   #           #"                     AND COALESCE(rtib006,' ') = COALESCE(debb018,' ') ", #稅別編號  #POS上傳無此資料
   #            "                     AND rtib013 = debb019                             ", #銷售單位
   #                                  #會員卡種
   #            "                     AND COALESCE(debb020,' ') = COALESCE((SELECT mmaq002 ",
   #            "                                                             FROM mmaq_t ",
   #            "                                                            WHERE mmaqent = rtiaent ",
   #            "                                                              AND mmaq001 = rtia001),' ') ",
   #            "                     AND COALESCE(debb021,' ') = COALESCE((SELECT mmag004 FROM mmag_t,mmaq_t ",
   #            "                                                            WHERE mmagent = rtiaent ",
   #            "                                                              AND mmagent = mmaqent ",
   #            "                                                              AND mmag001 = mmaq003 ",
   #            "                                                              AND mmaq001 = rtia001 ",
   #            "                                                              AND mmagent = ",g_enterprise,
   #            "                                                              AND mmag002 = '09' ",
   #            "                                                              AND mmag003 = '2024'),' ') ",
   #            "                     AND rtibent = ",g_enterprise,
   #            "                     AND rtiastus <> 'X' )"
   #
   #PREPARE adep990_debb_p3 FROM g_sql
   #EXECUTE adep990_debb_p3
   ##DISPLAY "J:",cl_get_current()
   #IF SQLCA.SQLcode THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = "adep990_debb_p3"
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   
   LET g_sql = "UPDATE adep990_tmp03 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
               #"   SET debb028 = COALESCE(debb027,0) - COALESCE(debb023,0) "
               "   SET debb028 = 0, ",
               "       debb029 = 0  "
   PREPARE adep990_debb_p4 FROM g_sql 
   EXECUTE adep990_debb_p4
   #DISPLAY "K:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#73 : adep990_debb_p4 : UPDATE adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03                 
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_debb_p4"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_debb_p4
   
   LET g_sql = "UPDATE adep990_tmp03 ",  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
               "   SET debb036 = (COALESCE(debb027,0) / CASE WHEN COALESCE(debb031,0) = 0 THEN 1 ELSE debb031 END) "
   
   PREPARE adep990_debb_p5 FROM g_sql 
   EXECUTE adep990_debb_p5
   #DISPLAY "L:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#74 : adep990_debb_p5 : UPDATE adep990_tmp03 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2] #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03                  
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_debb_p5"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   FREE adep990_debb_p5   
     
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep990_ins_table_1(ps_js)
   DEFINE ps_js         STRING
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_recountflag LIKE type_t.chr1
   DEFINE lc_param      type_parameter
   DEFINE l_site        LIKE deba_t.debasite
   DEFINE l_date        LIKE deba_t.deba002
   DEFINE l_cnt         LIKE type_t.num5  
   DEFINE l_where       STRING
   DEFINE l_sql         STRING
   DEFINE l_err_cnt     LIKE type_t.num5
   DEFINE l_wc          STRING   

   LET r_success = TRUE
   LET r_recountflag = 'N'
   CALL util.JSON.parse(ps_js,lc_param)
   CALL s_transaction_begin()

   IF lc_param.l_del = "Y" OR lc_param.l_del = "X" THEN
      #已結轉資料
      DECLARE adep990_deba_cl1 CURSOR FOR
      SELECT DISTINCT a.debasite,a.deba002 FROM adep990_tmp02 a   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
              WHERE EXISTS (SELECT 1 FROM deba_t b
                      WHERE b.debaent = a.debaent
                        AND b.debasite = a.debasite
                        AND b.deba002 = a.deba002)
                        
      FOREACH adep990_deba_cl1 INTO l_site,l_date
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00029'
         LET g_errparam.replace[1] = l_site
         LET g_errparam.replace[2] = l_date
         LET g_errparam.replace[3] = cl_getmsg('ade-00150',g_lang)
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_recountflag = 'Y'
      END FOREACH  
      FREE adep990_deba_cl1
      
      #刪除已結轉資料
      LET g_sql = "DELETE FROM deba_t a ",
                  "WHERE EXISTS (SELECT 1 FROM adep990_tmp02 b ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
                  "               WHERE b.debaent = a.debaent ",
                  "                 AND b.debasite = a.debasite ",
                  "                 AND b.deba002 = a.deba002) "
      PREPARE adep990_del_deba_p1 FROM g_sql           
      EXECUTE adep990_del_deba_p1
      FREE adep990_del_deba_p1
      
      #160607-00014#1 Add By Ken 160613(S)
------lanjj add on 2016-05-25 start 取aooi150配置 数量取位先写死为3位，截位配置先写死为“四舍五入” 
      LET l_sql = " MERGE INTO adep990_tmp02 o",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
                  " USING (SELECT ooef001,ooaj003,ooaj004,ooaj005 ",
                  "          FROM ooef_t ",
                  "               LEFT JOIN ooaj_t ON (ooajent = ooefent AND ooaj001 = ooef014 AND ooaj002 = ooef016) ",
                  "         WHERE ooefent = ",g_enterprise,
                  "           AND ooef304 = 'Y') u ",
                  "    ON (o.debasite = u.ooef001) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET o.deba019 = ROUND(o.deba019,NVL(u.ooaj004,2)), ",
                  "                  o.deba022 = ROUND(o.deba022,NVL(u.ooaj004,2)), ",
                  "                  o.deba023 = ROUND(o.deba023,NVL(u.ooaj004,2)), ",
                  "                  o.deba024 = ROUND(o.deba024,NVL(u.ooaj004,2)), ",
                  "                  o.deba025 = ROUND(o.deba025,NVL(u.ooaj004,2)), ",
                  "                  o.deba026 = ROUND(o.deba026,NVL(u.ooaj004,2)), ",
                  "                  o.deba027 = ROUND(o.deba027,NVL(u.ooaj004,2)), ",
                  "                  o.deba031 = ROUND(o.deba031,NVL(u.ooaj004,2)), ",
                  "                  o.deba032 = ROUND(o.deba032,NVL(u.ooaj004,2)), ",
                  "                  o.deba033 = ROUND(o.deba033,NVL(u.ooaj004,2)), ",
                  "                  o.deba034 = ROUND(o.deba034,NVL(u.ooaj004,2)), ",
                  "                  o.deba036 = ROUND(o.deba036,NVL(u.ooaj004,2)), ",
                  "                  o.deba037 = ROUND(o.deba037,NVL(u.ooaj004,2)), ",
                  "                  o.deba039 = ROUND(o.deba039,NVL(u.ooaj004,2)), ",
                  "                  o.deba040 = ROUND(o.deba040,NVL(u.ooaj004,2)), ",
                  "                  o.deba045 = ROUND(o.deba045,NVL(u.ooaj004,2)), ",
                  "                  o.deba046 = ROUND(o.deba046,NVL(u.ooaj004,2)), ",
                  "                  o.deba047 = ROUND(o.deba047,NVL(u.ooaj004,2)), ",
                  "                  o.deba048 = ROUND(o.deba048,NVL(u.ooaj003,4)), ",
                  "                  o.deba052 = ROUND(o.deba052,NVL(u.ooaj004,2)), ",
                  "                  o.deba021 = ROUND(o.deba021,3), ",
                  "                  o.deba029 = ROUND(o.deba029,3), ",
                  "                  o.deba030 = ROUND(o.deba030,3), ",
                  "                  o.deba035 = ROUND(o.deba035,3), ",
                  "                  o.deba038 = ROUND(o.deba038,3), ",
                  "                  o.deba044 = ROUND(o.deba044,3), ",
                  "                  o.deba051 = ROUND(o.deba051,3) "
      TRY
         EXECUTE IMMEDIATE l_sql
      CATCH
         LET g_log = "--Error#75 : MERGE INTO adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                 
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",l_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "merge adep990_tmp02"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END TRY
------lanjj add on 2016-05-25 start  
      #160607-00014#1 Add By Ken 160613(E)
      
      #塞資料                  
      INSERT INTO deba_t (debaent, debasite, deba001, deba002, deba003, deba004, deba005, deba006, deba007, deba008,
                          deba009, deba010, deba011, deba012, deba013, deba014, deba015, deba016, deba017, deba018, 
                          deba019, deba020, deba021, deba022, deba023, deba024, deba025, deba026, deba027, deba028, 
                          deba029, deba030, deba031, deba032, deba033, deba034, deba035, deba036, deba037, deba038,
                          deba039, deba040, deba043, deba045, deba046, deba047, deba048, deba049, deba050, deba051, 
                          deba052, deba053, deba054)                           
      SELECT debaent, debasite, deba001, deba002, deba003, deba004, deba005, deba006, deba007, deba008, 
             deba009, deba010, deba011, deba012, deba013, deba014, deba015, deba016, deba017, deba018, 
             deba019, deba020, deba021, deba022, deba023, deba024, deba025, deba026, deba027, deba028, 
             deba029, deba030, deba031, deba032, deba033, deba034, deba035, deba036, deba037, deba038,
             deba039, deba040, deba043, deba045, deba046, deba047, deba048, rtdx003, deba050, deba051,
             deba052, deba053, stbh001                                                         
        FROM adep990_tmp02   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
        
      IF SQLCA.SQLcode THEN 
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#75 : INSERT INTO deba_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                   
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",g_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deba_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END IF 
      
      #已結轉資料
      DECLARE adep990_debb_cl1 CURSOR FOR
      SELECT DISTINCT a.debbsite,a.debb002 FROM adep990_tmp03 a   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
              WHERE EXISTS (SELECT 1 FROM debb_t b
                      WHERE b.debbent = a.debbent
                        AND b.debbsite = a.debbsite
                        AND b.debb002 = a.debb002)
                        
      FOREACH adep990_debb_cl1 INTO l_site,l_date
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00029'
         LET g_errparam.replace[1] = l_site
         LET g_errparam.replace[2] = l_date
         LET g_errparam.replace[3] = cl_getmsg('ade-00151',g_lang)
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_recountflag = 'Y'
      END FOREACH  
      FREE adep990_debb_cl1

      #刪除已結轉資料
      LET g_sql = "DELETE FROM debb_t a ",
                  "WHERE EXISTS (SELECT 1 FROM adep990_tmp03 b ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
                  "               WHERE b.debbent = a.debbent ",
                  "                 AND b.debbsite = a.debbsite ",
                  "                 AND b.debb002 = a.debb002) "
      PREPARE adep990_del_debb_p1 FROM g_sql           
      EXECUTE adep990_del_debb_p1
      FREE adep990_del_debb_p1
      #塞資料                  
      INSERT INTO debb_t (debbent, debbsite, debb001, debb002, debb003, debb004, debb005, debb006, debb007, debb008, 
                          debb009, debb010,  debb011, debb012, debb013, debb014, debb015, debb016, debb017, debb018, 
                          debb019, debb020,  debb021, debb022, debb023, debb024, debb025, debb026, debb027, debb028,
                          debb029, debb030,  debb031, debb032, debb033, debb034, debb035, debb036, debb037, debb038,
                          debb039)  
      SELECT debbent, debbsite, debb001, debb002, debb003, debb004, debb005, debb006, debb007, debb008, 
             debb009, debb010,  debb011, debb012, debb013, debb014, debb015, debb016, debb017, debb018, 
             debb019, debb020,  debb021, debb022, debb023, debb024, debb025, debb026, debb027, debb028,
             debb029, debb030,  debb031, debb032, debb033, debb034, debb035, debb036, rtdx003, debb038,
             stbh001
        FROM adep990_tmp03   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
        
      IF SQLCA.SQLcode THEN 
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#76 : INSERT INTO debb_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                   
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",g_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END IF 
      
   ELSE
      #已結轉資料
      DECLARE adep990_deba_cl2 CURSOR FOR
      SELECT DISTINCT a.debasite,a.deba002 FROM adep990_tmp02 a   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
              WHERE EXISTS (SELECT 1 FROM deba_t b
                      WHERE b.debaent = a.debaent
                        AND b.debasite = a.debasite
                        AND b.deba002 = a.deba002)
                        
      FOREACH adep990_deba_cl2 INTO l_site,l_date
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00030'
         LET g_errparam.replace[1] = l_site
         LET g_errparam.replace[2] = l_date
         LET g_errparam.replace[3] = cl_getmsg('ade-00150',g_lang)
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_recountflag = 'Y'
      END FOREACH
      FREE adep990_deba_cl2
      
      #160607-00014#1 Add By Ken 160613(S)
------lanjj add on 2016-05-25 start 取aooi150配置 数量取位先写死为3位，截位配置先写死为“四舍五入” 
      LET l_sql = " MERGE INTO adep990_tmp02 o",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
                  " USING (SELECT ooef001,ooaj003,ooaj004,ooaj005 ",
                  "          FROM ooef_t ",
                  "               LEFT JOIN ooaj_t ON (ooajent = ooefent AND ooaj001 = ooef014 AND ooaj002 = ooef016) ",
                  "         WHERE ooefent = ",g_enterprise,
                  "           AND ooef304 = 'Y') u ",
                  "    ON (o.debasite = u.ooef001) ",
                  "  WHEN MATCHED THEN ",
                  "       UPDATE SET o.deba019 = ROUND(o.deba019,NVL(u.ooaj004,2)), ",
                  "                  o.deba022 = ROUND(o.deba022,NVL(u.ooaj004,2)), ",
                  "                  o.deba023 = ROUND(o.deba023,NVL(u.ooaj004,2)), ",
                  "                  o.deba024 = ROUND(o.deba024,NVL(u.ooaj004,2)), ",
                  "                  o.deba025 = ROUND(o.deba025,NVL(u.ooaj004,2)), ",
                  "                  o.deba026 = ROUND(o.deba026,NVL(u.ooaj004,2)), ",
                  "                  o.deba027 = ROUND(o.deba027,NVL(u.ooaj004,2)), ",
                  "                  o.deba031 = ROUND(o.deba031,NVL(u.ooaj004,2)), ",
                  "                  o.deba032 = ROUND(o.deba032,NVL(u.ooaj004,2)), ",
                  "                  o.deba033 = ROUND(o.deba033,NVL(u.ooaj004,2)), ",
                  "                  o.deba034 = ROUND(o.deba034,NVL(u.ooaj004,2)), ",
                  "                  o.deba036 = ROUND(o.deba036,NVL(u.ooaj004,2)), ",
                  "                  o.deba037 = ROUND(o.deba037,NVL(u.ooaj004,2)), ",
                  "                  o.deba039 = ROUND(o.deba039,NVL(u.ooaj004,2)), ",
                  "                  o.deba040 = ROUND(o.deba040,NVL(u.ooaj004,2)), ",
                  "                  o.deba045 = ROUND(o.deba045,NVL(u.ooaj004,2)), ",
                  "                  o.deba046 = ROUND(o.deba046,NVL(u.ooaj004,2)), ",
                  "                  o.deba047 = ROUND(o.deba047,NVL(u.ooaj004,2)), ",
                  "                  o.deba048 = ROUND(o.deba048,NVL(u.ooaj003,4)), ",
                  "                  o.deba052 = ROUND(o.deba052,NVL(u.ooaj004,2)), ",
                  "                  o.deba021 = ROUND(o.deba021,3), ",
                  "                  o.deba029 = ROUND(o.deba029,3), ",
                  "                  o.deba030 = ROUND(o.deba030,3), ",
                  "                  o.deba035 = ROUND(o.deba035,3), ",
                  "                  o.deba038 = ROUND(o.deba038,3), ",
                  "                  o.deba044 = ROUND(o.deba044,3), ",
                  "                  o.deba051 = ROUND(o.deba051,3) "
      TRY
         EXECUTE IMMEDIATE l_sql
      CATCH
         LET g_log = "--Error#75 : MERGE INTO adep990_tmp02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02                
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",l_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "merge adep990_tmp02"   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END TRY
------lanjj add on 2016-05-25 start
      #160607-00014#1 Add By Ken 160613(E)

      #塞資料
      INSERT INTO deba_t (debaent, debasite, deba001, deba002, deba003, deba004, deba005, deba006, deba007, deba008,
                          deba009, deba010,  deba011, deba012, deba013, deba014, deba015, deba016, deba017, deba018, 
                          deba019, deba020,  deba021, deba022, deba023, deba024, deba025, deba026, deba027, deba028, 
                          deba029, deba030,  deba031, deba032, deba033, deba034, deba035, deba036, deba037, deba038,
                          deba039, deba040,  deba043, deba045, deba046, deba047, deba048, deba049, deba050, deba051,
                          deba052, deba053,  deba054)  
      SELECT a.debaent, a.debasite, a.deba001, a.deba002, a.deba003, a.deba004, a.deba005, a.deba006, a.deba007, a.deba008, 
             a.deba009, a.deba010,  a.deba011, a.deba012, a.deba013, a.deba014, a.deba015, a.deba016, a.deba017, a.deba018, 
             a.deba019, a.deba020,  a.deba021, a.deba022, a.deba023, a.deba024, a.deba025, a.deba026, a.deba027, a.deba028, 
             a.deba029, a.deba030,  a.deba031, a.deba032, a.deba033, a.deba034, a.deba035, a.deba036, a.deba037, a.deba038,
             a.deba039, a.deba040,  a.deba043, a.deba045, a.deba046, a.deba047, a.deba048, a.rtdx003, a.deba050, a.deba051, 
             a.deba052, a.deba053,  a.stbh001
        FROM adep990_tmp02 a    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
       WHERE NOT EXISTS (SELECT 1 FROM deba_t b
                          WHERE b.debaent = a.debaent
                            AND b.debasite = a.debasite
                            AND b.deba002 = a.deba002)
      IF SQLCA.SQLcode THEN 
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#76 : INSERT INTO deba_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                              
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",g_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins deba_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END IF 
      
      #已結轉資料
      DECLARE adep990_debb_cl2 CURSOR FOR
      SELECT DISTINCT a.debbsite,a.debb002 FROM adep990_tmp03 a   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
              WHERE EXISTS (SELECT 1 FROM debb_t b
                      WHERE b.debbent = a.debbent
                        AND b.debbsite = a.debbsite
                        AND b.debb002 = a.debb002)
                        
      FOREACH adep990_debb_cl2 INTO l_site,l_date
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ade-00030'
         LET g_errparam.replace[1] = l_site
         LET g_errparam.replace[2] = l_date
         LET g_errparam.replace[3] = cl_getmsg('ade-00151',g_lang)
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_recountflag = 'Y'
      END FOREACH   
      FREE adep990_debb_cl2
      
      #塞資料
      INSERT INTO debb_t (debbent, debbsite, debb001, debb002, debb003, debb004, debb005, debb006, debb007, debb008, 
                          debb009, debb010,  debb011, debb012, debb013, debb014, debb015, debb016, debb017, debb018, 
                          debb019, debb020,  debb021, debb022, debb023, debb024, debb025, debb026, debb027, debb028,
                          debb029, debb030,  debb031, debb032, debb033, debb034, debb035, debb036, debb037, debb038,
                          debb039)
      SELECT a.debbent, a.debbsite, a.debb001, a.debb002, a.debb003, a.debb004, a.debb005, a.debb006, a.debb007, a.debb008, 
             a.debb009, a.debb010,  a.debb011, a.debb012, a.debb013, a.debb014, a.debb015, a.debb016, a.debb017, a.debb018, 
             a.debb019, a.debb020,  a.debb021, a.debb022, a.debb023, a.debb024, a.debb025, a.debb026, a.debb027, a.debb028,
             a.debb029, a.debb030,  a.debb031, a.debb032, a.debb033, a.debb034, a.debb035, a.debb036, a.rtdx003, a.debb038,
             a.stbh001
        FROM adep990_tmp03 a   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
       WHERE NOT EXISTS (SELECT 1 FROM debb_t b
                          WHERE b.debbent = a.debbent
                            AND b.debbsite = a.debbsite
                            AND b.debb002 = a.debb002)
      IF SQLCA.SQLcode THEN 
         #160111-00006#1 s983961 --add(s)                                   
         LET g_log = "--Error#77 : INSERT INTO debb_t fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                              
         CALL cl_log_write(g_log)
         DISPLAY g_log       
         
         LET g_log = "--SQL: ",g_sql
         CALL cl_log_write(g_log)
         DISPLAY g_log
         #160111-00006#1 s983961 --add(e)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins debb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')     
         LET r_success = FALSE
         RETURN r_success,r_recountflag
      END IF 
      
   END IF
   
   CALL s_transaction_end('Y','0') 
   

   LET l_where = cl_replace_str(g_where,'rtjasite','debasite')
   LET l_wc = cl_replace_str(lc_param.wc,'rtjasite','debasite') 
   LET l_wc = l_wc, " AND ",l_where
   CALL s_transaction_begin()
   IF s_adep101(l_wc,lc_param.rtjadocdt,'N') THEN
      CALL s_transaction_end('Y','0')
   ELSE
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#78 : CALL s_adep101 fail! Parameters : ",
                  "  l_wc:",l_wc," rtjadocdt:",lc_param.rtjadocdt
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e)
      CALL s_transaction_end('N','0')
      LET r_success = FALSE
      RETURN r_success,r_recountflag
   END IF
   #DISPLAY "M:",cl_get_current()
   RETURN r_success,r_recountflag
END FUNCTION

PRIVATE FUNCTION adep990_drop_temp()
   DEFINE r_success      LIKE type_t.num5

   DROP TABLE adep990_tmp01    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp01'   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp ——> adep990_tmp01
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp02   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp02'   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deba_tmp ——> adep990_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
         
   DROP TABLE adep990_tmp03   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp03'   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp04  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_site_tmp ——> adep990_tmp04
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp03'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debb_tmp ——> adep990_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp05  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep100_rtje_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp06    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep100_rtje_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp07  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp07'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debk_tmp ——> adep990_tmp07
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp08   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp08'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debl_tmp ——> adep990_tmp08
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp09  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp09'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debm_tmp ——> adep990_tmp09
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp10    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp10'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_deca_tmp ——> adep990_tmp10
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp11     #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp11'   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decb_tmp ——> adep990_tmp11
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp12     #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp12'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decc_tmp ——> adep990_tmp12
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DROP TABLE adep990_tmp13    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debf_tmp ——> adep990_tmp13
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp13'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_debf_tmp ——> adep990_tmp13
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #160512-00019#1 Add By Ken 160518(S)
   DROP TABLE adep990_tmp15    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp1 ——> adep990_tmp15
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp15'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp1 ——> adep990_tmp15
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF  
   
   DROP TABLE adep990_tmp16  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decx_tmp ——> adep990_tmp16
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp16'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_decx_tmp ——> adep990_tmp16
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF   
   #160512-00019#1 Add By Ken 160518(S)   
   
   DROP TABLE adep990_tmp14     #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtib_tmp ——> adep990_tmp14
   
   IF SQLCA.sqlcode != 0 AND SQLCA.sqlcode != '-206' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adep990_tmp14'  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtib_tmp ——> adep990_tmp14
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
END FUNCTION
#款別資訊暫存檔
PRIVATE FUNCTION adep990_ins_temp_rtje(ps_js)
   DEFINE ps_js       STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE lc_param    type_parameter
   DEFINE l_wc        STRING
   DEFINE l_where     STRING   
   
   CALL util.JSON.parse(ps_js,lc_param)

   DELETE FROM adep990_tmp05  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
   
   LET r_success = TRUE

   LET l_where = cl_replace_str(g_where,'rtjasite','rtjesite')  
   LET l_wc = cl_replace_str(lc_param.wc,'rtjasite','rtjesite')  
   #款別資訊
   LET g_sql = "INSERT INTO adep990_tmp05 ",  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05
               "SELECT rtjeent,rtjesite,rtjadocdt,COALESCE(rtjb025,' '),COALESCE(rtja005,' '), ",
               "       (SELECT imaa009 FROM imaa_t WHERE imaaent = rtjbent AND imaa001 = rtjb004), ",
               "       COALESCE(rtjb028,' '),COALESCE(rtjb006,' '), ",
               "       COALESCE(rtje001,' '),COALESCE(rtje002,' '),COALESCE(rtje006,0),COALESCE(rtja026,' ') ",
               "  FROM rtje_t,rtjb_t,rtja_t ",
               " WHERE rtjeent = rtjbent ",
               "   AND rtjedocno = rtjbdocno ",
               "   AND rtjeseq = rtjbseq ",
               "   AND rtjbent = rtjaent ",
               "   AND rtjbdocno = rtjadocno ",
               "   AND rtjastus <> 'X' ",
               "   AND rtjaent = '",g_enterprise,"'",
               "   AND ",l_wc,
               "   AND ",l_where
   IF NOT cl_null(lc_param.rtjadocdt) THEN
      LET g_sql = g_sql," AND rtjadocdt ='",lc_param.rtjadocdt,"'"
   END IF

   PREPARE adep990_rtje_p1 FROM g_sql
   EXECUTE adep990_rtje_p1
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#79 : adep990_rtje_p1 : INSERT INTO adep990_tmp05 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtje_tmp ——> adep990_tmp05                            
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins rtje_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
   FREE adep990_rtje_p1
   
   RETURN r_success 
END FUNCTION

PRIVATE FUNCTION adep990_ins_temp_s(ps_js)
   DEFINE ps_js       STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE lc_param    type_parameter
   DEFINE l_rtjb    RECORD
            rtjbsite    LIKE rtjb_t.rtjbsite,
            rtjadocdt   LIKE rtja_t.rtjadocdt,
            rtjb004     LIKE rtjb_t.rtjb004,
            imaf153     LIKE imaf_t.imaf153,
            rtdx003     LIKE rtdx_t.rtdx003
          END RECORD    
   DEFINE l_stbh001     LIKE stbh_t.stbh001
   DEFINE l_stbh004     LIKE stbh_t.stbh004
   DEFINE l_rtaw_para   LIKE type_t.chr10
   

   CALL util.JSON.parse(ps_js,lc_param)

   LET r_success = TRUE
   
   DELETE FROM adep990_tmp06    #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   
   LET l_rtaw_para = cl_get_para(g_enterprise,g_site,'E-CIR-0001')   
   
   #DISPLAY "1:",cl_get_current()
   #塞資料
   LET g_sql = "INSERT INTO adep990_tmp06(rtjbent,rtjbsite,rtjadocdt,rtjbdocno,rtjbseq, ",  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               "                               mmag004,mmaq002, mmaq003,  rtja005,  rtjb004, ",
               "                               imaa126,imaa009, imaf153,  rtjb006,  rtjb013, ",
               "                               rtjb025,rtjb028, rtja026,  rtjb005,  rtdx003, ",
               "                               rtja001,stbh001, stbh004,  rtax001,  rtjb012 ) ",
               "SELECT rtjbent,rtjbsite,rtjadocdt,rtjbdocno,rtjbseq,",
               "       COALESCE((SELECT mmag004 FROM mmag_t ",
               "                  WHERE mmagent = rtjaent ",
               "                    AND mmag001 = (SELECT mmaq003 FROM mmaq_t ",
               "                                    WHERE mmaqent = rtjaent ",
               "                                      AND mmaq001 = rtja001) ",
               "                    AND mmagent = ",g_enterprise,
               "                    AND mmag002 = '09' ",
               "                    AND mmag003 = '2024'),' '),",
               "       COALESCE((SELECT mmaq002 FROM mmaq_t WHERE mmaqent = rtjaent AND mmaq001 = rtja001),' '),",
               "       COALESCE((SELECT mmaq003 FROM mmaq_t WHERE mmaqent = rtjaent AND mmaq001 = rtja001),' '),",
               "       rtja005,",
               "       COALESCE(rtjb004,' '), '', '', '', ", 
               "       COALESCE(rtjb006,' '), COALESCE(rtjb013,' '),COALESCE(rtjb025,' '), COALESCE(rtjb028,' '),",
               "       rtja026,               COALESCE(rtjb005,' '),",  
               "       '',COALESCE(rtja001,' '),'','','', COALESCE(rtjb012,0)",   
               "  FROM rtjb_t, rtja_t ",
               " WHERE rtjbent = rtjaent ",
               "   AND rtjbdocno = rtjadocno ",
               "   AND rtjastus <> 'X' ",
               "   AND rtjaent = ",g_enterprise,
               "   AND rtjadocdt ='",lc_param.rtjadocdt,"'",
               "   AND ",lc_param.wc,
               "   AND ",g_where    

   PREPARE adep990_rtjb_s_p1 FROM g_sql           
   EXECUTE adep990_rtjb_s_p1 
   #DISPLAY "2:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#80 : adep990_rtjb_s_p1 : INSERT INTO adep990_tmp06 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06                             
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_s_p1"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success    
   END IF
   FREE adep990_rtjb_s_p1
   
   LET g_sql = "UPDATE adep990_tmp06 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               "   SET imaf153 = (SELECT imaf153 FROM imaf_t ",
               "                   WHERE imafent = rtjbent ",
               "                     AND imafsite = rtjbsite ",
               "                     AND imaf001 = rtjb004 ",
               "                     AND imafent = ",g_enterprise,"), ", 
               "       (imaa126,imaa009) = (SELECT imaa126,imaa009 FROM imaa_t ",
               "                             WHERE imaaent = rtjbent ",
               "                               AND imaa001 = rtjb004 ",
               "                               AND imaaent = ",g_enterprise,") "               
   
   PREPARE adep990_rtjb_s_p2 FROM g_sql 
   EXECUTE adep990_rtjb_s_p2 
   #DISPLAY "3:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#81 : adep990_rtjb_s_p2 : UPDATE adep990_tmp06 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06                             
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_s_p2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF
   FREE adep990_rtjb_s_p2
   
   #補資料2
   #1.取營運組織商品清單[經營方式]
   LET g_sql = "UPDATE adep990_tmp06 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               "   SET rtdx003 = (SELECT rtdx003 FROM rtdx_t WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004), ",
               "       rtax001 = (SELECT rtaw001 FROM rtaw_t WHERE rtawent = rtjbent AND rtaw002 = imaa009 AND rtaw003 = '",l_rtaw_para,"' )"
   PREPARE adep990_rtjb_s_p3 FROM g_sql           
   EXECUTE adep990_rtjb_s_p3 
   #DISPLAY "4:",cl_get_current()
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#82 : adep990_rtjb_s_p3 : UPDATE adep990_tmp06 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]  #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06                             
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_s_p3"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      LET r_success = FALSE
      RETURN r_success  
   END IF
   FREE adep990_rtjb_s_p3
   
   #2.先取促銷協議[合同編號][扣率],無促銷協議則取採購協議[合同編號][扣率]
   #促銷協議
   LET l_sql = "SELECT stbh001,stbh004",
               "  FROM stbh_t,stbi_t ",
               " WHERE stbhent   = ",g_enterprise,
               "   AND stbhsite  = ? ",
               "   AND stbhent = stbient ",                    #160922-00005#1 Add By ken 160922
               "   AND stbhdocno = stbidocno",
               "   AND stbh002   = ? ",   #供應商
               "   AND stbh003   = ? ",   #經營方式
               "   AND stbi001   = ? ",   #商品編號
               "   AND stbi011  <= ? ",
               "   AND (stbi012 >= ? OR stbi012 IS NULL) ",   
               "   AND stbhstus  = 'Y' ",
               " ORDER BY stbhcnfdt DESC "
               
   PREPARE adep990_rtjb_s_p7 FROM l_sql
   DECLARE adep990_rtjb_s_cs7 SCROLL CURSOR FOR adep990_rtjb_s_p7
   #採購協議
   LET l_sql = "SELECT star004,star006 ",
               "  FROM star_t,stas_t ",
               " WHERE starent  = ",g_enterprise,
               "   AND starsite =  ? ",  
               "   AND starent  = stasent ",  #160922-00005#1 Add By ken 160922
               "   AND starsite = stassite ", #160922-00005#1 Add By ken 160922               
               "   AND star001  =  stas001 ",           
               "   AND star003  =  ? ",   #供應商 
               "   AND star005  =  ? ",   #經營方式 
               "   AND stas003  =  ? ",   #商品編號               
               "   AND stas018  <= ? ",  
               "   AND (stas019 >= ? OR stas019 IS NULL) ",
               "   AND starstus  = 'Y' ",
               " ORDER BY starcnfdt DESC " 
   PREPARE adep990_rtjb_s_p8 FROM l_sql
   DECLARE adep990_rtjb_s_cs8 SCROLL CURSOR FOR adep990_rtjb_s_p8

   LET g_sql = "SELECT UNIQUE rtjbsite,rtjadocdt,rtjb004,imaf153,rtdx003 ",    
               "  FROM adep990_tmp06 "   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   PREPARE adep990_rtjb_s_p9 FROM g_sql
   DECLARE adep990_rtjb_s_cs9 CURSOR FOR adep990_rtjb_s_p9
   
   LET g_sql = "UPDATE adep990_tmp06 ",   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
               "   SET stbh001 = ? ,",
               "       stbh004 = ?  ",
               " WHERE rtjbent = ",g_enterprise,
               "   AND rtjbsite = ? ",
               "   AND rtjadocdt = ? ",
               "   AND rtjb004 = ? ",
               "   AND imaf153 = ? ",
               "   AND rtdx003 = ? "
   PREPARE adep990_rtjb_s_p10 FROM g_sql           
 
   IF lc_param.l_type = '0' OR  lc_param.l_type = '1' OR  lc_param.l_type = '2' OR  lc_param.l_type = '7' THEN
      FOREACH adep990_rtjb_s_cs9 INTO l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb004, 
                                      l_rtjb.imaf153, l_rtjb.rtdx003
         LET l_stbh001 = ''
         LET l_stbh004 = ''
         
         OPEN adep990_rtjb_s_cs7 USING l_rtjb.rtjbsite,l_rtjb.imaf153,  l_rtjb.rtdx003,
                                       l_rtjb.rtjb004, l_rtjb.rtjadocdt,l_rtjb.rtjadocdt
         FETCH FIRST adep990_rtjb_s_cs7 INTO l_stbh001,l_stbh004
         
         IF cl_null(l_stbh001) THEN
            OPEN adep990_rtjb_s_cs8 USING l_rtjb.rtjbsite,l_rtjb.imaf153,  l_rtjb.rtdx003,
                                          l_rtjb.rtjb004, l_rtjb.rtjadocdt,l_rtjb.rtjadocdt
            FETCH FIRST adep990_rtjb_s_cs8 INTO l_stbh001,l_stbh004
         END IF
         
         
         
         #更新[合同編號][扣率]
         EXECUTE adep990_rtjb_s_p10 USING l_stbh001,l_stbh004,
                                          l_rtjb.rtjbsite,l_rtjb.rtjadocdt,l_rtjb.rtjb004, 
                                          l_rtjb.imaf153, l_rtjb.rtdx003
         IF SQLCA.SQLcode THEN
            #160111-00006#1 s983961 --add(s)                                   
            LET g_log = "--Error#83 : EXECUTE adep990_rtjb_s_p10 USING stbh001(",l_stbh001,"),stbh004(",l_stbh004,"), ",
                        "  rtjbsite(",l_rtjb.rtjbsite,"),rtjadocdt(",l_rtjb.rtjadocdt,"),rtjb004(",l_rtjb.rtjb004,"),imaf153(",l_rtjb.imaf153,"), rtdx003(",l_rtjb.rtdx003,") fail! ",
                        "  SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                                                                         
            CALL cl_log_write(g_log)
            DISPLAY g_log       
            #160111-00006#1 s983961 --add(e)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "adep990_rtjb_s_p10"
            LET g_errparam.popup = TRUE
            CALL cl_err() 
            LET r_success = FALSE
            RETURN r_success
         END IF 
         
      END FOREACH  
   END IF
   FREE adep990_rtjb_s_p7
   FREE adep990_rtjb_s_cs7
   FREE adep990_rtjb_s_p8
   FREE adep990_rtjb_s_cs8
   FREE adep990_rtjb_s_p9
   FREE adep990_rtjb_s_cs9
   FREE adep990_rtjb_s_p10
   
   #160819-00054#48 by sakura add(S)
   #對應的 "會員編號mmaq003" 為一格空白時,則 "會員卡號rtja001" 也要更新為一格空白
   LET g_sql = "UPDATE adep990_tmp06 ",
               "   SET rtja001 = ' ' ",
               " WHERE mmaq003 = ' ' "             
   
   PREPARE adep990_rtjb_s_p11 FROM g_sql 
   EXECUTE adep990_rtjb_s_p11 
   IF SQLCA.SQLcode THEN                                 
      LET g_log = "--Error#87 : adep990_rtjb_s_p11 : UPDATE adep990_tmp06 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      
      LET g_log = "--SQL: ",g_sql
      CALL cl_log_write(g_log)
      DISPLAY g_log
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "adep990_rtjb_s_p11"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF
   FREE adep990_rtjb_s_p11   
   #160819-00054#48 by sakura add(E)
   
   #DISPLAY "5:",cl_get_current()
   
   #CREATE INDEX adep990_rtjb_ts01 ON adep990_rtjb_tmp_s(rtjbent,rtjadocdt,rtjbsite,rtjb004,rtjb025,
   #                                                     rtjb028,rtjb013,  rtjb006, rtjb012,mmaq002,
   #                                                     mmaq003,mmag004)
   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   EXECUTE IMMEDIATE "CREATE INDEX adep990_rtjb_ts01 
                          ON adep990_tmp06(rtjbent,rtjadocdt,rtjbsite,COALESCE(rtjb004,' '),COALESCE(rtjb025,' '),
                                                COALESCE(rtjb028,' '), COALESCE(rtjb013,' '),    COALESCE(rtjb006,' '), rtjb012,COALESCE(mmaq002,' '),
                                                COALESCE(mmaq003,' '), COALESCE(mmag004,' '))"                                                
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#84 : CREATE INDEX adep990_rtjb_ts01 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                                              
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep990_rtjb_ts01"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #CREATE INDEX adep990_rtjb_ts02 ON adep990_rtjb_tmp_s(rtjbent,rtjbsite,rtjadocdt,rtax001,imaa126,imaf153,
   #                                                     stbh004,rtjb006,mmaq002,mmag004,rtjb012)
   #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   EXECUTE IMMEDIATE "CREATE INDEX adep990_rtjb_ts02 
                          ON adep990_tmp06(rtjbent,rtjbsite,rtjadocdt,COALESCE(rtax001,' '),COALESCE(imaa126,' '),COALESCE(imaf153,' '),
                                                 COALESCE(stbh004,' '),COALESCE(rtjb006,' '),COALESCE(mmaq002,' '),COALESCE(mmag004,' '),rtjb012)"                                     
   IF SQLCA.SQLcode THEN
      #160111-00006#1 s983961 --add(s)                                   
      LET g_log = "--Error#85 : CREATE INDEX adep990_rtjb_ts02 fail! SQLCA.sqlerrd[2]: ",SQLCA.sqlerrd[2]                                              
      CALL cl_log_write(g_log)
      DISPLAY g_log       
      #160111-00006#1 s983961 --add(e)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX adep990_rtjb_ts02"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   

   #EXECUTE IMMEDIATE "analyze table adep990_rtjb_tmp_s estimate statistics"   
   IF cl_db_generate_analyze("adep990_tmp06") THEN END IF     #160727-00019#9   16/08/02 By 08734 临时表长度超过15码的减少到15码以下 adep990_rtjb_tmp_s ——> adep990_tmp06
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
