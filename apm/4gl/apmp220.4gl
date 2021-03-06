#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp220.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-10-26 14:18:42), PR版次:0002(2016-12-20 16:39:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: apmp220
#+ Description: 一般採購單整批確認作業
#+ Creator....: 05423(2015-10-23 10:11:33)
#+ Modifier...: 05423 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp220.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161207-00033#19  2016/12/20   By lixh 一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
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
   sel         LIKE type_t.chr1,             #選擇
   pmdldocno   LIKE pmdl_t.pmdldocno,        #採購單號
   pmdldocdt   LIKE pmdl_t.pmdldocdt,        #採購日期
   pmdl004     LIKE pmdl_t.pmdl004,          #供應商
   l_pmdl004_desc LIKE pmaal_t.pmaal004,     #供應商名稱
   pmdl002     LIKE pmdl_t.pmdl002,          #採購人員
   l_pmdl002_desc LIKE ooag_t.ooag011,       #姓名
   pmdl003     LIKE pmdl_t.pmdl003,          #採購部門 
   l_pmdl003_desc LIKE ooefl_t.ooefl003,     #部門名稱
   pmdl005     LIKE pmdl_t.pmdl005,          #採購性質
   pmdl009     LIKE pmdl_t.pmdl009,          #付款條件
   l_pmdl009_desc LIKE ooibl_t.ooibl004,     #付款條件說明
   pmdl010     LIKE pmdl_t.pmdl010,          #交易條件
   l_pmdl010_desc LIKE oocql_t.oocql004,     #交易條件說明
   pmdl011     LIKE pmdl_t.pmdl011,          #稅別
   l_pmdl011_desc LIKE oodbl_t.oodbl004,     #稅別說明
   pmdl012     LIKE pmdl_t.pmdl012,          #稅率
   pmdl013     LIKE pmdl_t.pmdl013,          #含稅否
   pmdl015     LIKE pmdl_t.pmdl015,          #幣別
   l_pmdl015_desc LIKE ooail_t.ooail003      #幣別說明  
END RECORD 
DEFINE g_pmdl    RECORD       #QBE
   pmdldocno   LIKE pmdl_t.pmdldocno,        #採購單號
   pmdldocdt   LIKE pmdl_t.pmdldocdt,        #採購日期
   pmdl004     LIKE pmdl_t.pmdl004,          #供應商
   pmdl002     LIKE pmdl_t.pmdl002,          #採購人員
   pmdl003     LIKE pmdl_t.pmdl003           #採購部門
END RECORD
DEFINE g_detail_idx         LIKE type_t.num5     
DEFINE g_detail_idx2        LIKE type_t.num5  
DEFINE g_detail_idx3        LIKE type_t.num5  
DEFINE g_detail_idx4        LIKE type_t.num5  
DEFINE g_detail_idx5        LIKE type_t.num5
DEFINE g_detail2_cnt       LIKE type_t.num5
DEFINE g_detail3_cnt       LIKE type_t.num5
DEFINE g_detail4_cnt       LIKE type_t.num5 
DEFINE g_detail5_cnt       LIKE type_t.num5 
DEFINE g_ooef019            LIKE ooef_t.ooef019
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
TYPE type_g_detail2_d RECORD        #採購明细
   pmdnseq     LIKE pmdn_t.pmdnseq,          #項次
   pmdn001     LIKE pmdn_t.pmdn001,          #料件編號
   l_pmdn001_desc    LIKE imaal_t.imaal003,  #品名
   l_pmdn001_desc_1  LIKE imaal_t.imaal004,  #規格
   pmdn002     LIKE pmdn_t.pmdn002,          #產品特征
   l_pmdn002_desc    LIKE oocql_t.oocql004,  #產品特征說明
   pmdn019     LIKE pmdn_t.pmdn019,          #子件特性
   pmdn006     LIKE pmdn_t.pmdn006,          #採購單位
   l_pmdn006_desc    LIKE oocal_t.oocal003,  #說明
   pmdn007     LIKE pmdn_t.pmdn007,          #採購數量
   pmdn012     LIKE pmdn_t.pmdn012,          #出貨日期
   pmdn013     LIKE pmdn_t.pmdn013,          #到廠日期
   pmdn014     LIKE pmdn_t.pmdn014,          #到庫日期
   pmdn010     LIKE pmdn_t.pmdn010,          #計價單位
   l_pmdn010_desc    LIKE oocal_t.oocal003,  #說明
   pmdn011     LIKE pmdn_t.pmdn011,          #計價數量
   pmdn015     LIKE pmdn_t.pmdn015,          #單價
   pmdn046     LIKE pmdn_t.pmdn046,          #未稅金額
   pmdn047     LIKE pmdn_t.pmdn047,          #含稅金額
   pmdn048     LIKE pmdn_t.pmdn048,          #稅額
   pmdn020     LIKE pmdn_t.pmdn020,          #緊急度
   pmdn052     LIKE pmdn_t.pmdn052           #檢驗否
