#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp960.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-10-31 15:33:10), PR版次:0008(2016-12-01 17:34:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: axrp960
#+ Description: 應收帳款重評價還原作業
#+ Creator....: 01533(2014-10-29 15:38:26)
#+ Modifier...: 01533 -SD/PR- 02481
 
{</section>}
 
{<section id="axrp960.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#4   2015/10/16  By Reanna   選的期別小於關帳日期才要報錯
#151117-00006#1   2015/11/17  By 01727    2*和02、04類型的單據金額回寫時需要＊－１
#160811-00009#4   2016/08/19  By 01531    账务中心/法人/账套权限控管
#161021-00050#4   2016/10/24  By 08729    處理組織開窗
#161128-00061#4   2016/12/01  by 02481     标准程式定义采用宣告模式,弃用.*写法
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
        sel LIKE type_t.chr1, 
   xrebld LIKE xreb_t.xrebld, 
   xrebld_desc LIKE type_t.chr500, 
   xrebcomp LIKE xreb_t.xrebcomp, 
   xrebcomp_desc LIKE type_t.chr500, 
   xreb100 LIKE xreb_t.xreb100, 
   glav004 LIKE glav_t.glav004, 
   xreb008 LIKE xreb_t.xreb008, 
   glca002 LIKE type_t.chr500, 
   glca003 LIKE type_t.chr500, 
   xreg005 LIKE xreg_t.xreg005
   END RECORD 
   
  TYPE type_g_master RECORD
       b_site           LIKE xrcb_t.xrcbsite, 
       b_site_desc      LIKE ooefl_t.ooefl003,
       xreb001          LIKE xreb_t.xreb001,
       xreb002          LIKE xreb_t.xreb002
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
DEFINE g_detail_idx          LIKE type_t.num5
DEFINE g_flag      LIKE type_t.chr1    #條件範圍是否有資料
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrp960.main" >}
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
      OPEN WINDOW w_axrp960 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp960_init()   
 
      #進入選單 Menu (="N")
      CALL axrp960_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp960
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp960.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp960_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
  #CALL cl_set_combo_scc('xreb001','9937') 
   CALL cl_set_combo_scc('b_glca002','8317') 
   CALL cl_set_combo_scc('b_glca003','8724')
    CALL s_fin_create_account_center_tmp()   
   CALL s_fin_set_comp_scc('xreb001','43')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp960.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp960_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   DEFINE l_site            LIKE xrcb_t.xrcbsite
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
         CALL axrp960_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
          INPUT BY NAME g_master.b_site,g_master.xreb001,g_master.xreb002

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL axrp960_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY BY NAME g_master.* 

            BEFORE FIELD b_site
               LET l_site = g_master.b_site
              

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_site != g_master.b_site THEN
                     SELECT ooef017 INTO l_ooef017 FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
                     LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

                     LET g_master.xreb001 = YEAR(l_flag)
                     LET g_master.xreb002 = MONTH(l_flag)
                  END IF
               END IF
               CALL axrp960_site_ref()

            BEFORE FIELD xreb001
      

            ON CHANGE xreb001
               IF NOT cl_null(g_master.xreb001) THEN
                  CALL axrp960_date_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_master.xreb001
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #151013-00019#4 add ------
                     SELECT ooef017 INTO l_ooef017 FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
                     LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期
                     LET g_master.xreb001 = YEAR(l_flag)
                     NEXT FIELD CURRENT
                     #151013-00019#4 add end---
                  END IF
               END IF

            BEFORE FIELD xreb002
            

            ON CHANGE xreb002
               IF NOT cl_null(g_master.xreb002) THEN
                  CALL axrp960_date_chk()
                  IF NOT cl_null(g_errno) THEN
                     LET g_errparam.extend = g_master.xreb002
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #151013-00019#4 add ------
                     SELECT ooef017 INTO l_ooef017 FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
                     LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期
                     LET g_master.xreb002 = MONTH(l_flag)
                     NEXT FIELD CURRENT
                     #151013-00019#4 add end---
                  END IF
               END IF

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#4 
               #CALL q_ooef001()                          #呼叫開窗    #161021-00050#4 mark
               LET g_qryparam.where = " ooefstus = 'Y' " #161021-00050#4 add
               CALL q_ooef001_46()                       #161021-00050#4 add
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL axrp960_site_ref()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT  
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
           
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
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
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_detail_d.getLength()
               #IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF NOT cl_null(g_detail_d[li_idx].xreg005) OR g_detail_d[li_idx].glca002 = '1' THEN  #1027 xreb023-->xreg005
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axr-00231'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_detail_d[li_idx].sel = "N"
                  END IF
               #END IF
               #02097-(S)
               CALL s_aap_evaluation_chk('2','AR',g_detail_d[li_idx].xrebld,g_detail_d[li_idx].xrebcomp,g_master.xreb001,g_master.xreb002) 
                    RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  LET g_detail_d[li_idx].sel = 'N'
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_detail_d[li_idx].xrebld
                  LET g_errparam.popup = TRUE
                  CALL cl_err()  
               END IF
               #02097-(E)
            END FOR
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
                  IF NOT cl_null(g_detail_d[li_idx].xreg005) OR g_detail_d[li_idx].glca002 = '1'  THEN  #1027 xreb023-->xreg005
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'axr-00231'
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     LET g_detail_d[li_idx].sel = "N"
                  END IF
                  #02097-(S)
                  CALL s_aap_evaluation_chk('2','AR',g_detail_d[li_idx].xrebld,g_detail_d[li_idx].xrebcomp,g_master.xreb001,g_master.xreb002) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_detail_d[li_idx].sel = 'N'
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_detail_d[li_idx].xrebld
                     LET g_errparam.popup = TRUE
                     CALL cl_err()  
                  END IF
                  #02097-(E)
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
            CALL axrp960_filter()
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
            CALL axrp960_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp960_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
          ON ACTION click_sel
           ##################################
           #FOR li_idx = 1 TO g_detail_d.getLength()
           #   CASE
           #      WHEN g_detail_d[li_idx].sel = 'N'
           #         IF NOT cl_null(g_detail_d[li_idx].xreg005) OR g_detail_d[l_ac].glca002 = '1' THEN
           #            INITIALIZE g_errparam TO NULL 
           #            LET g_errparam.extend = ''
           #            LET g_errparam.code   = 'axr-00231'
           #            LET g_errparam.popup  = TRUE 
           #            CALL cl_err()
           #            LET g_detail_d[li_idx].sel = "N"
           #         ELSE
           #            LET g_detail_d[li_idx].sel = "Y"
           #         END IF
           #      WHEN g_detail_d[li_idx].sel = 'Y'
           #         LET g_detail_d[li_idx].sel = "N"
           #   END CASE
           #END FOR
            IF l_ac > 0 THEN
              CASE
                 WHEN g_detail_d[l_ac].sel = 'N' 
                     IF NOT cl_null(g_detail_d[l_ac].xreg005) OR g_detail_d[l_ac].glca002 = '1' THEN
                          INITIALIZE g_errparam TO NULL 
                          LET g_errparam.extend = ''
                          LET g_errparam.code   = 'axr-00231'
                          LET g_errparam.popup  = TRUE 
                          CALL cl_err()
                          LET g_detail_d[l_ac].sel = "N"
                       ELSE
                          LET g_detail_d[l_ac].sel = "Y"
                       END IF
                 WHEN g_detail_d[l_ac].sel = 'Y'
                       LET g_detail_d[l_ac].sel = "N"
              END CASE   
            END IF
            ############################
            
         ON ACTION batch_execute
            CALL axrp960_process()
            IF g_success ='N' THEN
               CONTINUE DIALOG
            END IF
               
            IF g_bgjob = "N" THEN            
               CALL cl_ask_confirm3("std-00012","")
            END IF
            NEXT FIELD b_site  
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
 
{<section id="axrp960.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp960_query()
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
   CALL axrp960_b_fill()
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
 
{<section id="axrp960.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp960_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"

   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_glaa003       LIKE glaa_t.glaa003
   DEFINE l_ld_str        STRING   #160811-00009#4
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #LET g_sql = "SELECT  UNIQUE 'N',xrebld,'',xrebcomp,'',xreb100,'',xreb008,'','','' FROM xreb_t",
   #
   #
   #            "",
   #            " WHERE xrebent= ? AND 1=1 ",
   #
   #LET g_sql = g_sql, cl_sql_add_filter("xreb_t"),
   #                   " ORDER BY xrebld,xrebcomp"
#160811-00009#4 mod s---   
#   CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
#   #取得帳務組織下所屬成員之帳別   
#   CALL s_fin_account_center_ld_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL axrp960_get_xreald_wc(ls_wc) RETURNING ls_wc
#
#   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'',glaa001,'','',glca002,glca003,'' FROM glaa_t,glca_t ",
#              "  WHERE glaaent = ? ",
#              "    AND glaaent = glcaent ",
#              "    AND glaald = glcald ",
#              "    AND glca001 = 'AR' ",
#              "    AND glca002 <> '1' ",    #無重評不撈出
#              "    AND glaald IN ",ls_wc,    
#              "  ORDER BY glaald,glaacomp "
   CALL s_fin_account_center_sons_query('3',g_master.b_site,g_today,'1')
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)   
   CALL s_axrt300_get_site(g_user,ls_wc,'2') RETURNING l_ld_str
   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'',glaa001,'','',glca002,glca003,'' FROM glaa_t,glca_t ",
              "  WHERE glaaent = ? ",
              "    AND glaaent = glcaent ",
              "    AND glaald = glcald ",
              "    AND glca001 = 'AR' ",
              "    AND glca002 <> '1' ",    #無重評不撈出
              "    AND ",l_ld_str,
              "  ORDER BY glaald,glaacomp "
#160811-00009#4 mod e---              
   #end add-point
 
   PREPARE axrp960_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp960_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].xrebld,g_detail_d[l_ac].xrebld_desc,g_detail_d[l_ac].xrebcomp, 
       g_detail_d[l_ac].xrebcomp_desc,g_detail_d[l_ac].xreb100,g_detail_d[l_ac].glav004,g_detail_d[l_ac].xreb008, 
       g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003,g_detail_d[l_ac].xreg005
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
      CALL s_axrt300_xrca_ref('xrcald',g_detail_d[l_ac].xrebld,'','')
         RETURNING l_success,g_detail_d[l_ac].xrebld_desc
      LET g_detail_d[l_ac].xrebld_desc = g_detail_d[l_ac].xrebld,"(",g_detail_d[l_ac].xrebld_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_detail_d[l_ac].xrebcomp,'','')
         RETURNING l_success,g_detail_d[l_ac].xrebcomp_desc
      LET g_detail_d[l_ac].xrebcomp_desc = g_detail_d[l_ac].xrebcomp,"(",g_detail_d[l_ac].xrebcomp_desc,")"

