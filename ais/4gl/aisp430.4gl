#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-12-31 10:39:03), PR版次:0006(2015-12-31 16:58:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000066
#+ Filename...: aisp430
#+ Description: 進銷項媒體產生作業
#+ Creator....: 04152(2015-04-01 10:41:45)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp430.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150422-00012#3  2015/05/23 By Reanna 改抓取申報歸屬月份
#150224-00005#30 2015/06/22 By Reanna 增加1.零稅率銷售額轉檔2.固定資產退稅資料轉檔
#150624-00005#8  2015/06/26 By Jessy  處理排程相關程式
#150518-00039#3  2015/07/01 By Reanna 增加1.營業人直接扣抵檔2.營業人銷售申報書檔
#150915-00013#4  2015/09/15 By Reanna 開放可單獨執行產生申報書
#150925          2015/09/25 By Reanna 銷項發票買受人統編擷取八位就好
#151013-00019#13 2015/12/03 By Reanna 所屬日期改成取發票日期的年月
#151207-00018#5  2015/12/29 By Reanna 22格式皆取未稅及稅額產生媒體/32格式維持取含稅金額，稅額=0
#151229-00001#1  2015/12/30 By Reanna 增加選項:產生銷項媒體含零稅率申報資料，預設值 = N，等於N時isaj015<>'2'(課稅別<>2.零稅率)
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
   #150624-00005#8-----s
   isaa001      LIKE isaa_t.isaa001, 
   isaa002      LIKE isaa_t.isaa002, 
   isaa012      LIKE isaa_t.isaa012, 
   isaa013      LIKE isaa_t.isaa013, 
   l_chk1       LIKE type_t.chr500, 
   l_chk3       LIKE type_t.chr500, 
   l_chk4       LIKE type_t.chr500, 
   l_chk5       LIKE type_t.chr500, 
   l_chk6       LIKE type_t.chr500, 
   l_chk2       LIKE type_t.chr500, 
   l_route      LIKE type_t.chr500, 
   #150624-00005#8-----e
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       isaa001 LIKE isaa_t.isaa001, 
   isaa001_desc LIKE type_t.chr80, 
   isaa002 LIKE isaa_t.isaa002, 
   isaa012 LIKE isaa_t.isaa012, 
   isaa013 LIKE isaa_t.isaa013, 
   l_chk1 LIKE type_t.chr500, 
   l_chk3 LIKE type_t.chr500, 
   l_chk4 LIKE type_t.chr500, 
   l_chk5 LIKE type_t.chr500, 
   l_chk6 LIKE type_t.chr500, 
   l_chk7 LIKE type_t.chr500, 
   l_chk2 LIKE type_t.chr500, 
   l_chk8 LIKE type_t.chr500, 
   l_route LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ooef003     LIKE ooef_t.ooef003
DEFINE g_ooef017     LIKE ooef_t.ooef017
DEFINE g_dir         STRING
DEFINE g_isaa022     LIKE isaa_t.isaa022  #150518-00039#3
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp430.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL aisp430_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp430 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp430_init()
 
      #進入選單 Menu (="N")
      CALL aisp430_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp430
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp430.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp430_init()
 
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
 
