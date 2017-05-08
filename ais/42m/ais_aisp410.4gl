#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2017-02-03 14:47:57), PR版次:0015(2017-02-20 11:02:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: aisp410
#+ Description: 銷項發票擷取作業
#+ Creator....: 04152(2015-03-19 09:53:38)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp410.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150422-00012#1  2015/04/28 By Reanna 增加申報歸屬月份
#150512-00024#2  2015/06/05 By Reanna 抓取零稅率資訊&拿掉QBE格式&一般發票改取歷程檔isat_t
#150624-00005#6  2015/06/26 By Jessy  處理排程相關程式
#150915-00013#2  2015/09/15 By Reanna 零稅率金額改抓本幣、增加條件：作廢發票僅限於同張單據上即可、作廢發票課稅別要給F
#150925          2015/09/25 By Reanna 抓取銷項對帳單排除狀態=N
#150922-00021#5  2015/10/01 By Jessy  增加零稅率選項
#151005-00007#2  2015/10/08 By Hans   擷取isat時只需判斷, where isat014 ='11' or '21'  # 開立那筆
#151014-00019#3  2015/10/28 By Reanna 沒有對應的申報格式之發票不寫入媒體檔
#151013-00019#7  2015/10/28 By Reanna 刪除SQL要分零稅率跟非零稅率
#160308-00006#2  2016/03/24 By Reanna 因aist310作廢增加回收發票號碼機制，所以這裡擷取時要排除回收的號碼
#161130-00033#1  2016/11/30 By 06821  主 SQL 的狀態碼(isafstus)條件應為 Y,否則會抓到作廢資料PREPARE sel_isat_p,PREPARE sel_isaf_p
#161212-00023#1  2016/12/12 By Reanna 還原#161130-00033#1
#161220-00008#1  2016/12/23 By 06821  aist310 作廢狀態且發票性質為 2:扣抵折讓單 時不納入媒體申報中
#170112-00008#1  2017/01/12 By Reanna [零稅率選項]預設從原本的2調整為3全部
#161228-00045#1  2017/02/03 By Reanna 零稅率資料改用 isat_t 為主
#                                     畫面增加 零稅率清單是否產生貨品明細資料 勾選條件
#                                     增加過濾條件通關方式(isaf060)不為 null
#                                     課稅別改抓基礎資料的課稅別為主，不使用isaf054
#170218-00007#1  2017/02/20 By Reanna 零稅率作廢發票須改放入銷項發票清單內
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
   #150624-00005#6-----s
   isaa001        LIKE isaa_t.isaa001, 
   isaa012        LIKE isaa_t.isaa012, 
   isaa013        LIKE isaa_t.isaa013, 
   isaa013_2      LIKE type_t.num5, 
   l_report_date  LIKE type_t.num5, 
   isaf060        LIKE isaf_t.isaf060,   #150922-00021#5 add isaf060
   l_space        LIKE type_t.chr500,
   l_chk2         LIKE type_t.chr500,    #161228-00045#1
   #150624-00005#6-----e
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
   isaa012 LIKE isaa_t.isaa012, 
   isaa013 LIKE isaa_t.isaa013, 
   isaa013_2 LIKE type_t.num5, 
   l_report_date LIKE type_t.num5, 
   isaf060 LIKE isaf_t.isaf060, 
   l_space LIKE type_t.chr500, 
   l_chk2 LIKE type_t.chr500, 
   isat007 LIKE isat_t.isat007, 
   isat004 LIKE isat_t.isat004, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_isaosite STRING
