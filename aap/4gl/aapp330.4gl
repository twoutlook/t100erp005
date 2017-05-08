#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2016-01-08 16:21:08), PR版次:0017(2017-02-13 10:02:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000372
#+ Filename...: aapp330
#+ Description: 應付帳款單批次產生傳票作業
#+ Creator....: 02097(2014-05-15 16:48:02)
#+ Modifier...: 02114 -SD/PR- 06821
 
{</section>}
 
{<section id="aapp330.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150126-00027#1           By Belle     增加傳票補號
#150127-00007#1  15/02/24 By Reanna    筆數顯示異常處理
#150212-00011#3  15/03/03 By Reanna    傳票日期必須與帳款期間相同會計週期&已關帳的單據不可拋(立帳日>關帳日)
#150210-00011#4  15/03/25 By Reanna    依立帳日取會計期間，限定可立帳的範圍為會計期間起始日~輸入立帳日
#160310-00015#1  16/03/14 By Ann_Huang 當匯總項目為「全部」時，傳票憑證日期需控卡為必填(aap-00500、aap-00501)
#160318-00025#39 16/04/22 By pengxin   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160812-00027#3  16/08/18 By 06821     全面盤點應付程式帳套權限控管
#160920-00019#1  16/09/21 By 08732     交易對象開窗校驗調整
#161006-00005#2  16/10/12 By 08732     組織類型與職能開窗調整
#161115-00044#1  16/11/22 By 08729     開窗增加過濾據點+帳套權限調整
#161230-00029#1  17/01/03 By albireo   因cmdrun aapp330會預設好資料範圍 ,因此單別檢核應多卡在execute時
#161229-00047#13 17/01/09 By Reanna    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170110-00063#1  170111   By albireo   調整#161229-00047#13 位置
#170116-00053#1  170116   By albireo   帳務單號開窗調整
#160909-00015#3  170213   By 06821     帳款單性質條件取SCC8502應用碼五, Y的才顯示出來
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel           LIKE type_t.chr1,
       apcald        LIKE apca_t.apcald, 
       apcadocno     LIKE apca_t.apcadocno, 
       apcadocdt     LIKE apca_t.apcadocdt, 
       apca004       LIKE apca_t.apca004, 
       apca100       LIKE apca_t.apca005, 
       apca103       LIKE apca_t.apca103, 
       apca104       LIKE apca_t.apca104, 
       apca113       LIKE apca_t.apca113, 
       apca114       LIKE apca_t.apca114
                 END RECORD
TYPE type_g_glaq_d        RECORD
       docno         LIKE apca_t.apcadocno,  #單據編號
       docdt         LIKE apca_t.apcadocdt,  #單據日期
       glaq022       LIKE glaq_t.glaq022,    #帳款客戶
       glaqseq       LIKE glaq_t.glaqseq,    #項次
       glaq001       LIKE glaq_t.glaq001,    #摘要
       glaq002       LIKE glaq_t.glaq002,    #科目編號
       glaq002_desc  LIKE type_t.chr300,     #科目說明
       glaq003       LIKE glaq_t.glaq003,    #借方金額(本幣一)
       glaq004       LIKE glaq_t.glaq004,    #貸方金額(本幣一)
       glaq040       LIKE glaq_t.glaq040,    #借方金額(本幣二)
       glaq041       LIKE glaq_t.glaq041,    #貸方金額(本幣二)
       glaq043       LIKE glaq_t.glaq043,    #借方金額(本幣三)
       glaq044       LIKE glaq_t.glaq044,    #貸方金額(本幣三)
       img           LIKE type_t.chr80
       END RECORD
TYPE type_g_input    RECORD
       apcasite      LIKE apca_t.apcasite,
       apcasite_desc LIKE type_t.chr80,
       apcald        LIKE apca_t.apcald,
       apcald_desc   LIKE type_t.chr80,
       apcacomp      LIKE apca_t.apcacomp,
       apcacomp_desc LIKE type_t.chr80,
       type          LIKE type_t.chr1,
       glapdocno     LIKE glap_t.glapdocno,
       glapdocdt     LIKE glap_t.glapdocdt,
       glstr_no      LIKE apca_t.apcadocno,
       glend_no      LIKE apca_t.apcadocno
                 END RECORD
TYPE type_g_qbe      RECORD
       apcasite      LIKE apca_t.apcald,
       apca003       LIKE apca_t.apca003,
       apca001       LIKE apca_t.apca001,
       apca004       LIKE apca_t.apca004,
       apcadocdt     LIKE apca_t.apcadocdt,
       apcadocno     LIKE apca_t.apcadocno
                 END RECORD
GLOBALS
   DEFINE g_input    type_g_input    #INPUT條件
END GLOBALS
DEFINE g_input_t     type_g_input    ##150126-00027#1-備份INPUT條件
DEFINE g_qbe         type_g_qbe      #QBE條件

#變數
DEFINE g_rec_b       LIKE type_t.num5 
DEFINE g_rec_b2      LIKE type_t.num5 
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_detail_idx2 LIKE type_t.num5
DEFINE g_detail_idxb LIKE type_t.num5        #紀錄最後指向位置
DEFINE g_glaa003     LIKE glaa_t.glaa003     #會計週期參照表
DEFINE g_glaa013     LIKE glaa_t.glaa013     #最後關帳日期
DEFINE g_glaa102     LIKE glaa_t.glaa102     #借貸不平衡處理方式
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_glaa121     LIKE glaa_t.glaa121
DEFINE g_glaa100     LIKE glaa_t.glaa100
DEFINE g_docno       LIKE apca_t.apcadocno   #單號
DEFINE g_docdt       LIKE apca_t.apcadocdt   #帳款日期
DEFINE g_apca004     LIKE apca_t.apca004     #帳款客戶

TYPE type_l_tmp_d   RECORD
                     docno    LIKE glaq_t.glaqdocno,     #01-彙總單號
                     docdt    LIKE glap_t.glapdocdt,     #02-彙總日期
                     sw       LIKE type_t.chr1,          #03-1.借  2.貸
                     glaqent  LIKE glaq_t.glaqent,       #04-
                     glaqcomp LIKE glaq_t.glaqcomp,      #05-
                     glaqld   LIKE glaq_t.glaqld,        #06-
                     glaq001  LIKE glaq_t.glaq001,       #07-摘要
                     glaq002  LIKE glaq_t.glaq002,       #08-科目編號
                     glaq005  LIKE glaq_t.glaq005,       #09-交易幣別
                     glaq006  LIKE glaq_t.glaq006,       #10-匯率
                     glaq007  LIKE glaq_t.glaq007,       #11-計價單位
                     glaq008  LIKE glaq_t.glaq008,       #12-數量
                     glaq009  LIKE glaq_t.glaq009,       #13-單價
                     glaq011  LIKE glaq_t.glaq011,       #14-票據編碼
                     glaq012  LIKE glaq_t.glaq012,       #15-票據日期
                     glaq013  LIKE glaq_t.glaq013,       #16-申請人
                     glaq014  LIKE glaq_t.glaq014,       #17-銀行帳號
                     glaq015  LIKE glaq_t.glaq015,       #18-結算方式
                     glaq016  LIKE glaq_t.glaq016,       #19-收支項目
                     glaq017  LIKE glaq_t.glaq017,       #20-營運據點
                     glaq018  LIKE glaq_t.glaq018,       #21-固定核算項-部門
                     glaq019  LIKE glaq_t.glaq019,       #22-固定核算項-利潤/成本中心
                     glaq020  LIKE glaq_t.glaq020,       #23-固定核算項-區域
                     glaq021  LIKE glaq_t.glaq021,       #24-固定核算項-交易客商
                     glaq022  LIKE glaq_t.glaq022,       #25-固定核算項-帳款客戶
                     glaq023  LIKE glaq_t.glaq023,       #26-固定核算項-客群
                     glaq024  LIKE glaq_t.glaq024,       #27-固定核算項-產品類別
                     glaq025  LIKE glaq_t.glaq025,       #28-固定核算項-人員
                     glaq026  LIKE glaq_t.glaq026,       #29-固定核算項-預算編號
                     glaq027  LIKE glaq_t.glaq027,       #30-固定核算項-專案編號
                     glaq028  LIKE glaq_t.glaq028,       #31-固定核算項-WBS
                     glaq029  LIKE glaq_t.glaq029,       #32-自由核算項
                     glaq030  LIKE glaq_t.glaq030,       #33-自由核算項
                     glaq031  LIKE glaq_t.glaq031,       #34-自由核算項
                     glaq032  LIKE glaq_t.glaq032,       #35-自由核算項
                     glaq033  LIKE glaq_t.glaq033,       #36-自由核算項
                     glaq034  LIKE glaq_t.glaq034,       #37-自由核算項
                     glaq035  LIKE glaq_t.glaq035,       #38-自由核算項
                     glaq036  LIKE glaq_t.glaq036,       #39-自由核算項
                     glaq037  LIKE glaq_t.glaq037,       #40-自由核算項
                     glaq038  LIKE glaq_t.glaq038,       #41-自由核算項
                     d        LIKE glaq_t.glaq003,       #42-借方金額
                     c        LIKE glaq_t.glaq004,       #43-貸方金額
                     sum      LIKE glaq_t.glaq010,       #44-金額
                     glaq039  LIKE glaq_t.glaq039,       #45-本位幣二-匯率
                     glaq040  LIKE glaq_t.glaq040,       #46-本位幣二-借方金額
                     glaq041  LIKE glaq_t.glaq041,       #47-本位幣二-貸方金額
                     glaq042  LIKE glaq_t.glaq042,       #48-本位幣三-匯率
                     glaq043  LIKE glaq_t.glaq043,       #49-本位幣三-借方金額
                     glaq044  LIKE glaq_t.glaq044,       #40-本位幣三-貸方金額
                     seq      LIKE glaq_t.glaqseq,       #51-
                     source   LIKE type_t.chr100,        #52-來源TABLE(回寫時,會依據來源資料回寫)
                     glaqseq  LIKE glaq_t.glaqseq,       #53-項次
                     xrca039  LIKE xrca_t.xrca039,       #54-會計檢核附件份數
                     apcb022  LIKE apcb_t.apcb022,       #55-正負值
                     key1     LIKE type_t.chr80,         #56-PK1
                     key2     LIKE type_t.chr80,         #57-PK2
                     type     LIKE type_t.chr1           #58-彙總類型(1:清單,2:彙總)
                     END RECORD
DEFINE l_tmp         type_l_tmp_d
DEFINE g_flag2       LIKE type_t.chr1   #是否外部呼叫
DEFINE g_wc_apcald   STRING
DEFINE g_sql_ctrl    STRING             #160920-00019#1---add
DEFINE g_comp_str    STRING             #161229-00047#13
DEFINE g_apca001_scc STRING             #160909-00015#3 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp330.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151125-00006#2--s
   LET g_bgjob = g_argv[6]
   IF cl_null(g_bgjob) THEN LET g_bgjob = 'N' END IF
   #151125-00006#2--e
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #151125-00006#2--s
      DISPLAY 'OK!'
      CALL aapp330_init()
      LET g_input.type = 1
      LET g_input.apcald  = g_argv[1]
      LET g_qbe.apcadocno = g_argv[2]
      LET g_input.apcasite= g_argv[5]
      LET g_input.glapdocno=g_argv[3]
      LET g_input.glapdocdt=g_argv[4]
      LET g_wc = "apcadocno = '",g_qbe.apcadocno,"'"
      CALL s_ld_sel_glaa(g_input.apcald,'glaa015|glaa016|glaa019|glaa020|glaa102|glaacomp|glaa121|glaa024|glaa100|glaa003')
                       RETURNING g_sub_success,g_glaa015,g_glaa016,g_glaa019,
                                 g_glaa020,g_glaa102,g_input.apcacomp,g_glaa121,g_glaa024,
                                 g_glaa100,g_glaa003
      
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00044#1-add #161229-00047#13 mark
      #161229-00047#13 add ------
      CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#13 add end---
      SELECT glaa013 INTO g_glaa013
        FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = g_input.apcald
      CALL aapp330_b_fill()
      LET g_bgjob = 'N'
      CALL aapp330_p()
      #151125-00006#2--s
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp330 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp330_init()   
 
      #進入選單 Menu (="N")
      CALL aapp330_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp330
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_voucher_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp330.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp330_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL aapp330_apca001_scc()                   #160909-00015#3 add
   #CALL cl_set_combo_scc('apca001','8502')     #160909-00015#3 mark
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   CALL s_fin_continue_no_tmp()               #150126-00027#1
   CALL cl_set_combo_scc_part('apca068','6013',"1,3,4,5,A,B")    #151201-00002#25 add lujh
   #160920-00019#1---s
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00044#1 mark
   #160920-00019#1---e
   #161229-00047#13 mark ------   
   ##161115-00044#1-add(s)
   #SELECT ooef017 INTO g_input.apcacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00044#1-add(s)
   #161229-00047#13 mark end---  
   #170110-00063#1-----s
   SELECT ooef017 INTO g_input.apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'   
   CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #170110-00063#1-----e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp330.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp330_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_start_no      LIKE glap_t.glapdocno
   DEFINE l_end_no        LIKE glap_t.glapdocno
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_extend        LIKE type_t.chr80
   DEFINE l_flag          LIKE type_t.num5       #150212-00011#3
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002    #151201-00002#25 add lujh
   DEFINE l_comp_wc       STRING                 #161115-00044#1-add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp330_qbeclear()
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002   #151201-00002#25 add lujh
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp330_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
                 
         #INPUT區段
         INPUT g_input.apcasite,g_input.apcald,g_input.type,g_input.glapdocno,g_input.glapdocdt 
          FROM apcasite,apcald,type,glapdocno,glapdocdt
               ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
                  CALL aapp330_query()
               END IF

            AFTER FIELD apcasite
               LET g_input.apcasite_desc = ''
               IF NOT cl_null(g_input.apcasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcasite = ''
                     CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                     DISPLAY BY NAME g_input.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00044#1-add #161229-00047#13 mark
               #161229-00047#13 add ------
               SELECT ooef017 INTO g_input.apcacomp
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_input.apcasite
                  AND ooefstus = 'Y'
               CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               #161229-00047#13 add end---
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
               DISPLAY BY NAME g_input.apcasite_desc
            
            
            AFTER FIELD apcald
               LET g_input.apcald_desc   = ''
               LET g_input.apcacomp_desc = ''
               LET g_input.apcacomp      = ''
               IF NOT cl_null(g_input.apcald) THEN
                  #CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #160812-00027#3 mark
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno  #160812-00027#3 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcald = ''
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_ld_carry(g_input.apcald,'') RETURNING g_success,g_input.apcald,g_input.apcacomp,g_errno
                  IF NOT g_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_input.apcald
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                  END IF
                  IF NOT g_success THEN LET g_input.apcald = '' END IF               
                  CALL aapp330_set_ld_info(g_input.apcald)
                  #150126-00027#1--(S)
                  IF g_input.apcald <> g_input_t.apcald THEN
                     DELETE FROM s_fin_tmp_conti_no
                  END IF
                  LET g_input_t.apcald = g_input.apcald
                  #150126-00027#1--(E)
               END IF
               LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
               LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp) 
               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc
               
            AFTER FIELD type
               IF NOT g_input.type MATCHES '[12345]' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00379"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               
            ON CHANGE type
                #如果依帳款客戶產生則產生日期為必填 
               CALL cl_set_comp_required("glapdocdt" ,FALSE)               
               IF g_input.type MATCHES '[35]' THEN
                  CALL cl_set_comp_required("glapdocdt" ,TRUE) 
               END IF

            AFTER FIELD glapdocno
               IF NOT cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa024
                  LET g_chkparam.arg2 = g_input.glapdocno
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  IF cl_chk_exist("v_ooba002_07") THEN
                     #150126-00027#1--(S)
                     IF g_input_t.glapdocno <> g_input.glapdocno THEN
                        DELETE FROM s_fin_tmp_conti_no
                     END IF
                     LET g_input_t.glapdocno = g_input.glapdocno
                     #150126-00027#1--(E)
                  ELSE
                     LET g_input.glapdocno = ''
                     #150126-00027#1--(S)
                     DELETE FROM s_fin_tmp_conti_no
                     LET g_input_t.glapdocno = g_input.glapdocno
                     #150126-00027#1--(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            #150126-00027#1--(S)
            AFTER FIELD glapdocdt
               IF g_input_t.glapdocdt <> g_input.glapdocdt THEN
                  DELETE FROM s_fin_tmp_conti_no
               END IF               
               LET g_input_t.glapdocdt = g_input.glapdocdt
               SELECT glaa013 INTO g_glaa013 
                 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_input.apcald

               IF NOT cl_null(g_input.glapdocdt) AND g_input.glapdocdt <= g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.glapdocdt = ''
                  LET g_input_t.glapdocdt = g_input.glapdocdt
                  CONTINUE DIALOG
               END IF
               
            ON ACTION cont_no
               IF cl_null(g_input.apcald)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','apcald')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapdocno')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00331'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               CALL s_transaction_begin()
               CALL s_fin_continue_no_input(g_input.apcald,'',g_input.glapdocno,g_input.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
               
            #150126-00027#1--(E)   
            
            ON ACTION controlp INFIELD apcald
               CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00044#1-add
               CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00044#1-add
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcald                     #給予default值
               #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)  #160812-00027#3 mark
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               #LET g_qryparam.where = " glaald IN ",g_wc_apcald                                        #160812-00027#3 mark
               #LET g_qryparam.where = "(glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald    #160812-00027#3 add #161115-00044#1 mark
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,"" #161115-00044#1-add
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.apcald = g_qryparam.return1                      #將開窗取得的值回傳到變數
               CALL s_fin_ld_carry(g_input.apcald,'') RETURNING g_success,g_input.apcald,g_input.apcacomp,g_errno
               LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
               LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp) 
               DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc
               NEXT FIELD apcald                                            #返回原欄位
            
             ON ACTION controlp INFIELD apcasite
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcasite
               #CALL q_ooef001()     #161006-00005#2  mark
               CALL q_ooef001_46()   #161006-00005#2  add
               LET g_input.apcasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
               DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
               NEXT FIELD apcasite                
               
            ON ACTION controlp INFIELD glapdocno         
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapdocno  #給予default值
               LET g_qryparam.arg1 = g_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_input.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_input.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno                          #返回原欄位
               
            AFTER INPUT
             
         END INPUT
         

         #查詢QBE
         CONSTRUCT BY NAME g_wc ON apca003,apca001,apca004,apcadocdt,
                                   apcadocno,apca100,apca068,apca067    #151201-00002#25 add apca068,apca067 lujh

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
        
               
            ON ACTION controlp INFIELD apca003
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca003  #顯示到畫面上  
               NEXT FIELD apca003                     #返回原欄位 
   
            ON ACTION controlp INFIELD apcadocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         LET g_qryparam.where = " apcastus = 'Y' AND apca038 IS NULL AND apcald = '",g_input.apcald,"'"
   	         #161115-00044#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaa001 = apca004 ) "
               END IF
               #161115-00044#1-add(e)
               #170116-00053#1-----s
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND apca001 NOT IN('21','23','24','25','26')"
               #170116-00053#1-----e
               CALL q_apcadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apcadocno  #顯示到畫面上  
               NEXT FIELD apcadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD apca004
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         #160920-00019#1---s
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #160920-00019#1---e
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca004  #顯示到畫面上
               NEXT FIELD apca004                
               #返回原欄位  
               
           ON ACTION controlp INFIELD apca100
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               CALL q_ooai001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca100  #顯示到畫面上
               NEXT FIELD apca100   
               
           #151201-00002#25--add--str--lujh
           ON ACTION controlp INFIELD apca067
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = l_ooaa002
               CALL q_rtax001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca067        #顯示到畫面上
               NEXT FIELD apca067                           #返回原欄位 
           #151201-00002#25--add--end--lujh
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)                                        
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
                     
            #150212-00011#3 add---
            ON CHANGE sel
               CALL aapp330_chk_date(g_detail_d[l_ac].apcadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[l_ac].sel = 'N'
               END IF
            #150212-00011#3 add end---
         END INPUT
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            IF g_flag2 = 'Y' THEN
               DISPLAY g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,g_input.type
                    TO apcald,apcald_desc,apcacomp,apcacomp_desc,type
               DISPLAY g_qbe.apcadocno TO apcadocno            
            END IF
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            #150212-00011#3 add---
            CALL s_azzi902_get_gzzd('aapp330',"lbl_apcadocno_error") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               CALL aapp330_chk_date(g_detail_d[li_idx].apcadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apcadocno
                  CALL cl_err()
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
            END FOR
            CALL cl_err_collect_show()
            #150212-00011#3 add end---
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #150212-00011#3 add---
            CALL aapp330_chk_date(g_detail_d[l_ac].apcadocdt) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_detail_d[l_ac].sel = 'N'
            END IF
            #150212-00011#3 add end---
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapp330_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL aapp330_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL aapp330_qbeclear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp330_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         #批次執行
         ON ACTION batch_execute
            #以來源客戶產生,傳票日期需有值,且不可小於關帳日
            LET g_input.glstr_no = ''
            LET g_input.glend_no = ''
            DISPLAY BY NAME g_input.glstr_no,g_input.glend_no
            #160310-00015#1 --- add Start ---
            IF cl_null(g_input.glapdocno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aap-00500'   #「傳票憑證單別」欄位為必填！請確認！
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE DIALOG
               
            ELSE
               #161230-00029#1-----s
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_glaa024
               LET g_chkparam.arg2 = g_input.glapdocno
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
               IF NOT cl_chk_exist("v_ooba002_07") THEN
                  CONTINUE DIALOG
               END IF
               #161230-00029#1-----e
            END IF
            #160310-00015#1 --- add End   ---            
            IF g_input.type = '3' OR g_input.type = '5' THEN   #160310-00015#1 add OR g_input.type = '5'
               IF cl_null(g_input.glapdocdt) THEN
                  #160310-00015#1 --- add Start ---
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00501'   #「傳票憑證日期」欄位為必填！請確認！
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #160310-00015#1 --- add End   ---
                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(g_input.glapdocdt) AND g_input.glapdocdt <= g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
            END IF

            CALL s_transaction_begin()   
            DELETE  FROM s_voucher_tmp
            
            #150212-00011#3 add---
            LET l_flag = 1 #1:可執行0:錯誤了
            CALL s_azzi902_get_gzzd('aapp330',"lbl_apcadocno_error") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
            CALL cl_err_collect_init()
            #150212-00011#3 add end---
            FOR li_idx = 1 TO g_detail_cnt
               IF g_detail_d[li_idx].sel = 'N' THEN 
                  CONTINUE FOR
               ELSE
                  #若以原單據日期立帳
                  IF cl_null(g_input.glapdocdt) AND g_detail_d[li_idx].apcadocdt < = g_glaa013 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00077'
                     #LET g_errparam.extend = g_detail_d[li_idx].apcadocno       #150212-00011#3 mark
                     LET g_errparam.extend = ''                                  #150212-00011#3
                     LET g_errparam.popup = TRUE
                     LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apcadocno #150212-00011#3
                     CALL cl_err()
                     LET l_flag = 0                                              #150212-00011#3
                     #CONTINUE DIALOG                                            #150212-00011#3 mark
                  END IF
                  
                  #150212-00011#3 add---
                  CALL aapp330_chk_date(g_detail_d[li_idx].apcadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apcadocno
                     CALL cl_err()
                     LET l_flag = 0
                  END IF
                  #150212-00011#3 add end---

                  #將勾選的單號塞進temp_table
                  INSERT INTO s_voucher_tmp (docno,type)
                     VALUES ( g_detail_d[li_idx].apcadocno , '0' )
               END IF
            END FOR
            #150212-00011#3 add---
            CALL cl_err_collect_show()
            IF l_flag = 0 THEN
               CONTINUE DIALOG
            END IF
            #150212-00011#3 add end---

            SELECT count(*) INTO l_count FROM s_voucher_tmp
            IF l_count > 0 THEN           
               IF NOT g_glaa121 = 'Y' THEN                 
                  CALL s_aapp330_gen_ac('1','P10',g_input.apcald,'','',g_input.type,'!#@','Y') RETURNING g_sub_success,l_start_no,l_end_no
               END IF
               IF g_sub_success THEN
                  CALL s_transaction_end('Y','Y')
               ELSE
                  CALL s_transaction_end('N','Y')
               END IF   
                
               CALL s_transaction_begin()               
               CALL cl_err_collect_init()
               CALL s_aapp330_generate_voucher('P10',g_input.glapdocno,g_input.glapdocdt,g_input.apcald,g_input.type,'Y',g_glaa102,'AP')
                    RETURNING g_sub_success,g_input.glstr_no,g_input.glend_no
               CALL cl_err_collect_show()   
               IF g_sub_success AND NOT cl_null(g_input.glend_no) THEN
                  CALL s_transaction_end('Y','Y')
                  CALL aapp330_b_fill()
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00217'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  CALL s_transaction_end('N','Y')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00218'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF  

               DISPLAY BY NAME g_input.glstr_no,g_input.glend_no
               
            END IF
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp330.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp330_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aapp330_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   #150212-00011#3 add---
   IF l_ac = 0 THEN
      LET l_ac = 1
   END IF
   #150212-00011#3 add end---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp330_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_dfin0030       LIKE type_t.chr1
   DEFINE l_ap_slip        LIKE apca_t.apcadocno
   DEFINE l_apcacomp       LIKE apca_t.apcacomp
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
   DEFINE l_wdate         LIKE glav_t.glav004
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_glav007       LIKE glav_t.glav007
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #已確認(apcastus)/未拋轉傳票(apca038)
   LET g_sql = "SELECT 'N',apcald,apcadocno,apcadocdt,",
               "       apca004,apca100,apca103,apca104,apca113,",
               "       apca114,apcacomp",
               "  FROM apca_t",
               " WHERE apcastus = 'Y' AND apca038 IS NULL AND apcaent = ? ",
               "   AND apcasite = '",g_input.apcasite,"'    ",
               #"   AND apcald   = '",g_input.apcald,"' AND ",g_wc #161115-00044#1 mark
               #161115-00044#1-add
               "   AND apcald   = '",g_input.apcald,"' ",
               "    AND EXISTS (SELECT 1 FROM pmaa_t ",
               "                WHERE pmaaent = ",g_enterprise,
               "                AND ",g_sql_ctrl,
               "                AND pmaaent = apcaent ",
               "                AND pmaa001 = apca004 ) ",
               "    AND ",g_wc
               #161115-00044#1-add
   IF NOT cl_null(g_input.glapdocdt) THEN
      LET l_year = YEAR(g_input.glapdocdt)
      LET l_month = MONTH(g_input.glapdocdt)
      CALL s_get_accdate(g_glaa003,'',l_year,l_month) #取得會計當期起始日
           RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_wdate,l_wdate,
                     l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate,l_wdate
      #LET g_sql = g_sql, " AND apcadocdt BETWEEN '",l_pdate_s,"' AND '",l_pdate_e,"'"        #150210-00011#4 mark
      LET g_sql = g_sql, " AND apcadocdt BETWEEN '",l_pdate_s,"' AND '",g_input.glapdocdt,"'" #150210-00011#4
   END IF
   
   LET g_sql = g_sql," AND apca001 IN ",g_apca001_scc," "  #160909-00015#3 add
   #end add-point
 
   PREPARE aapp330_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp330_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*,l_apcacomp
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      CALL s_aooi200_fin_get_slip(g_detail_d[l_ac].apcadocno) RETURNING g_sub_success,l_ap_slip
      CALL s_fin_get_doc_para(g_detail_d[l_ac].apcald,l_apcacomp,l_ap_slip,'D-FIN-0030') RETURNING l_dfin0030
      IF NOT l_dfin0030 = 'Y' THEN
         CONTINUE FOREACH
      END IF
      LET g_detail_d[l_ac].sel = 'Y'
      IF g_detail_d[l_ac].apcadocdt <= g_glaa013 THEN
         LET g_detail_d[l_ac].sel = 'N'
      END IF
      #150212-00011#3 add---
      CALL aapp330_chk_date(g_detail_d[l_ac].apcadocdt) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET g_detail_d[l_ac].sel = 'N'
      END IF
      #150212-00011#3 add end---
      #end add-point
      
      CALL aapp330_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   ERROR "" 
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp330_sel
   
   LET l_ac = 1
   CALL aapp330_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index #150127-00007#1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp330.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp330_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_detail_idx) THEN LET g_detail_idx = g_detail_idxb END IF
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1 
   END IF
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aapp330.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp330_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp330.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp330_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aapp330_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp330.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp330_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aapp330.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp330_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapp330_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp330.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aapp330_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_detail_d.getLength() THEN
         LET g_detail_idx = g_detail_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_detail_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.h_index
      DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
   END IF
END FUNCTION

PRIVATE FUNCTION aapp330_qbeclear()
   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_input.*    TO NULL
   INITIALIZE g_input_t.*  TO NULL     #150126-00027#1
   INITIALIZE g_qbe.*      TO NULL
   INITIALIZE g_wc         TO NULL
   
   LET g_detail_idx = 1 
   #由aapt3*傳入參數 預設值
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      LET g_input.type = 1
      LET g_input.apcald  = g_argv[1]
      LET g_qbe.apcadocno = g_argv[2]
      LET g_input.apcasite= g_argv[5]
      LET g_input.glapdocno=g_argv[3]
      LET g_input.glapdocdt=g_argv[4]
      LET g_flag2 = 'Y'
      LET g_wc = "apcadocno = '",g_qbe.apcadocno,"'"
   ELSE
      #帳務組織/帳套/法人預設
      CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                         g_input.apcald,g_input.apcacomp
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00044#1 mark #161229-00047#13 mark
      #161229-00047#13 add ------
      CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#13 add end---
      LET g_input.type = 3
      CALL cl_set_comp_entry("glapdocdt",TRUE)
      LET g_flag2 = 'N'
   END IF
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   CALL aapp330_set_ld_info(g_input.apcald)
   LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
   LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
   LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
   
   DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,g_input.type,g_input.apcasite,
                   g_input.glapdocno,g_input.glapdocdt,g_input.apcasite_desc,g_input.apcasite_desc,g_qbe.apcadocno
   
   CALL cl_set_comp_required("glapdocdt" ,FALSE)
   IF g_input.type = 3 THEN
      CALL cl_set_comp_required("glapdocdt" ,TRUE)
   END IF
   
   LET g_input_t.* = g_input.*
   
END FUNCTION
#150126-00027#1   Belle    增加傳票補號
PRIVATE FUNCTION aapp330_set_ld_info(p_ld)
DEFINE p_ld          LIKE glaa_t.glaald

   CALL s_ld_sel_glaa(p_ld,'glaa015|glaa016|glaa019|glaa020|glaa102|glaacomp|glaa121|glaa024|glaa100|glaa003')
                       RETURNING g_sub_success,g_glaa015,g_glaa016,g_glaa019,
                                 g_glaa020,g_glaa102,g_input.apcacomp,g_glaa121,g_glaa024,
                                 g_glaa100,g_glaa003
   SELECT glaa013 INTO g_glaa013 
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld
             
   IF g_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
    ELSE
      CALL cl_set_comp_visible('cont_no',TRUE)
    END IF
END FUNCTION

################################################################################
# Descriptions...: 檢核單據日期是否符合 #150212-00011#3
# Memo...........:
# Usage..........: CALL aapp330_chk_date(p_apcadocdt)
#                  RETURNING r_success,r_errno
# Date & Author..: 2015/03/03 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp330_chk_date(p_apcadocdt)
DEFINE p_apcadocdt     LIKE apca_t.apcadocdt
DEFINE l_year          LIKE type_t.num5
DEFINE l_month         LIKE type_t.num5
DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
DEFINE l_glav002       LIKE glav_t.glav002
DEFINE l_glav005       LIKE glav_t.glav005
DEFINE l_glav006       LIKE glav_t.glav006
DEFINE l_glav007       LIKE glav_t.glav007
DEFINE l_wdate         LIKE glav_t.glav004
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         LIKE type_t.chr100
   
   LET r_success = TRUE
   
   #判斷傳票日期有值否，有值用此來推算出當期會計週期起始日，單據的立帳日必須在這區間內
   IF NOT cl_null(g_input.glapdocdt) THEN
      #取得會計週期參照表
      LET l_year = YEAR(g_input.glapdocdt)
      LET l_month = MONTH(g_input.glapdocdt)
      #取得會計當期起始日
      CALL s_get_accdate(g_glaa003,'',l_year,l_month)
            RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_wdate,l_wdate,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate,l_wdate
      IF NOT cl_null(l_pdate_s) AND NOT cl_null(l_pdate_e) THEN
         IF p_apcadocdt < l_pdate_s OR p_apcadocdt > l_pdate_e THEN
            LET r_errno = 'aap-00340'
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   #判斷立帳日期>關帳日
   IF NOT cl_null(g_glaa013) THEN
      IF p_apcadocdt <= g_glaa013 THEN
         LET r_errno = 'aap-00341'
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success,r_errno
   
END FUNCTION

################################################################################
# Descriptions...: 单笔传参数产生凭证
# Memo...........:
# Usage..........: CALL aapp330_p()

# Date & Author..: 2015/11/30 By muping
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp330_p()
   DEFINE l_start_no      LIKE glap_t.glapdocno
   DEFINE l_end_no        LIKE glap_t.glapdocno 
    
    
    CALL s_transaction_begin()   
    DELETE  FROM s_voucher_tmp
    CALL cl_err_collect_init()
   

    #若以原單據日期立帳
    IF cl_null(g_input.glapdocdt) OR g_input.glapdocdt < = g_glaa013 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'aap-00077'
      
       LET g_errparam.extend = ''                                  
       LET g_errparam.popup = TRUE
       LET g_errparam.coll_vals[1]  = g_qbe.apcadocno
       CALL cl_err()
                                         
       CALL s_transaction_end('N','Y')                               
    END IF
    
    CALL aapp330_chk_date(g_input.glapdocdt) RETURNING g_sub_success,g_errno
    IF NOT g_sub_success THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = g_errno
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       LET g_errparam.coll_vals[1]  = g_qbe.apcadocno
       CALL cl_err()
       CALL s_transaction_end('N','Y') 
    END IF
          
    CALL cl_err_collect_show()

    INSERT INTO s_voucher_tmp (docno,type)
          VALUES ( g_qbe.apcadocno , '0' )
   # CALL aapp330_set_ld_info(g_input.apcald)     
    IF NOT g_glaa121 = 'Y' THEN                 
       CALL s_aapp330_gen_ac('1','P10',g_input.apcald,'','',g_input.type,'!#@','Y') RETURNING g_sub_success,l_start_no,l_end_no
    END IF
    IF g_sub_success THEN
       CALL s_transaction_end('Y','Y')
    ELSE
       CALL s_transaction_end('N','Y')
    END IF   
        
        
        
        
    CALL s_transaction_begin()               
    CALL cl_err_collect_init()
    CALL s_aapp330_generate_voucher('P10',g_input.glapdocno,g_input.glapdocdt,g_input.apcald,g_input.type,'Y',g_glaa102,'AP')
         RETURNING g_sub_success,g_input.glstr_no,g_input.glend_no
    CALL cl_err_collect_show()   
    IF g_sub_success AND NOT cl_null(g_input.glend_no) THEN
       CALL s_transaction_end('Y','Y')
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'adz-00217'
       LET g_errparam.popup = TRUE
       CALL cl_err()
    ELSE
       CALL s_transaction_end('N','Y')
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'adz-00218'
       LET g_errparam.popup = TRUE
       CALL cl_err()
    END IF  
    

END FUNCTION

################################################################################
# Descriptions...: 帳款單性質條件取SCC8502應用碼五=Y
# Memo...........: #160909-00015#3
# Usage..........: CALL aapp330_apca001_scc()
# Date & Author..: 160213 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp330_apca001_scc()
DEFINE l_gzcb002 LIKE gzcb_t.gzcb002   
DEFINE l_str     STRING

   LET l_str = ''
   LET l_gzcb002 = ''
   LET g_apca001_scc = ''
   
   DECLARE sel_gzcb002 CURSOR FOR SELECT gzcb002 FROM gzcb_t WHERE gzcb001='8502' AND gzcb007="Y"
   FOREACH sel_gzcb002 INTO l_gzcb002
      IF cl_null(l_str) THEN
         LET l_str = l_gzcb002
      ELSE
         LET l_str = l_str,",",l_gzcb002
      END IF
   END FOREACH

   CALL cl_set_combo_scc_part('apca001','8502',l_str) 
   LET g_apca001_scc = s_fin_get_wc_str(l_str)
   IF cl_null(g_apca001_scc) THEN LET g_apca001_scc = "1=1" END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
