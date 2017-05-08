#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp910.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0015(2014-11-07 11:24:28), PR版次:0015(2016-12-01 17:34:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000273
#+ Filename...: axrp910
#+ Description: 應收帳款期末月結作業
#+ Creator....: 02599(2014-10-27 17:25:08)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp910.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150126-00011#1  2015/01/28 By zhangwei  1.單身勾選帳套或toolbar單選時,已有月結資料,則詢問"已有月結資料,是否重新執行月結?"
#                                          若確定勾選則 執行時背景 CALL axrp970
#                                          若axrp970　檢核時重評或暫估已有轉傳票不可還原時，也要回饋完整訊息
#                                        2.toolbar 全選時 已有月結資料的帳套不可自動打勾
#150518-00043#5  2015/05/26 By 01727     不依帳套詢問是重覆執行,只在執行時詢問一次
#150901-00020#4  2015/09/03 By Hans      寫入xrea_t增加發票號碼,收款條件編號,xrcc009,xrca008
#151223-00001#4  2015/12/28 By Reanna    如果agli171設定成2:重評價傳票，次月迴轉，那 xrea113 = xrcc118- xrcc119 + xreb115
#160106-00005#1  2016/01/06 By albireo   單據性質2* 及02,04  取重評後金額加到 xrea113 前要*-1
#160107-00003#4  2016/01/19 By fionchen  沖銷參數1/2的狀態下，其實xrcb/xrcc是對不上的
#151008-00009#10 2016/01/21 By Reanna    應收帳款期末月結作業(增加遞延收入月結處理)
#160426-00023#1  2016/04/26 By 02599     修改差异金额归未税金额计算公式为xrea114-(xrae114+xrea115-xrea116)
#151008-00009#9  2016/07/07 By 03538     增加21:銷退沖抵類型
#160811-00009#4  2016/08/19 By 01531     账务中心/法人/账套权限控管
#160905-00002#7  2016/09/05 By 08171     SQL補上ent
#161021-00050#4  2016/10/24 By 08729     處理組織開窗
#161128-00061#4  2016/12/01 by 02481     标准程式定义采用宣告模式,弃用.*写法
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
     sel               LIKE type_t.chr1,
     xreald            LIKE xrea_t.xreald,
     xreald_desc       LIKE type_t.chr500,
     xreacomp          LIKE xrea_t.xreacomp,
     xreacomp_desc     LIKE type_t.chr500,
     period            LIKE type_t.chr20,
     glav004_s         LIKE glav_t.glav004,
     glav004_e         LIKE glav_t.glav004
                  END RECORD 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
#單头 type 宣告
TYPE type_g_master RECORD
       xreasite           LIKE xrea_t.xreasite, 
       xreasite_desc      LIKE ooefl_t.ooefl003,
       xrea001            LIKE xrea_t.xrea001,
       xrea002            LIKE xrea_t.xrea002
       END RECORD

#模組變數(Module Variables)
DEFINE g_master         type_g_master
DEFINE g_master_t       type_g_master
#161128-00061#4-----modify--begin----------
#DEFINE g_glaa              RECORD LIKE glaa_t.* #160811-00009#4 
DEFINE g_glaa  RECORD  #帳套資料檔
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
#161128-00061#4-----modify--end----------
DEFINE g_success        LIKE type_t.chr1
DEFINE g_detail_idx     LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="axrp910.main" >}
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
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp910 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp910_init()   
 
      #進入選單 Menu (="N")
      CALL axrp910_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp910
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp910.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp910_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('xrea001','43')
   CALL s_fin_set_comp_scc('xrea002','111')
   CALL s_fin_create_account_center_tmp() 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp910.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp910_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_xrea001         LIKE xrea_t.xrea001
   DEFINE l_xrea002         LIKE xrea_t.xrea002
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_flag            LIKE type_t.dat
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
         CALL axrp910_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.xreasite,g_master.xrea001,g_master.xrea002

            BEFORE INPUT
               IF cl_null(g_master_t.xreasite) THEN
                  CALL axrp910_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.xreasite,g_master.xreasite_desc,g_master.xrea001,g_master.xrea002
                    TO xreasite,xreasite_desc,xrea001,xrea002

            BEFORE FIELD xreasite
               LET l_site = g_master.xreasite

            AFTER FIELD xreasite
               IF NOT cl_null(g_master.xreasite) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.xreasite,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.xreasite
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xreasite = l_site
                     CALL s_desc_get_department_desc(g_master.xreasite) RETURNING g_master.xreasite_desc
                     DISPLAY g_master.xreasite_desc TO xreasite_desc
                     NEXT FIELD CURRENT
                  END IF
                  SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.xreasite
               END IF
               CALL s_desc_get_department_desc(g_master.xreasite) RETURNING g_master.xreasite_desc
               #取得帳務中心歸屬法人 141223
               SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise
                  AND ooef001 = g_master.xreasite
               LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

               LET g_master.xrea001 = YEAR(l_flag)
               LET g_master.xrea002 = MONTH(l_flag)
               DISPLAY g_master.xreasite_desc,g_master.xrea001,g_master.xrea002 TO xreasite_desc,xrea001,xrea002

            BEFORE FIELD xrea001
               LET l_xrea001 = g_master.xrea001

            ON CHANGE xrea001
               IF NOT cl_null(g_master.xrea001) THEN
                  CALL axrp910_date_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_master.xrea001
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xrea001 = l_xrea001
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.xrea002) THEN
                     CALL axrp910_b_fill()
                  END IF
               END IF

            BEFORE FIELD xrea002
               LET l_xrea002 = g_master.xrea002

            ON CHANGE xrea002
               IF NOT cl_null(g_master.xrea002) THEN
                  CALL axrp910_date_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_master.xrea002
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xrea002 = l_xrea002
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.xrea001) THEN
                     CALL axrp910_b_fill()
                  END IF
               END IF

            ON ACTION controlp INFIELD xreasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xreasite       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 
               #CALL q_ooef001()                                #呼叫開窗   #161021-00050#4 mark
               CALL q_ooef001_46()                                         #161021-00050#4 add
               LET g_master.xreasite = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.xreasite TO xreasite               #顯示到畫面上
               CALL s_desc_get_department_desc(g_master.xreasite) RETURNING g_master.xreasite_desc
               DISPLAY g_master.xreasite_desc TO xreasite_desc
               NEXT FIELD xreasite                               #返回原欄位

         END INPUT  
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)    
            ON CHANGE sel
               LET l_ac = ARR_CURR()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                 #CALL axrp910_clik_chk(l_ac,'1')   #150518-00043#5 Mark
               END IF
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
#         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
# 
#            BEFORE DISPLAY
#               LET g_current_page = 1
# 
#            BEFORE ROW
#               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
#               LET g_master_idx = l_ac
#               CALL axrp910_b_fill()
# 
#         END DISPLAY
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
            
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
              #CALL axrp910_clik_chk(li_idx,'0') RETURNING l_success
              #IF NOT cl_null(g_errno) THEN
              #   LET g_detail_d[li_idx].sel = 'N'                    
              #END IF
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                 #CALL axrp910_clik_chk(li_idx,'1')   #150518-00043#5 Mark
                 #IF NOT cl_null(g_errno) THEN
                 #   INITIALIZE g_errparam TO NULL
                 #   LET g_errparam.code = g_errno
                 #   LET g_errparam.extend = ''
                 #   LET g_errparam.popup = TRUE
                 #   CALL cl_err()
                 #   LET g_detail_d[li_idx].sel = 'N'                     
                 #END IF
               END IF
            END FOR
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
            CALL axrp910_filter()
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
            CALL axrp910_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_master.* TO NULL
            CALL axrp910_def()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp910_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL axrp910_cycle_ld()
            CALL axrp910_b_fill()
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
 
{<section id="axrp910.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp910_query()
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
   CALL axrp910_b_fill()
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
 
{<section id="axrp910.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp910_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_year          LIKE type_t.num10   #   20151207 Mark BY 01727
   DEFINE l_ld_str        STRING   #160811-00009#4
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#160811-00009#4  MOD  ---(S)---
#   #取得帳務組織下所屬成員
#   CALL s_fin_account_center_sons_query('3',g_master.xreasite,g_today,'1')
#   #取得帳務組織下所屬成員之帳別   
#   CALL s_fin_account_center_ld_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
#   LET g_sql =" SELECT 'N',glaald,'',glaacomp,'','','','' FROM glaa_t ",
#              "  WHERE glaaent = ? ",
#              "    AND glaald IN ",ls_wc,    
#              "  ORDER BY glaald,glaacomp "
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_master.xreasite,g_today,'1')
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)   
   CALL s_axrt300_get_site(g_user,ls_wc,'2') RETURNING l_ld_str
   LET g_sql =" SELECT 'N',glaald,'',glaacomp,'','','','' FROM glaa_t ",
              "  WHERE glaaent = ? AND ",l_ld_str CLIPPED, 
              "  ORDER BY glaald,glaacomp "   
