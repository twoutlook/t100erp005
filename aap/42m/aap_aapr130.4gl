#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr130.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-10-19 09:20:55), PR版次:0006(2016-10-24 10:24:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: aapr130
#+ Description: 入庫帳款明細表
#+ Creator....: 05016(2014-12-10 14:43:27)
#+ Modifier...: 08171 -SD/PR- 06137
 
{</section>}
 
{<section id="aapr130.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#150629-00038#1    150630  albireo  入庫單性質增加20委外採購入庫  借貨相關   
#150702-00001#1    150703  albireo  入庫單性質改動態取用
#151102-00008#1    151104  Jessy    畫面增加選項 已立暫估未立帳款
#151231-00010#5    2016/01/20 By sakura 增加控制組
#161014-00053#1    161018  By 08171 帳套權限、交易對象控制組
#161006-00005#21   2016/10/24 By 06137  組織類型與職能開窗清單需測試及調整開窗內容
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
       apcasite LIKE apca_t.apcasite, 
   apcasite_desc LIKE type_t.chr80, 
   apcald LIKE apca_t.apcald, 
   apcald_desc LIKE type_t.chr80, 
   apcacomp_desc LIKE type_t.chr80, 
   pmds007 LIKE pmds_t.pmds007, 
   pmdt001 LIKE pmdt_t.pmdt001, 
   pmds001 LIKE pmds_t.pmds001, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmds011 LIKE pmds_t.pmds011, 
   type LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_apcacomp           LIKE apca_t.apcacomp
DEFINE g_wc_apcasite        STRING
DEFINE g_wc_apcald          STRING
DEFINE g_wc2                STRING
DEFINE g_sql_ctrl           STRING   #151231-00010#5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapr130.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aapr130_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapr130 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapr130_init()
 
      #進入選單 Menu (="N")
      CALL aapr130_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapr130
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapr130.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapr130_init()
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
   CALL cl_set_combo_scc('pmds011','2052')
   #建立撈取帳務中心所屬範圍需使用的暫存檔
   CALL s_fin_create_account_center_tmp()
   LET g_master.type = '1'

   #取預設帳務中心
   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apcasite,g_master.apcald,g_apcacomp
   CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald

   LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
   LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
   LET g_master.apcacomp_desc = s_desc_show1(g_apcacomp,s_desc_get_department_desc(g_apcacomp))

   DISPLAY BY NAME g_master.apcald  ,g_master.apcald_desc,
                   g_master.apcasite,g_master.apcasite_desc,
                  g_master.apcacomp_desc
   
   #151231-00010#1(S)
   LET g_sql_ctrl = NULL
   CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapr130.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr130_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_pmds000_str1   STRING   #150702-00001#1 add
   DEFINE l_comp_wc        STRING   #161014-00053#1 add
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"(gzcb003 = 'Y' OR gzcb005 = '2')")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)
   #150702-00001#1-----e
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald,g_master.type 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            #帳務中心
            LET g_master.apcald_desc = ''
            IF NOT cl_null(g_master.apcasite) THEN
               #取得法人            
               CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,g_apcacomp,g_master.apcald      
               LET g_master.apcacomp_desc = s_desc_show1(g_apcacomp,s_desc_get_department_desc(g_apcacomp))
               DISPLAY BY NAME g_master.apcacomp_desc

               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald

               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #161014-00053#1 --s add
                  #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                  CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,g_apcacomp,g_master.apcald
                  #判斷這個主帳套使用者是否有權限
                  CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  #161014-00053#1 --e add
                  NEXT FIELD CURRENT
               END IF

               LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
               LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
               DISPLAY BY NAME g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
            END IF
            #161014-00053#1 --s add
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下之組織範圍
            CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
            CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            #161014-00053#1 --e add   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcasite
            #add-point:BEFORE FIELD apcasite name="input.b.apcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcasite
            #add-point:ON CHANGE apcasite name="input.g.apcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcald
            
            #add-point:AFTER FIELD apcald name="input.a.apcald"
            #帳套
            LET g_master.apcald_desc = ''
            IF NOT cl_null(g_master.apcald) THEN                             
               #CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N',g_wc_apcald,g_today) #161014-00053#1 mark   
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','Y',g_wc_apcald,g_today)  #161014-00053#1 add     
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #161014-00053#1 add
                  LET g_master.apcald = ''
                  CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,g_apcacomp,g_errno
                  LET g_master.apcacomp_desc = s_desc_show1(g_apcacomp,s_desc_get_department_desc(g_apcacomp))
                  LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
                  DISPLAY BY NAME  g_master.apcacomp_desc,g_master.apcald_desc
                  #161014-00053#1 add
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,g_apcacomp,g_errno
            LET g_master.apcacomp_desc = s_desc_show1(g_apcacomp,s_desc_get_department_desc(g_apcacomp))
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME  g_master.apcacomp_desc,g_master.apcald_desc

  
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type name="input.b.type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type name="input.a.type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type
            #add-point:ON CHANGE type name="input.g.type"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite
            #CALL q_ooef001()      #161006-00005#21 Mark By Ken 161024
            CALL q_ooef001_46()    #161006-00005#21 Add By Ken 161024
            LET g_master.apcasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.apcasite_desc
            NEXT FIELD apcasite
            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            #帳套
            #161014-00053#1 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapr130_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161014-00053#1 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald  #161014-00053#1 mark            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""    #161014-00053#1 add
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.apcald = g_qryparam.return1
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            NEXT FIELD apcald


            #END add-point
 
 
         #Ctrlp:input.c.type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type name="input.c.type"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
          
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmds007,pmdt001,pmds001,pmdtdocno,pmds011
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds007
            #add-point:ON ACTION controlp INFIELD pmds007 name="construct.c.pmds007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#1(E)            
            CALL q_pmaa001_3()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmds007  #顯示到畫面上
            NEXT FIELD pmds007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds007
            #add-point:BEFORE FIELD pmds007 name="construct.b.pmds007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds007
            
            #add-point:AFTER FIELD pmds007 name="construct.a.pmds007"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdt001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdt001
            #add-point:ON ACTION controlp INFIELD pmdt001 name="construct.c.pmdt001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmdlent ",
                                      "            AND pmaa001 = pmdl004 )"
            END IF
            #151231-00010#1(E)            
            CALL q_pmdldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdt001  #顯示到畫面上
            NEXT FIELD pmdt001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdt001
            #add-point:BEFORE FIELD pmdt001 name="construct.b.pmdt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdt001
            
            #add-point:AFTER FIELD pmdt001 name="construct.a.pmdt001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds001
            #add-point:BEFORE FIELD pmds001 name="construct.b.pmds001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds001
            
            #add-point:AFTER FIELD pmds001 name="construct.a.pmds001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmds001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds001
            #add-point:ON ACTION controlp INFIELD pmds001 name="construct.c.pmds001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdtdocno
            #add-point:BEFORE FIELD pmdtdocno name="construct.b.pmdtdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdtdocno
            
            #add-point:AFTER FIELD pmdtdocno name="construct.a.pmdtdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdtdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdtdocno
            #add-point:ON ACTION controlp INFIELD pmdtdocno name="construct.c.pmdtdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL s_fin_get_ld_type(g_master.apcald) RETURNING g_qryparam.arg1
            LET g_qryparam.where = 
                                   #"     pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','22','24','25','26','20') ",   #150702-00001#1 mark  #150629-00038#1 add 17~20    #pmds000:SCC-2060排除收貨單
                                   "     pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
                                   " AND pmdtsite IN ",g_wc_apcasite," ",
                                   " AND pmdt084 = 'Y' "                       #排除"多角貿易"型態的單子
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = pmdtent ",
                                                       "                AND pmaa001 = pmds008 )"
            END IF
            #151231-00010#1(E)			   
            CALL q_pmdtdocno_7()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdtdocno  #顯示到畫面上
            NEXT FIELD pmdtdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds011
            #add-point:BEFORE FIELD pmds011 name="construct.b.pmds011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds011
            
            #add-point:AFTER FIELD pmds011 name="construct.a.pmds011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmds011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds011
            #add-point:ON ACTION controlp INFIELD pmds011 name="construct.c.pmds011"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc2 ON pmdl002
             ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl002  #顯示到畫面上
               NEXT FIELD pmdl002                     #返回原欄位

         END CONSTRUCT
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
            CALL aapr130_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aapr130_get_buffer(l_dialog)
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
         CALL aapr130_init()
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
                 CALL aapr130_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapr130_transfer_argv(ls_js)
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
 
