#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp135.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-01-30 11:32:36), PR版次:0014(2016-12-01 14:17:43)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000183
#+ Filename...: axrp135
#+ Description: 應收立帳單批次還原作業
#+ Creator....: 01727(2014-06-10 11:30:27)
#+ Modifier...: 02114 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp135.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
# Modify.....: 150126-00011#01 2015/01/27 By zhangwei 1.加帳務中心在帳套前,QBE帳務中心拿掉
#            :                                        2.帳務中心樹下的都可刪
#            :                                        3.發票訊息頁拿掉
#            :                                        4.xrca001 IN (01,02,12,17,22) 才可還原
#            :                                        5.已確認單據不可還原
# Modify.....: 151231-00010#9  2016/03/04 By 02599    增加控制组权限控管
# Modify.....: 151008-00009#8  2016/06/27 By 03538    有對應的遞延檔,需要刪除;已有被其他axrt470沖銷者,不可刪除;還原子檔失敗時應給為FALSE
# Modify.....: 160731-00372#1  2016/08/15 By 07900    客户开窗不要开供应商
# Modify.....: 160811-00009#4  2016/08/22 By 01531    账务中心/法人/账套权限控管
# Modify.....: 161021-00050#2  2016/10/24 By 08729    處理組織開窗
# Modify.....: 161111-00049#6  2016/11/24 By 01727    控制组权限修改
# Modify.....: 161128-00061#3  2016/12/01 by 02481    标准程式定义采用宣告模式,弃用.*写法

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
        sel             LIKE type_t.chr1,
        xrcasite        LIKE type_t.chr200,
        xrca004         LIKE type_t.chr200,
        xrca001         LIKE xrca_t.xrca001,
        xrcadocno       LIKE xrca_t.xrcadocno,
        xrcadocdt       LIKE xrca_t.xrcadocdt,
        xrca108         LIKE xrca_t.xrca108,
        xrca106         LIKE xrca_t.xrca106,
        xrca100         LIKE xrca_t.xrca100,
        xrca003         LIKE type_t.chr200,
        xrca014         LIKE type_t.chr200,
        xrcacrtid       LIKE type_t.chr200,
        xrcacrtdt       LIKE xrca_t.xrcacrtdt
                     END RECORD
TYPE type_g_xrca_m   RECORD
      xrcasite          LIKE xrca_t.xrcasite,
      xrcasite_desc     LIKE ooefl_t.ooefl003,
      xrcald            LIKE xrca_t.xrcald,
      xrcald_desc       LIKE glaal_t.glaal002,
      xrcacomp          LIKE type_t.chr200
                     END RECORD
DEFINE g_xrca_m      type_g_xrca_m
#161128-00061#3-----modify--begin----------
#DEFINE g_glaa        RECORD LIKE glaa_t.*
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
       
#161128-00061#3-----modify--end----------
DEFINE g_success     LIKE type_t.chr1
DEFINE g_totsuccess  LIKE type_t.chr1
#20150201#1  By zhangweib Add  ---(S)---
TYPE type_g_xrca_d   RECORD
        xrcadocno    LIKE xrca_t.xrcadocno,
        xrcadocdt    LIKE xrca_t.xrcadocdt,
        xrca001      LIKE xrca_t.xrca001
                     END RECORD
DEFINE g_xrca_d DYNAMIC ARRAY OF type_g_xrca_d
#20150201#1  By zhangweib Add  ---(S)---
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_rec_b       LIKE type_t.num5              #單身筆數
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_rec_b1      LIKE type_t.num5
DEFINE l_ac1         LIKE type_t.num5
DEFINE g_sql_ctrl    STRING   #151231-00010#9 add
#end add-point
 
{</section>}
 
{<section id="axrp135.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_fin_create_account_center_tmp()  #20150424 add lujh
   CALL s_axrt470_declare()                #151008-00009#8
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #20150424--add--str--lujh
      CALL axrp135_def()
      CALL axrp135_ar_rollback()
      #20150424--add--end--lujh
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp135 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp135_init()   
 
      #進入選單 Menu (="N")
      CALL axrp135_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp135
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp135.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp135_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("b_xrca001",8302)
   CALL cl_set_combo_scc("b_xrcastus",13)
   CALL cl_set_combo_scc("b_isafstus",13)
   #CALL s_fin_create_account_center_tmp()   #20150424 mark lujh
   #151231-00010#9--add--str--
   LET g_sql_ctrl = NULL
   CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #151231-00010#9--add--end
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp135.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp135_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_xrcacomp_desc   LIKE ooefl_t.ooefl004
   DEFINE l_ooag003         LIKE ooag_t.ooag003
   DEFINE ls_wc             STRING
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp135_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         INPUT BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcald ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               CALL axrp135_def()

            AFTER FIELD xrcald
              IF NOT cl_null(g_xrca_m.xrcald) THEN 
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 IF NOT l_success THEN
                    #161128-00061#3-----modify--begin----------
                    #SELECT * INTO g_glaa.* 
                     SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                            glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                            glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                            glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                            glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                            glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                    #161128-00061#3-----modify--end----------
                    FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_xrca_m.xrcald
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 LET g_xrca_m.xrcald_desc = ''
              END IF
              #161128-00061#3-----modify--begin----------
              #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
              #161128-00061#3-----modify--end----------
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
              #161111-00049#6 Add  ---(S)---
              CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
                 RETURNING g_sub_success,g_sql_ctrl
              #161111-00049#6 Add  ---(E)---
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp

           AFTER FIELD xrcasite
              IF NOT cl_null(g_xrca_m.xrcasite) THEN
                 #161021-00050#2-add(s)
                 CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                    IF NOT cl_null(g_errno) THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = g_errno
                       LET g_errparam.extend = g_xrca_m.xrcasite
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET g_xrca_m.xrcasite = ''
                       LET g_xrca_m.xrcald = ''
                       LET g_xrca_m.xrcasite_desc = ''
                       LET g_xrca_m.xrcald_desc = ''
                       DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                       DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                       NEXT FIELD CURRENT
                    END IF
                 #161021-00050#2-add(e)  
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
                 DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 DISPLAY BY NAME g_xrca_m.xrcacomp
                 IF NOT l_success THEN NEXT FIELD CURRENT END IF
              ELSE
                 LET g_xrca_m.xrcasite_desc = ''
              END IF
              #161128-00061#3-----modify--begin----------
              #SELECT * INTO g_glaa.* 
               SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                      glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                      glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                      glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                      glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                      glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
              #161128-00061#3-----modify--end---------- 
              FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
              IF NOT cl_null(g_glaa.glaacomp) THEN
                 CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                 LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
              ELSE
                 LET g_xrca_m.xrcacomp = ''
              END IF
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp
              #161111-00049#6 Add  ---(S)---
              CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
                 RETURNING g_sub_success,g_sql_ctrl
              #161111-00049#6 Add  ---(E)---

            ON ACTION controlp INFIELD xrcald
              #取得帳務組織下所屬成員
              CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
              #取得帳務組織下所屬成員之帳別   
              CALL s_fin_account_center_comp_str() RETURNING ls_wc
              #將取回的字串轉換為SQL條件
              CALL axrp135_get_ooef001_wc(ls_wc) RETURNING ls_wc  
              #開窗i段
			     INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
			     LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xrca_m.xrcald             #給予default值
#160811-00009#4 mod s---              
#              IF NOT cl_null(ls_wc) AND ls_wc <> '(\'\')' THEN
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#              ELSE
#                 LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y')"
#              END IF
              LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""
#160811-00009#4 mod e---
              LET g_qryparam.arg1 = g_user
              LET g_qryparam.arg2 = g_dept
              CALL  q_authorised_ld()                                  #呼叫開窗
              LET g_xrca_m.xrcald = g_qryparam.return1       #將開窗取得的值回傳到變數
              IF NOT cl_null(g_xrca_m.xrcald) THEN
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'ld')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 #161128-00061#3-----modify--begin----------
                 #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                 #161128-00061#3-----modify--end---------- 
                 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
                 IF NOT cl_null(g_glaa.glaacomp) THEN
                    CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                    LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
                 ELSE
                    LET g_xrca_m.xrcacomp = ''
                 END IF
              END IF
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc,g_xrca_m.xrcacomp
              NEXT FIELD xrcald                              #返回原欄位  

           ON ACTION controlp INFIELD xrcasite
              #開窗i段
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xrca_m.xrcasite             #給予default值
              #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4
              #給予arg
              #CALL q_ooef001()                                        #呼叫開窗   #161021-00050#2 mark
              CALL q_ooef001_46()                                                 #161021-00050#2 add
              LET g_xrca_m.xrcasite = g_qryparam.return1              #將開窗取得的值回傳到變數
              CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
              IF NOT cl_null(g_xrca_m.xrcasite) THEN
                 CALL s_axrt300_site_geared_ld(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,g_today,'site')
                    RETURNING l_success,g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,g_xrca_m.xrcald,g_xrca_m.xrcald_desc
                 #161128-00061#3-----modify--begin----------
                 #SELECT * INTO g_glaa.* 
                  SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                         glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                         glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                         glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                         glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                         glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                 #161128-00061#3-----modify--end----------
                 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
                 IF NOT cl_null(g_glaa.glaacomp) THEN
                    CALL s_axrt300_xrca_ref('xrcasite',g_glaa.glaacomp,'','') RETURNING l_success,g_xrca_m.xrcacomp
                    LET g_xrca_m.xrcacomp = g_glaa.glaacomp,'(', g_xrca_m.xrcacomp , ')'
                 ELSE
                    LET g_xrca_m.xrcacomp = ''
                 END IF
              END IF
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              DISPLAY BY NAME g_xrca_m.xrcald,g_xrca_m.xrcald_desc
              DISPLAY BY NAME g_xrca_m.xrcacomp
              DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc
              NEXT FIELD xrcasite

           #AFTER INPUT
           #   CALL axrp135_b_fill()

         END INPUT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         CONSTRUCT g_wc ON xrca004,xrcadocdt,xrca003,xrcadocno,xrcacrtid
                      FROM xrca004,xrcadocdt,xrca003,xrcadocno,xrcacrtid

            ON ACTION controlp INFIELD xrca004
               #開窗c段
	   		   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      #151231-00010#9--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #151231-00010#9--add--end
               #160731-00372#1   2016/08/15  By 07900 --s--
                IF cl_null(g_qryparam.where) THEN
                   LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3')"
                ELSE 
                   LET g_qryparam.where =" (pmaa002 ='2' OR pmaa002='3') AND ",g_qryparam.where            
                END IF 
                #160731-00372#1   2016/08/15  By 07900 --e--
               CALL q_pmaa001_7()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca004      #顯示到畫面上
               
               NEXT FIELD xrca004                         #返回原欄位

            ON ACTION controlp INFIELD xrcasite
               #開窗c段
	   		   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef201 = 'Y' "

               #給予arg

               #CALL q_ooef001()                           #呼叫開窗    #161021-00050#2 mark
               CALL q_ooef001_46()                                     #161021-00050#2 add
               DISPLAY g_qryparam.return1 TO xrcasite     #顯示到畫面上
               
               NEXT FIELD xrcasite                        #返回原欄位

            ON ACTION controlp INFIELD xrca003
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca003      #顯示到畫面上
               
               NEXT FIELD xrca003                         #返回原欄位

            ON ACTION controlp INFIELD xrcadocno
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " xrcald = '",g_xrca_m.xrcald,"'"
			      #151231-00010#9--add--str--
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaa001 = xrca004 )"
               END IF
               #151231-00010#9--add--end
               CALL q_xrcadocno_5()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcadocno    #顯示到畫面上
              
               NEXT FIELD xrcadocno                       #返回原欄位

            ON ACTION controlp INFIELD xrcacrtid
               #開窗c段
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrcacrtid    #顯示到畫面上
               
               NEXT FIELD xrcacrtid                       #返回原欄位

         END CONSTRUCT
         INPUT ARRAY g_detail_d FROM s_detail1.* 
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)    
            ON CHANGE sel
               LET l_ac = ARR_CURR()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL axrp135_click_chk(l_ac)
               END IF
               
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
        #DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
        #
        #   BEFORE ROW
        #      LET l_ac = DIALOG.getCurrentRow("s_detail1")
        #      DISPLAY l_ac TO FORMONLY.h_index
        #      
        #   BEFORE DISPLAY
        #      CALL FGL_SET_ARR_CURR(g_detail_idx)
        #      LET l_ac = DIALOG.getCurrentRow("s_detail1")
        #      
        #END DISPLAY
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
            NEXT FIELD xrcasite
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
            CALL axrp135_click_chk(0)
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
            IF g_detail_d.getLength() > 0 THEN
               IF l_ac > 0 THEN
                  CALL axrp135_click_chk(l_ac)
               ELSE
                  CALL axrp135_click_chk(1)
               END IF
            END IF
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
            CALL axrp135_filter()
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
            CALL axrp135_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            CALL axrp135_def()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp135_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL axrp135_ar_rollback()
            CALL axrp135_b_fill()

         ON ACTION modify_detail
            LET l_ac = DIALOG.getCurrentRow("s_detail1")
            IF g_detail_d[l_ac].sel = "Y" THEN
               LET g_detail_d[l_ac].sel = "N"
            ELSE
               CALL axrp135_click_chk(l_ac)
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
 
