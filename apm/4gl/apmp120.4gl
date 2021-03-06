#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-11-28 22:58:13), PR版次:0002(2016-12-20 16:39:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: apmp120
#+ Description: VMI採購結算還原作業
#+ Creator....: 07024(2015-11-27 09:19:10)
#+ Modifier...: 07024 -SD/PR- 01534
 
{</section>}
 
{<section id="apmp120.global" >}
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
     sel           LIKE type_t.chr1,          #選擇
     sel2          LIKE type_t.chr1,          #選擇 
     pmds000       LIKE gzcbl_t.gzcbl004,     #單據類型
     pmdsdocno     LIKE pmds_t.pmdsdocno,     #單據編號
     pmdsdocdt     LIKE pmds_t.pmdsdocdt,     #收貨日期
     pmds001       LIKE pmds_t.pmds001,       #過帳日期
     pmds007       LIKE pmds_t.pmds007,       #供應商
     pmds007_desc  LIKE pmaal_t.pmaal004,     #供應商名稱
     pmds002       LIKE pmds_t.pmds002,       #異動人員
     pmds002_desc  LIKE ooag_t.ooag011,       #姓名
     pmds003       LIKE pmds_t.pmds003        #異動部門
   END RECORD
TYPE type_g_detail2_d RECORD
    pmdtdocno         LIKE pmdt_t.pmdtdocno, #單據編號
    pmdtseq           LIKE pmdt_t.pmdtseq,   #項次
    pmdt006           LIKE pmdt_t.pmdt006,   #料件編號
    pmdt006_desc1     LIKE imaal_t.imaal003, #品名
    pmdt006_desc2     LIKE imaal_t.imaal004, #規格
    pmdt007           LIKE pmdt_t.pmdt007,   #產品特徵
    pmdt063           LIKE pmdt_t.pmdt063,   #庫存管理特徵
    pmdt019           LIKE pmdt_t.pmdt019,   #單位
    pmdt019_desc      LIKE oocal_t.oocal003, #單位說明
    pmdt020           LIKE pmdt_t.pmdt020,   #數量
    pmdt021           LIKE pmdt_t.pmdt021,   #參考單位
    pmdt021_desc      LIKE oocal_t.oocal003, #參考單位說明
    pmdt022           LIKE pmdt_t.pmdt022,   #參考數量
    pmdt016           LIKE pmdt_t.pmdt016,   #庫位
    pmdt016_desc      LIKE inaa_t.inaa002,   #庫位名稱
    pmdt017           LIKE pmdt_t.pmdt017,   #儲位
    pmdt017_desc      LIKE inab_t.inab003,   #儲位名稱
    pmdt018           LIKE pmdt_t.pmdt018,   #批號
    pmdt046           LIKE pmdt_t.pmdt046,   #稅別
    pmdt046_desc      LIKE oodbl_t.oodbl004, #稅別說明
    pmdt037           LIKE pmdt_t.pmdt037,   #稅率
    pmdt023           LIKE pmdt_t.pmdt023,   #計價單位
    pmdt023_desc      LIKE oocal_t.oocal003, #計價單位說明
    pmdt024           LIKE pmdt_t.pmdt024,   #計價數量
    pmdt036           LIKE pmdt_t.pmdt036,   #單價
    pmdt038           LIKE pmdt_t.pmdt038,   #未稅金額
    pmdt039           LIKE pmdt_t.pmdt039,   #含稅金額
    pmdt047           LIKE pmdt_t.pmdt047    #稅額
   END RECORD
TYPE type_g_detail3_d RECORD
    inaj015           LIKE inaj_t.inaj015,   #單據性質
    inaj022           LIKE inaj_t.inaj022,   #過帳日期
    inaj001           LIKE inaj_t.inaj001,   #單據編號
    inaj002           LIKE inaj_t.inaj002,   #項次
    inaj003           LIKE inaj_t.inaj003,   #項序
    inaj005           LIKE inaj_t.inaj005,   #料件編號
    inaj005_desc1     LIKE imaal_t.imaal003, #品名
    inaj005_desc2     LIKE imaal_t.imaal004, #規格
    inaj006           LIKE inaj_t.inaj006,   #產品特徵
    inaj007           LIKE inaj_t.inaj007,   #庫存管理特徵
    inaj011           LIKE inaj_t.inaj011,   #數量
    inaj012           LIKE inaj_t.inaj012,   #單位
    inaj012_desc      LIKE oocal_t.oocal003, #單位說明
    inaj008           LIKE inaj_t.inaj008,   #VMI結算庫位
    inaj008_desc      LIKE inaa_t.inaa002,   #庫位名稱
    inaj009           LIKE inaj_t.inaj009,   #VMI結算儲位
    inaj009_desc      LIKE inab_t.inab003,   #儲位名稱
    inaj010           LIKE inaj_t.inaj010    #批號
   END RECORD