END RECORD
TYPE type_g_detail3_d RECORD        #採購交期明细
   pmdoseq     LIKE pmdo_t.pmdoseq,          #項次
   pmdoseq1    LIKE pmdo_t.pmdoseq1,         #項序
   pmdo003     LIKE pmdo_t.pmdo003,          #子件特性
   pmdo001     LIKE pmdo_t.pmdo001,          #料件編號
   l_pmdo001_desc    LIKE imaal_t.imaal003,  #品名
   l_pmdo001_desc_1  LIKE imaal_t.imaal004,  #規格
   pmdo002     LIKE pmdo_t.pmdo002,          #產品特征
   l_pmdo002_desc    LIKE oocql_t.oocql004,  #產品特征說明
   pmdo004     LIKE pmdo_t.pmdo004,          #單位
   l_pmdo004_desc    LIKE oocal_t.oocal003,  #說明
   pmdoseq2    LIKE pmdo_t.pmdoseq2,         #分批序
   pmdo006     LIKE pmdo_t.pmdo006,          #分批數量
   pmdo011     LIKE pmdo_t.pmdo011,          #出貨日期
   pmdo012     LIKE pmdo_t.pmdo012,          #到廠日期
   pmdo013     LIKE pmdo_t.pmdo013           #到庫日期
END RECORD
TYPE type_g_detail4_d RECORD        #採購關聯單據明细
   pmdpseq     LIKE pmdp_t.pmdpseq,          #項次
   pmdpseq1    LIKE pmdp_t.pmdpseq1,         #項序
   pmdp001     LIKE pmdp_t.pmdp001,          #料件編號
   l_pmdp001_desc    LIKE imaal_t.imaal003,  #品名
   l_pmdp001_desc_1  LIKE imaal_t.imaal004,  #規格
   pmdp002     LIKE pmdp_t.pmdp002,          #產品特征
   l_pmdp002_desc    LIKE oocql_t.oocql004,  #產品特征說明
   pmdp003     LIKE pmdp_t.pmdp003,          #來源單號
   pmdp004     LIKE pmdp_t.pmdp004,          #來源項次
   pmdp005     LIKE pmdp_t.pmdp005,          #來源項序
   pmdp006     LIKE pmdp_t.pmdp006,          #來源分批序
   pmdp022     LIKE pmdp_t.pmdp022,          #需求單位
   l_pmdp022_desc    LIKE oocal_t.oocal003,  #說明
   pmdp023     LIKE pmdp_t.pmdp023,          #需求數量
   pmdp024     LIKE pmdp_t.pmdp024           #折合採購量
END RECORD
TYPE type_g_detail5_d RECORD        #採購多期預付款
   pmdm001     LIKE pmdm_t.pmdm001,          #期別
   pmdm002     LIKE pmdm_t.pmdm002,          #付款條件
   l_pmdm002_desc    LIKE ooibl_t.ooibl004,  #說明
   pmdm003     LIKE pmdm_t.pmdm003,          #預計應付款日
   pmdm004     LIKE pmdm_t.pmdm004,          #預計票據到期日
   pmdm005     LIKE pmdm_t.pmdm005,          #未稅金額
   pmdm006     LIKE pmdm_t.pmdm006,          #含稅金額
   pmdm007     LIKE pmdm_t.pmdm007           #應付帳款單號
END RECORD
DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d 
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d 
DEFINE g_detail4_d  DYNAMIC ARRAY OF type_g_detail4_d 
DEFINE g_detail5_d  DYNAMIC ARRAY OF type_g_detail5_d 
DEFINE g_detail2_idx         LIKE type_t.num5
DEFINE g_detail3_idx         LIKE type_t.num5
DEFINE g_detail4_idx         LIKE type_t.num5
DEFINE g_detail5_idx         LIKE type_t.num5
DEFINE g_count1      LIKE type_t.num5        #記錄勾選個數
DEFINE g_extra_cnt   LIKE type_t.num10
#end add-point
#end add-point
 