DEFINE g_ooef017     LIKE ooef_t.ooef017
DEFINE g_ooef019     LIKE ooef_t.ooef019
DEFINE g_isaa007     LIKE isaa_t.isaa007  #150422-00012#1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisp410.main" >}
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
      CALL aisp410_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp410 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp410_init()
 
      #進入選單 Menu (="N")
      CALL aisp410_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp410
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp410.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp410_init()
 
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
#   CALL cl_set_combo_scc('isaf060','9736')   #150922-00021#5
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp410.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp410_ui_dialog()
 
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
   DEFINE l_lastday    LIKE type_t.num10
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aisp410_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.isaa001,g_master.isaa012,g_master.isaa013,g_master.isaa013_2,g_master.l_report_date, 
             g_master.isaf060,g_master.l_space,g_master.l_chk2 
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
               #用申報單位取得營運據點&相關資料 #150422-00012#1 add g_isaa007
               CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
               
               CALL cl_set_comp_entry("isaa013_2",TRUE)
               IF g_isaa007 = 2 THEN
                  CALL cl_set_comp_entry("isaa013_2",FALSE)
               END IF
            END IF
            CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
            DISPLAY BY NAME g_master.isaa001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa001
            #add-point:BEFORE FIELD isaa001 name="input.b.isaa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa001
            #add-point:ON CHANGE isaa001 name="input.g.isaa001"
            
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
            IF NOT cl_null(g_master.isaa013) THEN
               #LET g_master.isaa013_2 = g_master.isaa013 + 1
               #IF g_master.isaa013 >= 12 THEN
               #   LET g_master.isaa013_2 = 12
               #END IF
               #150422-00012#1 add ------
               #帶出申報所屬月份
               #若為按期申報>>結束月份為奇數則+1變偶數月
               IF g_isaa007 = 1 THEN
                  LET g_master.isaa013_2 = g_master.isaa013 + 1
                  IF g_master.isaa013 >= 12 THEN
                     LET g_master.isaa013_2 = 12
                  END IF
                  IF g_master.isaa013_2 MOD 2 = 0 THEN
                     LET g_master.l_report_date = g_master.isaa013_2
                  ELSE
                     LET g_master.l_report_date = g_master.isaa013_2 + 1
                  END IF
               ELSE
                  LET g_master.isaa013_2 = g_master.isaa013
                  IF g_master.isaa013 >= 12 THEN
                     LET g_master.isaa013_2 = 12
                  END IF
                  LET g_master.l_report_date = g_master.isaa013_2
               END IF
               DISPLAY BY NAME g_master.l_report_date
               #150422-00012#1 add end---
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaa013_2
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.isaa013_2,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD isaa013_2
            END IF 
 
 
 
            #add-point:AFTER FIELD isaa013_2 name="input.a.isaa013_2"
            IF NOT cl_null(g_master.isaa013) AND NOT cl_null(g_master.isaa013_2) THEN
               #月份不可小於起始月份
               IF g_master.isaa013 > g_master.isaa013_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00147'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #150422-00012#1 add ------
               #帶出申報所屬月份
               #若為按期申報>>結束月份為奇數則+1變偶數月
               IF g_isaa007 = 1 THEN
                  IF g_master.isaa013_2 MOD 2 = 0 THEN
                     LET g_master.l_report_date = g_master.isaa013_2
                  ELSE
                     LET g_master.l_report_date = g_master.isaa013_2 + 1
                  END IF
               ELSE
                  LET g_master.l_report_date = g_master.isaa013_2
               END IF
               DISPLAY BY NAME g_master.l_report_date
               #150422-00012#1 add end---
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaa013_2
            #add-point:BEFORE FIELD isaa013_2 name="input.b.isaa013_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaa013_2
            #add-point:ON CHANGE isaa013_2 name="input.g.isaa013_2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_report_date
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_report_date,"0","0","12","1","azz-00087",1) THEN
               NEXT FIELD l_report_date
            END IF 
 
 
 
            #add-point:AFTER FIELD l_report_date name="input.a.l_report_date"
            IF NOT cl_null(g_master.l_report_date) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_report_date
            #add-point:BEFORE FIELD l_report_date name="input.b.l_report_date"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_report_date
            #add-point:ON CHANGE l_report_date name="input.g.l_report_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf060
            #add-point:BEFORE FIELD isaf060 name="input.b.isaf060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf060
            
            #add-point:AFTER FIELD isaf060 name="input.a.isaf060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaf060
            #add-point:ON CHANGE isaf060 name="input.g.isaf060"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_space
            #add-point:BEFORE FIELD l_space name="input.b.l_space"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_space
            
            #add-point:AFTER FIELD l_space name="input.a.l_space"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_space
            #add-point:ON CHANGE l_space name="input.g.l_space"
            
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
 
 
         #Ctrlp:input.c.isaa013_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaa013_2
            #add-point:ON ACTION controlp INFIELD isaa013_2 name="input.c.isaa013_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_report_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_report_date
            #add-point:ON ACTION controlp INFIELD l_report_date name="input.c.l_report_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.isaf060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf060
            #add-point:ON ACTION controlp INFIELD isaf060 name="input.c.isaf060"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_space
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_space
            #add-point:ON ACTION controlp INFIELD l_space name="input.c.l_space"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isat007,isat004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat007
            #add-point:BEFORE FIELD isat007 name="construct.b.isat007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat007
            
            #add-point:AFTER FIELD isat007 name="construct.a.isat007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat007
            #add-point:ON ACTION controlp INFIELD isat007 name="construct.c.isat007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isat004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isat004
            #add-point:ON ACTION controlp INFIELD isat004 name="construct.c.isat004"
            #c開窗-發票號碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
            CALL s_date_get_max_day(g_master.isaa012,g_master.isaa013_2) RETURNING l_lastday
            LET l_day2= MDY(g_master.isaa013_2,l_lastday,g_master.isaa012)
            LET g_qryparam.where = " isafstus = 'Y' AND isaf052 IN ",g_wc_isaosite," AND isat007 BETWEEN '",l_day1,"' AND '",l_day2,"'"
            CALL q_isat004()
            DISPLAY g_qryparam.return1 TO isat004
            NEXT FIELD isat004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isat004
            #add-point:BEFORE FIELD isat004 name="construct.b.isat004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isat004
            
            #add-point:AFTER FIELD isat004 name="construct.a.isat004"
            
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
            CALL aisp410_get_buffer(l_dialog)
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
            CALL aisp410_qbe_clear()
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
         CALL aisp410_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150624-00005#6-----s
      LET lc_param.isaa001       = g_master.isaa001
      LET lc_param.isaa012       = g_master.isaa012
      LET lc_param.isaa013       = g_master.isaa013
      LET lc_param.isaa013_2     = g_master.isaa013_2
      LET lc_param.l_report_date = g_master.l_report_date
      LET lc_param.isaf060       = g_master.isaf060         #150922-00021#5 add isaf060
      LET lc_param.l_space       = g_master.l_space
      LET lc_param.l_chk2       = g_master.l_chk2           #161228-00045#1
      #150624-00005#6-----e
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
                 CALL aisp410_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp410_transfer_argv(ls_js)
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
 
