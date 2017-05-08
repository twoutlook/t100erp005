#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2015-01-16 17:47:36), PR版次:0016(2017-01-20 10:08:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000227
#+ Filename...: axmp510
#+ Description: 訂單結案作業
#+ Creator....: 02040(2014-04-25 10:27:32)
#+ Modifier...: 02040 -SD/PR- 06948
 
{</section>}
 
{<section id="axmp510.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151111-00018#1   2015/11/11  By Shiun     回寫訂單時，一併回寫交期明細裡的異動人員、時間
#160523-00018#3   2016/05/31  By Polly     增加多角控卡；結案/取消結案需一併調整多角單據
#161109-00085#10  2016/11/10  By lienjunqi 整批調整系統星號寫法
#161207-00033#3   2016/12/20  By 08992     一次性交易對象顯示說明，所以的客戶/供應商欄位都應該處理
#170112-00054#1   2017/01/19  By wuxja     订单做结案取消结案时需同步更新"库存需求等候明细档“资料
#170118-00059#1   2017/01/20  By 06948     塞進temp table的資料以及撈取xmdc_t時增加帶入ent及site的條件
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
          xmdadocno      LIKE   xmda_t.xmdadocno,
          xmdadocdt      LIKE   xmda_t.xmdadocdt,
          xmda004        LIKE   xmda_t.xmda004,
          xmda004_desc   LIKE   type_t.chr500,          
          xmda033        LIKE   xmda_t.xmda033,
          xmda002        LIKE   xmda_t.xmda002,
          xmda002_desc   LIKE   type_t.chr500,
          xmda003        LIKE   xmda_t.xmda003,
          xmda003_desc   LIKE   type_t.chr500,
          xmda005        LIKE   xmda_t.xmda005,                
          xmda009        LIKE   xmda_t.xmda009,
          xmda009_desc   LIKE   type_t.chr500, 
          xmda010        LIKE   xmda_t.xmda010,
          xmda010_desc   LIKE   type_t.chr500,
          xmda011        LIKE   xmda_t.xmda011,
          xmda011_desc   LIKE   type_t.chr500,
          xmda012        LIKE   xmda_t.xmda012,
          xmda013        LIKE   xmda_t.xmda013,          
          xmda015        LIKE   xmda_t.xmda015,
          xmda015_desc   LIKE   type_t.chr500,
          xmda031        LIKE   xmda_t.xmda031          
          END RECORD
TYPE type_g_xmdc_d RECORD
          sel2           LIKE   type_t.chr1,
          closed2        LIKE   pmdb_t.pmdb051,
          closed2_desc   LIKE   type_t.chr500,
          xmdcdocno      LIKE   xmdc_t.xmdcdocno,
          xmdcseq        LIKE   xmdc_t.xmdcseq,
          xmdc001        LIKE   xmdc_t.xmdc001,
          xmdc001_desc   LIKE   type_t.chr500, 
          imaal004_1     LIKE   type_t.chr80,          
          xmdc002        LIKE   xmdc_t.xmdc002,
          xmdc002_desc   LIKE   type_t.chr500,
          xmdc019        LIKE   xmdc_t.xmdc019,
          xmdc004        LIKE   xmdc_t.xmdc004,
          xmdc004_desc   LIKE   type_t.chr500,           
          xmdc005        LIKE   xmdc_t.xmdc005,
          xmdc006        LIKE   xmdc_t.xmdc006,
          xmdc006_desc   LIKE   type_t.chr500,         
          xmdc007        LIKE   xmdc_t.xmdc007,
          xmdd014_1      LIKE   xmdd_t.xmdd014,     #已出貨量
          unxmdd014_1    LIKE   xmdd_t.xmdd014      #未出貨數量             
          END RECORD
TYPE type_g_xmdd_d RECORD
          xmdddocno     LIKE    xmdd_t.xmdddocno,
          xmddseq       LIKE    xmdd_t.xmddseq,
          xmddseq1      LIKE    xmdd_t.xmddseq1,
          xmdd003       LIKE    xmdd_t.xmdd003,
          xmdd001       LIKE    xmdd_t.xmdd001,
          xmdd001_desc  LIKE    type_t.chr500,
          imaal004_2    LIKE    type_t.chr80,
          xmdd002       LIKE    xmdd_t.xmdd002,
          xmdd004       LIKE    xmdd_t.xmdd004,
          xmdd004_desc  LIKE    type_t.chr500,
          xmddseq2      LIKE    xmdd_t.xmddseq2,
          xmdd006       LIKE    xmdd_t.xmdd006,
          xmdd031       LIKE    xmdd_t.xmdd031,
          xmdd014       LIKE    xmdd_t.xmdd014,  
          xmdd016       LIKE    xmdd_t.xmdd016,
          unxmdd014_2   LIKE    xmdd_t.xmdd014
          END RECORD
TYPE type_g_xmdb_d RECORD 
          xmdb001       LIKE    xmdb_t.xmdb001,
          xmdbdocno     LIKE    xmdb_t.xmdbdocno,
          xmdb002       LIKE    xmdb_t.xmdb002,
          xmdb002_desc  LIKE    type_t.chr500,
          xmdb003       LIKE    xmdb_t.xmdb003,
          xmdb004       LIKE    xmdb_t.xmdb004,
          xmdb005       LIKE    xmdb_t.xmdb005,
          xmdb006       LIKE    xmdb_t.xmdb006,
          xmdb007       LIKE    xmdb_t.xmdb007,
          xmdb008       LIKE    xmdb_t.xmdb008,
          xmdb009       LIKE    xmdb_t.xmdb009
          END RECORD  
TYPE type_g_xmdh_d RECORD
          xmdh001       LIKE    xmdh_t.xmdh001,
          xmdh002       LIKE    xmdh_t.xmdh002,
          xmdh006       LIKE    xmdh_t.xmdh006,
          xmdh006_desc  LIKE    type_t.chr500,
          imaal004      LIKE    type_t.chr80,
          xmdh007       LIKE    xmdh_t.xmdh007,
          xmdh015       LIKE    xmdh_t.xmdh015,
          xmdh015_desc  LIKE    type_t.chr500,
          xmdh017       LIKE    xmdh_t.xmdh017,
          xmdh030       LIKE    xmdh_t.xmdh030,
          unxmdh030     LIKE    xmdh_t.xmdh030
          END RECORD
TYPE type_g_xmdl_d RECORD
          xmdldocno     LIKE    xmdl_t.xmdldocno,
          xmdlseq       LIKE    xmdl_t.xmdlseq,
          xmdl008       LIKE    xmdl_t.xmdl008,
          xmdl008_desc  LIKE    type_t.chr500,
          imaal004_6    LIKE    type_t.chr80,
          xmdl009       LIKE    xmdl_t.xmdl009,
          xmdl017       LIKE    xmdl_t.xmdl017,
          xmdl017_desc  LIKE    type_t.chr500,
          xmdl018       LIKE    xmdl_t.xmdl018,
          xmdl028       LIKE    xmdl_t.xmdl028,
          xrcb119       LIKE    xrcb_t.xrcb119,
          unxrcb119     LIKE    xrcb_t.xrcb119          
          END RECORD
TYPE type_g_xrcc_d RECORD
          xrccdocno     LIKE    xrcc_t.xrccdocno,
          xrccseq       LIKE    xrcc_t.xrccseq,
          xrcc001       LIKE    xrcc_t.xrcc001,
          xrcc003       LIKE    xrcc_t.xrcc003,
          xrcc118       LIKE    xrcc_t.xrcc118,
          xrcc119       LIKE    xrcc_t.xrcc119,
          unxrcc119     LIKE    xrcc_t.xrcc119
          END RECORD
DEFINE g_tmp_d   DYNAMIC ARRAY OF RECORD
            sel2           LIKE   type_t.chr1,
            xmdc053        LIKE   xmdc_t.xmdc053,
            xmdcdocno      LIKE   xmdc_t.xmdcdocno,
            xmdcseq        LIKE   xmdc_t.xmdcseq,
            xmdc007        LIKE   xmdc_t.xmdc007,     #銷售數量
            xmdc040        LIKE   xmdc_t.xmdc040,
            xmdc041        LIKE   xmdc_t.xmdc041,
            xmdc042        LIKE   xmdc_t.xmdc042            
                 END RECORD
               
DEFINE g_type              LIKE type_t.chr1       #1時為結案作業；2時為取消結案作業
DEFINE g_mode              LIKE type_t.chr1
DEFINE g_mode_o            LIKE type_t.chr1
DEFINE g_slip              LIKE ooba_t.ooba001    #單別
DEFINE g_acc               LIKE gzcb_t.gzcb007
DEFINE g_detail_idx        LIKE type_t.num5
DEFINE g_detail2_idx       LIKE type_t.num5
DEFINE g_detail2_cnt       LIKE type_t.num5
DEFINE g_detail3_cnt       LIKE type_t.num5
DEFINE g_detail4_cnt       LIKE type_t.num5
DEFINE g_detail5_cnt       LIKE type_t.num5
DEFINE g_detail6_cnt       LIKE type_t.num5
DEFINE g_detail7_cnt       LIKE type_t.num5

DEFINE g_xmdc_d      DYNAMIC ARRAY OF type_g_xmdc_d  
DEFINE g_xmdb_d      DYNAMIC ARRAY OF type_g_xmdb_d
DEFINE g_xmdd_d      DYNAMIC ARRAY OF type_g_xmdd_d 
DEFINE g_xmdh_d      DYNAMIC ARRAY OF type_g_xmdh_d 
DEFINE g_xmdl_d      DYNAMIC ARRAY OF type_g_xmdl_d 
DEFINE g_xrcc_d      DYNAMIC ARRAY OF type_g_xrcc_d 
DEFINE l_ac1         LIKE type_t.num5
DEFINE g_detail_d_t  type_g_detail_d
DEFINE g_xmdc_d_t    type_g_xmdc_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axmp510.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '')
   IF NOT cl_null(g_argv[1]) THEN
      LET g_type = g_argv[1]
   END IF
  
   CALL axmp510_create_preview_tmp()   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp510 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmp510_init()   
 
      #進入選單 Menu (="N")
      CALL axmp510_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp510
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axmp510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_mode = '1'      #預設結案  
   LET g_mode_o = '1'
   LET g_acc = '284'     #預設結案理由碼
   
   CALL cl_set_comp_visible("b_closed,b_closed_desc,b_closed2,b_closed2_desc",TRUE)
   IF g_type = '2' THEN    
      CALL cl_set_comp_visible("b_closed,b_closed_desc,b_closed2,b_closed2_desc",FALSE)
   END IF

   CALL cl_set_combo_scc('b_xmda005','2063')
   CALL cl_set_combo_scc('b_xmdc019','2055')
   CALL cl_set_combo_scc('b_xmdd003','2055')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_detail2_cnt = g_xmdc_d.getLength()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmp510_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT g_wc ON xmdadocno,xmdadocdt,xmda004,xmda033,xmda002,xmda003
              FROM xmdadocno,xmdadocdt,xmda004,xmda033,xmda002,xmda003

            BEFORE CONSTRUCT
               CALL cl_qbe_init()

            ON ACTION controlp INFIELD xmdadocno
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                IF g_type = '1' THEN
                   LET g_qryparam.where = " xmdastus = 'Y' AND xmdc045 = '1' AND xmda006 <> '5' "
                ELSE
                   CASE g_mode
                     WHEN '1'
                       LET g_qryparam.where = " (xmdastus = 'C' OR ((xmdastus = 'Y' OR xmdastus = 'H') AND xmdc045 IN ('2','3','4'))) AND xmda006 <> '5'  "
                     WHEN '2'
                       LET g_qryparam.where = " ((xmdastus = 'H' OR xmdastus = 'Y') AND xmdc045 = '5')) AND xmda006 <> '5'  "
                   END CASE
                END IF
                CALL q_xmdadocno_7()                             #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmdadocno        #顯示到畫面上
                NEXT FIELD xmdadocno                           #返回原欄位

            ON ACTION controlp INFIELD xmda004               #客戶
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pmaastus = 'Y' "
	      		LET g_qryparam.arg1 = g_site
               CALL q_pmaa001_6()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda004      #顯示到畫面上
               NEXT FIELD xmda004                         #返回原欄位 

            ON ACTION controlp INFIELD xmda033               #客戶
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
                IF g_type = '1' THEN
                   LET g_qryparam.where = " xmdastus = 'Y' AND xmda006 <> '5' "
                ELSE
                   CASE g_mode
                     WHEN '1'
                       LET g_qryparam.where = " (xmdastus = 'C' OR (xmdastus = 'Y')) AND xmda006 <> '5'  "
                     WHEN '2'
                       LET g_qryparam.where = " (xmdastus = 'H' OR (xmdastus = 'Y')) AND xmda006 <> '5'  "
                   END CASE
                END IF
               CALL q_xmda033()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda033      #顯示到畫面上
               NEXT FIELD xmda033                         #返回原欄位 

            ON ACTION controlp INFIELD xmda002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooagstus = 'Y' "               
               CALL q_ooag001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xmda002      #顯示到畫面上
               NEXT FIELD xmda002                         #返回原欄位 

            ON ACTION controlp INFIELD xmda003
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " ooegstus = 'Y' "                
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO xmda003      #顯示到畫面上
                NEXT FIELD xmda003                         #返回原欄位 
                
         END CONSTRUCT                
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_mode FROM l_mode ATTRIBUTE(WITHOUT DEFAULTS)
           ON CHANGE l_mode
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt
                FROM axmp510_tmp
              IF l_cnt > 0 THEN
                 IF cl_ask_confirm('axm-00530') THEN 
                    IF g_mode = 1 THEN
                       LET g_acc = '284'
                    ELSE
                       LET g_acc = '297'
                    END IF
                    DELETE FROM axmp510_tmp                                      
                 ELSE
                    LET g_mode = g_mode_o
                    DISPLAY BY NAME g_mode 
                 END IF
              ELSE
                 IF g_mode = 1 THEN
                    LET g_acc = '284'
                 ELSE
                    LET g_acc = '297'
                 END IF
                                 
              END IF              
              LET g_mode_o = g_mode
              IF NOT cl_null(g_wc) AND g_wc <> ' 1=1'THEN
                 CALL axmp510_query()  
              END IF
         END INPUT
        
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_detail_cnt,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = TRUE)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               LET g_detail_d_t.* = g_detail_d[l_ac].*                     #BACKUP
               IF NOT cl_null(g_detail_d[g_detail_idx].xmdadocno) THEN 
                  CALL axmp510_docno_init()                                #依單別調整畫面欄位顯示
                  CALL axmp510_fetch()                
               END IF                
               CALL axmp510_set_entry()
               CALL axmp510_set_no_entry()            

            ON CHANGE b_sel
               IF g_detail_d[l_ac].sel = 'N' THEN
                  LET g_detail_d[l_ac].closed = ''
                  LET g_detail_d[l_ac].closed_desc = ''
                  DISPLAY BY NAME g_detail_d[l_ac].closed,g_detail_d[l_ac].closed_desc 
              #160523-00018#3-s-add 
               ELSE
                  IF g_type = '1' AND g_mode = 1 THEN
                     IF NOT s_axmp510_aic_chk(g_detail_d[l_ac].xmdadocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00224'   #此多角訂單%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_detail_d[l_ac].xmdadocno 
                        CALL cl_err()                      
                        LET g_detail_d[l_ac].sel = 'N'
                        LET g_detail_d[l_ac].closed = ''
                        LET g_detail_d[l_ac].closed_desc = ''    
                        DISPLAY BY NAME g_detail_d[l_ac].closed,g_detail_d[l_ac].closed_desc                     
                     END IF 
                  END IF   
              #160523-00018#3-e-add 
               END IF  
               
               CALL axmp510_set_entry()
               CALL axmp510_set_no_entry()
                

                
             AFTER FIELD b_closed
                IF NOT cl_null(g_detail_d[l_ac].closed) THEN
                   IF NOT axmp510_xmdc053_chk(g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].closed) THEN
                      NEXT FIELD b_sel
                   END IF   
                ELSE   
                   IF g_detail_d[l_ac].sel = 'Y' THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'axm-00266'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()            
                      NEXT FIELD b_sel                  
                   END IF
                END IF   
                CALL axmp510_closed_ref(g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc                
             
             ON ROW CHANGE 
                IF g_detail_d[l_ac].sel = 'Y' THEN             
                   CALL axmp510_upd_tmp('2','Y',g_detail_d[l_ac].xmdadocno,'',g_detail_d[l_ac].closed)
                ELSE
                   CALL axmp510_upd_tmp('2','N',g_detail_d[l_ac].xmdadocno,'','')
                END IF                     
                CALL axmp510_fetch()         
                
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
                CALL axmp510_closed_ref(g_detail_d[l_ac].closed) RETURNING g_detail_d[l_ac].closed_desc
                DISPLAY BY NAME g_detail_d[l_ac].closed_desc
                NEXT FIELD b_closed           
               
         END INPUT                
 
 
         INPUT ARRAY g_xmdc_d FROM s_detail2.*
            ATTRIBUTE(COUNT = g_detail2_cnt,MAXCOUNT = g_detail2_cnt,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = TRUE)
           BEFORE ROW
              LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
              LET l_ac1 = g_detail2_idx
              LET g_xmdc_d_t.* = g_xmdc_d[l_ac1].*                     #BACKUP
              CALL axmp510_set_entry_b()
              CALL axmp510_set_no_entry_b()             

           ON CHANGE b_sel2
              IF g_xmdc_d[l_ac1].sel2 = 'N' THEN
                 LET g_xmdc_d[l_ac1].closed2 = ''
                 LET g_xmdc_d[l_ac1].closed2_desc = '' 
                 DISPLAY BY NAME g_xmdc_d[l_ac1].closed2,g_xmdc_d[l_ac1].closed2_desc 
              #160523-00018#3-s-add 
               ELSE 
                  IF g_type = '1' AND g_mode = 1 THEN               
                     IF NOT s_axmp510_aic_chk(g_xmdc_d[l_ac1].xmdcdocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00224'   #此多角訂單%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_xmdc_d[l_ac1].xmdcdocno 
                        CALL cl_err()                      
                        LET g_xmdc_d[l_ac1].sel2 = 'N' 
                        LET g_xmdc_d[l_ac1].closed2 = ''
                        LET g_xmdc_d[l_ac1].closed2_desc = ''    
                        DISPLAY BY NAME g_xmdc_d[l_ac1].sel2,g_xmdc_d[l_ac1].closed2,g_xmdc_d[l_ac1].closed2_desc                      
                     END IF   
                  END IF   
              #160523-00018#3-e-add                  
              END IF 
              CALL axmp510_set_entry_b()
              CALL axmp510_set_no_entry_b() 
                         

           ON ACTION controlp INFIELD b_closed2
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_xmdc_d[l_ac1].closed2             #給予default值
              #給予arg
              LET g_qryparam.arg1 = g_acc
              CALL q_oocq002()                                                #呼叫開窗
              LET g_xmdc_d[l_ac1].closed2 = g_qryparam.return1                #將開窗取得的值回傳到變數
              DISPLAY g_xmdc_d[l_ac1].closed2 TO b_closed2                    #顯示到畫面上
              CALL axmp510_closed_ref(g_xmdc_d[l_ac1].closed2) RETURNING g_xmdc_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_xmdc_d[l_ac1].closed2_desc
              NEXT FIELD b_closed2

          AFTER FIELD b_closed2
              IF NOT cl_null(g_xmdc_d[l_ac1].closed2) THEN
                  IF NOT axmp510_xmdc053_chk(g_xmdc_d[l_ac1].xmdcdocno,g_xmdc_d[l_ac1].closed2) THEN
                     NEXT FIELD b_sel2
                  END IF
              ELSE
                IF g_xmdc_d[l_ac1].sel2 = 'Y' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'axm-00266'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()            
                   NEXT FIELD b_sel2
                END IF                   
              END IF
              CALL axmp510_closed_ref(g_xmdc_d[l_ac1].closed2) RETURNING g_xmdc_d[l_ac1].closed2_desc
              DISPLAY BY NAME g_xmdc_d[l_ac1].closed2_desc              

          AFTER ROW                
              IF g_xmdc_d[l_ac1].sel2 = 'Y' THEN
                 CALL axmp510_upd_tmp('3','Y',g_xmdc_d[l_ac1].xmdcdocno,g_xmdc_d[l_ac1].xmdcseq,g_xmdc_d[l_ac1].closed2)
              ELSE
                 CALL axmp510_upd_tmp('3','N',g_xmdc_d[l_ac1].xmdcdocno,g_xmdc_d[l_ac1].xmdcseq,g_xmdc_d[l_ac1].closed2)
              END IF                    
   
         END INPUT         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xmdd_d TO s_detail3.* ATTRIBUTES(COUNT = g_detail3_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2

         END DISPLAY

         DISPLAY ARRAY g_xmdb_d TO s_detail4.* ATTRIBUTES(COUNT = g_detail4_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3

         END DISPLAY

         DISPLAY ARRAY g_xmdh_d TO s_detail5.* ATTRIBUTES(COUNT = g_detail5_cnt)
            BEFORE DISPLAY
               LET g_current_page = 4

         END DISPLAY

         DISPLAY ARRAY g_xmdl_d TO s_detail6.* ATTRIBUTES(COUNT = g_detail6_cnt)
            BEFORE DISPLAY
               LET g_current_page = 5

         END DISPLAY
         
         DISPLAY ARRAY g_xrcc_d TO s_detail7.* ATTRIBUTES(COUNT = g_detail7_cnt)
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
               #160523-00018#3-s-add 
               IF g_type = '1' AND g_mode = 1 THEN
                  IF NOT s_axmp510_aic_chk(g_detail_d[li_idx].xmdadocno) THEN
                     LET g_detail_d[li_idx].sel = 'N'
                     CONTINUE FOR
                  END IF
               END IF   
              #160523-00018#3-e-add                
               CALL axmp510_upd_tmp('2','Y',g_detail_d[li_idx].xmdadocno,'',g_detail_d[li_idx].closed)
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL axmp510_fetch()
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               LET g_detail_d[li_idx].closed = ''
               LET g_detail_d[li_idx].closed_desc = ''
               CALL axmp510_upd_tmp('2','N',g_detail_d[li_idx].xmdadocno,'','')
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            CALL axmp510_fetch()
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
                 #160523-00018#3-s-add 
                  IF g_type = '1' AND g_mode = 1 THEN
                     IF NOT s_axmp510_aic_chk(g_detail_d[li_idx].xmdadocno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'aic-00224'   #此多角訂單%1仍有未拋轉單據，不可結案！
                        LET g_errparam.popup  = TRUE
                        LET g_errparam.replace[1] = g_detail_d[li_idx].xmdadocno                    
                        CALL cl_err()  
                        LET g_detail_d[li_idx].sel = 'N'
                        CONTINUE FOR
                     END IF
                  END IF   
                 #160523-00018#3-e-add                    
                  LET g_detail_d[li_idx].sel = "Y"
                  CALL axmp510_upd_tmp('2','Y',g_detail_d[li_idx].xmdadocno,'',g_detail_d[li_idx].closed)
               END IF
            END FOR 
            CALL axmp510_fetch()            
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
                  CALL axmp510_upd_tmp('2','N',g_detail_d[li_idx].xmdadocno,'','')
               END IF
            END FOR
            CALL axmp510_fetch()
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axmp510_filter()
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
            CALL axmp510_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axmp510_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute              #執行         
            
            IF axmp510_execute_chk() THEN
               IF g_type = '1' THEN
                  CASE g_mode 
                    WHEN '1'   #結案
                      CALL axmp510_closed_upd()
                    WHEN '2'   #留置
                      CALL axmp510_hold_upd(g_type)
                  END CASE                                    
               ELSE
                  CASE g_mode 
                    WHEN '1'   #取消結案
                      CALL axmp510_unclosed_upd()
                    WHEN '2'   #取消留置
                      CALL axmp510_hold_upd(g_type)
                  END CASE                                    
               END IF
               CALL cl_ask_confirm3("std-00012","")                 
               IF cl_ask_confirm('asf-00182') THEN
                  CLEAR FORM
                  CALL g_detail_d.clear()
                  CALL g_xmdc_d.clear()
                  CALL g_xmdd_d.clear()
                  CALL g_xmdb_d.clear()
                  CALL g_xmdh_d.clear()
                  CALL g_xmdl_d.clear()
                  CALL g_xrcc_d.clear()
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
 
{<section id="axmp510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmp510_query()
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
      LET g_wc = ' 1=1'
   END IF   
   LET g_wc2 = ''
   IF g_type = '1' THEN
      LET g_wc2 = " xmdastus = 'Y' AND xmdc045 = '1' "
   ELSE
     CASE g_mode
       WHEN '1'
         LET g_wc2 = " (xmdastus = 'C' OR ((xmdastus = 'Y' OR xmdastus = 'H') AND xmdc045 IN ('2','3','4')))  "
       WHEN '2'
         LET g_wc2 = " ((xmdastus = 'H' OR xmdastus = 'Y') AND xmdc045 = '5') "
     END CASE
   END IF
   LET l_sql = "SELECT DISTINCT '','',xmdcdocno,xmdcseq,xmdc007, ",
               "       xmdc040,xmdc041,xmdc042 ",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdcdocno = xmdadocno ",
               "   AND xmdaent = xmdcent",               #170118-00059#1 add
               "   AND xmdasite = xmdcsite",             #170118-00059#1 add
               "   AND xmdaent = '",g_enterprise,"' " ,
               "   AND xmdasite = '",g_site,"' " ,
               "   AND xmda006 <> '5' ",                      #需排除多角性質為5中間交易的單據
               "   AND ",g_wc ,
               "   AND ",g_wc2
   PREPARE axmp510_sel_pr_tmp FROM l_sql
   DECLARE axmp510_sel_cs_tmp CURSOR FOR axmp510_sel_pr_tmp
   #清空tmptable
   DELETE FROM axmp510_tmp
   LET l_cnt = 1
   #mod--161109-00085#10-s
   #FOREACH axmp510_sel_cs_tmp INTO g_tmp_d[l_cnt].*
   FOREACH axmp510_sel_cs_tmp 
   INTO g_tmp_d[l_cnt].sel2,g_tmp_d[l_cnt].xmdc053,g_tmp_d[l_cnt].xmdcdocno,g_tmp_d[l_cnt].xmdcseq,g_tmp_d[l_cnt].xmdc007,
        g_tmp_d[l_cnt].xmdc040,g_tmp_d[l_cnt].xmdc041,g_tmp_d[l_cnt].xmdc042
   #mod--161109-00085#10-e
       LET g_tmp_d[l_cnt].sel2 = 'N'
       #mod--161109-00085#10-s
       #INSERT INTO axmp510_tmp VALUES(g_tmp_d[l_cnt].*)
       INSERT INTO axmp510_tmp 
       (sel2,closed2,xmdcdocno,xmdcseq,xmdc007,
        xmdc040,xmdc041,xmdc042)
       VALUES(g_tmp_d[l_cnt].sel2,
              g_tmp_d[l_cnt].xmdc053,
              g_tmp_d[l_cnt].xmdcdocno,
              g_tmp_d[l_cnt].xmdcseq,
              g_tmp_d[l_cnt].xmdc007,
              g_tmp_d[l_cnt].xmdc040,
              g_tmp_d[l_cnt].xmdc041,
              g_tmp_d[l_cnt].xmdc042)
       #mod--161109-00085#10-e
       LET l_cnt = l_cnt + 1
   END FOREACH
   CALL g_tmp_d.deleteElement(l_cnt)   
   #end add-point
        
   LET g_error_show = 1
   CALL axmp510_b_fill()
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
 
{<section id="axmp510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmp510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_pmaa004       LIKE pmaa_t.pmaa004   #法人類型            #161207-00033#3 add
   DEFINE l_pmak003       LIKE pmak_t.pmak003   #一次性交易對象全名   #161207-00033#3 add
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_sql = "SELECT DISTINCT xmdadocno,xmdadocdt,xmda004,'',xmda033,xmda002, ",
               "       '',xmda003,'',xmda005,xmda009, ",
               "       '',xmda010,'',xmda011,'', ",
               "        xmda012,xmda013,xmda015,'',xmda031 ",
               #161207-00033#3-s
               "      ,(SELECT pmaa004 FROM pmaa_t WHERE pmaaent=xmdaent AND pmaa001=xmda004)",
               #161207-00033#3-e
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ? ",
               "   AND xmdaent = xmdcent",               #170118-00059#1 add
               "   AND xmdasite = xmdcsite",             #170118-00059#1 add
               "   AND xmdasite = '",g_site,"' ",
               "   AND xmda006 <> '5' ",                      #需排除多角性質為5中間交易的單據
               "   AND xmdadocno = xmdcdocno ",
               "   AND ",g_wc ,
               "   AND ",g_wc2 ,
               " ORDER BY xmdadocno "               
   #end add-point
 
   PREPARE axmp510_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axmp510_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   LET g_detail_idx = 1
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].xmdadocno,g_detail_d[l_ac].xmdadocdt,g_detail_d[l_ac].xmda004,
   g_detail_d[l_ac].xmda004_desc,g_detail_d[l_ac].xmda033,g_detail_d[l_ac].xmda002,
   g_detail_d[l_ac].xmda002_desc,g_detail_d[l_ac].xmda003,g_detail_d[l_ac].xmda003_desc,
   g_detail_d[l_ac].xmda005,g_detail_d[l_ac].xmda009,g_detail_d[l_ac].xmda009_desc,
   g_detail_d[l_ac].xmda010,g_detail_d[l_ac].xmda010_desc,g_detail_d[l_ac].xmda011,
   g_detail_d[l_ac].xmda011_desc,g_detail_d[l_ac].xmda012,g_detail_d[l_ac].xmda013,
   g_detail_d[l_ac].xmda015,g_detail_d[l_ac].xmda015_desc,g_detail_d[l_ac].xmda031                          
   ,l_pmaa004   #161207-00033#3 add
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
      IF g_type = '1' THEN
         IF NOT s_axmp510_xmdadocno_chk(g_detail_d[l_ac].xmdadocno) THEN
            CONTINUE FOREACH
         END IF
      END IF
      #160422-00027 by whitney add end
      LET g_detail_d[l_ac].sel = 'N'
      CALL axmp510_xmda002_ref(g_detail_d[l_ac].xmda002) RETURNING g_detail_d[l_ac].xmda002_desc
      CALL axmp510_xmda003_ref(g_detail_d[l_ac].xmda003) RETURNING g_detail_d[l_ac].xmda003_desc  
      CALL axmp510_xmda004_ref(g_detail_d[l_ac].xmda004) RETURNING g_detail_d[l_ac].xmda004_desc
      CALL axmp510_xmda009_ref(g_detail_d[l_ac].xmda009) RETURNING g_detail_d[l_ac].xmda009_desc 
      CALL axmp510_xmda010_ref(g_detail_d[l_ac].xmda010) RETURNING g_detail_d[l_ac].xmda010_desc 
      CALL axmp510_xmda011_ref(g_detail_d[l_ac].xmda011) RETURNING g_detail_d[l_ac].xmda011_desc 
      CALL axmp510_xmda015_ref(g_detail_d[l_ac].xmda015) RETURNING g_detail_d[l_ac].xmda015_desc 
      #161207-00033#3-s
      IF l_pmaa004 = '2' THEN   #2.一次性交易對象
         #一次性交易對象全名
         CALL s_desc_axm_get_oneturn_guest_desc('1',g_detail_d[l_ac].xmdadocno)
              RETURNING l_pmak003
         
         IF NOT cl_null(l_pmak003) THEN
            LET g_detail_d[l_ac].xmda004_desc = l_pmak003
         END IF
      END IF
      #161207-00033#3-e     
      #end add-point
      
      CALL axmp510_detail_show()      
 
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
   IF g_detail_d.getLength() > 0 THEN
      CALL axmp510_docno_init()                               #依單別調整畫面欄位顯示
   END IF   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axmp510_sel
   
   LET l_ac = 1
   CALL axmp510_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmp510_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   DEFINE l_sql           STRING
   DEFINE i               LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE ooba_t.ooba001    #單別
   DEFINE l_xmdd014       LIKE xmdd_t.xmdd014
   DEFINE l_xrcadocno     LIKE xrca_t.xrcadocno
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
         
   IF cl_null(g_detail_idx) OR g_detail_idx <=0 THEN
      RETURN
   END IF   
   INITIALIZE g_xmdc_d TO NULL    
   LET l_sql = "SELECT a.sel2,a.closed2,'',a.xmdcdocno,a.xmdcseq, ",
               "       b.xmdc001,'','',b.xmdc002,'',b.xmdc019, ",
               "       b.xmdc004,'',b.xmdc005,b.xmdc006,'', ",
               #161109-00085#10-s
               #"       b.xmdc007,'','','' ",
               "       b.xmdc007,'','' ",
               #161109-00085#10-e
               "  FROM axmp510_tmp a ,xmdc_t b ",
               " WHERE a.xmdcdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'" ,
               "   AND a.xmdcdocno = b.xmdcdocno ",
               "   AND a.xmdcseq = b.xmdcseq ",
               "   AND b.xmdcent = '",g_enterprise,"' ",    #170118-00059#1 add
			      "   AND b.xmdcsite = '",g_site,"' ",         #170118-00059#1 add
               " ORDER BY a.xmdcdocno,a.xmdcseq "
               
   PREPARE axmp510_sel_xmdc_pr FROM l_sql
   DECLARE axmp510_sel_xmdc_cs CURSOR FOR axmp510_sel_xmdc_pr 
   LET l_cnt = 1
   #161109-00085#10-s
   #FOREACH axmp510_sel_xmdc_cs INTO g_xmdc_d[l_cnt].*
   FOREACH axmp510_sel_xmdc_cs 
   INTO g_xmdc_d[l_cnt].sel2,g_xmdc_d[l_cnt].closed2,g_xmdc_d[l_cnt].closed2_desc,g_xmdc_d[l_cnt].xmdcdocno,g_xmdc_d[l_cnt].xmdcseq,
        g_xmdc_d[l_cnt].xmdc001,g_xmdc_d[l_cnt].xmdc001_desc,g_xmdc_d[l_cnt].imaal004_1,g_xmdc_d[l_cnt].xmdc002,g_xmdc_d[l_cnt].xmdc002_desc,
        g_xmdc_d[l_cnt].xmdc019,g_xmdc_d[l_cnt].xmdc004,g_xmdc_d[l_cnt].xmdc004_desc,g_xmdc_d[l_cnt].xmdc005,g_xmdc_d[l_cnt].xmdc006,
        g_xmdc_d[l_cnt].xmdc006_desc,g_xmdc_d[l_cnt].xmdc007,g_xmdc_d[l_cnt].xmdd014_1,g_xmdc_d[l_cnt].unxmdd014_1   
   #161109-00085#10-e
       LET l_xmdd014 = 0
       IF NOT cl_null(g_detail_d[g_detail_idx].xmdadocno) THEN
          IF cl_get_doc_para(g_enterprise,g_site,g_slip,'D-BAS-0077') = 'Y' THEN            #訂單需走出通單
             CALL s_axmt500_count_min_xmdd014(g_xmdc_d[l_cnt].xmdcdocno,g_xmdc_d[l_cnt].xmdcseq,'1',g_site)    #出通數量最小套數
             RETURNING l_xmdd014,l_success  
             LET g_xmdc_d[l_cnt].xmdd014_1 = l_xmdd014    #已出通數量

          ELSE
             CALL s_axmt500_count_min_xmdd014(g_xmdc_d[l_cnt].xmdcdocno,g_xmdc_d[l_cnt].xmdcseq,'2',g_site)    #出貨數量最小套數
             RETURNING l_xmdd014,l_success 
             LET g_xmdc_d[l_cnt].xmdd014_1 = l_xmdd014    #已出貨數量
         END IF
       END IF      
       LET g_xmdc_d[l_cnt].unxmdd014_1 = g_xmdc_d[l_cnt].xmdc007 - g_xmdc_d[l_cnt].xmdd014_1
       CALL axmp510_closed_ref(g_xmdc_d[l_cnt].closed2) RETURNING g_xmdc_d[l_cnt].closed2_desc
       CALL axmp510_xmdc001_ref(g_xmdc_d[l_cnt].xmdc001) RETURNING g_xmdc_d[l_cnt].xmdc001_desc,g_xmdc_d[l_cnt].imaal004_1
       CALL s_feature_description(g_xmdc_d[l_cnt].xmdc001,g_xmdc_d[l_cnt].xmdc002) RETURNING l_success,g_xmdc_d[l_cnt].xmdc002_desc
       CALL axmp510_xmdc004_ref(g_xmdc_d[l_cnt].xmdc004) RETURNING g_xmdc_d[l_cnt].xmdc004_desc
       CALL axmp510_unit_ref(g_xmdc_d[l_cnt].xmdc006) RETURNING g_xmdc_d[l_cnt].xmdc006_desc          
       LET l_cnt = l_cnt + 1      
   END FOREACH
   CALL g_xmdc_d.deleteElement(g_xmdc_d.getLength())
   LET g_detail2_cnt = l_cnt - 1   
   #帶出訂單交期明細
   INITIALIZE g_xmdd_d TO NULL
   LET l_sql = "SELECT xmdddocno,xmddseq,xmddseq1,xmdd003,xmdd001, ",
               "       '','',xmdd002,xmdd004,'', ",
               "       xmddseq2,xmdd006,xmdd031,xmdd014,xmdd016, ",
               "       '' ",
               "  FROM xmdd_t ",
               " WHERE xmddent = '",g_enterprise,"' ",
               "   AND xmddsite = '",g_site,"' ",
               "   AND xmdddocno = '",g_detail_d[g_detail_idx].xmdadocno,"'"
   PREPARE axmp510_sel_xmdd_pr FROM l_sql
   DECLARE axmp510_sel_xmdd_cs CURSOR FOR axmp510_sel_xmdd_pr 
   LET l_cnt = 1
   #161109-00085#10-s
   #FOREACH axmp510_sel_xmdd_cs INTO g_xmdd_d[l_cnt].*
   FOREACH axmp510_sel_xmdd_cs 
   INTO  g_xmdd_d[l_cnt].xmdddocno,g_xmdd_d[l_cnt].xmddseq,g_xmdd_d[l_cnt].xmddseq1,g_xmdd_d[l_cnt].xmdd003,g_xmdd_d[l_cnt].xmdd001,    
         g_xmdd_d[l_cnt].xmdd001_desc,g_xmdd_d[l_cnt].imaal004_2,g_xmdd_d[l_cnt].xmdd002,g_xmdd_d[l_cnt].xmdd004,g_xmdd_d[l_cnt].xmdd004_desc,
         g_xmdd_d[l_cnt].xmddseq2,g_xmdd_d[l_cnt].xmdd006,g_xmdd_d[l_cnt].xmdd031,g_xmdd_d[l_cnt].xmdd014,g_xmdd_d[l_cnt].xmdd016,    
         g_xmdd_d[l_cnt].unxmdd014_2   
   #161109-00085#10-e
       IF NOT cl_null(g_detail_d[g_detail_idx].xmdadocno) THEN
          IF cl_get_doc_para(g_enterprise,g_site,g_slip,'D-BAS-0077') = 'Y' THEN            #訂單需走出通單
             #未出通量 = 分批數量 - 已轉出通量
             LET g_xmdd_d[l_cnt].unxmdd014_2 = g_xmdd_d[l_cnt].xmdd006 - g_xmdd_d[l_cnt].xmdd031
          ELSE
             #未出貨量 = 分批數量 - 已出貨量 + 銷退換貨數量
             LET g_xmdd_d[l_cnt].unxmdd014_2 = g_xmdd_d[l_cnt].xmdd006 - g_xmdd_d[l_cnt].xmdd014 - g_xmdd_d[l_cnt].xmdd016
         END IF
       END IF
       CALL axmp510_xmdc001_ref(g_xmdd_d[l_cnt].xmdd001) RETURNING g_xmdd_d[l_cnt].xmdd001_desc,g_xmdd_d[l_cnt].imaal004_2
       CALL axmp510_unit_ref(g_xmdd_d[l_cnt].xmdd004) RETURNING g_xmdd_d[l_cnt].xmdd004_desc          
       LET l_cnt = l_cnt + 1      
   END FOREACH
   CALL g_xmdd_d.deleteElement(g_xmdd_d.getLength())
   LET g_detail3_cnt = l_cnt - 1                 
   #帶出訂單多期預付款
   INITIALIZE g_xmdb_d TO NULL   
   LET l_sql = "SELECT xmdb001,xmdbdocno,xmdb002,'',xmdb003, ",
               "       xmdb004,xmdb005,xmdb006,xmdb007,xmdb008, ",
               "       xmdb009 ",
               "  FROM xmdb_t ",
               " WHERE xmdbent = '",g_enterprise,"' ",
               "   AND xmdbsite = '",g_site,"' ",
               "   AND xmdbdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'"
   PREPARE axmp510_sel_xmdb_pr FROM l_sql
   DECLARE axmp510_sel_xmdb_cs CURSOR FOR axmp510_sel_xmdb_pr 
   LET l_cnt = 1
   #161109-00085#10-s
   #FOREACH axmp510_sel_xmdb_cs INTO g_xmdb_d[l_cnt].*
   FOREACH axmp510_sel_xmdb_cs
   INTO g_xmdb_d[l_cnt].xmdb001,g_xmdb_d[l_cnt].xmdbdocno,g_xmdb_d[l_cnt].xmdb002,g_xmdb_d[l_cnt].xmdb002_desc,g_xmdb_d[l_cnt].xmdb003,
        g_xmdb_d[l_cnt].xmdb004,g_xmdb_d[l_cnt].xmdb005,g_xmdb_d[l_cnt].xmdb006,g_xmdb_d[l_cnt].xmdb007,g_xmdb_d[l_cnt].xmdb008,
        g_xmdb_d[l_cnt].xmdb009      
   #161109-00085#10-e
       CALL axmp510_xmda009_ref(g_xmdb_d[l_cnt].xmdb002) RETURNING g_xmdb_d[l_cnt].xmdb002_desc          
       LET l_cnt = l_cnt + 1      
   END FOREACH
   CALL g_xmdb_d.deleteElement(g_xmdb_d.getLength())
   LET g_detail4_cnt = l_cnt - 1                     
   #已出通未出貨明細
   INITIALIZE g_xmdh_d TO NULL

   LET l_sql = "SELECT xmdh001,xmdh002,xmdh006,'','', ",
               "       xmdh007,xmdh015,'',xmdh017,xmdh030, ",
               "       '' ",
               "  FROM xmdg_t,xmdh_t ",
               " WHERE xmdgent = '",g_enterprise,"' ",
               "   AND xmdgsite = '",g_site,"' ",
               "   AND xmdgdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'",
               "   AND xmdgdocno = xmdhdocno "
   PREPARE axmp510_sel_xmdh_pr FROM l_sql
   DECLARE axmp510_sel_xmdh_cs CURSOR FOR axmp510_sel_xmdh_pr 
   LET l_cnt = 1
   #161109-00085#10-s
   #FOREACH axmp510_sel_xmdh_cs INTO g_xmdh_d[l_cnt].*
   FOREACH axmp510_sel_xmdh_cs 
   INTO g_xmdh_d[l_cnt].xmdh001,g_xmdh_d[l_cnt].xmdh002,g_xmdh_d[l_cnt].xmdh006,g_xmdh_d[l_cnt].xmdh006_desc,g_xmdh_d[l_cnt].imaal004,
        g_xmdh_d[l_cnt].xmdh007,g_xmdh_d[l_cnt].xmdh015,g_xmdh_d[l_cnt].xmdh015_desc,g_xmdh_d[l_cnt].xmdh017,g_xmdh_d[l_cnt].xmdh030,    
        g_xmdh_d[l_cnt].unxmdh030   
   #161109-00085#10-e
       #未出貨量 = 出通數量 - 已轉出貨量
       LET g_xmdh_d[l_cnt].unxmdh030 = g_xmdh_d[l_cnt].xmdh017 - g_xmdh_d[l_cnt].xmdh030       
       CALL axmp510_xmdc001_ref(g_xmdh_d[l_cnt].xmdh006) RETURNING g_xmdh_d[l_cnt].xmdh006_desc,g_xmdh_d[l_cnt].imaal004
       CALL axmp510_unit_ref(g_xmdh_d[l_cnt].xmdh015) RETURNING g_xmdh_d[l_cnt].xmdh015_desc            
       LET l_cnt = l_cnt + 1      
   END FOREACH
   CALL g_xmdh_d.deleteElement(g_xmdh_d.getLength())
   LET g_detail5_cnt = l_cnt - 1               
   
   #已出貨未立帳明細
   INITIALIZE g_xmdl_d TO NULL
   LET l_sql = "SELECT xmdldocno,xmdlseq,xmdl008,'','', ",
               "       xmdl009,xmdl017,'',xmdl018,xmdl028, ",
               "       '','' ",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = '",g_enterprise,"' ",
               "   AND xmdksite = '",g_site,"' ",
               "   AND xmdkdocno = '",g_detail_d[g_detail_idx].xmdadocno,"'",
               "   AND xmdkdocno = xmdldocno "
   PREPARE axmp510_sel_xmdl_pr FROM l_sql
   DECLARE axmp510_sel_xmdl_cs CURSOR FOR axmp510_sel_xmdl_pr 
   LET l_cnt = 1
   #161109-00085#10-s
   #FOREACH axmp510_sel_xmdl_cs INTO g_xmdl_d[l_cnt].*
   FOREACH axmp510_sel_xmdl_cs 
   INTO g_xmdl_d[l_cnt].xmdldocno,g_xmdl_d[l_cnt].xmdlseq,g_xmdl_d[l_cnt].xmdl008,g_xmdl_d[l_cnt].xmdl008_desc,g_xmdl_d[l_cnt].imaal004_6,
        g_xmdl_d[l_cnt].xmdl009,g_xmdl_d[l_cnt].xmdl017,g_xmdl_d[l_cnt].xmdl017_desc,g_xmdl_d[l_cnt].xmdl018,g_xmdl_d[l_cnt].xmdl028,     
        g_xmdl_d[l_cnt].xrcb119,g_xmdl_d[l_cnt].unxrcb119        
   #161109-00085#10-e
       #已立帳金額
       SELECT SUM(xrcb119) INTO g_xmdl_d[l_cnt].xrcb119
         FROM xrcb_t
        WHERE xrcbent = g_enterprise
          AND xrcbsite = g_site
          AND xrcbdocno = g_xmdl_d[l_cnt].xmdldocno
          AND xrcbseq = g_xmdl_d[l_cnt].xmdlseq
          AND xrcb001 = '12'
       IF cl_null(g_xmdl_d[l_cnt].xrcb119) THEN LET g_xmdl_d[l_cnt].xrcb119 = 0 END IF
       #未立帳金額 = 含稅金額 - 已立帳金額
       LET g_xmdl_d[l_cnt].unxrcb119 = g_xmdl_d[l_cnt].xmdl028 - g_xmdl_d[l_cnt].xrcb119       
       CALL axmp510_xmdc001_ref(g_xmdl_d[l_cnt].xmdl008) RETURNING g_xmdl_d[l_cnt].xmdl008_desc,g_xmdl_d[l_cnt].imaal004_6
       CALL axmp510_unit_ref(g_xmdl_d[l_cnt].xmdl017) RETURNING g_xmdl_d[l_cnt].xmdl017_desc            
       LET l_cnt = l_cnt + 1      
   END FOREACH
   CALL g_xmdl_d.deleteElement(g_xmdl_d.getLength())
   LET g_detail6_cnt = l_cnt - 1     
   #已立帳未沖帳明細
   INITIALIZE g_xrcc_d TO NULL
   #出貨單號、項次抓取應收憑單單身資料
   LET l_cnt = 1
   FOR i = 1 TO g_xmdl_d.getLength()
       SELECT xrcadocno INTO l_xrcadocno
         FROM xrca_t,xrcb_t
        WHERE xrcaent = g_enterprise
          AND xrcasite = g_site
          AND xrcadocno = xrcbdocno
          AND xrcb002 = g_xmdl_d[i].xmdldocno
          AND xrcb003 = g_xmdl_d[i].xmdlseq
          AND xrcb001 = '12' 
       LET l_sql = "SELECT xrccdocno,xrccseq,xrcc001,xrcc003,xrcc118, ",
                   "       xrcc119,'' ",
                   "  FROM xrcc_t ",
                   " WHERE xrccent = '",g_enterprise,"' ",
                   "   AND xrccsite = '",g_site,"' ",
                   "   AND xrccdocno = '",l_xrcadocno,"' "
       PREPARE axmp510_sel_xrcc_pr FROM l_sql
       DECLARE axmp510_sel_xrcc_cs CURSOR FOR axmp510_sel_xrcc_pr
       #161109-00085#10-s
       #FOREACH axmp510_sel_xrcc_cs INTO g_xrcc_d[l_cnt].*
       FOREACH axmp510_sel_xrcc_cs 
       INTO g_xrcc_d[l_cnt].xrccdocno,g_xrcc_d[l_cnt].xrccseq,g_xrcc_d[l_cnt].xrcc001,g_xrcc_d[l_cnt].xrcc003,  
            g_xrcc_d[l_cnt].xrcc118,g_xrcc_d[l_cnt].xrcc119,g_xrcc_d[l_cnt].unxrcc119       
       #161109-00085#10-e
           #本幣未沖帳金額 = 本幣應收金額 - 本幣收款沖帳金額
           LET g_xrcc_d[l_cnt].unxrcc119 = g_xrcc_d[l_cnt].xrcc118 - g_xrcc_d[l_cnt].xrcc119
           LET l_cnt = l_cnt + 1
       END FOREACH         
   END FOR
   CALL g_xrcc_d.deleteElement(g_xrcc_d.getLength())
   LET g_detail7_cnt = l_cnt - 1    
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axmp510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axmp510_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmp510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axmp510_filter()
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
   
   CALL axmp510_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axmp510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axmp510_filter_parser(ps_field)
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
 
{<section id="axmp510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axmp510_filter_show(ps_field,ps_object)
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
   LET ls_condition = axmp510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#業務人員姓名顯示
PRIVATE FUNCTION axmp510_xmda002_ref(p_xmda002)
DEFINE p_xmda002      LIKE xmda_t.xmda002
DEFINE r_xmda002_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_xmda002_desc = '', g_rtn_fields[1] , ''
       RETURN r_xmda002_desc
END FUNCTION
#建立tmptable
PRIVATE FUNCTION axmp510_create_preview_tmp()
   DROP TABLE axmp510_tmp
   CREATE TEMP TABLE axmp510_tmp
   (
      sel2       VARCHAR(1),
      closed2    VARCHAR(10),
      xmdcdocno  VARCHAR(20),
      xmdcseq    DECIMAL(10,0),
      xmdc007    DECIMAL(20,6),
      xmdc040    VARCHAR(1),
      xmdc041    VARCHAR(20),
      xmdc042    DECIMAL(10,0)
    );
END FUNCTION
#業務部門顯示
PRIVATE FUNCTION axmp510_xmda003_ref(p_xmda003)
DEFINE p_xmda003      LIKE xmda_t.xmda003
DEFINE r_xmda003_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_xmda003_desc = '', g_rtn_fields[1] , ''
       RETURN r_xmda003_desc
END FUNCTION
#單位名稱顯示
PRIVATE FUNCTION axmp510_unit_ref(p_xmdc006)
DEFINE p_xmdc006      LIKE xmdc_t.xmdc006
DEFINE r_xmdc006_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdc006
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_xmdc006_desc = '', g_rtn_fields[1] , ''
       RETURN r_xmdc006_desc
END FUNCTION
#收款條件說明
PRIVATE FUNCTION axmp510_xmda009_ref(p_xmda009)
DEFINE p_xmda009      LIKE xmda_t.xmda009
DEFINE r_ooibl004     LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda009
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooibl004 = g_rtn_fields[1]
       RETURN r_ooibl004
END FUNCTION
#交昜條件顯示
PRIVATE FUNCTION axmp510_xmda010_ref(p_xmda010)
DEFINE p_xmda010      LIKE xmda_t.xmda010
DEFINE r_oocql004     LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda010
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocql004 = g_rtn_fields[1]
       RETURN r_oocql004
END FUNCTION
 #幣別顯示
PRIVATE FUNCTION axmp510_xmda015_ref(p_xmda015)
DEFINE p_xmda015      LIKE xmda_t.xmda015
DEFINE r_ooail003     LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda015
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooail003 = '', g_rtn_fields[1] , ''
       RETURN r_ooail003
END FUNCTION
#帶出客戶名稱
PRIVATE FUNCTION axmp510_xmda004_ref(p_xmda004)
DEFINE p_xmda004    LIKE xmda_t.xmda004
DEFINE r_pmaal004   LIKE pmaal_t.pmaal004

        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_xmda004
        CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_pmaal004 = '', g_rtn_fields[1] , ''
        RETURN r_pmaal004
END FUNCTION
#畫面單身勾選/取消勾選，需更新tmptable資料
PRIVATE FUNCTION axmp510_upd_tmp(p_type,p_flag,p_xmdcdocno,p_xmdcseq,p_closed)
DEFINE p_type        LIKE type_t.chr1
DEFINE p_flag        LIKE type_t.chr1
DEFINE p_xmdcdocno   LIKE xmdc_t.xmdcdocno
DEFINE p_xmdcseq     LIKE xmdc_t.xmdcseq
DEFINE p_closed      LIKE xmdc_t.xmdc053
DEFINE i             LIKE type_t.num5

   CASE p_type
     WHEN '2'           #單頭單筆全選
       UPDATE axmp510_tmp
          SET sel2 = p_flag,
              closed2 = p_closed
        WHERE xmdcdocno = p_xmdcdocno

     WHEN '3'           #單身一筆勾選
       UPDATE axmp510_tmp
          SET sel2 = p_flag,
              closed2 = p_closed
        WHERE xmdcdocno = p_xmdcdocno
          AND xmdcseq = p_xmdcseq
    END CASE
END FUNCTION
#結案理由碼顯示
PRIVATE FUNCTION axmp510_closed_ref(p_closed)
DEFINE p_closed  LIKE xmdc_t.xmdc053
DEFINE r_oocql004 LIKE oocql_t.oocql004
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = p_closed
        CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET r_oocql004 = '', g_rtn_fields[1] , ''
        RETURN r_oocql004
END FUNCTION
#料件編號帶品名、規格
PRIVATE FUNCTION axmp510_xmdc001_ref(p_xmdc001)
DEFINE p_xmdc001     LIKE xmdc_t.xmdc001
DEFINE r_imaal003    LIKE imaal_t.imaal003
DEFINE r_imaal004    LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdc001
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields 
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
END FUNCTION
#作業編號說明
PRIVATE FUNCTION axmp510_xmdc004_ref(p_xmdc004)
DEFINE p_xmdc004   LIKE xmdc_t.xmdc004
DEFINE r_oocql004  LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmdc004
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oocql004 = '', g_rtn_fields[1] , ''
       RETURN r_oocql004
END FUNCTION
#依單別做畫面初始化
PRIVATE FUNCTION axmp510_docno_init()
   DEFINE l_success    LIKE type_t.num5   
   DEFINE l_gzze003    LIKE gzze_t.gzze003
   DEFINE l_gzze003_2  LIKE gzze_t.gzze003

     CALL cl_set_comp_visible("page_5",TRUE)                            #已出通未出貨頁籤
     CALL cl_set_comp_visible("b_xmdd014,b_xmdd016,b_xmdd031",TRUE)     #訂單交期明細頁籤：已出貨量、銷退換貨數量、已轉出通量欄位
     LET l_gzze003 = cl_getmsg('axm-00412',g_dlang)                     #訂單明細頁籤：已出貨量
     CALL cl_set_comp_att_text('b_xmdd014_1',l_gzze003)                
     LET l_gzze003 = cl_getmsg('axm-00413',g_dlang)                     #訂單明細頁籤：未出貨量
     CALL cl_set_comp_att_text('b_unxmdd014_1',l_gzze003)              
     LET l_gzze003 = cl_getmsg('axm-00413',g_dlang)                     #交期明細頁籤：未出貨量
     CALL cl_set_comp_att_text('b_unxmdd014_2',l_gzze003)  

     CALL s_aooi200_get_slip(g_detail_d[g_detail_idx].xmdadocno) RETURNING l_success,g_slip  #取單別
     IF cl_get_doc_para(g_enterprise,g_site,g_slip,'D-BAS-0077') = 'Y' THEN    #訂單需走出通單
        #訂單明細頁籤：將[欄位名稱]已出貨量改為已出通數量，未出貨量改為未出通量
        LET l_gzze003 = cl_getmsg('axm-00264',g_dlang)
        CALL cl_set_comp_att_text('b_xmdd014_1',l_gzze003)
        LET l_gzze003 = cl_getmsg('axm-00265',g_dlang)
        CALL cl_set_comp_att_text('b_unxmdd014_1',l_gzze003)                     
        #訂單交期明細頁籤：已出貨量、銷退換貨數量欄位隱藏
        CALL cl_set_comp_visible("b_xmdd014,b_xmdd016",FALSE)
        #訂單交期明細頁籤：將【欄位名稱】未出貨量改為未出通量
        LET l_gzze003 = cl_getmsg('axm-00265',g_dlang)
        CALL cl_set_comp_att_text('b_unxmdd014_2',l_gzze003)         
     ELSE                
        #訂單交期明細頁籤：已轉出通量欄位隱藏
        CALL cl_set_comp_visible("b_xmdd031",FALSE)
        #將已出通未出貨頁籤隱藏
        CALL cl_set_comp_visible("page_5",FALSE)
     END IF
END FUNCTION
#結案理由碼檢核
PRIVATE FUNCTION axmp510_xmdc053_chk(p_xmdcdocno,p_oocq002)
DEFINE p_xmdcdocno       LIKE xmdc_t.xmdcdocno
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
   CALL s_control_chk_doc('8',p_xmdcdocno,p_oocq002,'','','','')
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
################################################################################
# Descriptions...: 訂單結案
# Memo...........:
# Usage..........: CALL axmp510_closed_upd()
#                  
# Input parameter:
# Date & Author..: 2014/05/07  By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp510_closed_upd()
DEFINE l_xmda_d DYNAMIC ARRAY OF RECORD
       xmdadocno LIKE xmda_t.xmdadocno
    END RECORD    
DEFINE l_xmdcdocno LIKE xmdc_t.xmdcdocno
DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq
DEFINE l_xmdc040   LIKE xmdc_t.xmdc040    #取價來源
DEFINE l_xmdc041   LIKE xmdc_t.xmdc041    #取價來源單號
DEFINE l_xmdc042   LIKE xmdc_t.xmdc042    #取價來源項次
DEFINE l_closed    LIKE xmdc_t.xmdc053    #結案理由碼
DEFINE l_xmda006   LIKE xmda_t.xmda006    #多角性質
DEFINE l_xmda031   LIKE xmda_t.xmda031    #多角來源單號
DEFINE l_xmda050   LIKE xmda_t.xmda050    #多角流程代碼
DEFINE l_sql       STRING       
DEFINE i           LIKE type_t.num5
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_no_cnt    LIKE type_t.num5       #失敗總筆數
DEFINE l_no_cnt2   LIKE type_t.num5       #失敗筆數
DEFINE l_xmdc      RECORD LIKE xmdc_t.*   #170112-00054#1 add  
DEFINE l_imaf058   LIKE imaf_t.imaf058    #170112-00054#1 add



  LET l_sql = "SELECT DISTINCT xmdcdocno ",
              "  FROM axmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE axmp510_sel_docno_pr1 FROM l_sql
  DECLARE axmp510_sel_docno_cs1 CURSOR FOR axmp510_sel_docno_pr1 
  LET l_cnt = 1 
 
  FOREACH axmp510_sel_docno_cs1 INTO l_xmda_d[l_cnt].xmdadocno        
    LET l_cnt = l_cnt + 1
  END FOREACH  
  
  CALL l_xmda_d.deleteElement(l_xmda_d.getLength())
  LET l_cnt = l_cnt - 1
  

 
  CALL cl_showmsg_init()
  LET l_no_cnt = 0
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt  
         LET l_no_cnt2 = 0
        #160523-00018#3-s-mark 
        ##若為銷售多角，需做各據點多角結案
        #LET l_xmda006 = ''
        #LET l_xmda031 = ''
        #LET l_xmda050 = ''         
        #SELECT xmda006,xmda031,xmda050
        #  INTO l_xmda006,l_xmda031,l_xmda050
        #  FROM xmda_t
        # WHERE xmdaent = g_enterprise
        #   AND xmdasite = g_site
        #   AND xmdadocno = l_xmda_d[i].xmdadocno         
        #160523-00018#3-e-mark 
         CALL s_transaction_begin()     
         #抓取TMP單身資料做狀態結案
         LET l_sql = "SELECT closed2,xmdcdocno,xmdcseq,xmdc040,xmdc041,xmdc042",
                     "  FROM axmp510_tmp ",
                     " WHERE xmdcdocno = '",l_xmda_d[i].xmdadocno,"'",
                     "   AND sel2 = 'Y' ",
                     " ORDER BY xmdcdocno,xmdcseq "
         PREPARE axmp510_sel_xmdc045_pr FROM l_sql
         DECLARE axmp510_sel_xmdc045_cs CURSOR FOR axmp510_sel_xmdc045_pr
         FOREACH axmp510_sel_xmdc045_cs INTO l_closed,l_xmdcdocno,l_xmdcseq,l_xmdc040,l_xmdc041,l_xmdc042
           #單身狀態結案
           IF NOT s_axmp510_xmdc045_closed('2',l_xmdcdocno,l_xmdcseq,l_closed,g_site) THEN                 
              LET l_no_cnt2 = l_no_cnt2 + 1
           ELSE
              #取價來源為4：合約單短結時，須將未出貨的數量金額累加回寫合約單上的數量與金額 
              IF l_xmdc040 = '4' AND NOT cl_null(l_xmdc041) AND NOT cl_null(l_xmdc042) THEN
                 IF NOT axmp510_xmdy_upd('1',l_xmdcdocno,l_xmdcseq) THEN
                    LET l_no_cnt2 = l_no_cnt2 + 1
                 END IF
              END IF
             #160523-00018#3-s-mark 
              ##多角單身狀態結案 
              #IF l_xmda006 = '2' AND NOT cl_null(l_xmda031) THEN                    
              #   CALL axmp510_aic_closed('1',l_xmdcseq,l_closed,l_xmda031,l_xmda050)
              #END IF
             #160523-00018#3-e-mark  
             #170112-00054#1 add  --begin--
              IF NOT axmp510_upd_inas('closed',l_xmdcdocno,l_xmdcseq) THEN
                 LET l_no_cnt2 = l_no_cnt2 + 1
              END IF
             #170112-00054#1 add  --end--
           END IF      
         END FOREACH
         #物流結案
         IF NOT s_axmp510_xmda045_closed(l_xmda_d[i].xmdadocno,g_site) THEN                 
            LET l_no_cnt2 = l_no_cnt2 + 1
         END IF
         IF l_no_cnt2 = 0 THEN
            CALL s_transaction_end("Y","0")
         ELSE
            CALL s_transaction_end("N","0")
            LET l_no_cnt = l_no_cnt + 1
         END IF 
         #帳流結案
         CALL s_transaction_begin()
         IF NOT s_axmp510_xmda046_closed(l_xmda_d[i].xmdadocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
         #金流結案          
         CALL s_transaction_begin()
         IF NOT s_axmp510_xmda047_closed(l_xmda_d[i].xmdadocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1
         ELSE
            CALL s_transaction_end('Y','0')
         END IF
         #狀態結案
         CALL s_transaction_begin()
         IF NOT s_axmp510_xmdastus_closed('2',l_xmda_d[i].xmdadocno,g_site) THEN
            CALL s_transaction_end('N','0')
            LET l_no_cnt = l_no_cnt + 1
         ELSE
            CALL s_transaction_end('Y','0')
         END IF 
        #160523-00018#3-s-mark         
        ##做多角的物流、帳流、金流、狀態結案
        #IF l_xmda006 = '2' AND NOT cl_null(l_xmda031) THEN            
        #   CALL axmp510_aic_closed('1',0,'',l_xmda031,l_xmda050)
        #END IF      
        #160523-00018#3-e-mark
      END FOR
  END IF  
  IF l_no_cnt > 0 THEN
     CALL cl_showmsg()
  END IF
END FUNCTION
################################################################################
# Descriptions...: 訂單取消結案
# Memo...........:
# Usage..........: CALL axmp510_unclosed_upd()
# Input parameter:
# Date & Author..: 14/05/07 By polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp510_unclosed_upd()
DEFINE l_sql       STRING  
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_no_cnt    LIKE type_t.num5
DEFINE l_no_cnt2   LIKE type_t.num5
DEFINE i           LIKE type_t.num5

DEFINE l_xmda_d DYNAMIC ARRAY OF RECORD
       xmdadocno LIKE xmda_t.xmdadocno      
    END RECORD
DEFINE l_xmdcdocno LIKE xmdc_t.xmdcdocno
DEFINE l_xmdcseq   LIKE xmdc_t.xmdcseq
DEFINE l_xmdc040   LIKE xmdc_t.xmdc040    #取價來源
DEFINE l_xmdc041   LIKE xmdc_t.xmdc041    #取價來源單號
DEFINE l_xmdc042   LIKE xmdc_t.xmdc042    #取價來源項次
DEFINE l_xmda006   LIKE xmda_t.xmda006    #多角性質
DEFINE l_xmda031   LIKE xmda_t.xmda031    #多角來源單號
DEFINE l_xmda050   LIKE xmda_t.xmda050    #多角流程代碼

  LET l_sql = "SELECT DISTINCT xmdcdocno ",
              "  FROM axmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE axmp510_sel_docno_pr2 FROM l_sql
  DECLARE axmp510_sel_docno_cs2 CURSOR FOR axmp510_sel_docno_pr2 
  LET l_cnt = 1 
 
  FOREACH axmp510_sel_docno_cs2 INTO l_xmda_d[l_cnt].xmdadocno       
    LET l_cnt = l_cnt + 1
  END FOREACH   
  CALL l_xmda_d.deleteElement(l_xmda_d.getLength())
  LET l_cnt = l_cnt - 1
  
  
  CALL cl_showmsg_init()
  LET l_no_cnt = 0 
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt  
         LET l_no_cnt2 = 0       
         #若為銷售多角，需做各據點多角結案
         LET l_xmda006 = ''
         LET l_xmda031 = ''
         LET l_xmda050 = ''         
         SELECT xmda006,xmda031,xmda050
           INTO l_xmda006,l_xmda031,l_xmda050
           FROM xmda_t
          WHERE xmdaent = g_enterprise
            AND xmdasite = g_site
            AND xmdadocno = l_xmda_d[i].xmdadocno 
            
         CALL s_transaction_begin()     
         #抓取TMP單身資料做狀態取消結案
         LET l_sql = "SELECT xmdcdocno,xmdcseq,xmdc040,xmdc041,xmdc042 ",
                     "  FROM axmp510_tmp ",
                     " WHERE xmdcdocno = '",l_xmda_d[i].xmdadocno,"'",
                     "   AND sel2 = 'Y' "
         PREPARE axmp510_sel_tmp_pr FROM l_sql
         DECLARE axmp510_sel_tmp_cs CURSOR FOR axmp510_sel_tmp_pr
         FOREACH axmp510_sel_tmp_cs INTO l_xmdcdocno,l_xmdcseq,l_xmdc040,l_xmdc041,l_xmdc042            
           #單身狀態取消結案
           IF NOT s_axmp510_xmdc045_unclosed(l_xmdcdocno,l_xmdcseq,g_site) THEN                 
              LET l_no_cnt2 = l_no_cnt2 + 1
           ELSE    
              #取價來源為4：合約單短結時，須將未出貨的數量金額累加回寫合約單上的數量與金額 
              IF l_xmdc040 = '4' AND NOT cl_null(l_xmdc041) AND NOT cl_null(l_xmdc042) THEN
                 IF NOT axmp510_xmdy_upd('2',l_xmdcdocno,l_xmdcseq) THEN
                    LET l_no_cnt2 = l_no_cnt2 + 1
                 END IF
              END IF           
              #IF l_xmda006 = '2' AND NOT cl_null(l_xmda031) THEN              #多角單據結案 
              #   CALL axmp510_aic_closed('2',l_xmdcseq,'',l_xmda031,l_xmda050)
              #END IF
              #170112-00054#1 add  --begin--
              IF NOT axmp510_upd_inas('unclosed',l_xmdcdocno,l_xmdcseq) THEN
                 LET l_no_cnt2 = l_no_cnt2 + 1
              END IF
              #170112-00054#1 add  --end--
           END IF           
         END FOREACH
         #取消結案，更新單頭狀態為Y，物流結案為N
         IF NOT s_axmp510_xmda045_unclosed(l_xmda_d[i].xmdadocno,g_site) THEN                 
            LET l_no_cnt2 = l_no_cnt2 + 1
         #ELSE            
         #   IF l_xmda006 = '2' AND NOT cl_null(l_xmda031) THEN              #多角單據結案
         #      CALL axmp510_aic_closed('2',0,'',l_xmda031,l_xmda050)
         #   END IF
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
# Descriptions...: 訂單結案
# Memo...........: 訂單多角單據結案作業
# Usage..........: CALL axmp510_aic_closed(p_type,p_xmdcseq,p_xmdc053,p_xmda031,p_xmda050)                     
# Input parameter: p_type         狀態 1.結案 2取消結案
#                : p_xmdcseq      訂單項次
#                : p_xmdc053      結案理由碼
#                : p_xmda031      多角來源單號
#                : p_xmdc050      多角流程式碼
# Return code....: 
# Date & Author..: 2014-08-06     Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp510_aic_closed(p_type,p_xmdcseq,p_xmdc053,p_xmda031,p_xmda050)
   DEFINE p_type      LIKE type_t.num5          #型態1結案；2取消結案
   DEFINE p_xmdcseq   LIKE xmdc_t.xmdcseq       #訂單項次
   DEFINE p_xmdc053   LIKE xmdc_t.xmdc053       #結案理由碼 
   DEFINE p_xmda031   LIKE xmda_t.xmda031       #多角來源單號
   DEFINE p_xmda050   LIKE xmda_t.xmda050       #多角流程代碼
   DEFINE l_icab003   LIKE icab_t.icab003       #多角營運據點
   DEFINE l_pmdldocno LIKE pmdl_t.pmdldocno     #採購單單號
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno     #工單單號
   DEFINE l_xmdadocno LIKE xmda_t.xmdadocno     #訂單單號
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5

   LET l_sql = "SELECT icab003 ",
               "  FROM icaa_t,icab_t ",
               " WHERE icaaent = '",g_enterprise,"' " ,
               "   AND icaa001 = '",p_xmda050,"' " ,
               "   AND icaa001 = icab001 "
               
   PREPARE s_axmp510_sel_pr_aic FROM l_sql
   DECLARE s_axmp510_sel_cs_aic CURSOR FOR s_axmp510_sel_pr_aic
   
   #各站營運據點依多角流程序號取得各站 訂單/採購單/工單 單號做結案
   FOREACH s_axmp510_sel_cs_aic INTO l_icab003
           
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
                 IF p_xmdcseq > 0 THEN
                    CALL s_axmp510_xmdc045_closed('2',l_xmdadocno,p_xmdcseq,p_xmdc053,l_icab003) RETURNING l_success 
                 ELSE                  
                    CALL s_axmp510_xmda045_closed(l_xmdadocno,l_icab003) RETURNING l_success
                    CALL s_axmp510_xmda046_closed(l_xmdadocno,l_icab003) RETURNING l_success
                    CALL s_axmp510_xmda047_closed(l_xmdadocno,l_icab003) RETURNING l_success
                    CALL s_axmp510_xmdastus_closed('2',l_xmdadocno,l_icab003) RETURNING l_success
                 END IF                   
              ELSE
                 #取消結案
                 IF p_xmdcseq > 0 THEN
                    CALL s_axmp510_xmdc045_unclosed(l_xmdadocno,p_xmdcseq,l_icab003) RETURNING l_success 
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
              AND pmdl031 = p_xmda031
           IF NOT cl_null(l_pmdldocno) THEN
              IF p_type = 1 THEN
                 #結案
                 IF p_xmdcseq > 0 THEN
                    CALL s_apmp510_pmdn045_closed('2',l_pmdldocno,p_xmdcseq,p_xmdc053,l_icab003) RETURNING l_success 
                 ELSE                  
                    CALL s_apmp510_pmdl047_closed(l_pmdldocno,l_icab003) RETURNING l_success
                    CALL s_apmp510_pmdl048_closed(l_pmdldocno,l_icab003) RETURNING l_success
                    CALL s_apmp510_pmdl049_closed(l_pmdldocno,l_icab003) RETURNING l_success
                    CALL s_apmp510_pmdlstus_closed('2',l_pmdldocno,l_icab003) RETURNING l_success
                 END IF                   
              ELSE
                 #取消結案
                 IF p_xmdcseq > 0 THEN
                    CALL s_apmp510_pmdn045_unclosed(l_pmdldocno,p_xmdcseq,l_icab003) RETURNING l_success 
                 ELSE                
                    CALL s_apmp510_pmdl047_unclosed(l_pmdldocno,l_icab003) RETURNING l_success                  
                 END IF
              END IF             
           END IF
           #工單單號
           LET l_sfaadocno = ''
           SELECT sfaadocno INTO l_sfaadocno
             FROM sfaa_t
            WHERE sfaaent = g_enterprise
              AND sfaasite = l_icab003
              AND sfaa067 = p_xmda031
           IF NOT cl_null(l_sfaadocno) THEN
              IF p_type = 1 THEN
                 #結案
              END IF            
           END IF                    
   END FOREACH
END FUNCTION
#稅別顯示
PRIVATE FUNCTION axmp510_xmda011_ref(p_xmda011)
DEFINE p_xmda011      LIKE xmda_t.xmda011
DEFINE l_ooef019      LIKE ooef_t.ooef019
DEFINE r_oodbl004     LIKE oodbl_t.oodbl004

       #獲得當前營運據點的所屬稅區
       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 
         FROM ooef_t 
        WHERE ooefent = g_enterprise 
          AND ooef001 = g_site

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_xmda011
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001='"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_oodbl004 = '', g_rtn_fields[1] , ''
       RETURN r_oodbl004
END FUNCTION

PRIVATE FUNCTION axmp510_set_entry_b()

    CALL cl_set_comp_entry("b_closed2",TRUE)
END FUNCTION

PRIVATE FUNCTION axmp510_set_no_entry_b()
    IF g_xmdc_d[l_ac1].sel2 = 'N' THEN
       CALL cl_set_comp_entry("b_closed2",FALSE)
    END IF
END FUNCTION

PRIVATE FUNCTION axmp510_set_entry()
    CALL cl_set_comp_entry("b_closed",TRUE)
END FUNCTION

PRIVATE FUNCTION axmp510_set_no_entry()
    IF g_detail_d[l_ac].sel = 'N' THEN
       CALL cl_set_comp_entry("b_closed",FALSE)
    END IF
END FUNCTION
#執行前檢查
PRIVATE FUNCTION axmp510_execute_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_docno     LIKE xmda_t.xmdadocno     #160523-00018#3 add

       LET r_success = TRUE
       
       #因按執行時，不會走AFTR ROW 、ON ROW CHANGE 段無法即時寫入TEMP TABLE，所以在此段做處理
       #第一單身
       IF g_detail_idx > 0 THEN
          IF g_detail_d[g_detail_idx].sel <> g_detail_d_t.sel THEN 
             IF g_detail_d[g_detail_idx].sel = 'Y' THEN
                IF g_type = '1' THEN  #結案需控卡理由碼
                   IF NOT cl_null(g_detail_d[g_detail_idx].closed) THEN
                      IF NOT axmp510_xmdc053_chk(g_detail_d[g_detail_idx].xmdadocno,g_detail_d[g_detail_idx].closed) THEN
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
                CALL axmp510_upd_tmp('2','Y',g_detail_d[g_detail_idx].xmdadocno,'',g_detail_d[g_detail_idx].closed)
             ELSE
                LET g_detail_d[g_detail_idx].closed = ''
                LET g_detail_d[g_detail_idx].closed_desc = ''
                CALL axmp510_upd_tmp('2','N',g_detail_d[g_detail_idx].xmdadocno,'','')
             END IF                      
          END IF
       END IF
       #第二單身
       IF g_detail2_idx > 0 THEN
          IF g_xmdc_d[g_detail2_idx].sel2 <> g_xmdc_d_t.sel2 THEN
             IF g_xmdc_d[g_detail2_idx].sel2 = 'Y' THEN
                IF g_type = '1' THEN   #結案需控卡理由碼
                   IF NOT cl_null(g_xmdc_d[g_detail2_idx].closed2) THEN
                      IF NOT axmp510_xmdc053_chk(g_xmdc_d[g_detail2_idx].xmdcdocno,g_xmdc_d[g_detail2_idx].closed2) THEN
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
                CALL axmp510_upd_tmp('3','Y',g_xmdc_d[g_detail2_idx].xmdcdocno,g_xmdc_d[g_detail2_idx].xmdcseq,g_xmdc_d[g_detail2_idx].closed2)
             ELSE
                LET g_xmdc_d[g_detail2_idx].closed2 = ''
                LET g_xmdc_d[g_detail2_idx].closed2_desc = ''
                CALL axmp510_upd_tmp('3','N',g_xmdc_d[g_detail2_idx].xmdcdocno,g_xmdc_d[g_detail2_idx].xmdcseq,g_xmdc_d[g_detail2_idx].closed2)
             END IF            
          END IF          
       END IF      
       #檢查table是否有勾選資料       
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt
         FROM axmp510_tmp
        WHERE sel2 = 'Y'
       IF l_cnt = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00481'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success         
       END IF
       #檢查table結案理由碼不可空白
       IF g_type = '1' THEN
          LET l_cnt = 0      
          SELECT COUNT(*) INTO l_cnt
            FROM axmp510_tmp
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
# Descriptions...: 留置/取消留置
# Memo...........:
# Usage..........: CALL axmp510_hold_upd(p_type)
#                  
# Return code....: 
# Date & Author..: 20141230 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp510_hold_upd(p_type)
  DEFINE  p_type     LIKE type_t.chr1
  DEFINE l_xmda_d DYNAMIC ARRAY OF RECORD
           xmdadocno LIKE xmda_t.xmdadocno
    END RECORD   
  DEFINE  l_sql       STRING
  DEFINE  l_xmdcdocno LIKE xmdc_t.xmdcdocno
  DEFINE  l_xmdcseq   LIKE xmdc_t.xmdcseq
  DEFINE  l_closed    LIKE xmdc_t.xmdc053      #留置理由碼    
  DEFINE  l_xmdc045   LIKE xmdc_t.xmdc045
  DEFINE  l_xmdc053   LIKE xmdc_t.xmdc053
  DEFINE  l_xmdastus  LIKE xmda_t.xmdastus
  DEFINE  i           LIKE type_t.num5
  DEFINE  l_cnt       LIKE type_t.num5
  DEFINE  l_cnt2      LIKE type_t.num5
  DEFINE  l_no_cnt    LIKE type_t.num5         #失敗總筆數
  DEFINE  l_no_sum    LIKE type_t.num5         #失敗總筆數
  DEFINE  l_xmdamoddt DATETIME YEAR TO SECOND  #160419-00029 by whitney add


  LET l_sql = "SELECT DISTINCT xmdcdocno ",
              "  FROM axmp510_tmp ",
              " WHERE sel2 = 'Y' "              
 
  PREPARE axmp510_sel_docno_pr3 FROM l_sql
  DECLARE axmp510_sel_docno_cs3 CURSOR FOR axmp510_sel_docno_pr3 
  LET l_cnt = 1 
 
  FOREACH axmp510_sel_docno_cs3 INTO l_xmda_d[l_cnt].xmdadocno        
    LET l_cnt = l_cnt + 1
  END FOREACH  
  
  CALL l_xmda_d.deleteElement(l_xmda_d.getLength())
  LET l_cnt = l_cnt - 1

  CALL cl_err_collect_init()
  LET l_no_sum = 0
  IF l_cnt > 0 THEN    
     FOR i = 1 TO l_cnt  
         CALL s_transaction_begin()
         LET l_no_cnt = 0
         #抓取TMP單身資料做狀態留置
         LET l_sql = "SELECT closed2,xmdcdocno,xmdcseq",
                     "  FROM axmp510_tmp ",
                     " WHERE xmdcdocno = '",l_xmda_d[i].xmdadocno,"'",
                     "   AND sel2 = 'Y' ",
                     " ORDER BY xmdcdocno,xmdcseq "
         PREPARE axmp510_sel_xmdc045_pr2 FROM l_sql
         DECLARE axmp510_sel_xmdc045_cs2 CURSOR FOR axmp510_sel_xmdc045_pr2
         FOREACH axmp510_sel_xmdc045_cs2 INTO l_closed,l_xmdcdocno,l_xmdcseq
           IF p_type = 1 THEN           #留置
              LET l_xmdc045 = '5'
              LET l_xmdc053 = l_closed
           ELSE                         #取消留置
              LET l_xmdc045 = '1'
              LET l_xmdc053 = ''           
           END IF
           #單身狀態留置
           UPDATE xmdc_t
              SET xmdc045 = l_xmdc045,
                  xmdc053 = l_xmdc053
            WHERE xmdcent = g_enterprise
              AND xmdcdocno = l_xmdcdocno
              AND xmdcseq = l_xmdcseq
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = l_xmda_d[i].xmdadocno
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.popup  = TRUE
              CALL cl_err()           
              LET l_no_cnt = l_no_cnt + 1
              LET l_no_sum = l_no_sum + 1
           END IF       
           #add--151110-00030#1--By shiun--(S)
           #回寫訂單時，一併回寫交期明細裡的異動人員、時間
           UPDATE xmdd_t
              SET xmdd022 = g_user,
                  xmdd023 = g_today
            WHERE xmddent = g_enterprise
              AND xmdddocno = l_xmdcdocno
              AND xmddseq = l_xmdcseq
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.extend = l_xmda_d[i].xmdadocno
              LET g_errparam.code   = SQLCA.sqlcode
              LET g_errparam.popup  = TRUE
              CALL cl_err()           
              LET l_no_cnt = l_no_cnt + 1
              LET l_no_sum = l_no_sum + 1
           END IF       
           #add--151110-00030#1--By shiun--(E)
           
           #170112-00054#1 add  --begin--
           IF p_type = 1 THEN           #留置
              IF NOT axmp510_upd_inas('hold',l_xmdcdocno,l_xmdcseq) THEN
                 LET l_no_cnt = l_no_cnt + 1
                 LET l_no_sum = l_no_sum + 1
              END IF
           ELSE                         #取消留置
              IF NOT axmp510_upd_inas('unhold',l_xmdcdocno,l_xmdcseq) THEN
                 LET l_no_cnt = l_no_cnt + 1
                 LET l_no_sum = l_no_sum + 1
              END IF
           END IF
           #170112-00054#1 add  --end--
         END FOREACH
         #狀態碼留置/取消留置 (單身全部xmdc045='5'留置時，狀態碼才為"留置H"，不然都是"確認Y"狀態)
         LET l_cnt2 = 0
         LET l_xmdastus = 'Y'
         SELECT COUNT(*) INTO l_cnt2
           FROM xmdc_t
          WHERE xmdcent = g_enterprise
            AND xmdcdocno = l_xmda_d[i].xmdadocno
            AND xmdc045 <> '5'
         IF p_type = '1' AND l_cnt2 = 0 THEN           #留置
            LET l_xmdastus = 'H'
         END IF
         LET l_xmdamoddt = cl_get_current()  #160419-00029 by whitney add
         UPDATE xmda_t
            SET xmdastus = l_xmdastus,
                xmdamodid = g_user,
                xmdamoddt = l_xmdamoddt
          WHERE xmdaent = g_enterprise
            AND xmdadocno = l_xmda_d[i].xmdadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_xmda_d[i].xmdadocno
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
  IF l_no_sum > 0 THEN  
     CALL cl_err_collect_show()
  END IF



END FUNCTION
################################################################################
# Descriptions...: 更新合約單累積量與金額
# Memo...........: 取價來源為4：合約單短結時，須將未出貨的數量金額累加回寫合約單上的數量與金額
# Usage..........: CALL axmp510_xmdy_upd(p_mode,p_xmdcdocno,p_xmdcseq)
#                  RETURNING r_success
# Input parameter: p_mode         1結案2取消結案
#                : p_xmdcdocno    單號
#                : p_xmdcseq      項次
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20150306 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmp510_xmdy_upd(p_mode,p_xmdcdocno,p_xmdcseq)
   DEFINE   p_mode        LIKE type_t.num5
   DEFINE   p_xmdcdocno   LIKE xmdc_t.xmdcdocno
   DEFINE   p_xmdcseq     LIKE xmdc_t.xmdcseq
   DEFINE   l_xmda015     LIKE xmda_t.xmda015    #幣別
   DEFINE   l_xmda016     LIKE xmda_t.xmda016    #匯率
   DEFINE   l_xmdc011     LIKE xmdc_t.xmdc011    #計價數量
   DEFINE   l_xmdc015     LIKE xmdc_t.xmdc015    #單價
   DEFINE   l_xmdc016     LIKE xmdc_t.xmdc016    #稅別
   DEFINE   l_xmdc040     LIKE xmdc_t.xmdc040    #取價來源
   DEFINE   l_xmdc041     LIKE xmdc_t.xmdc041    #取價來源單號
   DEFINE   l_xmdc042     LIKE xmdc_t.xmdc042    #取價來源項次
   DEFINE   l_xmdc045     LIKE xmdc_t.xmdc045    #狀態碼
   DEFINE   l_xmdc046     LIKE xmdc_t.xmdc046    #未稅金額
   DEFINE   l_xmdc047     LIKE xmdc_t.xmdc047    #含稅金額
   DEFINE   l_xmdc048     LIKE xmdc_t.xmdc048    #稅額
   DEFINE   l_xmdc011_1   LIKE xmdc_t.xmdc011    #短結數量
   DEFINE   l_xmdc046_1   LIKE xmdc_t.xmdc046    #短結後未稅金額
   DEFINE   l_xmdc047_1   LIKE xmdc_t.xmdc047    #短結後含稅金額
   DEFINE   l_xmdc048_1   LIKE xmdc_t.xmdc048    #短結後稅額  
   DEFINE   l_xmdy020     LIKE xmdy_t.xmdy020    #累計數量
   DEFINE   l_xmdy021     LIKE xmdy_t.xmdy021    #累計未稅金額
   DEFINE   l_xmdy022     LIKE xmdy_t.xmdy022    #累計含稅金額
   DEFINE   l_xmdy023     LIKE xmdy_t.xmdy023    #累計稅額   
   DEFINE   l_success     LIKE type_t.num5
   DEFINE   r_success     LIKE type_t.num5
   
   
   LET r_success = TRUE
   
   SELECT xmdc011,xmdc015,xmdc016,xmdc041,xmdc042,
          xmdc045,xmdc046,xmdc047,xmdc048,xmda015,
          xmda016
     INTO l_xmdc011,l_xmdc015,l_xmdc016,l_xmdc041,l_xmdc042,
          l_xmdc045,l_xmdc046,l_xmdc047,l_xmdc048,l_xmda015,
          l_xmda016
     FROM xmdc_t,xmda_t
    WHERE xmdaent = xmdcent
      AND xmdadocno = xmdcdocno
      AND xmdcent = g_enterprise
      AND xmdcdocno = p_xmdcdocno
      AND xmdcseq = p_xmdcseq

   #計算短結數量
   CALL s_axmt500_count_min_xmdd014(p_xmdcdocno,p_xmdcseq,'2',g_site)  
     RETURNING l_xmdc011_1,l_success

   CASE p_mode
     WHEN '1'    #結案
       IF l_xmdc045 <> '4' THEN    #短結
          RETURN r_success
       END IF
     WHEN '2'    #取消結案
       IF l_xmdc011 <= l_xmdc011_1 THEN 
          RETURN r_success
       END IF
   END CASE    

   #計算短結後的未稅金額、含稅金額、稅額
   CALL s_axmt500_get_amount_2(l_xmdc011_1,l_xmdc015,l_xmdc016,l_xmda015,l_xmda016)
     RETURNING l_xmdc046_1,l_xmdc047_1,l_xmdc048_1 

   SELECT xmdy020,xmdy021,xmdy022,xmdy023
     INTO l_xmdy020,l_xmdy021,l_xmdy022,l_xmdy023
     FROM xmdy_t
    WHERE xmdyent = g_enterprise
      AND xmdysite = g_site
      AND xmdydocno = l_xmdc041
      AND xmdyseq = l_xmdc042
      
   IF cl_null(l_xmdy020) THEN LET l_xmdy020 = 0 END IF   
   IF cl_null(l_xmdy021) THEN LET l_xmdy021 = 0 END IF
   IF cl_null(l_xmdy022) THEN LET l_xmdy022 = 0 END IF
   IF cl_null(l_xmdy023) THEN LET l_xmdy023 = 0 END IF   

   CASE p_mode
     WHEN '1'    #結案
       LET l_xmdy020 = l_xmdy020 - (l_xmdc011 - l_xmdc011_1)
       LET l_xmdy021 = l_xmdy021 - (l_xmdc046 - l_xmdc046_1)
       LET l_xmdy022 = l_xmdy022 - (l_xmdc047 - l_xmdc047_1)
       LET l_xmdy023 = l_xmdy023 - (l_xmdc048 - l_xmdc048_1)
     WHEN '2'    #取消結案
       LET l_xmdy020 = l_xmdy020 + (l_xmdc011 - l_xmdc011_1)
       LET l_xmdy021 = l_xmdy021 + (l_xmdc046 - l_xmdc046_1)
       LET l_xmdy022 = l_xmdy022 + (l_xmdc047 - l_xmdc047_1)
       LET l_xmdy023 = l_xmdy023 + (l_xmdc048 - l_xmdc048_1)     
   END CASE
   UPDATE xmdy_t
      SET xmdy020 = l_xmdy020,
          xmdy021 = l_xmdy021,
          xmdy022 = l_xmdy022,
          xmdy023 = l_xmdy023
    WHERE xmdyent = g_enterprise
      AND xmdysite = g_site
      AND xmdydocno = l_xmdc041
      AND xmdyseq = l_xmdc042 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE xmdy_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   RETURN r_success


END FUNCTION

################################################################################
# Descriptions...: 库存需求等候异动
# Date & Author..: 170119 By wuxja
# Modify.........: #170112-00054#1 add
################################################################################
PRIVATE FUNCTION axmp510_upd_inas(p_cmd,p_docno,p_seq)
DEFINE p_cmd             LIKE type_t.chr10
DEFINE p_docno           LIKE xmdc_t.xmdcdocno
DEFINE p_seq             LIKE xmdc_t.xmdcseq
DEFINE l_sql             STRING
DEFINE l_xmddseq1        LIKE xmdd_t.xmddseq1
DEFINE l_xmddseq2        LIKE xmdd_t.xmddseq2
DEFINE l_xmdd001         LIKE xmdd_t.xmdd001
DEFINE l_xmdd002         LIKE xmdd_t.xmdd002
DEFINE l_xmdd004         LIKE xmdd_t.xmdd004
DEFINE l_xmdd006         LIKE xmdd_t.xmdd006
DEFINE l_imaf058         LIKE imaf_t.imaf058
DEFINE l_success         LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   LET l_sql = "SELECT xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd004,xmdd006 FROM xmdd_t ",
               " WHERE xmddent = ",g_enterprise," AND xmdddocno = '",p_docno,"' AND xmddseq = ",p_seq
   PREPARE axmp510_upd_inas_pre FROM l_sql
   DECLARE axmp510_upd_inas_cs CURSOR FOR axmp510_upd_inas_pre
    
   LET l_sql = "SELECT imaf058 FROM imaf_t ", 
               " WHERE imafent = ",g_enterprise," AND imafsite = '",g_site,"'",
               "   AND imaf001 = ? "
   PREPARE axmp510_upd_inas_pre_imaf058 FROM l_sql
                            
   FOREACH axmp510_upd_inas_cs INTO l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'foreach:axmp510_upd_inas_cs'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_imaf058 = ''
      EXECUTE axmp510_upd_inas_pre_imaf058 USING l_xmdd001 INTO l_imaf058
      IF l_imaf058 = '3' THEN
         CASE p_cmd
            WHEN 'closed'
               CALL s_inventory_upd_inas(g_site,p_docno,p_seq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd006,'-1')
                    RETURNING l_success
            WHEN 'unclosed'
               CALL s_inventory_upd_inas(g_site,p_docno,p_seq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd006,'1')
                    RETURNING l_success
            WHEN 'hold'
               CALL s_inventory_upd_inas(g_site,p_docno,p_seq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd006,'-1')
                    RETURNING l_success
            WHEN 'unhold'
               CALL s_inventory_upd_inas(g_site,p_docno,p_seq,l_xmddseq1,l_xmddseq2,l_xmdd001,l_xmdd002,l_xmdd004,l_xmdd006,'1')
                    RETURNING l_success
         END CASE
      END IF
     
      IF NOT l_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
       
END FUNCTION

#end add-point
 
{</section>}
 