{</section>}
 
{<section id="apmp220.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CREATE TEMP TABLE apmp220_tmp
   (
      pmdldocno    VARCHAR(40)
   );
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp220 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp220_init()   
 
      #進入選單 Menu (="N")
      CALL apmp220_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp220
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp220.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp220_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_count1 = 0
   LET g_pmdl.pmdldocdt = ''  
   CALL cl_set_combo_scc('b_pmdl005','2052') 
   CALL cl_set_combo_scc('b_pmdn019','2055') 
   CALL cl_set_combo_scc('b_pmdn020','2036') 
   CALL cl_set_combo_scc('b_pmdo003','2055') 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp220.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp220_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE ls_result   STRING
   DEFINE g_loc                LIKE type_t.chr5              #判斷游標所在位置
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_count1 = 0
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmp220_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003
            BEFORE CONSTRUCT
               DISPLAY BY NAME g_pmdl.pmdldocno,g_pmdl.pmdldocdt,g_pmdl.pmdl004,g_pmdl.pmdl002,g_pmdl.pmdl003
   
            AFTER FIELD pmdldocno
               LET g_pmdl.pmdldocno = GET_FLDBUF(pmdldocno)
            
            AFTER FIELD pmdldocdt
               LET g_pmdl.pmdldocdt = GET_FLDBUF(pmdldocdt)
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
               CALL FGL_DIALOG_SETBUFFER(ls_result)
               
            AFTER FIELD pmdl002
               LET g_pmdl.pmdl002 = GET_FLDBUF(pmdl002)
               
            AFTER FIELD pmdl003
               LET g_pmdl.pmdl003 = GET_FLDBUF(pmdl003)

            ON ACTION controlp INFIELD pmdldocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE g_argv[1]
                  WHEN '1'
                     LET g_qryparam.where = " pmdlstus = 'N' AND pmdl005 IN ('1','3','4') "   #一般採購
                  WHEN '2'
                     LET g_qryparam.where = " pmdlstus = 'N' AND pmdl005 = '2' "     #委外採購
                  WHEN '3'
                     LET g_qryparam.where = " pmdlstus = 'N' AND pmdl005 = '5' "     #重複性生產採購
                  WHEN '4'
                     LET g_qryparam.where = " pmdlstus = 'N' AND pmdl005 = '6' "     #借貸採購
               END CASE
               CALL q_pmdldocno()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdldocno    #顯示到畫面上
               NEXT FIELD pmdldocno                       #返回原欄位
               
            ON ACTION controlp INFIELD pmdl004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl004      #顯示到畫面上
               NEXT FIELD pmdl004                         #返回原欄位
   
            ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl002      #顯示到畫面上
               NEXT FIELD pmdl002                         #返回原欄位
               
            ON ACTION controlp INFIELD pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl003      #顯示到畫面上
               NEXT FIELD pmdl003                         #返回原欄位

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.* ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
            BEFORE INPUT

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL apmp220_fetch()
                  
            ON CHANGE l_chk
              IF g_detail_d[l_ac].sel = 'Y' THEN 
                 LET g_count1 = g_count1 + 1
              ELSE
                 LET g_count1 = g_count1 - 1
              END IF                   
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail2_cnt)

            BEFORE DISPLAY
               LET g_current_page = 2
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_detail2_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         
         DISPLAY ARRAY g_detail3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail3_cnt)

            BEFORE DISPLAY
               LET g_current_page = 3
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx3
               DISPLAY g_detail_idx3 TO FORMONLY.idx
               DISPLAY g_detail3_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail4_cnt)

            BEFORE DISPLAY
               LET g_current_page = 4
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx4 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx4
               DISPLAY g_detail_idx4 TO FORMONLY.idx
               DISPLAY g_detail4_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         
         DISPLAY ARRAY g_detail5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail5_cnt)

            BEFORE DISPLAY
               LET g_current_page = 5
               CALL cl_set_act_visible("filter",FALSE)

            BEFORE ROW
               LET g_detail_idx5 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx5
               DISPLAY g_detail_idx5 TO FORMONLY.idx
               DISPLAY g_detail5_d.getLength() TO FORMONLY.cnt
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE) 
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               LET g_count1 = g_detail_d.getLength()
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
            LET g_count1 = 0
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            LET g_count1 = g_count1 + 1
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            LET g_count1 = g_count1 - 1
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp220_filter()
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
            CALL apmp220_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp220_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF g_count1 > 0 THEN
               CALL apmp220_execute()
               
