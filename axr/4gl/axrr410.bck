#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-01-20 14:44:11), PR版次:0006(2016-12-02 09:50:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: axrr410
#+ Description: 應收帳款沖銷單列印
#+ Creator....: 01727(2015-01-05 16:59:02)
#+ Modifier...: 01727 -SD/PR- 02481
 
{</section>}
 
{<section id="axrr410.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#8  2016/03/11 By 02599   增加控制组权限控管,单据性质默认赋值‘41’
#160518-00075#12 2016/07/28 By 01531   (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
#160731-00372#1  2016/08/16 By 07900   客户开窗不要开供应商
#161128-00061#4  2016/12/02 by 02481   标准程式定义采用宣告模式,弃用.*写法

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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       xrdasite LIKE xrda_t.xrdasite, 
   xrdasite_desc LIKE type_t.chr80, 
   xrda001 LIKE xrda_t.xrda001, 
   xrdald LIKE xrda_t.xrdald, 
   xrdald_desc LIKE type_t.chr80, 
   xrdacomp_desc LIKE type_t.chr80, 
   xrdadocno LIKE xrda_t.xrdadocno, 
   xrda004 LIKE xrda_t.xrda004, 
   xrdadocdt LIKE xrda_t.xrdadocdt, 
   xrda003 LIKE xrda_t.xrda003, 
   xrda005 LIKE xrda_t.xrda005, 
   xrda014 LIKE xrda_t.xrda014, 
   b_style LIKE type_t.chr500, 
   b_print LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#161128-00061#4-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* 
DEFINE g_glaa  RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
#161128-00061#4-----modify--end----------
DEFINE g_sql_ctrl  STRING   #151231-00010#8 add
DEFINE g_sql_ctr2       STRING                #160518-00075#12
DEFINE g_sql_ctr3       STRING                #160518-00075#12
DEFINE g_glaa024        LIKE glaa_t.glaa024   #160518-00075#12
DEFINE l_site_len       LIKE type_t.num5      #160518-00075#12 #SITE段长度
DEFINE l_slip_len       LIKE type_t.num5      #160518-00075#12 #单别段长度 
DEFINE l_i              LIKE type_t.num5      #160518-00075#12
DEFINE l_j              LIKE type_t.num5      #160518-00075#12
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrr410.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axrr410_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrr410 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrr410_init()
 
      #進入選單 Menu (="N")
      CALL axrr410_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrr410
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrr410.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrr410_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL cl_set_combo_scc("xrda001","8307")
   #151231-00010#8--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#8--add--end
   
   #160518-00075#12 add s--- 
   #用g_site的單別參照表
   LET g_sql_ctr3 = NULL
   LET g_sql_ctr2 = NULL
   
   SELECT glaa024 INTO g_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_site AND glaa014 = 'Y' 

   CALL s_control_get_docno_sql_q(g_user,g_dept,g_glaa024) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3 
     
   #SITE 长度
   LET l_site_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
   
   #单别长度
   LET l_slip_len = cl_get_para(g_enterprise,g_site,'E-COM-0001')
   
   #第一个分隔符
   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
      LET l_i = l_site_len + 2
      LET l_j = l_slip_len
   ELSE
      LET l_i = 1
      LET l_j = l_slip_len
   END IF    

   #160518-00075#12 add e---     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrr410.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr410_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xrdasite,g_master.xrda001,g_master.xrdald,g_master.b_style,g_master.b_print  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               CALL axrr410_def()
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdasite
            
            #add-point:AFTER FIELD xrdasite name="input.a.xrdasite"
            IF NOT cl_null(g_master.xrdasite) THEN
               CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'site')
                  RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
               DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
               DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
               IF NOT l_success THEN NEXT FIELD CURRENT END IF
            ELSE
               LET g_master.xrdasite_desc = ''
            END IF
            #161128-00061#4-----modify--begin----------
            #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                    glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                    glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                    glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                    glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161128-00061#4----modify--end----------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
            DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
            DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
            IF NOT cl_null(g_glaa.glaacomp) THEN
               CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_master.xrdacomp_desc
               LET g_master.xrdacomp_desc = g_glaa.glaacomp,"(",g_master.xrdacomp_desc,")"
            ELSE
               LET g_master.xrdacomp_desc = ""
            END IF
            DISPLAY BY NAME g_master.xrdacomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdasite
            #add-point:BEFORE FIELD xrdasite name="input.b.xrdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdasite
            #add-point:ON CHANGE xrdasite name="input.g.xrdasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda001
            #add-point:BEFORE FIELD xrda001 name="input.b.xrda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda001
            
            #add-point:AFTER FIELD xrda001 name="input.a.xrda001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrda001
            #add-point:ON CHANGE xrda001 name="input.g.xrda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdald
            
            #add-point:AFTER FIELD xrdald name="input.a.xrdald"
            IF NOT cl_null(g_master.xrdald) THEN 
               CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'ld')
                  RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
               DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
               DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
               IF NOT l_success THEN
                  #161128-00061#4-----modify--begin----------
                  #SELECT * INTO g_glaa.* 
                   SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                          glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                          glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                          glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                          glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                          glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                  #161128-00061#4----modify--end----------
                  FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_master.xrdald
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_master.xrdald_desc = ''
            END IF
            #161128-00061#4-----modify--begin----------
            #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                    glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                    glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                    glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                    glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
            #161128-00061#4----modify--end---------- 
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
            DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
            DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
            IF NOT cl_null(g_glaa.glaacomp) THEN
               CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_master.xrdacomp_desc
               LET g_master.xrdacomp_desc = g_glaa.glaacomp,"(",g_master.xrdacomp_desc,")"
            ELSE
               LET g_master.xrdacomp_desc = ""
            END IF
            DISPLAY BY NAME g_master.xrdacomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdald
            #add-point:BEFORE FIELD xrdald name="input.b.xrdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdald
            #add-point:ON CHANGE xrdald name="input.g.xrdald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_style
            #add-point:BEFORE FIELD b_style name="input.b.b_style"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_style
            
            #add-point:AFTER FIELD b_style name="input.a.b_style"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_style
            #add-point:ON CHANGE b_style name="input.g.b_style"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_print
            #add-point:BEFORE FIELD b_print name="input.b.b_print"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_print
            
            #add-point:AFTER FIELD b_print name="input.a.b_print"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_print
            #add-point:ON CHANGE b_print name="input.g.b_print"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdasite
            #add-point:ON ACTION controlp INFIELD xrdasite name="input.c.xrdasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.xrdasite             #給予default值
            LET g_qryparam.default2 = "" #g_master.xrah002 #帳務中心
            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_xrah002_1()                                #呼叫開窗

            LET g_master.xrdasite = g_qryparam.return1              
            #LET g_master.xrah002 = g_qryparam.return2 
            DISPLAY g_master.xrdasite TO xrdasite              #
            #DISPLAY g_master.xrah002 TO xrah002 #帳務中心
            NEXT FIELD xrdasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xrda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda001
            #add-point:ON ACTION controlp INFIELD xrda001 name="input.c.xrda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrdald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdald
            #add-point:ON ACTION controlp INFIELD xrdald name="input.c.xrdald"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_style
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_style
            #add-point:ON ACTION controlp INFIELD b_style name="input.c.b_style"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_print
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_print
            #add-point:ON ACTION controlp INFIELD b_print name="input.c.b_print"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xrdadocno,xrda004,xrdadocdt,xrda003,xrda005,xrda014
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xrdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdadocno
            #add-point:ON ACTION controlp INFIELD xrdadocno name="construct.c.xrdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#8--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = xrdaent",
                                      "            AND pmaa001 = xrda005 )"
            END IF
            #151231-00010#8--add--end
            #160518-00075#12 add s---            
            IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
               IF cl_null(g_qryparam.where) THEN 
                  LET g_qryparam.where = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where," AND (substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
            END IF
            #160518-00075#12 add e---               
            CALL q_xrdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrdadocno  #顯示到畫面上
            NEXT FIELD xrdadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdadocno
            #add-point:BEFORE FIELD xrdadocno name="construct.b.xrdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdadocno
            
            #add-point:AFTER FIELD xrdadocno name="construct.a.xrdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda004
            #add-point:ON ACTION controlp INFIELD xrda004 name="construct.c.xrda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"  #160731-00372#1 2016/08/16 By 07900 add      
            CALL q_pmaa001()                  #呼叫開窗            
            DISPLAY g_qryparam.return1 TO xrda004  #顯示到畫面上
            NEXT FIELD xrda004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda004
            #add-point:BEFORE FIELD xrda004 name="construct.b.xrda004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda004
            
            #add-point:AFTER FIELD xrda004 name="construct.a.xrda004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdadocdt
            #add-point:BEFORE FIELD xrdadocdt name="construct.b.xrdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdadocdt
            
            #add-point:AFTER FIELD xrdadocdt name="construct.a.xrdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdadocdt
            #add-point:ON ACTION controlp INFIELD xrdadocdt name="construct.c.xrdadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xrda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda003
            #add-point:ON ACTION controlp INFIELD xrda003 name="construct.c.xrda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrda003  #顯示到畫面上
            NEXT FIELD xrda003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda003
            #add-point:BEFORE FIELD xrda003 name="construct.b.xrda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda003
            
            #add-point:AFTER FIELD xrda003 name="construct.a.xrda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda005
            #add-point:ON ACTION controlp INFIELD xrda005 name="construct.c.xrda005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#8--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#8--add--end

           #160731-00372#1   2016/08/15  By 07900 --s--
            IF cl_null(g_qryparam.where) THEN
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"
            ELSE 
               LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3') AND ",g_qryparam.where            
            END IF 
            #160731-00372#1   2016/08/15  By 07900 --e--

            CALL q_pmaa001()                   #呼叫開窗
           
            DISPLAY g_qryparam.return1 TO xrda005  #顯示到畫面上
            NEXT FIELD xrda005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda005
            #add-point:BEFORE FIELD xrda005 name="construct.b.xrda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda005
            
            #add-point:AFTER FIELD xrda005 name="construct.a.xrda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda014
            #add-point:ON ACTION controlp INFIELD xrda014 name="construct.c.xrda014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrda014()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrda014  #顯示到畫面上
            NEXT FIELD xrda014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda014
            #add-point:BEFORE FIELD xrda014 name="construct.b.xrda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda014
            
            #add-point:AFTER FIELD xrda014 name="construct.a.xrda014"
            
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL axrr410_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axrr410_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
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
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL axrr410_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
 
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL axrr410_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrr410_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axrr410.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrr410_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axrr410.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrr410_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xrdadocno,xrda004,xrdadocdt,xrda003,xrda005,xrda014")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF g_master.wc = " 1=1" THEN
      LET g_master.wc = " xrdasite = '",g_master.xrdasite,"'"
   ELSE
      LET g_master.wc = g_master.wc," AND xrdasite = '",g_master.xrdasite,"'"
   END IF
   IF NOT cl_null(g_master.xrda001) THEN
      LET g_master.wc = g_master.wc," AND xrda001 = '",g_master.xrda001,"'"
   END IF
   IF NOT cl_null(g_master.b_style) THEN
      IF g_master.b_style = '1' THEN
         LET g_master.wc = g_master.wc," AND xrdastus = 'N'"
      END IF
      IF g_master.b_style = '2' THEN
         LET g_master.wc = g_master.wc," AND xrdastus = 'Y'"
      END IF
   END IF
   IF NOT cl_null(g_master.b_print) THEN
      IF g_master.b_print = '1' THEN
         LET g_master.wc = g_master.wc," AND xrda016 = 0"
      END IF
      IF g_master.b_print = '2' THEN
         LET g_master.wc = g_master.wc," AND xrda016 > 0"
      END IF
   END IF
   #151231-00010#8--add--str--
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      IF cl_null(g_master.wc) THEN
         LET g_master.wc = " EXISTS (SELECT 1 FROM pmaa_t ",
                           "          WHERE pmaaent = ",g_enterprise,
                           "            AND ",g_sql_ctrl,
                           "            AND pmaaent = xrdaent",
                           "            AND pmaa001 = xrda005)"
      ELSE
         LET g_master.wc = g_master.wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                       "              WHERE pmaaent = ",g_enterprise,
                                       "                AND ",g_sql_ctrl,
                                       "                AND pmaaent = xrdaent",
                                       "                AND pmaa001 = xrda005)"
      END IF
   END IF
   #151231-00010#8--add--end
   
   #160518-00075#12 add s---            
   IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
      IF NOT cl_null(g_master.wc) THEN
         LET g_master.wc = g_master.wc," AND (substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
      ELSE
         LET g_master.wc =  " (substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
      END IF
   END IF
   #160518-00075#12 add e---    
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL axrr410_g01(g_master.wc)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrr410_process_cs CURSOR FROM ls_sql
#  FOREACH axrr410_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axrr410.get_buffer" >}
PRIVATE FUNCTION axrr410_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xrdasite = p_dialog.getFieldBuffer('xrdasite')
   LET g_master.xrda001 = p_dialog.getFieldBuffer('xrda001')
   LET g_master.xrdald = p_dialog.getFieldBuffer('xrdald')
   LET g_master.b_style = p_dialog.getFieldBuffer('b_style')
   LET g_master.b_print = p_dialog.getFieldBuffer('b_print')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr410.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 進入INPUT段給默認值
