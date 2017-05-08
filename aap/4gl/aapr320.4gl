#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-05-10 09:49:28), PR版次:0006(2016-10-24 10:47:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000046
#+ Filename...: aapr320
#+ Description: 應付餘額明細表列印
#+ Creator....: 03080(2015-09-01 13:54:31)
#+ Modifier...: 04152 -SD/PR- 06137
 
{</section>}
 
{<section id="aapr320.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#5   2016/01/20 By sakura 增加控制組
#160812-00027#4   2016/08/18 By 06821  全面盤點應付程式帳套權限控管
#161014-00053#1   2016/10/18 By 08171  帳套權限控管調整
#161006-00005#21  2016/10/24 By 06137  組織類型與職能開窗清單需測試及調整開窗內容
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
       site LIKE type_t.chr10, 
   site_desc LIKE type_t.chr80, 
   ld LIKE type_t.chr5, 
   ld_desc LIKE type_t.chr80, 
   comp LIKE type_t.chr10, 
   comp_desc LIKE type_t.chr80, 
   paytype LIKE type_t.chr500, 
   stus LIKE type_t.chr500, 
   groupby1 LIKE type_t.chr1, 
   apca003 LIKE type_t.chr20, 
   apca005 LIKE type_t.chr10, 
   apcadocdt LIKE type_t.dat, 
   apcadocno LIKE type_t.chr20, 
   apca001 LIKE type_t.chr10, 
   apca007 LIKE type_t.chr10, 
   apca100 LIKE type_t.chr10, 
   apca015 LIKE type_t.chr10,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o type_master
DEFINE g_wc_apcald   STRING
DEFINE g_sql_ctrl    STRING   #151231-00010#5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapr320.main" >}
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
      CALL aapr320_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapr320 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapr320_init()
 
      #進入選單 Menu (="N")
      CALL aapr320_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapr320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapr320.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapr320_init()
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
   CALL cl_set_combo_scc('apca001','8502')
   CALL s_fin_create_account_center_tmp()
   #151231-00010#1(S)
   LET g_sql_ctrl = NULL
   CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#1(E)    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapr320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr320_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp_wc STRING  #161014-00053#1
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapr320_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.site,g_master.ld,g_master.comp,g_master.paytype,g_master.stus,g_master.groupby1  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD site
            
            #add-point:AFTER FIELD site name="input.a.site"
            LET g_master.site_desc = ''
            #####
            DISPLAY BY NAME g_master.site_desc
            IF NOT cl_null(g_master.site) THEN
               CALL s_fin_account_center_sons_query('3',g_master.site,g_today,'1')
               IF g_master.site != g_master_o.site OR g_master_o.site IS NULL  THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.site,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #失敗給回預設
                     LET g_master.site = g_master_o.site
                     CALL s_fin_account_center_sons_query('3',g_master.site,g_today,'1')
                     CALL s_desc_get_department_desc(g_master.site) RETURNING g_master.site_desc
                     DISPLAY BY NAME g_master.site_desc,g_master.site
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_master.site) RETURNING g_sub_success,g_errno,g_master.comp,g_master.ld
                  CALL s_desc_get_ld_desc(g_master.ld) RETURNING g_master.ld_desc
                  CALL s_desc_get_department_desc(g_master.comp) RETURNING g_master.comp_desc
                  DISPLAY BY NAME g_master.ld,g_master.ld_desc,g_master.comp,g_master.comp_desc
               END IF
            END IF                            
            #CALL s_fin_account_center_sons_query('3',g_master.site,g_today,'')   #161014-00053#1 mark
            CALL s_fin_account_center_sons_query('3',g_master.site,g_today,'1')  #依據正確的資料再重展一次結構 #161014-00053#1 add
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            CALL s_desc_get_department_desc(g_master.site) RETURNING g_master.site_desc
            LET g_master_o.site = g_master.site
            DISPLAY BY NAME g_master.site_desc,g_master.site
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD site
            #add-point:BEFORE FIELD site name="input.b.site"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE site
            #add-point:ON CHANGE site name="input.g.site"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ld
            
            #add-point:AFTER FIELD ld name="input.a.ld"
            LET g_master.ld_desc = ''
            DISPLAY BY NAME g_master.ld_desc
            IF NOT cl_null(g_master.ld) THEN
               CALL s_fin_account_center_sons_query('3',g_master.ld,g_today,'1')
               IF g_master.ld != g_master_o.ld OR g_master_o.ld IS NULL  THEN
                  #CALL s_fin_account_center_with_ld_chk(g_master.site,g_master.ld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #160812-00027#4 mark
                  #CALL s_fin_account_center_with_ld_chk(g_master.site,g_master.ld,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno  #160812-00027#4 add #161014-00053#1 mark
                  CALL s_fin_account_center_with_ld_chk(g_master.site,g_master.ld,g_user,'3','Y',g_wc_apcald,g_today) RETURNING g_sub_success,g_errno  #161014-00053#1 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #失敗給回預設
                     LET g_master.ld = g_master_o.ld
                     CALL s_desc_get_ld_desc(g_master.ld) RETURNING g_master.ld_desc
                     DISPLAY BY NAME g_master.ld_desc,g_master.ld
                     NEXT FIELD CURRENT
                  END IF
                  
                  SELECT glaacomp INTO g_master.comp FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_master.ld
                  CALL s_desc_get_department_desc(g_master.comp) RETURNING g_master.comp_desc                 
                  DISPLAY BY NAME g_master.comp,g_master.comp_desc
               END IF
            END IF           
            LET g_master_o.ld = g_master.ld
            CALL s_desc_get_ld_desc(g_master.ld) RETURNING g_master.ld_desc
            DISPLAY BY NAME g_master.ld_desc,g_master.ld
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ld
            #add-point:BEFORE FIELD ld name="input.b.ld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ld
            #add-point:ON CHANGE ld name="input.g.ld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD comp
            
            #add-point:AFTER FIELD comp name="input.a.comp"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD comp
            #add-point:BEFORE FIELD comp name="input.b.comp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE comp
            #add-point:ON CHANGE comp name="input.g.comp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD paytype
            #add-point:BEFORE FIELD paytype name="input.b.paytype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD paytype
            
            #add-point:AFTER FIELD paytype name="input.a.paytype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE paytype
            #add-point:ON CHANGE paytype name="input.g.paytype"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stus
            #add-point:BEFORE FIELD stus name="input.b.stus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stus
            
            #add-point:AFTER FIELD stus name="input.a.stus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stus
            #add-point:ON CHANGE stus name="input.g.stus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD groupby1
            #add-point:BEFORE FIELD groupby1 name="input.b.groupby1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD groupby1
            
            #add-point:AFTER FIELD groupby1 name="input.a.groupby1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE groupby1
            #add-point:ON CHANGE groupby1 name="input.g.groupby1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.site
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD site
            #add-point:ON ACTION controlp INFIELD site name="input.c.site"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.site
            #CALL q_ooef001()       #161006-00005#21 Mark By Ken 161024
            CALL q_ooef001_46()     #161006-00005#21 Add By Ken 161024
            LET g_master.site = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.site) RETURNING g_master.site_desc
            DISPLAY BY NAME g_master.site,g_master.site_desc
            NEXT FIELD site
            #END add-point
 
 
         #Ctrlp:input.c.ld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ld
            #add-point:ON ACTION controlp INFIELD ld name="input.c.ld"
            #帳別
            #161014-00053#1 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapr320_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161014-00053#1 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ld
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_apcald                                      #160812-00027#4 mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald  #160812-00027#4 add #161014-00053#1 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""   #161014-00053#1 add
            CALL q_authorised_ld()
            LET g_master.ld = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.ld) RETURNING g_master.ld_desc
            DISPLAY BY NAME g_master.ld,g_master.ld_desc
            NEXT FIELD ld
            #END add-point
 
 
         #Ctrlp:input.c.comp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD comp
            #add-point:ON ACTION controlp INFIELD comp name="input.c.comp"
 
            #END add-point
 
 
         #Ctrlp:input.c.paytype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD paytype
            #add-point:ON ACTION controlp INFIELD paytype name="input.c.paytype"
            
            #END add-point
 
 
         #Ctrlp:input.c.stus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stus
            #add-point:ON ACTION controlp INFIELD stus name="input.c.stus"
            
            #END add-point
 
 
         #Ctrlp:input.c.groupby1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD groupby1
            #add-point:ON ACTION controlp INFIELD groupby1 name="input.c.groupby1"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apca003,apca005,apcadocdt,apcadocno,apca001,apca007,apca100, 
             apca015
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.apca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca003
            #add-point:ON ACTION controlp INFIELD apca003 name="construct.c.apca003"
            #帳務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apca003      #顯示到畫面上
            NEXT FIELD apca003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca003
            #add-point:BEFORE FIELD apca003 name="construct.b.apca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca003
            
            #add-point:AFTER FIELD apca003 name="construct.a.apca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca005
            #add-point:ON ACTION controlp INFIELD apca005 name="construct.c.apca005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = pmacent ",
                                      "            AND pmaa001 = pmac002 )"
            END IF
            #151231-00010#1(E)            
            CALL q_pmac002_1()
            DISPLAY g_qryparam.return1 TO apca005  #顯示到畫面上
            NEXT FIELD apca005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca005
            #add-point:BEFORE FIELD apca005 name="construct.b.apca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca005
            
            #add-point:AFTER FIELD apca005 name="construct.a.apca005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="construct.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="construct.a.apcadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="construct.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="construct.c.apcadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcasite = '",g_master.site,"' AND apcald = '",g_master.ld,"' "

            #單據狀態
            CASE g_master.stus
               WHEN 1  #已確認
                  LET g_qryparam.where = g_qryparam.where CLIPPED, " AND apcastus = 'Y' "
               WHEN 2  #未確認
                  LET g_qryparam.where = g_qryparam.where CLIPPED, " AND apcastus = 'N' "
            END CASE          

            CASE g_master.paytype
               WHEN 1 #未付款
                  LET g_qryparam.where = g_qryparam.where CLIPPED, 
                  " AND (apcald,apcadocno) IN (SELECT DISTINCT apccld,apccdocno FROM apcc_t ",
                                               " WHERE apccent = ",g_enterprise," ",
                                               "   AND ((apcc108-apcc109>0) OR (apcc118+apcc113-apcc119>0))) "
               WHEN 2 #已付款
               LET g_qryparam.where = g_qryparam.where CLIPPED, 
                   " AND (apcald,apcadocno) IN (SELECT DISTINCT apccld,apccdocno FROM apcc_t ",
                                               " WHERE apccent = ",g_enterprise," ",
                                                 " AND (apcc108-apcc109)=0 AND (apcc118+apcc113-apcc119) = 0)"
            END CASE
            #151231-00010#1(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = apcaent ",
                                                       "                AND pmaa001 = apca004 )"
            END IF
            #151231-00010#1(E)			   
            CALL q_apcadocno()
            DISPLAY g_qryparam.return1 TO apcadocno
            NEXT FIELD apcadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="construct.b.apcadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="construct.a.apcadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="construct.b.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="construct.a.apca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="construct.c.apca001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="construct.c.apca007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3211'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apca007  
            NEXT FIELD apca007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="construct.b.apca007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="construct.a.apca007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca100
            #add-point:ON ACTION controlp INFIELD apca100 name="construct.c.apca100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO apca100  #顯示到畫面上
            NEXT FIELD apca100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca100
            #add-point:BEFORE FIELD apca100 name="construct.b.apca100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca100
            
            #add-point:AFTER FIELD apca100 name="construct.a.apca100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca015
            #add-point:ON ACTION controlp INFIELD apca015 name="construct.c.apca015"
            #應用 a08 樣板自動產生(Version:2)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO apca015  #顯示到畫面上
            NEXT FIELD apca015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca015
            #add-point:BEFORE FIELD apca015 name="construct.b.apca015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca015
            
            #add-point:AFTER FIELD apca015 name="construct.a.apca015"
            
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
            CALL aapr320_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aapr320_get_buffer(l_dialog)
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
            CALL aapr320_qbeclear()
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
         CALL aapr320_init()
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
                 CALL aapr320_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapr320_transfer_argv(ls_js)
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
 
