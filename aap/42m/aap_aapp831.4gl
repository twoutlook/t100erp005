#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp831.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-01-04 11:28:57), PR版次:0003(2016-11-08 17:30:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapp831
#+ Description: 結算底稿暫估批處理作業(零售)
#+ Creator....: 02114(2015-12-07 13:55:44)
#+ Modifier...: 02114 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp831.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150126-00012#1  2015/01/26 By apo      transaction移至s_aapp831,以達成單筆commit
#15210apo        2015/02/10 By apo      以畫面上立帳日期取對應會計週期期別之起始日與立帳日期,作為入庫單之日期範圍限制
#150127-00007#1  2015/02/24 By Reanna   掃把清空&給預設值
#150629-00038#1  2015/06/30 By albireo  入庫單性質增加20委外採購入庫   17~19 借貨相關
#150702-00001#1  2015/07/03 By albireo  入庫單性質改動態抓取
#151012-00014#2  2015/10/14 By Jessy    帶入日/月平均匯率預設值，依aoos020(S-FIN-3009)設定
#160321-00016#20 2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息
#161006-00005#7  2016/10/12 By 08732    組織類型與職能開窗調整
#161108-00017#1  2016/11/08 By Reanna   程式中INSERT INTO 有星號作整批調整
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
         slip2          LIKE apca_t.apcadocno,
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
   slip2 LIKE type_t.chr500, 
   l_slip2_desc LIKE type_t.chr80, 
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
   stbc002 LIKE stbc_t.stbc002, 
   stbc004 LIKE stbc_t.stbc004, 
   stbc025 LIKE stbc_t.stbc025, 
   stbc009 LIKE stbc_t.stbc009, 
   pmdl002 LIKE pmdl_t.pmdl002, 
   pmdl003 LIKE pmdl_t.pmdl003, 
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
DEFINE g_ooaa002        LIKE ooaa_t.ooaa002
DEFINE g_dfin3500       LIKE ooac_t.ooac004      #20150624 add lujh 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp831.main" >}
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
   #20151202--add--str--lujh
   IF NOT cl_null(g_argv[01]) THEN
      LET g_bgjob = g_argv[01]
   END IF
   #20151202--add--end--lujh
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aapp831_cre_tmp()
      CALL s_fin_create_account_center_tmp()    #帳務中心
      CALL s_aap_create_multi_bill_perod_tmp()  #多帳期
      
      #20151202--add--str--lujh
      LET g_master.wc        = g_argv[02]
      LET g_master.apcasite  = g_argv[03]
      LET g_master.apcald    = g_argv[04]
      LET g_master.apca011   = g_argv[05]
      LET g_master.apca008   = g_argv[06]
      LET g_master.rate1     = g_argv[07]
      LET g_master.sel2      = g_argv[08]
      LET g_master.slip1     = g_argv[09]
      LET g_master.slip2     = g_argv[10]
      LET g_master.apca007   = g_argv[11]
      LET g_master.apcadocdt = g_argv[12]
      LET g_wc2 = " 1=1"
      CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_master.apcadocdt,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
      CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
      CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
      #20151102--add--end--lujh
      #end add-point
      CALL aapp831_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp831 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp831_init()
 
      #進入選單 Menu (="N")
      CALL aapp831_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp831
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp831.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp831_init()
 
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
   CALL s_aapp831_cre_tmp()
   CALL s_fin_create_account_center_tmp()    #帳務中心
   CALL s_aap_create_multi_bill_perod_tmp()  #多帳期
   CALL cl_set_combo_scc_part("sel2","8527","1,2,3,4,5,6")
   CALL cl_set_combo_scc("rate1","9951")
   #2015/6/23--by--02599--add--str--
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING g_ooaa002
   IF cl_null(g_ooaa002) THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "cxr-00001"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   #2015/6/23--by--02599--add--end
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp831.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp831_ui_dialog()
 
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

   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150127-00007#1
   CALL aapp831_qbe_clear() RETURNING l_apcacomp
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald,g_master.slip1,g_master.slip2,g_master.apca007, 
             g_master.apcadocdt,g_master.apca011,g_master.apca008,g_master.rate1,g_master.sel2 
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
            END IF 
            LET g_master.l_apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
            DISPLAY BY NAME g_master.l_apcasite_desc
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
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) 
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
               CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2010') RETURNING g_master.apca011   #稅額預設值
               CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012         #應付暫估立帳選項
               CALL aapp831_single_tax_chk(l_apcacomp,l_apcacomp,g_master.apca011) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  LET g_master.apca011 = ''
               END IF
               #不回转的话，暂估立税一定是要不含税立账的(如果是不迴轉 就不考慮暫估立帳參數
               IF g_sfin2011 = 'N' THEN LET g_sfin3012 = '1' END IF      
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
               DISPLAY BY NAME g_master.apca011
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
               CALL s_fin_slip_chk(g_master.slip1,'aapt820',g_master.apcald,'D-FIN-3001') RETURNING g_sub_success,g_errno
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

               #20150624--add--str--lujh
               CALL s_fin_get_doc_para(g_master.apcald,'',g_master.slip1,'D-FIN-3500') RETURNING g_dfin3500
               
               IF g_dfin3500 <> 'Y' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_master.slip1
                  LET g_errparam.code   = "aap-00412"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_master.slip1 = ''
                  NEXT FIELD slip1
               END IF
               #20150624--add--end--lujh
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
         AFTER FIELD slip2
            
            #add-point:AFTER FIELD slip2 name="input.a.slip2"
            #20150624--add--str--lujh
            LET g_master.l_slip2_desc = ''
            DISPLAY BY NAME g_master.l_slip2_desc
            IF NOT cl_null(g_master.slip2)THEN
               CALL s_fin_slip_chk(g_master.slip2,'aapt820',g_master.apcald,'D-FIN-3001') RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_slip2_desc = ''
                  DISPLAY BY NAME g_master.l_slip2_desc
                  NEXT FIELD CURRENT
               END IF

               CALL s_fin_get_doc_para(g_master.apcald,'',g_master.slip2,'D-FIN-3500') RETURNING g_dfin3500
               
               IF g_dfin3500 <> 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_master.slip2
                  LET g_errparam.code   = "aap-00413"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_master.slip2 = ''
                  NEXT FIELD slip2
               END IF
               
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.slip2)RETURNING g_master.l_slip2_desc
            DISPLAY BY NAME g_master.slip2,g_master.l_slip2_desc
            #20150624--add--end--lujh

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD slip2
            #add-point:BEFORE FIELD slip2 name="input.b.slip2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE slip2
            #add-point:ON CHANGE slip2 name="input.g.slip2"
            
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
            #150210apo--(s)
            #依年度+期別取得會計週期起迄日
            CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
            RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                      l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e   
            #150210apo--(e)     
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
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD apca011
                  END IF
                  IF g_sfin3012 = '1' THEN
                     IF NOT l_oodb008 MATCHES '[23]' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aap-00182'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
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
                  #160321-00016#20 --s add
                  LET g_errparam.replace[1] = 'aooi716'
                  LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi716'
                  #160321-00016#20 --e add
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
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite       
            #CALL q_ooef001()      #161006-00005#7   mark
            CALL q_ooef001_46()    #161006-00005#7   add                              
            LET g_master.apcasite = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.l_apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.l_apcasite_desc 
            NEXT FIELD apcasite
            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald                    
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald  #glaa008(平行記帳)/glaa014(主帳套)
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
            LET g_qryparam.arg2 = 'aapt820'
            #20150624--add--str--lujh
            LET g_qryparam.arg3 = 'D-FIN-3500'
            LET g_qryparam.arg4 = "'Y'"
            #20150624--add--end--lujh
            
            #CALL q_ooba002_1()       #20150624 mark lujh     
            CALL q_ooba002_11()       #20150624 add  lujh    
            
            LET g_master.slip1 = g_qryparam.return1              
            CALL s_aooi200_fin_get_slip_desc(g_master.slip1)RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.slip1,g_master.l_slip1_desc
            NEXT FIELD slip1
            #END add-point
 
 
         #Ctrlp:input.c.slip2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD slip2
            #add-point:ON ACTION controlp INFIELD slip2 name="input.c.slip2"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.slip2
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'aapt820'
            LET g_qryparam.arg3 = 'D-FIN-3500'
            LET g_qryparam.arg4 = "'N'"
            CALL q_ooba002_11()        
            
            LET g_master.slip2 = g_qryparam.return1              
            CALL s_aooi200_fin_get_slip_desc(g_master.slip2)RETURNING g_master.l_slip2_desc
            DISPLAY BY NAME g_master.slip2,g_master.l_slip2_desc
            NEXT FIELD slip2
            #END add-point
 
 
         #Ctrlp:input.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca007
            LET g_qryparam.arg1 = "3211"
            CALL q_oocq002()
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
         CONSTRUCT BY NAME g_master.wc ON pmds007,stbc002,stbc004,stbc025,stbc009
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmds007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmds007
            #add-point:ON ACTION controlp INFIELD pmds007 name="construct.c.pmds007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
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
         BEFORE FIELD stbc002
            #add-point:BEFORE FIELD stbc002 name="construct.b.stbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc002
            
            #add-point:AFTER FIELD stbc002 name="construct.a.stbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc002
            #add-point:ON ACTION controlp INFIELD stbc002 name="construct.c.stbc002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc004
            #add-point:ON ACTION controlp INFIELD stbc004 name="construct.c.stbc004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            #20150804--add--str--lujh
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
            CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
            CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " stbc003 IN ('1','2','3','4','8','A','B','11') ",    #20150826 add '4' lujh    #20150901 remove '3' lujh  #20150909 add '3' lujh  #20151102 remove '3' lujh   #20151104 add '3' lujh
                                   " AND stbc038 = 'Y' ",                                #20150909 add lujh
                                   " AND stbcsite IN ",g_wc_apcasite,
                                   " AND (ABS(stbc034)-ABS(COALESCE(stbc035,0))-ABS(COALESCE(stbc054,0))) > 0 ",
