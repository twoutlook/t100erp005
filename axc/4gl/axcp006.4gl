#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp006.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-05-06 17:26:02), PR版次:0014(2017-02-14 14:43:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000428
#+ Filename...: axcp006
#+ Description: 標準單位成本滾算作業
#+ Creator....: 01531(2014-03-26 08:26:37)
#+ Modifier...: 00768 -SD/PR- 00768
 
{</section>}
 
{<section id="axcp006.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00005#46  160401   by pengxin  修正azzi920重复定义之错误讯息
#160318-00025#36  160418   by pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160328-00022#3   160620   By 02097    增加進度條顯示
#160622-00008#1   2016/06/23 By xianghui 汇率检查SQL错误
#130813-00001#183 160623#1   By 00768 单位成本没有按本阶QPA计算，导致最终汇总的成本金额不对
#                 160623#2   By 00768 标准资源费用明细页签的成本改成按QPA计算的成本，这样汇总金额就能与标准成本构成明细相匹配了
#160829-00010#1   16/08/31   By Ann_Huang 修正axc-00085需多考慮成本次要素
#160905-00007#17  2016/09/05 By zhujing 调整系统中无ENT的SQL条件增加ent
#160822-00024#1   2016/09/19 By 02295 1.当画面有下料件条件，用画面上的料号去展BOM，把有关的料号都找出来，放到temp table里
#                                     2.当料号没有下料号条件，直接把axci004里面出现的料号，全部丢到temp档(包含单头单身)
#                                     3.计算采用跟axcp500的方式一样，由99阶往0阶计算，不要再使用循环了
#161019-00017#7   2016/10/19   By zhujing 据点组织开窗资料整批调整
#161107-00037#1   2016/11/15   By charles4m 1. FOREACH axcp006_imaa001_cur SQL imaa004 多撈虛擬件(X)
#                                           2. 當抓不到成本幣別時，報錯但還是要執行成功
#161113-00001#1   2016/11/23   By 02295   1.sql报错 2.资料插入重复 
#161124-00048#16  2016/12/16   By 08734   星号整批调整
#170214-00007#1   2016/02/14   By 00768   修正：处理旧资料时，处理失效日期的漏洞
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
       xcabsite LIKE xcab_t.xcabsite, 
   xcab002 LIKE xcab_t.xcab002, 
   xcag002 LIKE xcag_t.xcag002, 
   xcaa001 LIKE type_t.chr10, 
   xcag003 LIKE xcag_t.xcag003, 
   xcab001 LIKE type_t.chr10, 
   ooai001 LIKE type_t.chr10, 
   xcac001 LIKE type_t.chr10, 
   a LIKE type_t.chr500, 
   xcad001 LIKE type_t.chr10, 
   ooam004 LIKE ooam_t.ooam004, 
   xcae001 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_ooef001      STRING
DEFINE g_wc_imaa001      STRING
DEFINE g_cnt             LIKE type_t.num5
DEFINE g_xcabsite        LIKE xcab_t.xcabsite
DEFINE g_imaa001         LIKE imaa_t.imaa001
DEFINE g_imaa004         LIKE imaa_t.imaa004
DEFINE g_imaa006         LIKE imaa_t.imaa006
DEFINE g_seq             LIKE type_t.num10    #项次 对最终主件的元件项次
DEFINE g_xcad001         LIKE xcad_t.xcad001
DEFINE g_suceess         LIKE type_t.chr1
DEFINE g_flag            LIKE type_t.chr1
#DEFINE g_success1        LIKE type_t.chr1
#DEFINE g_ooef001_val     STRING #CONSTRUCT栏位值
#DEFINE g_imaa001_val     STRING #CONSTRUCT栏位值
#DEFINE g_ooef001_wc      STRING  #CONSTRUCT栏位wc
#DEFINE g_imaa001_wc      STRING  #CONSTRUCT栏位wc
#
#DEFINE g_ooef001         LIKE ooef_t.ooef001

DEFINE g_xcaiseq         LIKE xcai_t.xcaiseq   #项次
DEFINE g_close           LIKE type_t.chr1      #是否直接关闭，不再执行
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp006.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET ls_js = util.JSON.stringify(lc_param)
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL axcp006_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp006 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp006_init()
 
      #進入選單 Menu (="N")
      CALL axcp006_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      #DROP TABLE axcp006_temp
      DROP TABLE axcp006_xcah
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp006
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp006.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp006_init()
 
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
   CALL cl_set_combo_scc("a","40")
   LET g_today = cl_get_today()
   INITIALIZE g_master.* TO NULL
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp006.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp006_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_errmsg  STRING
   DEFINE l_success LIKE type_t.num5
   
   LET g_errshow = 1
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_close = 'N'   #不关作业
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      #汇率日期
      IF cl_null(g_master.ooam004) THEN
         LET g_master.ooam004 = cl_get_today()
      END IF
      #汇率采用方式
      IF cl_null(g_master.a) THEN
         LET g_master.a = '11'
      END IF
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xcag002,g_master.xcaa001,g_master.xcag003,g_master.xcab001,g_master.ooai001, 
             g_master.xcac001,g_master.a,g_master.xcad001,g_master.ooam004,g_master.xcae001 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcag002
            #add-point:BEFORE FIELD xcag002 name="input.b.xcag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcag002
            
            #add-point:AFTER FIELD xcag002 name="input.a.xcag002"
            #生效日期
            CALL axcp006_chk_column('xcag002') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcag002
            #add-point:ON CHANGE xcag002 name="input.g.xcag002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcaa001
            #add-point:BEFORE FIELD xcaa001 name="input.b.xcaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcaa001
            
            #add-point:AFTER FIELD xcaa001 name="input.a.xcaa001"
            #标准成本分类
            CALL axcp006_chk_column('xcaa001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcaa001
            #add-point:ON CHANGE xcaa001 name="input.g.xcaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcag003
            #add-point:BEFORE FIELD xcag003 name="input.b.xcag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcag003
            
            #add-point:AFTER FIELD xcag003 name="input.a.xcag003"
            #失效日期
            CALL axcp006_chk_column('xcag003') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcag003
            #add-point:ON CHANGE xcag003 name="input.g.xcag003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcab001
            #add-point:BEFORE FIELD xcab001 name="input.b.xcab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcab001
            
            #add-point:AFTER FIELD xcab001 name="input.a.xcab001"
            #材料成本版本
            CALL axcp006_chk_column('xcab001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcab001
            #add-point:ON CHANGE xcab001 name="input.g.xcab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooai001
            #add-point:BEFORE FIELD ooai001 name="input.b.ooai001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooai001
            
            #add-point:AFTER FIELD ooai001 name="input.a.ooai001"
            #币别
            CALL axcp006_chk_column('ooai001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooai001
            #add-point:ON CHANGE ooai001 name="input.g.ooai001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac001
            #add-point:BEFORE FIELD xcac001 name="input.b.xcac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac001
            
            #add-point:AFTER FIELD xcac001 name="input.a.xcac001"
            #资源标准费率版本
            CALL axcp006_chk_column('xcac001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac001
            #add-point:ON CHANGE xcac001 name="input.g.xcac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcad001
            #add-point:BEFORE FIELD xcad001 name="input.b.xcad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcad001
            
            #add-point:AFTER FIELD xcad001 name="input.a.xcad001"
            #成本BOM版本
            CALL axcp006_chk_column('xcad001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcad001
            #add-point:ON CHANGE xcad001 name="input.g.xcad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooam004
            #add-point:BEFORE FIELD ooam004 name="input.b.ooam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooam004
            
            #add-point:AFTER FIELD ooam004 name="input.a.ooam004"
            #汇率日期
            CALL axcp006_chk_column('ooam004') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooam004
            #add-point:ON CHANGE ooam004 name="input.g.ooam004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcae001
            #add-point:BEFORE FIELD xcae001 name="input.b.xcae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcae001
            
            #add-point:AFTER FIELD xcae001 name="input.a.xcae001"
            #成本工艺路线版本
            CALL axcp006_chk_column('xcae001') RETURNING l_success
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcae001
            #add-point:ON CHANGE xcae001 name="input.g.xcae001"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xcag002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcag002
            #add-point:ON ACTION controlp INFIELD xcag002 name="input.c.xcag002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcaa001
            #add-point:ON ACTION controlp INFIELD xcaa001 name="input.c.xcaa001"
            #允许共享的非主标准标准成本分类--都不要控管了
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcaa001      #給予default值
            #LET g_qryparam.where = " xcaa003 = 'Y' AND xcaa002 = 'N' "               
            #給予arg
            CALL q_xcaa001()                                #呼叫開窗
            LET g_master.xcaa001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.xcaa001 TO xcaa001             #顯示到畫面上
            NEXT FIELD xcaa001                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xcag003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcag003
            #add-point:ON ACTION controlp INFIELD xcag003 name="input.c.xcag003"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcab001
            #add-point:ON ACTION controlp INFIELD xcab001 name="input.c.xcab001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcab001      #給予default值
            #給予arg
            CALL q_xcab001()                                #呼叫開窗
            LET g_master.xcab001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.xcab001 TO xcab001             #顯示到畫面上
            NEXT FIELD xcab001                              #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.ooai001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooai001
            #add-point:ON ACTION controlp INFIELD ooai001 name="input.c.ooai001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ooai001      #給予default值
            #給予arg
            CALL q_ooai001()                                #呼叫開窗
            LET g_master.ooai001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.ooai001 TO ooai001             #顯示到畫面上
            NEXT FIELD ooai001                              #返回原欄位  
            #zll 检查
            #END add-point
 
 
         #Ctrlp:input.c.xcac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac001
            #add-point:ON ACTION controlp INFIELD xcac001 name="input.c.xcac001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcac001      #給予default值
            #給予arg
            CALL q_xcac001()                                #呼叫開窗
            LET g_master.xcac001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.xcac001 TO xcac001             #顯示到畫面上
            NEXT FIELD xcac001                              #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcad001
            #add-point:ON ACTION controlp INFIELD xcad001 name="input.c.xcad001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcad001      #給予default值
            #給予arg
            CALL q_xcad001_1()                              #呼叫開窗
            LET g_master.xcad001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.xcad001 TO xcad001             #顯示到畫面上
            NEXT FIELD xcad001                              #返回原欄位 
            #END add-point
 
 
         #Ctrlp:input.c.ooam004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooam004
            #add-point:ON ACTION controlp INFIELD ooam004 name="input.c.ooam004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcae001
            #add-point:ON ACTION controlp INFIELD xcae001 name="input.c.xcae001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xcae001      #給予default值
            #給予arg
            CALL q_xcae001()                                #呼叫開窗
            LET g_master.xcae001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_master.xcae001 TO xcae001             #顯示到畫面上
            NEXT FIELD xcae001                              #返回原欄位 
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xcabsite,xcab002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               #DISPLAY g_ooef001_val TO ooef001
               #DISPLAY g_imaa001_val TO imaa001
               #zll 检查不满足条件回来选的时候值是否依然保留
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xcabsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcabsite
            #add-point:ON ACTION controlp INFIELD xcabsite name="construct.c.xcabsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE 
		    	LET g_qryparam.where = " ooef201='Y' AND ooefstus='Y' ",
		    	                       " AND (ooef001 in (select unique xcabsite from xcab_t) ",  #已录入且确认之材料标准成本
		    	                       "   OR ooef001 in (select unique xcacsite from xcac_t) ",  #已录入且确认之资源标准费率
		    	                       "   OR ooef001 in (select unique xcadsite from xcad_t) ",  #已录入且确认之成本BOM 
		    	                       "   OR ooef001 in (select unique xcaesite from xcae_t) ",  #已录入且确认之营运据点
		    	                       "     ) "
#            CALL q_ooef001_15()                       #呼叫開窗    #161019-00017#7 marked
            CALL q_ooef001_1()                       #呼叫開窗    #161019-00017#7 marked
            DISPLAY g_qryparam.return1 TO xcabsite    #顯示到畫面上
            NEXT FIELD xcabsite                       #返回原欄位                #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcabsite
            #add-point:BEFORE FIELD xcabsite name="construct.b.xcabsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcabsite
            
            #add-point:AFTER FIELD xcabsite name="construct.a.xcabsite"
            #LET g_ooef001_wc = GET_FLDBUF(ooef001)
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcab002
            #add-point:ON ACTION controlp INFIELD xcab002 name="construct.c.xcab002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE 
            CALL q_imaa001_16()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcab002    #顯示到畫面上
            NEXT FIELD xcab002                       #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcab002
            #add-point:BEFORE FIELD xcab002 name="construct.b.xcab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcab002
            
            #add-point:AFTER FIELD xcab002 name="construct.a.xcab002"
            #LET g_imaa001_val = GET_FLDBUF(imaa001)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="construct.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="construct.a.a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="construct.c.a"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
         AFTER CONSTRUCT
            CALL axcp006_get_wc()
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
            CALL axcp006_get_buffer(l_dialog)
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
         CALL axcp006_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #执行前画面检查
      CALL axcp006_chk_column('ALL') RETURNING l_success
      IF NOT l_success THEN
         CONTINUE WHILE  #zll检查画面会清掉吗？变量值会清掉吗？g_master.*
      END IF
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
                 CALL axcp006_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp006_transfer_argv(ls_js)
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
         IF g_close = 'Y' THEN
            EXIT WHILE
         END IF
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
 
{<section id="axcp006.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp006_transfer_argv(ls_js)
 
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
 
{<section id="axcp006.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp006_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_wc        STRING
   DEFINE l_has_equal LIKE type_t.chr1  #是否存在=当前运算的资料：生效日期等于已有的生效日期
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_string      LIKE type_t.chr500#160328-00022#3
   DEFINE l_i           LIKE type_t.num5  #160328-00022#3
   DEFINE l_bar_cnt1    LIKE type_t.num5  #160328-00022#3
   DEFINE l_bar_cnt2    LIKE type_t.num5  #160328-00022#3
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET g_success = 'Y'
   #LET g_success1 = 'Y'
   LET l_has_equal = 'N'
   
   #建立临时表axcp006_temp
   CALL axcp006_create()
   
   CALL s_transaction_begin()  #开始事务
   #160328-00022#3--(S)
   LET l_bar_cnt1 = 4
   LET l_bar_cnt2 = l_bar_cnt1
   CALL cl_progress_bar_no_window(l_bar_cnt1)   
   
   LET l_bar_cnt2 = l_bar_cnt2 - 1              
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00771' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#3--(E)
   
   #=================检查==================
   #錯誤訊息彙總初始
   CALL cl_err_collect_init()

   #生效日期小於已有的生效日期
   LET l_cnt = 0
   
   #根据l_wc，标准分类xcaa001，生效日期xcag002从xcag中检查“是否已存在此次生效日期小于已有的生效日期的”
   LET l_wc = cl_replace_str(g_master.wc,"xcabsite","xcagsite")
   LET l_wc = cl_replace_str(l_wc,"xcab002","xcag004")
   LET g_sql = " SELECT COUNT(*) FROM xcag_t ",
               "  WHERE xcagent = ",g_enterprise,
               "    AND ",l_wc,                            #營運據點+料號
               "    AND xcag001 = '",g_master.xcaa001,"'", #標準分類碼
               "    AND xcag002 > '",g_master.xcag002,"'"  #生效日期
   DECLARE axcp006_cur_chk1 SCROLL CURSOR FROM g_sql
   OPEN axcp006_cur_chk1
   FETCH FIRST axcp006_cur_chk1 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "check1:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   CLOSE axcp006_cur_chk1
   #如果有，提示错误“生效日期小於已有的生效日期”
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00118'  #生效日期小於已有的生效日期
      LET g_errparam.extend = g_master.xcag002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'  #不满足小于条件，原则性不满足条件，不可执行的
   END IF

   #同上根据l_wc，标准分类xcaa001，生效日期xcag002从xcag中检查“是否已存在此次生效日期等于已有的生效日期的”
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM xcag_t ",
               "  WHERE xcagent = ",g_enterprise,
               "    AND ",l_wc,                            #營運據點+料號
               "    AND xcag001 = '",g_master.xcaa001,"'", #標準分類碼
               "    AND xcag002 = '",g_master.xcag002,"'"    #生效日期
   DECLARE axcp006_cur_chk2 SCROLL CURSOR FROM g_sql
   OPEN axcp006_cur_chk2
   FETCH FIRST axcp006_cur_chk2 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "check2:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   CLOSE axcp006_cur_chk2
   #如果有，提示错误“生效日期等于已有的生效日期”
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00213'  #生效日期等於已有的生效日期
      LET g_errparam.extend = g_master.xcag002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_has_equal = 'Y'  #不满足等于条件，等于的可以直接删除重新产生
   END IF
   
   CALL cl_err_collect_show()  #错误汇总显示
   
   #删除旧值
   IF l_has_equal = 'Y' THEN  #有不满足等于条件的
      IF NOT cl_ask_confirm('axc-00216') THEN  #已有相同的生效日期资料，是否需要刪除，重新卷算？
         CALL axcp006_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#3
         RETURN
      ELSE
         CALL axcp006_process_del() RETURNING l_success
         IF NOT l_success THEN
            #CALL s_transaction_end('N','0')
            ##执行失败
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.code = 'adz-00218'
            #LET g_errparam.extend = ''
            #LET g_errparam.popup = FALSE
            #CALL cl_err()
            #RETURN
            LET g_success = 'N'  #执行失败
         END IF
      END IF
   END IF
   
   IF g_success = 'N' THEN
      CALL s_transaction_end('N','0')
      CALL axcp006_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#3
      IF NOT cl_ask_confirm('axc-00212') THEN #產生失敗，是否繼續
         LET g_close = 'Y'  #关闭作业
         RETURN
      ELSE
         RETURN
      END IF
   END IF
   #===============检查结束==============
   
   #===============开始产生==============
   
   #160328-00022#3--(S)
   LET l_bar_cnt2 = l_bar_cnt2 - 1              
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00772' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#3--(E)
   CALL cl_err_collect_init()
   CALL axcp006_get_imaa001() RETURNING l_success  #根据查询条件获取料件
   CALL cl_err_collect_show()  #错误汇总显示
   IF NOT l_success THEN 
      CALL s_transaction_end('N',0)  #事务结束
      CALL axcp006_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)         #160328-00022#3
      IF NOT cl_ask_confirm('axc-00212') THEN #產生失敗，是否繼續
         LET g_close = 'Y'  #关闭作业
         RETURN
      ELSE
         RETURN
      END IF        
   END IF
   
   #160328-00022#3--(S)
   LET l_bar_cnt2 = l_bar_cnt2 - 1              
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00773' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#3--(E)
   
   CALL cl_err_collect_init()
   CALL axcp006_get_site() RETURNING l_success  #根据查询条件获取据点
   CALL cl_err_collect_show()  #错误汇总显示
   CALL axcp006_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)         #160328-00022#3
   IF l_success THEN
      CALL s_transaction_end('Y',0)  #事务结束
      ##执行成功
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'adz-00217'
      #LET g_errparam.extend = ''
      #LET g_errparam.popup = FALSE
      #CALL cl_err()
      IF cl_ask_confirm('axc-00211') THEN #產生成功，是否繼續
         RETURN
      ELSE
         LET g_close = 'Y'  #关闭作业
         RETURN
      END IF
   ELSE
      CALL s_transaction_end('N',0)  #事务结束
      ##执行失败
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'adz-00218'
      #LET g_errparam.extend = ''
      #LET g_errparam.popup = FALSE
      #CALL cl_err()
      IF NOT cl_ask_confirm('axc-00212') THEN #產生失敗，是否繼續
         LET g_close = 'Y'  #关闭作业
         RETURN
      ELSE
         RETURN
      END IF
   END IF
   #===============产生结束====================
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp006_process_cs CURSOR FROM ls_sql
#  FOREACH axcp006_process_cs INTO
   #add-point:process段process name="process.process"
   
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
   CALL axcp006_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp006.get_buffer" >}
PRIVATE FUNCTION axcp006_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xcag002 = p_dialog.getFieldBuffer('xcag002')
   LET g_master.xcaa001 = p_dialog.getFieldBuffer('xcaa001')
   LET g_master.xcag003 = p_dialog.getFieldBuffer('xcag003')
   LET g_master.xcab001 = p_dialog.getFieldBuffer('xcab001')
   LET g_master.ooai001 = p_dialog.getFieldBuffer('ooai001')
   LET g_master.xcac001 = p_dialog.getFieldBuffer('xcac001')
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.xcad001 = p_dialog.getFieldBuffer('xcad001')
   LET g_master.ooam004 = p_dialog.getFieldBuffer('ooam004')
   LET g_master.xcae001 = p_dialog.getFieldBuffer('xcae001')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp006.msgcentre_notify" >}
PRIVATE FUNCTION axcp006_msgcentre_notify()
 
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
 
{<section id="axcp006.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#将画面栏位转换为wc
#从wc中剥离出据点和物料的qbe条件g_wc_ooef001（*xcabsite*->*ooef001*），g_wc_imaa001（*xcab002*->*imaa001*）
#00768 add 150107
PRIVATE FUNCTION axcp006_get_wc()
DEFINE l_string       STRING
DEFINE tok            base.stringtokenizer

   LET g_wc_ooef001 = ''
   LET g_wc_imaa001 = ''
   IF NOT cl_null(g_master.wc) OR g_master.wc != " 1=1" THEN
      LET g_wc = g_master.wc
      LET g_wc = cl_replace_str(g_wc,"and","||")
      LET tok = base.StringTokenizer.create(g_wc,"||")
      WHILE tok.hasMoreTokens()
         LET l_string = tok.nextToken()
         LET l_string = l_string.trim()
         IF l_string MATCHES '*xcabsite*' THEN
            IF cl_null(g_wc_ooef001) THEN
               LET g_wc_ooef001 = l_string
            ELSE
               LET g_wc_ooef001 = g_wc_ooef001 CLIPPED," AND ",l_string
            END IF
         END IF
         IF l_string MATCHES '*xcab002*' THEN
            IF cl_null(g_wc_imaa001) THEN
               LET g_wc_imaa001 = l_string
            ELSE
               LET g_wc_imaa001 = g_wc_imaa001 CLIPPED," AND ",l_string
            END IF
         END IF
      END WHILE
   END IF
   IF cl_null(g_wc_ooef001) THEN
      LET g_wc_ooef001 = " 1=1 "
   ELSE
      LET g_wc_ooef001 = cl_replace_str(g_wc_ooef001,"xcabsite","ooef001")
   END IF
   IF cl_null(g_wc_imaa001) THEN
      LET g_wc_imaa001 = " 1=1 "
   ELSE
      LET g_wc_imaa001 = cl_replace_str(g_wc_imaa001,"xcab002","imaa001")
   END IF
   
END FUNCTION
# 定義cursor
PRIVATE FUNCTION axcp006_cursor()

   LET g_sql = "SELECT COUNT(*) FROM xcad_t ",
               " WHERE xcad002 = ? ",
               "   AND xcadent = ",g_enterprise,        
               "   AND xcad001 = ? "
   PREPARE cursor_pre_2 FROM g_sql   
 
   #營運據點所屬法人
   LET g_sql = "SELECT ooef017 FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND ooef001 = ? " 
   PREPARE cursor_pre_3 FROM g_sql      
   
   #根據元件-成本次要素
   LET g_sql = "SELECT xcax002 FROM xcax_t ",
               " WHERE xcaxent = ",g_enterprise,
               "   AND xcaxsite = ? ",
               "   AND xcax001 = ? " 
   PREPARE cursor_pre_9 FROM g_sql 
      
   #根據元件-材料成本  #材料幣別、成本
   LET g_sql = "SELECT xcab003,xcab004 FROM xcab_t ", 
               " WHERE xcab001 = ? ",       
               "   AND xcabent = ",g_enterprise,
               "   AND xcab002 = ? "
   PREPARE cursor_pre_10 FROM g_sql  

   LET g_sql = "SELECT SUM(xcai107) FROM xcai_t ",
               " WHERE xcaient = ",g_enterprise,
               "   AND xcaisite = ? ",
               "   AND xcai001 = ? ",
               "   AND xcai002 = ? ",
               "   AND xcai004 = ? ",
               "   AND xcai100 = ? ",
               "   AND xcai109 = ? ",  #本阶主件在最终主件里的项次   #add zhangllc 160623#2 如果xcai计算时不涉及QPA，损耗量等计算，则此行不需要
               "   AND xcai201 = ? "
   PREPARE cursor_pre_11 FROM g_sql  

   LET g_sql = "SELECT COUNT(*) FROM xcag_t ",
               " WHERE xcagent = ",g_enterprise,
               "   AND xcagsite = ? ",
               "   AND xcag001 = ? ",
               "   AND xcag004 = ? ", 
               "   AND xcag002 < ? "
   PREPARE cursor_pre_12 FROM g_sql  

   LET g_sql = "SELECT COUNT(*) FROM xcaj_t ",
               " WHERE xcaj005 = ? ",  #次要素
               "   AND xcaj004 = ? ",  #最終主件
               "   AND xcajsite = ? ", 
               "   AND xcaj001 = ? ",
               "   AND xcaj002 = ? ",
               "   AND xcajent = ",g_enterprise
   PREPARE cursor_pre_29 FROM g_sql
       
END FUNCTION

################################################
#axcp006_temp
#ex:
#    /F
#  /E
# A  
#  \B  /D
#    \C
#      \★
#-----------------------------------------------
#          /α
#        /F
#       ★
#        \β
#          \D
#            \γ
#----------------------------------------------
# 1 2 3 4 5 6 7  -------level
#----------------------------------------------
#level 元件  上阶主件+数据  最终主件+数据
#  4   D     C            A
#  6   D     β            A
#level 是对最终主件而言的
#      若料件的条件只下到★，则元件D只有level=3的
################################################
PRIVATE FUNCTION axcp006_create()
   #DROP TABLE axcp006_temp
   #CREATE TEMP TABLE axcp006_temp
   #      (
   #           x_level	 LIKE type_t.num5,       #階數        
   #           xcad003    LIKE xcad_t.xcad003,    #元件料號 
   #           xcad002    LIKE xcad_t.xcad002,    #上阶主件
   #           xcad004    LIKE xcad_t.xcad004,    #組成用量(对上阶主件)
   #           xcad005    LIKE xcad_t.xcad005,    #底数(对上阶主件)            
   #           xcad006    LIKE xcad_t.xcad006,    #損耗率(对上阶主件)
   #           xcad007    LIKE xcad_t.xcad007,    #損耗量(对上阶主件) 
   #           main_item  LIKE xcad_t.xcad002,    #最终主件
   #           xcad004_m  LIKE xcad_t.xcad004,    #組成用量(对最终主件)
   #           xcad005_m  LIKE xcad_t.xcad005,    #底数(对最终主件)            
   #           xcad006_m  LIKE xcad_t.xcad006,    #損耗率(对最终主件)
   #           xcad007_m  LIKE xcad_t.xcad007     #損耗量(对最终主件)       
   #       );
   #CREATE INDEX axcp006_temp_ix1 ON axcp006_temp (xcad003)
   
   #有些资讯可以在产生临时表时直接获得，就直接写入临时表，减少后面的运算，提升效能
   #说明：项次+元件，就是指定的一个节点
   DROP TABLE axcp006_xcah;
   CREATE TEMP TABLE axcp006_xcah
         (
              xcah004    LIKE xcah_t.xcah004,   #最终主件料号 ** ##
              xcah012    LIKE xcah_t.xcah012,   #最终主件来源码
              xcah013    LIKE xcah_t.xcah013,   #最终主件单位 
              xcahseq    LIKE xcah_t.xcahseq,   #项次        ** @@
              xcah022    LIKE xcah_t.xcah022,   #元件料号    **  ##
              xcah023    LIKE xcah_t.xcah023,   #元件类型码
              xcah024    LIKE xcah_t.xcah024,   #元件单位
              xcah020    LIKE xcah_t.xcah020,   #阶数        **
              xcah021    LIKE xcah_t.xcah021,   #BOM序号：同阶数之最大BOM序号+10 **
              xcah042    LIKE xcah_t.xcah042,   #本阶对最终主件的底数
              xcah043    LIKE xcah_t.xcah043,   #本阶对最终主件的组成用量
              xcah044    LIKE xcah_t.xcah044,   #本阶对最终主件的损耗率
              num_m      LIKE xcad_t.xcad007,   #本阶对最终主件的固定损耗量（预留，xcah中没有）
              xcah040    LIKE xcah_t.xcah040,   #本阶主件料号    ** ##
              xcah041    LIKE xcah_t.xcah041,   #本阶主件来源码  
              xcah028	 LIKE xcah_t.xcah028,   #本阶主件在最终主件里的项次  ** @@
              xcah025    LIKE xcah_t.xcah025,   #本阶对上阶主件的底数     --尾阶料号在本阶BOM中的底数
              xcah026    LIKE xcah_t.xcah026,   #本阶对上阶主件的组成用量 --尾阶料号在本阶BOM中的
              xcah027    LIKE xcah_t.xcah027,   #本阶对上阶主件的损耗率   --尾阶料号在本阶BOM中的
              num_s      LIKE xcad_t.xcad007    #本阶对上阶主件的固定损耗量（预留，xcah中没有）
          );
   CREATE INDEX axcp006_xcah_fk ON axcp006_xcah (xcah004);
   CREATE INDEX axcp006_xcah_fk ON axcp006_xcah (xcah004,xcah028);
END FUNCTION

#删除旧资料
PRIVATE FUNCTION axcp006_process_del()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_wc        STRING
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #xcag
   LET l_wc = cl_replace_str(g_master.wc,"xcabsite","xcagsite")
   LET l_wc = cl_replace_str(l_wc,"xcab002","xcag004")
   LET g_sql = "DELETE FROM xcag_t ",
               " WHERE xcagent = ",g_enterprise,
               "   AND ",l_wc,                      #營運據點+料號
               "   AND xcag001 = '",g_master.xcaa001,"'", #標準分類碼
               "   AND xcag002 = '",g_master.xcag002,"'"  #生效日期
   PREPARE axcp006_del_xcag FROM g_sql   
   EXECUTE axcp006_del_xcag         
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xcag"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #xcah
   LET l_wc = cl_replace_str(l_wc,"xcag004","xcah004")
   LET l_wc = cl_replace_str(l_wc,"xcagsite","xcahsite")
   LET g_sql = "DELETE FROM xcah_t ",
               " WHERE xcahent = ",g_enterprise,
               " AND ",l_wc,                      #營運據點+料號
               " AND xcah001 = '", g_master.xcaa001,"'", #標準分類碼
               " AND xcah002 = '",g_master.xcag002,"'"
   PREPARE axcp006_del_xcah FROM g_sql   
   EXECUTE axcp006_del_xcah 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xcah"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #xcai
   LET l_wc = cl_replace_str(l_wc,"xcah004","xcai004")
   LET l_wc = cl_replace_str(l_wc,"xcahsite","xcaisite")
   LET g_sql = "DELETE FROM xcai_t ",
               " WHERE xcaient = ",g_enterprise,
               "   AND ",l_wc,                      #營運據點+料號
               "   AND xcai001 = '", g_master.xcaa001,"'", #標準分類碼
               "   AND xcai002 = '",g_master.xcag002,"'"
   PREPARE axcp006_del_xcai FROM g_sql   
   EXECUTE axcp006_del_xcai
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xcai"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #xcaj
   LET l_wc = cl_replace_str(l_wc,"xcai004","xcaj004")
   LET l_wc = cl_replace_str(l_wc,"xcaisite","xcajsite")
   LET g_sql = "DELETE FROM xcaj_t ",
               " WHERE xcajent = ",g_enterprise,
               "   AND ",l_wc,                      #營運據點+料號
               "   AND xcaj001 = '", g_master.xcaa001,"'", #標準分類碼
               "   AND xcaj002 = '",g_master.xcag002,"'"
   PREPARE axcp006_del_xcaj FROM g_sql
   EXECUTE axcp006_del_xcaj
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xcaj"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件獲取料號
# Memo...........:
# Usage..........: CALL axcp006_get_imaa001()
# Input parameter:  
# Return code....:  
# Date & Author..: 2015/4/24 By 00768
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_get_imaa001()
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_flag         LIKE type_t.chr1  #是否有查到料件资料

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_flag = 'N'  #没有符合条件的料件
   
   #定义cursor
   CALL axcp006_cursor()

   
   #add zhangllc 160629--s 效能优化版
   CALL axcp006_get_imaa001_exp() RETURNING r_success  #优化版
   RETURN r_success 
   #add zhangllc 160629--e
   
   #根据QBE条件g_wc_imaa001,按低阶码由高到低，抓取料件类别为MA的料件给g_imaa001
   LET g_sql = " SELECT imaa001,imaa004,imaa006 ",
               "   FROM imaa_t LEFT OUTER JOIN imac_t ON imaaent = imacent AND imaa001 = imac001 ",
               "  WHERE imaastus = 'Y' ",
              #"    AND (imaa004 = 'M' OR imaa004 = 'A') AND imaaent = ",g_enterprise                  #161107-00037#1 mark
               "    AND (imaa004 = 'M' OR imaa004 = 'A' OR imaa004 = 'X') AND imaaent = ",g_enterprise #161107-00037#1 add
   IF NOT cl_null(g_wc_imaa001) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_imaa001
   END IF
   LET g_sql = g_sql CLIPPED," ORDER BY imac003 desc"
   
   PREPARE axcp006_imaa001_pre FROM g_sql
   DECLARE axcp006_imaa001_cur CURSOR FOR axcp006_imaa001_pre 
   #DELETE FROM axcp006_temp
   DELETE FROM axcp006_xcah
   FOREACH axcp006_imaa001_cur INTO g_imaa001,g_imaa004,g_imaa006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach imaa001:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
  
      LET l_flag = 'Y'  #有符合条件的料件
      
      LET g_seq = 0  #项次，最终主件对应元件的项次
      #查詢出來的料號獲取BOM資料
      ##當前主件（最終主件）需插入臨時表，階層位1 
      ##                        階數    元件    上阶主件 組成用量  底数    損耗率  損耗量  
      #INSERT INTO axcp006_temp(x_level,xcad003,xcad002,xcad004,xcad005,xcad006,xcad007,
      ##                        最终主件   組成用量   底数      損耗率    損耗量 
      #                         main_item,xcad004_m,xcad005_m,xcad006_m,xcad007_m)
      #   VALUES(1,g_imaa001,g_imaa001,1,1,0,0,
      #          g_imaa001,1,1,0,0)
      ################
      #                    最终主件料号 类型码  单位 
      INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013,
      #                        项次    元件料号 类型码   单位    阶数    BOM序号
                               xcahseq,xcah022,xcah023,xcah024,xcah020,xcah021,
      #          本阶对最终主件的底数   组成用量 损耗率   损耗量
                               xcah042,xcah043,xcah044,num_m,
      #                    本阶主件料号 类型码  上阶项次
                               xcah040,xcah041,xcah028,
      #          本阶对上阶主件的底数   组成用量 损耗率   损耗量
                               xcah025,xcah026,xcah027,num_s)
         VALUES(g_imaa001,g_imaa004,g_imaa006,
                g_seq,g_imaa001,g_imaa004,g_imaa006,0,0,
                1,1,0,0,
                g_imaa001,g_imaa004,0,
                1,1,0,0)           
      ##说明：项次+元件，就是指定的一个节点                
      CALL axcp006_bom(0,g_imaa001,g_imaa004,g_seq,1,1,0,0) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH  
   
   IF r_success = TRUE AND l_flag = 'N' THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件獲取料號(效能优化版)
# Memo...........:
# Usage..........: CALL axcp006_get_imaa001_exp()
# Input parameter:  
# Return code....:  
# Date & Author..: 2016/06/29 By 00768 160629
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_get_imaa001_exp()
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_imac003      LIKE imac_t.imac003
DEFINE l_flag1        LIKE type_t.chr1   #160822-00024#1
DEFINE l_flag2        LIKE type_t.chr1   #160822-00024#1

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   DELETE FROM axcp006_xcah
   #根据QBE条件g_wc_imaa001,先获取第0层的xcah，抓取料件类别为MA的料件给g_imaa001
      #                                  最终主件料号 类型码  单位 
   LET g_sql = "INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013, ",
      #                                  最终主件对应元件的项次 元件料号 类型码   单位    阶数    BOM序号
               "                         xcahseq,             xcah022,xcah023,xcah024,xcah020,xcah021, ",
      #                                  本阶对最终主件的底数   组成用量 损耗率   损耗量
               "                         xcah042,xcah043,xcah044,num_m, ",
      #                                  本阶主件料号 类型码  上阶项次
               "                         xcah040,xcah041,xcah028, ",
      #                                  本阶对上阶主件的底数   组成用量 损耗率   损耗量
               "                         xcah025,xcah026,xcah027,num_s) ",
               " SELECT DISTINCT imaa001,imaa004,imaa006, ",           #161113-00001#1 add DISTINCT
               "        0,imaa001,imaa004,imaa006,0,0, ",
               "        1,1,0,0, ",
               "        imaa001,imaa004,0, ",
               "        1,1,0,0",
               "   FROM imaa_t  ",
               "  WHERE imaastus = 'Y' ",
               "    AND (imaa004 = 'M' OR imaa004 = 'A') AND imaaent = ",g_enterprise
   IF NOT cl_null(g_wc_imaa001) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_imaa001
   END IF
   #160822-00024#1---add---s
   LET l_flag1 = 'Y'
      #                                  最终主件料号 类型码  单位 
   LET g_sql = "INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013, ",
      #                                  最终主件对应元件的项次 元件料号 类型码   单位    阶数    BOM序号
               "                         xcahseq,             xcah022,xcah023,xcah024,xcah020,xcah021, ",
      #                                  本阶对最终主件的底数   组成用量 损耗率   损耗量
               "                         xcah042,xcah043,xcah044,num_m, ",
      #                                  本阶主件料号 类型码  上阶项次
               "                         xcah040,xcah041,xcah028, ",
      #                                  本阶对上阶主件的底数   组成用量 损耗率   损耗量
               "                         xcah025,xcah026,xcah027,num_s) ",
               " SELECT DISTINCT xcad002,imaa004,imaa006, ",                   #161113-00001#1 add DISTINCT
               "        0,xcad002,imaa004,imaa006,0,0, ",
               "        1,1,0,0, ",
               "        xcad002,imaa004,0, ",
               "        1,1,0,0",
               "   FROM xcad_t INNER JOIN imaa_t ON xcadent = imaaent AND xcad002 = imaa001 ",
               "  WHERE xcadstus = 'Y' ",
               "    AND (imaa004 = 'M' OR imaa004 = 'A') AND xcadent = ",g_enterprise,
               "    AND xcad001 = '",g_master.xcad001,"'"               
   IF NOT cl_null(g_wc_imaa001) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_imaa001
   END IF               
   #160822-00024#1---add---e
   
   PREPARE axcp006_get_imaa001_exp_p FROM g_sql   
   EXECUTE axcp006_get_imaa001_exp_p        
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "del xcag"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF SQLCA.sqlerrd[3] = 0 THEN
      #160822-00024#1---mod---s
      LET l_flag1 = 'N'
      #无资料产生
      #INITIALIZE g_errparam TO NULL
      #LET g_errparam.code = 'axc-00530'
      #LET g_errparam.extend = ""
      #LET g_errparam.popup = TRUE
      #CALL cl_err()
      #LET r_success = FALSE
      #RETURN r_success
      #160822-00024#1---mod---e
   END IF
   
   #按低阶码由高到低，抓取料件类别为MA的料件给g_imaa001
   #取低阶码
   DECLARE axcp006_get_imaa001_exp_p0 CURSOR FOR
    SELECT UNIQUE xcah004,xcah012,xcah013,imac003 #,xcbb006
      FROM axcp006_xcah,imac_t
     WHERE imacent=g_enterprise AND xcah004 = imac001
       AND EXISTS (SELECT 1 FROM xcad_t
                    WHERE xcad002 = xcah004 AND xcadent=g_enterprise AND xcad001 = g_m3aster.xcad001 )
     ORDER BY imac003  DESC
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "DECLARE axcp006_get_imaa001_exp_p0"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF 
   FOREACH axcp006_get_imaa001_exp_p0 INTO g_imaa001,g_imaa004,g_imaa006,l_imac003 #,l_xcbb006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH axcp006_get_imaa001_exp_p0"
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF 
      
      LET g_seq = 0  #项次
      
      ##说明：项次+元件，就是指定的一个节点                
      CALL axcp006_bom(0,g_imaa001,g_imaa004,g_seq,1,1,0,0) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END FOREACH
   
   #160822-00024#1---add---s
   LET l_flag2 = 'Y'
      #                                  最终主件料号 类型码  单位 
   LET g_sql = "INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013, ",
      #                                  最终主件对应元件的项次 元件料号 类型码   单位    阶数    BOM序号
               "                         xcahseq,             xcah022,xcah023,xcah024,xcah020,xcah021, ",
      #                                  本阶对最终主件的底数   组成用量 损耗率   损耗量
               "                         xcah042,xcah043,xcah044,num_m, ",
      #                                  本阶主件料号 类型码  上阶项次
               "                         xcah040,xcah041,xcah028, ",
      #                                  本阶对上阶主件的底数   组成用量 损耗率   损耗量
               "                         xcah025,xcah026,xcah027,num_s) ",
               " SELECT DISTINCT xcab002,imaa004,imaa006, ",              #161113-00001#1 add DISTINCT
               "        0,xcab002,imaa004,imaa006,0,0, ",
               "        1,1,0,0, ",
               "        xcab002,imaa004,0, ",
               "        1,1,0,0",
               "   FROM xcab_t INNER JOIN imaa_t ON xcabent = imaaent AND xcab002 = imaa001 ",
               "  WHERE xcabstus = 'Y' ",
               #"    AND (imaa004 = 'M' OR imaa004 = 'A') AND xcadent = ",g_enterprise,   #161113-00001#1 mark
               "    AND (imaa004 = 'M' OR imaa004 = 'A') AND xcabent = ",g_enterprise,    #161113-00001#1 add
               "    AND xcab001 = '",g_master.xcab001,"'",
               "    AND NOT EXISTS(SELECT 1 FROM axcp006_xcah WHERE xcab002 = xcah004 )"               
   IF NOT cl_null(g_wc_imaa001) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_imaa001
   END IF               
 
   PREPARE axcp006_get_imaa001_exp_p2 FROM g_sql   
   EXECUTE axcp006_get_imaa001_exp_p2 
   EXECUTE axcp006_get_imaa001_exp_p2        
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins xcah"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF SQLCA.sqlerrd[3] = 0 THEN
      LET l_flag2 = 'N'
   END IF
   IF l_flag1 = 'N' AND l_flag2 = 'N' THEN 
      #无资料产生
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00530'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success   
   END IF
   #160822-00024#1---add---e   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 根據最終主件展開BOM
# Memo...........:
# Usage..........: CALL axcp006_bom(p_level,p_key,p_imaa004,p_seq,p_xcad004,p_xcad005,p_xcad006,p_xcad007)
# Input parameter:  
# Return code....: 
# Date & Author..: 2014/3/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_bom(p_level,p_key,p_imaa004,p_seq,p_xcad004,p_xcad005,p_xcad006,p_xcad007)
DEFINE p_level	   LIKE type_t.num5  #阶数
DEFINE p_key      LIKE xcad_t.xcad003  #主件，传入时是元件，接收当主件用
DEFINE p_imaa004  LIKE imaa_t.imaa004  #p_key的imaa004,传入进来，不重新抓取，提高效率
DEFINE p_seq      LIKE type_t.num10    #传入的主件在最终主件中的项次
DEFINE p_xcad004  LIKE xcad_t.xcad004  #组成用量，对最终主件的
DEFINE p_xcad005  LIKE xcad_t.xcad005  #底数，对最终主件的
DEFINE p_xcad006  LIKE xcad_t.xcad006 #損耗率，对最终主件的
DEFINE p_xcad007  LIKE xcad_t.xcad007 #損耗量，对最终主件的
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num5
DEFINE i        LIKE type_t.num5
DEFINE l_xcah021    LIKE xcah_t.xcah021   #BOM序号
DEFINE sr DYNAMIC ARRAY OF RECORD
          xcad003   LIKE xcad_t.xcad003,      #元件料號 
          imaa004   LIKE imaa_t.imaa004,
          imaa006   LIKE imaa_t.imaa006,
          xcad004   LIKE xcad_t.xcad004,      #組成用量
          xcad005   LIKE xcad_t.xcad005,      #底数
          xcad006   LIKE xcad_t.xcad006,      #損耗率
          xcad007   LIKE xcad_t.xcad007       #損耗量
          END RECORD
DEFINE l_temp     RECORD  #本次展bom计算到的(对最终主件的) 插入时用的变量
          xcad003   LIKE xcad_t.xcad003,      #元件料號 
          xcad004   LIKE xcad_t.xcad004,      #組成用量
          xcad005   LIKE xcad_t.xcad005,      #底数
          xcad006   LIKE xcad_t.xcad006,      #損耗率
          xcad007   LIKE xcad_t.xcad007       #損耗量
                  END RECORD
#DEFINE l_multiplier     LIKE type_file.num10  #变成整数需乘以的乘数
#DEFINE l_temp2    RECORD  #总计算到的(对最终主件的) 更新时用的变量
#          x_level       LIKE type_t.num5,         #階數
#          xcad003   LIKE xcad_t.xcad003,      #元件料號 
#          xcad004   LIKE xcad_t.xcad004,      #組成用量
#          xcad005   LIKE xcad_t.xcad005,      #底数
#          xcad006   LIKE xcad_t.xcad006,      #損耗率
#          xcad007   LIKE xcad_t.xcad007       #損耗量
#                  END RECORD

   #阶数
   LET p_level = p_level + 1
   
   LET r_success = TRUE
   
   #防止死循环
   IF p_level = 50 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abm-00202'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET g_sql = " SELECT xcad_t.xcad003,imaa_t.imaa004,imaa_t.imaa006, ",
               "        xcad_t.xcad004,xcad_t.xcad005,xcad_t.xcad006,xcad_t.xcad007  ",
               "   FROM xcad_t LEFT JOIN imaa_t ON imaaent=xcadent AND imaa001=xcad003",
               "  WHERE xcad002 = '",p_key,"'",
               "    AND xcadent = ",g_enterprise,
               "    AND xcad001 = '",g_master.xcad001,"'",  #畫面上的BOM版本
               " ORDER BY xcad002,xcad003 "            
   PREPARE axcp006_pre1 FROM g_sql
   DECLARE axcp006_cur1 CURSOR FOR axcp006_pre1 
   LET l_cnt = 1
   FOREACH axcp006_cur1 INTO sr[l_cnt].xcad003,sr[l_cnt].imaa004,sr[l_cnt].imaa006,
                             sr[l_cnt].xcad004,sr[l_cnt].xcad005,sr[l_cnt].xcad006,sr[l_cnt].xcad007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach1:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
    
   IF l_cnt > 1 THEN  #下阶有元件，先产生DL+OH+SUB的资料
      LET g_seq = g_seq + 1  #元件项次
      #                    最终主件料号 类型码  单位 
      INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013,
      #                        项次    元件料号 类型码   单位    阶数    BOM序号
                               xcahseq,xcah022,xcah023,xcah024,xcah020,xcah021,
      #          本阶对最终主件的底数   组成用量 损耗率   损耗量
                               xcah042,xcah043,xcah044,num_m,
      #                    本阶主件料号 类型码  上阶项次
                               xcah040,xcah041,xcah028,
      #          本阶对上阶主件的底数   组成用量 损耗率   损耗量
                               xcah025,xcah026,xcah027,num_s)
         VALUES(g_imaa001,g_imaa004,g_imaa006,
                g_seq,'DL+OH+SUB','','',p_level,0,
                p_xcad005,p_xcad004,p_xcad006,p_xcad007,
                p_key,p_imaa004,p_seq,
                1,1,0,0) 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins temp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success            
      END IF 
   ELSE  #下阶没有元件,即是尾阶了，无需再插入及下展
      RETURN r_success  
   END IF
   
   #BOM序号：同阶数之最大BOM序号+10
   SELECT MAX(xcah021) INTO l_xcah021 FROM axcp006_xcah
    WHERE xcah004 = g_imaa001  #最终主件
      AND xcah020 = p_level    #阶数
   FOR i = 1 TO l_cnt-1
       LET g_seq = g_seq + 1  #元件项次
       LET l_xcah021 = l_xcah021 + 10  #BOM序号：同阶数之最大BOM序号+10
        
       INITIALIZE l_temp.* TO NULL
       #计算组成用量、底数=乘
       LET l_temp.xcad004 = p_xcad004 * sr[i].xcad004 #組成用量計算=上站对最终主件的*当站对上站的
       LET l_temp.xcad005 = p_xcad005 * sr[i].xcad005 #底數計算=上站对最终主件的*当站对上站的
       ##若底数是小数，改成整数型(为加法做准备)
       #LET l_multiplier = s_num_get_multiplier(l_temp.xcad005)  #变成整数需乘以的乘数
       #IF l_multiplier! = 1 THEN
       #   LET l_temp.xcad004 = l_temp.xcad004 * l_multiplier   #组成用量
       #   LET l_temp.xcad005 = l_temp.xcad005 * l_multiplier   #底数
       #END IF
       
       #计算损耗率=当阶的损耗率+上阶对最终主件的损耗率+上阶对最终主件的损耗率*当阶的损耗率
       IF sr[i].xcad006 IS NULL THEN LET sr[i].xcad006 = 0 END IF
       LET l_temp.xcad006 = sr[i].xcad006+p_xcad006+sr[i].xcad006*p_xcad006
       #计算损耗量=上阶对最终主件的损耗量 * 当阶的QPA + 当阶的损耗量
       #备注说明：此损耗量先这么算着记录下来，实际不使用，因为这样算有误差的，所以当做0处理
       #同时正确计算出当阶对最终主件的损耗率和损耗量无解，所以这里先损耗量因为有限的，可忽略不计
       #但这边只是先预留单独的运算逻辑，比忽略不计，误差会更小点
       IF sr[i].xcad007 IS NULL THEN LET sr[i].xcad007 = 0 END IF
       LET l_temp.xcad007 =  p_xcad007*sr[i].xcad004/sr[i].xcad005 + sr[i].xcad007
       
       #IF cl_null(sr[i].xcad003_t) THEN #临时表中不存在——新增
       #                    最终主件料号 类型码  单位 
       INSERT INTO axcp006_xcah(xcah004,xcah012,xcah013,
       #                        项次    元件料号 类型码   单位    阶数    BOM序号
                                xcahseq,xcah022,xcah023,xcah024,xcah020,xcah021,
       #          本阶对最终主件的底数   组成用量 损耗率   损耗量
                                xcah042,xcah043,xcah044,num_m,
       #                    本阶主件料号 类型码  上阶项次
                                xcah040,xcah041,xcah028,
       #          本阶对上阶主件的底数   组成用量 损耗率   损耗量
                                xcah025,xcah026,xcah027,num_s)
          VALUES(g_imaa001,g_imaa004,g_imaa006,
                 g_seq,sr[i].xcad003,sr[i].imaa004,sr[i].imaa006,p_level,l_xcah021,
                 l_temp.xcad005,l_temp.xcad004,l_temp.xcad006,l_temp.xcad007,
                 p_key,p_imaa004,p_seq,
                 sr[i].xcad005,sr[i].xcad004,sr[i].xcad006,sr[i].xcad007)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "ins temp"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success            
       END IF 
       #ELSE
       ##临时表中已存在——更新
       #   LET l_temp2.* = l_temp.*
       #   #階數
       #   IF l_temp.x_level > sr[i].x_level_t THEN
       #      LET l_temp2.x_level = l_temp.x_level        
       #   ELSE
       #      LET l_temp2.x_level = sr[i].x_level_t
       #   END IF
       #   
       #   #计算组成用量、底数（加法）=本次算到的（对最终主件） + 已经存在的（对最终主件）
       #   #底数=>最小公倍数方法
       #   LET l_temp2.xcad005 = s_num_get_lcm(l_temp.xcad005,sr[i].xcad005_t)
       #   #组成用量
       #   LET l_temp2.xcad004 = l_temp.xcad004 * l_temp2.xcad005 / l_temp.xcad005
       #                         +
       #                         sr[i].xcad004_t * l_temp2.xcad005 / sr[i].xcad005_t
       #
       #   #计算损耗率=【本次算到的损耗率*QPA+已经存在的损耗率*QPA】/总QPA
       #   LET l_temp2.xcad006 = (l_temp.xcad006*l_temp.xcad004/l_temp.xcad005+sr[i].xcad006_t*sr[i].xcad004_t/sr[i].xcad005_t)
       #                          /
       #                         (l_temp2.xcad004/l_temp2.xcad005)
       #   #计算损耗量=本次算到的 + 已经存在的
       #   LET l_temp2.xcad007 = l_temp.xcad007 + sr[i].xcad007_t
       #   
       #   UPDATE axcp006_temp SET x_level	= l_temp2.x_level,    #階數     
       #                           xcad004   = l_temp2.xcad004,    #組成用量 
       #                           xcad005   = l_temp2.xcad005,    #底数              
       #                           xcad006   = l_temp2.xcad006,    #損耗率 
       #                           xcad007   = l_temp2.xcad007     #損耗量   
       #    WHERE xcad003   = l_temp2.xcad003     #元件料號             
       #      AND main_item = g_imaa001         #最终主件
       #   IF SQLCA.sqlcode THEN
       #      INITIALIZE g_errparam TO NULL
       #      LET g_errparam.code = SQLCA.sqlcode
       #      LET g_errparam.extend = "upd temp"
       #      LET g_errparam.popup = TRUE
       #      CALL cl_err()
       #      LET r_success = FALSE
       #      RETURN r_success            
       #   END IF 
       ##临时表中已存在——更新 end
       #END IF
         
       #往下展
       CALL axcp006_bom(p_level,sr[i].xcad003,sr[i].imaa004,g_seq,l_temp.xcad004,l_temp.xcad005,l_temp.xcad006,l_temp.xcad007) RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
          RETURN r_success 
       END IF
   END FOR
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件獲取符合條件的site
# Memo...........:
# Usage..........: CALL axcp006_get_site()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_get_site()
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   
   #从wc中剥离出据点和物料的qbe条件g_wc_ooef001（*xcabsite*->*ooef001*），g_wc_imaa001（*xcab002*->*imaa001*）
   #CALL axcp006_get_wc()  #AFTER CONSTRUCT处有处理

   LET g_flag = 'N'  #默认没有符合条件的营运据点资料
   #根据据点的QBE条件g_wc_ooef001,抓取有效的组织编号给g_xcabsite
   LET g_sql = " SELECT DISTINCT ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise,
               "    AND ooefstus= 'Y' ",
               "    AND ooef201 = 'Y' "
   IF NOT cl_null(g_wc_ooef001) THEN    
      LET g_sql = g_sql CLIPPED," AND ",g_wc_ooef001
   END IF
   PREPARE axcp006_site_pre FROM g_sql
   DECLARE axcp006_site_cur CURSOR FOR axcp006_site_pre 
   FOREACH axcp006_site_cur INTO g_xcabsite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach site:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE  
         EXIT FOREACH
      END IF
      LET g_flag = 'Y'  #標示有符合條件的營運據點資料
      CALL axcp006_deal_imaa001() RETURNING l_success  #处理料件
      IF NOT l_success THEN 
         LET r_success = FALSE 
         RETURN r_success         
      END IF
   END FOREACH
   
   IF r_success = 'Y' AND g_flag = 'N' THEN
      LET r_success = 'N'
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 根據查詢條件獲取料號
# Memo...........:
# Usage..........: CALL axcp006_deal_imaa001()
# Input parameter:  
# Return code....:  
# Date & Author..: 2015/4/24 By 00768
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_deal_imaa001()
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_xcah004      LIKE xcah_t.xcah004

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #定义cursor
   CALL axcp006_cursor()

   #从临时表中抓取最终主件（也是画面下qbe条件锁获取的值）
   LET g_sql = " SELECT unique xcah004 FROM axcp006_xcah "
   PREPARE axcp006_deal_imaa001_pre FROM g_sql
   DECLARE axcp006_deal_imaa001_cur CURSOR FOR axcp006_deal_imaa001_pre 
   FOREACH axcp006_deal_imaa001_cur INTO l_xcah004  #最终主件
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach xcah004:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE 
         EXIT FOREACH
      END IF
      
      LET g_xcaiseq = 0  #項次

      CALL axcp006_ins_xcah(l_xcah004) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         #需計算標準成本的最终主件，在所有階層卷算完之后，可以將xcah的資料彙總到xcag中
         CALL axcp006_ins_xcag(l_xcah004) RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success 
         END IF
      END IF
   END FOREACH  
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: ins xcah
# Memo...........:
# Usage..........: CALL axcp006_ins_xcah(p_xcah004)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_ins_xcah(p_xcah004)
DEFINE p_xcah004      LIKE xcah_t.xcah004  #最终主件
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_xcab003    LIKE xcab_t.xcab003
DEFINE l_xcab004    LIKE xcab_t.xcab004
DEFINE l_rate       LIKE apca_t.apca101
#DEFINE l_xcah  RECORD LIKE xcah_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcah RECORD  #標準成本_元件組成明細檔
       xcahent LIKE xcah_t.xcahent, #企业编号
       xcahsite LIKE xcah_t.xcahsite, #营运据点
       xcahcomp LIKE xcah_t.xcahcomp, #法人组织
       xcah001 LIKE xcah_t.xcah001, #标准成本分类
       xcah002 LIKE xcah_t.xcah002, #生效日期
       xcah003 LIKE xcah_t.xcah003, #失效日期
       xcah004 LIKE xcah_t.xcah004, #主件料号
       xcahseq LIKE xcah_t.xcahseq, #项次
       xcah010 LIKE xcah_t.xcah010, #版本
       xcah011 LIKE xcah_t.xcah011, #币种
       xcah012 LIKE xcah_t.xcah012, #主件来源码
       xcah013 LIKE xcah_t.xcah013, #主件单位
       xcah020 LIKE xcah_t.xcah020, #阶数
       xcah021 LIKE xcah_t.xcah021, #BOM序号
       xcah022 LIKE xcah_t.xcah022, #元件料号
       xcah023 LIKE xcah_t.xcah023, #元件来源码
       xcah024 LIKE xcah_t.xcah024, #元件单位
       xcah025 LIKE xcah_t.xcah025, #本阶主件底数
       xcah026 LIKE xcah_t.xcah026, #本阶元件组成用量
       xcah027 LIKE xcah_t.xcah027, #本阶元件损耗率
       xcah028 LIKE xcah_t.xcah028, #上阶项次
       xcah030 LIKE xcah_t.xcah030, #单位成本
       xcah030a LIKE xcah_t.xcah030a, #单位成本-材料
       xcah030b LIKE xcah_t.xcah030b, #单位成本-人工
       xcah030c LIKE xcah_t.xcah030c, #单位成本-委外
       xcah030d LIKE xcah_t.xcah030d, #单位成本-制费一
       xcah030e LIKE xcah_t.xcah030e, #单位成本-制费二
       xcah030f LIKE xcah_t.xcah030f, #单位成本-制费三
       xcah030g LIKE xcah_t.xcah030g, #单位成本-制费四
       xcah030h LIKE xcah_t.xcah030h, #单位成本-制费五
       xcah031 LIKE xcah_t.xcah031, #成本金额
       xcah031a LIKE xcah_t.xcah031a, #成本金额-材料
       xcah031b LIKE xcah_t.xcah031b, #成本金额-人工
       xcah031c LIKE xcah_t.xcah031c, #成本金额-委外
       xcah031d LIKE xcah_t.xcah031d, #成本金额-制费一
       xcah031e LIKE xcah_t.xcah031e, #成本金额-制费二
       xcah031f LIKE xcah_t.xcah031f, #成本金额-制费三
       xcah031g LIKE xcah_t.xcah031g, #成本金额-制费四
       xcah031h LIKE xcah_t.xcah031h, #成本金额-制费五
       xcah040 LIKE xcah_t.xcah040, #本阶主件料号
       xcah041 LIKE xcah_t.xcah041, #本阶主件类别码
       xcah042 LIKE xcah_t.xcah042, #最终主件底数
       xcah043 LIKE xcah_t.xcah043, #本阶主件组成用量
       xcah044 LIKE xcah_t.xcah044, #本阶主件损耗率
       xcah101 LIKE xcah_t.xcah101, #归属主成本要素
       xcah102 LIKE xcah_t.xcah102, #归属次成本要素
       xcahownid LIKE xcah_t.xcahownid, #资料所有者
       xcahowndp LIKE xcah_t.xcahowndp, #资料所有部门
       xcahcrtid LIKE xcah_t.xcahcrtid, #资料录入者
       xcahcrtdp LIKE xcah_t.xcahcrtdp, #资料录入部门
       xcahcrtdt LIKE xcah_t.xcahcrtdt, #资料创建日
       xcahmodid LIKE xcah_t.xcahmodid, #资料更改者
       xcahmoddt LIKE xcah_t.xcahmoddt, #最近更改日
       xcahstus LIKE xcah_t.xcahstus #状态码
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE i       LIKE type_t.num5
DEFINE l_cnt1     LIKE type_t.num5
DEFINE l_cnt2     LIKE type_t.num5 #=0代表是尾阶
DEFINE lc_param    type_parameter
DEFINE l_cnt      LIKE type_t.num5
DEFINE sr   RECORD
            xcah004   LIKE xcah_t.xcah004,  #最终主件料号
            xcah012   LIKE xcah_t.xcah012,  #类型码
            xcah013   LIKE xcah_t.xcah013,  #单位
            #--
            xcahseq   LIKE xcah_t.xcahseq,  #项次
            xcah022   LIKE xcah_t.xcah022,  #元件料号
            xcah023   LIKE xcah_t.xcah023,  #类型码
            xcah024   LIKE xcah_t.xcah024,  #单位
            xcah020   LIKE xcah_t.xcah020,  #阶数
            xcah021   LIKE xcah_t.xcah021,  #BOM序号
            #--
            xcah042   LIKE xcah_t.xcah042,  #本阶对最终主件的底数（元件角度看）
            xcah043   LIKE xcah_t.xcah043,  #本阶对最终主件的组成用量
            xcah044   LIKE xcah_t.xcah044,  #本阶对最终主件的损耗率
            num_m     LIKE xcad_t.xcad007,  #本阶对最终主件的固定损耗量（预留，xcah中没有）
            #--
            xcah040   LIKE xcah_t.xcah040,  #本阶主件料号
            xcah041   LIKE xcah_t.xcah041,  #类型码
            xcah028   LIKE xcah_t.xcah028,  #上阶项次
            #--
            xcah025   LIKE xcah_t.xcah025,  #本阶对上阶主件的底数
            xcah026   LIKE xcah_t.xcah026,  #组成用量
            xcah027   LIKE xcah_t.xcah027,  #损耗率
            num_s     LIKE xcad_t.xcad007   #本阶对最终主件的固定损耗量（预留，xcah中没有）
            END RECORD 

   LET r_success = TRUE
   
   #根据QBE条件g_wc_imaa001,按低阶码由高到低，抓取料件类别为MA的料件给g_imaa001
   #                最终主件料号 类型码  单位 
   LET g_sql = " SELECT xcah004,xcah012,xcah013, ",
   #                    项次    元件料号 类型码   单位    阶数    BOM序号
               "        xcahseq,xcah022,xcah023,xcah024,xcah020,xcah021, ",
   #         本阶对最终主件的底数 组成用量 损耗率  损耗量
               "        xcah042,xcah043,xcah044,num_m, ",
   #                本阶主件料号 类型码  上阶项次
               "        xcah040,xcah041,xcah028, ",
   #         本阶对上阶主件的底数 组成用量 损耗率  损耗量
               "        xcah025,xcah026,xcah027,num_s ",
               "   FROM axcp006_xcah ",
               "  WHERE xcah004 = '",p_xcah004,"' ", #最终主件
               "  ORDER BY xcah020 DESC,xcahseq "            #按阶数降序便于汇总,按项次升序可优先抓取DL+OH+SUB的组成用量、底数、损耗率
   PREPARE axcp006_ins_xcah_pre FROM g_sql
   DECLARE axcp006_ins_xcah_cur CURSOR FOR axcp006_ins_xcah_pre 
   #根据最终主件抓取所有临时表的信息（按阶数降阶）
   FOREACH axcp006_ins_xcah_cur INTO sr.xcah004,sr.xcah012,sr.xcah013,
                                     sr.xcahseq,sr.xcah022,sr.xcah023,sr.xcah024,sr.xcah020,sr.xcah021, 
                                     sr.xcah042,sr.xcah043,sr.xcah044,sr.num_m,
                                     sr.xcah040,sr.xcah041,sr.xcah028, 
                                     sr.xcah025,sr.xcah026,sr.xcah027,sr.num_s
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach axcp006_ins_xcah_cur:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE 
         EXIT FOREACH
      END IF
      
      ##level=0的元件也就是最终主件那笔，若有bom结构不需插入xcah，无bom结构则应当按采购件计算材料的成本
      #IF sr.xcah020 = 0 THEN
      #   CONTINUE FOREACH
      #END IF
      #mark 都插入到xcah中，如果是采购件，还可以计算材料成本
      
      #给l_xcah赋值并插入xcah_t中
      #元件为DL+OH+SUB的计算人工、委外、制费
      #元件非DL+OH+SUB的判断是否有下阶,无下阶的代表尾阶，获取材料费用
      #                              有下阶的需要合计其下阶的各项费用
      INITIALIZE l_xcah.* TO NULL
      LET l_xcah.xcahent = g_enterprise        #企業編號
      LET l_xcah.xcahsite = g_xcabsite         #畫面檔中查詢出來的營運據點
      #營運據點所屬法人  
      #-----------------------------------------------
      #SELECT ooef017 INTO l_xcah.xcahcomp FROM ooef_t
      # WHERE ooef001 = g_xcabsite AND ooefent = g_enterprise
      EXECUTE cursor_pre_3 USING g_xcabsite INTO l_xcah.xcahcomp  #法人組織
      #------------------------------------------------         
       
      LET l_xcah.xcah001 = g_master.xcaa001    #標準成本分類,来源于成本卷算作业录入的成本类型
      LET l_xcah.xcah002 = g_master.xcag002    #生效日期,来源于成本卷算作业选择的生效日期
      LET l_xcah.xcah003 = g_master.xcag003    #失效日期,来源于成本卷算作业选择的失效日期
      LET l_xcah.xcah004 = sr.xcah004          #最終主件
      LET l_xcah.xcahseq = sr.xcahseq          #項次
      LET l_xcah.xcah010 = ' '                 #版本
      LET l_xcah.xcah011 = g_master.ooai001    #幣別
      #最终主件（即标准成本计算料号）  
      LET l_xcah.xcah012 = sr.xcah012          #最终主件的类别码
      LET l_xcah.xcah013 = sr.xcah013          #最终主件的单位	
      #元件
      LET l_xcah.xcah020 = sr.xcah020          #阶数
      LET l_xcah.xcah021 = sr.xcah021          #同阶数之最大BOM序号+10 #BOM序號
      LET l_xcah.xcah022 = sr.xcah022          #元件料号  
      LET l_xcah.xcah023 = sr.xcah023          #元件类型码
      LET l_xcah.xcah024 = sr.xcah024          #元件单位  
      #本阶主件料号
      LET l_xcah.xcah040 = sr.xcah040  #本阶主件料号
      LET l_xcah.xcah041 = sr.xcah041  #本阶主件类别码 
      LET l_xcah.xcah025 = sr.xcah025  #本階主件底數
      LET l_xcah.xcah026 = sr.xcah026  #本階元件組成用量
      LET l_xcah.xcah027 = sr.xcah027  #本階元件損耗率
                                       #sr.num_s 损耗量 预留
      LET l_xcah.xcah028 =	sr.xcah028  #上階項次
      
      #单位成本
      LET l_xcah.xcah030a = 0   #幣別轉化得出的單位成本-材料
      LET l_xcah.xcah030b = 0   #單位成本-人工
      LET l_xcah.xcah030c = 0   #單位成本-委外
      LET l_xcah.xcah030d = 0   #單位成本-制費一
      LET l_xcah.xcah030e = 0   #單位成本-制費二
      LET l_xcah.xcah030f = 0   #單位成本-制費三
      LET l_xcah.xcah030g = 0   #單位成本-制費四
      LET l_xcah.xcah030h = 0   #單位成本-制費五
      LET l_xcah.xcah030  = 0   #單位成本
      #成本金额
      LET l_xcah.xcah031a = 0    #成本金額-材料
      LET l_xcah.xcah031b = 0    #成本金额-人工
      LET l_xcah.xcah031c = 0    #成本金额-委外
      LET l_xcah.xcah031d = 0    #成本金额-制费一   
      LET l_xcah.xcah031e = 0    #成本金额-制费二  
      LET l_xcah.xcah031f = 0    #成本金额-制费三               
      LET l_xcah.xcah031g = 0    #成本金额-制费四
      LET l_xcah.xcah031h = 0    #成本金额-制费五
      LET l_xcah.xcah031  = 0    #成本金額

      #最终主件
      LET l_xcah.xcah043 = sr.xcah043          #本阶对最终主件的组成用量
      LET l_xcah.xcah042 = sr.xcah042          #本阶对最终主件的底数
      LET l_xcah.xcah044 = sr.xcah044          #本阶对最终主件的损耗率
                                               #sr.num_m 损耗量 预留
      #成本要素
      LET l_xcah.xcah101 =''   #歸屬主成本要素
      LET l_xcah.xcah102 =''   #歸屬成本次要素

      LET l_xcah.xcahownid = g_user  #資料所有者
      LET l_xcah.xcahowndp = g_dept  #資料所屬部門
      LET l_xcah.xcahcrtid = g_user  #資料建立者
      LET l_xcah.xcahcrtdp = g_dept  #資料建立部門 
      LET l_xcah.xcahcrtdt = cl_get_current() #資料創建日
      LET l_xcah.xcahmoddt = ''   #最近修改日 
      LET l_xcah.xcahstus  = 'Y'  #狀態碼
      
      IF l_xcah.xcah022 = 'DL+OH+SUB' THEN
      #DL+OH+SUB --begin
         #資源費用的成本計算--先新增xaci
         #                      最终主件       本阶对最终主件的底数\组成用量\损耗率            本阶主件料号    本阶主件在最终主件里的项次
         CALL axcp006_ins_xcai(l_xcah.xcah004,l_xcah.xcah042,l_xcah.xcah043,l_xcah.xcah044,l_xcah.xcah040,l_xcah.xcah028)
            RETURNING l_success
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         #单位成本
         LET l_xcah.xcah030a = 0 #单位成本-材料
         #------------------------------------------
         #SELECT SUM(xcai107) INTO l_xcah.xcah030b FROM xcai_t 
         # WHERE xcaient = g_enterprise
         #   AND xcaisite = g_xcabsite
         #   AND xcai001 = g_master.xcaa001
         #   AND xcai002 = g_master.xcag002
         #   AND xcai004 = l_xcah.xcah004  #最终主件
         #   AND xcai100 = l_xcah.xcah040  #本階主件
         ##   AND xcai109 = l_xcah.xcah028  #本阶主件在最终主件里的项次  如果xcai计算时不涉及QPA，损耗量等计算，则此行不需要
         #   AND xcai201 = 2人工 3委外 4制費一 5制費二 6制費三 7制費四 8制費五  
         
         #mod zhangllc 160623#2--s add l_xcah.xcah028 & mod l_xcah.xcah030 to l_xcah.xcah031
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'2'
         #   INTO l_xcah.xcah030b                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'3'
         #   INTO l_xcah.xcah030c                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'4'
         #   INTO l_xcah.xcah030d                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'5'
         #   INTO l_xcah.xcah030e                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'6'
         #   INTO l_xcah.xcah030f                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'7'
         #   INTO l_xcah.xcah030g                                                                                    
         #EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,'8'
         #   INTO l_xcah.xcah030h
         #IF cl_null(l_xcah.xcah030a) THEN LET l_xcah.xcah030a = 0 END IF    
         #IF cl_null(l_xcah.xcah030b) THEN LET l_xcah.xcah030b = 0 END IF
         #IF cl_null(l_xcah.xcah030d) THEN LET l_xcah.xcah030d = 0 END IF    
         #IF cl_null(l_xcah.xcah030c) THEN LET l_xcah.xcah030c = 0 END IF  
         #IF cl_null(l_xcah.xcah030e) THEN LET l_xcah.xcah030e = 0 END IF
         #IF cl_null(l_xcah.xcah030f) THEN LET l_xcah.xcah030f = 0 END IF    
         #IF cl_null(l_xcah.xcah030g) THEN LET l_xcah.xcah030g = 0 END IF     
         #IF cl_null(l_xcah.xcah030h) THEN LET l_xcah.xcah030h = 0 END IF            
         #LET l_xcah.xcah030 = l_xcah.xcah030a+l_xcah.xcah030b+l_xcah.xcah030c+l_xcah.xcah030d+l_xcah.xcah030e+
         #                     l_xcah.xcah030f+l_xcah.xcah030g+l_xcah.xcah030h
         ##成本金额
         #LET l_xcah.xcah031a = l_xcah.xcah030a * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100) 
         #LET l_xcah.xcah031b = l_xcah.xcah030b * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)                  
         #LET l_xcah.xcah031c = l_xcah.xcah030c * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)                     
         #LET l_xcah.xcah031d = l_xcah.xcah030d * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
         #LET l_xcah.xcah031e = l_xcah.xcah030e * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
         #LET l_xcah.xcah031f = l_xcah.xcah030f * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
         #LET l_xcah.xcah031g = l_xcah.xcah030g * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
         #LET l_xcah.xcah031h = l_xcah.xcah030h * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
         #IF cl_null(l_xcah.xcah031a) THEN LET l_xcah.xcah031a = 0 END IF    
         #IF cl_null(l_xcah.xcah031b) THEN LET l_xcah.xcah031b = 0 END IF
         #IF cl_null(l_xcah.xcah031d) THEN LET l_xcah.xcah031d = 0 END IF    
         #IF cl_null(l_xcah.xcah031c) THEN LET l_xcah.xcah031c = 0 END IF  
         #IF cl_null(l_xcah.xcah031e) THEN LET l_xcah.xcah031e = 0 END IF
         #IF cl_null(l_xcah.xcah031f) THEN LET l_xcah.xcah031f = 0 END IF    
         #IF cl_null(l_xcah.xcah031g) THEN LET l_xcah.xcah031g = 0 END IF     
         #IF cl_null(l_xcah.xcah031h) THEN LET l_xcah.xcah031h = 0 END IF                          
         #LET l_xcah.xcah031 = l_xcah.xcah031a+l_xcah.xcah031b+l_xcah.xcah031c+l_xcah.xcah031d+l_xcah.xcah031e+
         #                     l_xcah.xcah031f+l_xcah.xcah031g+l_xcah.xcah031h
         
         #成本金额
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'2'
            INTO l_xcah.xcah031b                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'3'
            INTO l_xcah.xcah031c                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'4'
            INTO l_xcah.xcah031d                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'5'
            INTO l_xcah.xcah031e                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'6'
            INTO l_xcah.xcah031f                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'7'
            INTO l_xcah.xcah031g                                                                                                   
         EXECUTE cursor_pre_11 USING g_xcabsite,g_master.xcaa001,g_master.xcag002,l_xcah.xcah004,l_xcah.xcah040,l_xcah.xcah028,'8'
            INTO l_xcah.xcah031h
         IF cl_null(l_xcah.xcah031a) THEN LET l_xcah.xcah031a = 0 END IF    
         IF cl_null(l_xcah.xcah031b) THEN LET l_xcah.xcah031b = 0 END IF
         IF cl_null(l_xcah.xcah031d) THEN LET l_xcah.xcah031d = 0 END IF    
         IF cl_null(l_xcah.xcah031c) THEN LET l_xcah.xcah031c = 0 END IF  
         IF cl_null(l_xcah.xcah031e) THEN LET l_xcah.xcah031e = 0 END IF
         IF cl_null(l_xcah.xcah031f) THEN LET l_xcah.xcah031f = 0 END IF    
         IF cl_null(l_xcah.xcah031g) THEN LET l_xcah.xcah031g = 0 END IF     
         IF cl_null(l_xcah.xcah031h) THEN LET l_xcah.xcah031h = 0 END IF                          
         LET l_xcah.xcah031 = l_xcah.xcah031a+l_xcah.xcah031b+l_xcah.xcah031c+l_xcah.xcah031d+l_xcah.xcah031e+
                              l_xcah.xcah031f+l_xcah.xcah031g+l_xcah.xcah031h
         #单位成本
         LET l_xcah.xcah030a = l_xcah.xcah031a * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030b = l_xcah.xcah031b * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030c = l_xcah.xcah031c * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030d = l_xcah.xcah031d * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030e = l_xcah.xcah031e * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030f = l_xcah.xcah031f * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030g = l_xcah.xcah031g * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         LET l_xcah.xcah030h = l_xcah.xcah031h * l_xcah.xcah042/(l_xcah.xcah043*(1+l_xcah.xcah044/100) )
         IF cl_null(l_xcah.xcah030a) THEN LET l_xcah.xcah030a = 0 END IF    
         IF cl_null(l_xcah.xcah030b) THEN LET l_xcah.xcah030b = 0 END IF
         IF cl_null(l_xcah.xcah030d) THEN LET l_xcah.xcah030d = 0 END IF    
         IF cl_null(l_xcah.xcah030c) THEN LET l_xcah.xcah030c = 0 END IF  
         IF cl_null(l_xcah.xcah030e) THEN LET l_xcah.xcah030e = 0 END IF
         IF cl_null(l_xcah.xcah030f) THEN LET l_xcah.xcah030f = 0 END IF    
         IF cl_null(l_xcah.xcah030g) THEN LET l_xcah.xcah030g = 0 END IF     
         IF cl_null(l_xcah.xcah030h) THEN LET l_xcah.xcah030h = 0 END IF            
         LET l_xcah.xcah030 = l_xcah.xcah030a+l_xcah.xcah030b+l_xcah.xcah030c+l_xcah.xcah030d+l_xcah.xcah030e+
                              l_xcah.xcah030f+l_xcah.xcah030g+l_xcah.xcah030h
         #mod zhangllc 160623#2--e
      #DL+OH+SUB --end
      ELSE
      #正常料件，即非DL+OH+SUB --begin
         #判断是否尾阶的料号 是尾阶料号计算材料成本，不是尾阶料号汇总下阶的成本
         LET l_cnt2 = 0 
         #-------------------------------------
         #SELECT COUNT(*) INTO l_cnt2 FROM xcad_t 
         # WHERE xcad002 = l_xcah.xcah022 #元件料号
         #   AND xcad001 = g_master.xcad001
         #   AND xcadent = g_enterprise
         EXECUTE cursor_pre_2 USING l_xcah.xcah022,g_master.xcad001 INTO l_cnt2
         #-------------------------------------   
         IF l_cnt2 = 0 THEN
            #是尾阶 计算尾阶材料成本
            LET l_xcah.xcah101 =''   #歸屬主成本要素
            #根據元件-成本次要素
            #------------------------------------------------
            #SELECT xcax002 INTO l_xcah.xcah102 FROM xcax_t
            # WHERE xcaxent = g_enterprise
            #   AND xcaxsite = g_xcabsite
            #   AND xcax001 = l_xcah.xcah022  #元件料號
            EXECUTE cursor_pre_9 USING g_xcabsite,l_xcah.xcah022 INTO l_xcah.xcah102
            
           #IF SQLCA.sqlcode THEN       #160829-00010#1 mark
            IF SQLCA.sqlcode AND cl_get_para(g_enterprise,g_site,'S-FIN-6015') = 'Y' THEN   #160829-00010#1 add 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axc-00085'
               LET g_errparam.extend = l_xcah.xcah022
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET r_success = FALSE
            END IF
            IF cl_null(l_xcah.xcah102) THEN LET l_xcah.xcah102 = ' ' END IF   #160829-00010#1 add 
            #-------------------------------------------------

            #根據元件获得币别和成本
            #先检查能不能抓到，抓不到需提示下信息
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt FROM xcab_t  #材料幣別、成本
            WHERE xcab001 = g_master.xcab001 #版本           
              AND xcabent = g_enterprise
              AND xcab002 = l_xcah.xcah022 
            IF l_cnt =  0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axc-00305'  #来源币别为空,请检查！
               LET g_errparam.extend = l_xcah.xcah022
               LET g_errparam.popup = TRUE
               CALL cl_err()     
              #LET r_success = FALSE #161107-00037#1 mark
            END IF
            #----------------------------------------------------
            #SELECT xcab003,xcab004 INTO l_xcab003,l_xcab004 FROM xcab_t  #材料幣別、成本
            #WHERE xcab001 = g_master.xcab001  #版本           
            #  AND xcabent = g_enterprise
            #  AND xcab002 = l_xcah.xcah022 
            EXECUTE cursor_pre_10 USING g_master.xcab001,l_xcah.xcah022 INTO l_xcab003,l_xcab004  
            #----------------------------------------------------
            #获得画面币别的成本
            IF NOT cl_null(l_xcab003) THEN 
               #根據畫面幣別、材料成本、畫面匯率方式、畫面匯率日期算出匯率
               CALL s_aooi160_get_exrate('1',g_xcabsite,g_master.ooam004,l_xcab003,
                                     #目的幣別                 #匯類類型
                                     g_master.ooai001,0,g_master.a)
                 RETURNING l_rate
            END IF
            #单位成本
            LET l_xcah.xcah030a = l_rate * l_xcab004   #幣別轉化得出的單位成本-材料
            LET l_xcah.xcah030b = 0   #單位成本-人工
            LET l_xcah.xcah030c = 0   #單位成本-委外
            LET l_xcah.xcah030d = 0   #單位成本-制費一
            LET l_xcah.xcah030e = 0   #單位成本-制費二
            LET l_xcah.xcah030f = 0   #單位成本-制費三
            LET l_xcah.xcah030g = 0   #單位成本-制費四
            LET l_xcah.xcah030h = 0   #單位成本-制費五
            ##成本金額-材料（xcah031a）=单位成本(xcah030a)*[（元件组成用量(xcah026)/上阶主件底数（xcah025））*（1+元件损耗率(xcah027)）*（上阶主件组成用量(xcah043)/最终主件底数(xcah042)）*（1+上阶损耗率（xcah044））]
            #LET l_xcah.xcah031a = l_xcah.xcah030a * (l_xcah.xcah026/l_xcah.xcah025)*(1+(l_xcah.xcah027/100))*(l_xcah.xcah043/l_xcah.xcah042)*(1+(l_xcah.xcah044/100)) 
            #成本金额-材料（xcah031a）=单位成本(xcah030a)*[（尾阶对最终主件的组成用量/底数*（1+损耗率）+损耗量）]  #损耗量先算0，因为xcah没有损耗量
            LET l_xcah.xcah031a = l_xcah.xcah030a *l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)    
            LET l_xcah.xcah031b = 0    #成本金额-人工
            LET l_xcah.xcah031c = 0    #成本金额-委外
            LET l_xcah.xcah031d = 0    #成本金额-制费一   
            LET l_xcah.xcah031e = 0    #成本金额-制费二  
            LET l_xcah.xcah031f = 0    #成本金额-制费三               
            LET l_xcah.xcah031g = 0    #成本金额-制费四
            LET l_xcah.xcah031h = 0    #成本金额-制费五
         ELSE
         #非尾阶  计算得此元件下阶汇总过来的单位成本和成本金额  
            #单位成本
            #mod zhangllc 160623#1--s  单位成本没有按本阶QPA计算，导致最终汇总的成本金额不对
            #SELECT SUM(xcah030a),SUM(xcah030b),SUM(xcah030c),SUM(xcah030d),SUM(xcah030e),SUM(xcah030f),SUM(xcah030g),SUM(xcah030h)
            SELECT SUM(xcah030a*xcah026/xcah025*(1+xcah027/100)),SUM(xcah030b*xcah026/xcah025*(1+xcah027/100)),
                   SUM(xcah030c*xcah026/xcah025*(1+xcah027/100)),SUM(xcah030d*xcah026/xcah025*(1+xcah027/100)),
                   SUM(xcah030e*xcah026/xcah025*(1+xcah027/100)),SUM(xcah030f*xcah026/xcah025*(1+xcah027/100)),
                   SUM(xcah030g*xcah026/xcah025*(1+xcah027/100)),SUM(xcah030h*xcah026/xcah025*(1+xcah027/100))
            #mod zhangllc 160623#1--e
              INTO l_xcah.xcah030a,l_xcah.xcah030b,l_xcah.xcah030c,l_xcah.xcah030d,l_xcah.xcah030e,l_xcah.xcah030f,l_xcah.xcah030g,l_xcah.xcah030h
              FROM xcah_t 
             WHERE xcahent = g_enterprise
               AND xcahsite = g_xcabsite
               AND xcah001 = g_master.xcaa001 #標準成本分類
               AND xcah002 = g_master.xcag002 #生效日期
               AND xcah004 = l_xcah.xcah004  #最终主件
               AND xcah040 = l_xcah.xcah022  #本階主件=当笔元件
               AND xcah028 = l_xcah.xcahseq  #本阶主件在最终主件里的项次=当笔元件在最终主件里的项次
            IF cl_null(l_xcah.xcah030a) THEN LET l_xcah.xcah030a = 0 END IF    
            IF cl_null(l_xcah.xcah030b) THEN LET l_xcah.xcah030b = 0 END IF
            IF cl_null(l_xcah.xcah030d) THEN LET l_xcah.xcah030d = 0 END IF    
            IF cl_null(l_xcah.xcah030c) THEN LET l_xcah.xcah030c = 0 END IF  
            IF cl_null(l_xcah.xcah030e) THEN LET l_xcah.xcah030e = 0 END IF
            IF cl_null(l_xcah.xcah030f) THEN LET l_xcah.xcah030f = 0 END IF    
            IF cl_null(l_xcah.xcah030g) THEN LET l_xcah.xcah030g = 0 END IF     
            IF cl_null(l_xcah.xcah030h) THEN LET l_xcah.xcah030h = 0 END IF            
            LET l_xcah.xcah030 = l_xcah.xcah030a+l_xcah.xcah030b+l_xcah.xcah030c+l_xcah.xcah030d+l_xcah.xcah030e+
                                 l_xcah.xcah030f+l_xcah.xcah030g+l_xcah.xcah030h
            #成本金额
            LET l_xcah.xcah031a = l_xcah.xcah030a * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100) 
            LET l_xcah.xcah031b = l_xcah.xcah030b * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)                  
            LET l_xcah.xcah031c = l_xcah.xcah030c * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)                     
            LET l_xcah.xcah031d = l_xcah.xcah030d * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
            LET l_xcah.xcah031e = l_xcah.xcah030e * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
            LET l_xcah.xcah031f = l_xcah.xcah030f * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
            LET l_xcah.xcah031g = l_xcah.xcah030g * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
            LET l_xcah.xcah031h = l_xcah.xcah030h * l_xcah.xcah043/l_xcah.xcah042*(1+l_xcah.xcah044/100)
            IF cl_null(l_xcah.xcah031a) THEN LET l_xcah.xcah031a = 0 END IF    
            IF cl_null(l_xcah.xcah031b) THEN LET l_xcah.xcah031b = 0 END IF
            IF cl_null(l_xcah.xcah031d) THEN LET l_xcah.xcah031d = 0 END IF    
            IF cl_null(l_xcah.xcah031c) THEN LET l_xcah.xcah031c = 0 END IF  
            IF cl_null(l_xcah.xcah031e) THEN LET l_xcah.xcah031e = 0 END IF
            IF cl_null(l_xcah.xcah031f) THEN LET l_xcah.xcah031f = 0 END IF    
            IF cl_null(l_xcah.xcah031g) THEN LET l_xcah.xcah031g = 0 END IF     
            IF cl_null(l_xcah.xcah031h) THEN LET l_xcah.xcah031h = 0 END IF                          
            LET l_xcah.xcah031 = l_xcah.xcah031a+l_xcah.xcah031b+l_xcah.xcah031c+l_xcah.xcah031d+l_xcah.xcah031e+
                                 l_xcah.xcah031f+l_xcah.xcah031g+l_xcah.xcah031h
                                 
            #add point 如果因QPA小数误差导致的最终主件成本金额与展开所有元件的sum值不符，可考虑增加以下逻辑（方案是否可行？）
            #判断最终主件成本金额与展开所有元件的sum值是否相等，若不等，则：
            #1.xcah031的值用xcah030的同样获取方式，用sum的方式获得
            #2.重新根据xcah031，反推xcah030
         END IF  #是否尾阶，不同处理方式
      #正常料件，即非DL+OH+SUB --end
      END IF
      LET l_xcah.xcah030 = l_xcah.xcah030a + l_xcah.xcah030b + l_xcah.xcah030c + l_xcah.xcah030d + 
                           l_xcah.xcah030e + l_xcah.xcah030f + l_xcah.xcah030g + l_xcah.xcah030h
      LET l_xcah.xcah031 = l_xcah.xcah031a + l_xcah.xcah031b + l_xcah.xcah031c + l_xcah.xcah031d +
                           l_xcah.xcah031e + l_xcah.xcah031f + l_xcah.xcah031g + l_xcah.xcah031h
      
      #插入正常元件的资料，尾阶有材料成本，非尾阶没有
      #INSERT INTO xcah_t VALUES(l_xcah.*)  #161124-00048#16  2016/12/16  By 08734 mark
      INSERT INTO xcah_t(xcahent,xcahsite,xcahcomp,xcah001,
       xcah002,xcah003,xcah004,xcahseq,xcah010,xcah011,xcah012,xcah013,xcah020,xcah021,
       xcah022,xcah023,xcah024,xcah025,xcah026,xcah027,xcah028,xcah030,xcah030a,xcah030b,
       xcah030c,xcah030d,xcah030e,xcah030f,xcah030g,xcah030h,xcah031,xcah031a,xcah031b,xcah031c,
       xcah031d,xcah031e,xcah031f,xcah031g,xcah031h,xcah040,xcah041,xcah042,xcah043,xcah044,
       xcah101,xcah102,xcahownid,xcahowndp,xcahcrtid,xcahcrtdp,xcahcrtdt,xcahmodid,xcahmoddt,xcahstus)    #161124-00048#16  2016/12/16  By 08734 add
         VALUES(l_xcah.xcahent,l_xcah.xcahsite,l_xcah.xcahcomp,l_xcah.xcah001,
       l_xcah.xcah002,l_xcah.xcah003,l_xcah.xcah004,l_xcah.xcahseq,l_xcah.xcah010,l_xcah.xcah011,l_xcah.xcah012,l_xcah.xcah013,l_xcah.xcah020,l_xcah.xcah021,
       l_xcah.xcah022,l_xcah.xcah023,l_xcah.xcah024,l_xcah.xcah025,l_xcah.xcah026,l_xcah.xcah027,l_xcah.xcah028,l_xcah.xcah030,l_xcah.xcah030a,l_xcah.xcah030b,
       l_xcah.xcah030c,l_xcah.xcah030d,l_xcah.xcah030e,l_xcah.xcah030f,l_xcah.xcah030g,l_xcah.xcah030h,l_xcah.xcah031,l_xcah.xcah031a,l_xcah.xcah031b,l_xcah.xcah031c,
       l_xcah.xcah031d,l_xcah.xcah031e,l_xcah.xcah031f,l_xcah.xcah031g,l_xcah.xcah031h,l_xcah.xcah040,l_xcah.xcah041,l_xcah.xcah042,l_xcah.xcah043,l_xcah.xcah044,
       l_xcah.xcah101,l_xcah.xcah102,l_xcah.xcahownid,l_xcah.xcahowndp,l_xcah.xcahcrtid,l_xcah.xcahcrtdp,l_xcah.xcahcrtdt,l_xcah.xcahmodid,l_xcah.xcahmoddt,l_xcah.xcahstus)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xcah"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
   END FOREACH  #根据最终主件抓取所有临时表的信息（按阶数降阶）
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: ins xcai
# Memo...........:
# Usage..........: CALL axcp006_ins_xcai(p_xcah004,p_xcah042,p_xcah043,p_xcah044,p_xcah040,p_xcah028)
# Input parameter:  
# Return code....:  
# Date & Author..: 2015/4/28 By 00768
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_ins_xcai(p_xcah004,p_xcah042,p_xcah043,p_xcah044,p_xcah040,p_xcah028)
DEFINE p_xcah004      LIKE xcah_t.xcah004  #最终主件
DEFINE p_xcah042      LIKE xcah_t.xcah042  #本阶对最终主件的底数
DEFINE p_xcah043      LIKE xcah_t.xcah043  #本阶对最终主件的组成用量
DEFINE p_xcah044      LIKE xcah_t.xcah044  #本阶对最终主件的损耗率
DEFINE p_xcah040      LIKE xcah_t.xcah040  #本阶主件料号
DEFINE p_xcah028      LIKE xcah_t.xcah028  #本阶主件在最终主件里的项次 p_xcah040+p_xcah028可以定位一个点
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
#DEFINE l_xcai         RECORD LIKE xcai_t.*   #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcai RECORD  #標準成本_資源費用明細檔
       xcaient LIKE xcai_t.xcaient, #企业编号
       xcaisite LIKE xcai_t.xcaisite, #营运据点
       xcaicomp LIKE xcai_t.xcaicomp, #法人组织
       xcai001 LIKE xcai_t.xcai001, #标准成本分类
       xcai002 LIKE xcai_t.xcai002, #生效日期
       xcai003 LIKE xcai_t.xcai003, #失效日期
       xcai004 LIKE xcai_t.xcai004, #最终件料号
       xcaiseq LIKE xcai_t.xcaiseq, #项次
       xcai100 LIKE xcai_t.xcai100, #工艺料号
       xcai101 LIKE xcai_t.xcai101, #工艺编号
       xcai102 LIKE xcai_t.xcai102, #作业编号
       xcai103 LIKE xcai_t.xcai103, #工艺站
       xcai104 LIKE xcai_t.xcai104, #资源编号
       xcai105 LIKE xcai_t.xcai105, #资源单位成本
       xcai106 LIKE xcai_t.xcai106, #资源耗用量
       xcai107 LIKE xcai_t.xcai107, #资源成本
       xcai108 LIKE xcai_t.xcai108, #委外否
       xcai109 LIKE xcai_t.xcai109, #工艺料号项次
       xcai201 LIKE xcai_t.xcai201, #资源归属主成本要素
       xcai202 LIKE xcai_t.xcai202, #资源归属次成本要素
       xcaiownid LIKE xcai_t.xcaiownid, #资料所有者
       xcaiowndp LIKE xcai_t.xcaiowndp, #资料所有部门
       xcaicrtid LIKE xcai_t.xcaicrtid, #资料录入者
       xcaicrtdp LIKE xcai_t.xcaicrtdp, #资料录入部门
       xcaicrtdt LIKE xcai_t.xcaicrtdt, #资料创建日
       xcaimodid LIKE xcai_t.xcaimodid, #资料更改者
       xcaimoddt LIKE xcai_t.xcaimoddt, #最近更改日
       xcaistus LIKE xcai_t.xcaistus #状态码
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE l_xcaesite   LIKE xcae_t.xcaesite
DEFINE l_xcae002    LIKE xcae_t.xcae002
DEFINE l_xcae008    LIKE xcae_t.xcae008
DEFINE l_xcae004    LIKE xcae_t.xcae004
DEFINE l_xcae005    LIKE xcae_t.xcae005
DEFINE l_xcae006    LIKE xcae_t.xcae006
DEFINE l_xcaf003    LIKE xcaf_t.xcaf003
DEFINE l_xcac003    LIKE xcac_t.xcac003
DEFINE l_xcac004    LIKE xcac_t.xcac004
DEFINE l_xcac005    LIKE xcac_t.xcac005
DEFINE l_xcac006    LIKE xcac_t.xcac006
DEFINE l_xcaf005_sum  LIKE xcaf_t.xcaf005
DEFINE l_rate1      LIKE apca_t.apca101
DEFINE l_cnt        LIKE type_t.num5

   LET r_success = TRUE
   
   #按axcp006说明图示:
   #D的上阶有C，有H，以D和上阶C来看，它在不同线对最终主件的QPA，损耗率不一定相同，所以计算得到的xcai107也不一定相同
   #所以为了能正确对应上，觉得应该同增加xcah028上阶项次，也需要增加制程料号项次用来定位
   #以上是插入xcai时需要用QPA，损耗率等经过计算的情况，需要xcai109栏位
   #需不需要，则xcai109是no use栏位，走本次插入时需先判断有没有插入过，不用重复计算插入，以防D的不同线的情况，多次走到
   #以下判断本阶主件+最终主件有插入过的，不重复插入，返回
   SELECT COUNT(*) INTO l_cnt FROM xcai_t 
    WHERE xcaient = g_enterprise
      AND xcaisite = g_xcabsite
      AND xcai001 = g_master.xcaa001  #标准成本分类
      AND xcai002 = g_master.xcag002  #生效日期
      AND xcai004 = p_xcah004  #最终主件
      AND xcai100 = p_xcah040  #本阶主件
      AND xcai109 = p_xcah028  #本阶主件在最终主件中的项次  #add zhangllc 160623#2
   IF l_cnt > 0 THEN
      RETURN r_success  #产生过了，不用重复产生   如果xcai计算时会涉及QPA，损耗量等计算，则判断不需要，放开xcai109的逻辑
   END IF
   
   #                   製程料號 製程編號 作業編號 工作站  委外否   資源編號 成本主要素 次要素 幣種    標準費率 變動耗用
   LET g_sql = " SELECT xcae002,xcae008,xcae004,xcae005,xcae006,xcaf003,xcac003,xcac004,xcac005,xcac006,SUM(xcaf005) ",
               "   FROM xcae_t LEFT OUTER JOIN xcaf_t ON xcaeent = xcafent AND xcae001 = xcaf001 AND xcae002 = xcaf002 AND xcaeseq = xcafseq1",
               "               LEFT OUTER JOIN xcac_t ON xcacent = xcafent AND xcac002 = xcaf003 ",
               "  WHERE xcaeent = ",g_enterprise,
               "    AND xcae001 = '",g_master.xcae001,"' AND xcae002 = '",p_xcah040,"'" , #工藝版本，製程料號=本阶主件料号
               "    AND xcac001 = '",g_master.xcac001,"' ",  #資源版本
               #"    AND xcaesite= '",g_xcabsite,"' AND xcafsite='",g_xcabsite,"' AND xcacsite='",g_xcabsite,"' ",  #营运据点 mark axcae,xcaf档里会空
               "   GROUP BY xcae002,xcae008,xcae004,xcae005,xcae006,xcaf003,xcac003,xcac004,xcac005,xcac006"
   PREPARE axcp006_ins_xcai_pre6 FROM g_sql
   DECLARE axcp006_ins_xcai_cur6 CURSOR FOR axcp006_ins_xcai_pre6 
   FOREACH axcp006_ins_xcai_cur6 INTO l_xcae002,l_xcae008,l_xcae004,l_xcae005,l_xcae006,l_xcaf003,l_xcac003,l_xcac004,l_xcac005,l_xcac006,l_xcaf005_sum     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "axcp006_ins_xcai_cur6:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  

      LET l_xcai.xcaient = g_enterprise
      LET l_xcai.xcaisite = g_xcabsite 
      #營運據點所屬法人
      #-------------------------------------------
      #SELECT ooef017 INTO l_xcai.xcaicomp FROM ooef_t
      # WHERE ooef001 = l_xcaesite AND ooefent = g_enterprise      
      EXECUTE cursor_pre_3 USING l_xcai.xcaisite INTO l_xcai.xcaicomp 
      #------------------------------------------- 
      LET l_xcai.xcai001 = g_master.xcaa001 #標準成本分類
      LET l_xcai.xcai002 = g_master.xcag002 #生效日期
      LET l_xcai.xcai003 = g_master.xcag003 #失效日期
      LET l_xcai.xcai004 = p_xcah004        #最終主件
      LET g_xcaiseq = g_xcaiseq + 1
      LET l_xcai.xcaiseq = g_xcaiseq  #項次
      LET l_xcai.xcai100 = p_xcah040  #製程料號=本阶主件
      LET l_xcai.xcai109 = p_xcah028  #製程料號项次=本阶主件在最终主件里的项次，用于定位是哪个制程料号  #add zhangllc 160623#2
      LET l_xcai.xcai101 = l_xcae008  #工藝編號
      LET l_xcai.xcai102 = l_xcae004  #作業編號
      LET l_xcai.xcai103 = l_xcae005  #工藝站
      LET l_xcai.xcai104 = l_xcaf003  #資源編號
      
      #轉換匯率
      #根據畫面幣別、材料成本、畫面匯率方式、畫面匯率日期算出匯率
      IF NOT cl_null(l_xcac005) THEN  #币种
      #与画面币种做转换
         CALL s_aooi160_get_exrate('1',l_xcai.xcaisite,g_master.ooam004,l_xcac005,
                               #目的幣別                 #匯類類型
                               g_master.ooai001,0,g_master.a)
           RETURNING l_rate1
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00305' #来源币别为空,请检查！
         LET g_errparam.extend = l_xcaf003
         LET g_errparam.popup = TRUE
         CALL cl_err()
        #LET r_success = FALSE #161107-00037#1 mark
      END IF
      LET l_xcai.xcai105 = l_xcac006 * l_rate1  #資源單位成本=標準費率*币种转换率
      #LET l_xcai.xcai106 = l_xcaf005_sum   #資源耗用量，时间单位为资源编号对应的mrba024的时间单位SCC=5204：1秒，2分，3小时，4天
      LET l_xcai.xcai106 = l_xcaf005_sum * p_xcah043/p_xcah042*(1+p_xcah044/100)  #資源耗用量，时间单位为资源编号对应的mrba024的时间单位SCC=5204：1秒，2分，3小时，4天  #mod zhangllc 160623#2
      LET l_xcai.xcai107 = l_xcai.xcai105 * l_xcai.xcai106   #資源成本=資源單位成本*資源耗用量
            
      LET l_xcai.xcai108 = l_xcae006  #委外否
      LET l_xcai.xcai201 = l_xcac003 #資源歸屬主成本要素
      LET l_xcai.xcai202 = l_xcac004 #資源歸屬次成本要素
      
      LET l_xcai.xcaiownid = g_user  #資料所有者
      LET l_xcai.xcaiowndp = g_dept  #資料所屬部門
      LET l_xcai.xcaicrtid = g_user  #資料建立者
      LET l_xcai.xcaicrtdp = g_dept  #資料建立部門 
      LET l_xcai.xcaicrtdt = cl_get_current() #資料創建日
      LET l_xcai.xcaimoddt = ''   #最近修改日 
      LET l_xcai.xcaistus  = 'Y'  #狀態碼
            
      #INSERT INTO xcai_t VALUES(l_xcai.*)  #161124-00048#16  2016/12/16  By 08734 mark
      INSERT INTO xcai_t(xcaient,xcaisite,xcaicomp,xcai001,xcai002,xcai003,xcai004,xcaiseq,
                  xcai100,xcai101,xcai102,xcai103,xcai104,xcai105,xcai106,xcai107,xcai108,xcai109,
                  xcai201,xcai202,xcaiownid,xcaiowndp,xcaicrtid,xcaicrtdp,xcaicrtdt,xcaimodid,xcaimoddt,xcaistus)  #161124-00048#16  2016/12/16  By 08734 add
         VALUES(l_xcai.xcaient,l_xcai.xcaisite,l_xcai.xcaicomp,l_xcai.xcai001,l_xcai.xcai002,l_xcai.xcai003,l_xcai.xcai004,l_xcai.xcaiseq,
                l_xcai.xcai100,l_xcai.xcai101,l_xcai.xcai102,l_xcai.xcai103,l_xcai.xcai104,l_xcai.xcai105,l_xcai.xcai106,l_xcai.xcai107,l_xcai.xcai108,l_xcai.xcai109,
                l_xcai.xcai201,l_xcai.xcai202,l_xcai.xcaiownid,l_xcai.xcaiowndp,l_xcai.xcaicrtid,l_xcai.xcaicrtdp,l_xcai.xcaicrtdt,l_xcai.xcaimodid,l_xcai.xcaimoddt,l_xcai.xcaistus)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins xcai"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
   END FOREACH   
           
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: BOM中最终主件SUM到xcag中
# Memo...........:
# Usage..........: CALL axcp006_ins_xcag(p_xcah004)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/3/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_ins_xcag(p_xcah004)
DEFINE p_xcah004      LIKE xcah_t.xcah004  #最终主件
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
#DEFINE l_xcag RECORD LIKE xcag_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcag RECORD  #物料標準成本檔
       xcagent LIKE xcag_t.xcagent, #企业编号
       xcagsite LIKE xcag_t.xcagsite, #营运据点
       xcagcomp LIKE xcag_t.xcagcomp, #法人组织
       xcag001 LIKE xcag_t.xcag001, #标准成本分类
       xcag002 LIKE xcag_t.xcag002, #生效日期
       xcag003 LIKE xcag_t.xcag003, #失效日期
       xcag004 LIKE xcag_t.xcag004, #物料编码
       xcag010 LIKE xcag_t.xcag010, #版本
       xcag011 LIKE xcag_t.xcag011, #币种
       xcag102 LIKE xcag_t.xcag102, #标准单位成本
       xcag102a LIKE xcag_t.xcag102a, #单位成本-材料
       xcag102b LIKE xcag_t.xcag102b, #单位成本-人工
       xcag102c LIKE xcag_t.xcag102c, #单位成本-委外
       xcag102d LIKE xcag_t.xcag102d, #单位成本-制费一
       xcag102e LIKE xcag_t.xcag102e, #单位成本-制费二
       xcag102f LIKE xcag_t.xcag102f, #单位成本-制费三
       xcag102g LIKE xcag_t.xcag102g, #单位成本-制费四
       xcag102h LIKE xcag_t.xcag102h, #单位成本-制费五
       xcag104a LIKE xcag_t.xcag104a, #本阶-材料
       xcag104b LIKE xcag_t.xcag104b, #本阶-人工
       xcag104c LIKE xcag_t.xcag104c, #本阶-委外
       xcag104d LIKE xcag_t.xcag104d, #本阶-制费一
       xcag104e LIKE xcag_t.xcag104e, #本阶-制费二
       xcag104f LIKE xcag_t.xcag104f, #本阶-制费三
       xcag104g LIKE xcag_t.xcag104g, #本阶-制费四
       xcag104h LIKE xcag_t.xcag104h, #本阶-制费五
       xcag106a LIKE xcag_t.xcag106a, #下阶-材料
       xcag106b LIKE xcag_t.xcag106b, #下阶-人工
       xcag106c LIKE xcag_t.xcag106c, #下阶-委外
       xcag106d LIKE xcag_t.xcag106d, #下阶-制费一
       xcag106e LIKE xcag_t.xcag106e, #下阶-制费二
       xcag106f LIKE xcag_t.xcag106f, #下阶-制费三
       xcag106g LIKE xcag_t.xcag106g, #下阶-制费四
       xcag106h LIKE xcag_t.xcag106h, #下阶-制费五
       xcagownid LIKE xcag_t.xcagownid, #资料所有者
       xcagowndp LIKE xcag_t.xcagowndp, #资料所有部门
       xcagcrtid LIKE xcag_t.xcagcrtid, #资料录入者
       xcagcrtdp LIKE xcag_t.xcagcrtdp, #资料录入部门
       xcagcrtdt LIKE xcag_t.xcagcrtdt, #资料创建日
       xcagmodid LIKE xcag_t.xcagmodid, #资料更改者
       xcagmoddt LIKE xcag_t.xcagmoddt, #最近更改日
       xcagstus LIKE xcag_t.xcagstus #状态码
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE lc_param    type_parameter
DEFINE l_rate       LIKE apca_t.apca101
DEFINE l_xcab003    LIKE xcab_t.xcab003
DEFINE l_xcab004    LIKE xcab_t.xcab004
DEFINE l_imaa004    LIKE imaa_t.imaa004
DEFINE l_cnt        LIKE type_t.num5
   
   LET r_success = TRUE
   #當前需插入的xcag數據是否已存在且生效日期大於已有的生效日期
   #若存在則更新之前的失效日期=現在生效日期-1
   #xcag更新完后，xcah\xcai\xcaj應聯動更新
   CALL axcp006_deal_old_data(p_xcah004) RETURNING l_success  #170214-00007#1 mod add p_xcah004
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   

   LET l_xcag.xcagent = g_enterprise
   LET l_xcag.xcagsite = g_xcabsite         #畫面檔中查詢出來的營運據點
   #營運據點所屬法人
   #--------------------------------------
   #SELECT ooef017 INTO l_xcag.xcagcomp FROM ooef_t
   # WHERE ooef001 = g_xcabsite AND ooefent = g_enterprise
   EXECUTE cursor_pre_3 USING g_xcabsite INTO l_xcag.xcagcomp
   #--------------------------------------
      
   LET l_xcag.xcag001 = g_master.xcaa001    #標準成本分類
   LET l_xcag.xcag002 = g_master.xcag002    #生效日期
   LET l_xcag.xcag003 = g_master.xcag003    #失效日期
   LET l_xcag.xcag004 = p_xcah004           #最終主件
   LET l_xcag.xcag010 = ''                  #版本
   LET l_xcag.xcag011 = g_master.ooai001    #幣別
   
   #标准单位成本
   SELECT SUM(xcah031a),SUM(xcah031b),SUM(xcah031c),SUM(xcah031d),
          SUM(xcah031e),SUM(xcah031f),SUM(xcah031g),SUM(xcah031h)
     INTO l_xcag.xcag102a,l_xcag.xcag102b,l_xcag.xcag102c,l_xcag.xcag102d,
          l_xcag.xcag102e,l_xcag.xcag102f,l_xcag.xcag102g,l_xcag.xcag102h
     FROM xcah_t
    WHERE xcahent = g_enterprise
      AND xcahsite = g_xcabsite
      AND xcah020 = 0                #階數（本階主件是最終元件的時候，階數是給1的）
      AND xcah004 = p_xcah004        #最終主件
      AND xcah001 = g_master.xcaa001 #標準成本分類
      AND xcah002 = g_master.xcag002 #生效日期
   IF cl_null(l_xcag.xcag102a) THEN LET l_xcag.xcag102a = 0 END IF
   IF cl_null(l_xcag.xcag102b) THEN LET l_xcag.xcag102b = 0 END IF
   IF cl_null(l_xcag.xcag102c) THEN LET l_xcag.xcag102c = 0 END IF
   IF cl_null(l_xcag.xcag102d) THEN LET l_xcag.xcag102d = 0 END IF
   IF cl_null(l_xcag.xcag102e) THEN LET l_xcag.xcag102e = 0 END IF
   IF cl_null(l_xcag.xcag102f) THEN LET l_xcag.xcag102f = 0 END IF
   IF cl_null(l_xcag.xcag102g) THEN LET l_xcag.xcag102g = 0 END IF
   IF cl_null(l_xcag.xcag102h) THEN LET l_xcag.xcag102h = 0 END IF
   #單位成本
   LET l_xcag.xcag102 = l_xcag.xcag102a+l_xcag.xcag102b+l_xcag.xcag102c+l_xcag.xcag102d+
                        l_xcag.xcag102e+l_xcag.xcag102f+l_xcag.xcag102g+l_xcag.xcag102h
   
   #本阶-材料、本阶-人工、本阶-委外、本阶-制費
   #本階材料--這裡的本階就是當前的最終主件(<> 'DL+OH+SUB',当没下阶料时会有材料成本,不会有人工制费)
   SELECT SUM(xcah031a) INTO l_xcag.xcag104a FROM xcah_t
    WHERE xcahent = g_enterprise
      AND xcahsite= g_xcabsite
      AND xcah022 <> 'DL+OH+SUB'
      AND NOT EXISTS(select 1 from xcad_t   #没有下阶料
                      where xcadent = g_enterprise
                        and xcad001 = g_master.xcad001   #版本
                        and xcad002 = xcah022   )   #主件料號
      AND xcah020 <= 1                #階數（本階主件是最終元件的時候，階數是給1的）(考虑最终主件没有下阶的情况)
      AND xcah004 = p_xcah004        #最終主件
      AND xcah001 = g_master.xcaa001 #標準成本分類
      AND xcah002 = g_master.xcag002 #生效日期
   #本階人工、委外、制費--這裡的本階就是當前的最終主件(='DL+OH+SUB')
   SELECT SUM(xcah031b),SUM(xcah031c),SUM(xcah031d),
          SUM(xcah031e),SUM(xcah031f),SUM(xcah031g),SUM(xcah031h)
     INTO l_xcag.xcag104b,l_xcag.xcag104c,l_xcag.xcag104d,
          l_xcag.xcag104e,l_xcag.xcag104f,l_xcag.xcag104g,l_xcag.xcag104h
     FROM xcah_t
    WHERE xcahent = g_enterprise
      AND xcahsite = g_xcabsite
      AND xcah022 ='DL+OH+SUB'
      AND xcah020 = 1 #階數（本階主件是最終元件的時候，階數是給1的）
      AND xcah004 = p_xcah004 #最終主件
      AND xcah001 = g_master.xcaa001 #標準成本分類
      AND xcah002 = g_master.xcag002 #生效日期
   IF cl_null(l_xcag.xcag104a) THEN LET l_xcag.xcag104a = 0 END IF  
   IF cl_null(l_xcag.xcag104b) THEN LET l_xcag.xcag104b = 0 END IF   
   IF cl_null(l_xcag.xcag104c) THEN LET l_xcag.xcag104c = 0 END IF   
   IF cl_null(l_xcag.xcag104d) THEN LET l_xcag.xcag104d = 0 END IF   
   IF cl_null(l_xcag.xcag104e) THEN LET l_xcag.xcag104e = 0 END IF   
   IF cl_null(l_xcag.xcag104f) THEN LET l_xcag.xcag104f = 0 END IF   
   IF cl_null(l_xcag.xcag104g) THEN LET l_xcag.xcag104g = 0 END IF   
   IF cl_null(l_xcag.xcag104h) THEN LET l_xcag.xcag104h = 0 END IF 

   #下階=單位成本-本階
   LET l_xcag.xcag106a = l_xcag.xcag102a - l_xcag.xcag104a
   LET l_xcag.xcag106b = l_xcag.xcag102b - l_xcag.xcag104b  
   LET l_xcag.xcag106c = l_xcag.xcag102c - l_xcag.xcag104c     
   LET l_xcag.xcag106d = l_xcag.xcag102d - l_xcag.xcag104d   
   LET l_xcag.xcag106e = l_xcag.xcag102e - l_xcag.xcag104e
   LET l_xcag.xcag106f = l_xcag.xcag102f - l_xcag.xcag104f
   LET l_xcag.xcag106g = l_xcag.xcag102g - l_xcag.xcag104g  
   LET l_xcag.xcag106h = l_xcag.xcag102h - l_xcag.xcag104h
   
   LET l_xcag.xcagownid = g_user  #資料所有者
   LET l_xcag.xcagowndp = g_dept  #資料所屬部門
   LET l_xcag.xcagcrtid = g_user  #資料建立者
   LET l_xcag.xcagcrtdp = g_dept  #資料建立部門 
   LET l_xcag.xcagcrtdt = cl_get_current() #資料創建日
   LET l_xcag.xcagmoddt = ''   #最近修改日 
   LET l_xcag.xcagstus  = 'Y'  #狀態碼
               
   #INSERT INTO xcag_t VALUES(l_xcag.*)   #161124-00048#16  2016/12/16  By 08734 mark 
   INSERT INTO xcag_t(xcagent,xcagsite,xcagcomp,xcag001,xcag002,xcag003,xcag004,xcag010,xcag011,xcag102,xcag102a,xcag102b,
                      xcag102c,xcag102d,xcag102e,xcag102f,xcag102g,xcag102h,xcag104a,xcag104b,xcag104c,xcag104d,
                      xcag104e,xcag104f,xcag104g,xcag104h,xcag106a,xcag106b,xcag106c,xcag106d,xcag106e,xcag106f,
                      xcag106g,xcag106h,xcagownid,xcagowndp,xcagcrtid,xcagcrtdp,xcagcrtdt,xcagmodid,xcagmoddt,xcagstus)  #161124-00048#16  2016/12/16  By 08734 add
      VALUES(l_xcag.xcagent,l_xcag.xcagsite,l_xcag.xcagcomp,l_xcag.xcag001,l_xcag.xcag002,l_xcag.xcag003,l_xcag.xcag004,l_xcag.xcag010,l_xcag.xcag011,l_xcag.xcag102,l_xcag.xcag102a,l_xcag.xcag102b,
             l_xcag.xcag102c,l_xcag.xcag102d,l_xcag.xcag102e,l_xcag.xcag102f,l_xcag.xcag102g,l_xcag.xcag102h,l_xcag.xcag104a,l_xcag.xcag104b,l_xcag.xcag104c,l_xcag.xcag104d,
             l_xcag.xcag104e,l_xcag.xcag104f,l_xcag.xcag104g,l_xcag.xcag104h,l_xcag.xcag106a,l_xcag.xcag106b,l_xcag.xcag106c,l_xcag.xcag106d,l_xcag.xcag106e,l_xcag.xcag106f,
             l_xcag.xcag106g,l_xcag.xcag106h,l_xcag.xcagownid,l_xcag.xcagowndp,l_xcag.xcagcrtid,l_xcag.xcagcrtdp,l_xcag.xcagcrtdt,l_xcag.xcagmodid,l_xcag.xcagmoddt,l_xcag.xcagstus)   
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins xcag"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success         
    END IF  
    
   CALL axcp006_ins_xcaj(p_xcah004) RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success   
   END IF
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 根據最終主鍵新增資源主件和材料主件的資料
# Memo...........:
# Usage..........: CALL axcp006_ins_xcaj(p_xcah004)
# Input parameter: 
# Return code....:
# Date & Author..: 2014/3/27 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_ins_xcaj(p_xcah004)
DEFINE p_xcah004      LIKE xcah_t.xcah004  #最终主件
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_xcaj102    LIKE xcaj_t.xcaj102
DEFINE l_cnt        LIKE type_t.num5
#DEFINE l_xcaj  RECORD LIKE xcaj_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcaj RECORD  #物料標準成本要素明細檔
       xcajent LIKE xcaj_t.xcajent, #企业编号
       xcajsite LIKE xcaj_t.xcajsite, #营运据点
       xcajcomp LIKE xcaj_t.xcajcomp, #法人组织
       xcaj001 LIKE xcaj_t.xcaj001, #标准成本分类
       xcaj002 LIKE xcaj_t.xcaj002, #生效日期
       xcaj003 LIKE xcaj_t.xcaj003, #失效日期
       xcaj004 LIKE xcaj_t.xcaj004, #物料编码
       xcaj005 LIKE xcaj_t.xcaj005, #次成本要素
       xcaj010 LIKE xcaj_t.xcaj010, #版本
       xcaj011 LIKE xcaj_t.xcaj011, #币种
       xcaj102 LIKE xcaj_t.xcaj102, #标准单位成本
       xcajownid LIKE xcaj_t.xcajownid, #资料所有者
       xcajowndp LIKE xcaj_t.xcajowndp, #资料所有部门
       xcajcrtid LIKE xcaj_t.xcajcrtid, #资料录入者
       xcajcrtdp LIKE xcaj_t.xcajcrtdp, #资料录入部门
       xcajcrtdt LIKE xcaj_t.xcajcrtdt, #资料创建日
       xcajmodid LIKE xcaj_t.xcajmodid, #资料更改者
       xcajmoddt LIKE xcaj_t.xcajmoddt, #最近更改日
       xcajstus LIKE xcaj_t.xcajstus #状态码
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)

   LET r_success = TRUE
   LET l_xcaj.xcajent = g_enterprise
   LET l_xcaj.xcajsite = g_xcabsite
   #營運據點所屬法人
   #----------------------------------
   #SELECT ooef017 INTO l_xcaj.xcajcomp FROM ooef_t
   # WHERE ooef001 = g_xcabsite AND ooefent = g_enterprise
   EXECUTE cursor_pre_3 USING g_xcabsite INTO l_xcaj.xcajcomp
   #----------------------------------
   
   LET l_xcaj.xcaj001 = g_master.xcaa001    #標準成本分類
   LET l_xcaj.xcaj002 = g_master.xcag002     #生效日期
   LET l_xcaj.xcaj003 = g_master.xcag003     #失效日期
   LET l_xcaj.xcaj004 = p_xcah004           #最終主件
   LET l_xcaj.xcaj010 = ''                  #版本
   LET l_xcaj.xcaj011 = g_master.ooai001    #幣別
   
   LET l_xcaj.xcajownid = g_user  #資料所有者
   LET l_xcaj.xcajowndp = g_dept  #資料所屬部門
   LET l_xcaj.xcajcrtid = g_user  #資料建立者
   LET l_xcaj.xcajcrtdp = g_dept  #資料建立部門 
   LET l_xcaj.xcajcrtdt = cl_get_current() #資料創建日
   LET l_xcaj.xcajmoddt = ''   #最近修改日 
   LET l_xcaj.xcajstus  = 'Y'  #狀態碼
   
   #计算材料的次成本要素成本(从xcah中获取，非DL+OH+SUB的资料)
   #xcah022<>DL+OH+SUB的xcah031肯定=xcah031a,其他都是0
   LET g_sql = " SELECT xcah102,SUM(xcah031) FROM xcah_t",  #次要成本要素,成本金额
               "  WHERE xcahent = ",g_enterprise,
               "    AND xcahsite = '",l_xcaj.xcajsite,"'",
               "    AND xcah001 = '",l_xcaj.xcaj001,"'",  #標準成本分類
               "    AND xcah002 = '",l_xcaj.xcaj002,"'",  #生效日期
               "    AND xcah004 = '",l_xcaj.xcaj004,"'",  #主件料號
               "    AND xcah022 <> 'DL+OH+SUB' ",         #元件料號
               "    AND NOT EXISTS(select 1 from xcad_t ",  #没有下阶料,就是本阶原材料成本
               "                    where xcadent = ",g_enterprise,
               "                      and xcad001 = '",g_master.xcad001,"' ",  #版本
               "                      and xcad002 = xcah022 ) ",          #主件料號
               "    GROUP BY xcah102 "
   PREPARE axcp006_pre7 FROM g_sql
   DECLARE axcp006_cur7 CURSOR FOR axcp006_pre7
   FOREACH axcp006_cur7 INTO l_xcaj.xcaj005,l_xcaj.xcaj102     #次成本要素,標準單位成本
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach7:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #每笔xcah可能由不同的成本次要素；材料或費用的次要素也可能會有相同或不同，所以SUM出一筆后檢查該要素是否已存在
      #若已存在則update，否則insert
      LET l_cnt =0
      #-------------------------------
      #SELECT COUNT(*) INTO l_cnt FROM xcaj_t
      # WHERE xcaj005 = l_xcaj.xcaj005  #次要素
      #   AND xcaj004 = l_xcaj.xcaj004  #最終主件
      #   AND xcajsite= l_xcaj.xcajsite
      #   AND xcaj001 = l_xcaj.xcaj001  #標準成本分類
      #   AND xcaj002 = l_xcaj.xcaj002  #生效日期
      #   AND xcajent = g_enterprise
      EXECUTE cursor_pre_29 USING l_xcaj.xcaj005,l_xcaj.xcaj004,l_xcaj.xcajsite,l_xcaj.xcaj001,l_xcaj.xcaj002 
         INTO l_cnt
      #-------------------------------
      
      IF l_cnt = 0 THEN
         #INSERT INTO xcaj_t VALUES(l_xcaj.*)  #161124-00048#16  2016/12/16  By 08734 mark
         INSERT INTO xcaj_t(xcajent,xcajsite,xcajcomp,xcaj001,xcaj002,xcaj003,xcaj004,xcaj005,xcaj010,
       xcaj011,xcaj102,xcajownid,xcajowndp,xcajcrtid,xcajcrtdp,xcajcrtdt,xcajmodid,xcajmoddt,xcajstus)  #161124-00048#16  2016/12/16  By 08734 add
            VALUES(l_xcaj.xcajent,l_xcaj.xcajsite,l_xcaj.xcajcomp,l_xcaj.xcaj001,l_xcaj.xcaj002,l_xcaj.xcaj003,l_xcaj.xcaj004,l_xcaj.xcaj005,l_xcaj.xcaj010,
       l_xcaj.xcaj011,l_xcaj.xcaj102,l_xcaj.xcajownid,l_xcaj.xcajowndp,l_xcaj.xcajcrtid,l_xcaj.xcajcrtdp,l_xcaj.xcajcrtdt,l_xcaj.xcajmodid,l_xcaj.xcajmoddt,l_xcaj.xcajstus)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xcaj"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success              
         END IF
      ELSE
         UPDATE xcaj_t SET xcaj102   = xcaj102 + l_xcaj.xcaj102
          WHERE xcaj005 = l_xcaj.xcaj005  #次要素
            AND xcaj004 = l_xcaj.xcaj004  #最終主件
            AND xcajsite= l_xcaj.xcajsite
            AND xcaj001 = l_xcaj.xcaj001
            AND xcaj002 = l_xcaj.xcaj002 
            AND xcajent = g_enterprise  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd xcaj"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success              
         END IF                     
      END IF
   END FOREACH  
  
   #计算费用的次成本要素成本(从xcai中获取，即DL+OH+SUB的来源)
   LET g_sql = " SELECT xcai202,SUM(xcai107) FROM xcai_t", #資源歸屬次成本要素，資源成本
               " WHERE xcaisite = '",l_xcaj.xcajsite,"'",
               "   AND xcai001 = '",l_xcaj.xcaj001,"'",
               "   AND xcai002 = '",l_xcaj.xcaj002,"'",
               "   AND xcai004 = '",l_xcaj.xcaj004,"'",
               "   AND xcaient = ",g_enterprise,
               "   GROUP BY xcai202 "
   PREPARE axcp006_pre8 FROM g_sql
   DECLARE axcp006_cur8 CURSOR FOR axcp006_pre8
   FOREACH axcp006_cur8 INTO l_xcaj.xcaj005,l_xcaj.xcaj102 #次成本要素,標準單位成本
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach8:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  
      
      #每笔xcah可能由不同的成本次要素；材料或費用的次要素也可能會有相同或不同，所以SUM出一筆后檢查該要素是否已存在
      #若已存在則update，否則insert
      LET l_cnt = 0
      #-----------------------------------
      #SELECT COUNT(*) INTO l_cnt FROM xcaj_t
      # WHERE xcaj005 = l_xcaj.xcaj005  #次要素
      #   AND xcaj004 = l_xcaj.xcaj004  #最終主件
      #   AND xcajsite= l_xcaj.xcajsite
      #   AND xcaj001 = l_xcaj.xcaj001
      #   AND xcaj002 = l_xcaj.xcaj002
      #   AND xcajent = g_enterprise
      EXECUTE cursor_pre_29 USING l_xcaj.xcaj005,l_xcaj.xcaj004,l_xcaj.xcajsite,l_xcaj.xcaj001,l_xcaj.xcaj002 
         INTO l_cnt
      #-----------------------------------
      
      IF l_cnt = 0 THEN
         #INSERT INTO xcaj_t VALUES(l_xcaj.*)  #161124-00048#16  2016/12/16  By 08734 mark
         INSERT INTO xcaj_t(xcajent,xcajsite,xcajcomp,xcaj001,xcaj002,xcaj003,xcaj004,xcaj005,xcaj010,
       xcaj011,xcaj102,xcajownid,xcajowndp,xcajcrtid,xcajcrtdp,xcajcrtdt,xcajmodid,xcajmoddt,xcajstus)  #161124-00048#16  2016/12/16  By 08734 add
            VALUES(l_xcaj.xcajent,l_xcaj.xcajsite,l_xcaj.xcajcomp,l_xcaj.xcaj001,l_xcaj.xcaj002,l_xcaj.xcaj003,l_xcaj.xcaj004,l_xcaj.xcaj005,l_xcaj.xcaj010,
       l_xcaj.xcaj011,l_xcaj.xcaj102,l_xcaj.xcajownid,l_xcaj.xcajowndp,l_xcaj.xcajcrtid,l_xcaj.xcajcrtdp,l_xcaj.xcajcrtdt,l_xcaj.xcajmodid,l_xcaj.xcajmoddt,l_xcaj.xcajstus)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins xcaj 2"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success   
         END IF
      ELSE
         UPDATE xcaj_t SET xcaj102 = xcaj102 + l_xcaj.xcaj102
          WHERE xcaj005 = l_xcaj.xcaj005  #次要素
            AND xcaj004 = l_xcaj.xcaj004  #最終主件
            AND xcajsite = l_xcaj.xcajsite
            AND xcaj001 = l_xcaj.xcaj001
            AND xcaj002 = l_xcaj.xcaj002  
            AND xcajent = g_enterprise  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd xcaj 2"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success   
         END IF                      
      END IF
   END FOREACH     
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 处理旧资料
# Memo...........:
# Usage..........: CALL axcp006_deal_old_data(p_xcah004)
#                  RETURNING r_success
# Input parameter: p_xcah004  物料编号
# Return code....: 
# Date & Author..: 2015-04-30 By zhangllc
# Modify.........: 170214-00007#1 mod add p_xcah004
################################################################################
PRIVATE FUNCTION axcp006_deal_old_data(p_xcah004)
DEFINE p_xcah004      LIKE xcah_t.xcah004  #170214-00007#1 mod add p_xcah004
DEFINE r_success      LIKE type_t.num5
DEFINE l_success      LIKE type_t.num5
DEFINE l_cnt          LIKE type_t.num5
   LET r_success = TRUE
   
   #當前需插入的xcag數據是否已存在且生效日期大於已有的生效日期
   #若存在則更新之前的失效日期=現在生效日期-1
   #xcag更新完后，xcah\xcai\xcaj應聯動更新

   #-----------------------------------
   #SELECT COUNT(*) INTO l_cnt FROM xcag_t
   # WHERE xcagent = g_enterprise  
   #   AND xcagsite = g_xcabsite
   #   AND xcag001 = lc_param.xcaa001 
   #   AND xcag004 = g_imaa001 
   #   AND xcag002 < lc_param.date1 
   EXECUTE cursor_pre_12 USING g_xcabsite,g_master.xcaa001,p_xcah004,g_master.xcag002 INTO l_cnt #170214-00007#1 mod g_imaa001->p_xcah004
   #-----------------------------------
   IF l_cnt = 0 THEN
      RETURN r_success
   END IF
   
   #下面更新
   UPDATE xcag_t SET xcag003 = g_master.xcag002 -1 
    WHERE xcagent = g_enterprise
      AND xcagsite = g_xcabsite
      AND xcag001 = g_master.xcaa001 
      AND xcag004 = p_xcah004   #170214-00007#1 mod g_imaa001->p_xcah004
      AND xcag002 < g_master.xcag002
      AND (xcag003 IS NULL OR xcag003 >= g_master.xcag002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "update xcag"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   UPDATE xcah_t SET xcah003 = g_master.xcag002 -1 
    WHERE xcahent = g_enterprise
      AND xcahsite = g_xcabsite
      AND xcah001 = g_master.xcaa001 
      AND xcah004 = p_xcah004   #170214-00007#1 mod g_imaa001->p_xcah004
      AND xcah002 < g_master.xcag002
      AND (xcah003 IS NULL OR xcah003 >= g_master.xcag002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "update xcah"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   UPDATE xcai_t SET xcai003 = g_master.xcag002 -1 
    WHERE xcaient = g_enterprise
      AND xcaisite = g_xcabsite
      AND xcai001 = g_master.xcaa001 
      AND xcai004 = p_xcah004   #170214-00007#1 mod g_imaa001->p_xcah004
      AND xcai002 < g_master.xcag002
      AND (xcai003 IS NULL OR xcai003 >= g_master.xcag002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "update xcai"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
   
   UPDATE xcaj_t SET xcaj003 = g_master.xcag002 -1 
    WHERE xcajent = g_enterprise
      AND xcajsite = g_xcabsite
      AND xcaj001 = g_master.xcaa001 
      AND xcaj004 = p_xcah004   #170214-00007#1 mod g_imaa001->p_xcah004
      AND xcaj002 < g_master.xcag002
      AND (xcaj003 IS NULL OR xcaj003 >= g_master.xcag002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "update xcaj"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   RETURN r_success
END FUNCTION
# 匯率檢查
PRIVATE FUNCTION axcp006_b_chk(p_xcab001,p_ooam004,p_ooai001)
   DEFINE p_xcab001     LIKE xcab_t.xcab001  #版本
   DEFINE p_ooam004     LIKE ooam_t.ooam004  #汇率日期
   DEFINE p_ooai001     LIKE ooai_t.ooai001  #币别
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_wc_xcab002  STRING
   DEFINE l_xcab003     LIKE xcab_t.xcab003
   DEFINE l_ooef014     LIKE ooef_t.ooef014   #160622-00008#1
   
   LET r_success = TRUE
   
   #材料成本
   LET l_wc_xcab002 = cl_replace_str(g_wc_imaa001,"imaa001","xcab002")  
   IF cl_null(l_wc_xcab002) THEN #物料編碼
      LET l_wc_xcab002 = " 1=1 "
   END IF
   #160622-00008#1---add---s
   LET l_ooef014 = ''    
   SELECT ooef014 INTO l_ooef014
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #160622-00008#1---add---e      
   LET g_sql ="SELECT DISTINCT xcab003 FROM xcab_t ",  #币种
              " WHERE xcabent = ",g_enterprise,     #版本
              "   AND xcab001 = '",p_xcab001,"'",
              "   AND ",l_wc_xcab002     
   PREPARE axcp006_pre_b FROM g_sql
   DECLARE axcp006_cs_b CURSOR FOR axcp006_pre_b 
   FOREACH axcp006_cs_b INTO l_xcab003   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach axcp006_cs_b:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF  
      LET l_cnt = 0
      IF l_xcab003 <> p_ooai001 THEN 
         #160622-00008#1---mod---s
         #SELECT COUNT(*) INTO l_cnt FROM ooam_t #日匯率單頭檔
         # WHERE ooament = g_enterprise #企業編號
         #   AND ooam001 = l_xcab003  #匯率參照表號
         #   AND ooam003 = p_ooai001  #基礎幣別
         #   AND ooam004<= p_ooam004 #日期
         SELECT COUNT(*) INTO l_cnt FROM ooam_t #日匯率單頭檔
          WHERE ooament = g_enterprise #企業編號
            AND ooam001 = l_ooef014  #匯率參照表號
            AND ooam003 = p_ooai001  #基礎幣別
            AND ooam004<= p_ooam004 #日期            
         #160622-00008#1---mod---e
         IF l_cnt = 0 THEN 
            #营运据点无汇率资料，请重新输入！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axc-00218'
            LET g_errparam.extend = "foreach axcp006_cs_b:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END IF
   END FOREACH 
   
   RETURN r_success
END FUNCTION
#
PRIVATE FUNCTION axcp006_b_chk_1(p_xcac001,p_ooam004,p_ooai001)
   DEFINE p_xcac001     LIKE xcac_t.xcac001  #版本
   DEFINE p_ooam004     LIKE ooam_t.ooam004  #日期
   DEFINE p_ooai001     LIKE ooai_t.ooai001  #币别
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_wc_xcacsite STRING
   DEFINE l_wc_xcac002  STRING
   DEFINE l_xcab003     LIKE xcab_t.xcab003
   DEFINE l_xcac005     LIKE xcac_t.xcac005
   DEFINE l_ooef014     LIKE ooef_t.ooef014   #160622-00008#1
   
   LET r_success = TRUE
   
   #資源標準費率
   LET l_wc_xcacsite = cl_replace_str(g_wc_ooef001,"ooef001","xcacsite")  
   IF cl_null(l_wc_xcacsite) THEN LET l_wc_xcacsite = " 1=1 "
   END IF
   
   LET l_wc_xcac002 = cl_replace_str(g_wc_imaa001,"imaa001","xcac002")  
   IF cl_null(l_wc_xcac002) THEN LET l_wc_xcac002 = " 1=1 "
   END IF
   #160622-00008#1---add---s
   LET l_ooef014 = ''   
   SELECT ooef014 INTO l_ooef014
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #160622-00008#1---add---e    
   LET g_sql ="SELECT distinct xcac005 FROM xcac_t ",
              " WHERE xcacent = ",g_enterprise,
              "   AND xcac001 = '",p_xcac001,"'",
              "   AND ",l_wc_xcacsite,  
              "   AND ",l_wc_xcac002    
   PREPARE axcp006_pre_b_1 FROM g_sql
   DECLARE axcp006_cs_b_1 CURSOR FOR axcp006_pre_b_1 
   FOREACH axcp006_cs_b_1 INTO l_xcac005   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach chk b:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  
      LET l_cnt = 0
      IF l_xcac005 <> p_ooai001 THEN 
         #160622-00008#1---mod---s   
         #SELECT COUNT(*) INTO l_cnt FROM ooam_t
         # WHERE ooam001 = l_xcac005 
         #   AND ooam003 = p_ooai001
         #   AND ooam004 <= p_ooam004
         SELECT COUNT(*) INTO l_cnt FROM ooam_t
          WHERE ooam001 = l_ooef014 
            AND ooam003 = p_ooai001
            AND ooam004 <= p_ooam004     
            AND ooament = g_enterprise    #160905-00007#17 add            
         #160622-00008#1---mod---e   
         IF l_cnt = 0 THEN 
            #营运据点无汇率资料，请重新输入！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axc-00218'
            LET g_errparam.extend = "foreach chk b:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查當前輸入的匯率日期是否有匯率
# Memo...........:
# Usage..........: CALL axcp006_chk_rate(p_ooai001,p_ooam004)
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/4/3 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_chk_rate(p_ooai001,p_ooam004)
DEFINE p_ooai001    LIKE ooai_t.ooai001
DEFINE p_ooam004    LIKE ooam_t.ooam004  #日期
DEFINE l_ooef015    LIKE ooef_t.ooef015
DEFINE l_ooef001    LIKE ooef_t.ooef001
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_wc         STRING
DEFINE l_errmsg     STRING
   
   #LET l_errmsg = ""
   #LET g_sql = " SELECT ooef001,ooef015 FROM ooef_t ",
   #            "  WHERE ",g_wc_ooef001,
   #            "   AND ooefent = ",g_enterprise 
   #PREPARE axcp006_pre_chk_b FROM g_sql
   #DECLARE axcp006_cur_chk_b CURSOR FOR axcp006_pre_chk_b 
   #FOREACH axcp006_cur_chk_b INTO l_ooef001,l_ooef015     
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "foreach chk b:"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #      LET g_success = 'N'  
   #      EXIT FOREACH
   #   END IF  
   #   SELECT COUNT(*) INTO l_cnt FROM ooam_t
   #    WHERE ooam001 = l_ooef015 
   #      AND ooam003 = p_ooai001
   #      AND ooam004 <= p_ooam004
   #   IF l_cnt = 0 THEN 
   #      LET l_errmsg = l_errmsg," ",l_ooef001
   #   END IF     
   #END FOREACH          
   #  
   #RETURN l_errmsg
END FUNCTION

#栏位检查
PRIVATE FUNCTION axcp006_chk_column(p_column)
   DEFINE p_column      LIKE type_t.chr100
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CASE p_column
      WHEN 'xcag002'  #生效日期
           #生效日期不能小于已有的生效日期，一定要大于已有的生效日期(xcag之key中需要标准成本分类)
           IF NOT cl_null(g_master.xcag002) AND NOT cl_null(g_master.xcaa001) THEN
              CALL axcp006_chk_column_xcag002()
                 RETURNING l_success
              IF l_success = FALSE THEN 
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           IF NOT cl_null(g_master.xcag003) AND NOT cl_null(g_master.xcag002)THEN 
              IF g_master.xcag003 < g_master.xcag002 THEN 
                 #生效日期不可大于失效日期
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'ais-00047'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcag003'  #失效日期
           #失效日期大於或等於当前的日期 and 大於生效日期
           IF NOT cl_null(g_master.xcag003) THEN 
              IF g_master.xcag003 < g_today THEN 
                 #失效日期不可小于当前日期！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axc-00067'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           IF NOT cl_null(g_master.xcag003) AND NOT cl_null(g_master.xcag002)THEN 
              IF g_master.xcag003 < g_master.xcag002 THEN 
                 #失效日期不可小于生效日期
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'ais-00048'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'ooai001'  #币别
           IF NOT cl_null(g_master.ooai001) THEN 
              #是否有效存在于币别档
              INITIALIZE g_chkparam.* TO NULL
              LET g_chkparam.arg1 = g_master.ooai001
              #160318-00025#36  2016/04/18  by pengxin  add(S)
              LET g_errshow = TRUE #是否開窗 
              LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
              #160318-00025#36  2016/04/18  by pengxin  add(E)
              IF NOT cl_chk_exist("v_ooai001") THEN
                 LET r_success = FALSE
                 RETURN r_success
              END IF
              #axcp006_chk_rate()
           END IF
      #WHEN 'a'  #汇率采用方式
      #     #满足SCC=40
      WHEN 'ooam004'  #汇率日期
           #检核该日期是否有汇率资料
           LET l_success = TRUE
           CALL cl_err_collect_init()
           IF NOT cl_null(g_master.ooam004) AND NOT cl_null(g_master.xcab001) THEN 
              CALL axcp006_b_chk(g_master.xcab001,g_master.ooam004,g_master.ooai001)
                 RETURNING l_success
           END IF  
           
           IF NOT cl_null(g_master.ooam004) AND NOT cl_null(g_master.xcac001) THEN 
              CALL axcp006_b_chk_1(g_master.xcac001,g_master.ooam004,g_master.ooai001)
                 RETURNING l_success
           END IF
           
           CALL cl_err_collect_show()
           IF l_success = FALSE THEN 
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'xcaa001'  #标准成本分类
           #来源于标准成本分类（允许共享的非主标准标准成本分类）  zll检查
           IF NOT cl_null(g_master.xcaa001) THEN 
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_master.xcaa001
              #160318-00025#36  2016/04/18  by pengxin  add(S)
              LET g_errshow = TRUE #是否開窗 
              LET g_chkparam.err_str[1] = "axc-00063:sub-01302|axci001|",cl_get_progname("axci001",g_lang,"2"),"|:EXEPROGaxci001"
              #160318-00025#36  2016/04/18  by pengxin  add(E)
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_xcaa001_01") THEN
                 #檢查成功時後續處理
              ELSE
                 #檢查失敗時後續處理
                 LET g_master.xcaa001 = ''
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcab001'  #材料成本版本
           #来源于营运据点下材料标准成本档.版本（已确认之版本） zll检查
           IF NOT cl_null(g_master.xcab001) THEN 
              CALL axcp006_chk_column_xcab001(g_master.xcab001)
              IF NOT cl_null(g_errno) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_master.xcab001
                 #160318-00005#46 --s add
                 CASE g_errno
                    WHEN 'sub-01308'
                       LET g_errparam.replace[1] = 'axci002'
                       LET g_errparam.replace[2] = cl_get_progname('axci002',g_lang,"2")
                       LET g_errparam.exeprog = 'axci002'
                 END CASE
                 #160318-00005#46 --e add
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_master.xcab001 = ''
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           
           IF NOT cl_null(g_master.xcab001) AND NOT cl_null(g_master.ooam004) THEN 
              CALL cl_err_collect_init()
              CALL axcp006_b_chk(g_master.xcab001,g_master.ooam004,g_master.ooai001)
              RETURNING l_success
              
              CALL cl_err_collect_show()
              IF l_success = FALSE THEN 
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcac001'  #资源标准费率版本
           #来源于营运据点下资源标准费率档.版本（已确认之版本）
           IF NOT cl_null(g_master.xcac001) THEN 
              CALL axcp006_chk_column_xcac001(g_master.xcac001)
              IF NOT cl_null(g_errno) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_master.xcac001
                 #160318-00005#46 --s add
                 CASE g_errno
                    WHEN 'sub-01302'
                       LET g_errparam.replace[1] = 'axci003'
                       LET g_errparam.replace[2] = cl_get_progname('axci003',g_lang,"2")
                       LET g_errparam.exeprog = 'axci003'
                    WHEN 'sub-01308'
                       LET g_errparam.replace[1] = 'axci003'
                       LET g_errparam.replace[2] = cl_get_progname('axci003',g_lang,"2")
                       LET g_errparam.exeprog = 'axci003'
                 END CASE
                 #160318-00005#46 --e add
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_master.xcac001 = ''
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           
           IF NOT cl_null(g_master.xcac001) AND NOT cl_null(g_master.ooam004) THEN
              CALL cl_err_collect_init()
              CALL axcp006_b_chk_1(g_master.xcac001,g_master.ooam004,g_master.ooai001)
                 RETURNING l_success
              CALL cl_err_collect_show()
              IF l_success = FALSE THEN 
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcad001'  #成本BOM版本
           #来源于营运据点下成本BOM档.版本（已确认之版本）
           IF NOT cl_null(g_master.xcad001) THEN 
              CALL axcp006_chk_column_xcad001(g_master.xcad001)
              IF NOT cl_null(g_errno) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_master.xcad001
                 #160318-00005#46 --s add
                 CASE g_errno
                    WHEN 'sub-01302'
                       LET g_errparam.replace[1] = 'axci004'
                       LET g_errparam.replace[2] = cl_get_progname('axci004',g_lang,"2")
                       LET g_errparam.exeprog = 'axci004'
                    WHEN 'sub-01308'
                       LET g_errparam.replace[1] = 'axci004'
                       LET g_errparam.replace[2] = cl_get_progname('axci004',g_lang,"2")
                       LET g_errparam.exeprog = 'axci004'
                 END CASE
                 #160318-00005#46 --e add
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_master.xcad001 = ''
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'xcae001'  #成本工艺路线版本
           #来源于营运据点下成本工艺路线档.版本（已确认之版本） 
           IF NOT cl_null(g_master.xcae001) THEN 
              CALL axcp006_chk_column_xcae001(g_master.xcae001)
              IF NOT cl_null(g_errno) THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = g_errno
                 LET g_errparam.extend = g_master.xcae001
                 #160318-00005#46 --s add
                 CASE g_errno
                  WHEN 'sub-01302'
                     LET g_errparam.replace[1] = 'axci005'
                     LET g_errparam.replace[2] = cl_get_progname('axci005',g_lang,"2")
                     LET g_errparam.exeprog = 'axci005'
                  WHEN 'sub-01308'
                     LET g_errparam.replace[1] = 'axci005'
                     LET g_errparam.replace[2] = cl_get_progname('axci005',g_lang,"2")
                     LET g_errparam.exeprog = 'axci005'
                 END CASE
                 #160318-00005#46 --e add
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_master.xcae001 = ''
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN 'ALL'
           #生效日期不能小于已有的生效日期，一定要大于已有的生效日期(xcag之key中需要标准成本分类)
           IF NOT cl_null(g_master.xcag002) AND NOT cl_null(g_master.xcaa001) THEN
              CALL axcp006_chk_column_xcag002()
                 RETURNING l_success
              IF l_success = FALSE THEN 
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF   
           #zll测试如果g_master.xcag002 g_master.xcaa001能输入有空过去执行，这边卡主否
   END CASE
   RETURN r_success
END FUNCTION

# 生效日期檢查
# 生效日期不能小于已有的生效日期，一定要大于已有的生效日期(xcag之key中需要标准成本分类)
PRIVATE FUNCTION axcp006_chk_column_xcag002()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_xcag002     LIKE xcag_t.xcag002
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   IF cl_null(g_master.xcaa001)  OR cl_null(g_master.xcag002) THEN #标准成本分类 生效日期
      RETURN r_success
   END IF
   
   LET l_wc = cl_replace_str(g_master.wc,"xcabsite","xcagsite")
   LET l_wc = cl_replace_str(l_wc,"xcab002","xcag004")
   LET g_sql ="SELECT MAX(xcag002) FROM xcag_t ", #生效日期
              " WHERE xcagent = ",g_enterprise,
              "   AND xcag001 = '",g_master.xcaa001,"'", #標準成本分類
              "   AND ",l_wc CLIPPED
   PREPARE axcp006_pre_b_2 FROM g_sql
   EXECUTE axcp006_pre_b_2 INTO l_xcag002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "execute axcp006_pre_b_2:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE 
      RETURN r_success
   END IF 
   IF g_master.xcag002 < l_xcag002 THEN 
      #生效日期不能小于已有的生效日期,请检查!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00290'
      LET g_errparam.extend = l_xcag002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE 
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION
# xcab001欄位檢查
PRIVATE FUNCTION axcp006_chk_column_xcab001(p_xcab001)
   DEFINE p_xcab001     LIKE xcab_t.xcab001
   DEFINE l_xcabstus    LIKE xcab_t.xcabstus
   
   WHENEVER ERROR CONTINUE
   
   LET g_errno = ''
   SELECT DISTINCT xcabstus INTO l_xcabstus
     FROM xcab_t
    WHERE xcabent = g_enterprise 
      AND xcab001 = p_xcab001
   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'axc-00076' #输入的版本不存在，请重新输入！    #160318-00005#46  mark
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'sub-01308' #输入的版本不存在，请重新输入！     #160318-00005#46  add
      WHEN l_xcabstus = 'N'       LET g_errno = 'axc-00289' #输入的版本未审核,请检查!
   END CASE
      
END FUNCTION

# xcac001欄位檢查
PRIVATE FUNCTION axcp006_chk_column_xcac001(p_xcac001)
   DEFINE p_xcac001     LIKE xcac_t.xcac001
   DEFINE l_xcacstus    LIKE xcac_t.xcacstus
   
   LET g_errno = ''
   SELECT DISTINCT xcacstus INTO l_xcacstus
     FROM xcac_t
    WHERE xcacent = g_enterprise 
      AND xcac001 = p_xcac001
   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'axc-00045'  #输入的版本不存在，请重新输入！   #160318-00005#46  mark
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'sub-01308'  #输入的版本不存在，请重新输入！    #160318-00005#46  add
#      WHEN l_xcacstus = 'N'       LET g_errno = 'axc-00044'  #输入的资料未审核!   #160318-00005#46  mark
      WHEN l_xcacstus = 'N'       LET g_errno = 'sub-01302'  #输入的资料未审核!    #160318-00005#46  add
   END CASE
END FUNCTION

#xcad001检查
PRIVATE FUNCTION axcp006_chk_column_xcad001(p_xcad001)
   DEFINE p_xcad001     LIKE xcad_t.xcad001
   DEFINE l_xcadstus    LIKE xcad_t.xcadstus
   
   LET g_errno = ''
   SELECT DISTINCT xcadstus INTO l_xcadstus
     FROM xcad_t
    WHERE xcadent = g_enterprise 
      AND xcad001 = p_xcad001
   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'axc-00048'  #输入的版本不存在，请重新输入！ #160318-00005#46  mark
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'sub-01308'  #输入的版本不存在，请重新输入！ #160318-00005#46  add
#      WHEN l_xcadstus = 'N'       LET g_errno = 'axc-00047'  #输入的资料未审核!      #160318-00005#46  mark
      WHEN l_xcadstus = 'N'       LET g_errno = 'sub-01302'  #输入的资料未审核!       #160318-00005#46  add
   END CASE
END FUNCTION

#xcae检查
PRIVATE FUNCTION axcp006_chk_column_xcae001(p_xcae001)
   DEFINE p_xcae001     LIKE xcae_t.xcae001
   DEFINE l_xcaestus    LIKE xcae_t.xcaestus
   
   LET g_errno = ''
   SELECT DISTINCT xcaestus INTO l_xcaestus
     FROM xcae_t
    WHERE xcaeent = g_enterprise 
      AND xcae001 = p_xcae001
   CASE
#      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'axc-00050'  #输入的版本不存在，请重新输入！   #160318-00005#46  mark
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'sub-01308'  #输入的版本不存在，请重新输入！    #160318-00005#46  add
#      WHEN l_xcaestus = 'N'       LET g_errno = 'axc-00049'  #输入的资料未审核!   #160318-00005#46  mark
      WHEN l_xcaestus = 'N'       LET g_errno = 'sub-01302'  #输入的资料未审核!    #160318-00005#46  add
   END CASE
END FUNCTION

################################################################################
# Descriptions...: process_bar
# Memo...........:
# Date & Author..: 16/06/22 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp006_cnt_process_bar(p_sum,p_i)
DEFINE p_sum         LIKE type_t.num5
DEFINE p_i           LIKE type_t.num5
   IF p_i > 0 THEN
      FOR p_i = p_i TO p_sum 
         CALL cl_progress_no_window_ing(' ')
      END FOR   
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