DEFINE g_detail2_d  DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d

DEFINE g_detail2_cnt        LIKE type_t.num5
DEFINE g_detail3_cnt        LIKE type_t.num5

DEFINE g_detail2_idx        LIKE type_t.num5
DEFINE g_detail3_idx        LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp120.main" >}
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
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp120 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp120_init()   
 
      #進入選單 Menu (="N")
      CALL apmp120_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp120
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apmp120_tmp1
   DROP TABLE apmp120_tmp2
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp120.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp120_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_wc = "1=1"

   CALL cl_set_combo_scc('pmds000','2060')
   
   #判斷據點參數若不使用參考單位時，則參考單位、數量需隱藏不可以維護
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028') = 'N' THEN
      CALL cl_set_comp_visible("b_pmdt021,b_pmdt021_desc,b_pmdt022",FALSE)
   END IF

   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
      CALL cl_set_comp_visible("b_pmdt023,b_pmdt023_desc,b_pmdt024",FALSE)
   END IF
   CREATE TEMP TABLE apmp120_tmp1(
      pmdtdocno         LIKE pmdt_t.pmdtdocno, #單據編號
      pmdtseq           LIKE pmdt_t.pmdtseq,   #項次
      pmdt006           LIKE pmdt_t.pmdt006,   #料件編號
      pmdt006_desc1     LIKE imaal_t.imaal003, #品名
      pmdt006_desc2     LIKE imaal_t.imaal004, #規格
      pmdt007           LIKE pmdt_t.pmdt007,   #產品特徵
      pmdt063           LIKE pmdt_t.pmdt063,   #庫存管理特徵
      pmdt019           LIKE pmdt_t.pmdt019,   #單位
      pmdt019_desc      LIKE oocal_t.oocal003, #單位說明
      pmdt020           LIKE pmdt_t.pmdt020,   #數量
      pmdt021           LIKE pmdt_t.pmdt021,   #參考單位
      pmdt021_desc      LIKE oocal_t.oocal003, #參考單位說明
      pmdt022           LIKE pmdt_t.pmdt022,   #參考數量
      pmdt016           LIKE pmdt_t.pmdt016,   #庫位
      pmdt016_desc      LIKE inaa_t.inaa002,   #庫位名稱
      pmdt017           LIKE pmdt_t.pmdt017,   #儲位
      pmdt017_desc      LIKE inab_t.inab003,   #儲位名稱
      pmdt018           LIKE pmdt_t.pmdt018,   #批號
      pmdt046           LIKE pmdt_t.pmdt046,   #稅別
      pmdt046_desc      LIKE oodbl_t.oodbl004, #稅別說明
      pmdt037           LIKE pmdt_t.pmdt037,   #稅率
      pmdt023           LIKE pmdt_t.pmdt023,   #計價單位
      pmdt023_desc      LIKE oocal_t.oocal003, #計價單位說明
      pmdt024           LIKE pmdt_t.pmdt024,   #計價數量
      pmdt036           LIKE pmdt_t.pmdt036,   #單價
      pmdt038           LIKE pmdt_t.pmdt038,   #未稅金額
      pmdt039           LIKE pmdt_t.pmdt039,   #含稅金額
      pmdt047           LIKE pmdt_t.pmdt047    #稅額
   )
   CREATE TEMP TABLE apmp120_tmp2(
      inaj015           LIKE inaj_t.inaj015,   #單據性質
      inaj022           LIKE inaj_t.inaj022,   #過帳日期
      inaj001           LIKE inaj_t.inaj001,   #單據編號
      inaj002           LIKE inaj_t.inaj002,   #項次
      inaj003           LIKE inaj_t.inaj003,   #項序
      inaj005           LIKE inaj_t.inaj005,   #料件編號
      inaj005_desc1     LIKE imaal_t.imaal003, #品名
      inaj005_desc2     LIKE imaal_t.imaal004, #規格
      inaj006           LIKE inaj_t.inaj006,   #產品特徵
      inaj007           LIKE inaj_t.inaj007,   #庫存管理特徵
      inaj011           LIKE inaj_t.inaj011,   #數量
      inaj012           LIKE inaj_t.inaj012,   #單位
      inaj012_desc      LIKE oocal_t.oocal003, #單位說明
      inaj008           LIKE inaj_t.inaj008,   #VMI結算庫位
      inaj008_desc      LIKE inaa_t.inaa002,   #庫位名稱
      inaj009           LIKE inaj_t.inaj009,   #VMI結算儲位
      inaj009_desc      LIKE inab_t.inab003,   #儲位名稱
      inaj010           LIKE inaj_t.inaj010    #批號
   )
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp120_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sql   STRING
   DEFINE l_ac    LIKE type_t.num5
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
         CALL apmp120_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON pmdsdocno,pmdsdocdt,pmds002,pmds003,pmds007
            BEFORE CONSTRUCT
            
             ON ACTION controlp INFIELD pmdsdocno #單據編號
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = "('4','7')"
                CALL q_pmdsdocno()
                DISPLAY g_qryparam.return1 TO pmdsdocno
                NEXT FIELD pmdsdocno
                
             ON ACTION controlp INFIELD pmdsdocdt #收貨日期
                

             ON ACTION controlp INFIELD pmds002 #異動人員
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooag001() 
                DISPLAY g_qryparam.return1 TO pmds002
                NEXT FIELD pmds002
                
             ON ACTION controlp INFIELD pmds003 #異動部門
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooeg001()
                DISPLAY g_qryparam.return1 TO pmds003
                NEXT FIELD pmds003
                
             ON ACTION controlp INFIELD pmds007 #供應商
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_pmaa001_3()
                DISPLAY g_qryparam.return1 TO pmds007
                NEXT FIELD pmds007
                
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         #結算單據資料
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
            
            BEFORE INPUT
               LET g_detail_cnt = g_detail_d.getLength()
           
            BEFORE ROW
               LET g_master_idx = ARR_CURR()
               DISPLAY g_master_idx TO FORMONLY.h_index
               LET g_detail_cnt = g_detail_d.getLength()
               CALL apmp120_fetch()
               
            #選擇
            ON CHANGE b_sel
               #手動的勾選，直接改變sel2即
               LET g_detail_d[g_master_idx].sel2 = g_detail_d[g_master_idx].sel
               IF g_detail_d[g_master_idx].sel = 'N' THEN  #取消勾選
                  CALL apmp120_del_tmp1(g_detail_d[g_master_idx].pmdsdocno)
                  CALL apmp120_del_tmp2(g_detail_d[g_master_idx].pmdsdocno)
               ELSE
                  CALL apmp120_ins_tmp1(g_detail_d[g_master_idx].pmdsdocno)
                  CALL apmp120_ins_tmp2(g_detail_d[g_master_idx].pmdsdocno)
               END IF
            CALL apmp120_fetch()
         END INPUT
         
         
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #入庫/倉退明細
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt)

            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")

         END DISPLAY

         #對應的結算資料清單
         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail3_cnt)

            BEFORE ROW
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail3_idx)
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")

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
               #還沒有被寫入temp table的才能處理，否則會有資料重覆寫入的問題 
               IF g_detail_d[li_idx].sel2 = 'N' THEN
                  LET g_detail_d[li_idx].sel2 = 'Y'
                  CALL apmp120_ins_tmp1(g_detail_d[li_idx].pmdsdocno)
                  CALL apmp120_ins_tmp2(g_detail_d[li_idx].pmdsdocno)
               END IF

               CALL apmp120_fetch()
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
               #如果是已經被寫入temp table的，才花時間、效能去處理 
               IF g_detail_d[li_idx].sel2 = "Y" THEN
                  LET g_detail_d[li_idx].sel2 = "N"
                  CALL apmp120_del_tmp1(g_detail_d[li_idx].pmdsdocno)
                  CALL apmp120_del_tmp2(g_detail_d[li_idx].pmdsdocno)
               END IF
               CALL apmp120_fetch()
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
                  #還沒有被寫入temp table的才能處理，否則會有資料重覆寫入的問題 
                  IF g_detail_d[li_idx].sel2 = 'N' THEN
                     LET g_detail_d[li_idx].sel2 = 'Y'
                     CALL apmp120_ins_tmp1(g_detail_d[li_idx].pmdsdocno)
                     CALL apmp120_ins_tmp2(g_detail_d[li_idx].pmdsdocno)
                  END IF
               END IF
            END FOR 
            CALL apmp120_fetch()
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  #如果是已經被寫入temp table的，才花時間、效能去處理 
                  IF g_detail_d[li_idx].sel2 = "Y" THEN
                     LET g_detail_d[li_idx].sel2 = "N"
                     CALL apmp120_del_tmp1(g_detail_d[li_idx].pmdsdocno)
                     CALL apmp120_del_tmp2(g_detail_d[li_idx].pmdsdocno)
                  END IF
               END IF
            END FOR
            CALL apmp120_fetch()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp120_filter()
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
            CALL apmp120_query()
            EXIT DIALOG
            #end add-point
            CALL apmp120_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp120_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL apmp120_process()
            
            
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
 
