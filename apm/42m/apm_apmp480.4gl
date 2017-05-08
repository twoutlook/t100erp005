#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp480.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-08-30 13:57:31), PR版次:0007(2017-01-16 18:17:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: apmp480
#+ Description: 請轉採整批產生作業
#+ Creator....: 02295(2015-03-26 10:48:21)
#+ Modifier...: 02294 -SD/PR- 05423
 
{</section>}
 
{<section id="apmp480.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151215-00014#1   2015/12/17  By earl  抓不到下一站的單別時，顯示錯誤訊息
#160801-00004#2   2016/08/01  By lixiang  庫存管理特微有值時，需帶入到採購單上，且有值時，請購資料不合併
#160802-00014#1   2016/08/09  By xianghui 请购单有指定供应商时，则采购单的供应商给请购单的且数量不限
#160819-00043#5   2016/08/23  By lixiang  抓取"分配比率(pmao008)"的部份，改抓pmat_t檔，需串到site
#161124-00048#8   2016/12/14  By zhujing  .*整批调整
#161221-00064#8   2017/01/10  By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
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
       pmdadocno LIKE type_t.chr20, 
   pmdadocdt LIKE type_t.dat, 
   pmda003 LIKE type_t.chr10, 
   pmdb004 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr10, 
   pmdb030 LIKE type_t.dat, 
   imaf141 LIKE type_t.chr10, 
   pmda002 LIKE type_t.chr20, 
   pmdb015 LIKE type_t.chr10, 
   a LIKE type_t.chr500, 
   b LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_tmp RECORD 
         pmdbdocno     LIKE pmdb_t.pmdbdocno,      #請購單單據編號
         pmdbseq       LIKE pmdb_t.pmdbdocno,      #項次
         slip          LIKE ooba_t.ooba002,        #請購單單別對應採購單單別
         pmdb015       LIKE pmdb_t.pmdb015,        #供應商編號 
         pmdb004       LIKE pmdb_t.pmdb004,        #料號
         pmdb005       LIKE pmdb_t.pmdb005,        #產品特徵  
         pmdb007       LIKE pmdb_t.pmdb007,        #需求單位
         pmdb006       LIKE pmdb_t.pmdb006,        #需求數量
         pmdb011       LIKE pmdb_t.pmdb011,        #计价单位         
         pmdb010       LIKE pmdb_t.pmdb010,        #计价數量
         pmdb030       LIKE pmdb_t.pmdb030,        #需求日期
         #160801-00004#2--s
         pmdb038       LIKE pmdb_t.pmdb038,        #收货库位       
         pmdb039       LIKE pmdb_t.pmdb039,        #收货储位
         pmdb054       LIKE pmdb_t.pmdb054,        #库存管理特征
         #160801-00004#2--e
         pmdb050       LIKE pmdb_t.pmdb050,        #備註         
         qty           LIKE pmdb_t.pmdb006,        #未轉採購量     
         applied_qty   LIKE pmdb_t.pmdb006         #已分配數量 
        END RECORD 
 
 TYPE type_g_pmdn_d_02 RECORD
            pmdb014_02_01      LIKE pmdb_t.pmdb014,     #供應商選擇 
            pmdl004_02_01      LIKE pmdl_t.pmdl004,     #供應商編號
            pmdl002_02_01      LIKE pmdl_t.pmdl002,     #採購員            
            pmdb004_02_01      LIKE pmdb_t.pmdb004,     #料件編號  
            pmdb005_02_01      LIKE pmdb_t.pmdb005,     #產品特徵    
            pmdb007_02_01      LIKE pmdb_t.pmdb007,     #單位  
            qty_02_01          LIKE pmdb_t.pmdb006,     #未轉採購量  
            pmdn014_02_01      LIKE pmdn_t.pmdn014,     #到庫日期  
            pmdn001_02_01      LIKE pmdn_t.pmdn001,     #料件編號   
            pmdn002_02_01      LIKE pmdn_t.pmdn002,     #產品特徵   
            pmdn006_02_01      LIKE pmdn_t.pmdn006,     #採購單位  
            pmdn007_02_01      LIKE pmdn_t.pmdn007,     #採購數量   
            pmdn008_02_01      LIKE pmdn_t.pmdn008,     #參考單位  
            pmdn009_02_01      LIKE pmdn_t.pmdn009,     #參考數量 
            pmdn010_02_01      LIKE pmdn_t.pmdn010,     #計價單位           
            pmdn011_02_01      LIKE pmdn_t.pmdn011,     #計價數量   
            pmdn050_02_01      LIKE pmdn_t.pmdn050,     #備註 
            pmdbent_02_01      LIKE pmdb_t.pmdbent,
            pmdbsite_02_01     LIKE pmdb_t.pmdbsite
         END RECORD
         
 TYPE type_g_pmdl_d_03 RECORD
              pmdl004_03_01      LIKE pmdl_t.pmdl004,     #供應商
              pmdl002_03_01      LIKE pmdl_t.pmdl002,     #採購員              
              pmdl009_03_01      LIKE pmdl_t.pmdl009,     #付款條件   
              pmdl010_03_01      LIKE pmdl_t.pmdl010,     #交易條件   
              pmdl011_03_01      LIKE pmdl_t.pmdl011,     #稅別    
              pmdl012_03_01      LIKE pmdl_t.pmdl012,     #稅率   
              pmdl013_03_01      LIKE pmdl_t.pmdl013,     #含稅否  
              pmdl015_03_01      LIKE pmdl_t.pmdl015,     #幣別    
              pmdl016_03_01      LIKE pmdl_t.pmdl016,     #匯率   
              pmdl017_03_01      LIKE pmdl_t.pmdl017,     #取價方式   
              pmdl023_03_01      LIKE pmdl_t.pmdl023,     #採購通路  
              pmdl054_03_01      LIKE pmdl_t.pmdl054,     #內外購 
              pmdl033_03_01      LIKE pmdl_t.pmdl033,     #發票類型
              pmdl055_03_01      LIKE pmdl_t.pmdl055      #匯率計算基礎 
           END RECORD
 TYPE type_g_pmdn_d_03 RECORD
                  pmdnseq_03_02      LIKE pmdn_t.pmdnseq,     #項次  
                  pmdn001_03_02      LIKE pmdn_t.pmdn001,     #採購料號  
                  pmdn002_03_02      LIKE pmdn_t.pmdn002,     #採購產品特徵   
                  pmdn006_03_02      LIKE pmdn_t.pmdn006,     #採購單位   
                  pmdn007_03_02      LIKE pmdn_t.pmdn007,     #採購數量  
                  pmdn008_03_02      LIKE pmdn_t.pmdn008,     #參考單位 
                  pmdn009_03_02      LIKE pmdn_t.pmdn009,     #參考數量 
                  pmdn010_03_02      LIKE pmdn_t.pmdn010,     #計價單位  
                  pmdn011_03_02      LIKE pmdn_t.pmdn011,     #計價數量  
                  pmdn012_03_02      LIKE pmdn_t.pmdn012,     #交貨日期  
                  pmdn013_03_02      LIKE pmdn_t.pmdn013,     #到廠日期  
                  pmdn014_03_02      LIKE pmdn_t.pmdn014,     #到庫日期  
                  pmdn015_03_02      LIKE pmdn_t.pmdn015,     #單價  
                  pmdn043_03_02      LIKE pmdn_t.pmdn043,     #取出價格  
                  pmdn044_03_02      LIKE pmdn_t.pmdn044,     #價差比 
                  pmdn040_03_02      LIKE pmdn_t.pmdn040,     #取價來源 
                  pmdn050_03_02      LIKE pmdn_t.pmdn050,     #備註  
                  pmdl004_03_02      LIKE pmdl_t.pmdl004,     #供應商資料
                  pmdl002_03_02      LIKE pmdl_t.pmdl002,     #採購員                 
                  pmdn001_03_02_key  LIKE pmdn_t.pmdn001,
                  pmdn002_03_02_key  LIKE pmdn_t.pmdn002,
                  pmdn006_03_02_key  LIKE pmdn_t.pmdn006,
                  pmdn008_03_02_key  LIKE pmdn_t.pmdn008,
                  pmdn010_03_02_key  LIKE pmdn_t.pmdn010
               END RECORD
               
 TYPE type_g_pmdp_d_03 RECORD                      
              pmdpseq_03_03      LIKE pmdp_t.pmdpseq,     #項次  
              pmdpseq1_03_03     LIKE pmdp_t.pmdpseq1,    #項序  
              pmdp001_03_03      LIKE pmdp_t.pmdp001,     #料號  
              pmdp003_03_03      LIKE pmdp_t.pmdp003,     #請購單號  
              pmdp004_03_03      LIKE pmdp_t.pmdp004,     #請購項次    
              pmdp007_03_03      LIKE pmdp_t.pmdp007,     #請購料號  
              pmdp008_03_03      LIKE pmdp_t.pmdp008,     #請購產品特徵                              
              pmdp021_03_03      LIKE pmdp_t.pmdp021,     #沖銷順序  
              pmdp022_03_03      LIKE pmdp_t.pmdp022,     #需求單位  
              pmdp023_03_03      LIKE pmdp_t.pmdp023,     #需求數量  
              pmdp024_03_03      LIKE pmdp_t.pmdp024,     #折合採購量  
              pmdb030_03_03      LIKE pmdb_t.pmdb030,     #需求日期 
              pmdb033_03_03      LIKE pmdb_t.pmdb033,     #緊急度 
              pmdl004_03_03      LIKE pmdl_t.pmdl003,     #供應商
              pmdl002_03_03      LIKE pmdl_t.pmdl002      #採購員              
           END RECORD
                           
 TYPE type_g_pmdo_d_03 RECORD
              pmdoseq_03_04      LIKE pmdo_t.pmdoseq,     #項次  
              pmdoseq1_03_04     LIKE pmdo_t.pmdoseq1,    #項序  
              pmdo001_03_04      LIKE pmdo_t.pmdo001,     #採購料號   
              pmdo002_03_04      LIKE pmdo_t.pmdo002,     #採購產品特徵   
              pmdo004_03_04      LIKE pmdo_t.pmdo004,     #採購單位  
              pmdo005_03_04      LIKE pmdo_t.pmdo005,     #採購數量  
              pmdoseq2_03_04     LIKE pmdo_t.pmdoseq2,    #分批序 
              pmdo006_03_04      LIKE pmdo_t.pmdo006,     #分批採購數量 
              pmdo009_03_04      LIKE pmdo_t.pmdo009,     #交期類型 
              pmdo011_03_04      LIKE pmdo_t.pmdo011,     #交貨日期  
              pmdo012_03_04      LIKE pmdo_t.pmdo012,     #到廠日期  
              pmdo013_03_04      LIKE pmdo_t.pmdo013      #到庫日期  
           END RECORD
DEFINE l_ac    LIKE type_t.num5
DEFINE g_result_str LIKE type_t.chr1000        #執行結果
DEFINE g_ooef008           LIKE ooef_t.ooef008
DEFINE g_ooef009           LIKE ooef_t.ooef009
DEFINE g_ooef019           LIKE ooef_t.ooef019
DEFINE g_pmdn028_t         LIKE pmdn_t.pmdn028   #160801-00004#2
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp480.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apmp480_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp480 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp480_init()
 
      #進入選單 Menu (="N")
      CALL apmp480_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp480
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp480.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp480_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_msg     STRING 
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

   LET l_msg = cl_getmsg("apm-00474",g_lang),",",         #1.依料件進行匯總  
               cl_getmsg("apm-00475",g_lang)              #2.依料件+需求日期進行匯總  
   CALL cl_set_combo_items("a","1,2",l_msg)   
   CALL cl_set_combo_scc("b","2059")   
   LET g_master.a = '1'
   LET g_master.b = '1'
   LET g_master.c = 'N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp480.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp480_ui_dialog()
 
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
         INPUT BY NAME g_master.a,g_master.b,g_master.c 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
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
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmdadocno,pmdadocdt,pmda003,pmdb004,imaa009,pmdb030,imaf141, 
             pmda002,pmdb015
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno name="construct.c.pmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmdastus = 'Y'"
            CALL q_pmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdadocno  #顯示到畫面上
            NEXT FIELD pmdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocno
            #add-point:BEFORE FIELD pmdadocno name="construct.b.pmdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocno
            
            #add-point:AFTER FIELD pmdadocno name="construct.a.pmdadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdadocdt
            #add-point:BEFORE FIELD pmdadocdt name="construct.b.pmdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdadocdt
            
            #add-point:AFTER FIELD pmdadocdt name="construct.a.pmdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdadocdt
            #add-point:ON ACTION controlp INFIELD pmdadocdt name="construct.c.pmdadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda003
            #add-point:ON ACTION controlp INFIELD pmda003 name="construct.c.pmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda003  #顯示到畫面上
            NEXT FIELD pmda003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda003
            #add-point:BEFORE FIELD pmda003 name="construct.b.pmda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda003
            
            #add-point:AFTER FIELD pmda003 name="construct.a.pmda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004 name="construct.c.pmdb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb004  #顯示到畫面上
            NEXT FIELD pmdb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb004
            #add-point:BEFORE FIELD pmdb004 name="construct.b.pmdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb004
            
            #add-point:AFTER FIELD pmdb004 name="construct.a.pmdb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:2)
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb030
            #add-point:BEFORE FIELD pmdb030 name="construct.b.pmdb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb030
            
            #add-point:AFTER FIELD pmdb030 name="construct.a.pmdb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb030
            #add-point:ON ACTION controlp INFIELD pmdb030 name="construct.c.pmdb030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="construct.c.imaf141"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="construct.b.imaf141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="construct.a.imaf141"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002 name="construct.c.pmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda002  #顯示到畫面上
            NEXT FIELD pmda002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmda002
            #add-point:BEFORE FIELD pmda002 name="construct.b.pmda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmda002
            
            #add-point:AFTER FIELD pmda002 name="construct.a.pmda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdb015
            #add-point:ON ACTION controlp INFIELD pmdb015 name="construct.c.pmdb015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdb015  #顯示到畫面上
            NEXT FIELD pmdb015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdb015
            #add-point:BEFORE FIELD pmdb015 name="construct.b.pmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdb015
            
            #add-point:AFTER FIELD pmdb015 name="construct.a.pmdb015"
            
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="construct.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="construct.a.b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="construct.c.b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="construct.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="construct.a.c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="construct.c.c"
            
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
            CALL apmp480_get_buffer(l_dialog)
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
         CALL apmp480_init()
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
                 CALL apmp480_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp480_transfer_argv(ls_js)
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
 
{<section id="apmp480.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp480_transfer_argv(ls_js)
 
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
 
{<section id="apmp480.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp480_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_value      STRING
   DEFINE l_tmp  type_tmp
   DEFINE l_slip  LIKE ooba_t.ooba002
   DEFINE l_success LIKE type_t.num5
   DEFINE l_imaf152 LIKE imaf_t.imaf152
   DEFINE l_pmdb015 LIKE pmdb_t.pmdb015
   DEFINE l_pmdldocno LIKE pmdl_t.pmdldocno
   DEFINE l_pmdl040    LIKE pmdl_t.pmdl040        #採購總未稅金額  
   DEFINE l_pmdl041    LIKE pmdl_t.pmdl041        #採購總含稅金額  
   DEFINE l_pmdl042    LIKE pmdl_t.pmdl042        #採購總稅額     
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #CALL s_transaction_begin()
   CALL cl_err_collect_init() 
   CALL apmp480_create_tmp()   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
    
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp480_process_cs CURSOR FROM ls_sql
#  FOREACH apmp480_process_cs INTO
   #add-point:process段process name="process.process"
   #將滿足條件的請購單資料INSERT到請購單臨時表中
   LET ls_sql = " INSERT INTO apmp480_tmp ",
                " SELECT DISTINCT pmdbdocno,pmdbseq,'',pmdb015,pmdb004, ",
                "                 pmdb005,pmdb007,pmdb006,pmdb011,pmdb010,",
                "                 pmdb030,",
                "                 pmdb038,pmdb039,pmdb054, ",#160801-00004#2
                "                 pmdb050,0,pmdb006",
                "   FROM pmda_t,pmdb_t,imaa_t,imaf_t ",
                "  WHERE pmdaent=pmdbent AND pmdadocno=pmdbdocno ",
                "    AND pmdaent=imaaent AND pmdb004=imaa001 ",
                "    AND pmdaent=imafent AND pmdasite=imafsite AND pmdb004=imaf001 ",
                "    AND pmdaent='",g_enterprise,"'",
                "    AND pmdasite='",g_site,"'",
                "    AND pmdastus='Y' ",
                "    AND pmdb032='1' ",
                "    AND pmdb006>pmdb049 ",               
                "    AND ",g_master.wc
   PREPARE apmp480_insert_tmp FROM ls_sql
   EXECUTE apmp480_insert_tmp

   #更新請購臨時表中的單別
   LET ls_sql = " SELECT DISTINCT * FROM apmp480_tmp "  
   PREPARE apmp480_process_pr FROM ls_sql
   DECLARE apmp480_process_cs CURSOR FOR apmp480_process_pr
   FOREACH apmp480_process_cs INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF   
      #抓取採購單單別
      CALL apmp480_get_doc(g_site,'','3',l_tmp.pmdbdocno,'apmt500','') RETURNING l_success,l_tmp.slip
      IF l_success = FALSE THEN    #抓不到采购单单别的资料将排除掉
         DELETE FROM apmp480_tmp
          WHERE pmdbdocno = l_tmp.pmdbdocno
            AND pmdbseq = l_tmp.pmdbseq
         CONTINUE FOREACH
      ELSE
         #[T.料件據點進銷存檔].[C.廠商選擇方式]="3.人工選擇" OR 未設定，則該筆請購資料不處理
         LET l_imaf152 = ''
         SELECT imaf152 INTO l_imaf152
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_tmp.pmdb004
         IF l_imaf152 = '3' OR l_imaf152 IS NULL THEN
            DELETE FROM apmp480_tmp
             WHERE pmdbdocno = l_tmp.pmdbdocno
               AND pmdbseq = l_tmp.pmdbseq
            CONTINUE FOREACH            
         END IF
         UPDATE apmp480_tmp
            SET slip = l_tmp.slip
          WHERE pmdbdocno = l_tmp.pmdbdocno
            AND pmdbseq = l_tmp.pmdbseq  
      END IF 
   END FOREACH
     
   #分配汇总方式
   #1.依料件进行汇总
   #2.依料件+需求日期进行汇总
   #INSERT到apmp480_1_tmp中
   IF g_master.a = '1' THEN 
      LET ls_sql = " SELECT '','',slip,'',pmdb004, ",
                   "        pmdb005,pmdb007,SUM(pmdb006),pmdb011,SUM(pmdb010), ",
                   "        MIN(pmdb030),",
                   #160801-00004#2---s
                   "        CASE WHEN pmdb038 IS NULL THEN '' ELSE pmdb038 END , ",
                   "        CASE WHEN pmdb039 IS NULL THEN '' ELSE pmdb039 END , ",
                   "        CASE WHEN pmdb054 IS NULL THEN '' ELSE pmdb054 END , ",
                   #160801-00004#2---e
                   "        pmdb050,SUM(qty),SUM(applied_qty) ",
                   " FROM apmp480_tmp ",
                   " GROUP BY slip,pmdb004,pmdb005,pmdb007,pmdb011,",
                   #160801-00004#2---s
                   "        CASE WHEN pmdb038 IS NULL THEN '' ELSE pmdb038 END , ",
                   "        CASE WHEN pmdb039 IS NULL THEN '' ELSE pmdb039 END , ",
                   "        CASE WHEN pmdb054 IS NULL THEN '' ELSE pmdb054 END , ",
                   #160801-00004#2---e
                   "pmdb050"
   ELSE
      LET ls_sql = " SELECT '','',slip,'',pmdb004, ",
                   "        pmdb005,pmdb007,SUM(pmdb006),pmdb011,SUM(pmdb010), ",
                   "        pmdb030,",
                   #160801-00004#2---s
                   "        CASE WHEN pmdb038 IS NULL THEN '' ELSE pmdb038 END , ",
                   "        CASE WHEN pmdb039 IS NULL THEN '' ELSE pmdb039 END , ",
                   "        CASE WHEN pmdb054 IS NULL THEN '' ELSE pmdb054 END , ",
                   #160801-00004#2---e
                   "        pmdb050,SUM(qty),SUM(applied_qty) ",
                   " FROM apmp480_tmp ",
                   " GROUP BY slip,pmdb004,pmdb005,pmdb007,pmdb011,pmdb030,",
                   #160801-00004#2---s
                   "        CASE WHEN pmdb038 IS NULL THEN '' ELSE pmdb038 END , ",
                   "        CASE WHEN pmdb039 IS NULL THEN '' ELSE pmdb039 END , ",
                   "        CASE WHEN pmdb054 IS NULL THEN '' ELSE pmdb054 END , ",
                   #160801-00004#2---e
                   "          pmdb050"   
   END IF
   LET ls_sql = " INSERT INTO apmp480_1_tmp ",ls_sql
   PREPARE apmp480_process_pr1 FROM ls_sql
   EXECUTE apmp480_process_pr1
   
   #根据[T.料件據點進銷存檔].[C.廠商選擇方式(imaf152)]設定進行对每一笔请购单单身做分配
   #0.主要供應商，無限量
   #1.依廠商分配
   #2.主要供應商分配優先，餘量分配
   LET ls_sql = " SELECT DISTINCT * FROM apmp480_1_tmp "  
   PREPARE apmp480_process_pr2 FROM ls_sql
   DECLARE apmp480_process_cs2 CURSOR FOR apmp480_process_pr2
   FOREACH apmp480_process_cs2 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF   
      #160802-00014#1---add---s
      IF NOT cl_null(l_tmp.pmdb015) THEN
         INSERT INTO apmp480_new_tmp VALUES(l_tmp.*)
      ELSE
      #160802-00014#1---add---e      
         LET l_imaf152 = ''
         SELECT imaf152 INTO l_imaf152
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_tmp.pmdb004
         CASE l_imaf152
            WHEN '0'
               CALL apmp480_allot_0(l_tmp.*)
            WHEN '1'
               CALL apmp480_allot_1(l_tmp.*)
            WHEN '2'
               CALL apmp480_allot_2(l_tmp.*)
         END CASE
      END IF   #160802-00014#1
   END FOREACH
   
   IF g_bgjob <> "Y" THEN
      LET li_count = 0
      LET ls_sql = " SELECT COUNT(*) FROM (SELECT DISTINCT slip,pmdb015 FROM apmp480_new_tmp)"
      PREPARE apmp480_process_count FROM ls_sql
      EXECUTE apmp480_process_count INTO li_count
      CALL cl_progress_bar_no_window(li_count)      
   END IF 
   
   #产生采购单以采购单号+供应商做汇总单头
   LET ls_sql = " SELECT DISTINCT slip,pmdb015 FROM apmp480_new_tmp "  
   PREPARE apmp480_process_pr3 FROM ls_sql
   DECLARE apmp480_process_cs3 CURSOR WITH HOLD FOR apmp480_process_pr3
   FOREACH apmp480_process_cs3 INTO l_slip,l_pmdb015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      ##畫面顯示處理進度
      IF g_bgjob <> "Y" THEN
         LET ls_value = l_pmdb015
         CALL cl_progress_no_window_ing(ls_value)
      END IF
      
      CALL s_transaction_begin()
      
      #採購單頭檔
      CALL apmp480_ins_pmdl(l_slip,l_pmdb015) RETURNING l_pmdldocno

      #採購單身明細檔
      CALL apmp480_ins_pmdn(l_slip,l_pmdldocno)
      
      #採購多帳期預付款檔
      #CALL apmp480_ins_pmdm(l_pmdldocno) 
      IF g_success = 'Y' THEN 
         #更新回寫單頭的採購總未稅金額、採購總含稅金額、總稅額 
         LET l_pmdl040 = 0
         LET l_pmdl041 = 0
         LET l_pmdl042 = 0
         SELECT SUM(pmdn046),SUM(pmdn047),SUM(pmdn048)
           INTO l_pmdl040,l_pmdl041,l_pmdl042
           FROM pmdn_t
          WHERE pmdnent   = g_enterprise
            AND pmdnsite  = g_site
            AND pmdndocno = l_pmdldocno
         IF cl_null(l_pmdl040) THEN LET l_pmdl040 = 0 END IF
         IF cl_null(l_pmdl041) THEN LET l_pmdl041 = 0 END IF
         IF cl_null(l_pmdl042) THEN LET l_pmdl042 = 0 END IF
         UPDATE pmdl_t SET pmdl040 = l_pmdl040,
                           pmdl041 = l_pmdl041,
                           pmdl042 = l_pmdl042
          WHERE pmdlent   = g_enterprise
            AND pmdlsite  = g_site
            AND pmdldocno = l_pmdldocno
       
       
      END IF
      #自動確認
      IF g_master.c = 'Y' THEN
         CALL s_apmt500_conf_chk(l_pmdldocno) RETURNING l_success
         IF l_success THEN
            CALL s_apmt500_conf_upd(l_pmdldocno) RETURNING l_success
         END IF 

         IF NOT l_success THEN
            LET g_success = 'N'
         END IF
      END IF    
      
      IF g_success = 'Y' THEN 
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')      
      END IF
   END FOREACH 
   CALL apmp480_drop_tmp()   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #151215-00014#1   2015/12/17   By earl  add s
      CALL cl_err_collect_show() 
      #151215-00014#1   2015/12/17   By earl  add e
      
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #151215-00014#1   2015/12/17   By earl  add s
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()   
      #151215-00014#1   2015/12/17   By earl  add e
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apmp480_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp480.get_buffer" >}
PRIVATE FUNCTION apmp480_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.b = p_dialog.getFieldBuffer('b')
   LET g_master.c = p_dialog.getFieldBuffer('c')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmp480.msgcentre_notify" >}
PRIVATE FUNCTION apmp480_msgcentre_notify()
 
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
 
{<section id="apmp480.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apmp480_create_tmp()
   
   #請購單資料
   CREATE TEMP TABLE apmp480_tmp(
         pmdbdocno      VARCHAR(20),           #請購單單據編號
         pmdbseq        VARCHAR(20),           #項次
         slip           VARCHAR(5),             #請購單單別對應採購單單別
         pmdb015        VARCHAR(10),             #供應商編號 
         pmdb004        VARCHAR(40),             #料號
         pmdb005        VARCHAR(256),             #產品特徵  
         pmdb007        VARCHAR(10),             #單位
         pmdb006        DECIMAL(20,6),             #需求數量
         pmdb011        VARCHAR(10),             #计价单位         
         pmdb010        DECIMAL(20,6),             #计价數量
         pmdb030        DATE,             #需求日期
         #160801-00004#2--s
         pmdb038        VARCHAR(10),             #收货库位       
         pmdb039        VARCHAR(10),             #收货储位
         pmdb054        VARCHAR(30),             #库存管理特征
         #160801-00004#2--e
         pmdb050        VARCHAR(255),             #備註         
         qty            DECIMAL(20,6),             #未轉採購量     
         applied_qty    DECIMAL(20,6))             #已分配數量
         
   CREATE TEMP TABLE apmp480_1_tmp(
         pmdbdocno      VARCHAR(20),           #請購單單據編號
         pmdbseq        VARCHAR(20),           #項次
         slip           VARCHAR(5),             #請購單單別對應採購單單別
         pmdb015        VARCHAR(10),             #供應商編號 
         pmdb004        VARCHAR(40),             #料號
         pmdb005        VARCHAR(256),             #產品特徵  
         pmdb007        VARCHAR(10),             #單位
         pmdb006        DECIMAL(20,6),             #需求數量
         pmdb011        VARCHAR(10),             #计价单位         
         pmdb010        DECIMAL(20,6),             #计价數量
         pmdb030        DATE,             #需求日期
         #160801-00004#2--s
         pmdb038        VARCHAR(10),             #收货库位       
         pmdb039        VARCHAR(10),             #收货储位
         pmdb054        VARCHAR(30),             #库存管理特征
         #160801-00004#2--e
         pmdb050        VARCHAR(255),             #備註         
         qty            DECIMAL(20,6),             #未轉採購量     
         applied_qty    DECIMAL(20,6))             #已分配數量
         
   CREATE TEMP TABLE apmp480_new_tmp(
         pmdbdocno      VARCHAR(20),           #請購單單據編號
         pmdbseq        VARCHAR(20),           #項次
         slip           VARCHAR(5),             #請購單單別對應採購單單別
         pmdb015        VARCHAR(10),             #供應商編號 
         pmdb004        VARCHAR(40),             #料號
         pmdb005        VARCHAR(256),             #產品特徵  
         pmdb007        VARCHAR(10),             #單位
         pmdb006        DECIMAL(20,6),             #需求數量
         pmdb011        VARCHAR(10),             #计价单位         
         pmdb010        DECIMAL(20,6),             #计价數量
         pmdb030        DATE,             #需求日期
         #160801-00004#2--s
         pmdb038        VARCHAR(10),             #收货库位       
         pmdb039        VARCHAR(10),             #收货储位
         pmdb054        VARCHAR(30),             #库存管理特征
         #160801-00004#2--e
         pmdb050        VARCHAR(255),             #備註         
         qty            DECIMAL(20,6),             #未轉採購量     
         applied_qty    DECIMAL(20,6))             #已分配數量
  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp480_drop_tmp()
   
   WHENEVER ERROR CONTINUE 
   
   DROP TABLE apmp480_tmp;
   DROP TABLE apmp480_1_tmp; 
   DROP TABLE apmp480_new_tmp;  
END FUNCTION

################################################################################
#0.主要供應商，無限量
################################################################################
PRIVATE FUNCTION apmp480_allot_0(p_tmp)
DEFINE p_tmp  type_tmp
   
   WHENEVER ERROR CONTINUE 
   
   IF cl_null(p_tmp.pmdb015) THEN
      SELECT imaf153 INTO p_tmp.pmdb015
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = p_tmp.pmdb004
   END IF 
   IF NOT cl_null(p_tmp.pmdb015) THEN
      INSERT INTO apmp480_new_tmp VALUES(p_tmp.*)
   END IF
END FUNCTION

################################################################################
#1.依廠商分配
################################################################################
PRIVATE FUNCTION apmp480_allot_1(p_tmp)
DEFINE p_tmp  type_tmp
DEFINE l_tmp  type_tmp
DEFINE l_ac1            LIKE type_t.num5
DEFINE l_pmao008_sum    LIKE pmao_t.pmao008
DEFINE l_pmao008        LIKE pmao_t.pmao008
DEFINE l_sql            STRING
DEFINE l_pmao001        LIKE pmao_t.pmao001 
DEFINE l_success        LIKE type_t.num5
DEFINE l_rate           LIKE inaj_t.inaj014
DEFINE l_cnt            LIKE type_t.num10
DEFINE l_pmdb006        LIKE pmdb_t.pmdb006
DEFINE l_pmdb010        LIKE pmdb_t.pmdb010

   WHENEVER ERROR CONTINUE 

   #pmao008:分配比率 
   #先算出此料的總比率 
   LET l_pmao008_sum = 0
   #160819-00043#5--s
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = p_tmp.pmdb004                    #料件編號  
   #   AND NVL(pmao003,' ') = NVL(p_tmp.pmdb005,' ')  #產品特徵 
   #   AND pmaostus = 'Y'
   
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent = g_enterprise
      AND pmatsite = g_site
      AND pmat002 = p_tmp.pmdb004                #料件編號  
      AND NVL(pmat003,' ') = NVL(p_tmp.pmdb005,' ')  #產品特徵 
      AND pmatstus = 'Y'
   #160819-00043#5---e
   
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   #l_pamo008_sum有沒有可能真的會是0 是0的話應該要算錯   
   IF l_pmao008_sum = 0 THEN 
      #分配比率總合不可為0   
      RETURN 
   END IF 

   #再看供應商可分配多少比率 
   #160819-00043#5--s
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_tmp.pmdb004,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_tmp.pmdb005,"',' ') "
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_tmp.pmdb004,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_tmp.pmdb005,"',' ') " ,
               "   AND pmatstus = 'Y'  "
   #160819-00043#5--e
   PREPARE apmp480_allot_1_prep FROM l_sql
   DECLARE apmp480_allot_1_curs CURSOR FOR apmp480_allot_1_prep
   
   #160819-00043#5--s
   #LET l_sql = "SELECT COUNT(*)",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_tmp.pmdb004,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_tmp.pmdb005,"',' ') "    
   LET l_sql = "SELECT COUNT(*)",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_tmp.pmdb004,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_tmp.pmdb005,"',' ') " ,
               "   AND pmatstus = 'Y'  "
   #160819-00043#5--e
   PREPARE apmp480_allot_1_cnt_p FROM l_sql
   EXECUTE apmp480_allot_1_cnt_p INTO l_cnt
   
   LET l_ac1 = 1
   LET l_pmdb006 = p_tmp.pmdb006
   LET l_pmdb010 = p_tmp.pmdb010
   FOREACH apmp480_allot_1_curs INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_tmp.* = p_tmp.*
      
      IF l_ac1 = l_cnt THEN 
         LET l_tmp.pmdb015 = l_pmao001 
         LET l_tmp.pmdb006 = l_pmdb006 
         LET l_tmp.pmdb010 = l_pmdb010      
      ELSE
         LET l_tmp.pmdb015 = l_pmao001 
         LET l_tmp.pmdb006 = p_tmp.pmdb006 * l_pmao008 / l_pmao008_sum 
         LET l_tmp.pmdb010 = p_tmp.pmdb010 * l_pmao008 / l_pmao008_sum
         CALL apmp490_03_unit_round(l_tmp.pmdb007,l_tmp.pmdb006)
                    RETURNING l_tmp.pmdb006
         CALL apmp490_03_unit_round(l_tmp.pmdb011,l_tmp.pmdb010)
                    RETURNING l_tmp.pmdb010                    
         LET l_pmdb006 = l_pmdb006 - l_tmp.pmdb006
         LET l_pmdb010 = l_pmdb010 - l_tmp.pmdb010         
      END IF    
#      #參考單位與數量 
#      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
#         SELECT imaf015 INTO l_pmdn_d.pmdn008_02_01
#           FROM imaf_t
#          WHERE imafent  = g_enterprise
#            AND imafsite = g_site
#            AND imaf001  = l_pmdn_d.pmdb004_02_01
#         IF (NOT cl_null(l_pmdn_d.pmdn008_02_01)) AND
#            (NOT cl_null(l_pmdn_d.pmdn001_02_01)) AND
#            (NOT cl_null(l_pmdn_d.pmdn006_02_01)) THEN
#            CALL apmp490_02_convert_qty(l_pmdn_d.pmdn001_02_01,l_pmdn_d.pmdn006_02_01,
#                                        l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn007_02_01)
#                 RETURNING l_pmdn_d.pmdn009_02_01
#            IF NOT cl_null(l_pmdn_d.pmdn009_02_01) THEN
#               CALL apmp490_02_unit_round(l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn009_02_01)
#                    RETURNING l_pmdn_d.pmdn009_02_01
#            END IF
#         END IF
#      END IF
      
#      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
#         #取料件的預設採購計價單位 
#         SELECT imaf144 INTO l_pmdn_d.pmdn010_02_01
#           FROM imaf_t
#          WHERE imafent  = g_enterprise
#            AND imafsite = g_site
#            AND imaf001  = l_pmdn_d.pmdb004_02_01
#
#         IF cl_null(l_pmdn_d.pmdn010_02_01) THEN
#            LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
#         END IF
#
#         CALL apmp490_02_convert_qty(l_pmdn_d.pmdb004_02_01,l_pmdn_d.pmdn006_02_01,
#                                     l_pmdn_d.pmdn010_02_01,l_pmdn_d.pmdn007_02_01)
#              RETURNING l_pmdn_d.pmdn011_02_01
#      ELSE
#         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
#         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
#         LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
#         LET l_pmdn_d.pmdn011_02_01 = l_pmdn_d.pmdn007_02_01
#      END IF

#           RETURNING l_success
      INSERT INTO apmp480_new_tmp VALUES(l_tmp.*) 
      LET l_ac1 = l_ac1 + 1      
   END FOREACH
END FUNCTION

################################################################################
#2.主要供應商分配優先，餘量分配
################################################################################
PRIVATE FUNCTION apmp480_allot_2(p_tmp)
DEFINE p_tmp  type_tmp
DEFINE l_tmp  type_tmp
DEFINE l_max_qty        LIKE imaf_t.imaf154
DEFINE l_imaf153        LIKE imaf_t.imaf153
DEFINE l_imaf154        LIKE imaf_t.imaf154
DEFINE l_pmao008_sum    LIKE pmao_t.pmao008
DEFINE l_pmao008        LIKE pmao_t.pmao008
DEFINE l_pmao001        LIKE pmao_t.pmao001
DEFINE l_sql            STRING 
DEFINE l_rate           LIKE inaj_t.inaj014
DEFINE l_success        LIKE type_t.num5
DEFINE l_cnt            LIKE type_t.num10
DEFINE l_pmdb006        LIKE pmdb_t.pmdb006
DEFINE l_pmdb010        LIKE pmdb_t.pmdb010
DEFINE l_ac1            LIKE type_t.num5

   WHENEVER ERROR CONTINUE 

   #l_max_qty:主要供應商可分配數量的最大限度 
   #imaf153  :主要供應商 
   #imaf154  :主供應商分配限量 
   LET l_max_qty = 0
   SELECT imaf153,imaf154 INTO l_imaf153,l_imaf154
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_tmp.pmdb004
   
   
   LET l_max_qty = l_imaf154


   LET l_ac = l_ac + 1
   LET l_tmp.* = p_tmp.* 
   
   IF NOT cl_null(l_tmp.pmdb015) THEN
      LET l_imaf153 = l_tmp.pmdb015
   END IF 
   
   #第一筆資料的供應商應該是料件的主要供應商 
   LET l_tmp.pmdb015 = l_imaf153
   
   #如果採購數量是200 分配限量是120 則把採購數量修改為120 
   #否則則不改變 
   IF l_tmp.pmdb006 > l_max_qty THEN
      LET l_tmp.pmdb006 = l_max_qty
      LET p_tmp.pmdb006 = p_tmp.pmdb006 - l_max_qty
   END IF 
   
#   #重新計算參考單位與數量 
#   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
#      SELECT imaf015 INTO l_pmdn_d.pmdn008_02_01
#        FROM imaf_t
#       WHERE imafent  = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = l_pmdn_d.pmdb004_02_01
#      IF (NOT cl_null(l_pmdn_d.pmdn008_02_01)) AND
#         (NOT cl_null(l_pmdn_d.pmdn001_02_01)) AND
#         (NOT cl_null(l_pmdn_d.pmdn006_02_01)) THEN
#         CALL apmp490_02_convert_qty(l_pmdn_d.pmdn001_02_01,l_pmdn_d.pmdn006_02_01,
#                                     l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn007_02_01)
#              RETURNING l_pmdn_d.pmdn009_02_01
#         IF NOT cl_null(l_pmdn_d.pmdn009_02_01) THEN
#            CALL apmp490_02_unit_round(l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn009_02_01)
#                 RETURNING l_pmdn_d.pmdn009_02_01
#         END IF
#      END IF
#   END IF
   
   #需要重新計算計價數量 
   #如果aoos020中，設定使用採購計價單位 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
#      #取料件的預設採購計價單位 
#      SELECT imaf144 INTO l_pmdn_d.pmdn010_02_01
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = l_pmdn_d.pmdb004_02_01
#
#      IF cl_null(l_pmdn_d.pmdn010_02_01) THEN
#         LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
#      END IF

      CALL apmp490_02_convert_qty(l_tmp.pmdb004,l_tmp.pmdb007,
                                  l_tmp.pmdb011,l_tmp.pmdb006)
           RETURNING l_tmp.pmdb010
   ELSE
      #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
      #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
      LET l_tmp.pmdb010 = l_tmp.pmdb006
      LET l_tmp.pmdb011 = l_tmp.pmdb007
   END IF 
   LET p_tmp.pmdb010 = p_tmp.pmdb010 - l_tmp.pmdb010

   INSERT INTO apmp480_new_tmp VALUES(l_tmp.*)


   IF p_tmp.pmdb006 <= 0 THEN 
      RETURN
   END IF
   LET l_pmao008_sum = 0
   #160819-00043#5--s
   #SELECT SUM(pmao008) INTO l_pmao008_sum
   #  FROM pmao_t
   # WHERE pmaoent = g_enterprise
   #   AND pmao002 = p_tmp.pmdb004
   #   AND NVL(pmao003,' ') = NVL(p_tmp.pmdb005,' ')
   #   AND pmao001 <> l_imaf153
   #   AND pmaostus = 'Y'
   
   SELECT SUM(pmat004) INTO l_pmao008_sum
     FROM pmat_t
    WHERE pmatent = g_enterprise
      AND pmatsite = g_site
      AND pmat002 = p_tmp.pmdb004                #料件編號  
      AND NVL(pmat003,' ') = NVL(p_tmp.pmdb005,' ')  #產品特徵 
      AND pmat001 <> l_imaf153
      AND pmatstus = 'Y'
   #160819-00043#5---e
   IF cl_null(l_pmao008_sum) THEN
      LET l_pmao008_sum = 0
   END IF

   #l_pamo008_sum有沒有可能真的會是0 是0的話應該要算錯? 
   IF l_pmao008_sum = 0 THEN  
      #分配比率總合不可為0     
      RETURN 
   END IF 

   #160819-00043#5--s
   #LET l_sql = "SELECT pmao001,pmao008 ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_tmp.pmdb004,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_tmp.pmdb005,"',' ') ",
   #            "   AND pmao001 <> '",l_imaf153,"' "
   LET l_sql = "SELECT pmat001,pmat004 ",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_tmp.pmdb004,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_tmp.pmdb005,"',' ') " ,
               "   AND pmat001 <> '",l_imaf153,"' ",
               "   AND pmatstus = 'Y'  "
   #160819-00043#5--e
   PREPARE apmp480_allot_2_prep FROM l_sql
   DECLARE apmp480_allot_2_curs CURSOR FOR apmp480_allot_2_prep 

   #160819-00043#5--s
   #LET l_sql = "SELECT COUNT(*) ",
   #            "  FROM pmao_t ",
   #            " WHERE pmaoent = '",g_enterprise,"' ",
   #            "   AND pmao002 = '",p_tmp.pmdb004,"' ",
   #            "   AND NVL(pmao003,' ') = NVL('",p_tmp.pmdb005,"',' ') ",
   #            "   AND pmao001 <> '",l_imaf153,"' "
   
   LET l_sql = "SELECT COUNT(*)",
               "  FROM pmat_t ",
               " WHERE pmatent = '",g_enterprise,"' ",
               "   AND pmatsite = '",g_site,"' ",
               "   AND pmat002 = '",p_tmp.pmdb004,"' ",
               "   AND NVL(pmat003,' ') = NVL('",p_tmp.pmdb005,"',' ') " ,
               "   AND pmat001 <> '",l_imaf153,"' ",
               "   AND pmatstus = 'Y'  "
   #160819-00043#5--e            
   PREPARE apmp480_allot_2_cnt_prep FROM l_sql
   EXECUTE apmp480_allot_2_cnt_prep INTO l_cnt
   LET l_ac1 = 1
   LET l_pmdb006 = p_tmp.pmdb006 
   LET l_pmdb010 = p_tmp.pmdb010    
   FOREACH apmp480_allot_2_curs INTO l_pmao001,l_pmao008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_tmp.* = p_tmp.*
      LET l_tmp.pmdb015 = l_pmao001 
      
      IF l_ac1 = l_cnt THEN  
         LET l_tmp.pmdb006 = l_pmdb006 
         LET l_tmp.pmdb010 = l_pmdb010      
      ELSE 
         LET l_tmp.pmdb006 = p_tmp.pmdb006 * l_pmao008 / l_pmao008_sum  
         LET l_tmp.pmdb010 = p_tmp.pmdb010 * l_pmao008 / l_pmao008_sum
         CALL apmp490_03_unit_round(l_tmp.pmdb007,l_tmp.pmdb006)
                    RETURNING l_tmp.pmdb006
         CALL apmp490_03_unit_round(l_tmp.pmdb011,l_tmp.pmdb010)
                    RETURNING l_tmp.pmdb010          
         LET l_pmdb006 = l_pmdb006 - l_tmp.pmdb006
         LET l_pmdb010 = l_pmdb010 - l_tmp.pmdb010           
      END IF
#      #重新計算參考單位與數量 
#      IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
#         SELECT imaf015 INTO l_pmdn_d.pmdn008_02_01
#           FROM imaf_t
#          WHERE imafent  = g_enterprise
#            AND imafsite = g_site
#            AND imaf001  = l_pmdn_d.pmdb004_02_01
#         IF (NOT cl_null(l_pmdn_d.pmdn008_02_01)) AND
#            (NOT cl_null(l_pmdn_d.pmdn001_02_01)) AND
#            (NOT cl_null(l_pmdn_d.pmdn006_02_01)) THEN
#            CALL apmp490_02_convert_qty(l_pmdn_d.pmdn001_02_01,l_pmdn_d.pmdn006_02_01,
#                                        l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn007_02_01)
#                 RETURNING l_pmdn_d.pmdn009_02_01
#            IF NOT cl_null(l_pmdn_d.pmdn009_02_01) THEN
#               CALL apmp490_02_unit_round(l_pmdn_d.pmdn008_02_01,l_pmdn_d.pmdn009_02_01)
#                    RETURNING l_pmdn_d.pmdn009_02_01
#            END IF
#         END IF
#      END IF
#      
#      #需要重新計算計價數量 
#      #如果aoos020中，設定使用採購計價單位 
#      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
#         #取料件的預設採購計價單位 
#         SELECT imaf144 INTO l_pmdn_d.pmdn010_02_01
#           FROM imaf_t
#          WHERE imafent = g_enterprise
#            AND imafsite = g_site
#            AND imaf001 = l_pmdn_d.pmdb004_02_01
#
#         IF cl_null(l_pmdn_d.pmdn010_02_01) THEN
#            LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
#         END IF
#
#         CALL apmp490_02_convert_qty(l_pmdn_d.pmdb004_02_01,l_pmdn_d.pmdn006_02_01,
#                                     l_pmdn_d.pmdn010_02_01,l_pmdn_d.pmdn007_02_01)
#              RETURNING l_pmdn_d.pmdn011_02_01
#      ELSE
#         #[C:計價單位] = 採購料號主檔的預設採購計價單位，若不使用採購計價單位時則此欄位=採購單位
#         #[C:計價數量] = 採購數量*(採購單位與計價單位換算率)，若不使用採購計價單位時則此欄位=採購數量
#         LET l_pmdn_d.pmdn010_02_01 = l_pmdn_d.pmdn006_02_01
#         LET l_pmdn_d.pmdn011_02_01 = l_pmdn_d.pmdn007_02_01
#      END IF
#


      INSERT INTO apmp480_new_tmp VALUES(l_tmp.*)
      LET l_ac1 = l_ac1 + 1
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 产生采购单单头资料
# Memo...........:
# Usage..........: CALL apmp480_ins_pmdl(p_pmdldocno,l_pmdl004)
#                  RETURNING r_pmdldocno
# Input parameter: p_pmdldocno   采购单单别
#                : p_pmdl004     供应商编号
# Return code....: r_pmdldocno   采购单单据编号
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp480_ins_pmdl(p_pmdldocno,p_pmdl004)
DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
DEFINE p_pmdl004    LIKE pmdl_t.pmdl004
DEFINE l_sql        STRING
DEFINE l_pmdl_tmp   type_g_pmdl_d_03
#161124-00048#8 mod-S
#DEFINE l_pmdl       RECORD LIKE pmdl_t.*
DEFINE l_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
#161124-00048#8 mod-E
DEFINE l_desc       LIKE type_t.chr80
DEFINE l_ooef019    LIKE ooef_t.ooef019
DEFINE l_oofa001    LIKE oofa_t.oofa001
DEFINE l_pmaa004    LIKE pmaa_t.pmaa004
DEFINE l_success    LIKE type_t.num5
DEFINE l_keyno      LIKE type_t.num10
DEFINE l_errno      LIKE type_t.chr10          #錯誤訊息代碼 
DEFINE l_ooef016    LIKE ooef_t.ooef016
DEFINE l_pmal002    LIKE pmal_t.pmal002        #控制組編號  
DEFINE l_pmdl028    LIKE pmdl_t.pmdl028        #一次性交易識別碼 
DEFINE l_str        STRING  
DEFINE l_argv1      LIKE type_t.chr10 
DEFINE l_controlno  LIKE pmal_t.pmal002
DEFINE l_pmaa086    LIKE pmaa_t.pmaa086
DEFINE l_pmaa087    LIKE pmaa_t.pmaa087

   WHENEVER ERROR CONTINUE 


   INITIALIZE l_pmdl.* TO NULL
   LET g_result_str = ''
   LET g_success = 'Y'
   
   LET l_oofa001 = ''                             #聯絡對象識別碼  
   SELECT oofa001 INTO l_oofa001
     FROM oofa_t
    WHERE oofaent = g_enterprise
      AND oofa002 = '1'
      AND oofa003 = g_site 

   #獲得當前營運據點的所屬稅區
   LET l_ooef019 = ''
   SELECT ooef019 INTO l_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   #一般欄位給值  
   LET l_pmdl.pmdl001 = "0"
   LET l_pmdl.pmdl002 = g_user      #採購人員 
   LET l_pmdl.pmdl003 = g_dept      #採購部門
   LET l_pmdl.pmdl004 = p_pmdl004   #供應商編號   
   LET l_pmdl.pmdlstus = "N"
   LET l_pmdl.pmdl005 = "1"
   LET l_pmdl.pmdl006 = "1"
   LET l_pmdl.pmdl007 = "2"         #來源一定是請購單  
   LET l_pmdl.pmdl013 = "N"
   LET l_pmdl.pmdl019 = "Y"
   LET l_pmdl.pmdl030 = "N"
   LET l_pmdl.pmdl040 = "0" 
   LET l_pmdl.pmdl041 = "0"
   LET l_pmdl.pmdl042 = "0"
   LET l_pmdl.pmdl047 = "N"
   LET l_pmdl.pmdl048 = "N"
   LET l_pmdl.pmdl049 = "N"
   LET l_pmdl.pmdl046 = "1"
    
   LET l_pmdl.pmdlsite  = g_site
   LET l_pmdl.pmdldocdt = g_today 
   LET l_pmdl.pmdldocno = p_pmdldocno     #单别
   #公用欄位給值 
   LET l_pmdl.pmdlownid = g_user
   LET l_pmdl.pmdlowndp = g_dept
   LET l_pmdl.pmdlcrtid = g_user
   LET l_pmdl.pmdlcrtdp = g_dept
   LET l_pmdl.pmdlcrtdt = cl_get_current()
   LET l_pmdl.pmdlmodid = g_user
   LET l_pmdl.pmdlmoddt = cl_get_current()
   
   #獲取當前營運據點的出貨地址、帳款地址
   CALL apmp480_get_oofb019(g_site,'3') RETURNING l_pmdl.pmdl025
   CALL apmp480_get_oofb019(g_site,'5') RETURNING l_pmdl.pmdl026


   
   #抓取交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象顯示在採購單上的
   #[C:帳款供應商]，若有設置多筆收/付款交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"1:收/付款對象"的交易對象時，則[C:帳款供應商]預設採購供應商
   LET l_pmdl.pmdl021 = ''
   SELECT pmac002 INTO l_pmdl.pmdl021
     FROM pmac_t
    WHERE pmacent  = g_enterprise
      AND pmac001  = l_pmdl.pmdl004
      AND pmac003  = '1'
      AND pmacstus = 'Y'
      AND pmac004  = 'Y'
   IF cl_null(l_pmdl.pmdl021) THEN
      SELECT pmac002 INTO l_pmdl.pmdl021
        FROM pmac_t
       WHERE pmacent  = g_enterprise
         AND pmac001  = l_pmdl.pmdl004
         AND pmac003  = '1'
         AND pmacstus = 'Y'
         AND rownum  = 1
      IF cl_null(l_pmdl.pmdl021) THEN
         LET l_pmdl.pmdl021 = l_pmdl.pmdl004
      END IF
   END IF

   #抓取交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象顯示在採購單上的[C:送貨供應商]，
   #若有設置多筆出貨交易對象時，則取有勾選主要的交易對象那一個，
   #若沒有設交易對象夥伴關係檔且交易類型為"2:出貨對象"的交易對象時，則[C:送貨供應商]預設採購供應商
   LET l_pmdl.pmdl022 = ''
   SELECT pmac002 INTO l_pmdl.pmdl022
     FROM pmac_t
    WHERE pmacent  = g_enterprise
      AND pmac001  = l_pmdl.pmdl004
      AND pmac003  = '2'
      AND pmacstus = 'Y'
      AND pmac004  = 'Y'
   IF cl_null(l_pmdl.pmdl022) THEN
      SELECT pmac002 INTO l_pmdl.pmdl022
        FROM pmac_t
       WHERE pmacent  = g_enterprise
         AND pmac001  = l_pmdl.pmdl004
         AND pmac003  = '2'
         AND pmacstus = 'Y'
         AND rownum  = 1
      IF cl_null(l_pmdl.pmdl022) THEN
         LET l_pmdl.pmdl022 = l_pmdl.pmdl004
      END IF
   END IF

   #抓取交易對象聯絡人明細檔的聯絡對像識別碼顯示在採購單上的[C:供應商連絡人]，
   #若有設置多個聯絡人時，則取有勾選主要聯絡人的那一個
   LET l_pmdl.pmdl027 = ''
   SELECT pmaj002 INTO l_pmdl.pmdl027
     FROM pmaj_t
    WHERE pmajent  = g_enterprise
      AND pmaj001  = l_pmdl.pmdl004
      AND pmajstus = 'Y'
      AND pmaj004  = 'Y'
   IF cl_null(l_pmdl.pmdl027) THEN
      SELECT pmaj002 INTO l_pmdl.pmdl027
        FROM pmaj_t
       WHERE pmajent  = g_enterprise
         AND pmaj001  = l_pmdl.pmdl004
         AND pmajstus = 'Y'
         AND pmaj004  = 'Y'
         AND rownum   = 1
   END IF
   LET l_pmdl.pmdl023 = ''         #採購通路  
   LET l_pmdl.pmdl054 = ''         #內外購  
   LET l_pmdl.pmdl033 = ''         #發票類型  
   LET l_pmdl.pmdl055 = ''         #匯率計算基礎    
   
   #判斷供應商是否有設置採購控制組供應商預設條件(apmi110)，若有則抓取相關的預設條件
   CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
   IF l_success THEN
            #付款條件,交易條件,稅別,   幣別,  取價方式
            ##採購通路,內外購,發票類型,匯率計算基礎             
      SELECT pmal006,pmal020,pmal004,pmal003,pmal021,
             pmal008,pmal023,pmal022,pmal024,pmal009,pmal019,pmal025,pmal011
        INTO l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl015,l_pmdl.pmdl017,
             l_pmdl.pmdl023,l_pmdl.pmdl054,l_pmdl.pmdl033,l_pmdl.pmdl055,l_pmdl.pmdl024,
             l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl020
        FROM pmal_t
       WHERE pmalent = g_enterprise
         AND pmal001 = l_pmdl.pmdl004
         AND pmal002 = l_controlno         
   END IF
   IF NOT l_success OR SQLCA.sqlcode = 100 THEN 
      SELECT pmab037,pmab053,pmab034,pmab033,pmab054,
             pmab038,pmab057,pmab056,pmab058,pmab039,pmab031,pmab059,pmab040
        INTO l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011,l_pmdl.pmdl015,l_pmdl.pmdl017,
             l_pmdl.pmdl023,l_pmdl.pmdl054,l_pmdl.pmdl033,l_pmdl.pmdl055,l_pmdl.pmdl024,
             l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl020
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = g_site
         AND pmab001 = l_pmdl.pmdl004
   END IF
   
   IF cl_null(l_pmdl.pmdl002) OR cl_null(l_pmdl.pmdl003) THEN
      LET l_pmaa086 = ''
      LET l_pmaa087 = ''
      SELECT pmaa086,pmaa087 INTO l_pmaa086,l_pmaa087
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_pmdl_m.pmdl004
      IF cl_null(l_pmdl.pmdl002) THEN
         LET l_pmdl.pmdl002 = l_pmaa086
      END IF
      
      IF cl_null(l_pmdl.pmdl003) THEN
         LET l_pmdl.pmdl003 = l_pmaa087
      END IF
   END IF
   
   IF cl_null(l_pmdl.pmdl002) THEN
      LET l_pmdl.pmdl002 = g_user
   END IF
   
   IF cl_null(l_pmdl.pmdl003) THEN
      SELECT ooag003 INTO l_pmdl.pmdl003
        FROM ooag_t 
       WHERE ooagent = g_enterprise 
         AND ooag001 = l_pmdl.pmdl002
   END IF   
   #根据单别取得欄位預設值
   CALL apmp480_get_col_default(l_pmdl.*) RETURNING l_pmdl.*   
   #稅率,單價含稅否
   IF NOT cl_null(l_pmdl.pmdl011) THEN
      SELECT oodb006,oodb005 INTO l_pmdl.pmdl012,l_pmdl.pmdl013
        FROM oodb_t,ooef_t
       WHERE ooefent = oodbent
         AND ooef001 = g_site
         AND ooef019 = oodb001
         AND oodbent = g_enterprise
         AND oodb002 = l_pmdl.pmdl011
   END IF
   
   #取得匯率
   IF NOT cl_null(l_pmdl.pmdl015) THEN  
      SELECT ooef016 INTO l_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL s_aooi160_get_exrate('1',g_site,g_today,l_pmdl.pmdl015,l_ooef016,0,'11')
           RETURNING l_pmdl.pmdl016
   END IF
    
    
    
   #預設付款供應商與送貨供應商會與採購單供應商相同 
   #付款供應商   
   LET l_pmdl.pmdl021 = l_pmdl.pmdl004 
   #送貨供應商  
   LET l_pmdl.pmdl022 = l_pmdl.pmdl004

   
   CALL s_aooi200_gen_docno(g_site,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,'apmt500') RETURNING l_success,l_pmdl.pmdldocno
   IF l_success THEN
      INSERT INTO pmdl_t(pmdlent  ,pmdlsite ,pmdldocno,pmdldocdt,pmdl001  ,pmdl002,
                         pmdl003  ,pmdl004  ,pmdl005  ,pmdl006  ,pmdl007  ,pmdl008,
                         pmdl009  ,pmdl010  ,pmdl011  ,pmdl012  ,pmdl013  ,pmdl015,
                         pmdl016  ,pmdl017  ,pmdl018  ,pmdl019  ,pmdl020  ,pmdl021,
                         pmdl022  ,pmdl023  ,pmdl024  ,pmdl025  ,pmdl026  ,pmdl027,
                         pmdl028  ,pmdl029  ,pmdl030  ,pmdl031  ,pmdl032  ,pmdl033,
                         pmdl040  ,pmdl041  ,pmdl042  ,pmdl043  ,pmdl044  ,pmdl046,
                         pmdl047  ,pmdl048  ,pmdl049  ,pmdl050  ,pmdl051  ,pmdl052,
                         pmdl053  ,pmdl054  ,pmdl055  ,pmdlownid,pmdlowndp,pmdlcrtid,
                         pmdlcrtdp,pmdlcrtdt,pmdlmodid,pmdlmoddt,pmdlcnfid,pmdlcnfdt,
                         pmdlpstid,pmdlpstdt,pmdlstus)
                  VALUES(g_enterprise  ,g_site        ,l_pmdl.pmdldocno,l_pmdl.pmdldocdt,
                         l_pmdl.pmdl001,l_pmdl.pmdl002,l_pmdl.pmdl003  ,l_pmdl.pmdl004  ,
                         l_pmdl.pmdl005,l_pmdl.pmdl006,l_pmdl.pmdl007  ,l_pmdl.pmdl008  ,
                         l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl011  ,l_pmdl.pmdl012  ,
                         l_pmdl.pmdl013,l_pmdl.pmdl015,l_pmdl.pmdl016  ,l_pmdl.pmdl017  ,
                         l_pmdl.pmdl018,l_pmdl.pmdl019,l_pmdl.pmdl020  ,l_pmdl.pmdl021  ,
                         l_pmdl.pmdl022,l_pmdl.pmdl023,l_pmdl.pmdl024  ,l_pmdl.pmdl025  ,
                         l_pmdl.pmdl026,l_pmdl.pmdl027,l_pmdl.pmdl028  ,l_pmdl.pmdl029  ,
                         l_pmdl.pmdl030,l_pmdl.pmdl031,l_pmdl.pmdl032  ,l_pmdl.pmdl033  ,
                         l_pmdl.pmdl040,l_pmdl.pmdl041,l_pmdl.pmdl042  ,l_pmdl.pmdl043  ,
                         l_pmdl.pmdl044,l_pmdl.pmdl046,l_pmdl.pmdl047  ,l_pmdl.pmdl048  , 
                         l_pmdl.pmdl049,l_pmdl.pmdl050,l_pmdl.pmdl051  ,l_pmdl.pmdl052  ,
                         l_pmdl.pmdl053,l_pmdl.pmdl054,l_pmdl.pmdl055  ,l_pmdl.pmdlownid          ,
                         l_pmdl.pmdlowndp,l_pmdl.pmdlcrtid,l_pmdl.pmdlcrtdp ,l_pmdl.pmdlcrtdt     ,
                         l_pmdl.pmdlmodid,l_pmdl.pmdlmoddt,'','','','','N')
   END IF                         

    
   IF g_success = 'Y' THEN 
      LET g_result_str = cl_getmsg('apm-00538',g_lang)        #建立成功   
      
      #因為apmi004_01會破壞transaction，所以要移到最後再用update的 
      #若輸入供應商的法人類型為'2:一次性交易'或是'4:內部員工'時，則自動串apmi004_01
      #維護一次性交易對項基本資料，維護完基本資料後會回傳一個一次性交易對象識別碼，
      #將識別碼值預設給pmdl028欄位
      LET l_pmaa004 = ''
      SELECT pmaa004 INTO l_pmaa004
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = l_pmdl.pmdl004
      LET l_pmdl028 = ''
      IF l_pmaa004 = '2' THEN   #一次性交易對象
         CALL apmi004_01('1','',l_pmdl.pmdl004,l_pmdl.pmdldocno) RETURNING l_pmdl028
      END IF
      IF l_pmaa004 = '4' THEN   #內部員工
         CALL apmi004_01('2','',l_pmdl.pmdl004,l_pmdl.pmdldocno) RETURNING l_pmdl028
      END IF
    
      UPDATE pmdl_t SET pmdl028 = l_pmdl028
       WHERE pmdlent   = g_enterprise
         AND pmdlsite  = g_site
         AND pmdldocno = l_pmdl.pmdldocno 
   ELSE
      #因為執行失敗 所以不給予單號 
      LET l_pmdl.pmdldocno = '' 
      LET l_str = g_result_str
      LET g_result_str = l_str.subString(3,l_str.getLength())
   END IF
   RETURN l_pmdl.pmdldocno
END FUNCTION

################################################################################
#产生采购单身pmdn_t
################################################################################
PRIVATE FUNCTION apmp480_ins_pmdn(p_slip,p_pmdldocno)
DEFINE p_slip      LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
DEFINE l_sql       STRING
#161124-00048#8 mod-S
#DEFINE l_pmdl      RECORD LIKE pmdl_t.*
#DEFINE l_pmdn      RECORD LIKE pmdn_t.*
#DEFINE l_pmdp      RECORD LIKE pmdp_t.*
#DEFINE l_pmdq      RECORD LIKE pmdq_t.*
DEFINE l_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
       pmdnent LIKE pmdn_t.pmdnent, #企业编号
       pmdnsite LIKE pmdn_t.pmdnsite, #营运据点
       pmdnunit LIKE pmdn_t.pmdnunit, #应用组织
       pmdndocno LIKE pmdn_t.pmdndocno, #采购单号
       pmdnseq LIKE pmdn_t.pmdnseq, #项次
       pmdn001 LIKE pmdn_t.pmdn001, #料件编号
       pmdn002 LIKE pmdn_t.pmdn002, #产品特征
       pmdn003 LIKE pmdn_t.pmdn003, #包装容器
       pmdn004 LIKE pmdn_t.pmdn004, #作业编号
       pmdn005 LIKE pmdn_t.pmdn005, #作业序
       pmdn006 LIKE pmdn_t.pmdn006, #采购单位
       pmdn007 LIKE pmdn_t.pmdn007, #采购数量
       pmdn008 LIKE pmdn_t.pmdn008, #参考单位
       pmdn009 LIKE pmdn_t.pmdn009, #参考数量
       pmdn010 LIKE pmdn_t.pmdn010, #计价单位
       pmdn011 LIKE pmdn_t.pmdn011, #计价数量
       pmdn012 LIKE pmdn_t.pmdn012, #出货日期
       pmdn013 LIKE pmdn_t.pmdn013, #到厂日期
       pmdn014 LIKE pmdn_t.pmdn014, #到库日期
       pmdn015 LIKE pmdn_t.pmdn015, #单价
       pmdn016 LIKE pmdn_t.pmdn016, #税种
       pmdn017 LIKE pmdn_t.pmdn017, #税率
       pmdn019 LIKE pmdn_t.pmdn019, #子件特性
       pmdn020 LIKE pmdn_t.pmdn020, #紧急度
       pmdn021 LIKE pmdn_t.pmdn021, #保税
       pmdn022 LIKE pmdn_t.pmdn022, #部分交货
       pmdnorga LIKE pmdn_t.pmdnorga, #付款据点
       pmdn023 LIKE pmdn_t.pmdn023, #送货供应商
       pmdn024 LIKE pmdn_t.pmdn024, #多交期
       pmdn025 LIKE pmdn_t.pmdn025, #收货地址编号
       pmdn026 LIKE pmdn_t.pmdn026, #账款地址编号
       pmdn027 LIKE pmdn_t.pmdn027, #供应商料号
       pmdn028 LIKE pmdn_t.pmdn028, #收货库位
       pmdn029 LIKE pmdn_t.pmdn029, #收货储位
       pmdn030 LIKE pmdn_t.pmdn030, #收货批号
       pmdn031 LIKE pmdn_t.pmdn031, #运输方式
       pmdn032 LIKE pmdn_t.pmdn032, #取货模式
       pmdn033 LIKE pmdn_t.pmdn033, #备品率
       pmdn034 LIKE pmdn_t.pmdn034, #no use
       pmdn035 LIKE pmdn_t.pmdn035, #价格核决
       pmdn036 LIKE pmdn_t.pmdn036, #项目编号
       pmdn037 LIKE pmdn_t.pmdn037, #WBS编号
       pmdn038 LIKE pmdn_t.pmdn038, #活动编号
       pmdn039 LIKE pmdn_t.pmdn039, #费用原因
       pmdn040 LIKE pmdn_t.pmdn040, #取价来源
       pmdn041 LIKE pmdn_t.pmdn041, #价格参考单号
       pmdn042 LIKE pmdn_t.pmdn042, #价格参考项次
       pmdn043 LIKE pmdn_t.pmdn043, #取出价格
       pmdn044 LIKE pmdn_t.pmdn044, #价差比
       pmdn045 LIKE pmdn_t.pmdn045, #行状态
       pmdn046 LIKE pmdn_t.pmdn046, #税前金额
       pmdn047 LIKE pmdn_t.pmdn047, #含税金额
       pmdn048 LIKE pmdn_t.pmdn048, #税额
       pmdn049 LIKE pmdn_t.pmdn049, #理由码
       pmdn050 LIKE pmdn_t.pmdn050, #备注
       pmdn051 LIKE pmdn_t.pmdn051, #留置/结案理由码
       pmdn052 LIKE pmdn_t.pmdn052, #检验否
       pmdn053 LIKE pmdn_t.pmdn053, #库存管理特征
       pmdn200 LIKE pmdn_t.pmdn200, #商品条码
       pmdn201 LIKE pmdn_t.pmdn201, #包装单位
       pmdn202 LIKE pmdn_t.pmdn202, #包装数量
       pmdn203 LIKE pmdn_t.pmdn203, #收货部门
       pmdn204 LIKE pmdn_t.pmdn204, #No Use
       pmdn205 LIKE pmdn_t.pmdn205, #要货组织
       pmdn206 LIKE pmdn_t.pmdn206, #库存量
       pmdn207 LIKE pmdn_t.pmdn207, #采购在途量
       pmdn208 LIKE pmdn_t.pmdn208, #前日销售量
       pmdn209 LIKE pmdn_t.pmdn209, #上月销量
       pmdn210 LIKE pmdn_t.pmdn210, #第一周销量
       pmdn211 LIKE pmdn_t.pmdn211, #第二周销量
       pmdn212 LIKE pmdn_t.pmdn212, #第三周销量
       pmdn213 LIKE pmdn_t.pmdn213, #第四周销量
       pmdn214 LIKE pmdn_t.pmdn214, #采购渠道
       pmdn215 LIKE pmdn_t.pmdn215, #渠道性质
       pmdn216 LIKE pmdn_t.pmdn216, #经营方式
       pmdn217 LIKE pmdn_t.pmdn217, #结算方式
       pmdn218 LIKE pmdn_t.pmdn218, #合同编号
       pmdn219 LIKE pmdn_t.pmdn219, #协议编号
       pmdn220 LIKE pmdn_t.pmdn220, #采购人员
       pmdn221 LIKE pmdn_t.pmdn221, #采购部门
       pmdn222 LIKE pmdn_t.pmdn222, #采购中心
       pmdn223 LIKE pmdn_t.pmdn223, #配送中心
       pmdn224 LIKE pmdn_t.pmdn224, #采购失效日
       pmdn900 LIKE pmdn_t.pmdn900, #保留字段str
       pmdn999 LIKE pmdn_t.pmdn999, #保留字段end
       pmdn225 LIKE pmdn_t.pmdn225, #最终收货组织
       pmdn054 LIKE pmdn_t.pmdn054, #还料数量
       pmdn055 LIKE pmdn_t.pmdn055, #还量参考数量
       pmdn056 LIKE pmdn_t.pmdn056, #还价数量
       pmdn057 LIKE pmdn_t.pmdn057, #还价参考数量
       pmdn226 LIKE pmdn_t.pmdn226, #长效期每次送货量
       pmdn227 LIKE pmdn_t.pmdn227, #补货规格说明
       pmdn058 LIKE pmdn_t.pmdn058, #预算科目
       pmdn228 LIKE pmdn_t.pmdn228  #商品品类
END RECORD
DEFINE l_pmdp RECORD  #採購關聯單據明細檔
       pmdpent LIKE pmdp_t.pmdpent, #企业编号
       pmdpsite LIKE pmdp_t.pmdpsite, #营运据点
       pmdpdocno LIKE pmdp_t.pmdpdocno, #采购单号
       pmdpseq LIKE pmdp_t.pmdpseq, #采购项次
       pmdpseq1 LIKE pmdp_t.pmdpseq1, #项序
       pmdp001 LIKE pmdp_t.pmdp001, #料件编号
       pmdp002 LIKE pmdp_t.pmdp002, #产品特征
       pmdp003 LIKE pmdp_t.pmdp003, #来源单号
       pmdp004 LIKE pmdp_t.pmdp004, #来源项次
       pmdp005 LIKE pmdp_t.pmdp005, #来源项序
       pmdp006 LIKE pmdp_t.pmdp006, #来源分批序
       pmdp007 LIKE pmdp_t.pmdp007, #来源料号
       pmdp008 LIKE pmdp_t.pmdp008, #来源产品特征
       pmdp009 LIKE pmdp_t.pmdp009, #来源作业编号
       pmdp010 LIKE pmdp_t.pmdp010, #来源作业序
       pmdp011 LIKE pmdp_t.pmdp011, #来源BOM特性
       pmdp012 LIKE pmdp_t.pmdp012, #来源生产控制组
       pmdp021 LIKE pmdp_t.pmdp021, #冲销顺序
       pmdp022 LIKE pmdp_t.pmdp022, #需求单位
       pmdp023 LIKE pmdp_t.pmdp023, #需求数量
       pmdp024 LIKE pmdp_t.pmdp024, #折合采购量
       pmdp025 LIKE pmdp_t.pmdp025, #已收货量
       pmdp026 LIKE pmdp_t.pmdp026, #已入库量
       pmdp900 LIKE pmdp_t.pmdp900, #保留字段str
       pmdp999 LIKE pmdp_t.pmdp999  #保留字段end
END RECORD
DEFINE l_pmdq RECORD  #採購多交期匯總檔
       pmdqent LIKE pmdq_t.pmdqent, #企业编号
       pmdqsite LIKE pmdq_t.pmdqsite, #营运据点
       pmdqdocno LIKE pmdq_t.pmdqdocno, #采购单号
       pmdqseq LIKE pmdq_t.pmdqseq, #采购项次
       pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
       pmdq002 LIKE pmdq_t.pmdq002, #分批数量
       pmdq003 LIKE pmdq_t.pmdq003, #交货日期
       pmdq004 LIKE pmdq_t.pmdq004, #到厂日期
       pmdq005 LIKE pmdq_t.pmdq005, #到库日期
       pmdq006 LIKE pmdq_t.pmdq006, #收货时段
       pmdq007 LIKE pmdq_t.pmdq007, #MRP冻结否
       pmdq008 LIKE pmdq_t.pmdq008, #交期类型
       pmdq201 LIKE pmdq_t.pmdq201, #分批包装单位
       pmdq202 LIKE pmdq_t.pmdq202, #分批包装数量
       pmdq900 LIKE pmdq_t.pmdq900, #保留字段str
       pmdq999 LIKE pmdq_t.pmdq999  #保留字段end
END RECORD
#161124-00048#8 mod-E
DEFINE l_success   LIKE type_t.num5
DEFINE l_imaf173   LIKE imaf_t.imaf173
DEFINE l_imaf174   LIKE imaf_t.imaf174
DEFINE l_imaf158   LIKE imaf_t.imaf158
DEFINE l_pmam004   LIKE pmam_t.pmam004
DEFINE l_pmam005   LIKE pmam_t.pmam005
DEFINE l_pmam006   LIKE pmam_t.pmam006
DEFINE l_flag      LIKE type_t.num5
DEFINE l_desc      LIKE type_t.chr80
DEFINE l_errno     LIKE type_t.chr10          #錯誤訊息代碼 
DEFINE l_pmdq005   LIKE pmdq_t.pmdq005
DEFINE l_pmdq002   LIKE pmdq_t.pmdq002

DEFINE l_pmdn003   LIKE pmdn_t.pmdn003    #包裝容器   
DEFINE l_pmdn019   LIKE pmdn_t.pmdn019    #子件特性  
DEFINE l_pmdn020   LIKE pmdn_t.pmdn020    #緊急度  
DEFINE l_pmdn021   LIKE pmdn_t.pmdn021    #保稅  
DEFINE l_pmdn022   LIKE pmdn_t.pmdn022    #部分交貨  
DEFINE l_pmdn024   LIKE pmdn_t.pmdn024    #多交期  
DEFINE l_pmdn027   LIKE pmdn_t.pmdn027    #供應商料號  
DEFINE l_pmdn028   LIKE pmdn_t.pmdn028    #收貨庫位  
DEFINE l_pmdn029   LIKE pmdn_t.pmdn029    #收貨儲位 
DEFINE l_pmdn032   LIKE pmdn_t.pmdn032    #取貨模式 
DEFINE l_pmdn033   LIKE pmdn_t.pmdn033    #備品率  
DEFINE l_pmdn035   LIKE pmdn_t.pmdn035    #價格核決 
DEFINE l_pmdn045   LIKE pmdn_t.pmdn045    #行狀態 
DEFINE l_pmdn046   LIKE pmdn_t.pmdn046    #未稅金額 
DEFINE l_pmdn047   LIKE pmdn_t.pmdn047    #含稅金額  
DEFINE l_pmdn048   LIKE pmdn_t.pmdn048    #稅額 
DEFINE l_pmdnunit  LIKE pmdn_t.pmdnunit   #收貨據點  
DEFINE l_pmdnorga  LIKE pmdn_t.pmdnorga   #付款據點  
DEFINE l_pmdn011   LIKE pmdn_t.pmdn011
DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
DEFINE l_pmdp023   LIKE pmdp_t.pmdp023
DEFINE l_ooba002   LIKE ooba_t.ooba002
   WHENEVER ERROR CONTINUE 

   INITIALIZE l_pmdl.* TO NULL
   #161124-00048#8 mod-S
#   SELECT * INTO l_pmdl.* 
#     FROM pmdl_t 
#    WHERE pmdlent = g_enterprise 
#      AND pmdldocno = p_pmdldocno
   SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
          pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
          pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
          pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
          pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
          pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
          pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
          pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
          pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
          pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
          pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
          pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208
     INTO l_pmdl.* 
     FROM pmdl_t 
    WHERE pmdlent = g_enterprise 
      AND pmdldocno = p_pmdldocno
   #161124-00048#8 mod-E
   
   LET l_sql = "SELECT pmdb004,pmdb005,pmdb007,pmdb006,pmdb011,pmdb010,pmdb030,",
               " pmdb038, pmdb039,pmdb054, ",  #160801-00004#2
               "       pmdb050",
               "  FROM apmp480_new_tmp ",
               " WHERE slip = '",p_slip,"' ",
               "   AND pmdb015 = '",l_pmdl.pmdl004,"' ",
               " ORDER BY pmdb004,pmdb005,pmdb007,pmdb011,pmdb050"   
   PREPARE apmp480_ins_pmdn_prep FROM l_sql
   DECLARE apmp480_ins_pmdn_curs CURSOR WITH HOLD FOR apmp480_ins_pmdn_prep

   INITIALIZE l_pmdn.*     TO NULL 
   FOREACH apmp480_ins_pmdn_curs INTO l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdn.pmdn006,l_pmdn.pmdn007,
                                      l_pmdn.pmdn010,l_pmdn.pmdn011,l_pmdn.pmdn014,
                                      l_pmdn.pmdn028,l_pmdn.pmdn029,l_pmdn.pmdn053,    #160801-00004#2
                                      l_pmdn.pmdn050
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = STATUS
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = 'N'
         EXIT FOREACH
      END IF
      
      LET l_pmdn.pmdndocno = p_pmdldocno
      SELECT MAX(pmdnseq)+1 INTO l_pmdn.pmdnseq
        FROM pmdn_t 
       WHERE pmdnent = g_enterprise
         AND pmdndocno = p_pmdldocno
      IF cl_null(l_pmdn.pmdnseq) THEN          
         LET l_pmdn.pmdnseq = 1
      END IF

      #160801-00004#2---s
      #LET l_pmdn.pmdn028 = ''
      #LET l_pmdn.pmdn029 = ''
      #160801-00004#2---e
      LET l_pmdn.pmdn003 = ''     
      #before insert 的預設  
      LET l_pmdn.pmdn024 = "N"         #多交期 
      LET l_pmdn.pmdn045 = "1"         #行狀態 
      LET l_pmdn.pmdn015 = "0"         #單價 
      LET l_pmdn.pmdn019 = "1"         #子件特性 
      LET l_pmdn.pmdn020 = "1"         #緊急度 
      LET l_pmdn.pmdn021 = "N"         #保稅  
      LET l_pmdn.pmdn022 = "Y"         #部分交貨 
      LET l_pmdn.pmdn032 = "1"         #取貨模式 
      LET l_pmdn.pmdn035 = "1"         #價格核決 
      LET l_pmdn.pmdn040 = "1"         #取價來源
      LET l_pmdn.pmdnsite = g_site 
      LET l_pmdn.pmdnunit = g_site     #交貨據點 
      LET l_pmdn.pmdnorga = g_site     #付款據點 
      
      #-----------------------------------------------------
      LET l_pmdn.pmdn016 = l_pmdl.pmdl011     #稅別 
      LET l_pmdn.pmdn017 = l_pmdl.pmdl012     #稅率 
      LET l_pmdn.pmdn023 = l_pmdl.pmdl022     #送貨供應商 
      LET l_pmdn.pmdn031 = l_pmdl.pmdl020     #運輸方式  
      LET l_pmdn.pmdn025 = l_pmdl.pmdl025     #收貨地址代碼 
      LET l_pmdn.pmdn026 = l_pmdl.pmdl026     #帳款地址代碼 

      #pmdn001 #參考apmt500_pmdn001_desc() 給預設值
      CALL apmp480_pmdn001_desc(l_pmdl.pmdl004,l_pmdn.*,l_pmdl.pmdl002)
           RETURNING l_pmdn.*

      #pmdn006 
      IF NOT cl_null(l_pmdn.pmdn006) THEN
         IF NOT cl_null(l_pmdn.pmdn007) THEN
            CALL apmp490_03_unit_round(l_pmdn.pmdn006,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn007

#            #計算參考數量 
#            #系統參數使用參考單位 
#            IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
#               IF cl_null(l_pmdn.pmdn008) THEN
#                  LET l_pmdn.pmdn008 = l_pmdn.pmdn006
#               END IF
#               IF cl_null(l_pmdn.pmdn009) THEN
#                  #單位換算 
#                  CALL apmp490_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
#                                              l_pmdn.pmdn008,l_pmdn.pmdn007)
#                       RETURNING l_pmdn.pmdn009
#               END IF
#               IF NOT cl_null(l_pmdn.pmdn009) THEN
#                  CALL apmp490_03_unit_round(l_pmdn.pmdn008,l_pmdn.pmdn009)
#                       RETURNING l_pmdn.pmdn009
#               END IF
#            ELSE
#               LET l_pmdn.pmdn008 = ''
#               LET l_pmdn.pmdn009 = ''
#            END IF
 
            #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
            #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
               IF cl_null(l_pmdn.pmdn010) THEN
                  LET l_pmdn.pmdn010 = l_pmdn.pmdn006
               END IF
               IF cl_null(l_pmdn.pmdn011) THEN
                  CALL apmp490_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                              l_pmdn.pmdn010,l_pmdn.pmdn007)
                       RETURNING l_pmdn.pmdn011
               END IF
               IF NOT cl_null(l_pmdn.pmdn011) THEN
                  CALL apmp490_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
                       RETURNING l_pmdn.pmdn011
               END IF
            ELSE
               LET l_pmdn.pmdn010 = l_pmdn.pmdn006
               LET l_pmdn.pmdn011 = l_pmdn.pmdn007
            END IF
         END IF

      END IF
      
      #pmdn007 
      IF NOT cl_null(l_pmdn.pmdn007) THEN
         IF NOT cl_null(l_pmdn.pmdn006) THEN
            CALL apmp490_03_unit_round(l_pmdn.pmdn006,l_pmdn.pmdn007)
                 RETURNING l_pmdn.pmdn007
         END IF 
         
         #參考單位 
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'Y' THEN
            IF (NOT cl_null(l_pmdn.pmdn008)) AND (cl_null(l_pmdn.pmdn009)) THEN
               CALL apmp490_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                           l_pmdn.pmdn008,l_pmdn.pmdn007)
                    RETURNING l_pmdn.pmdn009
               CALL apmp490_03_unit_round(l_pmdn.pmdn008,l_pmdn.pmdn009)
                    RETURNING l_pmdn.pmdn009
            END IF
         END IF

         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN  #體參數使用採購計價單位
            IF (NOT cl_null(l_pmdn.pmdn010)) AND (cl_null(l_pmdn.pmdn011)) THEN
               CALL apmp490_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
                                           l_pmdn.pmdn010,l_pmdn.pmdn007)
                    RETURNING l_pmdn.pmdn011
               CALL apmp490_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
                    RETURNING l_pmdn.pmdn011
            END IF
         END IF
      END IF 
      
      #採購欄位賦初始值
      LET l_pmdn.pmdn019 = '1'    #料件子特性 
      #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
      #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
      #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
      #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
       
      LET l_pmdn.pmdn033 = ''
      LET l_imaf158 = ''
      SELECT imaf158,imaf165,imaf015
        INTO l_imaf158,l_pmdn.pmdn033,l_pmdn.pmdn008
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = l_pmdn.pmdn001
       
      #子件特性 
      CASE l_imaf158
         WHEN '1'
            LET l_pmdn.pmdn019 = '2'
         WHEN '2'
            LET l_pmdn.pmdn019 = '3'
      END CASE
         
         
      #多交期
      LET l_pmdn.pmdn024 = 'N'

      
      SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
 
      IF NOT cl_null(l_pmdn.pmdn014) THEN
         LET l_imaf173 = 0   #採購到廠前置時間  
         LET l_imaf174 = 0   #採購入庫前置時間  

         SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
           FROM imaf_t
          WHERE imafent = g_enterprise
            AND imafsite = g_site
            AND imaf001 = l_pmdn.pmdn001
         LET l_imaf173 = -1 * l_imaf173
         LET l_imaf174 = -1 * l_imaf174
         IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
            CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn014,0,l_imaf174)
                 RETURNING l_pmdn.pmdn013
         ELSE
            LET l_pmdn.pmdn013 = l_pmdn.pmdn014
         END IF
         
         #1.輸入交貨日期後需自動計算到廠日期，公式為交貨日期+[T:料件據點進銷存檔].[C:到廠前置時間]
         #2.輸入交貨日期後需自動計算到庫日期，公式為到廠日期+[T:料件據點進銷存檔].[C:到庫前置時間]
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,l_pmdn.pmdn013,0,l_imaf173)
                 RETURNING l_pmdn.pmdn012
         ELSE
            LET l_pmdn.pmdn012 = l_pmdn.pmdn013
         END IF

         #根據到庫日期計算緊急度 
         CALL apmp490_03_pmdn014_to_pmdn020(l_pmdn.pmdn001,l_pmdn.pmdn014) RETURNING l_pmdn.pmdn020 
      END IF

