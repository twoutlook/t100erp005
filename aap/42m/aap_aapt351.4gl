#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt351.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2015-06-18 09:49:02), PR版次:0016(2016-11-17 15:15:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000243
#+ Filename...: aapt351
#+ Description: 零用金撥補申請作業
#+ Creator....: 02097(2014-06-11 09:31:33)
#+ Modifier...: 03080 -SD/PR- 08729
 
{</section>}
 
{<section id="aapt351.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13  2015/07/17 By RayHuang statechange段問題修正
#151125-00006#2   2015/12/02 By 06421    新增[編輯完單據後立即審核]功能
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#160122-00001#5   2016/02/23 By 07673    添加交易账户编号用户权限控管
#160321-00016#21  2016/03/23 By Jessy    修正azzi920重複定義之錯誤訊息(sub部分)
#160318-00025#24  2016/04/25 BY 07900    校验代码重复错误讯息的修改
#160812-00027#1   2016/08/17 By 06821    全面盤點應付程式帳套權限控管(帳務中心改為同aapt300 ooef_t開窗)
#160822-00008#1   2016/08/24 By 08171    新舊值調整
#160818-00017#1   2016/08/30 By 07900    删除修改未重新判断状态码
#160905-00002#1   2016/09/05 By Reanna   SQL條件少ENT補上
#161006-00005#22  2016/10/24 By 06137    組織類型與職能開窗清單需測試及調整開窗內容
#161104-00024#3   2016/11/10 By 08729    處理DEFINE有星號
#161115-00042#5   2016/11/17 By 08729    開窗增加過濾據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_finance.inc"    #財務模組使用
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apda_m        RECORD
       apda006 LIKE apda_t.apda006, 
   apda006_desc LIKE type_t.chr80, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apdadocno LIKE apda_t.apdadocno, 
   apdadocno_desc LIKE type_t.chr80, 
   apda001 LIKE apda_t.apda001, 
   fflabel_1 LIKE type_t.chr80, 
   apdasite LIKE apda_t.apdasite, 
   apdasite_desc LIKE type_t.chr80, 
   apda003 LIKE apda_t.apda003, 
   apda003_desc LIKE type_t.chr80, 
   apdacomp LIKE apda_t.apdacomp, 
   apdald LIKE apda_t.apdald, 
   apacsite LIKE apac_t.apacsite, 
   glaa005 LIKE glaa_t.glaa005, 
   apdastus LIKE apda_t.apdastus, 
   apda018 LIKE apda_t.apda018, 
   apda018_desc LIKE type_t.chr80, 
   apda008 LIKE apda_t.apda008, 
   apda017 LIKE apda_t.apda017, 
   apda016 LIKE apda_t.apda016, 
   apda015 LIKE apda_t.apda015, 
   apda015_desc LIKE type_t.chr80, 
   apdaownid LIKE apda_t.apdaownid, 
   apdaownid_desc LIKE type_t.chr80, 
   apdaowndp LIKE apda_t.apdaowndp, 
   apdaowndp_desc LIKE type_t.chr80, 
   apdacrtid LIKE apda_t.apdacrtid, 
   apdacrtid_desc LIKE type_t.chr80, 
   apdacrtdp LIKE apda_t.apdacrtdp, 
   apdacrtdp_desc LIKE type_t.chr80, 
   apdacrtdt LIKE apda_t.apdacrtdt, 
   apdamodid LIKE apda_t.apdamodid, 
   apdamodid_desc LIKE type_t.chr80, 
   apdamoddt LIKE apda_t.apdamoddt, 
   apdacnfid LIKE apda_t.apdacnfid, 
   apdacnfid_desc LIKE type_t.chr80, 
   apdacnfdt LIKE apda_t.apdacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apde_d        RECORD
       apdeseq LIKE apde_t.apdeseq, 
   apde008 LIKE apde_t.apde008, 
   apde008_desc LIKE type_t.chr500, 
   apde100 LIKE apde_t.apde100, 
   apde109 LIKE apde_t.apde109, 
   apde011 LIKE apde_t.apde011, 
   apde011_desc LIKE type_t.chr500, 
   apad003_desc LIKE type_t.chr500, 
   apde032 LIKE apde_t.apde032, 
   apde010 LIKE apde_t.apde010, 
   apdecomp LIKE apde_t.apdecomp, 
   apdesite LIKE apde_t.apdesite, 
   apde001 LIKE apde_t.apde001, 
   apde002 LIKE apde_t.apde002, 
   apde003 LIKE apde_t.apde003, 
   apde004 LIKE apde_t.apde004, 
   apde006 LIKE apde_t.apde006, 
   apde017 LIKE apde_t.apde017, 
   apde018 LIKE apde_t.apde018, 
   apde019 LIKE apde_t.apde019, 
   apde028 LIKE apde_t.apde028, 
   apde012 LIKE apde_t.apde012
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apdadocno LIKE apda_t.apdadocno,
      b_apdald LIKE apda_t.apdald,
      b_apda003 LIKE apda_t.apda003,
      b_apdadocdt LIKE apda_t.apdadocdt,
      b_apdasite LIKE apda_t.apdasite
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_fin_arg1            LIKE gzsz_t.gzsz002      #財務應用參數(定義於azzi991)D-FIN-3006--應付沖銷單性質
DEFINE g_ap_slip             LIKE ooba_t.ooba002      #應付帳款單單別
DEFINE g_glaa001             LIKE glaa_t.glaa001      #帳簿本幣
DEFINE g_glaa015             LIKE glaa_t.glaa015      #是否啟用本位幣二
DEFINE g_glaa016             LIKE glaa_t.glaa016      #本位幣二
DEFINE g_glaa017             LIKE glaa_t.glaa017      #本位幣二換算基準
DEFINE g_glaa019             LIKE glaa_t.glaa019      #是否啟用本位幣三
DEFINE g_glaa020             LIKE glaa_t.glaa020      #本位幣三
DEFINE g_glaa021             LIKE glaa_t.glaa021      #本位幣三換算基準
DEFINE g_glaa024             LIKE glaa_t.glaa024

DEFINE g_sql_bank            STRING #160122-00001#5 add by07675
DEFINE g_site_str            STRING #161115-00042#5 add 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apda_m          type_g_apda_m
DEFINE g_apda_m_t        type_g_apda_m
DEFINE g_apda_m_o        type_g_apda_m
DEFINE g_apda_m_mask_o   type_g_apda_m #轉換遮罩前資料
DEFINE g_apda_m_mask_n   type_g_apda_m #轉換遮罩後資料
 
   DEFINE g_apdadocno_t LIKE apda_t.apdadocno
DEFINE g_apdald_t LIKE apda_t.apdald
 
 
DEFINE g_apde_d          DYNAMIC ARRAY OF type_g_apde_d
DEFINE g_apde_d_t        type_g_apde_d
DEFINE g_apde_d_o        type_g_apde_d
DEFINE g_apde_d_mask_o   DYNAMIC ARRAY OF type_g_apde_d #轉換遮罩前資料
DEFINE g_apde_d_mask_n   DYNAMIC ARRAY OF type_g_apde_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt351.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   LET g_fin_arg1 = 'D-FIN-3006'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
 
   #end add-point
   LET g_forupd_sql = " SELECT apda006,'',apdadocdt,apdadocno,'',apda001,'',apdasite,'',apda003,'',apdacomp, 
       apdald,'','',apdastus,apda018,'',apda008,apda017,apda016,apda015,'',apdaownid,'',apdaowndp,'', 
       apdacrtid,'',apdacrtdp,'',apdacrtdt,apdamodid,'',apdamoddt,apdacnfid,'',apdacnfdt", 
                      " FROM apda_t",
                      " WHERE apdaent= ? AND apdald=? AND apdadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt351_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apda006,t0.apdadocdt,t0.apdadocno,t0.apda001,t0.apdasite,t0.apda003, 
       t0.apdacomp,t0.apdald,t0.apdastus,t0.apda018,t0.apda008,t0.apda017,t0.apda016,t0.apda015,t0.apdaownid, 
       t0.apdaowndp,t0.apdacrtid,t0.apdacrtdp,t0.apdacrtdt,t0.apdamodid,t0.apdamoddt,t0.apdacnfid,t0.apdacnfdt, 
       t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011",
               " FROM apda_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.apdaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apdaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apdacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apdacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apdamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apdacnfid  ",
 
               " WHERE t0.apdaent = " ||g_enterprise|| " AND t0.apdald = ? AND t0.apdadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt351_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt351 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt351_init()   
 
      #進入選單 Menu (="N")
      CALL aapt351_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt351
      
   END IF 
   
   CLOSE aapt351_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt351.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt351_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apdastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
    #160122-00001#5--add--str--by 07675
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#5--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL aapt351_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt351.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt351_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_cn          LIKE type_t.num10 #151125-00006#2
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aapt351_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_apda_m.* TO NULL
         CALL g_apde_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt351_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aapt351_fetch('') # reload data
               LET l_ac = 1
               CALL aapt351_ui_detailshow() #Setting the current row 
         
               CALL aapt351_idx_chk()
               #NEXT FIELD apdeseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apde_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt351_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt351_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt351_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aapt351_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt351_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt351_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt351_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt351_set_act_visible()   
            CALL aapt351_set_act_no_visible()
            IF NOT (g_apda_m.apdald IS NULL
              OR g_apda_m.apdadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                                  " apdald = '", g_apda_m.apdald, "' "
                                  ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
               #填到對應位置
               CALL aapt351_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apde_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt351_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apda_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apde_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt351_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt351_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapt351_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt351_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt351_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt351_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt351_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt351_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt351_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt351_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt351_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt351_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt351_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_apde_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD apdeseq
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt351_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt351_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#2--s
               CALL aapt351_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apdaent = g_enterprise  #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt351_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt351_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aap/aapt351_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aap/aapt351_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt351_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#2--s
               CALL aapt351_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apda_t
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apdaent = g_enterprise  #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt351_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt351_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#2--s
               CALL aapt351_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apdaent = g_enterprise  #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt351_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt351_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#2--s
               CALL aapt351_immediately_conf()
               SELECT COUNT(*) INTO l_cn FROM apda_t 
                WHERE apdald  = g_apda_m.apdald AND  apdacomp = g_apda_m.apdacomp AND apdadocno = g_apda_m.apdadocno
                  AND apdaent = g_enterprise  #160905-00002#1
               IF l_cn > 0 THEN
                  CALL aapt351_ui_headershow()
               END IF
               #151125-00006#2--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apda003
            LET g_action_choice="prog_apda003"
            IF cl_auth_chk_act("prog_apda003") THEN
               
               #add-point:ON ACTION prog_apda003 name="menu.prog_apda003"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_apda_m.apda003)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt351_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt351_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt351_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apda_m.apdadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aapt351.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt351_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ",
                      " ",
                      " LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno ", "  ",
                      #add-point:browser_fill段sql(apde_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE apdaent = " ||g_enterprise|| " AND apdeent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ", 
                      "  ",
                      "  ",
                      " WHERE apdaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apda_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
#160122-00001#5 -add -str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ",
                      " LEFT JOIN apde_t ON apdeent = apdaent AND apdeld = apdald AND apdedocno = apdadocno ", "  ", 
                      " WHERE apdaent = '" ||g_enterprise|| "' ",
                      " AND TRIM(apde008) IS NULL ",
                      " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apda_t"),
                      " UNION ",
                      " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ,apde_t",
                      " WHERE apdaent = '" ||g_enterprise|| "' ",
                      " AND apdeent = apdaent AND apdeld = apdald AND apdedocno = apdadocno ", "  ", 
#                      " AND apde008 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"') ",
                       " AND apde008 IN (",g_sql_bank,")",               #160122-00001#5 mod by 07675
                      " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apda_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t ", 
                      " LEFT JOIN apde_t ON apdeent = apdaent AND apdeld = apdald AND apdedocno = apdadocno ", "  ",
                      " WHERE apdaent = '" ||g_enterprise|| "' ",
                      " AND TRIM(apde008) IS NULL ",
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("apda_t"),
                      " UNION ",
                      " SELECT DISTINCT apdald,apdadocno ",
                      " FROM apda_t,apde_t ", 
                      " WHERE apdaent = '" ||g_enterprise|| "'  ",
                      " AND apdeent = apdaent AND apdeld = apdald AND apdedocno = apdadocno ", "  ", 
#                      " AND apde008 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"') ",
                       " AND apde008 IN (",g_sql_bank,")",               #160122-00001#5 mod by 07675
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("apda_t")
   END IF
#160122-00001#5 -add -end

   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_apda_m.* TO NULL
      CALL g_apde_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
 
                  " FROM apda_t t0",
                  "  ",
                  "  LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno ", "  ", 
                  #add-point:browser_fill段sql(apde_t1) name="browser_fill.join.apde_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.apdaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apda_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
 
                  " FROM apda_t t0",
                  "  ",
                  
                  " WHERE t0.apdaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apda_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY apdald,apdadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
#160122-00001#5 -add -str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
                  " FROM apda_t t0",
                  " LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno ", "  ", 
                  " WHERE t0.apdaent = '" ||g_enterprise|| "'  AND ",l_wc,
                  " AND TRIM(apde008) IS NULL ",
                  " AND ",l_wc2, cl_sql_add_filter("apda_t"),
                  " UNION ",
                  " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
                  " FROM apda_t t0,apde_t",
                  
                  " WHERE t0.apdaent = '" ||g_enterprise|| "'  AND ",l_wc,
                  " AND apdeent = apdaent AND apdeld = apdald AND apdedocno = apdadocno ", "  ", 
#                  " AND apde008 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"') ",
                   " AND apde008 IN (",g_sql_bank,")",               #160122-00001#5 mod by 07675
                  " AND ",l_wc2, cl_sql_add_filter("apda_t")
                  
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
                  " FROM apda_t t0",
                  " LEFT JOIN apde_t ON apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno ", "  ", 
                  " WHERE t0.apdaent = '" ||g_enterprise|| "' ",
                  " AND TRIM(apde008) IS NULL ",
                  " AND ",l_wc, cl_sql_add_filter("apda_t"),
                  " UNION ",
                  " SELECT DISTINCT t0.apdastus,t0.apdadocno,t0.apdald,t0.apda003,t0.apdadocdt,t0.apdasite ", 
                  " FROM apda_t t0,apde_t",             
                  " WHERE t0.apdaent = '" ||g_enterprise|| "'  ",
                  " AND apdeent = apdaent AND apdald = apdeld AND apdadocno = apdedocno ", "  ", 
#                  " AND apde008 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"') ",
                   " AND apde008 IN (",g_sql_bank,")",               #160122-00001#5 mod by 07675
                  " AND ",l_wc, cl_sql_add_filter("apda_t")
   END IF   
#160122-00001#5 -add -end

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apda_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apdadocno,g_browser[g_cnt].b_apdald, 
          g_browser[g_cnt].b_apda003,g_browser[g_cnt].b_apdadocdt,g_browser[g_cnt].b_apdasite
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL aapt351_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_apdald) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt351_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apda_m.apdald = g_browser[g_current_idx].b_apdald   
   LET g_apda_m.apdadocno = g_browser[g_current_idx].b_apdadocno   
 
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
   CALL aapt351_apda_t_mask()
   CALL aapt351_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt351.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt351_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt351_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_apdald = g_apda_m.apdald 
         AND g_browser[l_i].b_apdadocno = g_apda_m.apdadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt351_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ld_str          STRING  
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apda_m.* TO NULL
   CALL g_apde_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apda006,apdadocdt,apdadocno,apda001,apdasite,apda003,apdacomp,apdald, 
          apacsite,glaa005,apdastus,apda018,apda008,apda017,apda015,apdaownid,apdaowndp,apdacrtid,apdacrtdp, 
          apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apdacrtdt>>----
         AFTER FIELD apdacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apdamoddt>>----
         AFTER FIELD apdamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdacnfdt>>----
         AFTER FIELD apdacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda006
            #add-point:BEFORE FIELD apda006 name="construct.b.apda006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda006
            
            #add-point:AFTER FIELD apda006 name="construct.a.apda006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda006
            #add-point:ON ACTION controlp INFIELD apda006 name="construct.c.apda006"
            #開窗c段
            #零用金帳戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda006
            CALL q_apac001_1()  
            LET g_apda_m.apda006 = g_qryparam.return1  
            DISPLAY BY NAME g_apda_m.apda006
            NEXT FIELD apda006                                #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="construct.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="construct.a.apdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="construct.c.apdadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="construct.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="construct.a.apdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="construct.c.apdadocno"
            #開窗c段
            #單據編號
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apda001 ='41'"
            #161115-00042#5 add (s)
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdald")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161115-00042#5 add (e)
            CALL q_apdadocno()  
            LET g_apda_m.apdadocno = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO apdadocno           #顯示到畫面上
            NEXT FIELD apdadocno        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda001
            #add-point:BEFORE FIELD apda001 name="construct.b.apda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda001
            
            #add-point:AFTER FIELD apda001 name="construct.a.apda001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda001
            #add-point:ON ACTION controlp INFIELD apda001 name="construct.c.apda001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="construct.c.apdasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                  #161006-00005#22 Mark By Ken 161024                #160812-00027#1 add
            CALL q_ooef001_46()                #161006-00005#22 Add By Ken 161024 
            #CALL q_xrah002_2()                      #呼叫開窗 #160812-00027#1 mark
            DISPLAY g_qryparam.return1 TO apdasite  #顯示到畫面上
            NEXT FIELD apdasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="construct.b.apdasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="construct.a.apdasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161115-00042#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="construct.b.apda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="construct.a.apda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="construct.c.apda003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacomp
            #add-point:BEFORE FIELD apdacomp name="construct.b.apdacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacomp
            
            #add-point:AFTER FIELD apdacomp name="construct.a.apdacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacomp
            #add-point:ON ACTION controlp INFIELD apdacomp name="construct.c.apdacomp"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="construct.b.apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="construct.a.apdald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="construct.c.apdald"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apacsite
            #add-point:BEFORE FIELD apacsite name="construct.b.apacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apacsite
            
            #add-point:AFTER FIELD apacsite name="construct.a.apacsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apacsite
            #add-point:ON ACTION controlp INFIELD apacsite name="construct.c.apacsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa005
            #add-point:BEFORE FIELD glaa005 name="construct.b.glaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa005
            
            #add-point:AFTER FIELD glaa005 name="construct.a.glaa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa005
            #add-point:ON ACTION controlp INFIELD glaa005 name="construct.c.glaa005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdastus
            #add-point:BEFORE FIELD apdastus name="construct.b.apdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdastus
            
            #add-point:AFTER FIELD apdastus name="construct.a.apdastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdastus
            #add-point:ON ACTION controlp INFIELD apdastus name="construct.c.apdastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018
            #add-point:BEFORE FIELD apda018 name="construct.b.apda018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="construct.a.apda018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="construct.c.apda018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda008
            #add-point:BEFORE FIELD apda008 name="construct.b.apda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda008
            
            #add-point:AFTER FIELD apda008 name="construct.a.apda008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda008
            #add-point:ON ACTION controlp INFIELD apda008 name="construct.c.apda008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda017
            #add-point:BEFORE FIELD apda017 name="construct.b.apda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda017
            
            #add-point:AFTER FIELD apda017 name="construct.a.apda017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda017
            #add-point:ON ACTION controlp INFIELD apda017 name="construct.c.apda017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda015
            #add-point:BEFORE FIELD apda015 name="construct.b.apda015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda015
            
            #add-point:AFTER FIELD apda015 name="construct.a.apda015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda015
            #add-point:ON ACTION controlp INFIELD apda015 name="construct.c.apda015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdaownid
            #add-point:ON ACTION controlp INFIELD apdaownid name="construct.c.apdaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdaownid  #顯示到畫面上
            NEXT FIELD apdaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdaownid
            #add-point:BEFORE FIELD apdaownid name="construct.b.apdaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdaownid
            
            #add-point:AFTER FIELD apdaownid name="construct.a.apdaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdaowndp
            #add-point:ON ACTION controlp INFIELD apdaowndp name="construct.c.apdaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdaowndp  #顯示到畫面上
            NEXT FIELD apdaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdaowndp
            #add-point:BEFORE FIELD apdaowndp name="construct.b.apdaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdaowndp
            
            #add-point:AFTER FIELD apdaowndp name="construct.a.apdaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacrtid
            #add-point:ON ACTION controlp INFIELD apdacrtid name="construct.c.apdacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacrtid  #顯示到畫面上
            NEXT FIELD apdacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtid
            #add-point:BEFORE FIELD apdacrtid name="construct.b.apdacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacrtid
            
            #add-point:AFTER FIELD apdacrtid name="construct.a.apdacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacrtdp
            #add-point:ON ACTION controlp INFIELD apdacrtdp name="construct.c.apdacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacrtdp  #顯示到畫面上
            NEXT FIELD apdacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtdp
            #add-point:BEFORE FIELD apdacrtdp name="construct.b.apdacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacrtdp
            
            #add-point:AFTER FIELD apdacrtdp name="construct.a.apdacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacrtdt
            #add-point:BEFORE FIELD apdacrtdt name="construct.b.apdacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdamodid
            #add-point:ON ACTION controlp INFIELD apdamodid name="construct.c.apdamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdamodid  #顯示到畫面上
            NEXT FIELD apdamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdamodid
            #add-point:BEFORE FIELD apdamodid name="construct.b.apdamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdamodid
            
            #add-point:AFTER FIELD apdamodid name="construct.a.apdamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdamoddt
            #add-point:BEFORE FIELD apdamoddt name="construct.b.apdamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacnfid
            #add-point:ON ACTION controlp INFIELD apdacnfid name="construct.c.apdacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdacnfid  #顯示到畫面上
            NEXT FIELD apdacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfid
            #add-point:BEFORE FIELD apdacnfid name="construct.b.apdacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacnfid
            
            #add-point:AFTER FIELD apdacnfid name="construct.a.apdacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacnfdt
            #add-point:BEFORE FIELD apdacnfdt name="construct.b.apdacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apdeseq,apde008,apde008_desc,apde100,apde109,apde011,apde011_desc,apad003_desc, 
          apde032,apde010,apde002,apde003,apde004,apde006,apde017,apde018,apde019,apde028,apde012
           FROM s_detail1[1].apdeseq,s_detail1[1].apde008,s_detail1[1].apde008_desc,s_detail1[1].apde100, 
               s_detail1[1].apde109,s_detail1[1].apde011,s_detail1[1].apde011_desc,s_detail1[1].apad003_desc, 
               s_detail1[1].apde032,s_detail1[1].apde010,s_detail1[1].apde002,s_detail1[1].apde003,s_detail1[1].apde004, 
               s_detail1[1].apde006,s_detail1[1].apde017,s_detail1[1].apde018,s_detail1[1].apde019,s_detail1[1].apde028, 
               s_detail1[1].apde012
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeseq
            #add-point:BEFORE FIELD apdeseq name="construct.b.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeseq
            
            #add-point:AFTER FIELD apdeseq name="construct.a.page1.apdeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeseq
            #add-point:ON ACTION controlp INFIELD apdeseq name="construct.c.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="construct.b.page1.apde008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="construct.a.page1.apde008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="construct.c.page1.apde008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008_desc
            #add-point:BEFORE FIELD apde008_desc name="construct.b.page1.apde008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008_desc
            
            #add-point:AFTER FIELD apde008_desc name="construct.a.page1.apde008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008_desc
            #add-point:ON ACTION controlp INFIELD apde008_desc name="construct.c.page1.apde008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="construct.b.page1.apde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="construct.a.page1.apde100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="construct.c.page1.apde100"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apde100  #顯示到畫面上
            NEXT FIELD apde100                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="construct.b.page1.apde109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            
            #add-point:AFTER FIELD apde109 name="construct.a.page1.apde109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="construct.c.page1.apde109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="construct.b.page1.apde011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="construct.a.page1.apde011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="construct.c.page1.apde011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011_desc
            #add-point:BEFORE FIELD apde011_desc name="construct.b.page1.apde011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011_desc
            
            #add-point:AFTER FIELD apde011_desc name="construct.a.page1.apde011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011_desc
            #add-point:ON ACTION controlp INFIELD apde011_desc name="construct.c.page1.apde011_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apad003_desc
            #add-point:BEFORE FIELD apad003_desc name="construct.b.page1.apad003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apad003_desc
            
            #add-point:AFTER FIELD apad003_desc name="construct.a.page1.apad003_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apad003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apad003_desc
            #add-point:ON ACTION controlp INFIELD apad003_desc name="construct.c.page1.apad003_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="construct.b.page1.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="construct.a.page1.apde032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="construct.c.page1.apde032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="construct.b.page1.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="construct.a.page1.apde010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="construct.c.page1.apde010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="construct.b.page1.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="construct.a.page1.apde002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="construct.c.page1.apde002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde003
            #add-point:BEFORE FIELD apde003 name="construct.b.page1.apde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde003
            
            #add-point:AFTER FIELD apde003 name="construct.a.page1.apde003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde003
            #add-point:ON ACTION controlp INFIELD apde003 name="construct.c.page1.apde003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde004
            #add-point:BEFORE FIELD apde004 name="construct.b.page1.apde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde004
            
            #add-point:AFTER FIELD apde004 name="construct.a.page1.apde004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde004
            #add-point:ON ACTION controlp INFIELD apde004 name="construct.c.page1.apde004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde006
            #add-point:BEFORE FIELD apde006 name="construct.b.page1.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="construct.a.page1.apde006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="construct.c.page1.apde006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="construct.b.page1.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="construct.a.page1.apde017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="construct.c.page1.apde017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="construct.b.page1.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="construct.a.page1.apde018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="construct.c.page1.apde018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="construct.b.page1.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="construct.a.page1.apde019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="construct.c.page1.apde019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde028
            #add-point:BEFORE FIELD apde028 name="construct.b.page1.apde028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde028
            
            #add-point:AFTER FIELD apde028 name="construct.a.page1.apde028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde028
            #add-point:ON ACTION controlp INFIELD apde028 name="construct.c.page1.apde028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="construct.b.page1.apde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="construct.a.page1.apde012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apde012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="construct.c.page1.apde012"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apda_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apde_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc = "apda001 ='41'"
   ELSE
      LET g_wc = g_wc CLIPPED, " AND apda001 ='41'" CLIPPED
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt351_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON apdadocno,apdald,apda003,apdadocdt,apdasite
                          FROM s_browse[1].b_apdadocno,s_browse[1].b_apdald,s_browse[1].b_apda003,s_browse[1].b_apdadocdt, 
                              s_browse[1].b_apdasite
 
         BEFORE CONSTRUCT
               DISPLAY aapt351_filter_parser('apdadocno') TO s_browse[1].b_apdadocno
            DISPLAY aapt351_filter_parser('apdald') TO s_browse[1].b_apdald
            DISPLAY aapt351_filter_parser('apda003') TO s_browse[1].b_apda003
            DISPLAY aapt351_filter_parser('apdadocdt') TO s_browse[1].b_apdadocdt
            DISPLAY aapt351_filter_parser('apdasite') TO s_browse[1].b_apdasite
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aapt351_filter_show('apdadocno')
   CALL aapt351_filter_show('apdald')
   CALL aapt351_filter_show('apda003')
   CALL aapt351_filter_show('apdadocdt')
   CALL aapt351_filter_show('apdasite')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt351_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="aapt351.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt351_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapt351_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt351_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apde_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt351_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt351_browser_fill("")
      CALL aapt351_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt351_filter_show('apdadocno')
   CALL aapt351_filter_show('apdald')
   CALL aapt351_filter_show('apda003')
   CALL aapt351_filter_show('apdadocdt')
   CALL aapt351_filter_show('apdasite')
   CALL aapt351_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt351_fetch("F") 
      #顯示單身筆數
      CALL aapt351_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt351_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apda_m.apdald = g_browser[g_current_idx].b_apdald
   LET g_apda_m.apdadocno = g_browser[g_current_idx].b_apdadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt351_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt351_set_act_visible()   
   CALL aapt351_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_apda_m.apdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
 
   #end add-point
   
   #保存單頭舊值
   LET g_apda_m_t.* = g_apda_m.*
   LET g_apda_m_o.* = g_apda_m.*
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #重新顯示   
   CALL aapt351_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt351_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apde_d.clear()   
 
 
   INITIALIZE g_apda_m.* TO NULL             #DEFAULT 設定
   
   LET g_apdald_t = NULL
   LET g_apdadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apda_m.apdaownid = g_user
      LET g_apda_m.apdaowndp = g_dept
      LET g_apda_m.apdacrtid = g_user
      LET g_apda_m.apdacrtdp = g_dept 
      LET g_apda_m.apdacrtdt = cl_get_current()
      LET g_apda_m.apdamodid = g_user
      LET g_apda_m.apdamoddt = cl_get_current()
      LET g_apda_m.apdastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_apda_m.apda016 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_fin_orga_get_comp_ld(g_site)     RETURNING g_sub_success,g_errno,g_apda_m.apdacomp,g_apda_m.apdald                     
      CALL aapt351_setld_info(g_apda_m.apdald)
      LET g_apda_m.apdadocdt = cl_get_current()
      LET g_apda_m.apda003 = g_user
      LET g_apda_m.apda003_desc = s_desc_get_person_desc(g_apda_m.apda003)
      DISPLAY BY NAME g_apda_m.apda003_desc
      LET g_apda_m_t.*  = g_apda_m.*    #設定預設值後
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apda_m_t.* = g_apda_m.*
      LET g_apda_m_o.* = g_apda_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aapt351_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_apda_m.* TO NULL
         INITIALIZE g_apde_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt351_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apde_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt351_set_act_visible()   
   CALL aapt351_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt351_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt351_cl
   
   CALL aapt351_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt351_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apda006_desc,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apdadocno_desc, 
       g_apda_m.apda001,g_apda_m.fflabel_1,g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003, 
       g_apda_m.apda003_desc,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apda015_desc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
       g_apda_m.apdacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt351_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt351_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apda_m_t.* = g_apda_m.*
   LET g_apda_m_o.* = g_apda_m.*
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   CALL s_transaction_begin()
   
   OPEN aapt351_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt351_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aapt351_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt351_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aapt351_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_apdald_t = g_apda_m.apdald
      LET g_apdadocno_t = g_apda_m.apdadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apda_m.apdamodid = g_user 
