#該程式未解開Section, 採用最新樣板產出!
{<section id="apjp500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-10-27 14:35:08), PR版次:0002(2016-12-15 16:16:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: apjp500
#+ Description: 專案成本計算作業
#+ Creator....: 02294(2015-10-08 17:58:21)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="apjp500.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161124-00048#14   2016/12/15  By 08734    星号整批调整
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
        yy           LIKE type_t.chr80, 
        pp           LIKE type_t.chr80,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pjba001 LIKE type_t.chr20, 
   yy LIKE type_t.num5, 
   pp LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaa003        LIKE glaa_t.glaa003
DEFINE g_comp           LIKE pjcc_t.pjcccomp
DEFINE g_ld             LIKE pjcc_t.pjccld
DEFINE g_type           LIKE xcdk_t.xcdk003   #成本域类型
DEFINE g_last_yy        LIKE type_t.num5      #上期的年度
DEFINE g_last_pp        LIKE type_t.num5      #上期的期别
DEFINE g_bdate          LIKE type_t.dat       #当期所属的起始日期
DEFINE g_edate          LIKE type_t.dat       #当期所属的截止日期
#DEFINE g_pjcc           RECORD LIKE pjcc_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE g_pjcc RECORD  #專案庫存成本期異動統計檔
       pjccent LIKE pjcc_t.pjccent, #企业编号
       pjcccomp LIKE pjcc_t.pjcccomp, #法人组织
       pjccld LIKE pjcc_t.pjccld, #账套
       pjcc001 LIKE pjcc_t.pjcc001, #账套本位币顺序
       pjcc002 LIKE pjcc_t.pjcc002, #成本域(项目编号)
       pjcc003 LIKE pjcc_t.pjcc003, #成本计算类型
       pjcc004 LIKE pjcc_t.pjcc004, #年度
       pjcc005 LIKE pjcc_t.pjcc005, #期别
       pjcc010 LIKE pjcc_t.pjcc010, #核算币种
       pjcc102 LIKE pjcc_t.pjcc102, #上期结存金额
       pjcc102a LIKE pjcc_t.pjcc102a,
       pjcc102b LIKE pjcc_t.pjcc102b,
       pjcc102c LIKE pjcc_t.pjcc102c,
       pjcc102d LIKE pjcc_t.pjcc102d,
       pjcc102e LIKE pjcc_t.pjcc102e,
       pjcc102f LIKE pjcc_t.pjcc102f,
       pjcc102g LIKE pjcc_t.pjcc102g,
       pjcc102h LIKE pjcc_t.pjcc102h,
       pjcc202 LIKE pjcc_t.pjcc202, #本期入库金额
       pjcc202a LIKE pjcc_t.pjcc202a,
       pjcc202b LIKE pjcc_t.pjcc202b,
       pjcc202c LIKE pjcc_t.pjcc202c,
       pjcc202d LIKE pjcc_t.pjcc202d,
       pjcc202e LIKE pjcc_t.pjcc202e,
       pjcc202f LIKE pjcc_t.pjcc202f,
       pjcc202g LIKE pjcc_t.pjcc202g,
       pjcc202h LIKE pjcc_t.pjcc202h,
       pjcc902 LIKE pjcc_t.pjcc902, #期末结存金额
       pjcc902a LIKE pjcc_t.pjcc902a,
       pjcc902b LIKE pjcc_t.pjcc902b,
       pjcc902c LIKE pjcc_t.pjcc902c,
       pjcc902d LIKE pjcc_t.pjcc902d,
       pjcc902e LIKE pjcc_t.pjcc902e,
       pjcc902f LIKE pjcc_t.pjcc902f,
       pjcc902g LIKE pjcc_t.pjcc902g,
       pjcc902h LIKE pjcc_t.pjcc902h,
       pjcctime LIKE pjcc_t.pjcctime,
       pjcc101 LIKE pjcc_t.pjcc101, #上期预收款
       pjcc201 LIKE pjcc_t.pjcc201, #本期预收款
       pjcc901 LIKE pjcc_t.pjcc901, #累计预收款
       pjcc112 LIKE pjcc_t.pjcc112, #上期现场投入合计
       pjcc112a LIKE pjcc_t.pjcc112a, #上期现场投入-材料
       pjcc112b LIKE pjcc_t.pjcc112b, #上期现场投入-包作
       pjcc112c LIKE pjcc_t.pjcc112c, #上期现场投入-人工
       pjcc112d LIKE pjcc_t.pjcc112d, #上期现场投入-费用
       pjcc112e LIKE pjcc_t.pjcc112e, #上期现场投入-其他
       pjcc212 LIKE pjcc_t.pjcc212, #本期现场投入合计
       pjcc212a LIKE pjcc_t.pjcc212a, #本期现场投入-材料
       pjcc212b LIKE pjcc_t.pjcc212b, #本期现场投入-包作
       pjcc212c LIKE pjcc_t.pjcc212c, #本期现场投入-人工
       pjcc212d LIKE pjcc_t.pjcc212d, #本期现场投入-费用
       pjcc212e LIKE pjcc_t.pjcc212e, #本期现场投入-其它
       pjcc912 LIKE pjcc_t.pjcc912, #期末现场投入合计
       pjcc912a LIKE pjcc_t.pjcc912a, #期末现场投入-材料
       pjcc912b LIKE pjcc_t.pjcc912b, #期末现场投入-包作
       pjcc912c LIKE pjcc_t.pjcc912c, #期末现场投入-人工
       pjcc912d LIKE pjcc_t.pjcc912d, #期末现场投入-费用
       pjcc912e LIKE pjcc_t.pjcc912e, #期末现场投入-其它
       pjcc103 LIKE pjcc_t.pjcc103, #上期项目成本合计
       pjcc103a LIKE pjcc_t.pjcc103a, #上期项目成本-材料
       pjcc103b LIKE pjcc_t.pjcc103b, #上期项目成本-包作
       pjcc103c LIKE pjcc_t.pjcc103c, #上期项目成本-人工
       pjcc103d LIKE pjcc_t.pjcc103d, #上期项目成本-费用
       pjcc103e LIKE pjcc_t.pjcc103e, #上期项目成本-其它
       pjcc103f LIKE pjcc_t.pjcc103f, #上期项目成本-亏损
       pjcc104 LIKE pjcc_t.pjcc104, #上期项目收入
       pjcc204 LIKE pjcc_t.pjcc204, #本期项目收入
       pjcc904 LIKE pjcc_t.pjcc904, #累计项目收入
       pjcc105 LIKE pjcc_t.pjcc105, #上期在建利益
       pjcc205 LIKE pjcc_t.pjcc205, #本期在建利益
       pjcc905 LIKE pjcc_t.pjcc905, #累计在建利益
       pjcc106 LIKE pjcc_t.pjcc106, #上期在建损失
       pjcc206 LIKE pjcc_t.pjcc206, #本期在建损失
       pjcc906 LIKE pjcc_t.pjcc906, #累计在建损失
       pjcc203 LIKE pjcc_t.pjcc203, #本期项目成本合计
       pjcc203a LIKE pjcc_t.pjcc203a, #本期项目成本-材料
       pjcc203b LIKE pjcc_t.pjcc203b, #本期项目成本-包作
       pjcc203c LIKE pjcc_t.pjcc203c, #本期项目成本-人工
       pjcc203d LIKE pjcc_t.pjcc203d, #本期项目成本-费用
       pjcc203e LIKE pjcc_t.pjcc203e, #本期项目成本-其他
       pjcc203f LIKE pjcc_t.pjcc203f, #本期项目成本-亏损
       pjcc903 LIKE pjcc_t.pjcc903, #期末项目成本合计
       pjcc903a LIKE pjcc_t.pjcc903a, #期末项目成本-材料
       pjcc903b LIKE pjcc_t.pjcc903b, #期末项目成本-包作
       pjcc903c LIKE pjcc_t.pjcc903c, #期末项目成本-人工
       pjcc903d LIKE pjcc_t.pjcc903d, #期末项目成本-费用
       pjcc903e LIKE pjcc_t.pjcc903e, #期末项目成本-其他
       pjcc903f LIKE pjcc_t.pjcc903f #期末项目成本-亏损
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
#DEFINE g_pjcd           RECORD LIKE pjcd_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE g_pjcd RECORD  #專案在製成本期異動統計檔
       pjcdent LIKE pjcd_t.pjcdent, #企业编号
       pjcdcomp LIKE pjcd_t.pjcdcomp, #法人组织
       pjcdld LIKE pjcd_t.pjcdld, #账套
       pjcd001 LIKE pjcd_t.pjcd001, #账套本位币顺序
       pjcd002 LIKE pjcd_t.pjcd002, #成本域(项目编号)
       pjcd003 LIKE pjcd_t.pjcd003, #成本计算类型
       pjcd004 LIKE pjcd_t.pjcd004, #年度
       pjcd005 LIKE pjcd_t.pjcd005, #期别
       pjcd011 LIKE pjcd_t.pjcd011, #核算币种
       pjcd102 LIKE pjcd_t.pjcd102, #上期结存金额
       pjcd102a LIKE pjcd_t.pjcd102a,
       pjcd102b LIKE pjcd_t.pjcd102b,
       pjcd102c LIKE pjcd_t.pjcd102c,
       pjcd102d LIKE pjcd_t.pjcd102d,
       pjcd102e LIKE pjcd_t.pjcd102e,
       pjcd102f LIKE pjcd_t.pjcd102f,
       pjcd102g LIKE pjcd_t.pjcd102g,
       pjcd102h LIKE pjcd_t.pjcd102h,
       pjcd202 LIKE pjcd_t.pjcd202, #本期投入金额
       pjcd202a LIKE pjcd_t.pjcd202a,
       pjcd202b LIKE pjcd_t.pjcd202b,
       pjcd202c LIKE pjcd_t.pjcd202c,
       pjcd202d LIKE pjcd_t.pjcd202d,
       pjcd202e LIKE pjcd_t.pjcd202e,
       pjcd202f LIKE pjcd_t.pjcd202f,
       pjcd202g LIKE pjcd_t.pjcd202g,
       pjcd202h LIKE pjcd_t.pjcd202h,
       pjcd902 LIKE pjcd_t.pjcd902, #期末结存金额
       pjcd902a LIKE pjcd_t.pjcd902a,
       pjcd902b LIKE pjcd_t.pjcd902b,
       pjcd902c LIKE pjcd_t.pjcd902c,
       pjcd902d LIKE pjcd_t.pjcd902d,
       pjcd902e LIKE pjcd_t.pjcd902e,
       pjcd902f LIKE pjcd_t.pjcd902f,
       pjcd902g LIKE pjcd_t.pjcd902g,
       pjcd902h LIKE pjcd_t.pjcd902h,
       pjcdtime LIKE pjcd_t.pjcdtime
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjp500.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apjp500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjp500 WITH FORM cl_ap_formpath("apj",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apjp500_init()
 
      #進入選單 Menu (="N")
      CALL apjp500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apjp500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apjp500.init" >}
#+ 初始化作業
PRIVATE FUNCTION apjp500_init()
 
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
 
{<section id="apjp500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apjp500_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_yy      LIKE type_t.num5 
   DEFINE l_pp      LIKE type_t.num5 
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.yy,g_master.pp 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #预设当前site的法人，主账套，年度期别，成本计算类型
               CALL s_axc_set_site_default() RETURNING g_comp,g_ld,g_master.yy,g_master.pp ,g_type
               
               #取得与日期及年期相关的资讯
               CALL apjp500_get_date() RETURNING l_success
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD yy
            #add-point:BEFORE FIELD yy name="input.b.yy"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD yy
            
            #add-point:AFTER FIELD yy name="input.a.yy"
            IF g_master.yy <1000 OR g_master.yy >9999 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00113'
               LET g_errparam.extend = g_master.yy
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.yy = ''
               NEXT FIELD yy
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE yy
            #add-point:ON CHANGE yy name="input.g.yy"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pp
            #add-point:BEFORE FIELD pp name="input.b.pp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pp
            
            #add-point:AFTER FIELD pp name="input.a.pp"
            IF NOT cl_null(g_master.pp) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pp
            #add-point:ON CHANGE pp name="input.g.pp"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.yy
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD yy
            #add-point:ON ACTION controlp INFIELD yy name="input.c.yy"
            
            #END add-point
 
 
         #Ctrlp:input.c.pp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pp
            #add-point:ON ACTION controlp INFIELD pp name="input.c.pp"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF cl_null(g_master.yy) THEN
                  NEXT FIELD yy
               END IF
               
               IF cl_null(g_master.pp) THEN
                  NEXT FIELD pp
               END IF
               
               IF NOT cl_null(g_master.yy) AND NOT cl_null(g_master.pp) THEN
                  IF NOT s_fin_date_chk_period(g_glaa003,g_master.yy,g_master.pp) THEN
                     LET g_master.pp = ''
                     DISPLAY BY NAME g_master.pp
                     NEXT FIELD yy
                  END IF
               END IF
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pjba001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pjba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba001
            #add-point:ON ACTION controlp INFIELD pjba001 name="construct.c.pjba001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " pjba011 <> 'Y' "
            #预设当前site的法人，主账套，年度期别，成本计算类型
            CALL s_axc_set_site_default() RETURNING g_comp,g_ld,g_master.yy,g_master.pp,g_type
            
            #取得与日期及年期相关的资讯
            CALL apjp500_get_date() RETURNING l_success
            
            #LET g_qryparam.where = " (pjba013 IS NULL OR pjba013 >= '",g_bdate,"')" #结案日期为空，或者结案日期大于当前的起始日期 都符合條件
            LET g_qryparam.where = " (pjba013 IS NULL OR pjba013 >= to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')) "
            #CALL q_pjba001()                           #呼叫開窗
            #LET g_qryparam.arg1 = g_bdate
            CALL q_pjba001_4()
            DISPLAY g_qryparam.return1 TO pjba001  #顯示到畫面上
            NEXT FIELD pjba001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba001
            #add-point:BEFORE FIELD pjba001 name="construct.b.pjba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba001
            
            #add-point:AFTER FIELD pjba001 name="construct.a.pjba001"
            
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
            CALL apjp500_get_buffer(l_dialog)
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
         CALL apjp500_init()
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
                 CALL apjp500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apjp500_transfer_argv(ls_js)
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
 
{<section id="apjp500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apjp500_transfer_argv(ls_js)
 
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
 
{<section id="apjp500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apjp500_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_yy        LIKE type_t.num5 
   DEFINE l_pp        LIKE type_t.num5  
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
      #抓去所需處理資料的總筆數
      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_comp,g_ld,l_yy,l_pp,g_type
      
      #取得与日期及年期相关的资讯
      CALL apjp500_get_date() RETURNING l_success
            
      LET g_sql = " SELECT COUNT(*) ",
                  "  FROM pjaa_t,pjba_t ",
                  "  WHERE pjaaent = pjbaent AND pjaa001 = pjba000 ",
                  "    AND pjbaent = '",g_enterprise,"'",
                  "    AND pjbastus = 'Y' ",
                 #"    AND pjba011 <> 'Y' ",
                  "    AND (pjba013 IS NULL OR pjba013 >= '",g_bdate,"')", #结案日期为空，或者结案日期大于当前的起始日期 都符合條件
                  "    AND " , lc_param.wc 
      PREPARE p500_count_pre FROM g_sql
      EXECUTE p500_count_pre INTO li_count
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apjp500_process_cs CURSOR FROM ls_sql
#  FOREACH apjp500_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL apjp500_cal()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apjp500_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apjp500.get_buffer" >}
PRIVATE FUNCTION apjp500_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.yy = p_dialog.getFieldBuffer('yy')
   LET g_master.pp = p_dialog.getFieldBuffer('pp')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjp500.msgcentre_notify" >}
PRIVATE FUNCTION apjp500_msgcentre_notify()
 
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
 
{<section id="apjp500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apjp500_cal()
DEFINE l_yy        LIKE type_t.num5 
DEFINE l_pp        LIKE type_t.num5 
DEFINE l_pjaa013   LIKE pjaa_t.pjaa013
DEFINE l_pjba001   LIKE pjaa_t.pjaa001
DEFINE l_success   LIKE type_t.num5 
DEFINE ls_value    STRING

      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_comp,g_ld,l_yy,l_pp,g_type
      
      #取得与日期及年期相关的资讯
      IF NOT apjp500_get_date() THEN
         RETURN
      END IF
      
      LET g_sql = " SELECT pjba001,pjaa013 FROM pjaa_t,pjba_t ",
                  "  WHERE pjaaent = pjbaent AND pjaa001 = pjba000 ",
                  "    AND pjbaent = '",g_enterprise,"' ",
                  "    AND pjbastus = 'Y' ",
                 #"    AND pjba011 <> 'Y' "
                 #"    AND (pjba013 IS NULL OR pjba013 >= '",g_bdate,"')", #结案日期为空，或者结案日期大于当前的起始日期 都符合條件
                  "    AND (pjba013 IS NULL OR pjba013 >= to_date('",g_bdate,"','yyyy-mm-dd hh24:mi:ss')) ",
                  "    AND " , g_master.wc
      PREPARE apjp500_pjaa_pb FROM g_sql
      DECLARE apjp500_pjaa_cs CURSOR FOR apjp500_pjaa_pb
      
      #错误收集
      CALL cl_err_collect_init() 
   
      FOREACH apjp500_pjaa_cs INTO l_pjba001,l_pjaa013
         
         ##畫面顯示處理進度 
         IF g_bgjob <> "Y" THEN
            LET ls_value = l_pjba001
            CALL cl_progress_no_window_ing(l_pjba001)
         END IF
         
         #INSERT INTO 專案總成本期異動統計檔(pjcc_t)
         IF apjp500_ins_pjcc(l_pjba001,l_pjaa013) THEN
         
            #INSERT INTO 專案在製成本期異動統計檔(pjcd_t)
            IF apjp500_ins_pjcd(l_pjba001,l_pjaa013) THEN
            
               #UPDATE 專案總成本期異動統計檔(pjcc_t)
               CALL apjp500_upd_pjcc(l_pjba001) RETURNING l_success
               
            END IF
         END IF
         
      END FOREACH
      
      #错误整体显示
      CALL cl_err_collect_show()
      
END FUNCTION

PRIVATE FUNCTION apjp500_ins_pjcc(p_pjba001,p_pjaa013)
DEFINE p_pjba001    LIKE pjba_t.pjba001
DEFINE p_pjaa013    LIKE pjaa_t.pjaa013
DEFINE r_success    LIKE type_t.num5
DEFINE l_pjcc001    LIKE pjcc_t.pjcc001
DEFINE l_pjcctime   DATETIME YEAR TO SECOND
DEFINE l_xccc001    LIKE xccc_t.xccc001
DEFINE l_xcck001    LIKE xcck_t.xcck001
DEFINE l_pjcc202    LIKE pjcc_t.pjcc202
DEFINE l_pjcc202a   LIKE pjcc_t.pjcc202a
DEFINE l_pjcc202b   LIKE pjcc_t.pjcc202b
DEFINE l_pjcc202c   LIKE pjcc_t.pjcc202c
DEFINE l_pjcc202d   LIKE pjcc_t.pjcc202d
DEFINE l_pjcc202e   LIKE pjcc_t.pjcc202e
DEFINE l_pjcc202f   LIKE pjcc_t.pjcc202f
DEFINE l_pjcc202g   LIKE pjcc_t.pjcc202g
DEFINE l_pjcc202h   LIKE pjcc_t.pjcc202h
DEFINE l_xcck202    LIKE xcck_t.xcck202
DEFINE l_xcck202a   LIKE xcck_t.xcck202a
DEFINE l_xcck202b   LIKE xcck_t.xcck202b
DEFINE l_xcck202c   LIKE xcck_t.xcck202c
DEFINE l_xcck202d   LIKE xcck_t.xcck202d
DEFINE l_xcck202e   LIKE xcck_t.xcck202e
DEFINE l_xcck202f   LIKE xcck_t.xcck202f
DEFINE l_xcck202g   LIKE xcck_t.xcck202g
DEFINE l_xcck202h   LIKE xcck_t.xcck202h

    WHENEVER ERROR CONTINUE
    LET r_success = TRUE
    
    INITIALIZE g_pjcc.* TO NULL
    
    LET g_pjcc.pjccent = g_enterprise
    LET g_pjcc.pjcccomp = g_comp
    LET g_pjcc.pjccld = g_ld
    LET g_pjcc.pjcc001 = '1'
    LET g_pjcc.pjcc002 = p_pjba001
    LET g_pjcc.pjcc003 = g_type
    LET g_pjcc.pjcc004 = g_master.yy
    LET g_pjcc.pjcc005 = g_master.pp
    
    DELETE FROM pjcc_t 
      WHERE pjccent = g_enterprise AND pjccld = g_ld AND pjcc002 = p_pjba001 AND pjcc003 = g_type 
        AND pjcc004 = g_master.yy AND pjcc005  = g_master.pp AND pjcc001 = g_pjcc.pjcc001
    
    #上期資料(pjcc102~pjcc102h)抓取上期專案庫存成本期異動統計檔(pjcc_t)期未結存資料(pjcc902~pjcc902h)寫入，抓不到預設為0
    
    #抓取 帳套本位幣順序最優先 的資料
    SELECT MIN(pjcc001) INTO l_pjcc001 FROM pjcc_t
       WHERE pjccent = g_enterprise AND pjccld = g_ld AND pjcc002 = p_pjba001 AND pjcc003 = g_type 
         AND pjcc004 = g_last_yy AND pjcc005  = g_last_pp
    
    SELECT pjcc902,pjcc902a,pjcc902b,pjcc902c,pjcc902d,pjcc902e,pjcc902f,pjcc902g,pjcc902h
       INTO g_pjcc.pjcc102 ,g_pjcc.pjcc102a,g_pjcc.pjcc102b,g_pjcc.pjcc102c,g_pjcc.pjcc102d,
            g_pjcc.pjcc102e,g_pjcc.pjcc102f,g_pjcc.pjcc102g,g_pjcc.pjcc102h
     FROM pjcc_t 
     WHERE pjccent = g_enterprise AND pjccld = g_ld AND pjcc002 = p_pjba001 AND pjcc003 = g_type 
       AND pjcc004 = g_last_yy AND pjcc005  = g_last_pp AND pjcc001 = l_pjcc001
     
    IF cl_null(g_pjcc.pjcc102)  THEN LET g_pjcc.pjcc102 = 0 END IF 
    IF cl_null(g_pjcc.pjcc102a) THEN LET g_pjcc.pjcc102a = 0 END IF
    IF cl_null(g_pjcc.pjcc102b) THEN LET g_pjcc.pjcc102b = 0 END IF
    IF cl_null(g_pjcc.pjcc102c) THEN LET g_pjcc.pjcc102c = 0 END IF
    IF cl_null(g_pjcc.pjcc102d) THEN LET g_pjcc.pjcc102d = 0 END IF
    IF cl_null(g_pjcc.pjcc102e) THEN LET g_pjcc.pjcc102e = 0 END IF
    IF cl_null(g_pjcc.pjcc102f) THEN LET g_pjcc.pjcc102f = 0 END IF
    IF cl_null(g_pjcc.pjcc102g) THEN LET g_pjcc.pjcc102g = 0 END IF
    IF cl_null(g_pjcc.pjcc102h) THEN LET g_pjcc.pjcc102h = 0 END IF     
    
    #專案庫存控管="Y"
    IF p_pjaa013 = 'Y' THEN
       #抓取xccc_t中成本域(xccc002)=專案代號 and 年度=計算年度 and 期別=計算期別 and 帳套本位幣順序最優先 的資料
       SELECT MIN(xccc001) INTO l_xccc001 FROM xccc_t
          WHERE xcccent = g_enterprise AND xccc002 = p_pjba001 AND xccc004 = g_master.yy AND xccc005 = g_master.pp
       SELECT xccc010 INTO g_pjcc.pjcc010 FROM xccc_t
          WHERE xcccent = g_enterprise AND xccc002 = p_pjba001 AND xccc004 = g_master.yy AND xccc005 = g_master.pp
            AND xccc001 = l_xccc001 AND ROWNUM = 1
       
       #其餘金額依法人組織、帳套、成本域、成本計算類型為群組
       #本期入庫金額(pjcc202) = SUM(本期採購入庫成本(xccc202) - 本期生產領用(xccc302))(備註：生產領用是出的，出項(ex：xcc302)資料已經是用負值存入，此處應該改用加法。)
       #本期入庫金額-材料(pjcc202a) = SUM(本期入庫金額-材料(xccc202a) - 本期領用金額-材料(xccc302a))
       #本期入庫金額-人工(pjcc202b) = SUM(本期入庫金額-人工(xccc202b) - 本期領用金額-人工(xccc302b))
       #本期入庫金額-加工(pjcc202c) = SUM(本期入庫金額-加工(xccc202c) - 本期領用金額-加工(xccc302c))
       #本期入庫金額-製費一(pjcc202d) = SUM(本期採購入庫製費一成本(xccc202d) - 本期領用製費一(xccc302d))
       #本期入庫金額-製費二(pjcc202e) = SUM(本期採購入庫製費二成本(xccc202e) - 本期領用製費二(xccc302e))
       #本期入庫金額-製費三(pjcc202f) = SUM(本期採購入庫製費三成本(xccc202f) - 本期領用製費三(xccc302f))
       #本期入庫金額-製費四(pjcc202g) = SUM(本期採購入庫製費四成本(xccc202g) - 本期領用製費四(xccc302g))
       #本期入庫金額-製費五(pjcc202h) = SUM(本期採購入庫製費五成本(xccc202h) - 本期領用製費五(xccc302h))
       SELECT SUM((CASE WHEN xccc202 IS NULL THEN 0 ELSE xccc202 END) + (CASE WHEN xccc302 IS NULL THEN 0 ELSE xccc302 END)),
              SUM((CASE WHEN xccc202a IS NULL THEN 0 ELSE xccc202a END) + (CASE WHEN xccc302a IS NULL THEN 0 ELSE xccc302a END)),
              SUM((CASE WHEN xccc202b IS NULL THEN 0 ELSE xccc202b END) + (CASE WHEN xccc302b IS NULL THEN 0 ELSE xccc302b END)),
              SUM((CASE WHEN xccc202c IS NULL THEN 0 ELSE xccc202c END) + (CASE WHEN xccc302c IS NULL THEN 0 ELSE xccc302c END)),
              SUM((CASE WHEN xccc202d IS NULL THEN 0 ELSE xccc202d END) + (CASE WHEN xccc302d IS NULL THEN 0 ELSE xccc302d END)),
              SUM((CASE WHEN xccc202e IS NULL THEN 0 ELSE xccc202e END) + (CASE WHEN xccc302e IS NULL THEN 0 ELSE xccc302e END)),
              SUM((CASE WHEN xccc202f IS NULL THEN 0 ELSE xccc202f END) + (CASE WHEN xccc302f IS NULL THEN 0 ELSE xccc302f END)),
              SUM((CASE WHEN xccc202g IS NULL THEN 0 ELSE xccc202g END) + (CASE WHEN xccc302g IS NULL THEN 0 ELSE xccc302g END)),
              SUM((CASE WHEN xccc202h IS NULL THEN 0 ELSE xccc202h END) + (CASE WHEN xccc302h IS NULL THEN 0 ELSE xccc302h END))
          INTO g_pjcc.pjcc202 ,g_pjcc.pjcc202a,g_pjcc.pjcc202b,g_pjcc.pjcc202c,g_pjcc.pjcc202d,
               g_pjcc.pjcc202e,g_pjcc.pjcc202f,g_pjcc.pjcc202g,g_pjcc.pjcc202h
         FROM xccc_t 
         WHERE xcccent = g_enterprise AND xccccomp = g_comp AND xcccld = g_ld AND xccc002 = p_pjba001 
           AND xccc003 = g_type AND xccc004 = g_master.yy AND xccc005 = g_master.pp AND xccc001 = l_xccc001
           
    #專案庫存控管="N"
    ELSE
       #抓取xcck_t的資料 WHERE 年度=計算年度 and 期別=計算期別 and 帳套本位幣順序最優先 and 單號(xcck006)=inaj001
       #    and 項次(xcck007)= inaj002 and 項序(xcck008)=inaj003 and 出入庫碼(xcck009)=inaj004
       #    and (xccc類型(xcck055) = '201' or '301') and 專案代號(inaj038)=專案代號 
       #    and 成本計算類型=成本計算類型
       SELECT MIN(xcck001) INTO l_xcck001 FROM xcck_t,inaj_t
         WHERE xcckent = inajent AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003 
           AND xcck009 = inaj004 AND xcck002 = inaj038 AND inaj022 BETWEEN g_bdate AND g_edate 
           AND xcckent = g_enterprise AND xcck002 = p_pjba001 AND xcck004 = g_master.yy AND xcck005 = g_master.pp
           AND xcck003 = g_type AND (xcck055 = '201' OR xcck055 = '301' )
       SELECT xcck041 INTO g_pjcc.pjcc010 FROM xcck_t,inaj_t
         WHERE xcckent = inajent AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003 
           AND xcck009 = inaj004 AND xcck002 = inaj038 AND inaj022 BETWEEN g_bdate AND g_edate
           AND xcckent = g_enterprise AND xcck002 = p_pjba001 AND xcck004 = g_master.yy AND xcck005 = g_master.pp
           AND (xcck055 = '201' OR xcck055 = '301' )
           AND xcck003 = g_type AND xcck001 = l_xcck001 AND ROWNUM = 1
       
       #其餘金額依法人組織、帳套、專案編號為群組
       #本期入庫金額(pjcc202) = SUM(本期異動金額(xcck202) where xcck055='201') - SUM(本期生產領用(xcck202) where xcck055='301')  #(備註：生產領用是出的，出項(ex：xcck202)資料已經是用負值存入，此處應該改用加法。)
       #本期入庫金額-材料(pjcc202a) = SUM(本期異動金額-材料(xcck202a) where xcck055='201') - SUM((本期領用-材料(xcck202a) where xcck055='301')
       #本期入庫金額-人工(pjcc202b) = SUM(本期異動金額-人工(xcck202b) where xcck055='201') - SUM(本期領用-人工(xcck202b) where xcck055='301')
       #本期入庫金額-加工(pjcc202c) = SUM(本期異動金額-加工(xcck202c) where xcck055='201') - SUM(本期領用-加工(xcck202c) where xcck055='301')
       #本期入庫金額-製費一(pjcc202d) = SUM(本期異動金額-製費一(xcck202d) where xcck055='201') - SUM(本期領用製費一(xcck202d) where xcck055='301')
       #本期入庫金額-製費二(pjcc202e) = SUM(本期異動金額-製費二(xcck202e) where xcck055='201') - SUM(本期領用製費二(xcck202e) where xcck055='301')
       #本期入庫金額-製費三(pjcc202f) = SUM(本期異動金額-製費三(xcck202f) where xcck055='201') - SUM(本期領用製費三(xcck202f) where xcck055='301')
       #本期入庫金額-製費四(pjcc202g) = SUM(本期異動金額-製費四(xcck202g) where xcck055='201') - SUM(本期領用製費四(xcck202g) where xcck055='301')
       #本期入庫金額-製費五(pjcc202h) = SUM(本期異動金額-製費五(xcck202h) where xcck055='201') - SUM(本期領用製費五(xcck202h) where xcck055='301')
       SELECT SUM(CASE WHEN xcck202 IS NULL THEN 0 ELSE xcck202 END) ,
              SUM(CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END),
              SUM(CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END),
              SUM(CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END),
              SUM(CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END),
              SUM(CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END),
              SUM(CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END),
              SUM(CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END),
              SUM(CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)
          INTO l_pjcc202 ,l_pjcc202a,l_pjcc202b,l_pjcc202c,l_pjcc202d,
               l_pjcc202e,l_pjcc202f,l_pjcc202g,l_pjcc202h
          FROM xcck_t,inaj_t
         WHERE xcckent = inajent AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003 
           AND xcck009 = inaj004 AND xcck002 = inaj038 AND inaj022 BETWEEN g_bdate AND g_edate 
           AND xcckent = g_enterprise AND xcckcomp = g_comp AND xcckld = g_ld
           AND xcck002 = p_pjba001 AND xcck003 = g_type AND xcck004 = g_master.yy AND xcck005 = g_master.pp
           AND xcck055 = '201' AND xcck001 = l_xcck001
       
       SELECT SUM(CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202 END),
              SUM(CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END),
              SUM(CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END),
              SUM(CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END),
              SUM(CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END),
              SUM(CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END),
              SUM(CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END),
              SUM(CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END),
              SUM(CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END),
          INTO l_xcck202 ,l_xcck202a,l_xcck202b,l_xcck202c,l_xcck202d,
               l_xcck202e,l_xcck202f,l_xcck202g,l_xcck202h
          FROM xcck_t,inaj_t
         WHERE xcckent = inajent AND xcck006 = inaj001 AND xcck007 = inaj002 AND xcck008 = inaj003 
           AND xcck009 = inaj004 AND xcck002 = inaj038 AND inaj022 BETWEEN g_bdate AND g_edate 
           AND xcckent = g_enterprise AND xcckcomp = g_comp AND xcckld = g_ld
           AND xcck002 = p_pjba001 AND xcck003 = g_type AND xcck004 = g_master.yy AND xcck005 = g_master.pp
           AND xcck055 = '301' AND xcck001 = l_xcck001  
           
       IF cl_null(l_pjcc202)   THEN LET l_pjcc202  = 0 END IF 
       IF cl_null(l_pjcc202a)  THEN LET l_pjcc202a = 0 END IF
       IF cl_null(l_pjcc202b)  THEN LET l_pjcc202b = 0 END IF
       IF cl_null(l_pjcc202c)  THEN LET l_pjcc202c = 0 END IF
       IF cl_null(l_pjcc202d)  THEN LET l_pjcc202d = 0 END IF
       IF cl_null(l_pjcc202e)  THEN LET l_pjcc202e = 0 END IF
       IF cl_null(l_pjcc202f)  THEN LET l_pjcc202f = 0 END IF
       IF cl_null(l_pjcc202g)  THEN LET l_pjcc202g = 0 END IF
       IF cl_null(l_pjcc202h)  THEN LET l_pjcc202h = 0 END IF
       
       IF cl_null(l_xcck202)   THEN LET l_xcck202  = 0 END IF   
       IF cl_null(l_xcck202a)  THEN LET l_xcck202a = 0 END IF   
       IF cl_null(l_xcck202b)  THEN LET l_xcck202b = 0 END IF   
       IF cl_null(l_xcck202c)  THEN LET l_xcck202c = 0 END IF   
       IF cl_null(l_xcck202d)  THEN LET l_xcck202d = 0 END IF   
       IF cl_null(l_xcck202e)  THEN LET l_xcck202e = 0 END IF   
       IF cl_null(l_xcck202f)  THEN LET l_xcck202f = 0 END IF   
       IF cl_null(l_xcck202g)  THEN LET l_xcck202g = 0 END IF   
       IF cl_null(l_xcck202h)  THEN LET l_xcck202h = 0 END IF   
       
       LET g_pjcc.pjcc202  = l_pjcc202  + l_xcck202  #(備註：生產領用是出的，出項(ex：xcck202)資料已經是用負值存入，此處應該改用加法。)
       LET g_pjcc.pjcc202a = l_pjcc202a + l_xcck202a 
       LET g_pjcc.pjcc202b = l_pjcc202b + l_xcck202b
       LET g_pjcc.pjcc202c = l_pjcc202c + l_xcck202c
       LET g_pjcc.pjcc202d = l_pjcc202d + l_xcck202d 
       LET g_pjcc.pjcc202e = l_pjcc202e + l_xcck202e 
       LET g_pjcc.pjcc202f = l_pjcc202f + l_xcck202f 
       LET g_pjcc.pjcc202g = l_pjcc202g + l_xcck202g 
       LET g_pjcc.pjcc202h = l_pjcc202h + l_xcck202h 
       
    END IF
    
    IF cl_null(g_pjcc.pjcc202)  THEN LET g_pjcc.pjcc202 = 0 END IF 
    IF cl_null(g_pjcc.pjcc202a) THEN LET g_pjcc.pjcc202a = 0 END IF
    IF cl_null(g_pjcc.pjcc202b) THEN LET g_pjcc.pjcc202b = 0 END IF
    IF cl_null(g_pjcc.pjcc202c) THEN LET g_pjcc.pjcc202c = 0 END IF
    IF cl_null(g_pjcc.pjcc202d) THEN LET g_pjcc.pjcc202d = 0 END IF
    IF cl_null(g_pjcc.pjcc202e) THEN LET g_pjcc.pjcc202e = 0 END IF
    IF cl_null(g_pjcc.pjcc202f) THEN LET g_pjcc.pjcc202f = 0 END IF
    IF cl_null(g_pjcc.pjcc202g) THEN LET g_pjcc.pjcc202g = 0 END IF
    IF cl_null(g_pjcc.pjcc202h) THEN LET g_pjcc.pjcc202h = 0 END IF  
    
    #INSERT INTO 專案總成本期異動統計檔(pjcc_t)
    LET l_pjcctime = cl_get_current()
    
    INSERT INTO pjcc_t (pjccent,pjcccomp,pjccld  ,pjcc001 ,pjcc002 ,pjcc003 ,pjcc004 ,pjcc005 ,
                        pjcc010,
                        pjcc102,pjcc102a,pjcc102b,pjcc102c,pjcc102d,pjcc102e,pjcc102f,pjcc102g,pjcc102h,
                        pjcc202,pjcc202a,pjcc202b,pjcc202c,pjcc202d,pjcc202e,pjcc202f,pjcc202g,pjcc202h,
                        pjcctime)
       VALUES (g_pjcc.pjccent,g_pjcc.pjcccomp,g_pjcc.pjccld  ,g_pjcc.pjcc001 ,g_pjcc.pjcc002 ,g_pjcc.pjcc003 ,g_pjcc.pjcc004 ,g_pjcc.pjcc005 ,
               g_pjcc.pjcc010,
               g_pjcc.pjcc102,g_pjcc.pjcc102a,g_pjcc.pjcc102b,g_pjcc.pjcc102c,g_pjcc.pjcc102d,g_pjcc.pjcc102e,g_pjcc.pjcc102f,g_pjcc.pjcc102g,g_pjcc.pjcc102h,
               g_pjcc.pjcc202,g_pjcc.pjcc202a,g_pjcc.pjcc202b,g_pjcc.pjcc202c,g_pjcc.pjcc202d,g_pjcc.pjcc202e,g_pjcc.pjcc202f,g_pjcc.pjcc202g,g_pjcc.pjcc202h,
               l_pjcctime)
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = p_pjba001 , " pjcc_t" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
    END IF
    
    RETURN r_success
    
END FUNCTION

PRIVATE FUNCTION apjp500_ins_pjcd(p_pjba001,p_pjaa013)
DEFINE p_pjba001    LIKE pjba_t.pjba001
DEFINE p_pjaa013    LIKE pjaa_t.pjaa013
DEFINE r_success    LIKE type_t.num5
DEFINE l_pjcd001    LIKE pjcd_t.pjcd001
DEFINE l_pjcdtime   DATETIME YEAR TO SECOND
DEFINE l_xccd001    LIKE xccd_t.xccd001

    WHENEVER ERROR CONTINUE
    LET r_success = TRUE
    
    INITIALIZE g_pjcd.* TO NULL
    
    LET g_pjcd.pjcdent = g_enterprise
    LET g_pjcd.pjcdcomp = g_comp
    LET g_pjcd.pjcdld = g_ld
    LET g_pjcd.pjcd001 = '1'
    LET g_pjcd.pjcd002 = p_pjba001
    LET g_pjcd.pjcd003 = g_type
    LET g_pjcd.pjcd004 = g_master.yy
    LET g_pjcd.pjcd005 = g_master.pp
    
    DELETE FROM pjcd_t 
      WHERE pjcdent = g_enterprise AND pjcdld = g_ld AND pjcd002 = p_pjba001 AND pjcd003 = g_type 
        AND pjcd004 = g_master.yy AND pjcd005  = g_master.pp AND pjcd001 = g_pjcd.pjcd001
        
    #上期資料(pjcd102~pjcd102h)抓取上期專案在製成本期異動統計檔(pjcd_t)期未結存資料(pjcd902~pjcd902h)寫入，抓不到預設為0
    #抓取 帳套本位幣順序最優先 的資料
    SELECT MIN(pjcd001) INTO l_pjcd001 FROM pjcd_t
       WHERE pjcdent = g_enterprise AND pjcdld = g_ld AND pjcd002 = p_pjba001 AND pjcd003 = g_type 
         AND pjcd004 = g_last_yy AND pjcd005  = g_last_pp
    
    SELECT pjcd902,pjcd902a,pjcd902b,pjcd902c,pjcd902d,pjcd902e,pjcd902f,pjcd902g,pjcd902h
       INTO g_pjcd.pjcd102 ,g_pjcd.pjcd102a,g_pjcd.pjcd102b,g_pjcd.pjcd102c,g_pjcd.pjcd102d,
            g_pjcd.pjcd102e,g_pjcd.pjcd102f,g_pjcd.pjcd102g,g_pjcd.pjcd102h
     FROM pjcd_t 
     WHERE pjcdent = g_enterprise AND pjcdld = g_ld AND pjcd002 = p_pjba001 AND pjcd003 = g_type 
       AND pjcd004 = g_last_yy AND pjcd005  = g_last_pp AND pjcd001 = l_pjcd001
     
    IF cl_null(g_pjcd.pjcd102)  THEN LET g_pjcd.pjcd102 = 0 END IF 
    IF cl_null(g_pjcd.pjcd102a) THEN LET g_pjcd.pjcd102a = 0 END IF
    IF cl_null(g_pjcd.pjcd102b) THEN LET g_pjcd.pjcd102b = 0 END IF
    IF cl_null(g_pjcd.pjcd102c) THEN LET g_pjcd.pjcd102c = 0 END IF
    IF cl_null(g_pjcd.pjcd102d) THEN LET g_pjcd.pjcd102d = 0 END IF
    IF cl_null(g_pjcd.pjcd102e) THEN LET g_pjcd.pjcd102e = 0 END IF
    IF cl_null(g_pjcd.pjcd102f) THEN LET g_pjcd.pjcd102f = 0 END IF
    IF cl_null(g_pjcd.pjcd102g) THEN LET g_pjcd.pjcd102g = 0 END IF
    IF cl_null(g_pjcd.pjcd102h) THEN LET g_pjcd.pjcd102h = 0 END IF     
    
    #專案庫存控管="Y"
    IF p_pjaa013 = 'Y' THEN
       #抓取xccd_t中成本域(xccd002)=專案代號 and 年度=計算年度 and 期別=計算期別 and 帳套本位幣順序最優先 的資料
       LET g_sql = " SELECT MIN(xccd001) FROM xccd_t " ,
                   " WHERE xccdent = '",g_enterprise,"' AND xccd002 = '",p_pjba001,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' "
    #專案庫存控管="N"
    ELSE
       #抓取xccd_t的資料 WHERE 年度=計算年度 and 期別=計算期別 and 帳套本位幣順序最優先 and 工單單號(xccd006)=sfaadocno 
       #   and 專案代號(sfaa028)=專案代號 and 成本計算類型=成本計算類型 
       LET g_sql = " SELECT MIN(xccd001) FROM xccd_t,sfaa_t " ,
                   " WHERE xccdent = sfaaent AND xccd006 = sfaadocno AND xccd002 = sfaa028 AND xccd003 = '",g_type,"' ",
                   "   AND (sfaa048 IS NULL OR sfaa048 >= '",g_bdate,"')", #成会结案日期
                   "   AND xccdent = '",g_enterprise,"' AND xccd002 = '",p_pjba001,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' "
    END IF
    
    PREPARE p500_xccd001_pre FROM g_sql
    EXECUTE p500_xccd001_pre INTO l_xccd001
    
    #專案庫存控管="Y"
    IF p_pjaa013 = 'Y' THEN
       LET g_sql = " SELECT xccd011 FROM xccd_t " ,
                   " WHERE xccdent = '",g_enterprise,"' AND xccd002 = '",p_pjba001,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' ",
                   "   AND xccd001 = '",l_xccd001,"' AND ROWNUM = 1 "
    #專案庫存控管="N"
    ELSE
       LET g_sql = " SELECT xccd011 FROM xccd_t,sfaa_t " ,
                   " WHERE xccdent = sfaaent AND xccd006 = sfaadocno AND xccd002 = sfaa028 AND xccd003 = '",g_type,"' ",
                   "   AND (sfaa048 IS NULL OR sfaa048 >= '",g_bdate,"')", #成会结案日期
                   "   AND xccdent = '",g_enterprise,"' AND xccd002 = '",p_pjba001,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' ",
                   "   AND xccd001 = '",l_xccd001,"' AND ROWNUM = 1 "
    END IF
    PREPARE p500_xccd011_pre FROM g_sql
    EXECUTE p500_xccd011_pre INTO g_pjcd.pjcd011
    
    #其餘金額依法人組織、帳套、專案代號、成本計算類型為群組
    #本期投入金額(pjcd202) = SUM(本期投入原料成本(xccd202) + 本期投入半成品(xccd302))
    #本期投入材料金額(pjcd202a) = SUM(本期投入原料材料成本(xccd202a) + 本期投入半成品材料(xccd302a))
    #本期投入人工金額(pjcd202b) = SUM(本期投入原料人工成本(xccd202b) + 本期投入半成品人工(xccd302b))
    #本期投入加工金額(pjcd202c) = SUM(本期投入原料加工成本(xccd202c) + 本期投入半成品加工(xccd302c))
    #本期投入製費一金額(pjcd202d) = SUM(本期投入原料製費一成本(xccd202d) + 本期投入半成品製費一(xccd302d))
    #本期投入製費二金額(pjcd202e) = SUM(本期投入原料製費二成本(xccd202e) + 本期投入半成品製費二(xccd302e))
    #本期投入製費三金額(pjcd202f) = SUM(本期投入原料製費三成本(xccd202f) + 本期投入半成品製費三(xccd302f))
    #本期投入製費四金額(pjcd202g) = SUM(本期投入原料製費四成本(xccd202g) + 本期投入半成品製費四(xccd302g))
    #本期投入製費五金額(pjcd202h) = SUM(本期投入原料製費五成本(xccd202h) + 本期投入半成品製費五(xccd302h))
    
    LET g_sql = " SELECT SUM((CASE WHEN xccd202 IS NULL THEN 0 ELSE xccd202 END) + (CASE WHEN xccd302 IS NULL THEN 0 ELSE xccd302 END)),    ",
                "        SUM((CASE WHEN xccd202a IS NULL THEN 0 ELSE xccd202a END) + (CASE WHEN xccd302a IS NULL THEN 0 ELSE xccd302a END)),",
                "        SUM((CASE WHEN xccd202b IS NULL THEN 0 ELSE xccd202b END) + (CASE WHEN xccd302b IS NULL THEN 0 ELSE xccd302b END)),",
                "        SUM((CASE WHEN xccd202c IS NULL THEN 0 ELSE xccd202c END) + (CASE WHEN xccd302c IS NULL THEN 0 ELSE xccd302c END)),",
                "        SUM((CASE WHEN xccd202d IS NULL THEN 0 ELSE xccd202d END) + (CASE WHEN xccd302d IS NULL THEN 0 ELSE xccd302d END)),",
                "        SUM((CASE WHEN xccd202e IS NULL THEN 0 ELSE xccd202e END) + (CASE WHEN xccd302e IS NULL THEN 0 ELSE xccd302e END)),",
                "        SUM((CASE WHEN xccd202f IS NULL THEN 0 ELSE xccd202f END) + (CASE WHEN xccd302f IS NULL THEN 0 ELSE xccd302f END)),",
                "        SUM((CASE WHEN xccd202g IS NULL THEN 0 ELSE xccd202g END) + (CASE WHEN xccd302g IS NULL THEN 0 ELSE xccd302g END)),",
                "        SUM((CASE WHEN xccd202h IS NULL THEN 0 ELSE xccd202h END) + (CASE WHEN xccd302h IS NULL THEN 0 ELSE xccd302h END)) "
                
    #專案庫存控管="Y"
    IF p_pjaa013 = 'Y' THEN
       LET g_sql = g_sql ," FROM xccd_t ",
                          " WHERE xccdent = '",g_enterprise,"' AND xccdcomp = '",g_comp,"' AND xccdld = '",g_ld,"' AND xccd002 = '",p_pjba001,"' ",
                          "   AND xccd003 = '",g_type,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' ",
                          "   AND xccd001 = '",l_xccd001,"' "
    #專案庫存控管="N"
    ELSE
       LET g_sql = g_sql ," FROM xccd_t,sfaa_t ",
                          " WHERE xccdent = sfaaent AND xccd006 = sfaadocno AND xccd002 = sfaa028 ",
                          "   AND (sfaa048 IS NULL OR sfaa048 >= '",g_bdate,"')", #成会结案日期
                          "   AND xccdent = '",g_enterprise,"' AND xccdcomp = '",g_comp,"' AND xccdld = '",g_ld,"' AND xccd002 = '",p_pjba001,"' ",
                          "   AND xccd003 = '",g_type,"' AND xccd004 = '",g_master.yy,"' AND xccd005 = '",g_master.pp,"' ",
                          "   AND xccd001 = '",l_xccd001,"' "
    END IF
    
    
    PREPARE p500_xccd_pre FROM g_sql
    EXECUTE p500_xccd_pre INTO g_pjcd.pjcd202 ,g_pjcd.pjcd202a,g_pjcd.pjcd202b,g_pjcd.pjcd202c,g_pjcd.pjcd202d,
                               g_pjcd.pjcd202e,g_pjcd.pjcd202f,g_pjcd.pjcd202g,g_pjcd.pjcd202h
    
    IF cl_null(g_pjcd.pjcd202)  THEN LET g_pjcd.pjcd202 = 0 END IF 
    IF cl_null(g_pjcd.pjcd202a) THEN LET g_pjcd.pjcd202a = 0 END IF
    IF cl_null(g_pjcd.pjcd202b) THEN LET g_pjcd.pjcd202b = 0 END IF
    IF cl_null(g_pjcd.pjcd202c) THEN LET g_pjcd.pjcd202c = 0 END IF
    IF cl_null(g_pjcd.pjcd202d) THEN LET g_pjcd.pjcd202d = 0 END IF
    IF cl_null(g_pjcd.pjcd202e) THEN LET g_pjcd.pjcd202e = 0 END IF
    IF cl_null(g_pjcd.pjcd202f) THEN LET g_pjcd.pjcd202f = 0 END IF
    IF cl_null(g_pjcd.pjcd202g) THEN LET g_pjcd.pjcd202g = 0 END IF
    IF cl_null(g_pjcd.pjcd202h) THEN LET g_pjcd.pjcd202h = 0 END IF  
    
    #期未結存金額(pjcd902) = 上期結存金額(pjcd102) + 本期投入金額(pjcd202)
    #期未結存材料金額(pjcd902a) = 上期結存材料金額(pjcd102a) + 本期投入材料金額(pjcd202a)
    #期未結存人工金額(pjcd902b) = 上期結存人工金額(pjcd102b) + 本期投入人工金額(pjcd202b)
    #期未結存加工金額(pjcd902c) = 上期結存加工金額(pjcd102c) + 本期投入加工金額(pjcd202c)
    #期未結存製費一金額(pjcd902d) = 上期結存製費一金額(pjcd102d) + 本期投入製費一金額(pjcd202d)
    #期未結存製費二金額(pjcd902e) = 上期結存製費二金額(pjcd102e) + 本期投入製費二金額(pjcd202e)
    #期未結存製費三金額(pjcd902f) = 上期結存製費三金額(pjcd102f) + 本期投入製費三金額(pjcd202f)
    #期未結存製費四金額(pjcd902g) = 上期結存製費四金額(pjcd102g) + 本期投入製費四金額(pjcd202g)
    #期未結存製費五金額(pjcd902h) = 上期結存製費五金額(pjcd102h) + 本期投入製費五金額(pjcd202h)
    LET g_pjcd.pjcd902  = g_pjcd.pjcd102 + g_pjcd.pjcd202
    LET g_pjcd.pjcd902a = g_pjcd.pjcd102a + g_pjcd.pjcd202a 
    LET g_pjcd.pjcd902b = g_pjcd.pjcd102b + g_pjcd.pjcd202b
    LET g_pjcd.pjcd902c = g_pjcd.pjcd102c + g_pjcd.pjcd202c
    LET g_pjcd.pjcd902d = g_pjcd.pjcd102d + g_pjcd.pjcd202d
    LET g_pjcd.pjcd902e = g_pjcd.pjcd102e + g_pjcd.pjcd202e
    LET g_pjcd.pjcd902f = g_pjcd.pjcd102f + g_pjcd.pjcd202f
    LET g_pjcd.pjcd902g = g_pjcd.pjcd102g + g_pjcd.pjcd202g
    LET g_pjcd.pjcd902h = g_pjcd.pjcd102h + g_pjcd.pjcd202h
    
    #INSERT INTO 專案在製成本期異動統計檔(pjcd_t)  
    LET l_pjcdtime = cl_get_current()
    
    INSERT INTO pjcd_t (pjcdent,pjcdcomp,pjcdld  ,pjcd001 ,pjcd002 ,pjcd003 ,pjcd004 ,pjcd005 ,
                        pjcd011,
                        pjcd102,pjcd102a,pjcd102b,pjcd102c,pjcd102d,pjcd102e,pjcd102f,pjcd102g,pjcd102h,
                        pjcd202,pjcd202a,pjcd202b,pjcd202c,pjcd202d,pjcd202e,pjcd202f,pjcd202g,pjcd202h,
                        pjcd902,pjcd902a,pjcd902b,pjcd902c,pjcd902d,pjcd902e,pjcd902f,pjcd902g,pjcd902h,
                        pjcdtime)
       VALUES (g_pjcd.pjcdent,g_pjcd.pjcdcomp,g_pjcd.pjcdld  ,g_pjcd.pjcd001 ,g_pjcd.pjcd002 ,g_pjcd.pjcd003 ,g_pjcd.pjcd004 ,g_pjcd.pjcd005 ,
               g_pjcd.pjcd011,
               g_pjcd.pjcd102,g_pjcd.pjcd102a,g_pjcd.pjcd102b,g_pjcd.pjcd102c,g_pjcd.pjcd102d,g_pjcd.pjcd102e,g_pjcd.pjcd102f,g_pjcd.pjcd102g,g_pjcd.pjcd102h,
               g_pjcd.pjcd202,g_pjcd.pjcd202a,g_pjcd.pjcd202b,g_pjcd.pjcd202c,g_pjcd.pjcd202d,g_pjcd.pjcd202e,g_pjcd.pjcd202f,g_pjcd.pjcd202g,g_pjcd.pjcd202h,
               g_pjcd.pjcd902,g_pjcd.pjcd902a,g_pjcd.pjcd902b,g_pjcd.pjcd902c,g_pjcd.pjcd902d,g_pjcd.pjcd902e,g_pjcd.pjcd902f,g_pjcd.pjcd902g,g_pjcd.pjcd902h,
               l_pjcdtime)
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = p_pjba001 , " pjcd_t" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
    END IF
    
    RETURN r_success
    
END FUNCTION

PRIVATE FUNCTION apjp500_upd_pjcc(p_pjba001)
DEFINE p_pjba001    LIKE pjba_t.pjba001
DEFINE r_success    LIKE type_t.num5
DEFINE l_pjbz100    LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_1  LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_2  LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_3  LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_4  LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_5  LIKE pjbz_t.pjbz100
DEFINE l_pjbz100_6  LIKE pjbz_t.pjbz100

    WHENEVER ERROR CONTINUE
    LET r_success = TRUE

    #專案所屬人工製費計算
    #抓取pjbz_t中專案代號(pjbz004)=專案代號 and 年度=計算年度 and 期別=計算期別 的資料
    #依法人組織、帳套為群組
    #專案人工製費金額 =SUM(分攤成本(pjbz100))
    #專案人工金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='1.人工')
    #專案製費一金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='2.製費一')
    #專案製費二金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='3.製費二')
    #專案製費三金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='4.製費三')
    #專案製費四金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='5.製費四')
    #專案製費五金額 = SUM(分攤成本(pjbz100) where 費用類型(pjbz001)='6.製費五')
    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001
        
    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_1 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '1'
        
    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_2 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '2'

    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_3 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '3'
        
    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_4 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '4'    
        
    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_5 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '5'  

    SELECT SUM(CASE WHEN pjbz100 IS NULL THEN 0 ELSE pjbz100 END) INTO l_pjbz100_6 FROM pjbz_t 
      WHERE pjbzent = g_enterprise AND pjbzcomp = g_comp AND pjbzld = g_ld AND pjbz002 = g_master.yy
        AND pjbz003 = g_master.pp AND pjbz004 = p_pjba001 AND pjbz001 = '6'
        
    IF cl_null(l_pjbz100)  THEN LET l_pjbz100 = 0 END IF 
    IF cl_null(l_pjbz100_1) THEN LET l_pjbz100_1 = 0 END IF
    IF cl_null(l_pjbz100_2) THEN LET l_pjbz100_2 = 0 END IF
    IF cl_null(l_pjbz100_3) THEN LET l_pjbz100_3 = 0 END IF
    IF cl_null(l_pjbz100_4) THEN LET l_pjbz100_4 = 0 END IF
    IF cl_null(l_pjbz100_5) THEN LET l_pjbz100_5 = 0 END IF
    IF cl_null(l_pjbz100_6) THEN LET l_pjbz100_6 = 0 END IF
        
    #專案總成本期異動統計檔(pjcc_t)本期金額加上在製金額及專案人工製費金額
    #本期入庫金額(pjcc202) = 本期入庫金額(pjcc202) + 本期投入金額(pjcd202) + 專案人工製費金額
    #本期入庫金額-材料(pjcc202a) = 本期入庫金額-材料(pjcc202a) + 本期投入材料金額(pjcd202a)
    #本期入庫金額-人工(pjcc202b) = 本期入庫金額-人工(pjcc202b) + 本期投入人工金額(pjcd202b) + 專案人工金額
    #本期入庫金額-加工(pjcc202c) = 本期入庫金額-加工(pjcc202c) + 本期投入加工金額(pjcd202c)
    #本期入庫金額-製費一(pjcc202d) = 本期入庫金額-製費一(pjcc202d) + 本期投入製費一金額(pjcd202d) + 專案製費一金額
    #本期入庫金額-製費二(pjcc202e) = 本期入庫金額-製費二(pjcc202e) + 本期投入製費二金額(pjcd202e) + 專案製費二金額
    #本期入庫金額-製費三(pjcc202f) = 本期入庫金額-製費三(pjcc202f) + 本期投入製費三金額(pjcd202f) + 專案製費三金額
    #本期入庫金額-製費四(pjcc202g) = 本期入庫金額-製費四(pjcc202g) + 本期投入製費四金額(pjcd202g) + 專案製費四金額
    #本期入庫金額-製費五(pjcc202h) = 本期入庫金額-製費五(pjcc202h) + 本期投入製費五金額(pjcd202h) + 專案製費五金額
    LET g_pjcc.pjcc202  = g_pjcc.pjcc202  + g_pjcd.pjcd202  + l_pjbz100
    LET g_pjcc.pjcc202a = g_pjcc.pjcc202a + g_pjcd.pjcd202a
    LET g_pjcc.pjcc202b = g_pjcc.pjcc202b + g_pjcd.pjcd202b + l_pjbz100_1
    LET g_pjcc.pjcc202c = g_pjcc.pjcc202c + g_pjcd.pjcd202c
    LET g_pjcc.pjcc202d = g_pjcc.pjcc202d + g_pjcd.pjcd202d + l_pjbz100_2
    LET g_pjcc.pjcc202e = g_pjcc.pjcc202e + g_pjcd.pjcd202e + l_pjbz100_3
    LET g_pjcc.pjcc202f = g_pjcc.pjcc202f + g_pjcd.pjcd202f + l_pjbz100_4
    LET g_pjcc.pjcc202g = g_pjcc.pjcc202g + g_pjcd.pjcd202g + l_pjbz100_5
    LET g_pjcc.pjcc202h = g_pjcc.pjcc202h + g_pjcd.pjcd202h + l_pjbz100_6
    
    
    #期未結存金額(pjcc902) = 上期結存金額(pjcc102) + 本期入庫金額(pjcc202)
    #期未結存金額-材料(pjcc902a) = 上期結存金額-材料(pjcc102a) + 本期入庫金額-材料(pjcc202a)
    #期未結存金額-人工(pjcc902b) = 上期結存金額-人工(pjcc102b) + 本期入庫金額-人工(pjcc202b)
    #期未結存金額-加工(pjcc902c) = 上期結存金額-加工(pjcc102c) + 本期入庫金額-加工(pjcc202c)
    #期未結存金額-製費一(pjcc902d) = 上期結存金額-製費一(pjcc102d) + 本期入庫金額-製費一(pjcc202d)
    #期未結存金額-製費二(pjcc902e) = 上期結存金額-製費二(pjcc102e) + 本期入庫金額-製費二(pjcc202e)
    #期未結存金額-製費三(pjcc902f) = 上期結存金額-製費三(pjcc102f) + 本期入庫金額-製費三(pjcc202f)
    #期未結存金額-製費四(pjcc902g) = 上期結存金額-製費四(pjcc102g) + 本期入庫金額-製費四(pjcc202g)
    #期未結存金額-製費五(pjcc902h) = 上期結存金額-製費五(pjcc102h) + 本期入庫金額-製費五(pjcc202h)
    LET g_pjcc.pjcc902  = g_pjcc.pjcc102  + g_pjcc.pjcc202
    LET g_pjcc.pjcc902a = g_pjcc.pjcc102a  + g_pjcc.pjcc202a
    LET g_pjcc.pjcc902b = g_pjcc.pjcc102b  + g_pjcc.pjcc202b
    LET g_pjcc.pjcc902c = g_pjcc.pjcc102c  + g_pjcc.pjcc202c
    LET g_pjcc.pjcc902d = g_pjcc.pjcc102d  + g_pjcc.pjcc202d
    LET g_pjcc.pjcc902e = g_pjcc.pjcc102e  + g_pjcc.pjcc202e
    LET g_pjcc.pjcc902f = g_pjcc.pjcc102f  + g_pjcc.pjcc202f
    LET g_pjcc.pjcc902g = g_pjcc.pjcc102g  + g_pjcc.pjcc202g
    LET g_pjcc.pjcc902h = g_pjcc.pjcc102h  + g_pjcc.pjcc202h
    
    #UPDATE 專案總成本期異動統計檔(pjcc_t)
    UPDATE pjcc_t SET pjcc202  = g_pjcc.pjcc202 ,
                      pjcc202a = g_pjcc.pjcc202a,
                      pjcc202b = g_pjcc.pjcc202b,
                      pjcc202c = g_pjcc.pjcc202c,
                      pjcc202d = g_pjcc.pjcc202d,
                      pjcc202e = g_pjcc.pjcc202e,
                      pjcc202f = g_pjcc.pjcc202f,
                      pjcc202g = g_pjcc.pjcc202g,
                      pjcc202h = g_pjcc.pjcc202h,
                      pjcc902  = g_pjcc.pjcc902 ,         
                      pjcc902a = g_pjcc.pjcc902a,
                      pjcc902b = g_pjcc.pjcc902b,
                      pjcc902c = g_pjcc.pjcc902c,
                      pjcc902d = g_pjcc.pjcc902d,
                      pjcc902e = g_pjcc.pjcc902e,
                      pjcc902f = g_pjcc.pjcc902f,
                      pjcc902g = g_pjcc.pjcc902g,
                      pjcc902h = g_pjcc.pjcc902h
          WHERE pjccent = g_enterprise AND pjccld = g_pjcc.pjccld AND pjcc002 = g_pjcc.pjcc002 AND pjcc003 = g_pjcc.pjcc003 
            AND pjcc004 = g_pjcc.pjcc004 AND pjcc005  = g_pjcc.pjcc005 AND pjcc001 = g_pjcc.pjcc001  
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = p_pjba001 , " pjcc_t" 
       LET g_errparam.code   = SQLCA.sqlcode 
       LET g_errparam.popup  = TRUE
       CALL cl_err()
       LET r_success = FALSE
    END IF
    
    RETURN r_success
    
END FUNCTION
################################################################################
# Descriptions...: 取得与日期及年期相关的资讯
# Memo...........:
# Usage..........: CALL apjp500_get_date()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2015-10-10 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp500_get_date()
DEFINE r_success       LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   #取"會計週期參照表號"
   SELECT glaa003 INTO g_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_ld
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Select glaa003'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   #取当期的起始及截止日期
   CALL s_fin_date_get_period_range(g_glaa003,g_master.yy,g_master.pp)
        RETURNING g_bdate,g_edate

   #取上期的年度/期别
   CALL s_fin_date_get_last_period('',g_ld,g_master.yy,g_master.pp)
        RETURNING l_success,g_last_yy,g_last_pp
   IF NOT l_success THEN
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#end add-point
 
{</section>}
 