#      #計價單位  
#      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = 'Y' THEN
#         IF cl_null(l_pmdn.pmdn011) THEN
#            CALL apmp490_03_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,
#                                        l_pmdn.pmdn010,l_pmdn.pmdn007)
#                 RETURNING l_pmdn.pmdn011
#         ELSE
#            IF l_pmdn.pmdn011 <= 0 THEN
#               LET l_errno = 'ade-00016'                 #數量不可小於等於0 
#               LET g_result_str = g_result_str,",",cl_getmsg(l_errno,g_lang)
#               LET g_success = 'N'
#            END IF
#         END IF 
#         
#         CALL apmp490_03_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011)
#              RETURNING l_pmdn.pmdn011
#
#      ELSE
#         LET l_pmdn.pmdn010 = l_pmdn.pmdn006
#         LET l_pmdn.pmdn011 = l_pmdn.pmdn007
#      END IF

      #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
      #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
      LET l_pmdn.pmdn027 = ''
      SELECT pmao004 INTO l_pmdn.pmdn027
        FROM pmao_t
       WHERE pmaoent = g_enterprise
         AND pmao001 = l_pmdl.pmdl004
         AND pmao002 = l_pmdn.pmdn001
         AND pmao003 = l_pmdn.pmdn002
         AND pmao007 = 'Y'
         AND pmao000 = '1'    #161221-00064#8 add
         
      IF cl_null(l_pmdn.pmdn027) THEN
         SELECT pmao004 INTO l_pmdn.pmdn027
           FROM pmao_t
          WHERE pmaoent = g_enterprise
            AND pmao001 = l_pmdl.pmdl004
            AND pmao002 = l_pmdn.pmdn001
            AND pmao003 = l_pmdn.pmdn002
            AND pmao000 = '1'    #161221-00064#8 add
            AND rownum = 1
      END IF
      
      #調用元件取單價
      LET l_pmdn.pmdn015 = 0 
      
      #1.不同交期匯總取價
      #2.依不同交期拆解
      IF g_master.b = '1' THEN 
                            #料號,   產品特徵,  计价单位,计价數量
         LET l_sql = "SELECT SUM(pmdb010)",
                     "  FROM apmp480_new_tmp ",
                     " WHERE slip = '",p_slip,"' ",
                     "   AND pmdb015 = '",l_pmdl.pmdl004,"' ",
                     "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                     "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                     "   AND pmdb011 = '",l_pmdn.pmdn010,"'"
      ELSE
         LET l_sql = "SELECT SUM(pmdb010),pmdb030",
                     "  FROM apmp480_new_tmp ",
                     " WHERE slip = '",p_slip,"' ",
                     "   AND pmdb015 = '",l_pmdl.pmdl004,"' ",
                     "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                     "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                     "   AND pmdb011 = '",l_pmdn.pmdn010,"'",
                     "   AND pmdb030 = '",l_pmdn.pmdn014,"'"   
      END IF 
      PREPARE apmp480_get_pmdn011 FROM l_sql       
      EXECUTE apmp480_get_pmdn011 INTO l_pmdn011
      IF cl_null(l_pmdn011) THEN LET l_pmdn011 = 0 END IF      
      IF NOT (cl_null(l_pmdl.pmdl017) OR cl_null(l_pmdl.pmdl004) OR cl_null(l_pmdn.pmdn001) OR
              cl_null(l_pmdl.pmdl015) OR cl_null(l_pmdl.pmdl011) OR cl_null(l_pmdl.pmdl009) OR
              cl_null(l_pmdl.pmdl010) OR cl_null(l_pmdl.pmdl023) OR cl_null(l_pmdn.pmdn010) OR 
              cl_null(l_pmdl.pmdl054) OR cl_null(l_pmdn011) ) THEN
         CALL s_purchase_price_get(l_pmdl.pmdl017,l_pmdl.pmdl004,l_pmdn.pmdn001,l_pmdn.pmdn002,
                                   l_pmdl.pmdl015,l_pmdl.pmdl011,l_pmdl.pmdl009,l_pmdl.pmdl010,
                                   l_pmdl.pmdl023,l_pmdl.pmdldocno,
                                   l_pmdl.pmdldocdt,l_pmdn.pmdn010,l_pmdn011,
                                   g_site,l_pmdl.pmdl054,'1','apmp480','' )
              RETURNING l_pmdn.pmdn040,l_pmdn.pmdn015,l_pmdn.pmdn041,l_pmdn.pmdn042
       
         LET l_pmdn.pmdn043 = l_pmdn.pmdn015
       
      END IF 
      
      CALL s_apmt500_get_amount(l_pmdl.pmdldocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,
                                l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)
           RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047
           
      #因為s_apmt500_get_amount會呼叫稅別元件(s_tax)，其中會產生xrcd的資料，所以要做刪除的動作 
      DELETE FROM xrcd_t WHERE xrcdent = g_enterprise
                           #AND xrcdld  = l_ooef017   #因為這裡只有單別，應該是不會有其他相同的資料  
                           AND xrcddocno = l_pmdl.pmdldocno
                           AND xrcdseq   = l_pmdn.pmdnseq
                           AND xrcdseq2  = '0'
                           
      LET l_pmdn.pmdnent = g_enterprise

      #單身資料檢驗否(pmdn052) 是由集團預設料件據點品質資料維護作業(aimm206)而來 
      #取 是否進行檢驗(imae114) 
      SELECT imae114 INTO l_pmdn.pmdn052
        FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = g_site
         AND imae001  = l_pmdn.pmdn001
      IF cl_null(l_pmdn.pmdn052) THEN
         LET l_pmdn.pmdn052 = 'N'
      END IF 
      
      #若取到的價格為0 ，則給當前錄入的那個產品特徵的單價
      IF l_pmdn.pmdn043 > 0 THEN
         LET l_pmdn.pmdn015 = l_pmdn.pmdn043
         LET l_pmdn.pmdn044 = 0
      ELSE
         LET l_pmdn.pmdn044 = ((l_pmdn.pmdn015 - l_pmdn.pmdn043) / l_pmdn.pmdn043) * 100
      END IF
      LET g_pmdn028_t = l_pmdn.pmdn028 #160801-00004#2
      IF cl_null(l_pmdn.pmdn028) THEN
         CALL s_aooi200_get_slip(l_pmdn.pmdndocno) RETURNING l_success,l_ooba002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076') RETURNING l_pmdn.pmdn028
      END IF      
      INSERT INTO pmdn_t(pmdnent ,pmdnsite,pmdndocno,pmdnseq,pmdn001,
                         pmdn002 ,pmdn003 ,pmdn004  ,pmdn005,pmdn006,
                         pmdn007 ,pmdn008 ,pmdn009  ,pmdn010,pmdn011,
                         pmdn012 ,pmdn013 ,pmdn014  ,pmdn015,pmdn016,
                         pmdn017 ,pmdn019 ,pmdn020  ,pmdn021,pmdn022,
                         pmdnunit,pmdnorga,pmdn023  ,pmdn024,pmdn025,
                         pmdn026 ,pmdn027 ,pmdn028  ,pmdn029,pmdn030,
                         pmdn031 ,pmdn032 ,pmdn033  ,pmdn034,pmdn035,
                         pmdn036 ,pmdn037 ,pmdn038  ,pmdn039,pmdn040,
                         pmdn041 ,pmdn042 ,pmdn043  ,pmdn044,pmdn045,
                         pmdn046 ,pmdn047 ,pmdn048  ,pmdn049,pmdn050,
                         pmdn051 ,pmdn052,
                         pmdn053)  #160801-00004#2
                  VALUES(l_pmdn.pmdnent,l_pmdn.pmdnsite,l_pmdn.pmdndocno, 
                         l_pmdn.pmdnseq,l_pmdn.pmdn001 ,l_pmdn.pmdn002  ,
                         l_pmdn.pmdn003,l_pmdn.pmdn004 ,l_pmdn.pmdn005  ,
                         l_pmdn.pmdn006,l_pmdn.pmdn007 ,l_pmdn.pmdn008  ,
                         l_pmdn.pmdn009,l_pmdn.pmdn010 ,l_pmdn.pmdn011  ,
                         l_pmdn.pmdn012,l_pmdn.pmdn013 ,l_pmdn.pmdn014  ,
                         l_pmdn.pmdn015,l_pmdn.pmdn016 ,l_pmdn.pmdn017  ,
                         l_pmdn.pmdn019,l_pmdn.pmdn020 ,l_pmdn.pmdn021  ,
                         l_pmdn.pmdn022,l_pmdn.pmdnunit,l_pmdn.pmdnorga ,
                         l_pmdn.pmdn023,l_pmdn.pmdn024 ,l_pmdn.pmdn025  ,
                         l_pmdn.pmdn026,l_pmdn.pmdn027 ,l_pmdn.pmdn028  ,
                         l_pmdn.pmdn029,l_pmdn.pmdn030 ,l_pmdn.pmdn031  ,
                         l_pmdn.pmdn032,l_pmdn.pmdn033 ,l_pmdn.pmdn034  ,
                         l_pmdn.pmdn035,l_pmdn.pmdn036 ,l_pmdn.pmdn037  ,
                         l_pmdn.pmdn038,l_pmdn.pmdn039 ,l_pmdn.pmdn040  ,
                         l_pmdn.pmdn041,l_pmdn.pmdn042 ,l_pmdn.pmdn043  ,
                         l_pmdn.pmdn044,l_pmdn.pmdn045 ,l_pmdn.pmdn046  ,
                         l_pmdn.pmdn047,l_pmdn.pmdn048 ,l_pmdn.pmdn049  ,
                         l_pmdn.pmdn050,l_pmdn.pmdn051 ,l_pmdn.pmdn052  ,
                         l_pmdn.pmdn053)   #160801-00004#2

      #採購關聯單據明細檔-INSERT
      IF g_master.a = '1' THEN
         LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,",
                     "       applied_qty",
                     "  FROM apmp480_tmp ",
                     " WHERE slip = '",p_slip,"' ",
                     "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                     "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                     "   AND pmdb007 = '",l_pmdn.pmdn006,"'",
                     "   AND pmdb011 = '",l_pmdn.pmdn010,"'",
                     #160801-00004#2---s
                     "   AND NVL(pmdb038,' ') = NVL('",g_pmdn028_t,"',' ') ",
                     "   AND NVL(pmdb039,' ') = NVL('",l_pmdn.pmdn029,"',' ') ",
                     "   AND NVL(pmdb054,' ') = NVL('",l_pmdn.pmdn053,"',' ') ",
                     #160801-00004#2---e
                     "   AND NVL(pmdb050,' ') = NVL('",l_pmdn.pmdn050,"',' ') ",
                     "   AND applied_qty > 0 ",
                     " ORDER BY pmdbdocno,pmdbseq "
      ELSE
         LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,",
                     "       applied_qty",
                     "  FROM apmp480_tmp ",
                     " WHERE slip = '",p_slip,"' ",
                     "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                     "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                     "   AND pmdb007 = '",l_pmdn.pmdn006,"'",
                     "   AND pmdb011 = '",l_pmdn.pmdn010,"'",
                     "   AND pmdb030 = '",l_pmdn.pmdn014,"'",
                     #160801-00004#2---s
                     "   AND NVL(pmdb038,' ') = NVL('",g_pmdn028_t,"',' ') ",
                     "   AND NVL(pmdb039,' ') = NVL('",l_pmdn.pmdn029,"',' ') ",
                     "   AND NVL(pmdb054,' ') = NVL('",l_pmdn.pmdn053,"',' ') ",
                     #160801-00004#2---e
                     "   AND NVL(pmdb050,' ') = NVL('",l_pmdn.pmdn050,"',' ') ",
                     "   AND applied_qty > 0 ",
                     " ORDER BY pmdbdocno,pmdbseq "     
      END IF            
      PREPARE apmp480_pmdp_prep FROM l_sql
      DECLARE apmp480_pmdp_curs CURSOR WITH HOLD FOR apmp480_pmdp_prep
      INITIALIZE l_pmdp.* TO NULL 
      LET l_pmdn007 = l_pmdn.pmdn007
      FOREACH apmp480_pmdp_curs INTO l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,
                                     l_pmdp.pmdp022,l_pmdp023
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.popup = TRUE
            CALL cl_err()
       
            EXIT FOREACH
         END IF
         LET l_pmdp.pmdpent = g_enterprise
         LET l_pmdp.pmdpsite = g_site
         LET l_pmdp.pmdpdocno = p_pmdldocno
         LET l_pmdp.pmdpseq = l_pmdn.pmdnseq          #請購關聯單的項次會等於採購單的項次 
       
         #設定項序 
         LET l_pmdp.pmdpseq1 = ''
         SELECT MAX(pmdpseq1) + 1 INTO l_pmdp.pmdpseq1
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpdocno = p_pmdldocno
            AND pmdpseq = l_pmdn.pmdnseq
         IF cl_null(l_pmdp.pmdpseq1) OR l_pmdp.pmdpseq1 = 0 THEN
            LET l_pmdp.pmdpseq1 = 1
         END IF
         LET l_pmdp.pmdp001 = l_pmdp.pmdp007
         LET l_pmdp.pmdp002 = l_pmdp.pmdp008
         
         #設定沖銷順序 
         SELECT MAX(pmdp021) + 1 INTO l_pmdp.pmdp021
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpdocno = p_pmdldocno
            AND pmdp001 = l_pmdn.pmdn001
         IF cl_null(l_pmdp.pmdp021) OR l_pmdp.pmdp021 = 0 THEN
            LET l_pmdp.pmdp021 = 1
         END IF
         IF l_pmdn007 > l_pmdp023 THEN 
            LET l_pmdp.pmdp023 = l_pmdp023
            LET l_pmdn007 = l_pmdn007 - l_pmdp023
         ELSE         
            LET l_pmdp.pmdp023 = l_pmdn007
            LET l_pmdn007 = 0
         END IF
         LET l_pmdp.pmdp024 = l_pmdp.pmdp023               #折合採購量
         LET l_pmdp.pmdp025 = 0
         LET l_pmdp.pmdp026 = 0
         INSERT INTO pmdp_t(pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,
                            pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,
                            pmdp006,pmdp007,pmdp008,pmdp009,pmdp010,
                            pmdp011,pmdp012,pmdp021,pmdp022,pmdp023,
                            pmdp024,pmdp025,pmdp026)
                     VALUES(l_pmdp.pmdpent,l_pmdp.pmdpsite,l_pmdp.pmdpdocno,l_pmdp.pmdpseq,l_pmdp.pmdpseq1,
                            l_pmdp.pmdp001,l_pmdp.pmdp002,l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp005,
                            l_pmdp.pmdp006,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp009,l_pmdp.pmdp010,
                            l_pmdp.pmdp011,l_pmdp.pmdp012,l_pmdp.pmdp021,l_pmdp.pmdp022,l_pmdp.pmdp023,
                            l_pmdp.pmdp024,l_pmdp.pmdp025,l_pmdp.pmdp026)
       
         IF g_master.a = '1' THEN
            LET l_sql = "UPDATE apmp480_tmp ",
                        "   SET applied_qty = applied_qty - ",l_pmdp.pmdp023,
                        " WHERE slip = '",p_slip,"' ",
                        "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                        "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                        "   AND pmdb007 = '",l_pmdn.pmdn006,"'",
                        "   AND pmdb011 = '",l_pmdn.pmdn010,"'",
                        #160801-00004#2---s
                        "   AND NVL(pmdb038,' ') = NVL('",g_pmdn028_t,"',' ') ,",
                        "   AND NVL(pmdb039,' ') = NVL('",l_pmdn.pmdn029,"',' ') ,",
                        "   AND NVL(pmdb054,' ') = NVL('",l_pmdn.pmdn053,"',' ') ,",
                        #160801-00004#2---e
                        "   AND NVL(pmdb050,' ') = NVL('",l_pmdn.pmdn050,"',' ') ",
                        "   AND pmdbdocno = '",l_pmdp.pmdp003,"'",
                        "   AND pmdbseq = ",l_pmdp.pmdp004
         ELSE
            LET l_sql = "UPDATE apmp480_tmp ",
                        "   SET applied_qty = applied_qty - ",l_pmdp.pmdp023,                        
                        " WHERE slip = '",p_slip,"' ",
                        "   AND pmdb004 = '",l_pmdn.pmdn001,"'",
                        "   AND pmdb005 = '",l_pmdn.pmdn002,"'",
                        "   AND pmdb007 = '",l_pmdn.pmdn006,"'",
                        "   AND pmdb011 = '",l_pmdn.pmdn010,"'",
                        "   AND pmdb030 = '",l_pmdn.pmdn014,"'",
                        #160801-00004#2---s
                        "   AND NVL(pmdb038,' ') = NVL('",g_pmdn028_t,"',' ') ,",
                        "   AND NVL(pmdb039,' ') = NVL('",l_pmdn.pmdn029,"',' ') ,",
                        "   AND NVL(pmdb054,' ') = NVL('",l_pmdn.pmdn053,"',' ') ,",
                        #160801-00004#2---e
                        "   AND NVL(pmdb050,' ') = NVL('",l_pmdn.pmdn050,"',' ') ",
                        "   AND pmdbdocno = '",l_pmdp.pmdp003,"'",
                        "   AND pmdbseq = ",l_pmdp.pmdp004    
         END IF
         PREPARE upd_tmp_qty FROM l_sql
         EXECUTE upd_tmp_qty  
         UPDATE pmdb_t
            SET pmdb049 = pmdb049 + l_pmdp.pmdp023
          WHERE pmdbent = g_enterprise
            AND pmdbdocno = l_pmdp.pmdp003
            AND pmdbseq = l_pmdp.pmdp004            
         IF l_pmdn007 = 0 THEN         
            EXIT FOREACH
         END IF
         INITIALIZE l_pmdp.* TO NULL
      END FOREACH

      #採購多交期匯總檔        
      LET l_sql = " SELECT pmdb030,SUM(pmdp024) ",
                  "   FROM pmdb_t,pmdp_t ",
                  " WHERE pmdbent = pmdpent ",
                  "   AND pmdbdocno = pmdp003 ",
                  "   AND pmdbseq = pmdp004",
                  "   AND pmdpdocno = '",p_pmdldocno,"'",
                  "   AND pmdpseq = ",l_pmdn.pmdnseq,
                  " GROUP BY pmdb030 "
      PREPARE apmp480_ins_pmdq_prep FROM l_sql
      DECLARE apmp480_ins_pmdq_curs CURSOR WITH HOLD FOR apmp480_ins_pmdq_prep
      LET l_pmdn007 = l_pmdn.pmdn007
      FOREACH apmp480_ins_pmdq_curs INTO l_pmdq005,l_pmdq002
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = STATUS
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         INITIALIZE l_pmdq.* TO NULL
         LET l_pmdq.pmdqent = g_enterprise
         LET l_pmdq.pmdqsite = g_site          
         LET l_pmdq.pmdqdocno = l_pmdn.pmdndocno 
         LET l_pmdq.pmdqseq = l_pmdn.pmdnseq
         LET l_pmdq.pmdq005 = l_pmdq005

         #分批序加1 
         SELECT MAX(pmdqseq2) + 1 INTO l_pmdq.pmdqseq2
           FROM pmdq_t
          WHERE pmdqent = g_enterprise
            AND pmdqdocno = l_pmdn.pmdndocno
            AND pmdqseq = l_pmdn.pmdnseq
         IF cl_null(l_pmdq.pmdqseq2) OR l_pmdq.pmdqseq2 = 0 THEN
            LET l_pmdq.pmdqseq2 = 1
         END IF

         #到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
         #交貨日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
         CALL apmp490_03_date_count(l_pmdn.pmdn001,l_pmdq.pmdq005)
              RETURNING l_pmdq.pmdq004,l_pmdq.pmdq003

         LET l_pmdq.pmdq006 = ''
         LET l_pmdq.pmdq007 = 'N'

         LET l_pmdq.pmdq002 = l_pmdq002

         
         INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
                            pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007)
                     VALUES(l_pmdq.pmdqent,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
                            l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,
                            l_pmdq.pmdq007)
         IF l_pmdq.pmdqseq2 > 1 AND l_pmdn.pmdn024 = 'N' THEN 
            UPDATE pmdn_t
               SET pmdn024 = 'Y'
             WHERE pmdnent = g_enterprise
               AND pmdndocno = l_pmdq.pmdqdocno
               AND pmdnseq = l_pmdq.pmdqseq               
         END IF
      END FOREACH
      
      
     
      #採購交期明細檔pmdo_t
      CALL s_apmt500_gen_pmdo(l_pmdn.pmdndocno,l_pmdn.pmdnseq) RETURNING l_success
      
      INITIALIZE l_pmdn.*     TO NULL
   END FOREACH      
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp480_pmdn001_desc(p_pmdl004,p_pmdn,p_pmal002)
DEFINE p_pmdl004  LIKE pmdl_t.pmdl004
#161124-00048#8 mod-S
#DEFINE p_pmdn     RECORD LIKE pmdn_t.*
DEFINE p_pmdn RECORD  #採購單身明細檔
       pmdnent LIKE pmdn_t.pmdnent, #企业编号
       pmdnsite LIKE pmdn_t.pmdnsite, #营运据点
       pmdnunit LIKE pmdn_t.pmdnunit, #应用组织
       pmdndocno LIKE pmdn_t.pmdndocno, #采购单号
       pmdnseq LIKE pmdn_t.pmdnseq, #项次
       pmdn001 LIKE pmdn_t.pmdn001, #料件编号
       pmdn002 LIKE pmdn_t.pmdn002, #产品特征
       pmdn003 LIKE pmdn_t.pmdn003, #包装容器
       pmdn004 LIKE pmdn_t.pmdn004, #作业编号
       pmdn005 LIKE pmdn_t.pmdn005, #作业序
       pmdn006 LIKE pmdn_t.pmdn006, #采购单位
       pmdn007 LIKE pmdn_t.pmdn007, #采购数量
       pmdn008 LIKE pmdn_t.pmdn008, #参考单位
       pmdn009 LIKE pmdn_t.pmdn009, #参考数量
       pmdn010 LIKE pmdn_t.pmdn010, #计价单位
       pmdn011 LIKE pmdn_t.pmdn011, #计价数量
       pmdn012 LIKE pmdn_t.pmdn012, #出货日期
       pmdn013 LIKE pmdn_t.pmdn013, #到厂日期
       pmdn014 LIKE pmdn_t.pmdn014, #到库日期
       pmdn015 LIKE pmdn_t.pmdn015, #单价
       pmdn016 LIKE pmdn_t.pmdn016, #税种
       pmdn017 LIKE pmdn_t.pmdn017, #税率
       pmdn019 LIKE pmdn_t.pmdn019, #子件特性
       pmdn020 LIKE pmdn_t.pmdn020, #紧急度
       pmdn021 LIKE pmdn_t.pmdn021, #保税
       pmdn022 LIKE pmdn_t.pmdn022, #部分交货
       pmdnorga LIKE pmdn_t.pmdnorga, #付款据点
       pmdn023 LIKE pmdn_t.pmdn023, #送货供应商
       pmdn024 LIKE pmdn_t.pmdn024, #多交期
       pmdn025 LIKE pmdn_t.pmdn025, #收货地址编号
       pmdn026 LIKE pmdn_t.pmdn026, #账款地址编号
       pmdn027 LIKE pmdn_t.pmdn027, #供应商料号
       pmdn028 LIKE pmdn_t.pmdn028, #收货库位
       pmdn029 LIKE pmdn_t.pmdn029, #收货储位
       pmdn030 LIKE pmdn_t.pmdn030, #收货批号
       pmdn031 LIKE pmdn_t.pmdn031, #运输方式
       pmdn032 LIKE pmdn_t.pmdn032, #取货模式
       pmdn033 LIKE pmdn_t.pmdn033, #备品率
       pmdn034 LIKE pmdn_t.pmdn034, #no use
       pmdn035 LIKE pmdn_t.pmdn035, #价格核决
       pmdn036 LIKE pmdn_t.pmdn036, #项目编号
       pmdn037 LIKE pmdn_t.pmdn037, #WBS编号
       pmdn038 LIKE pmdn_t.pmdn038, #活动编号
       pmdn039 LIKE pmdn_t.pmdn039, #费用原因
       pmdn040 LIKE pmdn_t.pmdn040, #取价来源
       pmdn041 LIKE pmdn_t.pmdn041, #价格参考单号
       pmdn042 LIKE pmdn_t.pmdn042, #价格参考项次
       pmdn043 LIKE pmdn_t.pmdn043, #取出价格
       pmdn044 LIKE pmdn_t.pmdn044, #价差比
       pmdn045 LIKE pmdn_t.pmdn045, #行状态
       pmdn046 LIKE pmdn_t.pmdn046, #税前金额
       pmdn047 LIKE pmdn_t.pmdn047, #含税金额
       pmdn048 LIKE pmdn_t.pmdn048, #税额
       pmdn049 LIKE pmdn_t.pmdn049, #理由码
       pmdn050 LIKE pmdn_t.pmdn050, #备注
       pmdn051 LIKE pmdn_t.pmdn051, #留置/结案理由码
       pmdn052 LIKE pmdn_t.pmdn052, #检验否
       pmdn053 LIKE pmdn_t.pmdn053, #库存管理特征
       pmdn200 LIKE pmdn_t.pmdn200, #商品条码
       pmdn201 LIKE pmdn_t.pmdn201, #包装单位
       pmdn202 LIKE pmdn_t.pmdn202, #包装数量
       pmdn203 LIKE pmdn_t.pmdn203, #收货部门
       pmdn204 LIKE pmdn_t.pmdn204, #No Use
       pmdn205 LIKE pmdn_t.pmdn205, #要货组织
       pmdn206 LIKE pmdn_t.pmdn206, #库存量
       pmdn207 LIKE pmdn_t.pmdn207, #采购在途量
       pmdn208 LIKE pmdn_t.pmdn208, #前日销售量
       pmdn209 LIKE pmdn_t.pmdn209, #上月销量
       pmdn210 LIKE pmdn_t.pmdn210, #第一周销量
       pmdn211 LIKE pmdn_t.pmdn211, #第二周销量
       pmdn212 LIKE pmdn_t.pmdn212, #第三周销量
       pmdn213 LIKE pmdn_t.pmdn213, #第四周销量
       pmdn214 LIKE pmdn_t.pmdn214, #采购渠道
       pmdn215 LIKE pmdn_t.pmdn215, #渠道性质
       pmdn216 LIKE pmdn_t.pmdn216, #经营方式
       pmdn217 LIKE pmdn_t.pmdn217, #结算方式
       pmdn218 LIKE pmdn_t.pmdn218, #合同编号
       pmdn219 LIKE pmdn_t.pmdn219, #协议编号
       pmdn220 LIKE pmdn_t.pmdn220, #采购人员
       pmdn221 LIKE pmdn_t.pmdn221, #采购部门
       pmdn222 LIKE pmdn_t.pmdn222, #采购中心
       pmdn223 LIKE pmdn_t.pmdn223, #配送中心
       pmdn224 LIKE pmdn_t.pmdn224, #采购失效日
       pmdn900 LIKE pmdn_t.pmdn900, #保留字段str
       pmdn999 LIKE pmdn_t.pmdn999, #保留字段end
       pmdn225 LIKE pmdn_t.pmdn225, #最终收货组织
       pmdn054 LIKE pmdn_t.pmdn054, #还料数量
       pmdn055 LIKE pmdn_t.pmdn055, #还量参考数量
       pmdn056 LIKE pmdn_t.pmdn056, #还价数量
       pmdn057 LIKE pmdn_t.pmdn057, #还价参考数量
       pmdn226 LIKE pmdn_t.pmdn226, #长效期每次送货量
       pmdn227 LIKE pmdn_t.pmdn227, #补货规格说明
       pmdn058 LIKE pmdn_t.pmdn058, #预算科目
       pmdn228 LIKE pmdn_t.pmdn228  #商品品类
