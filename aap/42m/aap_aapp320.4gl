#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2016-10-19 16:56:51), PR版次:0012(2017-01-11 18:06:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000077
#+ Filename...: aapp320
#+ Description: 入庫發票批次產生應付帳款作業
#+ Creator....: 03080(2015-07-06 11:24:16)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp320.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150730-00006#1  2015/07/30 By albireo  帳務中心,帳套加入直接開程式時的預設值
#150812-00010#2  2015/08/20 By apo      修正變數名稱
#150917          2015/09/17 By Alberti  不須考慮暫估的部分,此處只能立應付帳款
#150921-00148#3  2015/09/24 By albireo  呼叫aapp132參數變更,因應應付款日票到期日來源調整
#151012-00014#2  2015/10/14 By Jessy    帶入日/月平均匯率預設值，依aoos020(S-FIN-3009)設定
#151015          2015/10/15 By albireo  資料範圍補上正項入庫 才可拋轉 否則篩除
#151022-00017#2  2015/10/23 By Jessy    轉發票之匯率依畫面條件取得
#151022-00017#3  2015/10/23 By aapp320  匯率基準放 "依原單匯率" 然後隱藏那欄
#151231-00010#6  2016/01/25 By sakura   增加控制組
#160530-00005#3  2016/05/30 By 03538    採購性質串 scc 2061 應用分類一, 若為Y 之性質才可立帳
#160812-00027#3  2016/08/15 By 06821    全面盤點應付程式帳套權限控管
#160705-00035#4  2016/09/20 By Reanna   1.依據彙總條件拆單產生 2.版面調整 3.QBE增加條件
#160929-00030#1  2016/10/19 By Reanna   延續#160705-00035#4作彙總部份
#161006-00005#30 2016/10/28 By 08732    組織類型與職能開窗調整
#161108-00017#1  2016/11/08 By Reanna   程式中INSERT INTO 有星號作整批調整
#161115-00042#2  2016/11/30 By 08732    開窗範圍處理(1帳款對象控制組)+process加控制組條件
#161229-00047#12 2017/01/09 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161229-00047#76 2017/01/11 By Reanna   修正 #161229-00047#12 bug
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
       l_apcasite      LIKE type_t.chr10,
       l_apcald        LIKE type_t.chr5,
       l_comp          LIKE type_t.chr10,
       l_process_type  LIKE type_t.chr100,
       l_currbase_type LIKE type_t.chr100,
       l_apbbdocdt     LIKE type_t.dat,
       l_slip1         LIKE type_t.chr10,
       l_slip2         LIKE type_t.chr20,
       l_apca063       LIKE type_t.chr500,
       l_pmdsdocno     LIKE type_t.chr20,
       l_apca007       LIKE type_t.chr20,   #albireo 150825 add
       #160705-00035#4-s
       l_group_type    LIKE type_t.chr500,
       l_chk1          LIKE type_t.chr500,
       l_chk2          LIKE type_t.chr500,
       #160705-00035#4-e
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_apcasite LIKE type_t.chr10, 
   l_apcasite_desc LIKE type_t.chr80, 
   l_group_type LIKE type_t.chr500, 
   l_comp LIKE type_t.chr10, 
   l_apcald LIKE type_t.chr5, 
   l_apcald_desc LIKE type_t.chr80, 
   l_chk1 LIKE type_t.chr500, 
   l_chk2 LIKE type_t.chr500, 
   l_process_type LIKE type_t.chr100, 
   l_apbbdocdt LIKE type_t.dat, 
   l_slip1 LIKE type_t.chr10, 
   l_slip1_desc LIKE type_t.chr80, 
   l_currbase_type LIKE type_t.chr100, 
   l_slip2 LIKE type_t.chr20, 
   l_slip2_desc LIKE type_t.chr80, 
   l_apca007 LIKE type_t.chr10, 
   l_apca007_desc LIKE type_t.chr80, 
   l_apca063 LIKE type_t.chr500, 
   pmdssite LIKE type_t.chr10, 
   pmdsdocno LIKE type_t.chr20, 
   pmds008 LIKE type_t.chr10, 
   pmdsdocdt LIKE type_t.dat, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o type_master
DEFINE g_pmds         RECORD
          pmds000        LIKE pmds_t.pmds000,
          pmds001        LIKE pmds_t.pmds001,
          pmds038        LIKE pmds_t.pmds038,
          pmdssite       LIKE pmds_t.pmdssite,
          pmds007        LIKE pmds_t.pmds007   #albireo 150825 add
                      END RECORD