#      SELECT glca002,glca003 INTO g_detail_d[l_ac].glca002,g_detail_d[l_ac].glca003 FROM glca_t
#       WHERE glcaent = g_enterprise
#         AND glcald = g_detail_d[l_ac].xrebld
#         AND glca001 = 'AR'
     #重評價傳票號碼 2015/08/23        
      SELECT  UNIQUE xreg005 INTO g_detail_d[l_ac].xreg005 FROM xreg_t 
       WHERE xregent = g_enterprise 
         AND xregld = g_detail_d[l_ac].xrebld
         AND xreg001 = g_master.xreb001
         AND xreg002 = g_master.xreb002
         AND xreg003 = 'AR'

     #albireo 151015-----s
     #SELECT xreg005 INTO g_detail_d[l_ac].xreg005 FROM xreg_t 
     # WHERE xregent = g_enterprise AND xregld = g_detail_d[l_ac].xrebld
     #   AND xreg002 = g_master.xreb002
     #albireo 151015-----e  
         
      
      IF NOT cl_null(g_detail_d[l_ac].xreg005) OR g_detail_d[l_ac].glca002 = '1' THEN LET g_detail_d[l_ac].sel = 'N' END IF
      #02097-(S)
      CALL s_aap_evaluation_chk('2','AR',g_detail_d[l_ac].xrebld,g_detail_d[l_ac].xrebcomp,g_master.xreb001,g_master.xreb002) 
           RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET g_detail_d[l_ac].sel = 'N'
      END IF
      #02097-(E)
      SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaaent = g_enterprise
         AND glaald = g_detail_d[l_ac].xrebld

      SELECT MIN(glav004) INTO g_detail_d[l_ac].glav004 FROM glav_t WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_master.xreb001
         AND glav006 = g_master.xreb002

      SELECT MAX(glav004) INTO g_detail_d[l_ac].xreb008 FROM glav_t WHERE glavent = g_enterprise
         AND glav001 = l_glaa003
         AND glav002 = g_master.xreb001
         AND glav006 = g_master.xreb002
      #end add-point
      
      CALL axrp960_detail_show()      
 
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
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp960_sel
   
   LET l_ac = 1
   CALL axrp960_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp960.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp960_fetch()
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
 