#160811-00009#4  MOD  ---(E)---     
   

              
              
   #end add-point
 
   PREPARE axrp910_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp910_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].xreald,g_detail_d[l_ac].xreald_desc,g_detail_d[l_ac].xreacomp,
   g_detail_d[l_ac].xreacomp_desc,g_detail_d[l_ac].period,g_detail_d[l_ac].glav004_s,g_detail_d[l_ac].glav004_e
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
      CALL s_axrt300_xrca_ref('xrcald',g_detail_d[l_ac].xreald,'','')
         RETURNING l_success,g_detail_d[l_ac].xreald_desc
      LET g_detail_d[l_ac].xreald_desc = g_detail_d[l_ac].xreald,"(",g_detail_d[l_ac].xreald_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_detail_d[l_ac].xreacomp,'','')
         RETURNING l_success,g_detail_d[l_ac].xreacomp_desc
      LET g_detail_d[l_ac].xreacomp_desc = g_detail_d[l_ac].xreacomp,"(",g_detail_d[l_ac].xreacomp_desc,")"

     #SELECT MAX(xrea001 ||'/'||xrea002) INTO g_detail_d[l_ac].period    20151207 Mark BY 01727
      SELECT MAX(xrea001*100 + xrea002) INTO l_year   #20151207 Mark BY 01727
        FROM xrea_t
       WHERE xreaent = g_enterprise
         AND xreald = g_detail_d[l_ac].xreald
         AND xrea003 = 'AR'
       GROUP BY xreald,xreacomp
       LET g_detail_d[l_ac].period = l_year      #20151207 Mark BY 01727
       LET g_detail_d[l_ac].period = g_detail_d[l_ac].period[1,4],"/",g_detail_d[l_ac].period[5,6]      #20151207 Mark BY 01727

      SELECT glaa003 INTO l_glaa003 FROM glaa_t 
       WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_ac].xreald

      SELECT MIN(glav004),MAX(glav004) 
        INTO g_detail_d[l_ac].glav004_s,g_detail_d[l_ac].glav004_e
        FROM glav_t 
       WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_master.xrea001
         AND glav006 = g_master.xrea002
      #end add-point
      
      CALL axrp910_detail_show()      
 
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
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp910_sel
   
   LET l_ac = 1
   CALL axrp910_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp910.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp910_fetch()
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
 
