#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp910.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-11-29 16:00:46), PR版次:0002(2016-12-23 11:04:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp910
#+ Description: 應收預算產生憑證
#+ Creator....: 06821(2016-11-28 17:11:50)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgp910.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161222-00003#1   161222 By 06821 abgp910 算出本幣後,貸方金額由借方金額與稅額相減推算,避免傳票拋出產生尾差問題
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
       bgba001 LIKE type_t.chr10, 
   bgba001_desc LIKE type_t.chr80, 
   bgba003 LIKE type_t.chr10, 
   bgba002 LIKE type_t.chr10, 
   bgba006 LIKE type_t.chr10, 
   bgba010 LIKE type_t.chr10, 
   bgba010_desc LIKE type_t.chr80, 
   l_sale LIKE type_t.chr500, 
   l_assets LIKE type_t.chr500, 
   bgba004_s LIKE type_t.num5, 
   bgba004_s_1 LIKE type_t.num5, 
   bgbadocno LIKE type_t.chr20, 
   bgbadocno_desc LIKE type_t.chr80, 
   bgbb002 LIKE type_t.chr500, 
   bgbb002_desc LIKE type_t.chr80, 
   bgbb002_tax LIKE type_t.chr500, 
   bgbb002_tax_desc LIKE type_t.chr80, 
   bgcj007 LIKE type_t.chr10, 
   bgbadocno_1 LIKE type_t.chr20, 
   bgbadocno_2 LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_bgaa      RECORD
         bgaa002   LIKE bgaa_t.bgaa002,
         bgaa003   LIKE bgaa_t.bgaa003,
         bgaa008   LIKE bgaa_t.bgaa008,   #預算細項參照表號
         bgaa009   LIKE bgaa_t.bgaa009,   #現金變動碼參照表
         bgaa011   LIKE bgaa_t.bgaa011
                   END RECORD
DEFINE g_bgbb      RECORD                 #預算憑證單身檔
         bgbbent   LIKE bgbb_t.bgbbent,   #企業編號
         bgbb001   LIKE bgbb_t.bgbb001,   #預算編號
         bgbbdocno LIKE bgbb_t.bgbbdocno, #單據編號
         bgbbseq   LIKE bgbb_t.bgbbseq,   #項次
         bgbb002   LIKE bgbb_t.bgbb002,   #預算細項
         bgbb003   LIKE bgbb_t.bgbb003,   #借方金額
         bgbb004   LIKE bgbb_t.bgbb004,   #貸方金額
         bgbb005   LIKE bgbb_t.bgbb005,   #計量單位
         bgbb006   LIKE bgbb_t.bgbb006,   #數量
         bgbb007   LIKE bgbb_t.bgbb007,   #单价
         bgbb008   LIKE bgbb_t.bgbb008,   #交易幣別
         bgbb009   LIKE bgbb_t.bgbb009,   #汇率
         bgbb010   LIKE bgbb_t.bgbb010,   #原幣金額
         bgbb011   LIKE bgbb_t.bgbb011,   #部門
         bgbb012   LIKE bgbb_t.bgbb012,   #利潤成本中心
         bgbb013   LIKE bgbb_t.bgbb013,   #區域
         bgbb014   LIKE bgbb_t.bgbb014,   #收付款客商
         bgbb015   LIKE bgbb_t.bgbb015,   #帳款客商
         bgbb016   LIKE bgbb_t.bgbb016,   #客群
         bgbb017   LIKE bgbb_t.bgbb017,   #產品類別
         bgbb018   LIKE bgbb_t.bgbb018,   #人員
         bgbb019   LIKE bgbb_t.bgbb019,   #專案編號
         bgbb020   LIKE bgbb_t.bgbb020,   #WBS
         bgbb021   LIKE bgbb_t.bgbb021,   #經營方式
         bgbb022   LIKE bgbb_t.bgbb022,   #通路
         bgbb023   LIKE bgbb_t.bgbb023,   #品牌
         bgbb024   LIKE bgbb_t.bgbb024,   #現金碼
         bgbb025   LIKE bgbb_t.bgbb025,   #自由核算項一
         bgbb026   LIKE bgbb_t.bgbb026,   #自由核算項二
         bgbb027   LIKE bgbb_t.bgbb027,   #自由核算項三
         bgbb028   LIKE bgbb_t.bgbb028,   #自由核算項四
         bgbb029   LIKE bgbb_t.bgbb029,   #自由核算項五
         bgbb030   LIKE bgbb_t.bgbb030,   #自由核算項六
         bgbb031   LIKE bgbb_t.bgbb031,   #自由核算項七
         bgbb032   LIKE bgbb_t.bgbb032,   #自由核算項八
         bgbb033   LIKE bgbb_t.bgbb033,   #自由核算項九
         bgbb034   LIKE bgbb_t.bgbb034    #自由核算項十         
                   END RECORD 
     
DEFINE g_ld        LIKE glaa_t.glaald   
DEFINE g_glaa024   LIKE glaa_t.glaa024   
DEFINE g_master_o  type_master

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp910.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abgp910_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp910 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp910_init()
 
      #進入選單 Menu (="N")
      CALL abgp910_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp910
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp910.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp910_init()
 
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
 
