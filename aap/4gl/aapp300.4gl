#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-02-24 16:43:09), PR版次:0010(2017-01-06 16:31:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: aapp300
#+ Description: 應付帳款單批次確認
#+ Creator....: 03080(2015-01-06 13:53:04)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapp300.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#141030-00016#2                           aapt310採購預付確認段元件改CALL s_aapt310_conf_upd
#160509-00004#116  2016/08/15 By 02114    增加aapt210的逻辑
#160908-00006#1    2016/09/08 By Reanna   修正單據確認時產生的待抵單沒有產生多帳期
#161014-00053#6    2016/10/21 By 06814    補上控制組邏輯
#161006-00005#18   2016/10/26 By 08732    組織類型與職能開窗調整
#161115-00042#1    2016/11/18 By 08171    開窗範圍處理+帳套權限調整
#161229-00047#10   2017/01/06 By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
         apcasite       LIKE apca_t.apcasite,
         apcald         LIKE apca_t.apcald,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       apcasite LIKE type_t.chr10, 
   apcasite_desc LIKE type_t.chr80, 
   apcald LIKE type_t.chr5, 
   apcald_desc LIKE type_t.chr80, 
   apcadocno LIKE type_t.chr20, 
   apcadocdt LIKE type_t.dat, 
   apca003 LIKE type_t.chr20, 
   apca004 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_apcacomp    LIKE ooef_t.ooef001
DEFINE g_wc_apcasite STRING
DEFINE g_wc_apcald   STRING
DEFINE g_sql_ctrl    STRING   #161014-00053#6 20161021 add by beckxie
DEFINE g_comp        LIKE glaa_t.glaacomp  #161115-00042#1 add
DEFINE g_wc_cs_comp  STRING  #161229-00047#10 add
DEFINE g_comp_str    STRING  #161229-00047#10 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp300.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aap_create_multi_bill_perod_tmp()  #160908-00006#1
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_fin_create_account_center_tmp()
      #end add-point
      CALL aapp300_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp300 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp300_init()
 
      #進入選單 Menu (="N")
      CALL aapp300_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp300
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp300.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp300_init()
 
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
   CALL s_fin_create_account_center_tmp()
   #161014-00053#6 20161021 add by beckxie---S
   LET g_sql_ctrl = NULL
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 mark
   #161115-00042#1 --s add
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#10 mark
   #161115-00042#1 --e add
   #161014-00053#6 20161021 add by beckxie---E
   #161229-00047#10 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#10 --e add     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp300_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp_wc    STRING #161115-00042#1 add +ld
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp300_qbeclear() 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
 
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            IF NOT cl_null(g_master.apcasite) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apcasite = ''
                  LET g_master.apcasite_desc = ''
                  LET g_master.apcald = ''
                  LET g_master.apcald_desc = ''
                  LET g_wc_apcasite = ''
                  LET g_wc_apcald   = ''
                  DISPLAY BY NAME g_master.apcasite,g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
                  NEXT FIELD CURRENT
               END IF
               
               #帳務中心預設主帳套及主帳套所屬法人及其他預設值         
               CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,g_apcacomp,g_master.apcald
               CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str #161229-00047#10 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#10 add 
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#10 mark 
               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               
               LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
               LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
               DISPLAY BY NAME g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
            ELSE                        
               LET g_master.apcasite_desc = ''
               LET g_master.apcald = ''
               LET g_master.apcald_desc = ''
               LET g_wc_apcasite = ''
               LET g_wc_apcald   = ''
               DISPLAY BY NAME g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
            END IF
            #161115-00042#1 --s add +ld
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            #161115-00042#1 --e add +ld
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
            LET g_master.apcald_desc = ''
            IF NOT cl_null(g_master.apcald) THEN
              #CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N',g_wc_apcald,g_today) #161115-00042#1 mark +ld
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','Y',g_wc_apcald,g_today) #161115-00042#1 add  +ld
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apcald = ''
                  LET g_master.apcald_desc = ''
                  DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite
            #CALL q_ooef001()     #161006-00005#18   mark
            CALL q_ooef001_46()   #161006-00005#18   add
            LET g_master.apcasite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.apcasite_desc
            NEXT FIELD apcasite
            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00042#1  add +ld
            CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00042#1  add +ld
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald
           #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald     #161115-00042#1 mark +ld
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161115-00042#1 add  +ld
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            LET g_master.apcald = g_qryparam.return1
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            NEXT FIELD apcald
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apcadocno,apcadocdt,apca003,apca004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="construct.c.apcadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcastus = 'N' ",  #albireo 150119
                                   " AND apcald = '",g_master.apcald,"' ",
                                   " AND apcasite IN ",g_wc_apcasite," ",
                                   " AND apca017 <> '1' " 
            #161115-00042#1 --s add
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaa001 = apca004 ) "
            END IF
            #161115-00042#1 --e add
            CALL q_apcadocno_11()                    
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
 
 
         #Ctrlp:construct.c.apca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca003
            #add-point:ON ACTION controlp INFIELD apca003 name="construct.c.apca003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apca003  #顯示到畫面上
            NEXT FIELD apca003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca003
            #add-point:BEFORE FIELD apca003 name="construct.b.apca003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca003
            
            #add-point:AFTER FIELD apca003 name="construct.a.apca003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca004
            #add-point:ON ACTION controlp INFIELD apca004 name="construct.c.apca004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161014-00053#6 20161021 add by beckxie---S
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161014-00053#6 20161021 add by beckxie---E
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apca004      #顯示到畫面上
            NEXT FIELD apca004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca004
            #add-point:BEFORE FIELD apca004 name="construct.b.apca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca004
            
            #add-point:AFTER FIELD apca004 name="construct.a.apca004"
            
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
            CALL aapp300_get_buffer(l_dialog)
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
            CALL aapp300_qbeclear()
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
         CALL aapp300_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.apcasite  = g_master.apcasite    
      LET lc_param.apcald    = g_master.apcald
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
                 CALL aapp300_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp300_transfer_argv(ls_js)
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
 
