#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp134.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-05-16 15:57:36), PR版次:0017(2017-01-24 16:34:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000094
#+ Filename...: aapp134
#+ Description: 採購預付批次立帳作業
#+ Creator....: 03080(2014-10-23 11:10:31)
#+ Modifier...: 02097 -SD/PR- 07025
 
{</section>}
 
{<section id="aapp134.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150210-00011#4   2015/03/25  By Reanna   依立帳日取會計期間，限定可立帳的範圍為會計期間起始日~輸入立帳日
#141030-00016#7   2015/03/30  By albireo  預付單別檢核追加單別必須能預設apca001
#                                         採購單號開窗追加條件，不存在aapt310 的非作廢單據
#151231-00010#6   2016/01/25  By sakura   增加控制組
#160321-00016#19  2016/03/30  By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160325-00023#1   2016/03/29  By Hans     單別流程-預設單別修改 根據aooi210設置之流程修改單別合理性
#160420-00013#1   2016/04/25  By 02097    單頭的【帳款類型】原本開窗是取基礎資料設置，改為取依帳套設定的科目aapi011中有設定的類型，避免各帳套類型誤用。
#160530-00005#7   2016/07/24  By 03538    設定選項為不開發票時, 稅別條件不可空白;限定0稅稅別,且稅別不為過濾符合條件單據的條件
#160812-00027#3   2016/08/18  By 06821    全面盤點應付程式帳套權限控管
#160705-00035#6   2016/08/26  By Reanna   採購單開窗的期別欄位欄位移除
#160922-00053#1   2016/10/03  By dorishsu ON ACTION controlp INFIELD pmdldocno,取消pmdldocdt <= '",g_master.apcadocdt,"' "處理段落
#161006-00005#2   2016/10/12  By 08732    組織類型與職能開窗調整
#161012-00026#3   161019      By albireo  增加底稿產生
#161115-00042#1   2016/11/18  By 08171    開窗範圍處理
#161228-00025#1   2017/01/06  By Reanna   經與dido討論，最終改成：採購單號開窗增加"期別(pmdm001)"欄位顯示，但依舊只回傳採購單號而已，
#                                         原因是有顧問提出此需求，想在採購單號開窗看到該採購單每一期別的訂金明細，但假設開窗有三張採購單，
#                                         分別是A001、B001、C001，就算選A001第一期、B001第二期、C001第三期，還是只會回傳採購單號(A001、B001、C001)
#161229-00047#5   2017/01/10  By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170123-00002#1   2017/01/24  By catmoon  立訂金時會有跨期立帳情形，取消#150210-00011#4
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
         apcald       LIKE apca_t.apcald,     
         apcasite     LIKE apca_t.apcasite,
         apcadocdt    LIKE apca_t.apcadocdt,
         apcadocno    LIKE apca_t.apcadocno,
         apca007      LIKE apca_t.apca007,
         apca008      LIKE apca_t.apca008,
         apca011      LIKE apca_t.apca011,
         apca060      LIKE apca_t.apca060,
         pmdl055      LIKE pmdl_t.pmdl055,
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
   apcadocno_desc LIKE type_t.chr80, 
   apca007 LIKE type_t.chr10, 
   apca007_desc LIKE type_t.chr80, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apca008 LIKE type_t.chr10, 
   apca008_desc LIKE type_t.chr80, 
   apca060 LIKE type_t.chr1, 
   apca011 LIKE type_t.chr10, 
   apca011_desc LIKE type_t.chr80, 
   pmdl055 LIKE type_t.chr10, 
   pmdl004 LIKE type_t.chr10, 
   pmdldocno LIKE type_t.chr20, 
   pmdm001 LIKE type_t.num5, 
   pmdldocdt LIKE type_t.dat, 
   pmdm014 LIKE type_t.chr10, 
   pmdl002 LIKE type_t.chr20, 
   pmdl003 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_apcasite   STRING
DEFINE g_fin_arg1      LIKE type_t.chr1000
#150210-00011#4 add ------
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_pdate_s       LIKE glav_t.glav004   #立帳日期對應起始日(會計週期)
DEFINE g_pdate_e       LIKE glav_t.glav004   #立帳日期對應截止日(會計週期)
#以下僅承接不使用
DEFINE l_flag          LIKE type_t.chr1
DEFINE l_errno         LIKE type_t.chr100
DEFINE l_glav002       LIKE glav_t.glav002
DEFINE l_glav005       LIKE glav_t.glav005
DEFINE l_sdate_s       LIKE glav_t.glav004
DEFINE l_sdate_e       LIKE glav_t.glav004
DEFINE l_glav006       LIKE glav_t.glav006
DEFINE l_glav007       LIKE glav_t.glav007
DEFINE l_wdate_s       LIKE glav_t.glav004
DEFINE l_wdate_e       LIKE glav_t.glav004
#150210-00011#4 add end---
DEFINE g_sql_ctrl      STRING   #151231-00010#6
DEFINE g_apcacomp      LIKE apca_t.apcacomp  #161115-00042#1 add
DEFINE g_wc_apcald     STRING                #161115-00042#1 add
DEFINE g_wc_cs_comp    STRING   #161229-00047#5 add
DEFINE g_comp_str      STRING   #161229-00047#5 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp134.main" >}
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
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_fin_create_account_center_tmp()
      LET g_fin_arg1 = 'D-FIN-3001'
      #end add-point
      CALL aapp134_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp134 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp134_init()
 
      #進入選單 Menu (="N")
      CALL aapp134_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp134
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp134.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp134_init()
 
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
   CALL cl_set_combo_scc('apca060','8321')
   CALL cl_set_combo_scc("pmdl055","9951")
   CALL cl_set_combo_scc_part("pmdm014","3015","1,2")
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   CALL s_aap_create_multi_bill_perod_tmp()    #albireo 151228 fix 沖銷參數3多帳期異常
   LET g_fin_arg1 = 'D-FIN-3001'
   
   #161012-00026#3-----s
   CALL s_aapp330_cre_tmp()       RETURNING g_sub_success
   CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
   CALL s_aapp131_cre_tmp()
   #161012-00026#3-----e
   
   #151231-00010#6(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 mark
   #161115-00042#1 --s add
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#5 mark
   #161115-00042#1 --e add
   #151231-00010#6(E)    
   #161229-00047#5 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#5 --e add    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp134.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp134_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_apcacomp    LIKE apca_t.apcacomp
   DEFINE l_oodb        RECORD
                        oodb005   LIKE oodb_t.oodb005,
                        oodb006   LIKE oodb_t.oodb006,
                        oodb011   LIKE oodb_t.oodb011
                        END RECORD
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_ooef019     LIKE ooef_t.ooef019
   DEFINE l_ld_type     LIKE type_t.chr1
   DEFINE l_apca001     LIKE apca_t.apca001    #141030-00016#7
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp   #141030-00016#7 
   DEFINE l_where       STRING                 #160325-00023#1
   DEFINE l_comp_wc     STRING                 #161115-00042#1 add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp134_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald,g_master.apcadocno,g_master.apca007,g_master.apcadocdt, 
             g_master.apca008,g_master.apca060,g_master.apca011,g_master.pmdl055 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            LET g_master.apcasite_desc = ''
            IF NOT cl_null(g_master.apcasite) THEN         
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apcasite_desc = ''
                  DISPLAY BY NAME g_master.apcasite_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,l_apcacomp,g_master.apcald
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#5 mark
               CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#5 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#5 add 
              #CALL s_ld_sel_glaa(g_master.apcald,'glaa003') RETURNING  g_sub_success,g_glaa003  #150210-00011#4 #170123-00002#1 mark
               LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
               DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            END IF 
            LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
            DISPLAY BY NAME g_master.apcasite_desc 
            #161115-00042#1 --s add
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            #161115-00042#1 --e add
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
               #CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) #160812-00027#3 mark
               #CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','Y','',g_today)  #160812-00027#3 add #161115-00042#1 mark
                CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','Y',g_wc_apcald,g_today) #161115-00042#1 add 
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apcald_desc = ''
                  DISPLAY BY NAME g_master.apcald_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,l_apcacomp,g_errno
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#5 mark
               CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#5 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#5 add                
               #CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012      #應付暫估立帳選項
              #CALL s_ld_sel_glaa(g_master.apcald,'glaa003') RETURNING  g_sub_success,g_glaa003  #150210-00011#4 #170123-00002#1 mark
            END IF
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="input.a.apcadocno"
            LET g_master.apcadocno_desc = ' '
            #檢查是否有重複的單據編號(企業代碼/帳別/單號)
            IF NOT cl_null(g_master.apcadocno) THEN               
               #檢查單別是否存在單別檔/單別是有效
               LET g_errno = NULL
               #以帳別去取所屬法人,以法人勾稽單別是否在單別參照表
               CALL s_fin_slip_chk(g_master.apcadocno,'aapt310',g_master.apcald,g_fin_arg1) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_master.apcadocno = ''
                  LET g_master.apcadocno_desc = ''
                  DISPLAY BY NAME g_master.apcadocno_desc,g_master.apcadocno
                  NEXT FIELD CURRENT
               END IF
               #141030-00016#7-----s
               IF NOT cl_null(g_master.apcald)THEN
                  LET l_glaacomp = NULL
                  SELECT glaacomp INTO l_glaacomp 
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_master.apcald
                  LET l_apca001 = NULL
                  CALL s_fin_get_doc_para(g_master.apcald,l_glaacomp,g_master.apcadocno,g_fin_arg1) RETURNING l_apca001
                  IF cl_null(l_apca001)THEN
                     #無法在單別參數取得帳款單性質
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00345'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     LET g_master.apcadocno = ''
                     LET g_master.apcadocno_desc = ''
                     DISPLAY BY NAME g_master.apcadocno_desc,g_master.apcadocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #141030-00016#7-----e
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.apcadocno) RETURNING g_master.apcadocno_desc
            DISPLAY BY NAME g_master.apcadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="input.b.apcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocno
            #add-point:ON CHANGE apcadocno name="input.g.apcadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="input.a.apca007"
            LET g_master.apca007_desc = ' '
            IF NOT cl_null(g_master.apca007) THEN
               IF NOT s_azzi650_chk_exist('3211',g_master.apca007) THEN
                  LET g_master.apca007  = ''
                  LET g_master.apca007_desc = ''
                  DISPLAY BY NAME g_master.apca007_desc,g_master.apca007
                  NEXT FIELD CURRENT
               END IF
            END IF
            #160420-00013#1--(S)
            CALL s_aap_apca007_chk(g_master.apcald,g_master.apca007) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN        
               LET g_master.apca007  = ''            
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
            #160420-00013#1--(E)
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.apca007_desc
            DISPLAY BY NAME g_master.apca007_desc,g_master.apca007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="input.b.apca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca007
            #add-point:ON CHANGE apca007 name="input.g.apca007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="input.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="input.a.apcadocdt"
            #170123-00002#1--mark--start--
            ##150210-00011#4 add ------
            #IF NOT cl_null(g_master.apcadocdt) THEN
            #   #依年度+期別取得會計週期起迄日
            #   CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
            #   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
            #             l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
            #END IF
            ##150210-00011#4 add end---
            #170123-00002#1--mark--end----
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocdt
            #add-point:ON CHANGE apcadocdt name="input.g.apcadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca008
            
            #add-point:AFTER FIELD apca008 name="input.a.apca008"
            LET g_master.apca008_desc = ' '
            IF NOT cl_null(g_master.apca008) THEN
               CALL s_aap_ooib002_chk(g_master.apca008,'1')RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#19 --s add
                  LET g_errparam.replace[1] = 'aooi716'
                  LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi716'
                  #160321-00016#19 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apca008 = ''
                  LET g_master.apca008_desc = ''
                  DISPLAY BY NAME g_master.apca008_desc,g_master.apca008
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.apca008_desc
            DISPLAY BY NAME g_master.apca008_desc,g_master.apca008
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca008
            #add-point:BEFORE FIELD apca008 name="input.b.apca008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca008
            #add-point:ON CHANGE apca008 name="input.g.apca008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca060
            #add-point:BEFORE FIELD apca060 name="input.b.apca060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca060
            
            #add-point:AFTER FIELD apca060 name="input.a.apca060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca060
            #add-point:ON CHANGE apca060 name="input.g.apca060"
            #160530-00005#7--s
            CALL aapp134_set_no_required()  
            CALL aapp134_set_required()     
            #清空稅別,避免稅別舊值不符合零稅的條件
            LET g_master.apca011 = ''
            LET g_master.apca011_desc = ''
            DISPLAY BY NAME g_master.apca011_desc,g_master.apca011            
            #160530-00005#7--e
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="input.a.apca011"
            IF NOT cl_null(g_master.apca011) THEN              
               CALL s_tax_chk(l_apcacomp,g_master.apca011) 
                  RETURNING g_sub_success,g_master.apca011_desc,l_oodb.oodb005,l_oodb.oodb006,l_oodb.oodb011
               IF NOT g_sub_success THEN
                  LET g_master.apca011 = ''
                  LET g_master.apca011_desc = ''
                  DISPLAY BY NAME g_master.apca011_desc,g_master.apca011
                  NEXT FIELD CURRENT
               END IF
               
               #檢核特訂開發票條件與稅別是否有對到
               CALL s_aapt310_apca060_tax_chk(g_master.apca060,l_oodb.oodb006) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_master.apca011 = ''
                  LET g_master.apca011_desc = ''
                  DISPLAY BY NAME g_master.apca011_desc,g_master.apca011
                  NEXT FIELD CURRENT
               END IF                  
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca011
            #add-point:BEFORE FIELD apca011 name="input.b.apca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca011
            #add-point:ON CHANGE apca011 name="input.g.apca011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl055
            #add-point:BEFORE FIELD pmdl055 name="input.b.pmdl055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl055
            
            #add-point:AFTER FIELD pmdl055 name="input.a.pmdl055"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdl055
            #add-point:ON CHANGE pmdl055 name="input.g.pmdl055"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            #帳務中心
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite       #給予default值
            #LET g_qryparam.where = " ooef201 = 'Y' "
            #CALL q_ooef001()     #161006-00005#2  mark
            CALL q_ooef001_46()   #161006-00005#2  add                                #呼叫開窗
            LET g_master.apcasite = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.apcasite_desc
            NEXT FIELD apcasite                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            #開窗i段
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00042#1  add
            CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00042#1  add
            INITIALIZE g_qryparam.* TO NULL
            #161115-00042#1 --s add
           #CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
           #CALL s_fin_account_center_ld_str()RETURNING g_wc_apcasite
           #CALL s_fin_get_wc_str(g_wc_apcasite)RETURNING g_wc_apcasite
            #161115-00042#1 --e add
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_apcasite CLIPPED," "                                        #160812-00027#3 mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcasite CLIPPED," "   #160812-00027#3 add  #161115-00042#1 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""               #161115-00042#1 add
            CALL q_authorised_ld()
            LET g_master.apcald = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.apcald) RETURNING g_master.apcald_desc
            DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            NEXT FIELD apcald
            #END add-point
 
 
         #Ctrlp:input.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="input.c.apcadocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_master.apcald
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcadocno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "aapt310"
            CALL q_ooba002_1()
            LET g_master.apcadocno = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_aooi200_fin_get_slip_desc(g_master.apcadocno) RETURNING g_master.apcadocno_desc
            DISPLAY BY NAME g_master.apcadocno,g_master.apcadocno_desc
            NEXT FIELD apcadocno   #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca007      #給予default值
           #LET g_qryparam.arg1 = "3211"        #160420-00013#1 mark
           #CALL q_oocq002()                    #160420-00013#1 mark
            LET g_qryparam.arg1 = g_master.apcald     #160420-00013#1
            CALL q_glab002_1()                        #160420-00013#1  
            LET g_master.apca007 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.apca007_desc
            DISPLAY BY NAME g_master.apca007,g_master.apca007_desc
            NEXT FIELD apca007                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="input.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca008
            #add-point:ON ACTION controlp INFIELD apca008 name="input.c.apca008"
            #付款條件編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca008        #給予default值
            CALL q_ooib001_2()                                #呼叫開窗
            LET g_master.apca008 = g_qryparam.return1         #將開窗取得的值回傳到變數
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.apca008_desc
            DISPLAY BY NAME g_master.apca008,g_master.apca008_desc
            NEXT FIELD apca008
            #END add-point
 
 
         #Ctrlp:input.c.apca060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca060
            #add-point:ON ACTION controlp INFIELD apca060 name="input.c.apca060"
                                
            #END add-point
 
 
         #Ctrlp:input.c.apca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="input.c.apca011"
            #稅別
            #開窗i段
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise AND ooef001 = l_apcacomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca011        #給予default值
            LET g_qryparam.arg1 = l_ooef019                   #稅區
            IF NOT cl_null(g_master.apca060) AND (g_master.apca060 = '1' OR g_master.apca060 = '3') THEN
               LET g_qryparam.where = " oodb006 = 0 "
            END IF
            CALL q_oodb002_5()                                #呼叫開窗
            LET g_master.apca011 = g_qryparam.return1         #將開窗取得的值回傳到變數
            CALL s_tax_chk(l_apcacomp,g_master.apca011) RETURNING g_sub_success,g_master.apca011_desc,l_oodb.oodb005,l_oodb.oodb006,
                                                                  l_oodb.oodb011
            DISPLAY BY NAME g_master.apca011,g_master.apca011_desc
            NEXT FIELD apca011    #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.pmdl055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl055
            #add-point:ON ACTION controlp INFIELD pmdl055 name="input.c.pmdl055"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmdl004,pmdldocno,pmdm001,pmdldocdt,pmdm014,pmdl002,pmdl003 
 
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmdl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl004
            #add-point:ON ACTION controlp INFIELD pmdl004 name="construct.c.pmdl004"
            #供應商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#6(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#6(E)
            CALL q_pmaa001_3()
            DISPLAY g_qryparam.return1 TO pmdl004
            NEXT FIELD pmdl004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl004
            #add-point:BEFORE FIELD pmdl004 name="construct.b.pmdl004"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl004
            
            #add-point:AFTER FIELD pmdl004 name="construct.a.pmdl004"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocno
            #add-point:ON ACTION controlp INFIELD pmdldocno name="construct.c.pmdldocno"
            #採購單號
            INITIALIZE g_qryparam.* TO NULL
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
            CALL s_fin_account_center_sons_str()RETURNING g_wc_apcasite
            CALL s_fin_get_wc_str(g_wc_apcasite)RETURNING g_wc_apcasite
           #取得aooi210所設置之前置單別的合理性where 條件 
            CALL s_aooi210_get_check_sql(g_master.apcasite,'',g_master.apcadocno,'4','','pmdmdocno') RETURNING g_sub_success,l_where #160325-00023#1 #160705-00035#6 mark
            CALL s_aooi210_get_check_sql(g_master.apcasite,'',g_master.apcadocno,'4','','pmdldocno') RETURNING g_sub_success,l_where #160705-00035#6
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_get_ld_type(g_master.apcald) RETURNING l_ld_type
            IF NOT l_ld_type = 0 THEN
               LET g_qryparam.arg1 = l_ld_type
               LET g_qryparam.where = " pmdlstus = 'Y' "#,          #160705-00035#6 mark ,
                                     #" AND pmdm014 IN ('1','2') "  #160705-00035#6 mark
               #160922-00053---mark---str--                      
               #IF NOT cl_null(g_master.apcadocdt)THEN
               #   LET g_qryparam.where = g_qryparam.where CLIPPED,
               #              " AND pmdldocdt <= '",g_master.apcadocdt,"' "
               #END IF
               #160922-00053---mark---end--
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                                     #" AND pmdmsite IN ",g_wc_apcasite CLIPPED," ", #160705-00035#6 mark
                                      " AND pmdlsite IN ",g_wc_apcasite CLIPPED," ", #160705-00035#6
                                      " AND pmdl046 = '",g_master.apca060,"' "
               #170123-00002#1--mark--start--                       
               ##日期有輸入時,加入qbe條件 #150210-00011#4 add------
               #IF NOT cl_null(g_master.apcadocdt) THEN
               #   LET g_qryparam.where = g_qryparam.where," AND pmdldocdt BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' "
               #END IF
               ##150210-00011#4 add end---
               #170123-00002#1--mark--end----
               #過濾同稅別的資料
               #160530-00005#7 mark--s
               #IF NOT cl_null(g_master.apca011) THEN
               #  #LET g_qryparam.where = g_qryparam.where,
               #END IF
               #160530-00005#7 mark--e
               #160530-00005#7 --s
               IF g_master.apca060 <> '1' THEN
                  IF NOT cl_null(g_master.apca011) THEN
                     LET g_qryparam.where = g_qryparam.where , " AND pmdl011 = '",g_master.apca011,"'"
                  END IF
               END IF
               #160530-00005#7 --e
               
               #160705-00035#6 mark
               #改寫在r.q裡面
               ##141030-00016#7-----s
               ##不存在非確認的預付單據中
               #LET g_qryparam.where = g_qryparam.where," AND (pmdmdocno,pmdm001) NOT IN(",
               #                                        " SELECT DISTINCT apca018,apca064 FROM apca_t ",
               #                                        "  WHERE apcaent = ",g_enterprise,
               #                                        "    AND apcastus <> 'X' ",
               #                                        "    AND apcald = '",g_master.apcald,"' ",
               #                                        "    AND apca001 IN('11','14') ",
               #                                        "    AND apca018 IS NOT NULL ", 
               #                                        "    AND apca064 IS NOT NULL ",
               #                                        "    AND apca016 = '10') "
               ##141030-00016#7-----e
               #160705-00035#6 mark end---
               #151231-00010#6(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaa001 = pmdl004 )"
               END IF
               #151231-00010#6(E)
               LET g_qryparam.where = g_qryparam.where," AND ",l_where        #160325-00023#1
               CALL q_pmdldocno_5()
               DISPLAY g_qryparam.return1 TO pmdldocno
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00301'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
            NEXT FIELD pmdldocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocno
            #add-point:BEFORE FIELD pmdldocno name="construct.b.pmdldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocno
            
            #add-point:AFTER FIELD pmdldocno name="construct.a.pmdldocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm001
            #add-point:BEFORE FIELD pmdm001 name="construct.b.pmdm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm001
            
            #add-point:AFTER FIELD pmdm001 name="construct.a.pmdm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm001
            #add-point:ON ACTION controlp INFIELD pmdm001 name="construct.c.pmdm001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdldocdt
            #add-point:BEFORE FIELD pmdldocdt name="construct.b.pmdldocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdldocdt
            
            #add-point:AFTER FIELD pmdldocdt name="construct.a.pmdldocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdldocdt
            #add-point:ON ACTION controlp INFIELD pmdldocdt name="construct.c.pmdldocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdm014
            #add-point:BEFORE FIELD pmdm014 name="construct.b.pmdm014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdm014
            
            #add-point:AFTER FIELD pmdm014 name="construct.a.pmdm014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdm014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdm014
            #add-point:ON ACTION controlp INFIELD pmdm014 name="construct.c.pmdm014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl002
            #add-point:ON ACTION controlp INFIELD pmdl002 name="construct.c.pmdl002"
            #採購人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO pmdl002
            NEXT FIELD pmdl002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl002
            #add-point:BEFORE FIELD pmdl002 name="construct.b.pmdl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl002
            
            #add-point:AFTER FIELD pmdl002 name="construct.a.pmdl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdl003
            #add-point:ON ACTION controlp INFIELD pmdl003 name="construct.c.pmdl003"
            #採購部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()
            DISPLAY g_qryparam.return1 TO pmdl003
            NEXT FIELD pmdl003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdl003
            #add-point:BEFORE FIELD pmdl003 name="construct.b.pmdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdl003
            
            #add-point:AFTER FIELD pmdl003 name="construct.a.pmdl003"
            
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
            CALL aapp134_get_buffer(l_dialog)
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
            INITIALIZE g_master.* TO NULL
            CALL aapp134_qbeclear()
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
         CALL aapp134_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.apcald    = g_master.apcald    
      LET lc_param.apcasite  = g_master.apcasite  
      LET lc_param.apcadocdt = g_master.apcadocdt
      LET lc_param.apcadocno = g_master.apcadocno
      LET lc_param.apca007   = g_master.apca007
      LET lc_param.apca008   = g_master.apca008
      LET lc_param.apca011   = g_master.apca011
      LET lc_param.apca060   = g_master.apca060
      LET lc_param.pmdl055   = g_master.pmdl055
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
                 CALL aapp134_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp134_transfer_argv(ls_js)
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
 