{<section id="axrp910.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp910_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp910.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp910_filter()
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
   
   CALL axrp910_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp910.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp910_filter_parser(ps_field)
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
 
{<section id="axrp910.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp910_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp910_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp910.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 默認設置
# Memo...........:
# Usage..........: CALL axrp910_def()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp910_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_flag            LIKE type_t.dat
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   
   IF NOT cl_null(g_master.xreasite) THEN RETURN END IF
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.xreasite,g_errno
   CALL s_desc_get_department_desc(g_master.xreasite) RETURNING g_master.xreasite_desc

   #取得帳務中心歸屬法人 141223
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise
      AND ooef001 = g_master.xreasite
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET g_master.xrea001 = YEAR(l_flag)
   LET g_master.xrea002 = MONTH(l_flag)
END FUNCTION

################################################################################
# Descriptions...: 會計年度期別檢查
# Memo...........:
# Usage..........: CALL axrp910_date_chk()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp910_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_xrea001      LIKE xrea_t.xrea001
   DEFINE l_xrea002      LIKE xrea_t.xrea002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   IF cl_null(g_master.xreasite) THEN RETURN END IF
   IF cl_null(g_master.xrea001) THEN RETURN END IF
   IF cl_null(g_master.xrea002) THEN RETURN END IF

   #取得帳務中心歸屬法人 141223
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise
      AND ooef001 = g_master.xreasite
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET l_xrea001 = YEAR(l_flag)
   LET l_xrea002 = MONTH(l_flag)

   LET g_errno = ' '
   IF g_master.xrea001 < l_xrea001 THEN
      LET g_errno = 'anm-00248'
   END IF

   IF g_master.xrea001 = l_xrea001  AND g_master.xrea002 < l_xrea002 THEN
      LET g_errno = 'anm-00249'
   END IF
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
PRIVATE FUNCTION axrp910_cycle_ld()
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_title           LIKE gzzd_t.gzzd005
   DEFINE l_glca002         LIKE glca_t.glca002
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_tot_success     LIKE type_t.num5
   DEFINE l_cnt             LIKE type_t.num5
   DEFINE l_flag            LIKE type_t.num5
   DEFINE l_flag1           LIKE type_t.num5
   DEFINE l_msg             STRING

   SELECT gzzd005 INTO l_title FROM gzzd_t 
   WHERE gzzd001 = 'axrt300' AND gzzd002 = g_lang AND gzzd003 = 'lbl_xrcadocno'

   LET l_flag = FALSE
   LET g_errno = NULL
   LET l_tot_success = TRUE
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = 'Y' THEN
         CALL axrp910_clik_chk(l_i,'0') RETURNING l_success      #150518-00043#5 Add
         IF NOT l_success THEN LET l_tot_success = FALSE END IF
         LET l_flag = TRUE
      END IF
   END FOR

   IF NOT l_flag THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   IF NOT l_tot_success THEN
      LET l_msg = cl_getmsg('axr-00339',g_lang) CLIPPED
      IF NOT cl_ask_confirm2('',l_msg)THEN
         RETURN
      END IF
   END IF

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET g_coll_title[1] = l_title
   LET g_success = 'Y'
   LET l_success = TRUE
   LET l_flag = FALSE #是否產生資料
   LET l_flag1 = FALSE #是否勾選拋轉帳套

   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = "Y" THEN
         LET l_flag1 = TRUE
        #161128-00061#4-----modify--begin----------
         #SELECT * INTO g_glaa.* 
          SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                 glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                 glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                 glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                 glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                 glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
         #161128-00061#4-----modify--end---------- 
         FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_i].xreald

         #檢查是否已有月結資料產生
        #CALL axrp910_clik_chk(l_i,'2')      #150518-00043#5 Mark
         IF NOT cl_null(g_errno) AND g_errno = 'axr-00291' THEN
            CALL axrp910_axrp970(l_i) RETURNING l_success
            IF NOT l_success THEN LET g_success = 'N' END IF
         END IF
         IF g_success = 'N' THEN CONTINUE FOR END IF   #若刪除月結檔失敗,則不可繼續往下執行產生月結檔邏輯

         CALL axrp910_get_xrea(g_detail_d[l_i].xreald,g_detail_d[l_i].glav004_s,g_detail_d[l_i].glav004_e)
         IF g_success = 'Y' AND l_flag=FALSE THEN
            #判斷是否產生月結資料
            SELECT COUNT(*) INTO l_cnt FROM  xrea_t 
            WHERE xreaent = g_enterprise AND xreald = g_detail_d[l_i].xreald
              AND xrea001 = g_master.xrea001
              AND xrea002 = g_master.xrea002
              AND xrea003 = 'AR'
            IF l_cnt> 0 THEN
               LET l_flag=TRUE
            END IF
        END IF
      END IF
   END FOR
   #提示選取預處理資料
   IF l_flag1 = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = '-400'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF
   #判斷是否產生月結資料
   IF g_success = 'Y' AND l_flag1 = TRUE AND l_flag=FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axc-00530'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF

   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axm-00088'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      IF cl_ask_confirm('axr-00304') THEN
         CALL axrp910_aglp590()
      END IF
   END IF

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
PRIVATE FUNCTION axrp910_get_xrea(p_ld,p_glav004_s,p_glav004_e)
   DEFINE p_ld          LIKE xreb_t.xrebld
   DEFINE p_glav004_s   LIKE glav_t.glav004
   DEFINE p_glav004_e   LIKE xreb_t.xreb008
   DEFINE l_sql         STRING
   #161128-00061#4-----modify--begin----------
  #DEFINE l_xrea        RECORD LIKE xrea_t.*
  #DEFINE l_xreo        RECORD LIKE xreo_t.*
   DEFINE l_xrea RECORD  #往來帳科目月結檔
       xreaent LIKE xrea_t.xreaent, #企業編號
       xreacomp LIKE xrea_t.xreacomp, #法人
       xreasite LIKE xrea_t.xreasite, #帳務組織
       xreald LIKE xrea_t.xreald, #帳套
       xrea001 LIKE xrea_t.xrea001, #年度
       xrea002 LIKE xrea_t.xrea002, #期別
       xrea003 LIKE xrea_t.xrea003, #來源模組
       xrea004 LIKE xrea_t.xrea004, #帳款單性質
       xrea005 LIKE xrea_t.xrea005, #單據號碼
       xrea006 LIKE xrea_t.xrea006, #項次
       xrea007 LIKE xrea_t.xrea007, #分期帳款序
       xrea008 LIKE xrea_t.xrea008, #立帳日期
       xrea009 LIKE xrea_t.xrea009, #帳款對象
       xrea010 LIKE xrea_t.xrea010, #收款對象
       xrea011 LIKE xrea_t.xrea011, #部門
       xrea012 LIKE xrea_t.xrea012, #責任中心
       xrea013 LIKE xrea_t.xrea013, #區域
       xrea014 LIKE xrea_t.xrea014, #客群
       xrea015 LIKE xrea_t.xrea015, #產品類別
       xrea016 LIKE xrea_t.xrea016, #人員
       xrea017 LIKE xrea_t.xrea017, #專案編號
       xrea018 LIKE xrea_t.xrea018, #WBS編號
       xrea019 LIKE xrea_t.xrea019, #應收付科目
       xreaorga LIKE xrea_t.xreaorga, #來源組織
       xrea020 LIKE xrea_t.xrea020, #經營方式
       xrea021 LIKE xrea_t.xrea021, #通路
       xrea022 LIKE xrea_t.xrea022, #品牌
       xrea023 LIKE xrea_t.xrea023, #自由核算項一
       xrea024 LIKE xrea_t.xrea024, #自由核算項二
       xrea025 LIKE xrea_t.xrea025, #自由核算項三
       xrea026 LIKE xrea_t.xrea026, #自由核算項四
       xrea027 LIKE xrea_t.xrea027, #自由核算項五
       xrea028 LIKE xrea_t.xrea028, #自由核算項六
       xrea029 LIKE xrea_t.xrea029, #自由核算項七
       xrea030 LIKE xrea_t.xrea030, #自由核算項八
       xrea031 LIKE xrea_t.xrea031, #自由核算項九
       xrea032 LIKE xrea_t.xrea032, #自由核算項十
       xrea033 LIKE xrea_t.xrea033, #摘要
       xrea034 LIKE xrea_t.xrea034, #發票日期
       xrea035 LIKE xrea_t.xrea035, #出貨單據日期
       xrea036 LIKE xrea_t.xrea036, #交易認定日期
       xrea037 LIKE xrea_t.xrea037, #出入庫扣帳日期
       xrea038 LIKE xrea_t.xrea038, #應收款日
       xrea039 LIKE xrea_t.xrea039, #信評等級
       xrea040 LIKE xrea_t.xrea040, #稅別
       xrea041 LIKE xrea_t.xrea041, #稅率
       xrea042 LIKE xrea_t.xrea042, #No Use
       xrea043 LIKE xrea_t.xrea043, #No Use
       xrea100 LIKE xrea_t.xrea100, #幣別
       xrea101 LIKE xrea_t.xrea101, #交易匯率
       xrea102 LIKE xrea_t.xrea102, #重評匯率
       xrea103 LIKE xrea_t.xrea103, #原幣未沖含稅金額
       xrea104 LIKE xrea_t.xrea104, #原幣暫估未沖未稅金額
       xrea105 LIKE xrea_t.xrea105, #原幣暫估未沖稅額
       xrea106 LIKE xrea_t.xrea106, #原幣暫估未沖含稅金額
       xrea113 LIKE xrea_t.xrea113, #本幣未沖含稅金額
       xrea114 LIKE xrea_t.xrea114, #本幣暫估未沖未稅金額
       xrea115 LIKE xrea_t.xrea115, #本幣暫估未沖稅額
       xrea116 LIKE xrea_t.xrea116, #本幣暫估未沖含稅金額
       xrea122 LIKE xrea_t.xrea122, #本位幣二重評匯率
       xrea123 LIKE xrea_t.xrea123, #本位幣二未沖含稅金額
       xrea132 LIKE xrea_t.xrea132, #本位幣三重評匯率
       xrea133 LIKE xrea_t.xrea133, #本位幣三未沖含稅金額
       xrea044 LIKE xrea_t.xrea044, #發票號碼
       xrea045 LIKE xrea_t.xrea045  #交易條件
       END RECORD
   DEFINE l_xreo RECORD  #遞延收入月結檔
       xreoent LIKE xreo_t.xreoent, #企業編號
       xreocomp LIKE xreo_t.xreocomp, #法人
       xreosite LIKE xreo_t.xreosite, #帳務中心
       xreold LIKE xreo_t.xreold, #帳套
       xreo001 LIKE xreo_t.xreo001, #年度
       xreo002 LIKE xreo_t.xreo002, #期別
       xreodocno LIKE xreo_t.xreodocno, #單據號碼
       xreoseq LIKE xreo_t.xreoseq, #項次
       xreoorga LIKE xreo_t.xreoorga, #來源組織
       xreo003 LIKE xreo_t.xreo003, #異動類型
       xreo004 LIKE xreo_t.xreo004, #交易單號
       xreo005 LIKE xreo_t.xreo005, #交易單項次
       xreo006 LIKE xreo_t.xreo006, #帳款單號
       xreo007 LIKE xreo_t.xreo007, #立帳日期
       xreo008 LIKE xreo_t.xreo008, #攤銷類型
       xreo009 LIKE xreo_t.xreo009, #遞延科目
       xreo011 LIKE xreo_t.xreo011, #參考單號
       xreo012 LIKE xreo_t.xreo012, #參考項次
       xreo013 LIKE xreo_t.xreo013, #已攤銷期別
       xreo016 LIKE xreo_t.xreo016, #帳款對象
       xreo017 LIKE xreo_t.xreo017, #收款對象
       xreo018 LIKE xreo_t.xreo018, #部門
       xreo019 LIKE xreo_t.xreo019, #責任中心
       xreo020 LIKE xreo_t.xreo020, #區域
       xreo021 LIKE xreo_t.xreo021, #客群
       xreo022 LIKE xreo_t.xreo022, #產品類別
       xreo023 LIKE xreo_t.xreo023, #人員
       xreo024 LIKE xreo_t.xreo024, #專案編號
       xreo025 LIKE xreo_t.xreo025, #WBS編號
       xreo026 LIKE xreo_t.xreo026, #經營方式
       xreo027 LIKE xreo_t.xreo027, #通路
       xreo028 LIKE xreo_t.xreo028, #品牌
       xreo029 LIKE xreo_t.xreo029, #自由核算項一
       xreo030 LIKE xreo_t.xreo030, #自由核算項二
       xreo031 LIKE xreo_t.xreo031, #自由核算項三
       xreo032 LIKE xreo_t.xreo032, #自由核算項四
       xreo033 LIKE xreo_t.xreo033, #自由核算項五
       xreo034 LIKE xreo_t.xreo034, #自由核算項六
       xreo035 LIKE xreo_t.xreo035, #自由核算項七
       xreo036 LIKE xreo_t.xreo036, #自由核算項八
       xreo037 LIKE xreo_t.xreo037, #自由核算項九
       xreo038 LIKE xreo_t.xreo038, #自由核算項十
       xreo039 LIKE xreo_t.xreo039, #摘要
       xreo040 LIKE xreo_t.xreo040, #產品編號
       xreo041 LIKE xreo_t.xreo041, #遞延認列交易原幣金額
       xreo042 LIKE xreo_t.xreo042, #遞延認列交易本幣金額
       xreo043 LIKE xreo_t.xreo043, #遞延認列交易本幣二金額
       xreo044 LIKE xreo_t.xreo044, #遞延認列交易本幣三金額
       xreo045 LIKE xreo_t.xreo045, #銷售分群
       xreo100 LIKE xreo_t.xreo100, #交易原幣幣別
       xreo101 LIKE xreo_t.xreo101, #匯率
       xreo102 LIKE xreo_t.xreo102, #重評價匯率
       xreo103 LIKE xreo_t.xreo103, #未沖轉原幣金額
       xreo113 LIKE xreo_t.xreo113, #未沖轉本幣金額
       xreo114 LIKE xreo_t.xreo114, #重評價本幣未沖金額
       xreo121 LIKE xreo_t.xreo121, #本位幣二匯率
       xreo122 LIKE xreo_t.xreo122, #重評價匯率二
       xreo123 LIKE xreo_t.xreo123, #未沖轉本位幣二金額
       xreo124 LIKE xreo_t.xreo124, #重評價本幣二未沖金額
       xreo131 LIKE xreo_t.xreo131, #本位幣三匯率
       xreo132 LIKE xreo_t.xreo132, #重評價匯率三
       xreo133 LIKE xreo_t.xreo133, #未沖轉本位幣三金額
       xreo134 LIKE xreo_t.xreo134  #重評價本幣三未沖金額
       END RECORD
   #161128-00061#4-----modify--begin----------
   DEFINE l_success     LIKE type_t.chr1
   DEFINE l_flag        LIKE type_t.chr1
   DEFINE l_xrce109     LIKE xrce_t.xrce109
   DEFINE l_xrce119     LIKE xrce_t.xrce119
   DEFINE l_xrce129     LIKE xrce_t.xrce129
   DEFINE l_xrce139     LIKE xrce_t.xrce139
   DEFINE l_apce109     LIKE apce_t.apce109
   DEFINE l_apce119     LIKE apce_t.apce119
   DEFINE l_apce129     LIKE apce_t.apce129
   DEFINE l_apce139     LIKE apce_t.apce139
   DEFINE l_xrcc113     LIKE xrcc_t.xrcc113
   DEFINE l_glca002     LIKE glca_t.glca003
   DEFINE l_oodbl004    LIKE oodbl_t.oodbl004
   DEFINE l_oodb005     LIKE oodb_t.oodb005
   DEFINE l_oodb011     LIKE oodb_t.oodb004
   DEFINE l_xreb115     LIKE xreb_t.xreb115  #151223-00001#4
   #151008-00009#10 add ------
   DEFINE l_xreq        RECORD
                           xrepsite  LIKE xrep_t.xrepsite,
                           xrepcomp  LIKE xrep_t.xrepcomp,
                           xreqdocno LIKE xreq_t.xreqdocno,
                           xreqseq   LIKE xreq_t.xreqseq,
                           xreqorga  LIKE xreq_t.xreqorga,
                           
                           xreq001   LIKE xreq_t.xreq001,
                           xreq002   LIKE xreq_t.xreq002,
                           xreq003   LIKE xreq_t.xreq003,
                           xreq004   LIKE xreq_t.xreq004,
                           xreq005   LIKE xreq_t.xreq005,
                           
                           xreq006   LIKE xreq_t.xreq006,
                           xreq007   LIKE xreq_t.xreq007,
                           xreq008   LIKE xreq_t.xreq008,
                           xreq009   LIKE xreq_t.xreq009,
                           xreq010   LIKE xreq_t.xreq010,
                           
                           xreq012   LIKE xreq_t.xreq012,
                           xreq014   LIKE xreq_t.xreq014,
                           xreq015   LIKE xreq_t.xreq015,
                           
                           xreq016   LIKE xreq_t.xreq016,
                           xreq017   LIKE xreq_t.xreq017,
                           xreq018   LIKE xreq_t.xreq018,
                           xreq019   LIKE xreq_t.xreq019,
                           xreq020   LIKE xreq_t.xreq020,
                           
                           xreq021   LIKE xreq_t.xreq021,
                           xreq022   LIKE xreq_t.xreq022,
                           xreq023   LIKE xreq_t.xreq023,
                           xreq024   LIKE xreq_t.xreq024,
                           xreq025   LIKE xreq_t.xreq025,
                           
                           xreq026   LIKE xreq_t.xreq026,
                           xreq027   LIKE xreq_t.xreq027,
                           xreq028   LIKE xreq_t.xreq028,
                           xreq029   LIKE xreq_t.xreq029,
                           xreq030   LIKE xreq_t.xreq030,
                           
                           xreq031   LIKE xreq_t.xreq031,
                           xreq032   LIKE xreq_t.xreq032,
                           xreq033   LIKE xreq_t.xreq033,
                           xreq034   LIKE xreq_t.xreq034,
                           xreq035   LIKE xreq_t.xreq035,
                           
                           xreq036   LIKE xreq_t.xreq036,
                           xreq037   LIKE xreq_t.xreq037,
                           xreq038   LIKE xreq_t.xreq038,
                           xreq039   LIKE xreq_t.xreq039,
                           xreq040   LIKE xreq_t.xreq040,
                           
                           xreq041   LIKE xreq_t.xreq041,
                           xreq042   LIKE xreq_t.xreq042,
                           xreq043   LIKE xreq_t.xreq043,
                           xreq044   LIKE xreq_t.xreq044,
                           xreq045   LIKE xreq_t.xreq045,
                           
                           xreq100   LIKE xreq_t.xreq100,
                           xreq101   LIKE xreq_t.xreq101,
                           xreq103   LIKE xreq_t.xreq103,
                           xreq1031  LIKE xreq_t.xreq103,
                           xreq113   LIKE xreq_t.xreq113,
                           
                           xreq1131  LIKE xreq_t.xreq113,
                           xreq121   LIKE xreq_t.xreq121,
                           xreq123   LIKE xreq_t.xreq123,
                           xreq1231  LIKE xreq_t.xreq123,
                           xreq131   LIKE xreq_t.xreq131,
                           
                           xreq133   LIKE xreq_t.xreq133,
                           xreq1331  LIKE xreq_t.xreq133
                        END RECORD
   #151008-00009#10 add end---
   
#   #刪除已產生的月結資料
#   DELETE FROM xrea_t 
#   WHERE xreaent = g_enterprise AND xreald = p_ld
#     AND xrea001 = g_master.xrea001
#     AND xrea002 = g_master.xrea002
#     AND xrea003 = 'AR'

   #150315 add ------
   SELECT glca002 INTO l_glca002
     FROM glaa_t,glca_t 
    WHERE glaaent = g_enterprise
      AND glaaent = glcaent
      AND glaald = glcald 
      AND glca001 = 'AR' 
      AND glca002 <> '1'     #無重評不撈出           
      AND glaald = p_ld
   #150315 add end---

   #沖帳方式            
   CALL cl_get_para(g_enterprise,g_glaa.glaacomp,'S-FIN-1002') RETURNING l_flag
   
   LET l_sql = "SELECT xrccent,xrcacomp,xrcasite,xrcald,xrca001,xrccdocno,xrccseq,xrcc001,xrcadocdt,xrca004,xrca005,"
   IF l_flag = '1' OR l_flag = '2' THEN
      LET l_sql = l_sql," '','','','','',xrca014,'',''," ,
                        " xrca035,xrcacomp,'','','',",
                        " '','','','','','','','','','','',", #10個自由核算項+摘要
                        " xrca011,xrca012,"  #稅別、稅率
   ELSE
      LET l_sql = l_sql," xrcb010,xrcb011,xrcb024,xrcb014,xrcb012,xrca014,xrcb015,xrcb016,",
                        " xrcb029,xrcborga,xrcb034,xrcb035,xrcb036,",
                        " xrcb037,xrcb038,xrcb039,xrcb040,xrcb041,",    #10個自由核算項+摘要
                        " xrcb042,xrcb043,xrcb044,xrcb045,xrcb046,xrcb047,",
                        " xrcb020,'',"   #稅別、稅率
   END IF   
   LET l_sql = l_sql," xrcc010,xrcc011,xrcc013,xrcc014,xrcc003,xrcc100,xrcc101,xrcc102,",
                     " xrcc108-xrcc109,xrcc118-xrcc119+xrcc113,",
                     " xrcc122,xrcc128-xrcc129+xrcc123,xrcc132,xrcc138-xrcc139+xrcc133",
                     " ,xrcc009,xrca008,xrca015                                       "#, #150901-00020#4  #160107-00003#4 mark ,
                    #" FROM xrca_t,xrcb_t,xrcc_t",                                     #160107-00003#4 mark
   #160107-00003#4 add -----(S)-------
   IF l_flag = '1' OR l_flag = '2' THEN
      LET l_sql = l_sql," FROM xrca_t,xrcc_t",
                        " WHERE xrcaent = xrccent AND xrcadocno = xrccdocno AND xrcald  = xrccld "
   ELSE 
      LET l_sql = l_sql," FROM xrca_t,xrcb_t,xrcc_t",
   #160107-00003#4 add -----(E)-------
                     " WHERE xrcaent = xrcbent AND xrcadocno = xrcbdocno AND xrcald  = xrcbld ",
                     " AND xrccent = xrcbent AND xrccdocno = xrcbdocno AND xrccld = xrcbld AND xrccseq = xrcbseq "#,   #160107-00003#4 mark ,
   END IF    #160107-00003#4 add
                    #" AND xrcaent = '",g_enterprise,"' ",    #160107-00003#4 mark
   LET l_sql = l_sql," AND xrcaent = '",g_enterprise,"' ",    #160107-00003#4 add
                     " AND xrcald  = '",p_ld,"' ",
                     " AND xrcadocdt <='",p_glav004_e,"' ",
                     " AND xrcastus ='Y' ",                  
                     " ORDER BY xrccdocno,xrccseq,xrcc001"    
                    
   PREPARE axrp910_xrea_prep1 FROM l_sql
   DECLARE axrp910_xrea_curs1  CURSOR FOR axrp910_xrea_prep1

   FOREACH axrp910_xrea_curs1 INTO l_xrea.xreaent,l_xrea.xreacomp,l_xrea.xreasite,l_xrea.xreald,
                                   l_xrea.xrea004,l_xrea.xrea005,l_xrea.xrea006,l_xrea.xrea007,
                                   l_xrea.xrea008,l_xrea.xrea009,l_xrea.xrea010,
                                   l_xrea.xrea011,l_xrea.xrea012,l_xrea.xrea013,l_xrea.xrea014,
                                   l_xrea.xrea015,l_xrea.xrea016,l_xrea.xrea017,l_xrea.xrea018,
                                   l_xrea.xrea019,l_xrea.xreaorga,l_xrea.xrea020,l_xrea.xrea021,
                                   l_xrea.xrea022,l_xrea.xrea023,l_xrea.xrea024,l_xrea.xrea025,
                                   l_xrea.xrea026,l_xrea.xrea027,l_xrea.xrea028,l_xrea.xrea029,
                                   l_xrea.xrea030,l_xrea.xrea031,l_xrea.xrea032,l_xrea.xrea033,
                                   l_xrea.xrea040,l_xrea.xrea041,  #稅別、稅率
                                   l_xrea.xrea034,l_xrea.xrea035,l_xrea.xrea036,l_xrea.xrea037,
                                   l_xrea.xrea038,l_xrea.xrea100,l_xrea.xrea101,l_xrea.xrea102,
                                   l_xrea.xrea103,l_xrea.xrea113,l_xrea.xrea122,l_xrea.xrea123,
                                   l_xrea.xrea132,l_xrea.xrea133
                                  ,l_xrea.xrea044,l_xrea.xrea045,l_xrea.xrea011  #150901-00020#4
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
         EXIT FOREACH
      END IF

      IF l_flag = '3' THEN
         CALL s_tax_chk(g_glaa.glaacomp,l_xrea.xrea040)
            RETURNING l_success,l_oodbl004,l_oodb005,l_xrea.xrea041,l_oodb011
      END IF

      #原幣未沖金額
      #xrcc108-xrcc109(扣除大於當期的沖帳金額,反推)
      IF l_xrea.xrea004[1,1] <> '0' THEN
         SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
         FROM xrce_t,xrda_t
         WHERE xrceent=xrdaent AND xrcedocno=xrdadocno AND xrceld=xrdald
         AND xrceent=g_enterprise AND xrceld=l_xrea.xreald 
         AND xrce003=l_xrea.xrea005 AND xrce004=l_xrea.xrea006 AND xrce005=l_xrea.xrea007
         AND xrdadocdt > p_glav004_e AND xrdastus='Y'
      ELSE
         SELECT SUM(xrcf105),SUM(xrcf115),SUM(xrcf125),SUM(xrcf135)
         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
         FROM xrcf_t,xrca_t
         WHERE xrcfent=xrcaent AND xrcfdocno=xrcadocno AND xrcfld=xrcald
         AND xrcfent=g_enterprise AND xrcfld=l_xrea.xreald
         AND xrcf008=l_xrea.xrea005 AND xrcf009=l_xrea.xrea006
         AND xrcadocdt > p_glav004_e AND xrcastus='Y'
      END IF
      IF cl_null(l_xrce109) THEN LET l_xrce109=0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119=0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129=0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139=0 END IF
      IF cl_null(l_xrea.xrea103) THEN LET l_xrea.xrea103=0 END IF
      IF cl_null(l_xrea.xrea113) THEN LET l_xrea.xrea113=0 END IF
      IF cl_null(l_xrea.xrea123) THEN LET l_xrea.xrea123=0 END IF
      IF cl_null(l_xrea.xrea133) THEN LET l_xrea.xrea133=0 END IF
      LET l_xrea.xrea103=l_xrea.xrea103 + l_xrce109
      LET l_xrea.xrea113=l_xrea.xrea113 + l_xrce119
      LET l_xrea.xrea123=l_xrea.xrea123 + l_xrce129
      LET l_xrea.xrea133=l_xrea.xrea133 + l_xrce139

      #20150315--add--str--#直接冲帐
      SELECT SUM(xrce109),SUM(xrce119),SUM(xrce129),SUM(xrce139)
         INTO l_xrce109,l_xrce119,l_xrce129,l_xrce139
         FROM xrce_t,xrca_t
         WHERE xrceent=xrcaent AND xrcedocno=xrcadocno AND xrceld=xrcald
         AND xrceent=g_enterprise AND xrceld=l_xrea.xreald
         AND xrce003=l_xrea.xrea005 AND xrce004=l_xrea.xrea006 AND xrce005=l_xrea.xrea007
         AND xrcadocdt > p_glav004_e AND xrcastus='Y'
      IF cl_null(l_xrce109) THEN LET l_xrce109=0 END IF
      IF cl_null(l_xrce119) THEN LET l_xrce119=0 END IF
      IF cl_null(l_xrce129) THEN LET l_xrce129=0 END IF
      IF cl_null(l_xrce139) THEN LET l_xrce139=0 END IF
      IF cl_null(l_xrea.xrea103) THEN LET l_xrea.xrea103=0 END IF
      IF cl_null(l_xrea.xrea113) THEN LET l_xrea.xrea113=0 END IF
      IF cl_null(l_xrea.xrea123) THEN LET l_xrea.xrea123=0 END IF
      IF cl_null(l_xrea.xrea133) THEN LET l_xrea.xrea133=0 END IF
      LET l_xrea.xrea103=l_xrea.xrea103 + l_xrce109
      LET l_xrea.xrea113=l_xrea.xrea113 + l_xrce119
      LET l_xrea.xrea123=l_xrea.xrea123 + l_xrce129
      LET l_xrea.xrea133=l_xrea.xrea133 + l_xrce139
      #20150315--add--end

      #應付回沖
      SELECT SUM(apce109),SUM(apce119),SUM(apce129),SUM(apce139)
        INTO l_apce109,l_apce119,l_apce129,l_apce139
        FROM apda_t,apce_t 
       WHERE apdaent = apceent AND apdald = apceld AND apdadocno = apcedocno
         AND apdaent = g_enterprise 
         AND apdadocdt > p_glav004_e
         AND apdasite = l_xrea.xreasite    #同一帳務中心
         AND apdald   = l_xrea.xreald       #同一帳套
         AND apce003 = l_xrea.xrea005 #AR 單號 
         AND apce004 = l_xrea.xrea006 #AR 項次 
         AND apce005 = l_xrea.xrea007 #AR 期別
         AND apdastus= 'Y'
      IF cl_null(l_apce109) THEN LET l_apce109=0 END IF
      IF cl_null(l_apce119) THEN LET l_apce119=0 END IF
      IF cl_null(l_apce129) THEN LET l_apce129=0 END IF
      IF cl_null(l_apce139) THEN LET l_apce139=0 END IF
      LET l_xrea.xrea103=l_xrea.xrea103 + l_apce109
      LET l_xrea.xrea113=l_xrea.xrea113 + l_apce119
      LET l_xrea.xrea123=l_xrea.xrea123 + l_apce129
      LET l_xrea.xrea133=l_xrea.xrea133 + l_apce139

      #150315 add 匯差調整-------
      IF l_glca002 = '3' THEN
         LET l_xrcc113 = 0 
         SELECT SUM(xreb115) INTO l_xrcc113
           FROM xreb_t
          WHERE xrebent = g_enterprise
            AND xrebld  = l_xrea.xreald
            AND (xreb001 = g_master.xrea001 AND xreb002 > g_master.xrea002 OR xreb001 > g_master.xrea001)
            AND xreb003 = 'AR'
            AND xreb005 = l_xrea.xrea005
            AND xreb006 = l_xrea.xrea006
            AND xreb007 = l_xrea.xrea007
         IF cl_null(l_xrcc113) THEN LET l_xrcc113 = 0 END IF
         LET l_xrea.xrea113=l_xrea.xrea113 - l_xrcc113
      END IF
      #150315 add 匯差調整 end---
      
      #151223-00001#4 add ------
      #取得本期匯差金額
      IF l_glca002 = '2' THEN
         LET l_xreb115 = 0
         SELECT SUM(xreb115) INTO l_xreb115
           FROM xreb_t
          WHERE xrebent = g_enterprise
            AND xrebcomp = l_xrea.xreacomp
            AND xrebld  = l_xrea.xreald
            AND xreb001 = g_master.xrea001
            AND xreb002 = g_master.xrea002
            AND xreb003 = 'AR'
            AND xreb005 = l_xrea.xrea005
            AND xreb006 = l_xrea.xrea006
            AND xreb007 = l_xrea.xrea007
      END IF
      IF cl_null(l_xreb115) THEN LET l_xreb115 = 0 END IF
      
      #160106-00005#1-----s
      IF l_xrea.xrea004 matches '[2]*' OR l_xrea.xrea004 = '02' OR l_xrea.xrea004 = '04' THEN
         LET l_xreb115 = l_xreb115 * (-1)
      END IF
      #160106-00005#1-----e
      
      LET l_xrea.xrea113=l_xrea.xrea113 + l_xreb115
      #151223-00001#4 add end---      
      
      LET l_xrea.xrea103=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea103,'2')
      LET l_xrea.xrea113=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea113,'2')
      LET l_xrea.xrea123=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea123,'2')
      LET l_xrea.xrea133=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea133,'2')
      
      IF l_xrea.xrea103=0 AND l_xrea.xrea113=0 AND l_xrea.xrea123=0 AND l_xrea.xrea133=0 THEN
         CONTINUE FOREACH
      END IF
      
      #原幣暫估未沖未稅金額
      IF l_xrea.xrea004[1,1] ='0' THEN
         #含稅金額 = xrea103  
         #未稅金額 =  含稅金額 /(1+(稅率oodb006/100)) 
         # 依幣別設定小數位數四捨五入
         # 稅額 =  未稅金額 * 稅率     # 依幣別設定小數位數四捨五入
         #(未稅金額 +  稅額)  - 含稅金額 <> 0 表示有差額, 差額歸在未稅金額
         #原幣
         LET l_xrea.xrea106=l_xrea.xrea103
         LET l_xrea.xrea104=l_xrea.xrea106 / (1+(l_xrea.xrea041/100))
         LET l_xrea.xrea104=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea104,'2')
         LET l_xrea.xrea105=l_xrea.xrea104 * l_xrea.xrea041/100
         LET l_xrea.xrea105=s_curr_round(l_xrea.xreacomp,l_xrea.xrea100,l_xrea.xrea105,'2')
         IF (l_xrea.xrea104 + l_xrea.xrea105 - l_xrea.xrea106) <> 0 THEN