{<section id="aisp430.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp430_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt        LIKE type_t.num10
   DEFINE l_isaa012    LIKE isaa_t.isaa012    #年度
   DEFINE l_isaa013    LIKE isaa_t.isaa013    #月份
   DEFINE l_day1       LIKE type_t.dat        #輸入的年月
   DEFINE l_day2       LIKE type_t.dat        #aisi010設定的年月
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aisp430_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk1, 
             g_master.l_chk3,g_master.l_chk4,g_master.l_chk5,g_master.l_chk6,g_master.l_chk7,g_master.l_chk2, 
             g_master.l_chk8,g_master.l_route 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa001
            
            #add-point:AFTER FIELD isaa001 name="input.a.isaa001"
            IF NOT cl_null(g_master.isaa001) THEN
               #申報單位須存在aisi010裡面
               SELECT COUNT(*) INTO l_cnt
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00193'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #取該申報單位的統一編號&法人否
               SELECT ooef002,ooef003,ooef017 INTO g_master.isaa002,g_ooef003,g_ooef017
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_master.isaa001
               IF g_ooef003 = "Y" THEN
                  CALL cl_set_comp_entry("l_chk2",TRUE)
                  LET g_master.l_chk2 = "Y"
               ELSE 
                  CALL cl_set_comp_entry("l_chk2",FALSE)
                  LET g_master.l_chk2 = "N"
               END IF
               #150518-00039#3 add ------
               #抓取直接扣抵法否
               SELECT isaa022 INTO g_isaa022
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF g_isaa022 = "Y" THEN
                  CALL cl_set_comp_entry("l_chk6",TRUE)
               ELSE
                  CALL cl_set_comp_entry("l_chk6",FALSE)
               END IF
               LET g_master.l_chk6 = "N"
               #150518-00039#3 add end---
            END IF
            CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
            DISPLAY BY NAME g_master.isaa001_desc,g_master.isaa002
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa002
            #add-point:BEFORE FIELD isaa002 name="input.b.isaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa002
            
            #add-point:AFTER FIELD isaa002 name="input.a.isaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa002
            #add-point:ON CHANGE isaa002 name="input.g.isaa002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa012,"0","0","2099","1","azz-00087",1) THEN
               NEXT FIELD isaa012
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa012 name="input.a.isaa012"
            IF NOT cl_null(g_master.isaa012) THEN
               #年度不可小於aisi010的申報年度
               SELECT isaa012,isaa013 INTO l_isaa012,l_isaa013
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF NOT cl_null(l_isaa012) THEN
                  IF g_master.isaa012 < l_isaa012 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00190'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(l_isaa013) THEN
                     LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
                     LET l_day2= MDY(l_isaa013,1,l_isaa012)
                     IF l_day1 <= l_day2 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ais-00191'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD isaa013
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa012
            #add-point:BEFORE FIELD isaa012 name="input.b.isaa012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa012
            #add-point:ON CHANGE isaa012 name="input.g.isaa012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa013,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD isaa013
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa013 name="input.a.isaa013"
            IF NOT cl_null(g_master.isaa012) AND NOT cl_null(g_master.isaa013) THEN
               #年度不可小於aisi010的申報月份
               SELECT isaa012,isaa013 INTO l_isaa012,l_isaa013
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_master.isaa001
               IF NOT cl_null(l_isaa012) OR NOT cl_null(l_isaa013) THEN
                  LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
                  LET l_day2= MDY(l_isaa013,1,l_isaa012)
                  IF l_day1 <= l_day2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00191'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa013
            #add-point:BEFORE FIELD isaa013 name="input.b.isaa013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa013
            #add-point:ON CHANGE isaa013 name="input.g.isaa013"
            #150422-00012#3 mark ------
            #IF NOT cl_null(g_master.isaa013) THEN
            #   LET g_master.isaa013_2 = g_master.isaa013 + 1
            #   IF g_master.isaa013 >= 12 THEN
            #      LET g_master.isaa013_2 = 12
            #   END IF
            #END IF
            #150422-00012#3 mark end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk1
            #add-point:BEFORE FIELD l_chk1 name="input.b.l_chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk1
            
            #add-point:AFTER FIELD l_chk1 name="input.a.l_chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk1
            #add-point:ON CHANGE l_chk1 name="input.g.l_chk1"
            #151229-00001#1 add ------
            CALL cl_set_comp_entry("l_chk8",TRUE)
            IF g_master.l_chk1 <> 'Y' THEN
               LET g_master.l_chk8 = 'N'
               CALL cl_set_comp_entry("l_chk8",FALSE)
            END IF
            #151229-00001#1 add end---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk3
            #add-point:BEFORE FIELD l_chk3 name="input.b.l_chk3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk3
            
            #add-point:AFTER FIELD l_chk3 name="input.a.l_chk3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk3
            #add-point:ON CHANGE l_chk3 name="input.g.l_chk3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk4
            #add-point:BEFORE FIELD l_chk4 name="input.b.l_chk4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk4
            
            #add-point:AFTER FIELD l_chk4 name="input.a.l_chk4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk4
            #add-point:ON CHANGE l_chk4 name="input.g.l_chk4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk5
            #add-point:BEFORE FIELD l_chk5 name="input.b.l_chk5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk5
            
            #add-point:AFTER FIELD l_chk5 name="input.a.l_chk5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk5
            #add-point:ON CHANGE l_chk5 name="input.g.l_chk5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk6
            #add-point:BEFORE FIELD l_chk6 name="input.b.l_chk6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk6
            
            #add-point:AFTER FIELD l_chk6 name="input.a.l_chk6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk6
            #add-point:ON CHANGE l_chk6 name="input.g.l_chk6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk7
            #add-point:BEFORE FIELD l_chk7 name="input.b.l_chk7"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk7
            
            #add-point:AFTER FIELD l_chk7 name="input.a.l_chk7"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk7
            #add-point:ON CHANGE l_chk7 name="input.g.l_chk7"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk2
            #add-point:BEFORE FIELD l_chk2 name="input.b.l_chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk2
            
            #add-point:AFTER FIELD l_chk2 name="input.a.l_chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk2
            #add-point:ON CHANGE l_chk2 name="input.g.l_chk2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk8
            #add-point:BEFORE FIELD l_chk8 name="input.b.l_chk8"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk8
            
            #add-point:AFTER FIELD l_chk8 name="input.a.l_chk8"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk8
            #add-point:ON CHANGE l_chk8 name="input.g.l_chk8"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_route
            #add-point:BEFORE FIELD l_route name="input.b.l_route"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_route
            
            #add-point:AFTER FIELD l_route name="input.a.l_route"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_route
            #add-point:ON CHANGE l_route name="input.g.l_route"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa001
            #add-point:ON ACTION controlp INFIELD isaa001 name="input.c.isaa001"
            #i開窗-申報單位代碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.isaa001
            LET g_qryparam.where = "isaastus = 'Y' "
            CALL q_isaa001()
            LET g_master.isaa001 = g_qryparam.return1
            DISPLAY BY NAME g_master.isaa001
            NEXT FIELD isaa001
            #END add-point
 
 
         #Ctrlp:input.c.isaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa002
            #add-point:ON ACTION controlp INFIELD isaa002 name="input.c.isaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa012
            #add-point:ON ACTION controlp INFIELD isaa012 name="input.c.isaa012"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa013
            #add-point:ON ACTION controlp INFIELD isaa013 name="input.c.isaa013"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk3
            #add-point:ON ACTION controlp INFIELD l_chk3 name="input.c.l_chk3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk4
            #add-point:ON ACTION controlp INFIELD l_chk4 name="input.c.l_chk4"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk5
            #add-point:ON ACTION controlp INFIELD l_chk5 name="input.c.l_chk5"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk6
            #add-point:ON ACTION controlp INFIELD l_chk6 name="input.c.l_chk6"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk7
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk7
            #add-point:ON ACTION controlp INFIELD l_chk7 name="input.c.l_chk7"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk8
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk8
            #add-point:ON ACTION controlp INFIELD l_chk8 name="input.c.l_chk8"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_route
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_route
            #add-point:ON ACTION controlp INFIELD l_route name="input.c.l_route"
            CALL ui.interface.frontcall("standard", "opendir", ["C:/",""], [g_dir])
            LET g_master.l_route = g_dir
            DISPLAY BY NAME g_master.l_route
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
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL aisp430_get_buffer(l_dialog)
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
            CALL aisp430_qbe_clear()
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
         CALL aisp430_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#8-----s
      LET lc_param.isaa001 = g_master.isaa001
      LET lc_param.isaa002 = g_master.isaa002
      LET lc_param.isaa012 = g_master.isaa012
      LET lc_param.isaa013 = g_master.isaa013
      LET lc_param.l_chk1  = g_master.l_chk1
      LET lc_param.l_chk3  = g_master.l_chk3
      LET lc_param.l_chk4  = g_master.l_chk4
      LET lc_param.l_chk5  = g_master.l_chk5
      LET lc_param.l_chk6  = g_master.l_chk6
      LET lc_param.l_chk2  = g_master.l_chk2
      LET lc_param.l_route = g_master.l_route
      #150624-00005#8-----e
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
                 CALL aisp430_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp430_transfer_argv(ls_js)
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
 
{<section id="aisp430.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp430_transfer_argv(ls_js)
 
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
 
{<section id="aisp430.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp430_process(ls_js)
 
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
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_write       LIKE type_t.chr1   #判斷是否寫入
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #150624-00005#8-----s
   #將傳遞參數變數傳回給畫面上的變數
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc      = lc_param.wc
      LET g_master.isaa001 = lc_param.isaa001
      LET g_master.isaa002 = lc_param.isaa002
      LET g_master.isaa012 = lc_param.isaa012
      LET g_master.isaa013 = lc_param.isaa013
      LET g_master.l_chk1  = lc_param.l_chk1
      LET g_master.l_chk3  = lc_param.l_chk3
      LET g_master.l_chk4  = lc_param.l_chk4
      LET g_master.l_chk5  = lc_param.l_chk5
      LET g_master.l_chk6  = lc_param.l_chk6
      LET g_master.l_chk2  = lc_param.l_chk2
      LET g_master.l_route = lc_param.l_route
      LET g_dir            = lc_param.l_route
   END IF
   #150624-00005#8-----e
   
   
   #150422-00012#3 take out isaa013_2
   IF cl_null(g_master.isaa001) OR cl_null(g_master.isaa012) OR
      cl_null(g_master.isaa013) OR
      cl_null(g_master.l_route) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #沒有統一編號不能產生TXT檔案
   IF cl_null(g_master.isaa002) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'ais-00197'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp430_process_cs CURSOR FROM ls_sql
#  FOREACH aisp430_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_success = 'Y'
   LET l_write = 'N'

   #抓取媒體申報資料From aist410 #150422-00012#3 take out isaa013_2
   IF g_master.l_chk1 = "Y" THEN
      #151229-00001#1 add l_chk8
      CALL aisp430_catch_isaj(g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk2,g_master.l_chk8)
           RETURNING g_sub_success,l_write
   END IF
   
   #150224-00005#30 add ------
   #營業人申報固定資產退稅清單(T08)
   IF g_master.l_chk4 = "Y" THEN
      CALL aisp430_catch_isaj_t08(g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk2)
           RETURNING g_sub_success,l_write
   END IF
   
   #營業人零稅率銷售額資料檔(T02)
   IF g_master.l_chk5 = "Y" THEN
      CALL aisp430_catch_isaj_t02(g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk2)
           RETURNING g_sub_success,l_write
   END IF
   #150224-00005#30 add end---
   
   #150518-00039#3 add ------
   #營業人直接扣抵檔(T01)
   IF g_master.l_chk6 = "Y" THEN
      CALL aisp430_catch_isaj_t01(g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk2)
           RETURNING g_sub_success,l_write
   END IF
   
   #營業人銷售額與稅額申報書檔(TET)
   IF g_master.l_chk7 = "Y" THEN
      CALL aisp430_catch_isaj_tet(g_master.isaa001,g_master.isaa002,g_master.isaa012,g_master.isaa013,g_master.l_chk2)
           RETURNING g_sub_success,l_write
   END IF
   #150518-00039#3 add end---
   
   #150915-00013#4 mark ------
   #IF NOT g_sub_success THEN
   #   LET g_success = 'N'
   #ELSE
   #150915-00013#4 mark end---
   #產生401+403申報書
   IF g_master.l_chk3 = "Y" THEN
      #若有資料存在，需先刪除
      LET l_sql = "SELECT COUNT(*)",
                  "  FROM iscb_t",
                  " WHERE iscbent  = ",g_enterprise,
                  "   AND iscbsite = '",g_master.isaa001,"'",
                  #"   AND iscb200 = ",g_master.isaa012," AND iscb201 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                  "   AND iscb200 = ",g_master.isaa012," AND iscb201 = ",g_master.isaa013 #150422-00012#3
      PREPARE iscb_pb1 FROM l_sql
      EXECUTE iscb_pb1 INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         LET l_sql = " DELETE FROM iscb_t",
                     " WHERE iscbent  = ",g_enterprise,
                     "   AND iscbsite = '",g_master.isaa001,"'",
                     #"   AND iscb200 = ",g_master.isaa012," AND iscb201 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                     "   AND iscb200 = ",g_master.isaa012," AND iscb201 = ",g_master.isaa013 #150422-00012#3
         PREPARE iscb_pb2 FROM l_sql
         EXECUTE iscb_pb2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.sqlerr = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      END IF
      LET l_cnt = 0
      LET l_sql = "SELECT COUNT(*)",
                  "  FROM isca_t",
                  " WHERE iscaent  = ",g_enterprise,
                  "   AND iscasite = '",g_master.isaa001,"'",
                  #"   AND isca001 = ",g_master.isaa012," AND isca002 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                  "   AND isca001 = ",g_master.isaa012," AND isca002 = ",g_master.isaa013 #150422-00012#3
      PREPARE isca_pb1 FROM l_sql
      EXECUTE isca_pb1 INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         LET l_sql = " DELETE FROM isca_t",
                     " WHERE iscaent = ",g_enterprise,
                     "   AND iscasite = '",g_master.isaa001,"'",
                     #"   AND isca001 = ",g_master.isaa012," AND isca002 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                     "   AND isca001 = ",g_master.isaa012," AND isca002 = ",g_master.isaa013 #150422-00012#3
         PREPARE isca_pb2 FROM l_sql
         EXECUTE isca_pb2
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.sqlerr = SQLCA.sqlcode
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      END IF
      IF g_success = 'Y' THEN
         #150422-00012#3 take out isaa013_2
         CALL s_aisp401_ins_iscb(g_master.isaa012,g_master.isaa013,g_ooef017,g_master.isaa001) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            LET g_success = 'N'
         ELSE
            #如果寫入成功也要同時產生一筆isca_t，但要先刪除 #150422-00012#3 take out isaa013_2
            CALL s_aisp401_ins_isca(g_master.isaa012,g_master.isaa013,g_ooef017,g_master.isaa001) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET g_success = 'N'
            END IF
         END IF
      END IF
      #這裡check有沒有資料寫入
      IF g_success = 'Y' THEN
         LET l_sql = "SELECT COUNT(*)",
                     "  FROM iscb_t",
                     " WHERE iscbent  = ",g_enterprise,
                     "   AND iscbsite = '",g_master.isaa001,"'",
                     #"   AND iscb200 = ",g_master.isaa012," AND iscb201 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                     "   AND iscb200 = ",g_master.isaa012," AND iscb201 = ",g_master.isaa013 #150422-00012#3
         PREPARE iscb_pb_chk FROM l_sql
         EXECUTE iscb_pb_chk INTO l_cnt
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN LET l_write = 'Y' END IF
         LET l_cnt = 0
         LET l_sql = "SELECT COUNT(*)",
                     "  FROM isca_t",
                     " WHERE iscaent  = ",g_enterprise,
                     "   AND iscasite = '",g_master.isaa001,"'",
                     #"   AND isca001 = ",g_master.isaa012," AND isca002 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2 #150422-00012#3 mark
                     "   AND isca001 = ",g_master.isaa012," AND isca002 = ",g_master.isaa013 #150422-00012#3
         PREPARE isca_pb_chk FROM l_sql
         EXECUTE isca_pb_chk INTO l_cnt
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN LET l_write = 'Y' END IF
      END IF
   END IF
   
   #150915-00013#4 add ------
   IF NOT g_sub_success THEN
      LET g_success = 'N'
   #150915-00013#4 add end---
   END IF

   IF g_success = 'Y' THEN
      IF l_write = 'Y' THEN
      #ELSE
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'asf-00230' #無資料
      #   LET g_errparam.extend = ''
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
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
   CALL aisp430_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp430.get_buffer" >}
PRIVATE FUNCTION aisp430_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.isaa001 = p_dialog.getFieldBuffer('isaa001')
   LET g_master.isaa002 = p_dialog.getFieldBuffer('isaa002')
   LET g_master.isaa012 = p_dialog.getFieldBuffer('isaa012')
   LET g_master.isaa013 = p_dialog.getFieldBuffer('isaa013')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.l_chk3 = p_dialog.getFieldBuffer('l_chk3')
   LET g_master.l_chk4 = p_dialog.getFieldBuffer('l_chk4')
   LET g_master.l_chk5 = p_dialog.getFieldBuffer('l_chk5')
   LET g_master.l_chk6 = p_dialog.getFieldBuffer('l_chk6')
   LET g_master.l_chk7 = p_dialog.getFieldBuffer('l_chk7')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
   LET g_master.l_chk8 = p_dialog.getFieldBuffer('l_chk8')
   LET g_master.l_route = p_dialog.getFieldBuffer('l_route')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp430.msgcentre_notify" >}
PRIVATE FUNCTION aisp430_msgcentre_notify()
 
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
 
{<section id="aisp430.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aisp430_qbe_clear()
# Date & Author..: 2015/04/01 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_qbe_clear()
DEFINE l_cnt        LIKE type_t.num5
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL

   LET g_master.isaa001 = g_site
   #申報單位須存在aisi010裡面，沒有給空
   SELECT COUNT(*) INTO l_cnt
     FROM isaa_t
    WHERE isaaent = g_enterprise
      AND isaa001 = g_master.isaa001
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      LET g_master.isaa001 = ''
      LET g_master.l_chk2 = "N"
   ELSE
      CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
      #取該申報單位的統一編號&法人否
      SELECT ooef002,ooef003,ooef017 INTO g_master.isaa002,g_ooef003,g_ooef017
        FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_master.isaa001
      IF g_ooef003 = "Y" THEN
         CALL cl_set_comp_entry("l_chk2",TRUE)
         LET g_master.l_chk2 = "Y"
      ELSE 
         CALL cl_set_comp_entry("l_chk2",FALSE)
         LET g_master.l_chk2 = "N"
      END IF
   END IF
   CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
   
   LET g_master.isaa012 = YEAR(g_today)
   LET g_master.l_chk1 = "Y"
   LET g_dir = "C:\\tiptop"
   LET g_master.l_route = "C:\\tiptop"
   LET g_master.l_chk3 = "N" #150224-00005#30
   LET g_master.l_chk4 = "Y" #150224-00005#30
   LET g_master.l_chk5 = "Y"
   
   #150518-00039#3 add ------
   #抓取直接扣抵法否
   SELECT isaa022 INTO g_isaa022
     FROM isaa_t
    WHERE isaaent = g_enterprise
      AND isaa001 = g_master.isaa001
   IF g_isaa022 = "Y" THEN
      CALL cl_set_comp_entry("l_chk6",TRUE)
   ELSE
      CALL cl_set_comp_entry("l_chk6",FALSE)
   END IF
   LET g_master.l_chk6 = "N"
   LET g_master.l_chk7 = "N"
   #150518-00039#3 add end---
   
   #151229-00001#1 add ------
   #產生銷項媒體含零稅率申報資料
   LET g_master.l_chk8 = "N"
   CALL cl_set_comp_entry("l_chk8",TRUE)
   IF g_master.l_chk1 <> 'Y' THEN
      CALL cl_set_comp_entry("l_chk8",FALSE)
   END IF
   #151229-00001#1 add end---
   
   DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc,g_master.isaa002,g_master.isaa012,g_master.l_route,
                   g_master.l_chk3
END FUNCTION

################################################################################
# Descriptions...: 抓取媒體申報資料From aist410
# Memo...........:
# Usage..........: CALL aisp430_catch_isaj()
#                : p_isaa001   申報單位
#                : p_isaa002   申報單位的稅務編號
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_chk2      彙總申報Y:是N:否
#                : p_chk8      產生銷項媒體含零稅率申報資料Y:是N:否
# Date & Author..: 2015/04/01 By Reanna
# Modify.........: #150422-00012#3 take out isaa013_2
################################################################################
PRIVATE FUNCTION aisp430_catch_isaj(p_isaa001,p_isaa002,p_isaa012,p_isaa013,p_chk2,p_chk8)
DEFINE p_isaa001       LIKE isaa_t.isaa001
DEFINE p_isaa002       LIKE isaa_t.isaa002
DEFINE p_isaa012       LIKE isaa_t.isaa012
DEFINE p_isaa013       LIKE isaa_t.isaa013
#DEFINE p_isaa013_2     LIKE isaa_t.isaa013 #150422-00012#3 mark
DEFINE p_chk2          LIKE isaa_t.isaa017
DEFINE p_chk8          LIKE isaa_t.isaa017  #151229-00001#1
DEFINE l_sql           STRING
DEFINE l_wc            STRING
DEFINE l_isaj          RECORD
            isaj001       LIKE isaj_t.isaj001,
            isaj003       LIKE isaj_t.isaj003,
            isaj004       LIKE isaj_t.isaj004,
            isaj006       LIKE isaj_t.isaj006,
            isaj008       LIKE isaj_t.isaj008,
            isaj009       LIKE isaj_t.isaj009, #151013-00019#13
            isaj010       LIKE isaj_t.isaj010,
            isaj012       LIKE isaj_t.isaj012,
            isaj014       LIKE isaj_t.isaj014,
            isaj015       LIKE isaj_t.isaj015,
            isaj016       LIKE isaj_t.isaj016,
            isaj017       LIKE isaj_t.isaj017,
            isaj018       LIKE isaj_t.isaj018,
            isaj019       LIKE isaj_t.isaj019,
            isaj020       LIKE isaj_t.isaj020,
            isaj024       LIKE isaj_t.isaj024,
            isaj031       LIKE isaj_t.isaj031,
            isaj103       LIKE isaj_t.isaj103,
            isaj104       LIKE isaj_t.isaj104,
            isaj105       LIKE isaj_t.isaj105
                       END RECORD
DEFINE l_isaa          RECORD
            isaa002       LIKE isaa_t.isaa002
                       END RECORD
DEFINE l_tmp           RECORD
            tmp001        CHAR(2),
            tmp002        CHAR(9),
            tmp003        STRING,
            tmp004        STRING,
            tmp005        STRING,
            tmp006        STRING,
            tmp007        CHAR(4),
            tmp008        CHAR(2),
            tmp009        CHAR(8),
            tmp010        STRING,
            tmp011        CHAR(1),
            tmp012        STRING,
            tmp013        CHAR(1),
            tmp014        CHAR(5),
            tmp015        CHAR(1),
            tmp016        CHAR(1),
            tmp017        CHAR(1)
                       END RECORD
DEFINE l_isae010       LIKE isae_t.isae010
DEFINE l_first_isaj006 LIKE isaj_t.isaj006
DEFINE l_sum_count     LIKE type_t.num5
DEFINE l_isaj018_t     LIKE isaj_t.isaj018
DEFINE l_flag          LIKE type_t.chr1
DEFINE l_num           LIKE type_t.num5
DEFINE l_in_txt        STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_write         LIKE type_t.chr1
#存放TXT-----
DEFINE l_name          LIKE type_t.chr20
DEFINE ch              base.Channel
DEFINE l_file_name     STRING
DEFINE l_file_name2    STRING
DEFINE ls_target_file  STRING
DEFINE ls_source_file  STRING
DEFINE l_cmd           STRING
#存放TXT-----

   
   LET r_success = TRUE
   LET r_write = 'N'

   #存放TXT part1 start----------
   #檔案名稱default統一編號
   LET l_name = p_isaa002
   #取得暫時存放TXT的路徑(TEMPDIR)
   LET l_file_name = l_name,'orig.TXT'  #原始檔案
   LET l_file_name2 = l_name,'.TXT'     #轉成DOS格式的檔案
   
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED)
   LET ch = base.Channel.create()
   CALL ch.openFile(ls_source_file,"w")
   CALL ch.setDelimiter("")
   #存放TXT part1 end------------
   
   #抓取申報單位範圍
   IF p_chk2 = "Y" THEN #表示有很多家要彙總申報(總機構代碼isaa009=申報單位)
      LET l_wc = " (isaj003 = '",p_isaa001,"' OR isaa009 = '",p_isaa001,"')"
   ELSE
      LET l_wc = " isaj003 = '",p_isaa001,"'"
   END IF
   
   #151229-00001#1 add ------
   #產生銷項媒體含零稅率申報資料
   IF p_chk8 = "N" THEN
      LET l_wc = l_wc," AND isaj015 <> '2'"   # 課稅別 <> 2.零稅率
   END IF
   #151229-00001#1 add end---

   LET l_sql = "SELECT isaj001,isaj003,isaj004,isaj006,isaj008,",
               "       isaj010,isaj012,isaj014,isaj015,isaj016,",
               "       isaj017,isaj018,isaj019,isaj020,isaj024,",
               "       isaj031,isaj103,isaj104,isaj105,isaa002,", #151013-00019#13 add ,
               "       isaj009", #151013-00019#13
               "  FROM isaj_t",
               "  LEFT JOIN isaa_t ON isajent = isaaent AND isaj003 = isaa001",
               " WHERE isajent = ",g_enterprise,
               "   AND isajstus='Y'",
               #"   AND isaj019 = ",p_isaa012," AND isaj020 BETWEEN ",p_isaa013," AND ",p_isaa013_2, #150422-00012#3 mark
               "   AND isaj019 = ",p_isaa012," AND isaj020 = ",p_isaa013, #150422-00012#3
               "   AND isaj015 <> 'D' ",  #不含空白發票
               "   AND ",l_wc,
               " ORDER BY isaj018,isaj003,isaj006"
   PREPARE isaj_pb FROM l_sql
   DECLARE isaj_cs CURSOR FOR isaj_pb
   
   #進項(26、27格式)>>含稅金額、稅額
   LET l_sql = "SELECT SUM(isaj103),SUM(isaj104),SUM(isaj105)",
               "  FROM isaj_t",
               "  LEFT JOIN isaa_t ON isajent = isaaent AND isaj003 = isaa001",
               " WHERE isajent = ",g_enterprise,
               "   AND isajstus='Y'",
               #"   AND isaj019 = ",p_isaa012," AND isaj020 BETWEEN ",p_isaa013," AND ",p_isaa013_2, #150422-00012#3 mark
               "   AND isaj019 = ",p_isaa012," AND isaj020 = ",p_isaa013, #150422-00012#3
               "   AND isaj003 = ? ",  #申報單位
               "   AND isaj018 = ? "   #格式
   PREPARE isaj_pb1 FROM l_sql
   DECLARE isaj_cs1 CURSOR FOR isaj_pb1
   
   #進項(26、27格式)>>筆數
   LET l_sql = "SELECT COUNT(*)",
               "  FROM isaj_t",
               "  LEFT JOIN isaa_t ON isajent = isaaent AND isaj003 = isaa001",
               " WHERE isajent = ",g_enterprise,
               "   AND isajstus='Y'",
               #"   AND isaj019 = ",p_isaa012," AND isaj020 BETWEEN ",p_isaa013," AND ",p_isaa013_2, #150422-00012#3 mark
               "   AND isaj019 = ",p_isaa012," AND isaj020 = ",p_isaa013, #150422-00012#3
               "   AND isaj003 = ? ",  #申報單位
               "   AND isaj018 = ? "   #格式
   PREPARE isaj_pb2 FROM l_sql
   DECLARE isaj_cs2 CURSOR FOR isaj_pb2

   LET l_sum_count = 0
   LET l_num = 1
   FOREACH isaj_cs INTO l_isaj.isaj001,l_isaj.isaj003,l_isaj.isaj004,l_isaj.isaj006,l_isaj.isaj008,
                        l_isaj.isaj010,l_isaj.isaj012,l_isaj.isaj014,l_isaj.isaj015,l_isaj.isaj016,
                        l_isaj.isaj017,l_isaj.isaj018,l_isaj.isaj019,l_isaj.isaj020,l_isaj.isaj024,
                        l_isaj.isaj031,l_isaj.isaj103,l_isaj.isaj104,l_isaj.isaj105,l_isaa.isaa002, #151013-00019#13 add ,
                        l_isaj.isaj009    #151013-00019#13
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      INITIALIZE l_tmp.* TO NULL

      #若是銷項or進項彙總(同一筆交易取得多張發票)則取最後一張發票(有金額)來產生資料
      #EX取得3張發票 AA001 AA002 AA003，但只有AA003有登錄此交易的總額(取這張)，前面金額都=0(都不取)
      IF l_isaj.isaj103 = 0 AND l_isaj.isaj017 = 'A' AND l_isaj.isaj015 <> 'D' THEN
         #這裡先記錄該筆交易之第一張發票號碼
         IF l_isaj.isaj018[1,1] = '3' THEN
            IF cl_null(l_first_isaj006) THEN LET l_first_isaj006 = l_isaj.isaj006 END IF
         END IF
         #這裡計算總共有幾張發票彙總
         LET l_sum_count = l_sum_count + 1
         CONTINUE FOREACH
      END IF

      
      #進項(26、27格式)
      IF l_isaj.isaj018 = '26' OR l_isaj.isaj018 = '27' THEN
         IF cl_null(l_isaj018_t) OR l_isaj018_t != l_isaj.isaj018 THEN
            LET l_flag = 'Y'
         ELSE
            LET l_flag = 'N'
         END IF
         IF l_flag = 'Y' THEN  #第一筆才進來
            OPEN isaj_cs1 USING l_isaj.isaj003,l_isaj.isaj018
            FETCH isaj_cs1 INTO l_isaj.isaj103,l_isaj.isaj104,l_isaj.isaj105
            #進項憑證屬彙加資料者，則表示為彙加憑證張數。
            LET l_sum_count = 0
            OPEN isaj_cs2 USING l_isaj.isaj003,l_isaj.isaj018
            FETCH isaj_cs2 INTO l_sum_count
            LET l_isaj018_t = l_isaj.isaj018
         ELSE
            CONTINUE FOREACH
         END IF
      END IF
      
      
      #1~2
      #1.申報格式(2碼)
      LET l_tmp.tmp001 = l_isaj.isaj018
      
      
      #3~11
      #2.稅籍編號(9碼)
      LET l_tmp.tmp002 = l_isaa.isaa002
      
      
      #12~18
      #3.流水號(7碼)
      LET l_tmp.tmp003 = l_num USING "&&&&&&&"
      
      
      #19~23
      #4.資料所屬年月(5碼)
      #年要轉成民國年
      #151013-00019#13 mark ------
      #LET l_isaj.isaj019 = l_isaj.isaj019 - 1911
      #LET l_tmp.tmp004 = l_isaj.isaj019 USING "&&&" , l_isaj.isaj020 USING "&&"
      #151013-00019#13 mark end---
      #151013-00019#13 add ------
      LET l_isaj.isaj019 = YEAR(l_isaj.isaj009) - 1911
      LET l_isaj.isaj020 = MONTH(l_isaj.isaj009)
      LET l_tmp.tmp004 = l_isaj.isaj019 USING "&&&" , l_isaj.isaj020 USING "&&"
      #151013-00019#13 add end---
      
      
      #進項
      IF l_isaj.isaj018[1,1] = '2' THEN
         #24~31
         #5.買受人統編(8碼)
         LET l_tmp.tmp005 = l_isaj.isaj012 USING "&&&&&&&&"

         CASE
            WHEN l_isaj.isaj018 MATCHES '2[89]'
               #32~35空白
               #36~39海關代徵營業稅繳納證號碼
               LET l_tmp.tmp006 = l_tmp.tmp006 USING "####"
               LET l_tmp.tmp007 = l_isaj.isaj008[1,4]
            WHEN l_isaj.isaj018 = '26' OR l_isaj.isaj018 = '27'
               #32~39
               #進項26、27彙加>>8.彙總張數(4碼)+空白(4碼)
               LET l_tmp.tmp006 = l_sum_count USING "&&&&"
               LET l_tmp.tmp007 = l_tmp.tmp007
               LET l_sum_count = 0
            WHEN l_isaj.isaj017 = 'A' AND l_isaj.isaj103 <> 0
               #32~39
               #進項彙總>>8.彙總張數(4碼)+空白(4碼)
               #這裡要把最後一張發票加進來
               LET l_sum_count = l_sum_count + 1
               LET l_tmp.tmp006 = l_sum_count USING "&&&&"
               LET l_tmp.tmp007 = l_tmp.tmp007
               #最後在清空為0繼續記錄下一批同一筆交易的發票張數
               LET l_sum_count = 0
            OTHERWISE
               #32~39
               #進項無彙總>>8.銷售人統一編號(8碼)
               LET l_tmp.tmp006 = l_isaj.isaj010[1,4] USING "&&&&"
               LET l_tmp.tmp007 = l_isaj.isaj010[5,8]
         END CASE
      #銷項
      ELSE
         IF l_isaj.isaj017 = 'A' AND l_isaj.isaj103 <> 0 AND l_isaj.isaj015 <> 'D' THEN
            #24~31
            #銷項憑證屬彙加資料者，則表示為彙加資料連續發票之訖號(8碼)
            LET l_tmp.tmp005 = l_isaj.isaj006[3,10] USING "########"
         ELSE
            IF l_isaj.isaj018 = "32" THEN
               #24~31
               #銷項這裡給空白(8碼)
               LET l_tmp.tmp005 = l_tmp.tmp005 USING "########"
            ELSE
               #24~31
               #給買受人統一編號(8碼)
              #LET l_tmp.tmp005 = l_isaj.isaj012 USING "&&&&&&&&"       #150925 mark
               LET l_tmp.tmp005 = l_isaj.isaj012[1,8] USING "&&&&&&&&"  #150925
            END IF
         END IF
         
         #32~39
         #銷項>>我們家的統編
         LET l_tmp.tmp006 = p_isaa002[1,4] USING "&&&&"
         LET l_tmp.tmp007 = p_isaa002[5,8]
      END IF
      
      
      #40~49
      #彙加資料 >> #10.彙加資料之發票起始號碼之3-10碼(8碼) ELSE >> 10.發票號碼(8碼)(進項彙總也取最後一張)
      IF l_isaj.isaj018 NOT MATCHES '2[89]' THEN
         IF l_isaj.isaj017 = 'A' AND (l_isaj.isaj103 <> 0 OR l_isaj.isaj015 = 'D') AND l_isaj.isaj018[1,1] = '3' THEN
            #若空的表示該筆媒體資料是彙總，但只有一筆而已
            IF cl_null(l_first_isaj006) THEN LET l_first_isaj006 = l_isaj.isaj006 END IF
            
            LET l_tmp.tmp008 = l_first_isaj006[1,2]
            LET l_tmp.tmp009 = l_first_isaj006[3,10]
            #表示已抓到同一筆交易的最後一張發票，需清空繼續記錄下一筆交易
            LET l_first_isaj006 = ""
         ELSE
            #9.發票字軌(2碼)
            LET l_tmp.tmp008 = l_isaj.isaj006[1,2]
            LET l_tmp.tmp009 = l_isaj.isaj006[3,10]
         END IF
      ELSE
         #36~49海關代徵營業稅繳納證號碼
         LET l_tmp.tmp008 = l_isaj.isaj008[5,6]
         LET l_tmp.tmp009 = l_isaj.isaj008[7,14]
      END IF
      
      #50~61
      #13.銷售金額/營業稅稅基(12碼)
      #63~72
      #營業稅額(10碼)
      LET l_tmp.tmp010 = " "
      LET l_tmp.tmp012 = " "
      CASE
        #WHEN l_isaj.isaj018 MATCHES '2[1345689]' OR l_isaj.isaj018 MATCHES '3[38]'  #151207-00018#5 mark
         WHEN l_isaj.isaj018 MATCHES '2[12345689]' OR l_isaj.isaj018 MATCHES '3[38]' #151207-00018#5
            LET l_tmp.tmp010 = l_isaj.isaj103 USING "&&&&&&&&&&&&"
            LET l_tmp.tmp012 = l_isaj.isaj104 USING "&&&&&&&&&&"
        #WHEN l_isaj.isaj018 MATCHES '2[27]' OR l_isaj.isaj018 MATCHES '3[267]' #151207-00018#5 mark
         WHEN l_isaj.isaj018 MATCHES '2[7]' OR l_isaj.isaj018 MATCHES '3[267]'  #151207-00018#5
            LET l_tmp.tmp010 = l_isaj.isaj105 USING "&&&&&&&&&&&&"
            LET l_tmp.tmp012 = " "
         WHEN l_isaj.isaj018 MATCHES "3[4]"
            LET l_tmp.tmp010 = l_isaj.isaj105 USING "&&&&&&&&&&&&"
            LET l_tmp.tmp012 = l_isaj.isaj104 USING "&&&&&&&&&&"
         WHEN l_isaj.isaj018 MATCHES "3[15]"
            IF l_isaj.isaj017 = 'A' THEN
               LET l_tmp.tmp010 = l_isaj.isaj105 USING "&&&&&&&&&&&&"
               LET l_tmp.tmp012 = " "
            ELSE
               LET l_tmp.tmp010 = l_isaj.isaj103 USING "&&&&&&&&&&&&"
               LET l_tmp.tmp012 = l_isaj.isaj104 USING "&&&&&&&&&&"
            END IF
      END CASE
      IF cl_null(l_tmp.tmp010) THEN LET l_tmp.tmp010 = l_tmp.tmp010 USING "&&&&&&&&&&&&" END IF
      IF cl_null(l_tmp.tmp012) THEN LET l_tmp.tmp012 = l_tmp.tmp012 USING "&&&&&&&&&&" END IF
      
      #62
      #課稅別(1碼)
      LET l_tmp.tmp011 = l_isaj.isaj015
      
      
      #73
      #扣抵代號(1碼)
      LET l_tmp.tmp013 = l_isaj.isaj014
      
      
      #74~78
      #空白(5碼)
      LET l_tmp.tmp014 = l_tmp.tmp014
      
      
      #79
      #特種稅額稅率(1碼)>>空白
      LET l_tmp.tmp015 = l_tmp.tmp015
      
      
      #80
      #彙加註記(1碼)
      LET l_tmp.tmp016 = l_isaj.isaj017
      
      
      #81
      #通關方式註記(1碼)
      LET l_tmp.tmp017 = l_isaj.isaj024
      
      
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012,l_tmp.tmp013,l_tmp.tmp014,l_tmp.tmp015,
                     l_tmp.tmp016,l_tmp.tmp017
      CALL ch.write(l_in_txt)
      LET l_num = l_num + 1
      LET r_write = "Y"
      
   END FOREACH
   
   
   
   #空白發票
   #若是空白發票則只抓每本發票簿最後一張發票來產生資料>>走銷項無彙總
   LET l_sql = "SELECT isaj001,isaj003,isaj004,isaj006,isaj010,",
               "       isaj012,isaj014,isaj015,isaj016,isaj017,",
               "       isaj018,isaj019,isaj020,isaj024,isaj031,",
               "       isaj103,isaj104,isaj105,isaa002",
               "  FROM isaj_t",
               "  LEFT JOIN isaa_t ON isajent = isaaent AND isaj003 = isaa001",
               " WHERE isajent = ",g_enterprise,
               "   AND isajstus='Y'",
               #"   AND isaj019 = ",p_isaa012," AND isaj020 BETWEEN ",p_isaa013," AND ",p_isaa013_2, #150422-00012#3 mark
               "   AND isaj019 = ",p_isaa012," AND isaj020 = ",p_isaa013, #150422-00012#3
               "   AND isaj015 = 'D' ",
               "   AND EXISTS(SELECT 1 FROM  isae_t WHERE isajent = isaeent AND isaj031 = isae001 AND isaestus='Y'  AND isaj006 LIKE '%'||isae010)",
               "   AND ",l_wc,
               " ORDER BY isaj018,isaj003,isaj006"
   PREPARE isaj_pb3 FROM l_sql
   DECLARE isaj_cs3 CURSOR FOR isaj_pb3
   FOREACH isaj_cs3 INTO l_isaj.isaj001,l_isaj.isaj003,l_isaj.isaj004,l_isaj.isaj006,l_isaj.isaj010,
                         l_isaj.isaj012,l_isaj.isaj014,l_isaj.isaj015,l_isaj.isaj016,l_isaj.isaj017,
                         l_isaj.isaj018,l_isaj.isaj019,l_isaj.isaj020,l_isaj.isaj024,l_isaj.isaj031,
                         l_isaj.isaj103,l_isaj.isaj104,l_isaj.isaj105,l_isaa.isaa002
      
      INITIALIZE l_tmp.* TO NULL
      
      #1~2
      #1.申報格式(2碼)
      LET l_tmp.tmp001 = l_isaj.isaj018
      
      
      #3~11
      #2.稅籍編號(9碼)
      LET l_tmp.tmp002 = l_isaa.isaa002
      
      
      #12~18
      #3.流水號(7碼)
      LET l_tmp.tmp003 = l_num USING "&&&&&&&"
      
      
      #19~23
      #4.資料所屬年月(5碼)
      #年要轉成民國年
      LET l_isaj.isaj019 = l_isaj.isaj019 - 1911
      LET l_tmp.tmp004 = l_isaj.isaj019 USING "&&&" , l_isaj.isaj020 USING "&&"
      
      
      #24~31
      #銷項無彙總這裡給空白(8碼)
      LET l_tmp.tmp005 = l_tmp.tmp005 USING "########"
      
      
      #32~39
      #銷項>>我們家的統編
      LET l_tmp.tmp006 = p_isaa002[1,4] USING "####"
      LET l_tmp.tmp007 = p_isaa002[5,8]
   
      
      #40~49
      #9.發票字軌(2碼)
      LET l_tmp.tmp008 = l_isaj.isaj006[1,2]
      LET l_tmp.tmp009 = l_isaj.isaj006[3,10]
   
      
      #50~61
      #13.銷售金額/營業稅稅基(未稅金額)(12碼)isaj104
      LET l_tmp.tmp010 = " "
      IF l_isaj.isaj012 IS NULL THEN
         LET l_tmp.tmp010 = l_isaj.isaj103 USING "&&&&&&&&&&&&"
      ELSE
         #買受人為營業人
         IF l_isaj.isaj018[1,1] ='3' AND l_isaj.isaj018 <> '32' AND l_isaj.isaj018 <> '34' THEN
            LET l_tmp.tmp010 = (l_isaj.isaj105/(1+l_isaj.isaj016/100)) USING "&&&&&&&&&&&&"
         END IF
      END IF
      IF cl_null(l_tmp.tmp010) THEN LET l_tmp.tmp010 = l_tmp.tmp010 USING "&&&&&&&&&&&&" END IF
      
      
      #62
      #課稅別(1碼)
      LET l_tmp.tmp011 = l_isaj.isaj015
      
      
      #63~72
      #營業稅額(10碼)
      LET l_tmp.tmp012 = " "
      LET l_tmp.tmp012 = l_isaj.isaj104 USING "&&&&&&&&&&"
      IF cl_null(l_tmp.tmp012) THEN LET l_tmp.tmp012 = l_tmp.tmp012 USING "&&&&&&&&&&" END IF
      
      
      #73
      #扣抵代號(1碼)
      LET l_tmp.tmp013 = l_isaj.isaj014
      
      
      #74~78
      #空白(5碼)
      LET l_tmp.tmp014 = l_tmp.tmp014
      
      
      #79
      #特種稅額稅率(1碼)>>空白
      LET l_tmp.tmp015 = l_tmp.tmp015
      
      
      #80
      #彙加註記(1碼)
      LET l_tmp.tmp016 = l_isaj.isaj017
      
      
      #81
      #通關方式註記(1碼)
      LET l_tmp.tmp017 = l_isaj.isaj024
      
      
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012,l_tmp.tmp013,l_tmp.tmp014,l_tmp.tmp015,
                     l_tmp.tmp016,l_tmp.tmp017
      CALL ch.write(l_in_txt)
      LET l_num = l_num + 1
      LET r_write = "Y"
   
   END FOREACH
   
   
   #存放TXT part2 start----------
   #這裡要轉換成DOS格式
   LET l_cmd = "awk 'sub(\"$\", \"\\r\")' ", l_file_name, " > ", l_file_name2
   RUN l_cmd
   
   #取得user要存放TXT的路徑(user電腦端)
   LET ls_target_file = os.Path.join(g_dir CLIPPED,l_file_name2 CLIPPED)
   
   #取得存放TXT端的路徑(伺服器端)
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name2 CLIPPED)
   
   #EXAMPLE:CALL FGL_PUTFILE(ls_source_file,"C:\\Users\\bartscott\\Desktop\\5.1/aaa.txt.2")
   CALL FGL_PUTFILE(ls_source_file,ls_target_file)
   CALL ch.close() 
   #存放TXT part2 end------------
   
   RETURN r_success,r_write
END FUNCTION

################################################################################
# Descriptions...: 營業人零稅率銷售額資料檔(T02)
# Memo...........: #150224-00005#30
# Usage..........: CALL aisp430_catch_isaj_t02()
#                : p_isaa001   申報單位
#                : p_isaa002   申報單位的稅務編號
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_chk2      彙總申報Y:是N:否
# Date & Author..: 2015/06/19 端午節耶 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_catch_isaj_t02(p_isaa001,p_isaa002,p_isaa012,p_isaa013,p_chk2)
DEFINE p_isaa001       LIKE isaa_t.isaa001
DEFINE p_isaa002       LIKE isaa_t.isaa002
DEFINE p_isaa012       LIKE isaa_t.isaa012
DEFINE p_isaa013       LIKE isaa_t.isaa013
DEFINE p_chk2          LIKE isaa_t.isaa017
DEFINE l_sql           STRING
DEFINE l_wc            STRING
DEFINE l_tmp           RECORD
            tmp001        CHAR(8),
            tmp002        CHAR(1),
            tmp003        CHAR(9),
            tmp004        STRING,
            tmp005        STRING,
            tmp006        CHAR(10),
            tmp007        CHAR(8),
            tmp008        CHAR(1),
            tmp009        CHAR(1),
            tmp010        CHAR(2),
            tmp011        CHAR(14),
            tmp012        STRING,
            tmp013        STRING
                       END RECORD
DEFINE l_isaj          RECORD
            isaj006       LIKE isaj_t.isaj006,
            isaj009       LIKE isaj_t.isaj009,
            isaj012       LIKE isaj_t.isaj012,
            isaj019       LIKE isaj_t.isaj019,
            isaj020       LIKE isaj_t.isaj020,
            isaj022       LIKE isaj_t.isaj022,
            isaj023       LIKE isaj_t.isaj023,
            isaj024       LIKE isaj_t.isaj024,
            isaj027       LIKE isaj_t.isaj027,
            isaj028       LIKE isaj_t.isaj028,
            isaj105       LIKE isaj_t.isaj105,
            isaa002       LIKE isaa_t.isaa002,
            isaa027       LIKE isaa_t.isaa027,
            ooef002       LIKE ooef_t.ooef002
                       END RECORD
DEFINE l_year          LIKE type_t.num5
DEFINE l_in_txt        STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_write         LIKE type_t.chr1
#存放TXT-----
DEFINE l_name          LIKE type_t.chr20
DEFINE ch              base.Channel
DEFINE l_file_name     STRING
DEFINE l_file_name2    STRING
DEFINE ls_target_file  STRING
DEFINE ls_source_file  STRING
DEFINE l_cmd           STRING
#存放TXT-----

   LET r_success = TRUE
   LET r_write = 'N'

   #存放TXT part1 start----------
   #檔案名稱default統一編號
   LET l_name = p_isaa002
   #取得暫時存放TXT的路徑(TEMPDIR)
   LET l_file_name = l_name,'orig.T02'  #原始檔案
   LET l_file_name2 = l_name,'.T02'     #轉成DOS格式的檔案
   
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED)
   LET ch = base.Channel.create()
   CALL ch.openFile(ls_source_file,"w")
   CALL ch.setDelimiter("")
   #存放TXT part1 end------------
   
   #抓取申報單位範圍
   IF p_chk2 = "Y" THEN #表示有很多家要彙總申報(總機構代碼isaa009=申報單位)
      LET l_wc = " (isaj003 = '",p_isaa001,"' OR isaa009 = '",p_isaa001,"')"
   ELSE
      LET l_wc = " isaj003 = '",p_isaa001,"'"
   END IF
      
   LET l_sql = "SELECT isaj006,isaj009,isaj012,isaj019,isaj020,",
               "       isaj022,isaj023,isaj024,isaj027,isaj028,",
               "       isaj105,isaa002,isaa027,ooef002",
               "  FROM isaj_t",
               "  LEFT JOIN isaa_t ON isajent = isaaent AND isaj003 = isaa001",
               "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
               " WHERE isajent = ",g_enterprise,
               "   AND isajstus='Y'",
               "   AND isaj019 = ",p_isaa012," AND isaj020 = ",p_isaa013,
               "   AND isaj033 = '3' ",  #3.零稅率銷項發票
               "   AND ",l_wc,
               " ORDER BY isaj018,isaj003,isaj006"
   PREPARE isaj_pb_t02 FROM l_sql
   DECLARE isaj_cs_t02 CURSOR FOR isaj_pb_t02
   FOREACH isaj_cs_t02 INTO l_isaj.isaj006,l_isaj.isaj009,l_isaj.isaj012,l_isaj.isaj019,l_isaj.isaj020,
                            l_isaj.isaj022,l_isaj.isaj023,l_isaj.isaj024,l_isaj.isaj027,l_isaj.isaj028,
                            l_isaj.isaj105,l_isaj.isaa002,l_isaj.isaa027,l_isaj.ooef002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #1-8：銷售人統一編號(8碼)
      LET l_tmp.tmp001 = l_isaj.ooef002
      
      
      #9：銷售人縣市別(1碼)
      LET l_tmp.tmp002 = l_isaj.isaa027
      
      
      #10-18：銷售人稅籍編號(9碼)
      LET l_tmp.tmp003 = l_isaj.isaa002
      
      
      #19-23：資料所屬年月isaj019 -1911 民國年+ isaj020(5)
      #年要轉成民國年
      LET l_isaj.isaj019 = l_isaj.isaj019 - 1911
      LET l_tmp.tmp004 = l_isaj.isaj019 USING "&&&" , l_isaj.isaj020 USING "&&"
      
      
      #24-28：開立發票年月(5碼)
      #年要轉成民國年
      LET l_year = (YEAR(l_isaj.isaj009)) -1911
      LET l_tmp.tmp005 = l_year USING "&&&" , MONTH(l_isaj.isaj009) USING "&&"
      
      
      #29-38：字軌號碼(10碼)
      LET l_tmp.tmp006 = l_isaj.isaj006
      
      
      #39-46：買受人統一編號(8碼)
      LET l_tmp.tmp007 = l_isaj.isaj012
      
      
      #47：適用零稅率規定(1碼)
      LET l_tmp.tmp008 = l_isaj.isaj023
      
      
      #48：通關方式註記(1碼)
      LET l_tmp.tmp009 = l_isaj.isaj024
      
      
      #49-50：出口報單類別(2碼)
      LET l_tmp.tmp010 = l_isaj.isaj027
      
      
      #51-64：出口報單號碼(14碼)
      LET l_tmp.tmp011 = l_isaj.isaj028
      
      
      #65-76：金額(12碼)
      LET l_tmp.tmp012 = l_isaj.isaj105 USING "&&&&&&&&&&&&"
      
      
      #77-83：輸出或結匯日期(7碼)
      #換算成民國年
      LET l_year = ""
      LET l_year = (YEAR(l_isaj.isaj022)) - 1911
      LET l_tmp.tmp013 = l_year USING "&&&", MONTH(l_isaj.isaj022) USING "&&", DAY(l_isaj.isaj022) USING "&&"

      
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012,l_tmp.tmp013
      CALL ch.write(l_in_txt)
      LET r_write = "Y"
   
   END FOREACH
   
   
   #存放TXT part2 start----------
   #這裡要轉換成DOS格式
   LET l_cmd = "awk 'sub(\"$\", \"\\r\")' ", l_file_name, " > ", l_file_name2
   RUN l_cmd
   
   #取得user要存放TXT的路徑(user電腦端)
   LET ls_target_file = os.Path.join(g_dir CLIPPED,l_file_name2 CLIPPED)
   
   #取得存放TXT端的路徑(伺服器端)
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name2 CLIPPED)
   
   #EXAMPLE:CALL FGL_PUTFILE(ls_source_file,"C:\\Users\\bartscott\\Desktop\\5.1/aaa.txt.2")
   CALL FGL_PUTFILE(ls_source_file,ls_target_file)
   CALL ch.close() 
   #存放TXT part2 end------------
   
   RETURN r_success,r_write