END RECORD
#161124-00048#8 mod-E
DEFINE p_pmal002  LIKE pmal_t.pmal002
#161124-00048#8 mod-S
#DEFINE r_pmdn     RECORD LIKE pmdn_t.*
DEFINE r_pmdn RECORD  #採購單身明細檔
       pmdnent LIKE pmdn_t.pmdnent, #企业编号
       pmdnsite LIKE pmdn_t.pmdnsite, #营运据点
       pmdnunit LIKE pmdn_t.pmdnunit, #应用组织
       pmdndocno LIKE pmdn_t.pmdndocno, #采购单号
       pmdnseq LIKE pmdn_t.pmdnseq, #项次
       pmdn001 LIKE pmdn_t.pmdn001, #料件编号
       pmdn002 LIKE pmdn_t.pmdn002, #产品特征
       pmdn003 LIKE pmdn_t.pmdn003, #包装容器
       pmdn004 LIKE pmdn_t.pmdn004, #作业编号
       pmdn005 LIKE pmdn_t.pmdn005, #作业序
       pmdn006 LIKE pmdn_t.pmdn006, #采购单位
       pmdn007 LIKE pmdn_t.pmdn007, #采购数量
       pmdn008 LIKE pmdn_t.pmdn008, #参考单位
       pmdn009 LIKE pmdn_t.pmdn009, #参考数量
       pmdn010 LIKE pmdn_t.pmdn010, #计价单位
       pmdn011 LIKE pmdn_t.pmdn011, #计价数量
       pmdn012 LIKE pmdn_t.pmdn012, #出货日期
       pmdn013 LIKE pmdn_t.pmdn013, #到厂日期
       pmdn014 LIKE pmdn_t.pmdn014, #到库日期
       pmdn015 LIKE pmdn_t.pmdn015, #单价
       pmdn016 LIKE pmdn_t.pmdn016, #税种
       pmdn017 LIKE pmdn_t.pmdn017, #税率
       pmdn019 LIKE pmdn_t.pmdn019, #子件特性
       pmdn020 LIKE pmdn_t.pmdn020, #紧急度
       pmdn021 LIKE pmdn_t.pmdn021, #保税
       pmdn022 LIKE pmdn_t.pmdn022, #部分交货
       pmdnorga LIKE pmdn_t.pmdnorga, #付款据点
       pmdn023 LIKE pmdn_t.pmdn023, #送货供应商
       pmdn024 LIKE pmdn_t.pmdn024, #多交期
       pmdn025 LIKE pmdn_t.pmdn025, #收货地址编号
       pmdn026 LIKE pmdn_t.pmdn026, #账款地址编号
       pmdn027 LIKE pmdn_t.pmdn027, #供应商料号
       pmdn028 LIKE pmdn_t.pmdn028, #收货库位
       pmdn029 LIKE pmdn_t.pmdn029, #收货储位
       pmdn030 LIKE pmdn_t.pmdn030, #收货批号
       pmdn031 LIKE pmdn_t.pmdn031, #运输方式
       pmdn032 LIKE pmdn_t.pmdn032, #取货模式
       pmdn033 LIKE pmdn_t.pmdn033, #备品率
       pmdn034 LIKE pmdn_t.pmdn034, #no use
       pmdn035 LIKE pmdn_t.pmdn035, #价格核决
       pmdn036 LIKE pmdn_t.pmdn036, #项目编号
       pmdn037 LIKE pmdn_t.pmdn037, #WBS编号
       pmdn038 LIKE pmdn_t.pmdn038, #活动编号
       pmdn039 LIKE pmdn_t.pmdn039, #费用原因
       pmdn040 LIKE pmdn_t.pmdn040, #取价来源
       pmdn041 LIKE pmdn_t.pmdn041, #价格参考单号
       pmdn042 LIKE pmdn_t.pmdn042, #价格参考项次
       pmdn043 LIKE pmdn_t.pmdn043, #取出价格
       pmdn044 LIKE pmdn_t.pmdn044, #价差比
       pmdn045 LIKE pmdn_t.pmdn045, #行状态
       pmdn046 LIKE pmdn_t.pmdn046, #税前金额
       pmdn047 LIKE pmdn_t.pmdn047, #含税金额
       pmdn048 LIKE pmdn_t.pmdn048, #税额
       pmdn049 LIKE pmdn_t.pmdn049, #理由码
       pmdn050 LIKE pmdn_t.pmdn050, #备注
       pmdn051 LIKE pmdn_t.pmdn051, #留置/结案理由码
       pmdn052 LIKE pmdn_t.pmdn052, #检验否
       pmdn053 LIKE pmdn_t.pmdn053, #库存管理特征
       pmdn200 LIKE pmdn_t.pmdn200, #商品条码
       pmdn201 LIKE pmdn_t.pmdn201, #包装单位
       pmdn202 LIKE pmdn_t.pmdn202, #包装数量
       pmdn203 LIKE pmdn_t.pmdn203, #收货部门
       pmdn204 LIKE pmdn_t.pmdn204, #No Use
       pmdn205 LIKE pmdn_t.pmdn205, #要货组织
       pmdn206 LIKE pmdn_t.pmdn206, #库存量
       pmdn207 LIKE pmdn_t.pmdn207, #采购在途量
       pmdn208 LIKE pmdn_t.pmdn208, #前日销售量
       pmdn209 LIKE pmdn_t.pmdn209, #上月销量
       pmdn210 LIKE pmdn_t.pmdn210, #第一周销量
       pmdn211 LIKE pmdn_t.pmdn211, #第二周销量
       pmdn212 LIKE pmdn_t.pmdn212, #第三周销量
       pmdn213 LIKE pmdn_t.pmdn213, #第四周销量
       pmdn214 LIKE pmdn_t.pmdn214, #采购渠道
       pmdn215 LIKE pmdn_t.pmdn215, #渠道性质
       pmdn216 LIKE pmdn_t.pmdn216, #经营方式
       pmdn217 LIKE pmdn_t.pmdn217, #结算方式
       pmdn218 LIKE pmdn_t.pmdn218, #合同编号
       pmdn219 LIKE pmdn_t.pmdn219, #协议编号
       pmdn220 LIKE pmdn_t.pmdn220, #采购人员
       pmdn221 LIKE pmdn_t.pmdn221, #采购部门
       pmdn222 LIKE pmdn_t.pmdn222, #采购中心
       pmdn223 LIKE pmdn_t.pmdn223, #配送中心
       pmdn224 LIKE pmdn_t.pmdn224, #采购失效日
       pmdn900 LIKE pmdn_t.pmdn900, #保留字段str
       pmdn999 LIKE pmdn_t.pmdn999, #保留字段end
       pmdn225 LIKE pmdn_t.pmdn225, #最终收货组织
       pmdn054 LIKE pmdn_t.pmdn054, #还料数量
       pmdn055 LIKE pmdn_t.pmdn055, #还量参考数量
       pmdn056 LIKE pmdn_t.pmdn056, #还价数量
       pmdn057 LIKE pmdn_t.pmdn057, #还价参考数量
       pmdn226 LIKE pmdn_t.pmdn226, #长效期每次送货量
       pmdn227 LIKE pmdn_t.pmdn227, #补货规格说明
       pmdn058 LIKE pmdn_t.pmdn058, #预算科目
       pmdn228 LIKE pmdn_t.pmdn228  #商品品类