#mark by chenhz 15/10/09           " AND stbc002 BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"'"   ,
                                   " AND stbc002 <= '",g_master.apcadocdt,"'"   #add by chenhz 15/10/09  单据编号开窗开出小于立账日期的单据
            #CALL q_stbc003()                           #呼叫開窗   #20150909 mark lujh
            CALL q_stbc004()                                      #20150909 add lujh
            DISPLAY g_qryparam.return1 TO stbc004  #顯示到畫面上
            NEXT FIELD stbc004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc004
            #add-point:BEFORE FIELD stbc004 name="construct.b.stbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc004
            
            #add-point:AFTER FIELD stbc004 name="construct.a.stbc004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc025
            #add-point:BEFORE FIELD stbc025 name="construct.b.stbc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc025
            
            #add-point:AFTER FIELD stbc025 name="construct.a.stbc025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc025
            #add-point:ON ACTION controlp INFIELD stbc025 name="construct.c.stbc025"
            #20150804--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_ooaa002
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc025        #顯示到畫面上
            NEXT FIELD stbc025                           #返回原欄位
            #20150804--add--end--lujh
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbc009
            #add-point:BEFORE FIELD stbc009 name="construct.b.stbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbc009
            
            #add-point:AFTER FIELD stbc009 name="construct.a.stbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbc009
            #add-point:ON ACTION controlp INFIELD stbc009 name="construct.c.stbc009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6013'
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stbc009  #顯示到畫面上
            NEXT FIELD stbc009                     #返回原欄位
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
            CALL aapp831_get_buffer(l_dialog)
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
            #150127-00007#1
            CALL aapp831_qbe_clear() RETURNING l_apcacomp
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
         CALL aapp831_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
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
                 CALL aapp831_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp831_transfer_argv(ls_js)
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
 