END FUNCTION

################################################################################
# Descriptions...: 營業人申報固定資產退稅清單(T08)
# Memo...........: #150224-00005#30
# Usage..........: CALL aisp430_catch_isaj_t08()
#                : p_isaa001   申報單位
#                : p_isaa002   申報單位的稅務編號
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_chk2      彙總申報Y:是N:否
# Date & Author..: 2015/06/22 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_catch_isaj_t08(p_isaa001,p_isaa002,p_isaa012,p_isaa013,p_chk2)
DEFINE p_isaa001       LIKE isaa_t.isaa001
DEFINE p_isaa002       LIKE isaa_t.isaa002
DEFINE p_isaa012       LIKE isaa_t.isaa012
DEFINE p_isaa013       LIKE isaa_t.isaa013
DEFINE p_chk2          LIKE isaa_t.isaa017
DEFINE l_sql           STRING
DEFINE l_wc            STRING
DEFINE l_tmp           RECORD
            tmp001        CHAR(3),
            tmp002        CHAR(2),
            tmp003        CHAR(1),
            tmp004        CHAR(8),
            tmp005        CHAR(9),
            tmp006        CHAR(7),
            tmp007        CHAR(14),
            tmp008        STRING,
            tmp009        CHAR(12),
            tmp010        CHAR(12),
            tmp011        CHAR(10),
            tmp012        STRING
                       END RECORD
DEFINE l_iscc          RECORD
            iscc001       LIKE iscc_t.iscc001,
            iscc002       LIKE iscc_t.iscc002,
            iscc005       LIKE iscc_t.iscc005,
            iscc006       LIKE iscc_t.iscc006,
            iscc007       LIKE iscc_t.iscc007,
            iscc008       LIKE iscc_t.iscc008,
            iscc009       LIKE iscc_t.iscc009,
            iscc010       LIKE iscc_t.iscc010,
            iscc103       LIKE iscc_t.iscc103,
            iscc104       LIKE iscc_t.iscc104,
            isaa002       LIKE isaa_t.isaa002,
            isaa027       LIKE isaa_t.isaa027,
            ooef002       LIKE ooef_t.ooef002
                       END RECORD
DEFINE l_year          LIKE type_t.num5
DEFINE l_in_txt        STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_write         LIKE type_t.chr1
#存放TXT-----
DEFINE l_name          LIKE type_t.chr20
DEFINE ch              base.Channel
DEFINE l_file_name     STRING
DEFINE l_file_name2    STRING
DEFINE ls_target_file  STRING
DEFINE ls_source_file  STRING
DEFINE l_cmd           STRING
#存放TXT-----

   LET r_success = TRUE
   LET r_write = 'N'

   #存放TXT part1 start----------
   #檔案名稱default統一編號
   LET l_name = p_isaa002
   #取得暫時存放TXT的路徑(TEMPDIR)
   LET l_file_name = l_name,'orig.T08'  #原始檔案
   LET l_file_name2 = l_name,'.T08'     #轉成DOS格式的檔案
   
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED)
   LET ch = base.Channel.create()
   CALL ch.openFile(ls_source_file,"w")
   CALL ch.setDelimiter("")
   #存放TXT part1 end------------
   
   #抓取申報單位範圍
   IF p_chk2 = "Y" THEN #表示有很多家要彙總申報(總機構代碼isaa009=申報單位)
      LET l_wc = " (isccsite = '",p_isaa001,"' OR isaa009 = '",p_isaa001,"')"
   ELSE
      LET l_wc = " isccsite = '",p_isaa001,"'"
   END IF
   
   LET l_sql = "SELECT iscc001,iscc002,iscc005,iscc006,iscc007,",
               "       iscc008,iscc009,iscc010,iscc103,iscc104,",
               "       isaa002,isaa027,ooef002",
               "  FROM iscc_t",
               "  LEFT JOIN isaa_t ON isccent = isaaent AND isccsite = isaa001",
               "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
               " WHERE isccent = ",g_enterprise,
               "   AND isccstus='Y'",
               "   AND iscc001 = ",p_isaa012," AND iscc002 = ",p_isaa013,
               "   AND ",l_wc,
               " ORDER BY iscc003,isccsite,iscc005"
   PREPARE iscc_pb_t08 FROM l_sql
   DECLARE iscc_cs_t08 CURSOR FOR iscc_pb_t08
   FOREACH iscc_cs_t08 INTO l_iscc.iscc001,l_iscc.iscc002,l_iscc.iscc005,l_iscc.iscc006,l_iscc.iscc007,
                            l_iscc.iscc008,l_iscc.iscc009,l_iscc.iscc010,l_iscc.iscc103,l_iscc.iscc104,
                            l_iscc.isaa002,l_iscc.isaa027,l_iscc.ooef002 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #1-3：所屬年度(3碼)
      #換算成民國年
      LET l_tmp.tmp001 = l_iscc.iscc001 - 1911
      LET l_tmp.tmp001 = l_tmp.tmp001 USING "&&&"
      
      
      #4-5：所屬月份(2碼)
      LET l_tmp.tmp002 = l_iscc.iscc002 USING "&&"
      
      
      #6-6：縣市別(1碼)
      LET l_tmp.tmp003 = l_iscc.isaa027
      
      
      #7-14：統一編號(8碼)
      LET l_tmp.tmp004 = l_iscc.ooef002
      
      
      #15-23：稅籍編號(9碼)
      LET l_tmp.tmp005 = l_iscc.isaa002
      
      
      #24-30：進項憑證日期(7碼)
      #換算成民國年
      LET l_year = ""
      LET l_year = (YEAR(l_iscc.iscc006)) - 1911
      LET l_tmp.tmp006 = l_year USING "&&&", MONTH(l_iscc.iscc006) USING "&&", DAY(l_iscc.iscc006) USING "&&"
      
      
      #31-40：進項憑證號碼(1碼)
      IF NOT cl_null(l_iscc.iscc005) THEN
         LET l_tmp.tmp007 = l_iscc.iscc005  #發票號碼
      ELSE
         LET l_tmp.tmp007 = l_iscc.iscc007  #海關代徵營業稅繳納證號碼
      END IF
      
      #41-190：內容摘要名稱(150碼)
      CALL aisp430_convert(150,l_iscc.iscc008) RETURNING l_tmp.tmp008
      
      
      #191-202：內容摘要數量(12碼)
      LET l_tmp.tmp009 = l_iscc.iscc009 USING "&&&&&&&&&&&&"
      
      
      #203-214：內容摘要金額(不含稅)(12碼)
      LET l_tmp.tmp010 = l_iscc.iscc103 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp010,"T08","") RETURNING g_sub_success,l_tmp.tmp010
      
      
      #215-224：內容摘要稅額(10碼)
      LET l_tmp.tmp011 = l_iscc.iscc104 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp011,"T08","") RETURNING g_sub_success,l_tmp.tmp011
      
      
      #225-524：用途(300碼)
      CALL aisp430_convert(300,l_iscc.iscc010) RETURNING l_tmp.tmp012
      
      
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012
      CALL ch.write(l_in_txt)
      LET r_write = "Y"
      
   END FOREACH
   
   
   #存放TXT part2 start----------
   #轉成BIG-5+轉換成DOS格式
   LET l_cmd = "iconv -c -f UTF-8 -t BIG-5  ",l_file_name ,"|awk 'sub(\"$\", \"\\r\")' >",l_file_name2 
   RUN l_cmd
   
   #取得user要存放TXT的路徑(user電腦端)
   LET ls_target_file = os.Path.join(g_dir CLIPPED,l_file_name2 CLIPPED)
   
   #取得存放TXT端的路徑(伺服器端)
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name2 CLIPPED)
   
   #EXAMPLE:CALL FGL_PUTFILE(ls_source_file,"C:\\Users\\bartscott\\Desktop\\5.1/aaa.txt.2")
   CALL FGL_PUTFILE(ls_source_file,ls_target_file)
   CALL ch.close() 
   #存放TXT part2 end------------
   
   RETURN r_success,r_write