# Memo...........:
# Usage..........: CALL axrr410_def()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/01/06 By zhangwei
# Modify.........:
################################################################################
PRIVATE FUNCTION axrr410_def()
   DEFINE l_xrdacomp    LIKE xrda_t.xrdacomp
   DEFINE l_success     LIKE type_t.chr1

   IF cl_null(g_master.xrdasite) OR cl_null(g_master.xrdald) THEN
      #帳務中心
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xrdasite,g_errno
      #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      CALL s_fin_orga_get_comp_ld(g_master.xrdasite) RETURNING l_success,g_errno,l_xrdacomp,g_master.xrdald   

      #若取不出資料,則不預設帳別
      IF NOT l_success THEN
         LET g_master.xrdald   = ''
      END IF

      CALL s_axrt300_xrca_ref('xrcald',g_master.xrdald,'','') RETURNING l_success,g_master.xrdald_desc
      #161128-00061#4-----modify--begin----------
      #SELECT * INTO g_glaa.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161128-00061#4----modify--end----------
      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrdald
      CALL s_axrt300_xrca_ref('xrcasite',g_master.xrdasite,'','') RETURNING l_success,g_master.xrdasite_desc
      DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
   END IF

   IF NOT cl_null(g_glaa.glaacomp) THEN
      CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_master.xrdacomp_desc
      LET g_master.xrdacomp_desc = g_glaa.glaacomp,"(",g_master.xrdacomp_desc,")"
   ELSE
      LET g_master.xrdacomp_desc = ""
   END IF
   DISPLAY BY NAME g_master.xrdacomp_desc

   #IF cl_null(g_master.xrda001) THEN LET g_master.xrda001 = '1' END IF #151231-00010#8 mark
   IF cl_null(g_master.xrda001) THEN LET g_master.xrda001 = '41' END IF #151231-00010#8 add

   IF cl_null(g_master.b_style)  THEN LET g_master.b_style = '1' END IF
   IF cl_null(g_master.b_print)  THEN LET g_master.b_print = '1' END IF
   DISPLAY BY NAME g_master.xrda001,g_master.b_style,g_master.b_print

END FUNCTION

#end add-point
 
{</section>}
 
