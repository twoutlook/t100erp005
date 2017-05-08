#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-10-16 15:27:37), PR版次:0006(2016-12-15 17:30:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000080
#+ Filename...: apmp501
#+ Description: 採購交期變更作業
#+ Creator....: 03079(2014-08-07 11:49:24)
#+ Modifier...: 03079 -SD/PR- 05423
 
{</section>}
 
{<section id="apmp501.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#160523-00018#2  160617 By 02040    1.多角單據只能抓取起站的採購單2.多角單據需一併調整
#161109-00042#1  161109 By 01258    单笔的时候变更交期类型不回写问题调整
#161124-00048#8  161215 By zhujing  .*整批调整
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
                        sel            LIKE type_t.chr1,
                        pmdl004        LIKE pmdl_t.pmdl004,
                        pmdl004_desc   LIKE type_t.chr80,
                        pmdldocno      LIKE pmdl_t.pmdldocno,
                        pmdnseq        LIKE pmdn_t.pmdnseq,
                        pmdn001        LIKE pmdn_t.pmdn001,
                        pmdn001_desc   LIKE imaal_t.imaal003,
                        pmdn001_desc_1 LIKE imaal_t.imaal004,
                        pmdn002        LIKE pmdn_t.pmdn002, 
                        pmdn002_desc   LIKE type_t.chr80,
                        pmdn007        LIKE pmdn_t.pmdn007,
                        pmdn006        LIKE pmdn_t.pmdn006,
                        pmdn006_desc   LIKE type_t.chr80,
                        pmdn024        LIKE pmdn_t.pmdn024,
                        pmdn012        LIKE pmdn_t.pmdn012,
                        pmdn013        LIKE pmdn_t.pmdn013,
                        pmdn014        LIKE pmdn_t.pmdn014,
                        pmdl002        LIKE pmdl_t.pmdl002,
                        pmdl002_desc   LIKE type_t.chr80,
                        pmdl003        LIKE pmdl_t.pmdl003,
                        pmdl003_desc   LIKE type_t.chr80
                     END RECORD 
TYPE type_g_pmdq_d   RECORD
                        pmdqdocno         LIKE pmdq_t.pmdqdocno,    #採購單號  
                        pmdqseq           LIKE pmdq_t.pmdqseq,      #項次  
                        pmdqseq2          LIKE pmdq_t.pmdqseq2,     #分批序  
                        pmdq002           LIKE pmdq_t.pmdq002,      #分批數量  
                        pmdn006_down      LIKE pmdn_t.pmdn006,      #採購單位  
                        pmdn006_down_desc LIKE type_t.chr80,        #說明  
                        pmdo009           LIKE pmdo_t.pmdo009,      #交期類型  
                        pmdq005           LIKE pmdq_t.pmdq005,      #預計到庫日  
                        pmdq004           LIKE pmdq_t.pmdq004,      #預計到廠日  
                        pmdq003           LIKE pmdq_t.pmdq003,      #預計出貨日  
                        pmdo015           LIKE pmdo_t.pmdo015       #已收貨數量  
                     END RECORD
DEFINE g_pmdq_d      DYNAMIC ARRAY OF type_g_pmdq_d 
DEFINE g_pmdq_d_t    type_g_pmdq_d
DEFINE g_pmdq_d_o    type_g_pmdq_d
DEFINE g_detail_cnt2 LIKE type_t.num5                               #下方單身的筆數  
DEFINE l_ac1         LIKE type_t.num5                               #上方單身點選到的列數 
DEFINE l_ac2         LIKE type_t.num5                               #下方單身點選到的列數  
DEFINE g_ooef008     LIKE ooef_t.ooef008                            #行事曆參照表號 
DEFINE g_ooef009     LIKE ooef_t.ooef009                            #製造行事曆對應類別 
DEFINE g_flag        LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp501.main" >}
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

   CALL apmp501_create_table() 
   
   #根據當前營運據點g_site抓取aooi120中設置的行事曆參照表號 
   CALL apmp501_get_ooef()
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp501 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp501_init()   
 
      #進入選單 Menu (="N")
      CALL apmp501_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp501
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL apmp501_drop_table()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp501.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp501_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF

   LET g_errshow = 1
   LET g_flag = 0
   
   CALL cl_set_combo_scc('pmdl005','2052')
   CALL cl_set_combo_scc("b_pmdo009","2057") 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp501_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sql             STRING
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_cmd             LIKE type_t.chr1
   DEFINE l_imaf173         LIKE imaf_t.imaf173
   DEFINE l_imaf174         LIKE imaf_t.imaf174 
   DEFINE l_count           LIKE type_t.num5   
   DEFINE l_pmdq002         LIKE pmdq_t.pmdq002 
   DEFINE l_pmdq002_tmp     LIKE pmdq_t.pmdq002
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
         CALL apmp501_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT g_wc ON pmdldocno,pmdldocdt,pmdl004,pmdl002,
                           pmdl003,pmdl005,pmdn001,pmdn002
              FROM pmdldocno,pmdldocdt,pmdl004,pmdl002,
                   pmdl003,pmdl005,pmdn001,pmdn002

            BEFORE CONSTRUCT
               CALL cl_qbe_init()

            ON ACTION controlp INFIELD pmdldocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE 
               #開窗排除 作廢、已結案、單身行狀態不為1.一般 的單據 
               LET g_qryparam.WHERE = "     pmdlstus NOT IN ('C','X') ",
                                      " AND pmdldocno IN (SELECT DISTINCT pmdldocno ",
                                      "                     FROM pmdl_t,pmdn_t ",
                                      "                    WHERE pmdlent   = pmdnent ",
                                      "                      AND pmdlsite  = pmdnsite ",
                                      "                      AND pmdldocno = pmdndocno ",
                                      "                      AND pmdn045   = '1' ",       #行狀態  
                                      "                      AND pmdlent   = '",g_enterprise,"' ",
                                      "                      AND pmdlsite  = '",g_site,"') "
               CALL q_pmdldocno()
               DISPLAY g_qryparam.return1 TO pmdldocno 
               NEXT FIELD pmdldocno

            ON ACTION controlp INFIELD pmdl004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()
               DISPLAY g_qryparam.return1 TO pmdl004
               NEXT FIELD pmdl004

            ON ACTION controlp INFIELD pmdl002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO pmdl002
               NEXT FIELD pmdl002

            ON ACTION controlp INFIELD pmdl003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001()
               DISPLAY g_qryparam.return1 TO pmdl003
               NEXT FIELD pmdl003

            ON ACTION controlp INFIELD pmdn001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " 1=1 "
               LET l_sql = " 1=1 "
               CALL s_control_get_sql("imaa001",'6','4',g_user,g_dept)
                    RETURNING l_success,l_sql
               IF l_success THEN
                  IF cl_null(l_sql) THEN
                     LET l_sql = " 1=1 "
                  END IF
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF

               CALL q_imaf001()
               DISPLAY g_qryparam.return1 TO pmdn001
               NEXT FIELD pmdn001
         END CONSTRUCT 
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_pmdq_d FROM s_detail2.*
               ATTRIBUTE(COUNT=g_detail_cnt2,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS,
                         INSERT ROW = TRUE,
                         DELETE ROW = TRUE,
                         APPEND ROW = TRUE) 
                         
            BEFORE INPUT 
               IF g_detail_d.getLength() < 1 THEN
                  EXIT DIALOG
               END IF
            
               IF cl_null(l_ac1) OR l_ac1 = 0 THEN
                  EXIT DIALOG
               END IF
               CALL cl_set_act_visible("accept",FALSE) 
               LET g_detail_cnt2 = g_pmdq_d.getLength()

            BEFORE ROW
               LET l_ac2 = ARR_CURR()
               #LET g_detail2_idx = l_ac2 
               LET g_pmdq_d_t.* = g_pmdq_d[l_ac2].*
               LET g_detail_cnt2 = g_pmdq_d.getLength() 
               
               IF g_detail_cnt2 >= l_ac2 THEN
                  LET l_cmd = 'u'
               END IF

            BEFORE INSERT
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               LET l_cmd = 'a'
               INITIALIZE g_pmdq_d[l_ac2].* TO NULL 
               INITIALIZE g_pmdq_d_t.* TO NULL 
               INITIALIZE g_pmdq_d_o.* TO NULL 
               
               LET g_pmdq_d[l_ac2].pmdqdocno = g_detail_d[l_ac1].pmdldocno
               LET g_pmdq_d[l_ac2].pmdqseq   = g_detail_d[l_ac1].pmdnseq

               #設定分批序為最大數+1  
               SELECT MAX(pmdqseq2) + 1 INTO g_pmdq_d[l_ac2].pmdqseq2
                 FROM apmp501_pmdq_t

               IF cl_null(g_pmdq_d[l_ac2].pmdqseq2) OR
                  g_pmdq_d[l_ac2].pmdqseq2 = 0 THEN 
                  LET g_pmdq_d[l_ac2].pmdqseq2 = 1
               END IF 
               
               #新增單身資料時，自動計算剩餘量 
               LET l_pmdq002_tmp = 0
               SELECT SUM(pmdq002) INTO l_pmdq002_tmp
                 FROM apmp501_pmdq_t
               IF cl_null(l_pmdq002_tmp) OR l_pmdq002_tmp = 0 THEN
                  LET g_pmdq_d[l_ac2].pmdq002 = g_detail_d[l_ac1].pmdn007
               ELSE
                  LET g_pmdq_d[l_ac2].pmdq002 = g_detail_d[l_ac1].pmdn007 - l_pmdq002_tmp
               END IF
               IF cl_null(g_pmdq_d[l_ac2].pmdq002) OR g_pmdq_d[l_ac2].pmdq002 < 0 THEN
                  LET g_pmdq_d[l_ac2].pmdq002 = 0
               END IF

               #取得單位 
               SELECT pmdn006 INTO g_pmdq_d[l_ac2].pmdn006_down
                 FROM pmdn_t
                WHERE pmdnent   = g_enterprise
                  AND pmdnsite  = g_site
                  AND pmdndocno = g_pmdq_d[l_ac2].pmdqdocno
                  AND pmdnseq   = g_pmdq_d[l_ac2].pmdqseq

               #取得單位說明 
               CALL s_desc_get_unit_desc(g_pmdq_d[l_ac2].pmdn006_down)
                    RETURNING g_pmdq_d[l_ac2].pmdn006_down_desc

               #交期類型預設為1.約定交貨日 
               LET g_pmdq_d[l_ac2].pmdo009 = '1'

               #已收貨數量預設0 
               LET g_pmdq_d[l_ac2].pmdo015 = 0 
               
               LET g_pmdq_d_t.* = g_pmdq_d[l_ac2].*
               LET g_pmdq_d_o.* = g_pmdq_d[l_ac2].* 
               
            AFTER INSERT
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF

               LET l_count = 0
               SELECT COUNT(*) INTO l_count
                 FROM apmp501_pmdq_t
                WHERE pmdqseq2 = g_pmdq_d[l_ac2].pmdqseq2
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'std-00006'
                  LET g_errparam.extend = 'INSERT'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err() 
                  
                  INITIALIZE g_pmdq_d[l_ac2].* TO NULL
                  CANCEL INSERT
               END IF

               INSERT INTO apmp501_pmdq_t(pmdqdocno,pmdqseq,pmdqseq2,pmdq002,
                                          pmdn006_down,pmdo009,pmdq005,pmdq004,
                                          pmdq003,pmdo015)
                    VALUES(g_detail_d[g_detail_cnt].pmdldocno,g_detail_d[g_detail_cnt].pmdnseq,
                           g_pmdq_d[l_ac2].pmdqseq2,g_pmdq_d[l_ac2].pmdq002,
                           g_pmdq_d[l_ac2].pmdn006_down,g_pmdq_d[l_ac2].pmdo009,
                           g_pmdq_d[l_ac2].pmdq005,g_pmdq_d[l_ac2].pmdq004,
                           g_pmdq_d[l_ac2].pmdq003,g_pmdq_d[l_ac2].pmdo015)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.extend = "apmp501_pmdq_t"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  CANCEL INSERT
               END IF

               ERROR 'INSERT O.K'
               LET g_detail_cnt2 = g_detail_cnt2 + 1 
               LET g_flag = 1

            BEFORE DELETE
               #刪除時須檢核若該分批序的已收貨數量已大於0時 則該筆交期明細不允許刪除 
               IF g_pmdq_d[l_ac2].pmdo015 > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'apm-00589'     
                  LET g_errparam.extend = g_pmdq_d[l_ac2].pmdo015
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #分批序為1的資料不允許刪除 
               IF g_pmdq_d[l_ac2].pmdqseq2 = 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'axm-00427'    
                  LET g_errparam.extend = g_pmdq_d[l_ac2].pmdqseq2
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF 
               
               #是否取消單身 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF

               DELETE FROM apmp501_pmdq_t
                WHERE pmdqseq2 = g_pmdq_d[l_ac2].pmdqseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.extend = 'apmp501_pmdq_t'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               LET g_detail_cnt2 = g_detail_cnt2 - 1

            AFTER DELETE
               IF l_ac2 = (g_pmdq_d.getLength() + 1) THEN
                  CALL FGL_SET_ARR_CURR(l_ac2-1)
               END IF
               LET g_flag = 1 
               
            AFTER FIELD b_pmdq002
               IF NOT cl_null(g_pmdq_d[l_ac2].pmdq002) THEN
                  IF g_pmdq_d[l_ac2].pmdq002 != g_pmdq_d_o.pmdq002 OR cl_null(g_pmdq_d_o.pmdq002) THEN
                     INITIALIZE g_errparam TO NULL
                     CASE
                        WHEN g_pmdq_d[l_ac2].pmdq002 <= 0
                           #數量不可小於等於0 
                           LET g_errparam.code = "ade-00016"
                        WHEN g_pmdq_d[l_ac2].pmdq002 > g_detail_d[l_ac1].pmdn007
                           #分批數量不可大於原採購數量 
                           LET g_errparam.code = "apm-00582"
                        WHEN (g_pmdq_d[l_ac2].pmdq002 < g_pmdq_d[l_ac2].pmdo015 AND
                              g_pmdq_d[l_ac2].pmdo015 <> 0)
                           #輸入的數量不可小於已收貨數量 
                           LET g_errparam.code = "apm-00583"
                        OTHERWISE
                           EXIT CASE
                     END CASE

                     IF NOT cl_null(g_errparam.code) THEN
                        LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq002
                        LET g_errparam.popup  = TRUE
                        CALL cl_err() 
                        
                        LET g_pmdq_d[l_ac2].pmdq002 = g_pmdq_d_o.pmdq002
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

               LET g_pmdq_d_o.pmdq002 = g_pmdq_d[l_ac2].pmdq002

            AFTER FIELD b_pmdq005
               IF NOT cl_null(g_pmdq_d[l_ac2].pmdq005) THEN
                  IF g_pmdq_d[l_ac2].pmdq005 != g_pmdq_d_o.pmdq005 OR
                     g_pmdq_d_o.pmdq005 IS NULL THEN 
                     CALL apmp501_get_ooef()

                     CALL apmp501_get_imaf173_174(g_detail_d[l_ac1].pmdn001)
                          RETURNING l_imaf173,l_imaf174

                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq004) THEN
                        #到庫日不可小於到廠日 
                        IF g_pmdq_d[l_ac2].pmdq005 < g_pmdq_d[l_ac2].pmdq004 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00271'   #到庫日期不可小於到廠日期！  
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq005
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq005 = g_pmdq_d_o.pmdq005
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq005,0,(l_imaf174*(-1)))
                                RETURNING g_pmdq_d[l_ac2].pmdq004
                        ELSE
                           LET g_pmdq_d[l_ac2].pmdq004 = g_pmdq_d[l_ac2].pmdq005
                        END IF
                     END IF 
                     
                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq003) THEN
                        #到庫日不可小於出貨日 
                        IF g_pmdq_d[l_ac2].pmdq005 < g_pmdq_d[l_ac2].pmdq003 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00272'    #到庫日期不可小於交貨日期  
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq005
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq005 = g_pmdq_d_o.pmdq005
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq004,0,(l_imaf173*(-1)))
                                RETURNING g_pmdq_d[l_ac2].pmdq003
                        ELSE
                           LET g_pmdq_d[l_ac2].pmdq003 = g_pmdq_d[l_ac2].pmdq004
                        END IF
                     END IF
                  END IF
               END IF

               LET g_pmdq_d_o.pmdq005 = g_pmdq_d[l_ac2].pmdq005 
               
            AFTER FIELD b_pmdq004
               IF NOT cl_null(g_pmdq_d[l_ac2].pmdq004) THEN
                  IF g_pmdq_d[l_ac2].pmdq004 != g_pmdq_d_o.pmdq004 OR
                     g_pmdq_d_o.pmdq004 IS NULL THEN
                     CALL apmp501_get_ooef()

                     CALL apmp501_get_imaf173_174(g_detail_d[l_ac1].pmdn001)
                          RETURNING l_imaf173,l_imaf174

                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq005) THEN
                        IF g_pmdq_d[l_ac2].pmdq005 < g_pmdq_d[l_ac2].pmdq004 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00271'     #到庫日期不可小於到廠日期！ 
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq004
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq004 = g_pmdq_d_o.pmdq004 
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq004,0,l_imaf174)
                                RETURNING g_pmdq_d[l_ac2].pmdq005
                        ELSE
                           LET g_pmdq_d[l_ac2].pmdq005 = g_pmdq_d[l_ac2].pmdq004
                        END IF
                     END IF

                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq003) THEN
                        #到廠日不可小於出貨日 
                        IF g_pmdq_d[l_ac2].pmdq004 < g_pmdq_d[l_ac2].pmdq003 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00267'     #到廠日期不可小於交貨日期！  
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq004
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq004 = g_pmdq_d_o.pmdq004 
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq004,0,(l_imaf173*(-1)))
                                RETURNING g_pmdq_d[l_ac2].pmdq003
                        ELSE
                          LET g_pmdq_d[l_ac2].pmdq003 = g_pmdq_d[l_ac2].pmdq004
                        END IF
                     END IF
                  END IF
               END IF

               LET g_pmdq_d_o.pmdq004 = g_pmdq_d[l_ac2].pmdq004 
               
            AFTER FIELD b_pmdq003
               IF NOT cl_null(g_pmdq_d[l_ac2].pmdq003) THEN
                  IF g_pmdq_d[l_ac2].pmdq003 != g_pmdq_d_o.pmdq003 OR
                     g_pmdq_d_o.pmdq003 IS NULL THEN
                     CALL apmp501_get_ooef()

                     CALL apmp501_get_imaf173_174(g_detail_d[l_ac1].pmdn001)
                          RETURNING l_imaf173,l_imaf174

                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq004) THEN
                        IF g_pmdq_d[l_ac2].pmdq004 < g_pmdq_d[l_ac2].pmdq003 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00267'     #到廠日期不可小於交貨日期！  
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq004
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq003 = g_pmdq_d_o.pmdq003 
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq003,0,l_imaf173)
                                RETURNING g_pmdq_d[l_ac2].pmdq004
                        ELSE
                           LET g_pmdq_d[l_ac2].pmdq004 = g_pmdq_d[l_ac2].pmdq003
                        END IF
                     END IF

                     IF NOT cl_null(g_pmdq_d[l_ac2].pmdq005) THEN
                        IF g_pmdq_d[l_ac2].pmdq005 < g_pmdq_d[l_ac2].pmdq003 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code   = 'apm-00272'    #到庫日期不可小於交貨日期  
                           LET g_errparam.extend = g_pmdq_d[l_ac2].pmdq005
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()

                           LET g_pmdq_d[l_ac2].pmdq003 = g_pmdq_d_o.pmdq003 
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
                           CALL s_date_get_work_date(g_site,g_ooef008,g_ooef009,g_pmdq_d[l_ac2].pmdq004,0,l_imaf174)
                                RETURNING g_pmdq_d[l_ac2].pmdq003
                        ELSE
                           LET g_pmdq_d[l_ac2].pmdq005 = g_pmdq_d[l_ac2].pmdq004
                        END IF
                     END IF
                  END IF
               END IF 
               
            ON ROW CHANGE
               IF INT_FLAG THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 9001
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()

                  LET INT_FLAG = 0
                  LET g_pmdq_d[l_ac2].* = g_pmdq_d_t.*
                  EXIT DIALOG
               END IF

               INITIALIZE g_errparam TO NULL
               UPDATE apmp501_pmdq_t SET pmdq002 = g_pmdq_d[l_ac2].pmdq002,
                                         pmdo009 = g_pmdq_d[l_ac2].pmdo009,
                                         pmdq005 = g_pmdq_d[l_ac2].pmdq005,
                                         pmdq004 = g_pmdq_d[l_ac2].pmdq004,
                                         pmdq003 = g_pmdq_d[l_ac2].pmdq003
                WHERE pmdqseq2 = g_pmdq_d[l_ac2].pmdqseq2
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0     #更新不到資料 
                     LET g_errparam.code = 'std-00009'
                  WHEN SQLCA.sqlcode            #其他錯誤 
                     LET g_errparam.code = SQLCA.sqlcode
                  OTHERWISE
                     EXIT CASE
               END CASE 
               
               IF NOT cl_null(g_errparam.code) THEN
                  LET g_errparam.extend = 'apmp501_pmdq_t'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_pmdq_d[l_ac2].* = g_pmdq_d_t.*
               END IF
               LET g_flag = 1

            AFTER ROW

            AFTER INPUT
               IF g_flag = 1 THEN 
                  #是否不執行該筆資料交期變更，放棄編輯過的交期明細內容？ 
                  IF cl_ask_confirm("axm-00428") THEN     
                     LET g_flag = 0
                  ELSE
                     NEXT FIELD CURRENT 
                  END IF
               END IF 
               
               CALL cl_set_act_visible("accept",TRUE)

            ON ACTION batch_execute        #執行  
               IF cl_null(g_pmdq_d[l_ac2].pmdq002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00590'       #分批數量不可為空！ 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_pmdq_d[l_ac2].pmdo009) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00591'      #交期類型不可為空！ 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_pmdq_d[l_ac2].pmdq005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00592'      #到庫日不可為空！ 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
               
               IF cl_null(g_pmdq_d[l_ac2].pmdq004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00593'      #到廠日不可為空！ 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF cl_null(g_pmdq_d[l_ac2].pmdq003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00594'      #出貨日不可為空！ 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
               
               CALL s_transaction_begin()
               
               CASE l_cmd
                  WHEN 'a'
                     INSERT INTO apmp501_pmdq_t(pmdqdocno,pmdqseq,pmdqseq2,pmdq002,
                                                pmdn006_down,pmdo009,pmdq005,pmdq004,
                                                pmdq003,pmdo015)
                          VALUES(g_detail_d[g_detail_cnt].pmdldocno,g_detail_d[g_detail_cnt].pmdnseq,
                                 g_pmdq_d[l_ac2].pmdqseq2,g_pmdq_d[l_ac2].pmdq002,
                                 g_pmdq_d[l_ac2].pmdn006_down,g_pmdq_d[l_ac2].pmdo009,
                                 g_pmdq_d[l_ac2].pmdq005,g_pmdq_d[l_ac2].pmdq004,
                                 g_pmdq_d[l_ac2].pmdq003,g_pmdq_d[l_ac2].pmdo015)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.extend = "apmp501_pmdq_t"
                        LET g_errparam.popup  = TRUE
                        CALL cl_err() 
                        
                        CALL s_transaction_end('N',0)

                        NEXT FIELD CURRENT
                     END IF
                  WHEN 'u'
                     INITIALIZE g_errparam TO NULL 
                     UPDATE apmp501_pmdq_t SET pmdq002 = g_pmdq_d[l_ac2].pmdq002,
                                               pmdo009 = g_pmdq_d[l_ac2].pmdo009,
                                               pmdq005 = g_pmdq_d[l_ac2].pmdq005,
                                               pmdq004 = g_pmdq_d[l_ac2].pmdq004,
                                               pmdq003 = g_pmdq_d[l_ac2].pmdq003
                      WHERE pmdqseq2 = g_pmdq_d[l_ac2].pmdqseq2

                     CASE
                        WHEN SQLCA.sqlerrd[3] = 0     #更新不到資料 
                           LET g_errparam.code = 'std-00009'
                        WHEN SQLCA.sqlcode            #其他錯誤 
                           LET g_errparam.code = SQLCA.sqlcode
                        OTHERWISE
                           EXIT CASE
                     END CASE

                     IF NOT cl_null(g_errparam.code) THEN
                        LET g_errparam.extend = 'apmp501_pmdq_t'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err() 
                        
                        CALL s_transaction_end('N',0)

                        NEXT FIELD CURRENT
                     END IF
                  OTHERWISE
                     EXIT CASE
               END CASE 
            
               LET l_pmdq002 = 0
               SELECT SUM(pmdq002) INTO l_pmdq002
                 FROM apmp501_pmdq_t
               #維護確定後須檢核所有交期明細的數量總和需等於原採購數量 
               IF l_pmdq002 <> g_detail_d[l_ac1].pmdn007 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00586'
                  LET g_errparam.extend = g_detail_d[l_ac1].pmdn007
                  LET g_errparam.popup  = TRUE
                  CALL cl_err() 
                  
                  CALL s_transaction_end('N',0)

                  NEXT FIELD CURRENT
               END IF

               CALL s_transaction_end('Y',0)
               
               CALL apmp501_process() 
               
               EXIT DIALOG
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(l_ac1)
               
            BEFORE ROW
               LET l_ac1 = DIALOG.getCurrentRow("s_detail1")
               CALL apmp501_b_fill02()

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
            CALL cl_set_comp_visible("sel",FALSE)
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
            CALL apmp501_filter()
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
            CALL apmp501_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp501_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
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
 
{<section id="apmp501.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp501_query()
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
   CALL apmp501_b_fill()
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
 
{<section id="apmp501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp501_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT 'N',pmdl004,'',pmdldocno,pmdnseq,pmdn001,'','', ",
               "       pmdn002,pmdn007,pmdn006,'',pmdn024,pmdn012, ",
               "       pmdn013,pmdn014,pmdl002,'',pmdl003,'' ",
               "  FROM pmdl_t,pmdn_t ",
               " WHERE pmdlent   = ? ",
               "   AND pmdlsite  = '",g_site,"' ",
               "   AND pmdlent   = pmdnent ",
               "   AND pmdlsite  = pmdnsite ",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdlstus  = 'Y' ",                     #查詢的採購單需是已經確認且未結案的採購單   
               "   AND pmdn045   = '1' ",                     #單身的行狀態也需是未結案的資料
               "   AND (pmdl006 <> '6' OR pmdl007 <> '9') ",  #排除中間交易or多角拋轉 #160523-00018#2
               "   AND ",g_wc, 
               " ORDER BY pmdldocno,pmdnseq "
   #end add-point
 
   PREPARE apmp501_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp501_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
      g_detail_d[l_ac].sel,g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].pmdl004_desc,
      g_detail_d[l_ac].pmdldocno,g_detail_d[l_ac].pmdnseq,g_detail_d[l_ac].pmdn001,
      g_detail_d[l_ac].pmdn001_desc,g_detail_d[l_ac].pmdn001_desc_1,
      g_detail_d[l_ac].pmdn002,g_detail_d[l_ac].pmdn007,g_detail_d[l_ac].pmdn006,
      g_detail_d[l_ac].pmdn006_desc,g_detail_d[l_ac].pmdn024,g_detail_d[l_ac].pmdn012,
      g_detail_d[l_ac].pmdn013,g_detail_d[l_ac].pmdn014,g_detail_d[l_ac].pmdl002,
      g_detail_d[l_ac].pmdl002_desc,g_detail_d[l_ac].pmdl003,g_detail_d[l_ac].pmdl003_desc
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
      #取得交易對象簡稱 
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].pmdl004)
           RETURNING g_detail_d[l_ac].pmdl004_desc

      #取得品名 規格  
      CALL s_desc_get_item_desc(g_detail_d[l_ac].pmdn001)
           RETURNING g_detail_d[l_ac].pmdn001_desc,
                     g_detail_d[l_ac].pmdn001_desc_1

      #取得單位說明 
      CALL s_desc_get_unit_desc(g_detail_d[l_ac].pmdn006)
           RETURNING g_detail_d[l_ac].pmdn006_desc

      #取得人員姓名  
      CALL s_desc_get_person_desc(g_detail_d[l_ac].pmdl002)
           RETURNING g_detail_d[l_ac].pmdl002_desc

      #取得部門簡稱 
      CALL s_desc_get_department_desc(g_detail_d[l_ac].pmdl003)
           RETURNING g_detail_d[l_ac].pmdl003_desc 
           
      #取得產品特徵說明 
      CALL s_feature_description(g_detail_d[l_ac].pmdn001,g_detail_d[l_ac].pmdn002)
           RETURNING l_success,g_detail_d[l_ac].pmdn002_desc
      #end add-point
      
      CALL apmp501_detail_show()      
 
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
   FREE apmp501_sel
   
   LET l_ac = 1
   CALL apmp501_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   LET l_ac1 = 1

   CALL apmp501_b_fill02()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp501.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp501_fetch()
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
 
{<section id="apmp501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp501_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp501.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp501_filter()
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
   
   CALL apmp501_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp501.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp501_filter_parser(ps_field)
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
 
{<section id="apmp501.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp501_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp501.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 填充下方單身
# Memo...........:
# Usage..........: CALL apmp501_b_fill02()
# Date & Author..: 2014/08/12 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_b_fill02()
   DEFINE l_sql     STRING
   DEFINE l_pmdn006 LIKE pmdn_t.pmdn006        #採購單位  
   DEFINE l_pmdn007 LIKE pmdn_t.pmdn007        #採購數量 
   DEFINE l_pmdo009 LIKE pmdo_t.pmdo009        #交期類型  
   DEFINE l_pmdo011 LIKE pmdo_t.pmdo011        #出貨日期  
   DEFINE l_pmdo012 LIKE pmdo_t.pmdo012        #到廠日期  
   DEFINE l_pmdo013 LIKE pmdo_t.pmdo013        #到庫日期  
   DEFINE l_pmdo015 LIKE pmdo_t.pmdo015        #已收貨數量  

   CALL g_pmdq_d.clear() 
   
   IF g_detail_d.getLength() < 1 THEN
      RETURN
   END IF
   
   IF cl_null(l_ac1) OR l_ac1 = 0 THEN
      LET l_ac1 = 1
   END IF

   #清空temp table的資料 
   DELETE FROM apmp501_pmdq_t
   
   LET l_sql = "SELECT pmdqdocno,pmdqseq,pmdqseq2,pmdq002,'','','', ",
               "       pmdq005,pmdq004,pmdq003,'' ",
               "  FROM pmdq_t ",
               " WHERE pmdqent = '",g_enterprise,"' ",
               "   AND pmdqsite = '",g_site,"' ",
               "   AND pmdqdocno = '",g_detail_d[l_ac1].pmdldocno,"' ",
               "   AND pmdqseq = '",g_detail_d[l_ac1].pmdnseq,"' ",
               " ORDER BY pmdqseq,pmdqseq2 "

   PREPARE apmp501_b_fill02_prep FROM l_sql
   DECLARE apmp501_b_fill02_curs CURSOR FOR apmp501_b_fill02_prep

   LET g_detail_cnt2 = 1
   FOREACH apmp501_b_fill02_curs INTO g_pmdq_d[g_detail_cnt2].*

      #取得採購明細的單位 
      SELECT pmdn006 INTO g_pmdq_d[g_detail_cnt2].pmdn006_down
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdnsite  = g_site
         AND pmdndocno = g_pmdq_d[g_detail_cnt2].pmdqdocno
         AND pmdnseq   = g_pmdq_d[g_detail_cnt2].pmdqseq

      #取得單位說明   
      CALL s_desc_get_unit_desc(g_pmdq_d[g_detail_cnt2].pmdn006_down)
           RETURNING g_pmdq_d[g_detail_cnt2].pmdn006_down_desc

      #取得交期明細的交期類型 與 已收貨數量 
      SELECT pmdo009,SUM(pmdo015)
        INTO g_pmdq_d[g_detail_cnt2].pmdo009,
             g_pmdq_d[g_detail_cnt2].pmdo015
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdosite = g_site
         AND pmdodocno = g_pmdq_d[g_detail_cnt2].pmdqdocno
         AND pmdoseq   = g_pmdq_d[g_detail_cnt2].pmdqseq
         AND pmdoseq2  = g_pmdq_d[g_detail_cnt2].pmdqseq2
       GROUP BY pmdo009

      INSERT INTO apmp501_pmdq_t(pmdqdocno,pmdqseq,pmdqseq2,pmdq002,
                                 pmdn006_down,pmdo009,pmdq005,pmdq004,
                                 pmdq003,pmdo015)
           VALUES(g_pmdq_d[g_detail_cnt2].pmdqdocno,g_pmdq_d[g_detail_cnt2].pmdqseq,
                  g_pmdq_d[g_detail_cnt2].pmdqseq2,g_pmdq_d[g_detail_cnt2].pmdq002,
                  g_pmdq_d[g_detail_cnt2].pmdn006_down,g_pmdq_d[g_detail_cnt2].pmdo009,
                  g_pmdq_d[g_detail_cnt2].pmdq005,g_pmdq_d[g_detail_cnt2].pmdq004,
                  g_pmdq_d[g_detail_cnt2].pmdq003,g_pmdq_d[g_detail_cnt2].pmdo015)

      LET g_detail_cnt2 = g_detail_cnt2 + 1
   END FOREACH

   CALL g_pmdq_d.deleteElement(g_pmdq_d.getLength())

   LET g_detail_cnt2 = g_detail_cnt2 - 1 
   
   #如果沒有pmdq_t的資料 就從pmdo_t取得資料 
   IF g_detail_cnt2 = 0 THEN
      LET g_detail_cnt2 = g_detail_cnt2 + 1

      LET g_pmdq_d[g_detail_cnt2].pmdqdocno = g_detail_d[l_ac1].pmdldocno
      LET g_pmdq_d[g_detail_cnt2].pmdqseq   = g_detail_d[l_ac1].pmdnseq
      LET g_pmdq_d[g_detail_cnt2].pmdqseq2  = 1

      LET l_pmdn006 = ''
      LET l_pmdn007 = 0
      SELECT pmdn006,pmdn007 INTO l_pmdn006,l_pmdn007
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdnsite  = g_site
         AND pmdndocno = g_detail_d[l_ac1].pmdldocno
         AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
      IF cl_null(l_pmdn007) THEN
         LET l_pmdn007 = 0
      END IF

      LET g_pmdq_d[g_detail_cnt2].pmdq002      = l_pmdn007
      LET g_pmdq_d[g_detail_cnt2].pmdn006_down = l_pmdn006 
      
      #取得單位說明 
      CALL s_desc_get_unit_desc(g_pmdq_d[g_detail_cnt2].pmdn006_down)
           RETURNING g_pmdq_d[g_detail_cnt2].pmdn006_down_desc

      #如果是非多交期的資料 則只會有一筆pmdo_t的資料 
      SELECT pmdo009,pmdo011,pmdo012,pmdo013,pmdo015
        INTO l_pmdo009,l_pmdo011,l_pmdo012,l_pmdo013,l_pmdo015
        FROM pmdo_t
       WHERE pmdoent   = g_enterprise
         AND pmdosite  = g_site
         AND pmdodocno = g_detail_d[l_ac1].pmdldocno
         AND pmdoseq   = g_detail_d[l_ac1].pmdnseq

      IF cl_null(l_pmdo015) THEN
         LET l_pmdo015 = 0
      END IF
      LET g_pmdq_d[g_detail_cnt2].pmdo009 = l_pmdo009         #交期類型  
      LET g_pmdq_d[g_detail_cnt2].pmdq005 = l_pmdo013         #預計到庫日  
      LET g_pmdq_d[g_detail_cnt2].pmdq004 = l_pmdo012         #預計到廠日  
      LET g_pmdq_d[g_detail_cnt2].pmdq003 = l_pmdo011         #預計出貨日  
      LET g_pmdq_d[g_detail_cnt2].pmdo015 = l_pmdo015         #已收貨數量   
      
      INSERT INTO apmp501_pmdq_t(pmdqdocno,pmdqseq,pmdqseq2,pmdq002,
                                 pmdn006_down,pmdo009,pmdq005,pmdq004,
                                 pmdq003,pmdo015)
           VALUES(g_pmdq_d[g_detail_cnt2].pmdqdocno,g_pmdq_d[g_detail_cnt2].pmdqseq,
                  g_pmdq_d[g_detail_cnt2].pmdqseq2,g_pmdq_d[g_detail_cnt2].pmdq002,
                  g_pmdq_d[g_detail_cnt2].pmdn006_down,g_pmdq_d[g_detail_cnt2].pmdo009,
                  g_pmdq_d[g_detail_cnt2].pmdq005,g_pmdq_d[g_detail_cnt2].pmdq004,
                  g_pmdq_d[g_detail_cnt2].pmdq003,g_pmdq_d[g_detail_cnt2].pmdo015)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立temp table 
# Memo...........:
# Usage..........: CALL apmp501_create_table()
# Date & Author..: 2014/08/13 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_create_table()
   CREATE TEMP TABLE apmp501_pmdq_t(
      pmdqdocno       VARCHAR(20),         #採購單號  
      pmdqseq         INTEGER,           #項次  
      pmdqseq2        INTEGER,          #分批序  
      pmdq002         DECIMAL(20,6),           #分批數量  
      pmdn006_down    VARCHAR(10),           #採購單位  
      pmdo009         VARCHAR(10),           #交期類型  
      pmdq005         DATE,           #預計到庫日  
      pmdq004         DATE,           #預計到廠日  
      pmdq003         DATE,           #預計出貨日  
      pmdo015         DECIMAL(20,6)     #已收貨數量  
   )
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table 
# Memo...........:
# Usage..........: CALL apmp501_drop_table()
# Date & Author..: 2014/08/13 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_drop_table()
   DROP TABLE apmp501_pmdq_t;
END FUNCTION

################################################################################
# Descriptions...: 根據當前營運據點g_site抓取aooi120中設置的行事曆參照表號
# Memo...........:
# Usage..........: CALL apmp501_get_ooef()
# Date & Author..: 2014/08/13 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_get_ooef()
   #根據當前營運據點g_site抓取aooi120中設置的行事曆參照表號 
   SELECT ooef008,ooef009 INTO g_ooef008,g_ooef009
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
END FUNCTION

################################################################################
# Descriptions...: 取得採購到廠、入庫前置時間
# Memo...........:
# Usage..........: CALL apmp501_get_imaf173_174(p_imaf001)
#                  RETURNING 回传参数
# Input parameter: p_imaf001:料號
# Return code....: r_imaf173:採購到廠前置時間
#                : r_imaf174:採購入庫前置時間
# Date & Author..: 2014/08/13 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_get_imaf173_174(p_imaf001)
   DEFINE p_imaf001     LIKE imaf_t.imaf001
   DEFINE r_imaf173     LIKE imaf_t.imaf173
   DEFINE r_imaf174     LIKE imaf_t.imaf174

   #取得採購到廠、入庫前置時間 
   LET r_imaf173 = ''
   LET r_imaf174 = ''
   SELECT imaf173,imaf174
     INTO r_imaf173,r_imaf174
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_imaf001

   RETURN r_imaf173,r_imaf174
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp501_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/08/14 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_process()
   DEFINE l_totsuccess  LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_count       LIKE type_t.num5
   DEFINE l_pmdo        RECORD
                           pmdoseq2     LIKE pmdo_t.pmdoseq2,     #分批序  
                           pmdo002      LIKE pmdo_t.pmdo002,      #料號 
                           pmdo006      LIKE pmdo_t.pmdo006,      #分批採購數量 
                           pmdo004      LIKE pmdo_t.pmdo004,      #單位 
                           pmdo009      LIKE pmdo_t.pmdo009,      #交期類型 
                           pmdo011      LIKE pmdo_t.pmdo011,      #預計出貨日  
                           pmdo012      LIKE pmdo_t.pmdo012,      #預計到廠日  
                           pmdo013      LIKE pmdo_t.pmdo013,      #預計到庫日  
                           pmdo015      LIKE pmdo_t.pmdo015,      #已收貨數量  
                           pmdo028      LIKE pmdo_t.pmdo028,      #分批參考單位 
                           pmdo029      LIKE pmdo_t.pmdo029,      #分批參考數量 
                           pmdo030      LIKE pmdo_t.pmdo030,      #分批計價單位 
                           pmdo031      LIKE pmdo_t.pmdo031       #分批計價數量 
                        END RECORD
   DEFINE l_pmdoseq2    LIKE pmdo_t.pmdoseq2 
   
   DEFINE l_pmdo005     LIKE pmdo_t.pmdo005                       #採購總數量  
   DEFINE l_pmdo032     LIKE pmdo_t.pmdo032                       #分批未稅金額 
   DEFINE l_pmdo033     LIKE pmdo_t.pmdo033                       #分批含稅金額 
   DEFINE l_pmdo034     LIKE pmdo_t.pmdo034                       #分批稅額  

   DEFINE l_pmdn046     LIKE pmdn_t.pmdn046                       #未稅金額  
   DEFINE l_pmdn047     LIKE pmdn_t.pmdn047                       #含稅金額  
   DEFINE l_pmdn048     LIKE pmdn_t.pmdn048                       #稅額   
   DEFINE l_pmdl015     LIKE pmdl_t.pmdl015                       #幣別 
   DEFINE l_sql         STRING
   DEFINE l_pmdoseq2_1  LIKE pmdo_t.pmdoseq2
   DEFINE l_pmdoseq2_2  LIKE pmdo_t.pmdoseq2
   DEFINE l_pmdo032_p   LIKE pmdo_t.pmdo032
   DEFINE l_pmdo011     LIKE pmdo_t.pmdo011
   DEFINE l_pmdo012     LIKE pmdo_t.pmdo012
   DEFINE l_pmdo013     LIKE pmdo_t.pmdo013
   DEFINE l_pmdo011_p   LIKE pmdo_t.pmdo011
   DEFINE l_tot_pmdo032 LIKE pmdo_t.pmdo032
   DEFINE l_tot_pmdo033 LIKE pmdo_t.pmdo033
   DEFINE l_tot_pmdo034 LIKE pmdo_t.pmdo034
   DEFINE l_diff01      LIKE pmdo_t.pmdo032
   DEFINE l_diff02      LIKE pmdo_t.pmdo033
   DEFINE l_diff03      LIKE pmdo_t.pmdo034 
   DEFINE l_pmdo027     LIKE pmdo_t.pmdo027 
   DEFINE l_pmdl031     LIKE pmdl_t.pmdl031   #160523-00018#2 add
   

   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET l_totsuccess = TRUE

   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apmp501_pmdq_t 
   
   IF l_count = 1 THEN 
      #分批參考數量 分批計價數量 也應該拆解與合併 
      INITIALIZE l_pmdo.* TO NULL
      SELECT pmdo002,pmdo028,pmdo030
        INTO l_pmdo.pmdo002,l_pmdo.pmdo028,l_pmdo.pmdo030
        FROM pmdo_t
       WHERE pmdoent  = g_enterprise
         AND pmdosite = g_site
         AND pmdoseq  = g_detail_d[l_ac1].pmdnseq
         AND pmdoseq2 = 1 
         
      LET l_pmdo.pmdo029 = 0     #分批參考數量  
      IF NOT cl_null(l_pmdo.pmdo028) THEN
         CALL s_aooi250_convert_qty(l_pmdo.pmdo002,g_pmdq_d[1].pmdn006_down,l_pmdo.pmdo028,g_pmdq_d[1].pmdq002)
              RETURNING l_success,l_pmdo.pmdo029
      END IF

      LET  l_pmdo.pmdo031 = 0     #分批計價數量  
      IF NOT cl_null(l_pmdo.pmdo030) THEN
         CALL s_aooi250_convert_qty(l_pmdo.pmdo002,g_pmdq_d[1].pmdn006_down,l_pmdo.pmdo030,g_pmdq_d[1].pmdq002)
              RETURNING l_success,l_pmdo.pmdo031
      END IF 
      
      LET l_pmdo027 = cl_get_current()
      
      UPDATE pmdo_t SET pmdo006 = g_pmdq_d[1].pmdq002,
                        pmdo004 = g_pmdq_d[1].pmdn006_down,
                        pmdo009 = g_pmdq_d[1].pmdo009,     #161109-00042#1  add 
                        pmdo011 = g_pmdq_d[1].pmdq003,
                        pmdo012 = g_pmdq_d[1].pmdq004,
                        pmdo013 = g_pmdq_d[1].pmdq005,
                        pmdo026 = g_user,
                        pmdo027 = l_pmdo027,
                        pmdo029 = l_pmdo.pmdo029,
                        pmdo031 = l_pmdo.pmdo031
       WHERE pmdoent = g_enterprise
         AND pmdodocno = g_detail_d[l_ac1].pmdldocno
         AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
         AND pmdoseq2  = 1
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('pmdoseq2','1','upd pmdo_t',SQLCA.sqlcode,1)
         LET l_totsuccess = FALSE
      END IF

      IF g_detail_d[l_ac1].pmdn024 = 'Y' THEN
         UPDATE pmdn_t SET pmdn024 = 'N'
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_detail_d[l_ac1].pmdldocno
            AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('pmdnseq',g_detail_d[l_ac1].pmdnseq,'upd pmdn_t',SQLCA.sqlcode,1)
            LET l_totsuccess = FALSE
         END IF 
         
         DELETE FROM pmdq_t WHERE pmdqent = g_enterprise
                              AND pmdqdocno = g_detail_d[l_ac1].pmdldocno
                              AND pmdqseq   = g_detail_d[l_ac1].pmdnseq
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('pmdqseq',g_detail_d[l_ac1].pmdnseq,'del pmdq_t',SQLCA.sqlcode,1)
            LET l_totsuccess = FALSE
         END IF

         DELETE FROM pmdo_t WHERE pmdoent = g_enterprise
                              AND pmdodocno = g_detail_d[l_ac1].pmdldocno
                              AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
                              AND pmdoseq2  <> 1
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('pmdoseq',g_detail_d[l_ac1].pmdnseq,'del pmdoseq',SQLCA.sqlcode,1)
            LET l_totsuccess = FALSE
         END IF
      END IF

   ELSE
      IF g_detail_d[l_ac1].pmdn024 = 'N' THEN
         UPDATE pmdn_t SET pmdn024 = 'Y'
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_detail_d[l_ac1].pmdldocno
            AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
         IF SQLCA.sqlcode THEN
            CALL cl_errmsg('pmdnseq',g_detail_d[l_ac1].pmdnseq,'upd pmdn_t',SQLCA.sqlcode,1)
            LET l_totsuccess = FALSE
         END IF
      END IF 
      
      INITIALIZE l_pmdo.* TO NULL
      DECLARE apmp501_curs2 CURSOR FOR SELECT pmdqseq2,pmdq002,pmdn006_down,
                                              pmdo009,pmdq005,pmdq004,pmdq003,pmdo015
                                         FROM apmp501_pmdq_t
      FOREACH apmp501_curs2 INTO l_pmdo.pmdoseq2,l_pmdo.pmdo006,l_pmdo.pmdo004,
                                 l_pmdo.pmdo009,l_pmdo.pmdo013,l_pmdo.pmdo012,
                                 l_pmdo.pmdo011,l_pmdo.pmdo015 
                                 
         SELECT pmdo002,pmdo005,pmdo028,pmdo030
           INTO l_pmdo.pmdo002,l_pmdo005,l_pmdo.pmdo028,l_pmdo.pmdo030
           FROM pmdo_t
          WHERE pmdoent   = g_enterprise
            AND pmdodocno = g_detail_d[l_ac1].pmdldocno
            AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
            AND pmdoseq2  = l_pmdo.pmdoseq2
            
         LET l_pmdo.pmdo029 = 0     #分批參考數量  
         IF NOT cl_null(l_pmdo.pmdo028) THEN
            CALL s_aooi250_convert_qty(l_pmdo.pmdo002,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
                 RETURNING l_success,l_pmdo.pmdo029
         END IF
         
         LET l_pmdo.pmdo031 = 0     #分批計價數量 
         IF NOT cl_null(l_pmdo.pmdo030) THEN
            CALL s_aooi250_convert_qty(l_pmdo.pmdo002,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
                 RETURNING l_success,l_pmdo.pmdo031 
         END IF 
                 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pmdq_t
          WHERE pmdqent = g_enterprise
            AND pmdqdocno = g_detail_d[l_ac1].pmdldocno
            AND pmdqseq   = g_detail_d[l_ac1].pmdnseq
            AND pmdqseq2  = l_pmdo.pmdoseq2
         IF cl_null(l_count) OR l_count = 0 THEN
            INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005)
                        VALUES(g_enterprise,g_site,g_detail_d[l_ac1].pmdldocno,g_detail_d[l_ac1].pmdnseq,
                               l_pmdo.pmdoseq2,l_pmdo.pmdo006,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013)
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg('pmdqseq2',l_pmdo.pmdoseq2,'ins pmdo_t',SQLCA.sqlcode,1)
               LET l_totsuccess = FALSE
            END IF

         ELSE 
                     
            UPDATE pmdq_t SET pmdq002 = l_pmdo.pmdo006,
                              pmdq003 = l_pmdo.pmdo011, 
                              pmdq004 = l_pmdo.pmdo012,
                              pmdq005 = l_pmdo.pmdo013
             WHERE pmdqent = g_enterprise
               AND pmdqdocno = g_detail_d[l_ac1].pmdldocno
               AND pmdqseq   = g_detail_d[l_ac1].pmdnseq
               AND pmdqseq2  = l_pmdo.pmdoseq2
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg('pmdqseq2',l_pmdo.pmdoseq2,'upd pmdq_t',SQLCA.sqlcode,1)
               LET l_totsuccess = FALSE
            END IF
         END IF 
         
         #----------------------------------------------------------------------------
         
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pmdo_t
          WHERE pmdoent   = g_enterprise
            AND pmdodocno = g_detail_d[l_ac1].pmdldocno
            AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
            AND pmdoseq2  = l_pmdo.pmdoseq2
         IF cl_null(l_count) OR l_count = 0 THEN
            CALL apmp501_pmdo_ins(l_pmdo.pmdoseq2,l_pmdo.pmdo006,l_pmdo.pmdo009,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013)
                 RETURNING l_success
            IF NOT l_success THEN
               LET l_totsuccess = FALSE
            END IF
         ELSE  
            LET l_pmdn046 = 0                    #未稅金額   
            LET l_pmdn047 = 0                    #含稅金額  
            LET l_pmdn048 = 0                    #稅額  
            SELECT pmdn046,pmdn047,pmdn048 INTO l_pmdn046,l_pmdn047,l_pmdn048
              FROM pmdn_t
             WHERE pmdnent   = g_enterprise
               AND pmdnsite  = g_site
               AND pmdndocno = g_detail_d[l_ac1].pmdldocno
               AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
            IF cl_null(l_pmdn046) THEN
               LET l_pmdn046 = 0
            END IF
            IF cl_null(l_pmdn047) THEN
               LET l_pmdn047 = 0
            END IF
            IF cl_null(l_pmdn048) THEN
               LET l_pmdn048 = 0
            END IF
            #計算金額 分批數量/總數量 * 金額 
            #分批未稅金額 
            LET l_pmdo032 = l_pmdo.pmdo006 / l_pmdo005 * l_pmdn046     #pmdq002 / pmdo005 * pmdn046 
            #分批含稅金額 
            LET l_pmdo033 = l_pmdo.pmdo006 / l_pmdo005 * l_pmdn047     #pmdq002 / pmdo005 * pmdn047 
            #分批稅額 
            LET l_pmdo034 = l_pmdo.pmdo006 / l_pmdo005 * l_pmdn048     #pmdq002 / pmdo005 * pmdn048  
            
            #取得幣別匯率  
            LET l_pmdl015 = ''
            SELECT pmdl015 INTO l_pmdl015
              FROM pmdl_t
             WHERE pmdlent = g_enterprise
               AND pmdlsite = g_site
               AND pmdldocno = g_detail_d[l_ac1].pmdldocno

            LET l_pmdo032 = s_curr_round(g_site,l_pmdl015,l_pmdo032,2)
            LET l_pmdo033 = s_curr_round(g_site,l_pmdl015,l_pmdo033,2)
            LET l_pmdo034 = s_curr_round(g_site,l_pmdl015,l_pmdo034,2) 
            
            LET l_pmdo027 = cl_get_current()
         
            UPDATE pmdo_t SET pmdo006 = l_pmdo.pmdo006,
                              pmdo009 = l_pmdo.pmdo009,
                              pmdo011 = l_pmdo.pmdo011,
                              pmdo012 = l_pmdo.pmdo012,
                              pmdo013 = l_pmdo.pmdo013,
                              pmdo026 = g_user,
                              pmdo027 = l_pmdo027,
                              pmdo029 = l_pmdo.pmdo029,
                              pmdo031 = l_pmdo.pmdo031,
                              pmdo032 = l_pmdo032,
                              pmdo033 = l_pmdo033,
                              pmdo034 = l_pmdo034
             WHERE pmdoent = g_enterprise
               AND pmdodocno = g_detail_d[l_ac1].pmdldocno
               AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
               AND pmdoseq2  = l_pmdo.pmdoseq2
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg('pmdoseq2',l_pmdo.pmdoseq2,'upd pmdo_t',SQLCA.sqlcode,1)
               LET l_totsuccess = FALSE
            END IF
         END IF 
         
         INITIALIZE l_pmdo.* TO NULL
      END FOREACH

      LET l_pmdoseq2 = ''
      DECLARE apmp501_curs3 CURSOR FOR SELECT pmdqseq2 FROM pmdq_t
                                        WHERE pmdqent = g_enterprise
                                          AND pmdqdocno = g_detail_d[l_ac1].pmdldocno
                                          AND pmdqseq   = g_detail_d[l_ac1].pmdnseq
      FOREACH apmp501_curs3 INTO l_pmdoseq2
         LET l_count = 0
         SELECT COUNT(*) INTO l_count
           FROM apmp501_pmdq_t
          WHERE pmdqseq2 = l_pmdoseq2
         IF cl_null(l_count) OR l_count = 0 THEN
            DELETE FROM pmdq_t
             WHERE pmdqent = g_enterprise
               AND pmdqdocno = g_detail_d[l_ac1].pmdldocno
               AND pmdqseq   = g_detail_d[l_ac1].pmdnseq
               AND pmdqseq2  = l_pmdoseq2
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg('pmdqseq2',l_pmdoseq2,'del pmdq_t',SQLCA.sqlcode,1)
               LET l_totsuccess = FALSE
            END IF

            DELETE FROM pmdo_t
             WHERE pmdoent = g_enterprise
               AND pmdodocno = g_detail_d[l_ac1].pmdldocno
               AND pmdoseq   = g_detail_d[l_ac1].pmdnseq 
               AND pmdoseq2  = l_pmdoseq2
            IF SQLCA.sqlcode THEN
               CALL cl_errmsg('pmdoseq2',l_pmdoseq2,'del pmdo_t',SQLCA.sqlcode,1)
               LET l_totsuccess = FALSE
            END IF
         END IF

         LET l_pmdoseq2 = ''
      END FOREACH 
      
      #處理金額尾差與日期的更新 
      LET l_sql = "SELECT pmdoseq2,pmdo011,pmdo012,pmdo013,pmdo032,pmdo033,pmdo034 ",
                  "  FROM pmdo_t ",
                  " WHERE pmdoent   = '",g_enterprise,"' ",
                  "   AND pmdosite  = '",g_site,"' ",
                  "   AND pmdodocno = '",g_detail_d[l_ac1].pmdldocno,"' ",
                  "   AND pmdoseq   = '",g_detail_d[l_ac1].pmdnseq,"' "
      PREPARE apmp501_pmdo_upd_prep FROM l_sql
      DECLARE apmp501_pmdo_upd_curs CURSOR FOR apmp501_pmdo_upd_prep

      LET l_pmdoseq2    = ''
      LET l_pmdoseq2_1  = ''             #要修改日期的分批序  
      LET l_pmdoseq2_2  = ''             #要修改金額的分批序  
      LET l_pmdo032     = 0
      LET l_pmdo033     = 0
      LET l_pmdo034     = 0
      LET l_pmdo032_p   = 0              #要拿來比大小的  
      LET l_pmdo011     = ''
      LET l_pmdo012     = ''
      LET l_pmdo013     = ''
      LET l_pmdo011_p   = ''             #要拿來比大小的 
      LET l_tot_pmdo032 = 0
      LET l_tot_pmdo033 = 0
      LET l_tot_pmdo034 = 0 
      FOREACH apmp501_pmdo_upd_curs INTO l_pmdoseq2,
                                         l_pmdo011,l_pmdo012,l_pmdo013,
                                         l_pmdo032,l_pmdo033,l_pmdo034
         LET l_tot_pmdo032 = l_tot_pmdo032 + l_pmdo032
         LET l_tot_pmdo033 = l_tot_pmdo033 + l_pmdo033
         LET l_tot_pmdo034 = l_tot_pmdo034 + l_pmdo034

         IF l_pmdo032 > l_pmdo032_p OR l_pmdo032_p IS NULL THEN
            LET l_pmdo032_p = l_pmdo032
            LET l_pmdoseq2_2 = l_pmdoseq2
         END IF

         IF l_pmdo011 < l_pmdo011_p OR l_pmdo011_p IS NULL THEN
            LET l_pmdo011_p = l_pmdo011
            LET l_pmdoseq2_1 = l_pmdoseq2
         END IF
      END FOREACH

      LET l_pmdn046 = 0
      LET l_pmdn047 = 0
      LET l_pmdn048 = 0
      SELECT pmdn046,pmdn047,pmdn048 INTO l_pmdn046,l_pmdn047,l_pmdn048
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdnsite  = g_site
         AND pmdndocno = g_detail_d[l_ac1].pmdldocno
         AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
      IF (l_tot_pmdo032 - l_pmdn046 <> 0) OR
         (l_tot_pmdo033 - l_pmdn047 <> 0) OR 
         (l_tot_pmdo034 - l_pmdn048 <> 0) THEN
         LET l_diff01 = l_pmdn046 - l_tot_pmdo032
         LET l_diff02 = l_pmdn047 - l_tot_pmdo033
         LET l_diff03 = l_pmdn048 - l_tot_pmdo034

         UPDATE pmdo_t SET pmdo046 = pmdo046 + l_diff01,
                           pmdo047 = pmdo047 + l_diff02,
                           pmdo048 = pmdo048 + l_diff03
          WHERE pmdoent = g_enterprise
            AND pmdosite = g_site
            AND pmdodocno = g_detail_d[l_ac1].pmdldocno
            AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
            AND pmdoseq2  = l_pmdoseq2_2
      END IF

      LET l_pmdo011 = ''
      LET l_pmdo012 = ''
      LET l_pmdo013 = '' 
      SELECT pmdo011,pmdo012,pmdo013 INTO l_pmdo011,l_pmdo012,l_pmdo013
        FROM pmdo_t
       WHERE pmdoent = g_enterprise
         AND pmdosite = g_site
         AND pmdodocno = g_detail_d[l_ac1].pmdldocno
         AND pmdoseq   = g_detail_d[l_ac1].pmdnseq
         AND pmdoseq2  = l_pmdoseq2_1
      UPDATE pmdn_t SET pmdn012 = l_pmdo011,
                        pmdn013 = l_pmdo012,
                        pmdn014 = l_pmdo013
       WHERE pmdnent = g_enterprise
         AND pmdnsite = g_site
         AND pmdndocno = g_detail_d[l_ac1].pmdldocno
         AND pmdnseq   = g_detail_d[l_ac1].pmdnseq
   END IF

   #160523-00018#2-s-add
   #判斷單據是否為多角且已拋轉，則需一併調整多角單據
   SELECT pmdl031 INTO l_pmdl031
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = g_detail_d[l_ac1].pmdldocno
   IF NOT cl_null(l_pmdl031) THEN
      IF NOT apmp501_aic_upd(l_pmdl031,g_detail_d[l_ac1].pmdldocno,g_detail_d[l_ac1].pmdnseq) THEN
         LET l_totsuccess = FALSE
      END IF
   END IF   
   #160523-00018#2-e-add


   CALL cl_showmsg()

   IF l_totsuccess THEN
      CALL s_transaction_end('Y',0)
      LET g_flag = 0
   ELSE
      CALL s_transaction_end('N',0)
   END IF 
   
   IF g_bgjob = 'N' THEN
      #前景作業完成處理
      CALL cl_ask_pressanykey("std-00012")
   ELSE
      #背景作業完成處理 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apmp501_pmdo_ins(p_pmdoseq2,p_pmdo006,p_pmdo009,p_pmdo011,p_pmdo012,p_pmdo013)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/08/15 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_pmdo_ins(p_pmdoseq2,p_pmdo006,p_pmdo009,p_pmdo011,p_pmdo012,p_pmdo013)
   DEFINE p_pmdoseq2     LIKE pmdo_t.pmdoseq2
   DEFINE p_pmdo006      LIKE pmdo_t.pmdo006
   DEFINE p_pmdo009      LIKE pmdo_t.pmdo009
   DEFINE p_pmdo011      LIKE pmdo_t.pmdo011
   DEFINE p_pmdo012      LIKE pmdo_t.pmdo012
   DEFINE p_pmdo013      LIKE pmdo_t.pmdo013
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_pmdo         RECORD
                            pmdoent     LIKE pmdo_t.pmdoent,      #企業編號   
                            pmdosite    LIKE pmdo_t.pmdosite,     #營運據點  
                            pmdodocno   LIKE pmdo_t.pmdodocno,    #採購單號   
                            pmdoseq     LIKE pmdo_t.pmdoseq,      #採購項次  
                            pmdoseq1    LIKE pmdo_t.pmdoseq1,     #項序  
                            pmdoseq2    LIKE pmdo_t.pmdoseq2,     #分批序  
                            pmdo001     LIKE pmdo_t.pmdo001,      #料件編號   
                            pmdo002     LIKE pmdo_t.pmdo002,      #產品特徵  
                            pmdo003     LIKE pmdo_t.pmdo003,      #子件特性 
                            pmdo004     LIKE pmdo_t.pmdo004,      #採購單位 
                            pmdo005     LIKE pmdo_t.pmdo005,      #採購總數量  
                            pmdo006     LIKE pmdo_t.pmdo006,      #分批採購數量 
                            pmdo007     LIKE pmdo_t.pmdo007,      #折合主件數量 
                            pmdo008     LIKE pmdo_t.pmdo008,      #QPA 
                            pmdo009     LIKE pmdo_t.pmdo009,      #交期類型 
                            pmdo010     LIKE pmdo_t.pmdo010,      #收貨時段 
                            pmdo011     LIKE pmdo_t.pmdo011,      #出貨日期 
                            pmdo012     LIKE pmdo_t.pmdo012,      #到廠日期 
                            pmdo013     LIKE pmdo_t.pmdo013,      #到庫日期  
                            pmdo014     LIKE pmdo_t.pmdo014,      #MRP交期凍結  
                            pmdo015     LIKE pmdo_t.pmdo015,      #已收貨量 
                            pmdo016     LIKE pmdo_t.pmdo016,      #驗退量 
                            pmdo017     LIKE pmdo_t.pmdo017,      #倉退換貨量 
                            pmdo019     LIKE pmdo_t.pmdo019,      #已入庫量 
                            pmdo020     LIKE pmdo_t.pmdo020,      #VMI請款量 
                            pmdo021     LIKE pmdo_t.pmdo021,      #交貨狀態 
                            pmdo022     LIKE pmdo_t.pmdo022,      #參考價格 
                            pmdo023     LIKE pmdo_t.pmdo023,      #稅別 
                            pmdo024     LIKE pmdo_t.pmdo024,      #稅率 
                            pmdo025     LIKE pmdo_t.pmdo025,      #電子採購單號 
                            pmdo026     LIKE pmdo_t.pmdo026,      #最近修改人員 
                            pmdo027     LIKE pmdo_t.pmdo027,      #最近修改時間 
                            pmdo028     LIKE pmdo_t.pmdo028,      #分批參考單位 
                            pmdo029     LIKE pmdo_t.pmdo029,      #分批參考數量   
                            pmdo030     LIKE pmdo_t.pmdo030,      #分批計價單位 
                            pmdo031     LIKE pmdo_t.pmdo031,      #分批計價數量 
                            pmdo032     LIKE pmdo_t.pmdo032,      #分批未稅金額 
                            pmdo033     LIKE pmdo_t.pmdo033,      #分批含稅金額 
                            pmdo034     LIKE pmdo_t.pmdo034,      #分批稅額 
                            pmdo035     LIKE pmdo_t.pmdo035,      #初始營運據點 
                            pmdo036     LIKE pmdo_t.pmdo036,      #初始來源單號 
                            pmdo037     LIKE pmdo_t.pmdo037,      #初始來源項次 
                            pmdo038     LIKE pmdo_t.pmdo038,      #初始項序 
                            pmdo039     LIKE pmdo_t.pmdo039,      #初始分批序  
                            pmdo040     LIKE pmdo_t.pmdo040       #倉退量 
                         END RECORD
   DEFINE l_pmdn         RECORD
                            pmdn001     LIKE pmdn_t.pmdn001,      #料件編號  
                            pmdn002     LIKE pmdn_t.pmdn002,      #產品特徵 
                            pmdn006     LIKE pmdn_t.pmdn006,      #採購單位  
                            pmdn007     LIKE pmdn_t.pmdn007,      #採購數量 
                            pmdn008     LIKE pmdn_t.pmdn008,      #參考單位 
                            pmdn009     LIKE pmdn_t.pmdn009,      #參考數量 
                            pmdn010     LIKE pmdn_t.pmdn010,      #計價單位  
                            pmdn011     LIKE pmdn_t.pmdn011,      #計備數量 
                            pmdn015     LIKE pmdn_t.pmdn015,      #單價 
                            pmdn016     LIKE pmdn_t.pmdn016,      #稅別 
                            pmdn017     LIKE pmdn_t.pmdn017,      #稅率 
                            pmdn019     LIKE pmdn_t.pmdn019,      #子件特性  
                            pmdn033     LIKE pmdn_t.pmdn033       #備品率  
                         END RECORD
   DEFINE l_pmdl015      LIKE pmdl_t.pmdl015                      #幣別  
   DEFINE l_pmdl016      LIKE pmdl_t.pmdl016                      #匯率 
   DEFINE l_imaf176      LIKE imaf_t.imaf176                      #收貨時段     

   LET r_success = TRUE

   INITIALIZE l_pmdo.* TO NULL
   INITIALIZE l_pmdn.* TO NULL

   SELECT pmdn001,pmdn002,pmdn006,pmdn007,pmdn008,pmdn009,
          pmdn010,pmdn015,pmdn016,pmdn017,pmdn019,pmdn033
     INTO l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdn.pmdn006,
          l_pmdn.pmdn007,l_pmdn.pmdn008,l_pmdn.pmdn009,
          l_pmdn.pmdn010,l_pmdn.pmdn015,l_pmdn.pmdn016,
          l_pmdn.pmdn017,l_pmdn.pmdn019,l_pmdn.pmdn033
     FROM pmdn_t
    WHERE pmdnent   = g_enterprise
      AND pmdnsite  = g_site
      AND pmdndocno = g_detail_d[l_ac1].pmdldocno 
      AND pmdnseq   = g_detail_d[l_ac1].pmdnseq

   ##取得幣別匯率  
   #LET l_pmdl015 = '' 
   #LET l_pmdl016 = '' 
   #SELECT pmdl015,pmdl016 INTO l_pmdl015,l_pmdl016 
   #  FROM pmdl_t 
   # WHERE pmdlent = g_enterprise     
   #   AND pmdlsite = g_site 
   #   AND pmdldocno = g_detail_d[l_ac1].pmdldocno  
   
   #取得幣別匯率  
   LET l_pmdl015 = ''
   LET l_pmdl016 = ''
   SELECT pmdl015,pmdl016 INTO l_pmdl015,l_pmdl016
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdlsite = g_site
      AND pmdldocno = g_detail_d[l_ac1].pmdldocno
   
   LET l_pmdo.pmdoent   = g_enterprise
   LET l_pmdo.pmdosite  = g_site
   LET l_pmdo.pmdodocno = g_detail_d[l_ac1].pmdldocno    #企業編號  
   LET l_pmdo.pmdoseq   = g_detail_d[l_ac1].pmdnseq      #採購項次 
   LET l_pmdo.pmdoseq1  = '1'                            #項序 
   LET l_pmdo.pmdoseq2  = p_pmdoseq2                     #分批序 
   LET l_pmdo.pmdo001   = l_pmdn.pmdn001                 #料件編號 
   LET l_pmdo.pmdo002   = l_pmdn.pmdn002                 #產品特徵 
   LET l_pmdo.pmdo003   = l_pmdn.pmdn019                 #子件特性 
   LET l_pmdo.pmdo004   = l_pmdn.pmdn006                 #採購單位 
   LET l_pmdo.pmdo005   = l_pmdn.pmdn007                 #採購總數量 
   LET l_pmdo.pmdo006   = p_pmdo006                      #分批採購數量 
   LET l_pmdo.pmdo007   = p_pmdo006                      #折合主件數量 
   LET l_pmdo.pmdo008   = '1'                            #QPA 
   LET l_pmdo.pmdo009   = p_pmdo009                      #交期類型 
   
   LET l_pmdo.pmdo010   = ''                             #收貨時段 
   #收貨時段預設為aimm204的imaf176 
   LET l_imaf176 = ''
   SELECT imaf176 INTO l_imaf176
     FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = g_site
      AND imaf001  = l_pmdo.pmdo001
   IF NOT cl_null(l_imaf176) THEN
      LET l_pmdo.pmdo010 = l_imaf176
   END IF
   
   LET l_pmdo.pmdo011   = p_pmdo011                      #出貨日期 
   LET l_pmdo.pmdo012   = p_pmdo012                      #到廠日期 
   LET l_pmdo.pmdo013   = p_pmdo013                      #到庫日期 
   LET l_pmdo.pmdo014   = 'N'                            #MRP交期凍結 
   LET l_pmdo.pmdo015   = '0'                            #已收貨量 
   LET l_pmdo.pmdo016   = '0'                            #驗退量 
   LET l_pmdo.pmdo017   = '0'                            #倉退換貨量 
   LET l_pmdo.pmdo019   = '0'                            #已入庫量 
   LET l_pmdo.pmdo020   = '0'                            #VMI請款量 
   LET l_pmdo.pmdo021   = '2'                            #交貨狀態  
   LET l_pmdo.pmdo022   = l_pmdn.pmdn015                 #參考價格 
   LET l_pmdo.pmdo023   = l_pmdn.pmdn016                 #稅別 
   LET l_pmdo.pmdo024   = l_pmdn.pmdn017                 #稅率 
   LET l_pmdo.pmdo025   = ''                             #電子採購單號 
   LET l_pmdo.pmdo026   = g_user                         #最近修改人員  
   LET l_pmdo.pmdo027   = cl_get_current()               #最近修改時間 
   LET l_pmdo.pmdo028   = l_pmdn.pmdn008                 #分批參考單位 
   LET l_pmdo.pmdo029   = l_pmdn.pmdn009                 #分批參考數量 
   LET l_pmdo.pmdo030   = l_pmdn.pmdn010                 #分批計價單位 

   LET l_pmdo.pmdo032   = 0                              #分批未稅金額 
   LET l_pmdo.pmdo033   = 0                              #分批含稅金額  
   LET l_pmdo.pmdo034   = 0                              #分批稅額 
   LET l_pmdo.pmdo040   = 0                              #倉退量 

   IF NOT cl_null(l_pmdo.pmdo001) AND NOT cl_null(l_pmdo.pmdo004) AND
      NOT cl_null(l_pmdo.pmdo030) AND NOT cl_null(l_pmdo.pmdo006) THEN
      #依單位做數量轉換  
      CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
           RETURNING l_success,l_pmdn.pmdn011
      IF l_success THEN
         LET l_pmdo.pmdo031 = l_pmdn.pmdn011        #分批計價數量 
      END IF
   END IF 
   
   IF NOT cl_null(l_pmdo.pmdo028) THEN
      CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
           RETURNING l_success,l_pmdo.pmdo029
   END IF

   #分批未稅、含稅、稅額計算          
   #CALL s_axmt500_get_amount(l_xmdd.xmdd027,l_xmdd.xmdd018,l_xmdd.xmdd019,l_xmda015,l_xmda016)
   #  RETURNING l_xmdd.xmdd028,l_xmdd.xmdd029,l_xmdd.xmdd030   
   
   #分批未稅、含稅、稅額計算          
   CALL s_axmt500_get_amount(l_pmdo.pmdodocno,l_pmdo.pmdoseq,
                             l_pmdo.pmdo031,l_pmdo.pmdo022,
                             l_pmdo.pmdo023,l_pmdl015,l_pmdl016)
        RETURNING l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034

   INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
                      pmdo001,pmdo002 ,pmdo003  ,pmdo004,pmdo005 ,pmdo006,
                      pmdo007,pmdo008 ,pmdo009  ,pmdo010,pmdo011 ,pmdo012,
                      pmdo013,pmdo014 ,pmdo015  ,pmdo016,pmdo017 ,pmdo019,
                      pmdo020,pmdo021 ,pmdo022  ,pmdo023,pmdo024 ,pmdo025,
                      pmdo026,pmdo027 ,pmdo028  ,pmdo029,pmdo030 ,pmdo031,
                      pmdo032,pmdo033 ,pmdo034  ,pmdo035,pmdo036 ,pmdo037,
                      pmdo038,pmdo039 ,pmdo040)
               VALUES(l_pmdo.pmdoent ,l_pmdo.pmdosite,l_pmdo.pmdodocno,l_pmdo.pmdoseq,
                      l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdo001  ,l_pmdo.pmdo002,
                      l_pmdo.pmdo003 ,l_pmdo.pmdo004 ,l_pmdo.pmdo005  ,l_pmdo.pmdo006,
                      l_pmdo.pmdo007 ,l_pmdo.pmdo008 ,l_pmdo.pmdo009  ,l_pmdo.pmdo010,
                      l_pmdo.pmdo011 ,l_pmdo.pmdo012 ,l_pmdo.pmdo013  ,l_pmdo.pmdo014,
                      l_pmdo.pmdo015 ,l_pmdo.pmdo016 ,l_pmdo.pmdo017  ,l_pmdo.pmdo019,
                      l_pmdo.pmdo020 ,l_pmdo.pmdo021 ,l_pmdo.pmdo022  ,l_pmdo.pmdo023,
                      l_pmdo.pmdo024 ,l_pmdo.pmdo025 ,l_pmdo.pmdo026  ,l_pmdo.pmdo027,
                      l_pmdo.pmdo028 ,l_pmdo.pmdo029 ,l_pmdo.pmdo030  ,l_pmdo.pmdo031,
                      l_pmdo.pmdo032 ,l_pmdo.pmdo033 ,l_pmdo.pmdo034  ,l_pmdo.pmdo035,
                      l_pmdo.pmdo036 ,l_pmdo.pmdo037 ,l_pmdo.pmdo038  ,l_pmdo.pmdo039,
                      l_pmdo.pmdo040 )
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('pmdoseq2',p_pmdoseq2,'ins pmdo_t',SQLCA.sqlcode,1)
      LET r_success = FALSE
   END IF

   IF NOT cl_null(l_pmdn.pmdn033) AND l_pmdn.pmdn033 <> 0 THEN
      SELECT MAX(pmdoseq1) + 1 INTO l_pmdo.pmdoseq1
        FROM pmdo_t
       WHERE pmdoent   = g_enterprise
         AND pmdodocno = l_pmdo.pmdodocno
         AND pmdoseq   = l_pmdo.pmdoseq
         AND pmdoseq2 = l_pmdo.pmdoseq2    #160523-00018#2 add

      IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
         LET l_pmdo.pmdoseq1 = 1
      END IF

      LET l_pmdo.pmdo003 = '6'     #子件特性 
      LET l_pmdo.pmdo005 = l_pmdo.pmdo005 * (l_pmdn.pmdn033/100)   #採購總量 
      LET l_pmdo.pmdo006 = l_pmdo.pmdo006 * (l_pmdn.pmdn033/100)
      LET l_pmdo.pmdo007 = l_pmdo.pmdo007 * (l_pmdn.pmdn033/100)

      IF NOT cl_null(l_pmdo.pmdo001) AND NOT cl_null(l_pmdo.pmdo004) AND
         NOT cl_null(l_pmdo.pmdo030) AND NOT cl_null(l_pmdo.pmdo006) THEN
         #依單位做數量轉換  
         CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
              RETURNING l_success,l_pmdn.pmdn011
         IF l_success THEN
            LET l_pmdo.pmdo031 = l_pmdn.pmdn011        #分批計價數量 
         END IF
      END IF
      
      #分批未稅、含稅、稅額計算          
      #CALL s_axmt500_get_amount(l_xmdd.xmdd027,l_xmdd.xmdd018,l_xmdd.xmdd019,l_xmda015,l_xmda016)
      #  RETURNING l_xmdd.xmdd028,l_xmdd.xmdd029,l_xmdd.xmdd030    
      
      #分批未稅、含稅、稅額計算          
      CALL s_axmt500_get_amount(l_pmdo.pmdodocno,l_pmdo.pmdoseq,
                                l_pmdo.pmdo031,l_pmdo.pmdo022,
                                l_pmdo.pmdo023,l_pmdl015,l_pmdl016)
           RETURNING l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034

      INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,
                         pmdo001,pmdo002 ,pmdo003  ,pmdo004,pmdo005 ,pmdo006,
                         pmdo007,pmdo008 ,pmdo009  ,pmdo010,pmdo011 ,pmdo012,
                         pmdo013,pmdo014 ,pmdo015  ,pmdo016,pmdo017 ,pmdo019,
                         pmdo020,pmdo021 ,pmdo022  ,pmdo023,pmdo024 ,pmdo025,
                         pmdo026,pmdo027 ,pmdo028  ,pmdo029,pmdo030 ,pmdo031,
                         pmdo032,pmdo033 ,pmdo034  ,pmdo035,pmdo036 ,pmdo037,
                         pmdo038,pmdo039 ,pmdo040 )
                  VALUES(l_pmdo.pmdoent ,l_pmdo.pmdosite,l_pmdo.pmdodocno,l_pmdo.pmdoseq,
                         l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdo001  ,l_pmdo.pmdo002,
                         l_pmdo.pmdo003 ,l_pmdo.pmdo004 ,l_pmdo.pmdo005  ,l_pmdo.pmdo006,
                         l_pmdo.pmdo007 ,l_pmdo.pmdo008 ,l_pmdo.pmdo009  ,l_pmdo.pmdo010,
                         l_pmdo.pmdo011 ,l_pmdo.pmdo012 ,l_pmdo.pmdo013  ,l_pmdo.pmdo014,
                         l_pmdo.pmdo015 ,l_pmdo.pmdo016 ,l_pmdo.pmdo017  ,l_pmdo.pmdo019,
                         l_pmdo.pmdo020 ,l_pmdo.pmdo021 ,l_pmdo.pmdo022  ,l_pmdo.pmdo023,
                         l_pmdo.pmdo024 ,l_pmdo.pmdo025 ,l_pmdo.pmdo026  ,l_pmdo.pmdo027,
                         l_pmdo.pmdo028 ,l_pmdo.pmdo029 ,l_pmdo.pmdo030  ,l_pmdo.pmdo031,
                         l_pmdo.pmdo032 ,l_pmdo.pmdo033 ,l_pmdo.pmdo034  ,l_pmdo.pmdo035,
                         l_pmdo.pmdo036 ,l_pmdo.pmdo037 ,l_pmdo.pmdo038  ,l_pmdo.pmdo039,
                         l_pmdo.pmdo040 )
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('pmdoseq2',p_pmdoseq2,'ins pmdo_t',SQLCA.sqlcode,1)
         LET r_success = FALSE
      END IF
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 多角單據需一併調整
# Memo...........:
# Usage..........: CALL apmp501_aic_upd(p_pmdl031,p_pmdndocno,p_pmdnseq)
#                  RETURNING r_success
# Input parameter: p_pmdl031      多角流程序號
#                : p_pmdndocno    採購單單號
#                : p_pmdnseq      採購單項次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 160523-00018#2 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp501_aic_upd(p_pmdl031,p_pmdndocno,p_pmdnseq)
  DEFINE p_pmdl031     LIKE pmdl_t.pmdl031
  DEFINE p_pmdndocno   LIKE pmdn_t.pmdndocno
  DEFINE p_pmdnseq     LIKE pmdn_t.pmdnseq
  DEFINE l_pmdn024     LIKE pmdn_t.pmdn024
  DEFINE l_sql         STRING
  DEFINE l_aic_site    LIKE pmdn_t.pmdnsite
  DEFINE l_aic_docno   LIKE pmdn_t.pmdndocno
  DEFINE l_aic_seq     LIKE pmdn_t.pmdnseq
  DEFINE l_aic_xmda015 LIKE xmda_t.xmda015   #幣別
  DEFINE l_aic_xmda016 LIKE xmda_t.xmda016   #匯率
  DEFINE l_aic_xmdc015 LIKE xmdc_t.xmdc015   #參考價格
  DEFINE l_aic_xmdc016 LIKE xmdc_t.xmdc016   #稅別
  DEFINE l_aic_xmdc017 LIKE xmdc_t.xmdc017   #稅率  
  #161124-00048#8 mod-S
#  DEFINE l_xmdd        RECORD LIKE xmdd_t.*
#  DEFINE l_pmdo        RECORD LIKE pmdo_t.*
#  DEFINE l_pmdq        RECORD LIKE pmdq_t.*
#  DEFINE l_pmdp        RECORD LIKE pmdp_t.*
#  DEFINE l_sfab        RECORD LIKE sfab_t.*
  DEFINE l_xmdd RECORD  #訂單交期明細檔
          xmddent LIKE xmdd_t.xmddent, #企业编号
          xmddsite LIKE xmdd_t.xmddsite, #营运据点
          xmdddocno LIKE xmdd_t.xmdddocno, #订单单号
          xmddseq LIKE xmdd_t.xmddseq, #项次
          xmddseq1 LIKE xmdd_t.xmddseq1, #项序
          xmddseq2 LIKE xmdd_t.xmddseq2, #分批序
          xmdd001 LIKE xmdd_t.xmdd001, #料件编号
          xmdd002 LIKE xmdd_t.xmdd002, #产品特征
          xmdd003 LIKE xmdd_t.xmdd003, #子件特性
          xmdd004 LIKE xmdd_t.xmdd004, #销售单位
          xmdd005 LIKE xmdd_t.xmdd005, #订购总数量
          xmdd006 LIKE xmdd_t.xmdd006, #分批订购数量
          xmdd007 LIKE xmdd_t.xmdd007, #折合主件数量
          xmdd008 LIKE xmdd_t.xmdd008, #QPA
          xmdd009 LIKE xmdd_t.xmdd009, #交期类型
          xmdd010 LIKE xmdd_t.xmdd010, #出货时段
          xmdd011 LIKE xmdd_t.xmdd011, #约定交货日期
          xmdd012 LIKE xmdd_t.xmdd012, #预计签收日期
          xmdd013 LIKE xmdd_t.xmdd013, #MRP交期冻结
          xmdd014 LIKE xmdd_t.xmdd014, #已出货量
          xmdd015 LIKE xmdd_t.xmdd015, #已销退量
          xmdd016 LIKE xmdd_t.xmdd016, #销退换货数量
          xmdd017 LIKE xmdd_t.xmdd017, #出货状态
          xmdd018 LIKE xmdd_t.xmdd018, #参考价格
          xmdd019 LIKE xmdd_t.xmdd019, #税种
          xmdd020 LIKE xmdd_t.xmdd020, #税率
          xmdd021 LIKE xmdd_t.xmdd021, #电子订购单号
          xmdd022 LIKE xmdd_t.xmdd022, #最近更改人员
          xmdd023 LIKE xmdd_t.xmdd023, #最近更改时间
          xmdd024 LIKE xmdd_t.xmdd024, #分批参考单位
          xmdd025 LIKE xmdd_t.xmdd025, #分批参考数量
          xmdd026 LIKE xmdd_t.xmdd026, #分批计价单位
          xmdd027 LIKE xmdd_t.xmdd027, #分批计价数量
          xmdd028 LIKE xmdd_t.xmdd028, #分批税前金额
          xmdd029 LIKE xmdd_t.xmdd029, #分批含税金额
          xmdd030 LIKE xmdd_t.xmdd030, #分批税额
          xmdd031 LIKE xmdd_t.xmdd031, #已转出通数量
          xmdd032 LIKE xmdd_t.xmdd032, #备置量
          xmdd033 LIKE xmdd_t.xmdd033, #备置原因
          xmdd034 LIKE xmdd_t.xmdd034, #已签退量
          xmdd035 LIKE xmdd_t.xmdd035, #已分配量
          xmdd200 LIKE xmdd_t.xmdd200, #促销方案
          xmdd201 LIKE xmdd_t.xmdd201, #分批包装单位
          xmdd202 LIKE xmdd_t.xmdd202, #分批包装数量
          xmdd203 LIKE xmdd_t.xmdd203, #标准价
          xmdd204 LIKE xmdd_t.xmdd204, #促销价
          xmdd205 LIKE xmdd_t.xmdd205, #交易价
          xmdd206 LIKE xmdd_t.xmdd206, #折价金额
          xmddunit LIKE xmdd_t.xmddunit, #应用组织
          xmdd207 LIKE xmdd_t.xmdd207, #收货网点
          xmdd208 LIKE xmdd_t.xmdd208, #送货地址码
          xmdd209 LIKE xmdd_t.xmdd209, #送货站点
          xmdd210 LIKE xmdd_t.xmdd210, #送货时段
          xmdd211 LIKE xmdd_t.xmdd211, #送货客户
          xmdd212 LIKE xmdd_t.xmdd212, #MRP冻结
          xmdd213 LIKE xmdd_t.xmdd213, #库位/库区
          xmdd214 LIKE xmdd_t.xmdd214, #储位
          xmdd215 LIKE xmdd_t.xmdd215, #批号
          xmdd216 LIKE xmdd_t.xmdd216, #库存锁定等级
          xmdd217 LIKE xmdd_t.xmdd217, #库存余额
          xmdd218 LIKE xmdd_t.xmdd218, #销售渠道
          xmdd219 LIKE xmdd_t.xmdd219, #产品组编号
          xmdd220 LIKE xmdd_t.xmdd220, #销售范围编号
          xmdd221 LIKE xmdd_t.xmdd221, #备注
          xmdd222 LIKE xmdd_t.xmdd222, #办事处
          xmdd223 LIKE xmdd_t.xmdd223, #业务人员
          xmdd224 LIKE xmdd_t.xmdd224, #业务部门
          xmdd225 LIKE xmdd_t.xmdd225, #主合同编号
          xmdd226 LIKE xmdd_t.xmdd226, #经营方式
          xmdd227 LIKE xmdd_t.xmdd227, #结算类型
          xmdd228 LIKE xmdd_t.xmdd228, #结算方式
          xmddorga LIKE xmdd_t.xmddorga, #账务组织
          xmdd229 LIKE xmdd_t.xmdd229, #交易类型
          xmdd230 LIKE xmdd_t.xmdd230, #分批包装销退换货数量
          xmdd036 LIKE xmdd_t.xmdd036, #还量数量
          xmdd037 LIKE xmdd_t.xmdd037, #还量参考数量
          xmdd038 LIKE xmdd_t.xmdd038, #还价数量
          xmdd039 LIKE xmdd_t.xmdd039, #还价参考数量
          xmdd231 LIKE xmdd_t.xmdd231, #库存管理特征
          xmdd040 LIKE xmdd_t.xmdd040  #BOM特性
   END RECORD
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企业编号
          pmdosite LIKE pmdo_t.pmdosite, #营运据点
          pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
          pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件编号
          pmdo002 LIKE pmdo_t.pmdo002, #产品特征
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #采购单位
          pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
          pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
          pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期类型
          pmdo010 LIKE pmdo_t.pmdo010, #收货时段
          pmdo011 LIKE pmdo_t.pmdo011, #出货日期
          pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
          pmdo013 LIKE pmdo_t.pmdo013, #到库日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
          pmdo015 LIKE pmdo_t.pmdo015, #已收货量
          pmdo016 LIKE pmdo_t.pmdo016, #验退量
          pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
          pmdo019 LIKE pmdo_t.pmdo019, #已入库量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
          pmdo021 LIKE pmdo_t.pmdo021, #交货状态
          pmdo022 LIKE pmdo_t.pmdo022, #参考价格
          pmdo023 LIKE pmdo_t.pmdo023, #税种
          pmdo024 LIKE pmdo_t.pmdo024, #税率
          pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
          pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
          pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
          pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
          pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
          pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
          pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
          pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
          pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
          pmdo034 LIKE pmdo_t.pmdo034, #分批税额
          pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
          pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
          pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
          pmdo038 LIKE pmdo_t.pmdo038, #初始项序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #仓退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
          pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
          pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
          pmdo041 LIKE pmdo_t.pmdo041, #还料数量
          pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
          pmdo043 LIKE pmdo_t.pmdo043, #还价数量
          pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
   END RECORD
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企业编号
          pmdqsite LIKE pmdq_t.pmdqsite, #营运据点
          pmdqdocno LIKE pmdq_t.pmdqdocno, #采购单号
          pmdqseq LIKE pmdq_t.pmdqseq, #采购项次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批数量
          pmdq003 LIKE pmdq_t.pmdq003, #交货日期
          pmdq004 LIKE pmdq_t.pmdq004, #到厂日期
          pmdq005 LIKE pmdq_t.pmdq005, #到库日期
          pmdq006 LIKE pmdq_t.pmdq006, #收货时段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP冻结否
          pmdq008 LIKE pmdq_t.pmdq008, #交期类型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包装单位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包装数量
          pmdq900 LIKE pmdq_t.pmdq900, #保留字段str
          pmdq999 LIKE pmdq_t.pmdq999  #保留字段end
   END RECORD
   DEFINE l_pmdp RECORD  #採購關聯單據明細檔
          pmdpent LIKE pmdp_t.pmdpent, #企业编号
          pmdpsite LIKE pmdp_t.pmdpsite, #营运据点
          pmdpdocno LIKE pmdp_t.pmdpdocno, #采购单号
          pmdpseq LIKE pmdp_t.pmdpseq, #采购项次
          pmdpseq1 LIKE pmdp_t.pmdpseq1, #项序
          pmdp001 LIKE pmdp_t.pmdp001, #料件编号
          pmdp002 LIKE pmdp_t.pmdp002, #产品特征
          pmdp003 LIKE pmdp_t.pmdp003, #来源单号
          pmdp004 LIKE pmdp_t.pmdp004, #来源项次
          pmdp005 LIKE pmdp_t.pmdp005, #来源项序
          pmdp006 LIKE pmdp_t.pmdp006, #来源分批序
          pmdp007 LIKE pmdp_t.pmdp007, #来源料号
          pmdp008 LIKE pmdp_t.pmdp008, #来源产品特征
          pmdp009 LIKE pmdp_t.pmdp009, #来源作业编号
          pmdp010 LIKE pmdp_t.pmdp010, #来源作业序
          pmdp011 LIKE pmdp_t.pmdp011, #来源BOM特性
          pmdp012 LIKE pmdp_t.pmdp012, #来源生产控制组
          pmdp021 LIKE pmdp_t.pmdp021, #冲销顺序
          pmdp022 LIKE pmdp_t.pmdp022, #需求单位
          pmdp023 LIKE pmdp_t.pmdp023, #需求数量
          pmdp024 LIKE pmdp_t.pmdp024, #折合采购量
          pmdp025 LIKE pmdp_t.pmdp025, #已收货量
          pmdp026 LIKE pmdp_t.pmdp026, #已入库量
          pmdp900 LIKE pmdp_t.pmdp900, #保留字段str
          pmdp999 LIKE pmdp_t.pmdp999  #保留字段end
   END RECORD
   DEFINE l_sfab RECORD  #工單來源檔
          sfabent LIKE sfab_t.sfabent, #企业编号
          sfabsite LIKE sfab_t.sfabsite, #营运据点
          sfabdocno LIKE sfab_t.sfabdocno, #单号
          sfab001 LIKE sfab_t.sfab001, #来源
          sfab002 LIKE sfab_t.sfab002, #来源单号
          sfab003 LIKE sfab_t.sfab003, #来源项次
          sfab004 LIKE sfab_t.sfab004, #来源项序
          sfab005 LIKE sfab_t.sfab005, #分批序
          sfab006 LIKE sfab_t.sfab006, #分配优先序
          sfab007 LIKE sfab_t.sfab007, #本次转开工单量
          sfabseq LIKE sfab_t.sfabseq  #项次
   END RECORD
  #161124-00048#8 mod-E
  DEFINE l_pmdl005     LIKE pmdl_t.pmdl005     #採購性質
  DEFINE l_pmdl008     LIKE pmdl_t.pmdl008     #來源單號
  DEFINE l_wo_docno    LIKE sfaa_t.sfaadocno   #工單單號
  DEFINE l_cnt         LIKE type_t.num5
  DEFINE r_success     LIKE type_t.num5
  
  LET r_success = TRUE
  

  LET l_pmdn024 = ''
  SELECT pmdn024 INTO l_pmdn024
    FROM pmdn_t
   WHERE pmdnent = g_enterprise
     AND pmdndocno = p_pmdndocno
     AND pmdnseq = p_pmdnseq
     
  LET l_sql = "SELECT pmdqseq2,pmdq002,pmdq003,pmdq004,pmdq005, ",
              "        pmdq006,pmdq007,pmdq008 FROM pmdq_t ",
              " WHERE pmdqent = ",g_enterprise,
              "   AND pmdqdocno = '",p_pmdndocno,"'",
              "   AND pmdqseq = '",p_pmdnseq,"'"
  PREPARE apmp501_aic_pre FROM l_sql
  DECLARE apmp501_aic_cs CURSOR FOR apmp501_aic_pre     


  LET l_sql = " DELETE FROM ( ",
              "        SELECT 1 FROM xmdd_t ",
              "         WHERE xmddent = ",g_enterprise,
              "           AND xmdddocno = ? AND xmddseq = ? ",
              "           AND NOT EXISTS (SELECT 1 FROM pmdo_t  ",
              "                            WHERE pmdoent = xmddent ",
              "                              AND pmdodocno = '",p_pmdndocno,"' ",
              "                              AND pmdoseq = '",p_pmdnseq,"' ",
              "                              AND pmdoseq1 = xmddseq1 ",
              "                              AND pmdoseq2 = xmddseq2)",
              "              ) "  
  PREPARE apmp501_del_pre FROM l_sql   
  
  LET g_sql = "SELECT pmdoseq,pmdoseq1,pmdoseq2,",
              "       pmdo001,pmdo002,pmdo003,pmdo004,pmdo005,",
              "       pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,",
              "       pmdo011,pmdo013,",
              "       pmdo022,",
              "       pmdo028,pmdo029,pmdo030,",
              "       pmdo031,pmdo032,pmdo033,pmdo034",
              "  FROM pmdo_t",
              " WHERE pmdoent = ",g_enterprise,
              "   AND pmdodocno = '",p_pmdndocno,"'",
              "   AND pmdoseq = '",p_pmdnseq,"'"
              
  PREPARE apmp501_aic_pre1 FROM g_sql
  DECLARE apmp501_aic_cs1 CURSOR FOR apmp501_aic_pre1


#==訂單調整==     
  DECLARE apmp501_aic_cr CURSOR FOR
   SELECT xmdcsite,xmdcdocno,xmdcseq
    FROM xmda_t,xmdc_t
   WHERE xmdaent= xmdcent AND xmdadocno= xmdcdocno
      AND xmdaent = g_enterprise      
      AND xmda031 = p_pmdl031
      AND xmdcseq = p_pmdnseq
  FOREACH apmp501_aic_cr INTO l_aic_site,l_aic_docno,l_aic_seq
     #更新多交期  
     UPDATE xmdc_t
        SET xmdc024 = l_pmdn024
      WHERE xmdcent = g_enterprise
        AND xmdcdocno = l_aic_docno
        AND xmdcseq = l_aic_seq        
        
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('pmdndocno',l_aic_docno,'upd xmdc_t',SQLCA.sqlcode,1)
         LET r_success = FALSE
         RETURN r_success
      END IF
     #更新交期匯總檔pmdq_t
     DELETE FROM xmdf_t
      WHERE xmdfent   = g_enterprise
        AND xmdfdocno = l_aic_docno
        AND xmdfseq   = l_aic_seq
     IF SQLCA.sqlcode THEN
        CALL cl_errmsg('pmdndocno',l_aic_docno,'del xmdf_t',SQLCA.sqlcode,1)
        LET r_success = FALSE
        RETURN r_success        
     END IF
     FOREACH apmp501_aic_cs INTO l_pmdq.pmdqseq2,l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005, 
                                   l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008 
  
     
        INSERT INTO xmdf_t (xmdfent,xmdfsite,xmdfdocno,xmdfseq,xmdfseq2, 
                            xmdf002,xmdf003,xmdf004,xmdf005,xmdf006,xmdf007) 
           VALUES (g_enterprise,l_aic_site,l_aic_docno,l_aic_seq,l_pmdq.pmdqseq2,
                   l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008)      
         
        IF SQLCA.sqlcode THEN
           CALL cl_errmsg('pmdndocno',l_aic_docno,'ins xmdf_t',SQLCA.sqlcode,1)
           LET r_success = FALSE
           RETURN r_success        
        END IF        
     END FOREACH
     #先刪除已不存在xmdd
     EXECUTE apmp501_del_pre USING l_aic_docno,l_aic_seq
     IF SQLCA.sqlcode THEN
        CALL cl_errmsg('pmdndocno',l_aic_docno,'del xmxdd_t',SQLCA.sqlcode,1)
        LET r_success = FALSE
        RETURN r_success        
     END IF 
     #刪除工單的工單來源資料sfab_t
     LET l_wo_docno = ''     
     SELECT sfaadocno INTO l_wo_docno 
       FROM sfaa_t
      WHERE sfaaent = g_enterprise
        AND sfaa006 = l_aic_docno 
        AND sfaa007 = l_aic_seq 
     IF NOT cl_null(l_wo_docno) THEN                    
        DELETE FROM sfab_t
         WHERE sfabent = g_enterprise
           AND sfabdocno = l_wo_docno
        IF SQLCA.sqlcode THEN
           CALL cl_errmsg('pmdndocno',l_aic_docno,'del sfab_t',SQLCA.sqlcode,1)
           LET r_success = FALSE
           RETURN r_success 
        END IF           
     END IF
     #抓取幣別
     SELECT xmda015,xmda016,xmdc015,xmdc016,xmdc017
       INTO l_aic_xmda015,l_aic_xmda016,l_aic_xmdc015,l_aic_xmdc016,l_aic_xmdc017
       FROM xmda_t,xmdc_t
      WHERE xmdaent = xmdcent AND xmdadocno = xmdcdocno
        AND xmdcent = g_enterprise
        AND xmdcdocno = l_aic_docno
        AND xmdcseq = l_aic_seq
     INITIALIZE l_pmdo.* TO NULL 
     
     FOREACH apmp501_aic_cs1 INTO l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                  l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,
                                  l_pmdo.pmdo006,l_pmdo.pmdo007,l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,
                                  l_pmdo.pmdo011,l_pmdo.pmdo013,
                                  l_pmdo.pmdo022,
                                  l_pmdo.pmdo028,l_pmdo.pmdo029,l_pmdo.pmdo030,
                                  l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034
       #更新交期明細檔xmdd_t、工單來源檔sfab_t 
       INITIALIZE l_xmdd.* TO NULL 
       
       LET l_xmdd.xmdd018 = l_aic_xmdc015  #價格
       LET l_xmdd.xmdd019 = l_aic_xmdc016  #稅別
       LET l_xmdd.xmdd020 = l_aic_xmdc017  #稅別     
 
       #分批未稅、含稅、稅額計算
       LET l_xmdd.xmdd028 = 0
       LET l_xmdd.xmdd029 = 0
       LET l_xmdd.xmdd030 = 0
       CALL s_axmt500_get_amount_2(l_pmdo.pmdo031,l_aic_xmdc015,l_aic_xmdc016,l_aic_xmda015,l_aic_xmda016)
         RETURNING l_xmdd.xmdd028,l_xmdd.xmdd029,l_xmdd.xmdd030  

       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM xmdd_t
        WHERE xmddent = g_enterprise
          AND xmdddocno = l_aic_docno
          AND xmddseq = l_aic_seq
          AND xmddseq1 = l_pmdo.pmdoseq1
          AND xmddseq2 = l_pmdo.pmdoseq2
       IF l_cnt > 0 THEN
          UPDATE xmdd_t SET xmdd006 = l_pmdo.pmdo006,             #分批订购数量
                            xmdd009 = l_pmdo.pmdo009,             #交期类型
                            xmdd011 = l_pmdo.pmdo011,             #约定交货日期
                            xmdd012 = l_pmdo.pmdo013,             #预计签收日期
                            xmdd022 = g_user,                     #最近更改人员
                            xmdd023 = g_today,                    #最近更改时间      
                            xmdd027 = l_pmdo.pmdo031,             #分批计价数量
                            xmdd028 = l_xmdd.xmdd028,             #分批税前金额
                            xmdd029 = l_xmdd.xmdd029,             #分批含税金额
                            xmdd030 = l_xmdd.xmdd030              #分批税额
          WHERE xmddent   = g_enterprise
            AND xmdddocno = l_aic_docno
            AND xmddseq   = l_aic_seq
            AND xmddseq1  = l_pmdo.pmdoseq1
            AND xmddseq2  = l_pmdo.pmdoseq2
          IF SQLCA.sqlcode THEN
             CALL cl_errmsg('pmdndocno',l_aic_docno,'upd xmdd_t',SQLCA.sqlcode,1)
             LET r_success = FALSE
             RETURN r_success 
          END IF         
       ELSE
          LET l_xmdd.xmddsite = l_aic_site
          LET l_xmdd.xmdddocno = l_aic_docno
          LET l_xmdd.xmddseq = l_aic_seq
          LET l_xmdd.xmddseq1 = l_pmdo.pmdoseq1
          LET l_xmdd.xmddseq2 = l_pmdo.pmdoseq2
          LET l_xmdd.xmdd001 = l_pmdo.pmdo001
          LET l_xmdd.xmdd002 = l_pmdo.pmdo002
          LET l_xmdd.xmdd003 = l_pmdo.pmdo003
          LET l_xmdd.xmdd004 = l_pmdo.pmdo004
          LET l_xmdd.xmdd005 = l_pmdo.pmdo005
          LET l_xmdd.xmdd006 = l_pmdo.pmdo006
          LET l_xmdd.xmdd007 = l_pmdo.pmdo007
          LET l_xmdd.xmdd008 = l_pmdo.pmdo008
          LET l_xmdd.xmdd009 = l_pmdo.pmdo009
          LET l_xmdd.xmdd010 = l_pmdo.pmdo010
          LET l_xmdd.xmdd011 = l_pmdo.pmdo011
          LET l_xmdd.xmdd012 = l_pmdo.pmdo013
          LET l_xmdd.xmdd013 = 'N'                   
          LET l_xmdd.xmdd024 = l_pmdo.pmdo028
          LET l_xmdd.xmdd025 = l_pmdo.pmdo029
          LET l_xmdd.xmdd026 = l_pmdo.pmdo030
          LET l_xmdd.xmdd027 = l_pmdo.pmdo031
          LET l_xmdd.xmdd014 = 0  #已出貨數量
          LET l_xmdd.xmdd015 = 0  #已銷退數量          
          LET l_xmdd.xmdd016 = 0  #銷退換貨數量       
          LET l_xmdd.xmdd031 = 0  #已轉出通數量
          LET l_xmdd.xmdd032 = 0  #備置量
          LET l_xmdd.xmdd034 = 0  #已簽退量
          LET l_xmdd.xmdd035 = 0  #已分配量
        
          
          INSERT INTO xmdd_t (xmddent,xmddsite,
                              xmdddocno,xmddseq,xmddseq1,xmddseq2,
                              xmdd001,xmdd002,xmdd003,xmdd004,xmdd005,
                              xmdd006,xmdd007,xmdd008,xmdd009,xmdd010,
                              xmdd011,xmdd012,xmdd013,xmdd014,xmdd015,
                              xmdd016,xmdd017,xmdd018,xmdd019,xmdd020,
                              xmdd021,xmdd022,xmdd023,xmdd024,xmdd025,
                              xmdd026,xmdd027,xmdd028,xmdd029,xmdd030,
                              xmdd031,xmdd032,xmdd033,xmdd034,xmdd035)
          VALUES (g_enterprise,l_xmdd.xmddsite,
                  l_xmdd.xmdddocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,l_xmdd.xmddseq2,
                  l_xmdd.xmdd001,l_xmdd.xmdd002,l_xmdd.xmdd003,l_xmdd.xmdd004,l_xmdd.xmdd005,
                  l_xmdd.xmdd006,l_xmdd.xmdd007,l_xmdd.xmdd008,l_xmdd.xmdd009,l_xmdd.xmdd010,
                  l_xmdd.xmdd011,l_xmdd.xmdd012,l_xmdd.xmdd013,l_xmdd.xmdd014,l_xmdd.xmdd015,
                  l_xmdd.xmdd016,l_xmdd.xmdd017,l_xmdd.xmdd018,l_xmdd.xmdd019,l_xmdd.xmdd020,
                  l_xmdd.xmdd021,l_xmdd.xmdd022,l_xmdd.xmdd023,l_xmdd.xmdd024,l_xmdd.xmdd025,
                  l_xmdd.xmdd026,l_xmdd.xmdd027,l_xmdd.xmdd028,l_xmdd.xmdd029,l_xmdd.xmdd030,
                  l_xmdd.xmdd031,l_xmdd.xmdd032,l_xmdd.xmdd033,l_xmdd.xmdd034,l_xmdd.xmdd035)
                  
          IF SQLCA.sqlcode THEN
             CALL cl_errmsg('pmdndocno',l_aic_docno,'ins xmdd_t',SQLCA.sqlcode,1)
             LET r_success = FALSE
             RETURN r_success 
          END IF
       END IF
       IF NOT cl_null(l_wo_docno) THEN
          #塞sfab_t工單來源檔
          INITIALIZE l_sfab.* TO NULL
          LET l_sfab.sfabsite = l_aic_site
          LET l_sfab.sfabdocno = l_wo_docno
          LET l_sfab.sfab001 = '2'
          LET l_sfab.sfab002 = l_aic_docno            
          LET l_sfab.sfab003 = l_aic_seq
          LET l_sfab.sfab004 = l_pmdo.pmdoseq1
          LET l_sfab.sfab005 = l_pmdo.pmdoseq2       
          LET l_sfab.sfab006 = 10
          LET l_sfab.sfab007 = l_pmdo.pmdo006
            
          SELECT MAX(sfabseq)+1 INTO l_sfab.sfabseq
            FROM sfab_t
           WHERE sfabent = g_enterprise
             AND sfabdocno = l_wo_docno            
          IF cl_null(l_sfab.sfabseq) THEN
             LET l_sfab.sfabseq = 1
          END IF
            
          INSERT INTO sfab_t(sfabent,sfabsite,sfabdocno,sfabseq,
                             sfab001,sfab002,sfab003,sfab004,sfab005,
                             sfab006,sfab007)
           VALUES (g_enterprise,l_sfab.sfabsite,l_sfab.sfabdocno,l_sfab.sfabseq,
                   l_sfab.sfab001,l_sfab.sfab002,l_sfab.sfab003,l_sfab.sfab004,l_sfab.sfab005,
                   l_sfab.sfab006,l_sfab.sfab007)
            
          IF SQLCA.sqlcode THEN
             CALL cl_errmsg('pmdndocno',l_aic_docno,'ins sfab_t',SQLCA.sqlcode,1)
             LET r_success = FALSE
             RETURN r_success 
          END IF         
       END IF               
     END FOREACH

  END FOREACH 

#==採購單調整==
  LET l_sql = " DELETE FROM ( ",
              "        SELECT 1 FROM pmdo_t a ",
              "         WHERE a.pmdoent = ",g_enterprise,
              "           AND a.pmdodocno = ? AND a.pmdoseq = ? ",
              "           AND NOT EXISTS (SELECT 1 FROM pmdo_t  ",
              "                            WHERE pmdodocno = '",p_pmdndocno,"' ",
              "                              AND pmdoseq = '",p_pmdnseq,"' ",
              "                              AND a.pmdoseq1 = pmdoseq1 ",
              "                              AND a.pmdoseq2 = pmdoseq2)",
              "              ) "  
  PREPARE apmp501_del_pre2 FROM l_sql   

  LET l_sql = " DELETE FROM ( " ,
              "        SELECT 1 FROM pmdp_t ",
              "         WHERE pmdpent = ",g_enterprise,
              "           AND pmdpdocno = ? AND pmdpseq = ? ",
              "           AND NOT EXISTS (SELECT 1 FROM xmdd_t ",
              "                            WHERE xmddent = pmdpent ",
              "                              AND xmdddocno = ? ",
              "                              AND xmddseq = '",p_pmdnseq,"' ",
              "                              AND xmdddocno = pmdp003 ",
              "                              AND xmddseq = pmdp004 ",
              "                              AND xmddseq1 = pmdp005 ",
              "                              AND xmddseq2 = pmdp006) ",
              "              ) "
  PREPARE apmp501_del_pre3 FROM l_sql  

  DECLARE apmp501_aic_cr1 CURSOR FOR
   SELECT pmdnsite,pmdndocno,pmdnseq
    FROM pmdl_t,pmdn_t
   WHERE pmdlent= pmdnent AND pmdldocno= pmdndocno
      AND pmdlent = g_enterprise
      AND pmdlsite IN (SELECT icab003 FROM icab_t WHERE icabent = pmdlent AND icab001 = pmdl051 AND icab002 <> 0)
      AND pmdl031 = p_pmdl031
      AND pmdnseq = p_pmdnseq
  FOREACH apmp501_aic_cr1 INTO l_aic_site,l_aic_docno,l_aic_seq
     #更新多交期
     UPDATE pmdn_t
        SET pmdn024 = l_pmdn024
      WHERE pmdnent = g_enterprise
        AND pmdndocno = l_aic_docno
        AND pmdnseq = l_aic_seq
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('pmdndocno',l_aic_docno,'upd pmdn_t',SQLCA.sqlcode,1)
         LET r_success = FALSE
         RETURN r_success
      END IF
     #更新交期匯總檔pmdq_t
     DELETE FROM pmdq_t
      WHERE pmdqent   = g_enterprise
        AND pmdqdocno = l_aic_docno
        AND pmdqseq   = l_aic_seq
     IF SQLCA.sqlcode THEN
        CALL cl_errmsg('pmdndocno',l_aic_docno,'del pmdq_t',SQLCA.sqlcode,1)
        LET r_success = FALSE
        RETURN r_success
     END IF          
     FOREACH apmp501_aic_cs INTO l_pmdq.pmdqseq2,l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,
                                 l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008       

        INSERT INTO pmdq_t (pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2, 
                            pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,pmdq007,pmdq008) 
            VALUES (g_enterprise,l_aic_site,l_aic_docno,l_aic_seq,l_pmdq.pmdqseq2,
                    l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008) 
        
        IF SQLCA.sqlcode THEN
           CALL cl_errmsg('pmdndocno',l_aic_docno,'ins pmdq_t',SQLCA.sqlcode,1)
           LET r_success = FALSE
           RETURN r_success
        END IF       
     END FOREACH      
     
     #先刪除已不存在交期明細pmdo_t
     EXECUTE apmp501_del_pre2 USING l_aic_docno,l_aic_seq
      
     IF SQLCA.sqlcode THEN
        CALL cl_errmsg('pmdndocno',l_aic_docno,'del pmdo_t',SQLCA.sqlcode,1)
        LET r_success = FALSE
        RETURN r_success
     END IF  
     
     #先刪除已不存在關聯單據明細pmdp_t
     #只需調整一般採購單，委外採購單的關聯單據來源不工單，所以不需調整
     LET l_pmdl005 = ''
     LET l_pmdl008 = ''
     SELECT pmdl005,pmdl008 INTO l_pmdl005,l_pmdl008
       FROM pmdl_t 
      WHERE pmdlent = g_enterprise
        AND pmdldocno = l_aic_docno
        
     IF l_pmdl005 = '1' THEN       #一般採購
        
        EXECUTE apmp501_del_pre3 USING l_aic_docno,l_aic_seq,l_pmdl008
        
        IF SQLCA.sqlcode THEN
           CALL cl_errmsg('pmdndocno',l_aic_docno,'del pmdp_t',SQLCA.sqlcode,1)
           LET r_success = FALSE
           RETURN r_success
        END IF          
     END IF  
     #抓取幣別
     SELECT pmdl015,pmdl016,pmdn015,pmdn016,pmdn017            
       INTO l_aic_xmda015,l_aic_xmda016,l_aic_xmdc015,l_aic_xmdc016,l_aic_xmdc017            
       FROM pmdl_t,pmdn_t
      WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
        AND pmdnent = g_enterprise
        AND pmdndocno = l_aic_docno
        AND pmdnseq = l_aic_seq
     FOREACH apmp501_aic_cs1 INTO l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                                  l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,
                                  l_pmdo.pmdo006,l_pmdo.pmdo007,l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,
                                  l_pmdo.pmdo011,l_pmdo.pmdo013,
                                  l_pmdo.pmdo022,
                                  l_pmdo.pmdo028,l_pmdo.pmdo029,l_pmdo.pmdo030,
                                  l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034
       LET l_pmdo.pmdo032 = 0
       LET l_pmdo.pmdo033 = 0
       LET l_pmdo.pmdo034 = 0                               
       CALL s_axmt500_get_amount_2(l_pmdo.pmdo031,l_aic_xmdc015,l_aic_xmdc016,l_aic_xmda015,l_aic_xmda016)
         RETURNING l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034       
       
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM pmdo_t
        WHERE pmdoent = g_enterprise
          AND pmdodocno = l_aic_docno
          AND pmdoseq = l_aic_seq
          AND pmdoseq1 = l_pmdo.pmdoseq1
          AND pmdoseq2 = l_pmdo.pmdoseq2
          
       IF l_cnt > 0 THEN             
          UPDATE pmdo_t SET pmdo006 = l_pmdo.pmdo006,             
                            pmdo009 = l_pmdo.pmdo009,                             
                            pmdo026 = g_user,                     
                            pmdo027 = g_today,                         
                            pmdo031 = l_pmdo.pmdo031,             
                            pmdo032 = l_pmdo.pmdo032,             
                            pmdo033 = l_pmdo.pmdo033,             
                            pmdo034 = l_pmdo.pmdo034              
           WHERE pmdoent   = g_enterprise
             AND pmdodocno = l_aic_docno
             AND pmdoseq   = l_aic_seq
             AND pmdoseq1  = l_pmdo.pmdoseq1
             AND pmdoseq2  = l_pmdo.pmdoseq2
          IF SQLCA.sqlcode THEN
             CALL cl_errmsg('pmdndocno',l_aic_docno,'upd pmdo_t',SQLCA.sqlcode,1)
             LET r_success = FALSE
             RETURN r_success
          END IF
       ELSE
          LET l_pmdo.pmdo014 = 'N' #MRP交期凍結
          LET l_pmdo.pmdo015 = 0   #已收貨量      
          LET l_pmdo.pmdo016 = 0   #驗退量        
          LET l_pmdo.pmdo017 = 0   #倉退換貨量       
          LET l_pmdo.pmdo019 = 0   #已入庫量       
          LET l_pmdo.pmdo040 = 0   #倉退量

          INSERT INTO pmdo_t (pmdoent,pmdosite,pmdodocno,
                              pmdoseq,pmdoseq1,pmdoseq2,
                              pmdo001,pmdo002,pmdo003,pmdo004,pmdo005,
                              pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,
                              pmdo011,pmdo012,pmdo013,pmdo014,pmdo015,
                              pmdo016,pmdo017,pmdo019,pmdo020,
                              pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                              pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
                              pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,
                              pmdo036,pmdo037,pmdo038,pmdo039,pmdo040)
          VALUES (g_enterprise,l_aic_site,l_aic_docno,
                  l_aic_seq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,
                  l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,
                  l_pmdo.pmdo006,l_pmdo.pmdo007,l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,
                  l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,l_pmdo.pmdo015,
                  l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,
                  l_pmdo.pmdo021,l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,l_pmdo.pmdo025,
                  l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,l_pmdo.pmdo029,l_pmdo.pmdo030,
                  l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo035,
                  l_pmdo.pmdo036,l_pmdo.pmdo037,l_pmdo.pmdo038,l_pmdo.pmdo039,l_pmdo.pmdo040)
          IF SQLCA.sqlcode THEN    
             CALL cl_errmsg('pmdndocno',l_aic_docno,'ins pmdo_t',SQLCA.sqlcode,1)
             LET r_success = FALSE
             RETURN r_success
          END IF       
       END IF
        #更新關聯單據明細 
       IF l_pmdl005 = '1' AND NOT cl_null(l_pmdl008) THEN
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt
            FROM pmdp_t
           WHERE pmdpent = g_enterprise
             AND pmdpdocno = l_aic_docno
             AND pmdpseq = l_aic_seq
             AND pmdp003 = l_pmdl008
             AND pmdp004 = l_pmdo.pmdoseq
             AND pmdp005 = l_pmdo.pmdoseq1
             AND pmdp006 = l_pmdo.pmdoseq2
             
          IF l_cnt > 0 THEN       
             UPDATE pmdp_t
                SET pmdp023 = l_pmdo.pmdo006,
                    pmdp024 = l_pmdo.pmdo006              
              WHERE pmdpent = g_enterprise
                AND pmdpdocno = l_aic_docno
                AND pmdpseq = l_aic_seq
                AND pmdp003 = l_pmdl008
                AND pmdp004 = l_pmdo.pmdoseq
                 AND pmdp005 = l_pmdo.pmdoseq1
                AND pmdp006 = l_pmdo.pmdoseq2 
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL 
                LET g_errparam.extend = "upd pmdp_t" 
                LET g_errparam.code   = SQLCA.sqlcode 
                LET g_errparam.popup  = TRUE 
                LET g_errparam.coll_vals[1] = l_pmdo.pmdoseq1
                LET g_errparam.coll_vals[2] = l_pmdo.pmdoseq2
                CALL cl_err()
                LET r_success = FALSE
                RETURN r_success
             END IF              
          ELSE        
             SELECT MAX(pmdpseq1)+1 INTO l_pmdp.pmdpseq1 FROM pmdp_t  
              WHERE pmdpent = g_enterprise 
                AND pmdpdocno = l_aic_docno
                AND pmdpseq = l_aic_seq
             IF cl_null(l_pmdp.pmdpseq1) OR l_pmdp.pmdpseq1 = 0 THEN
                LET l_pmdp.pmdpseq1 = 1
             END IF                                
             LET l_pmdp.pmdp001 = l_pmdo.pmdo001        
             LET l_pmdp.pmdp002 = l_pmdo.pmdo002
             LET l_pmdp.pmdp003 = l_pmdl008
             LET l_pmdp.pmdp004 = l_pmdo.pmdoseq
             LET l_pmdp.pmdp005 = l_pmdo.pmdoseq1
             LET l_pmdp.pmdp006 = l_pmdo.pmdoseq2   
             LET l_pmdp.pmdp007 = l_pmdo.pmdo001       
             LET l_pmdp.pmdp008 = l_pmdo.pmdo002 
             #沖銷順序 
             SELECT MAX(pmdp021)+1 INTO l_pmdp.pmdp021 FROM pmdp_t
              WHERE pmdpent = g_enterprise 
                AND pmdpdocno = l_aic_docno
                AND pmdpseq = l_aic.seq
             IF cl_null(l_pmdp.pmdp021) OR l_pmdp.pmdp021 = 0 THEN
                LET l_pmdp.pmdp021 = 1
             END IF         
             LET l_pmdp.pmdp022 = l_pmdo.pmdo004        
             LET l_pmdp.pmdp023 = l_pmdo.pmdo006 
             #折合採購量
             LET l_pmdp.pmdp024 = l_pmdp.pmdp023
                
             INSERT INTO pmdp_t (pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,
                                 pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,
                                 pmdp006,pmdp007,pmdp008,pmdp021,pmdp022,
                                 pmdp023,pmdp024) 
               VALUES (g_enterprise,l_aic_site,l_aic_docno,l_aic_seq,l_pmdp.pmdpseq1,
                       l_pmdp.pmdp001,l_pmdp.pmdp002,l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp005,
                       l_pmdp.pmdp006,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp021,l_pmdp.pmdp022,
                       l_pmdp.pmdp023,l_pmdp.pmdp024)
                 
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "INSERT INTO pmdp_t"
                LET g_errparam.code   = SQLCA.sqlcode
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET r_success = FALSE
                EXIT FOREACH 
             END IF         
          END IF   
       END IF         
       
     
     END FOREACH                               

  END FOREACH  
  FREE apmp501_del_pre
  FREE apmp501_del_pre2
  FREE apmp501_del_pre3 
  
  RETURN r_success

END FUNCTION

#end add-point
 
{</section>}
 