END FUNCTION

################################################################################
# Descriptions...: 營業人直接扣抵檔(T01)
# Memo...........: #150518-00039#3
# Usage..........: CALL aisp430_catch_isaj_t01()
#                : p_isaa001   申報單位
#                : p_isaa002   申報單位的稅務編號
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_chk2      彙總申報Y:是N:否
# Date & Author..: 2015/07/01 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_catch_isaj_t01(p_isaa001,p_isaa002,p_isaa012,p_isaa013,p_chk2)
DEFINE p_isaa001       LIKE isaa_t.isaa001
DEFINE p_isaa002       LIKE isaa_t.isaa002
DEFINE p_isaa012       LIKE isaa_t.isaa012
DEFINE p_isaa013       LIKE isaa_t.isaa013
DEFINE p_chk2          LIKE isaa_t.isaa017
DEFINE l_sql           STRING
DEFINE l_wc            STRING
DEFINE l_tmp           RECORD
            tmp001        CHAR(8),
            tmp002        CHAR(5),
            tmp003        CHAR(1),
            tmp004        CHAR(10),
            tmp005        CHAR(10),
            tmp006        CHAR(10),
            tmp007        CHAR(10),
            tmp008        CHAR(10),
            tmp009        CHAR(10),
            tmp010        CHAR(10),
            
            tmp011        CHAR(10),
            tmp012        CHAR(10),
            tmp013        CHAR(10),
            tmp014        CHAR(10),
            tmp015        CHAR(10),
            tmp016        CHAR(10),
            tmp017        CHAR(10),
            tmp018        CHAR(10),
            tmp019        CHAR(10),
            tmp020        CHAR(10),
            
            tmp021        CHAR(10),
            tmp022        CHAR(10),
            tmp023        CHAR(10),
            tmp024        CHAR(10),
            tmp025        CHAR(10),
            tmp026        CHAR(10),
            tmp027        CHAR(10),
            tmp028        CHAR(10),
            tmp029        CHAR(10),
            tmp030        CHAR(10),
            
            tmp031        CHAR(10),
            tmp032        CHAR(10),
            tmp033        CHAR(10),
            tmp034        CHAR(10),
            tmp035        CHAR(10),
            tmp036        CHAR(10),
            tmp037        CHAR(10),
            tmp038        CHAR(10),
            tmp039        CHAR(10),
            tmp040        CHAR(10),
            
            tmp041        CHAR(10),
            tmp042        CHAR(10),
            tmp043        CHAR(10),
            tmp044        CHAR(10),
            tmp045        CHAR(10),
            tmp046        CHAR(10),
            tmp047        CHAR(10),
            tmp048        CHAR(10),
            tmp049        CHAR(10),
            tmp050        CHAR(10),
            
            tmp051        CHAR(10),
            tmp052        CHAR(10),
            tmp053        CHAR(10),
            tmp054        CHAR(10),
            tmp055        CHAR(10),
            tmp056        CHAR(10),
            tmp057        CHAR(10),
            tmp058        CHAR(10),
            tmp059        CHAR(10),
            tmp060        CHAR(10),
            
            tmp061        CHAR(10),
            tmp062        CHAR(10),
            tmp063        CHAR(10),
            tmp064        CHAR(10),
            tmp065        CHAR(3),
            tmp066        CHAR(12),
            tmp067        CHAR(12),
            tmp068        CHAR(12),
            tmp069        CHAR(12),
            tmp070        CHAR(10),
            
            tmp071        CHAR(10),
            tmp072        CHAR(10),
            tmp073        CHAR(12),
            tmp074        CHAR(12),
            tmp075        CHAR(12),
            tmp076        CHAR(12),
            tmp077        CHAR(10),
            tmp078        CHAR(10),
            tmp079        CHAR(10),
            tmp080        CHAR(12),
            
            tmp081        CHAR(12),
            tmp082        CHAR(12),
            tmp083        CHAR(12),
            tmp084        CHAR(12),
            tmp085        CHAR(12),
            tmp086        CHAR(12),
            tmp087        CHAR(12),
            tmp088        CHAR(12),
            tmp089        CHAR(12),
            tmp090        CHAR(12),
            
            tmp091        CHAR(12),
            tmp092        CHAR(10),
            tmp093        CHAR(10),
            tmp094        CHAR(10),
            tmp095        CHAR(10),
            tmp096        CHAR(10),
            tmp097        CHAR(10),
            tmp098        CHAR(10),
            tmp099        CHAR(9),
            tmp100        CHAR(3)
                       END RECORD
DEFINE l_isca          RECORD
            l_cnt         LIKE type_t.num10,
            isca001       LIKE isca_t.isca001,
            isca002       LIKE isca_t.isca002,
            
            isca101       LIKE isca_t.isca101,
            isca102       LIKE isca_t.isca102,
            isca103       LIKE isca_t.isca103,
            isca104       LIKE isca_t.isca104,
            isca105       LIKE isca_t.isca105,
            isca106       LIKE isca_t.isca106,
            isca107       LIKE isca_t.isca107,
            isca108       LIKE isca_t.isca108,
            isca109       LIKE isca_t.isca109,
            isca110       LIKE isca_t.isca110,
            isca111       LIKE isca_t.isca111,
            isca112       LIKE isca_t.isca112,
            
            isca201       LIKE isca_t.isca201,
            isca202       LIKE isca_t.isca202,
            isca203       LIKE isca_t.isca203,
            isca204       LIKE isca_t.isca204,
            isca205       LIKE isca_t.isca205,
            isca206       LIKE isca_t.isca206,
            isca207       LIKE isca_t.isca207,
            isca208       LIKE isca_t.isca208,
            isca209       LIKE isca_t.isca209,
            isca210       LIKE isca_t.isca210,
            isca211       LIKE isca_t.isca211,
            isca212       LIKE isca_t.isca212,
            
            isca301       LIKE isca_t.isca301,
            isca302       LIKE isca_t.isca302,
            isca303       LIKE isca_t.isca303,
            isca304       LIKE isca_t.isca304,
            isca305       LIKE isca_t.isca305,
            isca306       LIKE isca_t.isca306,
            isca307       LIKE isca_t.isca307,
            isca308       LIKE isca_t.isca308,
            isca309       LIKE isca_t.isca309,
            isca310       LIKE isca_t.isca310,
            isca311       LIKE isca_t.isca311,
            isca312       LIKE isca_t.isca312,
            
            isca401       LIKE isca_t.isca401,
            isca402       LIKE isca_t.isca402,
            isca403       LIKE isca_t.isca403,
            isca404       LIKE isca_t.isca404,
            isca405       LIKE isca_t.isca405,
            isca406       LIKE isca_t.isca406,
            isca407       LIKE isca_t.isca407,
            isca408       LIKE isca_t.isca408,
            isca409       LIKE isca_t.isca409,
            isca410       LIKE isca_t.isca410,
            isca411       LIKE isca_t.isca411,
            isca412       LIKE isca_t.isca412,
            
            isca501       LIKE isca_t.isca501,
            isca502       LIKE isca_t.isca502,
            isca503       LIKE isca_t.isca503,
            isca504       LIKE isca_t.isca504,
            isca505       LIKE isca_t.isca505,
            isca506       LIKE isca_t.isca506,
            isca507       LIKE isca_t.isca507,
            isca508       LIKE isca_t.isca508,
            isca509       LIKE isca_t.isca509,
            isca510       LIKE isca_t.isca510,
            isca511       LIKE isca_t.isca511,
            isca512       LIKE isca_t.isca512,
            
            isca601       LIKE isca_t.isca601,
            isca602       LIKE isca_t.isca602,
            isca603       LIKE isca_t.isca603,
            isca604       LIKE isca_t.isca604,
            isca605       LIKE isca_t.isca605,
            isca606       LIKE isca_t.isca606,
            isca607       LIKE isca_t.isca607,
            isca608       LIKE isca_t.isca608,
            isca609       LIKE isca_t.isca609,
            isca610       LIKE isca_t.isca610,
            isca611       LIKE isca_t.isca611,
            isca612       LIKE isca_t.isca612,
                       
            isca701       LIKE isca_t.isca701,
            isca702       LIKE isca_t.isca702,
            isca703       LIKE isca_t.isca703,
            isca704       LIKE isca_t.isca704,
            isca705       LIKE isca_t.isca705,
            isca706       LIKE isca_t.isca706,
            isca707       LIKE isca_t.isca707,
            isca708       LIKE isca_t.isca708,
            
            isca801       LIKE isca_t.isca801,
            isca802       LIKE isca_t.isca802,
            isca803       LIKE isca_t.isca803,
            isca804       LIKE isca_t.isca804,
            isca805       LIKE isca_t.isca805,
            isca806       LIKE isca_t.isca806,
            isca807       LIKE isca_t.isca807,
            isca808       LIKE isca_t.isca808,
            isca809       LIKE isca_t.isca809,
            
            isaa002       LIKE isaa_t.isaa002,
            isaa008       LIKE isaa_t.isaa008,
            ooef002       LIKE ooef_t.ooef002
                       END RECORD