END RECORD
#161124-00048#8 mod-E
DEFINE l_imaf158  LIKE imaf_t.imaf158
DEFINE l_n        LIKE type_t.num5 
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdn.* = p_pmdn.*
   LET l_n = 0

   IF NOT cl_null(p_pmal002) THEN
      SELECT COUNT(*) INTO l_n
        FROM pmap_t
       WHERE pmapent = g_enterprise
         AND pmapsite = g_site
         AND pmap001 = p_pmdl004
         AND pmap002 = p_pmal002
         AND pmap003 = r_pmdn.pmdn001
         AND pmap004 = r_pmdn.pmdn002
      #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
      IF l_n > 0 THEN
         #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改 
         SELECT pmap009,pmap012,pmap014,pmap005
           INTO r_pmdn.pmdnunit,         #收貨據點 
                r_pmdn.pmdn025,          #收貨地址代碼 
                r_pmdn.pmdn031,          #運輸方式 
                r_pmdn.pmdn003           #包裝容器  
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmapsite = g_site
            AND pmap001 = p_pmdl004
            AND pmap002 = p_pmal002
            AND pmap003 = r_pmdn.pmdn001
            AND pmap004 = r_pmdn.pmdn002
      END IF
   END IF

   IF cl_null(p_pmal002) OR l_n = 0 THEN
      #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件 
      #2015/01/05 採購不再預設庫儲資料，否則收貨、入庫時會沒辦法修改
      SELECT imaf157
        INTO r_pmdn.pmdn003          #包裝容器 
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = r_pmdn.pmdn001
   END IF

   #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
   #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
   #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
   #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
   LET r_pmdn.pmdn008 = ''      #參考單位  
   LET r_pmdn.pmdn033 = ''      #備品率   
   LET r_pmdn.pmdn019 = '1'     #子件特性   

   LET l_imaf158 = ''
   SELECT imaf158,imaf165,imaf015
     INTO l_imaf158,r_pmdn.pmdn033,r_pmdn.pmdn008
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = r_pmdn.pmdn001
   CASE l_imaf158
      WHEN '1'
         LET r_pmdn.pmdn019 = '2'
      WHEN '2'
         LET r_pmdn.pmdn019 = '3'
   END CASE

