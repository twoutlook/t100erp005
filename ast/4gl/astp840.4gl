#該程式未解開Section, 採用最新樣板產出!
{<section id="astp840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-09-03 14:48:07), PR版次:0004(2016-09-09 16:45:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: astp840
#+ Description: 租賃結算單批處理產生作業
#+ Creator....: 06814(2016-04-22 13:59:13)
#+ Modifier...: 05948 -SD/PR- 05948
 
{</section>}
 
{<section id="astp840.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
#160604-00009#61   2016/06/20   by 08172   结算组织赋值
#160516-00014#21   2016/9/3   by liyan l_r1,l_r2 总货款小于0是否结算，总费用小于0是否结算
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
        stbc040  LIKE stbc_t.stbc040, 
        l_choice LIKE type_t.chr500, 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stbc001 LIKE stbc_t.stbc001, 
   stbc033 LIKE stbc_t.stbc033, 
   stbc030 LIKE stbc_t.stbc030, 
   stbc008 LIKE stbc_t.stbc008, 
   stbc010 LIKE stbc_t.stbc010, 
   stbc040 LIKE stbc_t.stbc040, 
   l_choice LIKE type_t.chr500, 
   l_r1 LIKE type_t.chr1, 
   l_r2 LIKE type_t.chr1, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE g_type_stbc         RECORD   
          stbcent        LIKE stbc_t.stbcent, #企業編號
          stbcsite       LIKE stbc_t.stbcsite,#營運據點
          stbc001        LIKE stbc_t.stbc001, #結算中心
          stbc002        LIKE stbc_t.stbc002, #單據日期
          stbc003        LIKE stbc_t.stbc003, #單據類別
          stbc004        LIKE stbc_t.stbc004, #單據編號
          stbc005        LIKE stbc_t.stbc005, #項次
          stbc006        LIKE stbc_t.stbc006, #業務結算期
          stbc007        LIKE stbc_t.stbc007, #財務會計年度
          stbc008        LIKE stbc_t.stbc008, #對象編號
          stbc009        LIKE stbc_t.stbc009, #經營方式
          stbc010        LIKE stbc_t.stbc010, #結算方式
          stbc011        LIKE stbc_t.stbc011, #結算類型
          stbc012        LIKE stbc_t.stbc012, #費用編號
          stbc013        LIKE stbc_t.stbc013, #幣別
          stbc014        LIKE stbc_t.stbc014, #稅別
          stbc015        LIKE stbc_t.stbc015, #價款類別
          stbc016        LIKE stbc_t.stbc016, #方向
          stbc017        LIKE stbc_t.stbc017, #價外金額
          stbc018        LIKE stbc_t.stbc018, #價內金額
          stbc019        LIKE stbc_t.stbc019, #未結算金額
          stbc020        LIKE stbc_t.stbc020, #已結算金額
          stbc021        LIKE stbc_t.stbc021, #未校驗金額
          stbc022        LIKE stbc_t.stbc022, #已校驗金額
          stbc023        LIKE stbc_t.stbc023, #未立帳金額
          stbc024        LIKE stbc_t.stbc024, #已立帳金額
          stbc025        LIKE stbc_t.stbc025, #所屬品類
          stbc026        LIKE stbc_t.stbc026, #所屬部門
          stbc027        LIKE stbc_t.stbc027, #對象類別
          stbc028        LIKE stbc_t.stbc028, #財務會計期別
          stbc029        LIKE stbc_t.stbc029, #網點編號
          stbc030        LIKE stbc_t.stbc030, #結算合同編號
          stbc031        LIKE stbc_t.stbc031, #承擔對象
          stbc032        LIKE stbc_t.stbc032, #結算對象
          stbcstus       LIKE stbc_t.stbcstus,#狀態碼
          stbc033        LIKE stbc_t.stbc033, #專櫃編號
          stbc034        LIKE stbc_t.stbc034, #數量
          stbc035        LIKE stbc_t.stbc035, #已立帳數量
          stbc036        LIKE stbc_t.stbc036, #單價
          stbc037        LIKE stbc_t.stbc037, #納入結算單否
          stbc038        LIKE stbc_t.stbc038, #票扣否
          stbc039        LIKE stbc_t.stbc039, #結算扣率
          stbc040        LIKE stbc_t.stbc040, #結算日期
          stbc041        LIKE stbc_t.stbc041, #日結成本類型
          stbc042        LIKE stbc_t.stbc042, #銷售金額
          stbc043        LIKE stbc_t.stbc043, #商品編號
          stbc044        LIKE stbc_t.stbc044, #商品品類
          stbc045        LIKE stbc_t.stbc045, #開始日期
          stbc046        LIKE stbc_t.stbc046, #結束日期
          stbc047        LIKE stbc_t.stbc047, #已立帳金額帳套二
          stbc048        LIKE stbc_t.stbc048, #已立帳金額帳套三
          stbc049        LIKE stbc_t.stbc049, #主帳套暫估金額
          stbc050        LIKE stbc_t.stbc050, #帳套二暫估金額
          stbc051        LIKE stbc_t.stbc051, #帳套三暫估金額
          stbc052        LIKE stbc_t.stbc052, #已立帳數量帳套二
          stbc053        LIKE stbc_t.stbc053, #已立帳數量帳套三
          stbc054        LIKE stbc_t.stbc054, #主帳套暫估數量
          stbc055        LIKE stbc_t.stbc055, #帳套二暫估數量
          stbc056        LIKE stbc_t.stbc056, #帳套三暫估數量
          stbc057        LIKE stbc_t.stbc057, #已結算數量
          stbc058        LIKE stbc_t.stbc058, #含發票否
          stbc059        LIKE stbc_t.stbc059, #費用歸屬類型   #160510-00010#8 160514 by lori add
          stbc060        LIKE stbc_t.stbc060  #費用歸屬組織   #160510-00010#8 160514 by lori add
                         END RECORD

TYPE g_type_stbd         RECORD   
          stbdent        LIKE stbd_t.stbdent,  #企业编号
          stbdunit       LIKE stbd_t.stbdunit, #应用组织
          stbdsite       LIKE stbd_t.stbdsite, #营运据点
          stbddocdt      LIKE stbd_t.stbddocdt,#单据日期
          stbddocno      LIKE stbd_t.stbddocno,#单据编号
          stbd000        LIKE stbd_t.stbd000,  #结算单类型
          stbd001        LIKE stbd_t.stbd001,  #合同编号
          stbd002        LIKE stbd_t.stbd002,  #供应商编号
          stbd003        LIKE stbd_t.stbd003,  #经营方式
          stbd004        LIKE stbd_t.stbd004,  #结算账期
          stbd005        LIKE stbd_t.stbd005,  #起始日期
          stbd006        LIKE stbd_t.stbd006,  #截止日期
          stbd007        LIKE stbd_t.stbd007,  #上期结存金额
          stbd008        LIKE stbd_t.stbd008,  #本期销货成本
          stbd009        LIKE stbd_t.stbd009,  #本期进货金额
          stbd010        LIKE stbd_t.stbd010,  #本期退货金额
          stbd011        LIKE stbd_t.stbd011,  #本期折让金额
          stbd012        LIKE stbd_t.stbd012,  #税额
          stbd013        LIKE stbd_t.stbd013,  #价税合计
          stbd014        LIKE stbd_t.stbd014,  #本期预付金额
          stbd015        LIKE stbd_t.stbd015,  #本期价外扣款
          stbd016        LIKE stbd_t.stbd016,  #货款扣费用否
          stbd017        LIKE stbd_t.stbd017,  #应结算金额
          stbd018        LIKE stbd_t.stbd018,  #实际计算金额
          stbd019        LIKE stbd_t.stbd019,  #本期结存金额
          stbd020        LIKE stbd_t.stbd020,  #结算标识
          stbd021        LIKE stbd_t.stbd021,  #人员
          stbd022        LIKE stbd_t.stbd022,  #部门
          stbd023        LIKE stbd_t.stbd023,  #结算地点
          stbd024        LIKE stbd_t.stbd024,  #纳税编号
          stbd025        LIKE stbd_t.stbd025,  #银行编号
          stbd026        LIKE stbd_t.stbd026,  #银行账号
          stbd027        LIKE stbd_t.stbd027,  #发票日期
          stbd028        LIKE stbd_t.stbd028,  #发票号码
          stbd029        LIKE stbd_t.stbd029,  #付款日期
          stbd030        LIKE stbd_t.stbd030,  #发票人
          stbd031        LIKE stbd_t.stbd031,  #生效日期
          stbd032        LIKE stbd_t.stbd032,  #失效日期
          stbd033        LIKE stbd_t.stbd033,  #备注
          stbd034        LIKE stbd_t.stbd034,  #主账套账款金额
          stbd035        LIKE stbd_t.stbd035,  #次账套一账款金额
          stbd036        LIKE stbd_t.stbd036,  #次账套二账款金额
          stbd037        LIKE stbd_t.stbd037,  #专柜编号
          stbd038        LIKE stbd_t.stbd038,  #预估应付日
          stbd039        LIKE stbd_t.stbd039,  #数据类型
          stbd040        LIKE stbd_t.stbd040,  #本期销售金额
          stbd041        LIKE stbd_t.stbd041,  #合同状态
          stbd042        LIKE stbd_t.stbd042,  #含发票否
          stbd043        LIKE stbd_t.stbd043,  #财务会计年度
          stbd044        LIKE stbd_t.stbd044,  #财务会计期别
          stbd045        LIKE stbd_t.stbd045,  #本期开票金额
          stbd046        LIKE stbd_t.stbd046,  #付款供应商
          stbd047        LIKE stbd_t.stbd047,  #文档编号
          stbd048        LIKE stbd_t.stbd048,  #结算法人
          stbd049        LIKE stbd_t.stbd049,  #管理品类
          stbd050        LIKE stbd_t.stbd050,  #品牌
          stbdstus       LIKE stbd_t.stbdstus, #状态码
          stbdcrtdp      LIKE stbd_t.stbdcrtdp,#资料建立部门
          stbdcrtdt      LIKE stbd_t.stbdcrtdt,#资料创建日
          stbdcrtid      LIKE stbd_t.stbdcrtid,#资料建立者
          stbdowndp      LIKE stbd_t.stbdowndp,#资料所有部门
          stbdownid      LIKE stbd_t.stbdownid,#资料所有者
          stbdmodid      LIKE stbd_t.stbdmodid,#資料修改者
          stbdmoddt      LIKE stbd_t.stbdmoddt,#最近修改日
          stbdcnfid      LIKE stbd_t.stbdcnfid,#資料確認者
          stbdcnfdt      LIKE stbd_t.stbdcnfdt #資料確認日
                         END RECORD
                         
TYPE g_type_steu         RECORD
          steuent        LIKE steu_t.steuent,   #企业编号
          steuunit       LIKE steu_t.steuunit,  #应用组织
          steusite       LIKE steu_t.steusite,  #所属组织
          steudocnt      LIKE steu_t.steudocnt, #单据日期
          steudocno      LIKE steu_t.steudocno, #单据编号
          steu000        LIKE steu_t.steu000,   #交款汇总单类型
          steu001        LIKE steu_t.steu001,   #合同编号
          steu002        LIKE steu_t.steu002,   #专柜编号
          steu003        LIKE steu_t.steu003,   #供应商编号
          steu004        LIKE steu_t.steu004,   #经营方式
          steu005        LIKE steu_t.steu005,   #结算账期
          steu006        LIKE steu_t.steu006,   #起始日期
          steu007        LIKE steu_t.steu007,   #截止日期
          steu008        LIKE steu_t.steu008,   #交款情况
          steu009        LIKE steu_t.steu009,   #单据金额合计
          steu010        LIKE steu_t.steu010,   #货款扣费用否
          steu011        LIKE steu_t.steu011,   #结算单号
          steu012        LIKE steu_t.steu012,   #备注
          steustus       LIKE steu_t.steustus,  #状态码
          steuownid      LIKE steu_t.steuownid, #资料所有者
          steuowndp      LIKE steu_t.steuowndp, #资料所有部门
          steucrtid      LIKE steu_t.steucrtid, #资料建立者
          steucrtdt      LIKE steu_t.steucrtdt, #资料创建日
          steucrtdp      LIKE steu_t.steucrtdp, #资料建立部门
          steupstid      LIKE steu_t.steupstid, #资料过账者
          steupstdt      LIKE steu_t.steupstdt, #资料过账日
          steumodid      LIKE steu_t.steumodid, #资料修改者
          steumoddt      LIKE steu_t.steumoddt, #最近修改日
          steucnfdt      LIKE steu_t.steucnfdt, #数据确认日
          steucnfid      LIKE steu_t.steucnfid  #资料确认者
                         END RECORD  
                         
DEFINE g_astt840_doc_type    LIKE type_t.chr10          #arti200預設單別
DEFINE g_astt850_doc_type    LIKE type_t.chr10          #arti200預設單別
DEFINE g_para                LIKE type_t.chr1           #啟用交款匯總否(aoos010:S-CIR-2012)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp840.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp840_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp840 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp840_init()
 
      #進入選單 Menu (="N")
      CALL astp840_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp840
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp840.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp840_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
   CALL cl_set_combo_scc("l_choice","6832")
   CALL astp840_stbc010_display('stbc010') #add by geza 20160613
   LET g_master.l_r1='N'  #ADD BY LIYAN 
   LET g_master.l_r2='N'  #ADD BY LIYAN
   DISPLAY g_site TO stbc001  #160604-00009#61
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp840.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp840_ui_dialog()
 
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
         INPUT BY NAME g_master.stbc040,g_master.l_choice,g_master.l_r1,g_master.l_r2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc040
            #add-point:BEFORE FIELD stbc040 name="input.b.stbc040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc040
            
            #add-point:AFTER FIELD stbc040 name="input.a.stbc040"
            IF NOT cl_null(g_master.stbc040) AND g_master.stbc040 > g_today THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ast-00708'
               LET g_errparam.extend = g_master.stbc040
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_master.stbc040 = g_today - 1 
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stbc040
            #add-point:ON CHANGE stbc040 name="input.g.stbc040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_choice
            #add-point:BEFORE FIELD l_choice name="input.b.l_choice"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_choice
            
            #add-point:AFTER FIELD l_choice name="input.a.l_choice"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_choice
            #add-point:ON CHANGE l_choice name="input.g.l_choice"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_r1
            #add-point:BEFORE FIELD l_r1 name="input.b.l_r1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_r1
            
            #add-point:AFTER FIELD l_r1 name="input.a.l_r1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_r1
            #add-point:ON CHANGE l_r1 name="input.g.l_r1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_r2
            #add-point:BEFORE FIELD l_r2 name="input.b.l_r2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_r2
            
            #add-point:AFTER FIELD l_r2 name="input.a.l_r2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_r2
            #add-point:ON CHANGE l_r2 name="input.g.l_r2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.stbc040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc040
            #add-point:ON ACTION controlp INFIELD stbc040 name="input.c.stbc040"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_choice
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_choice
            #add-point:ON ACTION controlp INFIELD l_choice name="input.c.l_choice"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_r1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_r1
            #add-point:ON ACTION controlp INFIELD l_r1 name="input.c.l_r1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_r2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_r2
            #add-point:ON ACTION controlp INFIELD l_r2 name="input.c.l_r2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stbc001,stbc033,stbc030,stbc008,stbc010
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               DISPLAY g_site TO stbc001  #160604-00009#61
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc001
            #add-point:ON ACTION controlp INFIELD stbc001 name="construct.c.stbc001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = 'A' #mark by geza 20160613
            IF s_aooi500_setpoint(g_prog,'stbc001') THEN
               LET g_qryparam.where = "ooefstus='Y'",s_aooi500_q_where(g_prog,'stbc001',g_site,'c')   
            ELSE
               LET g_qryparam.where= "ooefstus='Y'" 
            END IF
            CALL q_ooef001_23()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc001  #顯示到畫面上
            NEXT FIELD stbc001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc001
            #add-point:BEFORE FIELD stbc001 name="construct.b.stbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc001
            
            #add-point:AFTER FIELD stbc001 name="construct.a.stbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc033
            #add-point:ON ACTION controlp INFIELD stbc033 name="construct.c.stbc033"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhbe001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc033  #顯示到畫面上
            NEXT FIELD stbc033                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc033
            #add-point:BEFORE FIELD stbc033 name="construct.b.stbc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc033
            
            #add-point:AFTER FIELD stbc033 name="construct.a.stbc033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc030
            #add-point:ON ACTION controlp INFIELD stbc030 name="construct.c.stbc030"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stje001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc030  #顯示到畫面上
            NEXT FIELD stbc030                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc030
            #add-point:BEFORE FIELD stbc030 name="construct.b.stbc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc030
            
            #add-point:AFTER FIELD stbc030 name="construct.a.stbc030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc008
            #add-point:ON ACTION controlp INFIELD stbc008 name="construct.c.stbc008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc008  #顯示到畫面上
            NEXT FIELD stbc008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc008
            #add-point:BEFORE FIELD stbc008 name="construct.b.stbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc008
            
            #add-point:AFTER FIELD stbc008 name="construct.a.stbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc010
            #add-point:ON ACTION controlp INFIELD stbc010 name="construct.c.stbc010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc010  #顯示到畫面上
            NEXT FIELD stbc010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc010
            #add-point:BEFORE FIELD stbc010 name="construct.b.stbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc010
            
            #add-point:AFTER FIELD stbc010 name="construct.a.stbc010"
            
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
            CALL astp840_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.stbc040 = g_today - 1
            LET g_para = cl_get_para(g_enterprise,g_site,"S-CIR-2012")
            #是否启用交款汇总单为N,只能生成结算单
            IF g_para = 'N' THEN
               CALL cl_set_combo_scc_part("l_choice","6832",'1')
               CALL cl_set_comp_entry("l_choice", FALSE)
               LET g_master.l_choice = '1' 
            ELSE
               CALL cl_set_comp_entry("l_choice", TRUE)
               LET g_master.l_choice = '0'
            END IF 
            DISPLAY 0 TO stagecomplete
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
         CALL astp840_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.stbc040  = g_master.stbc040 
      LET lc_param.l_choice = g_master.l_choice
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
                 CALL astp840_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp840_transfer_argv(ls_js)
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
 
{<section id="astp840.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp840_transfer_argv(ls_js)
 
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
 
{<section id="astp840.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp840_process(ls_js)
 
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
   DEFINE l_msg         STRING    
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_stbc001     LIKE stbc_t.stbc001
   DEFINE l_stbc030     LIKE stbc_t.stbc030
   DEFINE l_stbddocno   LIKE stbd_t.stbddocno
   DEFINE l_stevdocno   LIKE stev_t.stevdocno
   DEFINE l_string    STRING
   DEFINE l_string1    STRING
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
      CALL cl_progress_bar_no_window(3)
      
      LET l_msg = cl_getmsg('ast-00330',g_lang)
      CALL cl_progress_no_window_ing(l_msg)      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp840_process_cs CURSOR FROM ls_sql
#  FOREACH astp840_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   CALL s_transaction_begin()

      
   #结算日期空白或者无值则赋值=g_today-1
   IF cl_null(lc_param.stbc040) THEN
      LET lc_param.stbc040 = g_today - 1
   END IF
   IF lc_param.wc = " 1=1" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00740'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL cl_err_collect_show()
      RETURN
   END IF
   
   #160610-00001#1 160610 by lori mark---(S)
   #LET l_sql = " SELECT DISTINCT stbc001,stbc030 FROM stbc_t ",
   #            "  WHERE stbcent = ",g_enterprise," AND stbc009 = '5' AND ", lc_param.wc
   #PREPARE astp840_stbc001_pre FROM l_sql
   #DECLARE astp840_stbc001_cs  CURSOR FOR astp840_stbc001_pre
   #
   #LET l_msg = cl_getmsg('std-00012',g_lang)
   #CALL cl_progress_no_window_ing(l_msg)
   #
   #FOREACH astp840_stbc001_cs INTO l_stbc001,l_stbc030
   #   DISPLAY "l_stbc001:",l_stbc001," , l_stbc030:",l_stbc030
   #   #1.检查：
   #   CALL astp840_ins_chk(lc_param.l_choice,l_stbc001,l_stbc030,lc_param.stbc040) RETURNING l_success
   #   IF NOT l_success THEN
   #      EXIT FOREACH
   #   END IF
   #   #2.条件筛选与抓取
   #   CASE lc_param.l_choice
   #      WHEN '0' #0.全部
   #         CALL astp840_ins_astt840(lc_param.*,l_stbc001,l_stbc030) RETURNING l_success,l_stbddocno
   #         CALL astp840_ins_astt850(lc_param.*,l_stbc001,l_stbc030) RETURNING l_success,l_stevdocno
   #      WHEN '1' #1.結算單 
   #         CALL astp840_ins_astt840(lc_param.*,l_stbc001,l_stbc030) RETURNING l_success,l_stbddocno
   #      WHEN '2' #2.交款匯總單
   #         CALL astp840_ins_astt850(lc_param.*,l_stbc001,l_stbc030) RETURNING l_success,l_stevdocno
   #   END CASE
   #END FOREACH
   #160610-00001#1 160610 by lori mark---(E)
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   LET l_success = ''
  #CALL s_astp840_get_contract('Y',lc_param.*) RETURNING l_success   
  IF lc_param.l_choice = '0' OR lc_param.l_choice = '1' THEN     #mod by liyan 160516-00014#21 l_r1,l_r2 总货款小于0是否结算，总费用小于0是否结算
        CALL s_astp840_insert(lc_param.wc,lc_param.stbc040,lc_param.l_choice,g_master.l_r1,g_master.l_r2) RETURNING l_success,l_string
   END IF
   IF lc_param.l_choice = '0' AND cl_null(l_string) AND cl_null(l_string1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code = 'ast-00356'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   IF NOT l_success THEN
      CALL s_transaction_end("N","0")
   ELSE
      CALL s_transaction_end("Y","0")
   END IF
   CALL cl_err_collect_show()
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      LET l_msg = cl_getmsg('std-00012',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
      IF l_success THEN
         CALL s_astp840_insert_show(l_string,l_string1)
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL astp840_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp840.get_buffer" >}
PRIVATE FUNCTION astp840_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.stbc040 = p_dialog.getFieldBuffer('stbc040')
   LET g_master.l_choice = p_dialog.getFieldBuffer('l_choice')
   LET g_master.l_r1 = p_dialog.getFieldBuffer('l_r1')
   LET g_master.l_r2 = p_dialog.getFieldBuffer('l_r2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp840.msgcentre_notify" >}
PRIVATE FUNCTION astp840_msgcentre_notify()
 
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
 
{<section id="astp840.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 產生astt840結算單
# Memo...........:
# Usage..........: CALL astp840_ins_astt840()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astp840_ins_astt840(lc_param,p_stbc001,p_stbc030)
   DEFINE lc_param       type_parameter 
   DEFINE p_stbc001      LIKE stbc_t.stbc001
   DEFINE p_stbc030      LIKE stbc_t.stbc030
   DEFINE l_sql          STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_stjo002      LIKE stjo_t.stjo002
   DEFINE l_stbc         g_type_stbc
   DEFINE l_stbd         g_type_stbd
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_stbddocno    LIKE stbd_t.stbddocno 
   
   LET r_success = TRUE
   #依合約帶出單頭所需資訊
   SELECT stje005,stje006,stje007,stje027,stje029,stje030
     INTO l_stbd.stbd041,l_stbd.stbd047,l_stbd.stbd002,l_stbd.stbd049,l_stbd.stbd050,l_stbd.stbdsite
     FROM stje_t 
    WHERE stjeent= g_enterprise AND stje001 = p_stbc030 
      AND stjestus <> 'N'
   #产生单头资料
   
   #根据QBE条件以及结算组织、合同、供应商，产生结算单单头资料
   #当存在多个结算日期时，取最大的结算日期作为结算的日期，  同时推导出日期范围与财务结算会计期
   LET l_stbd.stbdent   = g_enterprise   
   LET l_stbd.stbdunit  = p_stbc001
   LET l_stbd.stbd000   = "3"
   #自動編號
   CALL s_aooi200_gen_docno(p_stbc001,g_astt840_doc_type,g_today,'astt840') RETURNING l_success,l_stbd.stbddocno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_astt840_doc_type
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success=FALSE
      RETURN r_success,r_stbddocno
   END IF  
   
   LET l_stbd.stbddocdt = g_today
   LET l_stbd.stbd001   = p_stbc030
   LET l_stbd.stbd003   = '5'
   
   
   SELECT MIN(stjoseq) INTO l_stbd.stbd004          #結算賬期
     FROM stjo_t
    WHERE stjoent = g_enterprise
      AND stjo001 = p_stbc030
      AND stjo005 = 'N'
      
   SELECT stjo003,stjo004 INTO l_stbd.stbd005,l_stbd.stbd006   #起始日期 #截止日期
     FROM stjo_t
    WHERE stjoent = g_enterprise
      AND stjo001 = p_stbc030
      AND stjo005 = 'N'
      AND stjoseq = l_stbd.stbd004
   CALL s_astt840_get_period(p_stbc030,l_stbd.stbd004 ,p_stbc001) RETURNING l_stjo002,l_stbd.stbd043,l_stbd.stbd044
   LET l_stbd.stbd007 = 0                             #上期結存金額
   LET l_stbd.stbd008 = 0                             #本期銷貨成本
   LET l_stbd.stbd009 = 0                             #本期進貨金額
   LET l_stbd.stbd010 = 0                             #本期退貨金額
   LET l_stbd.stbd011 = 0                             #本期折讓金額
   LET l_stbd.stbd012 = 0                             #稅額
   LET l_stbd.stbd013 = 0                             #價稅合計
   LET l_stbd.stbd014 = 0                             #本期預付金額
   LET l_stbd.stbd015 = 0                             #本期價外扣款
   LET l_stbd.stbd016 = 'N'                           #貨款扣費用否
   LET l_stbd.stbd017 = 0                             #應結算金額
   LET l_stbd.stbd018 = 0                             #實際計算金額
   LET l_stbd.stbd019 = 0                             #本期結存金額
   LET l_stbd.stbd020 = '0'                           #結算標識
   LET l_stbd.stbd021 = g_user                        #人員
   LET l_stbd.stbd022 = g_dept                        #部門  
   LET l_stbd.stbd023   = g_site
   LET l_stbd.stbd024   = ''
   LET l_stbd.stbd025   = ''
   LET l_stbd.stbd026   = ''
   LET l_stbd.stbd027   = ''
   LET l_stbd.stbd028   = ''
   LET l_stbd.stbd029   = ''
   LET l_stbd.stbd030   = ''
   LET l_stbd.stbd031   = ''
   LET l_stbd.stbd032   = ''
   LET l_stbd.stbd033   = ''
   LET l_stbd.stbd034   = ''
   LET l_stbd.stbd035   = ''
   LET l_stbd.stbd036   = ''
   
   SELECT stje008 INTO l_stbd.stbd037 
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = p_stbc030
   
   LET l_stbd.stbd038   = s_astt840_get_stbd038(p_stbc030,l_stbd.stbd006)
   LET l_stbd.stbd039   = "2"                                                #160516-00014#5 160609 by lori mod
   
   #付款供应商(stbd046)依供應商編號抓取pmac_t 且 交易類型 = 1.收/付款對象 且 勾主要
   CALL s_adb_get_pmac002(l_stbd.stbd002,'1','') RETURNING l_stbd.stbd046
   SELECT ooef017 INTO l_stbd.stbd048 #結算法人
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = l_stbd.stbdsite
   LET l_stbd.stbdstus  = 'N'
   LET l_stbd.stbdownid = g_user
   LET l_stbd.stbdowndp = g_dept
   LET l_stbd.stbdcrtid = g_user
   LET l_stbd.stbdcrtdp = g_dept 
   LET l_stbd.stbdcrtdt = cl_get_current()
   
   INSERT INTO stbd_t(
               stbdent,  stbdunit, stbdsite, stbddocno,stbddocdt,
               stbd001,  stbd002,  stbd003,  stbd004,  stbd005,  stbd006,
               stbd007,  stbd008,  stbd009,  stbd010,  stbd011,  stbd012,
               stbd013,  stbd014,  stbd015,  stbd016,  stbd017,  stbd018,
               stbd019,  stbd020,  stbd021,  stbd022,  stbd023,  stbd024,
               stbd025,  stbd026,  stbd027,  stbd028,  stbd029,  stbd030,
               stbd031,  stbd032,  stbd033,  stbdstus, stbdownid,
               stbdowndp,stbdcrtid,stbdcrtdp,stbdcrtdt,stbdmodid,
               stbdmoddt,stbdcnfid,stbdcnfdt,stbd034,  stbd035,
               stbd036,  stbd000,  stbd037,  stbd038,  stbd039,  stbd040,
               stbd041,  stbd042,  stbd043,  stbd044,  stbd045,  stbd046,
               stbd047,  stbd048,  stbd049,  stbd050)
        VALUES 
              (l_stbd.stbdent,  l_stbd.stbdunit, l_stbd.stbdsite, l_stbd.stbddocno,l_stbd.stbddocdt,
               l_stbd.stbd001,  l_stbd.stbd002,  l_stbd.stbd003,  l_stbd.stbd004,  l_stbd.stbd005,  l_stbd.stbd006,
               l_stbd.stbd007,  l_stbd.stbd008,  l_stbd.stbd009,  l_stbd.stbd010,  l_stbd.stbd011,  l_stbd.stbd012,
               l_stbd.stbd013,  l_stbd.stbd014,  l_stbd.stbd015,  l_stbd.stbd016,  l_stbd.stbd017,  l_stbd.stbd018,
               l_stbd.stbd019,  l_stbd.stbd020,  l_stbd.stbd021,  l_stbd.stbd022,  l_stbd.stbd023,  l_stbd.stbd024,
               l_stbd.stbd025,  l_stbd.stbd026,  l_stbd.stbd027,  l_stbd.stbd028,  l_stbd.stbd029,  l_stbd.stbd030,
               l_stbd.stbd031,  l_stbd.stbd032,  l_stbd.stbd033,  l_stbd.stbdstus, l_stbd.stbdownid,
               l_stbd.stbdowndp,l_stbd.stbdcrtid,l_stbd.stbdcrtdp,l_stbd.stbdcrtdt,l_stbd.stbdmodid,
               l_stbd.stbdmoddt,l_stbd.stbdcnfid,l_stbd.stbdcnfdt,l_stbd.stbd034,  l_stbd.stbd035,
               l_stbd.stbd036,  l_stbd.stbd000,  l_stbd.stbd037,  l_stbd.stbd038,  l_stbd.stbd039,  l_stbd.stbd040,
               l_stbd.stbd041,  l_stbd.stbd042,  l_stbd.stbd043,  l_stbd.stbd044,  l_stbd.stbd045,  l_stbd.stbd046,
               l_stbd.stbd047,  l_stbd.stbd048,  l_stbd.stbd049,  l_stbd.stbd050)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins stbd_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF  
   
   #160513-00037#12 160521 by lori mark and add---(S)
   #CALL s_astp840_stbc('1'              ,g_para          ,g_site     ,l_stbd.stbdsite  ,'' ,
   #                     ''              ,'5'             ,p_stbc030  ,l_stbd.stbd037   ,'',
   #                     lc_param.stbc040,l_stbd.stbddocno,lc_param.wc) RETURNING l_success,l_stbc.*
   #
   CALL s_astp840_ins_detail('Y', '1' , g_para , g_site    , l_stbd.stbdsite ,
                             '' , ''  , '5'    , p_stbc030 , l_stbd.stbd037 ,
                             '' , lc_param.stbc040 , l_stbd.stbddocno , lc_param.wc 
                             ) RETURNING l_success
   #160513-00037#12 160521 by lori mark and add---(E)
   IF NOT l_success THEN 
      LET r_success = FALSE
   END IF
   
   LET r_stbddocno = l_stbd.stbddocno
   RETURN r_success,r_stbddocno
END FUNCTION

################################################################################
# Descriptions...: 產生astt850(交款匯總單)
# Memo...........:
# Usage..........: CALL astp840_ins_astt850()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astp840_ins_astt850(lc_param,p_stbc001,p_stbc030)
   DEFINE lc_param       type_parameter 
   DEFINE p_stbc001      LIKE stbc_t.stbc001
   DEFINE p_stbc030      LIKE stbc_t.stbc030
   DEFINE l_sql          STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_stjo002      LIKE stjo_t.stjo002
   DEFINE l_stbc         g_type_stbc
   DEFINE l_steu         g_type_steu
   DEFINE r_success      LIKE type_t.num5
   DEFINE r_stevdocno    LIKE stev_t.stevdocno  
   
   LET r_success = TRUE
   
   LET l_steu.steuent   = g_enterprise
   LET l_steu.steuunit  = g_today
   LET l_steu.steusite  =  p_stbc001
   LET l_steu.steudocnt = g_today
   #自動編號
   CALL s_aooi200_gen_docno(p_stbc001,g_astt850_doc_type,g_today,'astt850') RETURNING l_success,l_steu.steudocno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = g_astt850_doc_type
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success=FALSE
      RETURN r_success,r_stevdocno
   END IF  
   
   SELECT stje007,stje008 INTO l_steu.steu003,l_steu.steu002 
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = p_stbc030
      AND stjestus <> 'N'
   LET l_steu.steu000   = '1'
   LET l_steu.steu001   = p_stbc030
   LET l_steu.steu004   = '5'
   
   SELECT MIN(stjoseq) INTO l_steu.steu005          #結算賬期
     FROM stjo_t
    WHERE stjoent = g_enterprise
      AND stjo001 = p_stbc030
      AND stjo005 = 'N'
      
   SELECT stjo003,stjo004 INTO l_steu.steu006,l_steu.steu007   #起始日期 #截止日期
     FROM stjo_t
    WHERE stjoent = g_enterprise
      AND stjo001 = p_stbc030
      AND stjo005 = 'N'
      AND stjoseq = l_steu.steu005
   
   LET l_steu.steu008   = '1'
   LET l_steu.steu009   = '0'
   LET l_steu.steustus  = 'N'
   LET l_steu.steuownid = g_user
   LET l_steu.steuowndp = g_dept
   LET l_steu.steucrtid = g_user
   LET l_steu.steucrtdp = g_dept 
   LET l_steu.steucrtdt = cl_get_current()
   
   INSERT INTO steu_t(
               steuent,steuunit,steusite,steudocno,steustus,
               steu001,steu002,steu003,steu004,steu005,
               steu006,steu007,steu008,steu009,steu010,
               steu011,steu012,steuownid,steuowndp,steucrtid,
               steucrtdp,steucrtdt,steumodid,steumoddt,steucnfid,
               steucnfdt,steupstid,steupstdt,steu000,steudocnt)
        VALUES 
              (l_steu.steuent  ,l_steu.steuunit ,l_steu.steusite ,l_steu.steudocno,l_steu.steustus ,
               l_steu.steu001  ,l_steu.steu002  ,l_steu.steu003  ,l_steu.steu004  ,l_steu.steu005  ,
               l_steu.steu006  ,l_steu.steu007  ,l_steu.steu008  ,l_steu.steu009  ,l_steu.steu010  ,
               l_steu.steu011  ,l_steu.steu012  ,l_steu.steuownid,l_steu.steuowndp,l_steu.steucrtid,
               l_steu.steucrtdp,l_steu.steucrtdt,l_steu.steumodid,l_steu.steumoddt,l_steu.steucnfid,
               l_steu.steucnfdt,l_steu.steupstid,l_steu.steupstdt,l_steu.steu000  ,l_steu.steudocnt)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins steu_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF  
   
   #160513-00037#12 160521 by lori mark and add---(S)
   #CALL s_astp840_stbc('2'              ,g_para          ,g_site     ,l_steu.steusite  ,'' ,
   #                     ''              ,'5'             ,p_stbc030  ,l_steu.steu002   ,'',
   #                     lc_param.stbc040,l_steu.steudocno,lc_param.wc) RETURNING l_success,l_stbc.*
   #
   CALL s_astp840_ins_detail('Y' , '2' , g_para , g_site , l_steu.steusite ,
                             ''  , ''  , '5'    , p_stbc030 , l_steu.steu002 ,
                             ''  , lc_param.stbc040 , l_steu.steudocno , lc_param.wc
                            ) RETURNING l_success
   #160513-00037#12 160521 by lori mark and add---(E)
   IF NOT l_success THEN 
      LET r_success = FALSE
   END IF
   
   LET r_stevdocno = l_steu.steudocno
   RETURN r_success,r_stevdocno
END FUNCTION

################################################################################
# Descriptions...: 打開arti200維護單據別
# Memo...........:
# Usage..........: astp840_open_arti200()
# Date & Author..: 20160425 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astp840_open_arti200()
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
          prog        STRING,
          actionid    STRING,
          background  LIKE type_t.chr1,
          param       DYNAMIC ARRAY OF STRING
                      END RECORD
 
   LET la_cmdrun.prog = 'arti200'
   LET la_cmdrun.background = "N"
   
   LET ls_js = util.JSON.stringify( la_cmdrun )
   CALL cl_cmdrun(ls_js)
   
END FUNCTION

################################################################################
# Descriptions...: ins前chk
# Memo...........:
# Usage..........: CALL astp840_ins_chk(p_choice,p_stbc001,p_stbc030,p_stbc040)
#                  RETURNING r_success
# Input parameter: p_choice       選項  
#                : p_stbc001      結算中心
#                : p_stbc030      合約編號
#                : p_stbc040      結算日期
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20160426 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION astp840_ins_chk(p_choice,p_stbc001,p_stbc030,p_stbc040)
   DEFINE p_choice  LIKE type_t.chr500
   DEFINE p_stbc001 LIKE stbc_t.stbc001 
   DEFINE p_stbc030 LIKE stbc_t.stbc030
   DEFINE p_stbc040 LIKE stbc_t.stbc040
   DEFINE l_errno   STRING
   DEFINE l_success LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   
   CASE p_choice
      WHEN '0' #全部
         #默认单别未设定，错误提示【XXX作业未设定默认单别，请到arti200中设定默认单别!】,并打开程序arti200方便维护
         #取arti200預設單別,type='2'批次拋轉預設單別
         LET g_astt840_doc_type = ''
         LET l_success = ''
         
         CALL s_arti200_get_def_doc_type(p_stbc001,'astt840','2') RETURNING l_success,g_astt840_doc_type
         IF NOT l_success THEN 
            LET r_success = FALSE
            CALL astp840_open_arti200()
         END IF
         
         LET g_astt850_doc_type = ''
         LET l_success = ''
         
         CALL s_arti200_get_def_doc_type(p_stbc001,'astt850','2') RETURNING l_success,g_astt850_doc_type
         IF NOT l_success THEN 
            LET r_success = FALSE
            CALL astp840_open_arti200()
         END IF
         
         #1.1结算日期>关账日期(asti206)    
         CALL s_asti206_check(p_stbc001,p_stbc040,'astt840') RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = p_stbc001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success=FALSE
         END IF  
         
         CALL s_asti206_check(p_stbc001,p_stbc040,'astt850') RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = p_stbc001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success=FALSE
         END IF  
         
         #1.2若存在未审核的合同的结算单，则不可产生结算单
         IF NOT astp840_stbd_chk(p_stbc030) THEN
            LET r_success = FALSE
         END IF
         
      WHEN '1' #結算單
         #默认单别未设定，错误提示【XXX作业未设定默认单别，请到arti200中设定默认单别!】,并打开程序arti200方便维护
         #取arti200預設單別,type='2'批次拋轉預設單別
         LET g_astt840_doc_type = ''
         LET l_success = ''
         
         CALL s_arti200_get_def_doc_type(p_stbc001,'astt840','2') RETURNING l_success,g_astt840_doc_type
         IF NOT l_success THEN 
            LET r_success = FALSE
            CALL astp840_open_arti200()
         END IF
         #1.1结算日期>关账日期(asti206)    
         CALL s_asti206_check(p_stbc001,p_stbc040,'astt840') RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = p_stbc001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success=FALSE
         END IF  
         #1.2若存在未审核的合同的结算单，则不可产生结算单
         IF NOT astp840_stbd_chk(p_stbc030) THEN
            LET r_success = FALSE
         END IF
         
      WHEN '2'
         #默认单别未设定，错误提示【XXX作业未设定默认单别，请到arti200中设定默认单别!】,并打开程序arti200方便维护
         #取arti200預設單別,type='2'批次拋轉預設單別
         LET g_astt850_doc_type = ''
         LET l_success = ''
         
         CALL s_arti200_get_def_doc_type(p_stbc001,'astt850','2') RETURNING l_success,g_astt850_doc_type
         IF NOT l_success THEN 
            LET r_success = FALSE
            CALL astp840_open_arti200()
         END IF
         
         #1.1结算日期>关账日期(asti206)
         CALL s_asti206_check(p_stbc001,p_stbc040,'astt850') RETURNING l_success,l_errno
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = l_errno
            LET g_errparam.extend = p_stbc001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success=FALSE
         END IF  
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 若存在未審核的合同的結算單,不可產生結算單
# Memo...........:
# Usage..........: CALL astp840_stbd_chk(p_stbc030) 
#                  RETURNING r_success
# Input parameter: p_stbc030      合同編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/04/29 By beckxie
################################################################################
PRIVATE FUNCTION astp840_stbd_chk(p_stbc030)
   DEFINE p_stbc030   LIKE stbc_t.stbc030
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_cnt
     FROM stbd_t
    WHERE stbdent = g_enterprise 
      AND stbd001 = p_stbc030   
      AND stbdstus = 'N' 
      
   IF l_cnt > 0 THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ast-00717'
      LET g_errparam.extend = p_stbc030
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 结算方式下拉框显示
# Memo...........:
# Usage..........: CALL astp840_stbc010_display(p_field)
#                  RETURNING 回传参数
# Input parameter: p_field        栏位名称
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 20160613 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astp840_stbc010_display(p_field)
DEFINE p_field        LIKE type_t.chr20     #栏位名称
DEFINE l_staa001      LIKE staa_t.staa001
DEFINE l_staal003     LIKE staal_t.staal003
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE cb004          ui.ComboBox
   
   
   LET cb004 = ui.ComboBox.forName(p_field)
   CALL cb004.clear()
   
   LET l_cnt = 0
   LET l_sql = " SELECT DISTINCT staa001,staal003 ",
               "   FROM staa_t LEFT JOIN staal_t ON staaent = staalent AND staa001 = staal001 AND staal002 = '",g_dlang,"' ",
               "  WHERE staaent = ",g_enterprise," ",
               "    AND staastus = 'Y' "
   LET l_sql = l_sql," ORDER BY staa001 "
  
   PREPARE sel_staa_pre FROM l_sql
   DECLARE sel_staa_cs  CURSOR FOR sel_staa_pre
   LET l_cnt = 1
   FOREACH sel_staa_cs  INTO l_staa001,l_staal003
      LET l_staal003 = l_staa001,':',l_staal003
      IF cl_null(l_staal003) THEN
         CALL cb004.addItem(l_staa001,l_staa001)
      ELSE
         CALL cb004.addItem(l_staa001,l_staal003)
      END IF
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION

#end add-point
 
{</section>}
 