{<section id="aisp410.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp410_transfer_argv(ls_js)
 
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
 
{<section id="aisp410.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp410_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_cnt2        LIKE type_t.num10   #151013-00019#7
   DEFINE l_sql         STRING
   DEFINE l_wc          STRING
   DEFINE l_write       LIKE type_t.chr1    #判斷是否寫入
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #150624-00005#6-----s
   #將傳遞參數變數傳回給畫面上的變數
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc            = lc_param.wc
      LET g_master.isaa001       = lc_param.isaa001
      LET g_master.isaa012       = lc_param.isaa012
      LET g_master.isaa013       = lc_param.isaa013
      LET g_master.isaa013_2     = lc_param.isaa013_2
      LET g_master.l_report_date = lc_param.l_report_date
      LET g_master.isaf060       = lc_param.isaf060         #150922-00021#5 add isaf060
      LET g_master.l_space       = lc_param.l_space
      CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
   END IF
   #150624-00005#6-----e
   
   IF cl_null(g_master.isaa001) OR cl_null(g_master.isaa012) OR
      cl_null(g_master.isaa013) OR cl_null(g_master.isaa013_2) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
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
#  DECLARE aisp410_process_cs CURSOR FROM ls_sql
#  FOREACH aisp410_process_cs INTO
   #add-point:process段process name="process.process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF
   
   #此為了先檢查有無資料存在，需先轉換成產生目的table格式
   LET l_wc = g_master.wc
   CALL s_chr_replace(l_wc,'isat007','isaj009',0) RETURNING l_wc
   CALL s_chr_replace(l_wc,'isat004','isaj006',0) RETURNING l_wc
   CALL s_chr_replace(l_wc,'isaf019','isaj018',0) RETURNING l_wc
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   LET l_write = 'N'
   
   #先看看有沒有資料存在，若有則詢問是否重新產生??
   #151013-00019#7 mark ------
   #LET l_sql = "SELECT COUNT(*)",
   #            "  FROM isaj_t",
   #            " WHERE isajent  = ",g_enterprise,
   #            "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
   #            "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 <> 'D'",
   #            "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
   #            "   AND ",l_wc
   ##150922-00021#5----s
   ##增加通關方式條件
   #CASE
   #   WHEN g_master.isaf060 = '1' 
   #      LET l_sql = l_sql," AND isaj024 = '1'"
   #   WHEN g_master.isaf060 = '2' 
   #      LET l_sql = l_sql," AND isaj024 = '2'"
   #END CASE
   ##150922-00021#5----e 
   #PREPARE isaj_pb1 FROM l_sql
   #EXECUTE isaj_pb1 INTO l_cnt
   #IF l_cnt > 0 THEN
   #151013-00019#7 mark end---
   #151013-00019#7 add ------
   #一般銷項發票
   LET l_sql = "SELECT COUNT(*)",
               "  FROM isaj_t",
               " WHERE isajent  = ",g_enterprise,
               "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
               "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 NOT IN ('2','D') ", #不含2.零稅/D.空白
               "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
               "   AND ",l_wc
   PREPARE isaj_pb1 FROM l_sql
   EXECUTE isaj_pb1 INTO l_cnt
   #零稅率
   LET l_sql = "SELECT COUNT(*)",
               "  FROM isaj_t",
               " WHERE isajent  = ",g_enterprise,
               "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
               "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 = '2'",
               "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
               "   AND ",l_wc
   #150922-00021#5----s
   #增加通關方式條件
   CASE
      WHEN g_master.isaf060 = '1' 
         LET l_sql = l_sql," AND isaj024 = '1'"
      WHEN g_master.isaf060 = '2' 
         LET l_sql = l_sql," AND isaj024 = '2'"
   END CASE
   #150922-00021#5----e
   PREPARE isaj_pb2 FROM l_sql
   EXECUTE isaj_pb2 INTO l_cnt2
   IF l_cnt > 0 OR l_cnt2 > 0 THEN
   #151013-00019#7 add end---
      IF NOT cl_ask_confirm('ais-00195') THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         #151013-00019#7 mark ------
         #LET l_sql = " DELETE FROM isaj_t",
         #            " WHERE isajent  = ",g_enterprise,
         #            "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
         #            "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 <> 'D'",
         #            "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
         #            "   AND ",l_wc
         ##150922-00021#5----s
         ##增加通關方式條件
         #CASE
         #   WHEN g_master.isaf060 = '1' 
         #      LET l_sql = l_sql," AND isaj024 = '1'"
         #   WHEN g_master.isaf060 = '2' 
         #      LET l_sql = l_sql," AND isaj024 = '2'"
         #END CASE
         ##150922-00021#5----e 
         #PREPARE isaj_pb2 FROM l_sql
         #EXECUTE isaj_pb2
         #IF SQLCA.sqlcode THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.sqlerr = SQLCA.sqlcode
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   LET g_success = 'N'
         #END IF
         #151013-00019#7 mark end---
         #151013-00019#7 add ------
         #一般銷項發票
         IF l_cnt > 0 THEN
            LET l_sql = " DELETE FROM isaj_t",
                        " WHERE isajent  = ",g_enterprise,
                        "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
                        "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 NOT IN ('2','D') ", #不含2.零稅/D.空白
                        "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
                        "   AND ",l_wc
            PREPARE isaj_pb3 FROM l_sql
            EXECUTE isaj_pb3
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.sqlerr = SQLCA.sqlcode
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
            END IF
         END IF
         #零稅率
         IF l_cnt2 > 0 THEN
            LET l_sql = " DELETE FROM isaj_t",
                        " WHERE isajent  = ",g_enterprise,
                        "   AND isajcomp = '",g_ooef017,"' AND isajsite IN ",g_wc_isaosite,
                        "   AND isaj001 = '1' AND isaj002 IS NOT NULL AND isaj015 = '2'",
                        "   AND isaj019 = ",g_master.isaa012," AND isaj020 BETWEEN ",g_master.isaa013," AND ",g_master.isaa013_2,
                        "   AND ",l_wc
            PREPARE isaj_pb4 FROM l_sql
            EXECUTE isaj_pb4
            #150922-00021#5----s
            #增加通關方式條件
            CASE
               WHEN g_master.isaf060 = '1' 
                  LET l_sql = l_sql," AND isaj024 = '1'"
               WHEN g_master.isaf060 = '2' 
                  LET l_sql = l_sql," AND isaj024 = '2'"
            END CASE
            #150922-00021#5----e
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.sqlerr = SQLCA.sqlcode
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
            END IF
         END IF
         #151013-00019#7 add end---
      END IF
   END IF

   IF g_success = 'Y' THEN
      #抓取銷項發票
      CALL aisp410_invoice(g_master.isaa001,g_master.isaa012,g_master.isaa013,g_master.isaa013_2,g_master.isaf060,g_master.wc) RETURNING g_sub_success,l_write  #150922-00021#5 add isaf060
      IF NOT g_sub_success THEN
         LET g_success = 'N'
      ELSE
         IF g_master.l_space = 'Y' THEN
            #抓取空白發票 #150422-00012#1 add l_report_date
            CALL s_aisp440_space_invoice(g_master.isaa001,g_master.isaa012,g_master.isaa013,g_master.isaa013_2,g_master.l_report_date)
                 RETURNING g_sub_success,l_write
            IF NOT g_sub_success THEN
               LET g_success = 'N'
            END IF
         END IF
      END IF
   END IF
   
   IF g_success = 'Y' THEN
      IF l_write = 'Y' THEN
         CALL s_transaction_end('Y','0')
         LET g_bgjob = "N"
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00230'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET g_bgjob = "Y"
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET g_bgjob = "Y"
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
   CALL aisp410_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp410.get_buffer" >}
PRIVATE FUNCTION aisp410_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.isaa001 = p_dialog.getFieldBuffer('isaa001')
   LET g_master.isaa012 = p_dialog.getFieldBuffer('isaa012')
   LET g_master.isaa013 = p_dialog.getFieldBuffer('isaa013')
   LET g_master.isaa013_2 = p_dialog.getFieldBuffer('isaa013_2')
   LET g_master.l_report_date = p_dialog.getFieldBuffer('l_report_date')
   LET g_master.isaf060 = p_dialog.getFieldBuffer('isaf060')
   LET g_master.l_space = p_dialog.getFieldBuffer('l_space')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp410.msgcentre_notify" >}
PRIVATE FUNCTION aisp410_msgcentre_notify()
 
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
 
{<section id="aisp410.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aisp410_qbe_clear()
# Date & Author..: 2015/03/19 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp410_qbe_clear()
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
   ELSE
      CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
      #用申報單位取得營運據點&相關資料 #150422-00012#1 add g_isaa007
      CALL s_aisp440_get_site_info(g_master.isaa001) RETURNING g_wc_isaosite,g_ooef017,g_ooef019,g_isaa007
   END IF
   CALL s_desc_get_department_desc(g_master.isaa001) RETURNING g_master.isaa001_desc
   LET g_master.isaa012 = YEAR(g_today)
   #LET g_master.isaf060 = '2'        #150922-00021#5 add isaf060 #170112-00008#1 mark
   LET g_master.isaf060 = '3'         #170112-00008#1
   LET g_master.l_space = 'N'
   
   CALL cl_set_comp_entry("isaa013_2",TRUE)
   IF g_isaa007 = 2 THEN
      CALL cl_set_comp_entry("isaa013_2",FALSE)
   END IF
   
   LET g_master.l_chk2 = 'N' #161228-00045#1
   
   DISPLAY BY NAME g_master.isaa001,g_master.isaa001_desc,g_master.isaa012,g_master.l_space,g_master.isaf060 
   
END FUNCTION

################################################################################
# Descriptions...: 抓取銷項發票
# Memo...........:
# Usage..........: CALL aisp410_invoice(p_isaa001,p_isaa012,p_isaa013,p_isaa013_2,p_isaf060,p_wc)
#                : p_isaa001   申報單位
#                : p_isaa012   年
#                : p_isaa013   月start
#                : p_isaa013_2 月end
#                : p_isaf060   通關條件 
#                : p_wc        條件
# Date & Author..: 2015/03/19 By Reanna
# Modify.........: #150922-00021#5 151002 By Jessy add isaf060
################################################################################
PRIVATE FUNCTION aisp410_invoice(p_isaa001,p_isaa012,p_isaa013,p_isaa013_2,p_isaf060,p_wc)
DEFINE p_isaa001    LIKE isaa_t.isaa001
DEFINE p_isaa012    LIKE isaa_t.isaa012
DEFINE p_isaa013    LIKE isaa_t.isaa013
DEFINE p_isaa013_2  LIKE isaa_t.isaa013
DEFINE p_isaf060    LIKE isaf_t.isaf060  #150922-00021#5
DEFINE p_wc         STRING
DEFINE l_sql        STRING
DEFINE l_i          LIKE type_t.num5
DEFINE l_ac         LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_str        STRING
DEFINE l_day1       LIKE type_t.dat
DEFINE l_day2       LIKE type_t.dat
DEFINE l_lastday    LIKE type_t.num10
DEFINE l_isat       RECORD
#150512-00024#2 add ------
            isatcomp   LIKE isat_t.isatcomp,
            isatsite   LIKE isat_t.isatsite,
            isatdocno  LIKE isat_t.isatdocno,
            isatdocdt  LIKE isat_t.isatdocdt,
#150512-00024#2 add end---
            isat001    LIKE isat_t.isat001,
            isat002    LIKE isat_t.isat002,
            isat003    LIKE isat_t.isat003,
            isat004    LIKE isat_t.isat004,
            isat007    LIKE isat_t.isat007,
            isat010    LIKE isat_t.isat010,
            isat012    LIKE isat_t.isat012,
            isat014    LIKE isat_t.isat014,
            isat022    LIKE isat_t.isat022,
            isat023    LIKE isat_t.isat023,
            isat113    LIKE isat_t.isat113,
            isat114    LIKE isat_t.isat114,
            isat115    LIKE isat_t.isat115,
            isat025    LIKE isat_t.isat025 #151005-00007#2
                    END RECORD
#150512-00024#2 add ------
DEFINE l_isaf       RECORD
            isafcomp   LIKE isaf_t.isafcomp,
            isafsite   LIKE isaf_t.isafsite,
            isafdocno  LIKE isaf_t.isafdocno,
            isafdocdt  LIKE isaf_t.isafdocdt,
            isaf002    LIKE isaf_t.isaf002,
            isaf008    LIKE isaf_t.isaf008,
            isaf009    LIKE isaf_t.isaf009,
            isaf010    LIKE isaf_t.isaf010,
            isaf011    LIKE isaf_t.isaf011,
            isaf014    LIKE isaf_t.isaf014,
            isaf018    LIKE isaf_t.isaf018,
            isaf021    LIKE isaf_t.isaf021,
            isaf022    LIKE isaf_t.isaf022,
            isaf028    LIKE isaf_t.isaf028,
            isaf035    LIKE isaf_t.isaf035,
            isaf051    LIKE isaf_t.isaf051,
            isaf054    LIKE isaf_t.isaf054,
            isaf059    LIKE isaf_t.isaf059,
            isaf060    LIKE isaf_t.isaf060,
            isaf061    LIKE isaf_t.isaf061,
            isaf062    LIKE isaf_t.isaf062,
            isaf063    LIKE isaf_t.isaf063,
            isaf064    LIKE isaf_t.isaf064,
            isaf065    LIKE isaf_t.isaf065,
            isah004    LIKE isah_t.isah004,
            isah006    LIKE isah_t.isah006,
           #isah103    LIKE isah_t.isah103, #150915-00013#2 mark
           #isah104    LIKE isah_t.isah104, #150915-00013#2 mark
           #isah105    LIKE isah_t.isah105, #150915-00013#2 mark
            isah113    LIKE isah_t.isah113, #150915-00013#2
            isah114    LIKE isah_t.isah114, #150915-00013#2
            isah115    LIKE isah_t.isah115  #150915-00013#2
                    END RECORD
#150512-00024#2 add end---
DEFINE l_isaj       RECORD
            isajent    LIKE isaj_t.isajent,
            isajcomp	  LIKE isaj_t.isajcomp,
            isajsite   LIKE isaj_t.isajsite,
            isajdocdt  LIKE isaj_t.isajdocdt,
            isaj001    LIKE isaj_t.isaj001,
            isaj002    LIKE isaj_t.isaj002,
            isaj003    LIKE isaj_t.isaj003,
            isaj004    LIKE isaj_t.isaj004,
            isaj005    LIKE isaj_t.isaj005,
            isaj006    LIKE isaj_t.isaj006,
            isaj007    LIKE isaj_t.isaj007,
            isaj008    LIKE isaj_t.isaj008,
            isaj009    LIKE isaj_t.isaj009,
            isaj010    LIKE isaj_t.isaj010,
            isaj011    LIKE isaj_t.isaj011,
            isaj012    LIKE isaj_t.isaj012,
            isaj013    LIKE isaj_t.isaj013,
            isaj014    LIKE isaj_t.isaj014,
            isaj015    LIKE isaj_t.isaj015,
            isaj016    LIKE isaj_t.isaj016,
            isaj017    LIKE isaj_t.isaj017,
            isaj018    LIKE isaj_t.isaj018,
            isaj019    LIKE isaj_t.isaj019,
            isaj020    LIKE isaj_t.isaj020,
            isaj021    LIKE isaj_t.isaj021,
            isaj022    LIKE isaj_t.isaj022,
            isaj023    LIKE isaj_t.isaj023,
            isaj024    LIKE isaj_t.isaj024,
            isaj025    LIKE isaj_t.isaj025,
            isaj026    LIKE isaj_t.isaj026,
            isaj027    LIKE isaj_t.isaj027,
            isaj028    LIKE isaj_t.isaj028,
            isaj029	  LIKE isaj_t.isaj029,
            isaj030	  LIKE isaj_t.isaj030,
            isaj031    LIKE isaj_t.isaj031,
            isaj032    LIKE isaj_t.isaj032,
            isaj103	  LIKE isaj_t.isaj103,
            isaj104	  LIKE isaj_t.isaj104,
            isaj105	  LIKE isaj_t.isaj105,
            isajstus   LIKE isaj_t.isajstus,
            isajownid  LIKE isaj_t.isajownid,
            isajowndp  LIKE isaj_t.isajowndp,
            isajcrtid  LIKE isaj_t.isajcrtid,
            isajcrtdp  LIKE isaj_t.isajcrtdp,
            isajcrtdt  LIKE isaj_t.isajcrtdt,
            isajmodid  LIKE isaj_t.isajmodid,
            isajmoddt  LIKE isaj_t.isajmoddt,
            isaj033	  LIKE isaj_t.isaj033,    #150512-00024#2 add
            isaj034	  LIKE isaj_t.isaj034,    #150512-00024#2 add
            isaj035	  LIKE isaj_t.isaj035,    #150512-00024#2 add
            isaj036	  LIKE isaj_t.isaj036,    #150512-00024#2 add
            isaj037	  LIKE isaj_t.isaj037     #150512-00024#2 add
                    END RECORD
DEFINE l_date       DATETIME YEAR TO SECOND
DEFINE r_success    LIKE type_t.num5
DEFINE r_write       LIKE type_t.chr1    #判斷是否寫入
   
   LET r_success = TRUE
   LET r_write = 'N'
   
   #抓取日期範圍
   LET l_day1= MDY(g_master.isaa013,1,g_master.isaa012)
   CALL s_date_get_max_day(g_master.isaa012,g_master.isaa013_2) RETURNING l_lastday
   LET l_day2= MDY(g_master.isaa013_2,l_lastday,g_master.isaa012)
      
   #撈取銷項發票
   #本來是用申報單位為key去撈出銷項發票
   #150323改成用申報單位找出營運據點，在用營運據點去撈出銷項發票
   #150408若有張3/1對帳單登錄2/28的發票，則該單申報要歸類在3、4月補申報，因此抓取區間範圍是以對帳單為主
   #150512-00024#2 換開發票時主檔不同，故設計成只取發票歷程檔isat_t
   #150512-00024#2 mark ------
   #LET l_sql = "SELECT isafcomp,isafdocno,isafdocdt,isaf002,isaf019,",
   #            "       isaf052,",
   #            "       isat001,isat002,isat003,isat004,isat007,",
   #            "       isat010,isat012,isat014,isat022,isat023,",
   #            "       isat113,isat114,isat115",
   #            "  FROM isaf_t",
   #            "  INNER JOIN isat_t ON isafent = isatent AND isafcomp = isatcomp AND isafdocno = isatdocno",
   #            " WHERE isafent = ",g_enterprise,
   #            "   AND isaf052 IN ",g_wc_isaosite,
   #            "   AND isafdocdt BETWEEN '",l_day1,"' AND '",l_day2,"'",
   #            "   AND isafstus = 'Y'",
   #            "   AND ",p_wc,
   #            " ORDER BY isat004,isat014"
   #PREPARE sel_isaf_p FROM l_sql
   #DECLARE sel_isaf_c CURSOR FOR sel_isaf_p
   #FOREACH sel_isaf_c INTO l_isaf.isafcomp,l_isaf.isafdocno,l_isaf.isafdocdt,l_isaf.isaf002,l_isaf.isaf019,
   #                        l_isaf.isaf052,
   #                        l_isat.isat001,l_isat.isat002,l_isat.isat003,l_isat.isat004,l_isat.isat007,
   #                        l_isat.isat010,l_isat.isat012,l_isat.isat014,l_isat.isat022,l_isat.isat023,
   #                        l_isat.isat113,l_isat.isat114,l_isat.isat115
   #150512-00024#2 mark end---
   #150512-00024#2 add ------
   LET l_sql = "SELECT isatcomp,isatsite,isatdocno,isatdocdt,",
               "       isat001,isat002,isat003,isat004,isat007,",
               "       isat010,isat012,isat014,isat022,isat023,",
              #"       isat113,isat114,isat115",         #150917 mark
              #"       isat113,isat114,isat115,isaf051", #150917 #151005-00007#2 mark
               "       isat113,isat114,isat115,isaf051,isat025", #151005-00007#2
               "  FROM isat_t",
               "  LEFT JOIN isaf_t ON isatent = isafent AND isatcomp = isafcomp AND isatdocno = isafdocno",
               " WHERE isatent = ",g_enterprise,
               "   AND isatsite IN ",g_wc_isaosite,
               "   AND isatdocdt BETWEEN '",l_day1,"' AND '",l_day2,"'",
               "   AND isat004 IS NOT NULL",
               #"   AND isaf054 <> '2' ", #去除課稅別=2.零稅 #161228-00045#1 mark
               "   AND isafstus <> 'N'", #150925  #161130-00033#1 mark #161212-00023#1 remark
               #"   AND isafstus = 'Y' ",         #161130-00033#1 add  #161212-00023#1 mark
               #161220-00008#1 --s add
               "   AND NOT EXISTS (SELECT 1 FROM isaf_t WHERE isafent = isatent AND isafcomp = isatcomp ",
               "                      AND isafdocno = isatdocno AND isafstus = 'X' AND isaf056 = '2') ",
               #161220-00008#1 --e add
               "   AND ",p_wc,
               "   AND isat014 IN ('11','21') ", #151005-00007#2
               "   AND isat025 <> '14'",         #160308-00006#2
               #170218-00007#1 mark ------
               ##161228-00045#1 add ------
               #"   AND EXISTS(SELECT 1 FROM oodb_t WHERE oodbent = isatent",
               #"                 AND oodb001 IN(SELECT ooef019 FROM ooef_t WHERE ooef001 = isatcomp ",
               #"                 AND ooefent = isatent) AND oodb002 = isaf016 AND oodb008 <> '2') ",
               ##161228-00045#1 add end---
               #170218-00007#1 mark end---
               #170218-00007#1 add ------
               #抓取銷項發票(排除零稅率)+零稅率作廢發票
               " AND (EXISTS(SELECT 1 FROM oodb_t WHERE oodbent = isatent",
               "                AND oodb001 IN(SELECT ooef019 FROM ooef_t WHERE ooef001 = isatcomp ",
               "                AND ooefent = isatent) AND oodb002 = isaf016 AND oodb008 <> '2') ",
               "   OR EXISTS(SELECT 1 FROM oodb_t WHERE oodbent = isatent",
               "                AND oodb001 IN(SELECT ooef019 FROM ooef_t WHERE ooef001 = isatcomp ",
               "                AND ooefent = isatent) AND oodb002 = isaf016 AND oodb008 = '2' AND isafstus <> 'Y') ",
               "     )",
               #170218-00007#1 add end---
               " ORDER BY isat004,isat014"
   
   PREPARE sel_isat_p FROM l_sql
   DECLARE sel_isat_c CURSOR FOR sel_isat_p
   FOREACH sel_isat_c INTO l_isat.isatcomp,l_isat.isatsite,l_isat.isatdocno,l_isat.isatdocdt,
                           l_isat.isat001,l_isat.isat002,l_isat.isat003,l_isat.isat004,l_isat.isat007,
                           l_isat.isat010,l_isat.isat012,l_isat.isat014,l_isat.isat022,l_isat.isat023,
                          #l_isat.isat113,l_isat.isat114,l_isat.isat115                #150917 mark
                          #l_isat.isat113,l_isat.isat114,l_isat.isat115,l_isaf.isaf051 #150917         #151005-00007#2 mark
                           l_isat.isat113,l_isat.isat114,l_isat.isat115,l_isaf.isaf051,l_isat.isat025  #151005-00007#2
   #150512-00024#2 add end---
      
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_isaj.* TO NULL
      
      #若同張發票存在不同狀態，EX一筆開立一筆作廢，則取作廢那張寫入，因為先開立才能去作作廢
      #151005-00007#2  mark ---s---
      #LET l_cnt = 0
      #SELECT COUNT(*) INTO l_cnt
      #  FROM isat_t
      # WHERE isatent = g_enterprise
      #   AND isat004 = l_isat.isat004
      #   AND isatdocno = l_isat.isatdocno #150915-00013#2
      #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      #IF l_cnt > 1 AND l_isat.isat014 <> '12' THEN
      #   CONTINUE FOREACH
      #END IF
      #151005-00007#2  mark ---e---
      
      LET l_isaj.isajent   =  g_enterprise                  # 企業編碼
      
     #LET l_isaj.isajcomp  =  l_isaf.isafcomp               # 法人編碼 #150512-00024#2 mark
      LET l_isaj.isajcomp  =  l_isat.isatcomp               # 法人編碼 #150512-00024#2 add
     #LET l_isaj.isajsite  =  l_isaf.isaf052                # 營運據點 #150512-00024#2 mark
      LET l_isaj.isajsite  =  l_isat.isatsite               # 營運據點 #150512-00024#2 add
     #LET l_isaj.isajdocdt =  l_isaf.isafdocdt              # 資料日期 #150512-00024#2 mark
      LET l_isaj.isajdocdt =  l_isat.isatdocdt              # 資料日期 #150512-00024#2 add
      
      LET l_isaj.isaj001   =  '1'                           # 來源類別 1.應收單 
     #LET l_isaj.isaj002   =  l_isaf.isafdocno              # 發票來源單號 #150512-00024#2 mark
      LET l_isaj.isaj002   =  l_isat.isatdocno              # 發票來源單號 #150512-00024#2 add
      LET l_isaj.isaj003   =  p_isaa001                     # 申報單位
      LET l_isaj.isaj004   =  l_isat.isat001                # 發票類型
      LET l_isaj.isaj005   =  l_isat.isat003                # 發票代碼
      IF cl_null(l_isaj.isaj005) THEN LET l_isaj.isaj005 = '　' END IF
      LET l_isaj.isaj006   =  l_isat.isat004                # 發票號碼
      #流水號
      SELECT MAX(isaj007)+1 INTO l_isaj.isaj007
        FROM isaj_t
       WHERE isajent = g_enterprise
         AND isaj005 = l_isaj.isaj005
         AND isaj006 = l_isaj.isaj006
      IF cl_null(l_isaj.isaj007) THEN
         LET l_isaj.isaj007 = 1
      END IF
      LET l_isaj.isaj008   =  ''                            # 海關代徵營業稅繳納證號
      LET l_isaj.isaj009   =  l_isat.isat007                # 發票日期
      LET l_isaj.isaj010   =  l_isat.isat012                # 銷貨方統一編號
      LET l_isaj.isaj011   =  ''                            # 銷貨方稅務編號
      LET l_isaj.isaj012   =  l_isat.isat010                # 購貨方統一編號
      LET l_isaj.isaj013   =  ''                            # 購貨方稅務編號
      LET l_isaj.isaj014   =  ''                            # 扣抵代號
      #150915-00013#2 add ------ 
      #IF l_isat.isat014 = '12' THEN  #作廢發票課稅別要給F        #151005-00007#2 mark
      IF l_isat.isat025 = '12' OR l_isat.isat025 = '22' THEN    #151005-00007#2 
         LET l_isaj.isaj015 = 'F'
      ELSE
      #150915-00013#2 add end---
         LET l_isaj.isaj015   =  l_isat.isat022             # 課稅別
      END IF #150915-00013#2
      LET l_isaj.isaj016   =  l_isat.isat023                # 稅率
      LET l_isaj.isaj017   =  ''                            # 彙加註記
     #LET l_isaj.isaj018   =  l_isaf.isaf019                # 申報格式 #150512-00024#2 mark
      #150422-00012#1 add ------
      #以發票類型抓取
      SELECT isac004 INTO l_isaj.isaj018
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = l_isaj.isaj004
      #150422-00012#1 add end---
      
      #151014-00019#3 add ------
      #若該發票類型沒有在aisi030設置媒體申報格式，那就PASS
      IF cl_null(l_isaj.isaj018) THEN
         CONTINUE FOREACH
      END IF
      #151014-00019#3 add end---
      
     #LET l_isaj.isaj019   =  YEAR(l_isaj.isajdocdt)        # 申報年度  #150422-00012#1 mark
     #LET l_isaj.isaj020   =  MONTH(l_isaj.isajdocdt)       # 申報月份  #150422-00012#1 mark
      LET l_isaj.isaj019   =  g_master.isaa012              # 申報年度  #150422-00012#1
      LET l_isaj.isaj020   =  g_master.l_report_date        # 申報月份  #150422-00012#1
     #LET l_isaj.isaj021   =  l_isaf.isaf002                # 客戶代碼  #150422-00012#1 mark
      #150422-00012#1 add ------
      #客戶代碼
      SELECT pmaa001 INTO l_isaj.isaj021
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa003 = l_isat.isat010
      #150422-00012#1 add end---
      LET l_isaj.isaj022   =  ''                            # 結關日期
      LET l_isaj.isaj023   =  ''                            # 外銷方式
      LET l_isaj.isaj024   =  ''                            # 通關方式
      LET l_isaj.isaj025   =  ''                            # 非經海關證明文件名稱
      LET l_isaj.isaj026   =  ''                            # 非經海關證明文件號碼
      LET l_isaj.isaj027   =  ''                            # 經由海關出口報單類別
      LET l_isaj.isaj028   =  ''                            # 出口報單號碼
      LET l_isaj.isaj029   =  l_isat.isat002                # 電子發票否
      IF cl_null(l_isaj.isaj029) THEN LET l_isaj.isaj029='N' END IF #150915-00013#2
      LET l_isaj.isaj030   =  l_isat.isat014                # 異動狀態
     #LET l_isaj.isaj031   =  ''                            # 發票簿號 #150917 mark
      LET l_isaj.isaj031   =  l_isaf.isaf051                # 發票簿號 #150917
      LET l_isaj.isaj103   =  l_isat.isat113                # 未稅金額
      LET l_isaj.isaj104   =  l_isat.isat114                # 稅額
      LET l_isaj.isaj105   =  l_isat.isat115                # 含稅金額
      IF cl_null(l_isaj.isaj103) THEN LET l_isaj.isaj103 = 0 END IF
      IF cl_null(l_isaj.isaj104) THEN LET l_isaj.isaj104 = 0 END IF
      IF cl_null(l_isaj.isaj105) THEN LET l_isaj.isaj105 = 0 END IF
      
      #150422-00012#1 add ------
      #進銷項類型 #應稅 OR 免稅
      LET l_isaj.isaj033 = '2'  #銷項發票

      #傳票號碼也可能是取不到，就給空白，因為換開發票時是對不到原始單據
      SELECT xrca038 INTO l_isaj.isaj037
        FROM isaf_t
        LEFT JOIN xrca_t ON isafent = xrcaent AND isaf035 = xrcadocno
       WHERE xrcaent = g_enterprise
         AND isafdocno = l_isat.isatdocno
      #150422-00012#1 add end---
      
      LET l_isaj.isajstus  =  'Y'
      LET l_isaj.isajownid = g_user
      LET l_isaj.isajowndp = g_dept
      LET l_isaj.isajcrtid = g_user
      LET l_isaj.isajcrtdp = g_dept
      LET l_date = cl_get_current()
      LET l_isaj.isajcrtdt = l_date
      LET l_isaj.isajmodid = g_user
      LET l_isaj.isajmoddt = l_date

      CALL s_aisp440_ins_isaj(l_isaj.*) RETURNING g_sub_success,r_write
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF

   END FOREACH
   
   

   #150512-00024#2 add ------
   #此為轉換成抓取零稅率用
   CALL s_chr_replace(p_wc,'isat007','isaf014',0) RETURNING p_wc #發票日期
   CALL s_chr_replace(p_wc,'isat004','isaf011',0) RETURNING p_wc #發票號碼
   #這裡只抓取零稅
   #161228-00045#1：因增加是否展開細項條件，故調整SQL
   #161228-00045#1 mark ------
   #LET l_sql = "SELECT isafcomp,isafsite,isafdocno,isafdocdt,",
   #            "       isaf002,isaf008,isaf009,isaf010,isaf011,",
   #            "       isaf014,isaf018,isaf021,isaf022,isaf028,",
   #            "       isaf035,isaf051,isaf054,isaf059,isaf060,",
   #            "       isaf061,isaf062,isaf063,isaf064,isaf065,",
   #            #"       isah004,isah006,isah103,isah104,isah105", #150915-00013#2 mark
   #            "       isah004,isah006,isah113,isah114,isah115",  #150915-00013#2
   #            "  FROM isaf_t",
   #            "  LEFT JOIN isah_t ON isafent = isahent AND isafcomp = isahcomp AND isafdocno = isahdocno",
   #            " WHERE isafent = ",g_enterprise,
   #            "   AND isafsite IN ",g_wc_isaosite,
   #            "   AND isafdocdt BETWEEN '",l_day1,"' AND '",l_day2,"'",
   #            "   AND isaf011 IS NOT NULL",
   #            "   AND isaf054 = '2' ", #課稅別=2.零稅
   #            "   AND isafstus <> 'N'", #150925 #161130-00033#1 mark  #161212-00023#1 remark
   #            #"   AND isafstus = 'Y'",         #161130-00033#1 add   #161212-00023#1 mark
   #            #161220-00008#1 --s add
   #            "   AND isafdocno NOT IN (SELECT a.isafdocno FROM isaf_t a WHERE a.isafent = isafent AND a.isafcomp = isafcomp  ",
   #            "                            AND a.isafdocno = isafdocno AND a.isafstus = 'X' AND a.isaf056 = '2')  ",           
   #            #161220-00008#1 --e add
   #            "   AND ",p_wc
   #            #" ORDER BY isaf011"   #150922-00021#5 mark 增加條件
   #161228-00045#1 mark end---
   #161228-00045#1 add ------
   #零稅率清單是否產生貨品明細資料
   IF g_master.l_chk2 = 'Y' THEN
      LET l_sql = "SELECT isatcomp,isatsite,isatdocno,isatdocdt,",
                  "       isaf002,isat001,isat002,isat003,isat004,",
                  "       isat007,isat023,isaf021,isat010,isat012,",
                  "       isaf035,isaf051,",
                  "       (SELECT oodb008 FROM oodb_t WHERE oodbent = isafent AND oodb002 = isaf016 AND oodb001 IN (SELECT ooef019 FROM ooef_t WHERE ooefent = isafent AND ooef001 = isafcomp)),",
                  "       isaf059,isaf060,",
                  "       isaf061,isaf062,isaf063,isaf064,isaf065,",
                  "       isah004,isah006,isah113,isah114,isah115", 
                  "  FROM isat_t",
                  "  LEFT JOIN isaf_t ON isatent = isafent AND isatcomp = isafcomp AND isatdocno = isafdocno",
                  "  LEFT JOIN isah_t ON isafent = isahent AND isafcomp = isahcomp AND isafdocno = isahdocno"
   ELSE
      LET l_sql = "SELECT isatcomp,isatsite,isatdocno,isatdocdt,",
                  "       isaf002,isat001,isat002,isat003,isat004,",
                  "       isat007,isat023,isaf021,isat010,isat012,",
                  "       isaf035,isaf051,",
                  "       (SELECT oodb008 FROM oodb_t WHERE oodbent = isafent AND oodb002 = isaf016 AND oodb001 IN (SELECT ooef019 FROM ooef_t WHERE ooefent = isafent AND ooef001 = isafcomp)),",
                  "       isaf059,isaf060,",
                  "       isaf061,isaf062,isaf063,isaf064,isaf065,",
                  "       '','',isat113,isat114,isat115", 
                  "  FROM isat_t",
                  "  LEFT JOIN isaf_t ON isatent = isafent AND isatcomp = isafcomp AND isatdocno = isafdocno"
   END IF
   LET l_sql = l_sql,
               " WHERE isatent = ",g_enterprise,
               "   AND isatsite IN ",g_wc_isaosite,
               "   AND isatdocdt BETWEEN '",l_day1,"' AND '",l_day2,"'",
               "   AND isaf011 IS NOT NULL",
              #"   AND isafstus <> 'N'", #170218-00007#1 mark
               "   AND isafstus = 'Y'",  #170218-00007#1
               "   AND isaf060 IS NOT NULL",
               "   AND isafdocno NOT IN (SELECT a.isafdocno FROM isaf_t a WHERE a.isafent = isafent AND a.isafcomp = isafcomp",
               "                            AND a.isafdocno = isafdocno AND a.isafstus = 'X' AND a.isaf056 = '2')",
               "   AND EXISTS(SELECT 1 FROM oodb_t WHERE oodbent = isafent ",
               "                 AND oodb001 IN(SELECT ooef019 FROM ooef_t WHERE ooef001 = isafcomp ",
               "                 AND ooefent = isafent) AND oodb002 = isaf016 AND oodb008 = '2') ",
               "   AND ",p_wc
   #161228-00045#1 add end---
   
   #150922-00021#5-----s
   CASE
      WHEN p_isaf060= '1'
         LET l_sql = l_sql," AND isaf060 = '1' ORDER BY isaf011"
      WHEN p_isaf060= '2'
         LET l_sql = l_sql," AND isaf060 = '2' ORDER BY isaf011"
      WHEN p_isaf060= '3'
         LET l_sql = l_sql," ORDER BY isaf011"
   END CASE 
   #150922-00021#5-----e
               
   PREPARE sel_isaf_p FROM l_sql
   DECLARE sel_isaf_c CURSOR FOR sel_isaf_p
   FOREACH sel_isaf_c INTO l_isaf.isafcomp,l_isaf.isafsite,l_isaf.isafdocno,l_isaf.isafdocdt,
                           l_isaf.isaf002,l_isaf.isaf008,l_isaf.isaf009,l_isaf.isaf010,l_isaf.isaf011,
                           l_isaf.isaf014,l_isaf.isaf018,l_isaf.isaf021,l_isaf.isaf022,l_isaf.isaf028,
                           l_isaf.isaf035,l_isaf.isaf051,l_isaf.isaf054,l_isaf.isaf059,l_isaf.isaf060,
                           l_isaf.isaf061,l_isaf.isaf062,l_isaf.isaf063,l_isaf.isaf064,l_isaf.isaf065,
                          #l_isaf.isah004,l_isaf.isah006,l_isaf.isah103,l_isaf.isah104,l_isaf.isah105  #150915-00013#2 mark
                           l_isaf.isah004,l_isaf.isah006,l_isaf.isah113,l_isaf.isah114,l_isaf.isah115  #150915-00013#2

      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      INITIALIZE l_isaj.* TO NULL
      
      LET l_isaj.isajent   =  g_enterprise                  # 企業編碼
      LET l_isaj.isajcomp  =  l_isaf.isafcomp               # 法人編碼
      LET l_isaj.isajsite  =  l_isaf.isafsite               # 營運據點
      LET l_isaj.isajdocdt =  l_isaf.isafdocdt              # 資料日期
      LET l_isaj.isaj001   =  '1'                           # 來源類別 1.應收單
      LET l_isaj.isaj002   =  l_isaf.isafdocno              # 發票來源單號
      LET l_isaj.isaj003   =  p_isaa001                     # 申報單位
      LET l_isaj.isaj004   =  l_isaf.isaf008                # 發票類型
      LET l_isaj.isaj005   =  l_isaf.isaf010                # 發票代碼
      IF cl_null(l_isaj.isaj005) THEN LET l_isaj.isaj005 = '　' END IF
      LET l_isaj.isaj006   =  l_isaf.isaf011                # 發票號碼
      #流水號
      SELECT MAX(isaj007)+1 INTO l_isaj.isaj007
        FROM isaj_t
       WHERE isajent = g_enterprise
         AND isaj005 = l_isaj.isaj005
         AND isaj006 = l_isaj.isaj006
      IF cl_null(l_isaj.isaj007) THEN
         LET l_isaj.isaj007 = 1
      END IF
      LET l_isaj.isaj008   =  ''                            # 海關代徵營業稅繳納證號
      LET l_isaj.isaj009   =  l_isaf.isaf014                # 發票日期
      LET l_isaj.isaj010   =  l_isaf.isaf028                # 銷貨方統一編號
      LET l_isaj.isaj011   =  ''                            # 銷貨方稅務編號
      LET l_isaj.isaj012   =  l_isaf.isaf022                # 購貨方統一編號
      LET l_isaj.isaj013   =  ''                            # 購貨方稅務編號
      LET l_isaj.isaj014   =  ''                            # 扣抵代號
      LET l_isaj.isaj015   =  l_isaf.isaf054                # 課稅別
      LET l_isaj.isaj016   =  l_isaf.isaf018                # 稅率
      LET l_isaj.isaj017   =  ''                            # 彙加註記
      #以發票類型抓取
      SELECT isac004 INTO l_isaj.isaj018
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = l_isaj.isaj004
      #151014-00019#3 add ------
      #若該發票類型沒有在aisi030設置媒體申報格式，那就PASS
      IF cl_null(l_isaj.isaj018) THEN
         CONTINUE FOREACH
      END IF
      #151014-00019#3 add end---
      LET l_isaj.isaj019   =  g_master.isaa012              # 申報年度
      LET l_isaj.isaj020   =  g_master.l_report_date        # 申報月份
      
      LET l_isaj.isaj021   =  l_isaf.isaf002                # 客戶代碼
      LET l_isaj.isaj022   =  l_isaf.isaf065                # 結關日期
      LET l_isaj.isaj023   =  l_isaf.isaf059                # 適用零稅率規定
      LET l_isaj.isaj024   =  l_isaf.isaf060                # 通關方式
      LET l_isaj.isaj025   =  l_isaf.isaf061                # 非經海關證明文件名稱
      LET l_isaj.isaj026   =  l_isaf.isaf062                # 非經海關證明文件號碼
      LET l_isaj.isaj027   =  l_isaf.isaf063                # 經由海關出口報單類別
      LET l_isaj.isaj028   =  l_isaf.isaf064                # 出口報單號碼
      LET l_isaj.isaj029   =  l_isaf.isaf009                # 電子發票否
      IF cl_null(l_isaj.isaj029) THEN LET l_isaj.isaj029='N' END IF #150915-00013#2
      LET l_isaj.isaj030   =  '11'                          # 異動狀態  #11.發票開立(零稅率不會有換開發票)
     
      LET l_isaj.isaj031   =  l_isaf.isaf051                # 發票簿號
      LET l_isaj.isaj033   =  '3'                           # 進銷項類型(3.零稅率銷項發票)
      LET l_isaj.isaj034   =  l_isaf.isaf021                # 買受人名稱
      LET l_isaj.isaj035   =  l_isaf.isah004                # 貨物名稱
      LET l_isaj.isaj036   =  l_isaf.isah006                # 貨物數量
     #LET l_isaj.isaj103   =  l_isaf.isah103                # 未稅金額  #150915-00013#2 mark
     #LET l_isaj.isaj104   =  l_isaf.isah104                # 稅額      #150915-00013#2 mark
     #LET l_isaj.isaj105   =  l_isaf.isah105                # 含稅金額  #150915-00013#2 mark
      LET l_isaj.isaj103   =  l_isaf.isah113                # 未稅金額  #150915-00013#2
      LET l_isaj.isaj104   =  l_isaf.isah114                # 稅額      #150915-00013#2
      LET l_isaj.isaj105   =  l_isaf.isah115                # 含稅金額  #150915-00013#2
      IF cl_null(l_isaj.isaj103) THEN LET l_isaj.isaj103 = 0 END IF
      IF cl_null(l_isaj.isaj104) THEN LET l_isaj.isaj104 = 0 END IF
      IF cl_null(l_isaj.isaj105) THEN LET l_isaj.isaj105 = 0 END IF
      
      #傳票號碼也可能是取不到，就給空白，因為換開發票時是對不到原始單據
      SELECT xrca038 INTO l_isaj.isaj037
        FROM xrca_t
       WHERE xrcaent = g_enterprise
         AND xrcadocno = l_isaf.isaf035
      
      LET l_isaj.isajstus  =  'Y'
      LET l_isaj.isajownid = g_user
      LET l_isaj.isajowndp = g_dept
      LET l_isaj.isajcrtid = g_user
      LET l_isaj.isajcrtdp = g_dept
      LET l_date = cl_get_current()
      LET l_isaj.isajcrtdt = l_date
      LET l_isaj.isajmodid = g_user
      LET l_isaj.isajmoddt = l_date

      CALL s_aisp440_ins_isaj(l_isaj.*) RETURNING g_sub_success,r_write
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF

   END FOREACH
   #150512-00024#2 add end---

   
   
   RETURN r_success,r_write
   
END FUNCTION

#end add-point
 
{</section>}
 