DEFINE l_value         LIKE type_t.chr1  #判斷正負 Y:正 N:負
DEFINE l_in_txt        STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_write         LIKE type_t.chr1
#存放TXT-----
DEFINE l_name          LIKE type_t.chr20
DEFINE ch              base.Channel
DEFINE l_file_name     STRING
DEFINE l_file_name2    STRING
DEFINE ls_target_file  STRING
DEFINE ls_source_file  STRING
DEFINE l_cmd           STRING
#存放TXT-----

   LET r_success = TRUE
   LET r_write = 'N'

   #存放TXT part1 start----------
   #檔案名稱default統一編號
   LET l_name = p_isaa002
   #取得暫時存放TXT的路徑(TEMPDIR)
   LET l_file_name = l_name,'orig.T01'  #原始檔案
   LET l_file_name2 = l_name,'.T01'     #轉成DOS格式的檔案
   
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED)
   LET ch = base.Channel.create()
   CALL ch.openFile(ls_source_file,"w")
   CALL ch.setDelimiter("")
   #存放TXT part1 end------------
   
   #彙總申報
   #若A總部幫B&C分公司代繳，那需產生3個T01檔：
   #第一個T01(2筆)：A+B+C匯總、A總部
   #第二個T01(1筆)：B公司
   #第三個T01(1筆)：C公司
   #但要執行三次aisp430產生，因為aisp430一次只能產生一間公司(國稅局軟體也是)
   IF p_chk2 = "Y" THEN
      LET l_sql = "SELECT '1' AS aa,",
                  "       SUM(isca101),SUM(isca102),SUM(isca103),SUM(isca104),SUM(isca105),",
                  "       SUM(isca106),SUM(isca107),SUM(isca108),SUM(isca109),SUM(isca110),",
                  "       SUM(isca111),SUM(isca112),",
                  "       SUM(isca201),SUM(isca202),SUM(isca203),SUM(isca204),SUM(isca205),",
                  "       SUM(isca206),SUM(isca207),SUM(isca208),SUM(isca209),SUM(isca210),",
                  "       SUM(isca211),SUM(isca212),",
                  "       SUM(isca301),SUM(isca302),SUM(isca303),SUM(isca304),SUM(isca305),",
                  "       SUM(isca306),SUM(isca307),SUM(isca308),SUM(isca309),SUM(isca310),",
                  "       SUM(isca311),SUM(isca312),",
                  "       SUM(isca401),SUM(isca402),SUM(isca403),SUM(isca404),SUM(isca405),",
                  "       SUM(isca406),SUM(isca407),SUM(isca408),SUM(isca409),SUM(isca410),",
                  "       SUM(isca411),SUM(isca412),",
                  "       SUM(isca501),SUM(isca502),SUM(isca503),SUM(isca504),SUM(isca505),",
                  "       SUM(isca506),SUM(isca507),SUM(isca508),SUM(isca509),SUM(isca510),",
                  "       SUM(isca511),SUM(isca512),",
                  "       SUM(isca601),SUM(isca602),SUM(isca603),SUM(isca604),SUM(isca605),",
                  "       SUM(isca606),SUM(isca607),SUM(isca608),SUM(isca609),SUM(isca610),",
                  "       SUM(isca611),SUM(isca612),",
                  "       SUM(isca701),SUM(isca702),SUM(isca703),SUM(isca704),SUM(isca705),",
                  "       SUM(isca706),SUM(isca707),SUM(isca708),",
                  "       SUM(isca801),SUM(isca802),SUM(isca803),SUM(isca804),SUM(isca805),",
                  "       SUM(isca806),SUM(isca807),SUM(isca808),SUM(isca809),",
                  "       '' AS isaa002,'' AS isaa008,'' AS ooef002",
                  "  FROM isca_t",
                  "  LEFT JOIN isaa_t ON iscaent = isaaent AND iscasite = isaa001",
                  "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                  " WHERE iscaent = ",g_enterprise,
                  "   AND iscastus='Y'",
                  "   AND isca001 = ",p_isaa012," AND isca002 = ",p_isaa013,
                  "   AND ooef017 = '",p_isaa001,"'",
                  " GROUP BY ooef017 ",
                  " UNION ALL ",
                  "SELECT '2',",
                  "       isca101,isca102,isca103,isca104,isca105,",
                  "       isca106,isca107,isca108,isca109,isca110,",
                  "       isca111,isca112,",
                  "       isca201,isca202,isca203,isca204,isca205,",
                  "       isca206,isca207,isca208,isca209,isca210,",
                  "       isca211,isca212,",
                  "       isca301,isca302,isca303,isca304,isca305,",
                  "       isca306,isca307,isca308,isca309,isca310,",
                  "       isca311,isca312,",
                  "       isca401,isca402,isca403,isca404,isca405,",
                  "       isca406,isca407,isca408,isca409,isca410,",
                  "       isca411,isca412,",
                  "       isca501,isca502,isca503,isca504,isca505,",
                  "       isca506,isca507,isca508,isca509,isca510,",
                  "       isca511,isca512,",
                  "       isca601,isca602,isca603,isca604,isca605,",
                  "       isca606,isca607,isca608,isca609,isca610,",
                  "       isca611,isca612,",
                  "       isca701,isca702,isca703,isca704,isca705,",
                  "       isca706,isca707,isca708,",
                  "       isca801,isca802,isca803,isca804,isca805,",
                  "       isca806,isca807,isca808,isca809,",
                  "       isaa002,isaa008,ooef002",
                  "  FROM isca_t",
                  "  LEFT JOIN isaa_t ON iscaent = isaaent AND iscasite = isaa001",
                  "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                  " WHERE iscaent = ",g_enterprise,
                  "   AND iscastus='Y'",
                  "   AND isca001 = ",p_isaa012," AND isca002 = ",p_isaa013,
                  "   AND iscasite = '",p_isaa001,"'",
                  " ORDER BY aa ASC"
   ELSE
      LET l_sql = "SELECT '0',",
                  "       isca101,isca102,isca103,isca104,isca105,",
                  "       isca106,isca107,isca108,isca109,isca110,",
                  "       isca111,isca112,",
                  "       isca201,isca202,isca203,isca204,isca205,",
                  "       isca206,isca207,isca208,isca209,isca210,",
                  "       isca211,isca212,",
                  "       isca301,isca302,isca303,isca304,isca305,",
                  "       isca306,isca307,isca308,isca309,isca310,",
                  "       isca311,isca312,",
                  "       isca401,isca402,isca403,isca404,isca405,",
                  "       isca406,isca407,isca408,isca409,isca410,",
                  "       isca411,isca412,",
                  "       isca501,isca502,isca503,isca504,isca505,",
                  "       isca506,isca507,isca508,isca509,isca510,",
                  "       isca511,isca512,",
                  "       isca601,isca602,isca603,isca604,isca605,",
                  "       isca606,isca607,isca608,isca609,isca610,",
                  "       isca611,isca612,",
                  "       isca701,isca702,isca703,isca704,isca705,",
                  "       isca706,isca707,isca708,",
                  "       isca801,isca802,isca803,isca804,isca805,",
                  "       isca806,isca807,isca808,isca809,",
                  "       isaa002,isaa008,ooef002",
                  "  FROM isca_t",
                  "  LEFT JOIN isaa_t ON iscaent = isaaent AND iscasite = isaa001",
                  "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                  " WHERE iscaent = ",g_enterprise,
                  "   AND iscastus='Y'",
                  "   AND isca001 = ",p_isaa012," AND isca002 = ",p_isaa013,
                  "   AND iscasite = '",p_isaa001,"'"
   END IF
   
   PREPARE isca_pb_t01 FROM l_sql
   DECLARE isca_cs_t01 CURSOR FOR isca_pb_t01
   FOREACH isca_cs_t01 INTO l_isca.l_cnt,
                            l_isca.isca101,l_isca.isca102,l_isca.isca103,l_isca.isca104,l_isca.isca105,
                            l_isca.isca106,l_isca.isca107,l_isca.isca108,l_isca.isca109,l_isca.isca110,
                            l_isca.isca111,l_isca.isca112,
                            l_isca.isca201,l_isca.isca202,l_isca.isca203,l_isca.isca204,l_isca.isca205,
                            l_isca.isca206,l_isca.isca207,l_isca.isca208,l_isca.isca209,l_isca.isca210,
                            l_isca.isca211,l_isca.isca212,
                            l_isca.isca301,l_isca.isca302,l_isca.isca303,l_isca.isca304,l_isca.isca305,
                            l_isca.isca306,l_isca.isca307,l_isca.isca308,l_isca.isca309,l_isca.isca310,
                            l_isca.isca311,l_isca.isca312,
                            l_isca.isca401,l_isca.isca402,l_isca.isca403,l_isca.isca404,l_isca.isca405,
                            l_isca.isca406,l_isca.isca407,l_isca.isca408,l_isca.isca409,l_isca.isca410,
                            l_isca.isca411,l_isca.isca412,
                            l_isca.isca501,l_isca.isca502,l_isca.isca503,l_isca.isca504,l_isca.isca505,
                            l_isca.isca506,l_isca.isca507,l_isca.isca508,l_isca.isca509,l_isca.isca510,
                            l_isca.isca511,l_isca.isca512,
                            l_isca.isca601,l_isca.isca602,l_isca.isca603,l_isca.isca604,l_isca.isca605,
                            l_isca.isca606,l_isca.isca607,l_isca.isca608,l_isca.isca609,l_isca.isca610,
                            l_isca.isca611,l_isca.isca612,
                            l_isca.isca701,l_isca.isca702,l_isca.isca703,l_isca.isca704,l_isca.isca705,
                            l_isca.isca706,l_isca.isca707,l_isca.isca708,
                            l_isca.isca801,l_isca.isca802,l_isca.isca803,l_isca.isca804,l_isca.isca805,
                            l_isca.isca806,l_isca.isca807,l_isca.isca808,l_isca.isca809,
                            l_isca.isaa002,l_isca.isaa008,l_isca.ooef002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #第一筆匯總需撈取總申報單位的相關訊息
      IF l_isca.l_cnt = 1 THEN
         LET l_sql = "SELECT isca001,isca002,",
                     "       isaa002,isaa008,ooef002",
                     "  FROM isca_t",
                     "  LEFT JOIN isaa_t ON iscaent = isaaent AND iscasite = isaa001",
                     "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                     " WHERE iscaent = ",g_enterprise,
                     "   AND iscastus='Y'",
                     "   AND isca001 = ",p_isaa012," AND isca002 = ",p_isaa013,
                     "   AND iscasite = '",p_isaa001,"'"
         PREPARE isca_pb_t012 FROM l_sql
         EXECUTE isca_pb_t012 INTO l_isca.isca001,l_isca.isca002,
                                   l_isca.isaa002,l_isca.isaa008,l_isca.ooef002
      ELSE
         LET l_isca.isca001 = p_isaa012
         LET l_isca.isca002 = p_isaa013
      END IF
      
      INITIALIZE l_tmp.* TO NULL
      
      #1-8：統一編號(8碼)
      LET l_tmp.tmp001 = l_isca.ooef002
      
      #9-13：所屬年度(5碼)
      #年要轉成民國年
      LET l_isca.isca001 = l_isca.isca001 - 1911
      LET l_tmp.tmp002 = l_isca.isca001 USING "&&&" , l_isca.isca002 USING "&&"
      
      #14：申報代號(1碼)
      #如果是總部匯總報繳，匯總的總繳代號是1，總部的總繳代號是2
      IF l_isca.l_cnt = 2 THEN LET l_isca.isaa008 = 2 END IF
      CASE
         WHEN l_isca.isaa008 MATCHES '[02]'
            LET l_tmp.tmp003 = "1"
         WHEN l_isca.isaa008 = "1"
            LET l_tmp.tmp003 = "5"
      END CASE
      
      
      #統一發票扣抵聯/進貨及費用
      #15-24：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca101) RETURNING g_sub_success,l_value
      LET l_tmp.tmp004 = l_isca.isca101 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp004,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp004
      
      #25-34：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca102) RETURNING g_sub_success,l_value
      LET l_tmp.tmp005 = l_isca.isca102 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp005,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp005
      
      #35-44：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca103) RETURNING g_sub_success,l_value
      LET l_tmp.tmp006 = l_isca.isca103 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp006,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp006
      
      #45-54：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca104) RETURNING g_sub_success,l_value
      LET l_tmp.tmp007 = l_isca.isca104 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp007,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp007
      
      #55-64：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca105) RETURNING g_sub_success,l_value
      LET l_tmp.tmp008 = l_isca.isca105 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp008,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp008
      
      #65-74：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca106) RETURNING g_sub_success,l_value
      LET l_tmp.tmp009 = l_isca.isca106 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp009,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp009
      
      
      
      #統一發票扣抵聯/固定資產
      #75-84：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca107) RETURNING g_sub_success,l_value
      LET l_tmp.tmp010 = l_isca.isca107 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp010,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp010
      
      #85-94：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca108) RETURNING g_sub_success,l_value
      LET l_tmp.tmp011 = l_isca.isca108 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp011,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp011
      
      #95-104：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca109) RETURNING g_sub_success,l_value
      LET l_tmp.tmp012 = l_isca.isca109 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp012,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp012
      
      #105-114：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca110) RETURNING g_sub_success,l_value
      LET l_tmp.tmp013 = l_isca.isca110 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp013,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp013
      
      #115-124：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca111) RETURNING g_sub_success,l_value
      LET l_tmp.tmp014 = l_isca.isca111 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp014,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp014
      
      #125-134：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca112) RETURNING g_sub_success,l_value
      LET l_tmp.tmp015 = l_isca.isca112 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp015,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp015
      
      
      
      #三聯式收銀機發票扣抵聯/進貨及費用
      #135-144：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca201) RETURNING g_sub_success,l_value
      LET l_tmp.tmp016 = l_isca.isca201 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp016,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp016
      
      #145-154：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca202) RETURNING g_sub_success,l_value
      LET l_tmp.tmp017 = l_isca.isca202 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp017,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp017
      
      #155-164：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca203) RETURNING g_sub_success,l_value
      LET l_tmp.tmp018 = l_isca.isca203 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp018,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp018
      
      #165-174：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca204) RETURNING g_sub_success,l_value
      LET l_tmp.tmp019 = l_isca.isca204 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp019,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp019
      
      #175-184：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca205) RETURNING g_sub_success,l_value
      LET l_tmp.tmp020 = l_isca.isca205 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp020,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp020
      
      #185-194：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca206) RETURNING g_sub_success,l_value
      LET l_tmp.tmp021 = l_isca.isca206 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp021,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp021
      
      
      
      #三聯式收銀機發票扣抵聯/固定資產
      #195-204：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca207) RETURNING g_sub_success,l_value
      LET l_tmp.tmp022 = l_isca.isca207 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp022,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp022
      
      #205-214：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca208) RETURNING g_sub_success,l_value
      LET l_tmp.tmp023 = l_isca.isca208 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp023,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp023
      
      #215-224：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca209) RETURNING g_sub_success,l_value
      LET l_tmp.tmp024 = l_isca.isca209 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp024,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp024
      
      #225-234：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca210) RETURNING g_sub_success,l_value
      LET l_tmp.tmp025 = l_isca.isca210 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp025,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp025
      
      #235-244：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca211) RETURNING g_sub_success,l_value
      LET l_tmp.tmp026 = l_isca.isca211 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp026,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp026
      
      #245-254：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca212) RETURNING g_sub_success,l_value
      LET l_tmp.tmp027 = l_isca.isca212 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp027,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp027
      
      
      
      #載有稅額之其他憑證/進貨及費用
      #255-264：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca301) RETURNING g_sub_success,l_value
      LET l_tmp.tmp028 = l_isca.isca301 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp028,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp028
      
      #265-274：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca302) RETURNING g_sub_success,l_value
      LET l_tmp.tmp029 = l_isca.isca302 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp029,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp029
      
      #275-284：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca303) RETURNING g_sub_success,l_value
      LET l_tmp.tmp030 = l_isca.isca303 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp030,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp030
      
      #285-294：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca304) RETURNING g_sub_success,l_value
      LET l_tmp.tmp031 = l_isca.isca304 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp031,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp031
      
      #295-304：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca305) RETURNING g_sub_success,l_value
      LET l_tmp.tmp032 = l_isca.isca305 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp032,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp032
      
      #305-314：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca306) RETURNING g_sub_success,l_value
      LET l_tmp.tmp033 = l_isca.isca306 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp033,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp033
      
      
      
      #載有稅額之其他憑證/固定資產
      #315-324：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca307) RETURNING g_sub_success,l_value
      LET l_tmp.tmp034 = l_isca.isca307 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp034,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp034
      
      #325-334：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca308) RETURNING g_sub_success,l_value
      LET l_tmp.tmp035 = l_isca.isca308 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp035,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp035
      
      #335-344：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca309) RETURNING g_sub_success,l_value
      LET l_tmp.tmp036 = l_isca.isca309 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp036,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp036
      
      #345-354：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca310) RETURNING g_sub_success,l_value
      LET l_tmp.tmp037 = l_isca.isca310 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp037,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp037
      
      #355-364：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca311) RETURNING g_sub_success,l_value
      LET l_tmp.tmp038 = l_isca.isca311 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp038,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp038
      
      #365-374：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca312) RETURNING g_sub_success,l_value
      LET l_tmp.tmp039 = l_isca.isca312 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp039,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp039
      
      
      
      #退出及折讓/進貨及費用
      #375-384：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca501) RETURNING g_sub_success,l_value
      LET l_tmp.tmp040 = l_isca.isca501 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp040,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp040
      
      #385-394：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca502) RETURNING g_sub_success,l_value
      LET l_tmp.tmp041 = l_isca.isca502 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp041,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp041
      
      #395-404：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca503) RETURNING g_sub_success,l_value
      LET l_tmp.tmp042 = l_isca.isca503 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp042,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp042
      
      #405-414：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca504) RETURNING g_sub_success,l_value
      LET l_tmp.tmp043 = l_isca.isca504 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp043,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp043
      
      #415-424：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca505) RETURNING g_sub_success,l_value
      LET l_tmp.tmp044 = l_isca.isca505 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp044,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp044
      
      #425-434：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca506) RETURNING g_sub_success,l_value
      LET l_tmp.tmp045 = l_isca.isca506 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp045,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp045
      
      
      
      #退出及折讓/固定資產
      #435-444：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca507) RETURNING g_sub_success,l_value
      LET l_tmp.tmp046 = l_isca.isca507 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp046,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp046
      
      #445-454：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca508) RETURNING g_sub_success,l_value
      LET l_tmp.tmp047 = l_isca.isca508 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp047,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp047
      
      #455-494：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca509) RETURNING g_sub_success,l_value
      LET l_tmp.tmp048 = l_isca.isca509 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp048,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp048
      
      #465-474：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca510) RETURNING g_sub_success,l_value
      LET l_tmp.tmp049 = l_isca.isca510 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp049,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp049
      
      #475-484：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca511) RETURNING g_sub_success,l_value
      LET l_tmp.tmp050 = l_isca.isca511 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp050,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp050
      
      #485-494：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca512) RETURNING g_sub_success,l_value
      LET l_tmp.tmp051 = l_isca.isca512 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp051,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp051
      
      
      
      #合計/進貨及費用
      #495-504：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca601) RETURNING g_sub_success,l_value
      LET l_tmp.tmp052 = l_isca.isca601 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp052,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp052
      
      #505-514：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca602) RETURNING g_sub_success,l_value
      LET l_tmp.tmp053 = l_isca.isca602 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp053,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp053
      
      #515-524：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca603) RETURNING g_sub_success,l_value
      LET l_tmp.tmp054 = l_isca.isca603 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp054,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp054
      
      #525-534：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca604) RETURNING g_sub_success,l_value
      LET l_tmp.tmp055 = l_isca.isca604 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp055,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp055
      
      #535-544：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca605) RETURNING g_sub_success,l_value
      LET l_tmp.tmp056 = l_isca.isca605 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp056,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp056
      
      #545-554：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca606) RETURNING g_sub_success,l_value
      LET l_tmp.tmp057 = l_isca.isca606 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp057,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp057
      
      
      
      #合計/固定資產
      #555-564：進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca607) RETURNING g_sub_success,l_value
      LET l_tmp.tmp058 = l_isca.isca607 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp058,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp058
      
      #565-574：專供課稅(含零稅率)營業用得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca608) RETURNING g_sub_success,l_value
      LET l_tmp.tmp059 = l_isca.isca608 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp059,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp059
      
      #575-584：供課稅及免稅營業共同使用之稅額小計(10碼)
      CALL aisp430_value_pn(l_isca.isca609) RETURNING g_sub_success,l_value
      LET l_tmp.tmp060 = l_isca.isca609 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp060,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp060
      
      #585-594：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca610) RETURNING g_sub_success,l_value
      LET l_tmp.tmp061 = l_isca.isca610 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp061,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp061
      
      #595-604：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca611) RETURNING g_sub_success,l_value
      LET l_tmp.tmp062 = l_isca.isca611 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp062,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp062
      
      #605-614：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca612) RETURNING g_sub_success,l_value
      LET l_tmp.tmp063 = l_isca.isca612 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp063,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp063
      
      
      
      #615-624：得扣抵進項稅額合計(10碼)
      CALL aisp430_value_pn(l_isca.isca808) RETURNING g_sub_success,l_value
      LET l_tmp.tmp064 = l_isca.isca808 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp064,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp064
      
      #625-627：不得扣抵比例(3碼)
      LET l_tmp.tmp065 = l_isca.isca809 USING "&&&"
      
      
      
      #海關代徵營業稅繳納證扣抵聯/進貨及費用
      #628-639：進項稅額合計(12碼)
      CALL aisp430_value_pn(l_isca.isca401) RETURNING g_sub_success,l_value
      LET l_tmp.tmp066 = l_isca.isca401 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp066,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp066
      
      #640-651：專供課稅(含零稅率)營業用得扣抵稅額(12碼)
      CALL aisp430_value_pn(l_isca.isca402) RETURNING g_sub_success,l_value
      LET l_tmp.tmp067 = l_isca.isca402 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp067,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp067
      
      #652-663：供課稅及免稅營業共同使用之稅額小計(12碼)
      CALL aisp430_value_pn(l_isca.isca403) RETURNING g_sub_success,l_value
      LET l_tmp.tmp068 = l_isca.isca403 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp068,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp068
      
      #664-675：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(12碼)
      CALL aisp430_value_pn(l_isca.isca404) RETURNING g_sub_success,l_value
      LET l_tmp.tmp069 = l_isca.isca404 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp069,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp069
      
      #676-685：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca405) RETURNING g_sub_success,l_value
      LET l_tmp.tmp070 = l_isca.isca405 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp070,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp070
      
      #686-695：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca406) RETURNING g_sub_success,l_value
      LET l_tmp.tmp071 = l_isca.isca406 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp071,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp071
      
      #696-705：空白(10碼)
      LET l_tmp.tmp072 = 0 USING "&&&&&&&&&&"
      
      
      
      #海關代徵營業稅繳納證扣抵聯/固定資產
      #706-717：進項稅額合計(12碼)
      CALL aisp430_value_pn(l_isca.isca407) RETURNING g_sub_success,l_value
      LET l_tmp.tmp073 = l_isca.isca407 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp073,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp073
      
      #718-729：專供課稅(含零稅率)營業用得扣抵稅額(12碼)
      CALL aisp430_value_pn(l_isca.isca408) RETURNING g_sub_success,l_value
      LET l_tmp.tmp074 = l_isca.isca408 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp074,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp074
      
      #730-741：供課稅及免稅營業共同使用之稅額小計(12碼)
      CALL aisp430_value_pn(l_isca.isca409) RETURNING g_sub_success,l_value
      LET l_tmp.tmp075 = l_isca.isca409 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp075,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp075
      
      #742-753：供課稅及免稅營業共同使用之稅額比例計算得扣抵稅額(12碼)
      CALL aisp430_value_pn(l_isca.isca410) RETURNING g_sub_success,l_value
      LET l_tmp.tmp076 = l_isca.isca410 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp076,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp076
      
      #754-763：供課稅及免稅營業共同使用之稅額比例計算不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca411) RETURNING g_sub_success,l_value
      LET l_tmp.tmp077 = l_isca.isca411 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp077,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp077
      
      #764-773：專供免稅營業使用不得扣抵稅額(10碼)
      CALL aisp430_value_pn(l_isca.isca412) RETURNING g_sub_success,l_value
      LET l_tmp.tmp078 = l_isca.isca412 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp078,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp078
      
      
      #774-783：空白(10碼)
      LET l_tmp.tmp079 = 0 USING "&&&&&&&&&&"
      #784-795：空白(12碼)
      LET l_tmp.tmp080 = 0 USING "&&&&&&&&&&&&"
      #796-807：空白(12碼)
      LET l_tmp.tmp081 = 0 USING "&&&&&&&&&&&&"
      #808-819：空白(12碼)
      LET l_tmp.tmp082 = 0 USING "&&&&&&&&&&&&"
      #820-831：空白(12碼)
      LET l_tmp.tmp083 = 0 USING "&&&&&&&&&&&&"
      
      
      #購買國外勞務/購買國外勞務給付額
      #832-843：合計(12碼)
      CALL aisp430_value_pn(l_isca.isca701) RETURNING g_sub_success,l_value
      LET l_tmp.tmp084 = l_isca.isca701 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp084,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp084
      #844-855：供免稅營業用(a)(12碼)
      CALL aisp430_value_pn(l_isca.isca702) RETURNING g_sub_success,l_value
      LET l_tmp.tmp085 = l_isca.isca702 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp085,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp085
      #856-867：供免稅營業用(b)(12碼)
      CALL aisp430_value_pn(l_isca.isca705) RETURNING g_sub_success,l_value
      LET l_tmp.tmp086 = l_isca.isca705 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp086,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp086
      #868-879：供免稅營業用(c)(12碼)
      CALL aisp430_value_pn(l_isca.isca706) RETURNING g_sub_success,l_value
      LET l_tmp.tmp087 = l_isca.isca706 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp087,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp087
      #880-891：供共同使用(d)(12碼)
      CALL aisp430_value_pn(l_isca.isca703) RETURNING g_sub_success,l_value
      LET l_tmp.tmp088 = l_isca.isca703 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp088,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp088
      #892-903：供共同使用(e)(12碼)
      CALL aisp430_value_pn(l_isca.isca707) RETURNING g_sub_success,l_value
      LET l_tmp.tmp089 = l_isca.isca707 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp089,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp089
      #904-915：供共同使用(f)(12碼)
      CALL aisp430_value_pn(l_isca.isca708) RETURNING g_sub_success,l_value
      LET l_tmp.tmp090 = l_isca.isca708 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp090,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp090
      #916-927：供課稅營業用(12碼)
      CALL aisp430_value_pn(l_isca.isca704) RETURNING g_sub_success,l_value
      LET l_tmp.tmp091 = l_isca.isca704 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp091,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp091
      
      
      
      #應納營業稅額
      #928-937：合計(10碼)
      CALL aisp430_value_pn(l_isca.isca805) RETURNING g_sub_success,l_value
      LET l_tmp.tmp092 = l_isca.isca805 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp092,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp092
      #938-947：供免稅營業用(g)1%(10碼)
      CALL aisp430_value_pn(l_isca.isca806) RETURNING g_sub_success,l_value
      LET l_tmp.tmp093 = l_isca.isca806 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp093,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp093
      #948-957：供免稅營業用(h)2%(10碼)
      CALL aisp430_value_pn(l_isca.isca801) RETURNING g_sub_success,l_value
      LET l_tmp.tmp094 = l_isca.isca801 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp094,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp094
      #958-967：供免稅營業用(i)5%(10碼)
      CALL aisp430_value_pn(l_isca.isca802) RETURNING g_sub_success,l_value
      LET l_tmp.tmp095 = l_isca.isca802 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp095,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp095
      #968-977：供共同使用(j)1%(10碼)
      CALL aisp430_value_pn(l_isca.isca807) RETURNING g_sub_success,l_value
      LET l_tmp.tmp096 = l_isca.isca807 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp096,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp096
      #978-987：供共同使用(k)2%(10碼)
      CALL aisp430_value_pn(l_isca.isca803) RETURNING g_sub_success,l_value
      LET l_tmp.tmp097 = l_isca.isca803 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp097,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp097
      #988-997：供共同使用(l)5%(10碼)
      CALL aisp430_value_pn(l_isca.isca804) RETURNING g_sub_success,l_value
      LET l_tmp.tmp098 = l_isca.isca804 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp098,"T01",l_value) RETURNING g_sub_success,l_tmp.tmp098
      
      
      #910-918：稅籍編號(9碼)
      LET l_tmp.tmp099 = l_isca.isaa002 USING "&&&&&&&&&"
      #919-921：空白(3碼)
      LET l_tmp.tmp100 = 0 USING "&&&"
      
      
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012,l_tmp.tmp013,l_tmp.tmp014,l_tmp.tmp015,
                     l_tmp.tmp016,l_tmp.tmp017,l_tmp.tmp018,l_tmp.tmp019,l_tmp.tmp020,
                     l_tmp.tmp021,l_tmp.tmp022,l_tmp.tmp023,l_tmp.tmp024,l_tmp.tmp025,
                     l_tmp.tmp026,l_tmp.tmp027,l_tmp.tmp028,l_tmp.tmp029,l_tmp.tmp030,
                     l_tmp.tmp031,l_tmp.tmp032,l_tmp.tmp033,l_tmp.tmp034,l_tmp.tmp035,
                     l_tmp.tmp036,l_tmp.tmp037,l_tmp.tmp038,l_tmp.tmp039,l_tmp.tmp040,
                     l_tmp.tmp041,l_tmp.tmp042,l_tmp.tmp043,l_tmp.tmp044,l_tmp.tmp045,
                     l_tmp.tmp046,l_tmp.tmp047,l_tmp.tmp048,l_tmp.tmp049,l_tmp.tmp050,
                     l_tmp.tmp051,l_tmp.tmp052,l_tmp.tmp053,l_tmp.tmp054,l_tmp.tmp055,
                     l_tmp.tmp056,l_tmp.tmp057,l_tmp.tmp058,l_tmp.tmp059,l_tmp.tmp060,
                     l_tmp.tmp061,l_tmp.tmp062,l_tmp.tmp063,l_tmp.tmp064,l_tmp.tmp065,
                     l_tmp.tmp066,l_tmp.tmp067,l_tmp.tmp068,l_tmp.tmp069,l_tmp.tmp070,
                     l_tmp.tmp071,l_tmp.tmp072,l_tmp.tmp073,l_tmp.tmp074,l_tmp.tmp075,
                     l_tmp.tmp076,l_tmp.tmp077,l_tmp.tmp078,l_tmp.tmp079,l_tmp.tmp080,
                     l_tmp.tmp081,l_tmp.tmp082,l_tmp.tmp083,l_tmp.tmp084,l_tmp.tmp085,
                     l_tmp.tmp086,l_tmp.tmp087,l_tmp.tmp088,l_tmp.tmp089,l_tmp.tmp090,
                     l_tmp.tmp091,l_tmp.tmp092,l_tmp.tmp093,l_tmp.tmp094,l_tmp.tmp095,
                     l_tmp.tmp096,l_tmp.tmp097,l_tmp.tmp098,l_tmp.tmp099,l_tmp.tmp100
      CALL ch.write(l_in_txt)
      LET r_write = "Y"
      
   END FOREACH
   
   
   #存放TXT part2 start----------
   #這裡要轉換成DOS格式
   LET l_cmd = "awk 'sub(\"$\", \"\\r\")' ", l_file_name, " > ", l_file_name2
   RUN l_cmd
   
   #取得user要存放TXT的路徑(user電腦端)
   LET ls_target_file = os.Path.join(g_dir CLIPPED,l_file_name2 CLIPPED)
   
   #取得存放TXT端的路徑(伺服器端)
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name2 CLIPPED)
   
   #EXAMPLE:CALL FGL_PUTFILE(ls_source_file,"C:\\Users\\bartscott\\Desktop\\5.1/aaa.txt.2")
   CALL FGL_PUTFILE(ls_source_file,ls_target_file)
   CALL ch.close() 
   #存放TXT part2 end------------
   
   RETURN r_success,r_write
