#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp131.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-09-01 15:40:59), PR版次:0017(2017-01-06 15:07:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000180
#+ Filename...: aapp131
#+ Description: 暫估應付批次立帳作業
#+ Creator....: 02097(2014-10-06 13:29:20)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="aapp131.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150126-00012#1   2015/01/26  By apo      transaction移至s_aapp131,以達成單筆commit
#15210apo         2015/02/10  By apo      以畫面上立帳日期取對應會計週期期別之起始日與立帳日期,作為入庫單之日期範圍限制
#150127-00007#1   2015/02/24  By Reanna   掃把清空&給預設值
#150629-00038#1   2015/06/30  By albireo  入庫單性質增加20委外採購入庫   17~19 借貨相關
#150702-00001#1   2015/07/03  By albireo  入庫單性質改動態抓取
#151012-00014#2   2015/10/14  By Jessy    帶入日/月平均匯率預設值，依aoos020(S-FIN-3009)設定
#151231-00010#6   2016/01/25  By sakura   增加控制組
#160114-00019#4   2016/01/26  By 02097    若是依入庫單, 理論上是依入庫扣帳日期產生 只要帳款日期是空白時,取入庫日期為帳款立帳日。
#160325-00023#1   2016/03/29  By Hans     單別流程-預設單別修改 根據aooi210設置之流程修改單別合理性
#160321-00016#19  2016/03/30  By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160420-00013#1   2016/04/25  By 02097    單頭的【帳款類型】原本開窗是取基礎資料設置，改為取依帳套設定的科目aapi011中有設定的類型，避免各帳套類型誤用。
#160530-00005#3   2016/05/30  By 03538    採購性質串 scc 2061 應用分類一, 若為Y 之性質才可立帳
#160621-00026#1   2016/06/22  By 03538    過帳套欄位,應重新依所屬法人取參數S-FIN-3012;並且拿掉S-FIN-3003迴轉否影響是否含稅立帳判斷,只看S-FIN-3012
#160623-00007#1   2016/06/23  By 03538    重新輸入條件前,先把工作進度條現處理階段清空
#160614-00014#2   2016/07/24  By 03538    稅別的輸入檢核及開窗，依參數決定取稅別
#160816-00022#2   2016/09/01  By 06821    1. QBE增加稅別, 若aoos020 為含稅立暫估,則"選項"框稅別隱藏, 因為要依入庫單稅別立暫估 2.暫估單若有稅額時, 稅額科目固定取 aapi011 暫估稅額科目
#                                         3. apcb107 目前為no use,請在立暫估時,把入庫單單價存入apcb107,在沖暫估時價差的比對,用apcb107和沖暫估單的單價比對,若有差額表示有價差
#161006-00005#2   2016/10/12  By 08732    組織類型與職能開窗調整
#161108-00017#1   2016/11/08  By Reanna   程式中INSERT INTO 有星號作整批調整
#161115-00042#1   2016/11/18  By 08171    開窗範圍處理
#160802-00007#2   161125      By albireo  加入一次性交易對象處理,從前端來源時承接相同交易對象一路往後帶
#161229-00047#2   170106      By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
         apca011        LIKE apca_t.apca011,
         apca008        LIKE apca_t.apca008,
         rate1          LIKE apca_t.apca101,
         sel2           LIKE type_t.chr1,
         slip1          LIKE apca_t.apcadocno,
         apca007        LIKE apca_t.apca007,
         apcadocdt      LIKE apca_t.apcadocdt,
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
   l_apcasite_desc LIKE type_t.chr80, 
   apcald LIKE apca_t.apcald, 
   l_apcald_desc LIKE type_t.chr80, 
   slip1 LIKE type_t.chr500, 
   l_slip1_desc LIKE type_t.chr80, 
   slip1type LIKE type_t.chr500, 
   apca007 LIKE apca_t.apca007, 
   l_apca007_desc LIKE type_t.chr80, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apca011 LIKE apca_t.apca011, 
   l_apca011_desc LIKE type_t.chr80, 
   apca008 LIKE apca_t.apca008, 
   l_apca008_desc LIKE type_t.chr80, 
   rate1 LIKE type_t.chr500, 
   sel2 LIKE type_t.chr500, 
   pmds007 LIKE pmds_t.pmds007, 
   pmds001 LIKE pmds_t.pmds001, 
   pmdtdocno LIKE pmdt_t.pmdtdocno, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
   l_apca011 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o      type_master