#            LET l_xrea.xrea104= l_xrea.xrea104 + (l_xrea.xrea104 + l_xrea.xrea105 - l_xrea.xrea106) #160426-00023#1 mark
            LET l_xrea.xrea104= l_xrea.xrea104 - (l_xrea.xrea104 + l_xrea.xrea105 - l_xrea.xrea106) #160426-00023#1 add
         END IF
         #本幣
         LET l_xrea.xrea116=l_xrea.xrea113
         LET l_xrea.xrea114=l_xrea.xrea116 / (1+(l_xrea.xrea041/100))
         LET l_xrea.xrea114=s_curr_round(l_xrea.xreacomp,g_glaa.glaa001,l_xrea.xrea114,'2')
         LET l_xrea.xrea115=l_xrea.xrea114 * l_xrea.xrea041/100
         LET l_xrea.xrea115=s_curr_round(l_xrea.xreacomp,g_glaa.glaa001,l_xrea.xrea115,'2')
         IF (l_xrea.xrea114 + l_xrea.xrea115 - l_xrea.xrea116) <> 0 THEN
#            LET l_xrea.xrea114= l_xrea.xrea114 + (l_xrea.xrea114 + l_xrea.xrea115 - l_xrea.xrea116) #160426-00023#1 mark
            LET l_xrea.xrea114= l_xrea.xrea114 - (l_xrea.xrea114 + l_xrea.xrea115 - l_xrea.xrea116) #160426-00023#1 add
         END IF
      ELSE
         LET l_xrea.xrea104=0
         LET l_xrea.xrea105=0
         LET l_xrea.xrea106=0
         LET l_xrea.xrea114=0
         LET l_xrea.xrea115=0
         LET l_xrea.xrea116=0
      END IF
      LET l_xrea.xrea001 = g_master.xrea001 #年度
      LET l_xrea.xrea002 = g_master.xrea002 #期別
      LET l_xrea.xrea003 = 'AR'  #來源模組
      #責任中心（部門對應的責任中心）
      IF l_flag = '1' OR l_flag = '2' THEN
         SELECT ooeg004 INTO l_xrea.xrea012 FROM ooeg_t
         WHERE ooegent=g_enterprise AND ooeg001=l_xrea.xrea011
      END IF
      #信評等級
      SELECT pmab004 INTO l_xrea.xrea039 FROM pmab_t  
       WHERE pmabent = g_enterprise AND pmab001 = l_xrea.xrea009 AND pmabsite = l_xrea.xreacomp 
      #稅率
      IF l_flag='3' THEN
         SELECT oodb006 INTO l_xrea.xrea041 FROM oodb_t
         WHERE oodbent=g_enterprise AND oodb002=l_xrea.xrea040
         AND oodb001=(SELECT ooef019 FROM ooef_t WHERE ooefent=g_enterprise AND ooef001=l_xrea.xreacomp)
      END IF
      
      #161128-00061#4-----modify--begin----------
      #INSERT INTO xrea_t VALUES (l_xrea.*)
      INSERT INTO xrea_t (xreaent,xreacomp,xreasite,xreald,xrea001,xrea002,xrea003,xrea004,xrea005,xrea006,
                          xrea007,xrea008,xrea009,xrea010,xrea011,xrea012,xrea013,xrea014,xrea015,xrea016,
                          xrea017,xrea018,xrea019,xreaorga,xrea020,xrea021,xrea022,xrea023,xrea024,xrea025,
                          xrea026,xrea027,xrea028,xrea029,xrea030,xrea031,xrea032,xrea033,xrea034,xrea035,
                          xrea036,xrea037,xrea038,xrea039,xrea040,xrea041,xrea042,xrea043,xrea100,xrea101,
                          xrea102,xrea103,xrea104,xrea105,xrea106,xrea113,xrea114,xrea115,xrea116,xrea122,
                          xrea123,xrea132,xrea133,xrea044,xrea045)
       VALUES (l_xrea.xreaent,l_xrea.xreacomp,l_xrea.xreasite,l_xrea.xreald,l_xrea.xrea001,l_xrea.xrea002,l_xrea.xrea003,l_xrea.xrea004,l_xrea.xrea005,l_xrea.xrea006,
               l_xrea.xrea007,l_xrea.xrea008,l_xrea.xrea009,l_xrea.xrea010,l_xrea.xrea011,l_xrea.xrea012,l_xrea.xrea013,l_xrea.xrea014,l_xrea.xrea015,l_xrea.xrea016,
               l_xrea.xrea017,l_xrea.xrea018,l_xrea.xrea019,l_xrea.xreaorga,l_xrea.xrea020,l_xrea.xrea021,l_xrea.xrea022,l_xrea.xrea023,l_xrea.xrea024,l_xrea.xrea025,
               l_xrea.xrea026,l_xrea.xrea027,l_xrea.xrea028,l_xrea.xrea029,l_xrea.xrea030,l_xrea.xrea031,l_xrea.xrea032,l_xrea.xrea033,l_xrea.xrea034,l_xrea.xrea035,
               l_xrea.xrea036,l_xrea.xrea037,l_xrea.xrea038,l_xrea.xrea039,l_xrea.xrea040,l_xrea.xrea041,l_xrea.xrea042,l_xrea.xrea043,l_xrea.xrea100,l_xrea.xrea101,
               l_xrea.xrea102,l_xrea.xrea103,l_xrea.xrea104,l_xrea.xrea105,l_xrea.xrea106,l_xrea.xrea113,l_xrea.xrea114,l_xrea.xrea115,l_xrea.xrea116,l_xrea.xrea122,
               l_xrea.xrea123,l_xrea.xrea132,l_xrea.xrea133,l_xrea.xrea044,l_xrea.xrea045)
      #161128-00061#4-----modify--end----------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "insert xrea_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END FOREACH
   
   #151008-00009#10 add ------
   #遞延收入月結處理
   LET l_sql = "SELECT * FROM (",
               "   SELECT xrepsite,xrepcomp,xreqdocno,xreqseq,xreqorga,",
               "          xreq001,xreq002,xreq003,xreq004,xreq005,",
               "          xreq006,xreq007,xreq008,xreq009,xreq010,",
               "          xreq012,xreq014,xreq015,",
               "          xreq016,xreq017,xreq018,xreq019,xreq020,",
               "          xreq021,xreq022,xreq023,xreq024,xreq025,",
               "          xreq026,xreq027,xreq028,xreq029,xreq030,",
               "          xreq031,xreq032,xreq033,xreq034,xreq035,",
               "          xreq036,xreq037,xreq038,xreq039,xreq040,",
               "          xreq045,xreq100,xreq101,xreq121,xreq131,",
                          #原幣金額
               "          COALESCE (xreq041, 0) xreq041,",   #原始
               "          COALESCE (xreq103, 0) xreq103,",   #已沖轉
               "          COALESCE (xreq1031,0) xreq1031,",  #回推
                          #本幣金額
               "          COALESCE (xreq042, 0) xreq042,",   #原始
               "          COALESCE (xreq113, 0) xreq113,",   #已沖轉
               "          COALESCE (xreq1131,0) xreq1131,",  #回推
                          #本幣二金額
               "          COALESCE (xreq043, 0) xreq043,",   #原始
               "          COALESCE (xreq123, 0) xreq123,",   #已沖轉
               "          COALESCE (xreq1231,0) xreq1231,",  #回推
                          #本幣三金額
               "          COALESCE (xreq044, 0) xreq044,",   #原始
               "          COALESCE (xreq133, 0) xreq133,",   #已沖轉
               "          COALESCE (xreq1331,0) xreq1331",   #回推
               "     FROM xrep_t ,xreq_t",
               "     LEFT OUTER JOIN (",
               "        SELECT xrepent xrepent2,xrepld xrepld2,xreq004 xreq0042,",
               "               xreq005 xreq0052,xreq006 xreq0062,SUM (xreq103) xreq1031,",
               "               SUM (xreq113) xreq1131,SUM (xreq123) xreq1231,SUM (xreq133) xreq1331",
               "          FROM xrep_t,xreq_t",
               "         WHERE xrepent = xreqent AND xrepld = xreqld AND xrepdocno = xreqdocno",
               "           AND xrepent = ",g_enterprise,
               "           AND xrepld = '",p_ld,"'",
               "           AND xrepstus = 'Y'",
              #"           AND xreq003 IN('2','4')",        #151008-00009#9 mark
               "           AND xreq003 IN('2','4','21')",   #151008-00009#9 
               "           AND xrepdocdt > '",p_glav004_e,"'",
               "      GROUP BY xrepent,xrepld,xreq004,xreq005,xreq006",
               "     )",
               "     ON xreqent = xrepent2 AND xreqld  = xrepld2 AND xreq004 = xreq0042",
               "     AND xreq005 = xreq0052 AND xreq006 = xreq0062",
               "    WHERE xrepent = xreqent AND xrepld = xreqld AND xrepdocno = xreqdocno",
               "      AND xrepent = ",g_enterprise,
               "      AND xreqld = '",p_ld,"'",
               "      AND xrepstus = 'Y'",
               "      AND xreq003 IN('1','3')",
               "      AND xrepdocdt <= '",p_glav004_e,"'",
               ")",
               "WHERE (xreq041 - xreq103 + xreq1031) > 0"
   PREPARE axrp910_xrep_prep1 FROM l_sql
   DECLARE axrp910_xrep_curs1  CURSOR FOR axrp910_xrep_prep1
   FOREACH axrp910_xrep_curs1 INTO l_xreq.xrepsite,l_xreq.xrepcomp,l_xreq.xreqdocno,l_xreq.xreqseq,l_xreq.xreqorga,
                                   l_xreq.xreq001,l_xreq.xreq002,l_xreq.xreq003,l_xreq.xreq004,l_xreq.xreq005,
                                   l_xreq.xreq006,l_xreq.xreq007,l_xreq.xreq008,l_xreq.xreq009,l_xreq.xreq010,
                                   l_xreq.xreq012,l_xreq.xreq014,l_xreq.xreq015,
                                   l_xreq.xreq016,l_xreq.xreq017,l_xreq.xreq018,l_xreq.xreq019,l_xreq.xreq020,
                                   l_xreq.xreq021,l_xreq.xreq022,l_xreq.xreq023,l_xreq.xreq024,l_xreq.xreq025,
                                   l_xreq.xreq026,l_xreq.xreq027,l_xreq.xreq028,l_xreq.xreq029,l_xreq.xreq030,
                                   l_xreq.xreq031,l_xreq.xreq032,l_xreq.xreq033,l_xreq.xreq034,l_xreq.xreq035,
                                   l_xreq.xreq036,l_xreq.xreq037,l_xreq.xreq038,l_xreq.xreq039,l_xreq.xreq040,
                                   l_xreq.xreq045,l_xreq.xreq100,l_xreq.xreq101,l_xreq.xreq121,l_xreq.xreq131,
                                   l_xreq.xreq041,l_xreq.xreq103,l_xreq.xreq1031,
                                   l_xreq.xreq042,l_xreq.xreq113,l_xreq.xreq1131,
                                   l_xreq.xreq043,l_xreq.xreq123,l_xreq.xreq1231,
                                   l_xreq.xreq044,l_xreq.xreq133,l_xreq.xreq1331
      
      INITIALIZE l_xreo.* TO NULL
      
      LET l_xreo.xreoent   = g_enterprise       #企業代碼
      LET l_xreo.xreocomp  = l_xreq.xrepcomp    #法人
      LET l_xreo.xreosite  = l_xreq.xrepsite    #帳務中心
      LET l_xreo.xreold    = p_ld               #帳套
      LET l_xreo.xreo001   = g_master.xrea001   #年度
      LET l_xreo.xreo002   = g_master.xrea002   #期別
      LET l_xreo.xreodocno = l_xreq.xreqdocno   #單據號碼
      LET l_xreo.xreoseq   = l_xreq.xreqseq     #項次
      LET l_xreo.xreoorga  = l_xreq.xreqorga    #來源組織
      LET l_xreo.xreo003   = l_xreq.xreq003     #異動類型
      LET l_xreo.xreo004   = l_xreq.xreq004     #交易單號
      LET l_xreo.xreo005   = l_xreq.xreq005     #交易單項次
      LET l_xreo.xreo006   = l_xreq.xreq006     #帳款單號
      LET l_xreo.xreo007   = l_xreq.xreq007     #立帳日期
      LET l_xreo.xreo008   = l_xreq.xreq009     #攤銷類型
      LET l_xreo.xreo009   = l_xreq.xreq012     #遞延科目
      LET l_xreo.xreo011   = l_xreq.xreq014     #參考單號
      LET l_xreo.xreo012   = l_xreq.xreq015     #參考項次
      LET l_xreo.xreo013   = l_xreq.xreq040     #已攤銷期別
      LET l_xreo.xreo016   = l_xreq.xreq016     #帳款對象
      LET l_xreo.xreo017   = l_xreq.xreq017     #收款對象
      LET l_xreo.xreo018   = l_xreq.xreq018     #部門
      LET l_xreo.xreo019   = l_xreq.xreq019     #責任中心
      LET l_xreo.xreo020   = l_xreq.xreq020     #區域
      LET l_xreo.xreo021   = l_xreq.xreq021     #客群
      LET l_xreo.xreo022   = l_xreq.xreq022     #產品類別
      LET l_xreo.xreo023   = l_xreq.xreq023     #人員
      LET l_xreo.xreo024   = l_xreq.xreq024     #專案代號
      LET l_xreo.xreo025   = l_xreq.xreq025     #WBS編號
      LET l_xreo.xreo026   = l_xreq.xreq026     #經營方式
      LET l_xreo.xreo027   = l_xreq.xreq027     #渠道
      LET l_xreo.xreo028   = l_xreq.xreq028     #品牌
      LET l_xreo.xreo029   = l_xreq.xreq029     #自由核算項一
      LET l_xreo.xreo030   = l_xreq.xreq030     #自由核算項二
      LET l_xreo.xreo031   = l_xreq.xreq031     #自由核算項三
      LET l_xreo.xreo032   = l_xreq.xreq032     #自由核算項四
      LET l_xreo.xreo033   = l_xreq.xreq033     #自由核算項五
      LET l_xreo.xreo034   = l_xreq.xreq034     #自由核算項六
      LET l_xreo.xreo035   = l_xreq.xreq035     #自由核算項七
      LET l_xreo.xreo036   = l_xreq.xreq036     #自由核算項八
      LET l_xreo.xreo037   = l_xreq.xreq037     #自由核算項九
      LET l_xreo.xreo038   = l_xreq.xreq038     #自由核算項十
      LET l_xreo.xreo039   = l_xreq.xreq039     #摘要
      LET l_xreo.xreo040   = l_xreq.xreq010     #產品代號
      LET l_xreo.xreo041   = l_xreq.xreq041     #遞延認列交易原幣金額
      LET l_xreo.xreo042   = l_xreq.xreq042     #遞延認列交易本幣金額
      LET l_xreo.xreo043   = l_xreq.xreq043     #遞延認列交易本幣二金額
      LET l_xreo.xreo044   = l_xreq.xreq044     #遞延認列交易本幣三金額
      LET l_xreo.xreo045   = l_xreq.xreq045     #銷售分群
      LET l_xreo.xreo100   = l_xreq.xreq100     #交易原幣幣別
      LET l_xreo.xreo101   = l_xreq.xreq101     #匯率
      LET l_xreo.xreo121   = l_xreq.xreq121     #本位幣二匯率
      LET l_xreo.xreo131   = l_xreq.xreq131     #本位幣三匯率
      LET l_xreo.xreo102   = 0                  #重評價匯率
      LET l_xreo.xreo122   = 0                  #重評價匯率二
      LET l_xreo.xreo132   = 0                  #重評價匯率三
      LET l_xreo.xreo114   = 0                  #重評價本幣未沖金額
      LET l_xreo.xreo124   = 0                  #重評價本幣二未沖金額
      LET l_xreo.xreo134   = 0                  #重評價本幣三未沖金額
      LET l_xreo.xreo103   = l_xreq.xreq041-l_xreq.xreq103+l_xreq.xreq1031  #未沖轉原幣金額
      LET l_xreo.xreo113   = l_xreq.xreq042-l_xreq.xreq113+l_xreq.xreq1131  #未沖轉本幣金額
      LET l_xreo.xreo123   = l_xreq.xreq043-l_xreq.xreq123+l_xreq.xreq1231  #未沖轉本位幣二金額
      LET l_xreo.xreo133   = l_xreq.xreq044-l_xreq.xreq133+l_xreq.xreq1331  #未沖轉本位幣三金額
      
      #161128-00061#4-----modify--begin----------
      #INSERT INTO xreo_t VALUES (l_xreo.*)
       INSERT INTO xreo_t (xreoent,xreocomp,xreosite,xreold,xreo001,xreo002,xreodocno,xreoseq,
                           xreoorga,xreo003,xreo004,xreo005,xreo006,xreo007,xreo008,xreo009,xreo011,
                           xreo012,xreo013,xreo016,xreo017,xreo018,xreo019,xreo020,xreo021,xreo022,
                           xreo023,xreo024,xreo025,xreo026,xreo027,xreo028,xreo029,xreo030,xreo031,
                           xreo032,xreo033,xreo034,xreo035,xreo036,xreo037,xreo038,xreo039,xreo040,
                           xreo041,xreo042,xreo043,xreo044,xreo045,xreo100,xreo101,xreo102,xreo103,
                           xreo113,xreo114,xreo121,xreo122,xreo123,xreo124,xreo131,xreo132,xreo133,xreo134)
        VALUES (l_xreo.xreoent,l_xreo.xreocomp,l_xreo.xreosite,l_xreo.xreold,l_xreo.xreo001,l_xreo.xreo002,l_xreo.xreodocno,l_xreo.xreoseq,
                l_xreo.xreoorga,l_xreo.xreo003,l_xreo.xreo004,l_xreo.xreo005,l_xreo.xreo006,l_xreo.xreo007,l_xreo.xreo008,l_xreo.xreo009,l_xreo.xreo011,
                l_xreo.xreo012,l_xreo.xreo013,l_xreo.xreo016,l_xreo.xreo017,l_xreo.xreo018,l_xreo.xreo019,l_xreo.xreo020,l_xreo.xreo021,l_xreo.xreo022,
                l_xreo.xreo023,l_xreo.xreo024,l_xreo.xreo025,l_xreo.xreo026,l_xreo.xreo027,l_xreo.xreo028,l_xreo.xreo029,l_xreo.xreo030,l_xreo.xreo031,
                l_xreo.xreo032,l_xreo.xreo033,l_xreo.xreo034,l_xreo.xreo035,l_xreo.xreo036,l_xreo.xreo037,l_xreo.xreo038,l_xreo.xreo039,l_xreo.xreo040,
                l_xreo.xreo041,l_xreo.xreo042,l_xreo.xreo043,l_xreo.xreo044,l_xreo.xreo045,l_xreo.xreo100,l_xreo.xreo101,l_xreo.xreo102,l_xreo.xreo103,
                l_xreo.xreo113,l_xreo.xreo114,l_xreo.xreo121,l_xreo.xreo122,l_xreo.xreo123,l_xreo.xreo124,l_xreo.xreo131,l_xreo.xreo132,l_xreo.xreo133,l_xreo.xreo134)
      #161128-00061#4-----modify--end----------
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] <> 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "insert xreo_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END FOREACH
   #151008-00009#10 add end---
   