{<section id="aapp831.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp831_transfer_argv(ls_js)
 
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
 
{<section id="aapp831.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp831_process(ls_js)
 
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
              apba006        LIKE apba_t.apba006     #參考項次
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
   
   DEFINE l_pmdsud001  LIKE pmds_t.pmdsud001         #20150624 add lujh
   DEFINE l_pmdsud002  LIKE pmds_t.pmdsud002         #20150624 by 02599 add
   DEFINE l_stbc009    LIKE stbc_t.stbc009           #20150826 add lujh
   DEFINE l_stbc038    LIKE stbc_t.stbc038           #20150909 add lujh
   DEFINE l_type       LIKE type_t.chr10             #20151027 add lujh
   DEFINE l_sign       LIKE type_t.chr1              #20151027 add lujh
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #20151203--mark--str--lujh
   #IF g_bgjob = "Y" OR g_bgjob = "T" THEN
   #   LET g_master.wc        = lc_param.wc
   #   LET g_master.apcasite  = lc_param.apcasite
   #   LET g_master.apcald    = lc_param.apcald
   #   LET g_master.apca011   = lc_param.apca011
   #   LET g_master.apca008   = lc_param.apca008
   #   LET g_master.rate1     = lc_param.rate1
   #   LET g_master.sel2      = lc_param.sel2
   #   LET g_master.slip1     = lc_param.slip1
   #   LET g_master.slip2     = lc_param.slip2
   #   LET g_master.apca007   = lc_param.apca007
   #   LET g_master.apcadocdt = lc_param.apcadocdt
   #   LET g_wc2 = " 1=1"
   #   CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_master.apcadocdt,'1')
   #   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   #   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #   CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
   #   
   #   DISPLAY lc_param.wc
   #   DISPLAY lc_param.apcasite
   #   DISPLAY lc_param.apcald
   #   DISPLAY lc_param.apca011
   #   DISPLAY lc_param.apca008
   #   DISPLAY lc_param.rate1
   #   DISPLAY lc_param.sel2
   #   DISPLAY lc_param.slip1
   #   DISPLAY lc_param.apca007
   #   DISPLAY lc_param.apcadocdt
   #END IF
   #20151103--mark--end--lujh
   
   #檢核單別是否該帳套可以使用
   IF NOT cl_null(g_master.slip1)THEN
      CALL s_fin_slip_chk(g_master.slip1,'aapt820',g_master.apcald,'D-FIN-3001') RETURNING g_sub_success,g_errno
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
#  DECLARE aapp831_process_cs CURSOR FROM ls_sql
#  FOREACH aapp831_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   CALL s_transaction_begin()   
   #依QBE條件建立temptable
   ########################################################################
   #單別不綁性質, 所以可以一張暫估單的單別，去產生 01/02性質的單據。
   #對aapp131的產生原則，仍是入庫單及倉退單別分產生帳款單, 性質也分別是對應到 01、02
   #但可以是使用同一個單別
   ########################################################################   
   
   DELETE FROM s_aapp831_tmp_g
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
   #LET l_wc = l_wc CLIPPED, " AND pmdssite IN ",g_wc_apcasite   #20150804 mark lujh
   LET l_wc = l_wc CLIPPED, " AND stbcsite IN ",g_wc_apcasite    #20150804 add lujh
   CALL s_ld_sel_glaa(g_master.apcald,'glaa001|glaacomp') RETURNING  g_sub_success,l_glaa001,l_apcacomp 
   #追加日期條件  
#150210apo--mark--(s)
#   #必須在輸入立帳日當月
#   #且當天之前
#   CALL s_date_get_first_date(g_master.apcadocdt) RETURNING l_strdat
#   LET l_enddat = g_master.apcadocdt
#   LET l_wc = l_wc CLIPPED," AND pmds001 BETWEEN '",l_strdat,"' AND '",l_enddat,"' "  
#150210apo--mark--(e)
   #150210apo--(s)
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_master.apcadocdt,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e   
   #LET l_wc = l_wc CLIPPED," AND pmds001 BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' "   #20150804 mark lujh
  # LET l_wc = l_wc CLIPPED," AND stbc002 BETWEEN '",g_pdate_s,"' AND '",g_master.apcadocdt,"' "    #20150804 add lujh   
   LET l_wc = l_wc CLIPPED," AND stbc002 <= '",g_master.apcadocdt,"' "    #20151009 add chenhz   
   #150210apo--(e)             
   
   LET l_field[1].f11 = "pmdt056"   LET l_field[2].f11 = "pmdt057"   LET l_field[3].f11 = "pmdt058"   #請款數量
   LET l_field[1].f21 = "pmdt066"   LET l_field[2].f21 = "pmdt067"   LET l_field[3].f21 = "pmdt068"   #暫估數量 
  
  
   #抓取資料條件和q_pmdtdocno_4盡量一致
   #可選取的資料才會跟預期的資料相同
   #可立暫估數量 = 計價數量 - 已立帳數量 - 已立暫估數量
   #20150804--mark--str--lujh
   #IF g_wc2 = " 1=1" THEN  #表示不需要join採購單欄位
   #   LET ls_sql ="SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
   #               "       pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,pmdt024, ",
   #               "       pmdldocno,pmdl002,pmdl003,pmdt024,'','','','','',pmdsud001,pmdsud002 ",   #20150624 add pmdsud001 lujh #20150714 by 02599 add pmdsud002
   #               "  FROM (",
   #               "       SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
   #               "              pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019, ",
   #               "              COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) - COALESCE(",l_field[l_ld_type].f21,",0) pmdt024, ",
   #               "              pmdldocno,pmdl002,pmdl003,pmdsud001,pmdsud002 ",    #20150624 add pmdsud001 lujh #20150714 by 02599 add pmdsud002
   #               "         FROM pmds_t,pmdt_t LEFT OUTER JOIN pmdl_t ON pmdlent = pmdtent AND pmdldocno = pmdt001 ",
   #               "        WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = ? ", 
   #               "          AND pmdsdocno = pmdtdocno ",
   #               "          AND pmds000 IN ('3','4','5','6','7','10','11','12','13','14','15') ",                #pmds000:SCC-2060
   #               "          AND pmdsstus = 'S' ",  #只抓入庫/且過帳
   #               "          AND ",l_wc CLIPPED,") ",
   #               "  WHERE pmdt024 > 0 "            
   #ELSE
   #   LET ls_sql ="SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
   #               "       pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,pmdt024, ",
   #               "       pmdldocno,pmdl002,pmdl003,pmdt024,'','','','','',pmdsud001,pmdsud002 ",   #20150624 add pmdsud001 lujh #20150714 by 02599 add pmdsud002
   #               "  FROM (",
   #               "       SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
   #               "              pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019, ",
   #               "              COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f11,",0) - COALESCE(",l_field[l_ld_type].f21,",0) pmdt024, ",
   #               "              pmdldocno,pmdl002,pmdl003,pmdsud001,pmdsud002 ",   #20150624 add pmdsud001 lujh #20150714 by 02599 add pmdsud002
   #               "         FROM pmds_t,pmdt_t,pmdl_t  ",
   #               "        WHERE pmdsent = pmdtent AND pmdt084 ='Y' AND pmdsent = ", g_enterprise,
   #               "          AND pmdsdocno = pmdtdocno AND pmdldocno = pmdt001",
   #               "          AND pmdsstus = 'S' AND pmds000 IN ('3','12','5','6','7','10','11','13','14','15') ",           #pmds000:SCC-2060 只抓入庫/且過帳
   #               "          AND ",l_wc CLIPPED, " AND ",g_wc2 CLIPPED,
   #               "       ) ",
   #               "  WHERE pmdt024 > 0 "    
   #END IF
   #20150804--mark--end--lujh
   #20150804--add--str--lujh
   LET ls_sql ="SELECT pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,pmds031,pmds033,pmds037,pmds038, ",
               "       pmdtsite,pmdtdocno,pmdtseq,pmdt001,pmdt006,pmdt019,pmdt024, ",
               "       pmdldocno,pmdl002,pmdl003,pmdt024,'','','','','',pmdsud001,pmdsud002,stbc009,stbc038,sign ",      #20150826 add stbc009 lujh   #20150909 add stbc038 lujh  #20151027 add sign lujh
               "  FROM (",
               "       SELECT stbcent pmdsent,stbc002 pmdsdocdt,stbc003 pmds000,",
               "              stbc008 pmds007,stbc008 pmds008,'' pmds031,",
               "              stbc014 pmds033,stbc013 pmds037,1  pmds038, ",
               "              stbcsite pmdtsite,stbc004 pmdtdocno,stbc005 pmdtseq,",
               "              '' pmdt001,stbc043 pmdt006,'' pmdt019, ",
               "              ABS(COALESCE(stbc034,0)) - ABS(COALESCE(stbc035,0)) - ABS(COALESCE(stbc054,0)) pmdt024, ",
               "              '' pmdldocno,'' pmdl002,'' pmdl003,stbc058 pmdsud001,stbc025 pmdsud002,stbc009,stbc038, ",   #20150826 add stbc009 lujh    #20150909 add stbc038 lujh
               "              (CASE WHEN stbc017 > 0  THEN '+' ELSE '-' END) sign ",    #20151027 add lujh
               "         FROM stbc_t ",
               "        WHERE stbcent = ? ", 
               "          AND stbc017<>0", #add BY chenhz 15/12/06
               "          AND stbc003 IN ('1','2','3','4','8','A','B','11') ",    #20150826 add '4' lujh   #20150901 remove '3' lujh  #20150909 add '3' lujh  #20151102 remove '3' lujh  #20151104 add '3' lujh
               "          AND ",l_wc CLIPPED,") ",
               "  WHERE pmdt024 > 0 "  
   #20150804--add--end--lujh
   PREPARE sel_aapp831_tmpp1 FROM ls_sql
   DECLARE sel_aapp831_tmpc1 CURSOR FOR sel_aapp831_tmpp1
                   
   ##########################################################################################
   #一些會取代掉的預設值會在這邊給入
   #若符合不可產生帳款單的單據，會在此利用CONTINUE FOREACH 跳過INSERT TEMP的部分
   #拆單條件若無值會給一個空白或定值以免SQL失敗少抓到資料
   ##########################################################################################
   
   FOREACH sel_aapp831_tmpc1 USING g_enterprise INTO l_tmp.*,l_pmdsud001,l_pmdsud002,l_stbc009,l_stbc038,l_sign   #20150826 add l_stbc009 lujh  #20151027 add l_sign lujh
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #20150909--add--str--lujh
      IF l_tmp.pmds000 = '3' AND l_stbc038 <> 'Y' THEN 
         CONTINUE FOREACH 
      END IF
      #20150909--add--end--lujh
      
      #20151027--add--str--lujh
      IF l_tmp.pmds000 = '3' THEN 
         LET l_type = '3'
      END IF
      
      IF l_tmp.pmds000 = '11' OR l_tmp.pmds000 MATCHES '[48AB]' THEN    #20151102 add OR l_tmp.pmds000 MATCHES '[48AB]' lujh
         LET l_type = '11'
      END IF
      
      IF l_tmp.pmds000 MATCHES '[1248AB]' THEN 
         LET l_type = '0' 
      END IF
      #20151027--add--end--lujh
      
      #入庫單所屬法人與帳務中心所屬法人不同者剔除
      CALL s_fin_orga_get_comp_ld(l_tmp.pmdtsite) RETURNING g_sub_success,g_errno,l_pmdtcomp,l_pmdtld
      IF l_pmdtcomp <> l_apcacomp THEN
         CONTINUE FOREACH
      END IF      
      #有輸入帳款類別用輸入的帳款類別
      IF NOT cl_null(g_master.apca007)THEN
         LET l_tmp.apca007 = g_master.apca007
      ELSE
         CALL s_apmm101_sel_pmab(l_apcacomp,l_tmp.pmds007,'pmab055') RETURNING g_sub_success,g_errno,l_tmp.apca007
         IF cl_null(l_tmp.apca007) THEN 
            SELECT pmab055 INTO l_tmp.apca007
              FROM pmab_t
             WHERE pmabent = g_enterprise
               AND pmabsite = 'ALL'
               AND pmab001 = l_tmp.pmds007
         END IF
      END IF
      IF cl_null(l_tmp.apca007)THEN LET l_tmp.apca007 = ' ' END IF
      
      #立帳日期
      IF NOT cl_null(g_master.apcadocdt) THEN LET l_tmp.pmdsdocdt = g_master.apcadocdt END IF  
      
      #稅別
      IF NOT cl_null(g_master.apca011)THEN LET l_tmp.pmds033 = g_master.apca011 END IF

      #付款條件
      IF NOT cl_null(g_master.apca008)THEN LET l_tmp.pmds031 = g_master.apca008 END IF  
      
      
      #匯率取用原則
      CASE
         WHEN g_master.rate1 = '1'
            #依原單
         WHEN g_master.rate1 = '2'
            #依立帳日匯率
            CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0014') RETURNING l_desc
            CALL s_aooi160_get_exrate('2',g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,l_glaa001,0,l_desc)
               RETURNING l_tmp.pmds038
            #是否無維護匯率的暫解，之後有更好的方法應該要修正 albireo 141008
            IF g_errparam.code = 'sub-00213' THEN
               CONTINUE FOREACH   
            END IF      
         WHEN g_master.rate1 = '3'
            #依立帳日月平均匯率   
            #aooi170
            CALL cl_get_para(g_enterprise,l_apcacomp,'S-BAS-0014') RETURNING l_desc
            CALL s_aooi160_get_exrate_avg('2',g_master.apcald,g_master.apcadocdt,l_tmp.pmds037,l_glaa001,0,l_desc)
                    RETURNING g_sub_success,g_errno,l_tmp.pmds038
            IF NOT g_sub_success THEN
               CONTINUE FOREACH
            END IF
      END CASE
      
      #20150804--add--str--lujh
      SELECT pmab037 INTO l_tmp.pmds031 
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = 'ALL'
         AND pmab001 = l_tmp.pmds007
      #20150804--add--end--lujh
      
      #不產生帳款的檢查(1:稅別 2:付款條件 3:原單無匯率)
      IF cl_null(l_tmp.pmds033) THEN
         CONTINUE FOREACH
      END IF    
      #20150804--add--str--lujh      
      #IF cl_null(l_tmp.pmds031)THEN #如果無付款條件 影響多帳期產生
      #   CONTINUE FOREACH
      #END IF
      #20150804--add--end--lujh
      IF g_master.rate1 = '1' AND cl_null(l_tmp.pmds038) THEN
         CONTINUE FOREACH
      END IF
      #處理拆單條件
      CASE
         WHEN g_master.sel2 = '1'
            LET l_tmp.cond1 = l_tmp.pmds007,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign   #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh                                             
         WHEN g_master.sel2 = '2'                                           
            LET l_tmp.cond1 = l_tmp.pmdtdocno,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh 
         WHEN g_master.sel2 = '3'                                           
            LET l_tmp.cond1 = l_tmp.pmdldocno,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh 
         WHEN g_master.sel2 = '4'                                           
            LET l_tmp.cond1 = l_tmp.pmdl002,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign   #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh 
         WHEN g_master.sel2 = '5'                                           
            LET l_tmp.cond1 = l_tmp.pmdl003,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign   #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh 
         WHEN g_master.sel2 = '6'                                            
            LET l_tmp.cond1 = l_tmp.pmdt006,'|',l_stbc009,'|',l_pmdsud002,'|',l_pmdsud001,l_type,l_sign   #20150624 add l_pmdsud001 lujh #20150714 by 02599 add "'|',l_pmdsud002,"    #20150826 add '|',l_stbc009, lujh   #20151027 add l_type,l_sign lujh 
      END CASE
      
      #INSERT INTO s_aapp831_tmp_g VALUES(l_tmp.*) #161108-00017#1 mark
      #161108-00017#1 add ------
      INSERT INTO s_aapp831_tmp_g (pmdsent,pmdsdocdt,pmds000,pmds007,pmds008,
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
   CALL s_transaction_end('Y',0)   #150126-00012#1 

   #計算迴圈筆數
   SELECT COUNT(*) INTO li_count
     FROM s_aapp831_tmp_g
   
   IF li_count = 0 THEN
      INITIALIZE g_errparam TO NULL
     #LET g_errparam.code = -100         #150210apo mark
      LET g_errparam.code = 'asf-00230'  #150210apo
     #LET g_errparam.extend = 'ins_tmp:' #150210apo mark
      LET g_errparam.extend = ''         #150210apo
      LET g_errparam.popup = FALSE
      CALL cl_err()  
   ELSE
      CALL s_aapp831_ins_apca('1','1',g_master.sel2,g_master.slip1,g_master.slip2,g_master.apcasite,g_master.apcald,'',g_bgjob)   #20150624 add g_master.slip2 lujh
         RETURNING g_sub_success,l_strno,l_endno
      IF g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00251'
         LET g_errparam.replace[1] = l_strno
         LET g_errparam.replace[2] = l_endno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #CALL s_transaction_end('Y',0)   #150126-00012#1 mark
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00187'   #單據產生失敗
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()   
         #CALL s_transaction_end('N',0)   #150126-00012#1 mark
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
   CALL aapp831_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp831.get_buffer" >}
PRIVATE FUNCTION aapp831_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
   LET g_master.slip1 = p_dialog.getFieldBuffer('slip1')
   LET g_master.slip2 = p_dialog.getFieldBuffer('slip2')
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
 
{<section id="aapp831.msgcentre_notify" >}
PRIVATE FUNCTION aapp831_msgcentre_notify()
 
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
 
{<section id="aapp831.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp831_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp831_qbe_clear()
DEFINE l_apcacomp    LIKE ooef_t.ooef001
DEFINE l_sql         STRING
   
   WHENEVER ERROR CONTINUE
   INITIALIZE g_master.* TO NULL
   
   LET g_master.sel2 = '1'   #彙總方式
   LET g_master.rate1= '1'
   LET g_master.apcadocdt = g_today

   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apcasite,g_master.apcald,l_apcacomp
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
         #CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2010') RETURNING g_master.apca011   #稅額預設值    #20150830
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2011') RETURNING g_sfin2011         #暫估迴轉否(Y:迴轉/N:不迴轉)
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-3012') RETURNING g_sfin3012         #應付暫估立帳選項
         CALL aapp831_single_tax_chk(l_apcacomp,l_apcacomp,g_master.apca011) RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            LET g_master.apca011 = ''
         END IF
         #不回转的话，暂估立税一定是要不含税立账的(如果是不迴轉 就不考慮暫估立帳參數
         IF g_sfin2011 = 'N' THEN LET g_sfin3012 = '1' END IF
      END IF
      LET g_master_o.apcasite = g_master.apcasite
   END IF
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
   DISPLAY BY NAME g_master.sel2,g_master.rate1,g_master.apca011,
                   g_master.apcald,g_master.apcasite,g_master.apcadocdt,
                   g_master.l_apcald_desc,g_master.l_apcasite_desc
                   
   #20150830--add--str--lujh
   LET l_sql = "SELECT DISTINCT ooba002 ",
               "  FROM ooba_t ",
               "  LEFT OUTER JOIN ooac_t ",
               "    ON ooacent = oobaent ",
               "   AND ooac001 = ooba001 ",
               "   AND ooac002 = ooba002 ",
               " WHERE oobaent = ",g_enterprise,
               "   AND ooba002 IN (SELECT oobl001 ",
               "                     FROM oobl_t ",
               "                    WHERE ooblent = ",g_enterprise,
               "                      AND oobl002 = 'aapt820')",
               "   AND oobastus = 'Y' ",
               "   AND ooba001 = '",g_glaa024,"'",
               "   AND ooac003 = 'D-FIN-3500' ",
               "   AND ooac004 = 'Y' ",
               " ORDER BY ooba002 "
   PREPARE ooba_pre1 FROM l_sql
   DECLARE ooba_cur1 SCROLL CURSOR WITH HOLD FOR ooba_pre1
   OPEN ooba_cur1
   FETCH FIRST ooba_cur1 INTO g_master.slip1
   CLOSE ooba_cur1
   CALL s_aooi200_fin_get_slip_desc(g_master.slip1)RETURNING g_master.l_slip1_desc
   DISPLAY BY NAME g_master.l_slip1_desc
   
   LET l_sql = "SELECT DISTINCT ooba002 ",
               "  FROM ooba_t ",
               "  LEFT OUTER JOIN ooac_t ",
               "    ON ooacent = oobaent ",
               "   AND ooac001 = ooba001 ",
               "   AND ooac002 = ooba002 ",
               " WHERE oobaent = ",g_enterprise,
               "   AND ooba002 IN (SELECT oobl001 ",
               "                     FROM oobl_t ",
               "                    WHERE ooblent = ",g_enterprise,
               "                      AND oobl002 = 'aapt820')",
               "   AND oobastus = 'Y' ",
               "   AND ooba001 = '",g_glaa024,"'",
               "   AND ooac003 = 'D-FIN-3500' ",
               "   AND ooac004 = 'N' ",
               " ORDER BY ooba002 "
   PREPARE ooba_pre2 FROM l_sql
   DECLARE ooba_cur2 SCROLL CURSOR WITH HOLD FOR ooba_pre2
   OPEN ooba_cur2
   FETCH FIRST ooba_cur2 INTO g_master.slip2
   CLOSE ooba_cur2
   CALL s_aooi200_fin_get_slip_desc(g_master.slip2)RETURNING g_master.l_slip2_desc
   DISPLAY BY NAME g_master.l_slip2_desc
   #20150830--add--end--lujh
   
   RETURN l_apcacomp
END FUNCTION

################################################################################
# Descriptions...: 檢核是否為單一稅
# Memo...........:
# Date & Author..: 15/05/21 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp831_single_tax_chk(p_ooef001,p_ooef017,p_apca011)
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
 