{<section id="aapp134.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp134_transfer_argv(ls_js)
 
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
 
{<section id="aapp134.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp134_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_wc        STRING
   DEFINE l_strno     LIKE apca_t.apcadocno
   DEFINE l_endno     LIKE apca_t.apcadocno
   DEFINE l_field     DYNAMIC ARRAY OF RECORD
                        f11       LIKE type_t.chr100,
                        f21       LIKE type_t.chr100
                      END RECORD
   DEFINE l_ld_type   LIKE type_t.chr1
   DEFINE l_where     STRING     #160325-00023#1
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
      LET g_master.apcald    = lc_param.apcald   
      LET g_master.apcasite  = lc_param.apcasite 
      LET g_master.apcadocdt = lc_param.apcadocdt
      LET g_master.apcadocno = lc_param.apcadocno
      LET g_master.apca007   = lc_param.apca007  
      LET g_master.apca008   = lc_param.apca008  
      LET g_master.apca011   = lc_param.apca011  
      LET g_master.apca060   = lc_param.apca060  
      LET g_master.pmdl055   = lc_param.pmdl055  
      CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
           RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                     l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   END IF
                           
   IF NOT cl_null(g_master.apcadocno) THEN               
      #檢查單別是否存在單別檔/單別是有效
      LET g_errno = NULL
      #以帳別去取所屬法人,以法人勾稽單別是否在單別參照表
      CALL s_fin_slip_chk(g_master.apcadocno,'aapt310',g_master.apcald,g_fin_arg1) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_master.apcadocno = ''
         LET g_master.apcadocno_desc = ''
         DISPLAY BY NAME g_master.apcadocno_desc,g_master.apcadocno
         RETURN
      END IF
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapp134_process_cs CURSOR FROM ls_sql
#  FOREACH aapp134_process_cs INTO
   #add-point:process段process name="process.process"
   #依input條件做l_wc
   
   LET l_wc = g_master.wc 
   IF cl_null(l_wc)THEN LET l_wc = " 1=1" END IF
   LET l_wc = l_wc CLIPPED,
              " AND pmdlstus = 'Y' ",
              " AND pmdm014 IN ('1','2') "
              
   #如果有立帳只能抓入小於等於立帳日範圍的單子
   IF NOT cl_null(g_master.apcadocdt)THEN
      LET l_wc = l_wc CLIPPED,
                 " AND pmdldocdt <= '",g_master.apcadocdt,"' " #150210-00011#4 mark     #170123-00002#1 remark
                #" AND pmdldocdt BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' " #150210-00011#4 #170123-00002#1 mark
   END IF
   
   #根據帳別判斷要組怎樣的數字判斷
   LET l_field[1].f11 = "pmdm008"   LET l_field[2].f11 = "pmdm010"   LET l_field[3].f11 = "pmdm012"   #請款數量
   CALL s_fin_get_ld_type(g_master.apcald) RETURNING l_ld_type
   LET l_wc = l_wc CLIPPED,
              " AND pmdm005 > ",l_field[l_ld_type].f11," "
   
   #151231-00010#6(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_sql = ls_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                          "              WHERE pmaaent = ",g_enterprise,
                          "                AND ",g_sql_ctrl,
                          "                AND pmaa001 = pmdl004 )"
   END IF
   #151231-00010#6(E)   
   
   #160325-00023#1 ---s---
   CALL s_aooi210_get_check_sql(g_master.apcasite,'',g_master.apcadocno,'4','','pmdmdocno') RETURNING g_sub_success,l_where   
   LET l_wc = l_wc CLIPPED," AND ",l_where 
   #160325-00023#1 ---e---
   
   CALL cl_err_collect_init()
   #這邊不開transaction
   #transaction已經包含在sub中 
   #原因是SA要求一張單各自的transaction
   CALL s_aapp134_ins_apca(g_master.apcald,g_master.apcasite,g_master.apcadocdt,
                           g_master.apcadocno,g_master.apca007,g_master.apca008,
                           g_master.apca011,g_master.apca060,g_master.pmdl055,l_wc)
                           RETURNING g_sub_success,l_strno,l_endno
   IF NOT cl_null(l_strno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = l_strno
      LET g_errparam.replace[2] = l_endno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
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
   CALL aapp134_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp134.get_buffer" >}
PRIVATE FUNCTION aapp134_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
   LET g_master.apcadocno = p_dialog.getFieldBuffer('apcadocno')
   LET g_master.apca007 = p_dialog.getFieldBuffer('apca007')
   LET g_master.apcadocdt = p_dialog.getFieldBuffer('apcadocdt')
   LET g_master.apca008 = p_dialog.getFieldBuffer('apca008')
   LET g_master.apca060 = p_dialog.getFieldBuffer('apca060')
   LET g_master.apca011 = p_dialog.getFieldBuffer('apca011')
   LET g_master.pmdl055 = p_dialog.getFieldBuffer('pmdl055')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp134.msgcentre_notify" >}
PRIVATE FUNCTION aapp134_msgcentre_notify()
 
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
 
{<section id="aapp134.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PUBLIC FUNCTION aapp134_qbeclear()
   DEFINE l_apcacomp   LIKE apca_t.apcacomp 
   LET g_master.pmdl055 = '1'
   LET g_master.apca060 = '1'
   CALL aapp134_set_no_required()   #160530-00005#7
   CALL aapp134_set_required()      #160530-00005#7
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_master.apcasite,g_errno
   CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_master.apcald,l_apcacomp,g_errno
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#5 mark
   CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#5 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#5 add     
   CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,3,'N','',g_today)
      RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN
      LET g_master.apcasite = ''
      LET g_master.apcald   = ''
   ELSE
      CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
      CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
      LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
      LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
     #CALL s_ld_sel_glaa(g_master.apcald,'glaa003') RETURNING  g_sub_success,g_glaa003  #150210-00011#4 #170123-00002#1 mark
   END IF
   LET g_master.apcadocdt = ' '
   DISPLAY BY NAME g_master.apcald_desc,g_master.apcasite_desc
END FUNCTION

################################################################################
# Descriptions...: 欄位必填控制
# Date & Author..: 160724 By 03538(#160530-00005#7)
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp134_set_required()
   IF g_master.apca060 = '1' THEN
      CALL cl_set_comp_required("apca011",TRUE)	
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 欄位必填控制
# Date & Author..: 160724 By 03538(#160530-00005#7)
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp134_set_no_required()
   CALL cl_set_comp_required("apca011",FALSE)	
END FUNCTION

#end add-point
 
{</section>}
 