#               CALL cl_ask_confirm3("std-00012","")          #批次作業已執行完成。       
#               IF cl_ask_confirm('asf-00182') THEN           #是否繼續執行？
                  CALL apmp220_query()
                  LET g_count1 = 0
#                  EXIT DIALOG
#               ELSE
#                  LET g_action_choice = 'exit'
#                  EXIT DIALOG
#               END IF  
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00481'    #未勾選任何資料！
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()           
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
 
{<section id="apmp220.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp220_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx3  = 1
   LET g_detail_idx4 = 1
   LET g_detail_idx5 = 1
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
   IF NOT cl_null(g_wc_filter) THEN 
      LET g_wc = g_wc," AND ",g_wc_filter
   END IF
   
   DELETE FROM apmp220_tmp;
   LET g_sql = " INSERT INTO apmp220_tmp SELECT pmdldocno FROM pmdl_t ",
               "  WHERE pmdlent = '",g_enterprise,"' AND pmdlsite = '",g_site,"' "
   CASE g_argv[1] 
      WHEN '1' #一般採購
         LET g_sql = g_sql CLIPPED, " AND pmdl005 IN ('1','3','4') AND ",g_wc," AND pmdlstus='N' AND rownum < = ",g_max_rec
      WHEN '2' #委外採購
         LET g_sql = g_sql CLIPPED, " AND pmdl005 = '2' AND ",g_wc," AND pmdlstus='N' AND rownum < = ",g_max_rec
      WHEN '3' #重複性生產採購
         LET g_sql = g_sql CLIPPED, " AND pmdl005 = '5' AND ",g_wc," AND pmdlstus='N' AND rownum < = ",g_max_rec
      WHEN '4' #借貸採購
         LET g_sql = g_sql CLIPPED, " AND pmdl005 = '6' AND ",g_wc," AND pmdlstus='N' AND rownum < = ",g_max_rec
   END CASE
   PREPARE apmp220_pre1 FROM g_sql
   EXECUTE apmp220_pre1 
   #end add-point
        
   LET g_error_show = 1
   CALL apmp220_b_fill()
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
 
{<section id="apmp220.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp220_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_pmdl028     LIKE pmdl_t.pmdl028     #161207-00033#19
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CLEAR FORM
   CALL g_detail_d.clear() 
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL g_detail5_d.clear()
   LET g_detail_idx = 0   
   LET g_sql = " SELECT DISTINCT 'N',apmp220_tmp.pmdldocno,pmdldocdt,pmdl004,pmaal004,pmdl002,ooag011,pmdl003,ooefl003,pmdl005, ",
               "                 pmdl009,ooibl004,pmdl010,oocql004,pmdl011,NULL,pmdl012,pmdl013,pmdl015,ooail003,pmdl028 ",         #161207-00033#19 add by lixh 
               "   FROM apmp220_tmp,pmdl_t ",
               "   LEFT OUTER JOIN ooag_t ON ooagent = pmdl_t.pmdlent AND pmdl_t.pmdl002 = ooag001 ",
               "   LEFT OUTER JOIN ooefl_t ON ooeflent = pmdl_t.pmdlent AND ooefl001 = pmdl_t.pmdl003 AND ooefl002 ='",g_dlang,"'",
               "   LEFT OUTER JOIN pmaal_t ON pmaalent = pmdl_t.pmdlent AND pmaal001 = pmdl_t.pmdl004 AND pmaal002 ='",g_dlang,"'",
               "   LEFT OUTER JOIN ooibl_t ON ooiblent = pmdl_t.pmdlent AND ooibl002 = pmdl_t.pmdl009 AND ooibl003 ='",g_dlang,"'",
               "   LEFT OUTER JOIN oocql_t ON oocqlent = pmdl_t.pmdlent AND oocql002 = pmdl_t.pmdl010 AND oocql001 = '238' AND oocql003 ='",g_dlang,"'",
               "   LEFT OUTER JOIN ooail_t ON ooailent = pmdl_t.pmdlent AND ooail001 = pmdl_t.pmdl015 AND ooail002 ='",g_dlang,"'",
               "  WHERE apmp220_tmp.pmdldocno = pmdl_t.pmdldocno AND pmdl_t.pmdlent = ? AND pmdl_t.pmdlsite = '",g_site,"' ",
               "  ORDER BY apmp220_tmp.pmdldocno " 
   #end add-point
 
   PREPARE apmp220_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp220_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
         g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdldocno,g_detail_d[l_ac].pmdldocdt,g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].l_pmdl004_desc,
         g_detail_d[l_ac].pmdl002,g_detail_d[l_ac].l_pmdl002_desc,g_detail_d[l_ac].pmdl003,g_detail_d[l_ac].l_pmdl003_desc,g_detail_d[l_ac].pmdl005,
         g_detail_d[l_ac].pmdl009,g_detail_d[l_ac].l_pmdl009_desc,g_detail_d[l_ac].pmdl010,g_detail_d[l_ac].l_pmdl010_desc,g_detail_d[l_ac].pmdl011,
         g_detail_d[l_ac].l_pmdl011_desc,g_detail_d[l_ac].pmdl012,g_detail_d[l_ac].pmdl013,g_detail_d[l_ac].pmdl015,g_detail_d[l_ac].l_pmdl015_desc,
         l_pmdl028
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
      LET g_detail_idx = l_ac
      #税别
      LET g_ooef019 = ''
      SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
      CALL s_desc_get_tax_desc(g_ooef019,g_detail_d[l_ac].pmdl011) RETURNING g_detail_d[l_ac].l_pmdl011_desc
      #161207-00033#19-S
      IF NOT cl_null(l_pmdl028) THEN  #一次性交易对象
         CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_detail_d[l_ac].l_pmdl004_desc
      END IF
      #161207-00033#19-E
      #end add-point
      
      CALL apmp220_detail_show()      
 
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
   FREE apmp220_sel
   
   LET l_ac = 1
   CALL apmp220_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp220.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp220_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_desc           LIKE type_t.chr100
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()
   CALL g_detail4_d.clear()
   CALL g_detail5_d.clear()
   #判定單頭是否有資料
   IF g_detail_idx <= 0 OR g_detail_d.getLength() = 0 THEN
      RETURN
   END IF
   IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
      #采购明细---------------------------------------
      LET l_ac = 1
      LET g_sql = " SELECT DISTINCT pmdnseq,pmdn001,imaal003,imaal004,pmdn002,NULL,pmdn019,pmdn006,a.oocal003, ",
                  "        pmdn007,pmdn012,pmdn013,pmdn014,pmdn010,b.oocal003,pmdn011,pmdn015,pmdn046,pmdn047,pmdn048, ",
                  "        pmdn020,pmdn052 ",
                  "   FROM pmdn_t ",
                  "   LEFT OUTER JOIN imaal_t ON pmdnent = imaalent AND pmdn001 = imaal001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT OUTER JOIN oocal_t a ON a.oocalent = pmdnent AND pmdn006 = a.oocal001 AND a.oocal002 = '",g_dlang,"' ",
                  "   LEFT OUTER JOIN oocal_t b ON b.oocalent = pmdnent AND pmdn010 = b.oocal001 AND b.oocal002 = '",g_dlang,"' ",
                  " WHERE pmdnent = '",g_enterprise,"' AND pmdndocno = '",g_detail_d[g_detail_idx].pmdldocno,"' ",
                  " ORDER BY pmdnseq "
      PREPARE apmp220_sel2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmp220_sel2
      LET l_ac = 1
      FOREACH b_fill_curs2 INTO g_detail2_d[l_ac].pmdnseq,g_detail2_d[l_ac].pmdn001,g_detail2_d[l_ac].l_pmdn001_desc,g_detail2_d[l_ac].l_pmdn001_desc_1,
                                g_detail2_d[l_ac].pmdn002,g_detail2_d[l_ac].l_pmdn002_desc,g_detail2_d[l_ac].pmdn019,g_detail2_d[l_ac].pmdn006,g_detail2_d[l_ac].l_pmdn006_desc,
                                g_detail2_d[l_ac].pmdn007,g_detail2_d[l_ac].pmdn012,g_detail2_d[l_ac].pmdn013,g_detail2_d[l_ac].pmdn014,
                                g_detail2_d[l_ac].pmdn010,g_detail2_d[l_ac].l_pmdn010_desc,g_detail2_d[l_ac].pmdn011,g_detail2_d[l_ac].pmdn015,
                                g_detail2_d[l_ac].pmdn046,g_detail2_d[l_ac].pmdn047,g_detail2_d[l_ac].pmdn048,g_detail2_d[l_ac].pmdn020,g_detail2_d[l_ac].pmdn052
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
    
            EXIT FOREACH
         END IF   
         #产品特征获取
         CALL s_feature_description(g_detail2_d[l_ac].pmdn001,g_detail2_d[l_ac].pmdn002) 
            RETURNING l_success,g_detail2_d[l_ac].l_pmdn002_desc   
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
      LET g_detail2_cnt = l_ac - 1
      CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
      #采购交期明细-----------------------------------------
      
      LET g_sql = " SELECT DISTINCT pmdoseq,pmdoseq1,pmdo003,pmdo001,imaal003,imaal004,pmdo002,NULL, ",
                  "        pmdo004,oocal003,pmdoseq2,pmdo006,pmdo011,pmdo012,pmdo013",
                  "   FROM pmdo_t ",
                  "   LEFT OUTER JOIN imaal_t ON pmdoent = imaalent AND pmdo001 = imaal001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT OUTER JOIN oocal_t ON oocalent = pmdoent AND pmdo004 = oocal001 AND oocal002 = '",g_dlang,"' ",
                  " WHERE pmdoent = '",g_enterprise,"' AND pmdodocno = '",g_detail_d[g_detail_idx].pmdldocno,"' ",
                  " ORDER BY pmdoseq "
      PREPARE apmp220_sel3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR apmp220_sel3
      LET l_ac = 1
      FOREACH b_fill_curs3 INTO g_detail3_d[l_ac].pmdoseq,g_detail3_d[l_ac].pmdoseq1,g_detail3_d[l_ac].pmdo003,g_detail3_d[l_ac].pmdo001,g_detail3_d[l_ac].l_pmdo001_desc,g_detail3_d[l_ac].l_pmdo001_desc_1,
                                g_detail3_d[l_ac].pmdo002,g_detail3_d[l_ac].l_pmdo002_desc,g_detail3_d[l_ac].pmdo004,g_detail3_d[l_ac].l_pmdo004_desc,
                                g_detail3_d[l_ac].pmdoseq2,g_detail3_d[l_ac].pmdo006,g_detail3_d[l_ac].pmdo011,g_detail3_d[l_ac].pmdo012,g_detail3_d[l_ac].pmdo013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
    
            EXIT FOREACH
         END IF   
         #产品特征获取
         CALL s_feature_description(g_detail3_d[l_ac].pmdo001,g_detail3_d[l_ac].pmdo002) 
            RETURNING l_success,g_detail3_d[l_ac].l_pmdo002_desc   
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
      LET g_detail3_cnt = l_ac - 1
      CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
      #采购关联单据明细------------------------------------
      LET g_sql = " SELECT DISTINCT pmdpseq,pmdpseq1,pmdp001,imaal003,imaal004,pmdp002,NULL, ",
                  "        pmdp003,pmdp004,pmdp005,pmdp006,pmdp022,oocal003,pmdp023,pmdp024 ",
                  "   FROM pmdp_t ",
                  "   LEFT OUTER JOIN imaal_t ON pmdpent = imaalent AND pmdp001 = imaal001 AND imaal002 = '",g_dlang,"'",
                  "   LEFT OUTER JOIN oocal_t ON oocalent = pmdpent AND pmdp022 = oocal001 AND oocal002 = '",g_dlang,"' ",
                  " WHERE pmdpent = '",g_enterprise,"' AND pmdpdocno = '",g_detail_d[g_detail_idx].pmdldocno,"' ",
                  " ORDER BY pmdpseq "
      PREPARE apmp220_sel4 FROM g_sql
      DECLARE b_fill_curs4 CURSOR FOR apmp220_sel4
      LET l_ac = 1
      FOREACH b_fill_curs4 INTO g_detail4_d[l_ac].pmdpseq,g_detail4_d[l_ac].pmdpseq1,g_detail4_d[l_ac].pmdp001,g_detail4_d[l_ac].l_pmdp001_desc,g_detail4_d[l_ac].l_pmdp001_desc_1,
                                g_detail4_d[l_ac].pmdp002,g_detail4_d[l_ac].l_pmdp002_desc,g_detail4_d[l_ac].pmdp003,g_detail4_d[l_ac].pmdp004,g_detail4_d[l_ac].pmdp005,
                                g_detail4_d[l_ac].pmdp006,g_detail4_d[l_ac].pmdp022,g_detail4_d[l_ac].l_pmdp022_desc,g_detail4_d[l_ac].pmdp023,g_detail4_d[l_ac].pmdp024
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
    
            EXIT FOREACH
         END IF   
         #产品特征获取
         CALL s_feature_description(g_detail4_d[l_ac].pmdp001,g_detail4_d[l_ac].pmdp002) 
            RETURNING l_success,l_desc
         LET g_detail4_d[l_ac].l_pmdp002_desc = l_desc
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
      LET g_detail4_cnt = l_ac - 1
      CALL g_detail4_d.deleteElement(g_detail4_d.getLength())
      #采购多期预付款---------------------------------------------
      LET g_sql = " SELECT DISTINCT pmdm001,pmdm002,ooibl004,pmdm003,pmdm004,pmdm005,pmdm006,pmdm007 ",
                  "   FROM pmdm_t ",
                  "   LEFT OUTER JOIN ooibl_t ON pmdment = ooiblent AND pmdm002 = ooibl002 AND ooibl003 = '",g_dlang,"'",
                  " WHERE pmdment = '",g_enterprise,"' AND pmdmdocno = '",g_detail_d[g_detail_idx].pmdldocno,"' ",
                  " ORDER BY pmdm001 "
      PREPARE apmp220_sel5 FROM g_sql
      DECLARE b_fill_curs5 CURSOR FOR apmp220_sel5
      LET l_ac = 1
      FOREACH b_fill_curs5 INTO g_detail5_d[l_ac].pmdm001,g_detail5_d[l_ac].pmdm002,g_detail5_d[l_ac].l_pmdm002_desc,
                                g_detail5_d[l_ac].pmdm003,g_detail5_d[l_ac].pmdm004,g_detail5_d[l_ac].pmdm005,
                                g_detail5_d[l_ac].pmdm006,g_detail5_d[l_ac].pmdm007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
    
            EXIT FOREACH
         END IF   
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
      CALL g_detail5_d.deleteElement(g_detail5_d.getLength())
      LET g_detail5_cnt = l_ac - 1
   END IF
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp220.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp220_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp220.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp220_filter()
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
   CONSTRUCT g_wc_filter ON pmdldocno,pmdl002,pmdl003 
      FROM s_detail1[1].b_pmdldocno,s_detail1[1].b_pmdl004,s_detail1[1].b_pmdl002,s_detail1[1].b_pmdl003
     
      BEFORE CONSTRUCT
  
      ON ACTION controlp INFIELD pmdldocno
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmdldocno()                         #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdldocno    #顯示到畫面上
         NEXT FIELD pmdldocno                       #返回原欄位
      
      ON ACTION controlp INFIELD pmdl004
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_pmaa001_1()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdl004      #顯示到畫面上
         NEXT FIELD pmdl004                         #返回原欄位
               
      ON ACTION controlp INFIELD pmdl002
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdl002      #顯示到畫面上
         NEXT FIELD pmdl002                         #返回原欄位
               
     ON ACTION controlp INFIELD pmdl003
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'c'
         LET g_qryparam.reqry = FALSE
         CALL q_ooag001()                           #呼叫開窗
         DISPLAY g_qryparam.return1 TO pmdl003      #顯示到畫面上
         NEXT FIELD pmdl003                         #返回原欄位

   END CONSTRUCT
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL apmp220_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp220.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp220_filter_parser(ps_field)
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
 
{<section id="apmp220.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp220_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp220_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp220.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 执行整批确认
# Memo...........:
# Usage..........: CALL apmp220_execute()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015-10-23 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp220_execute()
DEFINE ls_js         STRING
DEFINE lc_param      type_parameter
DEFINE li_count      LIKE type_t.num10  #progressbar計量
DEFINE ls_value      STRING
DEFINE l_success    LIKE type_t.num5
DEFINE l_count      LIKE type_t.num5
DEFINE l_i          LIKE type_t.num5
DEFINE l_idx        LIKE type_t.num5
DEFINE l_chr        STRING
DEFINE l_pmdl006        LIKE pmdl_t.pmdl006
DEFINE l_pmdl051        LIKE pmdl_t.pmdl051
DEFINE la_param   RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                     END RECORD
DEFINE l_success2    LIKE type_t.num5
DEFINE l_date        DATETIME YEAR TO SECOND

   LET l_success = TRUE
   LET l_success2  = TRUE
   LET li_count = 0
   CALL cl_err_collect_init()
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      #抓去所需處理資料的總筆數
      LET li_count = g_count1
      CALL cl_progress_bar_no_window(li_count) 
   END IF
   LET l_count = 0
   LET l_count = g_count1
   LET l_idx = 1
   LET g_extra_cnt = 0
   LET g_coll_title[1] = s_desc_get_error_desc('apm-01033') #采购单号
   IF l_count > 0 THEN 
      FOR l_i = 1 TO g_detail_d.getLength()
         IF g_detail_d[l_i].sel = 'Y' THEN 
            ##畫面顯示處理進度 
            IF g_bgjob <> "Y" THEN
               LET ls_value = g_detail_d[l_i].pmdldocno
               CALL cl_progress_no_window_ing(ls_value)
            END IF 
            #啟用事務
            LET l_success = TRUE
            CALL s_transaction_begin()
            IF s_apmt500_conf_chk(g_detail_d[l_i].pmdldocno) THEN
               IF NOT s_apmt500_conf_upd(g_detail_d[l_i].pmdldocno) THEN
                  CALL s_transaction_end('N',0)
                  LET l_success = FALSE 
                  LET l_success2 = FALSE   
               ELSE
                  LET l_date = cl_get_current()
               
                  #異動狀態碼欄位/修改人/修改日期
                  UPDATE pmdl_t 
                     SET (pmdlmodid,pmdlmoddt) 
                       = (g_user,l_date)     
                   WHERE pmdlent = g_enterprise AND pmdldocno = g_detail_d[l_i].pmdldocno
                
                   
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = FALSE 
                     CALL cl_err()
                     CALL s_transaction_end('N',0)              
                  ELSE
                     CALL s_transaction_end('Y',0)
                     SELECT pmdl006,pmdl051 INTO l_pmdl006,l_pmdl051
                       FROM pmdl_t
                      WHERE pmdldocno = g_detail_d[l_i].pmdldocno
                        AND pmdlent = g_enterprise
                        AND pmdlsite = g_site
                     #多角自動拋轉
                     IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y' AND
                        l_pmdl006 MATCHES '[23]' AND
                        l_pmdl051 IS NOT NULL THEN  
                        
                        INITIALIZE la_param.* TO NULL
                        LET la_param.prog     = 'aicp200'
                        LET la_param.param[1] = g_detail_d[l_i].pmdldocno
                        LET ls_js = util.JSON.stringify(la_param)
                        CALL cl_cmdrun_wait(ls_js)
                     END IF
                  END IF
               END IF                  
            ELSE
               CALL s_transaction_end('N',0)
               LET l_success = FALSE       
               LET l_success2 = FALSE         
            END IF
         END IF
         CALL apmp220_err_collect(g_detail_d[l_i].pmdldocno)
      END FOR         
   END IF
   CALL cl_err_collect_show() 
   IF l_success2 = TRUE THEN 
      CALL cl_ask_confirm3("std-00012","")
   END IF
END FUNCTION

################################################################################
# Descriptions...: 汇总采购单号
# Memo...........:
# Usage..........: CALL apmp220_err_collect(p_pmdldocno)
#                  RETURNING 回传参数
# Date & Author..: 2015-11-9 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp220_err_collect(p_pmdldocno)
   DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
   DEFINE l_i           LIKE type_t.num10
   
   FOR l_i = g_extra_cnt + 1 TO g_errcollect.getLength()
      LET g_errcollect[l_i].extra[1] = p_pmdldocno   #額外欄位資訊
   END FOR
   
   LET g_extra_cnt = g_errcollect.getLength()
END FUNCTION

#end add-point
 
{</section>}
 