DEFINE g_wc_apcasite   STRING
DEFINE g_wc_apcald     STRING
DEFINE g_wc2           STRING
DEFINE g_sfin2011      LIKE type_t.chr1
DEFINE g_sfin3012      LIKE type_t.chr1
DEFINE g_glaa024       LIKE glaa_t.glaa024
#150210apo--(s)
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_pdate_s       LIKE glav_t.glav004   #立帳日期對應起始日(會計週期)
DEFINE g_pdate_e       LIKE glav_t.glav004   #立帳日期對應截止日(會計週期)
#以下僅承接不使用
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_errno          LIKE type_t.chr100
DEFINE l_glav002        LIKE glav_t.glav002
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004
DEFINE l_sdate_e        LIKE glav_t.glav004
DEFINE l_glav006        LIKE glav_t.glav006
DEFINE l_glav007        LIKE glav_t.glav007
DEFINE l_wdate_s        LIKE glav_t.glav004
DEFINE l_wdate_e        LIKE glav_t.glav004
#150210apo--(e)
DEFINE g_sql_ctrl       STRING   #151231-00010#6
DEFINE g_apcacomp       LIKE apca_t.apcacomp  #161115-00042#1
DEFINE g_wc_cs_comp     STRING  #161229-00047#2 add
DEFINE g_comp_str       STRING  #161229-00047#2 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp131.main" >}
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
      CALL s_aapp131_cre_tmp()
      CALL s_fin_create_account_center_tmp()    #帳務中心
      CALL s_aap_create_multi_bill_perod_tmp()  #多帳期
      #end add-point
      CALL aapp131_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp131 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp131_init()
 
      #進入選單 Menu (="N")
      CALL aapp131_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp131
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp131.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp131_init()
 
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
   CALL s_aapp131_cre_tmp()
   CALL s_fin_create_account_center_tmp()    #帳務中心
   CALL s_aap_create_multi_bill_perod_tmp()  #多帳期
   CALL cl_set_combo_scc_part("sel2","8527","1,2,3,4,5,6")
   CALL cl_set_combo_scc("rate1","9951")
   
   #151231-00010#6(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 mark
   #161229-00047#2 --s mark
   ##161115-00042#1 --s add
   #SELECT ooef017 INTO g_apcacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#1 --e add
   ##151231-00010#6(E)  
   #161229-00047#2 --e mark
   #161229-00047#2 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#2 --e add   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp131.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp131_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_apcacomp    LIKE ooef_t.ooef001
   DEFINE l_apca012     LIKE apca_t.apca012
   DEFINE l_apca013     LIKE apca_t.apca013
   DEFINE l_oodb004     LIKE oodb_t.oodb004
   DEFINE l_oodb008     LIKE oodb_t.oodb008
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_ooef019     LIKE ooef_t.ooef019
   DEFINE l_ref         LIKE type_t.chr10
   DEFINE l_strdat      LIKE type_t.dat
   DEFINE l_enddat      LIKE type_t.dat
   DEFINE l_ld_type     LIKE type_t.chr1
   DEFINE l_pmds000_str1 STRING   #150702-00001#1 add
   DEFINE l_where      STRING     #160325-00023#1
   DEFINE l_pmds011_str1 STRING   #160530-00005#3
   DEFINE l_comp_wc      STRING   #161115-00042#1 add
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)  
   #150702-00001#1-----e
   #160530-00005#3--s
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)     
   #160530-00005#3--e
   
   #150127-00007#1
   CALL aapp131_qbe_clear() RETURNING l_apcacomp
   CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#2 add
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald,g_master.slip1,g_master.apca007,g_master.apcadocdt, 
             g_master.apca011,g_master.apca008,g_master.rate1,g_master.sel2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            LET g_master.l_apcasite_desc = ''
            IF NOT cl_null(g_master.apcasite) THEN
               IF g_master.apcasite != g_master_o.apcasite THEN
                  CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,l_apcacomp,g_master.apcald
               END IF
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_apcasite_desc = ''
                  DISPLAY BY NAME g_master.l_apcasite_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               #CALL s_ld_sel_glaa(g_master.apcald,'glaa024') RETURNING  g_sub_success,g_glaa024                    #150210apo mark
               CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024   #150210apo
               LET g_master.l_apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
               LET g_master_o.apcasite = g_master.apcasite
               DISPLAY BY NAME g_master.apcald,g_master.l_apcald_desc
               CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add 
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#2 add
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark
            END IF 
            LET g_master.l_apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
            DISPLAY BY NAME g_master.l_apcasite_desc
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
            LET g_master.l_apcald_desc = ''
            IF NOT cl_null(g_master.apcald) THEN         
              #CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) #161115-00042#1 mark
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','Y',g_wc_apcald,g_today) #161115-00042#1 add
                  RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_apcald_desc = ''
                  DISPLAY BY NAME g_master.l_apcald_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,l_apcacomp,g_errno
               CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#2 add
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark
              #CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2010') RETURNING g_master.apca011   #稅額預設值   #150717-mark
               CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3010') RETURNING g_master.apca011   #稅額預設值
               CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3011') RETURNING g_sfin2011         #暫估迴轉否(Y:迴轉/N:不迴轉)   #160621-00026#1
               CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012         #應付暫估立帳選項
               CALL aapp131_single_tax_chk(l_apcacomp,l_apcacomp,g_master.apca011) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  LET g_master.apca011 = ''
               END IF
               #不回转的话，暂估立税一定是要不含税立账的(如果是不迴轉 就不考慮暫估立帳參數
              #IF g_sfin2011 = 'N' THEN LET g_sfin3012 = '1' END IF      #160621-00026#1 mark
               IF NOT cl_null(g_master.apcadocdt) THEN      #160114-00019#4
                  CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
                  CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
                       RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                                 l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
                  IF cl_null(g_pdate_s) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = 'agl-00211'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_pdate_s = g_master.apcadocdt
                  END IF
               END IF         #160114-00019#4
               DISPLAY BY NAME g_master.apca011
               
               #160816-00022#2 add --s
               #若aoos020(s-fin-3012)為2.含稅立暫估,則選項框稅別隱藏,要依入庫單稅別立暫估
               CALL cl_set_comp_visible("lbl_apca011,apca011,l_apca011_desc",TRUE)
               IF g_sfin3012 = '2' THEN 
                  CALL cl_set_comp_visible("lbl_apca011,apca011,l_apca011_desc",FALSE)
               END IF
               #160816-00022#2 add --e
               
            END IF
            LET g_master.l_apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.l_apcald_desc
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
         AFTER FIELD slip1
            
            #add-point:AFTER FIELD slip1 name="input.a.slip1"
            LET g_master.l_slip1_desc = ''
            DISPLAY BY NAME g_master.l_slip1_desc
            IF NOT cl_null(g_master.slip1)THEN
               CALL s_fin_slip_chk(g_master.slip1,'aapt320',g_master.apcald,'D-FIN-3001') RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_slip1_desc = ''
                  LET g_master.slip1type = ''
                  DISPLAY BY NAME g_master.l_slip1_desc,g_master.slip1type
                  NEXT FIELD CURRENT
               END IF
               #給沖帳類型
               LET l_ref = ''
              #CALL cl_get_doc_para(g_enterprise,l_apcacomp,g_master.slip1,'D-FIN-3001') RETURNING l_ref
               CALL s_fin_get_doc_para(g_master.apcald,l_apcacomp,g_master.slip1,'D-FIN-3001') RETURNING l_ref
               CASE
                  WHEN l_ref = '01'
                     LET g_master.slip1type = '1'
                  WHEN l_ref = '02'
                     LET g_master.slip1type = '2'
               END CASE               
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.slip1)RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.slip1,g_master.l_slip1_desc,g_master.slip1type
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD slip1
            #add-point:BEFORE FIELD slip1 name="input.b.slip1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE slip1
            #add-point:ON CHANGE slip1 name="input.g.slip1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="input.a.apca007"
            LET g_master.l_apca007_desc = ' '
            IF NOT cl_null(g_master.apca007) THEN
               IF NOT s_azzi650_chk_exist('3211',g_master.apca007) THEN
                  LET g_master.l_apca007_desc = ''
                  DISPLAY BY NAME g_master.l_apca007_desc
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
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.l_apca007_desc
            DISPLAY BY NAME g_master.l_apca007_desc
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
            IF NOT cl_null(g_master.apcadocdt) THEN      #160114-00019#4
               #150210apo--(s)
               #依年度+期別取得會計週期起迄日
               CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e   
               #150210apo--(e)     
            END IF                      #160114-00019#4
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocdt
            #add-point:ON CHANGE apcadocdt name="input.g.apcadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="input.a.apca011"
            IF NOT cl_null(g_master.apca011)THEN
               CALL s_tax_chk(l_apcacomp,g_master.apca011) 
                  RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
               IF NOT g_sub_success THEN
                  LET g_master.l_apca011_desc = ''
                  DISPLAY BY NAME g_master.l_apca011_desc
                  NEXT FIELD apca011
               ELSE
                  #160614-00014#2--s
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t   #稅區
                   WHERE ooefent = g_enterprise AND ooef001 = l_apcacomp                  
                  #160614-00014#2--e
                  LET l_oodb004 = NULL
                  LET l_oodb008 = NULL
                  SELECT oodb004,oodb008 INTO l_oodb004,l_oodb008
                    FROM oodb_t
                   WHERE oodbent  = g_enterprise AND oodb001  = l_ooef019
                     AND oodb002  = g_master.apca011
                  IF l_oodb004 <> '1' THEN   #非單一稅率
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00182'
                     LET g_errparam.extend = ''
                    #LET g_errparam.popup = FALSE          #160614-00014#2 mark
                     LET g_errparam.popup = TRUE           #160614-00014#2                     
                     CALL cl_err()
                     NEXT FIELD apca011
                  END IF
                  IF g_sfin3012 = '1' THEN
                     IF NOT l_oodb008 MATCHES '[23]' THEN
                        INITIALIZE g_errparam TO NULL
                       #LET g_errparam.code = 'aap-00182'  #160614-00014#2 mark
                        LET g_errparam.code = 'aap-00343'  #160614-00014#2                         
                        LET g_errparam.extend = ''
                       #LET g_errparam.popup = FALSE       #160614-00014#2 mark
                        LET g_errparam.popup = TRUE        #160614-00014#2                        
                        CALL cl_err()
                        NEXT FIELD apca011
                     END IF
                  END IF
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
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca008
            
            #add-point:AFTER FIELD apca008 name="input.a.apca008"
            LET g_master.l_apca008_desc = ' '
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

                  CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.l_apca008_desc
                  DISPLAY BY NAME g_master.l_apca008_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.l_apca008_desc
            DISPLAY BY NAME g_master.l_apca008_desc
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
         BEFORE FIELD rate1
            #add-point:BEFORE FIELD rate1 name="input.b.rate1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rate1
            
            #add-point:AFTER FIELD rate1 name="input.a.rate1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rate1
            #add-point:ON CHANGE rate1 name="input.g.rate1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel2
            #add-point:BEFORE FIELD sel2 name="input.b.sel2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel2
            
            #add-point:AFTER FIELD sel2 name="input.a.sel2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel2
            #add-point:ON CHANGE sel2 name="input.g.sel2"
            #160114-00019#4---(S)
            CALL cl_set_comp_required("apcadocdt",TRUE)
            IF g_master.sel2 = '2' THEN
               CALL cl_set_comp_required("apcadocdt",FALSE)
            END IF
            #160114-00019#4---(E)
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite       
            #CALL q_ooef001()     #161006-00005#2  mark
            CALL q_ooef001_46()   #161006-00005#2  add
            LET g_master.apcasite = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.l_apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.l_apcasite_desc 
            NEXT FIELD apcasite
            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00042#1  add
            CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00042#1  add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald                    
           #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald  #glaa008(平行記帳)/glaa014(主帳套) #161115-00042#1  mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161115-00042#1 add 
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            CALL q_authorised_ld()                                       
            LET g_master.apcald = g_qryparam.return1                     
            LET g_master.l_apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.l_apcald_desc
            NEXT FIELD apcald                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.slip1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD slip1
            #add-point:ON ACTION controlp INFIELD slip1 name="input.c.slip1"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.slip1
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'aapt320'
            CALL q_ooba002_1()                
            LET g_master.slip1 = g_qryparam.return1              
            CALL s_aooi200_fin_get_slip_desc(g_master.slip1)RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.slip1,g_master.l_slip1_desc
            NEXT FIELD slip1
            #END add-point
 
 
         #Ctrlp:input.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca007
            #LET g_qryparam.arg1 = "3211"        #160420-00013#1 mark
            #CALL q_oocq002()                    #160420-00013#1 mark
            LET g_qryparam.arg1 = g_master.apcald     #160420-00013#1
            CALL q_glab002_1()                        #160420-00013#1  
            LET g_master.apca007 = g_qryparam.return1
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.l_apca007_desc
            DISPLAY BY NAME g_master.apca007,g_master.l_apca007_desc
            NEXT FIELD apca007
            #END add-point
 
 
         #Ctrlp:input.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="input.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="input.c.apca011"
            #稅別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca011  
            SELECT ooef019 INTO l_ooef019 FROM ooef_t   #稅區
             WHERE ooefent = g_enterprise AND ooef001 = l_apcacomp
            LET g_qryparam.arg1 = l_ooef019
            IF g_sfin3012 = '1' THEN   #不含稅
               LET g_qryparam.where = " oodb004 ='1' AND oodb008 IN ('2','3') "
            ELSE
               LET g_qryparam.where = " oodb004 ='1' "
            END IF
            CALL q_oodb002_5()
            LET g_master.apca011 = g_qryparam.return1
            LET g_master.l_apca011_desc = s_desc_get_tax_desc(l_ooef019,g_master.apca011)
            DISPLAY BY NAME g_master.apca011,g_master.l_apca011_desc
            NEXT FIELD apca011
            #END add-point
 
 
         #Ctrlp:input.c.apca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca008
            #add-point:ON ACTION controlp INFIELD apca008 name="input.c.apca008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca008
            CALL q_ooib001_2()
            LET g_master.apca008 = g_qryparam.return1
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.l_apca008_desc
            DISPLAY BY NAME g_master.apca008,g_master.l_apca008_desc
            NEXT FIELD apca008
            #END add-point
 
 
         #Ctrlp:input.c.rate1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rate1
            #add-point:ON ACTION controlp INFIELD rate1 name="input.c.rate1"
            
            #END add-point
 
 
         #Ctrlp:input.c.sel2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel2
            #add-point:ON ACTION controlp INFIELD sel2 name="input.c.sel2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmds007,pmds001,pmdtdocno,l_apca011
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca011
            #add-point:BEFORE FIELD apca011 name="construct.b.apca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="construct.a.apca011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apca011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="construct.c.apca011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds007
            #add-point:ON ACTION controlp INFIELD pmds007 name="construct.c.pmds007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#6(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #151231-00010#6(E)            
            CALL q_pmaa001_3()                           #呼叫開窗
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
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
            CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
            CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite 
           #CALL s_date_get_first_date(g_master.apcadocdt) RETURNING l_strdat  #150210apo mark
           #CALL s_date_get_last_date(g_master.apcadocdt)  RETURNING l_enddat  #150210apo mark
            #取得aooi210所設置之前置單別的合理性where 條件 
            CALL s_aooi210_get_check_sql(g_master.apcasite,'',g_master.slip1,'4','','pmdsdocno') RETURNING g_sub_success,l_where   #160325-00023#1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL s_fin_get_ld_type(g_master.apcald) RETURNING g_qryparam.arg1
            IF NOT g_qryparam.arg1 = 0 THEN
               LET g_qryparam.where = 
                                      #" pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','17','18','19','20') ", #150702-00001#1 mark   #150629-00038#1 add 17~20
                                      "     pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
                                      " AND pmds011 IN ",l_pmds011_str1 CLIPPED,   #160530-00005#3
                                      " AND pmdtsite IN ",g_wc_apcasite,
                                      " AND pmdsstus = 'S' "
                                      ," AND ",l_where #160325-00023#1
               IF NOT cl_null(g_pdate_s) AND NOT cl_null(g_master.apcadocdt) THEN         #160114-00019#4
                  LET g_qryparam.where = g_qryparam.where,
                                     #" AND pmds001 BETWEEN '",l_strdat,"' AND '",l_enddat,"' "              #150210apo mark
                                      " AND pmds001 BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' "   #150210apo
               END IF         #160114-00019#4
               #151231-00010#6(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaaent = pmdtent ",
                                                          "                AND pmaa001 = pmds008 )"
               END IF
               #151231-00010#6(E)                                      
               CALL q_pmdtdocno_4()
               DISPLAY g_qryparam.return1 TO pmdtdocno  #顯示到畫面上
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00301'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()   
            END IF
            NEXT FIELD pmdtdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apca011
            #add-point:BEFORE FIELD l_apca011 name="construct.b.l_apca011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apca011
            
            #add-point:AFTER FIELD l_apca011 name="construct.a.l_apca011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_apca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apca011
            #add-point:ON ACTION controlp INFIELD l_apca011 name="construct.c.l_apca011"
            #160816-00022#2 add --s
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET l_ooef019 = ''
            SELECT ooef019 INTO l_ooef019 FROM ooef_t   #稅區
             WHERE ooefent = g_enterprise AND ooef001 IN (SELECT ooef017 FROM ooef_t 
                                                           WHERE ooefent = g_enterprise AND ooef001 = g_master.apcasite)
            LET g_qryparam.arg1 = l_ooef019
            IF g_sfin3012 = '1' THEN   #不含稅
               LET g_qryparam.where = " oodb004 ='1' AND oodb008 IN ('2','3') "
            ELSE
               LET g_qryparam.where = " oodb004 ='1' "
            END IF
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO l_apca011  #顯示到畫面上
            NEXT FIELD l_apca011
            #160816-00022#2 add --e
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc2 ON pmdl002,pmdl003 
	         ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl002  #顯示到畫面上
               NEXT FIELD pmdl002                     #返回原欄位

            ON ACTION controlp INFIELD pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl003  #顯示到畫面上
               NEXT FIELD pmdl003                     #返回原欄位
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
            CALL aapp131_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL cl_progress_no_window_ing('')   #160623-00007#1
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
            #150127-00007#1
            CALL aapp131_qbe_clear() RETURNING l_apcacomp
            CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add 
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#2 add 原傳入g_apcacomp 僅被定義,實際為空值,改傳入前fun重取的comp
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark 
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
         CALL aapp131_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET g_master.wc = cl_replace_str(g_master.wc,"l_apca011","apca011")   #160816-00022#2 將wc:l_apca011，取代為apca011去串 
      LET lc_param.wc = g_master.wc," AND ",g_wc2
      LET lc_param.apcasite  = g_master.apcasite    
      LET lc_param.apcald    = g_master.apcald    
      LET lc_param.apca011   = g_master.apca011   
      LET lc_param.apca008   = g_master.apca008   
      LET lc_param.rate1     = g_master.rate1     
      LET lc_param.sel2      = g_master.sel2      
      LET lc_param.slip1     = g_master.slip1     
      LET lc_param.apca007   = g_master.apca007   
      LET lc_param.apcadocdt = g_master.apcadocdt
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
                 CALL aapp131_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp131_transfer_argv(ls_js)
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
 