{<section id="abgp910.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp910_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str  STRING
   DEFINE l_bgaa006   LIKE bgaa_t.bgaa006
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL abgp910_qbe_clear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgba001,g_master.bgba002,g_master.bgba010,g_master.l_sale,g_master.l_assets, 
             g_master.bgba004_s,g_master.bgba004_s_1,g_master.bgbadocno,g_master.bgbb002,g_master.bgbb002_tax  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba001
            
            #add-point:AFTER FIELD bgba001 name="input.a.bgba001"
            LET g_master.bgba001_desc = ''
            DISPLAY BY NAME g_master.bgba001_desc
            IF NOT cl_null(g_master.bgba001) THEN
               IF g_master.bgba001 != g_master_o.bgba001 OR cl_null(g_master_o.bgba001) THEN                                
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.bgba001
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_bgaa001") THEN
                     #檢查失敗時後續處理
                     LET g_master.bgba001 = g_master_o.bgba001
                     CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
                     DISPLAY BY NAME g_master.bgba001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查是否使用預測,不使用才可執行
                  LET l_bgaa006 = ''
                  SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgba001 AND bgaastus = 'Y'
                  IF l_bgaa006 <> '1' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00292'
                     LET g_errparam.extend = g_master.bgba001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgba001 = g_master_o.bgba001
                     CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
                     DISPLAY BY NAME g_master.bgba001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #如有管理組織,進行檢核
                  IF NOT cl_null(g_master.bgba010) THEN
                     CALL s_abg2_bgai002_chk(g_master.bgba001,g_master.bgba010,'07') 
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend =g_master.bgba010
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_master.bgba001 = g_master_o.bgba001 
                        LET g_master.bgba010 = ''
                        CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
                        LET g_master.bgba001_desc = s_desc_get_budget_desc(g_master.bgba001)
                        DISPLAY BY NAME g_master.bgba001_desc,g_master.bgba001,g_master.bgba010,g_master.bgba010_desc
                        NEXT FIELD CURRENT
                     END IF         
                  END IF                  
                  
                  INITIALIZE g_bgaa.* TO NULL
                  #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
                  SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
                    FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_master.bgba001
                  LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
                  LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
                  DISPLAY BY NAME g_master.bgba003,g_master.bgba006    

                  #根據各單身預算組織找主帳套
                  LET g_ld = ''
                  LET g_glaa024 = ''
                  SELECT glaald,glaa024 INTO g_ld,g_glaa024
                    FROM glaa_t,ooef_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = ooef017           
                     AND glaaent = ooefent
                     AND ooef001 = g_bgaa.bgaa011
                     AND glaa014 = 'Y'  
                  
                  #清空資料
                  LET g_master.bgbadocno = ''
                  LET g_master.bgbb002 = ''
                  LET g_master.bgbb002_tax = ''
                  LET g_master.bgbadocno_desc = ''
                  LET g_master.bgbb002_desc = ''
                  LET g_master.bgbb002_tax_desc = ''
                  DISPLAY BY NAME g_master.bgbadocno,g_master.bgbb002,g_master.bgbb002_tax,
                                  g_master.bgbadocno_desc,g_master.bgbb002_desc,g_master.bgbb002_tax_desc
               END IF
            END IF         
            CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
            DISPLAY BY NAME g_master.bgba001_desc       
            
            INITIALIZE g_bgaa.* TO NULL
            #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
            SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgba001
            LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
            LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
            DISPLAY BY NAME g_master.bgba003,g_master.bgba006    
             
            #根據各單身預算組織找主帳套
            LET g_ld = ''
            LET g_glaa024 = ''
            SELECT glaald,glaa024 INTO g_ld,g_glaa024
              FROM glaa_t,ooef_t
             WHERE glaaent = g_enterprise
               AND glaacomp = ooef017           
               AND glaaent = ooefent
               AND ooef001 = g_bgaa.bgaa011
               AND glaa014 = 'Y'  
               
            LET g_master_o.* = g_master.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba001
            #add-point:BEFORE FIELD bgba001 name="input.b.bgba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba001
            #add-point:ON CHANGE bgba001 name="input.g.bgba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.bgba002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD bgba002
            END IF 
 
 
 
            #add-point:AFTER FIELD bgba002 name="input.a.bgba002"
            IF NOT cl_null(g_master.bgba002) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba002
            #add-point:BEFORE FIELD bgba002 name="input.b.bgba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba002
            #add-point:ON CHANGE bgba002 name="input.g.bgba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba010
            
            #add-point:AFTER FIELD bgba010 name="input.a.bgba010"
            LET g_master.bgba010_desc = ''
            DISPLAY BY NAME g_master.bgba010_desc
            IF NOT cl_null(g_master.bgba010) THEN
               IF g_master.bgba010 != g_master_o.bgba010 OR cl_null(g_master_o.bgba010) THEN 
                  CALL s_abg2_bgai002_chk(g_master.bgba001,g_master.bgba010,'07')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.bgba010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgba010 = g_master_o.bgba010
                     CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
                     DISPLAY BY NAME g_master.bgba010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
            DISPLAY BY NAME g_master.bgba010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba010
            #add-point:BEFORE FIELD bgba010 name="input.b.bgba010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba010
            #add-point:ON CHANGE bgba010 name="input.g.bgba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_sale
            #add-point:BEFORE FIELD l_sale name="input.b.l_sale"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_sale
            
            #add-point:AFTER FIELD l_sale name="input.a.l_sale"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_sale
            #add-point:ON CHANGE l_sale name="input.g.l_sale"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_assets
            #add-point:BEFORE FIELD l_assets name="input.b.l_assets"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_assets
            
            #add-point:AFTER FIELD l_assets name="input.a.l_assets"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_assets
            #add-point:ON CHANGE l_assets name="input.g.l_assets"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba004_s
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.bgba004_s,"1","1","","","azz-00079",1) THEN
               NEXT FIELD bgba004_s
            END IF 
 
 
 
            #add-point:AFTER FIELD bgba004_s name="input.a.bgba004_s"
            IF NOT cl_null(g_master.bgba004_s) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba004_s
            #add-point:BEFORE FIELD bgba004_s name="input.b.bgba004_s"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba004_s
            #add-point:ON CHANGE bgba004_s name="input.g.bgba004_s"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgba004_s_1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.bgba004_s_1,"1","1","","","azz-00079",1) THEN
               NEXT FIELD bgba004_s_1
            END IF 
 
 
 
            #add-point:AFTER FIELD bgba004_s_1 name="input.a.bgba004_s_1"
            IF NOT cl_null(g_master.bgba004_s_1) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgba004_s_1
            #add-point:BEFORE FIELD bgba004_s_1 name="input.b.bgba004_s_1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgba004_s_1
            #add-point:ON CHANGE bgba004_s_1 name="input.g.bgba004_s_1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbadocno
            
            #add-point:AFTER FIELD bgbadocno name="input.a.bgbadocno"
            #沖銷單別
            IF NOT cl_null(g_master.bgbadocno) THEN
               IF NOT s_aooi200_fin_chk_docno(g_ld,'','',g_master.bgbadocno,g_today,'abgt030') THEN
                  LET g_master.bgbadocno = ''
                  CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
                  DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
            DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbadocno
            #add-point:BEFORE FIELD bgbadocno name="input.b.bgbadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbadocno
            #add-point:ON CHANGE bgbadocno name="input.g.bgbadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb002
            
            #add-point:AFTER FIELD bgbb002 name="input.a.bgbb002"
            LET g_master.bgbb002_desc = ''
            DISPLAY BY NAME g_master.bgbb002_desc
            IF NOT cl_null(g_master.bgbb002) THEN
               IF g_master.bgbb002 != g_master_o.bgbb002 OR cl_null(g_master_o.bgbb002) THEN                                
                  CALL s_abg_bgae001_chk(g_master.bgba001,'',g_master.bgbb002,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbb002 = g_master_o.bgbb002 
                     CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002)RETURNING g_master.bgbb002_desc
                     DISPLAY BY NAME g_master.bgbb002,g_master.bgbb002_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF      
            CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002)RETURNING g_master.bgbb002_desc            
            DISPLAY BY NAME g_master.bgbb002_desc            
            LET g_master_o.* = g_master.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb002
            #add-point:BEFORE FIELD bgbb002 name="input.b.bgbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb002
            #add-point:ON CHANGE bgbb002 name="input.g.bgbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb002_tax
            
            #add-point:AFTER FIELD bgbb002_tax name="input.a.bgbb002_tax"
            LET g_master.bgbb002_tax_desc = ''
            DISPLAY BY NAME g_master.bgbb002_tax_desc
            IF NOT cl_null(g_master.bgbb002_tax) THEN
               IF g_master.bgbb002_tax != g_master_o.bgbb002_tax OR cl_null(g_master_o.bgbb002_tax) THEN                                
                  CALL s_abg_bgae001_chk(g_master.bgba001,'',g_master.bgbb002_tax,'1')RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbb002_tax = g_master_o.bgbb002_tax 
                     CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002_tax)RETURNING g_master.bgbb002_tax_desc
                     DISPLAY BY NAME g_master.bgbb002_tax,g_master.bgbb002_tax_desc
                     NEXT FIELD CURRENT
                  END IF 
               END IF
            END IF   
            CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002_tax)RETURNING g_master.bgbb002_tax_desc
            DISPLAY BY NAME g_master.bgbb002_tax_desc
            LET g_master_o.* = g_master.*

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb002_tax
            #add-point:BEFORE FIELD bgbb002_tax name="input.b.bgbb002_tax"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb002_tax
            #add-point:ON CHANGE bgbb002_tax name="input.g.bgbb002_tax"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba001
            #add-point:ON ACTION controlp INFIELD bgba001 name="input.c.bgba001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba001
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開
            CALL q_bgaa001()
            LET g_master.bgba001 = g_qryparam.return1
            CALL s_desc_get_budget_desc(g_master.bgba001) RETURNING g_master.bgba001_desc
            
            #預算週期/預算幣別
            LET g_master.bgba003 = ''
            LET g_master.bgba006 = ''
            SELECT bgaa002,bgaa003 INTO g_master.bgba003,g_master.bgba006
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_master.bgba001
            DISPLAY BY NAME g_master.bgba003,g_master.bgba006,g_master.bgba001_desc 
            
            NEXT FIELD bgba001
            #END add-point
 
 
         #Ctrlp:input.c.bgba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba002
            #add-point:ON ACTION controlp INFIELD bgba002 name="input.c.bgba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba010
            #add-point:ON ACTION controlp INFIELD bgba010 name="input.c.bgba010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgba010             #給予default值
            LET g_qryparam.where = " bgaistus = 'Y' AND bgai003 = '",g_user,"' AND (bgai005 ='07' OR bgai005 = '00') "
            IF NOT cl_null(g_master.bgba001) THEN
               LET g_qryparam.where = g_qryparam.where," AND bgai001 = '",g_master.bgba001,"' "
            END IF            
            CALL q_bgai002()                                #呼叫開窗       
            LET g_master.bgba010 = g_qryparam.return1
            CALL s_desc_get_bgai002_desc(g_master.bgba001,g_master.bgba010) RETURNING g_master.bgba010_desc
            DISPLAY BY NAME g_master.bgba010,g_master.bgba010_desc
            NEXT FIELD bgba010
            #END add-point
 
 
         #Ctrlp:input.c.l_sale
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_sale
            #add-point:ON ACTION controlp INFIELD l_sale name="input.c.l_sale"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_assets
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_assets
            #add-point:ON ACTION controlp INFIELD l_assets name="input.c.l_assets"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba004_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba004_s
            #add-point:ON ACTION controlp INFIELD bgba004_s name="input.c.bgba004_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgba004_s_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgba004_s_1
            #add-point:ON ACTION controlp INFIELD bgba004_s_1 name="input.c.bgba004_s_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbadocno
            #add-point:ON ACTION controlp INFIELD bgbadocno name="input.c.bgbadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbadocno
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'abgt030'
            CALL q_ooba002_1()
            LET g_master.bgbadocno = g_qryparam.return1
            CALL s_aooi200_fin_get_slip_desc(g_master.bgbadocno) RETURNING g_master.bgbadocno_desc
            DISPLAY BY NAME g_master.bgbadocno,g_master.bgbadocno_desc
            NEXT FIELD bgbadocno
            #END add-point
 
 
         #Ctrlp:input.c.bgbb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb002
            #add-point:ON ACTION controlp INFIELD bgbb002 name="input.c.bgbb002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbb002 
            LET g_qryparam.where = " bgae006 = '",g_bgaa.bgaa008,"' "
            CALL q_bgae001()
            LET g_master.bgbb002 = g_qryparam.return1
            CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002)RETURNING g_master.bgbb002_desc
            DISPLAY BY NAME g_master.bgbb002_desc
            NEXT FIELD bgbb002
            #END add-point
 
 
         #Ctrlp:input.c.bgbb002_tax
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb002_tax
            #add-point:ON ACTION controlp INFIELD bgbb002_tax name="input.c.bgbb002_tax"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.bgbb002_tax 
            LET g_qryparam.where = " bgae006 = '",g_bgaa.bgaa008,"' "
            CALL q_bgae001()
            LET g_master.bgbb002_tax = g_qryparam.return1
            CALL s_abg_bgae001_desc(g_bgaa.bgaa008,g_master.bgbb002_tax)RETURNING g_master.bgbb002_tax_desc
            DISPLAY BY NAME g_master.bgbb002_tax_desc
            NEXT FIELD bgbb002_tax
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgcj007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="construct.c.bgcj007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #2.檢查預算組織是否在abgi090中可操作的組織中
            LET l_site_str = ''
            CALL s_abg2_get_budget_site(g_master.bgba001,g_master.bgba010,g_user,'07') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str            
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            CALL q_ooef001()                       #呼叫開窗     
            DISPLAY g_qryparam.return1 TO bgcj007  #顯示到畫面上
            NEXT FIELD bgcj007                     #返回原欄位            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="construct.b.bgcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="construct.a.bgcj007"
            
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
            CALL abgp910_get_buffer(l_dialog)
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
            CALL abgp910_qbe_clear()
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
         CALL abgp910_init()
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
                 CALL abgp910_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp910_transfer_argv(ls_js)
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
 
