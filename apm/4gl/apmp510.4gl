#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0017(2017-02-15 14:54:47), PR版次:0017(2017-02-15 15:58:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000258
#+ Filename...: apmp510
#+ Description: 採購單結案/留置作業
#+ Creator....: 02040(2014-05-02 16:58:36)
#+ Modifier...: 01258 -SD/PR- 01258
 
{</section>}
 
{<section id="apmp510.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151111-00018#2  15/11/11 By Shiun   回寫採購單時，一併回寫交期明細裡的異動人員、時間
#160523-00018#4  16/05/31 By Polly   增加多角控卡；結案/取消結案需一併調整多角單據
#160816-00001#7  16/08/17 By 08742   抓取理由碼改CALL sub
#161117-00025#1  16/11/17 By wuxja   排除已作废的单据
#161207-00033#20 16/12/21 By lixh    一次性交易對象顯示說明，所有的客戶/供應商欄位都應該處理
#170111-00026#3  17/01/11 By 08993   搜尋時，單頭和單身沒有串企業編號
#161115-00038#1  17/01/16 By xujing  与SA确认后,apmp510 不管后续 是否有单据(收货单,入库单),都可以做结案
#170213-00003#1  17/02/13 By wuxja   SQL缺少ENT条件，需增加
#170215-00009#1  17/02/15 By wuxja   新增备注栏位
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
          sel            LIKE   type_t.chr1,
          closed         LIKE   xmdc_t.xmdc053,
          closed_desc    LIKE   type_t.chr500,
          pmdldocno      LIKE   pmdl_t.pmdldocno,
          pmdldocdt      LIKE   pmdl_t.pmdldocdt,
          pmdl004        LIKE   pmdl_t.pmdl004,
          pmdl004_desc   LIKE   type_t.chr500,
          pmdl002        LIKE   pmdl_t.pmdl002,
          pmdl002_desc   LIKE   type_t.chr500,
          pmdl003        LIKE   pmdl_t.pmdl003,
          pmdl003_desc   LIKE   type_t.chr500,
          pmdl005        LIKE   pmdl_t.pmdl005,
          pmdl009        LIKE   pmdl_t.pmdl009,
          pmdl009_desc   LIKE   type_t.chr500,
          pmdl010        LIKE   pmdl_t.pmdl010,
          pmdl010_desc   LIKE   type_t.chr500,
          pmdl011        LIKE   pmdl_t.pmdl011,
          pmdl011_desc   LIKE   type_t.chr500,
          pmdl012        LIKE   pmdl_t.pmdl012,
          pmdl013        LIKE   pmdl_t.pmdl013,
          pmdl015        LIKE   pmdl_t.pmdl015,
          pmdl015_desc   LIKE   type_t.chr500,
          pmdl031        LIKE   pmdl_t.pmdl031
          END RECORD
TYPE type_g_pmdn_d RECORD
          sel2           LIKE   type_t.chr1,
          closed2        LIKE   pmdn_t.pmdn051,
          closed2_desc   LIKE   type_t.chr500,
          pmdndocno      LIKE   pmdn_t.pmdndocno,
          pmdnseq        LIKE   pmdn_t.pmdnseq,
          pmdn001        LIKE   pmdn_t.pmdn001,
          pmdn001_desc   LIKE   type_t.chr500,
          imaal004_1     LIKE   type_t.chr80,
          pmdn002        LIKE   pmdn_t.pmdn002,
          pmdn002_desc   LIKE   type_t.chr500,
          pmdn019        LIKE   pmdn_t.pmdn019,
          pmdn004        LIKE   pmdn_t.pmdn004,
          pmdn004_desc   LIKE   type_t.chr500,
          pmdn005        LIKE   pmdn_t.pmdn005,
          pmdn006        LIKE   pmdn_t.pmdn006,
          pmdn006_desc   LIKE   type_t.chr500,
          pmdn007        LIKE   pmdn_t.pmdn007,
          pmdo015_1      LIKE   pmdo_t.pmdo015,
          unpmdo015_1    LIKE   pmdo_t.pmdo015
         ,pmdn050        LIKE   pmdn_t.pmdn050    #170215-00009#1 add
          END RECORD 
TYPE type_g_pmdo_d RECORD
          pmdodocno      LIKE   pmdo_t.pmdodocno,
          pmdoseq        LIKE   pmdo_t.pmdoseq,
          pmdoseq1       LIKE   pmdo_t.pmdoseq1,
          pmdo003        LIKE   pmdo_t.pmdo003,
          pmdo001        LIKE   pmdo_t.pmdo001,
          pmdo001_desc   LIKE   type_t.chr500,
          imaal004_2     LIKE   type_t.chr80,
          pmdo002        LIKE   pmdo_t.pmdo002,
          pmdo002_desc   LIKE   type_t.chr500,          
          pmdo004        LIKE   pmdo_t.pmdo004,
          pmdo004_desc   LIKE   type_t.chr500,
          pmdoseq2       LIKE   pmdo_t.pmdoseq2,
          pmdo006        LIKE   pmdo_t.pmdo006,
          pmdo015        LIKE   pmdo_t.pmdo015,
          pmdo016        LIKE   pmdo_t.pmdo016,
          unpmdo015      LIKE   pmdo_t.pmdo015
          END RECORD
TYPE type_g_pmdm_d RECORD
          pmdmdocno     LIKE    pmdm_t.pmdmdocno,
          pmdm001       LIKE    pmdm_t.pmdm001,          
          pmdm002       LIKE    pmdm_t.pmdm002,
          pmdm002_desc  LIKE    type_t.chr500,
          pmdm003       LIKE    pmdm_t.pmdm003,
          pmdm004       LIKE    pmdm_t.pmdm004,
          pmdm005       LIKE    pmdm_t.pmdm005,
          pmdm006       LIKE    pmdm_t.pmdm006,
          pmdm007       LIKE    pmdm_t.pmdm007,
          pmdm008       LIKE    pmdm_t.pmdm008,
          pmdm009       LIKE    pmdm_t.pmdm009
          END RECORD     
TYPE type_g_pmdt_d RECORD
          pmdtdocno     LIKE    pmdt_t.pmdtdocno,
          pmdtseq       LIKE    pmdt_t.pmdtseq,
          pmdt006       LIKE    pmdt_t.pmdt006,
          pmdt006_desc  LIKE    type_t.chr500,
          imaal004_5    LIKE    type_t.chr80,
          pmdt007       LIKE    pmdt_t.pmdt007,
          pmdt019       LIKE    pmdt_t.pmdt019,
          pmdt019_desc  LIKE    type_t.chr500,
          pmdt020       LIKE    pmdt_t.pmdt020,
          pmdt054       LIKE    pmdt_t.pmdt054,
          pmdt055       LIKE    pmdt_t.pmdt055,
          unpmdt054     LIKE    pmdt_t.pmdt045
         ,pmdt059       LIKE    pmdt_t.pmdt059    #170215-00009#1 add
          END RECORD
TYPE type_g_pmdt3_d RECORD
          pmdtdocno     LIKE    pmdt_t.pmdtdocno,
          pmdtseq       LIKE    pmdt_t.pmdtseq,
          pmdt006       LIKE    pmdt_t.pmdt006,
          pmdt006_desc  LIKE    type_t.chr500,
          imaal004      LIKE    type_t.chr80,
          pmdt007       LIKE    pmdt_t.pmdt007,
          pmdt019       LIKE    pmdt_t.pmdt019,
          pmdt019_desc  LIKE    type_t.chr500,
          pmdt054       LIKE    pmdt_t.pmdt054,          
          pmdt039       LIKE    pmdt_t.pmdt039,
          account       LIKE    pmdt_t.pmdt039,
          unaccount     LIKE    pmdt_t.pmdt039
         ,pmdt059       LIKE    pmdt_t.pmdt059   #170215-00009#1 add
          END RECORD
TYPE type_g_apcc_d RECORD
          apccdocno     LIKE    apcc_t.apccdocno,
          apccseq       LIKE    apcc_t.apccseq,
          apcc001       LIKE    apcc_t.apcc001,
          apcc003       LIKE    apcc_t.apcc003,
          apcc118       LIKE    apcc_t.apcc118,
          apcc119       LIKE    apcc_t.apcc119,
          unapcc119     LIKE    apcc_t.apcc119
          END RECORD
DEFINE g_tmp_d   DYNAMIC ARRAY OF RECORD
            sel2           LIKE   type_t.chr1,
            pmdn049        LIKE   pmdn_t.pmdn049,       #理由碼
            pmdndocno      LIKE   pmdn_t.pmdndocno,
            pmdnseq        LIKE   pmdn_t.pmdnseq,
            pmdn007        LIKE   pmdn_t.pmdn007        #採購數量
           ,pmdl043        LIKE   pmdl_t.pmdl043        #2015/01/22 by stellar add
                 END RECORD
DEFINE g_pmdn_d  DYNAMIC ARRAY OF type_g_pmdn_d
DEFINE g_pmdo_d  DYNAMIC ARRAY OF type_g_pmdo_d
DEFINE g_pmdm_d  DYNAMIC ARRAY OF type_g_pmdm_d
DEFINE g_pmdt_d  DYNAMIC ARRAY OF type_g_pmdt_d
DEFINE g_pmdt3_d  DYNAMIC ARRAY OF type_g_pmdt3_d
DEFINE g_apcc_d  DYNAMIC ARRAY OF type_g_apcc_d
DEFINE g_acc               LIKE gzcb_t.gzcb007
DEFINE g_type              LIKE type_t.chr1               #1時為結案作業；2時為取消結案作業
DEFINE l_ac1               LIKE type_t.num5

DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_detail2_idx       LIKE type_t.num5
DEFINE g_detail2_cnt       LIKE type_t.num5
DEFINE g_detail3_cnt       LIKE type_t.num5
DEFINE g_detail4_cnt       LIKE type_t.num5
DEFINE g_detail5_cnt       LIKE type_t.num5
DEFINE g_detail6_cnt       LIKE type_t.num5
DEFINE g_detail7_cnt       LIKE type_t.num5
DEFINE g_detail_d_t        type_g_detail_d
DEFINE g_pmdn_d_t          type_g_pmdn_d

#2015/01/22 by stellar add ----- (S)
DEFINE g_mode              LIKE type_t.chr1   #異動類型
DEFINE g_mode_o            LIKE type_t.chr1
#2015/01/22 by stellar add ----- (E)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp510.main" >}
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
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
   CALL apmp510_create_preview_tmp()
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#7 mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#7  Add 
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp510 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmp510_init()   
 
      #進入選單 Menu (="N")
      CALL apmp510_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp510
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmp510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   IF g_type = '2' THEN
      CALL cl_set_comp_visible("b_closed,b_closed_desc,b_closed2,b_closed2_desc",FALSE)
   END IF
   CALL cl_set_combo_scc('b_pmdl005','2052')
   CALL cl_set_combo_scc('b_pmdn019','2055')
   CALL cl_set_combo_scc('b_pmdo003','2055')
   
   #2015/01/22 by stellar add ----- (S)
   #預設結案功能
   LET g_mode = '1'
   LET g_mode_o = g_mode
   LET g_acc = '258'
   #2015/01/22 by stellar add ----- (E)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt            LIKE type_t.num5
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
         CALL apmp510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #2015/01/22 by stellar add ----- (S)
         #原只有結案功能，現在加上留置功能
         INPUT g_mode FROM l_mode ATTRIBUTE(WITHOUT DEFAULTS)
           ON CHANGE l_mode
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt
                FROM apmp510_tmp
               WHERE sel2 = 'Y'
              IF l_cnt > 0 THEN
                 IF cl_ask_confirm('axm-00530') THEN 
                    IF g_mode = 1 THEN
                       LET g_acc = '258'
                    ELSE
                       LET g_acc = '317'
                    END IF
                 ELSE
                    LET g_mode = g_mode_o
                    DISPLAY BY NAME g_mode
                    NEXT FIELD l_mode
                 END IF
              ELSE
                 IF g_mode = 1 THEN
                    LET g_acc = '258'
                 ELSE
                    LET g_acc = '317'
                 END IF              
              END IF   
              CLEAR FORM
              CALL g_detail_d.clear()
              CALL g_pmdn_d.clear()
              DELETE FROM apmp510_tmp
              LET g_wc = " 1=1"
              LET g_mode_o = g_mode
         END INPUT
         #2015/01/22 by stellar add ----- (E)
         
         CONSTRUCT BY NAME g_wc ON pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD pmdldocno            #請購單單號
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                IF g_type = '1' THEN
                   LET g_qryparam.where = " pmdl006 <> '6' AND pmdlstus = 'Y' AND pmdn045 = '1' "
                ELSE
                   #2015/01/22 by stellar modify ----- (S)
#                   LET g_qryparam.where = " pmdl006 <> '6' AND (pmdlstus = 'C' OR (pmdlstus = 'Y' AND pmdn045 <> '1')) "
                   CASE g_mode
                      WHEN '1'
                           LET g_qryparam.where = " pmdl006 <> '6' AND pmdn045 IN ('2','3','4')"
                      WHEN '2'
                           LET g_qryparam.where = " pmdl006 <> '6' AND pmdn045 = '5' "
                   END CASE
                   #2015/01/22 by stellar modify ----- (S)
                END IF               
                CALL q_pmdldocno_1()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdldocno      #顯示到畫面上
                NEXT FIELD pmdldocno                         #返回原欄位

            ON ACTION controlp INFIELD pmdl004            #供應商
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pmaastus = 'Y' "               
               CALL q_pmaa001_3()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl004      #顯示到畫面上
               NEXT FIELD pmdl004                         #返回原欄位 

            ON ACTION controlp INFIELD pmdl002            #採購人員
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " ooagstus = 'Y' "                
                CALL q_ooag001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdl002      #顯示到畫面上
                NEXT FIELD pmdl002                         #返回原欄位              

            ON ACTION controlp INFIELD pmdl003            #採購部門
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " ooegstus = 'Y' "                
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdl003      #顯示到畫面上
                NEXT FIELD pmdl003                         #返回原欄位

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*                     #BACKUP
               IF NOT cl_null(g_detail_d[g_detail_idx].pmdldocno) THEN               
                  CALL apmp510_fetch()
               END IF
               CALL apmp510_set_entry()
               CALL apmp510_set_no_entry()


            ON CHANGE b_sel
               IF g_detail_d[l_ac].sel = 'N' THEN
                  LET g_detail_d[l_ac].closed = ''
                  LET g_detail_d[l_ac].closed_desc = ''
                  DISPLAY BY NAME g_detail_d[l_ac].closed,g_detail_d[l_ac].closed_desc              
              #160523-00018#4-s-add 
               ELSE 
                  IF g_type = '1' AND g_mode = 1 THEN               
                     IF NOT s_apmp510_aic_chk(g_detail_d[l_ac].pmdldocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00225'   #此多角採購單%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_detail_d[l_ac].pmdldocno 
                        CALL cl_err()                      
                        LET g_detail_d[l_ac].sel = 'N'
                        LET g_detail_d[l_ac].closed = ''
                        LET g_detail_d[l_ac].closed_desc = ''    
                        DISPLAY BY NAME g_detail_d[l_ac].closed,g_detail_d[l_ac].closed_desc                     
                     END IF  
                  END IF                      
              #160523-00018#4-e-add                   
               END IF
               CALL apmp510_set_entry()
               CALL apmp510_set_no_entry()
              
             AFTER FIELD b_closed 
                IF NOT cl_null(g_detail_d[l_ac].closed) THEN
                   IF NOT apmp510_pmdn051_chk(g_detail_d[l_ac].pmdldocno,g_detail_d[l_ac].closed) THEN
                      NEXT FIELD b_closed 
                   END IF
                ELSE
                   IF g_detail_d[l_ac].sel = 'Y' THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00266'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD b_closed
                   END IF                   
                END IF               
                CALL apmp510_closed_ref(g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc                 

             ON ROW CHANGE
                IF g_detail_d[l_ac].sel = 'Y' THEN
                   CALL apmp510_upd_tmp('2','Y',g_detail_d[l_ac].pmdldocno,'',g_detail_d[l_ac].closed)
                ELSE
                   CALL apmp510_upd_tmp('2','N',g_detail_d[l_ac].pmdldocno,'','')
                END IF
                CALL apmp510_fetch()


             ON ACTION controlp INFIELD b_closed
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_detail_d[l_ac].closed             #給予default值
                #給予arg
                LET g_qryparam.arg1 = g_acc
                CALL q_oocq002()                                                #呼叫開窗
                LET g_detail_d[l_ac].closed = g_qryparam.return1                #將開窗取得的值回傳到變數
                DISPLAY g_detail_d[l_ac].closed TO b_closed                     #顯示到畫面上
                CALL apmp510_closed_ref(g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc
                NEXT FIELD b_closed                                              #返回原欄位              
         END INPUT
         
         INPUT ARRAY g_pmdn_d FROM s_detail2.*
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)
                      
            BEFORE ROW
              LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
              LET l_ac1 = g_detail2_idx
              LET g_pmdn_d_t.* = g_pmdn_d[l_ac1].*                     #BACKUP
              CALL apmp510_set_entry_b()
              CALL apmp510_set_no_entry_b()             
              

          ON CHANGE b_sel2
              IF g_pmdn_d[l_ac1].sel2 = 'N' THEN
                 LET g_pmdn_d[l_ac1].closed2 = ''
                 LET g_pmdn_d[l_ac1].closed2_desc = ''
                 DISPLAY BY NAME g_pmdn_d[l_ac1].closed2,g_pmdn_d[l_ac1].closed2_desc              
              #160523-00018#4-s-add 
               ELSE 
                  IF g_type = '1' AND g_mode = 1 THEN               
                     IF NOT s_apmp510_aic_chk(g_pmdn_d[l_ac1].pmdndocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00225'   #此多角採購%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_pmdn_d[l_ac1].pmdndocno
                        CALL cl_err()                      
                        LET g_pmdn_d[l_ac1].sel2 = 'N' 
                        LET g_pmdn_d[l_ac1].closed2 = ''
                        LET g_pmdn_d[l_ac1].closed2_desc = ''    
                        DISPLAY BY NAME g_pmdn_d[l_ac1].sel2,g_pmdn_d[l_ac1].closed2,g_pmdn_d[l_ac1].closed2_desc                      
                     END IF
                  END IF   
              #160523-00018#4-e-add                  
              END IF
              CALL apmp510_set_entry_b()
              CALL apmp510_set_no_entry_b() 
              

           ON ACTION controlp INFIELD b_closed2
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_pmdn_d[l_ac1].closed2             #給予default值
              #給予arg
              LET g_qryparam.arg1 = g_acc
              CALL q_oocq002()                                                #呼叫開窗
              LET g_pmdn_d[l_ac1].closed2 = g_qryparam.return1                #將開窗取得的值回傳到變數
              DISPLAY g_pmdn_d[l_ac1].closed2 TO b_closed2                    #顯示到畫面上
              CALL apmp510_closed_ref(g_pmdn_d[l_ac1].closed2) RETURNING g_pmdn_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_pmdn_d[l_ac1].closed2_desc
              NEXT FIELD b_closed2

          AFTER FIELD b_closed2
              IF NOT cl_null(g_pmdn_d[l_ac1].closed2) THEN
                  IF NOT apmp510_pmdn051_chk(g_pmdn_d[l_ac1].pmdndocno,g_pmdn_d[l_ac1].closed2) THEN
                     NEXT FIELD b_closed2
                  END IF 
              ELSE
                  IF g_pmdn_d[l_ac1].sel2 = 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00266'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD b_closed2
                  END IF                  
              END IF                      
              CALL apmp510_closed_ref(g_pmdn_d[l_ac1].closed2) RETURNING g_pmdn_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_pmdn_d[l_ac1].closed2_desc               


          AFTER ROW
              IF g_pmdn_d[l_ac1].sel2 = 'Y' THEN
                 CALL apmp510_upd_tmp('3','Y',g_pmdn_d[l_ac1].pmdndocno,g_pmdn_d[l_ac1].pmdnseq,g_pmdn_d[l_ac1].closed2)
              ELSE
                 CALL apmp510_upd_tmp('3','N',g_pmdn_d[l_ac1].pmdndocno,g_pmdn_d[l_ac1].pmdnseq,g_pmdn_d[l_ac1].closed2)
              END IF                
         END INPUT                           
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_pmdo_d TO s_detail3.* ATTRIBUTES(COUNT = g_detail3_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
         END DISPLAY 

         DISPLAY ARRAY g_pmdm_d TO s_detail4.* ATTRIBUTES(COUNT = g_detail4_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
         END DISPLAY 
         
         DISPLAY ARRAY g_pmdt_d TO s_detail5.* ATTRIBUTES(COUNT = g_detail5_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4
         
         END DISPLAY 
         DISPLAY ARRAY g_pmdt3_d TO s_detail6.* ATTRIBUTES(COUNT = g_detail6_cnt)
            BEFORE DISPLAY
               LET g_current_page = 5
         
         END DISPLAY   
         DISPLAY ARRAY g_apcc_d TO s_detail7.* ATTRIBUTES(COUNT = g_detail7_cnt)
            BEFORE DISPLAY
               LET g_current_page = 6
         
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
               #160523-00018#4-s-add 
               IF g_type = '1' AND g_mode = 1 THEN
                  IF NOT s_apmp510_aic_chk(g_detail_d[li_idx].pmdldocno) THEN
                     LET g_detail_d[li_idx].sel = 'N'
                     CONTINUE FOR
                  END IF
               END IF
              #160523-00018#4-e-add                
               CALL apmp510_upd_tmp('2','Y',g_detail_d[li_idx].pmdldocno,'',g_detail_d[li_idx].closed)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL apmp510_fetch()
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               CALL apmp510_upd_tmp('2','N',g_detail_d[li_idx].pmdldocno,'','')
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL apmp510_fetch()
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
                 #160523-00018#4-s-add 
                  IF g_type = '1' AND g_mode = 1 THEN
                     IF NOT s_apmp510_aic_chk(g_detail_d[l_ac].pmdldocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00225'   #此多角採購單%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_detail_d[l_ac].pmdldocno                    
                        CALL cl_err()  
                        LET g_detail_d[li_idx].sel = 'N'
                        CONTINUE FOR
                     END IF
                  END IF
                 #160523-00018#4-e-add                   
                  LET g_detail_d[li_idx].sel = "Y"
                  CALL apmp510_upd_tmp('2','Y',g_detail_d[l_ac].pmdldocno,'',g_detail_d[l_ac].closed)
               END IF
            END FOR
            CALL apmp510_fetch()
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
                  LET g_detail_d[li_idx].sel = "N"
                  LET g_detail_d[li_idx].closed = ''
                  LET g_detail_d[li_idx].closed_desc = ''    
                  CALL apmp510_upd_tmp('2','N',g_detail_d[li_idx].pmdldocno,'','')                  
               END IF
            END FOR
            CALL apmp510_fetch()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmp510_filter()
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
            CALL apmp510_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL apmp510_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute        #執行結案
            IF apmp510_execute_chk() THEN
               IF g_type = '1' THEN
                  #2015/01/22 by stellar modify ----- (S)
#                  CALL apmp510_closed_upd()
                  CASE g_mode
                     WHEN '1' CALL apmp510_closed_upd()
                     WHEN '2' CALL apmp510_hold_upd(g_type)
                  END CASE
                  #2015/01/22 by stellar modify ----- (E)
               ELSE
                  #2015/01/22 by stellar modify ----- (S)
#                  CALL apmp510_unclosed_upd()
                  CASE g_mode
                     WHEN '1' CALL apmp510_unclosed_upd()
                     WHEN '2' CALL apmp510_hold_upd(g_type)
                  END CASE
                  #2015/01/22 by stellar modify ----- (E)
               END IF
               CALL cl_ask_confirm3("std-00012","") 
               IF cl_ask_confirm('asf-00182') THEN
                 CLEAR FORM
                 CALL g_detail_d.clear()
                 CALL g_pmdn_d.clear()
                 CALL g_pmdo_d.clear()
                 CALL g_pmdm_d.clear()
                 CALL g_pmdt_d.clear()	
                 CALL g_apcc_d.clear()
                 CALL g_pmdt3_d.clear()                 
                 EXIT DIALOG
               ELSE
                 LET g_action_choice = 'exit'
                 EXIT DIALOG
               END IF
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
 
{<section id="apmp510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmp510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   DEFINE l_sql      STRING
   DEFINE l_cnt      LIKE type_t.num5
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET g_wc2 = ''
   IF g_type = '1' THEN
      LET g_wc2 = " pmdl006 <> '6' AND pmdlstus = 'Y' AND pmdn045 = '1'  "
   ELSE
      #2015/01/22 by stellar modify ----- (S)
#      LET g_wc2 = " pmdl006 <> '6' AND (pmdlstus = 'C' OR (pmdlstus = 'Y' AND pmdn045 <> '1')) "
      CASE g_mode
         WHEN '1'
              LET g_wc2 = " pmdl006 <> '6' AND pmdn045 IN ('2','3','4') "
         WHEN '2'
              LET g_wc2 = " pmdl006 <> '6' AND pmdn045 = '5' "
      END CASE
      #2015/01/22 by stellar modify ----- (E)
   END IF
   LET l_sql = "SELECT DISTINCT '','',pmdndocno,pmdnseq,pmdn007,'' ",   #2015/01/22 by stellar add ''
               "  FROM pmdl_t,pmdn_t ",
               " WHERE pmdndocno = pmdldocno ",
               "   AND pmdnent = pmdlent ",                             #170111-00026#3 add
               "   AND pmdlent = ? ",
               "   AND pmdlsite = '",g_site,"' " ,
               "   AND pmdl006 <> '6' ",
               "   AND ",g_wc ,
               "   AND ",g_wc2
   PREPARE apmp510_sel_pr_tmp FROM l_sql
   DECLARE apmp510_sel_cs_tmp CURSOR FOR apmp510_sel_pr_tmp
   #清空tmptable
   DELETE FROM apmp510_tmp
   LET l_cnt = 1
   FOREACH apmp510_sel_cs_tmp USING g_enterprise INTO g_tmp_d[l_cnt].*
       LET g_tmp_d[l_cnt].sel2 = 'N'
       INSERT INTO apmp510_tmp VALUES(g_tmp_d[l_cnt].*)
       LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_tmp_d.deleteElement(g_tmp_d.getLength())
   #end add-point
        
   LET g_error_show = 1
   CALL apmp510_b_fill()
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
 
{<section id="apmp510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmp510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_n        LIKE type_t.num5    #160203-00006 by whitney add
   DEFINE l_pmdl028  LIKE pmdl_t.pmdl028 #161207-00033#20
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = " SELECT DISTINCT pmdldocno,pmdldocdt,pmdl004,'',pmdl002, ",
               "                 '',pmdl003,'',pmdl005,pmdl009, ",
               "                 '',pmdl010,'',pmdl011,'', ",
               "                 pmdl012,pmdl013,pmdl015,'',pmdl031,pmdl028 ", #161207-00033#20 add pmdl028
               "  FROM pmdl_t,pmdn_t ",
               " WHERE pmdlent = ? ",
               "   AND pmdlsite = '",g_site,"' ",
               "   AND pmdldocno = pmdndocno ",
               "   AND pmdl006 <> '6' ",               
               "   AND ",g_wc ,
               "   AND ",g_wc2
   #end add-point
 
   PREPARE apmp510_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmp510_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_detail_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].pmdldocno,g_detail_d[l_ac].pmdldocdt,g_detail_d[l_ac].pmdl004,g_detail_d[l_ac].pmdl004_desc,g_detail_d[l_ac].pmdl002,     
   g_detail_d[l_ac].pmdl002_desc,g_detail_d[l_ac].pmdl003,g_detail_d[l_ac].pmdl003_desc,g_detail_d[l_ac].pmdl005,g_detail_d[l_ac].pmdl009,
   g_detail_d[l_ac].pmdl009_desc,g_detail_d[l_ac].pmdl010,g_detail_d[l_ac].pmdl010_desc,g_detail_d[l_ac].pmdl011,g_detail_d[l_ac].pmdl011_desc,
   g_detail_d[l_ac].pmdl012,g_detail_d[l_ac].pmdl013,g_detail_d[l_ac].pmdl015,g_detail_d[l_ac].pmdl015_desc,g_detail_d[l_ac].pmdl031,
   l_pmdl028   #161207-00033#20 add pmdl028
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
      #160422-00027 by whitney add start
      #161115-00038#1 mark(s)
#      IF g_type = '1' THEN
#         IF NOT s_apmp510_pmdldocno_chk(g_detail_d[l_ac].pmdldocno) THEN
#            CONTINUE FOREACH
#         END IF
#      END IF
      #161115-00038#1 mark(e)
      #160422-00027 by whitney add end
      #160203-00006 by whitney add (s)
      IF g_type = '2' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM pmdp_t
          WHERE pmdpent = g_enterprise
            AND pmdpdocno = g_detail_d[l_ac].pmdldocno
            AND pmdp003 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaastus IN ('C','M') AND sfaaent = pmdpent)
         IF cl_null(l_n) THEN LET l_n = 0 END IF
         IF l_n > 0 THEN CONTINUE FOREACH END IF
      END IF
      #160203-00006 by whitney add (e)
      LET g_detail_d[l_ac].sel = 'N'
      #161207-00033#20-S
      IF NOT cl_null(l_pmdl028) THEN  
         CALL s_desc_get_oneturn_guest_desc(l_pmdl028) RETURNING g_detail_d[l_ac].pmdl004_desc
      ELSE 
      #161207-00033#20-E      
         CALL apmp510_pmdl004_ref(g_detail_d[l_ac].pmdl004) RETURNING g_detail_d[l_ac].pmdl004_desc
      END IF  #161207-00033#20
      
      CALL apmp510_pmdl002_ref(g_detail_d[l_ac].pmdl002) RETURNING g_detail_d[l_ac].pmdl002_desc
      CALL apmp510_pmdl003_ref(g_detail_d[l_ac].pmdl003) RETURNING g_detail_d[l_ac].pmdl003_desc
      CALL apmp510_pmdl009_ref(g_detail_d[l_ac].pmdl009) RETURNING g_detail_d[l_ac].pmdl009_desc
      CALL apmp510_pmdl010_ref(g_detail_d[l_ac].pmdl010) RETURNING g_detail_d[l_ac].pmdl010_desc
      CALL apmp510_pmdl011_ref(g_detail_d[l_ac].pmdl011) RETURNING g_detail_d[l_ac].pmdl011_desc
      CALL apmp510_pmdl015_ref(g_detail_d[l_ac].pmdl015) RETURNING g_detail_d[l_ac].pmdl015_desc
  
      #end add-point
      
      CALL apmp510_detail_show()      
 
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
   FREE apmp510_sel
   
   LET l_ac = 1
   CALL apmp510_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmp510_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE i               LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pmdo015       LIKE pmdo_t.pmdo015
   DEFINE l_apcadocno     LIKE apca_t.apcadocno
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   LET l_sql = "SELECT a.sel2,a.closed2,'',b.pmdndocno,b.pmdnseq, ",       
               "       b.pmdn001,'','',b.pmdn002,'',b.pmdn019, ",
               "       b.pmdn004,'',b.pmdn005,b.pmdn006,'', ",
               "       b.pmdn007,'','',b.pmdn050 ",   ##170215-00009#1 add pmdn050
               "  FROM apmp510_tmp a ,pmdn_t b ",
               " WHERE a.pmdndocno = '",g_detail_d[g_detail_idx].pmdldocno,"'" ,
               "   AND a.pmdndocno = b.pmdndocno ",
               "   AND a.pmdnseq = b.pmdnseq ",
               "   AND b.pmdnent = ",g_enterprise,                              #170111-00026#3 add
               " ORDER BY a.pmdndocno,a.pmdnseq "

   PREPARE apmp510_sel_pr FROM l_sql
   DECLARE apmp510_sel_cs CURSOR FOR apmp510_sel_pr

   LET l_cnt = 1
   CALL g_pmdn_d.clear()
   FOREACH apmp510_sel_cs INTO g_pmdn_d[l_cnt].*
     #取得已收貨量
     CALL s_apmt500_count_min_pmdo015 (g_pmdn_d[l_cnt].pmdndocno,g_pmdn_d[l_cnt].pmdnseq)  #採購已收貨量最小套數
               RETURNING l_pmdo015,l_success
     IF l_success THEN
        IF cl_null(l_pmdo015) THEN LET l_pmdo015 = 0 END IF
        LET g_pmdn_d[l_cnt].pmdo015_1  =  l_pmdo015   
        LET g_pmdn_d[l_cnt].unpmdo015_1  =  g_pmdn_d[l_cnt].pmdn007 - g_pmdn_d[l_cnt].pmdo015_1      
     END IF
     CALL apmp510_closed_ref(g_pmdn_d[l_cnt].closed2) RETURNING g_pmdn_d[l_cnt].closed2_desc       
     CALL apmp510_pmdn001_ref(g_pmdn_d[l_cnt].pmdn001) RETURNING g_pmdn_d[l_cnt].pmdn001_desc,g_pmdn_d[l_cnt].imaal004_1
     CALL s_feature_description(g_pmdn_d[l_cnt].pmdn001,g_pmdn_d[l_cnt].pmdn002) RETURNING l_success,g_pmdn_d[l_cnt].pmdn002_desc
     CALL apmp510_pmdn004_ref(g_pmdn_d[l_cnt].pmdn004) RETURNING g_pmdn_d[l_cnt].pmdn004_desc
     CALL apmp510_unit_ref(g_pmdn_d[l_cnt].pmdn006) RETURNING g_pmdn_d[l_cnt].pmdn006_desc
     
     LET l_cnt = l_cnt + 1

   END FOREACH
   CALL g_pmdn_d.deleteElement(g_pmdn_d.getLength())
   LET g_detail2_cnt = l_cnt - 1      

   #帶出採購交期明細資料
   LET l_sql = "SELECT pmdodocno,pmdoseq,pmdoseq1,pmdo003,pmdo001, ",
               "       '','',pmdo002,pmdo004,'', ",         
               "       pmdoseq2,pmdo006,pmdo015,pmdo016,'' ",
               "  FROM pmdo_t ",
               " WHERE pmdoent = '",g_enterprise,"' ",
               "   AND pmdosite = '",g_site,"' ",
               "   AND pmdodocno = '",g_detail_d[g_detail_idx].pmdldocno,"'" 
   PREPARE apmp510_sel_pmdo_pr FROM l_sql
   DECLARE apmp510_sel_pmdo_cs CURSOR FOR apmp510_sel_pmdo_pr 
   LET l_cnt = 1   
   CALL g_pmdo_d.clear()
   FOREACH apmp510_sel_pmdo_cs INTO g_pmdo_d[l_cnt].*
     #未收貨量 = 分批數量 - 已收貨量 + 驗退數量
     LET g_pmdo_d[l_cnt].unpmdo015 = g_pmdo_d[l_cnt].pmdo006 - g_pmdo_d[l_cnt].pmdo015 + g_pmdo_d[l_cnt].pmdo016
     CALL apmp510_pmdn001_ref(g_pmdo_d[l_cnt].pmdo001) RETURNING g_pmdo_d[l_cnt].pmdo001_desc,g_pmdo_d[l_cnt].imaal004_2
     CALL s_feature_description(g_pmdo_d[l_cnt].pmdo001,g_pmdo_d[l_cnt].pmdo002) RETURNING l_success,g_pmdo_d[l_cnt].pmdo002_desc
     CALL apmp510_unit_ref(g_pmdo_d[l_cnt].pmdo004) RETURNING g_pmdo_d[l_cnt].pmdo004_desc
     
     LET l_cnt = l_cnt + 1
   END FOREACH   
   CALL g_pmdo_d.deleteElement(g_pmdo_d.getLength())
   LET g_detail3_cnt = l_cnt - 1   
   FREE apmp510_sel_pmdo_pr
   

   #帶出採購多期預付款資料
   LET l_sql = "SELECT pmdmdocno,pmdm001,pmdm002,'',pmdm003, ",
               "       pmdm004,pmdm005,pmdm006,pmdm007,pmdm008, ",
               "       pmdm009 ",
               "  FROM pmdm_t ",
               " WHERE pmdment = '",g_enterprise,"' ",
               "   AND pmdmsite = '",g_site,"' ",
               "   AND pmdmdocno = '",g_detail_d[g_detail_idx].pmdldocno,"'" 
   PREPARE apmp510_sel_pmdm_pr FROM l_sql
   DECLARE apmp510_sel_pmdm_cs CURSOR FOR apmp510_sel_pmdm_pr 
   LET l_cnt = 1
   CALL g_pmdm_d.clear()   
   FOREACH apmp510_sel_pmdm_cs INTO g_pmdm_d[l_cnt].*
     CALL apmp510_pmdl009_ref(g_pmdm_d[l_cnt].pmdm002) RETURNING g_pmdm_d[l_cnt].pmdm002_desc
     LET l_cnt = l_cnt + 1
   END FOREACH   
   CALL g_pmdm_d.deleteElement(g_pmdm_d.getLength())
   LET g_detail4_cnt = l_cnt - 1   
   FREE apmp510_sel_pmdm_pr
   
   #帶出已收貨未入庫明細
   LET l_sql = "SELECT pmdtdocno,pmdtseq,pmdt006,'','', ",
               "       pmdt007,pmdt019,'',pmdt020,pmdt054, ",
               "       pmdt055, '',pmdt059 ",   #170215-00009#1 add pmdt059
               "  FROM pmdt_t,pmds_t ",
               " WHERE pmdtent = '",g_enterprise,"' ",
               "   AND pmdtsite = '",g_site,"' ",
               "   AND pmdtent = pmdsent ",     #170213-00003#1 add
               "   AND pmdtdocno = pmdsdocno ",
               "   AND pmdt001 = '",g_detail_d[g_detail_idx].pmdldocno,"'" ,
               "   AND pmds000 = '1' ",                   #收貨單
               "   AND pmdsstus != 'X'"   #161117-00025#1 add
   PREPARE apmp510_sel_pmdt_pr FROM l_sql
   DECLARE apmp510_sel_pmdt_cs CURSOR FOR apmp510_sel_pmdt_pr 
   LET l_cnt = 1 
   CALL g_pmdt_d.clear()   
   FOREACH apmp510_sel_pmdt_cs INTO g_pmdt_d[l_cnt].*
     #未入庫量 = 收貨數量 - 已入庫量 - 驗退數量
     LET g_pmdt_d[l_cnt].unpmdt054 = g_pmdt_d[l_cnt].pmdt020 - g_pmdt_d[l_cnt].pmdt054 - g_pmdt_d[l_cnt].pmdt055
     CALL apmp510_pmdn001_ref(g_pmdt_d[l_cnt].pmdt006) RETURNING g_pmdt_d[l_cnt].pmdt006_desc,g_pmdt_d[l_cnt].imaal004_5
     CALL apmp510_unit_ref(g_pmdt_d[l_cnt].pmdt019) RETURNING g_pmdt_d[l_cnt].pmdt019_desc
     LET l_cnt = l_cnt + 1
   END FOREACH   
   CALL g_pmdt_d.deleteElement(g_pmdt_d.getLength())
   LET g_detail5_cnt = l_cnt - 1   
   FREE apmp510_sel_pmdt_pr    

   #帶出已入庫未立帳明細
   LET l_sql = "SELECT pmdtdocno,pmdtseq,pmdt006,'','', ",
               "       pmdt007,pmdt019,'',pmdt054,pmdt039, ",
               "       '','',pmdt059 ",   #170215-00009#1 add pmdt059
               "  FROM pmdt_t,pmds_t ",
               " WHERE pmdtent = '",g_enterprise,"' ",
               "   AND pmdtsite = '",g_site,"' ",
               "   AND pmdtent = pmdsent ",     #170213-00003#1 add
               "   AND pmdtdocno = pmdsdocno ",
               "   AND pmdt001 = '",g_detail_d[g_detail_idx].pmdldocno,"'" ,
               "   AND pmds000 = '3' " ,                  #收貨入庫
               "   AND pmdsstus != 'X'"   #161117-00025#1 add
   PREPARE apmp510_sel_pmdt3_pr FROM l_sql
   DECLARE apmp510_sel_pmdt3_cs CURSOR FOR apmp510_sel_pmdt3_pr 
   LET l_cnt = 1  
   CALL g_pmdt3_d.clear()   
   FOREACH apmp510_sel_pmdt3_cs INTO g_pmdt3_d[l_cnt].*
     #已立帳金額
     SELECT SUM(apcb119) INTO g_pmdt3_d[l_cnt].account
       FROM apcb_t
      WHERE apcbent = g_enterprise
        AND apcbsite = g_site
        AND apcb002 = g_pmdt3_d[l_cnt].pmdtdocno
        AND apcb003 = g_pmdt3_d[l_cnt].pmdtseq
        AND apcb001 = '12'
     IF cl_null(g_pmdt3_d[l_cnt].account) THEN LET g_pmdt3_d[l_cnt].account = 0 END IF
     #未立帳金額(含稅金額 - 已立帳金額)
     LET g_pmdt3_d[l_cnt].unaccount = g_pmdt3_d[l_cnt].pmdt039 - g_pmdt3_d[l_cnt].account
     CALL apmp510_pmdn001_ref(g_pmdt3_d[l_cnt].pmdt006) RETURNING g_pmdt3_d[l_cnt].pmdt006_desc,g_pmdt3_d[l_cnt].imaal004
     CALL apmp510_unit_ref(g_pmdt3_d[l_cnt].pmdt019) RETURNING g_pmdt3_d[l_cnt].pmdt019_desc     
     LET l_cnt = l_cnt + 1
   END FOREACH   
   CALL g_pmdt3_d.deleteElement(g_pmdt3_d.getLength())
   LET g_detail6_cnt = l_cnt - 1   
   FREE apmp510_sel_pmdt_pr
   
   #帶出已立帳未沖帳明細
   #入庫單號、項次抓取應付憑單單身資料
   LET l_cnt = 1 
   CALL g_apcc_d.clear()
   FOR i = 1 TO g_pmdt3_d.getLength()
       SELECT apcadocno INTO l_apcadocno
         FROM apca_t,apcb_t
        WHERE apcaent = g_enterprise
          AND apcasite = g_site
          AND apcadocno = apcbdocno
          AND apcb002 = g_pmdt3_d[i].pmdtdocno
          AND apcb003 = g_pmdt3_d[i].pmdtseq
          AND apcb001 = '12'
   
       LET l_sql = "SELECT apccdocno,apccseq,apcc001,apcc003,apcc118, ",
                   "       apcc119,'' ",
                   "  FROM apcc_t ",
                   " WHERE apccent = '",g_enterprise,"' ",
                   "   AND apccsite = '",g_site,"' ",
                   "   AND apccdocno = '",l_apcadocno,"' "
       PREPARE apmp510_sel_apcc_pr FROM l_sql
       DECLARE apmp510_sel_apcc_cs CURSOR FOR apmp510_sel_apcc_pr 
         
       FOREACH apmp510_sel_apcc_cs INTO g_apcc_d[l_cnt].*
           #本幣未沖帳金額 = 本幣應付金額 - 本幣付款沖帳金額
           LET g_apcc_d[l_cnt].unapcc119 = g_apcc_d[l_cnt].apcc118 - g_apcc_d[l_cnt].apcc119
           LET l_cnt = l_cnt + 1
       END FOREACH                  
   END FOR
   CALL g_apcc_d.deleteElement(g_apcc_d.getLength())
   LET g_detail7_cnt = l_cnt - 1   
   FREE apmp510_sel_pmdt_pr     
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apmp510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmp510_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmp510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmp510_filter()
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
   
   CALL apmp510_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="apmp510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmp510_filter_parser(ps_field)
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
 
{<section id="apmp510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmp510_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmp510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#建立tmptable
PRIVATE FUNCTION apmp510_create_preview_tmp()
   DROP TABLE apmp510_tmp
   CREATE TEMP TABLE apmp510_tmp
   (
      sel2       VARCHAR(1),
      closed2    VARCHAR(10),
      pmdndocno  VARCHAR(20),
      pmdnseq    DECIMAL(10,0),
      pmdn007    DECIMAL(20,6)
     ,closed1    VARCHAR(10)   #2015/01/22 by stellar add
    );
END FUNCTION
#結案理由碼顯示
PRIVATE FUNCTION apmp510_closed_ref(p_closed)
DEFINE p_closed  LIKE pmdn_t.pmdn051
DEFINE r_oocql004 LIKE oocql_t.oocql004
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_closed
        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_oocql004 = '', g_rtn_fields[1] , ''
        RETURN r_oocql004
END FUNCTION
#供應商說明
PRIVATE FUNCTION apmp510_pmdl004_ref(p_pmdl004)
DEFINE p_pmdl004    LIKE pmdl_t.pmdl004
DEFINE r_pmaal004   LIKE pmaal_t.pmaal004

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_pmdl004
        CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_pmaal004 = '', g_rtn_fields[1] , ''
        RETURN r_pmaal004
END FUNCTION
#員工編號說明
PRIVATE FUNCTION apmp510_pmdl002_ref(p_pmdl002)
DEFINE p_pmdl002      LIKE pmdl_t.pmdl002
DEFINE r_pmdl002_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmdl002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdl002_desc
END FUNCTION
#部門編號說明
PRIVATE FUNCTION apmp510_pmdl003_ref(p_pmdl003)
DEFINE p_pmdl003      LIKE pmdl_t.pmdl003
DEFINE r_pmdl003_desc LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdl003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdl003_desc
END FUNCTION
#付款條件說明
PRIVATE FUNCTION apmp510_pmdl009_ref(p_pmdl009)
DEFINE p_pmdl009      LIKE pmdl_t.pmdl009
DEFINE r_ooibl004     LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl009
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooibl004 = g_rtn_fields[1]
       RETURN r_ooibl004
END FUNCTION
#交易條件說明
PRIVATE FUNCTION apmp510_pmdl010_ref(p_pmdl010)
DEFINE p_pmdl010      LIKE pmdl_t.pmdl010
DEFINE r_oocql004     LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl010
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocql004 = g_rtn_fields[1]
       RETURN r_oocql004
END FUNCTION
#稅別說明
PRIVATE FUNCTION apmp510_pmdl011_ref(p_pmdl011)
DEFINE p_pmdl011      LIKE pmdl_t.pmdl011
DEFINE r_oodbl004     LIKE oodbl_t.oodbl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl011
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oodbl004 = '', g_rtn_fields[1] , ''
       RETURN r_oodbl004
END FUNCTION
#幣別說明
PRIVATE FUNCTION apmp510_pmdl015_ref(p_pmdl015)
DEFINE p_pmdl015      LIKE pmdl_t.pmdl015
DEFINE r_ooail003     LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdl015
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooail003 = '', g_rtn_fields[1] , ''
       RETURN r_ooail003
END FUNCTION
#料件編號帶品名、規格
PRIVATE FUNCTION apmp510_pmdn001_ref(p_pmdn001)
DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
DEFINE r_imaal003    LIKE imaal_t.imaal003
DEFINE r_imaal004    LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdn001
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
END FUNCTION
#作業編號說明
PRIVATE FUNCTION apmp510_pmdn004_ref(p_pmdn004)
DEFINE p_pmdn004   LIKE pmdn_t.pmdn004
DEFINE r_oocql004  LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdn004
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocql004 = '', g_rtn_fields[1] , ''
       RETURN r_oocql004
END FUNCTION
#單位帶出說明
PRIVATE FUNCTION apmp510_unit_ref(p_pmdn006)
DEFINE p_pmdn006    LIKE pmdn_t.pmdn006
DEFINE r_oocal003   LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdn006
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocal003 = '', g_rtn_fields[1] , ''
       RETURN r_oocal003
END FUNCTION
#畫面單身勾選/取消勾選，需更新tmptable資料
PRIVATE FUNCTION apmp510_upd_tmp(p_type,p_flag,p_pmdndocno,p_pmdnseq,p_closed)
DEFINE p_type        LIKE type_t.chr1
DEFINE p_flag        LIKE type_t.chr1
DEFINE p_pmdndocno   LIKE pmdn_t.pmdndocno
DEFINE p_pmdnseq     LIKE pmdn_t.pmdnseq
DEFINE p_closed      LIKE pmdn_t.pmdn051
DEFINE i             LIKE type_t.num5

   CASE p_type
      
     WHEN '2'           #單頭單筆全選
       UPDATE apmp510_tmp
          SET sel2 = p_flag,
              closed2 = p_closed
             ,closed1 = p_closed   #2015/01/22 by stellar add
        WHERE pmdndocno = p_pmdndocno

     WHEN '3'           #單身一筆勾選
       UPDATE apmp510_tmp
          SET sel2 = p_flag,
              closed2 = p_closed
        WHERE pmdndocno = p_pmdndocno
          AND pmdnseq = p_pmdnseq
    END CASE

END FUNCTION
#結案理由碼檢查
PRIVATE FUNCTION apmp510_pmdn051_chk(p_pmdndocno,p_oocq002)
DEFINE p_pmdndocno       LIKE pmdn_t.pmdndocno
DEFINE p_oocq002         LIKE oocq_t.oocq002
DEFINE r_success         LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5
DEFINE l_flag            LIKE type_t.num5

   LET r_success = TRUE

   IF cl_null(p_oocq002) THEN
      RETURN r_success
   END IF
   
   IF NOT s_azzi650_chk_exist(g_acc,p_oocq002) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #檢核輸入的理由碼是否在單據別限制範圍內
   CALL s_control_chk_doc('8',p_pmdndocno,p_oocq002,'','','','')
        RETURNING l_success,l_flag
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      IF NOT l_flag THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   RETURN r_success
END FUNCTION

PRIVATE FUNCTION apmp510_set_entry()
    CALL cl_set_comp_entry("b_closed",TRUE)
END FUNCTION

PRIVATE FUNCTION apmp510_set_no_entry()
    IF g_detail_d[l_ac].sel = 'N' THEN
       CALL cl_set_comp_entry("b_closed",FALSE)
    END IF
END FUNCTION

PRIVATE FUNCTION apmp510_set_entry_b()
    CALL cl_set_comp_entry("b_closed2",TRUE)
END FUNCTION

PRIVATE FUNCTION apmp510_set_no_entry_b()
    IF g_pmdn_d[l_ac1].sel2 = 'N' THEN
       CALL cl_set_comp_entry("b_closed2",FALSE)
    END IF
END FUNCTION
#執行前檢查
PRIVATE FUNCTION apmp510_execute_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
       LET r_success = TRUE 

       #因按執行時，不會走AFTR ROW 、ON ROW CHANGE 段無法即時寫入TEMP TABLE，所以在此段做處理
       #第一單身
       IF g_detail_idx > 0 THEN
          IF g_detail_d[g_detail_idx].sel <> g_detail_d_t.sel THEN 
             IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                IF g_type = 1 THEN                     #結案需控卡理由碼
                   IF NOT cl_null(g_detail_d[g_detail_idx].closed) THEN
                      IF NOT apmp510_pmdn051_chk(g_detail_d[g_detail_idx].pmdldocno,g_detail_d[g_detail_idx].closed) THEN
                         LET r_success = FALSE
                         RETURN r_success 
                      END IF   
                   ELSE
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00266'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()            
                      LET r_success = FALSE
                      RETURN r_success 
                   END IF
                END IF
                CALL apmp510_upd_tmp('2','Y',g_detail_d[g_detail_idx].pmdldocno,'',g_detail_d[g_detail_idx].closed)
             ELSE
                LET g_detail_d[g_detail_idx].closed = ''
                LET g_detail_d[g_detail_idx].closed_desc = ''
                CALL apmp510_upd_tmp('2','N',g_detail_d[g_detail_idx].pmdldocno,'','')
             END IF                      
          END IF
       END IF
       #第二單身
       IF g_detail2_idx > 0 THEN
          IF g_pmdn_d[g_detail2_idx].sel2 <> g_pmdn_d_t.sel2 THEN
             IF g_pmdn_d[g_detail2_idx].sel2 = 'Y' THEN
                IF g_type = 1 THEN     #結案需控卡理由碼
                   IF NOT cl_null(g_pmdn_d[g_detail2_idx].closed2) THEN
                      IF NOT apmp510_pmdn051_chk(g_pmdn_d[g_detail2_idx].pmdndocno,g_pmdn_d[g_detail2_idx].closed2) THEN
                         LET r_success = FALSE
                         RETURN r_success 
                      END IF   
                   ELSE
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00266'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()            
                      LET r_success = FALSE
                      RETURN r_success  
                   END IF
                END IF
                CALL apmp510_upd_tmp('3','Y',g_pmdn_d[g_detail2_idx].pmdndocno,g_pmdn_d[g_detail2_idx].pmdnseq,g_pmdn_d[g_detail2_idx].closed2)
             ELSE
                LET g_pmdn_d[g_detail2_idx].closed2 = ''
                LET g_pmdn_d[g_detail2_idx].closed2_desc = ''
                CALL apmp510_upd_tmp('3','N',g_pmdn_d[g_detail2_idx].pmdndocno,g_pmdn_d[g_detail2_idx].pmdnseq,g_pmdn_d[g_detail2_idx].closed2)
             END IF            
          END IF          
       END IF       

       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM apmp510_tmp
        WHERE sel2 = 'Y'
       #未勾選任何資料
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00481'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
       #結案理由碼不可空白       
       IF g_type = '1' THEN
          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt
            FROM apmp510_tmp
           WHERE sel2 = 'Y'
             AND closed2 IS NULL
          IF l_cnt > 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'axm-00266'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success 

END FUNCTION
################################################################################
# Descriptions...: 請購單結案
# Memo...........:
# Usage..........: CALL apmp510_closed_upd()
#                  
# Input parameter:
# Date & Author..: 2014/08/20  By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp510_closed_upd()
DEFINE l_pmdl_d DYNAMIC ARRAY OF RECORD
       pmdldocno LIKE pmdl_t.pmdldocno
    END RECORD
DEFINE l_pmdndocno LIKE pmdn_t.pmdndocno
DEFINE l_pmdnseq   LIKE pmdn_t.pmdnseq
DEFINE l_closed    LIKE pmdn_t.pmdn051    #結案理由碼
DEFINE l_pmdl006   LIKE pmdl_t.pmdl006    #多角性質
DEFINE l_pmdl031   LIKE pmdl_t.pmdl031    #多角來源單號
DEFINE l_pmdl051   LIKE pmdl_t.pmdl051    #多角流程代碼
DEFINE l_sql       STRING       
DEFINE i           LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_no_cnt    LIKE type_t.num5    
DEFINE l_no_cnt2   LIKE type_t.num5


  LET l_sql = "SELECT DISTINCT pmdndocno ",
              "  FROM apmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE apmp510_sel_docno_pr FROM l_sql
  DECLARE apmp510_sel_docno_cs CURSOR FOR apmp510_sel_docno_pr 
  LET l_cnt = 1

  FOREACH apmp510_sel_docno_cs INTO l_pmdl_d[l_cnt].pmdldocno       
    LET l_cnt = l_cnt + 1
  END FOREACH   
  CALL l_pmdl_d.deleteElement(l_pmdl_d.getLength())
  LET l_cnt = l_cnt - 1
  
  
  CALL cl_showmsg_init() 
  LET l_no_cnt = 0
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt
         LET l_no_cnt2 = 0     
        #160523-00018#4-s-mark
        ##若為銷售多角，需做各據點多角結案
        #LET l_pmdl006 = ''
        #LET l_pmdl031 = ''
        #LET l_pmdl051 = ''         
        #SELECT pmdl006,pmdl031,pmdl051
        #  INTO l_pmdl006,l_pmdl031,l_pmdl051
        #  FROM pmdl_t
        # WHERE pmdlent = g_enterprise
        #   AND pmdlsite = g_site
        #   AND pmdldocno = l_pmdl_d[i].pmdldocno           
        #160523-00018#4-e-mark 
         CALL s_transaction_begin()     
         #抓取TMP單身資料做狀態結案
         LET l_sql = "SELECT closed2,pmdndocno,pmdnseq ",
                     "  FROM apmp510_tmp ",
                     " WHERE pmdndocno = '",l_pmdl_d[i].pmdldocno,"'",
                     "   AND sel2 = 'Y' "
         PREPARE s_apmp510_sel_tmp_pr FROM l_sql
         DECLARE s_apmp510_sel_tmp_cs CURSOR FOR s_apmp510_sel_tmp_pr
         FOREACH s_apmp510_sel_tmp_cs INTO l_closed,l_pmdndocno,l_pmdnseq
           #單身狀態結案
           IF NOT s_apmp510_pmdn045_closed('2',l_pmdndocno,l_pmdnseq,l_closed,g_site) THEN
              LET l_no_cnt2 = l_no_cnt2 + 1
           #160523-00018#4-s-mark
           #ELSE
           #   #多角結案(單身狀態)
           #   IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN                      #多角結案
           #      CALL apmp510_aic_closed('1',l_pmdnseq,l_closed,l_pmdl031,l_pmdl051)
           #   END IF
           #160523-00018#4-e-mark
           END IF       
         END FOREACH
         #物流結案
         IF NOT s_apmp510_pmdl047_closed(l_pmdl_d[i].pmdldocno,g_site) THEN                 
            LET l_no_cnt2 = l_no_cnt2 + 1
         END IF
         IF l_no_cnt2 = 0  THEN
            CALL s_transaction_end("Y","0")
         ELSE
            CALL s_transaction_end("N","0")
            LET l_no_cnt = l_no_cnt + 1
         END IF 
         #帳流結案
         CALL s_transaction_begin()
         IF NOT s_apmp510_pmdl048_closed(l_pmdl_d[i].pmdldocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
         #金流結案          
         CALL s_transaction_begin()
         IF NOT s_apmp510_pmdl049_closed(l_pmdl_d[i].pmdldocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1            
         ELSE
            CALL s_transaction_end('Y','0')
          END IF
         #狀態結案
         CALL s_transaction_begin()
         IF NOT s_apmp510_pmdlstus_closed('2',l_pmdl_d[i].pmdldocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1              
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
        #160523-00018#4-s-mark         
        ##多角結案(物流、帳流、金流、狀態)
        #IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN
        #   CALL apmp510_aic_closed('1',0,'',l_pmdl031,l_pmdl051)
        #END IF         
        #160523-00018#4-e-mark
      END FOR
  END IF  
  IF l_no_cnt > 0 THEN
     CALL cl_showmsg()
  END IF
END FUNCTION
################################################################################
# Descriptions...: 請購單取消結案
# Memo...........:
# Usage..........: CALL apmp510_unclosed_upd()
#                  
# Input parameter:
# Date & Author..: 2014/08/20  By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp510_unclosed_upd()
DEFINE l_sql       STRING  
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_no_cnt    LIKE type_t.num5
DEFINE l_no_cnt2   LIKE type_t.num5
DEFINE i           LIKE type_t.num5

DEFINE l_pmdl_d DYNAMIC ARRAY OF RECORD
       pmdldocno LIKE pmdl_t.pmdldocno      
    END RECORD
DEFINE l_pmdndocno LIKE pmdn_t.pmdndocno
DEFINE l_pmdnseq   LIKE pmdn_t.pmdnseq
DEFINE l_pmdl006   LIKE pmdl_t.pmdl006    #多角性質
DEFINE l_pmdl031   LIKE pmdl_t.pmdl031    #多角來源單號
DEFINE l_pmdl051   LIKE pmdl_t.pmdl051    #多角流程代碼


  LET l_sql = "SELECT DISTINCT pmdndocno ",
              "  FROM apmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE apmp510_sel_docno_pr2 FROM l_sql
  DECLARE apmp510_sel_docno_cs2 CURSOR FOR apmp510_sel_docno_pr2 
  LET l_cnt = 1 
 
  FOREACH apmp510_sel_docno_cs2 INTO l_pmdl_d[l_cnt].pmdldocno       
    LET l_cnt = l_cnt + 1
  END FOREACH   
  CALL l_pmdl_d.deleteElement(l_pmdl_d.getLength())
  LET l_cnt = l_cnt - 1
  

  CALL cl_showmsg_init()
  LET l_no_cnt = 0   
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt  
         CALL s_transaction_begin() 
         LET l_no_cnt2 = 0 
        #160523-00018#4-s-mark 
        ##若為銷售多角，需做各據點多角結案
        #LET l_pmdl006 = ''
        #LET l_pmdl031 = ''
        #LET l_pmdl051 = ''         
        #SELECT pmdl006,pmdl031,pmdl051
        #  INTO l_pmdl006,l_pmdl031,l_pmdl051
        #  FROM pmdl_t
        # WHERE pmdlent = g_enterprise
        #   AND pmdlsite = g_site
        #   AND pmdldocno = l_pmdl_d[i].pmdldocno 
        #160523-00018#4-e-mark    
         #抓取TMP單身資料做狀態取消結案
         LET l_sql = "SELECT pmdndocno,pmdnseq ",
                     "  FROM apmp510_tmp ",
                     " WHERE pmdndocno = '",l_pmdl_d[i].pmdldocno,"'",
                     "   AND sel2 = 'Y' "
         PREPARE apmp510_sel_tmp_pr FROM l_sql
         DECLARE apmp510_sel_tmp_cs CURSOR FOR apmp510_sel_tmp_pr
         FOREACH apmp510_sel_tmp_cs INTO l_pmdndocno,l_pmdnseq
           #單身狀態取消結案
           IF NOT s_apmp510_pmdn045_unclosed(l_pmdndocno,l_pmdnseq,g_site) THEN                 
              LET l_no_cnt2 = l_no_cnt2 + 1
           #160523-00018#4-s-mark
           #ELSE              
           #   IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN              #多角單據結案 
           #      CALL apmp510_aic_closed('2',l_pmdnseq,'',l_pmdl031,l_pmdl051)
           #   END IF
           #160523-00018#4-e-mark
           END IF 
         END FOREACH
         #取消結案，更新單頭狀態為Y，物流結案為N
         IF NOT s_apmp510_pmdl047_unclosed(l_pmdl_d[i].pmdldocno,g_site) THEN         
            LET l_no_cnt2 = l_no_cnt2 + 1
        #160523-00018#4-s-mark    
        #ELSE            
        #   IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN              #多角單據結案
        #      CALL apmp510_aic_closed('2',0,'',l_pmdl031,l_pmdl051)
        #   END IF
        #160523-00018#4-e-mark
         END IF
         IF l_no_cnt2 = 0 THEN
            CALL s_transaction_end("Y","0")
         ELSE
            CALL s_transaction_end("N","0")
            LET l_no_cnt = l_no_cnt + 1
         END IF  
      END FOR
  END IF  
  IF l_no_cnt > 0 THEN
     CALL cl_showmsg()   
  END IF
END FUNCTION
################################################################################
# Descriptions...: 請購單結案
# Memo...........: 請購單多角單據結案作業
# Usage..........: CALL apmp510_aic_closed(p_type,p_pmdnseq,p_pmdn051,p_pmdl031,p_pmdl051)                     
# Input parameter: p_type         狀態 1.結案 2取消結案
#                : p_pmdnseq      請購單項次
#                : p_pmdn051      結案理由碼
#                : p_pmdl031      多角來源單號
#                : p_pmdn050      多角流程式碼
# Return code....: 
# Date & Author..: 2014-08-20     Polly
# Modify.........: #160523-00018#4   By polly 移至s_axmp510處理
################################################################################
PRIVATE FUNCTION apmp510_aic_closed(p_type,p_pmdnseq,p_pmdn051,p_pmdl031,p_pmdl051)
   DEFINE p_type      LIKE type_t.num5          #型態1結案；2取消結案
   DEFINE p_pmdnseq   LIKE pmdn_t.pmdnseq       #請購單項次
   DEFINE p_pmdn051   LIKE pmdn_t.pmdn051       #結案理由碼 
   DEFINE p_pmdl031   LIKE pmdl_t.pmdl031       #多角來源單號
   DEFINE p_pmdl051   LIKE pmdl_t.pmdl051       #多角流程代碼
   DEFINE l_icab003   LIKE icab_t.icab003       #多角營運據點
   DEFINE l_pmdldocno LIKE pmdl_t.pmdldocno     #採購單單號
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno     #工單單號
   DEFINE l_xmdadocno LIKE xmda_t.xmdadocno     #訂單單號
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   

   LET l_sql = "SELECT icab003 ",
               "  FROM icaa_t,icab_t ",
               " WHERE icaaent = '",g_enterprise,"' " ,
               "   AND icaasite = '",g_site,"' " ,
               "   AND icaa001 = '",p_pmdl051,"' " ,
               "   AND icaa001 = icab001 "
               
   PREPARE s_apmp510_sel_pr_aic FROM l_sql
   DECLARE s_apmp510_sel_cs_aic CURSOR FOR s_apmp510_sel_pr_aic
   
   #各站營運據點依多角流程序號取得各站 請購單/採購單/工單 單號做結案
   FOREACH s_apmp510_sel_cs_aic INTO l_icab003           
      #訂單單號
      LET l_xmdadocno = ''
      SELECT xmdadocno INTO l_xmdadocno
        FROM xmda_t
       WHERE xmdaent = g_enterprise
         AND xmdasite = l_icab003
         AND xmda031 = p_xmda031
      IF NOT cl_null(l_xmdadocno) THEN
         IF p_type = 1 THEN
            #結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_axmp510_xmdc045_closed('2',l_xmdadocno,p_pmdnseq,p_pmdl051,l_icab003) RETURNING l_success 
            ELSE                  
               CALL s_axmp510_xmda045_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmda046_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmda047_closed(l_xmdadocno,l_icab003) RETURNING l_success
               CALL s_axmp510_xmdastus_closed('2',l_xmdadocno,l_icab003) RETURNING l_success
            END IF                   
         ELSE
            #取消結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_axmp510_xmdc045_unclosed(l_xmdadocno,p_pmdnseq,l_icab003) RETURNING l_success 
            ELSE                
               CALL s_axmp510_xmda045_unclosed(l_xmdadocno,l_icab003) RETURNING l_success                  
            END IF
         END IF             
      END IF                       
      #採購單單號
      LET l_pmdldocno = ''
      SELECT pmdldocno INTO l_pmdldocno
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdlsite = l_icab003
         AND pmdl031 = p_pmdl031
      IF NOT cl_null(l_pmdldocno) THEN
         IF p_type = 1 THEN
            #結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_apmp510_pmdn045_closed('2',l_pmdldocno,p_pmdnseq,p_pmdn051,l_icab003) RETURNING l_success 
            ELSE                  
               CALL s_apmp510_pmdl047_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdl048_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdl049_closed(l_pmdldocno,l_icab003) RETURNING l_success
               CALL s_apmp510_pmdlstus_closed('2',l_pmdldocno,l_icab003) RETURNING l_success
            END IF                   
         ELSE
            #取消結案
            IF NOT p_pmdnseq > 0 THEN
               CALL s_apmp510_pmdn045_unclosed(l_pmdldocno,p_pmdnseq,l_icab003) RETURNING l_success 
            ELSE                
               CALL s_apmp510_pmdl047_unclosed(l_pmdldocno,l_icab003) RETURNING l_success                  
            END IF
         END IF                
      END IF
      ##工單單號
      #LET l_sfaadocno = ''
      #SELECT sfaadocno INTO l_sfaadocno
      #  FROM sfaa_t
      # WHERE sfaaent = g_enterprise
      #   AND sfaasite = l_icab003
      #   AND sfaa067 = p_pmdl031
      #IF NOT cl_null(l_sfaadocno) THEN
      #   IF p_type = 1 THEN
      #      #結案
      #   END IF            
      #END IF                    
   END FOREACH   
END FUNCTION

################################################################################
# Descriptions...: 留置/取消留置
# Memo...........:
# Usage..........: CALL apmp510_hold_upd(p_type)
# Input parameter: p_type         狀態 1.結案 2取消結案
# Return code....: 
# Date & Author..: 2015/01/22 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apmp510_hold_upd(p_type)
DEFINE p_type            LIKE type_t.chr1
DEFINE l_pmdl_d          DYNAMIC ARRAY OF RECORD
         pmdldocno       LIKE pmdl_t.pmdldocno,
         pmdl043         LIKE pmdl_t.pmdl043
                         END RECORD   
DEFINE l_sql             STRING
DEFINE l_pmdndocno       LIKE pmdn_t.pmdndocno
DEFINE l_pmdnseq         LIKE pmdn_t.pmdnseq
DEFINE l_closed          LIKE pmdn_t.pmdn051   #留置理由碼    
DEFINE l_pmdn045         LIKE pmdn_t.pmdn045
DEFINE l_pmdn051         LIKE pmdn_t.pmdn051
DEFINE l_pmdlstus        LIKE pmdl_t.pmdlstus
DEFINE i                 LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_cnt2            LIKE type_t.num5
DEFINE l_no_cnt          LIKE type_t.num5      #失敗總筆數
DEFINE l_no_sum          LIKE type_t.num5      #失敗總筆數
DEFINE ld_date           DATETIME YEAR TO SECOND   #add--151110-00030#1--By shiun

  LET l_sql = "SELECT DISTINCT pmdndocno,closed1 ",
              "  FROM apmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE apmp510_hold_upd_pre FROM l_sql
  DECLARE apmp510_hold_upd_cs CURSOR FOR apmp510_hold_upd_pre
  
  LET l_cnt = 1 
  FOREACH apmp510_hold_upd_cs INTO l_pmdl_d[l_cnt].pmdldocno,l_pmdl_d[l_cnt].pmdl043   
    LET l_cnt = l_cnt + 1
  END FOREACH  
  
  CALL l_pmdl_d.deleteElement(l_pmdl_d.getLength())
  LET l_cnt = l_cnt - 1

  CALL cl_err_collect_init()
  LET l_no_sum = 0
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt  
         CALL s_transaction_begin()
         LET l_no_cnt = 0
         #抓取TMP單身資料做狀態留置
         LET l_sql = "SELECT closed2,pmdndocno,pmdnseq",
                     "  FROM apmp510_tmp ",
                     " WHERE pmdndocno = '",l_pmdl_d[i].pmdldocno,"'",
                     "   AND sel2 = 'Y' ",
                     " ORDER BY pmdndocno,pmdnseq "
         PREPARE apmp510_hold_upd_pre1 FROM l_sql
         DECLARE apmp510_hold_upd_cs1 CURSOR FOR apmp510_hold_upd_pre1
         
         FOREACH apmp510_hold_upd_cs1 INTO l_closed,l_pmdndocno,l_pmdnseq
           IF p_type = 1 THEN           #留置
              LET l_pmdn045 = '5'
              LET l_pmdn051 = l_closed
           ELSE                         #取消留置
              LET l_pmdn045 = '1'
              LET l_pmdn051 = ''           
           END IF
           #單身狀態留置
           UPDATE pmdn_t
              SET pmdn045 = l_pmdn045,
                  pmdn051 = l_pmdn051
            WHERE pmdnent = g_enterprise
              AND pmdndocno = l_pmdndocno
              AND pmdnseq = l_pmdnseq
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = l_pmdl_d[i].pmdldocno
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.popup  = TRUE
              CALL cl_err()           
              LET l_no_cnt = l_no_cnt + 1
              LET l_no_sum = l_no_sum + 1
           END IF       
           #add--151110-00030#1--By shiun--(S)
           LET ld_date = cl_get_current()
           #回寫採購單時，一併回寫交期明細裡的異動人員、時間
           UPDATE pmdo_t
              SET pmdo026 = g_user,
                  pmdo027 = ld_date
            WHERE pmdoent = g_enterprise
              AND pmdodocno = l_pmdndocno
              AND pmdoseq = l_pmdnseq
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = l_pmdl_d[i].pmdldocno
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.popup  = TRUE
              CALL cl_err()           
              LET l_no_cnt = l_no_cnt + 1
              LET l_no_sum = l_no_sum + 1
           END IF          
           #add--151110-00030#1--By shiun--(E)
         END FOREACH
         #狀態碼留置/取消留置 (單身全部xmdc045='5'留置時，狀態碼才為"留置H"，不然都是"確認Y"狀態)
         LET l_cnt2 = 0
         LET l_pmdlstus = 'Y'
         SELECT COUNT(*) INTO l_cnt2
           FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdndocno = l_pmdl_d[i].pmdldocno
            AND pmdn045 <> '5'
         IF p_type = '1' AND l_cnt2 = 0 THEN
            LET l_pmdlstus = 'H'
         ELSE
            LET l_pmdl_d[l_cnt].pmdl043 = ''
         END IF
         UPDATE pmdl_t
            SET pmdlstus = l_pmdlstus,
                pmdl043 = l_pmdl_d[l_cnt].pmdl043
          WHERE pmdlent = g_enterprise
            AND pmdldocno = l_pmdl_d[i].pmdldocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_pmdl_d[i].pmdldocno
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()           
            LET l_no_cnt = l_no_cnt + 1
            LET l_no_sum = l_no_sum + 1
         END IF    
         IF l_no_cnt = 0 THEN
            CALL s_transaction_end('Y','0')
         ELSE
            CALL s_transaction_end('N','0')
         END IF
     END FOR
  END IF
  
  CALL cl_err_collect_show()

END FUNCTION

#end add-point
 
{</section>}
 
