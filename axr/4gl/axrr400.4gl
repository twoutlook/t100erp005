#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2015-08-28 14:23:11), PR版次:0008(2016-10-28 11:39:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: axrr400
#+ Description: 應收核銷單
#+ Creator....: 05016(2015-08-28 13:53:15)
#+ Modifier...: 05016 -SD/PR- 08729
 
{</section>}
 
{<section id="axrr400.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#8  2016/03/11 By 02599   增加控制组权限控管
#160318-00025#47 2016/04/29 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160518-00075#11  2016/07/25 By 07900   (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
#160815-00029#1   2016/8/15  By 07900   修改axrr400_g01报表参数
#160811-00009#5   2016/08/18 By 01531   账务中心/法人/账套权限控管
#161021-00050#7   2016/10/28 By 08729   處理組織開窗
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
       xrdasite LIKE type_t.chr500, 
   xrdasite_desc LIKE type_t.chr80, 
   xrdald LIKE type_t.chr500, 
   xrdald_desc LIKE type_t.chr80, 
   xrda001 LIKE type_t.chr500, 
   xrdadocno LIKE type_t.chr500, 
   xrdadocdt LIKE type_t.chr500, 
   xrda005 LIKE type_t.chr500, 
   xrda003 LIKE type_t.chr500, 
   xrda014 LIKE type_t.chr500, 
   xrda016 LIKE type_t.chr500, 
   xrdastus LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_xrdald STRING
DEFINE g_xrdacomp  LIKE xrda_t.xrdacomp
DEFINE g_sql_ctrl  STRING   #151231-00010#8 add
DEFINE g_sql_ctr2       STRING                #160518-00075#11
DEFINE g_sql_ctr3       STRING                #160518-00075#11
DEFINE g_glaa024        LIKE glaa_t.glaa024   #160518-00075#11
DEFINE l_site_len       LIKE type_t.num5      #SITE段长度 #160518-00075#11
DEFINE l_slip_len       LIKE type_t.num5      #单别段长度 #160518-00075#11
DEFINE l_i              LIKE type_t.num5      #160518-00075#11
DEFINE l_j              LIKE type_t.num5      #160518-00075#11
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrr400.main" >}
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
      CALL axrr400_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrr400 WITH FORM cl_ap_formpath("axr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axrr400_init()
 
      #進入選單 Menu (="N")
      CALL axrr400_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrr400
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrr400.init" >}
#+ 初始化作業
PRIVATE FUNCTION axrr400_init()
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
   CALL cl_set_combo_scc_part('xrda001','8307','41')   
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔
   LET g_master.xrdastus = '1'
   LET g_master.xrda016  = '1'
   LET g_master.xrda001 = '41'
   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_master.xrdasite,
                                                       g_master.xrdald,g_xrdacomp
   CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
   CALL s_desc_get_department_desc(g_master.xrdasite)RETURNING g_master.xrdasite_desc  
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrdald
   CALL s_fin_get_wc_str(g_wc_xrdald) RETURNING g_wc_xrdald
   DISPLAY BY NAME g_master.xrdald_desc,g_master.xrdasite_desc,g_master.xrdastus,g_master.xrda016 
   #151231-00010#8--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#8--add--end
   
   #160518-00075#11 2016/07/25 By 07900 add --s--
   LET g_sql_ctr3 = NULL
   LET g_sql_ctr2 = NULL
   
   SELECT glaa024 INTO g_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_site
      AND glaa014 = 'Y' 

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
   #160518-00075#11  2016/07/25 By 07900  add --e--
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrr400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr400_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5 #160811-00009#5 
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
         INPUT BY NAME g_master.xrdasite,g_master.xrdald,g_master.xrda001,g_master.xrda016,g_master.xrdastus  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdasite
            
            #add-point:AFTER FIELD xrdasite name="input.a.xrdasite"
            LET g_master.xrdasite_desc = ''
            IF NOT cl_null(g_master.xrdasite) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.xrdasite#160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooef001") THEN
                  #檢查失敗時後續處理
                  LET g_master.xrdasite = ''
                  LET g_master.xrdasite_desc = ''
                  DISPLAY BY NAME g_master.xrdasite_desc,g_master.xrdasite  
                  NEXT FIELD CURRENT
               END IF
#160811-00009#5 mod s---  #161021-00050#7 remark(s)        
               CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #失敗給回預設
                  LET g_master.xrdasite = ''
                  LET g_master.xrdasite_desc = ''                                                    
                  DISPLAY BY NAME g_master.xrdasite_desc,g_master.xrdald_desc
                  NEXT FIELD CURRENT
               END IF
               #161021-00050#7 remark(e)
                  CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'site')
                     RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                  DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
                  DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF 
#160811-00009#5 mod e---    
            END IF
            #取得所屬法人+帳別
            CALL s_fin_orga_get_comp_ld(g_master.xrdasite) RETURNING g_sub_success,g_errno,g_xrdacomp,g_master.xrdald
            CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_xrdald
            CALL s_fin_get_wc_str(g_wc_xrdald) RETURNING g_wc_xrdald
            LET g_master.xrdald_desc   = s_desc_get_ld_desc(g_master.xrdald)
            CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
            DISPLAY BY NAME g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdasite
            #add-point:BEFORE FIELD xrdasite name="input.b.xrdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdasite
            #add-point:ON CHANGE xrdasite name="input.g.xrdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdald
            
            #add-point:AFTER FIELD xrdald name="input.a.xrdald"
            LET g_master.xrdald_desc   = ''       
            IF NOT cl_null(g_master.xrdald) AND NOT cl_null(g_master.xrdasite) THEN
#160811-00009#5 mod s---
#               CALL s_fin_account_center_with_ld_chk(g_master.xrdasite,g_master.xrdald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
#               IF NOT g_sub_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  LET g_master.xrdald = ''
#                  LET g_master.xrdald_desc =''
#                  DISPLAY BY NAME g_master.xrdald_desc
#                  NEXT FIELD CURRENT
#               END IF
                  CALL s_axrt300_site_geared_ld(g_master.xrdasite,g_master.xrdald,g_user,g_today,'ld')
                     RETURNING l_success,g_master.xrdasite,g_master.xrdasite_desc,g_master.xrdald,g_master.xrdald_desc
                  DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
                  DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF 
#160811-00009#5 mod e---                  
            END IF
            LET g_master.xrdald_desc   = s_desc_get_ld_desc(g_master.xrdald)
            DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc

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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda016
            #add-point:BEFORE FIELD xrda016 name="input.b.xrda016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda016
            
            #add-point:AFTER FIELD xrda016 name="input.a.xrda016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrda016
            #add-point:ON CHANGE xrda016 name="input.g.xrda016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdastus
            #add-point:BEFORE FIELD xrdastus name="input.b.xrdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdastus
            
            #add-point:AFTER FIELD xrdastus name="input.a.xrdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrdastus
            #add-point:ON CHANGE xrdastus name="input.g.xrdastus"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xrdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdasite
            #add-point:ON ACTION controlp INFIELD xrdasite name="input.c.xrdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrdasite
            #CALL q_ooef001()                         #161021-00050#7 mark
            LET g_qryparam.where = "ooefstus = 'Y'"   #161021-00050#7 add
            CALL q_ooef001_46()                       #161021-00050#7 add
            LET g_master.xrdasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.xrdasite) RETURNING g_master.xrdasite_desc
            DISPLAY BY NAME g_master.xrdasite,g_master.xrdasite_desc
            NEXT FIELD xrdasite
            #END add-point
 
 
         #Ctrlp:input.c.xrdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdald
            #add-point:ON ACTION controlp INFIELD xrdald name="input.c.xrdald"
            #160811-00009#5 add s---
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            #將取回的字串轉換為SQL條件
            CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc      
            #160811-00009#5 add e---            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xrdald                     #給予default值
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套) #160811-00009#5 
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""    #160811-00009#5 
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_xrdald
            CALL q_authorised_ld()                                       #呼叫開窗
            LET g_master.xrdald = g_qryparam.return1                      #將開窗取得的值回傳到變數
            LET g_master.xrdald_desc   = s_desc_get_ld_desc(g_master.xrdald)
            DISPLAY BY NAME g_master.xrdald,g_master.xrdald_desc
            NEXT FIELD xrdald                                            #返回原欄位  
            #END add-point
 
 
         #Ctrlp:input.c.xrda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda001
            #add-point:ON ACTION controlp INFIELD xrda001 name="input.c.xrda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrda016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda016
            #add-point:ON ACTION controlp INFIELD xrda016 name="input.c.xrda016"
            
            #END add-point
 
 
         #Ctrlp:input.c.xrdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdastus
            #add-point:ON ACTION controlp INFIELD xrdastus name="input.c.xrdastus"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xrdadocno,xrdadocdt,xrda005,xrda003,xrda014
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrdadocno
            #add-point:BEFORE FIELD xrdadocno name="construct.b.xrdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrdadocno
            
            #add-point:AFTER FIELD xrdadocno name="construct.a.xrdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrdadocno
            #add-point:ON ACTION controlp INFIELD xrdadocno name="construct.c.xrdadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrda001 = '",g_master.xrda001,"' AND xrdald = '",g_master.xrdald,"' ",
                                   "      AND xrdasite = '",g_master.xrdasite,"' "
            #151231-00010#8--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = xrdaent",
                                                       "                AND pmaa001 = xrda005 )"
            END IF
            #151231-00010#8--add--end
            
            #160518-00075#11 2016/07/25 By 07900 add --s--
             IF NOT cl_null(g_sql_ctr2) AND NOT cl_null(g_sql_ctr3) THEN
               LET g_qryparam.where = g_qryparam.where," AND (substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xrdadocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
            END IF
            #160518-00075#11 2016/07/25 By 07900 add --e--
            CALL q_xrdadocno()
            DISPLAY g_qryparam.return1 TO xrdadocno
            NEXT FIELD xrdadocno
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
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda005
            #add-point:BEFORE FIELD xrda005 name="construct.b.xrda005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda005
            
            #add-point:AFTER FIELD xrda005 name="construct.a.xrda005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda005
            #add-point:ON ACTION controlp INFIELD xrda005 name="construct.c.xrda005"
            #付款對象
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#8--add--str--
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent",
                                      "            AND pmaa001 = pmac001 )"
            END IF
            #151231-00010#8--add--end
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO xrda005  #顯示到畫面上
            NEXT FIELD xrda005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda003
            #add-point:BEFORE FIELD xrda003 name="construct.b.xrda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda003
            
            #add-point:AFTER FIELD xrda003 name="construct.a.xrda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda003
            #add-point:ON ACTION controlp INFIELD xrda003 name="construct.c.xrda003"
            #帳務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xrda003
            NEXT FIELD xrda003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrda014
            #add-point:BEFORE FIELD xrda014 name="construct.b.xrda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrda014
            
            #add-point:AFTER FIELD xrda014 name="construct.a.xrda014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xrda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrda014
            #add-point:ON ACTION controlp INFIELD xrda014 name="construct.c.xrda014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xrda001 = '",g_master.xrda001,"' AND xrdald = '",g_master.xrdald,"' ",
                                   "      AND xrdasite = '",g_master.xrdasite,"' "
            CALL q_xrda014()
            DISPLAY g_qryparam.return1 TO xrda014
            NEXT FIELD xrda014
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
            CALL axrr400_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axrr400_get_buffer(l_dialog)
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
            LET g_master.xrdastus = '1'
            LET g_master.xrda016 = '1'
            LET g_master.xrda001 = '41'
            #帳務組織/帳套/法人預設
            CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_master.xrdasite,
                                                                g_master.xrdald,g_xrdacomp
            CALL s_desc_get_ld_desc(g_master.xrdald) RETURNING g_master.xrdald_desc
            CALL s_desc_get_department_desc(g_master.xrdasite)RETURNING g_master.xrdasite_desc  
            
            DISPLAY BY NAME   g_master.xrdald_desc,g_master.xrdasite_desc
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_master.xrdasite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_xrdald
            CALL s_fin_get_wc_str(g_wc_xrdald) RETURNING g_wc_xrdald
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
         CALL axrr400_init()
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
                 CALL axrr400_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axrr400_transfer_argv(ls_js)
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
 