END FUNCTION

################################################################################
# Descriptions...: 勾選單身時的檢核
# Memo...........: 因為規格變更,如果已經有產生過月結資料
#                : 就一定要做還原,所以把檢核拉前到勾選的位置
# Usage..........: CALL axrp910_clik_chk(p_ac)
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp910_clik_chk(p_ac,p_type)
   DEFINE p_ac              LIKE type_t.num5
   DEFINE p_type            LIKE type_t.chr1    #0:檢查不報錯   1:檢查、報錯   #2:僅檢查是否已存在月結資料
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glca002         LIKE glca_t.glca002
   DEFINE l_msg             STRING
   DEFINE r_success         LIKE type_t.num5
   
   LET g_errno = NULL
   LET r_success = TRUE
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      RETURN 
   END IF
   
   #檢核 帳別+年度+期別+AR 有存在就提示要做還原
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xrea_t
    WHERE xreaent = g_enterprise
      AND xreald  = g_detail_d[p_ac].xreald
      AND xrea001 = g_master.xrea001
      AND xrea002 = g_master.xrea002
      AND xrea003 = 'AR'
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET g_errno   = 'axr-00291'
   END IF
   
   #151008-00009#10 add ------
   #檢核遞延收入月結檔有存在也要一起還原
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM xreo_t
    WHERE xreoent = g_enterprise
      AND xreold  = g_detail_d[p_ac].xreald
      AND xreo001 = g_master.xrea001
      AND xreo002 = g_master.xrea002
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET g_errno   = 'axr-00291'
   END IF
   #151008-00009#10 add end---

   IF NOT cl_null(g_errno) AND p_type = '1' THEN
      LET l_msg = cl_getmsg('aap-00152',g_lang) CLIPPED,':',g_detail_d[l_ac].xreald,
                  cl_getmsg(g_errno,g_lang) CLIPPED
      IF NOT cl_ask_confirm2('',l_msg)THEN
         LET g_detail_d[l_ac].sel = 'N'
         DISPLAY g_detail_d[l_ac].sel TO b_sel
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN LET r_success = FALSE END IF

   IF NOT cl_null(g_errno) AND p_type = '0' THEN RETURN r_success END IF

   IF p_type = '2' THEN RETURN r_success END IF

   LET g_errno = NULL
   #檢查重評價檔是否計算
   SELECT glca002 INTO l_glca002
     FROM glca_t
    #WHERE glcald = g_detail_d[p_ac].xreald AND glca001 = 'AR' #160905-00002#7 mark
    WHERE glcaent = g_enterprise #160905-00002#7
      AND glcald = g_detail_d[p_ac].xreald AND glca001 = 'AR'  #160905-00002#7 
      
   IF l_glca002 MATCHES '[23]' THEN     
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM xreb_t
       WHERE xrebent = g_enterprise
         AND xrebld  = g_detail_d[p_ac].xreald
         AND xreb001 = g_master.xrea001
         AND xreb002 = g_master.xrea002
         AND xreb003 = 'AR'
         
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN       
         LET g_errno   = 'aap-00321'
      END IF
   END IF

   IF NOT cl_null(g_errno) AND p_type = '1' THEN
      LET l_msg = cl_getmsg('aap-00152',g_lang) CLIPPED,':',g_detail_d[l_ac].xreald,
                  cl_getmsg(g_errno,g_lang) CLIPPED
      IF NOT cl_ask_confirm2('',l_msg)THEN
         LET g_detail_d[l_ac].sel = 'N'
         DISPLAY g_detail_d[l_ac].sel TO b_sel
      END IF
   END IF

   IF NOT cl_null(g_errno) THEN LET r_success = FALSE END IF

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 若再次拋轉已做月結的帳套,需要先執行月結還原
# Memo...........:
# Usage..........: CALL axrp910_axrp970(p_ac)
#                  RETURNING r_success
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/01/28 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION axrp910_axrp970(p_ac)
   DEFINE p_ac              LIKE type_t.num5
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_msg             STRING
   DEFINE r_success         LIKE type_t.num5

   #由axrp970複製到此處,如果修改就必須同步axrp970!!!

   LET r_success = TRUE
   LET l_success = TRUE

   #檢查是否有暫估傳票(xrem005) 及壞帳提列傳票(xrej005)
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xrem_t
    WHERE xrement = g_enterprise
      AND xremld  = g_detail_d[p_ac].xreald
      AND xrem001 = g_master.xrea001
      AND xrem002 = g_master.xrea002
      AND xrem003 = 'AR'
      AND xrem005 IS NOT NULL
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count <> 0 THEN
      LET l_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET l_msg = "ld:",g_detail_d[p_ac].xreald," "
      LET g_errparam.extend = l_msg CLIPPED
      LET g_errparam.code   = "aap-00220"
      LET g_errparam.replace[1] = g_master.xrea001
      LET g_errparam.replace[2] = g_master.xrea002
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF

   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM xrej_t
    WHERE xrejent = g_enterprise
      AND xrejld  = g_detail_d[p_ac].xreald
      AND xrej001 = g_master.xrea001
      AND xrej002 = g_master.xrea002
      AND xrej003 = 'AR'
      AND xrej005 IS NOT NULL
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count <> 0 THEN
      INITIALIZE g_errparam TO NULL
      LET l_msg = "ld:",g_detail_d[p_ac].xreald," "
      LET g_errparam.extend = l_msg CLIPPED
      LET g_errparam.code   = "aap-00221"
      LET g_errparam.replace[1] = g_master.xrea001
      LET g_errparam.replace[2] = g_master.xrea002
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF
   
   IF NOT r_success THEN RETURN r_success END IF
   
   #刪除暫估主檔(XREM_T)
   DELETE FROM xrem_t
    WHERE xrement = g_enterprise
      AND xremld  = g_detail_d[p_ac].xreald
      AND xrem001 = g_master.xrea001
      AND xrem002 = g_master.xrea002
      AND xrem003 = 'AR'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xrem_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF

   #刪除暫估明細檔(XREN_T)
   DELETE FROM xren_t
    WHERE xrenent = g_enterprise
      AND xren001 = g_master.xrea001
      AND xren002 = g_master.xrea002
      AND EXISTS(SELECT COUNT(*) FROM xrem_t
                  WHERE xrement = xrenent
                    AND xremdocno = xrendocno
                    AND xremld    = g_detail_d[p_ac].xreald
                    AND xrem003   = 'AR')
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xren_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF

   #刪除壞帳主檔(XREJ_T)
   DELETE FROM xrej_t
    WHERE xrejent = g_enterprise
      AND xrejld  = g_detail_d[p_ac].xreald
      AND xrej001 = g_master.xrea001
      AND xrej002 = g_master.xrea002
      AND xrej003 = 'AR'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xrej_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF
   
   #刪除壞帳明細檔(XREK_T)
   DELETE FROM xrek_t
    WHERE xrekent = g_enterprise
      AND xrek001 = g_master.xrea001
      AND xrek002 = g_master.xrea002
      AND EXISTS(SELECT COUNT(*) FROM xrej_t
                  WHERE xrejent = xrekent
                    AND xrejdocno = xrekdocno
                    AND xrejld    = g_detail_d[p_ac].xreald
                    AND xrej003   = 'AR')
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xrek_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF 

   #刪除月結檔(XREA_T)
   DELETE FROM xrea_t
    WHERE xreaent = g_enterprise
      AND xrea001 = g_master.xrea001
      AND xrea002 = g_master.xrea002
      AND xreald  = g_detail_d[p_ac].xreald
      AND xrea003 = 'AR'
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xrea_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF
   
   #151008-00009#10 add ------
   #刪除遞延收入月結檔
   DELETE FROM xreo_t
    WHERE xreoent = g_enterprise
      AND xreo001 = g_master.xrea001
      AND xreo002 = g_master.xrea002
      AND xreold  = g_detail_d[p_ac].xreald
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ld:",g_detail_d[p_ac].xreald," xreo_t del "
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   IF NOT l_success THEN LET r_success = FALSE END IF
   #151008-00009#10 add end---

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 底稿月结
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
PRIVATE FUNCTION axrp910_aglp590()
   DEFINE l_success      LIKE type_t.num5
   DEFINE t_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5

   LET l_success = TRUE
   LET t_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = "Y" THEN
         CALL s_aglp590_ins(g_detail_d[l_i].xreald,g_master.xrea001,g_master.xrea002,'AR') RETURNING l_success
         IF NOT l_success THEN
            LET t_success = FALSE
         END IF
      END IF

   END FOR

   IF NOT t_success THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axm-00088'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