{<section id="axrp135.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp135_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axrp135_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp135.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp135_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_desc          LIKE type_t.chr200
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF

   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_xrca_m.xrcasite,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   IF cl_null(ls_wc) THEN LET ls_wc = g_xrca_m.xrcasite END IF
   #將取回的字串轉換為SQL條件
   CALL axrp135_get_ooef001_wc(ls_wc) RETURNING ls_wc  

   LET g_sql = "SELECT 'N',xrcasite,xrca004,xrca001,xrcadocno,xrcadocdt, ",
               "       xrca108,xrca106 + xrca107,xrca100,xrca003,xrca014,",
               "       xrcacrtid,xrcacrtdt                               ",
               " FROM xrca_t                                             ",
               "WHERE     xrcaent = ?       AND xrca017 <> '1'           ",
               "      AND xrcastus = 'N'                                 ",
               "      AND (xrca047 IS Null OR xrca047 = ' ')             ",
               "      AND xrca001 IN ('01','02','12','17','22')          ",
               "      AND ",g_wc CLIPPED ,
               "      AND xrcasite IN ",ls_wc,
               "      AND xrcald = '",g_xrca_m.xrcald,"'                 "
   #151231-00010#9--add--str--
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrcaent ",
                        "                AND pmaa001 = xrca004)"
   END IF
   #151231-00010#9--add--end
   #end add-point
 
   PREPARE axrp135_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp135_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
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
      IF cl_nuLL(g_detail_d[l_ac].xrca106) THEN LET g_detail_d[l_ac].xrca106 = 0 END IF

      IF NOT cl_null(g_detail_d[l_ac].xrca004) THEN
         CALL s_axrt300_xrca_ref('xrca004',g_detail_d[l_ac].xrca004,'','') RETURNING l_success,l_desc
         LET g_detail_d[l_ac].xrca004 = g_detail_d[l_ac].xrca004,"(",l_desc,")"
      END IF

      IF NOT cl_null(g_detail_d[l_ac].xrcasite) THEN
         CALL s_axrt300_xrca_ref('xrcasite',g_detail_d[l_ac].xrcasite,'','') RETURNING l_success,l_desc
         LET g_detail_d[l_ac].xrcasite = g_detail_d[l_ac].xrcasite,"(",l_desc,")"
      END IF

      IF NOT cl_null(g_detail_d[l_ac].xrca003) THEN
         CALL s_axrt300_xrca_ref('xrca003',g_detail_d[l_ac].xrca003,'','') RETURNING l_success,l_desc
         LET g_detail_d[l_ac].xrca003 = g_detail_d[l_ac].xrca003,"(",l_desc,")"
      END IF

      IF NOT cl_null(g_detail_d[l_ac].xrca014) THEN
         CALL s_axrt300_xrca_ref('xrca003',g_detail_d[l_ac].xrca014,'','') RETURNING l_success,l_desc
         LET g_detail_d[l_ac].xrca014 = g_detail_d[l_ac].xrca014,"(",l_desc,")"
      END IF

      IF NOT cl_null(g_detail_d[l_ac].xrcacrtid) THEN
         CALL s_axrt300_xrca_ref('xrca003',g_detail_d[l_ac].xrcacrtid,'','') RETURNING l_success,l_desc
         LET g_detail_d[l_ac].xrcacrtid = g_detail_d[l_ac].xrcacrtid,"(",l_desc,")"
      END IF

      #end add-point
      
      CALL axrp135_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp135_sel
   
   LET l_ac = 1
   CALL axrp135_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp135.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp135_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrp135.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp135_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp135.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp135_filter()
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
   
   CALL axrp135_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp135.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp135_filter_parser(ps_field)
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
 
{<section id="axrp135.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp135_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp135_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp135.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp135_def()
   DEFINE l_sql             STRING
   DEFINE l_xrcasite        LIKE xrca_t.xrcasite
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_xrcacomp_desc   LIKE ooefl_t.ooefl004
   DEFINE l_ooefl003        LIKE ooefl_t.ooefl003
   
   #20150424--add--str--lujh
   IF NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) THEN 
      LET g_bgjob            = g_argv[1]    #背景执行
      LET g_xrca_m.xrcasite  = g_argv[2]    #账务中心
      LET g_xrca_m.xrcald    = g_argv[3]    #账套
      LET g_wc = " xrcadocno IN '",g_argv[4],"'"  #单据编号字串 
      
      SELECT ooef017 INTO g_xrca_m.xrcacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_xrca_m.xrcasite
      #161128-00061#3-----modify--begin----------
      #SELECT * INTO g_glaa.* 
       SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
              glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
              glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
              glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
              glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
              glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161128-00061#3-----modify--end---------- 
      FROM FROM glaa_t WHERE glaaent = g_enterprise AND glaald  = g_xrca_m.xrcald
   ELSE
   #20150424--add--end--lujh
      IF cl_null(g_xrca_m.xrcasite) OR cl_null(g_xrca_m.xrcald) THEN
         #帳務中心
         #帳務中心
         #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
         CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_xrca_m.xrcasite,g_errno
         CALL s_desc_get_department_desc(g_xrca_m.xrcasite) RETURNING g_xrca_m.xrcasite_desc
         #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
         CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_xrca_m.xrcald,g_xrca_m.xrcacomp,g_errno
         CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
      
        #若取不出資料，則預設帳別/法人為空
        IF NOT g_sub_success THEN
           LET g_xrca_m.xrcald   = ''
           LET g_xrca_m.xrcacomp = ''
        END IF
      
        #用帳務中心取得帳別與法人
        IF cl_null(g_xrca_m.xrcald) THEN
           CALL s_fin_orga_get_comp_ld(g_xrca_m.xrcasite) RETURNING g_sub_success,g_errno,g_xrca_m.xrcacomp,g_xrca_m.xrcald
           CALL s_fin_account_center_with_ld_chk(g_xrca_m.xrcasite,g_xrca_m.xrcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
        END IF
      
         #若取不出資料,則不預設帳別
         IF NOT g_sub_success THEN
            LET g_xrca_m.xrcald   = ''
            LET g_xrca_m.xrcacomp = ''
         END IF
         CALL s_axrt300_xrca_ref('xrcald',g_xrca_m.xrcald,'','') RETURNING l_success,g_xrca_m.xrcald_desc
         #161128-00061#3-----modify--begin----------
         #SELECT * INTO g_glaa.* 
          SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                 glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                 glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                 glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                 glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                 glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
         #161128-00061#3-----modify--end----------
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_xrca_m.xrcald
         CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcasite,'','') RETURNING l_success,g_xrca_m.xrcasite_desc
         CALL s_axrt300_xrca_ref('xrcasite',g_xrca_m.xrcacomp,'','') RETURNING l_success,l_ooefl003
         IF NOT cl_null(g_xrca_m.xrcacomp) THEN
            LET g_xrca_m.xrcacomp = g_xrca_m.xrcacomp,'(',l_ooefl003,')'
         ELSE
            LET g_xrca_m.xrcacomp = ""
         END IF
         DISPLAY BY NAME g_xrca_m.xrcasite,g_xrca_m.xrcasite_desc,
                         g_xrca_m.xrcald,  g_xrca_m.xrcald_desc,
                         g_xrca_m.xrcacomp
      END IF
   END IF    #20150424 add lujh

   #161111-00049#6 Add  ---(S)---
   #161128-00061#3-----modify--begin----------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
           glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
           glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
           glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
           glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
   #161128-00061#3-----modify--end----------
   FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.xrcald
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_glaa.glaacomp)
      RETURNING g_sub_success,g_sql_ctrl
   #161111-00049#6 Add  ---(E)---

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp135_ar_rollback()
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_dfin0030    LIKE type_t.chr1
   DEFINE l_ooba002     LIKE ooba_t.ooba002
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_s           LIKE type_t.num5
   #161128-00061#3-----modify--begin----------
   #DEFINE l_xrcb        RECORD LIKE xrcb_t.*
   #DEFINE l_xrde        RECORD LIKE xrde_t.*
   #DEFINE l_xrce        RECORD LIKE xrce_t.*
   DEFINE l_xrcb RECORD  #應收憑單單身
       xrcbent LIKE xrcb_t.xrcbent, #企業編號
       xrcbld LIKE xrcb_t.xrcbld, #帳套
       xrcbdocno LIKE xrcb_t.xrcbdocno, #單號
       xrcbseq LIKE xrcb_t.xrcbseq, #項次
       xrcbsite LIKE xrcb_t.xrcbsite, #營運據點
       xrcborga LIKE xrcb_t.xrcborga, #帳務來源SITE
       xrcb001 LIKE xrcb_t.xrcb001, #來源類型
       xrcb002 LIKE xrcb_t.xrcb002, #來源業務單據號碼
       xrcb003 LIKE xrcb_t.xrcb003, #來源業務單據項次
       xrcb004 LIKE xrcb_t.xrcb004, #產品編號
       xrcb005 LIKE xrcb_t.xrcb005, #品名規格
       xrcb006 LIKE xrcb_t.xrcb006, #單位
       xrcb007 LIKE xrcb_t.xrcb007, #計價數量
       xrcb008 LIKE xrcb_t.xrcb008, #參考單據號碼
       xrcb009 LIKE xrcb_t.xrcb009, #參考單號項次
       xrcblegl LIKE xrcb_t.xrcblegl, #核算組織
       xrcb010 LIKE xrcb_t.xrcb010, #業務部門
       xrcb011 LIKE xrcb_t.xrcb011, #責任中心
       xrcb012 LIKE xrcb_t.xrcb012, #產品類別
       xrcb013 LIKE xrcb_t.xrcb013, #發票帳否(搭贈/備品/樣品)
       xrcb014 LIKE xrcb_t.xrcb014, #理由碼
       xrcb015 LIKE xrcb_t.xrcb015, #專案編號
       xrcb016 LIKE xrcb_t.xrcb016, #WBS編號
       xrcb017 LIKE xrcb_t.xrcb017, #預算細項
       xrcb018 LIKE xrcb_t.xrcb018, #商戶編號
       xrcb019 LIKE xrcb_t.xrcb019, #開票性質
       xrcb020 LIKE xrcb_t.xrcb020, #稅別
       xrcb021 LIKE xrcb_t.xrcb021, #收入會計科目
       xrcb022 LIKE xrcb_t.xrcb022, #正負值
       xrcb023 LIKE xrcb_t.xrcb023, #沖暫估單否
       xrcb024 LIKE xrcb_t.xrcb024, #區域
       xrcb025 LIKE xrcb_t.xrcb025, #傳票號碼
       xrcb026 LIKE xrcb_t.xrcb026, #傳票項次
       xrcb027 LIKE xrcb_t.xrcb027, #發票編號
       xrcb028 LIKE xrcb_t.xrcb028, #發票號碼
       xrcb029 LIKE xrcb_t.xrcb029, #應收帳款科目
       xrcb030 LIKE xrcb_t.xrcb030, #已開發票數量
       xrcb031 LIKE xrcb_t.xrcb031, #收款條件編號
       xrcb032 LIKE xrcb_t.xrcb032, #訂金序次
       xrcb033 LIKE xrcb_t.xrcb033, #經營方式
       xrcb034 LIKE xrcb_t.xrcb034, #通路
       xrcb035 LIKE xrcb_t.xrcb035, #品牌
       xrcb036 LIKE xrcb_t.xrcb036, #客群
       xrcb037 LIKE xrcb_t.xrcb037, #自由核算項一
       xrcb038 LIKE xrcb_t.xrcb038, #自由核算項二
       xrcb039 LIKE xrcb_t.xrcb039, #自由核算項三
       xrcb040 LIKE xrcb_t.xrcb040, #自由核算項四
       xrcb041 LIKE xrcb_t.xrcb041, #自由核算項五
       xrcb042 LIKE xrcb_t.xrcb042, #自由核算項六
       xrcb043 LIKE xrcb_t.xrcb043, #自由核算項七
       xrcb044 LIKE xrcb_t.xrcb044, #自由核算項八
       xrcb045 LIKE xrcb_t.xrcb045, #自由核算項九
       xrcb046 LIKE xrcb_t.xrcb046, #自由核算項十
       xrcb047 LIKE xrcb_t.xrcb047, #摘要
       xrcb048 LIKE xrcb_t.xrcb048, #客戶訂購單號
       xrcb049 LIKE xrcb_t.xrcb049, #開票單號
       xrcb050 LIKE xrcb_t.xrcb050, #開票項次
       xrcb051 LIKE xrcb_t.xrcb051, #業務人員
       xrcb100 LIKE xrcb_t.xrcb100, #交易原幣
       xrcb101 LIKE xrcb_t.xrcb101, #交易原幣單價
       xrcb102 LIKE xrcb_t.xrcb102, #交易匯率
       xrcb103 LIKE xrcb_t.xrcb103, #交易原幣未稅金額
       xrcb104 LIKE xrcb_t.xrcb104, #交易原幣稅額
       xrcb105 LIKE xrcb_t.xrcb105, #交易原幣含稅金額
       xrcb106 LIKE xrcb_t.xrcb106, #交易原幣調整差異金額
       xrcb111 LIKE xrcb_t.xrcb111, #本幣單價
       xrcb113 LIKE xrcb_t.xrcb113, #本幣未稅金額
       xrcb114 LIKE xrcb_t.xrcb114, #本幣稅額
       xrcb115 LIKE xrcb_t.xrcb115, #本幣含稅金額
       xrcb116 LIKE xrcb_t.xrcb116, #本幣調整差異金額
       xrcb117 LIKE xrcb_t.xrcb117, #已開發票金額(未稅)
       xrcb118 LIKE xrcb_t.xrcb118, #應開發票未稅金額
       xrcb119 LIKE xrcb_t.xrcb119, #應開發票含稅金額
       xrcb121 LIKE xrcb_t.xrcb121, #本位幣二匯率
       xrcb123 LIKE xrcb_t.xrcb123, #本位幣二未稅金額
       xrcb124 LIKE xrcb_t.xrcb124, #本位幣二稅額
       xrcb125 LIKE xrcb_t.xrcb125, #本位幣二含稅金額
       xrcb126 LIKE xrcb_t.xrcb126, #本位幣二調整差異金額
       xrcb131 LIKE xrcb_t.xrcb131, #本位幣三匯率
       xrcb133 LIKE xrcb_t.xrcb133, #本位幣三未稅金額
       xrcb134 LIKE xrcb_t.xrcb134, #本位幣三稅額
       xrcb135 LIKE xrcb_t.xrcb135, #本位幣三含稅金額
       xrcb136 LIKE xrcb_t.xrcb136, #本位幣三調整差異金額
       xrcb052 LIKE xrcb_t.xrcb052, #款別編號
       xrcb053 LIKE xrcb_t.xrcb053, #帳款對象
       xrcb054 LIKE xrcb_t.xrcb054, #收款對象
       xrcb055 LIKE xrcb_t.xrcb055, #收現金額(流通)
       xrcb056 LIKE xrcb_t.xrcb056, #應收金額(流通)
       xrcb057 LIKE xrcb_t.xrcb057, #扣款金額(流通)
       xrcb058 LIKE xrcb_t.xrcb058, #預收科目
       xrcb059 LIKE xrcb_t.xrcb059, #代收銀科目
       xrcb060 LIKE xrcb_t.xrcb060, #月份類型
       xrcb107 LIKE xrcb_t.xrcb107  #出貨單單價
       END RECORD
   DEFINE l_xrde RECORD  #收款及差異處理明細檔
       xrdeent LIKE xrde_t.xrdeent, #企業編號
       xrdecomp LIKE xrde_t.xrdecomp, #法人
       xrdeld LIKE xrde_t.xrdeld, #帳套
       xrdedocno LIKE xrde_t.xrdedocno, #沖銷單單號
       xrdeseq LIKE xrde_t.xrdeseq, #項次
       xrdesite LIKE xrde_t.xrdesite, #帳務中心
       xrdeorga LIKE xrde_t.xrdeorga, #帳務歸屬組織
       xrde001 LIKE xrde_t.xrde001, #來源作業
       xrde002 LIKE xrde_t.xrde002, #沖銷帳款類型
       xrde003 LIKE xrde_t.xrde003, #來源單號
       xrde004 LIKE xrde_t.xrde004, #來源單項次
       xrde006 LIKE xrde_t.xrde006, #款別編號
       xrde007 LIKE xrde_t.xrde007, #款別編號
       xrde008 LIKE xrde_t.xrde008, #帳戶/票券號碼
       xrde010 LIKE xrde_t.xrde010, #摘要
       xrde011 LIKE xrde_t.xrde011, #銀行存提碼
       xrde012 LIKE xrde_t.xrde012, #現金變動碼
       xrde013 LIKE xrde_t.xrde013, #轉入客商碼
       xrde014 LIKE xrde_t.xrde014, #轉入帳款單編號
       xrde015 LIKE xrde_t.xrde015, #沖銷加減項
       xrde016 LIKE xrde_t.xrde016, #沖銷會科
       xrde017 LIKE xrde_t.xrde017, #業務人員
       xrde018 LIKE xrde_t.xrde018, #業務部門
       xrde019 LIKE xrde_t.xrde019, #責任中心
       xrde020 LIKE xrde_t.xrde020, #產品類別
       xrde022 LIKE xrde_t.xrde022, #專案編號
       xrde023 LIKE xrde_t.xrde023, #WBS編號
       xrde028 LIKE xrde_t.xrde028, #產生方式
       xrde029 LIKE xrde_t.xrde029, #傳票號碼
       xrde030 LIKE xrde_t.xrde030, #傳票項次
       xrde035 LIKE xrde_t.xrde035, #區域
       xrde036 LIKE xrde_t.xrde036, #客群
       xrde038 LIKE xrde_t.xrde038, #對象
       xrde039 LIKE xrde_t.xrde039, #經營方式
       xrde040 LIKE xrde_t.xrde040, #通路
       xrde041 LIKE xrde_t.xrde041, #品牌
       xrde042 LIKE xrde_t.xrde042, #自由核算項一
       xrde043 LIKE xrde_t.xrde043, #自由核算項二
       xrde044 LIKE xrde_t.xrde044, #自由核算項三
       xrde045 LIKE xrde_t.xrde045, #自由核算項四
       xrde046 LIKE xrde_t.xrde046, #自由核算項五
       xrde047 LIKE xrde_t.xrde047, #自由核算項六
       xrde048 LIKE xrde_t.xrde048, #自由核算項七
       xrde049 LIKE xrde_t.xrde049, #自由核算項八
       xrde050 LIKE xrde_t.xrde050, #自由核算項九
       xrde051 LIKE xrde_t.xrde051, #自由核算項十
       xrde100 LIKE xrde_t.xrde100, #幣別
       xrde101 LIKE xrde_t.xrde101, #匯率
       xrde109 LIKE xrde_t.xrde109, #原幣沖帳金額
       xrde119 LIKE xrde_t.xrde119, #本幣沖帳金額
       xrde120 LIKE xrde_t.xrde120, #本位幣二幣別
       xrde121 LIKE xrde_t.xrde121, #本位幣二匯率
       xrde129 LIKE xrde_t.xrde129, #本位幣二沖帳金額
       xrde130 LIKE xrde_t.xrde130, #本位幣三幣別
       xrde131 LIKE xrde_t.xrde131, #本位幣三匯率
       xrde139 LIKE xrde_t.xrde139, #本位幣三沖帳金額
       xrde032 LIKE xrde_t.xrde032, #收款日期
       xrde108 LIKE xrde_t.xrde108, #原幣手續費
       xrde118 LIKE xrde_t.xrde118  #本幣手續費
       END RECORD
   DEFINE l_xrce RECORD  #應收沖銷明細檔
       xrceent LIKE xrce_t.xrceent, #企業編號
       xrcecomp LIKE xrce_t.xrcecomp, #法人
       xrceld LIKE xrce_t.xrceld, #帳套
       xrcedocno LIKE xrce_t.xrcedocno, #沖銷單單號
       xrceseq LIKE xrce_t.xrceseq, #項次
       xrcelegl LIKE xrce_t.xrcelegl, #no use
       xrcesite LIKE xrce_t.xrcesite, #帳務中心
       xrceorga LIKE xrce_t.xrceorga, #帳務歸屬組織
       xrce001 LIKE xrce_t.xrce001, #來源作業
       xrce002 LIKE xrce_t.xrce002, #沖銷類型
       xrce003 LIKE xrce_t.xrce003, #沖銷帳款單單號
       xrce004 LIKE xrce_t.xrce004, #沖銷帳款單項次
       xrce005 LIKE xrce_t.xrce005, #沖銷帳款單帳期
       xrce006 LIKE xrce_t.xrce006, #no use
       xrce007 LIKE xrce_t.xrce007, #no use
       xrce008 LIKE xrce_t.xrce008, #no use
       xrce009 LIKE xrce_t.xrce009, #no use
       xrce010 LIKE xrce_t.xrce010, #摘要說明
       xrce011 LIKE xrce_t.xrce011, #no use
       xrce012 LIKE xrce_t.xrce012, #no use
       xrce013 LIKE xrce_t.xrce013, #no use
       xrce014 LIKE xrce_t.xrce014, #no use
       xrce015 LIKE xrce_t.xrce015, #沖銷加減項
       xrce016 LIKE xrce_t.xrce016, #沖銷科目
       xrce017 LIKE xrce_t.xrce017, #業務人員
       xrce018 LIKE xrce_t.xrce018, #業務部門
       xrce019 LIKE xrce_t.xrce019, #責任中心
       xrce020 LIKE xrce_t.xrce020, #產品類別
       xrce021 LIKE xrce_t.xrce021, #no use
       xrce022 LIKE xrce_t.xrce022, #專案編號
       xrce023 LIKE xrce_t.xrce023, #WBS編號
       xrce024 LIKE xrce_t.xrce024, #第二參考單號
       xrce025 LIKE xrce_t.xrce025, #第二參考單號項次
       xrce026 LIKE xrce_t.xrce026, #no use
       xrce027 LIKE xrce_t.xrce027, #應稅折抵否
       xrce028 LIKE xrce_t.xrce028, #產生方式
       xrce029 LIKE xrce_t.xrce029, #傳票號碼
       xrce030 LIKE xrce_t.xrce030, #傳票項次
       xrce035 LIKE xrce_t.xrce035, #區域
       xrce036 LIKE xrce_t.xrce036, #客戶分類
       xrce037 LIKE xrce_t.xrce037, #no use
       xrce038 LIKE xrce_t.xrce038, #對象
       xrce039 LIKE xrce_t.xrce039, #經營方式
       xrce040 LIKE xrce_t.xrce040, #通路
       xrce041 LIKE xrce_t.xrce041, #品牌
       xrce042 LIKE xrce_t.xrce042, #自由核算項一
       xrce043 LIKE xrce_t.xrce043, #自由核算項二
       xrce044 LIKE xrce_t.xrce044, #自由核算項三
       xrce045 LIKE xrce_t.xrce045, #自由核算項四
       xrce046 LIKE xrce_t.xrce046, #自由核算項五
       xrce047 LIKE xrce_t.xrce047, #自由核算項六
       xrce048 LIKE xrce_t.xrce048, #自由核算項七
       xrce049 LIKE xrce_t.xrce049, #自由核算項八
       xrce050 LIKE xrce_t.xrce050, #自由核算項九
       xrce051 LIKE xrce_t.xrce051, #自由核算項十
       xrce053 LIKE xrce_t.xrce053, #發票編號
       xrce054 LIKE xrce_t.xrce054, #發票號碼
       xrce100 LIKE xrce_t.xrce100, #幣別
       xrce101 LIKE xrce_t.xrce101, #匯率
       xrce104 LIKE xrce_t.xrce104, #原幣應稅折抵稅額
       xrce109 LIKE xrce_t.xrce109, #原幣沖帳金額
       xrce114 LIKE xrce_t.xrce114, #本幣應稅折抵稅額
       xrce119 LIKE xrce_t.xrce119, #本幣沖帳金額
       xrce120 LIKE xrce_t.xrce120, #本位幣二幣別
       xrce121 LIKE xrce_t.xrce121, #本位幣二匯率
       xrce124 LIKE xrce_t.xrce124, #本位幣二應稅折抵稅額
       xrce129 LIKE xrce_t.xrce129, #本位幣二沖帳金額
       xrce130 LIKE xrce_t.xrce130, #本位幣二幣別
       xrce131 LIKE xrce_t.xrce131, #本位幣三匯率
       xrce134 LIKE xrce_t.xrce134, #本位幣三應稅折抵稅額
       xrce139 LIKE xrce_t.xrce139, #本位幣三沖帳金額
       xrce055 LIKE xrce_t.xrce055, #費用編號
       xrce056 LIKE xrce_t.xrce056, #方向
       xrce057 LIKE xrce_t.xrce057, #預收待抵單號
       xrce058 LIKE xrce_t.xrce058, #應付單號
       xrce103 LIKE xrce_t.xrce103, #未稅原幣沖銷額
       xrce113 LIKE xrce_t.xrce113, #未稅本幣沖銷額
       xrce123 LIKE xrce_t.xrce123, #本位幣二未稅沖銷額
       xrce133 LIKE xrce_t.xrce133, #本位幣三未稅沖銷額
       xrce059 LIKE xrce_t.xrce059  #預收單號
       END RECORD
   #161128-00061#3-----modify--end----------
   DEFINE l_str         STRING
   DEFINE l_sql         STRING
   DEFINE ls_wc1        STRING
   DEFINE ls_wc2        STRING
   DEFINE ls_wc3        STRING
   DEFINE ls_wc4        STRING
   DEFINE ls_wc5        STRING
   DEFINE ls_wc6        STRING
   DEFINE l_ac          LIKE type_t.num5   #20150201#1 By zhangwei Add
   DEFINE li_idx        LIKE type_t.num5   #20150201#1 By zhangwei Add
   DEFINE l_doc_success  LIKE type_t.num5        #20150201  BY zhangwei
   DEFINE l_tot_success  LIKE type_t.num5        #20150201  BY zhangwei
   #151008-00009#8--s
   DEFINE ls_js  STRING
   DEFINE lc_param          RECORD
          xrcald            LIKE xrca_t.xrcald,        
          xrcadocno         LIKE xrca_t.xrcadocno,        
          type2             LIKE type_t.chr1       #刪除類型:1.刪除所有項次/2.刪除一筆項次
                        END RECORD
   #151008-00009#8--e

   #未查詢出資料時,直接返回
   LET l_count = g_detail_d.getLength()
   IF l_count < 1 THEN RETURN END IF
   
   #20150424--add--str--lujh
   IF NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) THEN  
      LET l_str = g_wc
      IF cl_null(l_str) THEN 
         LET l_str = " 1=1 "
      END IF 
   ELSE
   #20150424--add--end--lujh
      #未選擇任何資料料時,直接返回
      LET l_flag = 'N'
      LET l_str = Null
      FOR l_count = 1 TO g_detail_d.getLength()
         IF g_detail_d[l_count].sel = 'Y' THEN
            LET l_flag = 'Y'
            IF cl_null(l_str) THEN
               LET l_str = "xrcadocno IN ('",g_detail_d[l_count].xrcadocno,"'"
            ELSE
               LET l_str = l_str,",'",g_detail_d[l_count].xrcadocno,"'"
            END IF
         END IF
      END FOR
      IF l_flag = 'N' THEN RETURN END IF
      LET l_str = l_str,")"
   END IF  #20150424 add lujh

   #150126-00011#01 Add ---(S)---
   #   因為"已確認單據不可還原(2014/11/26 kris)",所以可執行性檢查無意義
   #150126-00011#01 Add ---(E)---

   #資料還原前,可執行性檢查
   #STEP1:有收款沖帳記錄及預計沖款者不可還原
   #STEP2:已產生傳票者不可還原
   #STEP3:對應的發票資料,皆尚無發票號碼者.
 　#      發票號碼空白或有發票號碼但已作廢者.任一筆發票已有正式發票號碼者,不可選取還原不可還原
   #STEP4:預收性質單據;必須檢核有無產生對應的"待抵"單據(21),須檢核該待抵單是否已有沖銷資料
   #         帳款性筫 = '11','12';檢核xrca019是否已有產生的待抵單號
   #         查核待抵單是否有沖銷記錄 sum(xrcc109) > 0
	#         檢核該單據是否有在其他單據上有預計沖銷記錄中(xrce_t)
   #      任一條件不符者,不可還原處理.
   #資料還原時,操作步驟
   #STEP1:取"帳款單身xrcb_t"資料
   #      1)依[來源作業]別,判斷應回寫的TABLE
   #      2)依[帳套別]判斷回寫的[己立帳數(金額)]欄位
   #      3)取"直接沖銷表xrce_t"資料
   #         1>依[沖銷類型]判斷應回寫的TABLE
   #         2>依[沖銷帳款單號]及[帳套別]回寫[己立帳數(金額)]欄位
   #※ 執行過程中,每筆單據之處理狀態應記入LOG,並於執行完成時,顯示執行結果.

   LET l_sql = "SELECT xrcadocno,xrcadocdt,xrca001 FROM xrca_t WHERE xrcaent = '",g_enterprise,"'",
               "   AND xrcald = '",g_xrca_m.xrcald,"'                          ",
               "   AND ",l_str CLIPPED,
               " ORDER BY xrcasite,xrcald,xrcadocno DESC"
   PREPARE axrp135_xrca_prep FROM l_sql
   DECLARE axrp135_xrca_curs CURSOR FOR axrp135_xrca_prep

   #20150201#1 By zhangwei Add  ---(S)---
   CALL g_xrca_d.clear()
   LET l_ac = 1
   FOREACH axrp135_xrca_curs INTO g_xrca_d[l_ac].*
      LET l_ac = l_ac + 1
   END FOREACH
   #20150201#1 By zhangwei Add  ---(E)---

   LET l_sql = "SELECT COUNT(doc) FROM (                                    ",
               "SELECT xrcadocno doc FROM xrca_t, xrce_t                    ",
               " WHERE     xrcald    = xrceld      AND xrcaent   = xrceent  ",
               "       AND xrcadocno = xrcedocno   AND xrcadocno = xrcedocno",
               "       AND xrcastus <> 'X'         AND xrce003 = ?          ",
               " UNION                                                      ",
               "SELECT xrdadocno doc FROM xrca_t,xrda_t,xrce_t              ",
               " WHERE     xrdaent   = xrcaent     AND xrdaent = xrceent    ",
               "       AND xrdadocno = xrcedocno   AND xrce003 = xrcadocno  ",
               "       AND xrdald    = xrcald      AND xrdald  = xrceld     ",
               "       AND xrdastus <> 'X'         AND xrcadocno = ? )      "
   PREPARE axrp135_cnt_prep FROM l_sql

  #161128-00061#3-----modify--begin----------
  #LET l_sql = "SELECT * FROM xrcb_t WHERE xrcbent = '",g_enterprise,"' AND xrcbld = '",g_xrca_m.xrcald,"' AND xrcbdocno = ?"
   LET l_sql = "SELECT xrcbent,xrcbld,xrcbdocno,xrcbseq,xrcbsite,xrcborga,xrcb001,xrcb002,",
               "xrcb003,xrcb004,xrcb005,xrcb006,xrcb007,xrcb008,xrcb009,xrcblegl,xrcb010,",
               "xrcb011,xrcb012,xrcb013,xrcb014,xrcb015,xrcb016,xrcb017,xrcb018,xrcb019,",
               "xrcb020,xrcb021,xrcb022,xrcb023,xrcb024,xrcb025,xrcb026,xrcb027,xrcb028,",
               "xrcb029,xrcb030,xrcb031,xrcb032,xrcb033,xrcb034,xrcb035,xrcb036,xrcb037,",
               "xrcb038,xrcb039,xrcb040,xrcb041,xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,",
               "xrcb047,xrcb048,xrcb049,xrcb050,xrcb051,xrcb100,xrcb101,xrcb102,xrcb103,",
               "xrcb104,xrcb105,xrcb106,xrcb111,xrcb113,xrcb114,xrcb115,xrcb116,xrcb117,",
               "xrcb118,xrcb119,xrcb121,xrcb123,xrcb124,xrcb125,xrcb126,xrcb131,xrcb133,",
               "xrcb134,xrcb135,xrcb136,xrcb052,xrcb053,xrcb054,xrcb055,xrcb056,xrcb057,",
               "xrcb058,xrcb059,xrcb060,xrcb107 FROM xrcb_t WHERE xrcbent = '",g_enterprise,"' AND xrcbld = '",g_xrca_m.xrcald,"' AND xrcbdocno = ?"
  #161128-00061#3-----modify--end----------
   PREPARE axrp135_xrcb_prep FROM l_sql
   DECLARE axrp135_xrcb_curs CURSOR FOR axrp135_xrcb_prep

  #161128-00061#3-----modify--begin----------
  #LET l_sql = "SELECT * FROM xrde_t WHERE xrdeent = '",g_enterprise,"' AND xrdeld = '",g_xrca_m.xrcald,"' AND xrdedocno = ?"
    LET l_sql = "SELECT xrdeent,xrdecomp,xrdeld,xrdedocno,xrdeseq,xrdesite,xrdeorga,xrde001,xrde002,xrde003,",
                "xrde004,xrde006,xrde007,xrde008,xrde010,xrde011,xrde012,xrde013,xrde014,xrde015,xrde016,",
                "xrde017,xrde018,xrde019,xrde020,xrde022,xrde023,xrde028,xrde029,xrde030,xrde035,xrde036,",
                "xrde038,xrde039,xrde040,xrde041,xrde042,xrde043,xrde044,xrde045,xrde046,xrde047,xrde048,",
                "xrde049,xrde050,xrde051,xrde100,xrde101,xrde109,xrde119,xrde120,xrde121,xrde129,xrde130,",
                "xrde131,xrde139,xrde032,xrde108,xrde118 FROM xrde_t WHERE xrdeent = '",g_enterprise,"' AND xrdeld = '",g_xrca_m.xrcald,"' AND xrdedocno = ?"
  #161128-00061#3-----modify--end----------
   PREPARE axrp135_xrde_prep FROM l_sql
   DECLARE axrp135_xrde_curs CURSOR FOR axrp135_xrde_prep

  #161128-00061#3-----modify--begin----------
  # LET l_sql = "SELECT * FROM xrce_t WHERE xrceent = '",g_enterprise,"' AND xrceld = '",g_xrca_m.xrcald,"' AND xrcedocno = ?"
   LET l_sql = "SELECT xrceent,xrcecomp,xrceld,xrcedocno,xrceseq,xrcelegl,xrcesite,xrceorga,",
               "xrce001,xrce002,xrce003,xrce004,xrce005,xrce006,xrce007,xrce008,xrce009,xrce010,",
               "xrce011,xrce012,xrce013,xrce014,xrce015,xrce016,xrce017,xrce018,xrce019,xrce020,",
               "xrce021,xrce022,xrce023,xrce024,xrce025,xrce026,xrce027,xrce028,xrce029,xrce030,",
               "xrce035,xrce036,xrce037,xrce038,xrce039,xrce040,xrce041,xrce042,xrce043,xrce044,",
               "xrce045,xrce046,xrce047,xrce048,xrce049,xrce050,xrce051,xrce053,xrce054,xrce100,",
               "xrce101,xrce104,xrce109,xrce114,xrce119,xrce120,xrce121,xrce124,xrce129,xrce130,",
               "xrce131,xrce134,xrce139,xrce055,xrce056,xrce057,xrce058,xrce103,xrce113,xrce123,",
               "xrce133,xrce059 FROM xrce_t WHERE xrceent = '",g_enterprise,"' AND xrceld = '",g_xrca_m.xrcald,"' AND xrcedocno = ?"
  #161128-00061#3-----modify--end----------
   PREPARE axrp135_xrce_prep FROM l_sql
   DECLARE axrp135_xrce_curs CURSOR FOR axrp135_xrce_prep

   CALL s_axrt300_sel_ld(g_xrca_m.xrcald) RETURNING l_success,l_s

   CASE
      WHEN l_s = '1'
         LET ls_wc1 = " rtib031 = rtib031 - ? "      #artt600
         LET ls_wc2 = " stbe021 = stbe021 - ? "      #astt503
         LET ls_wc3 = " xmdb008 = 0, xmdb009 = 0, xmdb007 = null "   #axmt500
         LET ls_wc4 = " xmdl038 = xmdl038 - ? "      #axmt540/axmt600
         LET ls_wc5 = " isaf035        "      #aist310
         LET ls_wc6 = " xmdl053 = xmdl053 - ? "      #暫估單
      WHEN l_s = '2'
         LET ls_wc1 = " rtib032 = rtib032 - ? "
         LET ls_wc2 = " stbe022 = stbe022 - ? "
         LET ls_wc3 = " xmdb010 = 0, xmdb011 = 0, xmdb007 = null "
         LET ls_wc4 = " xmdl039 = xmdl039 - ? "
         LET ls_wc5 = " isaf048         "
         LET ls_wc6 = " xmdl054 = xmdl054 - ? "
      WHEN l_s = '3'
         LET ls_wc1 = " rtib033 = rtib033 - ? "
         LET ls_wc2 = " stbe023 = stbe023 - ? "
         LET ls_wc3 = " xmdb014 = 0, xmdb015 = 0, xmdb007 = null "
         LET ls_wc4 = " xmdl040 = xmdl040 - ? "
         LET ls_wc5 = " isaf049         "
         LET ls_wc6 = " xmdl055 = xmdl055 - ? "
   END CASE

   LET l_sql = "UPDATE rtib_t SET ",ls_wc1,
               " WHERE rtibdocno = ?  AND rtibseq = ?  ",
               "   AND rtibent   = '",g_enterprise,"'  "
   PREPARE axrp135_rtib_upd FROM l_sql

   LET l_sql = "UPDATE stbe_t SET ",ls_wc2,
               " WHERE stbedocno = ?  AND stbeseq = ?  ",
               "   AND stbeent   = '",g_enterprise,"'  "
   PREPARE axrp135_stbe_upd FROM l_sql

   LET l_sql = "UPDATE xmdb_t SET ",ls_wc3,
               " WHERE xmdbdocno = ?  AND xmdb001 = ?  ",
               "   AND xmdbent   = '",g_enterprise,"'  "
   PREPARE axrp135_xmdb_upd FROM l_sql

   LET l_sql = "UPDATE xmdl_t SET ",ls_wc4,
               " WHERE xmdldocno = ?  AND xmdlseq = ?  ",
               "   AND xmdlent   = '",g_enterprise,"'  "
   PREPARE axrp135_xmdl_upd FROM l_sql

   LET l_sql = "UPDATE isaf_t SET ",ls_wc5," = NULL",
               " WHERE isafdocno IN (SELECT isafdocno FROM isaf_t WHERE isafent = '",g_enterprise,"' AND isafcomp = ? AND ",ls_wc5," = ?) ",
               "   AND isafcomp  = ? ",
               "   AND isafent = '",g_enterprise,"'"
   PREPARE axrp135_isaf_upd FROM l_sql

   LET l_sql = "UPDATE xmdl_t SET ",ls_wc6,
               " WHERE xmdldocno = ?  AND xmdlseq = ?  ",
               "   AND xmdlent   = '",g_enterprise,"'  "
   PREPARE axrp135_xmdl_upd_1 FROM l_sql

   CASE
      WHEN l_s = '1'
         LET ls_wc1 = " nmbb008 = nmbb008 + ?,nmbb009 = nmbb009 + ?,nmbb014 = nmbb014 + ?,nmbb018 = nmbb018 + ?"
      WHEN l_s = '2'
         LET ls_wc1 = " nmbb020 = nmbb020 + ?,nmbb021 = nmbb021 + ?"
      WHEN l_s = '3'
         LET ls_wc1 = " nmbb023 = nmbb023 + ?,nmbb024 = nmbb024 + ?"
   END CASE

   LET l_sql = "UPDATE nmbb_t SET ",ls_wc1,
               " WHERE nmbbdocno = ?  AND nmbbseq = ?  ",
               "   AND nmbbent   = '",g_enterprise,"'  "
   PREPARE axrp135_nmbb_upd FROM l_sql

   LET l_sql = "UPDATE xrcc_t SET xrcc109 = xrcc109 + ? ,",
               "                  xrcc119 = xrcc119 + ? ,",
               "                  xrcc129 = xrcc129 + ? ,",
               "                  xrcc139 = xrcc139 + ?  ",
               " WHERE xrccdocno = ? ",
               "   AND xrccseq   = ? ",
               "   AND xrcc001   = ? ",
               "   AND xrccld    = '",g_xrca_m.xrcald,"'",
               "   AND xrccent   = '",g_enterprise,"'"
   PREPARE axrp135_xrcc_upd FROM l_sql

   LET l_sql = "UPDATE apcc_t SET apcc109 = apcc109 + ? ,",
               "                  apcc119 = apcc119 + ? ,",
               "                  apcc129 = apcc129 + ? ,",
               "                  apcc139 = apcc139 + ?  ",
               " WHERE apccdocno = ? ",
               "   AND apccseq   = ? ",
               "   AND apcc001   = ? ",
               "   AND apccld    = '",g_xrca_m.xrcald,"'",
               "   AND apccent   = '",g_enterprise,"'"
   PREPARE axrp135_apcc_upd FROM l_sql

  #20150201#1 By zhangwei Add  ---(S)---
   LET l_sql = "SELECT xrcadocno FROM xrca_t WHERE xrcaent = '",g_enterprise,"' AND xrcadocno = ? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE axrp135_cl CURSOR FROM l_sql            # LOCK CURSOR
  #20150201#1 By zhangwei Add  ---(E)---

   #錯誤訊息匯總初始化
   #CALL cl_showmsg_init()
   CALL cl_err_collect_init()
  #CALL s_transaction_begin()   #20150201#1 By zhangwei Mark
  #LET g_success = 'Y'          #20150201#1 By zhangwei Mark
  #LET g_totsuccess = 'Y'       #20150201#1 By zhangwei Mark
   LET l_doc_success = TRUE     #20150201#1 By zhangwei Add
   LET l_tot_success = TRUE     #20150201#1 By zhangwei Add

  #FOREACH axrp135_xrca_curs INTO l_xrcadocno,l_xrca001,l_xrca016  #20150201#1 By zhangwei Mark
  #20150201#1 By zhangwei Add  ---(S)---
   FOR li_idx = 1 TO g_xrca_d.getLength()

      CALL s_transaction_begin()  # 每一筆資料單獨走一次事物
      OPEN axrp135_cl USING g_xrca_d[li_idx].xrcadocno
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "OPEN xrca_cl:"   #20150201 ~~~
         LET g_errparam.code   =  STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         CLOSE axrp135_cl
         CALL s_transaction_end('N','0')
         CONTINUE FOR
      END IF
  #20150201#1 By zhangwei Add  ---(S)---

     #150126-00011#01 Mark ---(S)---
     #SELECT xrcadocdt INTO l_xrcadocdt FROM xrca_t WHERE xrcaent = g_enterprise
     #   AND xrcadocno = g_xrca_d[li_idx].xrcadocno
     #   AND xrcald = g_xrca_m.xrcald
     #
     ##STEP1
     #LET l_count = 0
     #EXECUTE axrp135_cnt_prep INTO l_count USING l_xrcadocno
     #IF l_count > 0 THEN
     #   #CALL cl_errmsg('xrcadocno',l_xrcadocno,'','axr-00131',1)
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.extend = 'xrcadocno',l_xrcadocno
     #   LET g_errparam.code   = 'axr-00131'
     #   LET g_errparam.popup  = TRUE
     #   CALL cl_err()
     #   LET g_success = 'N'
     #END IF

     ##STEP2
     #SELECT xrca038 INTO l_xrca038 FROM xrca_t
     # WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcadocno = l_xrcadocno
     #IF l_xrca038 IS NOT NULL THEN
     #   #CALL cl_errmsg('xrcadocno',l_xrcadocno,'','axr-00129',1)
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.extend = 'xrcadocno',l_xrcadocno
     #   LET g_errparam.code   = 'axr-00129'
     #   LET g_errparam.popup  = TRUE
     #   CALL cl_err()
     #   LET g_success = 'N'
     #END IF

     ##STEP3
     #LET l_count = 0
     #SELECT COUNT (DISTINCT isafdocno) INTO l_count FROM xrcb_t, isag_t, isaf_t
     # WHERE     xrcb002 = isag002     AND xrcb003 = isag003
     #       AND isafdocno = isagdocno AND isaf011 IS NOT NULL
     #       AND isafstus <> 'X'       AND xrcbdocno = l_xrcadocno
     #IF l_count > 0 THEN
     #   #CALL cl_errmsg('xrcadocno',l_xrcadocno,'','axr-00133',1)
     #   INITIALIZE g_errparam TO NULL
     #   LET g_errparam.extend = 'xrcadocno',l_xrcadocno
     #   LET g_errparam.code   = 'axr-00133'
     #   LET g_errparam.popup  = TRUE
     #   CALL cl_err()
     #   LET g_success = 'N'
     #END IF

     ##STEP4
     #SELECT xrca001,xrca019 INTO l_xrca001,l_xrca019 FROM xrca_t
     # WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcadocno = l_xrcadocno
     #IF (l_xrca001 = '11' OR l_xrca001 = '12') AND NOT cl_null(l_xrca019) THEN
     #   SELECT SUM(xrcc109) INTO l_xrcc109 FROM xrcc_t
     #    WHERE xrccent = g_enterprise AND xrccld = g_xrca_m.xrcald AND xrccdocno = l_xrca019
     #   IF l_xrcc109 > 0 THEN
     #      #CALL cl_errmsg('xrcadocno',l_xrcadocno,'','axr-00134',1)
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.extend = 'xrcadocno',l_xrcadocno
     #      LET g_errparam.code   = 'axr-00134'
     #      LET g_errparam.popup  = TRUE
     #      CALL cl_err()
     #      LET g_success = 'N'
     #   END IF
     #
     #   IF g_success = 'Y' THEN
     #      LET l_count = 0
     #      EXECUTE axrp135_cnt_prep INTO l_count USING l_xrca019
     #      IF l_count < 1 THEN
     #         #CALL cl_errmsg('xrcadocno',l_xrcadocno,'','axr-00134',1)
     #         INITIALIZE g_errparam TO NULL
     #         LET g_errparam.extend = 'xrcadocno',l_xrcadocno
     #         LET g_errparam.code   = 'axr-00134'
     #         LET g_errparam.popup  = TRUE
     #         CALL cl_err()
     #         LET g_success = 'N'
     #      END IF
     #   END IF
     #END IF
     #150126-00011#01 Mark ---(E)---

      IF g_xrca_d[li_idx].xrca001 = '17' OR g_xrca_d[li_idx].xrca001 = '22' THEN    #為發票轉到應收
         EXECUTE axrp135_isaf_upd USING g_glaa.glaacomp,g_xrca_d[li_idx].xrcadocno,g_glaa.glaacomp
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
            LET l_str = g_xrca_d[li_idx].xrcadocno,g_xrca_m.xrcacomp
            #CALL cl_errmsg('xrcadocno,xrcacomp',l_str,'','axr-00251',1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'xrcadocno,xrcacomp',g_xrca_d[li_idx].xrcadocno
            LET g_errparam.code   = 'axr-00251'
            LET g_errparam.popup  = TRUE
            CALL cl_err()
           #LET g_success = 'N'          #20150201#1 By zhangwei Mark
           #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
            LET l_doc_success = FALSE    #151008-00009#8 
         END IF
      END IF

     #150126-00011#01 Mark ---(S)---
     #IF g_success = 'N' THEN
     #   LET g_success = 'Y'
     #   LET g_totsuccess = 'N'
     #   CONTINUE FOREACH
     #END IF

     #SELECT xrcastus INTO l_xrcastus FROM xrca_t
     # WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcadocno = l_xrcadocno
     #150126-00011#01 Mark ---(E)---
      #STEP1
     #150126-00011#01 Mark ---(S)---
     #FOREACH axrp135_xrcb_curs INTO l_xrcb.*
     #   IF l_xrcastus = 'Y' THEN
     #      IF NOT cl_null(l_xrcb.xrcb001) AND NOT cl_null(l_xrcb.xrcb007) AND
     #         NOT cl_null(l_xrcb.xrcb002) AND NOT cl_null(l_xrcb.xrcb003) THEN
     #         CASE
     #            WHEN l_xrcb.xrcb001 = "artt600"
     #               EXECUTE axrp135_rtib_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00135',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00135'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            WHEN l_xrcb.xrcb001 = "astt503"
     #               EXECUTE axrp135_stbe_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00136',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00136'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            WHEN l_xrca001 = "11"
     #               EXECUTE axrp135_xmdb_upd USING l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00137',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00137'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            WHEN l_xrca001 = "01" OR l_xrca001 = "02"
     #               EXECUTE axrp135_xmdl_upd_1 USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00137',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00137'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #
     #            WHEN l_xrcb.xrcb001 = "11"
     #               EXECUTE axrp135_xmdl_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00138',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00138'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            WHEN l_xrcb.xrcb001 = "21"
     #               EXECUTE axrp135_xmdl_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
     #                  #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00139',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
     #                  LET g_errparam.code   = 'axr-00139'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #         END CASE
     #      END IF
     #   END IF
     #END FOREACH
     #150126-00011#01 Mark ---(E)---
     #150126-00011#01 Add ---(S)---
      FOREACH axrp135_xrcb_curs USING g_xrca_d[li_idx].xrcadocno INTO l_xrcb.*
         IF NOT cl_null(l_xrcb.xrcb001) AND NOT cl_null(l_xrcb.xrcb007) AND
            NOT cl_null(l_xrcb.xrcb002) AND NOT cl_null(l_xrcb.xrcb003) THEN
            CASE
               WHEN l_xrcb.xrcb001 = "artt600"
                  EXECUTE axrp135_rtib_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
                     LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
                     #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00135',1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
                     LET g_errparam.code   = 'axr-00135'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    #LET g_success = 'N'          #20150201#1 By zhangwei Mark
                    #LET l_doc_success = TRUE     #151008-00009#8 mark  #20150201#1 By zhangwei Add
                     LET l_doc_success = FALSE    #151008-00009#8 
                  END IF
               WHEN l_xrcb.xrcb001 = "astt503"
                  EXECUTE axrp135_stbe_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
                     LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
                     #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00136',1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
                     LET g_errparam.code   = 'axr-00136'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    #LET g_success = 'N'          #20150201#1 By zhangwei Mark
                    #LET l_doc_success = TRUE     #151008-00009#8 mark  #20150201#1 By zhangwei Add
                     LET l_doc_success = FALSE    #151008-00009#8 
                  END IF
               WHEN l_xrcb.xrcb001 = "10"
                  EXECUTE axrp135_xmdb_upd USING l_xrcb.xrcb002,l_xrcb.xrcb003
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
                     LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
                     #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00137',1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
                     LET g_errparam.code   = 'axr-00137'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    #LET g_success = 'N'          #20150201#1 By zhangwei Mark
                    #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
                     LET l_doc_success = FALSE    #151008-00009#8 
                  END IF

               WHEN l_xrcb.xrcb001 = "11"
                  IF g_xrca_d[li_idx].xrca001 = '01' OR g_xrca_d[li_idx].xrca001 = "02" THEN
                     EXECUTE axrp135_xmdl_upd_1 USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  ELSE
                     EXECUTE axrp135_xmdl_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  END IF
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
                     LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
                     #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00138',1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
                     LET g_errparam.code   = 'axr-00138'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    #LET g_success = 'N'          #20150201#1 By zhangwei Mark
                    #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
                     LET l_doc_success = FALSE    #151008-00009#8 
                  END IF

               WHEN l_xrcb.xrcb001 = "21"
                  IF g_xrca_d[li_idx].xrca001 = '01' OR g_xrca_d[li_idx].xrca001 = "02" THEN
                     EXECUTE axrp135_xmdl_upd_1 USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  ELSE
                     EXECUTE axrp135_xmdl_upd USING l_xrcb.xrcb007,l_xrcb.xrcb002,l_xrcb.xrcb003
                  END IF
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
                     LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrcb.xrcb002,l_xrcb.xrcb003
                     #CALL cl_errmsg('xrcadocno,xrcb002,xrcb003',l_str,'','axr-00139',1)
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'xrcadocno,xrcb002,xrcb003',l_str
                     LET g_errparam.code   = 'axr-00139'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                    #LET g_success = 'N'          #20150201#1 By zhangwei Mark
                    #LET l_doc_success = TRUE     #151008-00009#8  mark   #20150201#1 By zhangwei Add
                     LET l_doc_success = FALSE    #151008-00009#8 
                  END IF
            END CASE
         END IF
      END FOREACH
     #150126-00011#01 Add ---(E)---

      DELETE FROM xrcf_t WHERE xrcfld = g_xrca_m.xrcald AND xrcfent = g_enterprise
         AND xrcfdocno = g_xrca_d[li_idx].xrcadocno
      IF SQLCA.SQLCODE THEN
         LET l_str = g_xrca_d[li_idx].xrcadocno
         #CALL cl_errmsg('xrcadocno,xrcbseq',l_str,SQLCA.SQLCODE,'axr-00140',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrcadocno',l_str
         LET g_errparam.code   = 'axr-00290'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

      
      #151008-00009#8--s
      IF g_glaa.glaa139 = 'Y' THEN
         IF NOT cl_null(g_xrca_m.xrcald) AND NOT cl_null(g_xrca_d[li_idx].xrcadocno) THEN
            #刪除遞延檔
            LET lc_param.xrcald    = g_xrca_m.xrcald
            LET lc_param.xrcadocno = g_xrca_d[li_idx].xrcadocno  
            LET lc_param.type2     = '1'   #刪除類型:1.刪除所有項次/2.刪除一筆項次
            LET ls_js = util.JSON.stringify(lc_param)       
            CALL s_axrt470_del_xreq(ls_js) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               LET l_doc_success = FALSE
            END IF      
         END IF    
      END IF    
      #151008-00009#8--e
      DELETE FROM xrcb_t WHERE xrcbld = g_xrca_m.xrcald AND xrcbent = g_enterprise
         AND xrcbdocno = g_xrca_d[li_idx].xrcadocno
      IF SQLCA.SQLCODE THEN
         LET l_str = g_xrca_d[li_idx].xrcadocno
         #CALL cl_errmsg('xrcadocno,xrcbseq',l_str,SQLCA.SQLCODE,'axr-00140',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrcadocno',l_str
         LET g_errparam.code   = 'axr-00140'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

      DELETE FROM xrcd_t WHERE xrcdld = g_xrca_m.xrcald AND xrcdent = g_enterprise
         AND xrcddocno = g_xrca_d[li_idx].xrcadocno
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] < 1 THEN
         LET l_str = l_xrcb.xrcbld,g_xrca_d[li_idx].xrcadocno
         #CALL cl_errmsg('xrcdld,xrcddocno,xrcdseq',l_str,SQLCA.SQLCODE,'axr-00145',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrcdld,xrcddocno',l_str
         LET g_errparam.code   = 'axr-00145'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
         
      END IF

      #STEP2
     #150126-00011#01 Mark ---(S)---
     #FOREACH axrp135_xrde_curs INTO l_xrde.*
     #   IF l_xrcastus = 'N' THEN
     #      CASE
     #         WHEN l_xrde.xrde002 = "10"
     #            IF l_s = '1' THEN
     #               EXECUTE axrp135_nmbb_upd USING l_xrde.xrde109,l_xrde.xrde119,l_xrde.xrde129,
     #                                              l_xrde.xrde139,l_xrde.xrde003,l_xrde.xrde004
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrde.xrde003,l_xrde.xrde004
     #                  #CALL cl_errmsg('gzza001,xrcadocno,xrde003,xrde004',l_str,SQLCA.SQLCODE,'axr-00141',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'gzza001,xrcadocno,xrde003,xrde004',l_str
     #                  LET g_errparam.code   = 'axr-00141'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            ELSE
     #               EXECUTE axrp135_nmbb_upd USING l_xrde.xrde109,l_xrde.xrde119,l_xrde.xrde003,l_xrde.xrde004
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrde.xrde003,l_xrde.xrde004
     #                  #CALL cl_errmsg('gzza001,xrcadocno,xrde003,xrde004',l_str,SQLCA.SQLCODE,'axr-00141',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'gzza001,xrcadocno,xrde003,xrde004',l_str
     #                  LET g_errparam.code   = 'axr-00141'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #            END IF
     #      END CASE
     #   END IF
     #
     #   DELETE FROM xrde_t WHERE xrdedocno = l_xrcadocno AND xrdeld = g_xrca_m.xrcald AND xrdeent = g_enterprise
     #   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #      LET l_str = l_xrcadocno,l_xrde.xrde003,l_xrde.xrde004
     #      #CALL cl_errmsg('xrcadocno,xrde003,xrde004',l_str,SQLCA.SQLCODE,'axr-00142',1)
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.extend = 'xrcadocno,xrde003,xrde004',l_str
     #      LET g_errparam.code   = 'axr-00142'
     #      LET g_errparam.popup  = TRUE
     #      CALL cl_err()
     #      LET g_success = 'N'
     #   END IF
     #END FOREACH
     #
     #FOREACH axrp135_xrce_curs INTO l_xrce.*
     #   IF l_xrcastus = 'N' THEN
     #      CASE
     #         WHEN l_xrce.xrce002 = '30' OR l_xrce.xrce002 = '31' OR l_xrce.xrce002 = '32'
     #               EXECUTE axrp135_xrcc_upd USING l_xrce.xrce109,l_xrce.xrce119,l_xrce.xrce129,
     #                                              l_xrce.xrce139,l_xrce.xrce003,l_xrce.xrce004,
     #                                              l_xrce.xrce005
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005
     #                  #CALL cl_errmsg('gzza001,xrcadocno,xrce003,xrce004,xrce005',l_str,SQLCA.SQLCODE,'axr-00141',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'gzza001,xrcadocno,xrce003,xrce004,xrce005',l_str
     #                  LET g_errparam.code   = 'axr-00141'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #
     #         WHEN l_xrce.xrce002 = '40' OR l_xrce.xrce002 = '41' OR l_xrce.xrce002 = '42'
     #               EXECUTE axrp135_xrcc_upd USING l_xrce.xrce109,l_xrce.xrce119,l_xrce.xrce129,
     #                                              l_xrce.xrce139,l_xrce.xrce003,l_xrce.xrce004,
     #                                              l_xrce.xrce005
     #               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #                  LET l_str = l_xrcadocno,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005
     #                  #CALL cl_errmsg('gzza001,xrcadocno,xrce003,xrce004,xrce005',l_str,SQLCA.SQLCODE,'axr-00141',1)
     #                  INITIALIZE g_errparam TO NULL
     #                  LET g_errparam.extend = 'gzza001,xrcadocno,xrce003,xrce004,xrce005',l_str
     #                  LET g_errparam.code   = 'axr-00141'
     #                  LET g_errparam.popup  = TRUE
     #                  CALL cl_err()
     #                  LET g_success = 'N'
     #               END IF
     #      END CASE
     #   END IF
     #
     #   DELETE FROM xrce_t WHERE xrcedocno = l_xrcadocno AND xrceld = g_xrca_m.xrcald AND xrceent = g_enterprise
     #   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
     #      LET l_str = l_xrcadocno,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005
     #      #CALL cl_errmsg('xrcadocno,xrce003,xrce004,xrce005',l_str,SQLCA.SQLCODE,'axr-00142',1)
     #      INITIALIZE g_errparam TO NULL
     #      LET g_errparam.extend = 'xrcadocno,xrce003,xrce004,xrce005',l_str
     #      LET g_errparam.code   = 'axr-00142'
     #      LET g_errparam.popup  = TRUE
     #      CALL cl_err()
     #      LET g_success = 'N'
     #   END IF
     #END FOREACH
     #150126-00011#01 Mark ---(E)---

     #150126-00011#01 Add ---(S)---
      DELETE FROM xrde_t WHERE xrdedocno = g_xrca_d[li_idx].xrcadocno AND xrdeld = g_xrca_m.xrcald AND xrdeent = g_enterprise
      IF SQLCA.SQLCODE THEN
         LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrde.xrde003,l_xrde.xrde004
         #CALL cl_errmsg('xrcadocno,xrde003,xrde004',l_str,SQLCA.SQLCODE,'axr-00142',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrcadocno,xrde003,xrde004',l_str
         LET g_errparam.code   = 'axr-00142'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

      DELETE FROM xrce_t WHERE xrcedocno = g_xrca_d[li_idx].xrcadocno AND xrceld = g_xrca_m.xrcald AND xrceent = g_enterprise
      IF SQLCA.SQLCODE THEN
         LET l_str = g_xrca_d[li_idx].xrcadocno,l_xrce.xrce003,l_xrce.xrce004,l_xrce.xrce005
         #CALL cl_errmsg('xrcadocno,xrce003,xrce004,xrce005',l_str,SQLCA.SQLCODE,'axr-00142',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrcadocno,xrce003,xrce004,xrce005',l_str
         LET g_errparam.code   = 'axr-00142'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF
     #150126-00011#01 Add ---(E)---

      DELETE FROM xrcc_t WHERE xrccdocno = g_xrca_d[li_idx].xrcadocno AND xrccld = g_xrca_m.xrcald AND xrccent = g_enterprise
      IF SQLCA.SQLCODE THEN
         #CALL cl_errmsg('xrccdocno',l_xrcadocno,SQLCA.SQLCODE,'axr-00143',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrccdocno',g_xrca_d[li_idx].xrcadocno
         LET g_errparam.code   = 'axr-00143'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

      CALL s_aooi200_fin_get_slip(g_xrca_d[li_idx].xrcadocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_xrca_m.xrcald,g_glaa.glaacomp,l_ooba002,'D-FIN-0030') RETURNING l_dfin0030
      IF g_glaa.glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
         CALL s_pre_voucher_del('AR','R10',g_xrca_m.xrcald,g_xrca_d[li_idx].xrcadocno) RETURNING l_success

         IF NOT l_success THEN
           #LET g_success = 'N'          #20150201#1 By zhangwei Mark
           #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
            LET l_doc_success = FALSE    #151008-00009#8
         END IF
      END IF

      DELETE FROM xrca_t WHERE xrcadocno = g_xrca_d[li_idx].xrcadocno AND xrcald = g_xrca_m.xrcald AND xrcaent = g_enterprise
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         #CALL cl_errmsg('xrccdocno',l_xrcadocno,SQLCA.SQLCODE,'axr-00144',1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'xrccdocno',g_xrca_d[li_idx].xrcadocno
         LET g_errparam.code   = 'axr-00144'
         LET g_errparam.popup  = TRUE
         CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark   #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

      #取得單據別所代表的程式代碼
      SELECT gzcb005 INTO g_prog FROM gzcb_t
       WHERE gzcb001 = '8302'
         AND gzcb002 = g_xrca_d[li_idx].xrca001

      CALL s_aooi200_fin_del_docno(g_xrca_m.xrcald,g_xrca_d[li_idx].xrcadocno,g_xrca_d[li_idx].xrcadocdt) RETURNING l_success
      IF NOT l_success THEN
        #INITIALIZE g_errparam TO NULL
        #LET g_errparam.code = 'aap-00300'
        #LET g_errparam.extend = ''
        #LET g_errparam.popup = TRUE
        #CALL cl_err()
        #LET g_success = 'N'          #20150201#1 By zhangwei Mark
        #LET l_doc_success = TRUE     #151008-00009#8 mark  #20150201#1 By zhangwei Add
         LET l_doc_success = FALSE    #151008-00009#8
      END IF

     #20150201#1 By zhangwei Mark ---(S)---
     #IF g_success = 'N' THEN
     #   LET g_totsuccess = 'N'
     #END IF
     #20150201#1 by zhangwei Mark ---(E)---
     #20150201#1 By zhangwei Add  ---(S)---
      CLOSE axrp135_cl
      IF NOT l_doc_success THEN
         CALL s_transaction_end('N',1)
         LET l_tot_success = FALSE
      ELSE
         CALL s_transaction_end('Y',1)
      END IF
      LET l_doc_success = TRUE
     #20150201#1 By zhangwei Add  ---(E)---
      LET g_prog = "axrp135"

   END FOR   #20150201#1 By zhangwei Mod FOREACH ---> FOR

  #20150201#1 By zhangwei Mark ---(S)---
  #IF g_totsuccess = 'N' THEN
  #   #CALL cl_err_showmsg()
  #   CALL cl_err_collect_show()
  #   LET g_success    = 'Y'
  #   LET g_totsuccess = 'Y'
  #   CALL s_transaction_end('N','1')
  #   RETURN
  #ELSE
  #   CALL s_transaction_end('Y','1')
  #   CALL cl_ask_confirm3("std-00012","")
  #END IF
  #20150201#1 By zhangwei Mark ---(E)---

  #20150201#1 By zhangwei Add  ---(S)---
   IF l_tot_success THEN
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      CALL cl_err_collect_show()
   END IF
  #20150201#1 By zhangwei Add  ---(E)---
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp135_click_chk(p_chr)
   DEFINE p_chr         LIKE type_t.num5
   DEFINE li_idx        LIKE type_t.num5
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_xrca038     LIKE xrca_t.xrca038
   DEFINE l_xrcc109     LIKE xrcc_t.xrcc109
   DEFINE l_xrcadocdt   LIKE xrca_t.xrcadocdt
   DEFINE l_xrcasite    LIKE xrca_t.xrcasite
   DEFINE l_flag        LIKE type_t.dat
   DEFINE l_str         STRING
   DEFINE l_sql         STRING

   #150126-00011#01 Add ---(S)---
   #   因為"已確認單據不可還原(2014/11/26 kris)",所以勾選資料時的檢查僅STEP4有意義
   #150126-00011#01 Add ---(E)---

   #資料勾選前,執行可勾選否檢查
   #STEP1:已產生傳票者不可還原
   #STEP2:已有收款沖銷記錄者不可還原
   #STEP3:帳款單號,已存在其他預計沖銷記錄中不可還原
   #STEP4:立帳日期小於關帳日期不可還原
   #STEP5:對應的發票資料,皆尚無發票號碼者.
 　#      發票號碼空白或有發票號碼但已作廢者.任一筆發票已有正式發票號碼者,不可選取還原不可還原

   LET l_sql = "SELECT COUNT(doc) FROM (                                    ",
               "SELECT DISTINCT xrcadocno doc FROM xrca_t, xrce_t           ",
               " WHERE     xrcald    = xrceld      AND xrcaent   = xrceent  ",
               "       AND xrcadocno = xrcedocno   AND xrcadocno = xrcedocno",
               "       AND xrcastus <> 'X'         AND xrce003   = ?        ",
               " UNION                                                      ",
               "SELECT DISTINCT xrdadocno doc FROM xrca_t,xrda_t,xrce_t     ",
               " WHERE     xrdaent   = xrcaent     AND xrdaent = xrceent    ",
               "       AND xrdadocno = xrcedocno   AND xrce003 = xrcadocno  ",
               "       AND xrdald    = xrcald      AND xrdald  = xrceld     ",
               "       AND xrdastus <> 'X'         AND xrcadocno = ?        "
   PREPARE axrp135_count_prep FROM l_sql

   WHILE TRUE
      IF p_chr = "0" THEN
         FOR li_idx = 1 TO g_detail_d.getLength()
           #150126-00011#01 Mark ---(S)---
           ##STEP1
           #SELECT xrca038 INTO l_xrca038 FROM xrca_t
           # WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcadocno = g_detail_d[li_idx].xrcadocno
           #IF l_xrca038 IS NOT NULL THEN LET g_detail_d[li_idx].sel = "N" CONTINUE FOR END IF

           ##STEP2
           #SELECT SUM(xrcc109) INTO l_xrcc109 FROM xrcc_t
           # WHERE xrccent = g_enterprise AND xrccld = g_xrca_m.xrcald AND xrccdocno = g_detail_d[li_idx].xrcadocno
           #IF l_xrcc109 > 0 THEN LET g_detail_d[li_idx].sel = "N" CONTINUE FOR END IF

           ##STEP3
           #LET l_count = 0
           #EXECUTE axrp135_count_prep INTO l_count USING g_detail_d[li_idx].xrcadocno
           #IF l_count > 0 THEN LET g_detail_d[li_idx].sel = "N" CONTINUE FOR END IF
           #150126-00011#01 Mark ---(E)---

            #STEP4
            SELECT xrcasite INTO l_xrcasite FROM xrca_t WHERE xrcaent = g_enterprise
               AND xrcadocno = g_detail_d[li_idx].xrcadocno AND xrcald = g_xrca_m.xrcald
            LET l_flag = cl_get_para(g_enterprise,l_xrcasite,'S-FIN-2007')

            SELECT xrcadocdt INTO l_xrcadocdt FROM xrca_t
             WHERE xrcaent = g_enterprise AND xrcadocno = g_detail_d[li_idx].xrcadocno AND xrcald = g_xrca_m.xrcald
            IF l_xrcadocdt  < l_flag THEN LET g_detail_d[li_idx].sel = "N" CONTINUE FOR END IF

           #150126-00011#01 Mark ---(S)---
           ##STEP5
           #LET l_count = 0
           #SELECT COUNT (DISTINCT isafdocno) INTO l_count FROM xrcb_t, isag_t, isaf_t
           # WHERE     xrcb002 = isag002     AND xrcb003 = isag003
           #       AND isafdocno = isagdocno AND isaf011 IS NOT NULL
           #       AND isafstus <> 'X'       AND xrcbdocno = g_detail_d[li_idx].xrcadocno
           #IF l_count > 0 THEN LET g_detail_d[li_idx].sel = "N" CONTINUE FOR END IF
           #150126-00011#01 Mark ---(E)---
      
            LET g_detail_d[li_idx].sel = "Y"
         END FOR
         IF cl_null(g_detail_d[li_idx].xrcadocno) THEN
            CALL g_detail_d.deleteElement(li_idx)
         END IF
         EXIT WHILE
      ELSE
         LET li_idx = p_chr
         LET g_detail_d[li_idx].sel = "Y"
         LET g_errno = ' '
      
        ##STEP1
        #SELECT xrca038 INTO l_xrca038 FROM xrca_t
        # WHERE xrcaent = g_enterprise AND xrcald = g_xrca_m.xrcald AND xrcadocno = g_detail_d[li_idx].xrcadocno
        #IF l_xrca038 IS NOT NULL THEN LET g_detail_d[li_idx].sel = "N" LET g_errno = 'axr-00129' EXIT WHILE END IF
         
        ##STEP2
        #SELECT SUM(xrcc109) INTO l_xrcc109 FROM xrcc_t
        # WHERE xrccent = g_enterprise AND xrccld = g_xrca_m.xrcald AND xrccdocno = g_detail_d[li_idx].xrcadocno
        #IF l_xrcc109 > 0 THEN LET g_detail_d[li_idx].sel = "N" LET g_errno = 'axr-00130' EXIT WHILE END IF
         
        ##STEP3
        #LET l_count = 0
        #EXECUTE axrp135_count_prep INTO l_count USING g_detail_d[li_idx].xrcadocno
        #IF l_count > 0 THEN LET g_detail_d[li_idx].sel = "N" LET g_errno = 'axr-00131' EXIT WHILE END IF
         
         #STEP4
         SELECT xrcasite INTO l_xrcasite FROM xrca_t WHERE xrcaent = g_enterprise
            AND xrcadocno = g_detail_d[li_idx].xrcadocno AND xrcald = g_xrca_m.xrcald
         LET l_flag = cl_get_para(g_enterprise,l_xrcasite,'S-FIN-2007')

         SELECT xrcadocdt INTO l_xrcadocdt FROM xrca_t
          WHERE xrcaent = g_enterprise AND xrcadocno = g_detail_d[li_idx].xrcadocno AND xrcald = g_xrca_m.xrcald
         IF l_xrcadocdt  < l_flag THEN LET g_detail_d[li_idx].sel = "N" LET g_errno = 'axr-00132' EXIT WHILE END IF
         
         #STEP5
        #LET l_count = 0
        #SELECT COUNT (DISTINCT isafdocno) INTO l_count FROM xrcb_t, isag_t, isaf_t
        # WHERE     xrcb002 = isag002     AND xrcb003 = isag003
        #       AND isafdocno = isagdocno AND isaf011 IS NOT NULL
        #       AND isafstus <> 'X'       AND xrcbdocno = g_detail_d[li_idx].xrcadocno
        #IF l_count > 0 THEN LET g_detail_d[li_idx].sel = "N" LET g_errno = 'axr-00133' EXIT WHILE END IF

         EXIT WHILE

      END IF

   END WHILE

   IF p_chr <> 0 THEN
      IF g_detail_d[li_idx].sel = "N"THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_detail_d[li_idx].xrcadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         DISPLAY g_detail_d[li_idx].sel TO s_detail1[li_idx].sel
      END IF
   END IF

END FUNCTION
################################################################################
# Descriptions...: sub產生的數據集轉換
# Memo...........: DSCNJ,DSCTP,DSCTC --> ('DSCNJ','DSCTP','DSCTC')
# Usage..........: CALL axrp135_get_ooef001_wc(p_wc)
#                  RETURNING r_wc
# Input parameter: p_wc           sub产生的数据集
# Return code....: r_wc           SQ可用的数据集
# Date & Author..: 2014/12/08 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp135_get_ooef001_wc(p_wc)
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
 