END FUNCTION

################################################################################
# Descriptions...: 營業人銷售額與稅額申報書檔(TET)
# Memo...........: #150518-00039#3
# Usage..........: CALL aisp430_catch_isaj_tet()
#                : p_isaa001   申報單位
#                : p_isaa002   申報單位的稅務編號
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_chk2      彙總申報Y:是N:否
# Date & Author..: 2015/07/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_catch_isaj_tet(p_isaa001,p_isaa002,p_isaa012,p_isaa013,p_chk2)
DEFINE p_isaa001       LIKE isaa_t.isaa001
DEFINE p_isaa002       LIKE isaa_t.isaa002
DEFINE p_isaa012       LIKE isaa_t.isaa012
DEFINE p_isaa013       LIKE isaa_t.isaa013
DEFINE p_chk2          LIKE isaa_t.isaa017
DEFINE l_sql           STRING
DEFINE l_wc            STRING
DEFINE l_tmp           RECORD
            tmp001        CHAR(1),
            tmp002        CHAR(2),
            tmp003        CHAR(8),
            tmp004        CHAR(8),
            tmp005        CHAR(5),
            tmp006        CHAR(1),
            tmp007        CHAR(9),
            tmp008        CHAR(5),
            tmp009        CHAR(1),
            tmp010        CHAR(6),
            
            tmp011        CHAR(10),
            tmp012        CHAR(12),
            tmp013        CHAR(12),
            tmp014        CHAR(12),
            tmp015        CHAR(12),
            tmp016        CHAR(12),
            tmp017        CHAR(12),
            tmp018        CHAR(10),
            tmp019        CHAR(10),
            tmp020        CHAR(10),
            
            tmp021        CHAR(10),
            tmp022        CHAR(10),
            tmp023        CHAR(10),
            tmp024        CHAR(12),
            tmp025        CHAR(12),
            tmp026        CHAR(12),
            tmp027        CHAR(12),
            tmp028        CHAR(12),
            tmp029        CHAR(12),
            tmp030        CHAR(12),
            
            tmp031        CHAR(12),
            tmp032        CHAR(12),
            tmp033        CHAR(12),
            tmp034        CHAR(12),
            tmp035        CHAR(12),
            tmp036        CHAR(12),
            tmp037        CHAR(10),
            tmp038        CHAR(12),
            tmp039        CHAR(10),
            tmp040        CHAR(12),
            
            tmp041        CHAR(10),
            tmp042        CHAR(12),
            tmp043        CHAR(10),
            tmp044        CHAR(12),
            tmp045        CHAR(10),
            tmp046        CHAR(12),
            tmp047        CHAR(12),
            tmp048        CHAR(10),
            tmp049        CHAR(12),
            tmp050        CHAR(10),
            
            tmp051        CHAR(12),
            tmp052        CHAR(12),
            tmp053        CHAR(12),
            tmp054        CHAR(12),
            tmp055        CHAR(12),
            tmp056        CHAR(12),
            tmp057        CHAR(12),
            tmp058        CHAR(12),
            tmp059        CHAR(12),
            tmp060        CHAR(12),
            
            tmp061        CHAR(12),
            tmp062        CHAR(12),
            tmp063        CHAR(12),
            tmp064        CHAR(10),
            tmp065        CHAR(10),
            tmp066        CHAR(10),
            tmp067        CHAR(10),
            tmp068        CHAR(10),
            tmp069        CHAR(10),
            tmp070        CHAR(10),
            
            tmp071        CHAR(10),
            tmp072        CHAR(10),
            tmp073        CHAR(10),
            tmp074        CHAR(12),
            tmp075        CHAR(12),
            tmp076        CHAR(3),
            tmp077        CHAR(10),
            tmp078        CHAR(12),
            tmp079        CHAR(12),
            tmp080        CHAR(12),
            
            tmp081        CHAR(12),
            tmp082        CHAR(10),
            tmp083        CHAR(10),
            tmp084        CHAR(10),
            tmp085        CHAR(10),
            tmp086        CHAR(10),
            tmp087        CHAR(10),
            tmp088        CHAR(10),
            tmp089        CHAR(10),
            tmp090        CHAR(10),
            
            tmp091        CHAR(10),
            tmp092        CHAR(10),
            tmp093        CHAR(10),
            tmp094        CHAR(10),
            tmp095        CHAR(10),
            tmp096        CHAR(10),
            tmp097        CHAR(10),
            tmp098        CHAR(10),
            tmp099        CHAR(10),
            tmp100        CHAR(10),
            
            tmp101        CHAR(10),
            tmp102        CHAR(10),
            tmp103        CHAR(23),
            tmp104        CHAR(1),
            tmp105        CHAR(1),
            tmp106        CHAR(1),
            tmp107        CHAR(6),
            tmp108        CHAR(1),
            tmp109        CHAR(10),
            tmp110        STRING,
            
            tmp111        CHAR(4),
            tmp112        CHAR(11),
            tmp113        CHAR(5),
            tmp114        STRING,
            tmp115        CHAR(12),
            tmp116        CHAR(12),
            tmp117        CHAR(12),
            tmp118        CHAR(10),
            tmp119        CHAR(10),
            tmp120        CHAR(10),
            
            tmp121        CHAR(12),
            tmp122        CHAR(10),
            tmp123        CHAR(4)
                       END RECORD
DEFINE l_iscb          RECORD
            l_cnt         LIKE type_t.num10,
            iscb001       LIKE iscb_t.iscb001,
            iscb002       LIKE iscb_t.iscb002,
            iscb004       LIKE iscb_t.iscb004,
            iscb005       LIKE iscb_t.iscb005,
            iscb006       LIKE iscb_t.iscb006,
            iscb007       LIKE iscb_t.iscb007,
            iscb008       LIKE iscb_t.iscb008,
            iscb009       LIKE iscb_t.iscb009,
            iscb010       LIKE iscb_t.iscb010,
            
            iscb012       LIKE iscb_t.iscb012,
            iscb013       LIKE iscb_t.iscb013,
            iscb014       LIKE iscb_t.iscb014,
            iscb015       LIKE iscb_t.iscb015,
            iscb016       LIKE iscb_t.iscb016,
            iscb017       LIKE iscb_t.iscb017,
            iscb018       LIKE iscb_t.iscb018,
            iscb019       LIKE iscb_t.iscb019,
            iscb020       LIKE iscb_t.iscb020,
            
            iscb021       LIKE iscb_t.iscb021,
            iscb022       LIKE iscb_t.iscb022,
            iscb023       LIKE iscb_t.iscb023,
            iscb024       LIKE iscb_t.iscb024,
            iscb025       LIKE iscb_t.iscb025,
            iscb026       LIKE iscb_t.iscb026,
            iscb027       LIKE iscb_t.iscb027,
            iscb028       LIKE iscb_t.iscb028,
            iscb029       LIKE iscb_t.iscb029,
            iscb030       LIKE iscb_t.iscb030,
            
            iscb031       LIKE iscb_t.iscb031,
            iscb032       LIKE iscb_t.iscb032,
            iscb033       LIKE iscb_t.iscb033,
            iscb034       LIKE iscb_t.iscb034,
            iscb035       LIKE iscb_t.iscb035,
            iscb036       LIKE iscb_t.iscb036,
            iscb037       LIKE iscb_t.iscb037,
            iscb038       LIKE iscb_t.iscb038,
            iscb039       LIKE iscb_t.iscb039,
            iscb040       LIKE iscb_t.iscb040,
            
            iscb041       LIKE iscb_t.iscb041,
            iscb042       LIKE iscb_t.iscb042,
            iscb043       LIKE iscb_t.iscb043,
            iscb044       LIKE iscb_t.iscb044,
            iscb045       LIKE iscb_t.iscb045,
            iscb046       LIKE iscb_t.iscb046,
            iscb047       LIKE iscb_t.iscb047,
            iscb048       LIKE iscb_t.iscb048,
            iscb049       LIKE iscb_t.iscb049,
            iscb050       LIKE iscb_t.iscb050,
            
            iscb051       LIKE iscb_t.iscb051,
            iscb052       LIKE iscb_t.iscb052,
            iscb053       LIKE iscb_t.iscb053,
            iscb054       LIKE iscb_t.iscb054,
            iscb055       LIKE iscb_t.iscb055,
            iscb056       LIKE iscb_t.iscb056,
            iscb057       LIKE iscb_t.iscb057,
            iscb058       LIKE iscb_t.iscb058,
            iscb059       LIKE iscb_t.iscb059,
            iscb060       LIKE iscb_t.iscb060,
            
            iscb061       LIKE iscb_t.iscb061,
            iscb062       LIKE iscb_t.iscb062,
            iscb063       LIKE iscb_t.iscb063,
            iscb064       LIKE iscb_t.iscb064,
            iscb065       LIKE iscb_t.iscb065,
            iscb066       LIKE iscb_t.iscb066,

            iscb073       LIKE iscb_t.iscb073,
            iscb074       LIKE iscb_t.iscb074,
            iscb075       LIKE iscb_t.iscb075,
            iscb076       LIKE iscb_t.iscb076,
            iscb078       LIKE iscb_t.iscb078,
            iscb079       LIKE iscb_t.iscb079,
            iscb080       LIKE iscb_t.iscb080,
            
            iscb081       LIKE iscb_t.iscb081,
            iscb082       LIKE iscb_t.iscb082,
            iscb084       LIKE iscb_t.iscb084,
            iscb085       LIKE iscb_t.iscb085,
            
            iscb101       LIKE iscb_t.iscb101,
            iscb103       LIKE iscb_t.iscb103,
            iscb104       LIKE iscb_t.iscb104,
            iscb105       LIKE iscb_t.iscb105,
            iscb106       LIKE iscb_t.iscb106,
            iscb107       LIKE iscb_t.iscb107,
            iscb108       LIKE iscb_t.iscb108,
            iscb109       LIKE iscb_t.iscb109,
            iscb110       LIKE iscb_t.iscb110,
            
            iscb111       LIKE iscb_t.iscb111,
            iscb112       LIKE iscb_t.iscb112,
            iscb113       LIKE iscb_t.iscb113,
            iscb114       LIKE iscb_t.iscb114,
            iscb115       LIKE iscb_t.iscb115,
            
            iscb200       LIKE iscb_t.iscb200,
            iscb201       LIKE iscb_t.iscb201,
            iscb202       LIKE iscb_t.iscb202,
            
            isaa002       LIKE isaa_t.isaa002,
            isaa003       LIKE isaa_t.isaa003,
            isaa005       LIKE isaa_t.isaa005,
            isaa007       LIKE isaa_t.isaa007,
            isaa008       LIKE isaa_t.isaa008,
            isaa010       LIKE isaa_t.isaa010,
            isaa020       LIKE isaa_t.isaa020,
            isaa022       LIKE isaa_t.isaa022,
            isaa027       LIKE isaa_t.isaa027,
            isaa028       LIKE isaa_t.isaa028,
            isaa029       LIKE isaa_t.isaa029,
            isaa030       LIKE isaa_t.isaa030,
            ooef002       LIKE ooef_t.ooef002
                       END RECORD