{<section id="apmp120.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp120_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"

   DELETE FROM apmp120_tmp1
   DELETE FROM apmp120_tmp2
   
   #end add-point
        
   LET g_error_show = 1
   CALL apmp120_b_fill()
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
 
{<section id="apmp120.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp120_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_pmds028       LIKE pmds_t.pmds028   #161207-00033#19
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   LET g_sql = " SELECT 'N','N',gzcbl004,pmdsdocno,pmdsdocdt,pmds001,pmds007,pmaal004,pmds002,ooag011,pmds003,pmds028",  #161207-00033#19 add by lixh 
               "   FROM pmds_t",
               "   LEFT OUTER JOIN pmaal_t ON pmaalent=pmdsent AND pmaal001=pmds007 AND pmaal002='",g_dlang,"'",
               "   LEFT OUTER JOIN ooag_t ON ooagent=pmdsent AND ooag001=pmds002",
               "   LEFT OUTER JOIN gzcbl_t ON gzcbl001='2060' AND gzcbl002=pmds000 AND gzcbl003='",g_dlang,"'",
               "  WHERE pmdsent=? AND pmdssite='",g_site,"' AND pmds054 ='3' AND pmds000 IN ('4','7') ",
               "    AND pmdsstus='S' AND ",g_wc CLIPPED,
               "  ORDER BY pmdsdocno"
   #end add-point
 
   PREPARE apmp120_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp120_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].sel2,g_detail_d[l_ac].pmds000,g_detail_d[l_ac].pmdsdocno,
      g_detail_d[l_ac].pmdsdocdt,g_detail_d[l_ac].pmds001,g_detail_d[l_ac].pmds007,
      g_detail_d[l_ac].pmds007_desc,g_detail_d[l_ac].pmds002,g_detail_d[l_ac].pmds002_desc,
      g_detail_d[l_ac].pmds003,l_pmds028
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
      #161207-00033#19-S    
      IF NOT cl_null(l_pmds028) THEN
         CALL s_desc_get_oneturn_guest_desc(l_pmds028) RETURNING g_detail_d[l_ac].pmds007_desc
      END IF   
      #161207-00033#19-E
      #end add-point
      
      CALL apmp120_detail_show()      
 
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
   IF (l_ac - 1) > 0 THEN
      LET g_master_idx = 1
   END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmp120_sel
   
   LET l_ac = 1
   CALL apmp120_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp120.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp120_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_master_idx) OR g_master_idx = 0 THEN
      RETURN
   END IF

   LET g_sql = " SELECT * ",
               "   FROM apmp120_tmp1",
               "  ORDER BY pmdtseq"
   PREPARE apmp120_tmp1 FROM g_sql
   DECLARE tmp1_curs CURSOR FOR apmp120_tmp1
   
   CALL g_detail2_d.clear()
   
   LET l_ac = 1 
 
   FOREACH tmp1_curs INTO g_detail2_d[l_ac].*
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
   
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   IF (l_ac - 1) > 0 THEN
      LET g_detail2_idx = 1
   END IF
    
   LET g_detail2_cnt = l_ac - 1

   FREE apmp120_tmp1

   CALL apmp120_fetch_1()
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp120.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp120_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp120.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp120_filter()
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
   
   CALL apmp120_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp120.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp120_filter_parser(ps_field)
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
 