{<section id="aapr130.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapr130_transfer_argv(ls_js)
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
 
{<section id="aapr130.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapr130_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"pmds007,pmdt001,pmds001,pmdtdocno,pmds011")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF
   LET g_master.wc = g_master.wc CLIPPED, " AND pmdssite IN ",g_wc_apcasite
   
  
#   CASE g_master.type
#      #未匹配
#      WHEN '1' LET g_master.wc = g_master.wc,"  AND apcb007 <> 0 "
#      #已匹配
#      WHEN '2' LET g_master.wc = g_master.wc,"  AND apcb007 = 0 "
#      #全部
#   END CASE
   IF g_wc2 <> " 1=1" THEN
      LET g_master.wc = g_master.wc," AND EXISTS ( SELECT 1 FROM pmdl_t ",
                                   "               WHERE pmdlent ='",g_enterprise,"' ",
                                   "                 AND pmdldocno = pmdt001 ",
                                   "                 AND ",g_wc2,") "
   END IF
   #g_master.type 匹配否條件
   #151231-00010#1(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_master.wc = g_master.wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                    "              WHERE pmaaent = ",g_enterprise,
                                    "                AND ",g_sql_ctrl,
                                    "                AND pmaaent = pmdsent ",
                                    "                AND pmaa001 = pmds007 )"
   END IF
   #151231-00010#1(E)    
   CALL aapr130_x01(g_master.wc,g_master.apcald,g_apcacomp,g_master.type,'1')
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapr130_process_cs CURSOR FROM ls_sql
#  FOREACH aapr130_process_cs INTO
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
 
{<section id="aapr130.get_buffer" >}
PRIVATE FUNCTION aapr130_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
   LET g_master.type = p_dialog.getFieldBuffer('type')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr130.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#1
# Usage..........: CALL aapr130_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161018 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr130_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aapr130_site_geared_ld(p_site,p_ld,p_user,p_date,p_flag)
#                  RETURNING 回传参数
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr130_site_geared_ld(p_site,p_ld,p_user,p_date,p_flag)
   DEFINE p_site         LIKE apca_t.apcasite
   DEFINE p_ld           LIKE apca_t.apcald
   DEFINE p_user         LIKE apca_t.apca003
   DEFINE p_date         LIKE apca_t.apcadocdt
   DEFINE p_flag         LIKE type_t.chr10

   DEFINE r_success      LIKE type_t.num5
   DEFINE r_site         LIKE apca_t.apcasite
   DEFINE r_ld           LIKE apca_t.apcald

   DEFINE l_success      LIKE type_t.num5
   DEFINE l_errno        LIKE type_t.chr10
   DEFINE l_comp         LIKE glaa_t.glaacomp

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CALL s_fin_account_center_sons_query('3',p_site,p_date,'1')

   #檢查修改
   CALL s_fin_account_center_with_ld_chk(p_site,p_ld,p_user,'3','Y','',p_date) RETURNING l_success,l_errno   #160811-00009#1 Mod 'N' --> 'Y'
   IF cl_null(l_errno) AND NOT cl_null(p_site) AND NOT cl_null(p_ld) THEN
      LET r_site = p_site
      LET r_ld = p_ld
   ELSE
      IF p_flag = 'site' THEN
         LET r_site = p_site
         CALL s_fin_account_center_sons_query('3',r_site,p_date,'1')
         CALL s_fin_orga_get_comp_ld(r_site) RETURNING l_success,l_errno,l_comp,r_ld
      ELSE
         LET r_ld = p_ld
         LET r_site = p_site  
      END IF
   END IF

   CALL s_fin_account_center_with_ld_chk(r_site,r_ld,p_user,'3','Y','',p_date) RETURNING l_success,l_errno 
   IF NOT cl_null(l_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      IF p_flag = 'site' THEN
         LET g_errparam.extend = r_site
      ELSE
         LET g_errparam.extend = r_ld
      END IF  
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   IF NOT r_success THEN
      IF p_flag = 'site' THEN
         LET r_site = ''
         LET r_ld = p_ld
      ELSE
         LET r_ld = ''
         LET r_site = p_site
      END IF
   END IF


   RETURN r_success,r_site,r_ld
END FUNCTION

#end add-point
 
{</section>}
 