{<section id="aapp300.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp300_transfer_argv(ls_js)
 
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
 
{<section id="aapp300.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp300_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql       STRING
   DEFINE l_wc        STRING
   DEFINE l_apca      RECORD
                      apcald       LIKE apca_t.apcald,
                      apcadocno    LIKE apca_t.apcadocno,
                      apca001      LIKE apca_t.apca001,
                      apcastus     LIKE apca_t.apcastus,
                      apcadocdt    LIKE apca_t.apcadocdt,
                      apcacomp     LIKE apca_t.apcacomp,
                      apcasite     LIKE apca_t.apcasite                      
                      END RECORD
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_gzcb005   LIKE gzcb_t.gzcb005      #apca001 推所用作業
   DEFINE l_diff      LIKE type_t.num20_6      #差異金額
   DEFINE l_success   LIKE type_t.chr1         
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc        = lc_param.wc
      LET g_master.apcasite  = lc_param.apcasite
      LET g_master.apcald    = lc_param.apcald
      CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
      CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   END IF
   #INPUT欄位的是否輸入及檢核
   IF NOT cl_null(g_master.apcald) AND NOT cl_null(g_master.apcasite)THEN
      CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N',g_wc_apcald,g_today)
         RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   ELSE
      #必要輸入其一欄位沒輸入
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'acr-00015'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF 
   
   IF g_master.wc = " 1=1" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00066'
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
#  DECLARE aapp300_process_cs CURSOR FROM ls_sql
#  FOREACH aapp300_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_wc  =  g_master.wc
   IF cl_null(l_wc) THEN LET l_wc = ' 1=1' END IF

   #狀態碼檢核交給_chk 去做 albireo 150115

   #依開窗及INPUT條件組主SQL
   LET l_sql = " SELECT apcald,apcadocno,apca001,apcastus,apcadocdt,apcacomp,apcasite FROM apca_t ",
               "  WHERE apcaent = ",g_enterprise," ",
               "    AND apcald  = '",g_master.apcald,"' ",
               "    AND apcasite IN ",g_wc_apcasite," ",
               "    AND apca017 <> '1' ",
               "    AND apcastus = 'N' ",   #160509-00004#116 add lujh
               #161115-00042#1 --s add
               "    AND EXISTS (SELECT 1 FROM pmaa_t ",
               "                WHERE pmaaent = ",g_enterprise,
               "                AND ",g_sql_ctrl,
               "                AND pmaaent = apcaent ",
               "                AND pmaa001 = apca004 ) ",
               #161115-00042#1 --e add
               "    AND ",l_wc CLIPPED
   PREPARE s_aapp300_apcap1 FROM l_sql
   DECLARE s_aapp300_apcac1 CURSOR WITH HOLD FOR s_aapp300_apcap1

   LET l_sql = "SELECT COUNT(*) FROM (",l_sql CLIPPED,")"
   PREPARE s_aapp300_countp1 FROM l_sql
   
   #檢核是否有符合條件的資料
   LET l_count = NULL
   EXECUTE s_aapp300_countp1 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF 
   IF l_count = 0 THEN
      #無符合條件資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   #####################################################################################
   #作法:
   #依帳款性質apca001 串SCC8502的gzcb005 得出作業
   #依各作業去跑不同的確認段

   #各確認prepare declare段
   #FOREACH
      #1.用apca001推出作業l_gzcb005
      #2.LET l_success = 'Y'   #用l_success標記此筆成功否 
      #3. CASE 作業別(l_gzcb005) 先跑_chk
      #   若_chk有任一失敗把l_success = 'N'
      #   且continue foreach
      #4. 開transaction
      #5. CASE 作業別(l_gzcb005) 跑_upd 及其他產生單據或回寫的部分
      #   照順序有任一失敗就l_success = 'N'
      #   且EXIT CASE
      #6. 判斷本筆成功否   commitwork或rollback work
   #END FOREACH

   #
   #原因:
   #EX. aapt300  aapt320確認時 差在一個要作發票金額差異處理一個不用 因此應該BY程式去拆分

   #要注意SCC8502的應用欄位三設定 以免抓不出作業別  
   #####################################################################################


   #各確認段prepare
   CALL s_aapt300_prepare_declare()
   CALL s_aapt330_prepare_declare()
   CALL s_aapt331_prepare_declare()

   CALL cl_err_collect_init()
   FOREACH s_aapp300_apcac1 INTO l_apca.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.extend = 'FOREACH:s_aapp300_apcac1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 

      #根據l_apca的資料重新展組織樹,s_aapt300_chk中檢核apcb組織時會使用
      CALL s_fin_account_center_sons_query('3',l_apca.apcasite,l_apca.apcadocdt,'1')

      #先從apca001推出所用作業     
      LET l_gzcb005 = s_fin_get_scc_value('8502',l_apca.apca001,'3')      
      LET g_prog = l_gzcb005    #避免確認段使用g_prog時無法正確判斷是哪隻程式的狀況
      
      LET l_success = 'Y'     #預設正確

      #依作業跑確認段的檢核
      CASE
         WHEN l_gzcb005 = 'aapt300' OR l_gzcb005 = 'aapt301'
            #金額檢核
            CALL s_aap_bill_receipt_chk(l_apca.apcacomp,l_apca.apcald,l_apca.apcadocno,l_apca.apca001) RETURNING l_diff,g_errno
            IF l_diff > 0 THEN
               #有差異金額 不可進行確認
               LET l_success = 'N'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno 
               LET g_errparam.extend = l_apca.apcadocno 
               LET g_errparam.popup = TRUE
               CALL cl_err() 
            END IF
            			
	         CALL s_aapt300_conf_chk(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
            
         #160509-00004#116--add--str--lujh         
         WHEN l_gzcb005 = 'aapt210' 
            #金額檢核
            CALL s_aap_bill_receipt_chk(l_apca.apcacomp,l_apca.apcald,l_apca.apcadocno,l_apca.apca001) RETURNING l_diff,g_errno
            IF l_diff > 0 THEN
               #有差異金額 不可進行確認
               LET l_success = 'N'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno 
               LET g_errparam.extend = l_apca.apcadocno 
               LET g_errparam.popup = TRUE
               CALL cl_err() 
            END IF
            
            CALL s_aapt300_conf_chk(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
         #160509-00004#116--add--str--lujh 
						
         WHEN l_gzcb005 = 'aapt310' 
            #金額檢核
            CALL s_aap_bill_receipt_chk(l_apca.apcacomp,l_apca.apcald,l_apca.apcadocno,l_apca.apca001) RETURNING l_diff,g_errno
            IF l_diff > 0 THEN
               #有差異金額 不可進行確認
               LET l_success = 'N'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno 
               LET g_errparam.extend = l_apca.apcadocno 
               LET g_errparam.popup = TRUE
               CALL cl_err() 
            END IF
            
            CALL s_aapt300_conf_chk(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
            
         WHEN l_gzcb005 = 'aapt320'
            CALL s_aapt300_conf_chk(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
 
         WHEN l_gzcb005 = 'aapt330'
            CALL s_aapt330_conf_chk(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
         WHEN l_gzcb005 = 'aapt331'
            CALL s_aapt331_conf_chk(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
         WHEN l_gzcb005 = 'aapt340' OR l_gzcb005 = 'aapt341'

            #金額檢核
            CALL s_aap_bill_receipt_chk(l_apca.apcacomp,l_apca.apcald,l_apca.apcadocno,l_apca.apca001) RETURNING l_diff,g_errno
            IF l_diff > 0 THEN
               #有差異金額 不可進行確認
               LET l_success = 'N'
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno 
               LET g_errparam.extend = l_apca.apcadocno 
               LET g_errparam.popup = TRUE
               CALL cl_err() 
            END IF
							
	         CALL s_aapt300_conf_chk(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
            END IF
         OTHERWISE
            #帳套+單號XXX不符合批次所執行範圍
            #SA:不存在此單的對應作業請查詢SCC8502之說明
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno 
            LET g_errparam.extend = l_apca.apcadocno 
            LET g_errparam.popup = TRUE
            CALL cl_err() 
            LET l_success = 'N'
      END CASE

      IF l_success = 'N' THEN
         #有檢核出錯誤 給錯誤訊息失敗
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00315'
         LET g_errparam.replace[1] = l_apca.apcald
         LET g_errparam.replace[2] = l_apca.apcadocno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF


      #開transaction
      CALL s_transaction_begin()
      #確認段upd段
      CASE
         WHEN l_gzcb005 = 'aapt300' OR l_gzcb005 = 'aapt301'
	      CALL s_aapt300_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF 
            
         #160509-00004#116--add--str--lujh   
         WHEN l_gzcb005 = 'aapt210' 
	         CALL s_aapt300_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF  
         #160509-00004#116--add--end--lujh     
            
         WHEN l_gzcb005 = 'aapt310' 
            #141030-00016#6 modify-----s
#            #基本確認
#            CALL s_aapt300_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
#            IF NOT g_sub_success THEN
#               LET l_success = 'N'
#               EXIT CASE
#            END IF 
#            #產生待抵
#            CALL s_aapt310_create_contra_doc(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
#            IF NOT g_sub_success THEN
#               LET l_success = 'N'
#               EXIT CASE
#            END IF
#            #回寫來源
#            CALL s_aapt310_apcb_upd_source(l_apca.apcald,l_apca.apcadocno,'+')
#               RETURNING g_sub_success,g_errno
           #元件已整合在s_aapt310_conf_upd中
            CALL s_aapt310_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
           
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF
            #141030-00016#6 modify-----e            

         WHEN l_gzcb005 = 'aapt320'
            CALL s_aapt300_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF 

         WHEN l_gzcb005 = 'aapt330'
            CALL s_aapt330_conf_upd(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF 
         WHEN l_gzcb005 = 'aapt331'
            CALL s_aapt331_conf_upd(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF 
         WHEN l_gzcb005 = 'aapt340' OR l_gzcb005 = 'aapt341'
            CALL s_aapt300_conf_upd(l_apca.apcald,l_apca.apcadocno)RETURNING g_sub_success   #Belle Modify
           #CALL s_aapt331_conf_upd(l_apca.apcald,l_apca.apcadocno) RETURNING g_sub_success  #Belle Mark 150211
            IF NOT g_sub_success THEN
               LET l_success = 'N'
               EXIT CASE
            END IF 
         OTHERWISE
            #帳套+單號XXX不符合批次所執行範圍
      END CASE
      #其他處理
      #判斷成功否
      #提示作業+帳別+單號成功否
      IF l_success = 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00314'
         LET g_errparam.replace[1] = l_apca.apcald
         LET g_errparam.replace[2] = l_apca.apcadocno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('Y','0')
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00315'
         LET g_errparam.replace[1] = l_apca.apcald
         LET g_errparam.replace[2] = l_apca.apcadocno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
   END FOREACH 
   
   LET g_prog = 'aapp300'
   CALL cl_err_collect_show()
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
   CALL aapp300_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp300.get_buffer" >}
PRIVATE FUNCTION aapp300_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp300.msgcentre_notify" >}
PRIVATE FUNCTION aapp300_msgcentre_notify()
 
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
 
{<section id="aapp300.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 回到預設值併清空qbe條件
# Memo...........:
# Date & Author..: 150107 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp300_qbeclear()
   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apcasite,g_master.apcald,g_apcacomp
   CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str #161229-00047#10 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#10 add  
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add  #161229-00047#10 mark
   CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald

   LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
   LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)

   DISPLAY BY NAME g_master.apcald  ,g_master.apcald_desc,
                   g_master.apcasite,g_master.apcasite_desc
END FUNCTION

#end add-point
 
{</section>}
 