LET g_apda_m.apdamoddt = cl_get_current()
LET g_apda_m.apdamodid_desc = cl_get_username(g_apda_m.apdamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_apda_m.apdastus MATCHES "[DR]" THEN 
         LET g_apda_m.apdastus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt351_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apda_t SET (apdamodid,apdamoddt) = (g_apda_m.apdamodid,g_apda_m.apdamoddt)
          WHERE apdaent = g_enterprise AND apdald = g_apdald_t
            AND apdadocno = g_apdadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apda_m.* = g_apda_m_t.*
            CALL aapt351_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apda_m.apdald != g_apda_m_t.apdald
      OR g_apda_m.apdadocno != g_apda_m_t.apdadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apde_t SET apdeld = g_apda_m.apdald
                                       ,apdedocno = g_apda_m.apdadocno
 
          WHERE apdeent = g_enterprise AND apdeld = g_apda_m_t.apdald
            AND apdedocno = g_apda_m_t.apdadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apde_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt351_set_act_visible()   
   CALL aapt351_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到對應位置
   CALL aapt351_browser_fill("")
 
   CLOSE aapt351_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt351_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt351.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt351_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   #DEFINE  l_apce                RECORD LIKE apce_t.*
   #DEFINE  l_apde                RECORD LIKE apde_t.* #161104-00024#3 mark
   #161104-00024#3-add(s)
   DEFINE l_apde  RECORD  #付款及差異處理明細檔
          apdeent   LIKE apde_t.apdeent, #企業編號
          apdecomp  LIKE apde_t.apdecomp, #法人
          apdeld    LIKE apde_t.apdeld, #帳套
          apdedocno LIKE apde_t.apdedocno, #沖銷單單號
          apdeseq   LIKE apde_t.apdeseq, #項次
          apdesite  LIKE apde_t.apdesite, #帳務中心
          apdeorga  LIKE apde_t.apdeorga, #帳務歸屬組織
          apde001   LIKE apde_t.apde001, #來源作業
          apde002   LIKE apde_t.apde002, #沖銷帳款類型
          apde003   LIKE apde_t.apde003, #已付款單號
          apde004   LIKE apde_t.apde004, #沖銷單項次
          apde006   LIKE apde_t.apde006, #款別編號
          apde008   LIKE apde_t.apde008, #帳戶/票券號碼
          apde009   LIKE apde_t.apde009, #已轉資料
          apde010   LIKE apde_t.apde010, #摘要說明
          apde011   LIKE apde_t.apde011, #銀行存提碼
          apde012   LIKE apde_t.apde012, #現金變動碼
          apde013   LIKE apde_t.apde013, #轉入客商碼
          apde014   LIKE apde_t.apde014, #轉入帳款單編號
          apde015   LIKE apde_t.apde015, #沖銷加減項
          apde016   LIKE apde_t.apde016, #沖銷會科
          apde017   LIKE apde_t.apde017, #業務人員
          apde018   LIKE apde_t.apde018, #業務部門
          apde019   LIKE apde_t.apde019, #責任中心
          apde020   LIKE apde_t.apde020, #產品類別
          apde021   LIKE apde_t.apde021, #票據類型
          apde022   LIKE apde_t.apde022, #專案編號
          apde023   LIKE apde_t.apde023, #WBS編號
          apde024   LIKE apde_t.apde024, #票據號碼
          apde028   LIKE apde_t.apde028, #產生方式
          apde029   LIKE apde_t.apde029, #傳票號碼
          apde030   LIKE apde_t.apde030, #傳票項次
          apde032   LIKE apde_t.apde032, #付款日
          apde035   LIKE apde_t.apde035, #區域
          apde036   LIKE apde_t.apde036, #客群
          apde038   LIKE apde_t.apde038, #對象
          apde039   LIKE apde_t.apde039, #受款銀行
          apde040   LIKE apde_t.apde040, #受款帳號
          apde041   LIKE apde_t.apde041, #受款人全名
          apde042   LIKE apde_t.apde042, #經營方式
          apde043   LIKE apde_t.apde043, #通路
          apde044   LIKE apde_t.apde044, #品牌
          apde045   LIKE apde_t.apde045, #摘要
          apde046   LIKE apde_t.apde046, #付款申請單
          apde047   LIKE apde_t.apde047, #付款申請單項次
          apde051   LIKE apde_t.apde051, #自由核算項一
          apde052   LIKE apde_t.apde052, #自由核算項二
          apde053   LIKE apde_t.apde053, #自由核算項三
          apde054   LIKE apde_t.apde054, #自由核算項四
          apde055   LIKE apde_t.apde055, #自由核算項五
          apde056   LIKE apde_t.apde056, #自由核算項六
          apde057   LIKE apde_t.apde057, #自由核算項七
          apde058   LIKE apde_t.apde058, #自由核算項八
          apde059   LIKE apde_t.apde059, #自由核算項九
          apde060   LIKE apde_t.apde060, #自由核算項十
          apde100   LIKE apde_t.apde100, #幣別
          apde101   LIKE apde_t.apde101, #匯率
          apde104   LIKE apde_t.apde104, #原幣應稅折抵稅額
          apde109   LIKE apde_t.apde109, #原幣沖帳金額
          apde119   LIKE apde_t.apde119, #本幣沖帳金額
          apde120   LIKE apde_t.apde120, #本位幣二幣別
          apde121   LIKE apde_t.apde121, #本位幣二匯率
          apde129   LIKE apde_t.apde129, #本位幣二沖帳金額
          apde130   LIKE apde_t.apde130, #本位幣三幣別
          apde131   LIKE apde_t.apde131, #本位幣三匯率
          apde139   LIKE apde_t.apde139, #本位幣三沖帳金額
          apdeud001 LIKE apde_t.apdeud001, #自定義欄位(文字)001
          apdeud002 LIKE apde_t.apdeud002, #自定義欄位(文字)002
          apdeud003 LIKE apde_t.apdeud003, #自定義欄位(文字)003
          apdeud004 LIKE apde_t.apdeud004, #自定義欄位(文字)004
          apdeud005 LIKE apde_t.apdeud005, #自定義欄位(文字)005
          apdeud006 LIKE apde_t.apdeud006, #自定義欄位(文字)006
          apdeud007 LIKE apde_t.apdeud007, #自定義欄位(文字)007
          apdeud008 LIKE apde_t.apdeud008, #自定義欄位(文字)008
          apdeud009 LIKE apde_t.apdeud009, #自定義欄位(文字)009
          apdeud010 LIKE apde_t.apdeud010, #自定義欄位(文字)010
          apdeud011 LIKE apde_t.apdeud011, #自定義欄位(數字)011
          apdeud012 LIKE apde_t.apdeud012, #自定義欄位(數字)012
          apdeud013 LIKE apde_t.apdeud013, #自定義欄位(數字)013
          apdeud014 LIKE apde_t.apdeud014, #自定義欄位(數字)014
          apdeud015 LIKE apde_t.apdeud015, #自定義欄位(數字)015
          apdeud016 LIKE apde_t.apdeud016, #自定義欄位(數字)016
          apdeud017 LIKE apde_t.apdeud017, #自定義欄位(數字)017
          apdeud018 LIKE apde_t.apdeud018, #自定義欄位(數字)018
          apdeud019 LIKE apde_t.apdeud019, #自定義欄位(數字)019
          apdeud020 LIKE apde_t.apdeud020, #自定義欄位(數字)020
          apdeud021 LIKE apde_t.apdeud021, #自定義欄位(日期時間)021
          apdeud022 LIKE apde_t.apdeud022, #自定義欄位(日期時間)022
          apdeud023 LIKE apde_t.apdeud023, #自定義欄位(日期時間)023
          apdeud024 LIKE apde_t.apdeud024, #自定義欄位(日期時間)024
          apdeud025 LIKE apde_t.apdeud025, #自定義欄位(日期時間)025
          apdeud026 LIKE apde_t.apdeud026, #自定義欄位(日期時間)026
          apdeud027 LIKE apde_t.apdeud027, #自定義欄位(日期時間)027
          apdeud028 LIKE apde_t.apdeud028, #自定義欄位(日期時間)028
          apdeud029 LIKE apde_t.apdeud029, #自定義欄位(日期時間)029
          apdeud030 LIKE apde_t.apdeud030, #自定義欄位(日期時間)030
          apde061   LIKE apde_t.apde061  #應付來源
              END RECORD
   #161104-00024#3-add(e)
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_msg                 STRING
   DEFINE  l_apde119             LIKE apde_t.apde119
   DEFINE  l_apde129             LIKE apde_t.apde129
   DEFINE  l_nmbc103             LIKE nmbc_t.nmbc103     #原幣金額
   DEFINE  l_nmbc113             LIKE nmbc_t.nmbc113     #本幣金額
   DEFINE  l_apad002             LIKE apad_t.apad002
   DEFINE  l_sum                 LIKE nmbc_t.nmbc113
   DEFINE  l_exeprog             LIKE type_t.chr80       #160321-00016#21 add
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apda006_desc,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apdadocno_desc, 
       g_apda_m.apda001,g_apda_m.fflabel_1,g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003, 
       g_apda_m.apda003_desc,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apda015_desc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
       g_apda_m.apdacnfdt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apdeseq,apde008,apde100,apde109,apde011,apde032,apde010,apdecomp,apdesite, 
       apde001,apde002,apde003,apde004,apde006,apde017,apde018,apde019,apde028,apde012 FROM apde_t WHERE  
       apdeent=? AND apdeld=? AND apdedocno=? AND apdeseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt351_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt351_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt351_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite, 
       g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
       g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda015
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt351.input.head" >}
      #單頭段
      INPUT BY NAME g_apda_m.apda006,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite, 
          g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
          g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda015 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt351_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt351_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt351_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt351_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aapt351_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda006
            
            #add-point:AFTER FIELD apda006 name="input.a.apda006"
            #零用金帳戶
            LET g_apda_m.apda006_desc = ''
            IF NOT cl_null(g_apda_m.apda006) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda006 != g_apda_m_t.apda006 OR g_apda_m_t.apda006 IS NULL )) THEN #160822-00008#1 Mark
               IF g_apda_m.apda006 != g_apda_m_o.apda006 OR cl_null(g_apda_m_o.apda006) THEN #160822-00008#1
                  CALL s_aap_apac001_chk(g_apda_m.apda006) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     LET g_errparam.replace[1] = 'aooi125'
                     LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi125'
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #160822-00008#1 Mark ---(S)---
                     #LET g_apda_m.apda006 = g_apda_m_t.apda006
                     #LET g_apda_m.apdald  = g_apda_m_t.apdald
                     #LET g_apda_m.apdacomp= g_apda_m_t.apdacomp
                     #LET g_apda_m.apdasite= g_apda_m_t.apdasite
                     #160822-00008#1  Mark ---(E)---
                     #160822-00008#1 ---(S)
                     LET g_apda_m.apda006 = g_apda_m_o.apda006
                     LET g_apda_m.apdald  = g_apda_m_o.apdald
                     LET g_apda_m.apdacomp= g_apda_m_o.apdacomp
                     LET g_apda_m.apdasite= g_apda_m_o.apdasite
                     #160822-00008#1 ---(E)                     
                     CALL aapt351_get_apda006_desc(g_apda_m.apda006) RETURNING g_apda_m.apda006_desc
                     DISPLAY BY NAME g_apda_m.apda006_desc
                     NEXT FIELD CURRENT
                  END IF
                  #預設帶零用金帳戶預設值
                  LET g_apda_m.apacsite = ''
                  LET g_apda_m.apdasite = ''
                  SELECT apac005,apacsite INTO g_apda_m.apdasite,g_apda_m.apacsite  #零用帳戶歸屬的營運據點/帳務中心
                    FROM apac_t 
                   WHERE apacent = g_enterprise AND apac001 = g_apda_m.apda006
                  CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
                  DISPLAY BY NAME g_apda_m.apdasite_desc
               END IF
            END IF
            CALL aapt351_get_apda006_desc(g_apda_m.apda006) RETURNING g_apda_m.apda006_desc
            DISPLAY BY NAME g_apda_m.apda006_desc
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda006
            #add-point:BEFORE FIELD apda006 name="input.b.apda006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda006
            #add-point:ON CHANGE apda006 name="input.g.apda006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="input.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="input.a.apdadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocdt
            #add-point:ON CHANGE apdadocdt name="input.g.apdadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            #撥補單號
            LET g_apda_m.apdadocno_desc = ''
            #檢查是否有重複的單據編號(企業代碼/帳別/單號)
            IF NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_apda_m_t.apdadocno) OR g_apda_m.apdadocno != g_apda_m_t.apdadocno)) THEN 
                  #檢查單別是否存在單別檔/單別是有效
                  LET g_errno = NULL
                  IF NOT s_aooi200_fin_chk_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,g_prog) THEN
                     LET g_apda_m.apdadocno = g_apda_m_t.apdadocno
                     NEXT FIELD CURRENT
                  END IF
                  #取得單別性質(apda001)
                  CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
                  CALL s_fin_get_doc_para('',g_apda_m.apdacomp,g_ap_slip,g_fin_arg1) RETURNING g_apda_m.apda001
                  DISPLAY BY NAME g_apda_m.apda001
               END IF
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno) RETURNING g_apda_m.apdadocno_desc
            DISPLAY BY NAME g_apda_m.apdadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocno
            #add-point:ON CHANGE apdadocno name="input.g.apdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda001
            #add-point:BEFORE FIELD apda001 name="input.b.apda001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda001
            
            #add-point:AFTER FIELD apda001 name="input.a.apda001"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda001
            #add-point:ON CHANGE apda001 name="input.g.apda001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            LET g_apda_m.apdasite_desc = ' '
            IF NOT cl_null(g_apda_m.apdasite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apdasite != g_apda_m_t.apdasite OR cl_null(g_apda_m.apdasite) )) THEN #160822-00008#1 Mark
               IF g_apda_m.apdasite != g_apda_m_o.apdasite OR cl_null(g_apda_m_o.apdasite) THEN #160822-00008#1
                 #CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,g_apda_m.apdald,g_user,'3','N','',g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno
                  #CALL s_fin_account_center_chk(g_apda_m.apdasite,g_apda_m.apdasite,'3',g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno        #160812-00027#1 mark
                  CALL s_fin_account_center_with_ld_chk(g_apda_m.apdasite,'',g_user,'3','N','',g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno  #160812-00027#1 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apda_m.apdasite = g_apda_m_t.apdasite #160822-00008#1 Mark
                     LET g_apda_m.apdasite = g_apda_m_o.apdasite  #160822-00008#1 
                     CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc
                     DISPLAY BY NAME g_apda_m.apdasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_apda_m.apdasite) RETURNING g_apda_m.apdasite_desc                    
            DISPLAY BY NAME g_apda_m.apdasite_desc
            LET g_apda_m_o.* = g_apda_m.*   #160822-00008#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="input.b.apdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdasite
            #add-point:ON CHANGE apdasite name="input.g.apdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="input.a.apda003"
            #申請人員
            LET g_apda_m.apda003_desc = ' '
            IF NOT cl_null(g_apda_m.apda003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apda_m.apda003 != g_apda_m_t.apda003 OR g_apda_m_t.apda003 IS NULL )) THEN
                  CALL s_employee_chk(g_apda_m.apda003) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apda_m.apda003 = g_apda_m_t.apda003
                     CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
                     DISPLAY BY NAME g_apda_m.apda003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
            DISPLAY BY NAME g_apda_m.apda003_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="input.b.apda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda003
            #add-point:ON CHANGE apda003 name="input.g.apda003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdacomp
            #add-point:BEFORE FIELD apdacomp name="input.b.apdacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdacomp
            
            #add-point:AFTER FIELD apdacomp name="input.a.apdacomp"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdacomp
            #add-point:ON CHANGE apdacomp name="input.g.apdacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apda_m.apdald) AND NOT cl_null(g_apda_m.apdadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t  OR g_apda_m.apdadocno != g_apdadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apda_t WHERE "||"apdaent = '" ||g_enterprise|| "' AND "||"apdald = '"||g_apda_m.apdald ||"' AND "|| "apdadocno = '"||g_apda_m.apdadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apacsite
            #add-point:BEFORE FIELD apacsite name="input.b.apacsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apacsite
            
            #add-point:AFTER FIELD apacsite name="input.a.apacsite"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apacsite
            #add-point:ON CHANGE apacsite name="input.g.apacsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa005
            #add-point:BEFORE FIELD glaa005 name="input.b.glaa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa005
            
            #add-point:AFTER FIELD glaa005 name="input.a.glaa005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa005
            #add-point:ON CHANGE glaa005 name="input.g.glaa005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdastus
            #add-point:BEFORE FIELD apdastus name="input.b.apdastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdastus
            
            #add-point:AFTER FIELD apdastus name="input.a.apdastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdastus
            #add-point:ON CHANGE apdastus name="input.g.apdastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="input.a.apda018"
            #請款理由碼
            LET g_apda_m.apda018_desc = ''
            IF NOT cl_null(g_apda_m.apda018) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_apda_m.apda018 != g_apda_m_t.apda018 OR g_apda_m_t.apda018 IS NULL ) )) THEN
                  IF NOT s_azzi650_chk_exist('3212',g_apda_m.apda018) THEN
                     LET g_apda_m.apda018 = g_apda_m_t.apda018
                     CALL s_desc_get_acc_desc('3212',g_apda_m.apda018) RETURNING g_apda_m.apda018_desc
                     DISPLAY BY NAME g_apda_m.apda018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               NEXT FIELD CURRENT 
            END IF
            CALL s_desc_get_acc_desc('3212',g_apda_m.apda018) RETURNING g_apda_m.apda018_desc
            DISPLAY BY NAME g_apda_m.apda018_desc   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018
            #add-point:BEFORE FIELD apda018 name="input.b.apda018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda018
            #add-point:ON CHANGE apda018 name="input.g.apda018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda008
            #add-point:BEFORE FIELD apda008 name="input.b.apda008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda008
            
            #add-point:AFTER FIELD apda008 name="input.a.apda008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda008
            #add-point:ON CHANGE apda008 name="input.g.apda008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda017
            #add-point:BEFORE FIELD apda017 name="input.b.apda017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda017
            
            #add-point:AFTER FIELD apda017 name="input.a.apda017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda017
            #add-point:ON CHANGE apda017 name="input.g.apda017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda015
            
            #add-point:AFTER FIELD apda015 name="input.a.apda015"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda015
            #add-point:BEFORE FIELD apda015 name="input.b.apda015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda015
            #add-point:ON CHANGE apda015 name="input.g.apda015"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apda006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda006
            #add-point:ON ACTION controlp INFIELD apda006 name="input.c.apda006"
            #開窗i段
            #零用金帳戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda006
            CALL q_apac001_1()  
            LET g_apda_m.apda006 = g_qryparam.return1  
            DISPLAY BY NAME g_apda_m.apda006
            NEXT FIELD apda006                                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="input.c.apdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="input.c.apdadocno"
            #撥補單號            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apdadocno      #給予default值
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()
            LET g_apda_m.apdadocno = g_qryparam.return1
            CALL s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno) RETURNING g_apda_m.apdadocno_desc
            CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING g_sub_success,g_ap_slip
            CALL s_fin_get_doc_para('',g_apda_m.apdacomp,g_ap_slip,g_fin_arg1) RETURNING g_apda_m.apda001
            
            DISPLAY BY NAME g_apda_m.apdadocno,g_apda_m.apdadocno_desc,g_apda_m.apda001
            NEXT FIELD apdadocno                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apda001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda001
            #add-point:ON ACTION controlp INFIELD apda001 name="input.c.apda001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   #CALL q_ooef001()           #161006-00005#22 Mark By Ken 161024    #160812-00027#1 add
			   CALL q_ooef001_46()         #161006-00005#22 Add By Ken 161024
            #CALL q_xrah002_2()          #160812-00027#1 mark
            LET g_apda_m.apdasite = g_qryparam.return1
            LET g_apda_m.apdasite_desc = g_qryparam.return2
            DISPLAY BY NAME g_apda_m.apdasite,g_apda_m.apdasite_desc
            #END add-point
 
 
         #Ctrlp:input.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="input.c.apda003"
            #帳務人員            
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda003      #給予default值
            CALL q_ooag001()  
            LET g_apda_m.apda003 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_apda_m.apda003) RETURNING g_apda_m.apda003_desc
            DISPLAY BY NAME g_apda_m.apda003,g_apda_m.apda003_desc
            NEXT FIELD apda003                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apdacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdacomp
            #add-point:ON ACTION controlp INFIELD apdacomp name="input.c.apdacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            
            #END add-point
 
 
         #Ctrlp:input.c.apacsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apacsite
            #add-point:ON ACTION controlp INFIELD apacsite name="input.c.apacsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa005
            #add-point:ON ACTION controlp INFIELD glaa005 name="input.c.glaa005"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdastus
            #add-point:ON ACTION controlp INFIELD apdastus name="input.c.apdastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="input.c.apda018"
            #開窗i段
            #請款理由碼
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
   			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apda_m.apda018
            LET g_qryparam.arg1 = "3212"
            CALL q_oocq002()   
            LET g_apda_m.apda018 = g_qryparam.return1 
            CALL s_desc_get_acc_desc('3212',g_apda_m.apda018) RETURNING g_apda_m.apda018_desc
            DISPLAY BY NAME g_apda_m.apda018,g_apda_m.apda018_desc
            NEXT FIELD apda018
            #END add-point
 
 
         #Ctrlp:input.c.apda008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda008
            #add-point:ON ACTION controlp INFIELD apda008 name="input.c.apda008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda017
            #add-point:ON ACTION controlp INFIELD apda017 name="input.c.apda017"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda015
            #add-point:ON ACTION controlp INFIELD apda015 name="input.c.apda015"
 
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apda_m.apdald,g_apda_m.apdadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               CALL s_aooi200_fin_gen_docno(g_apda_m.apdald,'','',g_apda_m.apdadocno,g_apda_m.apdadocdt,g_prog)
                    RETURNING l_success,g_apda_m.apdadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apda_m.apdadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  NEXT FIELD apdadocno
               END IF
               DISPLAY BY NAME g_apda_m.apdadocno
               #end add-point
               
               INSERT INTO apda_t (apdaent,apda006,apdadocdt,apdadocno,apda001,apdasite,apda003,apdacomp, 
                   apdald,apdastus,apda018,apda008,apda017,apda016,apda015,apdaownid,apdaowndp,apdacrtid, 
                   apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt)
               VALUES (g_enterprise,g_apda_m.apda006,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apda001, 
                   g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apdastus, 
                   g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
                   g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
                   g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apda_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               #新增預設值
               UPDATE apda_t 
                  SET apda004 = 'PETY' ,apda005 = 'PETY', apda007 = '0',apda011 = '0',apda013 = 'N'
                WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald AND apdadocno = g_apda_m.apdadocno
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt351_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt351_b_fill()
                  CALL aapt351_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt351_apda_t_mask_restore('restore_mask_o')
               
               UPDATE apda_t SET (apda006,apdadocdt,apdadocno,apda001,apdasite,apda003,apdacomp,apdald, 
                   apdastus,apda018,apda008,apda017,apda016,apda015,apdaownid,apdaowndp,apdacrtid,apdacrtdp, 
                   apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt) = (g_apda_m.apda006,g_apda_m.apdadocdt, 
                   g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp, 
                   g_apda_m.apdald,g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017, 
                   g_apda_m.apda016,g_apda_m.apda015,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid, 
                   g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid, 
                   g_apda_m.apdacnfdt)
                WHERE apdaent = g_enterprise AND apdald = g_apdald_t
                  AND apdadocno = g_apdadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apda_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF g_apda_m.apda003 != g_apda_m_t.apda003 THEN
                  LET l_cnt = 0
                  SELECT count(*) INTO l_cnt
                    FROM apde_t
                   WHERE apdeent   = g_enterprise AND apdeld =  g_apda_m.apdald
                     AND apdedocno = g_apda_m.apdadocno
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  IF l_cnt > 0 THEN
                     CALL s_employee_get_dept(g_apda_m.apda003) RETURNING g_sub_success,g_errno,l_apde.apde018,l_msg
                     IF NOT cl_null(l_apde.apde018) THEN
                        CALL s_department_get_respon_center(l_apde.apde018,g_apda_m.apdadocdt)  RETURNING g_sub_success,g_errno,l_apde.apde019,l_msg
                     END IF
                     IF cl_null(l_apde.apde019) THEN LET l_apde.apde019 = l_apde.apde018 END IF
                     UPDATE apde_t
                        SET (apde017,apde018,apde019) =(g_apda_m.apda003,l_apde.apde018,l_apde.apde019)
                      WHERE apdeent   = g_enterprise AND apdeld =  g_apda_m.apdald
                        AND apdedocno = g_apda_m.apdadocno
                  END IF
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt351_apda_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apda_m_t)
               LET g_log2 = util.JSON.stringify(g_apda_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apdald_t = g_apda_m.apdald
            LET g_apdadocno_t = g_apda_m.apdadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt351.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apde_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apde_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt351_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apde_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt351_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt351_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt351_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apde_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apde_d[l_ac].apdeseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apde_d_t.* = g_apde_d[l_ac].*  #BACKUP
               LET g_apde_d_o.* = g_apde_d[l_ac].*  #BACKUP
               CALL aapt351_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt351_set_no_entry_b(l_cmd)
               IF NOT aapt351_lock_b("apde_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt351_bcl INTO g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde100, 
                      g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde010, 
                      g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde002, 
                      g_apde_d[l_ac].apde003,g_apde_d[l_ac].apde004,g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde017, 
                      g_apde_d[l_ac].apde018,g_apde_d[l_ac].apde019,g_apde_d[l_ac].apde028,g_apde_d[l_ac].apde012 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apde_d_t.apdeseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apde_d_mask_o[l_ac].* =  g_apde_d[l_ac].*
                  CALL aapt351_apde_t_mask()
                  LET g_apde_d_mask_n[l_ac].* =  g_apde_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt351_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apde_d[l_ac].* TO NULL 
            INITIALIZE g_apde_d_t.* TO NULL 
            INITIALIZE g_apde_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #取得g_apda_m.apda003的人員歸屬部門/責任中心
            LET g_apde_d[l_ac].apdecomp = g_apda_m.apdacomp
            LET g_apde_d[l_ac].apdesite = g_apda_m.apdasite
           # LET g_apde_d[l_ac].apdelegl = g_apda_m.apdacomp
            LET g_apde_d[l_ac].apde003  = g_apda_m.apdadocno
            LET g_apde_d[l_ac].apde017  = g_apda_m.apda003
            CALL s_employee_get_dept(g_apda_m.apda003) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde018,l_msg
            IF NOT cl_null(g_apde_d[l_ac].apde018) THEN
               CALL s_department_get_respon_center(g_apde_d[l_ac].apde018,g_apda_m.apdadocdt) RETURNING g_sub_success,g_errno,g_apde_d[l_ac].apde019,l_msg
            END IF
            IF cl_null(g_apde_d[l_ac].apde019) THEN LET g_apde_d[l_ac].apde019 = g_apde_d[l_ac].apde018 END IF
            #end add-point
            LET g_apde_d_t.* = g_apde_d[l_ac].*     #新輸入資料
            LET g_apde_d_o.* = g_apde_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt351_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt351_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
 
               LET g_apde_d[li_reproduce_target].apdeseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF l_cmd = 'a' AND cl_null(g_apde_d[l_ac].apdeseq) THEN
               SELECT MAX(apdeseq)+1 INTO g_apde_d[l_ac].apdeseq
                 FROM apde_t
                WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
                  AND apdedocno = g_apda_m.apdadocno        
               IF cl_null(g_apde_d[l_ac].apdeseq) THEN LET g_apde_d[l_ac].apdeseq = 1 END IF  
            END IF
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apde_t 
             WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno
 
               AND apdeseq = g_apde_d[l_ac].apdeseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys[3] = g_apde_d[g_detail_idx].apdeseq
               CALL aapt351_insert_b('apde_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
 
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apde_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt351_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apda_m.apdald
               LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apde_d_t.apdeseq
 
            
               #刪除同層單身
               IF NOT aapt351_delete_b('apde_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt351_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt351_key_delete_b(gs_keys,'apde_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt351_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt351_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apde_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apde_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdeseq
            #add-point:BEFORE FIELD apdeseq name="input.b.page1.apdeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdeseq
            
            #add-point:AFTER FIELD apdeseq name="input.a.page1.apdeseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apda_m.apdald IS NOT NULL AND g_apda_m.apdadocno IS NOT NULL AND g_apde_d[g_detail_idx].apdeseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apda_m.apdald != g_apdald_t OR g_apda_m.apdadocno != g_apdadocno_t OR g_apde_d[g_detail_idx].apdeseq != g_apde_d_t.apdeseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apde_t WHERE "||"apdeent = '" ||g_enterprise|| "' AND "||"apdeld = '"||g_apda_m.apdald ||"' AND "|| "apdedocno = '"||g_apda_m.apdadocno ||"' AND "|| "apdeseq = '"||g_apde_d[g_detail_idx].apdeseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdeseq
            #add-point:ON CHANGE apdeseq name="input.g.page1.apdeseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008
            
            #add-point:AFTER FIELD apde008 name="input.a.page1.apde008"
            LET g_apde_d[l_ac].apde008_desc = ''
            IF NOT cl_null(g_apde_d[l_ac].apde008) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apde_d[l_ac].apde008 != g_apde_d_t.apde008 OR g_apde_d_t.apde008 IS NULL )) THEN #160822-00008#1 Mark
               IF g_apde_d[l_ac].apde008 != g_apde_d_o.apde008 OR cl_null(g_apde_d_o.apde008) THEN #160822-00008#1 
                  #檢核是否存在aapi350 
                  CALL s_anm_apad002_chk(g_apda_m.apda006,g_apde_d[l_ac].apde008) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apde_d[l_ac].apde008 = g_apde_d_t.apde008 #160822-00008#1 Mark
                     LET g_apde_d[l_ac].apde008 = g_apde_d_o.apde008  #160822-00008#1
                     NEXT FIELD CURRENT
                  END IF
                  #檢核是否存在銀行基本資料anmi120
                  LET g_errparam.exeprog = '' #160321-00016#21 add
                  LET l_exeprog = ''          #160321-00016#21 add
                  CALL s_anm_nmas002_chk(g_apde_d[l_ac].apde008) RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errparam.exeprog)THEN LET l_exeprog = g_errparam.exeprog END IF #160321-00016#21 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#21 --s add
                     IF NOT cl_null(l_exeprog) THEN
                        LET g_errparam.replace[1] = l_exeprog
                        LET g_errparam.replace[2] = cl_get_progname(l_exeprog,g_lang,"2")
                        LET g_errparam.exeprog = l_exeprog
                     END IF
                     #160321-00016#21 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apde_d[l_ac].apde008 = g_apde_d_t.apde008 #160822-00008#1 Mark
                     LET g_apde_d[l_ac].apde008 = g_apde_d_o.apde008  #160822-00008#1
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160122-00001#5 --add---str
                  IF NOT s_anmi120_nmll002_chk(g_apde_d[l_ac].apde008,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apde_d[l_ac].apde008
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     #LET g_apde_d[l_ac].apde008 = g_apde_d_t.apde008 #160822-00008#1 Mark
                     LET g_apde_d[l_ac].apde008 = g_apde_d_o.apde008  #160822-00008#1
                     NEXT FIELD CURRENT
                  END IF
                  #160122-00001#5 --add---end
                  #若無申請撥補金額給銀行餘額
                  IF cl_null(g_apde_d[l_ac].apde109) THEN
                     CALL s_anm_get_nmbc002_surplus(g_apde_d[l_ac].apde008,g_apda_m.apdadocdt) RETURNING g_apde_d[l_ac].apde109,l_nmbc113
                  END IF

               END IF
            END IF
            CALL aapt351_get_apce008_info(g_apda_m.apda006,g_apde_d[l_ac].apde008) RETURNING g_apde_d[l_ac].apde008_desc,g_apde_d[l_ac].apad003_desc
            LET g_apde_d_o.* = g_apde_d[l_ac].*   #160822-00008#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008
            #add-point:BEFORE FIELD apde008 name="input.b.page1.apde008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde008
            #add-point:ON CHANGE apde008 name="input.g.page1.apde008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde008_desc
            #add-point:BEFORE FIELD apde008_desc name="input.b.page1.apde008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde008_desc
            
            #add-point:AFTER FIELD apde008_desc name="input.a.page1.apde008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde008_desc
            #add-point:ON CHANGE apde008_desc name="input.g.page1.apde008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde100
            #add-point:BEFORE FIELD apde100 name="input.b.page1.apde100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde100
            
            #add-point:AFTER FIELD apde100 name="input.a.page1.apde100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde100
            #add-point:ON CHANGE apde100 name="input.g.page1.apde100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apde_d[l_ac].apde109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apde109
            END IF 
 
 
 
            #add-point:AFTER FIELD apde109 name="input.a.page1.apde109"
            IF NOT cl_null(g_apde_d[l_ac].apde109) AND NOT cl_null(g_apde_d[l_ac].apde008) AND NOT cl_null(g_apda_m.apdadocdt) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apde_d[l_ac].apde109 != g_apde_d_t.apde109 OR g_apde_d_t.apde109 IS NULL )) THEN
                  #交易帳號上限檢核：申請之金額與目前餘額合計值，不可＞留存上限金額apda004
                  CALL s_anm_get_nmbc002_surplus(g_apde_d[l_ac].apde008,g_apda_m.apdadocdt) RETURNING l_nmbc103,l_nmbc113
                  IF g_apde_d[l_ac].apde109 > l_nmbc103 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00133'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde109
            #add-point:BEFORE FIELD apde109 name="input.b.page1.apde109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde109
            #add-point:ON CHANGE apde109 name="input.g.page1.apde109"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011
            
            #add-point:AFTER FIELD apde011 name="input.a.page1.apde011"
            #存提碼
            LET g_apde_d[l_ac].apde011_desc = ""
            IF NOT cl_null(g_apde_d[l_ac].apde011) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apde_d[l_ac].apde011 != g_apde_d_t.apde011 OR g_apde_d_t.apde011 IS NULL )) THEN  #160822-00008#1 Mark
               IF g_apde_d[l_ac].apde011 != g_apde_d_o.apde011 OR cl_null(g_apde_d_o.apde011) THEN #160822-00008#1
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apda_m.glaa005
                  LET g_chkparam.arg2 = g_apde_d[l_ac].apde011
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
                  #160318-00025#24  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmad002") THEN
                     #LET g_apde_d[l_ac].apde011 = g_apde_d_t.apde011 #160822-00008#1 Mark
                     LET g_apde_d[l_ac].apde011 = g_apde_d_o.apde011  #160822-00008#1 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011) RETURNING g_apde_d[l_ac].apde011_desc
               SELECT nmad003 INTO g_apde_d[l_ac].apde012
                 FROM nmad_t
                WHERE nmadent = g_enterprise
                  AND nmad001 = g_apda_m.glaa005
                  AND nmad002 = g_apde_d[l_ac].apde011
            END IF
            DISPLAY BY NAME g_apde_d[l_ac].apde011_desc
            LET g_apde_d_o.* = g_apde_d[l_ac].*   #160822-00008#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011
            #add-point:BEFORE FIELD apde011 name="input.b.page1.apde011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde011
            #add-point:ON CHANGE apde011 name="input.g.page1.apde011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde011_desc
            #add-point:BEFORE FIELD apde011_desc name="input.b.page1.apde011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde011_desc
            
            #add-point:AFTER FIELD apde011_desc name="input.a.page1.apde011_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde011_desc
            #add-point:ON CHANGE apde011_desc name="input.g.page1.apde011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apad003_desc
            #add-point:BEFORE FIELD apad003_desc name="input.b.page1.apad003_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apad003_desc
            
            #add-point:AFTER FIELD apad003_desc name="input.a.page1.apad003_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apad003_desc
            #add-point:ON CHANGE apad003_desc name="input.g.page1.apad003_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde032
            #add-point:BEFORE FIELD apde032 name="input.b.page1.apde032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde032
            
            #add-point:AFTER FIELD apde032 name="input.a.page1.apde032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde032
            #add-point:ON CHANGE apde032 name="input.g.page1.apde032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde010
            #add-point:BEFORE FIELD apde010 name="input.b.page1.apde010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde010
            
            #add-point:AFTER FIELD apde010 name="input.a.page1.apde010"
            #摘要
            IF NOT cl_null(g_apde_d[l_ac].apde010) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apde_d[l_ac].apde010 != g_apde_d_t.apde010 OR g_apde_d_t.apde010 IS NULL )) THEN
                  LET l_msg = g_apde_d[l_ac].apde010
                  IF l_ac > 1 THEN
                     IF l_msg.toUpperCase() = 'CC' THEN
                        LET g_apde_d[l_ac].apde010 = g_apde_d[l_ac-1].apde010
                     END IF
                  END IF
                  IF l_msg.subString(1,1) = '.' THEN
                     LET g_apde_d[l_ac].apde010 = g_apde_d[l_ac].apde010[2,10]
                     SELECT oocql004 INTO g_apde_d[l_ac].apde010
                       FROM oocql_t
                      WHERE oocqlent = g_enterprise AND oocql001 = '3005'
                        AND oocql002 = g_apde_d[l_ac].apde010 AND oocql003 = g_dlang
                     DISPLAY BY NAME g_apde_d[l_ac].apde010
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde010
            #add-point:ON CHANGE apde010 name="input.g.page1.apde010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdecomp
            #add-point:BEFORE FIELD apdecomp name="input.b.page1.apdecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdecomp
            
            #add-point:AFTER FIELD apdecomp name="input.a.page1.apdecomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdecomp
            #add-point:ON CHANGE apdecomp name="input.g.page1.apdecomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdesite
            #add-point:BEFORE FIELD apdesite name="input.b.page1.apdesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdesite
            
            #add-point:AFTER FIELD apdesite name="input.a.page1.apdesite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdesite
            #add-point:ON CHANGE apdesite name="input.g.page1.apdesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde001
            #add-point:BEFORE FIELD apde001 name="input.b.page1.apde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde001
            
            #add-point:AFTER FIELD apde001 name="input.a.page1.apde001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde001
            #add-point:ON CHANGE apde001 name="input.g.page1.apde001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde002
            #add-point:BEFORE FIELD apde002 name="input.b.page1.apde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde002
            
            #add-point:AFTER FIELD apde002 name="input.a.page1.apde002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde002
            #add-point:ON CHANGE apde002 name="input.g.page1.apde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde003
            #add-point:BEFORE FIELD apde003 name="input.b.page1.apde003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde003
            
            #add-point:AFTER FIELD apde003 name="input.a.page1.apde003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde003
            #add-point:ON CHANGE apde003 name="input.g.page1.apde003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde004
            #add-point:BEFORE FIELD apde004 name="input.b.page1.apde004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde004
            
            #add-point:AFTER FIELD apde004 name="input.a.page1.apde004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde004
            #add-point:ON CHANGE apde004 name="input.g.page1.apde004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde006
            #add-point:BEFORE FIELD apde006 name="input.b.page1.apde006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde006
            
            #add-point:AFTER FIELD apde006 name="input.a.page1.apde006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde006
            #add-point:ON CHANGE apde006 name="input.g.page1.apde006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde017
            #add-point:BEFORE FIELD apde017 name="input.b.page1.apde017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde017
            
            #add-point:AFTER FIELD apde017 name="input.a.page1.apde017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde017
            #add-point:ON CHANGE apde017 name="input.g.page1.apde017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde018
            #add-point:BEFORE FIELD apde018 name="input.b.page1.apde018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde018
            
            #add-point:AFTER FIELD apde018 name="input.a.page1.apde018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde018
            #add-point:ON CHANGE apde018 name="input.g.page1.apde018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde019
            #add-point:BEFORE FIELD apde019 name="input.b.page1.apde019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde019
            
            #add-point:AFTER FIELD apde019 name="input.a.page1.apde019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde019
            #add-point:ON CHANGE apde019 name="input.g.page1.apde019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde028
            #add-point:BEFORE FIELD apde028 name="input.b.page1.apde028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde028
            
            #add-point:AFTER FIELD apde028 name="input.a.page1.apde028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde028
            #add-point:ON CHANGE apde028 name="input.g.page1.apde028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apde012
            #add-point:BEFORE FIELD apde012 name="input.b.page1.apde012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apde012
            
            #add-point:AFTER FIELD apde012 name="input.a.page1.apde012"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apde012
            #add-point:ON CHANGE apde012 name="input.g.page1.apde012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apdeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdeseq
            #add-point:ON ACTION controlp INFIELD apdeseq name="input.c.page1.apdeseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008
            #add-point:ON ACTION controlp INFIELD apde008 name="input.c.page1.apde008"
	    	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde008