{<section id="aapr320.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapr320_transfer_argv(ls_js)
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
 
{<section id="aapr320.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapr320_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"apca003,apca005,apcadocdt,apcadocno,apca001,apca007,apca100,apca015")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   LET g_master.wc = g_master.wc CLIPPED, " AND apcaent  = ",g_enterprise,"       ",
                                          " AND apcald = '",g_master.ld,"'   AND apcasite = '",g_master.site,"' "
   #付款狀態
   CASE g_master.paytype
      WHEN 1 #未付款
         LET g_master.wc = g_master.wc CLIPPED, " AND ((apcc108-apcc109>0) OR (apcc118+apcc113-apcc119>0)) "
      WHEN 2 #已付款
      LET g_master.wc = g_master.wc CLIPPED, " AND (apcc108-apcc109)=0 AND (apcc118+apcc113-apcc119) = 0"
   END CASE
   #單據狀態
   CASE g_master.stus
      WHEN 1  #已確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apcastus = 'Y' "
      WHEN 2  #未確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apcastus = 'N' "
   END CASE
   
   #151231-00010#1(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_master.wc = g_master.wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                    "              WHERE pmaaent = ",g_enterprise,
                                    "                AND ",g_sql_ctrl,
                                    "                AND pmaaent = apcaent ",
                                    "                AND pmaa001 = apca004 )"
   END IF
   #151231-00010#1(E)   
   
   CALL aapr320_g01(g_master.wc,g_master.groupby1)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapr320_process_cs CURSOR FROM ls_sql
#  FOREACH aapr320_process_cs INTO
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
 
{<section id="aapr320.get_buffer" >}
PRIVATE FUNCTION aapr320_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.site = p_dialog.getFieldBuffer('site')
   LET g_master.ld = p_dialog.getFieldBuffer('ld')
   LET g_master.comp = p_dialog.getFieldBuffer('comp')
   LET g_master.paytype = p_dialog.getFieldBuffer('paytype')
   LET g_master.stus = p_dialog.getFieldBuffer('stus')
   LET g_master.groupby1 = p_dialog.getFieldBuffer('groupby1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 操作預設值給予
# Memo...........:
# Date & Author..: 150901 by albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr320_qbeclear()
   INITIALIZE g_master.* TO NULL
   CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_master.site,g_master.ld, g_master.comp
   LET g_master.site_desc = s_desc_get_department_desc(g_master.site)
   LET g_master.ld_desc = s_desc_get_ld_desc(g_master.ld)
   LET g_master.comp_desc = s_desc_get_department_desc(g_master.comp)
   LET g_master.paytype  = '1'
   LET g_master.stus = '1'
   LET g_master.groupby1 = 'N'
   DISPLAY BY NAME g_master.site,g_master.ld,g_master.comp,
                   g_master.site_desc,g_master.ld_desc,g_master.comp_desc,
                   g_master.paytype,g_master.stus,g_master.groupby1
    
   LET g_master_o.* = g_master.*
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........:
# Usage..........: CALL aapr320_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161019 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr320_get_ooef001_wc(p_wc)
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

#end add-point
 
{</section>}
 