{<section id="axrp960.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp960_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp960.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp960_filter()
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
   LET g_detail_idx  = 1
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL axrp960_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp960.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp960_filter_parser(ps_field)
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
 
{<section id="axrp960.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp960_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp960_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp960.other_function" readonly="Y" >}
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
PUBLIC FUNCTION axrp960_site_ref()
DEFINE l_success      LIKE type_t.chr1
DEFINE l_flag         LIKE type_t.dat
DEFINE l_ooef017      LIKE ooef_t.ooef017

   CALL s_axrt300_xrca_ref('xrcasite',g_master.b_site,'','') RETURNING l_success,g_master.b_site_desc
   DISPLAY BY NAME g_master.b_site_desc

   #取得帳務中心歸屬法人 141223
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise
      AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET g_master.xreb001 = YEAR(l_flag)
   LET g_master.xreb002 = MONTH(l_flag)

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
PUBLIC FUNCTION axrp960_def()
DEFINE l_success         LIKE type_t.chr1
DEFINE l_flag            LIKE type_t.dat
   DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF NOT cl_null(g_master.b_site) THEN RETURN END IF

   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.b_site,g_errno
   CALL axrp960_site_ref()

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET g_master.xreb001 = YEAR(l_flag)
   LET g_master.xreb002 = MONTH(l_flag)
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
PUBLIC FUNCTION axrp960_date_chk()
DEFINE l_flag         LIKE type_t.dat
DEFINE l_xreb001      LIKE xreb_t.xreb001
DEFINE l_xreb002      LIKE xreb_t.xreb002
DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF cl_null(g_master.b_site) THEN RETURN END IF

   IF cl_null(g_master.xreb001) THEN RETURN END IF

   IF cl_null(g_master.xreb002) THEN RETURN END IF

   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.b_site
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-2007')   #关账日期

   LET l_xreb001 = YEAR(l_flag)
   LET l_xreb002 = MONTH(l_flag)

   LET g_errno = ' '
  #IF l_xreb001 < g_master.xreb001 THEN #151013-00019#4 mark
   IF l_xreb001 > g_master.xreb001 THEN #151013-00019#4
      LET g_errno = 'axr-00162'
   END IF

  #IF l_xreb001 >= g_master.xreb001 AND l_xreb002 < g_master.xreb002 THEN #151013-00019#4 mark
   IF l_xreb001 >= g_master.xreb001 AND l_xreb002 > g_master.xreb002 THEN #151013-00019#4
      LET g_errno = 'axr-00163'
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
PUBLIC FUNCTION axrp960_get_xreald_wc(p_wc)
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
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION axrp960_process()
DEFINE l_i         LIKE type_t.num5
DEFINE l_wc        STRING
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_t.num5

   LET g_success = 'N'

   #取得有勾選的帳套條件
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR 
      ELSE
         #02097-(S)
         CALL s_aap_evaluation_chk('2','AR',g_detail_d[l_i].xrebld,g_detail_d[l_i].xrebcomp,g_master.xreb001,g_master.xreb002) 
              RETURNING g_sub_success,g_errno
         IF NOT g_sub_success THEN
            LET g_detail_d[l_i].sel = 'N'
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_detail_d[l_i].xrebld
            LET g_errparam.popup = TRUE
            CALL cl_err()  
            RETURN
         ELSE
         #02097-(E)
            IF cl_null(l_wc) THEN
               LET l_wc = g_detail_d[l_i].xrebld
            ELSE
               LET l_wc = l_wc,"','",g_detail_d[l_i].xrebld
            END IF       
         END IF
      END IF
   END FOR
   #未勾選任何一筆資料
   IF cl_null(l_wc) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()       
      LET g_success = 'N'
      RETURN
   ELSE
      LET l_wc = "('",l_wc,"')"      
   END IF    
      
   LET g_success = 'Y'
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL axrp960_del_xreb(l_wc,g_master.b_site,g_master.xreb001,g_master.xreb002)
    RETURNING g_flag   

   IF g_flag = 'N' THEN    #條件範圍沒有資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00067'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   
   CALL cl_err_collect_show()
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
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
PUBLIC FUNCTION axrp960_del_xreb(p_wc,p_xrebsite,p_xreb001,p_xreb002)
DEFINE p_wc             STRING
DEFINE p_xrebsite       LIKE xreb_t.xrebsite
DEFINE p_xreb001        LIKE xreb_t.xreb001
DEFINE p_xreb002        LIKE xreb_t.xreb002
DEFINE l_glaa003        LIKE glaa_t.glaa003  
DEFINE l_flag           LIKE type_t.chr1
DEFINE l_errno          LIKE type_t.chr100
DEFINE l_glav002        LIKE glav_t.glav002
DEFINE l_glav005        LIKE glav_t.glav005
DEFINE l_sdate_s        LIKE glav_t.glav004
DEFINE l_sdate_e        LIKE glav_t.glav004
DEFINE l_glav006        LIKE glav_t.glav006
DEFINE l_pdate_s        LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e        LIKE glav_t.glav004   #當期截止日
DEFINE l_glav007        LIKE glav_t.glav007
DEFINE l_wdate_s        LIKE glav_t.glav004
DEFINE l_wdate_e        LIKE glav_t.glav004
DEFINE l_tmp            RECORD
          xrebld     LIKE xreb_t.xrebld,
          xreb001    LIKE xreb_t.xreb001,
          xreb002    LIKE xreb_t.xreb002,
          xreb003    LIKE xreb_t.xreb003,
          xreb005    LIKE xreb_t.xreb005,
          xreb006    LIKE xreb_t.xreb006,
          xreb007    LIKE xreb_t.xreb007,
          xreb102    LIKE xreb_t.xreb102,
          xreb115    LIKE xreb_t.xreb115,
          xreb125    LIKE xreb_t.xreb125,
          xreb122    LIKE xreb_t.xreb122,
          xreb132    LIKE xreb_t.xreb132,
          xreb135    LIKE xreb_t.xreb135
                        END RECORD 
DEFINE l_sql            STRING   
DEFINE l_last_y         LIKE type_t.num5
DEFINE l_last_m         LIKE type_t.num5
DEFINE l_glca002        LIKE glca_t.glca002
DEFINE l_xreb116_t      LIKE xreb_t.xreb116
DEFINE l_xreb126_t      LIKE xreb_t.xreb126
DEFINE l_xreb136_t      LIKE xreb_t.xreb136
DEFINE l_xreg005        LIKE xreg_t.xreg005
DEFINE r_flag           LIKE type_t.chr1    #條件範圍是否有資料 
DEFINE l_n              LIKE type_t.num5
#20150318 Add  By 01727 ---(S)---
DEFINE l_xregdocno  LIKE xreg_t.xregdocno
DEFINE l_glaacomp   LIKE glaa_t.glaacomp
DEFINE l_success    LIKE type_t.num5
DEFINE l_glaa121    LIKE glaa_t.glaa121
DEFINE l_dfin0030   LIKE type_t.chr1
DEFINE l_ooba002    LIKE ooba_t.ooba002
#20150318 Add  By 01727 ---(E)---
DEFINE l_xreb004    LIKE xreb_t.xreb004   #151117-00006#1 Add

   LET r_flag = 'N'
   LET l_sql = " SELECT xrebld,xreb001,xreb002,xreb003,xreb005,",
               "        xreb006,xreb007,xreb102,xreb115,xreb122,",
               "        xreb125,xreb132,xreb135",
               "   FROM xreb_t ",    
               "  WHERE xrebent = '",g_enterprise,"' ",
               "    AND xrebsite= '",p_xrebsite,"' ",
               "    AND xreb001 = '",p_xreb001,"' ",
               "    AND xreb002 = '",p_xreb002,"' ",
               "    AND xreb003 = 'AR' ",                              
               "    AND xrebld IN ",p_wc               

   PREPARE aapp960_sel_xreb_p FROM l_sql
   DECLARE aaapp960_sel_xreb_c CURSOR FOR aapp960_sel_xreb_p
                                              
   FOREACH aaapp960_sel_xreb_c INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #已有傳票號碼不可還原
      SELECT COUNT(*) INTO l_n
        FROM xreg_t
       WHERE xregent = g_enterprise
         AND xregld = l_tmp.xrebld
         AND xreg001 = l_tmp.xreb001
         AND xreg002 = l_tmp.xreb002
         AND xreg003 = 'AR'
         AND xreg005 IS NOT NULL
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00235'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = 'N'
      ELSE
         LET l_glaa003 = ''
         #取得會計週期參照表
         CALL s_ld_sel_glaa(l_tmp.xrebld,'glaa003') RETURNING  g_sub_success,l_glaa003
         
         #依年度+期別取得會計週期起迄日l_pdate_s,l_pdate_e
         CALL s_get_accdate(l_glaa003,'',p_xreb001,p_xreb002)
         RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                   l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
         #取上期的年度期別
         CALL s_fin_date_get_last_period(l_glaa003,l_tmp.xrebld,p_xreb001,p_xreb002)
         RETURNING g_sub_success,l_last_y,l_last_m

         #重評價處理模式
         SELECT glca002 INTO l_glca002
           FROM glca_t
          WHERE glcaent = g_enterprise
            AND glcald = l_tmp.xrebld
            AND glca001 = 'AR'
         #重評價傳票，次月不迴轉才update
         IF l_glca002 = '3' THEN
            LET l_xreb116_t = 0   #151117-00006#1 Add
            LET l_xreb126_t = 0   #151117-00006#1 Add
            LET l_xreb136_t = 0   #151117-00006#1 Add
            #取上期匯差
            SELECT xreb004,xreb116,xreb126,xreb136   #151117-00006#1 Add  xreb004
              INTO l_xreb004,l_xreb116_t,l_xreb126_t,l_xreb136_t   #151117-00006#1 Add l_xreb004
              FROM xreb_t
             WHERE xrebent = g_enterprise
               AND xrebld = l_tmp.xrebld
               AND xreb001 = l_last_y   #上期年度
               AND xreb002 = l_last_m   #上期月份
               AND xreb005 = l_tmp.xreb005
               AND xreb006 = l_tmp.xreb006
               AND xreb007 = l_tmp.xreb007
            IF cl_null(l_xreb116_t) THEN LET l_xreb116_t = 0 END IF
            IF cl_null(l_xreb126_t) THEN LET l_xreb126_t = 0 END IF
            IF cl_null(l_xreb136_t) THEN LET l_xreb136_t = 0 END IF
           #151117-00006#1 Add  ---(S)---
            IF l_xreb004[1,1] = '2' OR l_xreb004 = '02' OR l_xreb004 = '04' THEN 
               LET l_xreb116_t = l_xreb116_t * -1
               LET l_xreb126_t = l_xreb126_t * -1
               LET l_xreb136_t = l_xreb136_t * -1
            END IF
           #151117-00006#1 Add  ---(E)---
            ###還原重評價調整數###
            UPDATE xrcc_t SET 
                   xrcc102 = l_tmp.xreb102,
                   xrcc122 = l_tmp.xreb122,
                   xrcc132 = l_tmp.xreb132,
                   xrcc113 = l_xreb116_t,
                   xrcc123 = l_xreb126_t,
                   xrcc133 = l_xreb136_t
             WHERE xrccent = g_enterprise
               AND xrccld = l_tmp.xrebld
               AND xrccdocno = l_tmp.xreb005
               AND xrccseq = l_tmp.xreb006
               AND xrcc001 = l_tmp.xreb007
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd xrcc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = 'N'
            END IF
            
            
            ###重計本幣應付金額###
           #UPDATE xrcc_t SET xrcc118 = xrcc115 - xrcc116 - xrcc117 + xrcc114 + xrcc113,
           #                  xrcc128 = xrcc125 - xrcc126 - xrcc127 + xrcc124 + xrcc123,
           #                  xrcc138 = xrcc135 - xrcc136 - xrcc137 + xrcc134 + xrcc133
           # WHERE xrccent = g_enterprise
           #   AND xrccld = l_tmp.xrebld
           #   AND xrccdocno = l_tmp.xreb005
           #   AND xrccseq = l_tmp.xreb006
           #   AND xrcc001 = l_tmp.xreb007
           #IF SQLCA.SQLcode  THEN
           #   INITIALIZE g_errparam TO NULL
           #   LET g_errparam.code = SQLCA.sqlcode
           #   LET g_errparam.extend = "upd xrcc_t"
           #   LET g_errparam.popup = TRUE
           #   CALL cl_err()
           #   LET g_success = 'N'
           #END IF
         END IF
         
         
         ###還原帳套重評價年月為前期##
         UPDATE glca_t SET glca006 = l_last_y,
                           glca007 = l_last_m
          WHERE glcaent = g_enterprise
            AND glcald = l_tmp.xrebld 
            AND glca001 = 'AR'
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd glca_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
         LET r_flag = 'Y'
             #20150318 Add  By 01727 ---(S)---
         SELECT xregdocno INTO l_xregdocno FROM xreg_t WHERE xregent = g_enterprise
            AND xreg001 = p_xreb001
            AND xreg002 = p_xreb002
            AND xregld  = l_tmp.xrebld
            AND xreg003 = 'AR'

         IF NOT cl_null(l_xregdocno) THEN
            SELECT glaacomp,glaa121 INTO l_glaacomp,l_glaa121 FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = l_tmp.xrebld
           
            CALL s_aooi200_fin_get_slip(l_xregdocno) RETURNING l_success,l_ooba002
            CALL s_fin_get_doc_para(l_tmp.xrebld,l_glaacomp,l_ooba002,'D-FIN-0030')
               RETURNING l_dfin0030
            IF l_glaa121 = 'Y' AND l_dfin0030 = 'Y' THEN
               CALL s_pre_voucher_del('AR','R40',l_tmp.xrebld,l_xregdocno) RETURNING l_success
               
               IF NOT l_success THEN LET g_success = 'N' END IF
            END IF
         END IF

         #20150318 Add  By 01727 ---(E)---
         #刪除xreb_t資料
         LET l_sql = " DELETE FROM xreb_t ",
                     "  WHERE xrebent = '",g_enterprise,"'",
                     "    AND xrebsite= '",p_xrebsite,"'",
                     "    AND xrebld = '",l_tmp.xrebld,"'",
                     "    AND xreb001 = '",p_xreb001,"'",
                     "    AND xreb002 = '",p_xreb002,"'",
                     "    AND xreb003 = 'AR' "
         PREPARE aapp960_xreb_del FROM l_sql
         EXECUTE aapp960_xreb_del
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del xreb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
         
         #刪除xreg_t資料
         LET l_sql = " DELETE FROM xreg_t ",
                     "  WHERE xregent = '",g_enterprise,"' ",
                     "    AND xregsite= '",p_xrebsite,"' ",
                     "    AND xregld = '",l_tmp.xrebld,"'",
                     "    AND xreg001 = '",p_xreb001,"' ",
                     "    AND xreg002 = '",p_xreb002,"' ",
                     "    AND xreg003 = 'AR' "
         PREPARE aapp960_xreg_del FROM l_sql
         EXECUTE aapp960_xreg_del
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del xreg_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
      
         #刪除xreh_t資料
         LET l_sql = " DELETE FROM xreh_t ",
                     "  WHERE xrehent = '",g_enterprise,"' ",
                     "    AND xrehld = '",l_tmp.xrebld,"'",
                     "    AND xreh001 = '",p_xreb001,"' ",
                     "    AND xreh002 = '",p_xreb002,"' ",
                     "    AND xreh003 = 'AR' "
         PREPARE aapp960_xreh_del FROM l_sql
         EXECUTE aapp960_xreh_del
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "del xreh_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
         END IF
         
      END IF
   END FOREACH

   RETURN r_flag
END FUNCTION

#end add-point
 
{</section>}
 