#   #整體參數使用採購計價單位時:
#   #[C:計價單位]=[T:料件據點進銷存檔].[C:採購計價單位] 
#   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
#      SELECT imaf144 INTO r_pmdn.pmdn010
#        FROM imaf_t
#       WHERE imafent = g_enterprise
#         AND imafsite = g_site
#         AND imaf001 = r_pmdn.pmdn001
#   END IF

   #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
   #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
   LET r_pmdn.pmdn027 = ''
   SELECT pmao004 INTO r_pmdn.pmdn027
     FROM pmao_t
    WHERE pmaoent = g_enterprise 
      AND pmao001 = p_pmdl004
      AND pmao002 = r_pmdn.pmdn001
      AND pmao003 = r_pmdn.pmdn002
      AND pmao007 = 'Y'
      AND pmao000 = '1'    #161221-00064#8 add
   IF cl_null(r_pmdn.pmdn027) THEN
      SELECT pmao004 INTO r_pmdn.pmdn027
        FROM pmao_t
       WHERE pmaoent = g_enterprise
         AND pmao001 = p_pmdl004
         AND pmao002 = r_pmdn.pmdn001
         AND pmao003 = r_pmdn.pmdn002
#         AND pmao007 = 'Y'    #161221-00064#8 marked
         AND pmao000 = '1'    #161221-00064#8 add
         AND rownum = 1
   END IF

   RETURN r_pmdn.*