DEFINE g_apca_prog    LIKE type_t.chr20
DEFINE g_wc_apcasite  STRING   #帳務組織條件
DEFINE g_wc_apcald    STRING
DEFINE g_sql_ctrl     STRING   #151231-00010#6
DEFINE g_wc2          STRING   #160705-00035#4
DEFINE g_wc_site      STRING   #161006-00005#30   add  #azzi800權限
DEFINE g_comp_str     STRING   #161229-00047#12
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp320.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_count   LIKE type_t.num10
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
#   LET ls_js = g_argv[01]
#   IF NOT cl_null(ls_js)THEN
#      #檢核pmdw必須存在且發票金額跟入庫含稅金額相等
#      CALL util.JSON.parse(ls_js,lc_param)
#      LET l_count = NULL
#      SELECT COUNT(*) INTO l_count FROM(
#         SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t
#          WHERE pmdtent = g_enterprise
#            AND pmdtent = pmdwent 
#            AND pmdtdocno = pmdwdocno
#            AND pmdtdocno = lc_param.l_pmdsdocno
#            GROUP BY pmdtdocno,pmdw025)
#       WHERE pmdt039 = pmdw025
#     IF cl_null(l_count)THEN LET l_count = 0 END IF
#     IF l_count = 0 THEN
#        INITIALIZE g_errparam.* TO NULL
#        LET g_errparam.code = 'aap-00378'
#        LET g_errparam.extend = 'pmdsdocno_chk'
#        LET g_errparam.popup = FALSE
#        CALL cl_err()
#        CALL cl_ap_exitprogram("0")
#        RETURN
#     END IF
#   END IF
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aap_create_multi_bill_perod_tmp()                 #新增多帳期FUNCTION用的TEMP TABLE
      CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
      CALL s_aapp330_cre_tmp()       RETURNING g_sub_success
      CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
      CALL s_aapp131_cre_tmp()
      #161229-00047#76 add ------
      SELECT ooef017 INTO g_master.l_comp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
         AND ooefstus = 'Y'
      CALL s_fin_get_wc_str(g_master.l_comp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#76 add end---
      #end add-point
      CALL aapp320_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp320 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp320_init()
 
      #進入選單 Menu (="N")
      CALL aapp320_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp320.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp320_init()
 
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
   CALL s_aap_create_multi_bill_perod_tmp()                 #新增多帳期FUNCTION用的TEMP TABLE
   CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
   CALL s_aapp330_cre_tmp()       RETURNING g_sub_success
   CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
   CALL s_aapp131_cre_tmp()
   CALL cl_set_combo_scc_part('l_process_type','8522',"2,5")
   CALL cl_set_combo_scc("l_currbase_type","9951")
   #151231-00010#6(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161115-00042#2   mark
   #151231-00010#6(E)
   #161229-00047#12 mark ------
   ##161115-00042#2   add---s
   #SELECT ooef017 INTO g_master.l_comp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_master.l_comp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#2   add---e
   #161229-00047#12 mark end---
   
   CALL cl_set_combo_scc_part('l_group_type','8527','1,2,3,4,5,6')  #160705-00035#4
   
   #161229-00047#12 mark ------
   ##161006-00005#30   add---s
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_site
   #CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
   ##161006-00005#30   add---e
   #161229-00047#12 mark end---
   
   CALL aapp320_qbeclear() #161229-00047#76
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp320_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa024        LIKE glaa_t.glaa024
   DEFINE l_gzcb004        LIKE gzcb_t.gzcb004
   DEFINE l_pmds000_str2   STRING   #入庫單性質(入)
   DEFINE l_pmds000_str3   STRING   #入庫單性質(退)
   DEFINE l_pmds011_str1   STRING   #160530-00005#3
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
             oofg019          LIKE oofg_t.oofg019,   #field
             oofg020          LIKE oofg_t.oofg020    #value
                           END RECORD
   DEFINE l_count          LIKE type_t.num10
   DEFINE l_tran           RECORD
             wc               STRING
                           END RECORD
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #CALL aapp320_qbeclear() #161229-00047#76 mark
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      #抓取可用的入庫單性質
      LET l_pmds000_str2 =  s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = 1 ")
      LET l_pmds000_str2 = s_fin_get_wc_str(l_pmds000_str2)
      LET l_pmds000_str3 =  s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = -1 ")
      LET l_pmds000_str3 = s_fin_get_wc_str(l_pmds000_str3)      
      #160530-00005#3--s
      LET l_pmds011_str1 =  s_aap_get_acc_str('2061',"gzcb003 = 'Y' ")
      LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)            
      #160530-00005#3--e
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_apcasite,g_master.l_group_type,g_master.l_comp,g_master.l_apcald,g_master.l_chk1, 
             g_master.l_chk2,g_master.l_process_type,g_master.l_apbbdocdt,g_master.l_slip1,g_master.l_currbase_type, 
             g_master.l_slip2,g_master.l_apca007,g_master.l_apca063 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcasite
            
            #add-point:AFTER FIELD l_apcasite name="input.a.l_apcasite"
            IF NOT cl_null(g_master.l_apcasite)THEN
               IF (g_master.l_apcasite <> g_master_o.l_apcasite) OR cl_null(g_master_o.l_apcasite)THEN
                  CALL s_fin_account_center_sons_query('3',g_master.l_apcasite,g_today,'1')
                  CALL s_fin_account_center_with_ld_chk(g_master.l_apcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_apcasite = g_master_o.l_apcasite
                     CALL s_desc_get_department_desc(g_master.l_apcasite) RETURNING g_master.l_apcasite_desc
                     DISPLAY BY NAME g_master.l_apcasite,g_master.l_apcasite_desc
                     NEXT FIELD l_apcasite
                  END IF
                  CALL s_fin_orga_get_comp_ld(g_master.l_apcasite) RETURNING g_sub_success,g_errno,g_master.l_comp,g_master.l_apcald
                  CALL s_desc_get_ld_desc(g_master.l_apcald)RETURNING g_master.l_apcald_desc
                  DISPLAY BY NAME g_master.l_comp,g_master.l_apcald,
                                  g_master.l_apcald_desc
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
                  CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
                  CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               END IF
            END IF
            LET g_master_o.l_apcasite = g_master.l_apcasite
            CALL s_desc_get_department_desc(g_master.l_apcasite) RETURNING g_master.l_apcasite_desc
            DISPLAY BY NAME g_master.l_apcasite_desc
            
            #161115-00042#2   add---s
            SELECT ooef017 INTO g_master.l_comp
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_input.apcasite
               AND ooefstus = 'Y'
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_master.l_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#12 mark
            #161115-00042#2 add---e
            
            #161229-00047#12 add ------
            CALL s_fin_get_wc_str(g_master.l_comp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#12 add end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcasite
            #add-point:BEFORE FIELD l_apcasite name="input.b.l_apcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcasite
            #add-point:ON CHANGE l_apcasite name="input.g.l_apcasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_group_type
            #add-point:BEFORE FIELD l_group_type name="input.b.l_group_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_group_type
            
            #add-point:AFTER FIELD l_group_type name="input.a.l_group_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_group_type
            #add-point:ON CHANGE l_group_type name="input.g.l_group_type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_comp
            #add-point:BEFORE FIELD l_comp name="input.b.l_comp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_comp
            
            #add-point:AFTER FIELD l_comp name="input.a.l_comp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_comp
            #add-point:ON CHANGE l_comp name="input.g.l_comp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apcald
            
            #add-point:AFTER FIELD l_apcald name="input.a.l_apcald"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apcald
            #add-point:BEFORE FIELD l_apcald name="input.b.l_apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apcald
            #add-point:ON CHANGE l_apcald name="input.g.l_apcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk1
            #add-point:BEFORE FIELD l_chk1 name="input.b.l_chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk1
            
            #add-point:AFTER FIELD l_chk1 name="input.a.l_chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk1
            #add-point:ON CHANGE l_chk1 name="input.g.l_chk1"
            
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
            #160705-00035#4 -s
            CALL cl_set_comp_visible('group_toaap',TRUE)
            IF g_master.l_chk2 = 'N' THEN
               CALL cl_set_comp_visible('group_toaap',FALSE)
            END IF
            #160705-00035#4 -e
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_process_type
            #add-point:BEFORE FIELD l_process_type name="input.b.l_process_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_process_type
            
            #add-point:AFTER FIELD l_process_type name="input.a.l_process_type"
            IF NOT cl_null(g_master.l_process_type)THEN
               IF (g_master.l_process_type <> g_master_o.l_process_type) OR cl_null(g_master_o.l_process_type)THEN
                  CASE
                     WHEN g_master.l_process_type = '2'
                        LET g_apca_prog = 'aapt300'
                     WHEN g_master.l_process_type = '5'
                        LET g_apca_prog = 'aapt340'
                  END CASE
                  #改變執行批次就應該要重新輸入單別
                  LET g_master.l_slip2 = ''
                  LET g_master.l_slip2_desc = ''
                  DISPLAY BY NAME g_master.l_slip2_desc,g_master.l_slip2
               END IF
            END IF
            LET g_master_o.l_process_type = g_master.l_process_type
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_process_type
            #add-point:ON CHANGE l_process_type name="input.g.l_process_type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apbbdocdt
            #add-point:BEFORE FIELD l_apbbdocdt name="input.b.l_apbbdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apbbdocdt
            
            #add-point:AFTER FIELD l_apbbdocdt name="input.a.l_apbbdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apbbdocdt
            #add-point:ON CHANGE l_apbbdocdt name="input.g.l_apbbdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip1
            
            #add-point:AFTER FIELD l_slip1 name="input.a.l_slip1"
            IF NOT cl_null(g_master.l_slip1)THEN
               IF (g_master.l_slip1 <> g_master_o.l_slip1) OR (g_master_o.l_slip1 IS NULL) THEN
                  CALL s_aooi200_fin_chk_slip(g_master.l_apcald,'',g_master.l_slip1,'aapt110')
                     RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_master.l_slip1 = g_master_o.l_slip1
                     NEXT FIELD l_slip1
                  END IF
               END IF
            END IF
            LET g_master_o.l_slip1 = g_master.l_slip1
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.l_slip1_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip1
            #add-point:BEFORE FIELD l_slip1 name="input.b.l_slip1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip1
            #add-point:ON CHANGE l_slip1 name="input.g.l_slip1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_currbase_type
            #add-point:BEFORE FIELD l_currbase_type name="input.b.l_currbase_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_currbase_type
            
            #add-point:AFTER FIELD l_currbase_type name="input.a.l_currbase_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_currbase_type
            #add-point:ON CHANGE l_currbase_type name="input.g.l_currbase_type"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip2
            
            #add-point:AFTER FIELD l_slip2 name="input.a.l_slip2"
            IF NOT cl_null(g_master.l_slip2)THEN
               IF (g_master.l_slip2 <> g_master_o.l_slip2) OR (g_master_o.l_slip2 IS NULL) THEN
                  #由入或退判斷哪一隻程式
                  CALL s_aooi200_fin_chk_slip(g_master.l_apcald,'',g_master.l_slip2,g_apca_prog)
                     RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_master.l_slip2 = g_master_o.l_slip2
                     NEXT FIELD l_slip2
                  END IF
               END IF
            END IF
            LET g_master_o.l_slip2 = g_master.l_slip2
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc
            DISPLAY BY NAME g_master.l_slip2_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip2
            #add-point:BEFORE FIELD l_slip2 name="input.b.l_slip2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip2
            #add-point:ON CHANGE l_slip2 name="input.g.l_slip2"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apca007
            
            #add-point:AFTER FIELD l_apca007 name="input.a.l_apca007"
            #150825-00004#4-----s
            LET g_master.l_apca007_desc = ''
            DISPLAY BY NAME g_master.l_apca007_desc            
            IF NOT cl_null(g_master.l_apca007)THEN
               IF NOT s_azzi650_chk_exist('3211',g_master.l_apca007) THEN
                  LET g_master.l_apca007 = g_master_o.l_apca007
                  CALL s_desc_get_acc_desc('3211',g_master.l_apca007) RETURNING g_master.l_apca007_desc
                  
                  DISPLAY BY NAME g_master.l_apca007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master_o.l_apca007 = g_master.l_apca007
            CALL s_desc_get_acc_desc('3211',g_master.l_apca007) RETURNING g_master.l_apca007_desc
            DISPLAY BY NAME g_master.l_apca007_desc
            #150825-00004#4-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apca007
            #add-point:BEFORE FIELD l_apca007 name="input.b.l_apca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apca007
            #add-point:ON CHANGE l_apca007 name="input.g.l_apca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apca063
            #add-point:BEFORE FIELD l_apca063 name="input.b.l_apca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apca063
            
            #add-point:AFTER FIELD l_apca063 name="input.a.l_apca063"
            IF NOT cl_null(g_master.l_apca063)THEN
               IF NOT s_aooi390_chk('14',g_master.l_apca063) THEN
                  LET g_master.l_apca063 = g_master_o.l_apca063
                  DISPLAY BY NAME g_master.l_apca063
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master_o.l_apca063 = g_master.l_apca063
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apca063
            #add-point:ON CHANGE l_apca063 name="input.g.l_apca063"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcasite
            #add-point:ON ACTION controlp INFIELD l_apcasite name="input.c.l_apcasite"
            #帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_apcasite
            #LET g_qryparam.where = " ooef204 = 'Y' "      #160812-00027#3 mark
            #CALL q_ooef001()     #161006-00005#30   mark     
            CALL q_ooef001_46()   #161006-00005#30   add 
            LET g_master.l_apcasite = g_qryparam.return1
            DISPLAY BY NAME g_master.l_apcasite
            NEXT FIELD l_apcasite
            #END add-point
 
 
         #Ctrlp:input.c.l_group_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_group_type
            #add-point:ON ACTION controlp INFIELD l_group_type name="input.c.l_group_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_comp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_comp
            #add-point:ON ACTION controlp INFIELD l_comp name="input.c.l_comp"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_apcald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apcald
            #add-point:ON ACTION controlp INFIELD l_apcald name="input.c.l_apcald"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_process_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_process_type
            #add-point:ON ACTION controlp INFIELD l_process_type name="input.c.l_process_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_apbbdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apbbdocdt
            #add-point:ON ACTION controlp INFIELD l_apbbdocdt name="input.c.l_apbbdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip1
            #add-point:ON ACTION controlp INFIELD l_slip1 name="input.c.l_slip1"
            #對帳單單別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip1
            LET l_glaa024 = ''
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_master.l_apcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aapt110'
            CALL q_ooba002_1()
            LET g_master.l_slip1 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip1
            NEXT FIELD l_slip1
            #END add-point
 
 
         #Ctrlp:input.c.l_currbase_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_currbase_type
            #add-point:ON ACTION controlp INFIELD l_currbase_type name="input.c.l_currbase_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip2
            #add-point:ON ACTION controlp INFIELD l_slip2 name="input.c.l_slip2"
            #立帳單別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip2
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_master.l_apcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_apca_prog
            CALL q_ooba002_1()
            LET g_master.l_slip2 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip2
            NEXT FIELD l_slip2
            #END add-point
 
 
         #Ctrlp:input.c.l_apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apca007
            #add-point:ON ACTION controlp INFIELD l_apca007 name="input.c.l_apca007"
            #帳款類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_apca007
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()
            LET g_master.l_apca007 = g_qryparam.return1
            CALL s_desc_get_acc_desc('3211',g_master.l_apca007) RETURNING g_master.l_apca007_desc
            DISPLAY BY NAME g_master.l_apca007,g_master.l_apca007_desc
            NEXT FIELD l_apca007
            #END add-point
 
 
         #Ctrlp:input.c.l_apca063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apca063
            #add-point:ON ACTION controlp INFIELD l_apca063 name="input.c.l_apca063"
            #整帳批序號
            CALL s_aooi390_gen('14') RETURNING g_sub_success,g_master.l_apca063,l_oofg_return
            DISPLAY BY NAME g_master.l_apca063
            NEXT FIELD l_apca063
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmdssite,pmdsdocno,pmds008,pmdsdocdt
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdssite
            #add-point:BEFORE FIELD pmdssite name="construct.b.pmdssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdssite
            
            #add-point:AFTER FIELD pmdssite name="construct.a.pmdssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdssite
            #add-point:ON ACTION controlp INFIELD pmdssite name="construct.c.pmdssite"
            #160705-00035#4 -s
            #營運據點
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' AND ooef001 IN ",g_wc_site   #161006-00005#30   add
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO pmdssite
            NEXT FIELD pmdssite
            #160705-00035#4 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdsdocno
            #add-point:BEFORE FIELD pmdsdocno name="construct.b.pmdsdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdsdocno
            
            #add-point:AFTER FIELD pmdsdocno name="construct.a.pmdsdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdsdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdsdocno
            #add-point:ON ACTION controlp INFIELD pmdsdocno name="construct.c.pmdsdocno"
            #來源單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            LET g_qryparam.where = "pmdtent = ",g_enterprise," ",
                                   " AND pmdtsite IN ",g_wc_apcasite CLIPPED,
                                   " AND pmdsstus = 'S' ",
                                   " AND (pmdt024 - pmdt069) > 0 ",
                                   " AND pmds011 IN ",l_pmds011_str1 CLIPPED,   #160530-00005#3
                                   " AND pmdsdocno NOT IN (",
                                   "                      SELECT apba005 FROM apbb_t,apba_t ",
                                   "                       WHERE apbaent = ",g_enterprise," ",
                                   "                         AND apbaent = apbbent ",
                                   "                         AND apbadocno = apbbdocno ",
                                   "                         AND apbbstus <> 'X' AND apba005 IS NOT NULL ",
                                                         ") "
            CASE
               WHEN g_master.l_process_type = '2'
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND pmds000 IN ",l_pmds000_str2 CLIPPED   ,
                                         #151005 mark albireo-----s    #albireo 151015 remark
                                         " AND (pmdsdocno IN (",
                                         "                 SELECT pmdtdocno FROM (",
                                         "                    SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t ",
                                         "                     WHERE pmdtent = ",g_enterprise," ",
                                         "                       AND pmdtent = pmdwent ",
                                         "                       AND pmdtdocno = pmdwdocno ",
                                         "                       GROUP BY pmdtdocno,pmdw025) ",
                                         #"                  WHERE pmdt039 = pmdw025 ",   #albireo 151015 mark
                                         "                   )",
                                         "      OR pmds006 IN(",
                                         "                 SELECT pmdtdocno FROM (",
                                         "                    SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t ",
                                         "                     WHERE pmdtent = ",g_enterprise," ",
                                         "                       AND pmdtent = pmdwent ",
                                         "                       AND pmdtdocno = pmdwdocno ",
                                         "                       GROUP BY pmdtdocno,pmdw025) ",
                                         #"                  WHERE pmdt039 = pmdw025 ",     #albireo 151015 mark
                                         "                   )",
                                         "      )"
                                         #151005 mark albireo-----e   #albireo 151015 remark
               WHEN g_master.l_process_type = '5'
                  LET g_qryparam.where = g_qryparam.where CLIPPED,
                                         " AND pmds000 IN ",l_pmds000_str3 CLIPPED               
            END CASE
            #151231-00010#6(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaa001 = pmds008 )"
            END IF
            #151231-00010#6(E)      
            
            CALL q_pmdtdocno_4()
            DISPLAY g_qryparam.return1 TO pmdsdocno
            NEXT FIELD pmdsdocno
            #END add-point
 
 
         #Ctrlp:construct.c.pmds008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds008
            #add-point:ON ACTION controlp INFIELD pmds008 name="construct.c.pmds008"
            #160705-00035#4 -s
            #交易對象
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO pmds008
            NEXT FIELD pmds008
            #160705-00035#4 -e
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmds008
            #add-point:BEFORE FIELD pmds008 name="construct.b.pmds008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmds008
            
            #add-point:AFTER FIELD pmds008 name="construct.a.pmds008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdsdocdt
            #add-point:BEFORE FIELD pmdsdocdt name="construct.b.pmdsdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdsdocdt
            
            #add-point:AFTER FIELD pmdsdocdt name="construct.a.pmdsdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdsdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdsdocdt
            #add-point:ON ACTION controlp INFIELD pmdsdocdt name="construct.c.pmdsdocdt"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #160705-00035#4 -s
         CONSTRUCT BY NAME g_wc2 ON pmdl002,pmdl003
            #採購人員
            ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmdl002
               NEXT FIELD pmdl002
            
            #採購部門
            ON ACTION controlp INFIELD pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO pmdl003
               NEXT FIELD pmdl003
         END CONSTRUCT
         #160705-00035#4 -e
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
            CALL aapp320_get_buffer(l_dialog)
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
            CALL aapp320_qbeclear()
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
         CALL aapp320_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_comp      =  g_master.l_comp
      LET lc_param.l_slip1     =  g_master.l_slip1
      LET lc_param.l_apbbdocdt =  g_master.l_apbbdocdt
      LET lc_param.l_apcald    =  g_master.l_apcald
      LET lc_param.l_slip2     =  g_master.l_slip2
      LET lc_param.l_apca063   =  g_master.l_apca063
      LET lc_param.l_apcasite  =  g_master.l_apcasite
      LET lc_param.l_process_type = g_master.l_process_type
      LET lc_param.l_currbase_type = g_master.l_currbase_type
      LET lc_param.l_apca007 = g_master.l_apca007   #albireo 150825
      #151231-00010#6(S)
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET lc_param.wc = lc_param.wc," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                       "              WHERE pmaaent = ",g_enterprise,
                                       "                AND ",g_sql_ctrl,
                                       "                AND pmaa001 = pmds008 )"
      END IF
      #151231-00010#6(E)
      #160705-00035#4-s
      LET lc_param.l_group_type = g_master.l_group_type
      LET lc_param.l_chk1       = g_master.l_chk1
      LET lc_param.l_chk2       = g_master.l_chk2
      #160705-00035#4-e
      CALL util.JSON.parse(g_argv[1],l_tran)
      IF NOT cl_null(l_tran.wc)THEN
         LET lc_param.wc = lc_param.wc CLIPPED," AND ",l_tran.wc CLIPPED
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
                 CALL aapp320_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp320_transfer_argv(ls_js)
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
 
{<section id="aapp320.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp320_transfer_argv(ls_js)
 
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
 
{<section id="aapp320.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp320_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
DEFINE ls_js2          STRING   #pass用JSON字串
DEFINE l_strno1        LIKE apbb_t.apbbdocno
DEFINE l_endno1        LIKE apbb_t.apbbdocno
DEFINE l_strno2        LIKE apca_t.apcadocno
DEFINE l_endno2        LIKE apca_t.apcadocno
DEFINE l_strno         LIKE type_t.chr20
DEFINE l_endno         LIKE type_t.chr20
DEFINE l_success       LIKE type_t.num5
DEFINE l_do            LIKE type_t.chr1
DEFINE l_pmds000_str   STRING
DEFINE l_pmds000_str2  STRING
DEFINE l_pmds000_str3  STRING
DEFINE l_pmds011_str1  STRING   #160530-00005#3
DEFINE l_wc_apcasite   STRING
DEFINE l_pmdsdocno     LIKE pmds_t.pmdsdocno
DEFINE l_sql           STRING
DEFINE l_apbb010       LIKE apbb_t.apbb010
DEFINE l_tmp           RECORD
          pmdsent         LIKE pmds_t.pmdsent,
          pmdsdocdt       LIKE pmds_t.pmdsdocdt,  #單據日期
          pmds000         LIKE pmds_t.pmds000,    #單據性質(6:入庫/5:驗退/7:倉退)
          pmds007         LIKE pmds_t.pmds007,    #採購供應商(*)
          pmds008         LIKE pmds_t.pmds008,    #帳款供應商
          pmds031         LIKE pmds_t.pmds031,    #付款條件(*)
          pmds033         LIKE pmds_t.pmds033,    #稅別(*)
          pmds037         LIKE pmds_t.pmds037,    #幣別(*)
          pmds038         LIKE pmds_t.pmds038,    #匯率(*)
          pmdtsite        LIKE pmdt_t.pmdtsite,   #營運據點
          pmdtdocno       LIKE pmdt_t.pmdtdocno,  #收票單號(*)
          pmdtseq         LIKE pmdt_t.pmdtseq,    #收票項次
          pmdt001         LIKE pmdt_t.pmdt001,    #來源單號
          pmdt006         LIKE pmdt_t.pmdt006,    #料件編號
          pmdt019         LIKE pmdt_t.pmdt019,    #入庫單位
          pmdt024         LIKE pmdt_t.pmdt024,    #發票數量
          pmdldocno       LIKE pmdl_t.pmdldocno,  #採購單號
          pmdl002         LIKE pmdl_t.pmdl002,    #採購單-採購人員
          pmdl003         LIKE pmdl_t.pmdl003,    #採購單-採購部門
          apcb007         LIKE apcb_t.apcb007,    #可立帳數量
          apbb050         LIKE apbb_t.apbb050,    #發票性質(*)
          apca007         LIKE apca_t.apca007,    #帳款類型
          cond1           LIKE type_t.chr500,     #彙總條件
          apba005         LIKE apba_t.apba005,    #參考單號
          apba006         LIKE apba_t.apba006     #參考項次
                       END RECORD 
DEFINE l_pmdt024       LIKE pmdt_t.pmdt024
DEFINE l_glaa001       LIKE glaa_t.glaa001
DEFINE l_glaa025       LIKE glaa_t.glaa025
DEFINE l_field         DYNAMIC ARRAY OF RECORD
          cond1           LIKE type_t.chr100,
          f1              LIKE type_t.chr100
                       END RECORD
DEFINE lc_param_apca   RECORD
          type            LIKE type_t.chr1,       #類型(1:p131/2:p132/3:p133)
          sel1            LIKE type_t.chr1,       #立帳方式
          sel2            LIKE type_t.chr1,       #彙總方式
          slip            LIKE apca_t.apcadocno,  #單別
          site            LIKE apca_t.apcasite,   #帳務中心
          ld              LIKE apca_t.apcald,     #帳套
          wc2             STRING,                 #沖銷類型
          bgjob           LIKE type_t.chr1,       #是否背景執行
          apca063         LIKE apca_t.apca063     #整帳批序號
                       END RECORD
#151012-00014#2-----s
DEFINE lc_param_rate   RECORD
          type            LIKE type_t.chr1,       #類型
          apca004         LIKE apca_t.apca004,    #交易對象
          sfin2009        LIKE type_t.chr1        #匯率類型
                       END RECORD
DEFINE l_desc          LIKE type_t.chr500         #接沒有用到的參數用
#151012-00014#2-----e
DEFINE l_success_num1  LIKE type_t.num10
DEFINE l_success_num2  LIKE type_t.num10
DEFINE l_apca063       LIKE apca_t.apca063
#160929-00030#1 add ------
DEFINE l_tmp2          RECORD
          pmds008         LIKE pmds_t.pmds008,
          pmds031         LIKE pmds_t.pmds031,
          pmds033         LIKE pmds_t.pmds033,
          pmds037         LIKE pmds_t.pmds037,
          group           LIKE type_t.chr500,
          pmdssite        LIKE pmds_t.pmdssite,
          pmds038         LIKE pmds_t.pmds038
                       END RECORD
DEFINE l_ori_wc        STRING
DEFINE l_field1        STRING
DEFINE l_field2        STRING
DEFINE l_field3        STRING
DEFINE l_array         DYNAMIC ARRAY OF  RECORD
                          chr    LIKE type_t.chr1000,
                          dat    LIKE type_t.dat
                       END RECORD
#160929-00030#1 add end---
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapp320_process_cs CURSOR FROM ls_sql
#  FOREACH aapp320_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_pmds000_str2 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = 1 ")
   LET l_pmds000_str2 = s_fin_get_wc_str(l_pmds000_str2)
   LET l_pmds000_str3 = s_aap_get_acc_str('2060',"gzcb003 = 'Y' AND gzcb004 = -1 ")
   LET l_pmds000_str3 = s_fin_get_wc_str(l_pmds000_str3)
   #160530-00005#3--S
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y' ")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)
   #160530-00005#3--E
   CALL s_fin_account_center_sons_query('3',lc_param.l_apcasite,lc_param.l_apbbdocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING l_wc_apcasite
   CALL s_fin_get_wc_str(l_wc_apcasite) RETURNING l_wc_apcasite
   
   LET l_sql = "SELECT  apbaent ,apbb011,apba004,apbb002,     '',",                        #ent/發票日期/來源作業/交易對象/''
                "       apbb054 ,apbb012,apbb014,apbb015,",                                #付款條件/稅別/幣別/匯率
                "       apbaorga,apbbdocno,apbaseq,     '',     '',",                      #營運組織/收票單號/收票項次/''/''
                "       apba009 ,apba010,     '',apbb051,apbb052,",                        #入庫單位/發票數量/''/採購人員/採購部門
                "       ''      ,apbb050,     '',apbbdocno,",                              #''/發票性質/帳款類型/彙總條件
                "       apba005 ,apba006",                                                 #交易單號/交易項次
                "  FROM apba_t,apbb_t",
                " WHERE apbaent = apbbent AND apbadocno = apbbdocno AND apbbstus = 'Y'",
                "   AND apbaent = ",g_enterprise, " ",
                "   AND apbadocno = ? "
   PREPARE aapp320_apbap1 FROM l_sql
   DECLARE aapp320_apbac1 CURSOR FOR aapp320_apbap1
   
   LET l_field[1].f1 = "pmdt056"   LET l_field[2].f1 = "pmdt057"  LET l_field[3].f1 = "pmdt058"   #已請款數量              
  #LET ls_sql = " SELECT pmdt024 - ",l_field[1].f1,   #150812-00010#2 mark
   LET l_sql =  " SELECT pmdt024 - ",l_field[1].f1,   #150812-00010#2
                "   FROM pmdt_t",
                " WHERE pmdtent = ? AND pmdtdocno = ? AND pmdtseq =  ? "
   PREPARE aapp320_get_pmdt024_p FROM l_sql
   CASE
      WHEN lc_param.l_process_type = '2'
         LET l_pmds000_str = l_pmds000_str2
      WHEN lc_param.l_process_type = '5'
         LET l_pmds000_str = l_pmds000_str3
   END CASE
   
   #160929-00030#1 mark ------
   #LET l_sql =
   #      " SELECT DISTINCT pmdsdocno  ",
   #      "   FROM  (SELECT pmds000,pmdsdocno,pmds001,pmdt006,pmdt001,pmds011,pmdt039,pmds008,",
   #      "                 pmds037,pmds033,CASE WHEN pmdt024 IS NULL THEN 0 ELSE pmdt024 END AS pmdt024,",
   #      "                 CASE WHEN pmdt056 IS NULL THEN 0 ELSE pmdt056 END AS pmdt056,",
   #      "                 CASE WHEN pmdt057 IS NULL THEN 0 ELSE pmdt057 END AS pmdt057,",
   #      "                 CASE WHEN pmdt058 IS NULL THEN 0 ELSE pmdt058 END AS pmdt058,",
   #      "                 CASE WHEN pmdt066 IS NULL THEN 0 ELSE pmdt066 END AS pmdt066,",
   #      "                 CASE WHEN pmdt067 IS NULL THEN 0 ELSE pmdt067 END AS pmdt067,",
   #      "                 CASE WHEN pmdt068 IS NULL THEN 0 ELSE pmdt068 END AS pmdt068,",
   #      "                 pmdtsite,pmdsstus,pmdtent,pmdtseq,pmds100,pmdt084,pmds006, ",
   #      "                 pmdtdocno ",   #albireo 150804 add
   #      "            FROM pmds_t,pmdt_t   ",
   #      "           WHERE pmdsent = ",g_enterprise,"  AND pmdtent = pmdsent  AND pmdtdocno = pmdsdocno) ",
   #      #"  WHERE (( 1=1 AND pmdt024 > (pmdt056+pmdt066)) OR (2=1 AND pmdt024 > (pmdt057+pmdt067)) OR (3=1 AND pmdt024 > (pmdt058+pmdt068))) ",  #150917 mark
   #      "  WHERE (( 1=1 AND pmdt024 > (pmdt056)) OR (2=1 AND pmdt024 > (pmdt057)) OR (3=1 AND pmdt024 > (pmdt058))) ",                          #150917
   #      "    AND pmdtent = ",g_enterprise,"  AND pmdtsite IN ",l_wc_apcasite," AND pmdsstus = 'S'  ",
   #      #albireo mark 150812-----s
   #      #只有正項的時候才加上這個條件
   #      #"    AND (pmdsdocno IN (SELECT pmdtdocno FROM (SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t         ",
   #      #"                                              WHERE pmdtent =    ",g_enterprise,"           AND pmdtent = pmdwent ",
   #      #"                                                AND pmdtdocno = pmdwdocno           ",
   #      #"                                              GROUP BY pmdtdocno,pmdw025)      ",
   #      #"                       WHERE pmdt039 = pmdw025 ) ",
   #      #
   #      #"        OR pmds006 IN (SELECT pmdtdocno FROM (SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t         ",
   #      #"                                              WHERE pmdtent =    ",g_enterprise,"           AND pmdtent = pmdwent ",
   #      #"                                                AND pmdtdocno = pmdwdocno           ",
   #      #"                                              GROUP BY pmdtdocno,pmdw025)      ",
   #      #"                       WHERE pmdt039 = pmdw025 ) ",           
   #      #"         ) ",
   #      #albireo mark 150812-----e
   #      "    AND pmds000 IN ",l_pmds000_str CLIPPED,
   #      "    AND pmds011 IN ",l_pmds011_str1 CLIPPED,   #160530-00005#3
   #      "    AND ",lc_param.wc  CLIPPED
   ##albireo 150812-----s
   ##正項才加入發票金額控卡的邏輯
   #IF lc_param.l_process_type = '2' THEN
   #   LET l_sql = l_sql CLIPPED,
   #        "    AND (pmdsdocno IN (SELECT pmdtdocno FROM (SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t         ",
   #        "                                              WHERE pmdtent = ",g_enterprise," AND pmdtent = pmdwent ",
   #        "                                                AND pmdtdocno = pmdwdocno",
   #        "                                              GROUP BY pmdtdocno,pmdw025)",
   #        #"                       WHERE pmdt039 = pmdw025 ",   #albireo 151015 mark
   #        "                       ) ",
   #        
   #        "        OR pmds006 IN (SELECT pmdtdocno FROM (SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t         ",
   #        "                                              WHERE pmdtent = ",g_enterprise," AND pmdtent = pmdwent ",
   #        "                                                AND pmdtdocno = pmdwdocno",
   #        "                                              GROUP BY pmdtdocno,pmdw025)",
   #        #"                       WHERE pmdt039 = pmdw025 ",   #albireo 151015 mark
   #        "                       ) ",
   #        "         ) "
   #END IF
   ##albireo 150812-----e
   #160929-00030#1 mark end---
   
   #160929-00030#1 add ------
   #彙總group by條件組合處：
   #1.依照彙總條件
   CASE
      WHEN lc_param.l_group_type = '1'  #1:交易對象
         LET l_field1 = ",pmds008"
      WHEN lc_param.l_group_type = '2'  #2:入庫單號
         LET l_field1 = ",pmdsdocno"
      WHEN lc_param.l_group_type = '3'  #3:採購單號
         LET l_field1 = ",pmds006"
      WHEN lc_param.l_group_type = '4'  #4:採購人員
         LET l_field1 = ",pmdl002"
      WHEN lc_param.l_group_type = '5'  #5:採購部門
         LET l_field1 = ",pmdl003"
      WHEN lc_param.l_group_type = '6'  #6:產品編號
         LET l_field1 = ",pmdt006"
   END CASE
   #2.是否依來源營運據點拆單
   IF lc_param.l_chk1 = "Y" THEN
      LET l_field2 = ",pmdssite"
   ELSE
      LET l_field2 = ",''"
   END IF
   #3.匯率選擇是1:依原單匯率
   IF lc_param.l_currbase_type = '1' THEN
      LET l_field3 = ",pmds038"
   ELSE
      LET l_field3 = ",''"
   END IF
   
   CASE
      WHEN lc_param.l_group_type MATCHES '[1236]'
         LET l_sql =
         " SELECT pmds008,pmds031,pmds033,pmds037",
         l_field1,l_field2,l_field3,
         "   FROM pmds_t",
         "   LEFT JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno"
      WHEN lc_param.l_group_type MATCHES '[45]'
         LET l_sql =
         " SELECT pmds008,pmds031,pmds033,pmds037",
         l_field1,l_field2,l_field3,
         "   FROM pmdl_t",
         "   LEFT JOIN pmds_t ON pmdlent = pmdsent AND pmdldocno = pmds006",
         "   LEFT JOIN pmdt_t ON pmdsent = pmdtent AND pmdsdocno = pmdtdocno"
   END CASE
   
   LET l_sql = l_sql CLIPPED,
      " WHERE pmdsent = ",g_enterprise,
      "   AND (( 1=1 AND pmdt024 > pmdt056) OR (2=1 AND pmdt024 > pmdt057) OR (3=1 AND pmdt024 > pmdt058))",
      "   AND pmdtsite IN ",l_wc_apcasite," AND pmdsstus = 'S'",
      "   AND pmds000 IN ",l_pmds000_str CLIPPED,
      "   AND pmds011 IN ",l_pmds011_str1 CLIPPED,
      #161115-00042#2   add---s
      "    AND EXISTS (SELECT 1 FROM pmaa_t ",
      "                WHERE pmaaent = ",g_enterprise,
      "                AND ",g_sql_ctrl,
      "                AND pmaaent = pmdsent ",
      "                AND pmaa001 = pmds008 ) ",
      #161115-00042#2   add---e
      "   AND ",lc_param.wc  CLIPPED
   #正項才加入發票金額控卡的邏輯
   IF lc_param.l_process_type = '2' THEN
      LET l_sql = l_sql CLIPPED,
      " AND (pmdsdocno IN (SELECT pmdtdocno FROM (",
      "                       SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t",
      "                        WHERE pmdtent = ",g_enterprise," AND pmdtent = pmdwent ",
      "                          AND pmdtdocno = pmdwdocno",
      "                        GROUP BY pmdtdocno,pmdw025",
      "      ))",
      "      OR pmds006 IN (SELECT pmdtdocno FROM (",
      "                        SELECT pmdtdocno,SUM(pmdt039) pmdt039,pmdw025 FROM pmdw_t,pmdt_t",
      "                         WHERE pmdtent = ",g_enterprise," AND pmdtent = pmdwent ",
      "                           AND pmdtdocno = pmdwdocno",
      "                         GROUP BY pmdtdocno,pmdw025",
      "      ))",
      ")"
   END IF
   LET l_sql = l_sql CLIPPED," GROUP BY pmds008,pmds031,pmds033,pmds037",
                             l_field1,l_field2,l_field3
   #160929-00030#1 add end---
   PREPARE aapp320_pmdsp1 FROM l_sql
   DECLARE aapp320_pmdsc1 CURSOR WITH HOLD FOR aapp320_pmdsp1 
   
   CALL cl_err_collect_init()
   LET l_do = 'N'   #符合條件資料否
   LET l_success_num1 = 0  #第一階段成功筆數
   LET l_success_num2 = 0  #第二階段成功筆數
   #整帳批序號
   IF NOT cl_null(lc_param.l_apca063)THEN
      CALL s_transaction_begin()
      CALL s_aooi390_get_auto_no('14',lc_param.l_apca063) RETURNING g_sub_success,l_apca063
      CALL s_aooi390_oofi_upd('14',l_apca063) RETURNING g_sub_success
      CALL s_transaction_end('Y','0')
   END IF
   
   #FOREACH aapp320_pmdsc1 INTO l_pmdsdocno  #160929-00030#1 mark
   #160929-00030#1 add ------
   LET l_ori_wc = lc_param.wc
   FOREACH aapp320_pmdsc1 INTO l_tmp2.pmds008,l_tmp2.pmds031,l_tmp2.pmds033,l_tmp2.pmds037,
                               l_tmp2.group,l_tmp2.pmdssite,l_tmp2.pmds038
   #160929-00030#1 add end---
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:aapp320_pmdsc1'
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      CALL s_transaction_begin()
      LET l_success = TRUE
      
      #160929-00030#1 mark ------
      #LET lc_param.wc = " pmdsdocno = '",l_pmdsdocno,"' "
      #LET ls_js2 = util.JSON.stringify(lc_param)  
      #CALL s_aapp320_ins_apbb(ls_js2)RETURNING g_sub_success,l_strno,l_endno
      #160929-00030#1 mark end---
      #160929-00030#1 add ------
      LET lc_param.wc = l_ori_wc," AND pmds008 = '",l_tmp2.pmds008,"' AND pmds031 = '",l_tmp2.pmds031,"'",
                        "AND pmds033 = '",l_tmp2.pmds033,"' AND pmds037 = '",l_tmp2.pmds037,"'"
      CASE
         WHEN lc_param.l_group_type = '1'  #1:交易對象
            LET lc_param.wc = lc_param.wc," AND pmds008 = '",l_tmp2.group,"'"
         WHEN lc_param.l_group_type = '2'  #2:入庫單號
            LET lc_param.wc = lc_param.wc," AND pmdsdocno= '",l_tmp2.group,"'"
         WHEN lc_param.l_group_type = '3'  #3:採購單號
            IF NOT cl_null(l_tmp2.group) THEN
               LET lc_param.wc = lc_param.wc," AND pmds006= '",l_tmp2.group,"'"
            ELSE
               LET lc_param.wc = lc_param.wc," AND pmds006 IS NULL "
            END IF
         WHEN lc_param.l_group_type = '4'  #4:採購人員
            IF NOT cl_null(l_tmp2.group) THEN
               LET lc_param.wc = lc_param.wc," AND pmdl002= '",l_tmp2.group,"'"
            ELSE
               LET lc_param.wc = lc_param.wc," AND pmdl002 IS NULL "
            END IF
         WHEN lc_param.l_group_type = '5'  #5:採購部門
            IF NOT cl_null(l_tmp2.group) THEN
               LET lc_param.wc = lc_param.wc," AND pmdl003= '",l_tmp2.group,"'"
            ELSE
               LET lc_param.wc = lc_param.wc," AND pmdl003 IS NULL "
            END IF
         WHEN lc_param.l_group_type = '6'  #6:產品編號
            LET lc_param.wc = lc_param.wc," AND pmdt006= '",l_tmp2.group,"'"
      END CASE
      #2.是否依來源營運據點拆單
      IF lc_param.l_chk1 = "Y" THEN
         LET lc_param.wc = lc_param.wc," AND pmdssite = '",l_tmp2.pmdssite,"'"
      END IF
      #3.匯率選擇是1:依原單匯率
      IF lc_param.l_currbase_type = '1' THEN
         LET lc_param.wc = lc_param.wc," AND pmds038 = '",l_tmp2.pmds038,"'"
      END IF
      LET ls_js2 = util.JSON.stringify(lc_param)
      LET l_array[1].chr = l_tmp2.pmds008  #帳款供應商
      LET l_array[2].chr = l_tmp2.pmds031  #付款條件
      LET l_array[3].chr = l_tmp2.pmds033  #稅別
      LET l_array[4].chr = l_tmp2.pmds037  #幣別
      LET l_array[5].chr = l_tmp2.pmds038  #匯率
      LET l_array[6].chr = l_tmp2.group    #group
      CALL s_aapp320_ins_apbb2(ls_js2,l_array)RETURNING g_sub_success,l_strno,l_endno
      #160929-00030#1 add end---
      
      IF NOT g_sub_success THEN
         LET l_success = FALSE
      END IF
      
      IF l_success THEN
         CALL s_aapt110_conf_chk(l_strno)RETURNING g_sub_success,l_apbb010  
         IF NOT g_sub_success THEN
            LET l_success = FALSE
         ELSE
            CALL s_aapt110_conf_upd(l_strno)RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_success = FALSE
            END IF
         END IF
      END IF
      
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      ELSE
         LET l_do = 'Y'
         CALL s_transaction_end('Y','0')
         LET l_success_num1 = l_success_num1 + 1
         IF cl_null(l_strno1)THEN
            LET l_strno1 = l_strno
         END IF
         LET l_endno1 = l_strno
         
         #透過aapp132立帳 ----------
         IF lc_param.l_chk2 = "Y" THEN #160705-00035#4
            DELETE FROM s_aapp131_tmp_g
            
            SELECT glaa001,glaa025 INTO l_glaa001,l_glaa025
              FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaald = lc_param.l_apcald
            FOREACH aapp320_apbac1 USING l_strno INTO l_tmp.*
               #借用此暫存檔欄位pmds000,放置apba004
               #IF cl_null(l_tmp.pmdsdocdt)THEN LET l_tmp.pmdsdocdt = lc_param.l_apbbdocdt END IF
               LET l_tmp.pmdsdocdt = lc_param.l_apbbdocdt   #albireo 150825 修正為輸入的立帳日期
               IF l_tmp.pmds000 MATCHES '2[01]' OR l_tmp.pmds000 = '11' THEN
                  EXECUTE aapp320_get_pmdt024_p USING g_enterprise,l_tmp.apba005,l_tmp.apba006 INTO l_pmdt024
                  IF cl_null(l_pmdt024) THEN LET l_pmdt024 = 0 END IF
                  IF  l_pmdt024 < l_tmp.pmdt024 THEN
                     LET l_tmp.apcb007 = l_pmdt024
                  ELSE
                     LET l_tmp.apcb007 = l_tmp.pmdt024
                  END IF
               ELSE
                  LET l_tmp.apcb007 = l_tmp.pmdt024
               END IF
               #albireo 150825-----s
               #CALL s_apmm101_sel_pmab(lc_param.l_comp,l_tmp.pmds007,'pmab055') RETURNING g_sub_success,g_errno,l_tmp.apca007
               LET l_tmp.apca007 = lc_param.l_apca007
               #albireo 150825-----e
               
               #151012-00014#2-----s
               #改用參數判斷，帶出採用日/月平均匯率的預設值
               IF lc_param.l_currbase_type MATCHES '[23]' THEN
                  LET l_tmp.pmds038 = ''
                  LET lc_param_rate.type = '1'
                  LET lc_param_rate.apca004 = l_tmp.pmds007
                  LET lc_param_rate.sfin2009 = lc_param.l_currbase_type
                  LET ls_js = util.JSON.stringify(lc_param_rate)
                  CALL s_fin_get_curr_rate(lc_param.l_comp,lc_param.l_apcald,l_tmp.pmdsdocdt,l_tmp.pmds037,ls_js)
                       RETURNING l_tmp.pmds038,l_desc,l_desc
               END IF
               #--(mark)-s
               #CASE lc_param.l_currbase_type
               #     WHEN '2'  #依立帳日匯率(aooi160)
               #         CALL s_aooi160_get_exrate('2',lc_param.l_apcald,l_tmp.pmdsdocdt,l_tmp.pmds037,l_glaa001,0,l_glaa025)
               #              RETURNING l_tmp.pmds038
               #     WHEN '3'  #依立帳日月平均匯率(aooi170)
               #         CALL s_aooi160_get_exrate_avg('2',lc_param.l_apcald,l_tmp.pmdsdocdt,l_tmp.pmds037,l_glaa001,0,l_glaa025)
               #              RETURNING g_sub_success,g_errno,l_tmp.pmds038
               #END CASE
               #--(mark)-e
               #151012-00014#2-----e
               
               IF cl_null(l_tmp.pmds038) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00064'         #找不到有效的匯率資料
                  LET g_errparam.extend = l_tmp.pmdtdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE FOREACH
               END IF
               #INSERT INTO s_aapp131_tmp_g VALUES(l_tmp.*)  #161108-00017#1 mark
               #161108-00017#1 add ------
               INSERT INTO s_aapp131_tmp_g (pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,
                                            pmds031,pmds033,pmds037,pmds038,pmdtsite,
                                            pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,
                                            pmdt024,pmdldocno,pmdl002,pmdl003,apcb007,
                                            apbb050,apca007,cond1,apba005,apba006
                                            )
               VALUES (l_tmp.pmdsent,l_tmp.pmdsdocdt,l_tmp.pmds000,l_tmp.pmds007,l_tmp.pmds008,
                       l_tmp.pmds031,l_tmp.pmds033,l_tmp.pmds037,l_tmp.pmds038,l_tmp.pmdtsite,
                       l_tmp.pmdtdocno,l_tmp.pmdtseq,l_tmp.pmdt001,l_tmp.pmdt006,l_tmp.pmdt019,
                       l_tmp.pmdt024,l_tmp.pmdldocno,l_tmp.pmdl002,l_tmp.pmdl003,l_tmp.apcb007,
                       l_tmp.apbb050,l_tmp.apca007,l_tmp.cond1,l_tmp.apba005,l_tmp.apba006
                       )
               #161108-00017#1 add end---
            END FOREACH
            LET lc_param_apca.type = '2'
            LET lc_param_apca.sel1 = lc_param.l_process_type
            #LET lc_param_apca.sel2 = '7'   ##150921-00148#3 mark
            LET lc_param_apca.sel2 ='2'     ##150921-00148#3 add
            LET lc_param_apca.slip = lc_param.l_slip2
            LET lc_param_apca.site = lc_param.l_apcasite
            LET lc_param_apca.ld   = lc_param.l_apcald
            LET lc_param_apca.wc2  = ' 1=1'
            LET lc_param_apca.bgjob= 'Y' #g_bgjob
            LET lc_param_apca.apca063 = l_apca063
            LET ls_js = util.JSON.stringify(lc_param_apca)
            CALL s_transaction_begin()
            CALL s_aapp131_ins_apca(ls_js) RETURNING g_sub_success,l_strno,l_endno
            IF g_sub_success THEN
               CALL s_aooi390_oofi_upd('14',lc_param_apca.apca063) RETURNING g_sub_success
               CALL s_transaction_end('Y','0')
               LET l_success_num2 = l_success_num2 + 1
               IF cl_null(l_strno2)THEN
                  LET l_strno2 = l_strno
               END IF
               LET l_endno2 = l_strno
            ELSE
               CALL s_transaction_end('N','0')
            END IF
         END IF  #160705-00035#4
         #透過aapp132立帳 end-------
         
      END IF
   END FOREACH
   
  #IF l_do = 'N' OR (l_success_num1 + l_success_num2 = 0) THEN  #160705-00035#4 mark
   IF l_do = 'N' OR (l_success_num1 = 0) THEN                   #160705-00035#4
      #無符合條件資料
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
   ELSE
      IF l_success_num1 > 0 THEN
         #顯示成功的對帳單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00379'
         LET g_errparam.replace[1] = l_strno1
         LET g_errparam.replace[2] = l_endno1
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      IF l_success_num2 > 0 THEN
         #顯示成功的帳務單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00380'
         LET g_errparam.replace[1] = l_strno2
         LET g_errparam.replace[2] = l_endno2
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   
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
   CALL aapp320_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp320.get_buffer" >}
PRIVATE FUNCTION aapp320_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_apcasite = p_dialog.getFieldBuffer('l_apcasite')
   LET g_master.l_group_type = p_dialog.getFieldBuffer('l_group_type')
   LET g_master.l_comp = p_dialog.getFieldBuffer('l_comp')
   LET g_master.l_apcald = p_dialog.getFieldBuffer('l_apcald')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
   LET g_master.l_process_type = p_dialog.getFieldBuffer('l_process_type')
   LET g_master.l_apbbdocdt = p_dialog.getFieldBuffer('l_apbbdocdt')
   LET g_master.l_slip1 = p_dialog.getFieldBuffer('l_slip1')
   LET g_master.l_currbase_type = p_dialog.getFieldBuffer('l_currbase_type')
   LET g_master.l_slip2 = p_dialog.getFieldBuffer('l_slip2')
   LET g_master.l_apca007 = p_dialog.getFieldBuffer('l_apca007')
   LET g_master.l_apca063 = p_dialog.getFieldBuffer('l_apca063')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp320.msgcentre_notify" >}
PRIVATE FUNCTION aapp320_msgcentre_notify()
 
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
 
{<section id="aapp320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: ui輸入時預設值
# Memo...........:
# Date & Author..: 150706 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp320_qbeclear()
DEFINE l_tran      RECORD
          wc          STRING
                   END RECORD
DEFINE l_sql       STRING
DEFINE l_pmdsdocno LIKE pmds_t.pmdsdocno
DEFINE l_count     LIKE type_t.num10
DEFINE ls_js       STRING
DEFINE l_sfin3009  LIKE type_t.chr1 #151012-00014#2
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL    #畫面變數清空
   LET g_apca_prog = NULL
   #160705-00035#4-s
   LET g_master.l_group_type = '2'  #彙總條件
   LET g_master.l_chk1 = 'N'        #是否依來源營運據點拆單
   LET g_master.l_chk2 = 'N'        #是否一併產生應付帳款
   CALL cl_set_comp_visible('group_toaap',FALSE)
   #160705-00035#4-e
   LET g_master.l_currbase_type = '1'
   LET g_master.l_process_type = '2'
   LET g_master.l_apbbdocdt    = g_today
   DISPLAY BY NAME g_master.l_currbase_type,g_master.l_process_type,g_master.l_apbbdocdt
   CASE
      WHEN g_master.l_process_type = '2'
         LET g_apca_prog = 'aapt300'
      WHEN g_master.l_process_type = '5'
         LET g_apca_prog = 'aapt340'
   END CASE
   #150730-00006#1-----s
   
   #LET g_master.l_apcasite = g_site
   #CALL aapp320_pmdsdocno_def()
   
   #albireo 150803-----s
   LET ls_js = g_argv[01]
   CALL util.JSON.parse(ls_js,l_tran)
   LET l_sql = "SELECT DISTINCT pmdtdocno FROM pmdt_t ",
               " WHERE ",l_tran.wc CLIPPED
   PREPARE sel_pmdsp1 FROM l_sql
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,") "
   PREPARE sel_pmdsp2 FROM l_sql
   
   LET l_count = NULL
   EXECUTE sel_pmdsp2 INTO l_count
   CALL cl_set_comp_visible('group_sourceqbe',TRUE)
   CALL cl_set_comp_entry('l_apcasite,l_process_type',TRUE)
   IF l_count > 0 THEN
      LET l_pmdsdocno = NULL
      EXECUTE sel_pmdsp1 INTO l_pmdsdocno
      #CALL aisp320_xmdtdocno_def(l_xmdkdocno)
      CALL aapp320_pmdsdocno_def(l_pmdsdocno)
      CALL cl_set_comp_visible('group_sourceqbe',FALSE)
      CALL cl_set_comp_entry('l_apcasite,l_process_type',FALSE)
   ELSE
      LET g_master.l_apcasite = g_site
   END IF
   #albireo 150803-----e
    
   CALL s_fin_orga_get_comp_ld(g_master.l_apcasite) RETURNING g_sub_success,g_errno,g_master.l_comp,g_master.l_apcald
   CALL s_desc_get_ld_desc(g_master.l_apcald)RETURNING g_master.l_apcald_desc
   DISPLAY BY NAME g_master.l_comp,g_master.l_apcald,g_master.l_apcald_desc

   CALL s_fin_account_center_sons_query('3',g_master.l_apcasite,g_today,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   CALL s_desc_get_department_desc(g_master.l_apcasite) RETURNING g_master.l_apcasite_desc
   DISPLAY BY NAME g_master.l_apcasite_desc,g_master.l_apcasite
   #150730-00006#1-----e
   
   #161229-00047#12 add ------
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_wc_site
   CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
   
   CALL s_fin_get_wc_str(g_master.l_comp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#12 add end---
    
   #151022-00017#3 mark-----s
   #151012-00014#2-----s
   ##依畫面上帳套所屬法人取S-FIN-3009預設匯率選項
   #CALL cl_get_para(g_enterprise,g_master.l_comp,'S-FIN-3009') RETURNING l_sfin3009
   #CASE l_sfin3009
   #     WHEN '1'  #依立帳日匯率(aooi160)
   #        LET g_master.l_currbase_type = '2'
   #     WHEN '2'  #依立帳日月平均匯率(aooi170)
   #        LET g_master.l_currbase_type = '3'
   #END CASE
   #DISPLAY BY NAME g_master.l_currbase_type
   #151012-00014#2-----e
   #151022-00017#3 mark-----e
   
   LET g_master_o.* = g_master.*
   
END FUNCTION

################################################################################
# Descriptions...: 依入庫單預帶畫面資料
# Memo...........:
# Date & Author..: 150706 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp320_pmdsdocno_def(p_pmdsdocno)
   DEFINE l_pmds_slip   LIKE type_t.chr10
   DEFINE l_apbb_slip   LIKE type_t.chr10
   DEFINE l_apca_slip   LIKE type_t.chr10
   DEFINE l_gzcb004     LIKE type_t.chr10
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE p_pmdsdocno   LIKE pmds_t.pmdsdocno
   DEFINE l_cnt   LIKE type_t.num10
   DEFINE l_ooef004 LIKE ooef_t.ooef004
   
   INITIALIZE g_pmds.* TO NULL
   SELECT pmds000,pmds001,pmds038,pmdssite,
          pmds007   #albireo 150825 add
     INTO g_pmds.*
     FROM pmds_t
    WHERE pmdsent = g_enterprise
      AND pmdsdocno =  p_pmdsdocno 
   
   LET g_master.l_apbbdocdt = g_pmds.pmds001
   LET g_master.l_apcasite = g_pmds.pmdssite   
   CALL s_fin_orga_get_comp_ld(g_pmds.pmdssite) RETURNING g_sub_success,g_errno,g_master.l_comp,g_master.l_apcald
   CALL s_desc_get_ld_desc(g_master.l_apcald)RETURNING g_master.l_apcald_desc
   CALL s_desc_get_department_desc(g_master.l_apcasite) RETURNING g_master.l_apcasite_desc
   DISPLAY BY NAME g_master.l_slip1,g_master.l_slip2,g_master.l_comp,g_master.l_apcald,
           g_master.l_apbbdocdt,
           g_master.l_slip1_desc,g_master.l_slip2_desc,g_master.l_apcald_desc,
           g_master.l_apcasite,g_master.l_apcasite_desc

   CALL s_aooi200_get_slip(p_pmdsdocno)RETURNING g_sub_success,l_pmds_slip
   
   LET l_glaa024 = NULL
   SELECT glaa024 INTO l_glaa024 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.l_apcald
      
   #albireo 150825-----s
   #由入或退判斷哪一隻程式        
   LET l_gzcb004 = s_fin_get_scc_value('2060',g_pmds.pmds000,'2')
   LET g_apca_prog = NULL
   CASE
      WHEN l_gzcb004 = '1'
         LET g_apca_prog = 'aapt300'
         LET g_master.l_process_type = '2'
      WHEN l_gzcb004 = '-1'
         LET g_apca_prog = 'aapt340'
         LET g_master.l_process_type = '5'
   END CASE   
   #albireo 150825-----e   
   
#   CALL s_aooi210_get_doc(g_pmds.pmdssite,l_glaa024,'4',l_pmds_slip,'aapt110','Y')
#      RETURNING g_sub_success,l_apbb_slip
   #albireo 150823-----s
   CALL s_aooi100_sel_ooef004(g_pmds.pmdssite) RETURNING g_sub_success,l_ooef004
   CALL s_aooi210_set_chk(l_pmds_slip,'aapt110',l_ooef004,l_glaa024,'1')RETURNING l_cnt
   IF l_cnt > 0 THEN
      CALL s_aooi210_get_doc(g_pmds.pmdssite,l_glaa024,'4',l_pmds_slip,'aapt110','Y')
         RETURNING g_sub_success,l_apbb_slip
   END IF
   #albireo 150823-----e   
      
   IF NOT cl_null(l_apbb_slip)THEN
#      CALL s_aooi210_get_doc(g_pmds.pmdssite,l_glaa024,'4',l_apbb_slip,g_apca_prog,'Y')
#         RETURNING g_sub_success,l_apca_slip 
      #albireo 150823-----s
      #改為doc2
      CALL s_aooi100_sel_ooef004(g_pmds.pmdssite) RETURNING g_sub_success,l_ooef004
      CALL s_aooi210_set_chk(l_apbb_slip,g_apca_prog,l_ooef004,l_glaa024,'1')RETURNING l_cnt
      IF l_cnt > 0 THEN
         CALL s_aooi210_get_doc(g_pmds.pmdssite,l_glaa024,'4',l_apbb_slip,g_apca_prog,'Y')
            RETURNING g_sub_success,l_apca_slip 
      END IF
      #albireo 150823-----e
   END IF   
   
   LET g_master.l_slip1 = l_apbb_slip
   LET g_master.l_slip2 = l_apca_slip
   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc

   #albireo 150825-----s
   CALL s_apmm101_sel_pmab(g_master.l_comp,g_pmds.pmds007,'pmab055') RETURNING g_sub_success,g_errno,g_master.l_apca007
   CALL s_desc_get_acc_desc('3211',g_master.l_apca007) RETURNING g_master.l_apca007_desc
   DISPLAY BY NAME g_master.l_apca007_desc,g_master.l_apca007
   #albireo 150825-----e

   DISPLAY BY NAME g_master.l_slip1,g_master.l_slip2,g_master.l_comp,g_master.l_apcald,
           g_master.l_apbbdocdt,
           g_master.l_slip1_desc,g_master.l_slip2_desc,g_master.l_apcald_desc
   LET g_master_o.* = g_master.*       
END FUNCTION

#end add-point
 
{</section>}
 