{<section id="axrr400.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axrr400_transfer_argv(ls_js)
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
 
{<section id="axrr400.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axrr400_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xrdadocno,xrdadocdt,xrda005,xrda003,xrda014")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN  ## 若是t類進來 會是傳字串參數的方式
       CALL l_arg.clear()
       LET l_token = base.StringTokenizer.create(ls_js,",")
       LET l_cnt = 1
       WHILE l_token.hasMoreTokens()
             LET ls_next = l_token.nextToken()
             LET l_arg[l_cnt] = ls_next
             LET l_cnt = l_cnt + 1
       END WHILE
       CALL l_arg.deleteElement(l_cnt)
       LET g_master.wc = l_arg[01]
   ELSE       
      LET g_master.wc = g_master.wc CLIPPED, " AND xrda001 = '",g_master.xrda001,"' AND xrdaent ='",g_enterprise,"' ",
                                             " AND xrdald =  '",g_master.xrdald,"'  AND xrdasite = '",g_master.xrdasite,"' "
                                            
      
      #列印狀態                                       
      CASE g_master.xrda016 
         WHEN 1 #未列印
            LET g_master.wc = g_master.wc CLIPPED, " AND xrda016 = '0' "
         WHEN 2 #已列印
            LET g_master.wc = g_master.wc CLIPPED, " AND xrda016 <> '0' "       
      END CASE
      #單據狀態   
      CASE g_master.xrdastus  
         WHEN 1  #已確認
            LET g_master.wc = g_master.wc CLIPPED, " AND xrdastus = 'Y' "
         WHEN 2  #未確認
            LET g_master.wc = g_master.wc CLIPPED, " AND xrdastus = 'N' " 
      END CASE
   END IF
  # LET g_master.wc = g_master.wc CLIPPED, "  AND xrde002 = '10' "
  
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
      
   CALL axrr400_g01(g_master.wc)#,g_master.xrdald) #xulong 20160726 add  g_master.xrdald  #160815-00029#1 xulong mark
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axrr400_process_cs CURSOR FROM ls_sql
#  FOREACH axrr400_process_cs INTO
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
 
{<section id="axrr400.get_buffer" >}
PRIVATE FUNCTION axrr400_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xrdasite = p_dialog.getFieldBuffer('xrdasite')
   LET g_master.xrdald = p_dialog.getFieldBuffer('xrdald')
   LET g_master.xrda001 = p_dialog.getFieldBuffer('xrda001')
   LET g_master.xrda016 = p_dialog.getFieldBuffer('xrda016')
   LET g_master.xrdastus = p_dialog.getFieldBuffer('xrdastus')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axrr400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