{<section id="apmp120.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp120_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp120_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 抓取 '入庫/倉退明細' 資料
# Memo...........:
# Usage..........: CALL apmp120_ins_tmp1(p_pmdsdocno)
# Input parameter: p_pmdsdocno #單據單號
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_ins_tmp1(p_pmdsdocno)
   DEFINE p_pmdsdocno LIKE pmds_t.pmdsdocno
   DEFINE l_pmdt      type_g_detail2_d
   DEFINE l_sql       STRING
   
   INITIALIZE l_pmdt.* TO NULL #清空值
   #入庫/倉退明細
   LET l_sql =" SELECT pmdtdocno,pmdtseq,pmdt006,imaal003,imaal004,pmdt007,pmdt063,pmdt019,U1.oocal003,",
              "        pmdt020,pmdt021,U2.oocal003,pmdt022,pmdt016,inayl003,pmdt017,inab003,pmdt018,",
              "        pmdt046,oodbl004,pmdt037,pmdt023,U3.oocal003,pmdt024,pmdt036,pmdt038,pmdt039,",
              "        pmdt047",
              "   FROM pmdt_t",
              "   LEFT OUTER JOIN ooef_t ON ooefent=pmdtent AND ooef001='",g_site,"'",
              "   LEFT OUTER JOIN inayl_t ON inaylent=pmdtent AND inayl001=pmdt016 AND inayl002='",g_dlang,"'",
              "   LEFT OUTER JOIN inab_t ON inabent=pmdtent AND inab001=pmdt016 AND inab002=pmdt017 AND inabsite='",g_site,"'",
              "   LEFT OUTER JOIN imaal_t ON imaalent=pmdtent AND imaal001=pmdt006 AND imaal002='",g_dlang,"'",
              "   LEFT OUTER JOIN oocal_t U1 ON U1.oocalent=pmdtent AND U1.oocal001=pmdt019 AND U1.oocal002='",g_dlang,"'",
              "   LEFT OUTER JOIN oocal_t U2 ON U2.oocalent=pmdtent AND U2.oocal001=pmdt021 AND U2.oocal002='",g_dlang,"'",
              "   LEFT OUTER JOIN oocal_t U3 ON U3.oocalent=pmdtent AND U3.oocal001=pmdt023 AND U3.oocal002='",g_dlang,"'",
              "   LEFT OUTER JOIN oodbl_t ON oodblent=pmdtent AND oodbl001=ooef019 AND oodbl002=pmdt046  AND oodbl003='",g_dlang,"'",
              "  WHERE pmdtdocno='",p_pmdsdocno,"' AND pmdtsite='",g_site,"' AND pmdtent='",g_enterprise,"'",
              "  ORDER BY pmdtdocno,pmdtseq"
              
              
   PREPARE apmp120_detail2_pre FROM l_sql
   DECLARE apmp120_detail2_curs CURSOR FOR apmp120_detail2_pre
   
   
   FOREACH apmp120_detail2_curs INTO l_pmdt.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      INSERT INTO apmp120_tmp1 VALUES (l_pmdt.*)

   END FOREACH
   
   FREE apmp120_detail2_pre

END FUNCTION

################################################################################
# Descriptions...: 抓取 '對應的結算資料清單' 資料
# Memo...........:
# Usage..........: CALL apmp120_ins_tmp2(p_pmdsdocno)
# Input parameter: p_pmdsdocno #單據單號
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai (151111-00023#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_ins_tmp2(p_pmdsdocno)
   DEFINE p_pmdsdocno LIKE pmds_t.pmdsdocno
   DEFINE l_inaj      type_g_detail3_d
   DEFINE l_sql       STRING
   LET l_sql = " SELECT inaj015,inaj022,inaj001,inaj002,inaj003,inaj005,imaal003,imaal004,inaj006,",
               "        inaj007,inaj011,inaj012,oocal003,inaj008,inayl003,inaj009,inab002,inaj010",
               "   FROM inaj_t",
               "   LEFT OUTER JOIN inayl_t ON inaylent=inajent AND inayl001=inaj008 AND inayl002='",g_dlang,"'",
               "   LEFT OUTER JOIN inab_t ON inabent=inajent AND inab001=inaj008 AND inab002=inaj009 AND inabsite='",g_site,"'",
               "   LEFT OUTER JOIN imaal_t ON imaalent=inajent AND imaal001=inaj005 AND imaal002='",g_dlang,"'",
               "   LEFT OUTER JOIN oocal_t ON oocalent=inajent AND oocal001=inaj012 AND oocal002='",g_dlang,"'",
               "  WHERE inajent='",g_enterprise,"' AND inajsite='",g_site,"' AND inaj001='",p_pmdsdocno,"'"
               
   PREPARE apmp120_detail3_pre FROM l_sql
   DECLARE apmp120_detail3_curs CURSOR FOR apmp120_detail3_pre
   
   FOREACH apmp120_detail3_curs INTO l_inaj.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      INSERT INTO apmp120_tmp2 VALUES (l_inaj.*)

   END FOREACH
   
   FREE apmp120_detail3_pre
END FUNCTION

################################################################################
# Descriptions...: 收貨/倉退明細
# Memo...........:
# Usage..........: CALL apmp120_fetch_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai (151111-00023#2)
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_fetch_1()
   DEFINE li_ac           LIKE type_t.num5
   
   LET li_ac = l_ac 
   
   IF cl_null(g_detail2_idx) OR g_detail2_idx = 0 THEN
      RETURN
   END IF
   
   LET g_sql = " SELECT * ",
               "   FROM apmp120_tmp2 ",
               "  ORDER BY inaj001,inaj002,inaj003"
   
   PREPARE apmp120_tmp2 FROM g_sql
   DECLARE tmp2_curs CURSOR FOR apmp120_tmp2
   
   CALL g_detail3_d.clear()
   
   LET l_ac = 1 
 
   FOREACH tmp2_curs INTO g_detail3_d[l_ac].*
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
   
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   IF (l_ac - 1) > 0 THEN
      LET g_detail3_idx = 1
   END IF
    
   LET g_detail3_cnt = l_ac - 1

   FREE apmp120_tmp2
   
   LET l_ac = li_ac
   
END FUNCTION

################################################################################
# Descriptions...: 刪除 '入庫/倉退明細' 資料
# Memo...........:
# Usage..........: CALL apmp120_del_tmp1(p_pmdsdocno)
# Input parameter: p_pmdsdocno #單據單號
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_del_tmp1(p_pmdsdocno)
   DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno
   DEFINE l_cnt        LIKE type_t.num5

   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM apmp120_tmp1
    WHERE pmdtdocno = p_pmdsdocno


   IF l_cnt > 0 THEN
      DELETE FROM apmp120_tmp1
       WHERE pmdtdocno = p_pmdsdocno
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DELETE:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
    
    END IF 
    
END FUNCTION

################################################################################
# Descriptions...: 刪除 '對應的結算資料清單' 資料
# Memo...........:
# Usage..........: CALL apmp120_del_tmp2(p_pmdsdocno)
# Input parameter: p_pmdsdocno #單據單號
# Return code....: 
# Date & Author..: 2015/11/30 By Dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_del_tmp2(p_pmdsdocno)
   DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno
   DEFINE l_cnt        LIKE type_t.num5
   
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM apmp120_tmp2
    WHERE inaj001 = p_pmdsdocno
   
   IF l_cnt > 0 THEN
      DELETE FROM apmp120_tmp2
       WHERE inaj001 = p_pmdsdocno 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DELETE:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE
         CALL cl_err()
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 呼叫各單據作業的過帳還原與確認還原流程進行過帳還原與確認還原
# Memo...........:
# Usage..........: CALL apmp120_process()
# Input parameter: no
# Return code....: no
# Date & Author..: 2015/12/01 By Dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_process()
   DEFINE l_ac      LIKE type_t.num5
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   

   CALL cl_err_collect_init()
 
   
   FOR l_ac = 1 TO g_detail_d.getLength()
      CALL s_transaction_begin()
      LET l_cnt = 0
      LET l_success = TRUE
      #結算單據有勾選
      IF g_detail_d[l_ac].sel = 'Y' THEN
         # → VMI結算否(inaj030='1')
         # → VMI結算對應入庫/倉退單號(inaj031=NULL)
         # → VMI結算對應入庫/倉退項次(inaj032=NULL)         
         SELECT COUNT(*) INTO l_cnt
           FROM inaj_t
          WHERE inajent = g_enterprise
            AND inajsite = g_site
            AND inaj031 = g_detail_d[l_ac].pmdsdocno
         
         IF l_cnt > 0 THEN
            UPDATE inaj_t 
               SET inaj030='1',inaj031='',inaj032='',inaj033='',inaj034=''
             WHERE inajent = g_enterprise
               AND inajsite = g_site
               AND inaj031 = g_detail_d[l_ac].pmdsdocno
          
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE FOR
            END IF
         END IF
         
         IF s_apmt520_unposted_chk(g_detail_d[l_ac].pmdsdocno) THEN
            IF s_apmt520_unposted_upd(g_detail_d[l_ac].pmdsdocno) THEN
               IF s_apmt520_unconf_chk(g_detail_d[l_ac].pmdsdocno) THEN
                  IF s_apmt520_unconf_upd(g_detail_d[l_ac].pmdsdocno)  THEN
                     IF l_success THEN      
                        CALL apmp120_delete(g_detail_d[l_ac].pmdsdocno) RETURNING l_success
                        IF l_success THEN
                           CALL apmp120_del_tmp1(g_detail_d[l_ac].pmdsdocno)
                           CALL apmp120_del_tmp2(g_detail_d[l_ac].pmdsdocno)
                           CALL s_transaction_end('Y','0')
                        ELSE
                           CALL s_transaction_end('N','0')   
                        END IF
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
            ELSE
               CALL s_transaction_end('N','0')
            END IF
         ELSE
            CALL s_transaction_end('N','0')
         END IF
      END IF
   END FOR 
   
   CALL cl_err_collect_show() 
   
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      CALL apmp120_b_fill()
      CALL cl_ask_pressanykey("std-00012")
   ELSE
      #背景作業完成處理
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 刪除相關單據
# Memo...........:
# Usage..........: CALL apmp120_delete(p_pmdsdocno)
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 2015/12/01 By Dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp120_delete(p_pmdsdocno)
   DEFINE p_pmdsdocno  LIKE pmds_t.pmdsdocno
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   
   LET r_success = TRUE
   
   DELETE FROM pmds_t
    WHERE pmdsent = g_enterprise 
      AND pmdsdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE pmds_t:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除預算科目   
   CALL s_apmt520_stus_abg1(p_pmdsdocno,'D')
           RETURNING r_success
   IF NOT r_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除單身資料(收貨明細)
   DELETE FROM pmdt_t
    WHERE pmdtent = g_enterprise AND pmdtdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE pmdt_t:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除單身資料(多庫儲批明細)
   DELETE FROM pmdu_t
    WHERE pmduent = g_enterprise AND pmdudocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE pmdu_t:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除單身資料(原始需求分配明細)
   DELETE FROM pmdv_t
    WHERE pmdvent = g_enterprise AND pmdvdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE pmdv_t:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除進項發票檔
   DELETE FROM pmdw_t
    WHERE pmdwent = g_enterprise AND pmdwdocno = p_pmdsdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "DELETE pmdw_t:" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #刪除交易稅明細檔
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM xrcd_t
    WHERE xrcdent = g_enterprise
      AND xrcddocno = p_pmdsdocno
   IF l_cnt > 0 THEN
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise
         AND xrcddocno = p_pmdsdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "DELETE xrcd_t："
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #刪除inao製造批序號異動明細檔
    DELETE FROM inao_t 
     WHERE inaoent = g_enterprise AND inaodocno = p_pmdsdocno
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.extend = "DELETE inao_t"
       LET g_errparam.code   = SQLCA.sqlcode
       LET g_errparam.popup  = FALSE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success
    END IF

    RETURN r_success
   
END FUNCTION

#end add-point
 
{</section>}
 