DEFINE l_value         LIKE type_t.chr1  #判斷正負 Y:正 N:負
DEFINE l_in_txt        STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_write         LIKE type_t.chr1
#存放TXT-----
DEFINE l_name          LIKE type_t.chr20
DEFINE ch              base.Channel
DEFINE l_file_name     STRING
DEFINE l_file_name2    STRING
DEFINE ls_target_file  STRING
DEFINE ls_source_file  STRING
DEFINE l_cmd           STRING
#存放TXT-----

   LET r_success = TRUE
   LET r_write = 'N'
   
   #存放TXT part1 start----------
   #檔案名稱default統一編號
   LET l_name = p_isaa002
   #取得暫時存放TXT的路徑(TEMPDIR)
   LET l_file_name = l_name,'orig.TET'  #原始檔案
   LET l_file_name2 = l_name,'.TET'     #轉成DOS格式的檔案
   
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name CLIPPED)
   LET ch = base.Channel.create()
   CALL ch.openFile(ls_source_file,"w")
   CALL ch.setDelimiter("")
   #存放TXT part1 end------------
   
   
   #彙總申報
   #若A總部幫B&C分公司代繳，那需產生3個TET檔：
   #第一個TET(2筆)：A+B+C匯總、A總部
   #第二個TET(1筆)：B公司
   #第三個TET(1筆)：C公司
   #但要執行三次aisp430產生，因為aisp430一次只能產生一間公司(國稅局軟體也是)
   IF p_chk2 = "Y" THEN
      LET l_sql = "SELECT '1' AS aa,SUM(iscb001),SUM(iscb002),SUM(iscb004),SUM(iscb005),",
                  "       SUM(iscb006),SUM(iscb007),SUM(iscb008),SUM(iscb009),SUM(iscb010),",
                  "       SUM(iscb012),SUM(iscb013),SUM(iscb014),SUM(iscb015),",
                  "       SUM(iscb016),SUM(iscb017),SUM(iscb018),SUM(iscb019),SUM(iscb020),",
                  "       SUM(iscb021),SUM(iscb022),SUM(iscb023),SUM(iscb024),SUM(iscb025),",
                  "       SUM(iscb026),SUM(iscb027),SUM(iscb028),SUM(iscb029),SUM(iscb030),",
                  "       SUM(iscb031),SUM(iscb032),SUM(iscb033),SUM(iscb034),SUM(iscb035),",
                  "       SUM(iscb036),SUM(iscb037),SUM(iscb038),SUM(iscb039),SUM(iscb040),",
                  "       SUM(iscb041),SUM(iscb042),SUM(iscb043),SUM(iscb044),SUM(iscb045),",
                  "       SUM(iscb046),SUM(iscb047),SUM(iscb048),SUM(iscb049),SUM(iscb050),",
                  "       SUM(iscb051),SUM(iscb052),SUM(iscb053),SUM(iscb054),SUM(iscb055),",
                  "       SUM(iscb056),SUM(iscb057),SUM(iscb058),SUM(iscb059),SUM(iscb060),",
                  "       SUM(iscb061),SUM(iscb062),SUM(iscb063),SUM(iscb064),SUM(iscb065),",
                  "       SUM(iscb066),",
                  "       SUM(iscb073),SUM(iscb074),SUM(iscb075),",
                  "       SUM(iscb076),SUM(iscb078),SUM(iscb079),SUM(iscb080),",
                  "       SUM(iscb081),SUM(iscb082),SUM(iscb084),SUM(iscb085),",
                  "       SUM(iscb101),SUM(iscb103),SUM(iscb104),SUM(iscb105),",
                  "       SUM(iscb106),SUM(iscb107),SUM(iscb108),SUM(iscb109),SUM(iscb110),",
                  "       SUM(iscb111),SUM(iscb112),SUM(iscb113),SUM(iscb114),SUM(iscb115),",
                  "       SUM(iscb202),",
                  "       '' AS isaa002,'' AS isaa003,'' AS isaa005,'' AS isaa007,'' AS isaa008,",
                  "       '' AS isaa010,'' AS isaa020,'' AS isaa022,'' AS isaa027,'' AS isaa028,",
                  "       '' AS isaa029,'' AS isaa030,'' AS ooef002",
                  "  FROM iscb_t",
                  " WHERE iscbent = ",g_enterprise,
                  "   AND iscbstus='Y'",
                  "   AND iscb200 = ",p_isaa012," AND iscb201 = ",p_isaa013,
                  "   AND iscbcomp = '",p_isaa001,"'",
                  " GROUP BY iscbcomp ",
                  " UNION ALL ",
                  "SELECT '2',iscb001,iscb002,iscb004,iscb005,",
                  "       iscb006,iscb007,iscb008,iscb009,iscb010,",
                  "       iscb012,iscb013,iscb014,iscb015,",
                  "       iscb016,iscb017,iscb018,iscb019,iscb020,",
                  "       iscb021,iscb022,iscb023,iscb024,iscb025,",
                  "       iscb026,iscb027,iscb028,iscb029,iscb030,",
                  "       iscb031,iscb032,iscb033,iscb034,iscb035,",
                  "       iscb036,iscb037,iscb038,iscb039,iscb040,",
                  "       iscb041,iscb042,iscb043,iscb044,iscb045,",
                  "       iscb046,iscb047,iscb048,iscb049,iscb050,",
                  "       iscb051,iscb052,iscb053,iscb054,iscb055,",
                  "       iscb056,iscb057,iscb058,iscb059,iscb060,",
                  "       iscb061,iscb062,iscb063,iscb064,iscb065,",
                  "       iscb066,",
                  "       iscb073,iscb074,iscb075,",
                  "       iscb076,iscb078,iscb079,iscb080,",
                  "       iscb081,iscb082,iscb084,iscb085,",
                  "       iscb101,iscb103,iscb104,iscb105,",
                  "       iscb106,iscb107,iscb108,iscb109,iscb110,",
                  "       iscb111,iscb112,iscb113,iscb114,iscb115,",
                  "       iscb202,",
                  "       isaa002,isaa003,isaa005,isaa007,isaa008,",
                  "       isaa010,isaa020,isaa022,isaa027,isaa028,",
                  "       isaa029,isaa030,ooef002",
                  "  FROM iscb_t",
                  "  LEFT JOIN isaa_t ON iscbent = isaaent AND iscbsite = isaa001",
                  "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                  " WHERE iscbent = ",g_enterprise,
                  "   AND iscbstus='Y'",
                  "   AND iscb200 = ",p_isaa012," AND iscb201 = ",p_isaa013,
                  "   AND iscbsite = '",p_isaa001,"'",
                  " ORDER BY aa ASC"
   ELSE
      LET l_sql = "SELECT '0',iscb001,iscb002,iscb004,iscb005,",
                  "       iscb006,iscb007,iscb008,iscb009,iscb010,",
                  "       iscb012,iscb013,iscb014,iscb015,",
                  "       iscb016,iscb017,iscb018,iscb019,iscb020,",
                  "       iscb021,iscb022,iscb023,iscb024,iscb025,",
                  "       iscb026,iscb027,iscb028,iscb029,iscb030,",
                  "       iscb031,iscb032,iscb033,iscb034,iscb035,",
                  "       iscb036,iscb037,iscb038,iscb039,iscb040,",
                  "       iscb041,iscb042,iscb043,iscb044,iscb045,",
                  "       iscb046,iscb047,iscb048,iscb049,iscb050,",
                  "       iscb051,iscb052,iscb053,iscb054,iscb055,",
                  "       iscb056,iscb057,iscb058,iscb059,iscb060,",
                  "       iscb061,iscb062,iscb063,iscb064,iscb065,",
                  "       iscb066,",
                  "       iscb073,iscb074,iscb075,",
                  "       iscb076,iscb078,iscb079,iscb080,",
                  "       iscb081,iscb082,iscb084,iscb085,",
                  "       iscb101,iscb103,iscb104,iscb105,",
                  "       iscb106,iscb107,iscb108,iscb109,iscb110,",
                  "       iscb111,iscb112,iscb113,iscb114,iscb115,",
                  "       iscb202,",
                  "       isaa002,isaa003,isaa005,isaa007,isaa008,",
                  "       isaa010,isaa020,isaa022,isaa027,isaa028,",
                  "       isaa029,isaa030,ooef002",
                  "  FROM iscb_t",
                  "  LEFT JOIN isaa_t ON iscbent = isaaent AND iscbsite = isaa001",
                  "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                  " WHERE iscbent = ",g_enterprise,
                  "   AND iscbstus='Y'",
                  "   AND iscb200 = ",p_isaa012," AND iscb201 = ",p_isaa013,
                  "   AND iscbsite = '",p_isaa001,"'"
   END IF
   
   PREPARE iscb_pb_tet FROM l_sql
   DECLARE iscb_cs_tet CURSOR FOR iscb_pb_tet
   FOREACH iscb_cs_tet INTO l_iscb.l_cnt,l_iscb.iscb001,l_iscb.iscb002,l_iscb.iscb004,l_iscb.iscb005,
                            l_iscb.iscb006,l_iscb.iscb007,l_iscb.iscb008,l_iscb.iscb009,l_iscb.iscb010,
                            l_iscb.iscb012,l_iscb.iscb013,l_iscb.iscb014,l_iscb.iscb015,
                            l_iscb.iscb016,l_iscb.iscb017,l_iscb.iscb018,l_iscb.iscb019,l_iscb.iscb020,
                            l_iscb.iscb021,l_iscb.iscb022,l_iscb.iscb023,l_iscb.iscb024,l_iscb.iscb025,
                            l_iscb.iscb026,l_iscb.iscb027,l_iscb.iscb028,l_iscb.iscb029,l_iscb.iscb030,
                            l_iscb.iscb031,l_iscb.iscb032,l_iscb.iscb033,l_iscb.iscb034,l_iscb.iscb035,
                            l_iscb.iscb036,l_iscb.iscb037,l_iscb.iscb038,l_iscb.iscb039,l_iscb.iscb040,
                            l_iscb.iscb041,l_iscb.iscb042,l_iscb.iscb043,l_iscb.iscb044,l_iscb.iscb045,
                            l_iscb.iscb046,l_iscb.iscb047,l_iscb.iscb048,l_iscb.iscb049,l_iscb.iscb050,
                            l_iscb.iscb051,l_iscb.iscb052,l_iscb.iscb053,l_iscb.iscb054,l_iscb.iscb055,
                            l_iscb.iscb056,l_iscb.iscb057,l_iscb.iscb058,l_iscb.iscb059,l_iscb.iscb060,
                            l_iscb.iscb061,l_iscb.iscb062,l_iscb.iscb063,l_iscb.iscb064,l_iscb.iscb065,
                            l_iscb.iscb066,
                            l_iscb.iscb073,l_iscb.iscb074,l_iscb.iscb075,
                            l_iscb.iscb076,l_iscb.iscb078,l_iscb.iscb079,l_iscb.iscb080,
                            l_iscb.iscb081,l_iscb.iscb082,l_iscb.iscb084,l_iscb.iscb085,
                            l_iscb.iscb101,l_iscb.iscb103,l_iscb.iscb104,l_iscb.iscb105,
                            l_iscb.iscb106,l_iscb.iscb107,l_iscb.iscb108,l_iscb.iscb109,l_iscb.iscb110,
                            l_iscb.iscb111,l_iscb.iscb112,l_iscb.iscb113,l_iscb.iscb114,l_iscb.iscb115,
                            l_iscb.iscb202,
                            l_iscb.isaa002,l_iscb.isaa003,l_iscb.isaa005,l_iscb.isaa007,l_iscb.isaa008,
                            l_iscb.isaa010,l_iscb.isaa020,l_iscb.isaa022,l_iscb.isaa027,l_iscb.isaa028,
                            l_iscb.isaa029,l_iscb.isaa030,l_iscb.ooef002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      #第一筆匯總需撈取總申報單位的相關訊息
      IF l_iscb.l_cnt = 1 THEN
         LET l_sql = "SELECT iscb200,iscb201,",
                     "       isaa002,isaa003,isaa005,isaa007,isaa008,",
                     "       isaa010,isaa020,isaa022,isaa027,isaa028,",
                     "       isaa029,isaa030,ooef002",
                     "  FROM iscb_t",
                     "  LEFT JOIN isaa_t ON iscbent = isaaent AND iscbsite = isaa001",
                     "  LEFT JOIN ooef_t ON isaaent = ooefent AND isaa001 = ooef001",
                     " WHERE iscbent = ",g_enterprise,
                     "   AND iscbstus='Y'",
                     "   AND iscb200 = ",p_isaa012," AND iscb201 = ",p_isaa013,
                     "   AND iscbsite = '",p_isaa001,"'"
         PREPARE iscb_pb_tet2 FROM l_sql
         EXECUTE iscb_pb_tet2 INTO l_iscb.iscb200,l_iscb.iscb201,
                                   l_iscb.isaa002,l_iscb.isaa003,l_iscb.isaa005,l_iscb.isaa007,l_iscb.isaa008,
                                   l_iscb.isaa010,l_iscb.isaa020,l_iscb.isaa022,l_iscb.isaa027,l_iscb.isaa028,
                                   l_iscb.isaa029,l_iscb.isaa030,l_iscb.ooef002
      ELSE
         LET l_iscb.iscb200 = p_isaa012
         LET l_iscb.iscb201 = p_isaa013
      END IF
      
      INITIALIZE l_tmp.* TO NULL
      
      #1：資料別(1碼)
      IF l_iscb.isaa022 = "Y" THEN #直接扣抵=Y:403/=N:401
         LET l_tmp.tmp001 = "3"
      ELSE
         LET l_tmp.tmp001 = "1"
      END IF
      
      #2-3：空白(2碼)
      LET l_tmp.tmp002 = 0 USING "&&"
      
      #4-11：檔案編號>>全部補零(8碼)
      LET l_tmp.tmp003 = 0 USING "&&&&&&&&"
      
      #12-19：統一編號(8碼)
      LET l_tmp.tmp004 = l_iscb.ooef002
      
      #20-24：所屬年度(5碼)
      #年要轉成民國年
      LET l_iscb.iscb200 = l_iscb.iscb200 - 1911
      LET l_tmp.tmp005 = l_iscb.iscb200 USING "&&&" , l_iscb.iscb201 USING "&&"
      
      #25：申報代號(1碼)
      #如果是總部匯總報繳，匯總的總繳代號是1，總部的總繳代號是2
      IF l_iscb.l_cnt = 2 THEN LET l_iscb.isaa008 = 2 END IF
      CASE
         WHEN l_iscb.isaa008 MATCHES '[02]'
            LET l_tmp.tmp006 = "1"
         WHEN l_iscb.isaa008 = "1"
            LET l_tmp.tmp006 = "5"
      END CASE
      
      #26-34：稅籍編號(9碼)
      LET l_tmp.tmp007 = l_iscb.isaa002
      
      #35-39：空白(5碼)
      LET l_tmp.tmp008 = 0 USING "&&&&&"
      
      #40：總繳代號(1碼)
      LET l_tmp.tmp009 = l_iscb.isaa008
      
      #41-46：空白(6碼)
      LET l_tmp.tmp010 = 0 USING "&&&&&&"
      
      #47-56：使用發票分數(10碼)
      LET l_tmp.tmp011 = l_iscb.iscb202 USING "&&&&&&&&&&"
      
      #一般稅額銷項金額/應稅銷售額
      #57-68：三聯式電子計算機發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb001) RETURNING g_sub_success,l_value
      LET l_tmp.tmp012 = l_iscb.iscb001 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp012,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp012
      #69-80：收銀機發票(三聯式)及電子發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb005) RETURNING g_sub_success,l_value
      LET l_tmp.tmp013 = l_iscb.iscb005 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp013,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp013
      #81-92：二聯式收銀機(二聯式)發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb009) RETURNING g_sub_success,l_value
      LET l_tmp.tmp014 = l_iscb.iscb009 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp014,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp014
      #93-104：免用發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb013) RETURNING g_sub_success,l_value
      LET l_tmp.tmp015 = l_iscb.iscb013 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp015,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp015
      #105-116：退回及折讓(12碼)
      CALL aisp430_value_pn(l_iscb.iscb017) RETURNING g_sub_success,l_value
      LET l_tmp.tmp016 = l_iscb.iscb017 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp016,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp016
      #117-128：合計(12碼)
      CALL aisp430_value_pn(l_iscb.iscb021) RETURNING g_sub_success,l_value
      LET l_tmp.tmp017 = l_iscb.iscb021 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp017,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp017

      
      #一般稅額銷項金額/應稅稅額
      #129-138：三聯式電子計算機發票(10碼)
      CALL aisp430_value_pn(l_iscb.iscb002) RETURNING g_sub_success,l_value
      LET l_tmp.tmp018 = l_iscb.iscb002 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp018,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp018
      #139-148：收銀機發票(三聯式)及電子發票(10碼)
      CALL aisp430_value_pn(l_iscb.iscb006) RETURNING g_sub_success,l_value
      LET l_tmp.tmp019 = l_iscb.iscb006 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp019,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp019
      #149-158：二聯式收銀機(二聯式)發票(10碼)
      CALL aisp430_value_pn(l_iscb.iscb010) RETURNING g_sub_success,l_value
      LET l_tmp.tmp020 = l_iscb.iscb010 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp020,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp020
      #159-168：免用發票(10碼)
      CALL aisp430_value_pn(l_iscb.iscb014) RETURNING g_sub_success,l_value
      LET l_tmp.tmp021 = l_iscb.iscb014 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp021,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp021
      #169-178：退回及折讓(10碼)
      CALL aisp430_value_pn(l_iscb.iscb018) RETURNING g_sub_success,l_value
      LET l_tmp.tmp022 = l_iscb.iscb018 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp022,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp022
      #179-188：合計(10碼)
      CALL aisp430_value_pn(l_iscb.iscb022) RETURNING g_sub_success,l_value
      LET l_tmp.tmp023 = l_iscb.iscb022 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp023,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp023
      
      
      #189-200：免稅出口區內之區內...(12碼)
      CALL aisp430_value_pn(l_iscb.iscb082) RETURNING g_sub_success,l_value
      LET l_tmp.tmp024 = l_iscb.iscb082 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp024,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp024
      
      
      #零稅率銷售額
      #201-212：非經海關出口應附證明文件者(12碼)
      CALL aisp430_value_pn(l_iscb.iscb007) RETURNING g_sub_success,l_value
      LET l_tmp.tmp025 = l_iscb.iscb007 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp025,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp025
      #213-224：空白(12碼)
      LET l_tmp.tmp026 = 0 USING "&&&&&&&&&&&&"
      #225-236：經海關出口免附證明文件者(12碼)
      CALL aisp430_value_pn(l_iscb.iscb015) RETURNING g_sub_success,l_value
      LET l_tmp.tmp027 = l_iscb.iscb015 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp027,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp027
      #237-248：退回及折讓(12碼)
      CALL aisp430_value_pn(l_iscb.iscb019) RETURNING g_sub_success,l_value
      LET l_tmp.tmp028 = l_iscb.iscb019 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp028,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp028
      #249-260：合計(12碼)
      CALL aisp430_value_pn(l_iscb.iscb023) RETURNING g_sub_success,l_value
      LET l_tmp.tmp029 = l_iscb.iscb023 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp029,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp029
      
      
      #免稅銷售額
      #261-272：三聯式電子計算機發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb004) RETURNING g_sub_success,l_value
      LET l_tmp.tmp030 = l_iscb.iscb004 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp030,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp030
      #273-284：收銀機發票(三聯式)及電子發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb008) RETURNING g_sub_success,l_value
      LET l_tmp.tmp031 = l_iscb.iscb008 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp031,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp031
      #285-296：二聯式收銀機(二聯式)發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb012) RETURNING g_sub_success,l_value
      LET l_tmp.tmp032 = l_iscb.iscb012 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp032,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp032
      #297-308：免用發票(12碼)
      CALL aisp430_value_pn(l_iscb.iscb016) RETURNING g_sub_success,l_value
      LET l_tmp.tmp033 = l_iscb.iscb016 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp033,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp033
      #309-320：退回及折讓(12碼)
      CALL aisp430_value_pn(l_iscb.iscb020) RETURNING g_sub_success,l_value
      LET l_tmp.tmp034 = l_iscb.iscb020 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp034,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp034
      #321-332：合計(12碼)
      CALL aisp430_value_pn(l_iscb.iscb024) RETURNING g_sub_success,l_value
      LET l_tmp.tmp035 = l_iscb.iscb024 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp035,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp035
      
      
      
      #特種稅額-特種飲食/25%
      #333-344：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb052) RETURNING g_sub_success,l_value
      LET l_tmp.tmp036 = l_iscb.iscb052 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp036,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp036
      #345-354：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb053) RETURNING g_sub_success,l_value
      LET l_tmp.tmp037 = l_iscb.iscb053 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp037,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp037
      
      #特種稅額-特種飲食/15%
      #355-366：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb054) RETURNING g_sub_success,l_value
      LET l_tmp.tmp038 = l_iscb.iscb054 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp038,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp038
      #367-376：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb055) RETURNING g_sub_success,l_value
      LET l_tmp.tmp039 = l_iscb.iscb055 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp039,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp039
      
      #其他專屬本業收入(不含銀行業、保險業經營銀行、保險本業收入)2%
      #377-388：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb056) RETURNING g_sub_success,l_value
      LET l_tmp.tmp040 = l_iscb.iscb056 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp040,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp040
      #389-398：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb057) RETURNING g_sub_success,l_value
      LET l_tmp.tmp041 = l_iscb.iscb057 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp041,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp041
      
      #非專屬本業收入5%
      #399-410：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb058) RETURNING g_sub_success,l_value
      LET l_tmp.tmp042 = l_iscb.iscb058 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp042,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp042
      #411-420：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb059) RETURNING g_sub_success,l_value
      LET l_tmp.tmp043 = l_iscb.iscb059 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp043,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp043
      
      #特種稅額再保收入1%
      #421-432：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb060) RETURNING g_sub_success,l_value
      LET l_tmp.tmp044 = l_iscb.iscb060 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp044,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp044
      #433-442：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb061) RETURNING g_sub_success,l_value
      LET l_tmp.tmp045 = l_iscb.iscb061 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp045,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp045
      
      #特種稅額免稅收入
      #443-454：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb062) RETURNING g_sub_success,l_value
      LET l_tmp.tmp046 = l_iscb.iscb062 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp046,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp046
      
      #特種稅額退回及折讓
      #455-466：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb063) RETURNING g_sub_success,l_value
      LET l_tmp.tmp047 = l_iscb.iscb063 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp047,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp047
      #467-476：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb064) RETURNING g_sub_success,l_value
      LET l_tmp.tmp048 = l_iscb.iscb064 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp048,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp048
      
      #特種稅額合計
      #477-488：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb065) RETURNING g_sub_success,l_value
      LET l_tmp.tmp049 = l_iscb.iscb065 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp049,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp049
      #489-498：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb066) RETURNING g_sub_success,l_value
      LET l_tmp.tmp050 = l_iscb.iscb066 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp050,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp050
      
      #銷售額總計
      #499-510：總計(12碼)
      CALL aisp430_value_pn(l_iscb.iscb025) RETURNING g_sub_success,l_value
      LET l_tmp.tmp051 = l_iscb.iscb025 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp051,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp051
      #511-522：土地(12碼)
      CALL aisp430_value_pn(l_iscb.iscb026) RETURNING g_sub_success,l_value
      LET l_tmp.tmp052 = l_iscb.iscb026 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp052,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp052
      #523-534：其他固定之資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb027) RETURNING g_sub_success,l_value
      LET l_tmp.tmp053 = l_iscb.iscb027 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp053,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp053
      
      
      
      #應比例計算得扣抵進項金額
      #統一發票扣抵聯
      #535-546：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb028) RETURNING g_sub_success,l_value
      LET l_tmp.tmp054 = l_iscb.iscb028 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp054,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp054
      #547-558：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb030) RETURNING g_sub_success,l_value
      LET l_tmp.tmp055 = l_iscb.iscb030 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp055,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp055
      
      #三聯式收銀機發票扣抵聯及一般稅額計算之電子發票
      #559-570：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb032) RETURNING g_sub_success,l_value
      LET l_tmp.tmp056 = l_iscb.iscb032 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp056,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp056
      #571-582：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb034) RETURNING g_sub_success,l_value
      LET l_tmp.tmp057 = l_iscb.iscb034 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp057,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp057
      
      #載有稅額之其他憑證
      #583-594：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb036) RETURNING g_sub_success,l_value
      LET l_tmp.tmp058 = l_iscb.iscb036 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp058,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp058
      #595-606：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb038) RETURNING g_sub_success,l_value
      LET l_tmp.tmp059 = l_iscb.iscb038 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp059,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp059
      
      #退出及折讓
      #607-618：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb040) RETURNING g_sub_success,l_value
      LET l_tmp.tmp060 = l_iscb.iscb040 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp060,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp060
      #619-630：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb042) RETURNING g_sub_success,l_value
      LET l_tmp.tmp061 = l_iscb.iscb042 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp061,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp061
      
      #合計
      #631-642：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb044) RETURNING g_sub_success,l_value
      LET l_tmp.tmp062 = l_iscb.iscb044 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp062,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp062
      #643-654：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb046) RETURNING g_sub_success,l_value
      LET l_tmp.tmp063 = l_iscb.iscb046 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp063,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp063
      
      
      
      
      #應比例計算得扣抵進項稅額
      #統一發票扣抵聯
      #655-664：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb029) RETURNING g_sub_success,l_value
      LET l_tmp.tmp064 = l_iscb.iscb029 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp064,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp064
      #665-674：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb031) RETURNING g_sub_success,l_value
      LET l_tmp.tmp065 = l_iscb.iscb031 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp065,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp065
      
      #三聯式收銀機發票扣抵聯及一般稅額計算之電子發票
      #675-684：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb033) RETURNING g_sub_success,l_value
      LET l_tmp.tmp066 = l_iscb.iscb033 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp066,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp066
      #685-694：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb035) RETURNING g_sub_success,l_value
      LET l_tmp.tmp067 = l_iscb.iscb035 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp067,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp067
      
      #載有稅額之其他憑證
      #695-704：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb037) RETURNING g_sub_success,l_value
      LET l_tmp.tmp068 = l_iscb.iscb037 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp068,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp068
      #705-714：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb039) RETURNING g_sub_success,l_value
      LET l_tmp.tmp069 = l_iscb.iscb039 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp069,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp069
      
      #退出及折讓
      #715-724：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb041) RETURNING g_sub_success,l_value
      LET l_tmp.tmp070 = l_iscb.iscb041 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp070,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp070
      #725-734：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb043) RETURNING g_sub_success,l_value
      LET l_tmp.tmp071 = l_iscb.iscb043 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp071,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp071
      
      #合計
      #735-744：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb045) RETURNING g_sub_success,l_value
      LET l_tmp.tmp072 = l_iscb.iscb045 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp072,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp072
      #745-754：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb047) RETURNING g_sub_success,l_value
      LET l_tmp.tmp073 = l_iscb.iscb047 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp073,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp073
      
      
      
      
      #進項總金額
      #755-766：進貨及費用(12碼)
      CALL aisp430_value_pn(l_iscb.iscb048) RETURNING g_sub_success,l_value
      LET l_tmp.tmp074 = l_iscb.iscb048 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp074,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp074
      #767-778：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb049) RETURNING g_sub_success,l_value
      LET l_tmp.tmp075 = l_iscb.iscb049 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp075,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp075
      
      
      #779-781：不得扣抵比例(3碼)
      LET l_tmp.tmp076 = l_iscb.iscb050 USING "&&&"
      
      
      #782-791：得扣抵之進項稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb051) RETURNING g_sub_success,l_value
      LET l_tmp.tmp077 = l_iscb.iscb051 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp077,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp077
      
      
      #海關代徵營業稅繳納證扣抵聯金額
      #792-803：進貨及費用金額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb078) RETURNING g_sub_success,l_value
      LET l_tmp.tmp078 = l_iscb.iscb078 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp078,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp078
      #804-815：固定資產(12碼)
      CALL aisp430_value_pn(l_iscb.iscb080) RETURNING g_sub_success,l_value
      LET l_tmp.tmp079 = l_iscb.iscb080 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp079,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp079
      
      
      #816-827：進口免稅貨物(12碼)
      CALL aisp430_value_pn(l_iscb.iscb073) RETURNING g_sub_success,l_value
      LET l_tmp.tmp080 = l_iscb.iscb073 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp080,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp080
      #828-839：購買國外勞務給付額之購買國外勞務稅額計算(12碼)
      CALL aisp430_value_pn(l_iscb.iscb074) RETURNING g_sub_success,l_value
      LET l_tmp.tmp081 = l_iscb.iscb074 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp081,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp081
      
      
      #海關代徵營業稅繳納證扣抵聯稅額
      #840-849：進貨及費用(10碼)
      CALL aisp430_value_pn(l_iscb.iscb079) RETURNING g_sub_success,l_value
      LET l_tmp.tmp082 = l_iscb.iscb079 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp082,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp082
      #850-859：固定資產(10碼)
      CALL aisp430_value_pn(l_iscb.iscb081) RETURNING g_sub_success,l_value
      LET l_tmp.tmp083 = l_iscb.iscb081 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp083,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp083
      
      #860-869：營業稅額之購買國外勞務稅額計算(10碼)
      CALL aisp430_value_pn(l_iscb.iscb075) RETURNING g_sub_success,l_value
      LET l_tmp.tmp084 = l_iscb.iscb075 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp084,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp084
      #870-879：空白欄補零(10碼)
      LET l_tmp.tmp085 = 0 USING "&&&&&&&&&&"
      #880-889：空白欄補零(10碼)
      LET l_tmp.tmp086 = 0 USING "&&&&&&&&&&"
      #890-899：應納稅額之購買國外勞務稅額計算(10碼)
      CALL aisp430_value_pn(l_iscb.iscb076) RETURNING g_sub_success,l_value
      LET l_tmp.tmp087 = l_iscb.iscb076 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp087,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp087
      
      
      #稅額計算
      #900-909：本(期)月銷項稅額合計(10碼)
      CALL aisp430_value_pn(l_iscb.iscb101) RETURNING g_sub_success,l_value
      LET l_tmp.tmp088 = l_iscb.iscb101 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp088,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp088
      #910-919：空白欄補零(10碼)
      LET l_tmp.tmp089 = 0 USING "&&&&&&&&&&"
      #920-929：購買國外勞務應納稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb103) RETURNING g_sub_success,l_value
      LET l_tmp.tmp090 = l_iscb.iscb103 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp090,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp090
      #930-939：特種稅額計算應納稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb104) RETURNING g_sub_success,l_value
      LET l_tmp.tmp091 = l_iscb.iscb104 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp091,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp091
      #940-949：中途歇業年底調整補徵應繳稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb105) RETURNING g_sub_success,l_value
      LET l_tmp.tmp092 = l_iscb.iscb105 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp092,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp092
      #950-959：小計(1+3+4+5)(10碼)
      CALL aisp430_value_pn(l_iscb.iscb106) RETURNING g_sub_success,l_value
      LET l_tmp.tmp093 = l_iscb.iscb106 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp093,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp093
      #960-969：得扣抵進項稅額合計(10碼)
      CALL aisp430_value_pn(l_iscb.iscb107) RETURNING g_sub_success,l_value
      LET l_tmp.tmp094 = l_iscb.iscb107 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp094,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp094
      #970-979：上期(月)累積留抵稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb108) RETURNING g_sub_success,l_value
      LET l_tmp.tmp095 = l_iscb.iscb108 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp095,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp095
      #980-989：中途歇業或年底調整應退稅額、辦理現場小額退稅申報扣減金額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb109) RETURNING g_sub_success,l_value
      LET l_tmp.tmp096 = l_iscb.iscb109 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp096,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp096
      #990-999：小計(7+8+9)(10碼)
      CALL aisp430_value_pn(l_iscb.iscb110) RETURNING g_sub_success,l_value
      LET l_tmp.tmp097 = l_iscb.iscb110 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp097,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp097
      #1000-1009：本期(月)應實繳稅額(6-10)(10碼)
      CALL aisp430_value_pn(l_iscb.iscb111) RETURNING g_sub_success,l_value
      LET l_tmp.tmp098 = l_iscb.iscb111 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp098,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp098
      #1010-1019：本期(月)申報留抵稅額(10-6)(10碼)
      CALL aisp430_value_pn(l_iscb.iscb112) RETURNING g_sub_success,l_value
      LET l_tmp.tmp099 = l_iscb.iscb112 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp099,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp099
      #10200-1029：得退稅限額合計(10碼)
      CALL aisp430_value_pn(l_iscb.iscb113) RETURNING g_sub_success,l_value
      LET l_tmp.tmp100 = l_iscb.iscb113 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp100,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp100
      #1030-1039：本期(月)應退稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb114) RETURNING g_sub_success,l_value
      LET l_tmp.tmp101 = l_iscb.iscb114 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp101,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp101
      #1040-1049：本期(月)累積留抵稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb115) RETURNING g_sub_success,l_value
      LET l_tmp.tmp102 = l_iscb.iscb115 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp102,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp102
      #1050-1072：空白欄補零(23碼)
      LET l_tmp.tmp103 = 0 USING "&&&&&&&&&&&&&&&&&&&&&&&"
      
      #1073：申報種類(1碼)
      LET l_tmp.tmp104 = l_iscb.isaa007
      
      #1074：空白欄補零(1碼)
      LET l_tmp.tmp105 = 0 USING "&"
      
      #1075：縣市別(1碼)
      LET l_tmp.tmp106 = l_iscb.isaa027
      
      #1076-1081：空白欄補零(6碼)
      LET l_tmp.tmp107 = 0 USING "&&&&&&"
      
      #1082：自行或委託辦理申報註記(1碼)
      LET l_tmp.tmp108 = l_iscb.isaa010
      
      #1083-1092：申報人身分證統一編號(10碼)
      LET l_tmp.tmp109 = l_iscb.isaa030
      
      #1093-1104：申報人姓名(12碼)
      CALL aisp430_convert(12,l_iscb.isaa003) RETURNING l_tmp.tmp110
      
      #1105-1108：申報人電話區域碼(4碼)
      LET l_tmp.tmp111 = l_iscb.isaa028
      
      #1109-1119：申報人電話(11碼)
      LET l_tmp.tmp112 = l_iscb.isaa005
      
      #1120-1124：申報人電話分機(5碼)
      LET l_tmp.tmp113 = l_iscb.isaa029
      
      #1125-1174：代理申報人登錄(文)字號(50碼)
      CALL aisp430_convert(50,l_iscb.isaa020) RETURNING l_tmp.tmp114
      
      
      #因為是特種行業使用(404)故此一律給0 ----------
      #購買國外勞務項目
      #1175-1186：外國保險業再保費收入給付金額(12碼)
      LET l_tmp.tmp115 = 0 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp115,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp115
      
      #1187-1198：第11條各業專屬本業勞務給付金額(不含銀行業、保險業經營銀行、保險本業收入)(12碼)
      LET l_tmp.tmp116 = 0 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp116,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp116
      
      #1199-1210：其他給付金額(含銀行業、保險業經營銀行、保險本業收入)(12碼)
      LET l_tmp.tmp117 = 0 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp117,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp117
      
      #1211-1220：外國保險業再保費收入稅額(10碼)
      LET l_tmp.tmp118 = 0 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp118,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp118
      
      #1221-1230：第11條各業專屬本業勞務稅額(不含銀行業、保險業經營銀行、保險本業收入)(10碼)
      LET l_tmp.tmp119 = 0 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp119,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp119
      
      #1231-1240：其他稅額(含銀行業、保險業經營銀行、保險本業收入)(10碼)
      LET l_tmp.tmp120 = 0 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp120,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp120
      #因為是特種行業使用(404)故此一律給0 end-------
      
      
      #銀行業、保險業經營銀行、保險本業收入5%
      #1241-1252：銷售額(12碼)
      CALL aisp430_value_pn(l_iscb.iscb084) RETURNING g_sub_success,l_value
      LET l_tmp.tmp121 = l_iscb.iscb084 USING "&&&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp121,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp121
      
      #1253-1262：稅額(10碼)
      CALL aisp430_value_pn(l_iscb.iscb085) RETURNING g_sub_success,l_value
      LET l_tmp.tmp122 = l_iscb.iscb085 USING "&&&&&&&&&&"
      CALL aisp430_change_last_type(l_tmp.tmp122,"TET",l_value) RETURNING g_sub_success,l_tmp.tmp122
      
      
      #1263-1266：空白欄補零(4碼)
      LET l_tmp.tmp123 = 0 USING "&&&&"
      
   
      #組成一長條的數字資料
      LET l_in_txt = l_tmp.tmp001,l_tmp.tmp002,l_tmp.tmp003,l_tmp.tmp004,l_tmp.tmp005,
                     l_tmp.tmp006,l_tmp.tmp007,l_tmp.tmp008,l_tmp.tmp009,l_tmp.tmp010,
                     l_tmp.tmp011,l_tmp.tmp012,l_tmp.tmp013,l_tmp.tmp014,l_tmp.tmp015,
                     l_tmp.tmp016,l_tmp.tmp017,l_tmp.tmp018,l_tmp.tmp019,l_tmp.tmp020,
                     l_tmp.tmp021,l_tmp.tmp022,l_tmp.tmp023,l_tmp.tmp024,l_tmp.tmp025,
                     l_tmp.tmp026,l_tmp.tmp027,l_tmp.tmp028,l_tmp.tmp029,l_tmp.tmp030,
                     l_tmp.tmp031,l_tmp.tmp032,l_tmp.tmp033,l_tmp.tmp034,l_tmp.tmp035,
                     l_tmp.tmp036,l_tmp.tmp037,l_tmp.tmp038,l_tmp.tmp039,l_tmp.tmp040,
                     l_tmp.tmp041,l_tmp.tmp042,l_tmp.tmp043,l_tmp.tmp044,l_tmp.tmp045,
                     l_tmp.tmp046,l_tmp.tmp047,l_tmp.tmp048,l_tmp.tmp049,l_tmp.tmp050,
                     l_tmp.tmp051,l_tmp.tmp052,l_tmp.tmp053,l_tmp.tmp054,l_tmp.tmp055,
                     l_tmp.tmp056,l_tmp.tmp057,l_tmp.tmp058,l_tmp.tmp059,l_tmp.tmp060,
                     l_tmp.tmp061,l_tmp.tmp062,l_tmp.tmp063,l_tmp.tmp064,l_tmp.tmp065,
                     l_tmp.tmp066,l_tmp.tmp067,l_tmp.tmp068,l_tmp.tmp069,l_tmp.tmp070,
                     l_tmp.tmp071,l_tmp.tmp072,l_tmp.tmp073,l_tmp.tmp074,l_tmp.tmp075,
                     l_tmp.tmp076,l_tmp.tmp077,l_tmp.tmp078,l_tmp.tmp079,l_tmp.tmp080,
                     l_tmp.tmp081,l_tmp.tmp082,l_tmp.tmp083,l_tmp.tmp084,l_tmp.tmp085,
                     l_tmp.tmp086,l_tmp.tmp087,l_tmp.tmp088,l_tmp.tmp089,l_tmp.tmp090,
                     l_tmp.tmp091,l_tmp.tmp092,l_tmp.tmp093,l_tmp.tmp094,l_tmp.tmp095,
                     l_tmp.tmp096,l_tmp.tmp097,l_tmp.tmp098,l_tmp.tmp099,l_tmp.tmp100,
                     l_tmp.tmp101,l_tmp.tmp102,l_tmp.tmp103,l_tmp.tmp104,l_tmp.tmp105,
                     l_tmp.tmp106,l_tmp.tmp107,l_tmp.tmp108,l_tmp.tmp109,l_tmp.tmp110,
                     l_tmp.tmp111,l_tmp.tmp112,l_tmp.tmp113,l_tmp.tmp114,l_tmp.tmp115,
                     l_tmp.tmp116,l_tmp.tmp117,l_tmp.tmp118,l_tmp.tmp119,l_tmp.tmp120,
                     l_tmp.tmp121,l_tmp.tmp122,l_tmp.tmp123
      CALL ch.write(l_in_txt)
      LET r_write = "Y"
      
   END FOREACH

   #存放TXT part2 start----------
   #轉成BIG-5+轉換成DOS格式
   LET l_cmd = "iconv -c -f UTF-8 -t BIG-5  ",l_file_name ,"|awk 'sub(\"$\", \"\\r\")' >",l_file_name2 
   RUN l_cmd
   
   #取得user要存放TXT的路徑(user電腦端)
   LET ls_target_file = os.Path.join(g_dir CLIPPED,l_file_name2 CLIPPED)
   
   #取得存放TXT端的路徑(伺服器端)
   LET ls_source_file = os.Path.join(FGL_GETENV("TEMPDIR"),l_file_name2 CLIPPED)
   
   #EXAMPLE:CALL FGL_PUTFILE(ls_source_file,"C:\\Users\\bartscott\\Desktop\\5.1/aaa.txt.2")
   CALL FGL_PUTFILE(ls_source_file,ls_target_file)
   CALL ch.close() 
   #存放TXT part2 end------------
   
   RETURN r_success,r_write