END FUNCTION

################################################################################
#根据请购单单别抓取后续单别采购单单别
################################################################################
PRIVATE FUNCTION apmp480_get_doc(p_site,p_oobm003,p_control,p_oobn002,p_produce,p_show)
   DEFINE p_site      LIKE ooef_t.ooef001  #營運據點(組織編號)
   DEFINE p_oobm003   LIKE oobm_t.oobm003  #財務單據別參照表號(若Null同進銷存單據別參照表)
   DEFINE p_control   LIKE ooha_t.ooha002  #控制組類型(1.研發2.銷售3.請購4.採購5.庫存6.生管)
   DEFINE p_oobn002   LIKE type_t.chr20    #前置單號or單別
   DEFINE p_produce   LIKE oobx_t.oobx003  #後置單別的單據性質
   DEFINE p_show      LIKE gzze_t.gzze001  #顯示備註(將azzi920的設定顯示在子畫面下方)
   DEFINE r_success   LIKE type_t.num5     #執行結果
   DEFINE r_oobn003   LIKE oobn_t.oobn003  #後置單別
   DEFINE l_ooef004   LIKE ooef_t.ooef004  #進銷存單據別參照表號
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_where     STRING
   DEFINE l_only      LIKE type_t.chr1
   DEFINE l_oobn003   LIKE oobn_t.oobn003

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_oobn003 = ''

   IF cl_null(p_site) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00009'   #傳入的營運據點代碼為空
      LET g_errparam.extend = ''
      LET g_errparam.popup = g_errshow
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_oobn003
   END IF

   IF cl_null(p_control) OR p_control NOT MATCHES '[123456]' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00280'   #傳入參數為空或傳入值不正確!
      LET g_errparam.extend = ''
      LET g_errparam.popup = g_errshow
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   IF cl_null(p_oobn002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00532'   #單別不可為空！
      LET g_errparam.extend = ''
      LET g_errparam.popup = g_errshow
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_oobn003
   END IF

   IF cl_null(p_produce) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00610'   #傳入單據性質為空！
      LET g_errparam.extend = ''
      LET g_errparam.popup = g_errshow
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success,r_oobn003
   END IF

   #單號擷取單別
   CALL s_aooi200_get_slip(p_oobn002) RETURNING r_success,p_oobn002
   IF NOT r_success THEN
      RETURN r_success,r_oobn003
   END IF
   
   #由營運據點抓取aooi100單據別參照表號
   CALL s_aooi100_sel_ooef004(p_site) RETURNING r_success,l_ooef004
   IF NOT r_success THEN
      RETURN r_success,r_oobn003
   END IF

   IF cl_null(p_oobm003) THEN
      LET p_oobm003 = l_ooef004   #財務單據別參照表號(若Null同進銷存單據別參照表)
   END IF

   #預設後置單別
   CALL apmp480_aooi210_default(l_ooef004,p_oobm003,p_oobn002,p_produce) RETURNING l_oobn003,l_only
   IF cl_null(l_oobn003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-01054' #請購單別%1沒有設定對應的採購單別！
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_oobn002
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_oobn003
   END IF
   LET r_oobn003 = l_oobn003
   RETURN r_success,r_oobn003
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp480_aooi210_default(p_oobm002,p_oobm003,p_oobn002,p_produce)
   DEFINE p_oobm002  LIKE oobm_t.oobm002 #進銷存單據別參照表
   DEFINE p_oobm003  LIKE oobm_t.oobm003 #財務單據別參照表
   DEFINE p_oobn002  LIKE oobn_t.oobn002 #前置單別
   DEFINE p_produce  LIKE oobx_t.oobx003 #後置單據性質

   DEFINE r_oobn003  LIKE oobn_t.oobn002 #後置單別
   DEFINE r_only     LIKE type_t.chr1

   DEFINE l_sql      STRING
   DEFINE l_slip     LIKE oobn_t.oobn003

   DEFINE l_num      LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_oobn003 = ''
   LET r_only = 'N'

   #先確認有無設置
   CALL apmp480_aooi210_set_chk(p_oobn002,p_produce,p_oobm002,p_oobm003,'1') RETURNING l_num
   IF l_num > 0 THEN
      LET l_sql = "SELECT oobn003",
                  "  FROM oobm_t,oobn_t",
                  " WHERE oobment = oobnent AND oobnent = '",g_enterprise,"'",
                  "   AND oobm001 = oobn001",
                  "   AND oobm002 = '",p_oobm002,"'",
                  "   AND oobm003 = '",p_oobm003,"'",
                  "   AND oobmstus = 'Y'",
                  "   AND oobn002 = '",p_oobn002,"'",
                  "   AND oobn003 IN (SELECT oobx001 FROM oobx_t",
                  "                    WHERE oobxent = '",g_enterprise,"'",
                  "                      AND oobx003 = '",p_produce,"')",
                  " ORDER BY oobn003"

      PREPARE s_aooi210_sql_pre2 FROM l_sql
      DECLARE s_aooi210_sql_cs2 SCROLL CURSOR FOR s_aooi210_sql_pre2

      OPEN s_aooi210_sql_cs2
      FETCH FIRST s_aooi210_sql_cs2 INTO r_oobn003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'FETCH'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = g_errshow
         CALL cl_err()

         LET r_oobn003 = ''
      END IF

      IF l_num = 1 THEN
         LET r_only = 'Y'
      END IF
   END IF

   RETURN r_oobn003,r_only
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp480_aooi210_set_chk(p_docno,p_produce,p_oobm002,p_oobm003,p_type)
   DEFINE p_docno    LIKE oobn_t.oobn002  #單別
   DEFINE p_produce  LIKE oobx_t.oobx003  #要得出的單別的單據性質
   DEFINE p_oobm002  LIKE oobm_t.oobm002  #進銷存單據別參照表
   DEFINE p_oobm003  LIKE oobm_t.oobm003  #財務單據別參照表
   DEFINE p_type     LIKE type_t.chr1     #檢核類型:1.檢核後置單別、2.檢核前置單別

   DEFINE r_num      LIKE type_t.num5     #已設定單據流程的數量

   WHENEVER ERROR CONTINUE

   LET r_num = 0
   CASE p_type
      WHEN '1'  #檢查後置單別
         #先確認有無設置後置單別
         SELECT COUNT(oobn003) INTO r_num
           FROM oobm_t,oobn_t
          WHERE oobment = oobnent AND oobnent = g_enterprise
            AND oobm001 = oobn001
            AND oobm002 = p_oobm002
            AND oobm003 = p_oobm003
            AND oobmstus = 'Y'
            AND oobn002 = p_docno
            AND oobn003 IN (SELECT oobx001 FROM oobx_t
                             WHERE oobxent = g_enterprise
                               AND oobx003 = p_produce)

      WHEN '2'  #檢查前置單別
         #先確認有無設置前置單別
         SELECT COUNT(oobn002) INTO r_num
           FROM oobm_t,oobn_t
          WHERE oobment = oobnent AND oobnent = g_enterprise
            AND oobm001 = oobn001
            AND oobm002 = p_oobm002
            AND oobm003 = p_oobm003
            AND oobmstus = 'Y'
            AND oobn003 = p_docno
            AND oobn002 IN (SELECT oobx001 FROM oobx_t
                             WHERE oobxent = g_enterprise
                               AND oobx003 = p_produce)
   END CASE

   IF cl_null(r_num) THEN   #aooi210沒有設定
      LET r_num = 0
   END IF

   RETURN r_num
END FUNCTION

################################################################################
#根据采购单单别去抓取aooi200单别预设作业栏位值
################################################################################
PRIVATE FUNCTION apmp480_get_col_default(p_pmdl)
   #161124-00048#8 mod-S
#   DEFINE p_pmdl     RECORD LIKE pmdl_t.*
#   DEFINE r_pmdl     RECORD LIKE pmdl_t.*
   DEFINE p_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   DEFINE r_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#8 mod-E
   
   WHENEVER ERROR CONTINUE 

   LET r_pmdl.* = p_pmdl.*

   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdldocdt',r_pmdl.pmdldocdt)
        RETURNING r_pmdl.pmdldocdt
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl001',r_pmdl.pmdl001)
        RETURNING r_pmdl.pmdl001
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl002',r_pmdl.pmdl002)
        RETURNING r_pmdl.pmdl002
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl003',r_pmdl.pmdl003)
        RETURNING r_pmdl.pmdl003
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl004',r_pmdl.pmdl004)
        RETURNING r_pmdl.pmdl004
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl005',r_pmdl.pmdl005)
        RETURNING r_pmdl.pmdl005
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl006',r_pmdl.pmdl006)
        RETURNING r_pmdl.pmdl006
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl007',r_pmdl.pmdl007)
        RETURNING r_pmdl.pmdl007
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl008',r_pmdl.pmdl008)
        RETURNING r_pmdl.pmdl008
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl009',r_pmdl.pmdl009)
        RETURNING r_pmdl.pmdl009
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl010',r_pmdl.pmdl010)
        RETURNING r_pmdl.pmdl010 
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl011',r_pmdl.pmdl011)
        RETURNING r_pmdl.pmdl011
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl012',r_pmdl.pmdl012)
        RETURNING r_pmdl.pmdl012
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl013',r_pmdl.pmdl013)
        RETURNING r_pmdl.pmdl013
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl015',r_pmdl.pmdl015)
        RETURNING r_pmdl.pmdl015
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl016',r_pmdl.pmdl016)
        RETURNING r_pmdl.pmdl016
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl017',r_pmdl.pmdl017)
        RETURNING r_pmdl.pmdl017
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl018',r_pmdl.pmdl018)
        RETURNING r_pmdl.pmdl018
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl019',r_pmdl.pmdl019)
        RETURNING r_pmdl.pmdl019
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl020',r_pmdl.pmdl020)
        RETURNING r_pmdl.pmdl020
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl021',r_pmdl.pmdl021)
        RETURNING r_pmdl.pmdl021
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl022',r_pmdl.pmdl022)
        RETURNING r_pmdl.pmdl022
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl023',r_pmdl.pmdl023)
        RETURNING r_pmdl.pmdl023
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl024',r_pmdl.pmdl024)
        RETURNING r_pmdl.pmdl024
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl025',r_pmdl.pmdl025)
        RETURNING r_pmdl.pmdl025 
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl026',r_pmdl.pmdl026)
        RETURNING r_pmdl.pmdl026
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl027',r_pmdl.pmdl027)
        RETURNING r_pmdl.pmdl027
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl028',r_pmdl.pmdl028)
        RETURNING r_pmdl.pmdl028
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl029',r_pmdl.pmdl029)
        RETURNING r_pmdl.pmdl029
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl030',r_pmdl.pmdl030)
        RETURNING r_pmdl.pmdl030
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl031',r_pmdl.pmdl031)
        RETURNING r_pmdl.pmdl031
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl032',r_pmdl.pmdl032)
        RETURNING r_pmdl.pmdl032
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl033',r_pmdl.pmdl033)
        RETURNING r_pmdl.pmdl033
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl040',r_pmdl.pmdl040)
        RETURNING r_pmdl.pmdl040
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl041',r_pmdl.pmdl041)
        RETURNING r_pmdl.pmdl041
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl042',r_pmdl.pmdl042)
        RETURNING r_pmdl.pmdl042
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl043',r_pmdl.pmdl043)
        RETURNING r_pmdl.pmdl043
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl044',r_pmdl.pmdl044)
        RETURNING r_pmdl.pmdl044
   CALL s_aooi200_get_doc_default(g_site,'1',r_pmdl.pmdldocno,'pmdl046',r_pmdl.pmdl046)
        RETURNING r_pmdl.pmdl046

   RETURN r_pmdl.*
END FUNCTION

################################################################################
#获取据点的出货地址帐款地址
################################################################################
PRIVATE FUNCTION apmp480_get_oofb019(p_site,p_oofb008)
DEFINE p_site     LIKE ooef_t.ooef001
DEFINE p_oofb008  LIKE oofb_t.oofb008
DEFINE l_oofa001  LIKE oofa_t.oofa001
DEFINE r_oofb019  LIKE oofb_t.oofb019

   WHENEVER ERROR CONTINUE

   LET r_oofb019 = ''

   #獲取當前營運據點的聯絡對象識別碼
   SELECT oofa001 INTO l_oofa001 
     FROM oofa_t 
    WHERE oofaent = g_enterprise 
      AND oofa002 = '1' 
      AND oofa003 = p_site
   IF NOT cl_null(l_oofa001) THEN
      #主要出貨地址
         SELECT oofb019 INTO r_oofb019
           FROM oofb_t
          WHERE oofbent = g_enterprise
            AND oofb002 = l_oofa001
            AND oofb008 = p_oofb008
            AND oofb010 = 'Y'
         #若沒有勾選主要的
         IF cl_null(r_oofb019) THEN
            SELECT oofb019,oofb011 INTO r_oofb019
              FROM oofb_t
             WHERE oofbent = g_enterprise
               AND oofb002 = l_oofa001
               AND oofb008 = p_oofb008
               AND rownum = 1
         END IF
         #呼叫地址組合應用元件
   END IF
   RETURN r_oofb019
END FUNCTION

#end add-point
 
{</section>}
 