{<section id="abgp910.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp910_transfer_argv(ls_js)
 
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
 
{<section id="abgp910.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp910_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql           STRING
   DEFINE l_docno         LIKE bgba_t.bgbadocno
   DEFINE l_bgcj008       LIKE bgcj_t.bgcj008
   DEFINE l_bgcj007       LIKE bgcj_t.bgcj007
   DEFINE l_bgcj049       LIKE bgcj_t.bgcj049
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt_diffCurr  LIKE type_t.num10
   DEFINE l_do            LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #wc處理
   IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1" END IF
   
   #至少選一種資料來源
   IF g_master.l_sale = 'N'  AND g_master.l_assets = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "abg-00259"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF 
  
   #預算週期/預算幣別/使用預算項目參照表/現金異動表編碼
   INITIALIZE g_bgaa.* TO NULL
   SELECT bgaa002,bgaa003,bgaa008,bgaa009,bgaa011 INTO g_bgaa.*
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgba001
   LET g_master.bgba003 = g_bgaa.bgaa002 #預算週期
   LET g_master.bgba006 = g_bgaa.bgaa003 #預算幣別
   DISPLAY BY NAME g_master.bgba003,g_master.bgba006
   
   #根據各單身預算組織找主帳套
   LET g_ld = ''
   SELECT glaald INTO g_ld FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise AND glaacomp = ooef017 AND glaaent = ooefent AND ooef001 = g_bgaa.bgaa011 AND glaa014 = 'Y' 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp910_process_cs CURSOR FROM ls_sql
#  FOREACH abgp910_process_cs INTO
   #add-point:process段process name="process.process"
   
   ####預算細項####
   #銷售預算 DECLARE-------------------------------------------
   #                             期別/   預算組織/細項
   #LET l_sql = " SELECT DISTINCT bgcj008,bgcj007,bgcj049  ",  #161222-00003#1 mark
   LET l_sql = " SELECT DISTINCT bgcj008,bgcj007  ",           #161222-00003#1 add
               "   FROM bgcj_t ",
               "  WHERE bgcjent = ",g_enterprise," ",
               "    AND bgcj001 = '20' ",
               "    AND bgcj002 = '",g_master.bgba001,"' ",
               "    AND bgcj003 = '",g_master.bgba002,"' ",
               "    AND bgcj008 BETWEEN '",g_master.bgba004_s,"' AND '",g_master.bgba004_s_1,"' ", 
               "    AND ",g_master.wc,     
               "    AND (bgcj103 <> 0 OR bgcj105 <> 0) ",  #金額皆為0不做寫入
               "    AND bgcj048 IS NULL ",                 #憑證單號為空才可做拋轉
               "    AND bgcjstus = 'FC' ",
               #"  ORDER BY bgcj008,bgcj007,bgcj049 "  #161222-00003#1 mark
               "  ORDER BY bgcj008,bgcj007 "           #161222-00003#1 add

   PREPARE sel_bgcjs FROM l_sql
   DECLARE sel_bgcjc CURSOR FOR sel_bgcjs  
   
   #固資出售 DECLARE-------------------------------------------
   #待來源程式完成
   #g_master.wc要做字元取代為另個wc
   
   #----------------------------------------------------------

   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   LET g_success = TRUE
   LET g_master.bgbadocno_1 = ''
   LET g_master.bgbadocno_2 = ''
   LET l_do = 0

   #寫入abgt030 (bgba_t,bgbb_t)
   #(1)銷售預算細項-----------------------------------
   IF g_master.l_sale = 'Y' THEN
      LET l_bgcj008 = ''
      LET l_bgcj007 = ''
      LET l_bgcj049 = ''
      LET l_do = 0
      #FOREACH sel_bgcjc INTO l_bgcj008,l_bgcj007,l_bgcj049 #161222-00003#1 mark
      FOREACH sel_bgcjc INTO l_bgcj008,l_bgcj007            #161222-00003#1 add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:sel_bgcjc"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET g_success = FALSE
            CONTINUE FOREACH
         END IF   
         
         #單頭資料處理--------------------------
         #判斷是否已存在單頭 
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM bgba_t  
          WHERE bgbaent = g_enterprise
            AND bgba001 = g_master.bgba001  
            AND bgba002 = g_master.bgba002  
            AND bgba003 = g_master.bgba003                 
            AND bgba004 = l_bgcj008               
            AND bgba005 = l_bgcj007                
            AND bgba006 = g_master.bgba006   
            AND bgba007 = '10'     

         IF l_cnt = 0 THEN
            LET l_docno = ''
            #CALL abgp910_ins_bgba(l_bgcj008,l_bgcj007,l_bgcj049,'1') RETURNING g_sub_success,l_docno #銷售 #161222-00003#1 mark 
            CALL abgp910_ins_bgba(l_bgcj008,l_bgcj007,'1') RETURNING g_sub_success,l_docno #銷售            #161222-00003#1 add 移除l_bgcj049
            IF NOT g_sub_success THEN 
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            #寫入第一組產生的單號
            IF cl_null(g_master.bgbadocno_1) THEN
               LET g_master.bgbadocno_1 = l_docno
            END IF
         END IF
         
         #寫入單身
         #CALL abgp910_ins_bgbb_bgcj(l_bgcj008,l_bgcj007,l_bgcj049,l_docno)RETURNING g_sub_success #161222-00003#1 mark
         CALL abgp910_ins_bgbb_bgcj(l_bgcj008,l_bgcj007,l_docno)RETURNING g_sub_success            #161222-00003#1 add 移除l_bgcj049
         IF NOT g_sub_success THEN
            LET g_success = FALSE
            EXIT FOREACH
         END IF
   
         #計算是否有預算幣別<>交易幣別
         LET l_cnt_diffCurr = 0
         SELECT COUNT(1) INTO l_cnt_diffCurr FROM bgbb_t WHERE bgbbent = g_enterprise AND bgbbdocno = l_docno AND bgbb008 <> g_master.bgba006
         IF cl_null(l_cnt_diffCurr) THEN LET l_cnt_diffCurr = 0 END IF
         
         #回寫單頭外幣憑證否(更新bgba_t:bgba009)
         IF l_cnt_diffCurr <> 0 THEN
            UPDATE bgba_t SET bgba009 = 'Y' WHERE bgbaent = g_enterprise AND bgbadocno = l_docno
         END IF
         
         #回寫來源table:bgcj048 憑證單號
         UPDATE bgcj_t SET bgcj048 = l_docno 
          WHERE bgcjent = g_enterprise 
            AND bgcj001 = '20'
            AND bgcj002 = g_master.bgba001
            AND bgcj003 = g_master.bgba002
            AND bgcj007 = l_bgcj007
            AND bgcj008 = l_bgcj008
            AND bgcjstus = 'FC'
         
         IF SQLCA.SQLCODE OR SQLCA.sqlerrd[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "UPD_bgcj_t:bgcj048_ERR"
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH   
         END IF 
         LET l_do = l_do + 1
      END FOREACH 
   END IF
   #(2)固資出售細項----------------------------------- 
   #IF g_master.l_assets = 'Y' THEN
   #END IF   
   
   #是否有資料執行
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00491'   #無資料產生
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')     
      CALL cl_err_collect_show()        
      RETURN
   END IF

   #commit or rollback      
   IF g_success THEN
      #寫入最後一組產生的單號
      LET g_master.bgbadocno_2 = l_docno              
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show()
      DISPLAY BY NAME g_master.bgbadocno_1,g_master.bgbadocno_2
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'   #失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()    
      CALL s_transaction_end('N','0')       
      CALL cl_err_collect_show()        
      CALL abgp910_qbe_clear()         
      RETURN      
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
   CALL abgp910_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp910.get_buffer" >}
PRIVATE FUNCTION abgp910_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgba001 = p_dialog.getFieldBuffer('bgba001')
   LET g_master.bgba002 = p_dialog.getFieldBuffer('bgba002')
   LET g_master.bgba010 = p_dialog.getFieldBuffer('bgba010')
   LET g_master.l_sale = p_dialog.getFieldBuffer('l_sale')
   LET g_master.l_assets = p_dialog.getFieldBuffer('l_assets')
   LET g_master.bgba004_s = p_dialog.getFieldBuffer('bgba004_s')
   LET g_master.bgba004_s_1 = p_dialog.getFieldBuffer('bgba004_s_1')
   LET g_master.bgbadocno = p_dialog.getFieldBuffer('bgbadocno')
   LET g_master.bgbb002 = p_dialog.getFieldBuffer('bgbb002')
   LET g_master.bgbb002_tax = p_dialog.getFieldBuffer('bgbb002_tax')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp910.msgcentre_notify" >}
PRIVATE FUNCTION abgp910_msgcentre_notify()
 
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
 
{<section id="abgp910.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL abgp910_qbe_clear()
# Date & Author..: 161121 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp910_qbe_clear()
   CLEAR FORM
   INITIALIZE g_master.* TO NULL   #畫面變數清空
   LET g_master.l_sale = 'Y'
   LET g_master.l_assets = 'N' 
   LET g_master.bgba004_s = MONTH(g_today)
   LET g_master.bgba004_s_1 = MONTH(g_today)
   
   DISPLAY BY NAME g_master.l_sale,g_master.l_assets,g_master.bgba004_s,g_master.bgba004_s_1   
END FUNCTION

################################################################################
# Descriptions...: 單頭寫入
# Memo...........:
# Usage..........: CALL abgp910_ins_bgba(p_bgba004,p_bgba005,p_flag)
#                  RETURNING g_sub_success,r_docno
# Input parameter: p_bgba004       預算期別
#                : p_bgba005       預算組織
#                : p_flag          資料來源
# Return code....: g_sub_success   成功否
#                : r_docno         回傳單號
# Date & Author..: 161125 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp910_ins_bgba(p_bgba004,p_bgba005,p_flag)
DEFINE p_bgba004     LIKE bgba_t.bgba004
DEFINE p_bgba005     LIKE bgba_t.bgba005
DEFINE p_bgbb002     LIKE bgbb_t.bgbb002
DEFINE p_flag        LIKE type_t.chr1
DEFINE l_bgac002     LIKE bgac_t.bgac002
DEFINE l_bgba        RECORD
         bgbaent     LIKE bgba_t.bgbaent,   #企業代碼
         bgbadocno   LIKE bgba_t.bgbadocno, #傳票編號
         bgba001     LIKE bgba_t.bgba001,   #預算編號
         bgba002     LIKE bgba_t.bgba002,   #版本
         bgba003     LIKE bgba_t.bgba003,   #預算週期
         bgba004     LIKE bgba_t.bgba004,   #預算期別
         bgba005     LIKE bgba_t.bgba005,   #預算組織
         bgba006     LIKE bgba_t.bgba006,   #預算幣別
         bgba007     LIKE bgba_t.bgba007,   #資料來源
         bgba008     LIKE bgba_t.bgba008,   #列印次數
         bgba009     LIKE bgba_t.bgba009,   #外幣憑證否
         bgba010     LIKE bgba_t.bgba010,   #管理組織
         bgbaownid   LIKE bgba_t.bgbaownid, #資料所有者
         bgbaowndp   LIKE bgba_t.bgbaowndp, #資料所屬部門
         bgbacrtid   LIKE bgba_t.bgbacrtid, #資料建立者
         bgbacrtdp   LIKE bgba_t.bgbacrtdp, #資料建立部門
         bgbacrtdt   LIKE bgba_t.bgbacrtdt, #資料創建日
         bgbamodid   LIKE bgba_t.bgbamodid, #資料修改者
         bgbamoddt   LIKE bgba_t.bgbamoddt, #最近修改日
         bgbacnfid   LIKE bgba_t.bgbacnfid, #資料確認者
         bgbacnfdt   LIKE bgba_t.bgbacnfdt, #資料確認日
         bgbastus    LIKE bgba_t.bgbastus   #狀態碼
                     END RECORD
DEFINE l_ecom0005    LIKE type_t.num5                     
DEFINE r_success     LIKE type_t.num5 
DEFINE r_docno       LIKE bgba_t.bgbadocno

   LET r_success = TRUE
   LET r_docno = ''

   #取單別
   LET l_bgac002 = '' #期別最後一天
   SELECT MAX(bgac002) INTO l_bgac002 FROM bgac_t 
    WHERE bgacent = g_enterprise AND bgac001 = g_master.bgba003 AND bgac004 = p_bgba004
   CALL s_aooi200_fin_gen_docno(g_ld,'','',g_master.bgbadocno,l_bgac002,'abgt030')
      RETURNING g_sub_success,r_docno
   
   LET l_ecom0005 = ''
   LET l_ecom0005 = cl_get_para(g_enterprise,'','E-COM-0005')     
   IF l_ecom0005 <> LENGTH(r_docno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00111'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      LET r_docno = ''
      RETURN r_success,r_docno
   END IF
   
   INITIALIZE l_bgba.* TO NULL
   LET l_bgba.bgbaent   = g_enterprise   
   LET l_bgba.bgbadocno = r_docno
   LET l_bgba.bgba001   = g_master.bgba001
   LET l_bgba.bgba002   = g_master.bgba002   
   LET l_bgba.bgba003   = g_master.bgba003  
   LET l_bgba.bgba004   = p_bgba004
   LET l_bgba.bgba005   = p_bgba005
   LET l_bgba.bgba006   = g_master.bgba006
   
   CASE p_flag
      WHEN 1 #銷售預算
         LET l_bgba.bgba007 = '10' 
      WHEN 2 #固資出售        
         LET l_bgba.bgba007 = '60' 
   END CASE

   LET l_bgba.bgba008   = 0
   LET l_bgba.bgba009   = 'N'  #單身完成後update
   LET l_bgba.bgba010   = g_master.bgba010
   LET l_bgba.bgbaownid = g_user
   LET l_bgba.bgbaowndp = g_dept
   LET l_bgba.bgbacrtid = g_user
   LET l_bgba.bgbacrtdp = g_dept
   LET l_bgba.bgbacrtdt = cl_get_current()
   LET l_bgba.bgbamodid = ''
   LET l_bgba.bgbamoddt = ''
   LET l_bgba.bgbacnfid = ''
   LET l_bgba.bgbacnfdt = ''
   LET l_bgba.bgbastus  = 'N'
   
   #寫入單頭
   CASE p_flag
      #銷售預算-----------------------------------------------------------------------------------
      WHEN 1 
         INSERT INTO bgba_t(bgbaent,bgbadocno,bgba001,bgba002,bgba003,   
                            bgba004,bgba005,bgba006,bgba007,bgba008,
                            bgba009,bgba010,bgbaownid,bgbaowndp,bgbacrtid,
                            bgbacrtdp,bgbacrtdt,bgbamodid,bgbamoddt,bgbacnfid,
                            bgbacnfdt,bgbastus)
                     VALUES(l_bgba.bgbaent,l_bgba.bgbadocno,l_bgba.bgba001,l_bgba.bgba002,l_bgba.bgba003,   
                            l_bgba.bgba004,l_bgba.bgba005,l_bgba.bgba006,l_bgba.bgba007,l_bgba.bgba008,
                            l_bgba.bgba009,l_bgba.bgba010,l_bgba.bgbaownid,l_bgba.bgbaowndp,l_bgba.bgbacrtid,
                            l_bgba.bgbacrtdp,l_bgba.bgbacrtdt,l_bgba.bgbamodid,l_bgba.bgbamoddt,l_bgba.bgbacnfid,
                            l_bgba.bgbacnfdt,l_bgba.bgbastus)                           

         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "INS_bgba_ERR_FROM_bgcj"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            LET r_docno = ''
            RETURN r_success,r_docno
         END IF
         
      #固資出售-----------------------------------------------------------------------------------
      WHEN 2
         #IF SQLCA.SQLcode THEN
         #   INITIALIZE g_errparam TO NULL
         #   LET g_errparam.code = SQLCA.sqlcode
         #   LET g_errparam.extend = "INS_bgba_ERR_FROM_bgXX"
         #   LET g_errparam.popup = TRUE
         #   CALL cl_err()
         #   LET r_success = FALSE
         #   LET r_docno = ''
         #   RETURN r_success,r_docno
         #END IF

   END CASE


   RETURN r_success,r_docno
END FUNCTION

################################################################################
# Descriptions...: 銷售預算寫入bgbb單身(1by1)
# Memo...........:
# Usage..........: CALL abgp910_ins_bgbb_bgcj(p_bgba004,p_bgba005,p_docno)
#                  RETURNING g_sub_success
# Input parameter: p_bgcj008       預算期別
#                : p_bgcj007       預算組織
#                : p_docno         單據號碼
# Return code....: g_sub_success   成功否
# Date & Author..: 161128 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgp910_ins_bgbb_bgcj(p_bgba004,p_bgba005,p_docno)
DEFINE p_bgba004       LIKE bgba_t.bgba004
DEFINE p_bgba005       LIKE bgba_t.bgba005
DEFINE p_docno         LIKE bgba_t.bgbadocno
DEFINE l_bgcj          RECORD
         bgcj002       LIKE bgcj_t.bgcj002,  #預算編號
         bgcj003       LIKE bgcj_t.bgcj003,  #版本
         bgcj007       LIKE bgcj_t.bgcj007,  #預算組織
         bgcj008       LIKE bgcj_t.bgcj008,  #預算期別
         bgcj037       LIKE bgcj_t.bgcj037,  #銷售單位
         bgcj045       LIKE bgcj_t.bgcj045,  #核准數量
         bgcj046       LIKE bgcj_t.bgcj046,  #核准單價
         bgcj049       LIKE bgcj_t.bgcj049,  #預算細項
         bgcj100       LIKE bgcj_t.bgcj100,  #交易幣別
         bgcj101       LIKE bgcj_t.bgcj101,  #匯率
         bgcj103       LIKE bgcj_t.bgcj103,  #核准原幣未稅金額
         bgcj104       LIKE bgcj_t.bgcj104,  #核准原幣稅額
         bgcj105       LIKE bgcj_t.bgcj105,  #核准原幣含稅金額
         bgcj012       LIKE bgcj_t.bgcj012,  #人員                 
         bgcj013       LIKE bgcj_t.bgcj013,  #部門
         bgcj014       LIKE bgcj_t.bgcj014,  #成本利潤中心
         bgcj015       LIKE bgcj_t.bgcj015,  #區域
         bgcj016       LIKE bgcj_t.bgcj016,  #收付款客商
         bgcj017       LIKE bgcj_t.bgcj017,  #帳款客商
         bgcj018       LIKE bgcj_t.bgcj018,  #客群
         bgcj019       LIKE bgcj_t.bgcj019,  #產品類別
         bgcj020       LIKE bgcj_t.bgcj020,  #專案編號
         bgcj021       LIKE bgcj_t.bgcj021,  #WBS
         bgcj022       LIKE bgcj_t.bgcj022,  #經營方式
         bgcj023       LIKE bgcj_t.bgcj023,  #通路
         bgcj024       LIKE bgcj_t.bgcj024,  #品牌    
         bgcj025       LIKE bgcj_t.bgcj025,  #自由核算項一
         bgcj026       LIKE bgcj_t.bgcj026,  #自由核算項二
         bgcj027       LIKE bgcj_t.bgcj027,  #自由核算項三
         bgcj028       LIKE bgcj_t.bgcj028,  #自由核算項四
         bgcj029       LIKE bgcj_t.bgcj029,  #自由核算項五
         bgcj030       LIKE bgcj_t.bgcj030,  #自由核算項六
         bgcj031       LIKE bgcj_t.bgcj031,  #自由核算項七
         bgcj032       LIKE bgcj_t.bgcj032,  #自由核算項八
         bgcj033       LIKE bgcj_t.bgcj033,  #自由核算項九
         bgcj034       LIKE bgcj_t.bgcj034   #自由核算項十         
                       END RECORD                  
DEFINE l_sql           STRING
DEFINE l_seq           LIKE type_t.num10
DEFINE l_i             LIKE type_t.num10                       
DEFINE l_bgae004       LIKE bgae_t.bgae004        
DEFINE l_bgaq009       LIKE bgaq_t.bgaq009 
DEFINE l_comp          LIKE glaa_t.glaacomp
DEFINE l_glaa004       LIKE glaa_t.glaa004
DEFINE l_bgao004       LIKE bgao_t.bgao004 
#161222-00003#1 --s add
DEFINE l_bgcj049       LIKE bgcj_t.bgcj049
DEFINE l_amt_d         LIKE bgeg_t.bgeg103 
DEFINE l_amt_tax       LIKE bgeg_t.bgeg103
#161222-00003#1 --e add
DEFINE r_success       LIKE type_t.num5 

   LET l_seq = 0 
   LET r_success = TRUE
   
   ####寫入來源####
   #銷售預算 DECLARE-------------------------------------------
   #(一對一)
   LET l_sql = " SELECT bgcj002,bgcj003,bgcj007,bgcj008,bgcj037, ",        
               "        bgcj045,bgcj046,bgcj049,bgcj100,bgcj101, ",
               "        bgcj103,bgcj104,bgcj105,bgcj012,bgcj013, ",
               "        bgcj014,bgcj015,bgcj016,bgcj017,bgcj018, ",
               "        bgcj019,bgcj020,bgcj021,bgcj022,bgcj023, ",
               "        bgcj024,bgcj025,bgcj026,bgcj027,bgcj028, ",
               "        bgcj029,bgcj030,bgcj031,bgcj032,bgcj033, ",
               "        bgcj034   ",          
               "   FROM bgcj_t ",
               "  WHERE bgcjent = ",g_enterprise," ",
               "    AND bgcj001 = '20' ",
               "    AND bgcj002 = '",g_master.bgba001,"' ",
               "    AND bgcj003 = '",g_master.bgba002,"' ",
               "    AND bgcj008 = ? ", #期別
               "    AND bgcj007 = ? ", #預算組織
               "    AND bgcj049 = ? ", #細項                        
               "    AND ",g_master.wc,
               "    AND (bgcj103 <> 0 OR bgcj105 <> 0) ",  #金額皆為0不做寫入
               "    AND bgcj048 IS NULL ",                 #憑證單號為空才可做拋轉
               "    AND bgcjstus = 'FC' ",
               "  ORDER BY bgcj002,bgcj003,bgcj008,bgcj007 "        
               
   PREPARE sel_bgcjs_ins FROM l_sql
   DECLARE sel_bgcjc_ins CURSOR FOR sel_bgcjs_ins  
   
   #(GROUP條件)  
   LET l_sql = " SELECT bgcj002,bgcj003,bgcj007,bgcj008,'', ",       
               "        0,0,bgcj049,bgcj100,bgcj101, ",
               "        SUM(bgcj103),SUM(bgcj104),SUM(bgcj105),bgcj012,bgcj013, ",
               "        bgcj014,bgcj015,bgcj016,bgcj017,bgcj018, ",
               "        bgcj019,bgcj020,bgcj021,bgcj022,bgcj023, ",
               "        bgcj024,bgcj025,bgcj026,bgcj027,bgcj028, ",
               "        bgcj029,bgcj030,bgcj031,bgcj032,bgcj033, ",
               "        bgcj034   ",
               "   FROM bgcj_t ",
               "  WHERE bgcjent = ",g_enterprise," ",
               "    AND bgcj001 = '20' ",
               "    AND bgcj002 = '",g_master.bgba001,"' ",
               "    AND bgcj003 = '",g_master.bgba002,"' ",
               "    AND bgcj008 = ? ", #期別
               "    AND bgcj007 = ? ", #預算組織
               "    AND bgcj049 = ? ", #細項                       
               "    AND ",g_master.wc,
               "    AND (bgcj103 <> 0 OR bgcj105 <> 0) ",  #金額皆為0不做寫入
               "    AND bgcj048 IS NULL ",                 #憑證單號為空才可做拋轉
               "    AND bgcjstus = 'FC' ",
               "  GROUP BY bgcj002,bgcj003,bgcj007,bgcj008,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016, ",       
               "           bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj025,bgcj026, ",
               "           bgcj027,bgcj028,bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,bgcj034,bgcj100,bgcj101  ",
               "  ORDER BY bgcj002,bgcj003,bgcj007,bgcj008,bgcj049,bgcj012,bgcj013,bgcj014,bgcj015,bgcj016, ",     
               "           bgcj017,bgcj018,bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,bgcj024,bgcj025,bgcj026, ",
               "           bgcj027,bgcj028,bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,bgcj034,bgcj100,bgcj101  "
               
   PREPARE sel_bgcjs_ins_g FROM l_sql
   DECLARE sel_bgcjc_ins_g CURSOR FOR sel_bgcjs_ins_g  
   
   #161222-00003#1 --s add
   LET l_sql = " SELECT DISTINCT bgcj049  ",         
               "   FROM bgcj_t ",
               "  WHERE bgcjent = ",g_enterprise," ",
               "    AND bgcj001 = '20' ",
               "    AND bgcj002 = '",g_master.bgba001,"' ",
               "    AND bgcj003 = '",g_master.bgba002,"' ",
               "    AND ",g_master.wc,     
               "    AND bgcj008 = '",p_bgba004,"' ",
               "    AND bgcj007 = '",p_bgba005,"' ",
               "    AND (bgcj103 <> 0 OR bgcj105 <> 0) ",  #金額皆為0不做寫入
               "    AND bgcj048 IS NULL ",                 #憑證單號為空才可做拋轉
               "    AND bgcjstus = 'FC' ",
               "  ORDER BY bgcj049 "   
   PREPARE sel_bgcj049_g FROM l_sql
   DECLARE sel_bgcj049_gc CURSOR FOR sel_bgcj049_g        
   #161222-00003#1 --e add   
   
   #固資出售 DECLARE-------------------------------------------
   #待來源程式完成
   #g_master.wc要做字元取代為另個wc
   
   #----------------------------------------------------------
   
   #161222-00003#1 --s add
   LET l_bgcj049 = ''
   FOREACH sel_bgcj049_gc INTO l_bgcj049 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:sel_bgcj049_gc"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF   
   #161222-00003#1 --e add
   
   
   #依預算細項檔的計量方式(abgi040)
   LET l_bgae004 = ''      
   SELECT bgae004 INTO l_bgae004 FROM bgae_t
    #WHERE bgaeent = g_enterprise AND bgae006 = g_bgaa.bgaa008 AND bgae001 = p_bgbb002 #161222-00003#1 mark
    WHERE bgaeent = g_enterprise AND bgae006 = g_bgaa.bgaa008 AND bgae001 = l_bgcj049  #161222-00003#1 add p_bgbb002>l_bgcj049
   
   #單身資料處理---------------------------
   #計量方式是否為2.實物計量 or 3.雙重計量
   IF l_bgae004 = '2' OR l_bgae004 = '3' THEN 
      #一對一寫入
      INITIALIZE l_bgcj.* TO NULL
      #FOREACH sel_bgcjc_ins USING p_bgba004,p_bgba005,p_bgbb002 INTO l_bgcj.* #161222-00003#1 mark
      FOREACH sel_bgcjc_ins USING p_bgba004,p_bgba005,l_bgcj049 INTO l_bgcj.*  #161222-00003#1 add p_bgbb002>l_bgcj049
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:sel_bgcjc_ins"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
   
         INITIALIZE g_bgbb.* TO NULL
         LET g_bgbb.bgbbent   = g_enterprise      #企業編號
         LET g_bgbb.bgbb001   = g_master.bgba001  #預算編號
         LET g_bgbb.bgbbdocno = p_docno           #單據編號
         LET g_bgbb.bgbbseq   = 0                 #項次
         LET g_bgbb.bgbb002   = ''                #預算細項
         LET g_bgbb.bgbb003   = 0                 #借方金額
         LET g_bgbb.bgbb004   = 0                 #貸方金額
         LET g_bgbb.bgbb005   = l_bgcj.bgcj037    #計量單位
         LET g_bgbb.bgbb006   = l_bgcj.bgcj045    #數量
         LET g_bgbb.bgbb007   = l_bgcj.bgcj046    #单价
         LET g_bgbb.bgbb008   = l_bgcj.bgcj100    #交易幣別
         LET g_bgbb.bgbb009   = l_bgcj.bgcj101    #汇率
         LET g_bgbb.bgbb010   = 0                 #原幣金額
         LET g_bgbb.bgbb011   = l_bgcj.bgcj013    #部門
         LET g_bgbb.bgbb012   = l_bgcj.bgcj014    #利潤成本中心
         LET g_bgbb.bgbb013   = l_bgcj.bgcj015    #區域
         LET g_bgbb.bgbb014   = l_bgcj.bgcj016    #收付款客商
         LET g_bgbb.bgbb015   = l_bgcj.bgcj017    #帳款客商
         LET g_bgbb.bgbb016   = l_bgcj.bgcj018    #客群
         LET g_bgbb.bgbb017   = l_bgcj.bgcj019    #產品類別
         LET g_bgbb.bgbb018   = l_bgcj.bgcj012    #人員
         LET g_bgbb.bgbb019   = l_bgcj.bgcj020    #專案編號
         LET g_bgbb.bgbb020   = l_bgcj.bgcj021    #WBS
         LET g_bgbb.bgbb021   = l_bgcj.bgcj022    #經營方式
         LET g_bgbb.bgbb022   = l_bgcj.bgcj023    #通路
         LET g_bgbb.bgbb023   = l_bgcj.bgcj024    #品牌
         LET g_bgbb.bgbb024   = " "               #現金碼   
         LET g_bgbb.bgbb025   = l_bgcj.bgcj025    #自由核算項一
         LET g_bgbb.bgbb026   = l_bgcj.bgcj026    #自由核算項二
         LET g_bgbb.bgbb027   = l_bgcj.bgcj027    #自由核算項三
         LET g_bgbb.bgbb028   = l_bgcj.bgcj028    #自由核算項四
         LET g_bgbb.bgbb029   = l_bgcj.bgcj029    #自由核算項五
         LET g_bgbb.bgbb030   = l_bgcj.bgcj030    #自由核算項六
         LET g_bgbb.bgbb031   = l_bgcj.bgcj031    #自由核算項七
         LET g_bgbb.bgbb032   = l_bgcj.bgcj032    #自由核算項八
         LET g_bgbb.bgbb033   = l_bgcj.bgcj033    #自由核算項九
         LET g_bgbb.bgbb034   = l_bgcj.bgcj034    #自由核算項十          
         
         #取abgi150交易客商慣用應收類型
         LET l_bgaq009 = ''
         SELECT bgaq009 INTO l_bgaq009 FROM bgaq_t
          WHERE bgaqent = g_enterprise AND bgaq001 = g_bgbb.bgbb014 AND bgaq002 = '1' AND bgaqsite = p_bgba005
         
         #取預算組織歸屬法人主帳套
         LET l_comp = ''
         LET l_glaa004 = ''
         SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_bgba005
         SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'
         
         #161222-00003#1 --s add
         #紀錄借方與稅額金額
         LET l_amt_d = 0
         LET l_amt_tax = 0
         #161222-00003#1 --e add       
   
         #科目寫入 1.借方科目_應收 /2.貸方科目_銷貨收入(細項) /3.銷項稅額 三筆
         LET l_i = 1
         FOR l_i = 1 TO 3 
            LET l_seq = l_seq + 1  #項次
            CASE l_i 
               WHEN 1
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj105 = 0 OR cl_null(l_bgcj.bgcj105) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb003 = l_bgcj.bgcj105 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb003,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb003

                  #預算細項
                  IF cl_null(g_master.bgbb002)THEN
                     #axri011對應會計應收科目    
                     LET g_bgbb.bgbb002 = ''
                     SELECT glab005 INTO g_bgbb.bgbb002 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_ld
                        AND glab002 = l_bgaq009        # 帳款類別
                        AND glab001 = '13'             # 應收帳務類型科目設定
 　                     AND glab003 = '8304_01'                     
                     
                     LET l_bgao004 = ''
                     SELECT bgao004 INTO l_bgao004 FROM bgao_t 
                      WHERE bgaoent = g_enterprise AND bgao001 = g_bgaa.bgaa008 AND bgao002 = l_glaa004 AND bgao003 = g_bgbb.bgbb002
                     
                     LET g_bgbb.bgbb002   = l_bgao004         
                  ELSE
                     LET g_bgbb.bgbb002 = g_master.bgbb002
                  END IF
                  IF cl_null(g_bgbb.bgbb002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'abg-00258'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     EXIT FOREACH
                  END IF
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  LET g_bgbb.bgbb003   = g_bgbb.bgbb003    #借方金額
                  LET g_bgbb.bgbb004   = 0                 #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj105    #原幣金額   
                  
                  LET l_amt_d = g_bgbb.bgbb003  #161222-00003#1 add 記錄借方金額
   
               WHEN 2 
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj104 = 0 OR cl_null(l_bgcj.bgcj104) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb004 = l_bgcj.bgcj104 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb004,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb004 
                  
                  #預算細項
                  IF cl_null(g_master.bgbb002_tax)THEN
                     #axri011對應會計稅額科目
                     LET g_bgbb.bgbb002 = ''
                     SELECT glab005 INTO g_bgbb.bgbb002 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld = g_ld
                        AND glab001 = '13'             # 應收帳務類型科目設定
                        AND glab002 = l_bgaq009        # 帳款類別
                        AND glab003 = '8304_29'
                     
                     LET l_bgao004 = ''
                     SELECT bgao004 INTO l_bgao004 FROM bgao_t 
                      WHERE bgaoent = g_enterprise AND bgao001 = g_bgaa.bgaa008 AND bgao002 = l_glaa004 AND bgao003 = g_bgbb.bgbb002

                     LET g_bgbb.bgbb002 = l_bgao004         
                  ELSE
                     LET g_bgbb.bgbb002 = g_master.bgbb002_tax
                  END IF
                  IF cl_null(g_bgbb.bgbb002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'abg-00258'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     EXIT FOREACH
                  END IF
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  LET g_bgbb.bgbb003   = 0                 #借方金額
                  LET g_bgbb.bgbb004   = g_bgbb.bgbb004    #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj104    #原幣金額
                  
                  LET l_amt_tax = g_bgbb.bgbb004  #161222-00003#1 add 記錄稅額金額
 
               WHEN 3
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj103 = 0 OR cl_null(l_bgcj.bgcj103) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb004 = l_bgcj.bgcj103 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb004,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb004  
                  
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  #LET g_bgbb.bgbb002   = p_bgbb002         #預算細項  #161222-00003#1 mark
                  LET g_bgbb.bgbb002   = l_bgcj049         #預算細項   #161222-00003#1 add p_bgbb002>l_bgcj049
                  LET g_bgbb.bgbb003   = 0                 #借方金額
                  LET g_bgbb.bgbb004   = g_bgbb.bgbb004    #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj103    #原幣金額  
 
                  LET g_bgbb.bgbb004 = l_amt_d - l_amt_tax  #161222-00003#1 add 借方與稅額相減 
                    
            END CASE
            
            #單身寫入-----------------------
            INSERT INTO bgbb_t(bgbbent,bgbb001,bgbbdocno,bgbbseq,bgbb002,
                               bgbb003,bgbb004,bgbb005,bgbb006,bgbb007,
                               bgbb008,bgbb009,bgbb010,bgbb011,bgbb012,
                               bgbb013,bgbb014,bgbb015,bgbb016,bgbb017,
                               bgbb018,bgbb019,bgbb020,bgbb021,bgbb022,
                               bgbb023,bgbb024,bgbb025,bgbb026,bgbb027,
                               bgbb028,bgbb029,bgbb030,bgbb031,bgbb032,
                               bgbb033,bgbb034)
                        VALUES(g_bgbb.bgbbent,g_bgbb.bgbb001,g_bgbb.bgbbdocno,g_bgbb.bgbbseq,g_bgbb.bgbb002,
                               g_bgbb.bgbb003,g_bgbb.bgbb004,g_bgbb.bgbb005,g_bgbb.bgbb006,g_bgbb.bgbb007,
                               g_bgbb.bgbb008,g_bgbb.bgbb009,g_bgbb.bgbb010,g_bgbb.bgbb011,g_bgbb.bgbb012,
                               g_bgbb.bgbb013,g_bgbb.bgbb014,g_bgbb.bgbb015,g_bgbb.bgbb016,g_bgbb.bgbb017,
                               g_bgbb.bgbb018,g_bgbb.bgbb019,g_bgbb.bgbb020,g_bgbb.bgbb021,g_bgbb.bgbb022,
                               g_bgbb.bgbb023,g_bgbb.bgbb024,g_bgbb.bgbb025,g_bgbb.bgbb026,g_bgbb.bgbb027,
                               g_bgbb.bgbb028,g_bgbb.bgbb029,g_bgbb.bgbb030,g_bgbb.bgbb031,g_bgbb.bgbb032,
                               g_bgbb.bgbb033,g_bgbb.bgbb034)
            
            
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INS_ERR_FROM_bgcj_1by1:",l_i
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOR
            END IF
         END FOR  
         
         IF NOT r_success THEN
            EXIT FOREACH 
            RETURN r_success
         END IF
      END FOREACH 
   ELSE 
      #GROUP 預算編號＋版本＋預算組織＋期別 + 預算細項 + 核算項 + 幣別 + 匯率
      INITIALIZE l_bgcj.* TO NULL
      #FOREACH sel_bgcjc_ins_g USING p_bgba004,p_bgba005,p_bgbb002 INTO l_bgcj.* #161222-00003#1 mark
      FOREACH sel_bgcjc_ins_g USING p_bgba004,p_bgba005,l_bgcj049 INTO l_bgcj.*  #161222-00003#1 add p_bgbb002>l_bgcj049      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:sel_bgcjc_ins_g"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
   
         INITIALIZE g_bgbb.* TO NULL
         LET g_bgbb.bgbbent   = g_enterprise      #企業編號
         LET g_bgbb.bgbb001   = g_master.bgba001  #預算編號
         LET g_bgbb.bgbbdocno = p_docno           #單據編號
         LET g_bgbb.bgbbseq   = 0                 #項次
         LET g_bgbb.bgbb002   = ''                #預算細項
         LET g_bgbb.bgbb003   = 0                 #借方金額
         LET g_bgbb.bgbb004   = 0                 #貸方金額
         LET g_bgbb.bgbb005   = l_bgcj.bgcj037    #計量單位
         LET g_bgbb.bgbb006   = l_bgcj.bgcj045    #數量
         LET g_bgbb.bgbb007   = l_bgcj.bgcj046    #单价
         LET g_bgbb.bgbb008   = l_bgcj.bgcj100    #交易幣別
         LET g_bgbb.bgbb009   = l_bgcj.bgcj101    #汇率
         LET g_bgbb.bgbb010   = 0                 #原幣金額
         LET g_bgbb.bgbb011   = l_bgcj.bgcj013    #部門
         LET g_bgbb.bgbb012   = l_bgcj.bgcj014    #利潤成本中心
         LET g_bgbb.bgbb013   = l_bgcj.bgcj015    #區域
         LET g_bgbb.bgbb014   = l_bgcj.bgcj016    #收付款客商
         LET g_bgbb.bgbb015   = l_bgcj.bgcj017    #帳款客商
         LET g_bgbb.bgbb016   = l_bgcj.bgcj018    #客群
         LET g_bgbb.bgbb017   = l_bgcj.bgcj019    #產品類別
         LET g_bgbb.bgbb018   = l_bgcj.bgcj012    #人員
         LET g_bgbb.bgbb019   = l_bgcj.bgcj020    #專案編號
         LET g_bgbb.bgbb020   = l_bgcj.bgcj021    #WBS
         LET g_bgbb.bgbb021   = l_bgcj.bgcj022    #經營方式
         LET g_bgbb.bgbb022   = l_bgcj.bgcj023    #通路
         LET g_bgbb.bgbb023   = l_bgcj.bgcj024    #品牌
         LET g_bgbb.bgbb024   = " "               #現金碼   
         LET g_bgbb.bgbb025   = l_bgcj.bgcj025    #自由核算項一
         LET g_bgbb.bgbb026   = l_bgcj.bgcj026    #自由核算項二
         LET g_bgbb.bgbb027   = l_bgcj.bgcj027    #自由核算項三
         LET g_bgbb.bgbb028   = l_bgcj.bgcj028    #自由核算項四
         LET g_bgbb.bgbb029   = l_bgcj.bgcj029    #自由核算項五
         LET g_bgbb.bgbb030   = l_bgcj.bgcj030    #自由核算項六
         LET g_bgbb.bgbb031   = l_bgcj.bgcj031    #自由核算項七
         LET g_bgbb.bgbb032   = l_bgcj.bgcj032    #自由核算項八
         LET g_bgbb.bgbb033   = l_bgcj.bgcj033    #自由核算項九
         LET g_bgbb.bgbb034   = l_bgcj.bgcj034    #自由核算項十          
         
         #取abgi150交易客商慣用應收類型
         LET l_bgaq009 = ''
         SELECT bgaq009 INTO l_bgaq009 FROM bgaq_t
          WHERE bgaqent = g_enterprise AND bgaq001 = g_bgbb.bgbb014 AND bgaq002 = '1' AND bgaqsite = p_bgba005
         
         #取預算組織歸屬法人主帳套
         LET l_comp = ''
         LET l_glaa004 = ''
         SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_bgba005
         SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_comp AND glaa014 = 'Y'

         #161222-00003#1 --s add
         #紀錄借方與稅額金額
         LET l_amt_d = 0
         LET l_amt_tax = 0
         #161222-00003#1 --e add     

         #科目寫入 1.借方科目_應收 /2.貸方科目_銷貨收入(細項) /3.銷項稅額 三筆
         LET l_i = 1
         FOR l_i = 1 TO 3 
            LET l_seq = l_seq + 1  #項次
            CASE l_i 
               WHEN 1
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj105 = 0 OR cl_null(l_bgcj.bgcj105) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb003 = l_bgcj.bgcj105 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb003,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb003

                  #預算細項
                  IF cl_null(g_master.bgbb002)THEN
                     #axri011對應會計應收科目    
                     LET g_bgbb.bgbb002 = ''
                     SELECT glab005 INTO g_bgbb.bgbb002 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld  = g_ld
                        AND glab002 = l_bgaq009        # 帳款類別
                        AND glab001 = '13'             # 應收帳務類型科目設定
 　                     AND glab003 = '8304_01'                     
                     
                     LET l_bgao004 = ''
                     SELECT bgao004 INTO l_bgao004 FROM bgao_t 
                      WHERE bgaoent = g_enterprise AND bgao001 = g_bgaa.bgaa008 AND bgao002 = l_glaa004 AND bgao003 = g_bgbb.bgbb002
                     
                     LET g_bgbb.bgbb002   = l_bgao004         
                  ELSE
                     LET g_bgbb.bgbb002 = g_master.bgbb002
                  END IF
                  IF cl_null(g_bgbb.bgbb002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'abg-00258'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     EXIT FOREACH
                  END IF
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  LET g_bgbb.bgbb003   = g_bgbb.bgbb003    #借方金額
                  LET g_bgbb.bgbb004   = 0                 #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj105    #原幣金額   
                  LET l_amt_d = g_bgbb.bgbb003  #161222-00003#1 add 記錄借方金額
   
   
               WHEN 2
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj104 = 0 OR cl_null(l_bgcj.bgcj104) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb004 = l_bgcj.bgcj104 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb004,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb004 
                  
                  #預算細項
                  IF cl_null(g_master.bgbb002_tax)THEN
                     #axri011對應會計稅額科目
                     LET g_bgbb.bgbb002 = ''
                     SELECT glab005 INTO g_bgbb.bgbb002 FROM glab_t
                      WHERE glabent = g_enterprise
                        AND glabld = g_ld
                        AND glab001 = '13'             # 應收帳務類型科目設定
                        AND glab002 = l_bgaq009        # 帳款類別
                        AND glab003 = '8304_29'
                     
                     LET l_bgao004 = ''
                     SELECT bgao004 INTO l_bgao004 FROM bgao_t 
                      WHERE bgaoent = g_enterprise AND bgao001 = g_bgaa.bgaa008 AND bgao002 = l_glaa004 AND bgao003 = g_bgbb.bgbb002

                     LET g_bgbb.bgbb002 = l_bgao004         
                  ELSE
                     LET g_bgbb.bgbb002 = g_master.bgbb002_tax
                  END IF
                  IF cl_null(g_bgbb.bgbb002) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'abg-00258'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET r_success = FALSE
                     EXIT FOREACH
                  END IF
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  LET g_bgbb.bgbb003   = 0                 #借方金額
                  LET g_bgbb.bgbb004   = g_bgbb.bgbb004    #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj104    #原幣金額
                  LET l_amt_tax = g_bgbb.bgbb004  #161222-00003#1 add 記錄稅額金額
 
               WHEN 3
                  #如金額為0,則不顯示
                  IF l_bgcj.bgcj103 = 0 OR cl_null(l_bgcj.bgcj103) THEN CONTINUE FOR END IF 
                  
                  #原幣金額換算為本幣金額後取位
                  LET g_bgbb.bgbb004 = l_bgcj.bgcj103 * l_bgcj.bgcj101
                  CALL s_curr_round_ld('1',g_ld,g_master.bgba006,g_bgbb.bgbb004,2) RETURNING g_sub_success,g_errno,g_bgbb.bgbb004  
                  
                  LET g_bgbb.bgbbseq   = l_seq             #項次
                  #LET g_bgbb.bgbb002   = p_bgbb002        #預算細項  #161222-00003#1 mark
                  LET g_bgbb.bgbb002   = l_bgcj049         #預算細項  #161222-00003#1 add p_bgbb002>l_bgcj049                  
                  LET g_bgbb.bgbb003   = 0                 #借方金額
                  LET g_bgbb.bgbb004   = g_bgbb.bgbb004    #貸方金額
                  LET g_bgbb.bgbb010   = l_bgcj.bgcj103    #原幣金額
                  LET g_bgbb.bgbb004 = l_amt_d - l_amt_tax  #161222-00003#1 add 借方與稅額相減                   
                    
            END CASE
            
            #單身寫入
            INSERT INTO bgbb_t(bgbbent,bgbb001,bgbbdocno,bgbbseq,bgbb002,
                               bgbb003,bgbb004,bgbb005,bgbb006,bgbb007,
                               bgbb008,bgbb009,bgbb010,bgbb011,bgbb012,
                               bgbb013,bgbb014,bgbb015,bgbb016,bgbb017,
                               bgbb018,bgbb019,bgbb020,bgbb021,bgbb022,
                               bgbb023,bgbb024,bgbb025,bgbb026,bgbb027,
                               bgbb028,bgbb029,bgbb030,bgbb031,bgbb032,
                               bgbb033,bgbb034)
                        VALUES(g_bgbb.bgbbent,g_bgbb.bgbb001,g_bgbb.bgbbdocno,g_bgbb.bgbbseq,g_bgbb.bgbb002,
                               g_bgbb.bgbb003,g_bgbb.bgbb004,g_bgbb.bgbb005,g_bgbb.bgbb006,g_bgbb.bgbb007,
                               g_bgbb.bgbb008,g_bgbb.bgbb009,g_bgbb.bgbb010,g_bgbb.bgbb011,g_bgbb.bgbb012,
                               g_bgbb.bgbb013,g_bgbb.bgbb014,g_bgbb.bgbb015,g_bgbb.bgbb016,g_bgbb.bgbb017,
                               g_bgbb.bgbb018,g_bgbb.bgbb019,g_bgbb.bgbb020,g_bgbb.bgbb021,g_bgbb.bgbb022,
                               g_bgbb.bgbb023,g_bgbb.bgbb024,g_bgbb.bgbb025,g_bgbb.bgbb026,g_bgbb.bgbb027,
                               g_bgbb.bgbb028,g_bgbb.bgbb029,g_bgbb.bgbb030,g_bgbb.bgbb031,g_bgbb.bgbb032,
                               g_bgbb.bgbb033,g_bgbb.bgbb034)         
            
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "INS_ERR_FROM_bgcj_GROUP:",l_i
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOR
            END IF
         END FOR  
         
         IF NOT r_success THEN
            EXIT FOREACH 
            RETURN r_success
         END IF
      END FOREACH 
   END IF
   
   #161222-00003#1 --s add
      IF NOT r_success THEN
         EXIT FOREACH 
         RETURN r_success
      END IF
   END FOREACH 
   #161222-00003#1 --e add
   
   IF NOT r_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF         

   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