#            LET g_qryparam.where    = "apad001 = '",g_apda_m.apda006,"'" #160122-00001#5 mrak
            #160122-00001#5 -add -str
#            LET g_qryparam.where    = " apad001 = '",g_apda_m.apda006,"'",
#                                      "  AND apad002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')"
            LET g_qryparam.where    = " apad001 = '",g_apda_m.apda006,"'",
                                      "  AND apad002 IN(",g_sql_bank,") " #160122-00001#5 mod by 07675
            #160122-00001#5 -add -end
            CALL q_apad001()
            LET g_apde_d[l_ac].apde008 = g_qryparam.return1
            LET g_apde_d[l_ac].apde100 = g_qryparam.return2
            DISPLAY BY NAME g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde100
            NEXT FIELD apde008
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde008_desc
            #add-point:ON ACTION controlp INFIELD apde008_desc name="input.c.page1.apde008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde100
            #add-point:ON ACTION controlp INFIELD apde100 name="input.c.page1.apde100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde109
            #add-point:ON ACTION controlp INFIELD apde109 name="input.c.page1.apde109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011
            #add-point:ON ACTION controlp INFIELD apde011 name="input.c.page1.apde011"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde011
            LET g_qryparam.where = " nmaj002 = '2'"
            CALL q_nmaj001()
            LET g_apde_d[l_ac].apde011 = g_qryparam.return1              
            CALL s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011) RETURNING g_apde_d[l_ac].apde011_desc
            DISPLAY g_apde_d[l_ac].apde011 TO apde011
          # INITIALIZE g_ref_fields TO NULL
          # LET g_ref_fields[1] = g_apde_d[l_ac].apde011
          # CALL ap_ref_array2(g_ref_fields,"SELECT nmajl003 FROM nmajl_t WHERE nmajlent='"||g_enterprise||"' AND nmajl001=? AND nmajl002='"||g_dlang||"'","") RETURNING g_rtn_fields
          # LET g_apde_d[l_ac].apde011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apde_d[l_ac].apde011_desc
            
            NEXT FIELD apde011
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde011_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde011_desc
            #add-point:ON ACTION controlp INFIELD apde011_desc name="input.c.page1.apde011_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apad003_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apad003_desc
            #add-point:ON ACTION controlp INFIELD apad003_desc name="input.c.page1.apad003_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde032
            #add-point:ON ACTION controlp INFIELD apde032 name="input.c.page1.apde032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde010
            #add-point:ON ACTION controlp INFIELD apde010 name="input.c.page1.apde010"
            #摘要
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apde_d[l_ac].apde010
            CALL q_oocq002_2()
            LET g_apde_d[l_ac].apde010 = g_qryparam.return1
            DISPLAY g_apde_d[l_ac].apde010 TO apde010
            NEXT FIELD apde010
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdecomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdecomp
            #add-point:ON ACTION controlp INFIELD apdecomp name="input.c.page1.apdecomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdesite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdesite
            #add-point:ON ACTION controlp INFIELD apdesite name="input.c.page1.apdesite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde001
            #add-point:ON ACTION controlp INFIELD apde001 name="input.c.page1.apde001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde002
            #add-point:ON ACTION controlp INFIELD apde002 name="input.c.page1.apde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde003
            #add-point:ON ACTION controlp INFIELD apde003 name="input.c.page1.apde003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde004
            #add-point:ON ACTION controlp INFIELD apde004 name="input.c.page1.apde004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde006
            #add-point:ON ACTION controlp INFIELD apde006 name="input.c.page1.apde006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde017
            #add-point:ON ACTION controlp INFIELD apde017 name="input.c.page1.apde017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde018
            #add-point:ON ACTION controlp INFIELD apde018 name="input.c.page1.apde018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde019
            #add-point:ON ACTION controlp INFIELD apde019 name="input.c.page1.apde019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde028
            #add-point:ON ACTION controlp INFIELD apde028 name="input.c.page1.apde028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apde012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apde012
            #add-point:ON ACTION controlp INFIELD apde012 name="input.c.page1.apde012"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apde_d[l_ac].apde012     
            LET g_qryparam.default2 = "" #g_apde_d[l_ac].nmad003 #現金異動碼
            CALL q_nmad003()  
            LET g_apde_d[l_ac].apde012 = g_qryparam.return1              
            DISPLAY g_apde_d[l_ac].apde012 TO apde012              #
            NEXT FIELD apde012                          #返回原欄位
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apde_d[l_ac].* = g_apde_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt351_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apde_d[l_ac].apdeseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apde_d[l_ac].* = g_apde_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt351_apde_t_mask_restore('restore_mask_o')
      
               UPDATE apde_t SET (apdeld,apdedocno,apdeseq,apde008,apde100,apde109,apde011,apde032,apde010, 
                   apdecomp,apdesite,apde001,apde002,apde003,apde004,apde006,apde017,apde018,apde019, 
                   apde028,apde012) = (g_apda_m.apdald,g_apda_m.apdadocno,g_apde_d[l_ac].apdeseq,g_apde_d[l_ac].apde008, 
                   g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde011,g_apde_d[l_ac].apde032, 
                   g_apde_d[l_ac].apde010,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite,g_apde_d[l_ac].apde001, 
                   g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde003,g_apde_d[l_ac].apde004,g_apde_d[l_ac].apde006, 
                   g_apde_d[l_ac].apde017,g_apde_d[l_ac].apde018,g_apde_d[l_ac].apde019,g_apde_d[l_ac].apde028, 
                   g_apde_d[l_ac].apde012)
                WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald 
                  AND apdedocno = g_apda_m.apdadocno 
 
                  AND apdeseq = g_apde_d_t.apdeseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apde_d[l_ac].* = g_apde_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apde_d[l_ac].* = g_apde_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apda_m.apdald
               LET gs_keys_bak[1] = g_apdald_t
               LET gs_keys[2] = g_apda_m.apdadocno
               LET gs_keys_bak[2] = g_apdadocno_t
               LET gs_keys[3] = g_apde_d[g_detail_idx].apdeseq
               LET gs_keys_bak[3] = g_apde_d_t.apdeseq
               CALL aapt351_update_b('apde_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt351_apde_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apde_d[g_detail_idx].apdeseq = g_apde_d_t.apdeseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apda_m.apdald
                  LET gs_keys[gs_keys.getLength()+1] = g_apda_m.apdadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apde_d_t.apdeseq
 
                  CALL aapt351_key_update_b(gs_keys,'apde_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apde_d_t)
               LET g_log2 = util.JSON.stringify(g_apda_m),util.JSON.stringify(g_apde_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            CALL s_fin_get_curr_rate(g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apdadocdt,g_glaa001,'')
                 RETURNING l_apde.apde101,l_apde.apde121,l_apde.apde131
            LET l_apde119 = l_apde.apde101 * l_apde.apde109
            IF cl_null(l_apde119) THEN LET l_apde119 = 0 END IF
            CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa001,l_apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde119
            IF g_glaa015 = 'Y' THEN
               IF g_glaa017 = '1' THEN
                  LET l_apde119 = l_apde.apde121 * l_apde.apde109
               ELSE
                  LET l_apde119 = l_apde.apde121 * l_apde.apde119
               END IF
               IF cl_null(l_apde119) THEN LET l_apde119 = 0 END IF
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa016,l_apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde129
            END IF
            IF g_glaa019 = 'Y' THEN
               IF g_glaa021 = '1' THEN
                  LET l_apde119 = l_apde.apde131 * l_apde.apde109
               ELSE
                  LET l_apde119 = l_apde.apde131 * l_apde.apde119
               END IF
               IF cl_null(l_apde119) THEN LET l_apde119 = 0 END IF
               CALL s_curr_round_ld('1',g_apda_m.apdald,g_glaa017,l_apde119,2) RETURNING g_sub_success,g_errno,l_apde.apde129
            END IF
            IF cl_null(l_apde.apde129) THEN LET l_apde.apde129 = 0 END IF
            IF cl_null(l_apde.apde139) THEN LET l_apde.apde139 = 0 END IF
            UPDATE apde_t
               SET (apde101,apde114,apde119,
                    apde121,apde124,apde129,apde120,
                    apde131,apde134,apde139,apde130)
                  =(l_apde.apde101,0,l_apde.apde119,
                    l_apde.apde121,0,l_apde.apde129,g_glaa016,
                    l_apde.apde131,0,l_apde.apde139,g_glaa020)
             WHERE apdeent = g_enterprise AND apdeld =  g_apda_m.apdald
               AND apdedocno = g_apda_m.apdadocno AND apdeseq = g_apde_d[l_ac].apdeseq
            #end add-point
            CALL aapt351_unlock_b("apde_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apde_d[li_reproduce_target].* = g_apde_d[li_reproduce].*
 
               LET g_apde_d[li_reproduce_target].apdeseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apde_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apde_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aapt351.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD apda006
         END IF

         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apdald
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apdeseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt351_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt351_b_fill() #單身填充
      CALL aapt351_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt351_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_apda_m.apdasite_desc = s_desc_get_department_desc(g_apda_m.apdasite) #帳務中心
   LET g_apda_m.apdadocno_desc= s_aooi200_fin_get_slip_desc(g_apda_m.apdadocno)   #單別
   LET g_apda_m.apda003_desc  = s_desc_get_person_desc(g_apda_m.apda003)      #帳務人員
   LET g_apda_m.apda006_desc  = aapt351_get_apda006_desc(g_apda_m.apda006)    #零用金帳戶說明
   LET g_apda_m.apda015_desc  = s_desc_get_acc_desc('3115',g_apda_m.apda015)  #作廢理由碼
   LET g_apda_m.apda018_desc  = s_desc_get_acc_desc('3212',g_apda_m.apda018)  #請款理由碼
   CALL aapt351_setld_info(g_apda_m.apdald)
   #end add-point
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt351_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apda006_desc,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apdadocno_desc, 
       g_apda_m.apda001,g_apda_m.fflabel_1,g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003, 
       g_apda_m.apda003_desc,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apda015_desc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
       g_apda_m.apdacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_apde_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt351_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt351_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt351_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apda_t.apdald 
   DEFINE l_oldno     LIKE apda_t.apdald 
   DEFINE l_newno02     LIKE apda_t.apdadocno 
   DEFINE l_oldno02     LIKE apda_t.apdadocno 
 
   DEFINE l_master    RECORD LIKE apda_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apde_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
    
   LET g_apda_m.apdald = ""
   LET g_apda_m.apdadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apda_m.apdaownid = g_user
      LET g_apda_m.apdaowndp = g_dept
      LET g_apda_m.apdacrtid = g_user
      LET g_apda_m.apdacrtdp = g_dept 
      LET g_apda_m.apdacrtdt = cl_get_current()
      LET g_apda_m.apdamodid = g_user
      LET g_apda_m.apdamoddt = cl_get_current()
      LET g_apda_m.apdastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apda_m.apdastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_apda_m.apdadocno_desc = ''
   DISPLAY BY NAME g_apda_m.apdadocno_desc
 
   
   CALL aapt351_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apda_m.* TO NULL
      INITIALIZE g_apde_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt351_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt351_set_act_visible()   
   CALL aapt351_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdaent = " ||g_enterprise|| " AND",
                      " apdald = '", g_apda_m.apdald, "' "
                      ," AND apdadocno = '", g_apda_m.apdadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt351_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt351_idx_chk()
   
   LET g_data_owner = g_apda_m.apdaownid      
   LET g_data_dept  = g_apda_m.apdaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt351_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt351_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apde_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt351_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apde_t
    WHERE apdeent = g_enterprise AND apdeld = g_apdald_t
     AND apdedocno = g_apdadocno_t
 
    INTO TEMP aapt351_detail
 
   #將key修正為調整後   
   UPDATE aapt351_detail 
      #更新key欄位
      SET apdeld = g_apda_m.apdald
          , apdedocno = g_apda_m.apdadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apde_t SELECT * FROM aapt351_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt351_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apdald_t = g_apda_m.apdald
   LET g_apdadocno_t = g_apda_m.apdadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt351_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num5  #160122-00001#5 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apda_m.apdald IS NULL
   OR g_apda_m.apdadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt351_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt351_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt351_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apda_m_mask_o.* =  g_apda_m.*
   CALL aapt351_apda_t_mask()
   LET g_apda_m_mask_n.* =  g_apda_m.*
   
   CALL aapt351_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt351_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      #160122-00001#5 -add -str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      SELECT COUNT(*) INTO l_n FROM apde_t
       WHERE apdeent = g_enterprise AND apdedocno = g_apda_m.apdadocno
         AND apde008 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus='Y')
         #160122-00001#5 add by07675--str
         AND apde008 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus='Y')
         AND TRIM(apde008) IS NOT NULL
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE aapt351_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #160122-00001#5 add by07675--end
     # IF l_n = 0 THEN
      #160122-00001#5 -add -end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apdald_t = g_apda_m.apdald
      LET g_apdadocno_t = g_apda_m.apdadocno
 
 
      DELETE FROM apda_t
       WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
         AND apdadocno = g_apda_m.apdadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apda_m.apdald,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_apda_m.apdald,g_apda_m.apdadocno,g_apda_m.apdadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
    #END IF   
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apde_t
       WHERE apdeent = g_enterprise AND apdeld = g_apda_m.apdald
         AND apdedocno = g_apda_m.apdadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
#         AND (apde008 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user) #160122-00001#5 add
#          OR apde008 IS NULL) #160122-00001#5 add                 #160122-00001#5 mark by07675
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
 
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apda_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt351_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apde_d.clear() 
 
     
      CALL aapt351_ui_browser_refresh()  
      #CALL aapt351_ui_headershow()  
      #CALL aapt351_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt351_browser_fill("")
         CALL aapt351_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt351_cl
 
   #功能已完成,通報訊息中心
   CALL aapt351_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt351.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt351_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apde_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt351_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apdeseq,apde008,apde100,apde109,apde011,apde032,apde010,apdecomp, 
             apdesite,apde001,apde002,apde003,apde004,apde006,apde017,apde018,apde019,apde028,apde012  FROM apde_t", 
                
                     " INNER JOIN apda_t ON apdaent = " ||g_enterprise|| " AND apdald = apdeld ",
                     " AND apdadocno = apdedocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE apdeent=? AND apdeld=? AND apdedocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#         LET g_sql = g_sql," AND (apde008 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = '"||g_enterprise||"' AND nmll002 = '"||g_user||"')",  #160122-00001#5 add
#                     " OR apde008 IS NULL)"  #160122-00001#5 add
           LET g_sql = g_sql," AND (apde008 IN(",g_sql_bank,")",  
                     " OR TRIM(apde008) IS NULL)"  #160122-00001#5 mod by 07675
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apde_t.apdeseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt351_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt351_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno INTO g_apde_d[l_ac].apdeseq, 
          g_apde_d[l_ac].apde008,g_apde_d[l_ac].apde100,g_apde_d[l_ac].apde109,g_apde_d[l_ac].apde011, 
          g_apde_d[l_ac].apde032,g_apde_d[l_ac].apde010,g_apde_d[l_ac].apdecomp,g_apde_d[l_ac].apdesite, 
          g_apde_d[l_ac].apde001,g_apde_d[l_ac].apde002,g_apde_d[l_ac].apde003,g_apde_d[l_ac].apde004, 
          g_apde_d[l_ac].apde006,g_apde_d[l_ac].apde017,g_apde_d[l_ac].apde018,g_apde_d[l_ac].apde019, 
          g_apde_d[l_ac].apde028,g_apde_d[l_ac].apde012   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL aapt351_get_apce008_info(g_apda_m.apda006,g_apde_d[l_ac].apde008) RETURNING g_apde_d[l_ac].apde008_desc,g_apde_d[l_ac].apad003_desc
         CALL s_desc_get_nmajl003_desc(g_apde_d[l_ac].apde011) RETURNING g_apde_d[l_ac].apde011_desc
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_apde_d.deleteElement(g_apde_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt351_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apde_d.getLength()
      LET g_apde_d_mask_o[l_ac].* =  g_apde_d[l_ac].*
      CALL aapt351_apde_t_mask()
      LET g_apde_d_mask_n[l_ac].* =  g_apde_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt351_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM apde_t
       WHERE apdeent = g_enterprise AND
         apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apde_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt351_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO apde_t
                  (apdeent,
                   apdeld,apdedocno,
                   apdeseq
                   ,apde008,apde100,apde109,apde011,apde032,apde010,apdecomp,apdesite,apde001,apde002,apde003,apde004,apde006,apde017,apde018,apde019,apde028,apde012) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apde_d[g_detail_idx].apde008,g_apde_d[g_detail_idx].apde100,g_apde_d[g_detail_idx].apde109, 
                       g_apde_d[g_detail_idx].apde011,g_apde_d[g_detail_idx].apde032,g_apde_d[g_detail_idx].apde010, 
                       g_apde_d[g_detail_idx].apdecomp,g_apde_d[g_detail_idx].apdesite,g_apde_d[g_detail_idx].apde001, 
                       g_apde_d[g_detail_idx].apde002,g_apde_d[g_detail_idx].apde003,g_apde_d[g_detail_idx].apde004, 
                       g_apde_d[g_detail_idx].apde006,g_apde_d[g_detail_idx].apde017,g_apde_d[g_detail_idx].apde018, 
                       g_apde_d[g_detail_idx].apde019,g_apde_d[g_detail_idx].apde028,g_apde_d[g_detail_idx].apde012) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apde_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt351_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apde_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt351_apde_t_mask_restore('restore_mask_o')
               
      UPDATE apde_t 
         SET (apdeld,apdedocno,
              apdeseq
              ,apde008,apde100,apde109,apde011,apde032,apde010,apdecomp,apdesite,apde001,apde002,apde003,apde004,apde006,apde017,apde018,apde019,apde028,apde012) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apde_d[g_detail_idx].apde008,g_apde_d[g_detail_idx].apde100,g_apde_d[g_detail_idx].apde109, 
                  g_apde_d[g_detail_idx].apde011,g_apde_d[g_detail_idx].apde032,g_apde_d[g_detail_idx].apde010, 
                  g_apde_d[g_detail_idx].apdecomp,g_apde_d[g_detail_idx].apdesite,g_apde_d[g_detail_idx].apde001, 
                  g_apde_d[g_detail_idx].apde002,g_apde_d[g_detail_idx].apde003,g_apde_d[g_detail_idx].apde004, 
                  g_apde_d[g_detail_idx].apde006,g_apde_d[g_detail_idx].apde017,g_apde_d[g_detail_idx].apde018, 
                  g_apde_d[g_detail_idx].apde019,g_apde_d[g_detail_idx].apde028,g_apde_d[g_detail_idx].apde012)  
 
         WHERE apdeent = g_enterprise AND apdeld = ps_keys_bak[1] AND apdedocno = ps_keys_bak[2] AND apdeseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apde_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt351_apde_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt351_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt351_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt351_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL aapt351_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apde_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt351_bcl USING g_enterprise,
                                       g_apda_m.apdald,g_apda_m.apdadocno,g_apde_d[g_detail_idx].apdeseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt351_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt351_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt351_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt351_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apdadocno,apdald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apdald,apdadocno",TRUE)
      CALL cl_set_comp_entry("apdadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("apdadocdt",TRUE)  #151130-00015#2 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt351_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80  #151130-00015#2 
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apdald,apdadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("apdasite",FALSE)     
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apdadocno,apdald",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apdadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("apda015",FALSE)
   #151130-00015#2  -add -str
   IF NOT cl_null(g_apda_m.apdadocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
      #取得單別設置的"是否直接審核"參數
      CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("apdadocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt351_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt351_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt351_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt351_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_apda_m.apdastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt351_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt351_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt351_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " apdald = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apdadocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apda_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apde_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
 
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt351_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apda_m.apdald IS NULL
      OR g_apda_m.apdadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt351_cl USING g_enterprise,g_apda_m.apdald,g_apda_m.apdadocno
   IF STATUS THEN
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt351_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006,g_apda_m.apdadocdt, 
       g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003,g_apda_m.apdacomp,g_apda_m.apdald, 
       g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid,g_apda_m.apdacrtdp,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc, 
       g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc, 
       g_apda_m.apdacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt351_action_chk() THEN
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apda006_desc,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apdadocno_desc, 
       g_apda_m.apda001,g_apda_m.fflabel_1,g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003, 
       g_apda_m.apda003_desc,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005,g_apda_m.apdastus, 
       g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda008,g_apda_m.apda017,g_apda_m.apda016,g_apda_m.apda015, 
       g_apda_m.apda015_desc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc, 
       g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp,g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt, 
       g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt,g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc, 
       g_apda_m.apdacnfdt
 
   CASE g_apda_m.apdastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_apda_m.apdastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed,posted",FALSE)

      CASE g_apda_m.apdastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed,post",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            CALL s_transaction_end('N','0')        #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("posted",TRUE)  
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
             
         WHEN "S"  #只能顯示確認; 其餘應用功能皆隱藏
             CALL s_transaction_end('N','0')        #150401-00001#13
             RETURN
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aapt351_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt351_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt351_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt351_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_apda_m.apdastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_apda_m.apdastus = 'N' THEN
         CALL s_aapt351_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL s_aapt351_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                  CALL cl_err_collect_show()
               END IF
            END IF
         END IF
      END IF  
   END IF  
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_aapt351_unconf_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt351_unconf_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #作廢
   IF lc_state = 'X' THEN
      CALL s_aapt351_void_chk(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行作廢？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL cl_set_comp_entry("apda015",TRUE)
            INPUT BY NAME g_apda_m.apda015 ATTRIBUTE(WITHOUT DEFAULTS)
            
               AFTER FIELD apda015  #作廢理由碼
                  LET g_apda_m.apda015_desc = ''
                  IF NOT cl_null(g_apda_m.apda015) THEN
                     IF NOT s_azzi650_chk_exist('3115',g_apda_m.apda015) THEN
                        LET g_apda_m.apda015 = g_apda_m_t.apda015
                        CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                        DISPLAY BY NAME g_apda_m.apda015_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT 
                  END IF
                  CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                  DISPLAY BY NAME g_apda_m.apda015_desc  
               
               ON ACTION controlp INFIELD apda015
      			   INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
         			LET g_qryparam.reqry = FALSE
                  LET g_qryparam.default1 = g_apda_m.apda015
                  LET g_qryparam.arg1 = "3115"
                  CALL q_oocq002()   
                  LET g_apda_m.apda015 = g_qryparam.return1 
                  CALL s_desc_get_acc_desc('3115',g_apda_m.apda015) RETURNING g_apda_m.apda015_desc
                  DISPLAY BY NAME g_apda_m.apda015,g_apda_m.apda015_desc
                  NEXT FIELD apda015
               
               AFTER INPUT
                  CALL s_transaction_begin()
                  CALL s_aapt351_void_upd(g_apda_m.apdald,g_apda_m.apdadocno) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()
                     RETURN
                  ELSE
                     UPDATE apda_t SET apda015 = g_apda_m.apda015
                      WHERE apdaent = g_enterprise
                        AND apdald  = g_apda_m.apdald AND apdadocno = g_apda_m.apdadocno
                     CALL s_transaction_end('Y','0')
                     CALL cl_err_collect_show()
                  END IF
               
            END INPUT

         END IF
      END IF
   END IF  
   #end add-point
   
   LET g_apda_m.apdamodid = g_user
   LET g_apda_m.apdamoddt = cl_get_current()
   LET g_apda_m.apdastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apda_t 
      SET (apdastus,apdamodid,apdamoddt) 
        = (g_apda_m.apdastus,g_apda_m.apdamodid,g_apda_m.apdamoddt)     
    WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aapt351_master_referesh USING g_apda_m.apdald,g_apda_m.apdadocno INTO g_apda_m.apda006, 
          g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apda001,g_apda_m.apdasite,g_apda_m.apda003, 
          g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda008,g_apda_m.apda017, 
          g_apda_m.apda016,g_apda_m.apda015,g_apda_m.apdaownid,g_apda_m.apdaowndp,g_apda_m.apdacrtid, 
          g_apda_m.apdacrtdp,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamoddt,g_apda_m.apdacnfid, 
          g_apda_m.apdacnfdt,g_apda_m.apdaownid_desc,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid_desc, 
          g_apda_m.apdacrtdp_desc,g_apda_m.apdamodid_desc,g_apda_m.apdacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apda_m.apda006,g_apda_m.apda006_desc,g_apda_m.apdadocdt,g_apda_m.apdadocno,g_apda_m.apdadocno_desc, 
          g_apda_m.apda001,g_apda_m.fflabel_1,g_apda_m.apdasite,g_apda_m.apdasite_desc,g_apda_m.apda003, 
          g_apda_m.apda003_desc,g_apda_m.apdacomp,g_apda_m.apdald,g_apda_m.apacsite,g_apda_m.glaa005, 
          g_apda_m.apdastus,g_apda_m.apda018,g_apda_m.apda018_desc,g_apda_m.apda008,g_apda_m.apda017, 
          g_apda_m.apda016,g_apda_m.apda015,g_apda_m.apda015_desc,g_apda_m.apdaownid,g_apda_m.apdaownid_desc, 
          g_apda_m.apdaowndp,g_apda_m.apdaowndp_desc,g_apda_m.apdacrtid,g_apda_m.apdacrtid_desc,g_apda_m.apdacrtdp, 
          g_apda_m.apdacrtdp_desc,g_apda_m.apdacrtdt,g_apda_m.apdamodid,g_apda_m.apdamodid_desc,g_apda_m.apdamoddt, 
          g_apda_m.apdacnfid,g_apda_m.apdacnfid_desc,g_apda_m.apdacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt351_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt351_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt351.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt351_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apde_d.getLength() THEN
         LET g_detail_idx = g_apde_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apde_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apde_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt351_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aapt351_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt351_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt351.status_show" >}
PRIVATE FUNCTION aapt351_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt351.mask_functions" >}
&include "erp/aap/aapt351_mask.4gl"
 
{</section>}
 
{<section id="aapt351.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt351_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aapt351_show()
   CALL aapt351_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_aapt351_conf_chk(g_apda_m.apdald ,g_apda_m.apdadocno) THEN
      CLOSE aapt351_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apda_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apde_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt351_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt351_ui_headershow()
   CALL aapt351_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt351_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt351_ui_headershow()  
   CALL aapt351_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt351.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt351_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_apda_m.apdald
   LET g_pk_array[1].column = 'apdald'
   LET g_pk_array[2].values = g_apda_m.apdadocno
   LET g_pk_array[2].column = 'apdadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt351.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt351.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt351_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL aapt351_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apda_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt351.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt351_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#1   2016/08/30  By 07900 --add--s--
    SELECT apdastus INTO g_apda_m.apdastus
     FROM apda_t
    WHERE apdaent = g_enterprise
      AND apdadocno= g_apda_m.apdadocno
      AND apdald = g_apda_m.apdald 
       
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail") THEN
       LET g_errno = NULL
      CASE g_apda_m.apdastus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_apda_m.apdadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aapt351_set_act_visible()
        CALL aapt351_set_act_no_visible()
        CALL aapt351_show()
        RETURN FALSE
     END IF
   END IF   
   #160818-00017#1   2016/08/30  By 07900 --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt351.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 零用金帳戶說明欄位
# Usage..........: CALL aapt351_get_apda006_desc(p_apda006)
#                  RETURNING r_desc
# Date & Author..: 14/06/11 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt351_get_apda006_desc(p_apda006)
DEFINE p_apda006   LIKE apda_t.apda006
DEFINE r_desc      LIKE type_t.chr80
DEFINE l_apac003   LIKE apac_t.apac003
DEFINE l_apacsite  LIKE apac_t.apacsite
DEFINE l_apacl003  LIKE apacl_t.apacl003  #零用金說明
DEFINE l_ooefl003  LIKE ooefl_t.ooefl003  #組織說明
DEFINE l_oofa011   LIKE oofa_t.oofa011    #人員說明
   
   LET l_apacsite = ''
   LET l_apac003  = ''
   LET l_apacl003 = ''
   LET l_apacl003 = ''
   LET l_ooefl003 = ''
   LET l_oofa011  = ''
   LET r_desc = ''

   SELECT apac003,apacsite,apacl003 INTO l_apac003,l_apacsite,l_apacl003
     FROM apac_t LEFT OUTER JOIN apacl_t ON apacent = apaclent AND apac001 = apacl001 AND apacl002 = g_lang
    WHERE apacent = g_enterprise
      AND apac001 = p_apda006
   CALL s_desc_get_department_desc(l_apacsite) RETURNING l_ooefl003
   CALL s_desc_get_person_desc(l_apac003) RETURNING l_oofa011 
   LET r_desc = l_apacl003 CLIPPED ,"/",l_ooefl003 CLIPPED ,"/", l_oofa011 CLIPPED
   IF r_desc = "//" THEN LET r_desc = "" END IF
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 交易帳戶資訊相關資料
# Memo...........:
# Date & Author..: 14/07/23 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt351_get_apce008_info(p_apad001,p_apad002)
DEFINE p_apad001        LIKE apad_t.apad001  #零用金帳戶
DEFINE p_apad002        LIKE apad_t.apad002  #交易帳戶
DEFINE r_apad002_desc   LIKE type_t.chr80
DEFINE r_apad003_desc   LIKE type_t.chr80
DEFINE l_apad003        DECIMAL(20,2)
DEFINE l_apad004        DECIMAL(20,2)

   CALL s_desc_get_nmas002_desc(p_apad002) RETURNING r_apad002_desc
   LET l_apad003 = ''
   LET l_apad004 = ''
   SELECT apad003,apad004 INTO l_apad003,l_apad004
     FROM apad_t
    WHERE apadent = g_enterprise
      AND apad001 = p_apad001 AND apad002 = p_apad002
   IF cl_null(l_apad003) THEN LET l_apad003 = 0 END IF
   IF cl_null(l_apad004) THEN LET l_apad004 = 0 END IF
   LET r_apad003_desc = l_apad003 ,"~", l_apad004
   LET r_apad003_desc = s_chr_replace(r_apad003_desc,' ','',80)
   
   RETURN r_apad002_desc,r_apad003_desc
END FUNCTION

################################################################################
# Descriptions...: 取得帳別資訊
# Memo...........:
# Usage..........: CALL aapt351_setld_info(p_ld)
# Date & Author..: 14/08/11 By Belle
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt351_setld_info(p_ld)
DEFINE p_ld    LIKE glaa_t.glaa001

   CALL s_ld_sel_glaa(p_ld,'glaa001|glaa005|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024')
        RETURNING g_sub_success,g_glaa001,g_apda_m.glaa005,
                  g_glaa015,g_glaa016,g_glaa017,
                  g_glaa019,g_glaa020,g_glaa021,g_glaa024
END FUNCTION

################################################################################
# Descriptions...: 立即審核
# Memo...........:
# Usage..........: CALL aapt351_immediately_conf()
#                  RETURNING ---
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/03 By 06421
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt351_immediately_conf()
#151125-00006#2--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count  LIKE type_t.num5
   DEFINE l_sfin3008        LIKE type_t.chr80             #S-FIN-3008-付款單直接產生銀存支付帳
   IF cl_null(g_apda_m.apdald)    THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdasite)  THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_apda_m.apdadocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM apde_t WHERE apdeent = g_enterprise
      AND apdedocno = g_apda_m.apdadocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF

   IF l_count = 0  THEN
      RETURN 
   END IF                   #单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_apda_m.apdadocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(g_apda_m.apdald,g_apda_m.apdacomp,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
      

   IF NOT s_aapt351_conf_chk(g_apda_m.apdald,g_apda_m.apdadocno) THEN
      LET l_doc_success = FALSE
   END IF

   IF NOT s_aapt351_conf_upd(g_apda_m.apdald,g_apda_m.apdadocno)  THEN
      LET l_doc_success = FALSE
   END IF

   
   #異動狀態碼欄位/修改人/修改日期
   LET g_apda_m.apdamoddt = cl_get_current()
   LET g_apda_m.apdacnfdt = cl_get_current()
   UPDATE apda_t SET apdastus = 'Y',
                     apdamodid= g_user,
                     apdamoddt= g_apda_m.apdamoddt,
                     apdacnfid= g_user,
                     apdacnfdt= g_apda_m.apdacnfdt
    WHERE apdaent = g_enterprise AND apdald = g_apda_m.apdald
      AND apdadocno = g_apda_m.apdadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#2--e
END FUNCTION

 
{</section>}
 