END FUNCTION

################################################################################
# Descriptions...: 判斷數字是正還是負
# Memo...........: #150518-00039#3
# Usage..........: CALL aisp430_value_pn()
# Date & Author..: 2015/07/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_value_pn(p_money)
DEFINE p_money         LIKE isca_t.isca101
DEFINE r_success       LIKE type_t.num5
DEFINE r_value         LIKE type_t.chr1    #判斷正負 Y:正 N:負

   LET r_success = TRUE
   
   LET r_value = "Y"
   IF p_money < 0 THEN LET r_value = "N" END IF
   
   RETURN r_success,r_value
   
END FUNCTION

################################################################################
# Descriptions...: 金額最後一碼轉換
# Memo...........: #150224-00005#30
# Usage..........: CALL aisp430_change_last_type()
# Input parameter: p_money    金額
#                : p_type     型態
# Date & Author..: 2015/06/23 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_change_last_type(p_money,p_type,p_value)
DEFINE p_money         STRING
DEFINE p_type          STRING
DEFINE p_value         LIKE type_t.chr1  #判斷正負 Y:正 N:負
DEFINE l_len           LIKE type_t.num5
DEFINE l_last_word     STRING
DEFINE r_success       LIKE type_t.num5
DEFINE r_money         STRING

   LET r_success = TRUE
   
   IF cl_null(p_money) THEN
      LET r_success = FALSE
      RETURN r_success,p_money
   END IF
   
   #取得該金額長度EX：12345>>5位
   LET l_len = p_money.getLength()
   
   #取得該金額最後一位數字EX：12345>>5
   LET l_last_word = p_money.getCharAt(l_len)
   
   #擷取該金額(不含最後一位數字)EX：12345>>1234
   LET r_money = p_money.substring(1,l_len-1)
   
   #轉換最後一位數字EX：12345>>5>>E
   #固定資產
   IF p_type = "T08" THEN
      CASE l_last_word
         WHEN "0"
            LET l_last_word = "{"
         WHEN "1"
            LET l_last_word = "A"
         WHEN "2"
            LET l_last_word = "B"
         WHEN "3"
            LET l_last_word = "C"
         WHEN "4"
            LET l_last_word = "D"
         WHEN "5"
            LET l_last_word = "E"
         WHEN "6"
            LET l_last_word = "F"
         WHEN "7"
            LET l_last_word = "G"
         WHEN "8"
            LET l_last_word = "H"
         WHEN "9"
            LET l_last_word = "I"
      END CASE
   END IF
   
   #直接扣抵/銷售額與稅額申報書
   IF p_type = "T01" OR p_type = "TET" THEN
      IF p_value = "Y" THEN
         CASE l_last_word
            WHEN "0"
               LET l_last_word = "{"
            WHEN "1"
               LET l_last_word = "A"
            WHEN "2"
               LET l_last_word = "B"
            WHEN "3"
               LET l_last_word = "C"
            WHEN "4"
               LET l_last_word = "D"
            WHEN "5"
               LET l_last_word = "E"
            WHEN "6"
               LET l_last_word = "F"
            WHEN "7"
               LET l_last_word = "G"
            WHEN "8"
               LET l_last_word = "H"
            WHEN "9"
               LET l_last_word = "I"
         END CASE
      ELSE
         CASE l_last_word
            WHEN "0"
               LET l_last_word = "}"
            WHEN "1"
               LET l_last_word = "J"
            WHEN "2"
               LET l_last_word = "K"
            WHEN "3"
               LET l_last_word = "L"
            WHEN "4"
               LET l_last_word = "M"
            WHEN "5"
               LET l_last_word = "N"
            WHEN "6"
               LET l_last_word = "O"
            WHEN "7"
               LET l_last_word = "P"
            WHEN "8"
               LET l_last_word = "Q"
            WHEN "9"
               LET l_last_word = "R"
         END CASE
      END IF
   END IF
   
   
   #最後在組合起來EX：1234+E>>1234E
   LET r_money = r_money,l_last_word
   
   RETURN r_success,r_money
END FUNCTION

################################################################################
# Descriptions...: 填補轉成big5少的空白
# Memo...........: #150518-00039#3 FROM anmp490
# Usage..........: CALL aisp430_convert()
# Input parameter: p_cnt      傳入該欄位的長度
#                : p_string   傳入要轉換的字
# Date & Author..: 2015/07/08 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp430_convert(p_cnt,p_string)
DEFINE l_length    LIKE type_t.num5
DEFINE l_lb        LIKE type_t.num5
DEFINE l_sum       LIKE type_t.num5
DEFINE l_i         LIKE type_t.num5
DEFINE l_en        LIKE type_t.num5
DEFINE l_sumtrue   LIKE type_t.num5
DEFINE r_string    VARCHAR(2000)
DEFINE p_string    STRING
DEFINE p_cnt       LIKE type_t.num5
DEFINE l_space     STRING
   
   LET l_space = ''
   LET r_string = p_string
   IF cl_null (r_string) THEN
      FOR l_i = 1 to p_cnt
        LET l_space = l_space,'#'
      END FOR
      LET r_string = r_string USING l_space
   ELSE
      SELECT LENGTHB(r_string) INTO l_length FROM dual #取得字串長度
  
      FOR l_i = 1 TO l_length
         SELECT LENGTHB(SUBSTR(r_string,l_i,1)) INTO l_lb FROM dual
         IF l_lb > 1 THEN  #big5的長度
            LET l_sum = l_sum + 2
         ELSE
            LET l_sum = l_sum + 1
         END IF 
         LET l_sumtrue = l_sumtrue + l_lb #字串原始的長度
         IF l_sum = p_cnt THEN
            EXIT FOR
         END IF
         IF l_sum > p_cnt THEN
            IF l_lb > 1 THEN  #big5的長度
               LET l_sum = l_sum - 2
            ELSE
               LET l_sum = l_sum - 1
            END IF
            LET l_sumtrue = l_sumtrue - l_lb #字串原始的長度
            EXIT FOR
         END IF
         IF l_sumtrue >= l_length THEN EXIT FOR END IF
      END FOR
      SELECT SUBSTRB(r_string,1,l_sumtrue) INTO r_string FROM dual
      LET l_en = p_cnt -l_sum 
      LET r_string = r_string,l_en SPACES
   END IF
   
   RETURN r_string
END FUNCTION

#end add-point
 
{</section>}
 