{<section id="aapp131.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp131_transfer_argv(ls_js)
 
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
 
{<section id="aapp131.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp131_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_ld_type    LIKE type_t.chr1    #主帳輔帳
   DEFINE l_field      DYNAMIC ARRAY OF RECORD
                        f11       LIKE type_t.chr100,
                        f21       LIKE type_t.chr100
                       END RECORD
   DEFINE l_wc         STRING
   DEFINE r_success    LIKE type_t.num5
   DEFINE p_slip1type  LIKE type_t.chr1
   DEFINE l_strno      LIKE apca_t.apcadocno
   DEFINE l_endno      LIKE apca_t.apcadocno
   DEFINE l_tmp        RECORD 
              pmdsent        LIKE pmds_t.pmdsent,
              pmdsdocdt      LIKE pmds_t.pmdsdocdt,  #單據日期
              pmds000        LIKE pmds_t.pmds000,    #單據性質(6:入庫/5:驗退/7:倉退)
              pmds007        LIKE pmds_t.pmds007,    #採購供應商(*)
              pmds008        LIKE pmds_t.pmds008,    #帳款供應商
              pmds031        LIKE pmds_t.pmds031,    #付款條件(*)
              pmds033        LIKE pmds_t.pmds033,    #稅別(*)
              pmds037        LIKE pmds_t.pmds037,    #幣別(*)
              pmds038        LIKE pmds_t.pmds038,    #匯率(*)
              pmdtsite       LIKE pmdt_t.pmdtsite,   #營運據點
              pmdtdocno      LIKE pmdt_t.pmdtdocno,  #入庫/倉退/驗退單號(*)
              pmdtseq        LIKE pmdt_t.pmdtseq,    #入庫項次
              pmdt001        LIKE pmdt_t.pmdt001,    #來源單號
              pmdt006        LIKE pmdt_t.pmdt006,    #料件編號
              pmdt019        LIKE pmdt_t.pmdt019,    #入庫單位
              pmdt024        LIKE pmdt_t.pmdt024,    #計價數量
              pmdldocno      LIKE pmdl_t.pmdldocno,  #採購單號
              pmdl002        LIKE pmdl_t.pmdl002,    #採購單-採購人員
              pmdl003        LIKE pmdl_t.pmdl003,    #採購單-採購部門
              apcb007        LIKE apcb_t.apcb007,    #可立帳數量      
              apbb050        LIKE apbb_t.apbb050,    #發票性質(*)
              apca007        LIKE apca_t.apca007,    #帳款類別
              cond1          LIKE type_t.chr500,     #彙總條件
              apba005        LIKE apba_t.apba005,    #參考單號
              apba006        LIKE apba_t.apba006,    #參考項次
              pmds028        LIKE pmds_t.pmds028     #一次性交易對象   #160802-00007#2
                       END RECORD
   DEFINE l_month       LIKE type_t.num5              #做日期條件用
   DEFINE l_year        LIKE type_t.num5              #做日期條件用
   DEFINE l_strdat      LIKE type_t.dat               #做日期條件用
   DEFINE l_enddat      LIKE type_t.dat               #做日期條件用
   DEFINE l_apca035     LIKE apca_t.apca035           #接沒有用到的參數用
   DEFINE l_apca036     LIKE apca_t.apca036           #接沒有用到的參數用
   DEFINE l_apca058     LIKE apca_t.apca058           #接沒有用到的參數用
   DEFINE l_desc        LIKE type_t.chr500            #接沒有用到的參數用
   DEFINE l_apca011     LIKE apca_t.apca011           #接沒有用到的參數用
   DEFINE l_apca014     LIKE apca_t.apca014           #接沒有用到的參數用
   DEFINE l_apca008     LIKE apca_t.apca008           #接沒有用到的參數用
   DEFINE l_glaa001     LIKE glaa_t.glaa001           #帳別資料
   DEFINE l_apcacomp    LIKE ooef_t.ooef001           #帳別資料
   DEFINE l_cnt         LIKE type_t.num5              
   DEFINE l_pmdtcomp    LIKE apca_t.apcacomp          #入庫單據點所屬法人   
   DEFINE l_pmdtld      LIKE apca_t.apcald            #入庫單據點帳套 
   DEFINE l_pmds000_str1 STRING   #150702-00001#1 add   
   DEFINE l_pmds011_str1 STRING   #160530-00005#3
   DEFINE lc_param_apca RECORD
            type        LIKE type_t.chr1,     #類型(1:p131/2:p132/3:p133)
            sel1        LIKE type_t.chr1,     #立帳方式
            sel2        LIKE type_t.chr1,     #彙總方式
            slip        LIKE apca_t.apcadocno,#單別
            site        LIKE apca_t.apcasite, #帳務中心
            ld          LIKE apca_t.apcald,   #帳套
            wc2         STRING,               #沖銷類型
            bgjob       LIKE type_t.chr1,     #是否背景執行
            apca063     LIKE apca_t.apca063   #整帳批序號
                    END RECORD
   DEFINE lc_param_rate RECORD
            type        LIKE type_t.chr1,       #類型
            apca004     LIKE apca_t.apca004,    #交易對象
            sfin2009    LIKE type_t.chr1        #匯率類型   #151012-00014#2
#            docno       LIKE apca_t.apcadocno   #單號      #151012-00014#2-mark
                    END RECORD
   DEFINE l_pmab057     LIKE pmab_t.pmab057
   DEFINE l_where      STRING     #160325-00023#1
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
       LET g_master.apca011   = lc_param.apca011
       LET g_master.apca008   = lc_param.apca008
       LET g_master.rate1     = lc_param.rate1
       LET g_master.sel2      = lc_param.sel2
       LET g_master.slip1     = lc_param.slip1
       LET g_master.apca007   = lc_param.apca007
       LET g_master.apcadocdt = lc_param.apcadocdt
       LET g_wc2 = " 1=1"
       CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_master.apcadocdt,'1')
       CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
       CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
       CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
    END IF
   
   #檢核單別是否該帳套可以使用
   IF NOT cl_null(g_master.slip1)THEN
      CALL s_fin_slip_chk(g_master.slip1,'aapt320',g_master.apcald,'D-FIN-3001') RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET g_master.slip1 = ''
         LET g_master.l_slip1_desc = ''
         LET g_master.slip1type = ''
         DISPLAY BY NAME g_master.slip1,g_master.l_slip1_desc,g_master.slip1type
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
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
#  DECLARE aapp131_process_cs CURSOR FROM ls_sql
#  FOREACH aapp131_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   #依QBE條件建立temptable
   ########################################################################
   #單別不綁性質, 所以可以一張暫估單的單別，去產生 01/02性質的單據。
   #對aapp131的產生原則，仍是入庫單及倉退單別分產生帳款單, 性質也分別是對應到 01、02
   #但可以是使用同一個單別
   ########################################################################   
   
   DELETE FROM s_aapp131_tmp_g
   CALL s_fin_get_ld_type(g_master.apcald) RETURNING l_ld_type
   IF l_ld_type = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00301'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      CALL cl_err_collect_show()
      RETURN
   END IF
   LET l_wc =  g_master.wc CLIPPED
   IF cl_null(l_wc)THEN LET l_wc = ' 1=1' END IF
   LET l_wc = l_wc CLIPPED, " AND pmdssite IN ",g_wc_apcasite
   CALL s_ld_sel_glaa(g_master.apcald,'glaa001|glaacomp') RETURNING  g_sub_success,l_glaa001,l_apcacomp 
   CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#2 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark
   IF NOT cl_null(g_master.apcadocdt) THEN   #160114-00019#4   
      #150210apo--(s)
      #依年度+期別取得會計週期起迄日  #追加日期條件  
      CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e   
      LET l_wc = l_wc CLIPPED," AND pmds001 BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' "              
      #150210apo--(e)             
   END IF         #160114-00019#4
   LET l_field[1].f11 = "pmdt056"   LET l_field[2].f11 = "pmdt057"   LET l_field[3].f11 = "pmdt058"   #請款數量
   LET l_field[1].f21 = "pmdt066"   LET l_field[2].f21 = "pmdt067"   LET l_field[3].f21 = "pmdt068"   #暫估數量 
  
   #150702-00001#1-----s
   LET l_pmds000_str1 = s_aap_get_acc_str('2060',"gzcb003 = 'Y'")
   LET l_pmds000_str1 = s_fin_get_wc_str(l_pmds000_str1)  
   #150702-00001#1-----e
   #160530-00005#3--S
   LET l_pmds011_str1 = s_aap_get_acc_str('2061',"gzcb003 = 'Y'")
   LET l_pmds011_str1 = s_fin_get_wc_str(l_pmds011_str1)     
   #160530-00005#3--E
  
   #抓取資料條件和q_pmdtdocno_4盡量一致
   #可選取的資料才會跟預期的資料相同
   #可立暫估數量 = 計價數量 - 已立帳數量 - 已立暫估數量
   IF g_wc2 = " 1=1" THEN  #表示不需要join採購單欄位
      LET ls_sql ="SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
                  "       pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,pmdt024, ",
                  "       pmdldocno,pmdl002,pmdl003,pmdt024,'','','','','' ",
                  "      ,pmds028 ",    #160802-00007#2                  
                  "  FROM (",
                  "       SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
                  "              pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019, ",
                  "              COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) - COALESCE(",l_field[l_ld_type].f21,",0) pmdt024, ",
                  "              pmdldocno,pmdl002,pmdl003,pmds011 ",   #160530-00005#3 add pmds011
                  "             ,pmds028 ",   #160802-00007#2
                  "         FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
                  "        WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = ? ", 
                  "          AND pmdsdocno = pmdtdocno ",
                  #"          AND pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15','17','18','19','20') ",  #150702-00001#1 mark #150629-00038#1  add 17~20             #pmds000:SCC-2060
                  "          AND pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
                  "          AND pmds011 IN ",l_pmds011_str1 CLIPPED,   #160530-00005#3
                  "          AND pmdsstus = 'S' ",  #只抓入庫/且過帳
                  "          AND ",l_wc CLIPPED,") ",
                  "  WHERE pmdt024 > 0 "            
   ELSE
      LET ls_sql ="SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
                  "       pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,pmdt024, ",
                  "       pmdldocno,pmdl002,pmdl003,pmdt024,'','','','','' ", 
                  "      ,pmds028 ",    #160802-00007#2      
                  "  FROM (",
                  "       SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
                  "              pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019, ",
                  "              COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) - COALESCE(",l_field[l_ld_type].f21,",0) pmdt024, ",
                  "              pmdldocno,pmdl002,pmdl003,pmds011 ",   #160530-00005#3 add pmds011
                  "             ,pmds028 ",    #160802-00007#2      
                  "         FROM pmds_t,pmdt_t,pmdl_t  ",
                  "        WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = ", g_enterprise,
                  "          AND pmdsdocno = pmdtdocno AND pmdldocno = pmdt001",
                  #"          AND pmdsstus = 'S' AND pmds000 IN ('3','12','5','6','7','10','11','13','14','15','17','18','19','20') ",#150702-00001#1 mark  #150629-00038#1 add 17~20           #pmds000:SCC-2060 只抓入庫/且過帳
                  "          AND pmdsstus = 'S' AND pmds000 IN ",l_pmds000_str1 CLIPPED,   #150702-00001#1 add
                  "          AND pmds011 IN ",l_pmds011_str1 CLIPPED,                      #160530-00005#3
                  "          AND ",l_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                  "       ) ",
                  "  WHERE pmdt024 > 0 "    
   END IF
   #151231-00010#6(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_sql = ls_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                          "              WHERE pmaaent = ",g_enterprise,
                          "                AND ",g_sql_ctrl,
                          "                AND pmaaent = pmdsent ",
                          "                AND pmaa001 = pmds008 )"
   END IF
   #151231-00010#6(E)   
   #160325-00023#1 ---s---
   CALL s_aooi210_get_check_sql(g_master.apcasite,'',g_master.slip1,'4','','pmdtdocno') RETURNING g_sub_success,l_where   
   LET ls_sql = ls_sql CLIPPED," AND ",l_where 
   #160325-00023#1 ---e---
   
   PREPARE sel_aapp131_tmpp1 FROM ls_sql
   DECLARE sel_aapp131_tmpc1 CURSOR FOR sel_aapp131_tmpp1

   ##########################################################################################
   #一些會取代掉的預設值會在這邊給入
   #若符合不可產生帳款單的單據，會在此利用CONTINUE FOREACH 跳過INSERT TEMP的部分
   #拆單條件若無值會給一個空白或定值以免SQL失敗少抓到資料
   ##########################################################################################
   
   FOREACH sel_aapp131_tmpc1 USING g_enterprise INTO l_tmp.*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      #入庫單所屬法人與帳套所屬法人不同者剔除
      CALL s_fin_orga_get_comp_ld(l_tmp.pmdtsite) RETURNING g_sub_success,g_errno,l_pmdtcomp,l_pmdtld
      IF l_pmdtcomp <> l_apcacomp THEN
         CONTINUE FOREACH
      END IF      
      #有輸入帳款類別用輸入的帳款類別
      IF NOT cl_null(g_master.apca007)THEN
         LET l_tmp.apca007 = g_master.apca007
      ELSE
         CALL s_apmm101_sel_pmab(l_apcacomp,l_tmp.pmds007,'pmab055') RETURNING g_sub_success,g_errno,l_tmp.apca007
      END IF
      IF cl_null(l_tmp.apca007)THEN LET l_tmp.apca007 = ' ' END IF
      
      #立帳日期
      IF NOT cl_null(g_master.apcadocdt) THEN LET l_tmp.pmdsdocdt = g_master.apcadocdt END IF  
      
      #稅別
      #IF NOT cl_null(g_master.apca011)THEN LET l_tmp.pmds033 = g_master.apca011 END IF #160816-00022#2 mark 
      
      #160816-00022#2 add --s
      #如有設定稅別，則使用該稅別寫入
      CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012
      IF g_sfin3012 <> '2' THEN 
         IF NOT cl_null(g_master.apca011)THEN LET l_tmp.pmds033 = g_master.apca011 END IF
      END IF
      #160816-00022#2 add --e

      #付款條件
      IF NOT cl_null(g_master.apca008)THEN LET l_tmp.pmds031 = g_master.apca008 END IF  
      
      #151012-00014#2-----s
      #改用參數判斷，帶出採用日/月平均匯率的預設值
      IF g_master.rate1 MATCHES '[23]' THEN 
         LET l_tmp.pmds038 = ''
         LET lc_param_rate.type = '1'
         LET lc_param_rate.apca004 = l_tmp.pmds007
         LET lc_param_rate.sfin2009 = g_master.rate1 
         LET ls_js = util.JSON.stringify(lc_param_rate)
         CALL s_fin_get_curr_rate(l_apcacomp,g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,ls_js)
              RETURNING l_tmp.pmds038,l_desc,l_desc
      END IF  
      
      #--(mark)-s      
#      #匯率取用原則
#      CASE
#         WHEN g_master.rate1 = '1'
#            #依原單
#         WHEN g_master.rate1 = '2'
#            #依立帳日匯率
#            LET l_tmp.pmds038 = ''
#            LET lc_param_rate.type = '1'
#            LET lc_param_rate.apca004 = l_tmp.pmds007
#            LET ls_js = util.JSON.stringify(lc_param_rate)
#            CALL s_fin_get_curr_rate(l_apcacomp,g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,ls_js)
#                 RETURNING l_tmp.pmds038,l_desc,l_desc
#            IF cl_null(l_tmp.pmds038) OR l_tmp.pmds038 = 0 THEN
#               CONTINUE FOREACH   
#            END IF      
#           #150727--Mark--(S)
#           #CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0014') RETURNING l_desc
#           #CALL s_aooi160_get_exrate('2',g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,l_glaa001,0,l_desc)
#           #   RETURNING l_tmp.pmds038
#           ##是否無維護匯率的暫解，之後有更好的方法應該要修正 albireo 141008
#           #IF g_errparam.code = 'sub-00213' THEN
#           #   CONTINUE FOREACH   
#           #END IF      
#           #150727--Mark--(E)
#         WHEN g_master.rate1 = '3'
#            #依立帳日月平均匯率   
#            #aooi170
#            #CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0014') RETURNING l_desc
#            CALL s_apmm101_sel_pmab(l_apcacomp,l_tmp.pmds007,'pmab057') RETURNING g_sub_success,g_errno,l_pmab057
#               IF l_pmab057 = '1' THEN
#                  CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0014') RETURNING l_desc
#               ELSE
#                  CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0015') RETURNING l_desc
#               END IF
#            CALL s_aooi160_get_exrate_avg('2',g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,l_glaa001,0,l_desc)
#                    RETURNING g_sub_success,g_errno,l_tmp.pmds038
#            IF NOT g_sub_success THEN
#               CONTINUE FOREACH
#            END IF
#      END CASE
      #--(mark)-e
      #151012-00014#2-----e
      
      #不產生帳款的檢查(1:稅別 2:付款條件 3:原單無匯率)
      IF cl_null(l_tmp.pmds033) THEN
         CONTINUE FOREACH
      END IF      
      IF cl_null(l_tmp.pmds031)THEN #如果無付款條件 影響多帳期產生
         CONTINUE FOREACH
      END IF
      IF g_master.rate1 = '1' AND cl_null(l_tmp.pmds038) THEN
         CONTINUE FOREACH
      END IF
      #處理拆單條件
      CASE
         WHEN g_master.sel2 = '1'
            LET l_tmp.cond1 = l_tmp.pmds007
         WHEN g_master.sel2 = '2'
            LET l_tmp.cond1 = l_tmp.pmdtdocno
         WHEN g_master.sel2 = '3'
            LET l_tmp.cond1 = l_tmp.pmdldocno
         WHEN g_master.sel2 = '4'
            LET l_tmp.cond1 = l_tmp.pmdl002
         WHEN g_master.sel2 = '5'
            LET l_tmp.cond1 = l_tmp.pmdl003
         WHEN g_master.sel2 = '6'
            LET l_tmp.cond1 = l_tmp.pmdt006
      END CASE
      
      #INSERT INTO s_aapp131_tmp_g VALUES(l_tmp.*)  #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO s_aapp131_tmp_g (pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,
                                   pmds031,pmds033,pmds037,pmds038,pmdtsite,
                                   pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,
                                   pmdt024,pmdldocno,pmdl002,pmdl003,apcb007,
                                   apbb050,apca007,cond1,apba005,apba006,
                                   pmds028                                   #160802-00007#2      
                                   )
      VALUES (l_tmp.pmdsent,l_tmp.pmdsdocdt,l_tmp.pmds000,l_tmp.pmds007,l_tmp.pmds008,
              l_tmp.pmds031,l_tmp.pmds033,l_tmp.pmds037,l_tmp.pmds038,l_tmp.pmdtsite,
              l_tmp.pmdtdocno,l_tmp.pmdtseq,l_tmp.pmdt001,l_tmp.pmdt006,l_tmp.pmdt019,
              l_tmp.pmdt024,l_tmp.pmdldocno,l_tmp.pmdl002,l_tmp.pmdl003,l_tmp.apcb007,
              l_tmp.apbb050,l_tmp.apca007,l_tmp.cond1,l_tmp.apba005,l_tmp.apba006,
              l_tmp.pmds028                                                   #160802-00007#2      
              )
      #161108-00017#1 add end---
   END FOREACH
   CALL s_transaction_end('Y',0)   #150126-00012#1 
   #計算迴圈筆數
   SELECT COUNT(*) INTO li_count
     FROM s_aapp131_tmp_g
   
   IF li_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'  #150210apo
      LET g_errparam.extend = ''         #150210apo
      LET g_errparam.popup = FALSE
      CALL cl_err()  
   ELSE
      LET lc_param_apca.type   = '1'
      LET lc_param_apca.sel1   = ''
      LET lc_param_apca.sel2   = g_master.sel2
      LET lc_param_apca.slip   = g_master.slip1
      LET lc_param_apca.site   = g_master.apcasite
      LET lc_param_apca.ld     = g_master.apcald
      LET lc_param_apca.bgjob  = g_bgjob
      LET ls_js = util.JSON.stringify(lc_param_apca)
      CALL s_aapp131_ins_apca(ls_js) RETURNING g_sub_success,l_strno,l_endno
      IF g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00251'
         LET g_errparam.replace[1] = l_strno
         LET g_errparam.replace[2] = l_endno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00187'   #單據產生失敗
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()   
         DISPLAY '' ,0 TO stagenow,stagecomplete
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
      #背景作業怎麼串先不寫albireo 141007
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aapp131_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp131.get_buffer" >}
PRIVATE FUNCTION aapp131_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
   LET g_master.slip1 = p_dialog.getFieldBuffer('slip1')
   LET g_master.apca007 = p_dialog.getFieldBuffer('apca007')
   LET g_master.apcadocdt = p_dialog.getFieldBuffer('apcadocdt')
   LET g_master.apca011 = p_dialog.getFieldBuffer('apca011')
   LET g_master.apca008 = p_dialog.getFieldBuffer('apca008')
   LET g_master.rate1 = p_dialog.getFieldBuffer('rate1')
   LET g_master.sel2 = p_dialog.getFieldBuffer('sel2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp131.msgcentre_notify" >}
PRIVATE FUNCTION aapp131_msgcentre_notify()
 
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
 
{<section id="aapp131.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp131_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp131_qbe_clear()
DEFINE l_apcacomp    LIKE ooef_t.ooef001
DEFINE l_sfin3009    LIKE type_t.chr1    #151012-00014#2
   
   WHENEVER ERROR CONTINUE
   INITIALIZE g_master.* TO NULL
   
   LET g_master.sel2 = '1'   #彙總方式
   LET g_master.rate1= '1'
   LET g_master.apcadocdt = g_today

   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apcasite,g_master.apcald,l_apcacomp
   CALL s_fin_get_wc_str(l_apcacomp) RETURNING g_comp_str #161229-00047#2 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#2 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',l_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#2 mark
   IF g_sub_success THEN
      CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
      CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
      CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
      CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
      CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
      LET g_master.l_apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
      LET g_master.l_apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
      IF NOT cl_null(l_apcacomp) THEN
        #CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2010') RETURNING g_master.apca011   #稅額預設值
        #CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2011') RETURNING g_sfin2011         #暫估迴轉否(Y:迴轉/N:不迴轉)
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3010') RETURNING g_master.apca011   #稅額預設值
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3011') RETURNING g_sfin2011         #暫估迴轉否(Y:迴轉/N:不迴轉)
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012         #應付暫估立帳選項
         CALL aapp131_single_tax_chk(l_apcacomp,l_apcacomp,g_master.apca011) RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            LET g_master.apca011 = ''
         END IF
         #不回转的话，暂估立税一定是要不含税立账的(如果是不迴轉 就不考慮暫估立帳參數
        #IF g_sfin2011 = 'N' THEN LET g_sfin3012 = '1' END IF   #160621-00026#1 mark
        
         #160816-00022#2 add --s
         #若aoos020(s-fin-3012)為2.含稅立暫估,則選項框稅別隱藏,要依入庫單稅別立暫估
         CALL cl_set_comp_visible("lbl_apca011,apca011,l_apca011_desc",TRUE)
         IF g_sfin3012 = '2' THEN 
            CALL cl_set_comp_visible("lbl_apca011,apca011,l_apca011_desc",FALSE)
         END IF
         #160816-00022#2 add --e
        
      END IF
      LET g_master_o.apcasite = g_master.apcasite
   END IF
   IF NOT cl_null(g_master.apcadocdt) THEN #160114-00019#4
      #依年度+期別取得會計週期起迄日
      CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e 
      IF cl_null(g_pdate_s) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'agl-00211'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_pdate_s = g_today
      END IF
   END IF  #160114-00019#4

   #151012-00014#2-----s
   #依畫面上帳套所屬法人取S-FIN-3009預設匯率選項
   CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3009') RETURNING l_sfin3009
   CASE l_sfin3009
         WHEN '1'  #依立帳日匯率(aooi160)
            LET g_master.rate1 = '2'
         WHEN '2'  #依立帳日月平均匯率(aooi170)
            LET g_master.rate1 = '3'
   END CASE
   #151012-00014#2-----e
   
   DISPLAY BY NAME g_master.sel2,g_master.rate1,g_master.apca011,
                   g_master.apcald,g_master.apcasite,g_master.apcadocdt,
                   g_master.l_apcald_desc,g_master.l_apcasite_desc
                   
   RETURN l_apcacomp
END FUNCTION

################################################################################
# Descriptions...: 檢核是否為單一稅
# Memo...........:
# Date & Author..: 15/05/21 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp131_single_tax_chk(p_ooef001,p_ooef017,p_apca011)
DEFINE p_ooef001     LIKE ooef_t.ooef001
DEFINE p_ooef017     LIKE ooef_t.ooef017
DEFINE p_apca011     LIKE apca_t.apca011
DEFINE l_ooef019     LIKE ooef_t.ooef019
DEFINE l_oodb004     LIKE oodb_t.oodb004
DEFINE l_oodb008     LIKE oodb_t.oodb008
DEFINE l_apca012     LIKE apca_t.apca012
DEFINE l_apca013     LIKE apca_t.apca013
DEFINE l_oodb011     LIKE oodb_t.oodb011
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   CALL s_tax_get_ooef019(p_ooef001) RETURNING g_sub_success,l_ooef019
   IF cl_null(p_apca011) THEN
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
   CALL s_tax_chk(p_ooef017,p_apca011) 
        RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
   IF NOT g_sub_success THEN
      RETURN r_success,r_errno
   END IF
   LET l_oodb004 = NULL
   LET l_oodb008 = NULL
   SELECT oodb004,oodb008 INTO l_oodb004,l_oodb008
     FROM oodb_t
    WHERE oodbent  = g_enterprise AND oodb001  = l_ooef019
      AND oodb002  = p_apca011
   IF l_oodb004 <> '1' THEN   #非單一稅率
      RETURN r_success,r_errno
   END IF
            
   IF g_sfin3012 = '1' THEN
      IF NOT l_oodb008 MATCHES '[23]' THEN
         RETURN r_success,r_errno
      END IF
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

#end add-point
 
{</section>}
 
